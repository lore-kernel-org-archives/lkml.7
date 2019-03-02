Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D34C8C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 13:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95D0120838
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 13:48:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbfCBNsi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Mar 2019 08:48:38 -0500
Received: from sauhun.de ([88.99.104.3]:36354 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726220AbfCBNrr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Mar 2019 08:47:47 -0500
Received: from localhost (p54B33179.dip0.t-ipconnect.de [84.179.49.121])
        by pokefinder.org (Postfix) with ESMTPSA id 690714A1777;
        Sat,  2 Mar 2019 14:47:45 +0100 (CET)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-i2c@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Keerthy <j-keerthy@ti.com>,
        Peter Rosin <peda@axentia.se>,
        Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Stefan Lengfeld <contact@stefanchrist.eu>,
        Phil Reid <preid@electromag.com.au>,
        Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org,
        linux-tegra@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [RFC PATCH v2 4/7] i2c: demux: WIP: handle the new atomic callbacks
Date:   Sat,  2 Mar 2019 14:47:32 +0100
Message-Id: <20190302134735.4393-5-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190302134735.4393-1-wsa+renesas@sang-engineering.com>
References: <20190302134735.4393-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the parent has an atomic callback, we need to translate it the same
way as the non-atomic callback.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/muxes/i2c-demux-pinctrl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/i2c/muxes/i2c-demux-pinctrl.c b/drivers/i2c/muxes/i2c-demux-pinctrl.c
index 035032e20327..5d00adfbe578 100644
--- a/drivers/i2c/muxes/i2c-demux-pinctrl.c
+++ b/drivers/i2c/muxes/i2c-demux-pinctrl.c
@@ -99,6 +99,9 @@ static int i2c_demux_activate_master(struct i2c_demux_pinctrl_priv *priv, u32 ne
 
 	/* Now fill out current adapter structure. cur_chan must be up to date */
 	priv->algo.master_xfer = i2c_demux_master_xfer;
+	/* FIXME: regular muxes need proper handling, too! */
+	if (adap->algo->master_xfer_atomic)
+		priv->algo.master_xfer_atomic = i2c_demux_master_xfer;
 	priv->algo.functionality = i2c_demux_functionality;
 
 	snprintf(priv->cur_adap.name, sizeof(priv->cur_adap.name),
-- 
2.11.0

