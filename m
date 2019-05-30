Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D280C28CC1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DDFE24A61
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559186714;
	bh=pq8DH5vJ+r/czJBLB7goRxkkFDsB/y4F+Nuk/fNzKh0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2evOFSniO/lDTbec5K51RDrxSv9aU7vUgk4lT7ym7nkiZEo8ERVovdmX0FmPKZ9mm
	 SifxLPmsZJ8V+dGWRvUGhIvsZV7mzMnCjhm+TtPm909LL92NEJCUmf4FzW/ekHXcOX
	 jraj3IcSDqUzRAgy+syKcz6+TiAG8f64LioqBHNQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727350AbfE3DZN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 23:25:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:50856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730035AbfE3DSW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:18:22 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3586A247BC;
        Thu, 30 May 2019 03:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559186302;
        bh=pq8DH5vJ+r/czJBLB7goRxkkFDsB/y4F+Nuk/fNzKh0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aGR1yB8SjtZyOQxWqQjN1yNBobQbrgsfn67RqW5imj7QLN3Wxp5X81LHK43+IZTwB
         meLpZfp32FWaulr6BPTth3BeESrItAXKhhQibqCLpdEWclBgH+YRrgmBsJBn0kwdDQ
         iHZX8hk7zNgpMEJc0CJ9ikBw1oJ52PfPYHwbqh0A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chris Lesiak <chris.lesiak@licor.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 268/276] spi: Fix zero length xfer bug
Date:   Wed, 29 May 2019 20:07:06 -0700
Message-Id: <20190530030541.962793651@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030523.133519668@linuxfoundation.org>
References: <20190530030523.133519668@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 5442dcaa0d90fc376bdfc179a018931a8f43dea4 ]

This fixes a bug for messages containing both zero length and
unidirectional xfers.

The function spi_map_msg will allocate dummy tx and/or rx buffers
for use with unidirectional transfers when the hardware can only do
a bidirectional transfer.  That dummy buffer will be used in place
of a NULL buffer even when the xfer length is 0.

Then in the function __spi_map_msg, if he hardware can dma,
the zero length xfer will have spi_map_buf called on the dummy
buffer.

Eventually, __sg_alloc_table is called and returns -EINVAL
because nents == 0.

This fix prevents the error by not using the dummy buffer when
the xfer length is zero.

Signed-off-by: Chris Lesiak <chris.lesiak@licor.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 9da0bc5a036cf..88a8a8edd44be 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -982,6 +982,8 @@ static int spi_map_msg(struct spi_controller *ctlr, struct spi_message *msg)
 		if (max_tx || max_rx) {
 			list_for_each_entry(xfer, &msg->transfers,
 					    transfer_list) {
+				if (!xfer->len)
+					continue;
 				if (!xfer->tx_buf)
 					xfer->tx_buf = ctlr->dummy_tx;
 				if (!xfer->rx_buf)
-- 
2.20.1



