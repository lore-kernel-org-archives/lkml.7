Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C780C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E96A020637
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574419791;
	bh=6pmJeMGmgveo2F8W5HfH26LHnPnw77rwTGUaqDtjx2Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=a9FEka70YjFvueJ6iQ+JHyfLJRiUIt0AAQlXJFASQagX+lyIBv2SMf0zGkEm8h+OX
	 DjeMvAh2DjUvyvPz/7q9vL0jkPMdVd6lltcHj+7yETozyfQPw34xttWSh7JZgnW/qG
	 6jT3IPWMaiZTmQiXCIwlPVv4D+fkWdd+cmahL1Oc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730060AbfKVKtt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 05:49:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:59408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729587AbfKVKtq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 05:49:46 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3266E2072E;
        Fri, 22 Nov 2019 10:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574419785;
        bh=6pmJeMGmgveo2F8W5HfH26LHnPnw77rwTGUaqDtjx2Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yMD8SorJF71cqh+c4tlKT8EiL6T2x+7OyPvBnwOiWO5FbVm7oUMB5DdsfINRMdCjD
         1v/4jA3uxWBfTKuHzaBp5iZidm/b78QSo6DS+QmCCUTF2OGehP4PqU5y5nynGdbi82
         oERAr4mHE9xE6R0WThoMgeKecq1BolBcbr4dv9MY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Leilk Liu <leilk.liu@mediatek.com>,
        Mark Brown <broonie@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 4.14 001/122] spi: mediatek: use correct mata->xfer_len when in fifo transfer
Date:   Fri, 22 Nov 2019 11:27:34 +0100
Message-Id: <20191122100722.782908443@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122100722.177052205@linuxfoundation.org>
References: <20191122100722.177052205@linuxfoundation.org>
User-Agent: quilt/0.66
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Leilk Liu <leilk.liu@mediatek.com>

commit a4d8f64f7267a88d4688f5c216926f5f6cafbae6 upstream.

when xfer_len is greater than 64 bytes and use fifo mode
to transfer, the actual length from the third time is mata->xfer_len
but not len in mtk_spi_interrupt().

Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/spi/spi-mt65xx.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -522,11 +522,11 @@ static irqreturn_t mtk_spi_interrupt(int
 		mdata->xfer_len = min(MTK_SPI_MAX_FIFO_SIZE, len);
 		mtk_spi_setup_packet(master);
 
-		cnt = len / 4;
+		cnt = mdata->xfer_len / 4;
 		iowrite32_rep(mdata->base + SPI_TX_DATA_REG,
 				trans->tx_buf + mdata->num_xfered, cnt);
 
-		remainder = len % 4;
+		remainder = mdata->xfer_len % 4;
 		if (remainder > 0) {
 			reg_val = 0;
 			memcpy(&reg_val,


