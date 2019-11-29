Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBC0FC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 09:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94733215A5
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 09:11:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbfK2JL0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 04:11:26 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:38037 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726709AbfK2JL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 04:11:26 -0500
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1iacJ6-0003Rw-Em; Fri, 29 Nov 2019 10:11:20 +0100
Received: from mfe by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1iacJ5-0005iC-TE; Fri, 29 Nov 2019 10:11:19 +0100
Date:   Fri, 29 Nov 2019 10:11:19 +0100
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Support Opensource <support.opensource@diasemi.com>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, stwiss.opensource@diasemi.com,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>
Subject: Re: [PATCH v2 5/5] regulator: da9062: add gpio based regulator
 dis-/enable support
Message-ID: <20191129091119.wqwpr4jklj27hdfp@pengutronix.de>
References: <20191127135932.7223-1-m.felsch@pengutronix.de>
 <20191127135932.7223-6-m.felsch@pengutronix.de>
 <CACRpkdb9iXneW3BUj6RfODYnL7DwMwbGbPwXgQ4Z5YTj7MgGcw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdb9iXneW3BUj6RfODYnL7DwMwbGbPwXgQ4Z5YTj7MgGcw@mail.gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 10:09:27 up 14 days, 28 min, 29 users,  load average: 0.06, 0.05,
 0.00
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-11-29 09:25, Linus Walleij wrote:
> On Wed, Nov 27, 2019 at 2:59 PM Marco Felsch <m.felsch@pengutronix.de> wrote:
> 
> > Each regulator can be enabeld/disabled by the internal pmic state
> > machine or by a gpio input signal. Typically the OTP configures the
> > regulators to be enabled/disabled on a specific sequence number which is
> > most the time fine. Sometimes we need to reconfigure that due to a PCB
> > bug. This patch adds the support to disable/enable the regulator based
> > on a gpio input signal.
> >
> > Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> 
> Overall I think this is fine, it's a solid use case that need to be
> supported.
> 
> > +       struct reg_field ena_gpi;
> 
> Maybe just add some doc comment to this struct member?

Yes, I can do that.

> IIUC it is a general purpose input that can be configured
> such that it will enable one of the DA9062 regulators when
> asserted. (Correct?)

Yes that's correct.

Regards,
  Marco

> Yours,
> Linus Walleij
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
