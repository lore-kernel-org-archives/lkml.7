Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EA77C2D0D2
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 11:26:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECD3A206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 11:26:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbfLXL0X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Dec 2019 06:26:23 -0500
Received: from honk.sigxcpu.org ([24.134.29.49]:42022 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726102AbfLXL0X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 06:26:23 -0500
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 8179BFB03;
        Tue, 24 Dec 2019 12:26:18 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id nHMPm4X5RhAK; Tue, 24 Dec 2019 12:26:17 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 91FB140BD8; Tue, 24 Dec 2019 12:26:16 +0100 (CET)
Date:   Tue, 24 Dec 2019 12:26:16 +0100
From:   Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Dan Murphy <dmurphy@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] leds: lm3692x: Allow to set ovp and brigthness mode
Message-ID: <20191224112616.GA23468@bogon.m.sigxcpu.org>
References: <cover.1576499103.git.agx@sigxcpu.org>
 <9c87a17aefbf758d58f199f7046114ee7505a1fa.1576499103.git.agx@sigxcpu.org>
 <20191221191844.GH32732@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191221191844.GH32732@amd>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Sat, Dec 21, 2019 at 08:18:44PM +0100, Pavel Machek wrote:
> Hi!
> 
> > Overvoltage protection and brightness mode are currently hardcoded
> > as disabled in the driver. Make these configurable via DT.
> 
> What exactly is overvoltage protection good for? Should we default to
> 29V if we have no other information?

The OVP protects the IC from overvoltage conditions on the output side.
While looking at the manual again I noticed that i misremembered the
'00' value which means 17V - not unprotected. Also the chip defaults
to 29V OVP so i've adjusted that too.

Cheers,
 -- Guido

> 
> > Signed-off-by: Guido Günther <agx@sigxcpu.org>
> 
> > +	ret = device_property_read_u32(&led->client->dev,
> > +				       "ti,overvoltage-volts", &ovp);
> > +	if (!ret) {
> > +		switch (ovp) {
> > +		case 0:
> > +			break;
> > +		case 22:
> > +			led->boost_ctrl |= LM3692X_OVP_21V;
> > +			break;
> 
> Should be case 21.
> 								Pavel
> -- 
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html


