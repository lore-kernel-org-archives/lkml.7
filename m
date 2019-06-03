Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F315C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 15:22:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 577C126F71
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 15:22:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bGT+bYiM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729341AbfFCPWh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 11:22:37 -0400
Received: from mail-vk1-f194.google.com ([209.85.221.194]:43746 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729004AbfFCPWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 11:22:37 -0400
Received: by mail-vk1-f194.google.com with SMTP id m193so2451744vke.10
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 08:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uUAvxoeII5KrsgiehiEtR11+rs8kWwhifr5LUT7zXxA=;
        b=bGT+bYiM3Dp5MVMx/qeUbjdC9FkljtDPAIP5Y7y07YFogHMKYZCTZn6cpmxLd36Zoa
         89x/+hE3F5AEu0RGNwuirn+ZIHlIhaGBP9FXH5ukvhc757Ro3DIkQjQwkqxwKzaq5iEY
         6FssEapPaCShNs7o8uR9nQ4L+vr2XPr4rjW20=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uUAvxoeII5KrsgiehiEtR11+rs8kWwhifr5LUT7zXxA=;
        b=MUAPv+HfWlsI9pa3yO+XuyXQsHEn1H5kshG4zi5HT6dhwuNKbihyPshk4XJkokH8U2
         DJ2uXVULwDlE4X6CjonHZTwN6OOdZw7uuah9WN8c5Aytvlh51KZJcY5LXjsIQAaHgz4P
         6TLCnCg8Xtn29inokqswRqUT1jEZHNcQkvQZx6mMAuzrlcvAiLhrR+vAAqXHxKYuza7Z
         /MFd2hmrG/mkyRNSpLvFp+2UNvmycfmBuAS35NRXB5eK6OuQQ25YgfPQvQ86Sw03IXVy
         jG1/QMhL/APYIzg/I8hqNcSWMJRyCxOpz6i+5bsG5Sk2wd0AZuxWBgS3rsEhHCdmOuVS
         W1Rg==
X-Gm-Message-State: APjAAAW2nTPzRhEWvKewwhDTzD7hT7PSKs5l9cUv1PNs+cgO3krzyix2
        C+NY7h482t8KKNc2dgMWYapg3LNYsfc=
X-Google-Smtp-Source: APXvYqx+cFtvy7pwTQlKGPHAAMypER23fnZqo6t/mtCIylgdGP6Bf6JMiDo1eLWJS7VgcShjgzSIaw==
X-Received: by 2002:a1f:9916:: with SMTP id b22mr9510275vke.59.1559575354267;
        Mon, 03 Jun 2019 08:22:34 -0700 (PDT)
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com. [209.85.222.53])
        by smtp.gmail.com with ESMTPSA id 64sm5553815vky.48.2019.06.03.08.22.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 08:22:31 -0700 (PDT)
Received: by mail-ua1-f53.google.com with SMTP id l3so6493619uad.4
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 08:22:31 -0700 (PDT)
X-Received: by 2002:ab0:670c:: with SMTP id q12mr12649951uam.106.1559575350775;
 Mon, 03 Jun 2019 08:22:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190507234857.81414-1-dianders@chromium.org> <79ca5499-6b7d-fe55-2030-283f5cfb1d27@rock-chips.com>
 <82480aa5-ab2e-11c5-8dd5-c395f72fc6e7@ti.com>
In-Reply-To: <82480aa5-ab2e-11c5-8dd5-c395f72fc6e7@ti.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 3 Jun 2019 08:22:18 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Us1WyEqYDqVSuA+QPCDU7ceMEwwaWKtLz9ZNBFD0E7NQ@mail.gmail.com>
Message-ID: <CAD=FV=Us1WyEqYDqVSuA+QPCDU7ceMEwwaWKtLz9ZNBFD0E7NQ@mail.gmail.com>
Subject: Re: [PATCH] phy: rockchip-dp: Avoid power leak by leaving the PHY
 power on
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Caesar Wang <wxt@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>,
        Lin Huang <hl@rock-chips.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Derek Basehore <dbasehore@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Ryan Case <ryandcase@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "nickey.yang (nickey.yang@rock-chips.com)" 
        <nickey.yang@rock-chips.com>, wzz <wzz@rock-chips.com>,
        Huang Jiachai <hjc@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kishon,

On Mon, Jun 3, 2019 at 4:22 AM Kishon Vijay Abraham I <kishon@ti.com> wrote:
>
> Hi,
>
> On 20/05/19 1:34 PM, Caesar Wang wrote:
> > Hi Doug,
> >
> > For now,  nobody of rockchip is responsible for this driver.
> > Cc: Nickey, Zain, Hjc
> >
> >
> > On 5/8/19 7:48 AM, Douglas Anderson wrote:
> >> While testing a newer kernel on rk3288-based Chromebooks I found that
> >> the power draw in suspend was higher on newer kernels compared to the
> >> downstream Chrome OS 3.14 kernel.  Specifically the power of an
> >> rk3288-veyron-jerry board that I tested (as measured by the smart
> >> battery) was ~16 mA on Chrome OS 3.14 and ~21 mA on a newer kernel.
> >>
> >> I tracked the regression down to the fact that the "DP PHY" driver
> >> didn't exist in our downstream 3.14.  We relied on the eDP driver to
> >> turn on the clock and relied on the fact that the power for the PHY
> >> was default turned on.
> >>
> >> Specifically the thing that caused the power regression was turning
> >> the eDP PHY _off_.  Presumably there is some sort of power leak in the
> >> system and when we turn the PHY off something is leaching power from
> >> something else and causing excessive power draw.
> >>
> >> Doing a search through device trees shows that this PHY is only ever
> >> used on rk3288.  Presumably this power leak is present on all
> >> rk3288-SoCs running upstream Linux so let's just whack the driver to
> >> make sure we never turn off power.  We'll still leave the parts that
> >> turn _on_ the power and grab the clock, though.
> >>
> >> NOTES:
> >> A) If someone can identify what this power leak is and fix it in some
> >>     other way we can revert this patch.
> >> B) If someone can show that their particular board doesn't have this
> >>     power leak (maybe they have rails hooked up differently?) we can
> >>     perhaps add a device tree property indicating that for some boards
> >>     it's OK to turn this rail off.  I don't want to add this property
> >>     until I know of a board that needs it.
> >>
> >> Fixes: fd968973de95 ("phy: Add driver for rockchip Display Port PHY")
> >> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> >
> >
> > Reviewed-by: Caesar Wang <wxt@rock-chips.com>
> >
> >> ---
> >> As far as I know Yakir (the original author) is no longer at Rockchip.
> >> I've added a few other Rockchip people and hopefully one of them can
> >> help direct even if they're not directly responsible.
> >>
> >>   drivers/phy/rockchip/phy-rockchip-dp.c | 11 +++++++----
> >>   1 file changed, 7 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/drivers/phy/rockchip/phy-rockchip-dp.c
> >> b/drivers/phy/rockchip/phy-rockchip-dp.c
> >> index 8b267a746576..10bbcd69d6f5 100644
> >> --- a/drivers/phy/rockchip/phy-rockchip-dp.c
> >> +++ b/drivers/phy/rockchip/phy-rockchip-dp.c
> >> @@ -35,7 +35,7 @@ struct rockchip_dp_phy {
> >>   static int rockchip_set_phy_state(struct phy *phy, bool enable)
> >>   {
> >>       struct rockchip_dp_phy *dp = phy_get_drvdata(phy);
> >> -    int ret;
> >> +    int ret = 0;
> >>         if (enable) {
> >>           ret = regmap_write(dp->grf, GRF_SOC_CON12,
> >> @@ -50,9 +50,12 @@ static int rockchip_set_phy_state(struct phy *phy, bool
> >> enable)
> >>       } else {
> >>           clk_disable_unprepare(dp->phy_24m);
> >>   -        ret = regmap_write(dp->grf, GRF_SOC_CON12,
> >> -                   GRF_EDP_PHY_SIDDQ_HIWORD_MASK |
> >> -                   GRF_EDP_PHY_SIDDQ_OFF);
> >> +        /*
> >> +         * Intentionally don't turn SIDDQ off when disabling
> >> +         * the PHY.  There is a power leak on rk3288 and
> >> +         * suspend power _increases_ by 5 mA if you turn this
> >> +         * off.
> >> +         */
>
> Can someone in Rockchip try to find the root-cause of the issue? Keeping the
> PHY off shouldn't increase power draw.

It sounded like Chris already answered this, though?  Basically things
aren't hooked up in a way that this line can be turned safely turned
off in rk3288 with the current state of the world.  Chris says that
there's an ordering problem where we've got to turn off PD_VIO
_before_ we turn off SIDDQ.  ...but PD_VIO is a power domain that
contains much more than just eDP.  So if we truly wanted to try to
solve this we'd need to come up with a way to make sure PD_VIO got all
the way off and then turn this off only afterwards.

...and right now on rk3288 it looks like we never actually turn off
PD_VIO while the system is running.

-Doug
