Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3C09C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 19:56:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76A23214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 19:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552334219;
	bh=6pktP2eBvwBqfSFJUuY97dQAnRVVDhWo5AvqF1PZkQU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Oa1gqlK7jgiCcM64BO8l8esPKpaHPAJqKi0Wz5d2+JBNg4URVLgAP4X81qLFFEiiU
	 9pahQZLc3mFtKXHIvwZ6dmseE8dsU+RasMPjny9dHzrW4uSIE1WG5CSZ065s2K480D
	 Veyx4pe+T3N44RW9lKhc/pjziiyMj0AV6B41+w5o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728919AbfCKT45 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 15:56:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:34282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728286AbfCKT4z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 15:56:55 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0986F21773;
        Mon, 11 Mar 2019 19:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552334214;
        bh=6pktP2eBvwBqfSFJUuY97dQAnRVVDhWo5AvqF1PZkQU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pd4ObuS1kOY50p/98F1Rj1WSlJaiLfrru6Mq6rbvo2OliWxnsf3ai4A1AvtzmzMWt
         Z/xpS6O2rlrJrrPyrakUlrC4BbbIFoYYtm9Cja8Bqf+1OIvQd9mr/Y/WIRBPRfTHGI
         Z7TZsfmkizlZKAXd0HfzDCBz5UVPJTjdm8MtD4DM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sasha Levin <sashal@kernel.org>, linux-i2c@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 49/52] i2c: bcm2835: Clear current buffer pointers and counts after a transfer
Date:   Mon, 11 Mar 2019 15:55:13 -0400
Message-Id: <20190311195516.137772-49-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190311195516.137772-1-sashal@kernel.org>
References: <20190311195516.137772-1-sashal@kernel.org>
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

