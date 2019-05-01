Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 629E8C43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 14:10:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24CD420866
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 14:10:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="bbCwLAC8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbfEAOKB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 10:10:01 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:44635 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbfEAOKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 10:10:00 -0400
Received: by mail-io1-f66.google.com with SMTP id r71so14862881iod.11
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2019 07:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nB5mo0PzD9+ciKHE3nzQsu/xBNhXLuJh3fQvApZ4eDE=;
        b=bbCwLAC8NXEO1MlCMIaPy05mv66RouPcb+bvkijVpS+pzk5BLMIHVOtFkqZcoAPTA4
         6ga9XjzjJ1sOuJ49EW+AI/eNAGSgIIkq1S10/GNVx8ke9aJUbIjcO98Y5Kb8NR6cOrWL
         bjwz8AnzWjfQMhg2dn5RtOw3PplDq7u4QwDmg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nB5mo0PzD9+ciKHE3nzQsu/xBNhXLuJh3fQvApZ4eDE=;
        b=ooVRxAFRCXFyZx96sLMTwEAoOV1w0UxPWef9CrFqIoSvsfG6FNxNhj7ho3BUkIc3oN
         9jdjDU0GMAG/pVgxdPn+jHW1dY0SI6ecO7OqdHu0Z1yRo5k8cykxfwuPfnHR7scI3Vgh
         LXLw/fhrb63R1z5YF6uUnPoCaqF2OprFd0B8dDujGj9vCErnVN/7ux7lmzlEUceho9YX
         dgevnnTKdCU6BHQe+NmYRLCM8eHW7aCWsne81IDa0M7KImjA4Cq4OSPcQ2mE2xVafC+v
         ZjMZCiVDpjvBuhiQH1L4tOV8pJOSjdvnhzDyryASqO5/xc1wzpY1Fh95i52JNKyGX9sI
         1C4Q==
X-Gm-Message-State: APjAAAUV7xMxdZtq3KaitEes5tEg7wI9aVYsT8DaA4WQwndRhllsb9Rm
        W/m097DzC8AwA9CsjndpDeIDW2rQIbxTh6bXmkXnvg==
X-Google-Smtp-Source: APXvYqwJw2QwrXIxZJq4e669u8UmLxc5NF8gdYbnL+eL3xI7LbmEUaDO3+S4myUwXwutRlCDThcxZxJk+wimJdIMuHs=
X-Received: by 2002:a5d:8d18:: with SMTP id p24mr2089671ioj.267.1556719799202;
 Wed, 01 May 2019 07:09:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190501121448.3812-1-jagan@amarulasolutions.com>
 <20190501121448.3812-2-jagan@amarulasolutions.com> <cc16498b-71f8-04ce-44d1-25417fd64757@arm.com>
In-Reply-To: <cc16498b-71f8-04ce-44d1-25417fd64757@arm.com>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Wed, 1 May 2019 19:39:46 +0530
Message-ID: <CAMty3ZBdko3+p6SoKYH-Mwism-Qnp3F5u7JV8YQTHzNP8A5kEg@mail.gmail.com>
Subject: Re: [DO NOT MERGE] [PATCH 2/2] arm64: rockchip: rk3399: nanopc-t4:
 Enable FriendlyELEC HD702E eDP panel
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-rockchip@lists.infradead.org,
        linux-amarula <linux-amarula@amarulasolutions.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 1, 2019 at 6:17 PM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 01/05/2019 13:14, Jagan Teki wrote:
> > FriendlyELEC HD702E is one of optional LCD panel for
> > NanoPC T4 eDP interface.
> >
> > It features 800x1280 resolutions, with built in GT9271 captive
> > touchscreen and adjustable backlight via PWM.
> >
> > eDP panel connections are:
> > - VCC3V3_SYS: 3.3V panel power supply
> > - GPIO4_C2: PWM0_BL pin
> > - GPIO4_D5_LCD_BL_EN: Backlight enable pin
> > - VCC12V0_SYS: 12V backlight power supply
> > - Touchscreen connected via I2C4
> > - GPIO1_C4_TP_INT: touchscreen interrupt pin
> > - GPIO1_B5_TP_RST: touchscreen reset pin
> >
> > Add support for it.
> >
> > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > ---
> > Note: we need to disable hdmi-cec pinctrl to work with
> > edp-hpd since both share same pin, otherwise we can
> > encounter below error during bootup
> > [    1.047726] rockchip-pinctrl pinctrl: pin gpio4-23 already requested by ff940000.hdmi; cannot claim for ff970000.edp
> > [    1.048655] rockchip-pinctrl pinctrl: pin-151 (ff970000.edp) status -22
> > [    1.049235] rockchip-pinctrl pinctrl: could not request pin 151 (gpio4-23) from group edp-hpd  on device rockchip-pinctrl
> > [    1.050191] rockchip-dp ff970000.edp: Error applying setting, reverse things back
> > [    1.050867] rockchip-dp: probe of ff970000.edp failed with error -22
>
> Hmm, AFAICS that pin is exclusively wired to the HDMI connector and not
> used for the eDP interface, so really it's the fault of rk3399.dtsi for
> trying to claim it unconditionally. Ideally we'd pull those pinctrl
> properties out into the board DTs which do actually need them, but the
> quick and easy approach would be to add some "/delete-property/ ..."
> workarounds to the &edp node here.

Thought that initially, but the same pin shared between HDMI CEC and
eDP hotplug with different bit function to enable.

gpio4c7_sel
GPIO4C[7] iomux select
2'b00: gpio
2'b01: hdmi_cecinout
2'b10: edp_hotplug
2'b11: reserved

GPIO4_C7/HDMI_CECINOUT/EDP_HOTPLUG is the shared pin, which is
available in any nanopc-t4 as well in rk3399 datasheet, look like it's
an SoC pin that driver hotplug to eDP and ie same reason is pinmux in
rk3399.dtsi.

I event removed edp_hpd pinctrl from edp node in rk3399.dtsi, but
display not appear on the screen and observed edp bridge issue on
host.

[    1.052191] rockchip-drm display-subsystem: bound ff8f0000.vop (ops
vop_component_ops)
[    1.054460] rockchip-drm display-subsystem: bound ff900000.vop (ops
vop_component_ops)
[    1.055214] rockchip-dp ff970000.edp: no DP phy configured
[    1.056088] rockchip-drm display-subsystem: bound ff970000.edp (ops
rockchip_dp_component_ops)
[    1.056852] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    1.057449] [drm] No driver support for vblank timestamp query.
[    1.174379] [drm:analogix_dp_bridge_enable] *ERROR* failed to get
hpd single ret = -110
[    1.174408] rockchip-dp ff970000.edp: failed to set bridge, retry: 0
[    1.285524] [drm:analogix_dp_bridge_enable] *ERROR* failed to get
hpd single ret = -110
[    1.285539] rockchip-dp ff970000.edp: failed to set bridge, retry: 1
[    1.355241] dwmmc_rockchip fe310000.dwmmc: Successfully tuned phase to 212
[    1.358757] mmc0: new ultra high speed SDR104 SDIO card at address 0001
[    1.397049] [drm:analogix_dp_bridge_enable] *ERROR* failed to get
hpd single ret = -110
[    1.397069] rockchip-dp ff970000.edp: failed to set bridge, retry: 2
[    1.485582] dwmmc_rockchip fe320000.dwmmc: Successfully tuned phase to 220
[    1.485590] mmc1: new ultra high speed SDR104 SDHC card at address 084e
[    1.486246] mmcblk1: mmc1:084e R04GS 3.71 GiB
[    1.488032]  mmcblk1: p1
[    1.509088] [drm:analogix_dp_bridge_enable] *ERROR* failed to get
hpd single ret = -110
[    1.509119] rockchip-dp ff970000.edp: failed to set bridge, retry: 3
[    1.620938] [drm:analogix_dp_bridge_enable] *ERROR* failed to get
hpd single ret = -110
[    1.620953] rockchip-dp ff970000.edp: failed to set bridge, retry: 4
[    1.620970] rockchip-dp ff970000.edp: too many times retry set
bridge, give it up
[    1.644026] Console: switching to colour frame buffer device 100x80


>
> >   .../boot/dts/rockchip/rk3399-nanopc-t4.dts    | 82 +++++++++++++++++++
> >   1 file changed, 82 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3399-nanopc-t4.dts b/arch/arm64/boot/dts/rockchip/rk3399-nanopc-t4.dts
> > index 931c3dbf1b7d..b652d960946f 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3399-nanopc-t4.dts
> > +++ b/arch/arm64/boot/dts/rockchip/rk3399-nanopc-t4.dts
> > @@ -46,6 +46,48 @@
> >               };
> >       };
> >
> > +     backlight: backlight {
> > +             compatible = "pwm-backlight";
> > +             brightness-levels = <
> > +                       0   1   2   3   4   5   6   7
> > +                       8   9  10  11  12  13  14  15
> > +                      16  17  18  19  20  21  22  23
> > +                      24  25  26  27  28  29  30  31
> > +                      32  33  34  35  36  37  38  39
> > +                      40  41  42  43  44  45  46  47
> > +                      48  49  50  51  52  53  54  55
> > +                      56  57  58  59  60  61  62  63
> > +                      64  65  66  67  68  69  70  71
> > +                      72  73  74  75  76  77  78  79
> > +                      80  81  82  83  84  85  86  87
> > +                      88  89  90  91  92  93  94  95
> > +                      96  97  98  99 100 101 102 103
> > +                     104 105 106 107 108 109 110 111
> > +                     112 113 114 115 116 117 118 119
> > +                     120 121 122 123 124 125 126 127
> > +                     128 129 130 131 132 133 134 135
> > +                     136 137 138 139 140 141 142 143
> > +                     144 145 146 147 148 149 150 151
> > +                     152 153 154 155 156 157 158 159
> > +                     160 161 162 163 164 165 166 167
> > +                     168 169 170 171 172 173 174 175
> > +                     176 177 178 179 180 181 182 183
> > +                     184 185 186 187 188 189 190 191
> > +                     192 193 194 195 196 197 198 199
> > +                     200 201 202 203 204 205 206 207
> > +                     208 209 210 211 212 213 214 215
> > +                     216 217 218 219 220 221 222 223
> > +                     224 225 226 227 228 229 230 231
> > +                     232 233 234 235 236 237 238 239
> > +                     240 241 242 243 244 245 246 247
> > +                     248 249 250 251 252 253 254 255>;
>
> This looks trivial enough that I wonder whether it might still work to
> just omit it? Not that I know anything about backlights, but I had the
> impression (from mailing list traffic, I guess) that the driver gained
> the ability to provide a reasonable default behaviour at some point.

Unaware about this, would you please pass the thread. on the
other-hand I can see sapphire-excavator still using the brightness
levels like this.
