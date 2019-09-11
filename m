Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF9C7C49ED6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 13:31:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC9A42084D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 13:31:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbfIKNb2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 09:31:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40330 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726341AbfIKNb2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 09:31:28 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 02E0A309BDB9;
        Wed, 11 Sep 2019 13:31:28 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.72])
        by smtp.corp.redhat.com (Postfix) with SMTP id 35A9D1001B13;
        Wed, 11 Sep 2019 13:31:21 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 11 Sep 2019 15:31:27 +0200 (CEST)
Date:   Wed, 11 Sep 2019 15:31:20 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Eugene Syromiatnikov <esyr@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Christian Brauner <christian@brauner.io>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH v2] fork: check exit_signal passed in clone3() call
Message-ID: <20190911133119.GA17580@redhat.com>
References: <20190910175852.GA15572@asgard.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190910175852.GA15572@asgard.redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Wed, 11 Sep 2019 13:31:28 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/10, Eugene Syromiatnikov wrote:
>
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -2338,6 +2338,8 @@ struct mm_struct *copy_init_mm(void)
>   *
>   * It copies the process, and if successful kick-starts
>   * it and waits for it to finish using the VM if required.
> + *
> + * args->exit_signal is expected to be checked for sanity by the caller.

not sure this comment is really useful but it doesn't hurt

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

OK, agreed. As you pointed out, this doesn't guarantee valid_signal(exit_signal).
But we do no really care as long as it is non-negative, it acts as exit_signal==0.

I have no idea if we want to deny exit_signal >= _NSIG in clone3(), this was always
allowed...

I think this needs the "CC: stable" tag.

Acked-by: Oleg Nesterov <oleg@redhat.com>

