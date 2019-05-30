Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BDDBC072B1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:43:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B1D924C57
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559187834;
	bh=XctbAn9oKco3ZTcpPr0FOraHUuXoaFY+/vmce3lj+MI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iGAMxTyywZ0nLnkgwLcU3K5Mo/r8w4FyztSA94LGs4C4yQTwXgwb13SLEaoVMipzG
	 Ba3TFiCGKxu3NQmwU0xoD1JXFOwf+d42WljxKR33LcCiE7rHI9f2VIqfvgbvs0+Sap
	 ozeOMPasy6HiT3HTLOQJ/Gq0gJ3hM111EzIobtNw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732810AbfE3Dnx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 23:43:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:60964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732415AbfE3DVC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:21:02 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D208A2496D;
        Thu, 30 May 2019 03:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559186461;
        bh=XctbAn9oKco3ZTcpPr0FOraHUuXoaFY+/vmce3lj+MI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=untOUEDnIO+Ktwl4SW10irpWm075nn0PRQOs/zrqG1+pKlU1hGoH9/dhHH+BMiAGf
         X447XV1HvAH5XOZ/Tazvsg+TehwxZwn3N5q7m9+0keSPDsnB4anWn3nUzQcYXH1fIb
         dO++jC9Lque4RHgG/I8/t1j3mB4CBzc5jVMCILo4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kangjie Lu <kjlu@umn.edu>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 079/128] mmc_spi: add a status check for spi_sync_locked
Date:   Wed, 29 May 2019 20:06:51 -0700
Message-Id: <20190530030448.876467781@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030432.977908967@linuxfoundation.org>
References: <20190530030432.977908967@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 611025983b7976df0183390a63a2166411d177f1 ]

In case spi_sync_locked fails, the fix reports the error and
returns the error code upstream.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/host/mmc_spi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
index 6224ad37fd80b..c2df68e958b33 100644
--- a/drivers/mmc/host/mmc_spi.c
+++ b/drivers/mmc/host/mmc_spi.c
@@ -819,6 +819,10 @@ mmc_spi_readblock(struct mmc_spi_host *host, struct spi_transfer *t,
 	}
 
 	status = spi_sync_locked(spi, &host->m);
+	if (status < 0) {
+		dev_dbg(&spi->dev, "read error %d\n", status);
+		return status;
+	}
 
 	if (host->dma_dev) {
 		dma_sync_single_for_cpu(host->dma_dev,
-- 
2.20.1



