Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5435DC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 05:10:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A96120882
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 05:10:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sbAT5d8j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726870AbfDDFKN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 01:10:13 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40834 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726818AbfDDFKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 01:10:13 -0400
Received: by mail-pg1-f196.google.com with SMTP id u9so606911pgo.7
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 22:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TwZwcfQZmyrQh4osKkmpWYd/wJZhOgCuylNR0zMT/RE=;
        b=sbAT5d8jHLX0Y2LokpDIv98MIwAZ/VaN2rk89O34Ti1oWVd98AtCEanCie7K8Dq/Z3
         hggcB0rHomr46Chchxx0pofgmgODT5v1K3ToZfsS2b+Zw4i9w+lWgskc1CeuUP/eC95K
         FRpGzuFsp1J+i/N7dsltQW+dYxbOr1qiiZ+xBUag41o5Au3BrBD8hqegSgaHNv+cU5JM
         RRsx4sYxjpdVx95DV7DO80muxgm3QX+mXe8taS06wEjvRb2Zdos+piWLasXuERBL72sy
         y4FXgU+8yocCUHGnoH1lD9p12CNP32rQZsBDyU2sPRTad2Cz1eGKfPr+R4OaYX8nA3cF
         pe3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TwZwcfQZmyrQh4osKkmpWYd/wJZhOgCuylNR0zMT/RE=;
        b=Ok1nipv10qXrzgJVjHBc0z3nxL3QPCOvrgx7p9n470cbYBmCK1tidyOdWj6k27zVBL
         e9uXLfWbMoNHZca2nAVSy9qX9s0jhJ9RI+7LBIVxrU1Z/VvoooT1gsmATbPq1A2X4dni
         7BjfEoEBcZMVdFvdbVXm9MBk1I9MiYMGcBdT2yw0YuRc2ubUI3QzD6a1orgEM3Vw5chs
         fRuOuOC5K37gD1wR4/90KwPfkMDkVNiwYClwdYee0qduO8r0cL0q8Qe/1R1x02cd9JEr
         uro62dFuFrIpnuXJGfRbAvkO9vUuCD1/cP/HX7Sqx7Ei0lz6XOMMdh9Mt8ov/1lLMMQ2
         /yqg==
X-Gm-Message-State: APjAAAXjta/Nf0ep5iS093bG4DNWkfqYtWITNM5ioF8udQDMTESBTKXX
        XCVuckktSiA1kqWV63sqkxpxaA==
X-Google-Smtp-Source: APXvYqyuUjfszpJzIVdXZNVy6yQ7cbguUYd4mcVyy6+xdxtvjjh4AOYCoP3a+AsldvOWPvNGqodFZA==
X-Received: by 2002:a65:654c:: with SMTP id a12mr3799647pgw.101.1554354612126;
        Wed, 03 Apr 2019 22:10:12 -0700 (PDT)
Received: from centauri.imgcgcw.net ([147.50.13.10])
        by smtp.gmail.com with ESMTPSA id q80sm27623011pfa.66.2019.04.03.22.10.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Apr 2019 22:10:11 -0700 (PDT)
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, jorge.ramirez-ortiz@linaro.org,
        Niklas Cassel <niklas.cassel@linaro.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 3/9] cpufreq: qcom: create a driver struct
Date:   Thu,  4 Apr 2019 07:09:24 +0200
Message-Id: <20190404050931.9812-4-niklas.cassel@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190404050931.9812-1-niklas.cassel@linaro.org>
References: <20190404050931.9812-1-niklas.cassel@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

create a driver struct to make it easier to free up all common
resources, and only call dev_pm_opp_set_supported_hw() if the
implementation has dynamically allocated versions.

Co-developed-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
---
 drivers/cpufreq/qcom-cpufreq-nvmem.c | 69 ++++++++++++++++++----------
 1 file changed, 46 insertions(+), 23 deletions(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
index 652a1de2a5d4..366c65a7132a 100644
--- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
+++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
@@ -43,6 +43,11 @@ enum _msm8996_version {
 	NUM_OF_MSM8996_VERSIONS,
 };
 
+struct qcom_cpufreq_drv {
+	struct opp_table **opp_tables;
+	u32 *versions;
+};
+
 static struct platform_device *cpufreq_dt_pdev, *cpufreq_pdev;
 
 static enum _msm8996_version qcom_cpufreq_get_msm_id(void)
@@ -76,12 +81,16 @@ static enum _msm8996_version qcom_cpufreq_get_msm_id(void)
 
 static int qcom_cpufreq_kryo_name_version(struct device *cpu_dev,
 					  struct nvmem_cell *speedbin_nvmem,
-					  u32 *versions)
+					  struct qcom_cpufreq_drv *drv)
 {
 	size_t len;
 	u8 *speedbin;
 	enum _msm8996_version msm8996_version;
 
+	drv->versions = kzalloc(sizeof(*drv->versions), GFP_KERNEL);
+	if (!drv->versions)
+		return -ENOMEM;
+
 	msm8996_version = qcom_cpufreq_get_msm_id();
 	if (NUM_OF_MSM8996_VERSIONS == msm8996_version) {
 		dev_err(cpu_dev, "Not Snapdragon 820/821!");
@@ -94,10 +103,10 @@ static int qcom_cpufreq_kryo_name_version(struct device *cpu_dev,
 
 	switch (msm8996_version) {
 	case MSM8996_V3:
-		*versions = 1 << (unsigned int)(*speedbin);
+		*drv->versions = 1 << (unsigned int)(*speedbin);
 		break;
 	case MSM8996_SG:
-		*versions = 1 << ((unsigned int)(*speedbin) + 4);
+		*drv->versions = 1 << ((unsigned int)(*speedbin) + 4);
 		break;
 	default:
 		BUG();
@@ -110,15 +119,14 @@ static int qcom_cpufreq_kryo_name_version(struct device *cpu_dev,
 
 static int qcom_cpufreq_probe(struct platform_device *pdev)
 {
-	struct opp_table **opp_tables;
+	struct qcom_cpufreq_drv *drv;
 	int (*get_version)(struct device *cpu_dev,
 			   struct nvmem_cell *speedbin_nvmem,
-			   u32 *versions);
+			   struct qcom_cpufreq_drv *drv);
 	struct nvmem_cell *speedbin_nvmem;
 	struct device_node *np;
 	struct device *cpu_dev;
 	unsigned cpu;
-	u32 versions;
 	const struct of_device_id *match;
 	int ret;
 
@@ -141,23 +149,31 @@ static int qcom_cpufreq_probe(struct platform_device *pdev)
 		return -ENOENT;
 	}
 
+	drv = kzalloc(sizeof(*drv), GFP_KERNEL);
+	if (!drv)
+		return -ENOMEM;
+
 	speedbin_nvmem = of_nvmem_cell_get(np, NULL);
 	of_node_put(np);
 	if (IS_ERR(speedbin_nvmem)) {
 		if (PTR_ERR(speedbin_nvmem) != -EPROBE_DEFER)
 			dev_err(cpu_dev, "Could not get nvmem cell: %ld\n",
 				PTR_ERR(speedbin_nvmem));
-		return PTR_ERR(speedbin_nvmem);
+		ret = PTR_ERR(speedbin_nvmem);
+		goto free_drv;
 	}
 
-	ret = get_version(cpu_dev, speedbin_nvmem, &versions);
+	ret = get_version(cpu_dev, speedbin_nvmem, drv);
 	nvmem_cell_put(speedbin_nvmem);
 	if (ret)
-		return ret;
+		goto free_drv;
 
-	opp_tables = kcalloc(num_possible_cpus(), sizeof(*opp_tables), GFP_KERNEL);
-	if (!opp_tables)
-		return -ENOMEM;
+	drv->opp_tables = kcalloc(num_possible_cpus(), sizeof(*drv->opp_tables),
+				  GFP_KERNEL);
+	if (!drv->opp_tables) {
+		ret = -ENOMEM;
+		goto free_drv;
+	}
 
 	for_each_possible_cpu(cpu) {
 		cpu_dev = get_cpu_device(cpu);
@@ -166,10 +182,12 @@ static int qcom_cpufreq_probe(struct platform_device *pdev)
 			goto free_opp;
 		}
 
-		opp_tables[cpu] = dev_pm_opp_set_supported_hw(cpu_dev,
-							      &versions, 1);
-		if (IS_ERR(opp_tables[cpu])) {
-			ret = PTR_ERR(opp_tables[cpu]);
+		if (drv->versions)
+			drv->opp_tables[cpu] =
+				dev_pm_opp_set_supported_hw(cpu_dev,
+							    drv->versions, 1);
+		if (IS_ERR(drv->opp_tables[cpu])) {
+			ret = PTR_ERR(drv->opp_tables[cpu]);
 			dev_err(cpu_dev, "Failed to set supported hardware\n");
 			goto free_opp;
 		}
@@ -178,7 +196,7 @@ static int qcom_cpufreq_probe(struct platform_device *pdev)
 	cpufreq_dt_pdev = platform_device_register_simple("cpufreq-dt", -1,
 							  NULL, 0);
 	if (!IS_ERR(cpufreq_dt_pdev)) {
-		platform_set_drvdata(pdev, opp_tables);
+		platform_set_drvdata(pdev, drv);
 		return 0;
 	}
 
@@ -187,26 +205,31 @@ static int qcom_cpufreq_probe(struct platform_device *pdev)
 
 free_opp:
 	for_each_possible_cpu(cpu) {
-		if (IS_ERR_OR_NULL(opp_tables[cpu]))
+		if (IS_ERR_OR_NULL(drv->opp_tables[cpu]))
 			break;
-		dev_pm_opp_put_supported_hw(opp_tables[cpu]);
+		dev_pm_opp_put_supported_hw(drv->opp_tables[cpu]);
 	}
-	kfree(opp_tables);
+	kfree(drv->opp_tables);
+free_drv:
+	kfree(drv->versions);
+	kfree(drv);
 
 	return ret;
 }
 
 static int qcom_cpufreq_remove(struct platform_device *pdev)
 {
-	struct opp_table **opp_tables = platform_get_drvdata(pdev);
+	struct qcom_cpufreq_drv *drv = platform_get_drvdata(pdev);
 	unsigned int cpu;
 
 	platform_device_unregister(cpufreq_dt_pdev);
 
 	for_each_possible_cpu(cpu)
-		dev_pm_opp_put_supported_hw(opp_tables[cpu]);
+		dev_pm_opp_put_supported_hw(drv->opp_tables[cpu]);
 
-	kfree(opp_tables);
+	kfree(drv->opp_tables);
+	kfree(drv->versions);
+	kfree(drv);
 
 	return 0;
 }
-- 
2.20.1

