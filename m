Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30661C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 21:59:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D909121951
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 21:59:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mV4yN9Xb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730814AbfGVV7Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 17:59:25 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:37981 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726553AbfGVV7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 17:59:25 -0400
Received: by mail-io1-f65.google.com with SMTP id j6so2289960ioa.5
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 14:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M4B5MWHaBM5L6mAB44C8VC587AuJcqw9v3suudathig=;
        b=mV4yN9XbiPm46rZRFWHIwRnJLaAHpFcZQXjZTtYF+lvWkpqAE8M0TSjnqF7x9XW2/A
         wJ5yzv+XKjZLlUo+WTNIs2iqS8X0STj8twa3zEjI9a8G2KOBbGN0BkP/IRtZmdHoJKu2
         KI2kXbrAtzBfyIjLpL/W0Sft1zOYuf7ZqdFt8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M4B5MWHaBM5L6mAB44C8VC587AuJcqw9v3suudathig=;
        b=Rt4pbdPjLizRLZr69R+cto2D+a2QmDiHLS2lMVt24fAtfia4Km31sW1O7GWBnWHBOm
         xQgr0p5Mm5EJEmFGkONQmaxoDlI5LlphYj8MKFLybCd+RWBDnxPoOtj6JxIQBw7DTavd
         5gTiFIKj1ioSNrBJRd0ux+kr+c7NRagF9YN9c0kKtnSXr/m/Io4qLCT5lR//D4EDx8Mt
         9s6Qi+/r1t4ABvCswnnvA3wKriknUuMK8Wzn670MzHw1G1ZQx6DqzRy3wI5eXG/B3YFm
         u6tDC4EC13hugDT37QznPpdB5Rt2DOIJkWaegrMqIbNkDJDOgfmm+6wDsqsKb+piTk3E
         u+OA==
X-Gm-Message-State: APjAAAUE1M5GiUfy3aFYdrZAfaBZlHzO6aIwzetcvH9TeNHyD3tCR8Vm
        u/eM4BWDY0tHDa0SBzs8slhhoPxULwM=
X-Google-Smtp-Source: APXvYqz/to6mNWNWYTqat4kMzgjTc/48g7IrNjgJ7mqWNMLQPqTTB0+zOxdJ4DFm22UWdY2Gur1rgQ==
X-Received: by 2002:a02:ac03:: with SMTP id a3mr77656655jao.132.1563832763938;
        Mon, 22 Jul 2019 14:59:23 -0700 (PDT)
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com. [209.85.166.51])
        by smtp.gmail.com with ESMTPSA id l11sm30798470ioj.32.2019.07.22.14.59.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jul 2019 14:59:23 -0700 (PDT)
Received: by mail-io1-f51.google.com with SMTP id o9so77501472iom.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 14:59:23 -0700 (PDT)
X-Received: by 2002:a02:ac03:: with SMTP id a3mr77628446jao.132.1563832348559;
 Mon, 22 Jul 2019 14:52:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190507234857.81414-1-dianders@chromium.org> <79ca5499-6b7d-fe55-2030-283f5cfb1d27@rock-chips.com>
 <82480aa5-ab2e-11c5-8dd5-c395f72fc6e7@ti.com> <CAD=FV=Us1WyEqYDqVSuA+QPCDU7ceMEwwaWKtLz9ZNBFD0E7NQ@mail.gmail.com>
In-Reply-To: <CAD=FV=Us1WyEqYDqVSuA+QPCDU7ceMEwwaWKtLz9ZNBFD0E7NQ@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 22 Jul 2019 14:52:16 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XgawwLf6BQ-ruY5e36VyA3jM4Vf5gpFPfC8nLQwxwW_w@mail.gmail.com>
Message-ID: <CAD=FV=XgawwLf6BQ-ruY5e36VyA3jM4Vf5gpFPfC8nLQwxwW_w@mail.gmail.com>
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

On Mon, Jun 3, 2019 at 8:22 AM Doug Anderson <dianders@chromium.org> wrote:
>
> Kishon,
>
> On Mon, Jun 3, 2019 at 4:22 AM Kishon Vijay Abraham I <kishon@ti.com> wrote:
> >
> > Hi,
> >
> > On 20/05/19 1:34 PM, Caesar Wang wrote:
> > > Hi Doug,
> > >
> > > For now,  nobody of rockchip is responsible for this driver.
> > > Cc: Nickey, Zain, Hjc
> > >
> > >
> > > On 5/8/19 7:48 AM, Douglas Anderson wrote:
> > >> While testing a newer kernel on rk3288-based Chromebooks I found that
> > >> the power draw in suspend was higher on newer kernels compared to the
> > >> downstream Chrome OS 3.14 kernel.  Specifically the power of an
> > >> rk3288-veyron-jerry board that I tested (as measured by the smart
> > >> battery) was ~16 mA on Chrome OS 3.14 and ~21 mA on a newer kernel.
> > >>
> > >> I tracked the regression down to the fact that the "DP PHY" driver
> > >> didn't exist in our downstream 3.14.  We relied on the eDP driver to
> > >> turn on the clock and relied on the fact that the power for the PHY
> > >> was default turned on.
> > >>
> > >> Specifically the thing that caused the power regression was turning
> > >> the eDP PHY _off_.  Presumably there is some sort of power leak in the
> > >> system and when we turn the PHY off something is leaching power from
> > >> something else and causing excessive power draw.
> > >>
> > >> Doing a search through device trees shows that this PHY is only ever
> > >> used on rk3288.  Presumably this power leak is present on all
> > >> rk3288-SoCs running upstream Linux so let's just whack the driver to
> > >> make sure we never turn off power.  We'll still leave the parts that
> > >> turn _on_ the power and grab the clock, though.
> > >>
> > >> NOTES:
> > >> A) If someone can identify what this power leak is and fix it in some
> > >>     other way we can revert this patch.
> > >> B) If someone can show that their particular board doesn't have this
> > >>     power leak (maybe they have rails hooked up differently?) we can
> > >>     perhaps add a device tree property indicating that for some boards
> > >>     it's OK to turn this rail off.  I don't want to add this property
> > >>     until I know of a board that needs it.
> > >>
> > >> Fixes: fd968973de95 ("phy: Add driver for rockchip Display Port PHY")
> > >> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > >
> > >
> > > Reviewed-by: Caesar Wang <wxt@rock-chips.com>
> > >
> > >> ---
> > >> As far as I know Yakir (the original author) is no longer at Rockchip.
> > >> I've added a few other Rockchip people and hopefully one of them can
> > >> help direct even if they're not directly responsible.
> > >>
> > >>   drivers/phy/rockchip/phy-rockchip-dp.c | 11 +++++++----
> > >>   1 file changed, 7 insertions(+), 4 deletions(-)
> > >>
> > >> diff --git a/drivers/phy/rockchip/phy-rockchip-dp.c
> > >> b/drivers/phy/rockchip/phy-rockchip-dp.c
> > >> index 8b267a746576..10bbcd69d6f5 100644
> > >> --- a/drivers/phy/rockchip/phy-rockchip-dp.c
> > >> +++ b/drivers/phy/rockchip/phy-rockchip-dp.c
> > >> @@ -35,7 +35,7 @@ struct rockchip_dp_phy {
> > >>   static int rockchip_set_phy_state(struct phy *phy, bool enable)
> > >>   {
> > >>       struct rockchip_dp_phy *dp = phy_get_drvdata(phy);
> > >> -    int ret;
> > >> +    int ret = 0;
> > >>         if (enable) {
> > >>           ret = regmap_write(dp->grf, GRF_SOC_CON12,
> > >> @@ -50,9 +50,12 @@ static int rockchip_set_phy_state(struct phy *phy, bool
> > >> enable)
> > >>       } else {
> > >>           clk_disable_unprepare(dp->phy_24m);
> > >>   -        ret = regmap_write(dp->grf, GRF_SOC_CON12,
> > >> -                   GRF_EDP_PHY_SIDDQ_HIWORD_MASK |
> > >> -                   GRF_EDP_PHY_SIDDQ_OFF);
> > >> +        /*
> > >> +         * Intentionally don't turn SIDDQ off when disabling
> > >> +         * the PHY.  There is a power leak on rk3288 and
> > >> +         * suspend power _increases_ by 5 mA if you turn this
> > >> +         * off.
> > >> +         */
> >
> > Can someone in Rockchip try to find the root-cause of the issue? Keeping the
> > PHY off shouldn't increase power draw.
>
> It sounded like Caesar already answered this, though?  Basically things
> aren't hooked up in a way that this line can be turned safely turned
> off in rk3288 with the current state of the world.  Chris says that
> there's an ordering problem where we've got to turn off PD_VIO
> _before_ we turn off SIDDQ.  ...but PD_VIO is a power domain that
> contains much more than just eDP.  So if we truly wanted to try to
> solve this we'd need to come up with a way to make sure PD_VIO got all
> the way off and then turn this off only afterwards.
>
> ...and right now on rk3288 it looks like we never actually turn off
> PD_VIO while the system is running.

Is now a good time to land this patch since 5.3-rc1 is out?  Do you
need me to re-send?  Hopefully your concerns are all addressed?

-Doug
