Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7E3FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 18:56:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7667C217F5
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 18:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552589762;
	bh=InaAZHDafJY5qvnZgWAImKoBcV/xIIACj/9gfC3xiws=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=G+U6H9pXhhNBjFuN8y41OVmTizt+ijTHOfpnEgqQ3amxrgucd0U0AdpiAzMVSLy1b
	 CrRSzC8gLdd5F4sJ9cRUJbnPGUt4vtYku7tVGNtDlUSGHkgrA4AMW3RMtoLuqRbY9y
	 pyTutwjWVcHLRHa0SLAjpvBiaQOXlTEwQpkqbcDg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbfCNS4A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 14:56:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:45920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726743AbfCNS4A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 14:56:00 -0400
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7E92218A5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 18:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552589758;
        bh=InaAZHDafJY5qvnZgWAImKoBcV/xIIACj/9gfC3xiws=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=iXJZZTrqQtelS1hvjSeLFhjAT6qZehIY1qbkkoKNM5A4efrHnRoKAsc+ONbVNUDTW
         eYWT8iS3iKWuBkt3OkoTjpU+0gDeuwSX4wXhF3kc0w6lrYs9iVjeF+2wHA5oBYHhO2
         CxWlbNoFOANIzbfeoqFJxRK3zqZAUZkqDOlU6O/Y=
Received: by mail-qt1-f176.google.com with SMTP id b3so7344764qtj.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 11:55:58 -0700 (PDT)
X-Gm-Message-State: APjAAAVp9oRtDO+xaVYDfetL74pvioOaWKkTNtH3rxYohircbD3oDdXa
        eAIo0WQKQPkEssBgUp7+JMpZMOCLvFPxcLKb+Q==
X-Google-Smtp-Source: APXvYqwecn+C9pRWJ7MGU9VAqkwunUluf2fy330uT8aorrBXM1U7AIWVCGR8FWECJ+pdNcXtRrxhYB9jOECDcbQq2Y4=
X-Received: by 2002:ac8:2a39:: with SMTP id k54mr40357296qtk.26.1552589757905;
 Thu, 14 Mar 2019 11:55:57 -0700 (PDT)
MIME-Version: 1.0
References: <1549022873-40549-1-git-send-email-narmstrong@baylibre.com>
 <1549022873-40549-2-git-send-email-narmstrong@baylibre.com>
 <CAL_JsqLa1QNYTo+Yj-5fC4k8C1bd+V8qi5LiHgLA_qZY+Gy5cg@mail.gmail.com>
 <36800d4e-0bb7-378c-e512-5ae02406865b@baylibre.com> <CAL_Jsq+-q3+PtU6zS-dLSy3Gx+xOzquLyuW3n3ey6iRT3tw9KA@mail.gmail.com>
 <6e0f70a4-8e12-7000-bc5d-de5093d173c5@baylibre.com>
In-Reply-To: <6e0f70a4-8e12-7000-bc5d-de5093d173c5@baylibre.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 14 Mar 2019 13:55:45 -0500
X-Gmail-Original-Message-ID: <CAL_JsqL+R_wyzQ9UB37N4jwD8na301+=B9x6+z1LSMdKer88qg@mail.gmail.com>
Message-ID: <CAL_JsqL+R_wyzQ9UB37N4jwD8na301+=B9x6+z1LSMdKer88qg@mail.gmail.com>
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
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 3:53 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> On 08/03/2019 15:54, Rob Herring wrote:
> > On Fri, Mar 8, 2019 at 2:05 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
> >>
> >> Hi Rob,
> >>
> >> On 08/03/2019 00:13, Rob Herring wrote:
> >>> On Fri, Feb 1, 2019 at 6:08 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
> >>>>
> >>>> Add support for SCDC Setup for TMDS Clock > 3.4GHz and enable TMDS
> >>>> Scrambling when supported or mandatory.
> >>>>
> >>>> This patch also adds an helper to setup the control bit to support
> >>>> the high TMDS Bit Period/TMDS Clock-Period Ratio as required with
> >>>> TMDS Clock > 3.4GHz for HDMI2.0 3840x2160@60/50 modes.
> >>>>
> >>>> These changes were based on work done by Huicong Xu <xhc@rock-chips.com>
> >>>> and Nickey Yang <nickey.yang@rock-chips.com> to support HDMI2.0 modes
> >>>> on the Rockchip 4.4 BSP kernel at [1]
> >>>>
> >>>> [1] https://github.com/rockchip-linux/kernel/tree/release-4.4
> >>>>
> >>>> Cc: Nickey Yang <nickey.yang@rock-chips.com>
> >>>> Cc: Huicong Xu <xhc@rock-chips.com>
> >>>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> >>>> Tested-by: Heiko Stuebner <heiko@sntech.de>
> >>>> Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
> >>>> ---
> >>>>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 85 ++++++++++++++++++++++++++++++-
> >>>>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.h |  1 +
> >>>>  include/drm/bridge/dw_hdmi.h              |  1 +
> >>>>  3 files changed, 85 insertions(+), 2 deletions(-)
> >>>
> >>> This commit in drm-misc-next is breaking booting on the Rock960. I
> >>> have FB and fbcon enabled. The boot hangs after this message:
> >>>
> >>> [    3.012334] [drm:rockchip_drm_fbdev_create] FB [1920x1080]-24
> >>> kvaddr=(____ptrval____) offset=0 size=8294400
> >>
> >> Could you give more details on the tree used ? did you bisect to find this commit ?
> >
> > As I said above, drm-misc-next (from drm-misc tree) is the branch. I
> > bisected between it and v5.0. Reverting it fixes booting.
>
> Thanks, could you give more details on the environment ? Did you test over the latest linux-next ?

Here's a log of the drm parts: https://pastebin.com/tFJ9Gs6h

linux-next also hangs.

> Can you share the EDID of your monitor ?

Maybe not mode related. I tried forcing to 1280x720 and it hangs too.
In any case, here's the parsed EDID:

256-byte EDID successfully retrieved from i2c bus 3
Looks like i2c was successful. Have a good day.
Checksum Correct

Section "Monitor"
Identifier "CYS-R101"
ModelName "CYS-R101"
VendorName "CYX"
# Monitor Manufactured week 28 of 2018
# EDID version 1.3
# Digital Display
DisplaySize 220 130
Gamma 2.20
Option "DPMS" "true"
Horizsync 30-102
VertRefresh 48-75
# Maximum pixel clock is 190MHz
#Not giving standard mode: 1920x1080, 60Hz
#Not giving standard mode: 1920x1080, 60Hz
#Not giving standard mode: 1920x1080, 60Hz
#Not giving standard mode: 1440x900, 60Hz
#Not giving standard mode: 1400x1050, 60Hz
#Not giving standard mode: 1280x1024, 60Hz
#Not giving standard mode: 1280x960, 60Hz
#Not giving standard mode: 1280x720, 60Hz

#Extension block found. Parsing...
Modeline "Mode 5" 54.00 2560 2608 2640 2720 1440 1443 1448 1481 +hsync +vsync
Modeline "Mode 0" 267.81 2560 2608 2640 2720 1600 1603 1608 1641 +hsync +vsync
Modeline "Mode 1" 148.500 1920 2008 2052 2200 1080 1084 1089 1125 +hsync +vsync
Modeline "Mode 2" 74.250 1920 2008 2052 2200 1080 1082 1087 1125
+hsync +vsync interlace
Modeline "Mode 3" 74.250 1280 1390 1420 1650 720 725 730 750 +hsync +vsync
Modeline "Mode 4" 148.500 1920 2448 2492 2640 1080 1084 1089 1125 +hsync +vsync
Option "PreferredMode" "Mode 5"
EndSection

> Can you check this patch :

Still hangs with it.

>
> ----><----------------------------------------------------------------------------------------
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> index a63e5f0dae56..f33c2ac158c1 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> @@ -1268,8 +1268,6 @@ static int hdmi_phy_configure(struct dw_hdmi *hdmi)
>
>         dw_hdmi_phy_power_off(hdmi);
>
> -       dw_hdmi_set_high_tmds_clock_ratio(hdmi);
> -
>         /* Leave low power consumption mode by asserting SVSRET. */
>         if (phy->has_svsret)
>                 dw_hdmi_phy_enable_svsret(hdmi, 1);
>
>
