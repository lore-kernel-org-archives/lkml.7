Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D3C5CA9EA1
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 07:40:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 136EA21D80
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 07:40:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pJCPbtlK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442133AbfJRHkO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 03:40:14 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36907 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393834AbfJRHkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 03:40:13 -0400
Received: by mail-wr1-f68.google.com with SMTP id p14so5081804wro.4
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 00:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=5iztkm06g93DGhL7MltWaye7ky43Diy2spcjfqFIzXg=;
        b=pJCPbtlKt6Rvp+pV9pRvRRTB2+C2HV3kB8c8I0/yqQfCX1XILLaTFo35IB5nQTJtDM
         r9tTOQbpFgwCznZAP7qrE4cjnzi9qj6ZmdZGM1h1W5XfeazaxmF2MQu7674gQ2JvQYEr
         2njL2yf4ovlyLYmjBr4GUucktQC+SrgIDf56mP73dW7lI8dxYXSRuGNBDTX7/SweYT2e
         riAEXLMNTeT5LEopMjCuOCz8mo1DZscS2DBrV7iO6lbt7JZpcOHcZSgvd4iCvqII523b
         d9g8mpFLw5ipUQ2n81QUKvjxUvNjgP/G6QBe5rqiruEoearvj6JcSGh2PPB4m2NZOlgO
         ra8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=5iztkm06g93DGhL7MltWaye7ky43Diy2spcjfqFIzXg=;
        b=X64ednzFAOmAc7HBfc6nzGpMeM3d1Nqd7bmnPZn5t6CfYqVIOovg4lzfliuE3fIAJO
         5QJETgEg+h8KRLgm/nYMalI3pW1yppLJTgIcujdaQIRaLvzroYhCjBA5OnzNay2Yvz7d
         iyOLabGNZYm2W2927xfFo/pCoHTqBbTvYcTjFDXAe8+Ybe+a7si4U6JH9n3fJaZm5e9q
         mLEqAoGsH0WCdXJN0/gPemnWI5+TWvh0btIkGkUgWdMObITup8r7UgytYHz/vE8hkfEO
         i2Yhyyu8flZq1pAbQmNBljMr4MgUqUHkYoeGd/pmiPgQfeHIU9bh9Cp3StIZjjB+pZp5
         QBBg==
X-Gm-Message-State: APjAAAV8KkVtNQUgRSod3gW2Ta9kZtPFecKy+BHOJKywuXD32NSOwfPE
        1F7F9mMwqGW/OubdMoFt6V18CsFJPsY=
X-Google-Smtp-Source: APXvYqyaR1yIy6/nHTciHSlsM7Yad4h/pKWcFB87SKBaPMe+VEelXm6J/rsxud+fKoJs55M7U1t4SQ==
X-Received: by 2002:adf:a141:: with SMTP id r1mr6580104wrr.122.1571384409625;
        Fri, 18 Oct 2019 00:40:09 -0700 (PDT)
Received: from dell ([95.149.164.47])
        by smtp.gmail.com with ESMTPSA id y1sm5466054wrw.6.2019.10.18.00.40.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 18 Oct 2019 00:40:09 -0700 (PDT)
Date:   Fri, 18 Oct 2019 08:40:07 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH 29/34] backlight/jornada720: Use CONFIG_PREEMPTION
Message-ID: <20191018074007.GV4365@dell>
References: <20191015191821.11479-1-bigeasy@linutronix.de>
 <20191015191821.11479-30-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191015191821.11479-30-bigeasy@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Oct 2019, Sebastian Andrzej Siewior wrote:

> From: Thomas Gleixner <tglx@linutronix.de>
> 
> CONFIG_PREEMPTION is selected by CONFIG_PREEMPT and by CONFIG_PREEMPT_RT.
> Both PREEMPT and PREEMPT_RT require the same functionality which today
> depends on CONFIG_PREEMPT.
> 
> Switch the Kconfig dependency to CONFIG_PREEMPTION.
> 
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Jingoo Han <jingoohan1@gmail.com>
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-fbdev@vger.kernel.org
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> [bigeasy: +LCD_HP700]
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  drivers/video/backlight/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
