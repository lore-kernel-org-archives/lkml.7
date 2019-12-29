Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44609C2D0D1
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 18:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1487B20718
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 18:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577642681;
	bh=SO14ytmvWlkBdIUPvWJBq0qkqjZ/rvey0FkPu8dhX5s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CZnW0Xo1X5lk/qQA4x7DshEUUw1btlzNu+o+lA+oeLufZ1Ydu8grGsD1RFeJw1jai
	 HepT5Ciru2CvY3q1WgqbtwidIz92LbM8pk6i2fNSDrSrz9ziOXTHRytELD2b7/JT5V
	 mdyBolR32dVDfp0mYGgJuBBxVLgi4lhrJQbsS/gY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732186AbfL2RwA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 12:52:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:37594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732168AbfL2Rvv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 12:51:51 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D9DA208C4;
        Sun, 29 Dec 2019 17:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577641911;
        bh=SO14ytmvWlkBdIUPvWJBq0qkqjZ/rvey0FkPu8dhX5s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Sx0wE0r/Yov1jlp5YCETT0yyBYAL/pmgfmp/E7oBEKV7Ya6a+HKKSdoIHnl911HKn
         m7c2nkTCNZgYIo5b7rv6azCQaalqkWG0tc8fWFS0aHpoWYapOy8VhYMSP7s6IVP+Yy
         APirWrlHMLHUEwGNijnYuu4qvKrppz6DL/u67CGU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thor Thayer <thor.thayer@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 236/434] spi: dw: Fix Designware SPI loopback
Date:   Sun, 29 Dec 2019 18:24:49 +0100
Message-Id: <20191229172717.557909063@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191229172702.393141737@linuxfoundation.org>
References: <20191229172702.393141737@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thor Thayer <thor.thayer@linux.intel.com>

[ Upstream commit 1403cfa69d310781f9548951c97725c67ffcf613 ]

The SPI_LOOP is set in spi->mode but not propagated to the register.
A previous patch removed the bit during a cleanup.

Fixes: e1bc204894ea ("spi: dw: fix potential variable assignment error")
Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
Link: https://lore.kernel.org/r/1572985330-5525-1-git-send-email-thor.thayer@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-dw.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index 9a49e073e8b7..076652d3d051 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -308,7 +308,8 @@ static int dw_spi_transfer_one(struct spi_controller *master,
 	cr0 = (transfer->bits_per_word - 1)
 		| (chip->type << SPI_FRF_OFFSET)
 		| ((((spi->mode & SPI_CPOL) ? 1 : 0) << SPI_SCOL_OFFSET) |
-			(((spi->mode & SPI_CPHA) ? 1 : 0) << SPI_SCPH_OFFSET))
+			(((spi->mode & SPI_CPHA) ? 1 : 0) << SPI_SCPH_OFFSET) |
+			(((spi->mode & SPI_LOOP) ? 1 : 0) << SPI_SRL_OFFSET))
 		| (chip->tmode << SPI_TMOD_OFFSET);
 
 	/*
-- 
2.20.1



