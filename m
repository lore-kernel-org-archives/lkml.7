Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5785C282E3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 13:43:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B0582054F
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 13:43:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=plaes.org header.i=@plaes.org header.b="nsFTjcKa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727609AbfE1Nnq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 09:43:46 -0400
Received: from plaes.org ([188.166.43.21]:54830 "EHLO plaes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727045AbfE1Nnp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 09:43:45 -0400
Received: from plaes.org (localhost [127.0.0.1])
        by plaes.org (Postfix) with ESMTPSA id C71B5402DD;
        Tue, 28 May 2019 13:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=plaes.org; s=mail;
        t=1559051023; bh=f16GXwO0bccw+CqyxghYo/6IH2hKOaqFoaXAUl2gBYY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nsFTjcKaRiqZx+PCgmpPV4uZ/cM9FBuepy2A96v2cnNvGBmmSQLg7/hAyTqSWCbIb
         XnTU75k8LsJlRz+Kmx6Ry+gKKR3lBa6ZCm80MNo8WlPBbf0cux4PwMlvoqHlBIyRPZ
         4XC/sNs+shNbpEATraIYAAT2UGxSvrKGxcAw3fPjUgcA2nOFsvP4nLJNkg+rZTE1XO
         nKgXg8HWyQk1ERo7LO3sHRrqb9nPZQFu2biMrYy5JYUzCf14XoX6OeyOXBLQf0M3Jl
         jO9GlPYr/8XKFdrmUZx0LXfL0XTxBiMoFdTeZAVXSfYg7u68J8oijIh8CS0O916rZV
         D/Jp3Frlo70pg==
Date:   Tue, 28 May 2019 13:43:42 +0000
From:   Priit Laes <plaes@plaes.org>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [linux-sunxi] [RESEND PATCH] ARM: dts: sun7i: olimex-lime2:
 Enable ac and power supplies
Message-ID: <20190528134342.25fep6kpmrr4p7vw@plaes.org>
References: <20190528063544.17408-1-plaes@plaes.org>
 <2b671c1f0734177a6283407f753403473b70f5bc.camel@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b671c1f0734177a6283407f753403473b70f5bc.camel@bootlin.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 28, 2019 at 02:58:57PM +0200, Paul Kocialkowski wrote:
> Hi,
> 
> On Tue, 2019-05-28 at 09:35 +0300, Priit Laes wrote:
> > Lime2 has battery connector so enable these supplies.
> 
> Out of curiosity, what is reported to userspace when no battery is
> attached?

Data from /sys/class/power_supply/axp20x-battery:

[snip]
$ for i in $(ls -1); do echo "cat $i"; cat $i; done

cat capacity
100
cat constant_charge_current
1200000
cat constant_charge_current_max
1200000
cat current_now
0
cat health
Good
cat online
0
cat present
0
cat status
Not charging
cat type
Battery
cat uevent
POWER_SUPPLY_NAME=axp20x-battery
POWER_SUPPLY_PRESENT=0
POWER_SUPPLY_ONLINE=0
POWER_SUPPLY_STATUS=Not charging
POWEROSUPPLY_VOLTAGE_NOW=0
POWER_SUPPLY_CURRENT_NOW=0
POWER_SUPPLY_CON/TANT_CHARGE_CURRENT=1200000
POWER_SUPPLY_CONSTANT_CHARGE_CURRENT_MAX=1200000
POWER_SUPPLY_HEALTH=Good
POWER_SUPPLY_VOLTAGE_MAXODESIGN=4200000
POWEROSUPPLY_VOLTAGE_MIN_DESIGN=2900000
POWER_SUPPLY_CAPACITY=100
cat voltage_max_design
4200000
cat voltage_min_design
2900000
cat voltage_now
0
[/snip]

> Looks good otherwise:
> Reviewed-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> 
> Cheers,
> 
> Paul
> 
> > Signed-off-by: Priit Laes <plaes@plaes.org>
> > ---
> >  arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
> > index 9c8eecf4337a..9001b5527615 100644
> > --- a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
> > +++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
> > @@ -206,6 +206,14 @@
> >  
> >  #include "axp209.dtsi"
> >  
> > +&ac_power_supply {
> > +	status = "okay";
> > +};
> > +
> > +&battery_power_supply {
> > +	status = "okay";
> > +};
> > +
> >  &reg_dcdc2 {
> >  	regulator-always-on;
> >  	regulator-min-microvolt = <1000000>;
> > -- 
> > 2.11.0
> > 
> -- 
> Paul Kocialkowski, Bootlin
> Embedded Linux and kernel engineering
> https://bootlin.com
> 
