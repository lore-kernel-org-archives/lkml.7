Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91AC8C10F06
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 16:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CF40206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 16:15:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbfDCQPd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 12:15:33 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:36919 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbfDCQPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 12:15:33 -0400
X-Originating-IP: 109.213.83.19
Received: from localhost (alyon-652-1-60-19.w109-213.abo.wanadoo.fr [109.213.83.19])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 6F6F71BF21A;
        Wed,  3 Apr 2019 16:15:30 +0000 (UTC)
Date:   Wed, 3 Apr 2019 18:15:29 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Flavio Suligoi <f.suligoi@asem.it>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] rtc: pcf2127: add battery-low INTn generation
Message-ID: <20190403161529.GS22216@piout.net>
References: <1554303165-24813-1-git-send-email-f.suligoi@asem.it>
 <1554303165-24813-2-git-send-email-f.suligoi@asem.it>
 <20190403150824.GO22216@piout.net>
 <452a4cf1410a41c8b6f767ac6258482e@asem.it>
 <20190403153143.GQ22216@piout.net>
 <fd4bef0bb64e4b6fbdf74cbebaa12de3@asem.it>
 <20190403155654.GR22216@piout.net>
 <8367f68a023d468f8235810b0cf583bc@asem.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8367f68a023d468f8235810b0cf583bc@asem.it>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/04/2019 16:09:14+0000, Flavio Suligoi wrote:
> Hi,
> 
> > On 03/04/2019 15:49:03+0000, Flavio Suligoi wrote:
> > > > Then, you should probably not enable BLIE because this will cause
> > issues
> > > > with the alarm functionnality.. It is certainly enough to use
> > > > RTC_VL_READ periodically.
> > >
> > > We use the nINT signaling solution because of this pin, in addition
> > > to be used by the CPU, can be also connected to an external connector,
> > > available for the final user.
> > > Anyway, even if the BLIE is set, the sw low voltage alarm works,
> > > with the message (displayed about every 12 minutes):
> > >
> > 
> > I agree the DT property makes sense when the nINT pin is not connected
> > to the CPU. But if it is, then you have an issue that nINT will be
> > pulled low until the user changes the battery, meaning that you will
> > not get any alarm interrupt anymore, possibly leading to a system that
> > is not waking up anymore.
> 
> Ah, ok, thanks for the info. 
> I know this, but in our specific case, this is not a problem,
> since we don't use the nINT for other purposes, but only for
> a battery low indicator. On the contrary, in our case, it's better
> that the alarm signal remains low until the battery is changed.
> 
> Anyway, I can specify this collateral effect in a specific file for the
> Pcf2127 in the DT bindings Documentation. What do you think?
> 

This is fine as-is, I'll handle that in my series adding alarm support
because there will be no issues until then.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
