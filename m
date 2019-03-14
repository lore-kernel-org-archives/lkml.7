Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86BC2C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 20:14:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 383042077B
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 20:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552594480;
	bh=XpvisWBTZfxwtP1pGbIc1Ot+e4MWEZ0DCSUhVw0/K6U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=qLn4J1Npz4iU7Suj1NfMwqltOxhfZSr+K+ZvRFr+VKLlS75lNGh/VoghyzOOBNNwo
	 n8Uh9eQPtyZPJgNkzu2dQmGU1Xu5eqCHLnsuvJl7ukAwGkVBrvf1C39E69858OAyHe
	 pEIVOVJLqgZCafO+iIFtrovOmAe3E1oMetGNiy9c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727693AbfCNUOj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 16:14:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:49132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726444AbfCNUOi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 16:14:38 -0400
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35468218A6
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 20:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552594477;
        bh=XpvisWBTZfxwtP1pGbIc1Ot+e4MWEZ0DCSUhVw0/K6U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tx8QPVJkd1G4YXOLxUPl1mziYo221YnXZyuPDF4tKwZxiXMMHcBmUL/fpQPUphA0e
         cayGaaMv1ob4tBIIB2mc8fwqZW8nbra3AAKbbOsClbasYOJKTLELOSOTZeSEgDtdRU
         JAnSiqNul4gDs9B2wqzCX6NLlMd9nk+GybQU3/bk=
Received: by mail-qt1-f178.google.com with SMTP id b3so7643018qtj.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 13:14:37 -0700 (PDT)
X-Gm-Message-State: APjAAAUgPb7opAnhCSMKogiaiWWd+MLuwoG7BzZZ8tAeDOvYUnqfKCeo
        2D2AGPmuaKIyQHRt0xuFLqyVv0BRjW4/ac5luQ==
X-Google-Smtp-Source: APXvYqwBSIdTcTbPQiSrV2xMljvh4RTjLTVBsqjFehun/5IbHpFJM5UTQwQb+Q8/L95tCJbwnlSWM0C1IXqEs2TB9zU=
X-Received: by 2002:a0c:ec11:: with SMTP id y17mr12704675qvo.77.1552594476257;
 Thu, 14 Mar 2019 13:14:36 -0700 (PDT)
MIME-Version: 1.0
References: <1549022873-40549-1-git-send-email-narmstrong@baylibre.com>
 <1549022873-40549-2-git-send-email-narmstrong@baylibre.com>
 <CAL_JsqLa1QNYTo+Yj-5fC4k8C1bd+V8qi5LiHgLA_qZY+Gy5cg@mail.gmail.com>
 <36800d4e-0bb7-378c-e512-5ae02406865b@baylibre.com> <CAL_Jsq+-q3+PtU6zS-dLSy3Gx+xOzquLyuW3n3ey6iRT3tw9KA@mail.gmail.com>
 <6e0f70a4-8e12-7000-bc5d-de5093d173c5@baylibre.com> <CAL_JsqL+R_wyzQ9UB37N4jwD8na301+=B9x6+z1LSMdKer88qg@mail.gmail.com>
 <5C8AB489.3000202@baylibre.com>
In-Reply-To: <5C8AB489.3000202@baylibre.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 14 Mar 2019 15:14:24 -0500
X-Gmail-Original-Message-ID: <CAL_JsqK1_qXKBuSY6X9XG9AOdTP=tfNAtuJaSA_ONhVm-2kysQ@mail.gmail.com>
Message-ID: <CAL_JsqK1_qXKBuSY6X9XG9AOdTP=tfNAtuJaSA_ONhVm-2kysQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] drm/bridge: dw-hdmi: Add SCDC and TMDS Scrambling support
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sandy Huang <hjc@rock-chips.com>,
        "heiko@sntech.de" <heiko@sntech.de>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Nickey Yang <nickey.yang@rock-chips.com>,
        linux-amlogic@lists.infradead.org, Huicong Xu <xhc@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 14, 2019 at 3:07 PM Neil Armstrong <narmstrong@baylibre.com> wr=
ote:
>
> Hi Rob,
>
> Le 14/03/2019 19:55, Rob Herring a =C3=A9crit :
> > On Mon, Mar 11, 2019 at 3:53 AM Neil Armstrong <narmstrong@baylibre.com=
> wrote:
> >>
> >> On 08/03/2019 15:54, Rob Herring wrote:
> >>> On Fri, Mar 8, 2019 at 2:05 AM Neil Armstrong <narmstrong@baylibre.co=
m> wrote:
> >>>>
> >>>> Hi Rob,
> >>>>
> >>>> On 08/03/2019 00:13, Rob Herring wrote:
> >>>>> On Fri, Feb 1, 2019 at 6:08 AM Neil Armstrong <narmstrong@baylibre.=
com> wrote:
> >>>>>>
> >>>>>> Add support for SCDC Setup for TMDS Clock > 3.4GHz and enable TMDS
> >>>>>> Scrambling when supported or mandatory.
> >>>>>>
> >>>>>> This patch also adds an helper to setup the control bit to support
> >>>>>> the high TMDS Bit Period/TMDS Clock-Period Ratio as required with
> >>>>>> TMDS Clock > 3.4GHz for HDMI2.0 3840x2160@60/50 modes.
> >>>>>>
> >>>>>> These changes were based on work done by Huicong Xu <xhc@rock-chip=
s.com>
> >>>>>> and Nickey Yang <nickey.yang@rock-chips.com> to support HDMI2.0 mo=
des
> >>>>>> on the Rockchip 4.4 BSP kernel at [1]
> >>>>>>
> >>>>>> [1] https://github.com/rockchip-linux/kernel/tree/release-4.4
> >>>>>>
> >>>>>> Cc: Nickey Yang <nickey.yang@rock-chips.com>
> >>>>>> Cc: Huicong Xu <xhc@rock-chips.com>
> >>>>>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> >>>>>> Tested-by: Heiko Stuebner <heiko@sntech.de>
> >>>>>> Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
> >>>>>> ---
> >>>>>>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 85 ++++++++++++++++++=
++++++++++++-
> >>>>>>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.h |  1 +
> >>>>>>  include/drm/bridge/dw_hdmi.h              |  1 +
> >>>>>>  3 files changed, 85 insertions(+), 2 deletions(-)
> >>>>>
> >>>>> This commit in drm-misc-next is breaking booting on the Rock960. I
> >>>>> have FB and fbcon enabled. The boot hangs after this message:
> >>>>>
> >>>>> [    3.012334] [drm:rockchip_drm_fbdev_create] FB [1920x1080]-24
> >>>>> kvaddr=3D(____ptrval____) offset=3D0 size=3D8294400
> >>>>
> >>>> Could you give more details on the tree used ? did you bisect to fin=
d this commit ?
> >>>
> >>> As I said above, drm-misc-next (from drm-misc tree) is the branch. I
> >>> bisected between it and v5.0. Reverting it fixes booting.
> >>
> >> Thanks, could you give more details on the environment ? Did you test =
over the latest linux-next ?
> >
> > Here's a log of the drm parts: https://pastebin.com/tFJ9Gs6h
> >
> > linux-next also hangs.
> >
> >> Can you share the EDID of your monitor ?
> >
> > Maybe not mode related. I tried forcing to 1280x720 and it hangs too.
> > In any case, here's the parsed EDID:
> >
> > 256-byte EDID successfully retrieved from i2c bus 3
> > Looks like i2c was successful. Have a good day.
> > Checksum Correct
> >
> > Section "Monitor"
> > Identifier "CYS-R101"
> > ModelName "CYS-R101"
> > VendorName "CYX"
> > # Monitor Manufactured week 28 of 2018
> > # EDID version 1.3
> > # Digital Display
> > DisplaySize 220 130
> > Gamma 2.20
> > Option "DPMS" "true"
> > Horizsync 30-102
> > VertRefresh 48-75
> > # Maximum pixel clock is 190MHz
> > #Not giving standard mode: 1920x1080, 60Hz
> > #Not giving standard mode: 1920x1080, 60Hz
> > #Not giving standard mode: 1920x1080, 60Hz
> > #Not giving standard mode: 1440x900, 60Hz
> > #Not giving standard mode: 1400x1050, 60Hz
> > #Not giving standard mode: 1280x1024, 60Hz
> > #Not giving standard mode: 1280x960, 60Hz
> > #Not giving standard mode: 1280x720, 60Hz
> >
> > #Extension block found. Parsing...
> > Modeline "Mode 5" 54.00 2560 2608 2640 2720 1440 1443 1448 1481 +hsync =
+vsync
> > Modeline "Mode 0" 267.81 2560 2608 2640 2720 1600 1603 1608 1641 +hsync=
 +vsync
> > Modeline "Mode 1" 148.500 1920 2008 2052 2200 1080 1084 1089 1125 +hsyn=
c +vsync
> > Modeline "Mode 2" 74.250 1920 2008 2052 2200 1080 1082 1087 1125
> > +hsync +vsync interlace
> > Modeline "Mode 3" 74.250 1280 1390 1420 1650 720 725 730 750 +hsync +vs=
ync
> > Modeline "Mode 4" 148.500 1920 2448 2492 2640 1080 1084 1089 1125 +hsyn=
c +vsync
> > Option "PreferredMode" "Mode 5"
> > EndSection
> >
> >> Can you check this patch :
> >
> > Still hangs with it.
>
>
> Thanks for testing, the only impact would be if hdmi_info->scdc.supported
> and hdmi_info->scdc.scrambling.low_rate were true.
> Honestly, hdmi_info->scdc.scrambling.low_rate wasn't really tested.
>
> Could you dump the edid in binary format ? or parse it with https://githu=
b.com/rpavlik/edid-decode
> supporting modern HDMI EDIDs.

Here's with edid-decode:

EDID version: 1.3
Manufacturer: CYX Model 101 Serial Number 16843009
Made in week 28 of 2018
Digital display
Maximum image size: 22 cm x 13 cm
Gamma: 2.20
DPMS levels: Off
Undefined display color type
Default (sRGB) color space is primary color space
First detailed timing is preferred timing
Display x,y Chromaticity:
  Red:   0.6455, 0.3300
  Green: 0.3095, 0.6171
  Blue:  0.1523, 0.0732
  White: 0.3134, 0.3291
Established timings supported:
  640x480@60Hz 4:3 HorFreq: 31469 Hz Clock: 25.175 MHz
  800x600@60Hz 4:3 HorFreq: 37900 Hz Clock: 40.000 MHz
  1024x768@60Hz 4:3 HorFreq: 48400 Hz Clock: 65.000 MHz
Standard timings supported:
  1920x1080@60Hz 16:9
  1920x1080@60Hz 16:9
  1920x1080@60Hz 16:9
  1440x900@60Hz 16:10 HorFreq: 55500 Hz Clock: 88.750 MHz
  1400x1050@60Hz 4:3 HorFreq: 64700 Hz Clock: 101.000 MHz
  1280x1024@60Hz 5:4 HorFreq: 64000 Hz Clock: 108.000 MHz
  1280x960@60Hz 4:3 HorFreq: 60000 Hz Clock: 108.000 MHz
  1280x720@60Hz 16:9
Detailed mode: Clock 267.810 MHz, 220 mm x 130 mm
               2560 2608 2640 2720 hborder 0
               1600 1603 1608 1641 vborder 0
               +hsync +vsync
               VertFreq: 59 Hz, HorFreq: 98459 Hz
Monitor name: CYS-R101
Serial number:
Monitor ranges (bare limits): 48-75Hz V, 30-102kHz H, max dotclock 190MHz
Has 1 extension blocks
Checksum: 0x8b (valid)

CTA extension block
Extension version: 3
58 bytes of CTA data
  Video data block
    VIC  16 1920x1080@60Hz 16:9  HorFreq: 67500 Hz Clock: 148.500 MHz
    VIC   5 1920x1080i@60Hz 16:9  HorFreq: 33750 Hz Clock: 74.250 MHz
    VIC   4 1280x720@60Hz 16:9  HorFreq: 45000 Hz Clock: 74.250 MHz
    VIC  31 1920x1080@50Hz 16:9  HorFreq: 56250 Hz Clock: 148.500 MHz
  Audio data block
    Linear PCM, max channels 2
      Supported sample rates (kHz): 48 44.1 32
      Supported sample sizes (bits): 24 20 16
  Speaker allocation data block
    Speaker map:
      FL/FR - Front Left/Right
  Vendor-specific data block, OUI 000c03 (HDMI)
    Source physical address 1.0.0.0
    DC_36bit
    DC_30bit
    DC_Y444
    Maximum TMDS clock: 340MHz
  Vendor-specific data block, OUI c45dd8 (HDMI Forum)
    Version: 1
    Maximum TMDS Character Rate: 340MHz
    SCDC Present
    Supports 10-bits/component Deep Color 4:2:0 Pixel Encoding
  Vendor-specific data block, OUI 00001a
  Extended tag: YCbCr 4:2:0 capability map data block
    VSD Index 17
    VSD Index 18
  Extended tag: Colorimetry data block
    BT2020YCC
    BT2020RGB
  Extended tag: Video capability data block
    YCbCr quantization: Selectable (via AVI YQ) (1)
    RGB quantization: Selectable (via AVI Q) (1)
    PT scan behaviour: Support both over- and underscan (3)
    IT scan behaviour: Support both over- and underscan (3)
    CE scan behaviour: Support both over- and underscan (3)
  Extended tag: HDR static metadata data block
    Electro optical transfer functions:
      Traditional gamma - SDR luminance range
      SMPTE ST2084
    Supported static metadata descriptors:
      Static metadata type 1
    Desired content max luminance: 89 (343.724 cd/m^2)
    Desired content max frame-average luminance: 89 (343.724 cd/m^2)
    Desired content min luminance: 73 (0.282 cd/m^2)
Underscans PC formats by default
Basic audio support
Supports YCbCr 4:4:4
Supports YCbCr 4:2:2
1 native detailed modes
Detailed mode: Clock 54.000 MHz, 220 mm x 130 mm
               2560 2608 2640 2720 hborder 0
               1440 1443 1448 1481 vborder 0
               +hsync +vsync side by side interleaved
               VertFreq: 13 Hz, HorFreq: 19852 Hz
Checksum: 0x3c (valid)
