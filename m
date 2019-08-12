Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 328E9C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 07:54:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01B4820820
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 07:54:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbfHLHyV convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 03:54:21 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46024 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726753AbfHLHyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 03:54:18 -0400
Received: by mail-ed1-f68.google.com with SMTP id x19so96976414eda.12;
        Mon, 12 Aug 2019 00:54:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SOVNyFeEtai/A5ZZgvPx+OqlDS//TmiI6n774GHwAK8=;
        b=S9MVamREAOaHigp6ogaEz0bBf9dBw4/qWGv/hSs5HJayB3akL2jx15SD8C81gc4n5D
         bX76hqB3sz6yMPUxaPpdYnppfUDyH2dIxkpujUjrYrLOkyQKXJmhn9Ps/FtA2OBLdt/H
         Y/9e1Ml2fgGtAB82xp5XszYXFRIGth3OT2Mu2kBBWWDKe2r6HyIyo0Wv70MKfHT5NcqD
         twDWV2JKUpyKdUcSYn7Ukkr+zSvDaSLnOlMQyFKHr/aX2ye4xzZsy3H0a0JdLsKe/421
         MEm0PgJNoDkhPzdf6i1f2tsawA+nufbPSx8jLGxcKw/r/OkT0xmZWyKeSPR4asVcf5w8
         EUnA==
X-Gm-Message-State: APjAAAXdP8JcIqFGWlP7LX/x1GDBGNdLvCO6dwVJ6oMqqdNyzvjUDnOU
        lnPPALQ8gEuU/JX0eRk8pHWii+aTGIs=
X-Google-Smtp-Source: APXvYqzUuL/YmK0Q13l1Cuxp207zea1udFcmNce/bstzHv3hUKx1S2dC/0EZLE0+weTldJWJIEG8CQ==
X-Received: by 2002:aa7:c30d:: with SMTP id l13mr24663307edq.286.1565596455682;
        Mon, 12 Aug 2019 00:54:15 -0700 (PDT)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com. [209.85.221.43])
        by smtp.gmail.com with ESMTPSA id h2sm1501008edr.16.2019.08.12.00.54.14
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Aug 2019 00:54:15 -0700 (PDT)
Received: by mail-wr1-f43.google.com with SMTP id b16so7007815wrq.9;
        Mon, 12 Aug 2019 00:54:14 -0700 (PDT)
X-Received: by 2002:adf:e941:: with SMTP id m1mr39772503wrn.279.1565596454773;
 Mon, 12 Aug 2019 00:54:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190806155744.10263-1-megous@megous.com> <2218280.0sI6yjypBf@jernej-laptop>
In-Reply-To: <2218280.0sI6yjypBf@jernej-laptop>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Mon, 12 Aug 2019 15:54:03 +0800
X-Gmail-Original-Message-ID: <CAGb2v67JVG2rhOdUwBmfsO0+RYb4DNOPmUo=Q_UhL3N+niLiEg@mail.gmail.com>
Message-ID: <CAGb2v67JVG2rhOdUwBmfsO0+RYb4DNOPmUo=Q_UhL3N+niLiEg@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH v8 0/4] Add support for Orange Pi 3
To:     Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     linux-sunxi <linux-sunxi@googlegroups.com>,
        =?UTF-8?Q?Ond=C5=99ej_Jirman?= <megous@megous.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 12, 2019 at 3:45 PM Jernej Škrabec <jernej.skrabec@gmail.com> wrote:
>
> Dne torek, 06. avgust 2019 ob 17:57:39 CEST je megous@megous.com napisal(a):
> > From: Ondrej Jirman <megous@megous.com>
> >
> > This series implements support for Xunlong Orange Pi 3 board. There
> > are only a few patches remaining.
> >
> > - ethernet support - just a DT change (patch 1)
> > - HDMI support (patches 2-4)
> >
> > For some people, ethernet doesn't work after reboot because u-boot doesn't
> > support AXP805 PMIC, and will not turn off the etherent PHY regulators.
> > So the regulator controlled by gpio will be shut down, but the other one
> > controlled by the AXP PMIC will not.
> >
> > This is a problem only when running with a builtin driver. This needs
> > to be fixed in u-boot.
> >
> >
> > Please take a look.
>
> Is there anything missing? It would be nice to get this in 5.4. There is a lot
> of H6 boards which needs DDC bus enable mechanism (part of H6 reference
> design), including Beelink GS1 which already has HDMI node in mainline kernel
> DT, but due to disabled DDC lines works only with 1024x768 (fallback
> resolution in DRM core).

I have a few minor comments about patch 1.

I think the HDMI bits are good, but I don't have maintainership / commit
permissions for drm-misc, so I'll have to wait until someone applies patches
2 and 3 before I apply patch 4.

ChenYu

> Best regards,
> Jernej
>
> >
> > thank you and regards,
> >   Ondrej Jirman
> >
> > Changes in v8:
> > - added reviewed-by tags
> > - dropped already applied patches
> > - added more info about the phy initialization issue after reset
> >
> > Changes in v7:
> > - dropped stored reference to connector_pdev as suggested by Jernej
> > - added forgotten dt-bindings reviewed-by tag
> >
> > Changes in v6:
> > - added dt-bindings reviewed-by tag
> > - fix wording in stmmac commit (as suggested by Sergei)
> >
> > Changes in v5:
> > - dropped already applied patches (pinctrl patches, mmc1 pinconf patch)
> > - rename GMAC-3V3 -> GMAC-3V to match the schematic (Jagan)
> > - changed hdmi-connector's ddc-supply property to ddc-en-gpios
> >   (Rob Herring)
> >
> > Changes in v4:
> > - fix checkpatch warnings/style issues
> > - use enum in struct sunxi_desc_function for io_bias_cfg_variant
> > - collected acked-by's
> > - fix compile error in drivers/pinctrl/sunxi/pinctrl-sun9i-a80-r.c:156
> >   caused by missing conversion from has_io_bias_cfg struct member
> >   (I've kept the acked-by, because it's a trivial change, but feel free
> >   to object.) (reported by Martin A. on github)
> >   I did not have A80 pinctrl enabled for some reason, so I did not catch
> >   this sooner.
> > - dropped brcm firmware patch (was already applied)
> > - dropped the wifi dts patch (will re-send after H6 RTC gets merged,
> >   along with bluetooth support, in a separate series)
> >
> > Changes in v3:
> > - dropped already applied patches
> > - changed pinctrl I/O bias selection constants to enum and renamed
> > - added /omit-if-no-ref/ to mmc1_pins
> > - made mmc1_pins default pinconf for mmc1 in H6 dtsi
> > - move ddc-supply to HDMI connector node, updated patch descriptions,
> >   changed dt-bindings docs
> >
> > Changes in v2:
> > - added dt-bindings documentation for the board's compatible string
> >   (suggested by Clement)
> > - addressed checkpatch warnings and code formatting issues (on Maxime's
> >   suggestions)
> > - stmmac: dropped useless parenthesis, reworded description of the patch
> >   (suggested by Sergei)
> > - drop useles dev_info() about the selected io bias voltage
> > - docummented io voltage bias selection variant macros
> > - wifi: marked WiFi DTS patch and realted mmc1_pins as "DO NOT MERGE",
> >   because wifi depends on H6 RTC support that's not merged yet (suggested
> >   by Clement)
> > - added missing signed-of-bys
> > - changed &usb2otg dr_mode to otg, and added a note about VBUS
> > - improved wording of HDMI driver's DDC power supply patch
> >
> > Ondrej Jirman (4):
> >   arm64: dts: allwinner: orange-pi-3: Enable ethernet
> >   dt-bindings: display: hdmi-connector: Support DDC bus enable
> >   drm: sun4i: Add support for enabling DDC I2C bus to sun8i_dw_hdmi glue
> >   arm64: dts: allwinner: orange-pi-3: Enable HDMI output
> >
> >  .../display/connector/hdmi-connector.txt      |  1 +
> >  .../dts/allwinner/sun50i-h6-orangepi-3.dts    | 70 +++++++++++++++++++
> >  drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c         | 54 ++++++++++++--
> >  drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h         |  2 +
> >  4 files changed, 123 insertions(+), 4 deletions(-)
>
>
>
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe@googlegroups.com.
> To view this discussion on the web, visit https://groups.google.com/d/msgid/linux-sunxi/2218280.0sI6yjypBf%40jernej-laptop.
