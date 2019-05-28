Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D63CAC04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 13:03:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA47021670
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 13:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559048604;
	bh=to2yA5jMaWgB/wFrj0Azo3OT7/Y8ggodEnCmIoV0dKw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=yelCxLhsKxcWFbjJYomIW4wXh2uVEYL0G1MpaWm4KL8NeKkCBe6kmz2V7HmdmhxKH
	 +qQs408yp9m8AB3qz5kA0Xj7aJ3/k9AJFmnIiycJfK1EemJFNHVME1W1UD48Icpfim
	 rNJYZY1q6OpJI0opBcVKAw0Ca5CzmsC0PygdsERM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbfE1NDY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 09:03:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:36008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726972AbfE1NDX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 09:03:23 -0400
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7EE82133F;
        Tue, 28 May 2019 13:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559048602;
        bh=to2yA5jMaWgB/wFrj0Azo3OT7/Y8ggodEnCmIoV0dKw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=F9LGIU7halvFDEIqbcTR8bckXfWSQd+enUAhJx76nZOmjj1gyaf9cPIWD3X3DILOn
         OKCbnFCvYk5tKGfdBVwzrON5Hb+9Sd+yA+HAbYZGlONZ2g2FBQFRi6Uf72our2b0bK
         3xE0TF7WmwbRxP1b9ngeE4meBVKQM8eNGbX/wGH4=
Received: by mail-wr1-f49.google.com with SMTP id c2so4946253wrm.8;
        Tue, 28 May 2019 06:03:21 -0700 (PDT)
X-Gm-Message-State: APjAAAUm5V0HH2+mHj0joVk/qdO+RWC5zGXtvbG+ijqE16EmI6FpYvJa
        6yvzgc9kkWLCrfeELST7puneE8mWJ9HgM8Qx9hg=
X-Google-Smtp-Source: APXvYqxA+f1nD0R4RwrTP1NJJRgGbpzv3YTyXYDlyDk27gkQGMeCS38Lxu2OIj9vkhWsA4t5wB+BmsLILLrEFRfbV2k=
X-Received: by 2002:a5d:49d0:: with SMTP id t16mr16026596wrs.324.1559048600302;
 Tue, 28 May 2019 06:03:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190520150637.23557-1-megous@megous.com> <20190520151003.uklhhak5clxi5zpf@core.my.home>
In-Reply-To: <20190520151003.uklhhak5clxi5zpf@core.my.home>
From:   Chen-Yu Tsai <wens@kernel.org>
Date:   Tue, 28 May 2019 21:03:06 +0800
X-Gmail-Original-Message-ID: <CAGb2v64NDYo-yOvUQDpqzRB_A3NUgF3dXJeYbz_57uwB7mXwqQ@mail.gmail.com>
Message-ID: <CAGb2v64NDYo-yOvUQDpqzRB_A3NUgF3dXJeYbz_57uwB7mXwqQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] ARM: sun8i: a83t: Support Camera Sensor Interface controller
To:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Ondrej Jirman <megous@megous.com>
Cc:     devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Yong Deng <yong.deng@magewell.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Chen-Yu Tsai <wens@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2019 at 11:10 PM Ond=C5=99ej Jirman <megous@megous.com> wro=
te:
>
> On Mon, May 20, 2019 at 05:06:34PM +0200, verejna wrote:
> > From: Ondrej Jirman <megous@megous.com>
> >
> > This is a re-send of Chen-Yu's A83T CSI patch series with review tags
> > applied and removed address/size cells from csi_in port. Already applie=
d
> > patches from v1  were dropped.
> >
> > The series is ready to be merged:
> >
> >   Patch 1 and 2 via sunxi tree
> >   Patch 3 via media tree
>
> Sorry, wrong numbers. 2 is for media tree, 3 is for sunxi, 1 is a dt-bind=
ings
> patch, where I'm not sure.

Bindings typically go with the driver.

Sakari, this series is and has been ready for some time since before the me=
rge
window. Could you please merge patches 1 and 2.


Thanks
ChenYu


>
> thanks,
>         Ondrej
>
> > v2:
> > - dropped address/size cells from csi_in port
> > - added review tags
> >
> > Please take a look and merge.
> >
> > Thank you,
> >       Ondrej
> >
> > --------------------------
> > Original description:
> >
> > Hi everyone,
> >
> > This series adds support for the camera sensor interface controller
> > found on the Allwinner A83T SoC. The controller is similar to the one
> > found on  the H3, with the addition of a MIPI CSI-2 interface. However,
> > this series only supports parallel and BT.656 interfaces, based on the
> > existing driver.
> >
> > Patch 1 adds an undocumented clock parent of the CSI MCLK. This was
> > found after finding the default value to sometimes work and sometimes
> > not, and then comparing against BSP code.
> >
> > Patch 2 adds a compatible string for the A83T variant.
> >
> > Patch 3 adds support for the A83T variant to the existing sun6i-csi
> > driver.
> >
> > Patch 4 adds a device node for the controller, as well as commonly
> > used pin muxing options.
> >
> > Patch 5 adds a pin muxing option for I2C1 on the PE pins, used in
> > conjunction with the CSI pins.
> >
> > Patch 6 provides an example usage of the CSI controller: the Bananapi M=
3
> > with its camera module attached.
> >
> > Please have a look.
> >
> > Regards
> > ChenYu
> >
> > Chen-Yu Tsai (3):
> >   dt-bindings: media: sun6i-csi: Add compatible string for A83T variant
> >   media: sun6i: Support A83T variant
> >   ARM: dts: sun8i: a83t: Add device node for CSI (Camera Sensor
> >     Interface)
> >
> >  .../devicetree/bindings/media/sun6i-csi.txt   |  1 +
> >  arch/arm/boot/dts/sun8i-a83t.dtsi             | 29 +++++++++++++++++++
> >  .../platform/sunxi/sun6i-csi/sun6i_csi.c      |  1 +
> >  3 files changed, 31 insertions(+)
> >
> > --
> > 2.21.0
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
