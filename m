Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31A62C49ED6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 17:32:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BCA42084F
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 17:32:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729528AbfIKRco (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 13:32:44 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:40357 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728897AbfIKRco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 13:32:44 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1i86Tw-0002nA-MY; Wed, 11 Sep 2019 11:32:40 -0600
Received: from 110.8.30.213.rev.vodafone.pt ([213.30.8.110] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1i86Tv-0005Lh-OI; Wed, 11 Sep 2019 11:32:40 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Eugene Syromiatnikov <esyr@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Christian Brauner <christian@brauner.io>,
        Oleg Nesterov <oleg@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Peter Zijlstra \(Intel\)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Dmitry V. Levin" <ldv@altlinux.org>
References: <20190910175852.GA15572@asgard.redhat.com>
Date:   Wed, 11 Sep 2019 12:32:17 -0500
In-Reply-To: <20190910175852.GA15572@asgard.redhat.com> (Eugene
        Syromiatnikov's message of "Tue, 10 Sep 2019 18:58:52 +0100")
Message-ID: <87d0g691su.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1i86Tv-0005Lh-OI;;;mid=<87d0g691su.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=213.30.8.110;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18Q8+CvTzcoLi+RF1BzgBUOMruIPSj6/JI=
X-SA-Exim-Connect-IP: 213.30.8.110
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH v2] fork: check exit_signal passed in clone3() call
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eugene Syromiatnikov <esyr@redhat.com> writes:

> Previously, higher 32 bits of exit_signal fields were lost when
> copied to the kernel args structure (that uses int as a type for the
> respective field).  Moreover, as Oleg has noted[1], exit_signal is used
> unchecked, so it has to be checked for sanity before use; for the legacy
> syscalls, applying CSIGNAL mask guarantees that it is at least non-negative;
> however, there's no such thing is done in clone3() code path, and that can
> break at least thread_group_leader.
>
> Checking user-passed exit_signal against ~CSIGNAL mask solves both
> of these problems.
>
> [1] https://lkml.org/lkml/2019/9/10/467
>
> * kernel/fork.c (copy_clone_args_from_user): Fail with -EINVAL if
> args.exit_signal has bits set outside CSIGNAL mask.
> (_do_fork): Note that exit_signal is expected to be checked for the
> sanity by the caller.
>
> Fixes: 7f192e3cd316 ("fork: add clone3")
> Reported-by: Oleg Nesterov <oleg@redhat.com>
> Signed-off-by: Eugene Syromiatnikov <esyr@redhat.com>

Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>

> ---
>  kernel/fork.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 2852d0e..9dee2ab 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -2338,6 +2338,8 @@ struct mm_struct *copy_init_mm(void)
>   *
>   * It copies the process, and if successful kick-starts
>   * it and waits for it to finish using the VM if required.
> + *
> + * args->exit_signal is expected to be checked for sanity by the caller.
>   */
>  long _do_fork(struct kernel_clone_args *args)
>  {
> @@ -2562,6 +2564,16 @@ noinline static int copy_clone_args_from_user(struct kernel_clone_args *kargs,
>  	if (copy_from_user(&args, uargs, size))
>  		return -EFAULT;
>  
> +	/*
> +	 * exit_signal is confined to CSIGNAL mask in legacy syscalls,
> +	 * so it is used unchecked deeper in syscall handling routines;
> +	 * moreover, copying to struct kernel_clone_args.exit_signals
> +	 * trims higher 32 bits, so it is has to be checked that they
> +	 * are zero.
> +	 */
> +	if (unlikely(args.exit_signal & ~((u64)CSIGNAL)))
> +		return -EINVAL;
> +
>  	*kargs = (struct kernel_clone_args){
>  		.flags		= args.flags,
>  		.pidfd		= u64_to_user_ptr(args.pidfd),
