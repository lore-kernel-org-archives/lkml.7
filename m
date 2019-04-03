Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3907FC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 12:41:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E5342147C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 12:41:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727525AbfDCMlf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 08:41:35 -0400
Received: from sauhun.de ([88.99.104.3]:48338 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726206AbfDCMki (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 08:40:38 -0400
Received: from localhost (p54B3311F.dip0.t-ipconnect.de [84.179.49.31])
        by pokefinder.org (Postfix) with ESMTPSA id A70173E43CB;
        Wed,  3 Apr 2019 14:40:36 +0200 (CEST)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-i2c@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Peter Rosin <peda@axentia.se>,
        Stefan Lengfeld <contact@stefanchrist.eu>,
        linux-omap@vger.kernel.org, linux-tegra@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 04/12] i2c: mux: populate the new *_atomic callbacks
Date:   Wed,  3 Apr 2019 14:40:11 +0200
Message-Id: <20190403124019.8947-5-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190403124019.8947-1-wsa+renesas@sang-engineering.com>
References: <20190403124019.8947-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the parent adapter has atomic_xfer callbacks, populate them for the
mux adapter as well. We can use the same translation function as for the
non-atomic xfer callback.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/i2c-mux.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/i2c/i2c-mux.c b/drivers/i2c/i2c-mux.c
index f330690b4125..603252fa1284 100644
--- a/drivers/i2c/i2c-mux.c
+++ b/drivers/i2c/i2c-mux.c
@@ -310,12 +310,18 @@ int i2c_mux_add_adapter(struct i2c_mux_core *muxc,
 		else
 			priv->algo.master_xfer = __i2c_mux_master_xfer;
 	}
+	if (parent->algo->master_xfer_atomic)
+		priv->algo.master_xfer_atomic = priv->algo.master_xfer;
+
 	if (parent->algo->smbus_xfer) {
 		if (muxc->mux_locked)
 			priv->algo.smbus_xfer = i2c_mux_smbus_xfer;
 		else
 			priv->algo.smbus_xfer = __i2c_mux_smbus_xfer;
 	}
+	if (parent->algo->smbus_xfer_atomic)
+		priv->algo.smbus_xfer_atomic = priv->algo.smbus_xfer;
+
 	priv->algo.functionality = i2c_mux_functionality;
 
 	/* Now fill out new adapter structure */
-- 
2.11.0

