Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B6EC7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 12:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 034DE21903
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 12:47:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mdO+FpwF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389859AbfGWMrO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 08:47:14 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40097 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389797AbfGWMrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 08:47:13 -0400
Received: by mail-pg1-f193.google.com with SMTP id w10so19391253pgj.7;
        Tue, 23 Jul 2019 05:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RvJTgF+BOn0RoftzxFYR6bLO76ZgRwKBwjddXUMQ278=;
        b=mdO+FpwFctnohKCWuCH49mHKxqMsQRapR01Af2NxzrcvDyxseTNc7eUWdkK/utUCHY
         a1rhqK8OJ8cwvhXB3dn6ojcTJq2G8rRAkiJF6ecFGdgIdb58pOscSftnbcMR21itm0Gg
         pCtNfgAaUbQNy57nooxSvcv+25test50QR6cj7+8TiPEyW93TLUAOozBqpA0RrNe7ped
         hsh9hj2l049LdLUYeQWTyk/M2rFypoDEz4PnM3LBrYP0oCgbgtb64bpq7ixorNfE/Cy9
         A/aHpkVI7vcUkK9KlOBu1oNIxc9DoPhDZPe+uZ2nmsErEto2wFdiLfjTSaOtVaFwRMqy
         YREQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RvJTgF+BOn0RoftzxFYR6bLO76ZgRwKBwjddXUMQ278=;
        b=AaQ8AkTox92YhZxRHqDcNXyeb1wUfPt8CGb/6VLkik5NSL+80A6qFbxgoQwvbcp81u
         /7cVTiQiKuMUVIfGBB3K+wa2ROuHQR1chysaCYfbGQKyzDBvPf5i4tYMDx2yJ1qsYr7H
         wR17vReXte1EimYmzlAKtE1yW2NNr2rHhAIy6kbXmio+QmiR0DULSIB7gQgiO2AMI1PK
         fMqslVvJ91turwP3LezU8iUz7um9MpU+2j+QVLJ7AbcqcgitGmQPD9/ZiwQGehkbfW/G
         b6T1e5ixIYUMnjBwlfad/NqW6K7P4Z1ODuqmQI5F/HUNWx1PGIkpb6wfoYjIn2Iu+F00
         4Xgw==
X-Gm-Message-State: APjAAAWAixdin7/WHeOglz6Tqk6Fpv5Ngs+p7GT2iiwZqzva8WNtYoPT
        EFwhxS37B8WuhjQr6VU6zyM=
X-Google-Smtp-Source: APXvYqxcn0WFoYb8j7/TG4ohUCx982Olky66Q6qucS0ygw8/QdHxp5v3aoNavIwttB/3aRAs8TGeyA==
X-Received: by 2002:aa7:9dc7:: with SMTP id g7mr5407603pfq.170.1563886032549;
        Tue, 23 Jul 2019 05:47:12 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id w1sm36278872pjt.30.2019.07.23.05.47.10
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 23 Jul 2019 05:47:11 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] mmc: sdhci-pci: Use dev_get_drvdata
Date:   Tue, 23 Jul 2019 20:47:07 +0800
Message-Id: <20190723124707.24782-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of using to_pci_dev + pci_get_drvdata,
use dev_get_drvdata to make code simpler.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 drivers/mmc/host/sdhci-pci-core.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index 4041878eb0f3..d10aceed5bb7 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -1759,8 +1759,7 @@ static const struct sdhci_ops sdhci_pci_ops = {
 #ifdef CONFIG_PM_SLEEP
 static int sdhci_pci_suspend(struct device *dev)
 {
-	struct pci_dev *pdev = to_pci_dev(dev);
-	struct sdhci_pci_chip *chip = pci_get_drvdata(pdev);
+	struct sdhci_pci_chip *chip = dev_get_drvdata(dev);
 
 	if (!chip)
 		return 0;
@@ -1773,8 +1772,7 @@ static int sdhci_pci_suspend(struct device *dev)
 
 static int sdhci_pci_resume(struct device *dev)
 {
-	struct pci_dev *pdev = to_pci_dev(dev);
-	struct sdhci_pci_chip *chip = pci_get_drvdata(pdev);
+	struct sdhci_pci_chip *chip = dev_get_drvdata(dev);
 
 	if (!chip)
 		return 0;
@@ -1789,8 +1787,7 @@ static int sdhci_pci_resume(struct device *dev)
 #ifdef CONFIG_PM
 static int sdhci_pci_runtime_suspend(struct device *dev)
 {
-	struct pci_dev *pdev = to_pci_dev(dev);
-	struct sdhci_pci_chip *chip = pci_get_drvdata(pdev);
+	struct sdhci_pci_chip *chip = dev_get_drvdata(dev);
 
 	if (!chip)
 		return 0;
@@ -1803,8 +1800,7 @@ static int sdhci_pci_runtime_suspend(struct device *dev)
 
 static int sdhci_pci_runtime_resume(struct device *dev)
 {
-	struct pci_dev *pdev = to_pci_dev(dev);
-	struct sdhci_pci_chip *chip = pci_get_drvdata(pdev);
+	struct sdhci_pci_chip *chip = dev_get_drvdata(dev);
 
 	if (!chip)
 		return 0;
-- 
2.20.1

