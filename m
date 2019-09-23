Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EB7CC3A5A6
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 09:18:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF19E2064A
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 09:18:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406258AbfIWJSI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 05:18:08 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:51197 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727358AbfIWJSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 05:18:07 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1iCKTc-0005wP-Px; Mon, 23 Sep 2019 11:17:48 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1iCKTZ-0001wK-TP; Mon, 23 Sep 2019 11:17:45 +0200
Date:   Mon, 23 Sep 2019 11:17:45 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Russell King <linux@armlinux.org.uk>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH 1/4] pwm: mxs: implement ->apply
Message-ID: <20190923091745.ehvz4zi2riyanmug@pengutronix.de>
References: <20190923081348.6843-1-linux@rasmusvillemoes.dk>
 <20190923081348.6843-2-linux@rasmusvillemoes.dk>
 <20190923082459.huqpbz5eseonkscv@pengutronix.de>
 <a6407644-0b5b-ba46-9435-0d14be9066a5@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a6407644-0b5b-ba46-9435-0d14be9066a5@rasmusvillemoes.dk>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

[expanded the recipents to include RMK and the clk list]

On Mon, Sep 23, 2019 at 11:04:39AM +0200, Rasmus Villemoes wrote:
> On 23/09/2019 10.24, Uwe Kleine-König wrote:
> > Also there is a bug already in .config: You are not supposed to call
> > clk_get_rate if the clk might be off.
> 
> Interesting, I didn't know that. So the prepare_enable logic needs to be
> moved before we start computing the period/duty cycles. Do you know why
> it has apparently worked so far? I would have thought such a rule would
> be enforced by the clock framework, or at least produced a warning.

FTR: This is documented in the kerneldoc code comment to clk_get_rate in
include/linux/clk.h.

Assuming this is relevant, it might indeed make sense to add a
WARN_ONCE for this.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
