Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E351CA9EB0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 17:48:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61CD82064B
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 17:48:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729238AbfJURsN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 13:48:13 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:47583 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbfJURsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 13:48:12 -0400
X-Originating-IP: 86.202.229.42
Received: from localhost (lfbn-lyo-1-146-42.w86-202.abo.wanadoo.fr [86.202.229.42])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id EACD7240006;
        Mon, 21 Oct 2019 17:48:09 +0000 (UTC)
Date:   Mon, 21 Oct 2019 19:48:09 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Brian Norris <briannorris@chromium.org>
Cc:     Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH] rtc: report time-retrieval errors when updating alarm
Message-ID: <20191021174809.GA3125@piout.net>
References: <20180521164222.149896-1-briannorris@chromium.org>
 <20191021161113.GZ3125@piout.net>
 <CA+ASDXOXSKoRcuRWZ1FGNcioFKSiazXGxOvMv5=px_pn46vJbw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+ASDXOXSKoRcuRWZ1FGNcioFKSiazXGxOvMv5=px_pn46vJbw@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/10/2019 10:20:08-0700, Brian Norris wrote:
> Hi Alexandre!
> 
> On Mon, Oct 21, 2019 at 9:11 AM Alexandre Belloni
> <alexandre.belloni@bootlin.com> wrote:
> > On 21/05/2018 09:42:22-0700, Brian Norris wrote:
> > > __rtc_read_time() can fail (e.g., if the RTC uses an unreliable medium).
> > > When it does, we don't report the error, but instead calculate a
> > > 1-second alarm based on the potentially-garbage 'tm' (in practice,
> > > __rtc_read_time() zeroes out the time first, so it's likely to still be
> > > all 0).
> > >
> > > Let's propagate the error instead.
> > >
> >
> > I submitted
> > https://lore.kernel.org/linux-rtc/20191021155631.3342-2-alexandre.belloni@bootlin.com/T/#u
> > to solve this after looking at all the implication checking the return
> > value of __rtc_read_time had.
> 
> Only about a year and a half late, nice!

I know, right? :) The fact is that this is not a common issue or at
least, I didn't have any report that this was causing real problems in
the field. So it ended up being one of the longest standing patch in
patchwork...

>Fortunately we have a decent
> (albeit time-consuming) process for rebasing our downstream patches in
> Chrome OS kernels...
> 

Do you need that patch backported to LTS kernels?


-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
