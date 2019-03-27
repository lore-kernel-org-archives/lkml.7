Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9391C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 21:13:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D4A220700
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 21:13:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727604AbfC0VNW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 17:13:22 -0400
Received: from sauhun.de ([88.99.104.3]:38958 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726059AbfC0VNV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 17:13:21 -0400
Received: from localhost (p5486CE6B.dip0.t-ipconnect.de [84.134.206.107])
        by pokefinder.org (Postfix) with ESMTPSA id E72342E35A2;
        Wed, 27 Mar 2019 22:13:18 +0100 (CET)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-i2c@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [RFC PATCH] i2c: remove use of in_atomic()
Date:   Wed, 27 Mar 2019 22:12:56 +0100
Message-Id: <20190327211256.17232-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit cea443a81c9c ("i2c: Support i2c_transfer in atomic contexts")
added in_atomic() to the I2C core. However, the use of in_atomic()
outside of core kernel code is discouraged and was already[1] when this
code was added in early 2008. The above commit was a preparation for
b7a3670131c7 ("i2c-pxa: Add polling transfer"). Its commit message says
explicitly it was added "for cases where I2C transactions have to occur
at times interrups are disabled". So, the intention was 'disabled
interrupts'. This matches the use cases for atomic I2C transfers I have
seen so far: very late communication (mostly to a PMIC) to powerdown or
reboot the system. For those cases, interrupts are disabled then. It
doesn't seem that in_atomic() adds value.

Note that only ~10 out of ~120 bus master drivers support atomic
transfers, mostly by polling always when no irq is supplied. A generic
I2C client driver cannot assume support for atomic transfers. This is
currently a platform-dependent corner case.

The I2C core will soon gain an extra callback into bus drivers
especially for atomic transfers to make them more generic. The code
deciding which transfer to use (atomic/non-atomic) should mimic the
behaviour which locking to use (trylock/lock). Because I don't want to
add more in_atomic() to the I2C core, this patch simply removes it.

[1] https://lwn.net/Articles/274695/

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

So, I had to dive into this in_atomic() topic and this is what I
concluded. I don't see any reasonable constellation where this could
cause a regression, but I am all open for missing something and being
pointed to it. This is why the patch is RFC. I'd really welcome
comments. Thanks!


 drivers/i2c/i2c-core-base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 38af18645133..943bebeec3ed 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -1946,7 +1946,7 @@ int i2c_transfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 	 *    one (discarding status on the second message) or errno
 	 *    (discarding status on the first one).
 	 */
-	if (in_atomic() || irqs_disabled()) {
+	if (irqs_disabled()) {
 		ret = i2c_trylock_bus(adap, I2C_LOCK_SEGMENT);
 		if (!ret)
 			/* I2C activity is ongoing. */
-- 
2.19.1

