Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD6B7C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 04:10:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 993A4218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 04:10:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M+mu7NZN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730737AbfB1EKj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 23:10:39 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37895 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730698AbfB1EKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 23:10:38 -0500
Received: by mail-pl1-f194.google.com with SMTP id g37so6265267plb.5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 20:10:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tur0iSlfcnlVrz49pmZ+o4WEGS0vT8E32Az/XwHIWGg=;
        b=M+mu7NZN0r2R8EBTQ9KSztb1up1Hr/dgvOWV2Ca+GMdoo3BwvOAXz7PnsUD5gMQqC3
         aNmTG4A7KOwF9v+aVvbIuVWVb6rjJwFIZWO7JsjUNGTxmGOp+Xv4pFt3+k/61LTvkYb0
         sm0SVZIdlQj2FY/0943ewJRRtDAP5S6oVPkiNj8SZSMHh6idap49bgf7jeHf89OPzyQr
         BMEGl/ZqXTbClSkmrEXNx7Lt4rQuT0imPpfKbVllggwHZAXzDV7eD6rSMED4etX7/+3X
         fe/6ZBUT/JW+T7pDI7/JTdBsucqlvXIS6/QrGpLF0ExAOyuiJDEMi+2oB8MnXeJVIrJS
         1GGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tur0iSlfcnlVrz49pmZ+o4WEGS0vT8E32Az/XwHIWGg=;
        b=nqnG5T8gvF+e3sShKSxHt8fgC0/QWK/n1IJ051hcjTkft6weJD2/Hl9cclZDcv+eXs
         pzVrV5fEwHIkwppuyZ8jeh6Z7JGE+0vClsUaR21PSxrO6XCkn6bHks7zoDWnOuLdDsVG
         xANu/3OPVzhlM1IthP/q+2fQO6wiTp+2IhQc7Y2QQhupcsixOsyKmmUFPCvS/Hq9mCpH
         5G3QOM8PXRb4w2Tr/Uw+LvXysdHa+kcI07bSq3mIyEeH0vv5C5ryv8DBg+KOig1y1CZB
         6Skq/FZlKDpSw6qWfEAytYvynqAovebHBrn0aMNXg39dDg3mm289SnG8Wzo4Px1nZAXQ
         BtOg==
X-Gm-Message-State: AHQUAubknaiDdaf17UAOLQPGYpxtmaHdWWVsnL/tqxFnUAJEjTUua+9O
        YQwvXvZo/lJvFw9TsCGHWZBkCw==
X-Google-Smtp-Source: AHgI3IbmAkqdPI6RT40s4qMtMAUrCrpl17CAHs4DmSQDk8/WgbllhZ8MSiBwhpwym8Ad9vRiXJP+bA==
X-Received: by 2002:a17:902:4081:: with SMTP id c1mr5873349pld.297.1551327037557;
        Wed, 27 Feb 2019 20:10:37 -0800 (PST)
Received: from localhost ([122.167.168.92])
        by smtp.gmail.com with ESMTPSA id b70sm28606804pfm.6.2019.02.27.20.10.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Feb 2019 20:10:35 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>, Ilia Lin <ilia.lin@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, amit.kucheria@linaro.org,
        georgi.djakov@linaro.org, "4 . 18+" <stable@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3] cpufreq: kryo: Release OPP tables on module removal
Date:   Thu, 28 Feb 2019 09:40:12 +0530
Message-Id: <0334906c06967142c8805fbe88acf787f65d3d26.1551326937.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.21.0.rc0.269.g1a574e7a288b
In-Reply-To: <78f96969448b17e95b0b21cb78194bb9f709a897.1551261748.git.viresh.kumar@linaro.org>
References: <78f96969448b17e95b0b21cb78194bb9f709a897.1551261748.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 5ad7346b4ae2 ("cpufreq: kryo: Add module remove and exit") made
it possible to build the kryo cpufreq driver as a module, but it failed
to release all the resources, i.e. OPP tables, when the module is
unloaded.

This patch fixes it by releasing the OPP tables, by calling
dev_pm_opp_put_supported_hw() for them, from the
qcom_cpufreq_kryo_remove() routine. The array of pointers to the OPP
tables is also allocated dynamically now in qcom_cpufreq_kryo_probe(),
as the pointers will be required while releasing the resources.

Compile tested only.

Cc: 4.18+ <stable@vger.kernel.org> # v4.18+
Fixes: 5ad7346b4ae2 ("cpufreq: kryo: Add module remove and exit")
Reviewed-by: Georgi Djakov <georgi.djakov@linaro.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
V2->V3:
- s/kyro/kryo/
- s/unsigned/unsigned int/
- Added Reviewed-by tag

 drivers/cpufreq/qcom-cpufreq-kryo.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-kryo.c b/drivers/cpufreq/qcom-cpufreq-kryo.c
index 2a3675c24032..a472b814058f 100644
--- a/drivers/cpufreq/qcom-cpufreq-kryo.c
+++ b/drivers/cpufreq/qcom-cpufreq-kryo.c
@@ -75,7 +75,7 @@ static enum _msm8996_version qcom_cpufreq_kryo_get_msm_id(void)
 
 static int qcom_cpufreq_kryo_probe(struct platform_device *pdev)
 {
-	struct opp_table *opp_tables[NR_CPUS] = {0};
+	struct opp_table **opp_tables;
 	enum _msm8996_version msm8996_version;
 	struct nvmem_cell *speedbin_nvmem;
 	struct device_node *np;
@@ -133,6 +133,10 @@ static int qcom_cpufreq_kryo_probe(struct platform_device *pdev)
 	}
 	kfree(speedbin);
 
+	opp_tables = kcalloc(num_possible_cpus(), sizeof(*opp_tables), GFP_KERNEL);
+	if (!opp_tables)
+		return -ENOMEM;
+
 	for_each_possible_cpu(cpu) {
 		cpu_dev = get_cpu_device(cpu);
 		if (NULL == cpu_dev) {
@@ -151,8 +155,10 @@ static int qcom_cpufreq_kryo_probe(struct platform_device *pdev)
 
 	cpufreq_dt_pdev = platform_device_register_simple("cpufreq-dt", -1,
 							  NULL, 0);
-	if (!IS_ERR(cpufreq_dt_pdev))
+	if (!IS_ERR(cpufreq_dt_pdev)) {
+		platform_set_drvdata(pdev, opp_tables);
 		return 0;
+	}
 
 	ret = PTR_ERR(cpufreq_dt_pdev);
 	dev_err(cpu_dev, "Failed to register platform device\n");
@@ -163,13 +169,23 @@ static int qcom_cpufreq_kryo_probe(struct platform_device *pdev)
 			break;
 		dev_pm_opp_put_supported_hw(opp_tables[cpu]);
 	}
+	kfree(opp_tables);
 
 	return ret;
 }
 
 static int qcom_cpufreq_kryo_remove(struct platform_device *pdev)
 {
+	struct opp_table **opp_tables = platform_get_drvdata(pdev);
+	unsigned int cpu;
+
 	platform_device_unregister(cpufreq_dt_pdev);
+
+	for_each_possible_cpu(cpu)
+		dev_pm_opp_put_supported_hw(opp_tables[cpu]);
+
+	kfree(opp_tables);
+
 	return 0;
 }
 
-- 
2.21.0.rc0.269.g1a574e7a288b

