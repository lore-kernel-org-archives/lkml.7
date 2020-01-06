Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 776CEC33C9E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 15:52:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 577AE24677
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 15:52:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbgAFPwQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 10:52:16 -0500
Received: from honk.sigxcpu.org ([24.134.29.49]:41292 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726508AbgAFPwQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 10:52:16 -0500
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 4A4D1FB03;
        Mon,  6 Jan 2020 16:52:13 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id sImuiCrcHRMc; Mon,  6 Jan 2020 16:52:11 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 7681549D3D; Mon,  6 Jan 2020 16:52:11 +0100 (CET)
Date:   Mon, 6 Jan 2020 16:52:11 +0100
From:   Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the leds tree
Message-ID: <20200106155211.GA30225@bogon.m.sigxcpu.org>
References: <20200106142116.538320e1@canb.auug.org.au>
 <20200106093129.GA13043@bogon.m.sigxcpu.org>
 <20200106103233.GA32426@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200106103233.GA32426@amd>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Mon, Jan 06, 2020 at 11:32:33AM +0100, Pavel Machek wrote:
> Hi!
> 
> > > After merging the leds tree, today's linux-next build (x86_64
> > > allmodconfig) failed like this:
> > > 
> > > drivers/leds/leds-lm3692x.c: In function 'lm3692x_max_brightness':
> > > drivers/leds/leds-lm3692x.c:355:9: error: 'struct lm3692x_led' has no member named 'brightness_ctrl'
> > >   355 |  if (led->brightness_ctrl & LM3692X_MAP_MODE_EXP) {
> > >       |         ^~
> > 
> > That's a result of a patch from the mid of the series not being applied.
> > 'leds: lm3692x: Allow to configure brigthness mode' introduces that
> > struct member.
> > 
> > > drivers/leds/leds-lm3692x.c: In function 'lm3692x_probe_dt':
> > > drivers/leds/leds-lm3692x.c:437:61: error: 'max_cur' undeclared (first use in this function)
> > >   437 |  ret = fwnode_property_read_u32(child, "led-max-microamp", &max_cur);
> > >       |                                                             ^~~~~~~
> > 
> > That somehow got lost during merge of this commit:
> > 
> >     https://lore.kernel.org/linux-leds/5826b77d42521595e93d01d53475a8881cad1875.1578134779.git.agx@sigxcpu.org/T/#u
> > 
> > Pavel, shall i send a patch to fix that up or should we rather try to
> > get the rest of the series in in the right order? Resetting linux-next
> > back to cffd61a5c7755546154539dcd7f36590e91e002f for the moment?
> 
> I kept just three patches from the series, and pushed the result.
> 
> Could I get the rest of the series, minus the "exponential" stuff, on
> top of that?
> 
> Sorry for the confusion,

No problem, reshuffling stuff turned out to be simpler than expected:

     https://lore.kernel.org/linux-leds/cover.1578324703.git.agx@sigxcpu.org/T/#mbbbaabea8ebaba1f864d8a4211d9bcac780261aa

If you don't want the exponential mode setting just omit 5/6 and
6/6.

Cheers,
 -- Guido

> 
> 									Pavel
> -- 
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html


