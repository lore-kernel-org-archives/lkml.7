Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85E41C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 12:13:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DFC1208C4
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 12:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560341612;
	bh=H4DWvHq5GmInPvRkYviYUkhahmtQnlyzUK8i8dLGyQI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ankpTO5wmXYAOfN+VQ6MgrYAgKiyseZ/DnH/XAIqcsn4LWfa7DRJUdjEVP9sm3his
	 otUF2EUpPCdgUqWr2HF8opeyIFe8vVpcyEqzzLlsPlIjkEppIZEqewpzAO01Q4QBjK
	 ulX/3VFN9erqzIh9okXoWqft0Ix6n6cCIxlZjwAE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438685AbfFLMNb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 08:13:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:53662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727826AbfFLMN1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 08:13:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1C75208C4;
        Wed, 12 Jun 2019 12:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560341607;
        bh=H4DWvHq5GmInPvRkYviYUkhahmtQnlyzUK8i8dLGyQI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=COp3l3ZrH3oGWLyE5ohcNxTV8qttbGU/czbXk98sKnQ2Nv9WntV4UFiO/2iw1c3VK
         KqN121BQvCa2r62aBL+izOxuOkMnNBzbwoy40WXHquCGkoLdEe9+9IcHVNazEg3l2I
         IfJZU3MM3ag6s0RZ8w21/jh/CW18lkMohOOK3rUQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     dvhart@infradead.org, andy@infradead.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>,
        Vishwanath Somayaji <vishwanath.somayaji@intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 7/8] platform: x86: intel_pmc: no need to check return value of debugfs_create functions
Date:   Wed, 12 Jun 2019 14:12:57 +0200
Message-Id: <20190612121258.19535-7-gregkh@linuxfoundation.org>
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

Cc: Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>
Cc: Vishwanath Somayaji <vishwanath.somayaji@intel.com>
Cc: Darren Hart <dvhart@infradead.org>
Cc: Andy Shevchenko <andy@infradead.org>
Cc: platform-driver-x86@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/platform/x86/intel_pmc_core.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel_pmc_core.c
index 1d902230ba61..27d6470e43ec 100644
--- a/drivers/platform/x86/intel_pmc_core.c
+++ b/drivers/platform/x86/intel_pmc_core.c
@@ -753,14 +753,11 @@ static void pmc_core_dbgfs_unregister(struct pmc_dev *pmcdev)
 	debugfs_remove_recursive(pmcdev->dbgfs_dir);
 }
 
-static int pmc_core_dbgfs_register(struct pmc_dev *pmcdev)
+static void pmc_core_dbgfs_register(struct pmc_dev *pmcdev)
 {
 	struct dentry *dir;
 
 	dir = debugfs_create_dir("pmc_core", NULL);
-	if (!dir)
-		return -ENOMEM;
-
 	pmcdev->dbgfs_dir = dir;
 
 	debugfs_create_file("slp_s0_residency_usec", 0444, dir, pmcdev,
@@ -794,13 +791,10 @@ static int pmc_core_dbgfs_register(struct pmc_dev *pmcdev)
 		debugfs_create_bool("slp_s0_dbg_latch", 0644,
 				    dir, &slps0_dbg_latch);
 	}
-
-	return 0;
 }
 #else
-static inline int pmc_core_dbgfs_register(struct pmc_dev *pmcdev)
+static inline void pmc_core_dbgfs_register(struct pmc_dev *pmcdev)
 {
-	return 0;
 }
 
 static inline void pmc_core_dbgfs_unregister(struct pmc_dev *pmcdev)
@@ -862,7 +856,6 @@ static int pmc_core_probe(struct platform_device *pdev)
 	struct pmc_dev *pmcdev = &pmc;
 	const struct x86_cpu_id *cpu_id;
 	u64 slp_s0_addr;
-	int err;
 
 	if (device_initialized)
 		return -ENODEV;
@@ -896,12 +889,7 @@ static int pmc_core_probe(struct platform_device *pdev)
 	pmcdev->pmc_xram_read_bit = pmc_core_check_read_lock_bit();
 	dmi_check_system(pmc_core_dmi_table);
 
-	err = pmc_core_dbgfs_register(pmcdev);
-	if (err < 0) {
-		dev_warn(&pdev->dev, "debugfs register failed.\n");
-		iounmap(pmcdev->regbase);
-		return err;
-	}
+	pmc_core_dbgfs_register(pmcdev);
 
 	device_initialized = true;
 	dev_info(&pdev->dev, " initialized\n");
-- 
2.22.0

