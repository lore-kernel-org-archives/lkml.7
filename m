Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36969C04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 15:48:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FE2F2082E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 15:48:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727525AbfEPPsn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 11:48:43 -0400
Received: from verein.lst.de ([213.95.11.211]:60317 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727037AbfEPPsm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 11:48:42 -0400
Received: by newverein.lst.de (Postfix, from userid 2005)
        id BC11268B02; Thu, 16 May 2019 17:48:20 +0200 (CEST)
Date:   Thu, 16 May 2019 17:48:20 +0200
From:   Torsten Duwe <duwe@lst.de>
To:     Vasily Khoruzhick <anarsoul@gmail.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Sean Paul <seanpaul@chromium.org>,
        Harald Geyer <harald@ccbib.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>,
        arm-linux <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] arm64: DTS: allwinner: a64: enable ANX6345 bridge
 on Teres-I
Message-ID: <20190516154820.GA10431@lst.de>
References: <20190514155911.6C0AC68B05@newverein.lst.de> <20190514160241.9EAC768C7B@newverein.lst.de> <CA+E=qVfuKBzWK7dpM_eabjU8mLdzOw3zCnYk6Tc1oXdavH7CNA@mail.gmail.com> <20190515093141.41016b11@blackhole.lan> <CA+E=qVf6K_0T0x2Hsfp6EDqM-ok6xiAzeZPvp6SRg0yt010pKA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+E=qVf6K_0T0x2Hsfp6EDqM-ok6xiAzeZPvp6SRg0yt010pKA@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 15, 2019 at 08:08:57AM -0700, Vasily Khoruzhick wrote:
> On Wed, May 15, 2019 at 12:32 AM Torsten Duwe <duwe@lst.de> wrote:
> >
> > It does comply with the bindings. The ports are all optional.
> > As far as DT is concerned, the signal path ends here. This is also the
> > final component _required_ to get the Linux kernel DRI up and running.
> 
> Ugh, then bindings should be fixed. It's not optional. It may work if
> bootloader enables power for you, but it won't if you disable display
> driver in u-boot.

I double-checked. On the Teres-I, mentioning the panel _is_ optional.
PD23 powers down panel and backlight as much as possible, see
24bd5d2cb93bc arm64: dts: allwinner: a64: teres-i: enable backlight
(currently only in Maxime's repo) and the Teres-I schematics...

And the driver in your repo neatly guards all accesses with
"if (anx6345->panel)" -- good!
But I found the Vdds are required, so I added them as such.

> I guess you're testing it with older version of anx6345. Newer version
> that supports power management [1] needs startup delay for panel.
> Another issue that you're seeing is that backlight is not disabled on
> DPMS events. All in all, you need to describe panel in dts.
> 
> [1] https://github.com/anarsoul/linux-2.6/commit/2fbf9c242419c8bda698e8331a02d4312143ae2c

> > Should I also have added a Tested-by: ? ;-)
> 
> I don't have Teres, so I haven't tested these.

*I* have one, and this works. I'll retest with your newer driver,
just in case. Nonetheless, the changes in this series should be fine.
Sending out v2 in a moment...

	Torsten

