Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9EC4C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 22:21:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CA9821019
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 22:21:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KmUkrLz4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbfCMWVa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 18:21:30 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:48258 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726568AbfCMWVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 18:21:30 -0400
Received: by mail-pf1-f201.google.com with SMTP id v19so2525350pfe.15
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 15:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=b8nrt+CPzo8qCRbcc0fE+vDG4wcOoKaSz2ai/pwTDyw=;
        b=KmUkrLz46+zddnlPY4GUK58JTUAHHyJ33gSWetgzaJZgtB6ocdFS5wuQLO+6Q4rrJg
         KkM3bRHLjzLycb6tHcFRgSNotIimvzJQ+7lCZwJvc7xPOpME3rMScFg9B/Ls/2g6Rct2
         94O6wFFoX/AqInU+ZZTFfJc6VUarGyyKnOPRYE3UGHvyZNH5Ujopf5Sou39soc4nUre5
         rkpGtUFD11t5zpEDaTJ8juyHJ2ImWLmQoK7e7Mig7Aqb3U1VcjrH7COMpMQJ5QGfrVW9
         Ra6t2GvKgm9LdbdeTLWji6XPweTAMpU0rgvvwMRBvtuRq9333FX1kzgPkS+HIeQ2rbeX
         HSFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=b8nrt+CPzo8qCRbcc0fE+vDG4wcOoKaSz2ai/pwTDyw=;
        b=enbA3EDKuMp18VnIbQztsfGrFplbIF6g5xYWWzhRRXU+vUgzkp1WyJFo7kaJHIxFta
         1evHxD90v07PuJPCz++NNHdRuefdRwngOd3GtJKQv7b1MA7NNiGfXvAySus3KmMAfl3Y
         HV3s8FTC57vkJCd3H5zKtjDBvWUFWC2EnwvP8d4i+iwos47A3OhgJdvkyGAi2+DNJGZK
         qCh/1niuSuZ+DihbsYLQIiXVpeIqB/Il68NZ2sNcnDHmPgfdzwqlJUPTeiAuMmeUcQJp
         MzFSDg6BHWnCzENGgKT6WcZIq9waioDaRApjkNdGpPC0cvtXC5xxHy4BGyu0YDZ0vktf
         UGsg==
X-Gm-Message-State: APjAAAX9oS9t0rzLwwOO3h0dXhPIbnyUGJmrBIJBs8+KhpwqeelUdtaQ
        9OEb4dji6BOrGzk/hyGQxIwKOczUoAXS
X-Google-Smtp-Source: APXvYqzqZw2mvTfWv08nuYxq9UFFs79u3MwVRjE9m1Tq/m+jpbNkvMrSXzIeHv974i0VZnUn/8azzwK75I8B
X-Received: by 2002:a63:288:: with SMTP id 130mr17679465pgc.145.1552515689076;
 Wed, 13 Mar 2019 15:21:29 -0700 (PDT)
Date:   Wed, 13 Mar 2019 15:21:23 -0700
Message-Id: <20190313222124.229371-1-rajatja@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.360.g471c308f928-goog
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
functional change. Some code that tries to determine what kind of
CPU this is, has been moved code is moved from pmc_core_probe() to
pmc_core_init().

Signed-off-by: Rajat Jain <rajatja@google.com>
---
This is rebased off
git://git.infradead.org/linux-platform-drivers-x86.git/for-next

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
2.21.0.360.g471c308f928-goog

