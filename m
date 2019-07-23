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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27E10C7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 12:46:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E21A321903
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 12:46:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RZGc6b++"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389753AbfGWMqd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 08:46:33 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34476 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727724AbfGWMqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 08:46:33 -0400
Received: by mail-pl1-f196.google.com with SMTP id i2so20598449plt.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 05:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KQTE/ixRUrNiBtj/aCpsC+f5UpJn3iQqRlhswTO8qG0=;
        b=RZGc6b++3eT519FJQCYX0Qiv89Cz3sJEGeYm1DTXyPOgKYWbnjOyLO2NbiTqowj+vz
         6T4+VwCOCOU8IzCc16KkHaAizNB3t8mNaTBNRcUI72Q3gxQvB1U5sSGGc+/nNYADfSnR
         DZPV4bJCsxKQDqO+d+ksBbWMz9LdgxrkMGDEhTRdvzGA5eIdYupgOLj5ENsKfjbCTLB2
         N4PH4wn7FyLmygPFa7gYSTMZ9dGoszoVmYHgAiC+8LRBneMj8FZRbM86GQuERQnSZ+L2
         SWYNlZN5gW5+JXk7jU8XhWiGiIuyv9H4QwC9I4+vEyUpGMDO9ESpUK6zHI4PGdVkJqkf
         P2jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KQTE/ixRUrNiBtj/aCpsC+f5UpJn3iQqRlhswTO8qG0=;
        b=c68E7dkikFPJKzk1F+mWLApaQWlLrboxfY11X5VdzT5UcYuFw4Mmq0T3Y3WSx3Bmmi
         qTq6yGORqqYszK0xrqwV4VNeoXvDKwliQ1B68QkCJU4gXW492dsK9xKqBcpT5wtqOQU2
         JLy86mz5la2x/Lww7pll9UprnNfaC3oJdlZZIa3X6GcCDqSkLlj4M3e6HvIDbfjNoJjC
         mjK5e6SWO83PK5e8w3K2u/oJ5eJKXNdz8n81vZQhO7vsrnsReftAKoOBe8MCpvpNrZV8
         r6kLUEM/NXB3jqUoeAQKUeDyYE7bLtGHCPDqCLBB0qHb+TrcfgsMjYLE/yRbboLYPrW4
         lOsA==
X-Gm-Message-State: APjAAAV7xn3scKWWA7Qd1WaamxQ1Rw6w3M338T50qZlWqS1Z95+yj7s2
        TYcrLI97GnK80WEM+tvJFO4=
X-Google-Smtp-Source: APXvYqy3OJk9lLMqnzn7EXeNsHulNCCOU0xxWAXhmI09ll8Rb/2t18RMfQ9zJIa/iytybS/wwAcjxg==
X-Received: by 2002:a17:902:aa41:: with SMTP id c1mr79846178plr.201.1563885992294;
        Tue, 23 Jul 2019 05:46:32 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id c69sm53818955pje.6.2019.07.23.05.46.30
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 23 Jul 2019 05:46:31 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Tomas Winkler <tomas.winkler@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH v2] mei: Use dev_get_drvdata where possible
Date:   Tue, 23 Jul 2019 20:46:27 +0800
Message-Id: <20190723124627.24671-1-hslester96@gmail.com>
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
Changes in v2:
  - Split v1 into different subsystems

 drivers/misc/mei/pci-me.c  | 19 ++++++++-----------
 drivers/misc/mei/pci-txe.c | 19 ++++++++-----------
 2 files changed, 16 insertions(+), 22 deletions(-)

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

