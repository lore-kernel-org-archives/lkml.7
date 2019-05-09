Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 259F9C04A6B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 00:55:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF1C12173B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 00:55:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbfEIAzJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 20:55:09 -0400
Received: from www.osadl.org ([62.245.132.105]:59629 "EHLO www.osadl.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725778AbfEIAzJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 20:55:09 -0400
Received: from debian01.hofrr.at (178.115.242.59.static.drei.at [178.115.242.59])
        by www.osadl.org (8.13.8/8.13.8/OSADL-2007092901) with ESMTP id x490sgfS028444;
        Thu, 9 May 2019 02:54:43 +0200
From:   Nicholas Mc Guire <hofrat@osadl.org>
To:     Laxman Dewangan <ldewangan@nvidia.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-i2c@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH] i2c: tegra: use busendiannes variable
Date:   Thu,  9 May 2019 02:48:57 +0200
Message-Id: <1557362937-6591-1-git-send-email-hofrat@osadl.org>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Converting from bus to host endiannes was done using the same variable
which makes sparse unhappy as it can not verify the endiannes handling
properly. To allow sparse to verify endiannes handling a __le32 is
introduced. This patch does not actually change the code logic while
the binary does change due to limit on instruction re-ordering induced
by the additional constraint.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
---

Problem located by an experimental coccinelle script to locate
patters that make sparse unhappy (false positives):

sparse was complaining about:
drivers/i2c/busses/i2c-tegra.c:596:23: warning: cast to restricted __le32

Note that the binary does change in this case - from inspection of the
.lst files it seems that the introduction of the __le32 limits
the re-ordering options for the compiler so one instruction
position changed (ldr     r1, [sp, #4]) but from my understanding
that does not change the program logic here.

Patch was compile-tested with: tegra_defconfig (implies I2C_TEGRA=y)

Patch is against 5.1 (localversion-next is next-20190508)

 drivers/i2c/busses/i2c-tegra.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
index ebaa78d..cbaddcc 100644
--- a/drivers/i2c/busses/i2c-tegra.c
+++ b/drivers/i2c/busses/i2c-tegra.c
@@ -543,18 +543,19 @@ static int tegra_i2c_empty_rx_fifo(struct tegra_i2c_dev *i2c_dev)
 static int tegra_i2c_fill_tx_fifo(struct tegra_i2c_dev *i2c_dev)
 {
 	u32 val;
+	__le32 busval;
 	int tx_fifo_avail;
 	u8 *buf = i2c_dev->msg_buf;
 	size_t buf_remaining = i2c_dev->msg_buf_remaining;
 	int words_to_transfer;
 
 	if (i2c_dev->hw->has_mst_fifo) {
-		val = i2c_readl(i2c_dev, I2C_MST_FIFO_STATUS);
-		tx_fifo_avail = (val & I2C_MST_FIFO_STATUS_TX_MASK) >>
+		busval = i2c_readl(i2c_dev, I2C_MST_FIFO_STATUS);
+		tx_fifo_avail = (busval & I2C_MST_FIFO_STATUS_TX_MASK) >>
 			I2C_MST_FIFO_STATUS_TX_SHIFT;
 	} else {
-		val = i2c_readl(i2c_dev, I2C_FIFO_STATUS);
-		tx_fifo_avail = (val & I2C_FIFO_STATUS_TX_MASK) >>
+		busval = i2c_readl(i2c_dev, I2C_FIFO_STATUS);
+		tx_fifo_avail = (busval & I2C_FIFO_STATUS_TX_MASK) >>
 			I2C_FIFO_STATUS_TX_SHIFT;
 	}
 
@@ -592,8 +593,8 @@ static int tegra_i2c_fill_tx_fifo(struct tegra_i2c_dev *i2c_dev)
 	 */
 	if (tx_fifo_avail > 0 && buf_remaining > 0) {
 		BUG_ON(buf_remaining > 3);
-		memcpy(&val, buf, buf_remaining);
-		val = le32_to_cpu(val);
+		memcpy(&busval, buf, buf_remaining);
+		val = le32_to_cpu(busval);
 
 		/* Again update before writing to FIFO to make sure isr sees. */
 		i2c_dev->msg_buf_remaining = 0;
-- 
2.1.4

