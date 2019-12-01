Return-Path: <SRS0=SILN=ZX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C61D9C432C0
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Dec 2019 10:52:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 931DA20833
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Dec 2019 10:52:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DfL709z0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbfLAKw3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Dec 2019 05:52:29 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:45220 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbfLAKw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Dec 2019 05:52:28 -0500
Received: by mail-pj1-f65.google.com with SMTP id r11so7742547pjp.12
        for <linux-kernel@vger.kernel.org>; Sun, 01 Dec 2019 02:52:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sW0LJ/G1N09LX4PKc59YIEDU3pRKgqLhiJhn7knkesE=;
        b=DfL709z0SLbIWML1vezpr98p1iPrjbJ3wWQyCWrzHi3cqbzTEHstkEc9dfNh+8ldxx
         mL7XncKkvF/cQYopJgexmJY/gMZI1Fk9gpW1Oo7P8ttdk6yy5yP7BFPQ8roGGRuwFLiS
         Nf/n7Y8Aj6pqTf2CjP8fC2ZDRdG/5A+lc+BETVjwqe3qBjOTuM/1duYlu9gGzYHxTI/S
         CkfFSg/9/6bXCkujZa4RfBBUvE6uueMd0QUt+N4YQbRva3zEIoSrMAyhIc4KpMCAo4tK
         sJWaizdBR7R3+ZW2IVpR823QyVrfKnNw75VFIGMjad3wYKzpN7S6Zm17y5OifLN8wKA8
         czmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sW0LJ/G1N09LX4PKc59YIEDU3pRKgqLhiJhn7knkesE=;
        b=sKmdXHrwfUrvP5ZFAeVVDkHcI7RHplDWGFXayq+E7qjiqEbQ6vd5N/g1oSedtymJA/
         eyromQC63UGbZtD9fmx0BQ7wMiAk6AAgY9AishhDigXYgerbKINny6QUe2rQgfJlfLLi
         BtDgT3Aze6c7u1grFCV87fKxfCzio3+JidDEzFKqhh44r9yepoS70wIRnqTPfPXw8XN5
         rEx8KWkO9j0vUwjdnpbY/AizthgmP84yTGn1sv5jO3911kGTNyfL7+QO4OcRtiYBsN8R
         nPqExXKI9otv623WMzIqreuLX1r1W4XjXBZQpg9kjS609YiE8N/6Yg2kN3Cwe59uP1m1
         Vsqg==
X-Gm-Message-State: APjAAAXAkx5lTnePNYWCv8aQ4hdjSmphSDi0ZND6ppwjlwMX6UOp2/3w
        DP2jUdwX+vRnKrJD6D1RdsI=
X-Google-Smtp-Source: APXvYqyxVuV8zjAdItwyvKJoV2U+/pkaLi2yKTwOY8FDFgS6fgGPM76y/ho9TAGuiLJSSD4dYelxIw==
X-Received: by 2002:a17:902:ab98:: with SMTP id f24mr22430142plr.257.1575197547889;
        Sun, 01 Dec 2019 02:52:27 -0800 (PST)
Received: from mail.google.com ([139.180.133.10])
        by smtp.gmail.com with ESMTPSA id z26sm8595931pgu.80.2019.12.01.02.52.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Dec 2019 02:52:27 -0800 (PST)
Date:   Sun, 1 Dec 2019 18:52:19 +0800
From:   Changbin Du <changbin.du@gmail.com>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        hpa@zytor.com, x86@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] x86/nmi: remove the irqwork for long nmi handler
 duration warning
Message-ID: <20191201105218.2zcitogobsylytv2@mail.google.com>
References: <20191116084835.3524-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191116084835.3524-1-changbin.du@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI Thomas and Ingo,
Could you check this one? Thanks!

On Sat, Nov 16, 2019 at 04:48:35PM +0800, Changbin Du wrote:
> First, printk is NMI context safe now since the safe printk has been
> implemented. The safe printk will help us to do such work in its irqwork.
> 
> Second, the NMI irqwork actually does not work if a NMI handler causes
> watchdog timeout panic. The NMI irqwork have no chance to run in such
> case, while the safe printk will flush its per-cpu buffer before panic.
> 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> ---
>  arch/x86/include/asm/nmi.h |  1 -
>  arch/x86/kernel/nmi.c      | 20 +++++++++-----------
>  2 files changed, 9 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/x86/include/asm/nmi.h b/arch/x86/include/asm/nmi.h
> index 75ded1d13d98..9d5d949e662e 100644
> --- a/arch/x86/include/asm/nmi.h
> +++ b/arch/x86/include/asm/nmi.h
> @@ -41,7 +41,6 @@ struct nmiaction {
>  	struct list_head	list;
>  	nmi_handler_t		handler;
>  	u64			max_duration;
> -	struct irq_work		irq_work;
>  	unsigned long		flags;
>  	const char		*name;
>  };
> diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
> index 4df7705022b9..0fa51f80ad73 100644
> --- a/arch/x86/kernel/nmi.c
> +++ b/arch/x86/kernel/nmi.c
> @@ -104,18 +104,22 @@ static int __init nmi_warning_debugfs(void)
>  }
>  fs_initcall(nmi_warning_debugfs);
>  
> -static void nmi_max_handler(struct irq_work *w)
> +static void nmi_check_duration(struct nmiaction *action, u64 duration)
>  {
> -	struct nmiaction *a = container_of(w, struct nmiaction, irq_work);
>  	int remainder_ns, decimal_msecs;
> -	u64 whole_msecs = READ_ONCE(a->max_duration);
> +	u64 whole_msecs = READ_ONCE(action->max_duration);
> +
> +	if (duration < nmi_longest_ns || duration < action->max_duration)
> +		return;
> +
> +	action->max_duration = duration;
>  
>  	remainder_ns = do_div(whole_msecs, (1000 * 1000));
>  	decimal_msecs = remainder_ns / 1000;
>  
>  	printk_ratelimited(KERN_INFO
>  		"INFO: NMI handler (%ps) took too long to run: %lld.%03d msecs\n",
> -		a->handler, whole_msecs, decimal_msecs);
> +		action->handler, whole_msecs, decimal_msecs);
>  }
>  
>  static int nmi_handle(unsigned int type, struct pt_regs *regs)
> @@ -142,11 +146,7 @@ static int nmi_handle(unsigned int type, struct pt_regs *regs)
>  		delta = sched_clock() - delta;
>  		trace_nmi_handler(a->handler, (int)delta, thishandled);
>  
> -		if (delta < nmi_longest_ns || delta < a->max_duration)
> -			continue;
> -
> -		a->max_duration = delta;
> -		irq_work_queue(&a->irq_work);
> +		nmi_check_duration(a, delta);
>  	}
>  
>  	rcu_read_unlock();
> @@ -164,8 +164,6 @@ int __register_nmi_handler(unsigned int type, struct nmiaction *action)
>  	if (!action->handler)
>  		return -EINVAL;
>  
> -	init_irq_work(&action->irq_work, nmi_max_handler);
> -
>  	raw_spin_lock_irqsave(&desc->lock, flags);
>  
>  	/*
> -- 
> 2.20.1
> 

-- 
Cheers,
Changbin Du
