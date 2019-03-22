Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F8EAC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50E0D21939
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553256019;
	bh=+HXhKoqRjS8+ljtvoWOpEi/D9MCs2d2oSkYVsrEnXDM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gdRzdzfvQBZtttMeVhpNB7/wF1NeEciWAyCOYv548SSav9A1TzW3df5UYNsQMhdHu
	 WNzve3AcBJX5Eg5+Mc/dWDUCKQOZTFdrKqVyBBB+por/x5SmevKIPZkJqRxOIc8fih
	 TZu8kf1q7HrgIj5Rt3DXhN70QgRomkF2aWdo2ZFI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388065AbfCVMAS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:00:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:37310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732561AbfCVMAM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:00:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AEF1B204FD;
        Fri, 22 Mar 2019 12:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256012;
        bh=+HXhKoqRjS8+ljtvoWOpEi/D9MCs2d2oSkYVsrEnXDM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GV3ankkVIdjOkPKzp/Jj0aaeFzdxOGiwjTcDd2M9buKN/YX6UsQERCnjsSR9lHRUn
         wx/Gja/SqcgGBmL/rkTE7d1qNxEe48h4WUER9VJVkKmDZqEjRwTgzsebihwR/leyYU
         AugKLXy32KsB9rPE82LZlkKhqXmYMSrvBtPaTtsU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 064/280] i2c: bcm2835: Clear current buffer pointers and counts after a transfer
Date:   Fri, 22 Mar 2019 12:13:37 +0100
Message-Id: <20190322111309.872066289@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111306.356185024@linuxfoundation.org>
References: <20190322111306.356185024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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



