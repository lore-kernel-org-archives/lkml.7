Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 761AFC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 12:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49BFE2084C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 12:40:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbfDCMkh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 08:40:37 -0400
Received: from sauhun.de ([88.99.104.3]:48284 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726206AbfDCMkg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 08:40:36 -0400
Received: from localhost (p54B3311F.dip0.t-ipconnect.de [84.179.49.31])
        by pokefinder.org (Postfix) with ESMTPSA id F11803E604C;
        Wed,  3 Apr 2019 14:40:34 +0200 (CEST)
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
Subject: [PATCH 01/12] i2c: remove use of in_atomic()
Date:   Wed,  3 Apr 2019 14:40:08 +0200
Message-Id: <20190403124019.8947-2-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190403124019.8947-1-wsa+renesas@sang-engineering.com>
References: <20190403124019.8947-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit cea443a81c9c ("i2c: Support i2c_transfer in atomic contexts")
added in_atomic() to the I2C core. However, the use of in_atomic()
outside of core kernel code is discouraged and was already[1] when this
code was added in early 2008. The above commit was a preparation for
commit b7a3670131c7 ("i2c-pxa: Add polling transfer"). Its commit
message says explicitly it was added "for cases where I2C transactions
have to occur at times interrup[t]s are disabled". So, the intention was
'disabled interrupts'. This matches the use cases for atomic I2C
transfers I have seen so far: very late communication (mostly to a PMIC)
to powerdown or reboot the system. For those cases, interrupts are
disabled then. It doesn't seem that in_atomic() adds value.

After a discussion with Peter Zijlstra[2], we came up with a better set
of conditionals to match the use case.

The I2C core will soon gain an extra callback into bus drivers
especially for atomic transfers to make them more generic. The code
deciding which transfer to use (atomic/non-atomic) should mimic the
behaviour which locking to use (trylock/lock). This is why we add a
helper for it.

[1] https://lwn.net/Articles/274695/
[2] http://patchwork.ozlabs.org/patch/1067437/

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/i2c-core-base.c |  2 +-
 drivers/i2c/i2c-core.h      | 10 ++++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 38af18645133..f8502064cd6b 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -1946,7 +1946,7 @@ int i2c_transfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 	 *    one (discarding status on the second message) or errno
 	 *    (discarding status on the first one).
 	 */
-	if (in_atomic() || irqs_disabled()) {
+	if (i2c_in_atomic_xfer_mode()) {
 		ret = i2c_trylock_bus(adap, I2C_LOCK_SEGMENT);
 		if (!ret)
 			/* I2C activity is ongoing. */
diff --git a/drivers/i2c/i2c-core.h b/drivers/i2c/i2c-core.h
index 37576f50fe20..9d8526415b26 100644
--- a/drivers/i2c/i2c-core.h
+++ b/drivers/i2c/i2c-core.h
@@ -29,6 +29,16 @@ extern int		__i2c_first_dynamic_bus_num;
 
 int i2c_check_7bit_addr_validity_strict(unsigned short addr);
 
+/*
+ * We only allow atomic transfers for very late communication, e.g. to send
+ * the powerdown command to a PMIC. Atomic transfers are a corner case and not
+ * for generic use!
+ */
+static inline bool i2c_in_atomic_xfer_mode(void)
+{
+	return system_state > SYSTEM_RUNNING && irqs_disabled();
+}
+
 #ifdef CONFIG_ACPI
 const struct acpi_device_id *
 i2c_acpi_match_device(const struct acpi_device_id *matches,
-- 
2.11.0

