Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5AA6C3A5A7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 20:30:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8732122CED
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 20:30:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbfICUak (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 16:30:40 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:38248 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbfICUak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 16:30:40 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id E3DD480F8A; Tue,  3 Sep 2019 22:30:23 +0200 (CEST)
Date:   Tue, 3 Sep 2019 22:30:36 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Akinobu Mita <akinobu.mita@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        linux-leds@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Dan Murphy <dmurphy@ti.com>
Subject: Re: [PATCH] leds: remove PAGE_SIZE limit of
 /sys/class/leds/<led>/trigger
Message-ID: <20190903203036.GA923@bug>
References: <1567090164-6819-1-git-send-email-akinobu.mita@gmail.com>
 <6ebeedab-4a7f-14ea-d62e-9184e911047f@gmail.com>
 <20190902181207.GA18577@kroah.com>
 <1cd468a3-b6e5-a93b-739a-f30288318356@gmail.com>
 <20190902190843.GB25019@kroah.com>
 <CAC5umyjTJSMdKMtZbF8Uxky6nOrAHesTHmZRV5VA1uPwX2rtxA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAC5umyjTJSMdKMtZbF8Uxky6nOrAHesTHmZRV5VA1uPwX2rtxA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Also, you all didn't document the heck out of this.  So no, I really do
> > not want to see this patch accepted as-is.
> >
> > > Provided that will be fixed, can we count on your ack for the
> > > implementation of the solution you proposed? :-)
> >
> > Let's see the patch that actually implements what I suggested first :)
> 
> I'd propose introducing a new procfs file (/proc/led-triggers) and new
> /sys/class/leds/<led>/current-trigger api.

No.

Your patch is good, it just needs adding comment:
 /* It was stupid to create 10000 cpu triggers, but we are
stuck with it now. Don't make that mistake again. We work around it here by creating binary
attribute, which is not limited by length. This is _not_ good design, do not copy it. */

Best regards,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
