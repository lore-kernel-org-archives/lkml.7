Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E602EFC6195
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 16:52:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDE912178F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 16:52:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbfKHQwm convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 11:52:42 -0500
Received: from gloria.sntech.de ([185.11.138.130]:33404 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726101AbfKHQwm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 11:52:42 -0500
Received: from ip5f5a6266.dynamic.kabel-deutschland.de ([95.90.98.102] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1iT7Uy-0002QA-3f; Fri, 08 Nov 2019 17:52:36 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Markus Reichl <m.reichl@fivetechno.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] arm64: dts: rockchip: Split rk3399-roc-pc for with and without mezzanine board.
Date:   Fri, 08 Nov 2019 17:52:35 +0100
Message-ID: <4421021.f1aGTiCmcP@diego>
In-Reply-To: <616df0fa-a503-1a57-12b6-43bcd674db8c@fivetechno.de>
References: <7293c5f6-a07f-cf51-954f-92907879eea2@fivetechno.de> <1628743.87kQKnQNn8@diego> <616df0fa-a503-1a57-12b6-43bcd674db8c@fivetechno.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Markus,

Am Freitag, 8. November 2019, 16:18:39 CET schrieb Markus Reichl:
> Am 08.11.19 um 15:41 schrieb Heiko Stübner:
> > Am Montag, 4. November 2019, 16:22:25 CET schrieb Markus Reichl:
> >> For rk3399-roc-pc is a mezzanine board available that carries M.2 and
> >> POE interfaces. Use it with a separate dts.
> >> 
> >> ---
> >> v3: Use enum in binding and full name in compatible string and file name.
> >> v2: Add new compatible string for roc-pc with mezzanine board.
> >> --
> >> 
> >> Signed-off-by: Markus Reichl <m.reichl@fivetechno.de>
> >> ---
> >>  .../devicetree/bindings/arm/rockchip.yaml     |   4 +-
> >>  arch/arm64/boot/dts/rockchip/Makefile         |   1 +
> >>  .../dts/rockchip/rk3399-roc-pc-mezzanine.dts  |  72 ++
> >>  .../arm64/boot/dts/rockchip/rk3399-roc-pc.dts | 757 +----------------
> >>  .../boot/dts/rockchip/rk3399-roc-pc.dtsi      | 770 ++++++++++++++++++
> >>  5 files changed, 847 insertions(+), 757 deletions(-)
> >>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-roc-pc-mezzanine.dts
> >>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
> >> 
> > 
> >> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dts b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dts
> >> index 7e07dae33d0f..cd4195425309 100644
> >> --- a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dts
> >> +++ b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dts
> >> @@ -4,764 +4,9 @@
> > 
> > This whole hunk fails to apply against my current branch for 5.5
> > which contain your other patches [0].
> > 
> > And the moved block is obviously so big that I can't really check
> > which part is somehow different, so I'd ask you to rebase this
> > patch accordingly, so that it applies again.
> 
> Yes, will rebase and come with v4.

Not wanting to put any pressure on you, but do you have an estimate
for this? I need to do my second (and final) round of pull requests for
v5.5, so it would of course be interesting if it's sensible to wait for
your respin ;-)

Thanks
Heiko



