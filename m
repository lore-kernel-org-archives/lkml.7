Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30396C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 02:17:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8AF9218D9
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 02:17:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="RZsZ90Q0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730308AbfC3CRd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 22:17:33 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33487 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730001AbfC3CRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 22:17:33 -0400
Received: by mail-ed1-f65.google.com with SMTP id q3so3630583edg.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 19:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PD76K0NMhqfbElUsgcEMx0/FxEoi+G99p31kq6K+oNQ=;
        b=RZsZ90Q02ELCKPExop1F7jMsE3jxMR+12PItPJtoVm9TlCfVVrOvXWMdBz4SIBX9RM
         XR2JStkdXj1GC1xtbjI4yKw9CUzcFOBv0fnPRxGDzD+92FLDDDR5CJ7bRKGfFaJVXywG
         9JI5inCs0UhM79HfOlXdERJG/EBv+jCvvxR9KYBTSbbip926I2WQYA/7ar2Jee/jn19s
         CnAwm4YA9VUbzXKUksWDDYRZZ01u6vs3rozhTVzpzjbN755CkJZQNNLfs65JV6+KoEtp
         /1xO0mDQuY79YlgtJOJk+8JSIsXtTywKyirDumMPQKLhVYcyZ6mL9ftdWU3LAqPPLpOd
         eAJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PD76K0NMhqfbElUsgcEMx0/FxEoi+G99p31kq6K+oNQ=;
        b=lfrRgKQjmO3SgZi5rU1gTxkduREcp7cjFxuHCoDQH27PBWX/Ynq8VIbEvrCt+8oTDE
         YtrIqoDF2/89noUrZbR5Uz0QloISNLgh2PrjX1p+gLqKe7A8esSnTHZzqBbt958bLspv
         g6Lijitoabif6rKyro2jSZLrkKaHLCXjvW9PICobYsfBKkSbAFx7dpDZRcCriYHvDliD
         pkyI3k4PjXLdZ72kvAK198jXjrj9khEe2AjFSycCcVa4SRwaNArNzsqvd1bBOhu91ON4
         NHRHrrtR7rpY/9DYXAiKz6g7cPuN2gwsdza6uOH+nxEFwisfl6ya1HxraqPGPOJ06eHN
         Un1A==
X-Gm-Message-State: APjAAAViDhsy4Jm1c0ikdWQMtxFzZk/rxLfjF/5edf/IdRF6oJR4NJiK
        5vZmF9ZxVZ8FRtCQ0hdM3Q9WCvNItWI=
X-Google-Smtp-Source: APXvYqxYE17N6pdZY7DWKhm/nJaVq6UoNfZQAPRnVYy1JHQK1hUH8dkVEu4StR8TLWqkBciOHCHdvg==
X-Received: by 2002:a05:6402:608:: with SMTP id n8mr34061648edv.136.1553912251712;
        Fri, 29 Mar 2019 19:17:31 -0700 (PDT)
Received: from brauner.io ([2a02:8109:b6bf:d24a:b136:35b0:7c8c:280a])
        by smtp.gmail.com with ESMTPSA id h34sm1112489edb.13.2019.03.29.19.17.30
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 29 Mar 2019 19:17:31 -0700 (PDT)
Date:   Sat, 30 Mar 2019 03:17:30 +0100
From:   Christian Brauner <christian@brauner.io>
To:     Jann Horn <jannh@google.com>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] signal: don't silently convert SI_USER signals to
 non-current pidfd
Message-ID: <20190330021729.3utry4va44jt4ib6@brauner.io>
References: <20190330021232.191205-1-jannh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190330021232.191205-1-jannh@google.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 30, 2019 at 03:12:32AM +0100, Jann Horn wrote:
> The current sys_pidfd_send_signal() silently turns signals with explicit
> SI_USER context that are sent to non-current tasks into signals with
> kernel-generated siginfo.
> This is unlike do_rt_sigqueueinfo(), which returns -EPERM in this case.
> If a user actually wants to send a signal with kernel-provided siginfo,
> they can do that with pidfd_send_signal(pidfd, sig, NULL, 0); so allowing
> this case is unnecessary.
> 
> Instead of silently replacing the siginfo, just bail out with an error;
> this is consistent with other interfaces and avoids special-casing behavior
> based on security checks.
> 
> Fixes: 3eb39f47934f ("signal: add pidfd_send_signal() syscall")
> Signed-off-by: Jann Horn <jannh@google.com>

Reviewed-by: Christian Brauner <christian@brauner.io>

As discussed in
https://lore.kernel.org/lkml/20190330012229.yt3hecmgaj2r6vp7@brauner.io
targeting this for a 5.1 rc.

> ---
>  kernel/signal.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/kernel/signal.c b/kernel/signal.c
> index b7953934aa99..f98448cf2def 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -3605,16 +3605,11 @@ SYSCALL_DEFINE4(pidfd_send_signal, int, pidfd, int, sig,
>  		if (unlikely(sig != kinfo.si_signo))
>  			goto err;
>  
> +		/* Only allow sending arbitrary signals to yourself. */
> +		ret = -EPERM;
>  		if ((task_pid(current) != pid) &&
> -		    (kinfo.si_code >= 0 || kinfo.si_code == SI_TKILL)) {
> -			/* Only allow sending arbitrary signals to yourself. */
> -			ret = -EPERM;
> -			if (kinfo.si_code != SI_USER)
> -				goto err;
> -
> -			/* Turn this into a regular kill signal. */
> -			prepare_kill_siginfo(sig, &kinfo);
> -		}
> +		    (kinfo.si_code >= 0 || kinfo.si_code == SI_TKILL))
> +			goto err;
>  	} else {
>  		prepare_kill_siginfo(sig, &kinfo);
>  	}
> -- 
> 2.21.0.392.gf8f6787159e-goog
> 
