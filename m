Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8A5DC4CECE
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 08:07:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9662720872
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 08:07:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408163AbfJQIHv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 04:07:51 -0400
Received: from smtp1.goneo.de ([85.220.129.30]:50424 "EHLO smtp1.goneo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727791AbfJQIHu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 04:07:50 -0400
Received: from localhost (localhost [127.0.0.1])
        by smtp1.goneo.de (Postfix) with ESMTP id B9F8623F130;
        Thu, 17 Oct 2019 10:07:47 +0200 (CEST)
X-Virus-Scanned: by goneo
Received: from smtp1.goneo.de ([127.0.0.1])
        by localhost (smtp1.goneo.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id PC-kkIo8vkqh; Thu, 17 Oct 2019 10:07:46 +0200 (CEST)
Received: from lem-wkst-02.lemonage (hq.lemonage.de [87.138.178.34])
        by smtp1.goneo.de (Postfix) with ESMTPSA id 0CCE023F38F;
        Thu, 17 Oct 2019 10:07:46 +0200 (CEST)
Date:   Thu, 17 Oct 2019 10:07:41 +0200
From:   Lars Poeschel <poeschel@lemonage.de>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Willy Tarreau <willy@haproxy.com>,
        Ksenija Stanojevic <ksenija.stanojevic@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 1/3] auxdisplay: Make charlcd.[ch] more general
Message-ID: <20191017080741.GA17556@lem-wkst-02.lemonage>
References: <20191016082430.5955-1-poeschel@lemonage.de>
 <CANiq72=uXWpEWHixM+wwyxZfzQ41WYvQsoV8B3+JLRharDjC0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72=uXWpEWHixM+wwyxZfzQ41WYvQsoV8B3+JLRharDjC0w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2019 at 06:53:20PM +0200, Miguel Ojeda wrote:
> On Wed, Oct 16, 2019 at 10:24 AM Lars Poeschel <poeschel@lemonage.de> wrote:
> >
> > charlcd.c contains lots of hd44780 hardware specific stuff. It is nearly
> > impossible to reuse the interface for other character based displays.
> > The current users of charlcd are the hd44780 and the panel drivers.
> > This does factor out the hd44780 specific stuff out of charlcd into a
> > new module called hd44780_common.
> > charlcd gets rid of the hd44780 specfics and more generally useable.
> > The hd44780 and panel drivers are modified to use the new
> > hd44780_common.
> > This is tested on a hd44780 connected through the gpios of a pcf8574.
> >
> > Signed-off-by: Lars Poeschel <poeschel@lemonage.de>
> > ---
> >  drivers/auxdisplay/Kconfig          |  16 +
> >  drivers/auxdisplay/Makefile         |   1 +
> >  drivers/auxdisplay/charlcd.c        | 591 ++++++++--------------------
> >  drivers/auxdisplay/charlcd.h        | 109 ++++-
> >  drivers/auxdisplay/hd44780.c        | 121 ++++--
> >  drivers/auxdisplay/hd44780_common.c | 370 +++++++++++++++++
> >  drivers/auxdisplay/hd44780_common.h |  32 ++
> >  drivers/auxdisplay/panel.c          | 178 ++++-----
> >  8 files changed, 851 insertions(+), 567 deletions(-)
> 
> Thanks Lars, CC'ing Geert since he wrote a large portion of this, as
> well as Andy.
> 
> From a cursory look (sorry, not doing it inline since it is a pain to
> edit in this UI given the size...):

I am okay with this. I know, what you are talking about, since I know
the code very well. But maybe it is a bit harder to follow for others.

>   * panel.c doesn't compile since lcd_backlight's return type did not
> get updated, which makes me uneasy. I am not sure why you changed the
> return type anyway, since callers ignore it and callees always return
> 0.

That panel.c doesn't compile is of course a no-go. Sorry. I missed
something and I will fix this in a next version of the patch. But before
submitting a next version, I will wait some time, if there is more
feedback.
The idea with changing the return types: It seems a bit, that with this
patch charlcd is becoming more of an universal interface and maybe more
display backends get added - maybe with displays, that can report
failure of operations. And I thought, it will be better to have this
earlier and have the "interface" stable and more uniform. But you are
the maintainer. If you don't like the changed return types I happily
revert back to the original ones in the next version of the patch.

>   * Declared and then immediately defined hd44780_common in the header...?

This is not intended. I'll change it.

>   * Some things (e.g. the addition of enums like charlcd_onoff) seem
> like could have been done other patches (since they are not really
> related to the reorganization).

I can split this out into separate patches. It'd be good know what else
you mean by "some things" so I can do this as well. Do you want each
enum as a separate patch or one big enum patch ?

>   * From checkpatch.pl: DOS line endings and trailing whitespace

Strange. I did indeed checkpatch.pl the patches before submitting and I
got no complaints about whitespace or line endings. There was "WARNING:
added, moved or deleted file(s), does MAINTAINERS need updating?" and
patch 1 also has "WARNING: please write a paragraph that describes the
config symbol fully". I submitted the patches with git send-email so it
is very unlikely, that the mailer messed up the patches. Strange...
Oh by the way: Do you know what I can do to make checkpatch happy with
its describing of the config symbol ? I tried writing a help paragraph
for the config symbols in Kconfig, but that did not help.

> I am not capable of testing this, so extra testing by anyone who has
> the different hardware affected around is very welcome.

Are you able to test the panel driver ?

Thank you for your prompt feedback!

Lars
