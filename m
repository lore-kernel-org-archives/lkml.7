Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6DF4C3A5A8
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 06:46:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9512A217D7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 06:46:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="oDI5zO2M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727305AbfICGqQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 02:46:16 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:44960 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbfICGqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 02:46:16 -0400
Received: by mail-io1-f66.google.com with SMTP id j4so33401864iog.11
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2019 23:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=evIBGpMkKq7gF2bmpGJVBBvFtlHOCCwSRuXGW57v0+I=;
        b=oDI5zO2M8YPD9bqqe8WAGL5+SleeShW5D3daIfkP4IBrrtXnD8iiyqQSSSur5aK/+6
         tnXF13xw3i9XX6HysJWBNS2tnbdzOimL7w66m7ezaTaFsxq1/UcfO+cBBwWOFwVMHMxV
         tq3hIjQlxiuxg80Z/I3ThLDprCX5lXjcEn053bs24k59SCmmMdQdAb2g6Xmu/SOiP/l7
         1DPQFOui3x52Xy12pyhTRUA1NjZo1TOIN1+jQq90/KptExJ5SbGYuevS3C1T5eLPGnjT
         xRjE93h4x90xtAQKaaeGcoidicG7tIvfIcw9wl/Yq1tlNXLgOpPwg0vD4u/VvFuHRfQJ
         CExg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=evIBGpMkKq7gF2bmpGJVBBvFtlHOCCwSRuXGW57v0+I=;
        b=P7s4Vaj33AFu0tvoZOOYlt+HI4fBqoxhCb6RjgcpEbFOPiW1XhU21hTl10IJysaSun
         UlQPRQn/kIitqDkcmiN/kZmRZG799k1qg7jsG8M9udYip+Fm1xG5B+fYievSg2POFHuy
         4Gs0vq26kT0Xwb3T/pShl2Bih11Faj94g4j61IwAEErRxOOF/9B4y8PaYn4icmYit1TE
         Gmhylwen9RrNsjs3tSzOxd+s4U1HRlrTFkH51ESYq4snwkrFDjm+EL0E9wrFkCgukuJn
         Df62Tw4KcXPXhcrzl0UdqtXY+FDluneKBYtvk4Rl8gPwnwJAbT2KpmZiddBF2uWWY26F
         WImA==
X-Gm-Message-State: APjAAAUbfcCVtzd4LtB53WxSMffohx49z3jwGkfOF7DJMq9y8RBuf/lR
        a6p0nohqLMGVEtoKwmMD27/i6RHunCqTq4nhsPIkUQ==
X-Google-Smtp-Source: APXvYqxCXXDVuNB2PUOLGJK10JygRjb97+McBAXtxlqw5yercmiWGDQp5Y2f1gYVpwc4cq+ZwIk5nVJf7wrFx10heJ0=
X-Received: by 2002:a02:6a56:: with SMTP id m22mr34218784jaf.114.1567493175261;
 Mon, 02 Sep 2019 23:46:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190903142638.79d2cc87@canb.auug.org.au>
In-Reply-To: <20190903142638.79d2cc87@canb.auug.org.au>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 3 Sep 2019 08:46:04 +0200
Message-ID: <CAMRc=Mc=nCCgjrp_4j+n0RBKSoboHzvUFJnQZeG2qOXc8KnZ=g@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the regulator tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wt., 3 wrz 2019 o 06:26 Stephen Rothwell <sfr@canb.auug.org.au> napisa=C5=
=82(a):
>
> Hi all,
>
> After merging the regulator tree, today's linux-next build (powerpc
> ppc64_defconfig) failed like this:
>
> ld: drivers/ata/ahci.o:(.opd+0x150): multiple definition of `regulator_bu=
lk_set_supply_names'; drivers/phy/phy-core.o:(.opd+0x3f0): first defined he=
re
> ld: drivers/ata/ahci.o: in function `.regulator_bulk_set_supply_names':
> ahci.c:(.text+0x1780): multiple definition of `.regulator_bulk_set_supply=
_names'; drivers/phy/phy-core.o:(.text+0x2390): first defined here
> ld: drivers/ata/libahci.o: in function `.regulator_bulk_set_supply_names'=
:
> (.text+0x84a0): multiple definition of `.regulator_bulk_set_supply_names'=
; drivers/phy/phy-core.o:(.text+0x2390): first defined here
> ld: drivers/ata/libahci.o:(.opd+0x5d0): multiple definition of `regulator=
_bulk_set_supply_names'; drivers/phy/phy-core.o:(.opd+0x3f0): first defined=
 here
> ld: drivers/ata/sata_mv.o:(.opd+0x690): multiple definition of `regulator=
_bulk_set_supply_names'; drivers/phy/phy-core.o:(.opd+0x3f0): first defined=
 here
> ld: drivers/ata/sata_mv.o: in function `.regulator_bulk_set_supply_names'=
:
> sata_mv.c:(.text+0xb9b0): multiple definition of `.regulator_bulk_set_sup=
ply_names'; drivers/phy/phy-core.o:(.text+0x2390): first defined here
> ld: drivers/usb/common/common.o: in function `.regulator_bulk_set_supply_=
names':
> (.text+0x7d0): multiple definition of `.regulator_bulk_set_supply_names';=
 drivers/phy/phy-core.o:(.text+0x2390): first defined here
> ld: drivers/usb/common/common.o:(.opd+0x120): multiple definition of `reg=
ulator_bulk_set_supply_names'; drivers/phy/phy-core.o:(.opd+0x3f0): first d=
efined here
> ld: drivers/usb/core/usb.o: in function `.regulator_bulk_set_supply_names=
':
> (.text+0x17d0): multiple definition of `.regulator_bulk_set_supply_names'=
; drivers/phy/phy-core.o:(.text+0x2390): first defined here
> ld: drivers/usb/core/usb.o:(.opd+0x348): multiple definition of `regulato=
r_bulk_set_supply_names'; drivers/phy/phy-core.o:(.opd+0x3f0): first define=
d here
> ld: drivers/usb/core/hub.o: in function `.regulator_bulk_set_supply_names=
':
> (.text+0x2610): multiple definition of `.regulator_bulk_set_supply_names'=
; drivers/phy/phy-core.o:(.text+0x2390): first defined here
> ld: drivers/usb/core/hub.o:(.opd+0x378): multiple definition of `regulato=
r_bulk_set_supply_names'; drivers/phy/phy-core.o:(.opd+0x3f0): first define=
d here
> ld: drivers/usb/core/hcd.o: in function `.regulator_bulk_set_supply_names=
':
> (.text+0x3020): multiple definition of `.regulator_bulk_set_supply_names'=
; drivers/phy/phy-core.o:(.text+0x2390): first defined here
> ld: drivers/usb/core/hcd.o:(.opd+0x378): multiple definition of `regulato=
r_bulk_set_supply_names'; drivers/phy/phy-core.o:(.opd+0x3f0): first define=
d here
> ld: drivers/usb/core/message.o: in function `.regulator_bulk_set_supply_n=
ames':
> (.text+0x2350): multiple definition of `.regulator_bulk_set_supply_names'=
; drivers/phy/phy-core.o:(.text+0x2390): first defined here
> ld: drivers/usb/core/message.o:(.opd+0x240): multiple definition of `regu=
lator_bulk_set_supply_names'; drivers/phy/phy-core.o:(.opd+0x3f0): first de=
fined here
> ld: drivers/usb/core/phy.o: in function `.regulator_bulk_set_supply_names=
':
> (.text+0x700): multiple definition of `.regulator_bulk_set_supply_names';=
 drivers/phy/phy-core.o:(.text+0x2390): first defined here
> ld: drivers/usb/core/phy.o:(.opd+0xc0): multiple definition of `regulator=
_bulk_set_supply_names'; drivers/phy/phy-core.o:(.opd+0x3f0): first defined=
 here
> ld: drivers/usb/core/of.o: in function `.regulator_bulk_set_supply_names'=
:
> (.text+0x2f0): multiple definition of `.regulator_bulk_set_supply_names';=
 drivers/phy/phy-core.o:(.text+0x2390): first defined here
> ld: drivers/usb/core/of.o:(.opd+0x48): multiple definition of `regulator_=
bulk_set_supply_names'; drivers/phy/phy-core.o:(.opd+0x3f0): first defined =
here
> ld: drivers/usb/phy/of.o: in function `.regulator_bulk_set_supply_names':
> (.text+0x120): multiple definition of `.regulator_bulk_set_supply_names';=
 drivers/phy/phy-core.o:(.text+0x2390): first defined here
> ld: drivers/usb/phy/of.o:(.opd+0x18): multiple definition of `regulator_b=
ulk_set_supply_names'; drivers/phy/phy-core.o:(.opd+0x3f0): first defined h=
ere
> ld: drivers/usb/host/ehci-hcd.o: in function `.regulator_bulk_set_supply_=
names':
> (.text+0x11830): multiple definition of `.regulator_bulk_set_supply_names=
'; drivers/phy/phy-core.o:(.text+0x2390): first defined here
> ld: drivers/usb/host/ehci-hcd.o:(.opd+0x8d0): multiple definition of `reg=
ulator_bulk_set_supply_names'; drivers/phy/phy-core.o:(.opd+0x3f0): first d=
efined here
> ld: drivers/usb/host/ohci-hcd.o: in function `.regulator_bulk_set_supply_=
names':
> (.text+0xe8d0): multiple definition of `.regulator_bulk_set_supply_names'=
; drivers/phy/phy-core.o:(.text+0x2390): first defined here
> ld: drivers/usb/host/ohci-hcd.o:(.opd+0x570): multiple definition of `reg=
ulator_bulk_set_supply_names'; drivers/phy/phy-core.o:(.opd+0x3f0): first d=
efined here
> ld: drivers/of/platform.o: in function `.regulator_bulk_set_supply_names'=
:
> (.text+0x1180): multiple definition of `.regulator_bulk_set_supply_names'=
; drivers/phy/phy-core.o:(.text+0x2390): first defined here
> ld: drivers/of/platform.o:(.opd+0x180): multiple definition of `regulator=
_bulk_set_supply_names'; drivers/phy/phy-core.o:(.opd+0x3f0): first defined=
 here
>
> Caused by commit
>
>   d0087e72710c ("regulator: provide regulator_bulk_set_supply_names()")
>
> I applied the following patch for today.
>
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Tue, 3 Sep 2019 14:23:17 +1000
> Subject: [PATCH] regulator: stubs in header files should be static inline
>
> Fixes: d0087e72710c ("regulator: provide regulator_bulk_set_supply_names(=
)")
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  include/linux/regulator/consumer.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/regulator/consumer.h b/include/linux/regulator=
/consumer.h
> index 6d2181a76987..fe9bdf37c296 100644
> --- a/include/linux/regulator/consumer.h
> +++ b/include/linux/regulator/consumer.h
> @@ -586,7 +586,7 @@ static inline int regulator_list_voltage(struct regul=
ator *regulator, unsigned s
>         return -EINVAL;
>  }
>
> -void regulator_bulk_set_supply_names(struct regulator_bulk_data *consume=
rs,
> +static inline void regulator_bulk_set_supply_names(struct regulator_bulk=
_data *consumers,
>                                      const char *const *supply_names,
>                                      unsigned int num_supplies)
>  {
> --
> 2.23.0.rc1
>
> --
> Cheers,
> Stephen Rothwell

Hi Stephen,

a patch for this was already on the list: https://lkml.org/lkml/2019/9/2/66=
8

Bart
