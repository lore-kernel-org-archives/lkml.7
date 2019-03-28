Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2106BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 15:29:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB3FD206DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 15:29:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Moii8SyQ";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="CkDRvx3Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727599AbfC1P3b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 11:29:31 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:52890 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbfC1P3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 11:29:30 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B649161A1E; Thu, 28 Mar 2019 15:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553786969;
        bh=sGwRr0RI3MC9asNopdI7X8k7yKvKf+lSlw/YZ3i/d7Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Moii8SyQICIcvS/PBec3YSDM7L3MkrZiroTLJ/rmDf5i/0DhrRffYN+Yj9sl1pPTh
         HvrWrXRtQEf1L3Gf9iHfYoet4frpJnakhgBToNbUfpCr8JrBz3btDeU6GEJshLKOnP
         H7oDlrb2SE7vkleHck+/B5T9/EdYse78X2zX+upw=
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D998961F65;
        Thu, 28 Mar 2019 15:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553786964;
        bh=sGwRr0RI3MC9asNopdI7X8k7yKvKf+lSlw/YZ3i/d7Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CkDRvx3QjRLfw65XIPgMy37i7XLbDo2m1hWSl95uoACd66gVBkeA0SqdGjpBWqG0c
         M5k2+TEKoDyIymBT1x/nh7zHehXEk5X5/Cj5qqn/hGBAbn8fXk774e/XPO9oSQlbdV
         0XUSuENMIrZZzaRxObvDvldGyVr+TswE2Z4ufj1E=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D998961F65
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     robh+dt@kernel.org, andy.gross@linaro.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        rjw@rjwysocki.net, viresh.kumar@linaro.org, nm@ti.com,
        sboyd@kernel.org, georgi.djakov@linaro.org
Cc:     bjorn.andersson@linaro.org, david.brown@linaro.org,
        mark.rutland@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-msm-owner@vger.kernel.org, devicetree@vger.kernel.org,
        rnayak@codeaurora.org, cw00.choi@samsung.com,
        linux-pm@vger.kernel.org, evgreen@chromium.org,
        daidavid1@codeaurora.org, dianders@chromium.org,
        Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH RFC 7/9] cpufreq: qcom: Add support to update cpu node's OPP tables
Date:   Thu, 28 Mar 2019 20:58:20 +0530
Message-Id: <20190328152822.532-8-sibis@codeaurora.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190328152822.532-1-sibis@codeaurora.org>
References: <20190328152822.532-1-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to parse and update OPP tables attached to the cpu nodes.

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---
 drivers/cpufreq/qcom-cpufreq-hw.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
index 4b0b50403901..5c268dd2346c 100644
--- a/drivers/cpufreq/qcom-cpufreq-hw.c
+++ b/drivers/cpufreq/qcom-cpufreq-hw.c
@@ -73,6 +73,25 @@ static unsigned int qcom_cpufreq_hw_fast_switch(struct cpufreq_policy *policy,
 	return policy->freq_table[index].frequency;
 }
 
+static int qcom_find_update_opp(struct device *cpu_dev, unsigned long freq,
+				unsigned long volt)
+{
+	int ret;
+	struct dev_pm_opp *opp;
+
+	opp = dev_pm_opp_find_freq_exact(cpu_dev, freq, true);
+	if (IS_ERR(opp)) {
+		ret = dev_pm_opp_add(cpu_dev, freq, volt);
+	} else {
+		dev_pm_opp_disable(cpu_dev, freq);
+		ret = dev_pm_opp_update_voltage(cpu_dev, freq, volt);
+		dev_pm_opp_enable(cpu_dev, freq);
+		dev_pm_opp_put(opp);
+	}
+
+	return ret;
+}
+
 static int qcom_cpufreq_hw_read_lut(struct device *cpu_dev,
 				    struct cpufreq_policy *policy,
 				    void __iomem *base)
@@ -81,11 +100,16 @@ static int qcom_cpufreq_hw_read_lut(struct device *cpu_dev,
 	u32 volt;
 	unsigned int max_cores = cpumask_weight(policy->cpus);
 	struct cpufreq_frequency_table	*table;
+	int ret;
 
 	table = kcalloc(LUT_MAX_ENTRIES + 1, sizeof(*table), GFP_KERNEL);
 	if (!table)
 		return -ENOMEM;
 
+	ret = dev_pm_opp_of_add_table(cpu_dev);
+	if (ret)
+		dev_dbg(cpu_dev, "Couldn't add OPP table\n");
+
 	for (i = 0; i < LUT_MAX_ENTRIES; i++) {
 		data = readl_relaxed(base + REG_FREQ_LUT +
 				      i * LUT_ROW_SIZE);
@@ -104,7 +128,7 @@ static int qcom_cpufreq_hw_read_lut(struct device *cpu_dev,
 
 		if (freq != prev_freq && core_count == max_cores) {
 			table[i].frequency = freq;
-			dev_pm_opp_add(cpu_dev, freq * 1000, volt);
+			qcom_find_update_opp(cpu_dev, freq * 1000, volt);
 			dev_dbg(cpu_dev, "index=%d freq=%d, core_count %d\n", i,
 				freq, core_count);
 		} else {
@@ -125,7 +149,8 @@ static int qcom_cpufreq_hw_read_lut(struct device *cpu_dev,
 			if (prev_cc != max_cores) {
 				prev->frequency = prev_freq;
 				prev->flags = CPUFREQ_BOOST_FREQ;
-				dev_pm_opp_add(cpu_dev,	prev_freq * 1000, volt);
+				qcom_find_update_opp(cpu_dev, prev_freq * 1000,
+						     volt);
 			}
 
 			break;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

