Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBD24C31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 10:11:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7379C20B1F
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 10:11:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="KQzE8lzJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732588AbfHFKLv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 06:11:51 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46569 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbfHFKLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 06:11:51 -0400
Received: by mail-pf1-f194.google.com with SMTP id c3so18111613pfa.13
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 03:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=lUpr9FUhH57QcCVU+vO9HZiupwMzhMDSaNOkei0kz5o=;
        b=KQzE8lzJdxbMLa7xWIi9QlXR8wrWagY9a9wVsb+QGRhBWY5aqhsfHHE2AyrjJIcVD/
         7LYxPKcutsYSEKgNxm7cHvsqHgv4eTeS4Y7FuW3hmQqrDvKCQhJfyRqr4VisGAV4v9J5
         Yi6MXdOHOENOtg14J9z1y0qkaHfa34vKckpUQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lUpr9FUhH57QcCVU+vO9HZiupwMzhMDSaNOkei0kz5o=;
        b=Ip7Nibc5b3VBFsXu+j0XQWlxgnWKx1KIoVJDFzQP4YFE2OIM9QUvsSIxc9xi3U5yBN
         Epc5Jz2SIdvYXaYvCncnz95wgyjALkdQSQ710sPZAX/b9CiU/7F4YoMfH67LiSGjrjh8
         n0xlWujGJwR6/gbY1G4RdFJ7o0QbQPaPVY7sBJrHx7JznZOrESB0zap4QN27ZJlfvlM9
         SNgV4ESa4iQA5IXoVU9WSiE1c5bZRs+856KYfW2QlU/fq/MuwbvKDrnoJn2h4YIST1Xx
         PBoQjVatzI/F1qxk9l8TOxy3Q0jR804vc4yABtMeGqUgngTZtksFvGPXnMBMA2drhsAa
         vUlA==
X-Gm-Message-State: APjAAAVhxIhlvt1gJVjEb6RVlc+yD7FMC/i2R3aDCkn/5Htld9EcN4no
        caYsoPFEm6N1moesxdr+c2mPwg==
X-Google-Smtp-Source: APXvYqz3DsQSBvWF/KP/ixJyTHvQYj+8c8sIGjrKtx0GL00qLG7Y9M9fH8rbf2sPJXyIBjVqc6hKZQ==
X-Received: by 2002:a17:90a:9488:: with SMTP id s8mr2495733pjo.2.1565086310244;
        Tue, 06 Aug 2019 03:11:50 -0700 (PDT)
Received: from rayagonda.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id f20sm101713186pgg.56.2019.08.06.03.11.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 06 Aug 2019 03:11:49 -0700 (PDT)
From:   Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
To:     Kamal Dasu <kdasu.kdev@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Subject: [PATCH v1 1/1] spi: bcm-qspi: Fix BSPI QUAD and DUAL mode support when using flex mode
Date:   Tue,  6 Aug 2019 15:37:50 +0530
Message-Id: <1565086070-28451-1-git-send-email-rayagonda.kokatanur@broadcom.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix data transfer width settings based on DT field 'spi-rx-bus-width'
to configure BSPI in single, dual or quad mode by using data width
and not the command width.

Fixes: 5f195ee7d830c ("spi: bcm-qspi: Implement the spi_mem interface")

Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
---
 drivers/spi/spi-bcm-qspi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-bcm-qspi.c b/drivers/spi/spi-bcm-qspi.c
index 902bdbf..0dbfd24 100644
--- a/drivers/spi/spi-bcm-qspi.c
+++ b/drivers/spi/spi-bcm-qspi.c
@@ -343,7 +343,7 @@ static int bcm_qspi_bspi_set_flex_mode(struct bcm_qspi *qspi,
 {
 	int bpc = 0, bpp = 0;
 	u8 command = op->cmd.opcode;
-	int width  = op->cmd.buswidth ? op->cmd.buswidth : SPI_NBITS_SINGLE;
+	int width = op->data.buswidth ? op->data.buswidth : SPI_NBITS_SINGLE;
 	int addrlen = op->addr.nbytes;
 	int flex_mode = 1;
 
@@ -981,7 +981,7 @@ static int bcm_qspi_exec_mem_op(struct spi_mem *mem,
 	if (mspi_read)
 		return bcm_qspi_mspi_exec_mem_op(spi, op);
 
-	ret = bcm_qspi_bspi_set_mode(qspi, op, -1);
+	ret = bcm_qspi_bspi_set_mode(qspi, op, 0);
 
 	if (!ret)
 		ret = bcm_qspi_bspi_exec_mem_op(spi, op);
-- 
1.9.1

