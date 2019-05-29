Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79369C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 16:21:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44B2423D5D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 16:21:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbfE2QV2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 12:21:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45181 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726097AbfE2QV2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 12:21:28 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E565F30B97AA;
        Wed, 29 May 2019 16:21:22 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.159])
        by smtp.corp.redhat.com (Postfix) with SMTP id 971C11001F5D;
        Wed, 29 May 2019 16:21:21 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 29 May 2019 18:21:22 +0200 (CEST)
Date:   Wed, 29 May 2019 18:21:20 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Jann Horn <jannh@google.com>
Cc:     "Eric W . Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        David Howells <dhowells@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ptrace: restore smp_rmb() in __ptrace_may_access()
Message-ID: <20190529162120.GB27659@redhat.com>
References: <20190529113157.227380-1-jannh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190529113157.227380-1-jannh@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Wed, 29 May 2019 16:21:28 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/29, Jann Horn wrote:
>
> (I have no clue whatsoever what the relevant tree for this is, but I
> guess Oleg is the relevant maintainer?)

we usually route ptrace changes via -mm tree, plus I lost my account on korg.

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

(I am wondering if smp_acquire__after_ctrl_dep() could be used instead, just to
 make this code look more confusing)

>  	mm = task->mm;

while at it, could you also change this into mm = READ_ONCE(task->mm) ?

Oleg.

