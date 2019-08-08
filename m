Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB756C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 17:57:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BA652171F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 17:57:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="2D6xPvfG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733047AbfHHR54 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 13:57:56 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33148 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729780AbfHHR5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 13:57:55 -0400
Received: by mail-pg1-f193.google.com with SMTP id n190so3638879pgn.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 10:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:date:message-id:mime-version;
        bh=dlAMDaen95qV2UTyBXZtIHRtvI1SXwxJ2LQmY5Uh0zs=;
        b=2D6xPvfGrZOu7k7cMvY57yHcMqEPpzgyC3LjZsj0+wycBUR53jHzXW2/dRAb7Tjh9l
         MOsBWg1KHVxkbrJtbEDPZbcaL3D/Cx1MmYEGn6PPFO/F6B5n2L3hNxRE9YrBj6XXiTp1
         AsqcRTjU7oORT279g88Lv1Afie2AeB0n3kg6jCii5bY6ryVuKsePMW+GU4+PQGReG01I
         iUr6Skj2nmRDY+5iUL/N23Qc/jCjSdxaZtF+MdHDau84vI+5cEgEvfNbSs85BBC/WE59
         KXZJ6135QBqHpFgtJo6FSWoH1gYfVV0NwL/PEJaBBbRjSkEJmm6AZIja+gzYeSBhWYxR
         8yQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:date:message-id
         :mime-version;
        bh=dlAMDaen95qV2UTyBXZtIHRtvI1SXwxJ2LQmY5Uh0zs=;
        b=PJJwZE52tYRsQEa/D+oYqu9fN5i67jqZ+rONcCiKbbTdzI/pUqJNBFvx4+t1Z+yqht
         yMHdODTGbDecH2z4ivLMvOVcIZfI2EJPzuCK0LRfaKNOkK6CmV7uaas37LF3LTje2duq
         9G+IRNJqssFgNiAlvQyYW1x3s8GRsG2TaUjHxd1fA7E3Er1eW5SOSkatZVxCwuJMrSq+
         ThNGrIbMhWxYSyR9EnP5829Lio/39n4H8P3fu5eZALr7ZYwPjv3b6pO3N86XK6dhmdcx
         gcZ9zjzK3u/qhQaue9zePHMB2SEUUd2sCmIa+tpkUrC2SD9le8VCK+y+68OeMQchnCH9
         A6og==
X-Gm-Message-State: APjAAAXQX8U7myLl2j+whhTbnsFBWcqLTYAdJ2o1oRYx4u/LEOw0Qwjl
        W9Hwv+5D8Qj6kYTQp50vJhUlbg==
X-Google-Smtp-Source: APXvYqxqWxI19xhZ4NNLIkIIuu5ZgI5/xUh8viSAx5HhgIax1wserqOX54QOEDrSA48PXB6+dxkL8A==
X-Received: by 2002:a62:ce8e:: with SMTP id y136mr17048236pfg.29.1565287075043;
        Thu, 08 Aug 2019 10:57:55 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id 65sm97022232pff.148.2019.08.08.10.57.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Aug 2019 10:57:54 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        christianshewitt@gmail.com
Subject: Re: [PATCH 0/6] arm64: add support for the Khadas VIM3
In-Reply-To: <20190731124000.22072-1-narmstrong@baylibre.com>
Date:   Thu, 08 Aug 2019 10:57:53 -0700
Message-ID: <7h4l2rfske.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> The Khadas VIM3 uses the Amlogic S922X or A311S SoC, both based on the
> Amlogic G12B SoC family, on a board with the same form factor as the
> VIM/VIM2 models. It ships in two variants; basic and
> pro which differ in RAM and eMMC size:
>
> - 2GB (basic) or 4GB (pro) LPDDR4 RAM
> - 16GB (basic) or 32GB (pro) eMMC 5.1 storage
> - 16MB SPI flash
> - 10/100/1000 Base-T Ethernet
> - AP6398S Wireless (802.11 a/b/g/n/ac, BT5.0)
> - HDMI 2.1 video
> - 1x USB 2.0 + 1x USB 3.0 ports
> - 1x USB-C (power) with USB 2.0 OTG
> - 3x LED's (1x red, 1x blue, 1x white)
> - 3x buttons (power, function, reset)
> - IR receiver
> - M2 socket with PCIe, USB, ADC & I2C
> - 40pin GPIO Header
> - 1x micro SD card slot
>
> First of all, the S922X and A311D are now specified since they differ
> by some HW features and the capable operating points.
>
> A common meson-g12b-khadas-vim3.dtsi is added to support both S922X and
> A311D SoCs supported by two variants of the board.
>
> Odroid-N2 is changed to use the s922x.dtsi include.
>
> Dependencies:
> - patch 5 & 6: "arm64: g12a: add support for DVFS" at [1]

And patch 6 on the clock series (specificly the new CPU_CLKB id)

> [1] https://patchwork.kernel.org/cover/11063837/
>
> Christian Hewitt (4):
>   soc: amlogic: meson-gx-socinfo: add A311D id

Queued in v5.4/drivers

>   dt-bindings: arm: amlogic: add support for the Khadas VIM3
>   arm64: dts: meson-g12b: support a311d and s922x cpu operating points

Queued in v5.4/dt64

>   arm64: dts: meson-g12b-khadas-vim3: add initial device-tree

This one I've left off for now due to the clock dependency and some
suggestions from Martin.

> Neil Armstrong (2):
>   dt-bindings: arm: amlogic: add bindings for G12B based S922X SoC
>   dt-bindings: arm: amlogic: add bindings for the Amlogic G12B based
>     A311D SoC

Queued in v5.4/dt64

Kevin
