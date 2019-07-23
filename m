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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0289C7618E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 13:19:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 987B1218D4
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 13:19:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AhiBI4iv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390169AbfGWNTi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 09:19:38 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37989 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729452AbfGWNTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 09:19:35 -0400
Received: by mail-pf1-f195.google.com with SMTP id y15so19146746pfn.5;
        Tue, 23 Jul 2019 06:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xLbjkGnyqbbz4BH8MubMCB3MNb9jNkxMOv80SlkHi3o=;
        b=AhiBI4iv1tUnVtDISYXZHLp1hXgvEMBiYIvBAyKpCA4C/THfUHD+dp9CSz5ar46+DB
         ELKVNaOPdbOI1m4zyWMjD+d/Gy+zJBVOtm/SsBOOPfJR8dHqlKPZwLZqb+iMCS+9B/xu
         Q3KcRZ3SebAjoviHfqb+jrn8cnUqgALh6SjBeSMtFxDPie4ugn7h9a3xJgjfnZT1P/em
         IAFxlgH8Q4yUPZqLxLqTnUlVhORetlm+s2cuXpbZI4Hl+CzYOAbx/g/mYAy0S7lLB8fJ
         JAAcHxRCHT3dHzI1CERv7ePUoZJBs8AaIycuONGPR8g150TUIAqYD62I4hOsCV5BlRcH
         MCLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xLbjkGnyqbbz4BH8MubMCB3MNb9jNkxMOv80SlkHi3o=;
        b=ZG2RKoaJ9NEAg2CwthLo8wmqcvJXHGr6LA0oAPc1cPCWycYco/BTOJ9sK18qIGQ6hd
         th5/aZcaNJ/N2aYW13vis03YwrhOxUmTnIYNv6czAmFabYH01AKhiFdLEZzk1mkjD0p5
         4Co4DdkgcnDvlCf/IlI9D78GX98AslSvBF37JEW3CAc1XEvDLbNo9V/4aHOMs6Fs+xw0
         ivX+fNiZCnv6IUId0kcayS6dR5Pg2WzsRBwYQcLPRZUzxSjgdjXYlml/RVRyxFlxzzrm
         UGFByWGNxcbQL0AbGrBk9K/4O2RJRTRQDYumvtJQEirf6z4yTygzGvomYuMU+x0Xl9zJ
         SS4w==
X-Gm-Message-State: APjAAAVnD0wpOmP8AwmMExjDeebgqY+8HGPnWffT5Vifq08OJxbncUlb
        qpBCgFyS/Z446VtQzOpqVQ4=
X-Google-Smtp-Source: APXvYqwbkP4ZEi+noY1JRzhuAhZ5pSU+yFtdOhCmNQkZws8Ff3OMGzTYggzXv8013Bgb6kHmi4lJlA==
X-Received: by 2002:a17:90a:cb18:: with SMTP id z24mr31356951pjt.108.1563887975020;
        Tue, 23 Jul 2019 06:19:35 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id c130sm41862623pfc.184.2019.07.23.06.19.31
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 23 Jul 2019 06:19:34 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Rasesh Mody <rmody@marvell.com>, GR-Linux-NIC-Dev@marvell.com,
        "David S . Miller" <davem@davemloft.net>,
        Michael Chan <michael.chan@broadcom.com>,
        Siva Reddy Kallam <siva.kallam@broadcom.com>,
        Prashant Sreedharan <prashant@broadcom.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] net: broadcom: Use dev_get_drvdata
Date:   Tue, 23 Jul 2019 21:19:29 +0800
Message-Id: <20190723131929.31987-1-hslester96@gmail.com>
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
 drivers/net/ethernet/broadcom/bnx2.c      | 6 ++----
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 6 ++----
 drivers/net/ethernet/broadcom/tg3.c       | 6 ++----
 3 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnx2.c b/drivers/net/ethernet/broadcom/bnx2.c
index dfdd14eadd57..fbc196b480b6 100644
--- a/drivers/net/ethernet/broadcom/bnx2.c
+++ b/drivers/net/ethernet/broadcom/bnx2.c
@@ -8673,8 +8673,7 @@ bnx2_remove_one(struct pci_dev *pdev)
 static int
 bnx2_suspend(struct device *device)
 {
-	struct pci_dev *pdev = to_pci_dev(device);
-	struct net_device *dev = pci_get_drvdata(pdev);
+	struct net_device *dev = dev_get_drvdata(device);
 	struct bnx2 *bp = netdev_priv(dev);
 
 	if (netif_running(dev)) {
@@ -8693,8 +8692,7 @@ bnx2_suspend(struct device *device)
 static int
 bnx2_resume(struct device *device)
 {
-	struct pci_dev *pdev = to_pci_dev(device);
-	struct net_device *dev = pci_get_drvdata(pdev);
+	struct net_device *dev = dev_get_drvdata(device);
 	struct bnx2 *bp = netdev_priv(dev);
 
 	if (!netif_running(dev))
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 7134d2c3eb1c..1aad59b8a413 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -10920,8 +10920,7 @@ static void bnxt_shutdown(struct pci_dev *pdev)
 #ifdef CONFIG_PM_SLEEP
 static int bnxt_suspend(struct device *device)
 {
-	struct pci_dev *pdev = to_pci_dev(device);
-	struct net_device *dev = pci_get_drvdata(pdev);
+	struct net_device *dev = dev_get_drvdata(device);
 	struct bnxt *bp = netdev_priv(dev);
 	int rc = 0;
 
@@ -10937,8 +10936,7 @@ static int bnxt_suspend(struct device *device)
 
 static int bnxt_resume(struct device *device)
 {
-	struct pci_dev *pdev = to_pci_dev(device);
-	struct net_device *dev = pci_get_drvdata(pdev);
+	struct net_device *dev = dev_get_drvdata(device);
 	struct bnxt *bp = netdev_priv(dev);
 	int rc = 0;
 
diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index 4c404d2213f9..77f3511b97de 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -18041,8 +18041,7 @@ static void tg3_remove_one(struct pci_dev *pdev)
 #ifdef CONFIG_PM_SLEEP
 static int tg3_suspend(struct device *device)
 {
-	struct pci_dev *pdev = to_pci_dev(device);
-	struct net_device *dev = pci_get_drvdata(pdev);
+	struct net_device *dev = dev_get_drvdata(device);
 	struct tg3 *tp = netdev_priv(dev);
 	int err = 0;
 
@@ -18098,8 +18097,7 @@ static int tg3_suspend(struct device *device)
 
 static int tg3_resume(struct device *device)
 {
-	struct pci_dev *pdev = to_pci_dev(device);
-	struct net_device *dev = pci_get_drvdata(pdev);
+	struct net_device *dev = dev_get_drvdata(device);
 	struct tg3 *tp = netdev_priv(dev);
 	int err = 0;
 
-- 
2.20.1

