Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 071D5C433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 15:48:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAEA322293
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 15:48:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388786AbfHGPsc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 11:48:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48516 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388769AbfHGPsc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 11:48:32 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D8177EC529;
        Wed,  7 Aug 2019 15:48:31 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.136])
        by smtp.corp.redhat.com (Postfix) with SMTP id DAE0960BE1;
        Wed,  7 Aug 2019 15:48:29 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed,  7 Aug 2019 17:48:31 +0200 (CEST)
Date:   Wed, 7 Aug 2019 17:48:29 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Adrian Reber <areber@redhat.com>
Cc:     Christian Brauner <christian@brauner.io>,
        Eric Biederman <ebiederm@xmission.com>,
        Pavel Emelianov <xemul@virtuozzo.com>,
        Jann Horn <jannh@google.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        linux-kernel@vger.kernel.org, Andrei Vagin <avagin@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Radostin Stoyanov <rstoyanov1@gmail.com>
Subject: Re: [PATCH v3 1/2] fork: extend clone3() to support CLONE_SET_TID
Message-ID: <20190807154828.GD24112@redhat.com>
References: <20190806191551.22192-1-areber@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806191551.22192-1-areber@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Wed, 07 Aug 2019 15:48:32 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/06, Adrian Reber wrote:
>
> @@ -2530,12 +2530,14 @@ noinline static int copy_clone_args_from_user(struct kernel_clone_args *kargs,
>  					      struct clone_args __user *uargs,
>  					      size_t size)
>  {
> +	struct pid_namespace *pid_ns = task_active_pid_ns(current);
>  	struct clone_args args;
>  
>  	if (unlikely(size > PAGE_SIZE))
>  		return -E2BIG;
>  
> -	if (unlikely(size < sizeof(struct clone_args)))
> +	/* The struct needs to be at least the size of the original struct. */
> +	if (size < (sizeof(struct clone_args) - sizeof(__aligned_u64)))
>  		return -EINVAL;

slightly off-topic, but with or without this patch I do not understand
-EINVAL. Can't we replace this check with

	if (size < sizeof(struct clone_args))
		memset((void*)&args + size, sizeof(struct clone_args) - size, 0);

?

this way we can new members at the end of clone_args and this matches
the "if (size > sizeof(struct clone_args))" block below which promises
that whatever we add into clone_args a zero value should work.


And if we do this

> +	if (size == sizeof(struct clone_args)) {
> +		/* Only check permissions if set_tid is actually set. */
> +		if (args.set_tid &&
> +			!ns_capable(pid_ns->user_ns, CAP_SYS_ADMIN))
> +			return -EPERM;
> +		kargs->set_tid = args.set_tid;
> +	}

we can move this check into clone3_args_valid() or even copy_process()

	if (kargs->set_tid) {
		if (!ns_capable(...))
			return -EPERM;
	}


Either way,

> @@ -2585,6 +2595,10 @@ static bool clone3_args_valid(const struct kernel_clone_args *kargs)
>  	if (kargs->flags & ~CLONE_LEGACY_FLAGS)
>  		return false;
>
> +	/* Fail if set_tid is invalid */
> +	if (kargs->set_tid < 0)
> +		return false;

I think it would be more clean to do this along with ns_capable() check,
or along with the "set_tid >= pid_max" check in alloc_pid().

I won't insist, but I do not really like the fact we check set_tid 3 times
in copy_clone_args_from_user(), clone3_args_valid(), and alloc_pid().

Oleg.

