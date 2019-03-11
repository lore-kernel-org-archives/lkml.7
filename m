Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9BA3C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 20:02:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC9372087C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 20:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552334537;
	bh=6pktP2eBvwBqfSFJUuY97dQAnRVVDhWo5AvqF1PZkQU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OQpjAYm5qj72JRXAd0Sw15D9Dy0D5mcn1iSvQUwK/jnmstCxfYpP44W9OgqHWbKRW
	 ASK5/2MnLbPy5VenhbZhxMORoeQiDK5paUmtxn100m8XO0BexfI7hCK4UboIsQKfqa
	 cRP7XrOKWZQ2HTmM3l8ptd70+P+eRov6VKECJ+Ro=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729559AbfCKT7M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 15:59:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:36568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728460AbfCKT7J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 15:59:09 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 340A7214AF;
        Mon, 11 Mar 2019 19:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552334348;
        bh=6pktP2eBvwBqfSFJUuY97dQAnRVVDhWo5AvqF1PZkQU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hmDxFPLGpPGuLzIZOeUNkgG4q3W2iyyY8UK+kQktuGkrj17l2y2oqSO2ec1v2o91i
         iySbeL8dpzoMfrK90KqKRYnw2k7urQNFSWA/3aFuj++ZC5Fe4Uk+fi0HaZrlki27Ua
         4C1afl3RMIqhXnRNuGUwbvbcxcwfn1E/oFpNNHYI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sasha Levin <sashal@kernel.org>, linux-i2c@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 25/27] i2c: bcm2835: Clear current buffer pointers and counts after a transfer
Date:   Mon, 11 Mar 2019 15:58:22 -0400
Message-Id: <20190311195824.139043-25-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190311195824.139043-1-sashal@kernel.org>
References: <20190311195824.139043-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

[ Upstream commit f275a4659484716259cc46268d9043424e51cf0f ]

The driver's interrupt handler checks whether a message is currently
being handled with the curr_msg pointer. When it is NULL, the interrupt
is considered to be unexpected. Similarly, the i2c_start_transfer
routine checks for the remaining number of messages to handle in
num_msgs.

However, these values are never cleared and always keep the message and
number relevant to the latest transfer (which might be done already and
the underlying message memory might have been freed).

When an unexpected interrupt hits with the DONE bit set, the isr will
then try to access the flags field of the curr_msg structure, leading
to a fatal page fault.

The msg_buf and msg_buf_remaining fields are also never cleared at the
end of the transfer, which can lead to similar pitfalls.

Fix these issues by introducing a cleanup function and always calling
it after a transfer is finished.

Fixes: e2474541032d ("i2c: bcm2835: Fix hang for writing messages larger than 16 bytes")
Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Acked-by: Stefan Wahren <stefan.wahren@i2se.com>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-bcm2835.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/i2c/busses/i2c-bcm2835.c b/drivers/i2c/busses/i2c-bcm2835.c
index 44deae78913e..4d19254f78c8 100644
--- a/drivers/i2c/busses/i2c-bcm2835.c
+++ b/drivers/i2c/busses/i2c-bcm2835.c
@@ -191,6 +191,15 @@ static void bcm2835_i2c_start_transfer(struct bcm2835_i2c_dev *i2c_dev)
 	bcm2835_i2c_writel(i2c_dev, BCM2835_I2C_C, c);
 }
 
+static void bcm2835_i2c_finish_transfer(struct bcm2835_i2c_dev *i2c_dev)
+{
+	i2c_dev->curr_msg = NULL;
+	i2c_dev->num_msgs = 0;
+
+	i2c_dev->msg_buf = NULL;
+	i2c_dev->msg_buf_remaining = 0;
+}
+
 /*
  * Note about I2C_C_CLEAR on error:
  * The I2C_C_CLEAR on errors will take some time to resolve -- if you were in
@@ -291,6 +300,9 @@ static int bcm2835_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[],
 
 	time_left = wait_for_completion_timeout(&i2c_dev->completion,
 						adap->timeout);
+
+	bcm2835_i2c_finish_transfer(i2c_dev);
+
 	if (!time_left) {
 		bcm2835_i2c_writel(i2c_dev, BCM2835_I2C_C,
 				   BCM2835_I2C_C_CLEAR);
-- 
2.19.1

