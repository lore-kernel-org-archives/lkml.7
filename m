Return-Path: <SRS0=Z/Yg=ZW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 178AEC432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 15:27:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBC032072C
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 15:27:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbfK3P1O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Nov 2019 10:27:14 -0500
Received: from verein.lst.de ([213.95.11.211]:60500 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726385AbfK3P1N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Nov 2019 10:27:13 -0500
Received: by verein.lst.de (Postfix, from userid 107)
        id C1C4768C4E; Sat, 30 Nov 2019 16:27:11 +0100 (CET)
Received: from lst.de (p5B0D82C7.dip0.t-ipconnect.de [91.13.130.199])
        by verein.lst.de (Postfix) with ESMTPSA id C31D667329;
        Sat, 30 Nov 2019 16:27:06 +0100 (CET)
Date:   Sat, 30 Nov 2019 16:27:00 +0100
From:   Torsten Duwe <duwe@lst.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] regulator: Defer init completion for a while after
 late_initcall
Message-ID: <20191130152700.GA14121@lst.de>
References: <20190904124250.25844-1-broonie@kernel.org>
 <20191116125233.GA5570@lst.de>
 <20191118124654.GD9761@sirena.org.uk>
 <20191118164101.GA7894@lst.de>
 <20191118165651.GK9761@sirena.org.uk>
 <20191118194012.GB7894@lst.de>
 <20191118202949.GD43585@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191118202949.GD43585@sirena.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 18, 2019 at 08:29:49PM +0000, Mark Brown wrote:
> On Mon, Nov 18, 2019 at 08:40:12PM +0100, Torsten Duwe wrote:
> 
> > kernel: anx6345 0-0038: 0-0038 supply dvdd12-supply not found, using dummy regulator
> > kernel: anx6345 0-0038: 0-0038 supply dvdd25-supply not found, using dummy regulator
> 
> > DT has:
> >   dvdd25-supply = <&reg_dldo2>;
> >   dvdd12-supply = <&reg_dldo3>;

Note these 4 lines...

> > It's only that the regulator driver module has not fully loaded at that point.
> 
> We substitute in the dummy regulator in regulator_get() if
> regulator_dev_lookup() returns -ENODEV and a few other conditions are
> satisfied.  When lookup up via DT regulator_dev_lookup() will use
> of_find_regulator_by_node() to look up the regulator, if that lookup
> fails it returns -EPROBE_DEFER.  Until we get to of_find_regulator_by_node()
> we're just looking to see if nodes exist, not to see if anything is
> registered.  What mechanism do you see causing issues?  If there's
> something going wrong here it's in that area.

First of all: thanks a lot! This has put me onto the right track.

> As far as I can tell whatever is going on with your system it's only
> ever been working through luck.

Yes indeed. It turned out the regulators were still on from U-Boot
and that code never worked.

>   Without any specific references to
> what's going on in the system it's hard to tell what might be happening,

Well, actually the 4 lines above give a good hint :) of_get_regulator()
will look for "dvdd25-supply-supply". I'm fairly relieved that even you
didn't spot this right away. The fix just went to dri-devel, you're Cc'ed.
Unfortunately the documentation for this is buried in the git commit log.

For the record: I'm still convinced that the original change can uncover
bugs unexpectedly, and is not suited for -stable.

Thanks for the help, and sorry for the non-standard nomenclature.

	Torsten

