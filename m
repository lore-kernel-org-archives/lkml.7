Return-Path: <SRS0=ATYp=YN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3AD9CA9EAD
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 17:54:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD88921A4A
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 17:54:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ec90vniS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbfJTRyx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Oct 2019 13:54:53 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:45792 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726559AbfJTRyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Oct 2019 13:54:53 -0400
Received: by mail-lf1-f65.google.com with SMTP id v8so7657684lfa.12
        for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2019 10:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=lezLxz9ZEViSL/s9KgaBFqX70JcczDlWKnb8jAuYGeM=;
        b=ec90vniSXCHPRmxIeHIqnueQnWjuhD3TybVWYWc6oT+Haw6EaikAdw1YE2H7lgwY+B
         og64CZgDCHslF/HfAe3JTYzOkt4NZ9X0COOzBhf/2O8Jrwdr7Nx60P85FNhcjtKlgWPi
         MuCI02s/xEJeojnVtv8xom0HPV83/TRAoaZeFIieaGTxrN+v7NXTqvPbPMpFrb6o7Sig
         ORrS1gFaL7WiR92dXKoc//0/gpo2tRO4P5ypJNwuxXWPnvlfIrKy8IxAHI3u22KndR4G
         rpFW6Kx6EKtvdnOHpuHtogHfFEdHUg6uWQ2XIHvYLZLPJmzGYimfk4NxBwpy8tnQ81ZD
         mnKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lezLxz9ZEViSL/s9KgaBFqX70JcczDlWKnb8jAuYGeM=;
        b=gYM5zsXazl5WnUGv7yvm64yYXQwQrM5YWH0AgHsdeNSNdJOVLk3/QliXQsuPtYTGRX
         nVUby+gBS1yFW3FqOro/tOf2QzMoSAUWWnL0zAO7bG4z47RNXGljZp9+UnD/vakPDkle
         3f7PdLpFSGVh2OQZiTIQRLOLbv2kMZz00FB7gZwh74+59Zudrr2i/c/NVxxWO05HVFcj
         RACpH9Qd9wWiH/8MrkeguIOZ07WNZ+wtI19FyGrGKwRMJWzgmMisDGvtk2D79FmsgyAD
         2t4TxWgZOb3zlB4BCRkfEXv3Nhrc0GQYf7VEXWynM3TKMd9kEPG1bC57yP2M62fWg73p
         GdvQ==
X-Gm-Message-State: APjAAAWBNv+K3zG2A7JxEqD2uf789qZSv8O2Gj6BAquNdLxBxXxEX6Sw
        1TwdbBhZ6/awrgKqgmokakc=
X-Google-Smtp-Source: APXvYqymdpC+Rp5WhOYkAbJ6JCs/CGvWEYhZfI+Je7Qev+wAQ3esy20KnJdueQRiQTynmMWfp4k10A==
X-Received: by 2002:a19:855:: with SMTP id 82mr11965142lfi.44.1571594089814;
        Sun, 20 Oct 2019 10:54:49 -0700 (PDT)
Received: from localhost.localdomain ([93.152.168.243])
        by smtp.gmail.com with ESMTPSA id t6sm5806085ljd.102.2019.10.20.10.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2019 10:54:49 -0700 (PDT)
From:   Samuil Ivanov <samuil.ivanovbg@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Samuil Ivanov <samuil.ivanovbg@gmail.com>
Subject: [PATCH] Staging: gasket: apex_driver: fixed a line over 80 characters coding style issue
Date:   Sun, 20 Oct 2019 20:50:01 +0300
Message-Id: <20191020175001.22105-1-samuil.ivanovbg@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed four lines of code that were over 80 characters long.

Signed-off-by: Samuil Ivanov <samuil.ivanovbg@gmail.com>
---
 drivers/staging/gasket/apex_driver.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/gasket/apex_driver.c b/drivers/staging/gasket/apex_driver.c
index 46199c8ca441..f729ecd6363b 100644
--- a/drivers/staging/gasket/apex_driver.c
+++ b/drivers/staging/gasket/apex_driver.c
@@ -263,8 +263,8 @@ static int apex_enter_reset(struct gasket_dev *gasket_dev)
 	 *    - Enable GCB idle
 	 */
 	gasket_read_modify_write_64(gasket_dev, APEX_BAR_INDEX,
-				    APEX_BAR2_REG_IDLEGENERATOR_IDLEGEN_IDLEREGISTER,
-				    0x0, 1, 32);
+			APEX_BAR2_REG_IDLEGENERATOR_IDLEGEN_IDLEREGISTER,
+			0x0, 1, 32);
 
 	/*    - Initiate DMA pause */
 	gasket_dev_write_64(gasket_dev, 1, APEX_BAR_INDEX,
@@ -399,7 +399,7 @@ static int apex_device_cleanup(struct gasket_dev *gasket_dev)
 	hib_error = gasket_dev_read_64(gasket_dev, APEX_BAR_INDEX,
 				       APEX_BAR2_REG_USER_HIB_ERROR_STATUS);
 	scalar_error = gasket_dev_read_64(gasket_dev, APEX_BAR_INDEX,
-					  APEX_BAR2_REG_SCALAR_CORE_ERROR_STATUS);
+					APEX_BAR2_REG_SCALAR_CORE_ERROR_STATUS);
 
 	dev_dbg(gasket_dev->dev,
 		"%s 0x%p hib_error 0x%llx scalar_error 0x%llx\n",
@@ -606,10 +606,10 @@ static int apex_pci_probe(struct pci_dev *pci_dev,
 	while (retries < APEX_RESET_RETRY) {
 		page_table_ready =
 			gasket_dev_read_64(gasket_dev, APEX_BAR_INDEX,
-					   APEX_BAR2_REG_KERNEL_HIB_PAGE_TABLE_INIT);
+				APEX_BAR2_REG_KERNEL_HIB_PAGE_TABLE_INIT);
 		msix_table_ready =
 			gasket_dev_read_64(gasket_dev, APEX_BAR_INDEX,
-					   APEX_BAR2_REG_KERNEL_HIB_MSIX_TABLE_INIT);
+				APEX_BAR2_REG_KERNEL_HIB_MSIX_TABLE_INIT);
 		if (page_table_ready && msix_table_ready)
 			break;
 		schedule_timeout(msecs_to_jiffies(APEX_RESET_DELAY));
-- 
2.17.1

