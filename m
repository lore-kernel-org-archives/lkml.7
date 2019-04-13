Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0300C10F14
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 18:55:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB43D21721
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 18:55:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727136AbfDMSyn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 14:54:43 -0400
Received: from smtp11.smtpout.orange.fr ([80.12.242.133]:33312 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727074AbfDMSyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 14:54:43 -0400
Received: from mail-qt1-f172.google.com ([209.85.160.172])
        by mwinf5d22 with ME
        id zuue1z00F3jUGuh03uufPd; Sat, 13 Apr 2019 20:54:39 +0200
X-ME-Helo: mail-qt1-f172.google.com
X-ME-Auth: bWF4aS5qb3VyZGFuQHdhbmFkb28uZnI=
X-ME-Date: Sat, 13 Apr 2019 20:54:39 +0200
X-ME-IP: 209.85.160.172
Received: by mail-qt1-f172.google.com with SMTP id k14so15034509qtb.0
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2019 11:54:39 -0700 (PDT)
X-Gm-Message-State: APjAAAVl8O85BJn4tm3UnnuWD/457EETJ6lcM8QD8FiqcYtuvGF2vLga
        Pr1fc/HRO+avFTGeS1Ax6oduF9YkEPF/9usTcd8=
X-Google-Smtp-Source: APXvYqyAIWGms/Ld5bHH3b4v+Cz5YdDsV/LyEGeqCqanUCVawbKdZ5JICupwPjN+cCQlPSW3cprP3aUaVOH0a3xXOj4=
X-Received: by 2002:ac8:38f5:: with SMTP id g50mr51218724qtc.119.1555181678353;
 Sat, 13 Apr 2019 11:54:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190413171532.25967-1-martin.blumenstingl@googlemail.com>
In-Reply-To: <20190413171532.25967-1-martin.blumenstingl@googlemail.com>
From:   Maxime Jourdan <maxi.jourdan@wanadoo.fr>
Date:   Sat, 13 Apr 2019 20:54:27 +0200
X-Gmail-Original-Message-ID: <CAHStOZ5Pe9LvDk4cKAVB4SS5wgFcK-bweFTqU_mnEhOAyZKHuA@mail.gmail.com>
Message-ID: <CAHStOZ5Pe9LvDk4cKAVB4SS5wgFcK-bweFTqU_mnEhOAyZKHuA@mail.gmail.com>
Subject: Re: [PATCH 0/3] 32-bit Meson: add the canvas module
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-amlogic <linux-amlogic@lists.infradead.org>,
        Kevin Hilman <khilman@baylibre.com>, mjourdan@baylibre.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,
On Sat, Apr 13, 2019 at 7:15 PM Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> This adds the canvas module on Meson8, Meson8b and Meson8m2. The canvas
> IP is used by the video decoder hardware as well as the VPU (video
> output) hardware.
>
> Neither the VPU nor the video decoder driver support the 32-bit SoCs
> yet. However, we can still add the canvas module to have it available
> once these drivers gain support for the older SoCs.
>
> I have tested this on my Meson8m2 board by hacking the VPU driver to
> not re-initialize the VPU (and to use the configuration set by u-boot).
> With that hack I could get some image out of the CVBS connector. No
> changes to the canvas driver were required.
>
> Due to lack of hardware I could not test Meson8, but I'm following (as
> always) what the Amlogic 3.10 vendor kernel uses.
> Meson8b is also not tested because u-boot of my EC-100 doesn't have
> video output enabled (so I couldn't use the same hack I used on my
> Meson8m2 board).
>
> This series meant to be applied on top of "Meson8b: add support for the
> RTC on EC-100 and Odroid-C1" from [0]
>
>

The series looks good to me, however I wonder if we should maybe add a
new compatible ?

The canvas IP before the GX* generation does not handle what Amlogic
calls "endianness", the field that allows doing some byte-switching to
get proper NV12/NV21. So the following defines are unusable:

#define MESON_CANVAS_ENDIAN_SWAP16 0x1
#define MESON_CANVAS_ENDIAN_SWAP32 0x3
#define MESON_CANVAS_ENDIAN_SWAP64 0x7
#define MESON_CANVAS_ENDIAN_SWAP128 0xf

It wouldn't change much functionally, but we could have e.g a warning
if a m8 canvas user tries to set endianness even though it does
nothing.

Maxime

> [0] https://patchwork.kernel.org/cover/10899509/
>
>
> Martin Blumenstingl (3):
>   ARM: dts: meson8: add the canvas module
>   ARM: dts: meson8m2: update the offset of the canvas module
>   ARM: dts: meson8b: add the canvas module
>
>  arch/arm/boot/dts/meson8.dtsi   | 21 +++++++++++++++++++++
>  arch/arm/boot/dts/meson8b.dtsi  | 21 +++++++++++++++++++++
>  arch/arm/boot/dts/meson8m2.dtsi | 10 ++++++++++
>  3 files changed, 52 insertions(+)
>
> --
> 2.21.0
>
>
> _______________________________________________
> linux-amlogic mailing list
> linux-amlogic@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-amlogic
