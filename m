Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75B3AC433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 08:30:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49CB82067D
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 08:30:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="MBLoncso"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbfHEIai (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 04:30:38 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:46954 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726423AbfHEIah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 04:30:37 -0400
Received: by mail-io1-f67.google.com with SMTP id i10so52243475iol.13
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 01:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yyl06VlC6+KCObHiyWGls6JX8m37oW5ZUavAlFOgRwY=;
        b=MBLoncsocISVckTtBkUcx1oZ1ATdC/vQzYufJcdYCtudNT1v8Hqd4WTrUuJRTUcaX2
         tLVeYIVrE1wbVHLuk3FkIUUtAP/BOaSfeM/C3DI6bbbbQ7o3iWWrIt1C7ehr8MLkU8UG
         T/04JQH8eW6m6sa8cg7Wc9h+YGcqxJRWkVtOLN5dQiynlleSvpqaXvR7JycB4UhgRguS
         P5LkYwQBoQWdCFHFDIKxFvYAs0qLCzp59JKfbCN1AuFsQQDdVMe4p5mSqdJJfePdktGV
         ygBco/z+Lh5If06f1ZONGTbxoxSH1qEik7tmaVKHKEts5EozNXpSarfdwfNVRlIo930n
         VvKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yyl06VlC6+KCObHiyWGls6JX8m37oW5ZUavAlFOgRwY=;
        b=NMG2F+YQaFTYq93sz2hYMbUpWbfFml13Xc2W8ks8u6GiW64V4drRrct//hp42TBSHV
         /yUIR7phRe5Y0F+EYc3FV+ynLcfhaMsVeuytjjkBNWNMxCfN18uNssAQBkpvuS7Q9HlW
         cr9XH4kTCAXx1zIK5ZdVeBuMUjPuoRFWMx1RuYmjozLUvWcitpSnF1pWxwzFa7Zfzmaq
         A5jSst0nBD/h7cetoE6oTOqJj7EaJzlvtQ0wAPJKxzDFxAEzZu/LDul8je+BmxG9bzyU
         c5eiO/iprYYtc6VDz8oO8VNENpE9/B6v9PDSxfBLP9e/Aq81CegrU+0INjHA1YKlJzTi
         M2Lw==
X-Gm-Message-State: APjAAAXt9m8pbEks/KEk4/1Rnwfywba6MWJacWusKS1b9r7M//B50p7c
        n5DqzXsQHdfqfn+/Ql41gS9DELlecq5GyUhYi+g=
X-Google-Smtp-Source: APXvYqx6T0N1Ra1tdlHmxChURIXRJl2MTdbHsY9hPq8d6/X7xlF0XynNY+IOJMgjzboNM2rejEeOazjtnKv1GoQeMQE=
X-Received: by 2002:a05:6638:cf:: with SMTP id w15mr75704049jao.136.1564993837015;
 Mon, 05 Aug 2019 01:30:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190722134423.26555-1-brgl@bgdev.pl>
In-Reply-To: <20190722134423.26555-1-brgl@bgdev.pl>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 5 Aug 2019 10:30:26 +0200
Message-ID: <CAMRc=Me51RgQu8VK70dy=1OhmHeKo40HLxfsvp2nD5UC+Mzb=w@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] ARM: davinci: da850-evm: remove more legacy GPIO calls
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        David Lechner <david@lechnology.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fbdev@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pon., 22 lip 2019 o 15:44 Bartosz Golaszewski <brgl@bgdev.pl> napisa=C5=82(=
a):
>
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> This is another small step on the path to liberating davinci from legacy
> GPIO API calls and shrinking the davinci GPIO driver by not having to
> support the base GPIO number anymore.
>
> This time we're removing the legacy calls used indirectly by the LCDC
> fbdev driver.
>
> First two patches enable the GPIO backlight driver in
> davinci_all_defconfig.
>
> Patch 3/12 models the backlight GPIO as an actual GPIO backlight device.
>
> Patches 4-6 extend the fbdev driver with regulator support and convert
> the da850-evm board file to using it.
>
> Last three patches are improvements to the da8xx fbdev driver since
> we're already touching it in this series.
>
> v1 -> v2:
> - dopped the gpio-backlight patches from this series as since v5.3-rc1 we
>   can probe the module with neither the OF node nor platform data
> - collected review and ack tags
> - rebased on top of v5.3-rc1
>
> Bartosz Golaszewski (9):
>   ARM: davinci: refresh davinci_all_defconfig
>   ARM: davinci_all_defconfig: enable GPIO backlight
>   ARM: davinci: da850-evm: model the backlight GPIO as an actual device
>   fbdev: da8xx: add support for a regulator
>   ARM: davinci: da850-evm: switch to using a fixed regulator for lcdc
>   fbdev: da8xx: remove panel_power_ctrl() callback from platform data
>   fbdev: da8xx-fb: use devm_platform_ioremap_resource()
>   fbdev: da8xx-fb: drop a redundant if
>   fbdev: da8xx: use resource management for dma
>
>  arch/arm/configs/davinci_all_defconfig  |  27 ++----
>  arch/arm/mach-davinci/board-da850-evm.c |  90 +++++++++++++-----
>  drivers/video/fbdev/da8xx-fb.c          | 118 +++++++++++++-----------
>  include/video/da8xx-fb.h                |   1 -
>  4 files changed, 141 insertions(+), 95 deletions(-)
>
> --
> 2.21.0
>

Hi Sekhar,

the fbdev patches have been acked by Bartlomiej. I think the entire
series can go through the ARM-SoC tree.

Bart
