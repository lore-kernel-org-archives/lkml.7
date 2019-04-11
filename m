Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F223C10F11
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 00:31:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18F1720818
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 00:31:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pZo8awca"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbfDKAbX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 20:31:23 -0400
Received: from mail-ua1-f74.google.com ([209.85.222.74]:48146 "EHLO
        mail-ua1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbfDKAbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 20:31:23 -0400
Received: by mail-ua1-f74.google.com with SMTP id j45so571627uag.15
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 17:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=fUO4Zc9r9iRqnMXU7pmbDFyIQVT4ORoAx+PUxxOCeLo=;
        b=pZo8awcaLdM4ZsZS0mw7O8Cq7wGTfkcbZizy5b8WGnKrUaoDIMBYs6TRwCTX1Or/gU
         39gg3z/qMcCuqYc22t4noDDTknF4lWdVbR9XXlziXba3NdxkCOttAY5oZQBnMyYWGHUy
         qxu+AE0XsxynevzOP0N2KXgORCfSA3RD2KbVre1k2fzOFAs1evMyHf8SO4uIDg+ET7+2
         ZQnOPOnDaRxCOOgnX58olCG3RdP1pXMUtP97YZjgV5XDmSnn3lH6VzvN845i3e8qILLt
         9Mg2ZHz9o9VBWEv2M+jJCNfJ46xhFUvh5GkmPbthn6n2H44muEAHtZtqhAmN97NBsAcB
         P1pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=fUO4Zc9r9iRqnMXU7pmbDFyIQVT4ORoAx+PUxxOCeLo=;
        b=rwcRIsYplIvfE2ZWKu7mkifAgVNccVYdgwRbDDl/rn/6CSh3N4SHcQb8qmaW9OhPzb
         CAo98PokPAYqbVQ/yovqqKGa4Zyp6QaQsulSnly3ajVXhOR3DjviwS73gTwoA1XhR1um
         6XGrxkUUKm7eDYl7C7Gs3P+icUMpvLizXajjmUzgGrolIa6wctpzblG7BN2rmeShE1Bs
         s1wExyIfe0684l3MjvO67+QlAL4ZSdHRQFASXbNTMHHFOOd0iykDHnjRQlt9RQZ1XoW2
         d/PpfogeNVRXOUvhoxlBGXW3FQu8Yi86We0kszgwe6gEdwwpz3ocSU2sqjxU8lLoKcHl
         5y3A==
X-Gm-Message-State: APjAAAV2rQXWjerZ5AxzqGekUhghlYRiEbykW2zzdLMQcNfafpGmLUeI
        6gOMYLS4MmNVNJBoWBm5thtmV4ske5EE
X-Google-Smtp-Source: APXvYqy/2fjtHKxVyhxosPCF4p9Dx8wnwZu1j0wAj/f00fcr9hZBtZsFmWeG5PfGm5hhhc5KKtguBuo/n9TT
X-Received: by 2002:a1f:6095:: with SMTP id u143mr5418278vkb.13.1554942681882;
 Wed, 10 Apr 2019 17:31:21 -0700 (PDT)
Date:   Wed, 10 Apr 2019 17:31:05 -0700
In-Reply-To: <20190313222124.229371-1-rajatja@google.com>
Message-Id: <20190411003107.52044-1-rajatja@google.com>
Mime-Version: 1.0
References: <20190313222124.229371-1-rajatja@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH v4 1/3] platform/x86: intel_pmc_core: Convert to a platform_driver
From:   Rajat Jain <rajatja@google.com>
To:     Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>,
        Vishwanath Somayaji <vishwanath.somayaji@intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rafael J <rafael.j.wysocki@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     Rajat Jain <rajatja@google.com>, furquan@google.com,
        evgreen@google.com, rajatxjain@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the intel_pmc_core driver to a platform driver, and attach using
the ACPI enumeration method (via the ACPI device "INT33A1").

Change-Id: I2c2c9bbff48a6548f5c96e18d766ffc4633762c0
Signed-off-by: Rajat Jain <rajatja@google.com>
---
v4: put back the x86_match_cpu() method.
v3: Don't instantiate the platform_device. Use ACPI enumeration.
v2: Rephrase the commit log. No code changes.

 drivers/platform/x86/intel_pmc_core.c | 42 ++++++++++++++++++++++-----
 1 file changed, 34 insertions(+), 8 deletions(-)

diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel_pmc_core.c
index 9908d233305e..8da886e17681 100644
--- a/drivers/platform/x86/intel_pmc_core.c
+++ b/drivers/platform/x86/intel_pmc_core.c
@@ -19,6 +19,7 @@
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/pci.h>
+#include <linux/platform_device.h>
 #include <linux/uaccess.h>
 
 #include <asm/cpu_device_id.h>
@@ -854,13 +855,17 @@ static const struct dmi_system_id pmc_core_dmi_table[]  = {
 	{}
 };
 
-static int __init pmc_core_probe(void)
+static int pmc_core_probe(struct platform_device *pdev)
 {
+	static bool device_initialized;
 	struct pmc_dev *pmcdev = &pmc;
 	const struct x86_cpu_id *cpu_id;
 	u64 slp_s0_addr;
 	int err;
 
+	if (device_initialized)
+		return -ENODEV;
+
 	cpu_id = x86_match_cpu(intel_pmc_core_ids);
 	if (!cpu_id)
 		return -ENODEV;
@@ -888,28 +893,49 @@ static int __init pmc_core_probe(void)
 	mutex_init(&pmcdev->lock);
 	pmcdev->pmc_xram_read_bit = pmc_core_check_read_lock_bit();
 
+	dmi_check_system(pmc_core_dmi_table);
+	platform_set_drvdata(pdev, pmcdev);
+
 	err = pmc_core_dbgfs_register(pmcdev);
 	if (err < 0) {
-		pr_warn(" debugfs register failed.\n");
+		dev_warn(&pdev->dev, "debugfs register failed.\n");
 		iounmap(pmcdev->regbase);
 		return err;
 	}
 
-	dmi_check_system(pmc_core_dmi_table);
-	pr_info(" initialized\n");
+	dev_info(&pdev->dev, " initialized\n");
+	device_initialized = true;
+
 	return 0;
 }
-module_init(pmc_core_probe)
 
-static void __exit pmc_core_remove(void)
+static int pmc_core_remove(struct platform_device *pdev)
 {
-	struct pmc_dev *pmcdev = &pmc;
+	struct pmc_dev *pmcdev = platform_get_drvdata(pdev);
 
+	platform_set_drvdata(pdev, NULL);
 	pmc_core_dbgfs_unregister(pmcdev);
 	mutex_destroy(&pmcdev->lock);
 	iounmap(pmcdev->regbase);
+	return 0;
 }
-module_exit(pmc_core_remove)
+
+static const struct acpi_device_id pmc_core_acpi_ids[] = {
+	{"INT33A1", 0}, /* _HID for Intel Power Engine, _CID PNP0D80*/
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, pmc_core_acpi_ids);
+
+static struct platform_driver pmc_core_driver = {
+	.driver = {
+		.name = "pmc_core",
+		.acpi_match_table = ACPI_PTR(pmc_core_acpi_ids),
+	},
+	.probe = pmc_core_probe,
+	.remove = pmc_core_remove,
+};
+
+module_platform_driver(pmc_core_driver);
 
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("Intel PMC Core Driver");
-- 
2.21.0.392.gf8f6787159e-goog

