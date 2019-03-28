Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26D96C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 15:28:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAAE0206BA
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 15:28:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ZAXyzuVA";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="hFLHCZf6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbfC1P2t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 11:28:49 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:51342 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbfC1P2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 11:28:49 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id BF8D1618CD; Thu, 28 Mar 2019 15:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553786928;
        bh=saxFG01wr/WqbM/6BscCUxiM8aweZyEy5YEKycoCjMs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZAXyzuVAOxL8T+ybzcWarUiea2mlQ9l13ZM/RilnX315+itbSfynnfmVQg/AfyROP
         S+3xozMRUki3LZQzjImZBk1s3lo6O/H5HuPlsbkX11RqCC9zy9pj3AbSc2g/frEUdu
         1l1qrgg3GZ/s2QC+IL5JjEiMpEVQJq0z9znFsVOA=
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 62FC961639;
        Thu, 28 Mar 2019 15:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553786924;
        bh=saxFG01wr/WqbM/6BscCUxiM8aweZyEy5YEKycoCjMs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hFLHCZf6b5lYFYNZa24m735IZbqzEQsbbciSxM09DA7Qhp1wNKZUCCeIBvg5EO14r
         XWkC2/ImhlT8/HFy1fbgu4qkPTagi4egdTCNoBlIQ6x+zbrs39KmaqduuOwobeejOx
         t1p1QNEovdIM0BmNREG0mWu643wcFiJgpoSHv7xM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 62FC961639
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
Subject: [PATCH RFC 1/9] OPP: Add and export helpers to get avg/peak bw
Date:   Thu, 28 Mar 2019 20:58:14 +0530
Message-Id: <20190328152822.532-2-sibis@codeaurora.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190328152822.532-1-sibis@codeaurora.org>
References: <20190328152822.532-1-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add and export helpers 'dev_pm_opp_get_avg_bw()' and
'dev_pm_opp_get_peak_bw()' that can be used to get the
average and peak bandwidth values read from device tree
when present.

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---
 drivers/opp/core.c     | 38 ++++++++++++++++++++++++++++++++++++++
 include/linux/pm_opp.h | 12 ++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 4fcc2b9259c5..addaf7aae9ae 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -149,6 +149,44 @@ unsigned int dev_pm_opp_get_level(struct dev_pm_opp *opp)
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_get_level);
 
+/**
+ * dev_pm_opp_get_avg_bw() - Gets the average bandwidth corresponding to an
+ * available opp
+ * @opp:	opp for which average bandwidth has to be returned for
+ *
+ * Return: average bandwidth read from device tree corresponding to the
+ * opp, else return 0.
+ */
+unsigned int dev_pm_opp_get_avg_bw(struct dev_pm_opp *opp)
+{
+	if (IS_ERR_OR_NULL(opp) || !opp->available) {
+		pr_err("%s: Invalid parameters\n", __func__);
+		return 0;
+	}
+
+	return opp->bandwidth->avg;
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_get_avg_bw);
+
+/**
+ * dev_pm_opp_get_peak_bw() - Gets the peak bandwidth corresponding to an
+ * available opp
+ * @opp:	opp for which peak bandwidth has to be returned for
+ *
+ * Return: peak bandwidth read from device tree corresponding to the
+ * opp, else return 0.
+ */
+unsigned int dev_pm_opp_get_peak_bw(struct dev_pm_opp *opp)
+{
+	if (IS_ERR_OR_NULL(opp) || !opp->available) {
+		pr_err("%s: Invalid parameters\n", __func__);
+		return 0;
+	}
+
+	return opp->bandwidth->peak;
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_get_peak_bw);
+
 /**
  * dev_pm_opp_is_turbo() - Returns if opp is turbo OPP or not
  * @opp: opp for which turbo mode is being verified
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 80a49d1fa9a8..82ff8e2e1ff7 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -99,6 +99,8 @@ unsigned long dev_pm_opp_get_voltage(struct dev_pm_opp *opp);
 unsigned long dev_pm_opp_get_freq(struct dev_pm_opp *opp);
 
 unsigned int dev_pm_opp_get_level(struct dev_pm_opp *opp);
+unsigned int dev_pm_opp_get_avg_bw(struct dev_pm_opp *opp);
+unsigned int dev_pm_opp_get_peak_bw(struct dev_pm_opp *opp);
 
 bool dev_pm_opp_is_turbo(struct dev_pm_opp *opp);
 
@@ -179,6 +181,16 @@ static inline unsigned int dev_pm_opp_get_level(struct dev_pm_opp *opp)
 	return 0;
 }
 
+static inline unsigned int dev_pm_opp_get_avg_bw(struct dev_pm_opp *opp)
+{
+	return 0;
+}
+
+static inline unsigned int dev_pm_opp_get_peak_bw(struct dev_pm_opp *opp)
+{
+	return 0;
+}
+
 static inline bool dev_pm_opp_is_turbo(struct dev_pm_opp *opp)
 {
 	return false;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

