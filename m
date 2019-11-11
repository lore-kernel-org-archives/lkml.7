Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA27BC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 09:25:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 781E220674
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 09:25:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g45g1B9C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbfKKJY7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 04:24:59 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33504 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbfKKJY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 04:24:58 -0500
Received: by mail-wr1-f66.google.com with SMTP id w9so6964059wrr.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 01:24:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=YWJNU/KRDci9JaBSSlvjD8ejfPkt5O8bTmBLBv7FEfI=;
        b=g45g1B9CgnICXh+L7YGsSwGItv1VEJKTbuwdGm/cgURZrltl6remdq17TWkf9IQj0t
         2cgaZlsss/2FQVPU4QV83/EZYMXeP4/JM/rzgGquBXWY6tsruKzcr0+SGbVegz+xLLcZ
         WRlkw6voDLEDe2B7TEZryWLFlOlqEbkxvcdq3fjD/vIom2LOugSVjFmrSTEjpHYiyTeg
         jy3QY5TM9aS6jBUdcaYKPjTc07TztHyuCW+skdOtl3zc2svXUOdhiAc53Q5Ohry9vPLQ
         X91mgOIDh2Hy+Xa/MpzmiIpup7RmwG/dso2672x4CVD4Z4HurT/bAG9/az5EB48HKFhA
         5CBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=YWJNU/KRDci9JaBSSlvjD8ejfPkt5O8bTmBLBv7FEfI=;
        b=VCmZ+9UXWYRX6ZAbPRTvkHFG77DqEHgvtbJeNoiLyX7qW4qgSqx/to+amhWeU2kVR1
         a5Hduw0OAEaa2IwgnBCPQIbGFV8KFLnM8mEkOVt7olcrvlsljfcSFG0AgNKJZ7EVt4qv
         HrQWfiZcgQ7fVuihPBEzH0LxNBg70qSQqcyu6s5vk0S33wjeGZhDYsZR/K5pZpoc/8Hc
         zle4IrWj8GUkDj77hfU46Ufn33O1t/4yMhSf3Vc93rGnY5xsa6v4XW0Y7J/3ieM4NQki
         IJrcYlrR5V4VVKSuEydy2ZgBZd3cqPUKYnptiyZpm2Y1derlFZshKbPI5KW6ANUjqUK+
         JjAw==
X-Gm-Message-State: APjAAAU6Hh+Db03vGk5qOFVXsp8oEApnv6rQsuY1Vm7fIkOfGtGunO3b
        uOH1vGSJAwvqQBxK3SHVHIq0Cw==
X-Google-Smtp-Source: APXvYqxLWSqz1Db3ODg/rszTepYxIenSPrtyAq4nFKwOfdpSCLBq8+G1tD9JlSzHMInuJ7vRBsDVHg==
X-Received: by 2002:adf:e5c5:: with SMTP id a5mr20805012wrn.103.1573464294593;
        Mon, 11 Nov 2019 01:24:54 -0800 (PST)
Received: from dell ([95.147.198.88])
        by smtp.gmail.com with ESMTPSA id w18sm14019087wrl.2.2019.11.11.01.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 01:24:54 -0800 (PST)
Date:   Mon, 11 Nov 2019 09:24:46 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Kiran Gunda <kgunda@codeaurora.org>
Cc:     bjorn.andersson@linaro.org, jingoohan1@gmail.com,
        b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org,
        daniel.thompson@linaro.org, jacek.anaszewski@gmail.com,
        pavel@ucw.cz, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dan Murphy <dmurphy@ti.com>,
        Andy Gross <agross@kernel.org>, linux-fbdev@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH V10 1/8] backlight: qcom-wled: Rename pm8941-wled.c to
 qcom-wled.c
Message-ID: <20191111092446.GO18902@dell>
References: <1572589624-6095-1-git-send-email-kgunda@codeaurora.org>
 <1572589624-6095-2-git-send-email-kgunda@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1572589624-6095-2-git-send-email-kgunda@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 01 Nov 2019, Kiran Gunda wrote:

> pm8941-wled.c driver is supporting the WLED peripheral
> on pm8941. Rename it to qcom-wled.c so that it can support
> WLED on multiple PMICs.
> 
> Signed-off-by: Kiran Gunda <kgunda@codeaurora.org>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Acked-by: Rob Herring <robh@kernel.org>
> Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
> Acked-by: Pavel Machek <pavel@ucw.cz>
> ---
>  .../bindings/leds/backlight/{pm8941-wled.txt => qcom-wled.txt}    | 2 +-
>  drivers/video/backlight/Kconfig                                   | 8 ++++----
>  drivers/video/backlight/Makefile                                  | 2 +-
>  drivers/video/backlight/{pm8941-wled.c => qcom-wled.c}            | 0
>  4 files changed, 6 insertions(+), 6 deletions(-)
>  rename Documentation/devicetree/bindings/leds/backlight/{pm8941-wled.txt => qcom-wled.txt} (95%)
>  rename drivers/video/backlight/{pm8941-wled.c => qcom-wled.c} (100%)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
