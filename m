Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ADD2C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 09:30:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD76B21582
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 09:30:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbfLRJaH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 04:30:07 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:45591 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbfLRJaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 04:30:07 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ihVea-000702-Do; Wed, 18 Dec 2019 10:30:00 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1ihVeY-0000Ut-Ku; Wed, 18 Dec 2019 10:29:58 +0100
Date:   Wed, 18 Dec 2019 10:29:58 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Rob Herring <robh@kernel.org>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH] serdev: fix builds with CONFIG_SERIAL_DEV_BUS=m
Message-ID: <20191218092958.tu6n452zwbpkreks@pengutronix.de>
References: <201912181000.82Z7czbN%lkp@intel.com>
 <20191218083842.14882-1-u.kleine-koenig@pengutronix.de>
 <20191218090606.GJ22665@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191218090606.GJ22665@localhost>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 18, 2019 at 10:06:06AM +0100, Johan Hovold wrote:
> On Wed, Dec 18, 2019 at 09:38:42AM +0100, Uwe Kleine-König wrote:
> > Commit 54edb425346a ("serdev: simplify Makefile") broke builds with
> > serdev configured as module. I don't understand it completely yet, but
> > it seems that
> > 
> > 	obj-$(CONFIG_SERIAL_DEV_BUS) += serdev/
> > 
> > in drivers/tty/Makefile with CONFIG_SERIAL_DEV_BUS=m doesn't result in
> > code that is added using obj-y in drivers/tty/serdev/Makefile being
> > compiled. So instead of dropping $(CONFIG_SERIAL_DEV_BUS) in serdev's
> > Makefile, drop it in drivers/tty/Makefile.
> 
> Why not simply revert the offending patch? There are some dependencies
> here related to how the tty layer is built. If you're still not certain
> on why things broke, I suggest just reverting for now.

I see that it is not easy to define what obj-y should do in a Makefile
that is included via obj-m. Now it is the other way round and that
should be safe. This construct is used in several places, so I'd say the
patch is fine unless you have more concrete concerns.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
