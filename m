Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF92C10F11
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 00:37:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E828020818
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 00:37:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IcJskFP5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbfDKAhs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 20:37:48 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:37072 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725982AbfDKAhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 20:37:48 -0400
Received: by mail-pl1-f201.google.com with SMTP id v5so2889596plo.4
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 17:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=WuCLO1xjYGpgkgYX+R5A6aWXWpQcgwwbzIbNqQedb3g=;
        b=IcJskFP59nqQ5mMXNq/5o//icwqeVqId2wqPiIY3EhJX2irh1kELAK854GGCOjV/bZ
         6HBSJZJF0IYJtNS0SuFmbIf/NTXRo72PCy8hrI65ij3MND33zs969MAU7QFpeaxRzDmJ
         npgDP39/zC8UvwE/68CJRJ/Y+TCSqBBiyJn95MuznFkAeLBQSKJBOR3KZKKdMAJlaqnl
         XC06ww6anU8YSYlDonGUu/g1RS/N5b7Zs1IKqheSZRuBObzsFAefwSheZgFVD2Q5Ks6T
         /aG99s/Z/qQ6ki9llMl4P+mv6G4n82wvrx3ISYjmvFvWbEw3J0/o4UYBb3WBXJWqGHph
         Yd5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=WuCLO1xjYGpgkgYX+R5A6aWXWpQcgwwbzIbNqQedb3g=;
        b=Gg/gwkTtyNuMjmEY9jJoRe7aqm/FLnJKX51hAoasefM9CIc0h+t2NnoWFcn+HAPmNe
         O/L7X2s0McgQNVdR1fpe2PJeeo4TdQludwv+4lDcWtFkg8xsDGu8949ngGWT7mjDjSUz
         JtT64GwLzfq9sMqZeZQhz6al7oW61wQXHvinQNvi2XaD8gBCyAgzPqFNqUEIULEX8gDT
         u5D45Fdd/J+Wp+ADp6LFGmUFbmh2R+9EUzcdCr+s0YcRCPtzTELOTy8cBwNmYQAlTT1I
         k4BXfgT9neSWHimGK8nQuAKaGAGrBMw2QpltiuHY4Nte/cUhxZ/Lp6Z+UU1lPxQaOqp7
         I+RA==
X-Gm-Message-State: APjAAAUYXsWNcmHUK4qKRmZ0lr7GccMab8fSJSGoQefejmNAMzul6oyj
        nO6rnXfN5dRWZFqLsqf7or08fwhl4gE+
X-Google-Smtp-Source: APXvYqwgi72xgqf2PdPoZjm4GHT4sI2kpVQJuaB+WmgSWW0GWdmHUx5f9z0ItapkZmReasKEYRt/41ll6M4G
X-Received: by 2002:a17:902:8f90:: with SMTP id z16mr1946536plo.6.1554943067362;
 Wed, 10 Apr 2019 17:37:47 -0700 (PDT)
Date:   Wed, 10 Apr 2019 17:37:36 -0700
In-Reply-To: <20190313222124.229371-1-rajatja@google.com>
Message-Id: <20190411003738.55073-1-rajatja@google.com>
Mime-Version: 1.0
References: <20190313222124.229371-1-rajatja@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH v5 1/3] platform/x86: intel_pmc_core: Convert to a platform_driver
From:   Rajat Jain <rajatja@google.com>
To:     Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>,
        Vishwanath Somayaji <vishwanath.somayaji@intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rafael J Wysocki <rafael.j.wysocki@intel.com>,
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

Signed-off-by: Rajat Jain <rajatja@google.com>
---
v5: Remove the gerrit ID from commit log
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

