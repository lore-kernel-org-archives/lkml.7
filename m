Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D466C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 15:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E673023CA0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 15:59:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbfE2P7O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 11:59:14 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:56652 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbfE2P7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 11:59:13 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hW0yt-0000xT-LR; Wed, 29 May 2019 09:59:11 -0600
Received: from ip72-206-97-68.om.om.cox.net ([72.206.97.68] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hW0ys-0007IP-SG; Wed, 29 May 2019 09:59:11 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Jann Horn <jannh@google.com>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        David Howells <dhowells@redhat.com>,
        linux-kernel@vger.kernel.org
References: <20190529113157.227380-1-jannh@google.com>
Date:   Wed, 29 May 2019 10:59:06 -0500
In-Reply-To: <20190529113157.227380-1-jannh@google.com> (Jann Horn's message
        of "Wed, 29 May 2019 13:31:57 +0200")
Message-ID: <87v9xtz1yt.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1hW0ys-0007IP-SG;;;mid=<87v9xtz1yt.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=72.206.97.68;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+HZZhP+I6gkJd2bJSMtuTonAEQcH3Rs7I=
X-SA-Exim-Connect-IP: 72.206.97.68
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH] ptrace: restore smp_rmb() in __ptrace_may_access()
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jann Horn <jannh@google.com> writes:

> Restore the read memory barrier in __ptrace_may_access() that was deleted
> a couple years ago. Also add comments on this barrier and the one it pairs
> with to explain why they're there (as far as I understand).

My bad.

When I made that change I could not figure out what that barrier was
for, and it did not appear necessary.

Do you happen to know of any real world problems?

Reviewed-by: "Eric W. Biederman" <ebiederm@xmission.com>

If no one else would prefer to pick this up I will grab it.  I have
another bug fix I already queueing for 5.2-rcX.

Thank you,
Eric

>
> Fixes: bfedb589252c ("mm: Add a user_ns owner to mm_struct and fix ptrace permission checks")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jann Horn <jannh@google.com>
> ---
> (I have no clue whatsoever what the relevant tree for this is, but I
> guess Oleg is the relevant maintainer?)
>
>  kernel/cred.c   |  9 +++++++++
>  kernel/ptrace.c | 10 ++++++++++
>  2 files changed, 19 insertions(+)
>
> diff --git a/kernel/cred.c b/kernel/cred.c
> index 45d77284aed0..07e069d00696 100644
> --- a/kernel/cred.c
> +++ b/kernel/cred.c
> @@ -450,6 +450,15 @@ int commit_creds(struct cred *new)
>  		if (task->mm)
>  			set_dumpable(task->mm, suid_dumpable);
>  		task->pdeath_signal = 0;
> +		/*
> +		 * If a task drops privileges and becomes nondumpable,
> +		 * the dumpability change must become visible before
> +		 * the credential change; otherwise, a __ptrace_may_access()
> +		 * racing with this change may be able to attach to a task it
> +		 * shouldn't be able to attach to (as if the task had dropped
> +		 * privileges without becoming nondumpable).
> +		 * Pairs with a read barrier in __ptrace_may_access().
> +		 */
>  		smp_wmb();
>  	}
>  
> diff --git a/kernel/ptrace.c b/kernel/ptrace.c
> index 5710d07e67cf..e54452c2954b 100644
> --- a/kernel/ptrace.c
> +++ b/kernel/ptrace.c
> @@ -324,6 +324,16 @@ static int __ptrace_may_access(struct task_struct *task, unsigned int mode)
>  	return -EPERM;
>  ok:
>  	rcu_read_unlock();
> +	/*
> +	 * If a task drops privileges and becomes nondumpable (through a syscall
> +	 * like setresuid()) while we are trying to access it, we must ensure
> +	 * that the dumpability is read after the credentials; otherwise,
> +	 * we may be able to attach to a task that we shouldn't be able to
> +	 * attach to (as if the task had dropped privileges without becoming
> +	 * nondumpable).
> +	 * Pairs with a write barrier in commit_creds().
> +	 */
> +	smp_rmb();
>  	mm = task->mm;
>  	if (mm &&
>  	    ((get_dumpable(mm) != SUID_DUMP_USER) &&
