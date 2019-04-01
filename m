Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39EBCC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 11:30:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F216F2086C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 11:30:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="oJIBlrS4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbfDALau (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 07:30:50 -0400
Received: from vps.xff.cz ([195.181.215.36]:57362 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725882AbfDALau (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 07:30:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1554118248; bh=ZFs1BKsLGNpqfgDsAoDMH+Cb9t9ODxul5gvdxucrvUQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oJIBlrS4n9kiNgq8KrmHsF7Qo/B32JqgcryIVqYPwlJVGrId5RkWgibnh7/P5dXIW
         RvJHt2fjq37S55NIVaN2KtZXw8XkmM7DUc5GXn6cfspGahHigVhA4mcay05gBmzxXg
         c/J/m8r2ySaOnkcpkP8x0/m7NtQDZEWFkyRMNxoo=
Date:   Mon, 1 Apr 2019 13:30:47 +0200
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-sunxi@googlegroups.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] ARM: dts: sun8i: a83t: Add missing CPU clock
 references
Message-ID: <20190401113047.uudhhl7zecdskfrb@core.my.home>
Mail-Followup-To: Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        linux-sunxi@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20190328113159.9668-1-megous@megous.com>
 <20190328113159.9668-3-megous@megous.com>
 <20190401082242.ashnencaiubbidor@flea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190401082242.ashnencaiubbidor@flea>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Maxime,

On Mon, Apr 01, 2019 at 10:22:42AM +0200, Maxime Ripard wrote:
> Hi,
> 
> On Thu, Mar 28, 2019 at 12:31:59PM +0100, megous@megous.com wrote:
> > From: Ondrej Jirman <megous@megous.com>
> >
> > A83T DTSI has cpu clocks defined only on the first CPU in each cluster.
> > We can bring down any CPU in the cluster, so we need to define clock
> > for each CPU, so that the system knows what clock to use if the first
> > CPU is down.
> >
> > Signed-off-by: Ondrej Jirman <megous@megous.com>
> > ---
> >  arch/arm/boot/dts/sun8i-a83t.dtsi | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
> > index 7a40b7d77ec0..1b0b025b9250 100644
> > --- a/arch/arm/boot/dts/sun8i-a83t.dtsi
> > +++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
> > @@ -73,6 +73,8 @@
> >  		};
> >
> >  		cpu@1 {
> > +			clocks = <&ccu CLK_C0CPUX>;
> 
> Usually we'll have the compatible first

I'll re-order it.

> > +			clock-names = "cpu";
> 
> And that's not documented anywhere?

Cpufreq doesn't use CPU clock names, except for the mediatek cpufreq driver.

It's not docummented explicitly, except it's used as part of examples in
bindings/opp/opp.txt.

I guess I can safely drop it, but other will probably keep using it, because
it's part of the examples.

thank you and regards,
  Ondrej

> Maxime
> 
> --
> Maxime Ripard, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com


