Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58593C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 10:39:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FA492072B
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 10:39:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbfLRKji (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 05:39:38 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:48621 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbfLRKji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 05:39:38 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ihWjt-0007gZ-Dl; Wed, 18 Dec 2019 11:39:33 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1ihWjr-0004Ql-MS; Wed, 18 Dec 2019 11:39:31 +0100
Date:   Wed, 18 Dec 2019 11:39:31 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Johan Hovold <johan@kernel.org>
Cc:     Rob Herring <robh@kernel.org>, kbuild test robot <lkp@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        Jiri Slaby <jslaby@suse.com>
Subject: Re: [PATCH] serdev: fix builds with CONFIG_SERIAL_DEV_BUS=m
Message-ID: <20191218103931.kgytwzt6cc75iuud@pengutronix.de>
References: <201912181000.82Z7czbN%lkp@intel.com>
 <20191218083842.14882-1-u.kleine-koenig@pengutronix.de>
 <20191218090606.GJ22665@localhost>
 <20191218092958.tu6n452zwbpkreks@pengutronix.de>
 <20191218093806.GK22665@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191218093806.GK22665@localhost>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Johan,

On Wed, Dec 18, 2019 at 10:38:06AM +0100, Johan Hovold wrote:
> On Wed, Dec 18, 2019 at 10:29:58AM +0100, Uwe Kleine-König wrote:
> > On Wed, Dec 18, 2019 at 10:06:06AM +0100, Johan Hovold wrote:
> > > On Wed, Dec 18, 2019 at 09:38:42AM +0100, Uwe Kleine-König wrote:
> > > > Commit 54edb425346a ("serdev: simplify Makefile") broke builds with
> > > > serdev configured as module. I don't understand it completely yet, but
> > > > it seems that
> > > > 
> > > > 	obj-$(CONFIG_SERIAL_DEV_BUS) += serdev/
> > > > 
> > > > in drivers/tty/Makefile with CONFIG_SERIAL_DEV_BUS=m doesn't result in
> > > > code that is added using obj-y in drivers/tty/serdev/Makefile being
> > > > compiled. So instead of dropping $(CONFIG_SERIAL_DEV_BUS) in serdev's
> > > > Makefile, drop it in drivers/tty/Makefile.
> > > 
> > > Why not simply revert the offending patch? There are some dependencies
> > > here related to how the tty layer is built. If you're still not certain
> > > on why things broke, I suggest just reverting for now.
> > 
> > I see that it is not easy to define what obj-y should do in a Makefile
> > that is included via obj-m. Now it is the other way round and that
> > should be safe. This construct is used in several places, so I'd say the
> > patch is fine unless you have more concrete concerns.
> 
> No, and I don't have time to look into this right now.
> 
> It's more about the general principle that a patch should do one thing;

IMHO it does one thing: It does what 54edb425346a intended to do in the
right way.

But I don't feel strong here. If you prefer to revert, that's ok, too.
Not sure I will find the motivation then, to reimplement the
cleanup, though.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
