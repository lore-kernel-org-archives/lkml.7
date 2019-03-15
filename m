Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77FD0C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 21:52:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3288D2085A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 21:52:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gateworks-com.20150623.gappssmtp.com header.i=@gateworks-com.20150623.gappssmtp.com header.b="wKdJ6Dm2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbfCOVwa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 17:52:30 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38110 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbfCOVwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 17:52:30 -0400
Received: by mail-wr1-f65.google.com with SMTP id g12so11072560wrm.5
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 14:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Jk5leCOS/Mw4F1Qb3pxp/rPRbBsAN9mIty/axtt5WbU=;
        b=wKdJ6Dm2+DxzO2aDnPhK8CloOrBCsB1ELQ4ZBHV91YjOVv1lMdbkV0wWiTCbpq2C7Q
         bgI5TIbojDT9KR6cAqj7df1VwGBWORVOFI+QkBriGt6wdyMpci8DiOq99C9IqkRU6ITB
         PDjAVGPnd31avU/tSrqMe+9+5M84lroSwIX02PwJT0vTsnWpy03v0OkMBkG1zbY9Mrmq
         QGmj/xVAdBV20LCV7LNwINnmppEWr6UBAFCM3leGS+J94HKAP6TtKk5CbvGgHCNCQ5dl
         Rw2XBLwlflw2duYRBThDo2liaZdHX62LT5SsFVWFs1MqzbSdCmhdyeolJGubeLBJDy4s
         xJ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Jk5leCOS/Mw4F1Qb3pxp/rPRbBsAN9mIty/axtt5WbU=;
        b=ohsfxAtiMnyAAy0nPAxLZWPnbQ8qNrqjLQ86xMgwEhMbfh5K9ZCt4E9f2kS9w/o8Fz
         xwK/bpwlYVFyzspbZ6XFTNouHitHWxO+CuCaB6n+9l4ktrj9uZcN6/904yMpTNbhzN7/
         YjVfzPCMf3qFu3+PdWkK2YKA4lKNCVW/Kfmuinw/SRXVhGE8V0BQw4pwcyEfOdA404B/
         E4Zcf2lnxC+rZ5P9egVjma/hSIawmqX5ARDSQI4ydMsqw85epyTmH6Y401Odkl4q1Zc7
         YEFs8ckuG7jdO4kAqoN7jRfKRt/EiQ2sk10kNLJIPIYQfBHxQERb8sMIroxRHksmV2bY
         L/lA==
X-Gm-Message-State: APjAAAX22lubmzjGADVwPnN/3m14+LSkwzEQD9NbHO6nrvYyYwjSw7km
        jhhSVxbhEJE5nDqtfcIBdsCsNH0TjwrgBjDl8EnogQ==
X-Google-Smtp-Source: APXvYqzy7rwz1iJHXUjHF+FfWugnySK2tIwyEXj0iD6cDEJLpO8X3WhMUnjM51mLMiJZXPRCbDfaDscomIl9wKE3PFo=
X-Received: by 2002:a5d:690d:: with SMTP id t13mr3690760wru.135.1552686747969;
 Fri, 15 Mar 2019 14:52:27 -0700 (PDT)
MIME-Version: 1.0
References: <1461951139-6109-1-git-send-email-dianders@chromium.org> <yw1x5zsx5wc7.fsf@mansr.com>
In-Reply-To: <yw1x5zsx5wc7.fsf@mansr.com>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Fri, 15 Mar 2019 14:52:10 -0700
Message-ID: <CAJ+vNU1PxK-B63Dc3AgzYb9POyxxoF-xPOWBEpxJ+3eVNK8xqw@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Patches to allow consistent mmc / mmcblk numbering
 w/ device tree
To:     =?UTF-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>,
        Marek Vasut <marex@denx.de>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        shawn.lin@rock-chips.com, Adrian Hunter <adrian.hunter@intel.com>,
        stefan@agner.ch, Linux MMC List <linux-mmc@vger.kernel.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Jisheng Zhang <jszhang@marvell.com>,
        linux-rockchip@lists.infradead.org,
        devicetree-spec@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        open list <linux-kernel@vger.kernel.org>,
        vbyravarasu@nvidia.com, Lars-Peter Clausen <lars@metafoo.de>,
        Russell King - ARM Linux <linux@arm.linux.org.uk>,
        jonathanh@nvidia.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        grundler@chromium.org, Kumar Gala <galak@codeaurora.org>,
        lporzio@micron.com, Rob Herring <robh+dt@kernel.org>,
        chaotian.jing@mediatek.com,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        sudeep.holla@arm.com, zhonghui.fu@linux.intel.com,
        kirill.shutemov@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Harvey - Principal Software EngineerGateworks Corporation -
http://www.gateworks.com/3026 S. Higuera St. San Luis Obispo CA
93401805-781-2000
On Tue, Mar 5, 2019 at 4:39 AM M=C3=A5ns Rullg=C3=A5rd <mans@mansr.com> wro=
te:
>
> Douglas Anderson <dianders@chromium.org> writes:
>
> > This series picks patches from various different places to produce what
> > I consider the best solution to getting consistent mmc and mmcblk
> > ordering.
> >
> > Why consistent ordering and why not just use UUIDs?  IMHO consistent
> > ordering solves a few different problems:
> >
> > 1. For poor, feeble-minded humans like me, have sane numbering for
> >    devices helps a lot.  When grepping through dmesg it's terribly hand=
y
> >    if a given SDMMC device has a consistent number.  I know that I can
> >    do "dmesg | grep mmc0" or "dmesg | grep mmcblk0" to find info about
> >    the eMMC.  I know that I can do "dmesg | grep mmc1" to find info
> >    about the SD card slot.  I don't want it to matter which one probed
> >    first, I don't want it to matter if I'm working on a variant of the
> >    hardware that has the SD card slot disabled, and I don't want to car=
e
> >    what my boot device was.  Worrying about what device number I got
> >    increases my cognitive load.
> >
> > 2. There are cases where it's not trivially easy during development to
> >    use the UUID.  Specifically I work a lot with coreboot / depthcharge
> >    as a BIOS.  When configured properly, that BIOS has a nice feature t=
o
> >    allow you to fetch the kernel and kernel command line from TFTP by
> >    pressing Ctrl-N.  In this particular case the BIOS doesn't actually
> >    know which disk I'd like for my root filesystem, so it's not so easy
> >    for it to put the right UUID into the command line.  For this
> >    purpose, knowing that "mmcblk0" will always refer to eMMC is handy.
> >
> > Changes in v2:
> > - Rebased atop mmc-next
> > - Stat dynamic allocation after fixed allocation; thanks Wolfram!
> > - rk3288 patch new for v2
> >
> > Douglas Anderson (1):
> >   ARM: dts: rockchip: Add mmc aliases for rk3288 platform
> >
> > Jaehoon Chung (1):
> >   Documentation: mmc: Document mmc aliases
> >
> > Stefan Agner (2):
> >   mmc: read mmc alias from device tree
> >   mmc: use SD/MMC host ID for block device name ID
> >
> >  Documentation/devicetree/bindings/mmc/mmc.txt | 11 +++++++++++
> >  arch/arm/boot/dts/rk3288.dtsi                 |  4 ++++
> >  drivers/mmc/card/block.c                      |  2 +-
> >  drivers/mmc/core/host.c                       | 17 ++++++++++++++++-
> >  4 files changed, 32 insertions(+), 2 deletions(-)
>
> Did anyone ever come up with an acceptable solution for this?  After
> three years, I'm getting tired of rebasing these patches onto every new
> kernel.
>
> UUIDs or similar are NOT an option for multiple reasons:
>
> - We have two rootfs partitions for ping-pong updates, so simply
>   referring to "the thing with ID foo" doesn't work.
>
> - Installing said updates needs direct access the device/partition,
>   which may not even have a filesystem.
>
> - The u-boot environment is stored in an eMMC "boot" partition, and
>   userspace needs to know where to find it.
>
> I'm sure I'm not the only one in a similar situation.
>
> Russel, feel free to shout abuse at me.  I don't care, but it makes you
> look stupid.
>

Completely agree here - we need a dt solution that allows us to
specify ordering.

I support a variety of IMX6 boards where for PCB routing reasons the
bootable MMC device is not always the first sdhc (sometimes the first
one is an SDIO radio for example). It seems ridiculous that I can't
handle this with:

        aliases {
                mmc0 =3D &usdhc3; /* MMC boot device */
                mmc1 =3D &usdhc2; /* SDIO radio */
        };

I see the imx6q-dhcom-som added in
52c7a088badd665a09ca9307ffa91e88d5686a7d re-defines the default
imx6qdl.dtsi mmc0-mmc3 aiases but I don't see any handling of this in
code anywhere - am I missing something?

Marek, why did you change the alias ordering for imx6q-dhcom-som.dtsi?
(maybe your carrying around a patch to make this useful?)

+       aliases {
+               mmc0 =3D &usdhc2;
+               mmc1 =3D &usdhc3;
+               mmc2 =3D &usdhc4;
+               mmc3 =3D &usdhc1;
+       };

Regards,

Tim
