Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7AC2C4CECF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 20:19:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9F62205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 20:19:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502505AbfIWUTl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 16:19:41 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:35551 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728647AbfIWUTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 16:19:41 -0400
X-Originating-IP: 90.65.161.137
Received: from localhost (lfbn-1-1545-137.w90-65.abo.wanadoo.fr [90.65.161.137])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 08151C0009;
        Mon, 23 Sep 2019 20:19:38 +0000 (UTC)
Date:   Mon, 23 Sep 2019 22:19:38 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Nick Crews <ncrews@chromium.org>
Cc:     Pavel Machek <pavel@ucw.cz>, Benson Leung <bleung@chromium.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Duncan Laurie <dlaurie@chromium.org>
Subject: Re: [PATCH v2 1/2] rtc: wilco-ec: Remove yday and wday calculations
Message-ID: <20190923201938.GB4141@piout.net>
References: <20190916181215.501-1-ncrews@chromium.org>
 <20190922161306.GA1999@bug>
 <20190922190542.GC3185@piout.net>
 <CAHX4x876iDn_6Q1+p1SNMncHJezSUQysfM+py0gjD2ytMKBj=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHX4x876iDn_6Q1+p1SNMncHJezSUQysfM+py0gjD2ytMKBj=w@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/09/2019 11:20:42-0600, Nick Crews wrote:
> > This is coming from struct tm, it is part of C89 but I think I was not
> > born when this decision was made. man rtc properly reports that those
> > fields are unused and no userspace tools are actually making use of
> > them. Nobody cares about the broken down representation of the time.
> > What is done is use the ioctl then mktime to have a UNIX timestamp.
> >
> > "The mktime function ignores the specified contents of the tm_wday,
> > tm_yday, tm_gmtoff, and tm_zone members of the broken-down time
> > structure. It uses the values of the other components to determine the
> > calendar time; it’s permissible for these components to have
> > unnormalized values outside their normal ranges. The last thing that
> > mktime does is adjust the components of the brokentime structure,
> > including the members that were initially ignored."
> 
> This is very non-obvious and I only knew this from talking to you,
> Alexandre. Perhaps we should add this note to the RTC core,
> such as in the description for rtc_class_ops?
> 

I'm planning to add documentation on what should be done in an RTC
driver, I'll ensure to add something on this topic.

> For this patch, do you want me to make any further changes?
> 

No need for any changes, however, I can't apply it right now because we
are in the middle of the merge window.


-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
