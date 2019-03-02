Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E54C1C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 13:48:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEFF220838
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 13:48:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbfCBNsa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Mar 2019 08:48:30 -0500
Received: from sauhun.de ([88.99.104.3]:36324 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726119AbfCBNrr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Mar 2019 08:47:47 -0500
Received: from localhost (p54B33179.dip0.t-ipconnect.de [84.179.49.121])
        by pokefinder.org (Postfix) with ESMTPSA id D8C6B4A1776;
        Sat,  2 Mar 2019 14:47:44 +0100 (CET)
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
Subject: [RFC PATCH v2 3/7] i2c: core: introduce callbacks for atomic transfers
Date:   Sat,  2 Mar 2019 14:47:31 +0100
Message-Id: <20190302134735.4393-4-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190302134735.4393-1-wsa+renesas@sang-engineering.com>
References: <20190302134735.4393-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We had the request to access devices very late when interrupts are not
available anymore multiple times now. Mostly to prepare shutdown or
reboot. Allow adapters to specify a specific callback for this case.
Note that we fall back to the generic {master|smbus}_xfer callback if
this new atomic one is not present. This is intentional to preserve the
previous behaviour and avoid regressions. Because there are drivers not
using interrupts or because it might have worked "accidently" before.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/i2c-core-base.c  |  6 +++++-
 drivers/i2c/i2c-core-smbus.c | 18 ++++++++++++++----
 drivers/i2c/i2c-core.h       |  7 +++++--
 include/linux/i2c.h          | 15 ++++++++++++---
 4 files changed, 36 insertions(+), 10 deletions(-)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 004f8a3b6365..2127dd08ff01 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -1890,7 +1890,11 @@ int __i2c_transfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 	/* Retry automatically on arbitration loss */
 	orig_jiffies = jiffies;
 	for (ret = 0, try = 0; try <= adap->retries; try++) {
-		ret = adap->algo->master_xfer(adap, msgs, num);
+		if ((in_atomic() || irqs_disabled()) && adap->algo->master_xfer_atomic)
+			ret = adap->algo->master_xfer_atomic(adap, msgs, num);
+		else
+			ret = adap->algo->master_xfer(adap, msgs, num);
+
 		if (ret != -EAGAIN)
 			break;
 		if (time_after(jiffies, orig_jiffies + adap->timeout))
diff --git a/drivers/i2c/i2c-core-smbus.c b/drivers/i2c/i2c-core-smbus.c
index 357e083e8f45..e01a548fc559 100644
--- a/drivers/i2c/i2c-core-smbus.c
+++ b/drivers/i2c/i2c-core-smbus.c
@@ -548,6 +548,9 @@ s32 __i2c_smbus_xfer(struct i2c_adapter *adapter, u16 addr,
 		     unsigned short flags, char read_write,
 		     u8 command, int protocol, union i2c_smbus_data *data)
 {
+	int (*xfer_func)(struct i2c_adapter *adap, u16 addr,
+			 unsigned short flags, char read_write,
+			 u8 command, int size, union i2c_smbus_data *data);
 	unsigned long orig_jiffies;
 	int try;
 	s32 res;
@@ -562,13 +565,20 @@ s32 __i2c_smbus_xfer(struct i2c_adapter *adapter, u16 addr,
 
 	flags &= I2C_M_TEN | I2C_CLIENT_PEC | I2C_CLIENT_SCCB;
 
-	if (adapter->algo->smbus_xfer) {
+	xfer_func = adapter->algo->smbus_xfer;
+	if (in_atomic() || irqs_disabled()) {
+		if (adapter->algo->smbus_xfer_atomic)
+			xfer_func = adapter->algo->smbus_xfer_atomic;
+		else if (adapter->algo->master_xfer_atomic)
+			xfer_func = NULL; /* fallback to I2C emulation */
+	}
+
+	if (xfer_func) {
 		/* Retry automatically on arbitration loss */
 		orig_jiffies = jiffies;
 		for (res = 0, try = 0; try <= adapter->retries; try++) {
-			res = adapter->algo->smbus_xfer(adapter, addr, flags,
-							read_write, command,
-							protocol, data);
+			res = xfer_func(adapter, addr, flags, read_write,
+					command, protocol, data);
 			if (res != -EAGAIN)
 				break;
 			if (time_after(jiffies,
diff --git a/drivers/i2c/i2c-core.h b/drivers/i2c/i2c-core.h
index 6e98aa811980..01a6cb9b53aa 100644
--- a/drivers/i2c/i2c-core.h
+++ b/drivers/i2c/i2c-core.h
@@ -33,10 +33,13 @@ static inline int __i2c_lock_bus_helper(struct i2c_adapter *adap)
 {
 	int ret = 0;
 
-	if (in_atomic() || irqs_disabled())
+	if (in_atomic() || irqs_disabled()) {
+		WARN(!adap->algo->master_xfer_atomic && !adap->algo->smbus_xfer_atomic,
+		     "No atomic I2C transfer handler for '%s'\n", dev_name(&adap->dev));
 		ret = i2c_trylock_bus(adap, I2C_LOCK_SEGMENT) ? 0 : -EAGAIN;
-	else
+	} else {
 		i2c_lock_bus(adap, I2C_LOCK_SEGMENT);
+	}
 
 	return ret;
 }
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 758a6db864c9..3cd921dd39e3 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -499,9 +499,13 @@ i2c_register_board_info(int busnum, struct i2c_board_info const *info,
  * @master_xfer: Issue a set of i2c transactions to the given I2C adapter
  *   defined by the msgs array, with num messages available to transfer via
  *   the adapter specified by adap.
+ * @master_xfer_atomic: same as @master_xfer. Yet, only using atomic context
+ *   so e.g. PMICs can be accessed very late before shutdown. Optional.
  * @smbus_xfer: Issue smbus transactions to the given I2C adapter. If this
  *   is not present, then the bus layer will try and convert the SMBus calls
  *   into I2C transfers instead.
+ * @smbus_xfer_atomic: same as @smbus_xfer. Yet, only using atomic context
+ *   so e.g. PMICs can be accessed very late before shutdown. Optional.
  * @functionality: Return the flags that this algorithm/adapter pair supports
  *   from the I2C_FUNC_* flags.
  * @reg_slave: Register given client to I2C slave mode of this adapter
@@ -512,9 +516,9 @@ i2c_register_board_info(int busnum, struct i2c_board_info const *info,
  * be addressed using the same bus algorithms - i.e. bit-banging or the PCF8584
  * to name two of the most common.
  *
- * The return codes from the @master_xfer field should indicate the type of
- * error code that occurred during the transfer, as documented in the kernel
- * Documentation file Documentation/i2c/fault-codes.
+ * The return codes from the @master_xfer{_atomic} field should indicate the
+ * type of error code that occurred during the transfer, as documented in the
+ * Kernel Documentation file Documentation/i2c/fault-codes.
  */
 struct i2c_algorithm {
 	/*
@@ -528,9 +532,14 @@ struct i2c_algorithm {
 	 */
 	int (*master_xfer)(struct i2c_adapter *adap, struct i2c_msg *msgs,
 			   int num);
+	int (*master_xfer_atomic)(struct i2c_adapter *adap,
+				   struct i2c_msg *msgs, int num);
 	int (*smbus_xfer)(struct i2c_adapter *adap, u16 addr,
 			  unsigned short flags, char read_write,
 			  u8 command, int size, union i2c_smbus_data *data);
+	int (*smbus_xfer_atomic)(struct i2c_adapter *adap, u16 addr,
+				 unsigned short flags, char read_write,
+				 u8 command, int size, union i2c_smbus_data *data);
 
 	/* To determine what the adapter supports */
 	u32 (*functionality)(struct i2c_adapter *adap);
-- 
2.11.0

