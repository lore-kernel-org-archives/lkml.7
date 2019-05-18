Return-Path: <SRS0=//ty=TS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEE2BC04AAF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 07:51:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF43A20C01
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 07:51:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728337AbfERHvM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 May 2019 03:51:12 -0400
Received: from gloria.sntech.de ([185.11.138.130]:38818 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725268AbfERHvM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 May 2019 03:51:12 -0400
Received: from p508fcf3a.dip0.t-ipconnect.de ([80.143.207.58] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1hRu7X-0005Nr-HM; Sat, 18 May 2019 09:51:07 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Doug Anderson <dianders@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Elaine Zhang <zhangqing@rock-chips.com>,
        Caesar <wxt@rock-chips.com>, Lin Huang <hl@rock-chips.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Derek Basehore <dbasehore@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Ryan Case <ryandcase@chromium.org>
Subject: Re: [PATCH] phy: rockchip-dp: Avoid power leak by leaving the PHY power on
Date:   Sat, 18 May 2019 09:51:06 +0200
Message-ID: <1862323.vETM5zrFmV@phil>
In-Reply-To: <CAD=FV=VcF688tSArf5gu0sV5oKVgFEvPBxXm7j-5GXXMP_CYRw@mail.gmail.com>
References: <20190507234857.81414-1-dianders@chromium.org> <CAD=FV=VcF688tSArf5gu0sV5oKVgFEvPBxXm7j-5GXXMP_CYRw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am Samstag, 18. Mai 2019, 01:57:47 CEST schrieb Doug Anderson:
> Elaine and Caesar,
> 
> On Tue, May 7, 2019 at 4:50 PM Douglas Anderson <dianders@chromium.org> wrote:
> >
> > While testing a newer kernel on rk3288-based Chromebooks I found that
> > the power draw in suspend was higher on newer kernels compared to the
> > downstream Chrome OS 3.14 kernel.  Specifically the power of an
> > rk3288-veyron-jerry board that I tested (as measured by the smart
> > battery) was ~16 mA on Chrome OS 3.14 and ~21 mA on a newer kernel.
> >
> > I tracked the regression down to the fact that the "DP PHY" driver
> > didn't exist in our downstream 3.14.  We relied on the eDP driver to
> > turn on the clock and relied on the fact that the power for the PHY
> > was default turned on.
> >
> > Specifically the thing that caused the power regression was turning
> > the eDP PHY _off_.  Presumably there is some sort of power leak in the
> > system and when we turn the PHY off something is leaching power from
> > something else and causing excessive power draw.
> >
> > Doing a search through device trees shows that this PHY is only ever
> > used on rk3288.  Presumably this power leak is present on all
> > rk3288-SoCs running upstream Linux so let's just whack the driver to
> > make sure we never turn off power.  We'll still leave the parts that
> > turn _on_ the power and grab the clock, though.
> >
> > NOTES:
> > A) If someone can identify what this power leak is and fix it in some
> >    other way we can revert this patch.
> > B) If someone can show that their particular board doesn't have this
> >    power leak (maybe they have rails hooked up differently?) we can
> >    perhaps add a device tree property indicating that for some boards
> >    it's OK to turn this rail off.  I don't want to add this property
> >    until I know of a board that needs it.
> >
> > Fixes: fd968973de95 ("phy: Add driver for rockchip Display Port PHY")
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> > As far as I know Yakir (the original author) is no longer at Rockchip.
> > I've added a few other Rockchip people and hopefully one of them can
> > help direct even if they're not directly responsible.
> >
> >  drivers/phy/rockchip/phy-rockchip-dp.c | 11 +++++++----
> >  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> Can you help direct this to the right person?  ...or should we just
> land it and assume it's fine?

I tink Kishon as phy-maintainer is the correct person to take on this
patch, but maybe he's waiting for the merge-window to be over.


Heiko


