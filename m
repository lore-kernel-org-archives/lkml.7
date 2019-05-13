Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D500C04AB1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 09:58:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 609F221479
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 09:58:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="rQAsUxmb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728113AbfEMJ6r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 05:58:47 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54425 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727339AbfEMJ6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 05:58:47 -0400
Received: by mail-wm1-f67.google.com with SMTP id i3so7360503wml.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 02:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=7fofqNxbQms2+HwADe45aBmqLLu1PHLRYhgcawTMF5w=;
        b=rQAsUxmbSNHpYELYa3AtXHTF6H7uSGcX5KB+iChn/ZAVb0g/ZeOTsHlGShNFrlLZCe
         MsGrQZSIoDohYhzAiN9zHefJuQ5UgARlg4i7PumliY2Ge/B+uuz2yxm4lx+2PH1nPhFd
         kz0upbi1NVh8VVQR8YwOl1lPPbTijccu4HH8iqIcIFEOO4EqbwOzIWHP8adzzInNZXn/
         kuAX1Q5CaEfBLhfUEaQ52E3Np48thKKulmTGe1LYKuWltClc9Orvk4xYcSD5R3NMxUmx
         y6aenVmacBl2X1KO/9TB2i9lVBm8KpUU2ffcGwU/Gd6pzJoVfpOvfp1ivTELyYNTXI1H
         e4XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=7fofqNxbQms2+HwADe45aBmqLLu1PHLRYhgcawTMF5w=;
        b=PPB9BoGaf/kTnxjU7XSBC/QuKJdsDMamvToL7Fku1gZOX9se4sj2hfUbPP11dqjsqp
         1CYsakDV644IpGqjLLfAK7QR+AjPa37unj9Pq6H+/ae/CZ9JRc3JOHMpMX5UC1xmGgPS
         mUUah/yT+St8y2il/yivtLHRUgu5rnE+2jWiRZ8J4M3ek7N+pf4TFXt7/JwZx2g2iE96
         63wVDToYp20W/XafENrcdKUWsoJChSdV4CjRSptPM0+vk6Fbm8lJ58zdh2QRnYovrMS8
         WcHnHDqW4r0FWZEf54wPPVdAeRyLY1Q2AgAa3bgp5JYUx5widgUYQ/AQzJt9buhzDrlv
         XDxw==
X-Gm-Message-State: APjAAAUjtSlZbJ7Y++qrGXIFKdwyjFOCcYPk813obkUkn+GMwOWM1gwL
        h6O+uEpFSzp73ZI296EZkR2mjg==
X-Google-Smtp-Source: APXvYqyYDFbeqT3rRqew9EDTgcLF2uXw3708KjlbLJNd9je1Y3K8HdRrkDcoqgCgDXK3+kEnUnabKw==
X-Received: by 2002:a1c:f205:: with SMTP id s5mr14236365wmc.131.1557741525070;
        Mon, 13 May 2019 02:58:45 -0700 (PDT)
Received: from boomer.baylibre.com (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id c130sm29316546wmf.47.2019.05.13.02.58.43
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 13 May 2019 02:58:44 -0700 (PDT)
Message-ID: <24b8cd2eb2879378ca0cac6ddfd9c5cae68699bc.camel@baylibre.com>
Subject: Re: [PATCH 0/3] mmc: meson-gx: add ddr-access-quirk support
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>, ulf.hansson@linaro.org,
        khilman@baylibre.com
Cc:     baylibre-upstreaming@groups.io, linux-mmc@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Mon, 13 May 2019 11:58:43 +0200
In-Reply-To: <20190513091548.16674-1-narmstrong@baylibre.com>
References: <20190513091548.16674-1-narmstrong@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-05-13 at 11:15 +0200, Neil Armstrong wrote:
> On the Amlogic G12A SoC family, (only) the SDIO controller fails to access
> the data from DDR, leading to a broken controller.
> 
> Add the amlogic,ddr-access-quirk property so signal this particular
> controller has this bug and needs a quirk to work properly.
> 
> But each MMC controller has 1,5KiB of SRAM after the registers, that can
> be used as bounce buffer to avoid direct DDR access from the integrated
> DMAs (this SRAM may be used by the boot ROM when DDR is not yet initialized).
> 
> The quirk is to disable the chained descriptor for this controller, and
> use this SRAM memory zone as buffer for the bounce buffer fallback mode.
> 
> The performance hit hasn't been evaluated, but the fix has been tested
> using a WiFi AP6398S SDIO module, and the iperf3 Bandwidth measurement gave
> 55.2 Mbits/sec over a 63 Hours long test, with the SDIO ios set as High-Speed
> at 50MHz clock. It gave around 170 Mbits/sec as SDR104 and 200MHz clock.

These numbers looks to be limited by the MMC bandwidth of the related modes.
So, if the SRAM quirk introduce a penalty for the controller, it does not appear
to be a limiting factor, AFAICT.

> 
> Neil Armstrong (3):
>   dt-bindings: mmc: meson-gx: add ddr-access-quirk property
>   mmc: meson-gx: add ddr-access-quirk
>   arm64: dts: meson-g12a: add ddr-access-quirk property to SDIO
>     controller
> 
>  .../bindings/mmc/amlogic,meson-gx.txt         |  4 ++
>  arch/arm64/boot/dts/amlogic/meson-g12a.dtsi   |  1 +
>  drivers/mmc/host/meson-gx-mmc.c               | 65 +++++++++++++++----
>  3 files changed, 57 insertions(+), 13 deletions(-)
> 


