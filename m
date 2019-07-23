Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 101B5C7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 12:19:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C80D82238E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 12:19:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FQWi23dc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389686AbfGWMT5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 08:19:57 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46941 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387839AbfGWMT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 08:19:57 -0400
Received: by mail-pg1-f194.google.com with SMTP id k189so313025pgk.13
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 05:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=00zWsVCiRcL8XnZGBOUu0LnqcxXNZjHUwxVDcj34sCg=;
        b=FQWi23dcGYXrzYwsr1qGSwvJL8/OM1OmCeE4nGg5qzDIBQ5yg1Yl9yio4klE/suSHi
         jWNBMq/J4ZAukhp3E+VgyKKJNSuBPIzQZZSg+S5Fq8fMYrVLWHRt3m7gqjUkkhPvgJNU
         4mrjbU5inbGrckAP9HA84C+VOBfyfYc4Ij4jEwnKriIUOAYqzMC+mqLlqlSiMYt++vGu
         Q/PIjHbjKssBUwsXJRz2eaytXt43D7xdeD3d7CHgAek90nDl021gxdVjesg32EGsekk6
         3ZF/jAibtUGvICN2trH/VOfcX0yy7+3Ll8r39kUD1XiNvoArkylQPpLjd7VriR+LPwJ5
         snXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=00zWsVCiRcL8XnZGBOUu0LnqcxXNZjHUwxVDcj34sCg=;
        b=ZX3NDQ9O/wOVPcYzMWWMU+B9uYW/58bQ0Q0osS0uR5+K0grBEPH4pn+UGX90H77unx
         24k2n6jkbwz94c0YKOWywyM+p8V/H1sDAEWb2rVUwLSaLXJeu+yNJwlJ5jS1NcGFGZPx
         DlvRe8eAEEw8h+YXSGEuR1c5M+/sohLo9q2mm0T5TOj73NQ07yRyNW8Nlt7Ome5DWLeS
         1rx6XpRJBK9NF0uQAIJJYuOxafGe77WtEESFHJ4nlVeQ8aMifQJ/w/Am4e4EbEkpVX5F
         u78AaMGyWEg1y222HqIYPvTf/pxTjU3NAt8ASh4+ZoiWlGwIjJNuHn22My6G+ALHyggW
         WG2Q==
X-Gm-Message-State: APjAAAVEgAzQ1Szt3YSu/iQTgwxD1zQVjazjD3AX3OPnF/0RfBx6LcmD
        OqXUgHG/RIQIr4UArBZlb1o=
X-Google-Smtp-Source: APXvYqwRrh/U6FpHgKTpVmzvR2Ck2d24UzNYtDt/vox2Ks0SkRYzKPkJ7xUwCtZ5/BAty+rNptAfxw==
X-Received: by 2002:a17:90a:258b:: with SMTP id k11mr78670049pje.110.1563884396485;
        Tue, 23 Jul 2019 05:19:56 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id l26sm31602002pgb.90.2019.07.23.05.19.53
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 23 Jul 2019 05:19:55 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oded Gabbay <oded.gabbay@gmail.com>,
        Tomas Winkler <tomas.winkler@intel.com>,
        linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] misc: Use dev_get_drvdata where possible
Date:   Tue, 23 Jul 2019 20:19:49 +0800
Message-Id: <20190723121949.22021-1-hslester96@gmail.com>
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
 drivers/misc/cardreader/alcor_pci.c      |  6 ++----
 drivers/misc/habanalabs/habanalabs_drv.c |  6 ++----
 drivers/misc/mei/pci-me.c                | 19 ++++++++-----------
 drivers/misc/mei/pci-txe.c               | 19 ++++++++-----------
 4 files changed, 20 insertions(+), 30 deletions(-)

diff --git a/drivers/misc/cardreader/alcor_pci.c b/drivers/misc/cardreader/alcor_pci.c
index bcb10fa4bc3a..259fe1dfec03 100644
--- a/drivers/misc/cardreader/alcor_pci.c
+++ b/drivers/misc/cardreader/alcor_pci.c
@@ -334,8 +334,7 @@ static void alcor_pci_remove(struct pci_dev *pdev)
 #ifdef CONFIG_PM_SLEEP
 static int alcor_suspend(struct device *dev)
 {
-	struct pci_dev *pdev = to_pci_dev(dev);
-	struct alcor_pci_priv *priv = pci_get_drvdata(pdev);
+	struct alcor_pci_priv *priv = dev_get_drvdata(dev);
 
 	alcor_pci_aspm_ctrl(priv, 1);
 	return 0;
@@ -344,8 +343,7 @@ static int alcor_suspend(struct device *dev)
 static int alcor_resume(struct device *dev)
 {
 
-	struct pci_dev *pdev = to_pci_dev(dev);
-	struct alcor_pci_priv *priv = pci_get_drvdata(pdev);
+	struct alcor_pci_priv *priv = dev_get_drvdata(dev);
 
 	alcor_pci_aspm_ctrl(priv, 0);
 	return 0;
diff --git a/drivers/misc/habanalabs/habanalabs_drv.c b/drivers/misc/habanalabs/habanalabs_drv.c
index 6f6dbe93f1df..678f61646ca9 100644
--- a/drivers/misc/habanalabs/habanalabs_drv.c
+++ b/drivers/misc/habanalabs/habanalabs_drv.c
@@ -295,8 +295,7 @@ void destroy_hdev(struct hl_device *hdev)
 
 static int hl_pmops_suspend(struct device *dev)
 {
-	struct pci_dev *pdev = to_pci_dev(dev);
-	struct hl_device *hdev = pci_get_drvdata(pdev);
+	struct hl_device *hdev = dev_get_drvdata(dev);
 
 	pr_debug("Going to suspend PCI device\n");
 
@@ -310,8 +309,7 @@ static int hl_pmops_suspend(struct device *dev)
 
 static int hl_pmops_resume(struct device *dev)
 {
-	struct pci_dev *pdev = to_pci_dev(dev);
-	struct hl_device *hdev = pci_get_drvdata(pdev);
+	struct hl_device *hdev = dev_get_drvdata(dev);
 
 	pr_debug("Going to resume PCI device\n");
 
diff --git a/drivers/misc/mei/pci-me.c b/drivers/misc/mei/pci-me.c
index 7a2b3545a7f9..6c7d54ab9bc5 100644
--- a/drivers/misc/mei/pci-me.c
+++ b/drivers/misc/mei/pci-me.c
@@ -378,12 +378,11 @@ static int mei_me_pci_resume(struct device *device)
 #ifdef CONFIG_PM
 static int mei_me_pm_runtime_idle(struct device *device)
 {
-	struct pci_dev *pdev = to_pci_dev(device);
 	struct mei_device *dev;
 
-	dev_dbg(&pdev->dev, "rpm: me: runtime_idle\n");
+	dev_dbg(device, "rpm: me: runtime_idle\n");
 
-	dev = pci_get_drvdata(pdev);
+	dev = dev_get_drvdata(device);
 	if (!dev)
 		return -ENODEV;
 	if (mei_write_is_idle(dev))
@@ -394,13 +393,12 @@ static int mei_me_pm_runtime_idle(struct device *device)
 
 static int mei_me_pm_runtime_suspend(struct device *device)
 {
-	struct pci_dev *pdev = to_pci_dev(device);
 	struct mei_device *dev;
 	int ret;
 
-	dev_dbg(&pdev->dev, "rpm: me: runtime suspend\n");
+	dev_dbg(device, "rpm: me: runtime suspend\n");
 
-	dev = pci_get_drvdata(pdev);
+	dev = dev_get_drvdata(device);
 	if (!dev)
 		return -ENODEV;
 
@@ -413,7 +411,7 @@ static int mei_me_pm_runtime_suspend(struct device *device)
 
 	mutex_unlock(&dev->device_lock);
 
-	dev_dbg(&pdev->dev, "rpm: me: runtime suspend ret=%d\n", ret);
+	dev_dbg(device, "rpm: me: runtime suspend ret=%d\n", ret);
 
 	if (ret && ret != -EAGAIN)
 		schedule_work(&dev->reset_work);
@@ -423,13 +421,12 @@ static int mei_me_pm_runtime_suspend(struct device *device)
 
 static int mei_me_pm_runtime_resume(struct device *device)
 {
-	struct pci_dev *pdev = to_pci_dev(device);
 	struct mei_device *dev;
 	int ret;
 
-	dev_dbg(&pdev->dev, "rpm: me: runtime resume\n");
+	dev_dbg(device, "rpm: me: runtime resume\n");
 
-	dev = pci_get_drvdata(pdev);
+	dev = dev_get_drvdata(device);
 	if (!dev)
 		return -ENODEV;
 
@@ -439,7 +436,7 @@ static int mei_me_pm_runtime_resume(struct device *device)
 
 	mutex_unlock(&dev->device_lock);
 
-	dev_dbg(&pdev->dev, "rpm: me: runtime resume ret = %d\n", ret);
+	dev_dbg(device, "rpm: me: runtime resume ret = %d\n", ret);
 
 	if (ret)
 		schedule_work(&dev->reset_work);
diff --git a/drivers/misc/mei/pci-txe.c b/drivers/misc/mei/pci-txe.c
index 2e37fc2e0fa8..f1c16a587495 100644
--- a/drivers/misc/mei/pci-txe.c
+++ b/drivers/misc/mei/pci-txe.c
@@ -276,12 +276,11 @@ static int mei_txe_pci_resume(struct device *device)
 #ifdef CONFIG_PM
 static int mei_txe_pm_runtime_idle(struct device *device)
 {
-	struct pci_dev *pdev = to_pci_dev(device);
 	struct mei_device *dev;
 
-	dev_dbg(&pdev->dev, "rpm: txe: runtime_idle\n");
+	dev_dbg(device, "rpm: txe: runtime_idle\n");
 
-	dev = pci_get_drvdata(pdev);
+	dev = dev_get_drvdata(device);
 	if (!dev)
 		return -ENODEV;
 	if (mei_write_is_idle(dev))
@@ -291,13 +290,12 @@ static int mei_txe_pm_runtime_idle(struct device *device)
 }
 static int mei_txe_pm_runtime_suspend(struct device *device)
 {
-	struct pci_dev *pdev = to_pci_dev(device);
 	struct mei_device *dev;
 	int ret;
 
-	dev_dbg(&pdev->dev, "rpm: txe: runtime suspend\n");
+	dev_dbg(device, "rpm: txe: runtime suspend\n");
 
-	dev = pci_get_drvdata(pdev);
+	dev = dev_get_drvdata(device);
 	if (!dev)
 		return -ENODEV;
 
@@ -310,7 +308,7 @@ static int mei_txe_pm_runtime_suspend(struct device *device)
 
 	/* keep irq on we are staying in D0 */
 
-	dev_dbg(&pdev->dev, "rpm: txe: runtime suspend ret=%d\n", ret);
+	dev_dbg(device, "rpm: txe: runtime suspend ret=%d\n", ret);
 
 	mutex_unlock(&dev->device_lock);
 
@@ -322,13 +320,12 @@ static int mei_txe_pm_runtime_suspend(struct device *device)
 
 static int mei_txe_pm_runtime_resume(struct device *device)
 {
-	struct pci_dev *pdev = to_pci_dev(device);
 	struct mei_device *dev;
 	int ret;
 
-	dev_dbg(&pdev->dev, "rpm: txe: runtime resume\n");
+	dev_dbg(device, "rpm: txe: runtime resume\n");
 
-	dev = pci_get_drvdata(pdev);
+	dev = dev_get_drvdata(device);
 	if (!dev)
 		return -ENODEV;
 
@@ -340,7 +337,7 @@ static int mei_txe_pm_runtime_resume(struct device *device)
 
 	mutex_unlock(&dev->device_lock);
 
-	dev_dbg(&pdev->dev, "rpm: txe: runtime resume ret = %d\n", ret);
+	dev_dbg(device, "rpm: txe: runtime resume ret = %d\n", ret);
 
 	if (ret)
 		schedule_work(&dev->reset_work);
-- 
2.20.1

