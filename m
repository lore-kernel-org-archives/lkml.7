Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 706B3C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 13:36:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53EE720728
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 13:36:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727567AbfKONgb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 08:36:31 -0500
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:51689 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727329AbfKONg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 08:36:29 -0500
X-Originating-IP: 90.66.177.178
Received: from localhost (lfbn-1-2888-178.w90-66.abo.wanadoo.fr [90.66.177.178])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 07B40FF80D;
        Fri, 15 Nov 2019 13:36:27 +0000 (UTC)
Date:   Fri, 15 Nov 2019 14:36:27 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Steve Muckle <smuckle@google.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH] rtc: class: support hctosys from modular RTC drivers
Message-ID: <20191115133627.GT3572@piout.net>
References: <20191106194625.116692-1-smuckle@google.com>
 <20191106231923.GK8309@piout.net>
 <b96f085b-8a0c-7c71-4fde-8af83d49823a@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b96f085b-8a0c-7c71-4fde-8af83d49823a@google.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/11/2019 15:37:49-0800, Steve Muckle wrote:
> On 11/6/19 3:19 PM, Alexandre Belloni wrote:
> > On 06/11/2019 11:46:25-0800, Steve Muckle wrote:
> > > Due to distribution constraints it may not be possible to statically
> > > compile the required RTC driver into the kernel.
> > > 
> > > Expand RTC_HCTOSYS support to cover all RTC devices (statically compiled
> > > or not) by checking at the end of RTC device registration whether the
> > > time should be synced.
> > > 
> > 
> > This does not really help distributions because most of them will still
> > have "rtc0" hardcoded and rtc0 is often the rtc that shouldn't be used.
> 
> Just for my own edification, why is that? Is rtc0 normally useless on PC for
> some reason?
> 

On PC, rtc0 is probably fine which is not the case for other
architectures where rtc0 is the SoC RTC and is often not battery backed.

> On the platforms I'm working with I believe it can be assured that rtc0 will
> be the correct rtc. That doesn't help typical distributions though.
> 
> What about a kernel parameter to optionally override the rtc hctosys device
> at runtime?
> 

What about keeping that in userspace instead which is way easier than
messing with kernel parameters?

> > Can't you move away from HCTOSYS and do the correct thing in userspace
> > instead of the crap hctosys is doing?
> 
> Yes, I just figured it's a small change, and if hctosys can be made to work
> might as well use that.

The fact is that hctosys is more related to time keeping than it is to
the RTC subsytem. It also does a very poor job setting the system time
because adding 0.5s is not the smartest thing to do. The rtc granularity
is indeed 1 second but is can be very precisely set.


-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
