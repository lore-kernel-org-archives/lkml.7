Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37868C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 15:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ABEE2067C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 15:41:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="m3ngXj4q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728175AbfFDPl0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 11:41:26 -0400
Received: from vps.xff.cz ([195.181.215.36]:36274 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728044AbfFDPlZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 11:41:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1559662884; bh=QKcBPWY3CbkjfYN89rLEZysY97rw4wPAuVtD6U6xPrg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m3ngXj4qq1GciQjkwDqUoYqSmjqED0N54diMTYXwe3lWOM52GaID2qkX7+cE/wroZ
         KD+HABGKCwc431teBRH27R/UH8Yj2NZa2otOhUErymlHORylXTsDPB5gjmYltRSfVL
         vqIlAry4sXUPqEW7ue6gnlmOHvTEkIC1u3qYXZKs=
Date:   Tue, 4 Jun 2019 17:41:24 +0200
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>
To:     Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>
Cc:     linux-sunxi@googlegroups.com,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Michael Turquette <mturquette@baylibre.com>,
        open list <linux-kernel@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>,
        "moderated list:ARM/Allwinner sunXi SoC support" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [linux-sunxi] [PATCH] clk: sunxi-ng: sun50i-h6-r: Fix incorrect
 W1 clock gate register
Message-ID: <20190604154124.lalh3uhshx43l3rs@core.my.home>
Mail-Followup-To: Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>,
        linux-sunxi@googlegroups.com,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Michael Turquette <mturquette@baylibre.com>,
        open list <linux-kernel@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>,
        "moderated list:ARM/Allwinner sunXi SoC support" <linux-arm-kernel@lists.infradead.org>
References: <20190604150054.17683-1-megous@megous.com>
 <20522585.shqbOC0eQD@jernej-laptop>
 <20190604153120.zcxfn4kh2qjfktgo@core.my.home>
 <2504206.OUqqUFhxAD@jernej-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2504206.OUqqUFhxAD@jernej-laptop>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jernej,

On Tue, Jun 04, 2019 at 05:35:48PM +0200, Jernej Škrabec wrote:
> Hi!
> 
> Dne torek, 04. junij 2019 ob 17:31:20 CEST je 'Ondřej Jirman' via linux-sunxi 
> napisal(a):
> > Hi Jernej,
> > 
> > On Tue, Jun 04, 2019 at 05:03:55PM +0200, Jernej Škrabec wrote:
> > > Dne torek, 04. junij 2019 ob 17:00:54 CEST je megous via linux-sunxi
> > > 
> > > napisal(a):
> > > > From: Ondrej Jirman <megous@megous.com>
> > > > 
> > > > The current code defines W1 clock gate to be at 0x1cc, overlaying it
> > > > with the IR gate.
> > > > 
> > > > Clock gate for r-apb1-w1 is at 0x1ec. This fixes issues with IR receiver
> > > > causing interrupt floods on H6 (because interrupt flags can't be
> > > > cleared,
> > > > due to IR module's bus being disabled).
> > > > 
> > > > Signed-off-by: Ondrej Jirman <megous@megous.com>
> > > 
> > > You should add Fixes tag and CC stable with this.
> > 
> > Not necessary, since H6 IR is not yet supported on mainline.
> 
> Well, CCing stable is probably really not necessary, but you are fixing bug in 
> existing driver (clk), fixes tag still apply.

Right, resent v2.

thank you and regards,
	o.

> Best regards,
> Jernej
> 
> > 
> > regards,
> > 	o.
> > 
> > > Best regards,
> > > Jernej
> > > 
> > > 
> > > 
> > > _______________________________________________
> > > linux-arm-kernel mailing list
> > > linux-arm-kernel@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
> 
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
