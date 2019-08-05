Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89C09C41514
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 13:27:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56D9120880
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 13:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565011670;
	bh=r7/bb3/ji9bGTifwektGoikT6jNDDZzNNwJmWEzJpKY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jHAni4au9OFE+f0NP582MZOwqhA2eA3ADlnEFwWU8GalOwOiPIgI/pRUZYfLrPGOX
	 xj+IbRyftZHL7EE/N3muWfvRum0U5XhJQo1dwRRwM8lgQ4v93KKCxHcGX6A90IEizF
	 Qs/v2ipeo7kjrn2k5/L8SXvlA+knnUwJCRsmORWI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730765AbfHENYX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 09:24:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:32778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730757AbfHENYQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 09:24:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 037F320651;
        Mon,  5 Aug 2019 13:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565011455;
        bh=r7/bb3/ji9bGTifwektGoikT6jNDDZzNNwJmWEzJpKY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ijRg0YjTM9LZ9MR+AFuhm0wSCYUzmEVrgQWWZ0CqEQLaPoPNHb/vbj9dyLr/0e22M
         UpufCA6NiOuPdYwpEcVbFBHXVyk5lprc6cft61vIvYt4H14V0Vsl6Qcm+1NvE9f6Ok
         xBJSSW4A2s/8nxWgKUYt4JWHXGiobQSAZql98GVY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, stable@kernel.org,
        Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
        Ray Jui <ray.jui@broadcom.com>,
        Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 5.2 094/131] i2c: iproc: Fix i2c master read more than 63 bytes
Date:   Mon,  5 Aug 2019 15:03:01 +0200
Message-Id: <20190805124958.260336710@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190805124951.453337465@linuxfoundation.org>
References: <20190805124951.453337465@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>

commit fd01eecdf9591453177d7b06faaabef8c300114a upstream.

Use SMBUS_MASTER_DATA_READ.MASTER_RD_STATUS bit to check for RX
FIFO empty condition because SMBUS_MASTER_FIFO_CONTROL.MASTER_RX_PKT_COUNT
is not updated for read >= 64 bytes. This fixes the issue when trying to
read from the I2C slave more than 63 bytes.

Fixes: c24b8d574b7c ("i2c: iproc: Extend I2C read up to 255 bytes")
Cc: stable@kernel.org
Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Reviewed-by: Ray Jui <ray.jui@broadcom.com>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/i2c/busses/i2c-bcm-iproc.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

--- a/drivers/i2c/busses/i2c-bcm-iproc.c
+++ b/drivers/i2c/busses/i2c-bcm-iproc.c
@@ -403,16 +403,18 @@ static bool bcm_iproc_i2c_slave_isr(stru
 static void bcm_iproc_i2c_read_valid_bytes(struct bcm_iproc_i2c_dev *iproc_i2c)
 {
 	struct i2c_msg *msg = iproc_i2c->msg;
+	uint32_t val;
 
 	/* Read valid data from RX FIFO */
 	while (iproc_i2c->rx_bytes < msg->len) {
-		if (!((iproc_i2c_rd_reg(iproc_i2c, M_FIFO_CTRL_OFFSET) >> M_FIFO_RX_CNT_SHIFT)
-		      & M_FIFO_RX_CNT_MASK))
+		val = iproc_i2c_rd_reg(iproc_i2c, M_RX_OFFSET);
+
+		/* rx fifo empty */
+		if (!((val >> M_RX_STATUS_SHIFT) & M_RX_STATUS_MASK))
 			break;
 
 		msg->buf[iproc_i2c->rx_bytes] =
-			(iproc_i2c_rd_reg(iproc_i2c, M_RX_OFFSET) >>
-			M_RX_DATA_SHIFT) & M_RX_DATA_MASK;
+			(val >> M_RX_DATA_SHIFT) & M_RX_DATA_MASK;
 		iproc_i2c->rx_bytes++;
 	}
 }


