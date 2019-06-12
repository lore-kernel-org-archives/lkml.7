Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD1A6C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 12:13:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6C4A217F4
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 12:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560341608;
	bh=mnEMQqcIZyYYy6tRZgovJ/xEPKXIK1opq3MoAC4IEm4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=D3H1ZYNSomZ0AAuMhC+g6AM2gVWm0VCKmB3bp/96kM+Cs832JMTIHUb/u9V0swW6U
	 pl/iRbi0pLRFzhR9YLGSnTrrfQKkPHaYlLwLhmOfaWqPMlGNaVP1wcc4UwUMEqZglR
	 riwoh8k0kdj+wAnclc5+xvpwfyHo65MNMrNJNrVc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438670AbfFLMN1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 08:13:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:53614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728433AbfFLMNZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 08:13:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA76921019;
        Wed, 12 Jun 2019 12:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560341604;
        bh=mnEMQqcIZyYYy6tRZgovJ/xEPKXIK1opq3MoAC4IEm4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HzceL25iFwN+uLKR4EGITNhSGQ6T7NO/oZ3loXq20Fo/OVblYG4fLfmNcOi2mAKSl
         LzF1AkWUcufE9swWLie2GPear9RDY+LUOdxIqrEcYE6w59yAhETcZX1GdzCzbQOhsj
         YExdh3JZuvU3OinDTeHwj7+jtLti3MKnCMn1Rpww=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     dvhart@infradead.org, andy@infradead.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/8] platform: x86: pmc_atom: no need to check return value of debugfs_create functions
Date:   Wed, 12 Jun 2019 14:12:56 +0200
Message-Id: <20190612121258.19535-6-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190612121258.19535-1-gregkh@linuxfoundation.org>
References: <20190612121258.19535-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When calling debugfs functions, there is no need to ever check the
return value.  The function can work or not, but the code logic should
never do something different based on this.

Cc: Darren Hart <dvhart@infradead.org>
Cc: Andy Shevchenko <andy@infradead.org>
Cc: platform-driver-x86@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/platform/x86/pmc_atom.c | 43 ++++++++-------------------------
 1 file changed, 10 insertions(+), 33 deletions(-)

diff --git a/drivers/platform/x86/pmc_atom.c b/drivers/platform/x86/pmc_atom.c
index b1d804376237..2104e1ad38d9 100644
--- a/drivers/platform/x86/pmc_atom.c
+++ b/drivers/platform/x86/pmc_atom.c
@@ -350,45 +350,24 @@ static int pmc_sleep_tmr_show(struct seq_file *s, void *unused)
 
 DEFINE_SHOW_ATTRIBUTE(pmc_sleep_tmr);
 
-static void pmc_dbgfs_unregister(struct pmc_dev *pmc)
+static void pmc_dbgfs_register(struct pmc_dev *pmc)
 {
-	debugfs_remove_recursive(pmc->dbgfs_dir);
-}
-
-static int pmc_dbgfs_register(struct pmc_dev *pmc)
-{
-	struct dentry *dir, *f;
+	struct dentry *dir;
 
 	dir = debugfs_create_dir("pmc_atom", NULL);
-	if (!dir)
-		return -ENOMEM;
 
 	pmc->dbgfs_dir = dir;
 
-	f = debugfs_create_file("dev_state", S_IFREG | S_IRUGO,
-				dir, pmc, &pmc_dev_state_fops);
-	if (!f)
-		goto err;
-
-	f = debugfs_create_file("pss_state", S_IFREG | S_IRUGO,
-				dir, pmc, &pmc_pss_state_fops);
-	if (!f)
-		goto err;
-
-	f = debugfs_create_file("sleep_state", S_IFREG | S_IRUGO,
-				dir, pmc, &pmc_sleep_tmr_fops);
-	if (!f)
-		goto err;
-
-	return 0;
-err:
-	pmc_dbgfs_unregister(pmc);
-	return -ENODEV;
+	debugfs_create_file("dev_state", S_IFREG | S_IRUGO, dir, pmc,
+			    &pmc_dev_state_fops);
+	debugfs_create_file("pss_state", S_IFREG | S_IRUGO, dir, pmc,
+			    &pmc_pss_state_fops);
+	debugfs_create_file("sleep_state", S_IFREG | S_IRUGO, dir, pmc,
+			    &pmc_sleep_tmr_fops);
 }
 #else
-static int pmc_dbgfs_register(struct pmc_dev *pmc)
+static void pmc_dbgfs_register(struct pmc_dev *pmc)
 {
-	return 0;
 }
 #endif /* CONFIG_DEBUG_FS */
 
@@ -500,9 +479,7 @@ static int pmc_setup_dev(struct pci_dev *pdev, const struct pci_device_id *ent)
 	/* PMC hardware registers setup */
 	pmc_hw_reg_setup(pmc);
 
-	ret = pmc_dbgfs_register(pmc);
-	if (ret)
-		dev_warn(&pdev->dev, "debugfs register failed\n");
+	pmc_dbgfs_register(pmc);
 
 	/* Register platform clocks - PMC_PLT_CLK [0..5] */
 	ret = pmc_setup_clks(pdev, pmc->regmap, data);
-- 
2.22.0

