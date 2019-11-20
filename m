Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D551C43215
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:53:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FF52219FA
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:53:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730336AbfKTNxo convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 08:53:44 -0500
Received: from gloria.sntech.de ([185.11.138.130]:39494 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727671AbfKTNxo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:53:44 -0500
Received: from ip5f5a6266.dynamic.kabel-deutschland.de ([95.90.98.102] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1iXQQN-0003aZ-Vt; Wed, 20 Nov 2019 14:53:40 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        Tom Cubie <tom@radxa.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Akash Gajjar <akash@openedev.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-amarula <linux-amarula@amarulasolutions.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 4/5] ARM: dts: rockchip: Add Radxa Carrier board
Date:   Wed, 20 Nov 2019 14:53:39 +0100
Message-ID: <12496011.EUIoF19S7S@diego>
In-Reply-To: <CAMty3ZA+p2pWokLrwnkv6_q0G8d76AntE5Kar4JN8MN48O9VSw@mail.gmail.com>
References: <20191120113923.11685-1-jagan@amarulasolutions.com> <5644395.EDGZVd1YuU@diego> <CAMty3ZA+p2pWokLrwnkv6_q0G8d76AntE5Kar4JN8MN48O9VSw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jagan,

Am Mittwoch, 20. November 2019, 14:45:35 CET schrieb Jagan Teki:
> On Wed, Nov 20, 2019 at 6:55 PM Heiko Stübner <heiko@sntech.de> wrote:
> > Am Mittwoch, 20. November 2019, 12:39:22 CET schrieb Jagan Teki:
> > > Carrier board often referred as baseboard. For making
> > > complete SBC, the associated SOM will mount on top of
> > > this carrier board.
> > >
> > > Radxa has a carrier board which supports on board
> > > peripherals, ports like USB-2.0, USB-3.0, HDMI, MIPI DSI/CSI,
> > > eDP, Ethernet, PCIe, USB-C, 40-Pin GPIO header and etc.
> > >
> > > Currently this carrier board can be used together with
> > > VMARC RK3399Por SOM for making Rock PI N10 SBC.
> > >
> > > So add this carrier board dtsi as a separate file in
> > > ARM directory, so-that the same can reuse it in both
> > > arm32 and arm64 variants of Rockchip SOMs.
> >
> > Do you really think someone will create an arm32 soc using that
> > carrier board?
> 
> Yes, we have Rock Pi N8 which is using same carrier board design with
> (+ external codec) on top of RK3288 SOM. I didn't mentioned on the
> commit message since radxa doesn't officially announced on the
> website.
> 
> >
> > Similarly so far I don't think we haven't even seen a lot of reuse
> > of existing carrier boards at all, other than their initial combination.
> >
> > So maybe just having the content of your
> >         rockchip-radxa-carrierboard.dtsi
> > in
> >         rockchip/rk3399pro-rock-pi-n10.dts
> > from patch 5 might be a better start - at least until there is any
> > further usage - if at all?
> 
> But, this particular design has proper use case.
> 1. rk3399pro SOM + carrier board (Rock Pi N10)
> 2. rk3288 SOM + carrier board (Rock Pi N8)
> 
> >
> > Also rockchip-radxa-carrierboard might even be overly generic
> > as there may be multiple carrierboards from Radxa later on.
> 
> I'm slightly disagree of having overlay here, since these are fixed
> design combinations. where SOM with respective carrier board is
> mandatory to make final board. Understand that we can have a
> maintenance over-ahead if we have multiple carrier boards, but right
> now radxa has only one carrier board with 2 sets of SOM's combinations
> that indeed fit like a dev board, so there is unused carrier board.

All is good ... with that information from above (rk3288) this definitly
makes more sense :-)

The naming of the file is still a tiny struggle though. Does this board
maybe have some actual product name or is it really just called
"carrierboard"? :-)

Thanks
Heiko


