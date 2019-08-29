Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 743E4C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 18:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3958B215EA
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 18:44:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="sXXYtAAa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728635AbfH2SoE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 14:44:04 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41593 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728595AbfH2SoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 14:44:04 -0400
Received: by mail-pl1-f194.google.com with SMTP id m9so1979065pls.8
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 11:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=v1Wo1j2tnlDDBx+9tVoNxVDQEbVVitJMbE6zkrCsNYQ=;
        b=sXXYtAAaVMdonPdNFmCLacc1yMs7M1edc94O5lELRYJxadC3JjUM5YbUwWi4dWK0jJ
         zN29PrPjete6yiziQDuS3B95q7jfnVD8wxKih2rukf/ma6btEa7zj5D+Yc/L3IS1sn3U
         Wzo+4s7a1O06d9y0kvd5ashlirrH5iOvhibysr7HVY69SnScODa2J78ftUOVJxT1EWW3
         9om/44Pa0e6rQamyCftba66Zw3RTmOnxK8wAbFNqJ2qRomcgzemIdJxt+QbsO18zv/Nq
         zzUYrsM5YSe2WqLJp4NWtD/ZnQTypUYO3+AYtZiL7/gQb+E0qjUlhkq1YrIt1qDMwOfE
         HcAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=v1Wo1j2tnlDDBx+9tVoNxVDQEbVVitJMbE6zkrCsNYQ=;
        b=r9sAW1leEOv50yq1TwayEavdBXU6I4Fbe4ehIOcZz6mCGVkyKt3W73IzCApXdar/op
         iW+tKrgMM1zeLUxKCZvjkgOAFZZNaapJQmXBANJtwLqIg1dRS+4fbR7DHtxWDwjnXIZm
         80eLyoVZizPE1mja9a/gxK4i3IgbR7Vyi7utGQxMzF0AMrJN7eIuwSFnVwXdZWB/H6lZ
         hT8OwuGZUdTu1LGOgxrmCgCTwR1LU8SxnVTNcAwWxWs/eeHtm0kX9ve2fZAwvqC/NAPC
         bFP0UE+j/TFHbANMFPhKR8PQsScgFPhUAdVJPacPYB3bYeLXHvTX1qZfItVMJ6+CVOu4
         aI9g==
X-Gm-Message-State: APjAAAUaLVQwbOdAPBUVWlEvhL2hwTVHOrfAlYW5TOobZ1dv3+TYNfyF
        H5B/jhzvypJ8tjlqdvHF7BPVTA==
X-Google-Smtp-Source: APXvYqySV7f6ZMmiEy8g7xUfSMB1MLLk+cK+esN7+JKSPp3z46QGrwido2SYzkKtN/oLNUGfcjySEw==
X-Received: by 2002:a17:902:ba16:: with SMTP id j22mr10261299pls.253.1567104243423;
        Thu, 29 Aug 2019 11:44:03 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id z189sm6021212pfb.137.2019.08.29.11.44.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Aug 2019 11:44:02 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] irqchip/meson-gpio: Add support for meson sm1 SoCs
In-Reply-To: <20190829161635.25067-3-jbrunet@baylibre.com>
References: <20190829161635.25067-1-jbrunet@baylibre.com> <20190829161635.25067-3-jbrunet@baylibre.com>
Date:   Thu, 29 Aug 2019 11:43:59 -0700
Message-ID: <7h1rx3revk.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jerome Brunet <jbrunet@baylibre.com> writes:

> The meson sm1 SoCs uses the same type of GPIO interrupt controller IP
> block as the other meson SoCs, A total of 100 pins can be spied on:
>
> - 223:100 undefined (no interrupt)
> - 99:97   3 pins on bank GPIOE
> - 96:77   20 pins on bank GPIOX
> - 76:61   16 pins on bank GPIOA
> - 60:53   8 pins on bank GPIOC
> - 52:37   16 pins on bank BOOT
> - 36:28   9 pins on bank GPIOH
> - 27:12   16 pins on bank GPIOZ
> - 11:0    12 pins in the AO domain
>
> Mapping is the same as the g12a family but the sm1 controller
> allows to trig an irq on both edges of the input signal. This was
> not possible with the previous SoCs families
>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>

Reviewed-by: Kevin Hilman <khilman@baylibre.com>
Tested-by: Kevin Hilman <khilman@baylibre.com>

> ---
>  drivers/irqchip/irq-meson-gpio.c | 52 +++++++++++++++++++++++---------
>  1 file changed, 38 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/irqchip/irq-meson-gpio.c b/drivers/irqchip/irq-meson-gpio.c
> index dcdc23b9dce6..829084b568fa 100644
> --- a/drivers/irqchip/irq-meson-gpio.c
> +++ b/drivers/irqchip/irq-meson-gpio.c
> @@ -24,14 +24,25 @@
>  #define REG_PIN_47_SEL	0x08
>  #define REG_FILTER_SEL	0x0c
>  
> -#define REG_EDGE_POL_MASK(x)	(BIT(x) | BIT(16 + (x)))
> +/*
> + * Note: The S905X3 datasheet reports that BOTH_EDGE is controlled by
> + * bits 24 to 31. Tests on the actual HW show that these bits are
> + * stuck at 0. Bits 8 to 15 are responsive and have the expected
> + * effect.
> + */

nice catch!

Kevin
