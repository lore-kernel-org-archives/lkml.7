Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA580C282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 23:12:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93EB320656
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 23:12:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MhDS2Dh6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729119AbgAIXM2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 18:12:28 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53509 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbgAIXM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 18:12:28 -0500
Received: by mail-wm1-f66.google.com with SMTP id m24so4846162wmc.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 15:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IWz9xWsEI1+86yCJM7yCCiK90nZabCdzx093IFKqpFQ=;
        b=MhDS2Dh68R1EBrSZF3dOGZdMeX6aJpvQmuB8+QL0PRShJEFjrV4+q/TB0fn/0PMxhn
         pHts+ZPjikhaK3+DC5K8UQc7CHion+2Xpjlg/7RK5ea+zgbkI699n8REF87gNTTs4VWF
         mggF6XXE8Ea2KpbbnCJMlpBuSBlcnNrdJsAPvuHRRhFOwuyPVKe2VzsAxnM6Fn/C9V++
         4zqzBR0Mx0TMEsfFoKWjSGcVZimHo1fWKU4z/lGVpqI+FgOid7UCBtbciMfi3dGw3f+F
         PqkBelyj079EP5ij5DteK8Fa0beOu5m02coK6E61uvs4vu3tmCPTDESrJlpfqbFfei7u
         Kkew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=IWz9xWsEI1+86yCJM7yCCiK90nZabCdzx093IFKqpFQ=;
        b=ql+lSBocbOv3U3wgegEBqOXDoy+ktCtVEFosB5hCSisY40207c23TaoEsWKEyy9PNh
         wJpAgrb0BroC2DYm26xPolKqldW5zTRCCHw7gZVgCRNKF7x0Ddm1jcsl+tD3MUG6PEOU
         QEj/pdGKhn40/TH1HFwuE1teYQBZXOQrZyIa959VcsJaZWI5vbFCD62TE4DLBn7vQCEB
         lwdH3K/iEpdOri/fiBbPK6XNwImU4vx+CCKL/StkI21esBlmpGLA5+2278ryunkO2IkF
         SWqZthOWDaIFz32wq1xu31SmPUGZaroxJvG9RpNFFLZqZyWMbloEqhbUUXTALGDT4+ZP
         T61w==
X-Gm-Message-State: APjAAAVo/ImKmf2VzPHwd7Jr9ZUuwqqr6yoTEPfMaV7oMQeIkNkUNdvu
        +GlOI+hO433FmRyJO0ddRIQoVSrXu4BWrQ==
X-Google-Smtp-Source: APXvYqzL9uwEACaxKqA0GUMup78Gv4eHv8lsjHStUstVk2oxh5YMEnUtLWwEAeY5Que0MbYlgkyS6A==
X-Received: by 2002:a1c:a50e:: with SMTP id o14mr341133wme.2.1578611544561;
        Thu, 09 Jan 2020 15:12:24 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:f1d5:61e0:e9d8:1c3d? ([2a01:e34:ed2f:f020:f1d5:61e0:e9d8:1c3d])
        by smtp.googlemail.com with ESMTPSA id n8sm58549wrx.42.2020.01.09.15.12.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jan 2020 15:12:23 -0800 (PST)
Subject: Re: [PATCH v2 1/3] clocksource: davinci: only enable tim34 in
 periodic mode once it's initialized
To:     Bartosz Golaszewski <brgl@bgdev.pl>, Sekhar Nori <nsekhar@ti.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Lechner <david@lechnology.com>,
        Kevin Hilman <khilman@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20191224100328.13608-1-brgl@bgdev.pl>
 <20191224100328.13608-2-brgl@bgdev.pl>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Autocrypt: addr=daniel.lezcano@linaro.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <c6b69cb6-b784-0d6c-efaf-87926c20db16@linaro.org>
Date:   Fri, 10 Jan 2020 00:12:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191224100328.13608-2-brgl@bgdev.pl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/12/2019 11:03, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> The DM365 platform has a strange quirk (only present when using ancient
> u-boot - mainline u-boot v2013.01 and later works fine) where if we
> enable the second half of the timer in periodic mode before we do its
> initialization - the time won't start flowing and we can't boot.
> 
> When using more recent u-boot, we can enable the timer, then reinitialize
> it and all works fine.
> 
> I've been unable to figure out why that is, but a workaround for this
> is straightforward - don't enable the tim34 timer in periodic mode until
> it's properly initialized.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  drivers/clocksource/timer-davinci.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/clocksource/timer-davinci.c b/drivers/clocksource/timer-davinci.c
> index 62745c962049..2801f21bb0e2 100644
> --- a/drivers/clocksource/timer-davinci.c
> +++ b/drivers/clocksource/timer-davinci.c
> @@ -62,6 +62,7 @@ static struct {
>  	struct clocksource dev;
>  	void __iomem *base;
>  	unsigned int tim_off;
> +	bool initialized;
>  } davinci_clocksource;
>  
>  static struct davinci_clockevent *
> @@ -94,8 +95,9 @@ static void davinci_tim12_shutdown(void __iomem *base)
>  	 * halves. In this case TIM34 runs in periodic mode and we must
>  	 * not modify it.
>  	 */
> -	tcr |= DAVINCI_TIMER_ENAMODE_PERIODIC <<
> -		DAVINCI_TIMER_ENAMODE_SHIFT_TIM34;
> +	if (likely(davinci_clocksource.initialized))
> +		tcr |= DAVINCI_TIMER_ENAMODE_PERIODIC <<
> +		       DAVINCI_TIMER_ENAMODE_SHIFT_TIM34;
>  
>  	writel_relaxed(tcr, base + DAVINCI_TIMER_REG_TCR);
>  }
> @@ -107,8 +109,9 @@ static void davinci_tim12_set_oneshot(void __iomem *base)
>  	tcr = DAVINCI_TIMER_ENAMODE_ONESHOT <<
>  		DAVINCI_TIMER_ENAMODE_SHIFT_TIM12;
>  	/* Same as above. */
> -	tcr |= DAVINCI_TIMER_ENAMODE_PERIODIC <<
> -		DAVINCI_TIMER_ENAMODE_SHIFT_TIM34;
> +	if (likely(davinci_clocksource.initialized))
> +		tcr |= DAVINCI_TIMER_ENAMODE_PERIODIC <<
> +		       DAVINCI_TIMER_ENAMODE_SHIFT_TIM34;
>  
>  	writel_relaxed(tcr, base + DAVINCI_TIMER_REG_TCR);
>  }
> @@ -206,6 +209,8 @@ static void davinci_clocksource_init_tim34(void __iomem *base)
>  	writel_relaxed(0x0, base + DAVINCI_TIMER_REG_TIM34);
>  	writel_relaxed(UINT_MAX, base + DAVINCI_TIMER_REG_PRD34);
>  	writel_relaxed(tcr, base + DAVINCI_TIMER_REG_TCR);
> +
> +	davinci_clocksource.initialized = true;
>  }

Why not move clockevents_config_and_register() after
davinci_clocksource_init_tim34() is called ?


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

