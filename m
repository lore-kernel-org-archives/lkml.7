Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 811C0C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 01:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 455EF20854
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 01:04:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XtAoOwpe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727395AbfCTBEh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 21:04:37 -0400
Received: from mail-yw1-f74.google.com ([209.85.161.74]:55220 "EHLO
        mail-yw1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727148AbfCTBEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 21:04:36 -0400
Received: by mail-yw1-f74.google.com with SMTP id h3so868389ywe.21
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 18:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=No6fDABdGUuFmTDwPQq43WXJwl+CadMwlN7qs62e0To=;
        b=XtAoOwpejCayTEEzlIvDIi3bWL+UuueswrUG6TJ7/p01/HhQbFMpyi2dh1bZJllBah
         BbYd4z0zk+mPAXzEUXRbxhArDGU+O/fu+wvpent99ED4u/uc5TrLjGRL35NwiVxoJFZa
         MnCs55GoBfWrxbUGwmcpYYPdAhgZ4Vq4mVbV8mwRcpj78bgvNR3LhRerWRE04X/jWrsR
         fpuJwR/ESIb1zdKw42QSWYG8ZgwOenBOPW50haHDkYpenW42C7DzPohT9Ds0FtB8BSvp
         fS4tGF5P/lj7y/4AiJb5a8LvdYiOGdgGlxpGSI3kOld/azyzXntnE6O+1hWeHkg+d4Yg
         5TLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=No6fDABdGUuFmTDwPQq43WXJwl+CadMwlN7qs62e0To=;
        b=p5nxLQG/UC7pa0pQfMypI4ckBkvYlrKNddjRjFAHgRWzq2zhZX6GBltXPUS4parBn3
         dg5Iibj5gCtuwujkqcJCW96Suj8ZSVFnnZJIt9b2bfE1MiAIeFso+UtuNs8WL9uQ9UUE
         Y3gW/yg3/pPs4AUdyhMgvBEEdDrCNGr7oZzlbdrgwsYOGlVL+Mj1dmA8zlQX5tVTEG/M
         PGn8Gl2cx+/k4kCjQTq+LgU1CDhfSpRLiUzOXq2965HI87xneCQCw+ifr+xrWDrymHMy
         DlsZRq3Q6k2PyWYuEWWt9XcVARWT6oE+JUrN5I3zv60CIqkbxOc9H14TeWnL92LTgYsQ
         q0CA==
X-Gm-Message-State: APjAAAWS+6dqXhF5fqisa/KKykVK4BIq5I5l1S/2D/1aaAhvydLVK30a
        xewAjTN8E6SHhpWnGdQnxXtBYXUhfqJo
X-Google-Smtp-Source: APXvYqwTGjANcNze7Rd9PCENWzdfwChccFyp6mQEvrdiHBvULiJnHJLm8zl16MyuolYoqfYI9Y4008iEtYEg
X-Received: by 2002:a25:2ac1:: with SMTP id q184mr1517297ybq.35.1553043875938;
 Tue, 19 Mar 2019 18:04:35 -0700 (PDT)
Date:   Tue, 19 Mar 2019 18:04:30 -0700
In-Reply-To: <20190313222124.229371-1-rajatja@google.com>
Message-Id: <20190320010431.19833-1-rajatja@google.com>
Mime-Version: 1.0
References: <20190313222124.229371-1-rajatja@google.com>
X-Mailer: git-send-email 2.21.0.225.g810b269d1ac-goog
Subject: [PATCH 1/2] platform/x86: intel_pmc_core: Convert to a platform_driver
From:   Rajat Jain <rajatja@google.com>
To:     Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>,
        Vishwanath Somayaji <vishwanath.somayaji@intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rajat Jain <rajatja@google.com>, furquan@google.com,
        evgreen@google.com, rajatxjain@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the intel_pmc_core driver to a platform driver. There is no
functional change. Some code that tried to determine the kind of
CPU, has been moved from pmc_core_probe() to pmc_core_init().

Signed-off-by: Rajat Jain <rajatja@google.com>
---
v2: Rephrase the commit log. No code changes.

 drivers/platform/x86/intel_pmc_core.c | 93 ++++++++++++++++++++-------
 1 file changed, 68 insertions(+), 25 deletions(-)

diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel_pmc_core.c
index f2c621b55f49..55578d07610c 100644
--- a/drivers/platform/x86/intel_pmc_core.c
+++ b/drivers/platform/x86/intel_pmc_core.c
@@ -19,6 +19,7 @@
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/pci.h>
+#include <linux/platform_device.h>
 #include <linux/uaccess.h>
 
 #include <asm/cpu_device_id.h>
@@ -854,12 +855,59 @@ static const struct dmi_system_id pmc_core_dmi_table[]  = {
 	{}
 };
 
-static int __init pmc_core_probe(void)
+static int pmc_core_probe(struct platform_device *pdev)
 {
-	struct pmc_dev *pmcdev = &pmc;
+	struct pmc_dev *pmcdev = platform_get_drvdata(pdev);
+	int err;
+
+	pmcdev->regbase = ioremap(pmcdev->base_addr,
+				  pmcdev->map->regmap_length);
+	if (!pmcdev->regbase)
+		return -ENOMEM;
+
+	mutex_init(&pmcdev->lock);
+	pmcdev->pmc_xram_read_bit = pmc_core_check_read_lock_bit();
+
+	err = pmc_core_dbgfs_register(pmcdev);
+	if (err < 0) {
+		dev_warn(&pdev->dev, "debugfs register failed.\n");
+		iounmap(pmcdev->regbase);
+		return err;
+	}
+
+	dmi_check_system(pmc_core_dmi_table);
+	dev_info(&pdev->dev, " initialized\n");
+	return 0;
+}
+
+static int pmc_core_remove(struct platform_device *pdev)
+{
+	struct pmc_dev *pmcdev = platform_get_drvdata(pdev);
+
+	pmc_core_dbgfs_unregister(pmcdev);
+	mutex_destroy(&pmcdev->lock);
+	iounmap(pmcdev->regbase);
+	return 0;
+}
+
+static struct platform_driver pmc_core_driver = {
+	.driver = {
+		.name = "pmc_core",
+	},
+	.probe = pmc_core_probe,
+	.remove = pmc_core_remove,
+};
+
+static struct platform_device pmc_core_device = {
+	.name           = "pmc_core",
+};
+
+static int __init pmc_core_init(void)
+{
+	int ret;
 	const struct x86_cpu_id *cpu_id;
+	struct pmc_dev *pmcdev = &pmc;
 	u64 slp_s0_addr;
-	int err;
 
 	cpu_id = x86_match_cpu(intel_pmc_core_ids);
 	if (!cpu_id)
@@ -880,36 +928,31 @@ static int __init pmc_core_probe(void)
 	else
 		pmcdev->base_addr = slp_s0_addr - pmcdev->map->slp_s0_offset;
 
-	pmcdev->regbase = ioremap(pmcdev->base_addr,
-				  pmcdev->map->regmap_length);
-	if (!pmcdev->regbase)
-		return -ENOMEM;
+	platform_set_drvdata(&pmc_core_device, pmcdev);
 
-	mutex_init(&pmcdev->lock);
-	pmcdev->pmc_xram_read_bit = pmc_core_check_read_lock_bit();
+	ret = platform_device_register(&pmc_core_device);
+	if (ret)
+		return ret;
 
-	err = pmc_core_dbgfs_register(pmcdev);
-	if (err < 0) {
-		pr_warn(" debugfs register failed.\n");
-		iounmap(pmcdev->regbase);
-		return err;
-	}
+	ret = platform_driver_register(&pmc_core_driver);
+	if (ret)
+		goto out_remove_dev;
 
-	dmi_check_system(pmc_core_dmi_table);
-	pr_info(" initialized\n");
 	return 0;
+
+out_remove_dev:
+	platform_device_unregister(&pmc_core_device);
+	return ret;
 }
-module_init(pmc_core_probe)
 
-static void __exit pmc_core_remove(void)
+static void __init pmc_core_exit(void)
 {
-	struct pmc_dev *pmcdev = &pmc;
-
-	pmc_core_dbgfs_unregister(pmcdev);
-	mutex_destroy(&pmcdev->lock);
-	iounmap(pmcdev->regbase);
+	platform_driver_unregister(&pmc_core_driver);
+	platform_device_unregister(&pmc_core_device);
 }
-module_exit(pmc_core_remove)
+
+module_init(pmc_core_init);
+module_exit(pmc_core_exit);
 
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("Intel PMC Core Driver");
-- 
2.21.0.225.g810b269d1ac-goog

