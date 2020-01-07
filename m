Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 558D8C33C8C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 14:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28A7420715
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 14:42:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VdtjwDkH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728239AbgAGOmC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 09:42:02 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46543 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727894AbgAGOmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 09:42:02 -0500
Received: by mail-pf1-f194.google.com with SMTP id n9so20832222pff.13
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 06:42:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eEYkUNGS8mhB7emwtN313Sbfg/RUdQ3TrJ4h5H7dG24=;
        b=VdtjwDkHRXSyjDMgIZkql7APZlgBoF0R6+7S/GGMVwpAxwVpQL1uLOsVAov0qkInwN
         ryd0HE3YksFSa2rtBal0M2WlOthiJVMUYi/26xiCZDXr1MYho4o1NFOsxgaKazraqGrO
         wITMrAvINmeLVUs2YskXaSRxXxKyjxxrsfjMW9Tm6XW+9gu7WMIbuK9UlTi61Y3zoX3j
         /wTUHoMhAMgsuUiG+GqXWktLyoGOQQngv2Klhp8sHT7nW2s+VkI8cai9HTx8Em3DIiUJ
         F3Y472m8UHZ/6P0RpxH+bCFVg/oq76WCRmJND42l9d6cRk8VtGSalkVksFvwSJoEVgzt
         HpcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eEYkUNGS8mhB7emwtN313Sbfg/RUdQ3TrJ4h5H7dG24=;
        b=BEsb5QPXWDek95LTQapJ234N45iNo/tiq5FATp2KmI8xAKIE9XF1AnIWYL8nCUAd4W
         x+Ub+w9y+6NqHAKnVkhpQFvXJffamoBPY0r/UY9WKwOtPdJZk4elCioQprAwnSDKrW6G
         tUzmehavfedoVIFp+YyMzRNtDDGA1Ob7br9mmuI6Eu6tH4CHE0hzh+lvQJZNvrHTFP7D
         Q3DbSfRatJ8xK3fVPJNhpHPiG40q6Ql4VhNLByL5jdS1RrDd1oCvY2wTFlUVYNdCrmBv
         cYidhIUcPAm+rO3ZppXq+7l+rd5RC6ue+eF3uYbQ2BP+1oO1COkF9uZjzwLFfOTWnszw
         0yPg==
X-Gm-Message-State: APjAAAVfXhaeJRnWxskdFV7WxgzFibLrKGMUfdM3lJ8FVX3fq6Kkc/dz
        b1SRP3AYF6AiGVOxHCOCeCQ=
X-Google-Smtp-Source: APXvYqww1jTJEaOV/kyFVs7FWPXfJGHF0cQheWFpt9nhw0KY1A9+wdcdxP53amRpC5tIRb9yplYo4g==
X-Received: by 2002:a62:7c58:: with SMTP id x85mr114809042pfc.76.1578408121405;
        Tue, 07 Jan 2020 06:42:01 -0800 (PST)
Received: from mail.google.com ([139.180.133.10])
        by smtp.gmail.com with ESMTPSA id w11sm75744646pgs.60.2020.01.07.06.41.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 06:42:00 -0800 (PST)
Date:   Tue, 7 Jan 2020 22:41:53 +0800
From:   Changbin Du <changbin.du@gmail.com>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        hpa@zytor.com, x86@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/nmi: remove the irqwork from long duration nmi
 handler
Message-ID: <20200107144153.ysspbqtuwbywpjnm@mail.google.com>
References: <20200101072017.82990-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200101072017.82990-1-changbin.du@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Thomas,
Have you checked this one? I think this even can consider as a fix.

On Wed, Jan 01, 2020 at 03:20:17PM +0800, Changbin Du wrote:
> First, printk is NMI context safe now since the safe printk has been
> implemented. The safe printk already has an irqwork to make NMI context
> safe.
> 
> Second, the NMI irqwork actually does not work if a NMI handler causes
> panic by watchdog timeout. This NMI irqwork have no chance to run in such
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
> index e676a9916c49..aa15d4f2340f 100644
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
> 2.24.0
> 

-- 
Cheers,
Changbin Du
