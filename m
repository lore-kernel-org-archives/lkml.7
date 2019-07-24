Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F1D2C7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 13:18:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4448C21926
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 13:18:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mWXv2Fd6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728552AbfGXNSP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 09:18:15 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39390 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbfGXNSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 09:18:15 -0400
Received: by mail-pl1-f194.google.com with SMTP id b7so22042432pls.6
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 06:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N3CuhKfaCXS5+RVrtPUBsSZgW2TO6UsJpB2dnxfofao=;
        b=mWXv2Fd69Dx7tedigK8/WeV6VI82/JtB6GpqkRaH9rKQZ5H78ZEawRZK855Erpf1Na
         Gl9ftOihNchEgmAxYODJDYb0XBW/5VdbQE2ZIdys5VgPnlEfbDHuNgaEWw90ECVydg4Q
         +BwWeu9LrAfvl/zLejI+mbUCnXlS8s6MZ9JL6arNrOpG0GAZH2IxGyIEd0j343in+EEI
         HKOud7C5ivxQ68s/CASaou/EXqkPQaf11axeDV2yQev0IqxzNkpMLg78cUW+7lnwJys6
         zeKMpMwCMEea3gaMSgMMXWE0VkeWlzDJFZCV93CvLGhOj292FkrQ5hbPqfjNs7Q+fxlv
         gH8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N3CuhKfaCXS5+RVrtPUBsSZgW2TO6UsJpB2dnxfofao=;
        b=tfHWhYcZKaedGw+1VQQfgKKfZoYloqHlSrOVBb4mFh67LKAWrqDuTx0PLfhHEgndCu
         IyQ4j9qL9AApbgJ9Z/wIn74V69lPmieftkFCz0A0RUSSmSH2RdwvDF0dwA1pYYzKcUBq
         aA4L/EIlNEJZiUIj7vsvTmQbAGS+G7kXRQuC6tPNlTlO+TtvqL44JkEK8un9X+mL2kqG
         QrKbWEKmh/c17Wc+gYOlNnqz4+6yqlBnfyQoE1tzDBrlcHo3pzuX2MgcHKZzQe8AKkpV
         I87rEk2P14ClV+AiGWdOIa7tKhcZyF5zvviH0ghZVxDGmW2UYvhgAeIkFBoSqhZOXCNh
         YmrA==
X-Gm-Message-State: APjAAAXEWkVDOEkosiSgE+a2UGHfZyiyrgAFrZxf3h3pEBkBZ5BMe9FL
        Hd17KqWnSMVs3USIu5GwumA=
X-Google-Smtp-Source: APXvYqzJmlxztDm3VDJebeeVUtWDQjovdC19XHfKfM5KjvlfygfLsp+aVP/1nJG5fd0n1sC7gzq/JQ==
X-Received: by 2002:a17:902:361:: with SMTP id 88mr87175474pld.123.1563974294729;
        Wed, 24 Jul 2019 06:18:14 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id u1sm43313934pgi.28.2019.07.24.06.18.12
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 06:18:14 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] thunderbolt: Use dev_get_drvdata where possible
Date:   Wed, 24 Jul 2019 21:18:09 +0800
Message-Id: <20190724131809.1818-1-hslester96@gmail.com>
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
 drivers/thunderbolt/nhi.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/thunderbolt/nhi.c b/drivers/thunderbolt/nhi.c
index 27fbe62c7ddd..76f490759944 100644
--- a/drivers/thunderbolt/nhi.c
+++ b/drivers/thunderbolt/nhi.c
@@ -847,8 +847,7 @@ static irqreturn_t nhi_msi(int irq, void *data)
 
 static int nhi_suspend_noirq(struct device *dev)
 {
-	struct pci_dev *pdev = to_pci_dev(dev);
-	struct tb *tb = pci_get_drvdata(pdev);
+	struct tb *tb = dev_get_drvdata(dev);
 
 	return tb_domain_suspend_noirq(tb);
 }
@@ -889,40 +888,36 @@ static int nhi_resume_noirq(struct device *dev)
 
 static int nhi_suspend(struct device *dev)
 {
-	struct pci_dev *pdev = to_pci_dev(dev);
-	struct tb *tb = pci_get_drvdata(pdev);
+	struct tb *tb = dev_get_drvdata(dev);
 
 	return tb_domain_suspend(tb);
 }
 
 static void nhi_complete(struct device *dev)
 {
-	struct pci_dev *pdev = to_pci_dev(dev);
-	struct tb *tb = pci_get_drvdata(pdev);
+	struct tb *tb = dev_get_drvdata(dev);
 
 	/*
 	 * If we were runtime suspended when system suspend started,
 	 * schedule runtime resume now. It should bring the domain back
 	 * to functional state.
 	 */
-	if (pm_runtime_suspended(&pdev->dev))
-		pm_runtime_resume(&pdev->dev);
+	if (pm_runtime_suspended(dev))
+		pm_runtime_resume(dev);
 	else
 		tb_domain_complete(tb);
 }
 
 static int nhi_runtime_suspend(struct device *dev)
 {
-	struct pci_dev *pdev = to_pci_dev(dev);
-	struct tb *tb = pci_get_drvdata(pdev);
+	struct tb *tb = dev_get_drvdata(dev);
 
 	return tb_domain_runtime_suspend(tb);
 }
 
 static int nhi_runtime_resume(struct device *dev)
 {
-	struct pci_dev *pdev = to_pci_dev(dev);
-	struct tb *tb = pci_get_drvdata(pdev);
+	struct tb *tb = dev_get_drvdata(dev);
 
 	nhi_enable_int_throttling(tb->nhi);
 	return tb_domain_runtime_resume(tb);
-- 
2.20.1

