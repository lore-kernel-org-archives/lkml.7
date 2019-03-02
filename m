Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 676D6C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 13:48:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D01320838
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 13:48:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbfCBNsT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Mar 2019 08:48:19 -0500
Received: from sauhun.de ([88.99.104.3]:36374 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726384AbfCBNrs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Mar 2019 08:47:48 -0500
Received: from localhost (p54B33179.dip0.t-ipconnect.de [84.179.49.121])
        by pokefinder.org (Postfix) with ESMTPSA id 7AB254A177A;
        Sat,  2 Mar 2019 14:47:46 +0100 (CET)
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
Subject: [RFC PATCH v2 6/7] i2c: tegra-bpmp: convert to use new atomic callbacks
Date:   Sat,  2 Mar 2019 14:47:34 +0100
Message-Id: <20190302134735.4393-7-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190302134735.4393-1-wsa+renesas@sang-engineering.com>
References: <20190302134735.4393-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver did handle this internally, convert it to use the new
callbacks.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/i2c-tegra-bpmp.c | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-tegra-bpmp.c b/drivers/i2c/busses/i2c-tegra-bpmp.c
index f6cd35d0a2ac..02b78ba5b23b 100644
--- a/drivers/i2c/busses/i2c-tegra-bpmp.c
+++ b/drivers/i2c/busses/i2c-tegra-bpmp.c
@@ -207,7 +207,8 @@ static int tegra_bpmp_i2c_msg_len_check(struct i2c_msg *msgs, unsigned int num)
 
 static int tegra_bpmp_i2c_msg_xfer(struct tegra_bpmp_i2c *i2c,
 				   struct mrq_i2c_request *request,
-				   struct mrq_i2c_response *response)
+				   struct mrq_i2c_response *response,
+				   bool atomic)
 {
 	struct tegra_bpmp_message msg;
 	int err;
@@ -222,7 +223,7 @@ static int tegra_bpmp_i2c_msg_xfer(struct tegra_bpmp_i2c *i2c,
 	msg.rx.data = response;
 	msg.rx.size = sizeof(*response);
 
-	if (irqs_disabled())
+	if (atomic)
 		err = tegra_bpmp_transfer_atomic(i2c->bpmp, &msg);
 	else
 		err = tegra_bpmp_transfer(i2c->bpmp, &msg);
@@ -230,8 +231,9 @@ static int tegra_bpmp_i2c_msg_xfer(struct tegra_bpmp_i2c *i2c,
 	return err;
 }
 
-static int tegra_bpmp_i2c_xfer(struct i2c_adapter *adapter,
-			       struct i2c_msg *msgs, int num)
+static int tegra_bpmp_i2c_xfer_common(struct i2c_adapter *adapter,
+				      struct i2c_msg *msgs, int num,
+				      bool atomic)
 {
 	struct tegra_bpmp_i2c *i2c = i2c_get_adapdata(adapter);
 	struct mrq_i2c_response response;
@@ -253,7 +255,7 @@ static int tegra_bpmp_i2c_xfer(struct i2c_adapter *adapter,
 		return err;
 	}
 
-	err = tegra_bpmp_i2c_msg_xfer(i2c, &request, &response);
+	err = tegra_bpmp_i2c_msg_xfer(i2c, &request, &response, atomic);
 	if (err < 0) {
 		dev_err(i2c->dev, "failed to transfer message: %d\n", err);
 		return err;
@@ -268,6 +270,20 @@ static int tegra_bpmp_i2c_xfer(struct i2c_adapter *adapter,
 	return num;
 }
 
+static int tegra_bpmp_i2c_xfer(struct i2c_adapter *adapter,
+			       struct i2c_msg *msgs, int num)
+
+{
+	return tegra_bpmp_i2c_xfer_common(adapter, msgs, num, false);
+}
+
+static int tegra_bpmp_i2c_xfer_atomic(struct i2c_adapter *adapter,
+				      struct i2c_msg *msgs, int num)
+
+{
+	return tegra_bpmp_i2c_xfer_common(adapter, msgs, num, true);
+}
+
 static u32 tegra_bpmp_i2c_func(struct i2c_adapter *adapter)
 {
 	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL | I2C_FUNC_10BIT_ADDR |
@@ -276,6 +292,7 @@ static u32 tegra_bpmp_i2c_func(struct i2c_adapter *adapter)
 
 static const struct i2c_algorithm tegra_bpmp_i2c_algo = {
 	.master_xfer = tegra_bpmp_i2c_xfer,
+	.master_xfer_atomic = tegra_bpmp_i2c_xfer_atomic,
 	.functionality = tegra_bpmp_i2c_func,
 };
 
-- 
2.11.0

