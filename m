Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32699C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 09:49:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01C6921850
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 09:49:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="jv60lTTm";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="KMch30hU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727692AbfCTJt4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 05:49:56 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:50578 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727607AbfCTJtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 05:49:53 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 3B5E46119F; Wed, 20 Mar 2019 09:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553075392;
        bh=3IvBCa8OvZCbpW39LzSPn2awcEdwJySydBlFfwz//Qk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jv60lTTmo/oSTWSH5bqz0wI88JiYRLFrAt3MLTiY+uTFyE2s2qw7nXDvS1OJOIQKs
         wwm7ElGoh+0uZRMOv40nVqbiRqMkRT0KlG9g5iYf4wQDQ9u5bXRSrmNYuI0QGxNyJ+
         8KgiL17hYd8hMhlN7BAZUErS4qpOjIglJbPkWRMo=
Received: from blr-ubuntu-173.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AC0BF61155;
        Wed, 20 Mar 2019 09:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553075391;
        bh=3IvBCa8OvZCbpW39LzSPn2awcEdwJySydBlFfwz//Qk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KMch30hUliwKuV4UflNp832h+jG5WfiZw127EZi/2uDOePetJiwVvkDThSuFZqoS9
         Misl5nL1vVBi0LRJ7E7fZqeptUVLvZgOqqWNsJSXJlJJtPC8uZxZRpWZGPjdNvISrJ
         /NFMkouris2qEKig+CJFuBTsQm1wjhzIy/sP24vA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AC0BF61155
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
From:   Rajendra Nayak <rnayak@codeaurora.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-scsi@vger.kernel.org,
        swboyd@chromium.org, ulf.hansson@linaro.org,
        viresh.kumar@linaro.org, dianders@chromium.org, rafael@kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>
Subject: [RFC v2 04/11] spi: spi-geni-qcom: Use OPP API to set clk/perf state
Date:   Wed, 20 Mar 2019 15:19:11 +0530
Message-Id: <20190320094918.20234-5-rnayak@codeaurora.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190320094918.20234-1-rnayak@codeaurora.org>
References: <20190320094918.20234-1-rnayak@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

geni spi needs to express a perforamnce state requirement on CX
depending on the frequency of the clock rates. Use OPP table from
DT to register with OPP framework and use dev_pm_opp_set_rate() to
set the clk/perf state.

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/spi/spi-geni-qcom.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index 5f0b0d5bfef4..c251e6df1bc0 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -8,6 +8,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/pm_opp.h>
 #include <linux/pm_runtime.h>
 #include <linux/qcom-geni-se.h>
 #include <linux/spi/spi.h>
@@ -96,7 +97,6 @@ static int get_spi_clk_cfg(unsigned int speed_hz,
 {
 	unsigned long sclk_freq;
 	unsigned int actual_hz;
-	struct geni_se *se = &mas->se;
 	int ret;
 
 	ret = geni_se_clk_freq_match(&mas->se,
@@ -113,9 +113,9 @@ static int get_spi_clk_cfg(unsigned int speed_hz,
 
 	dev_dbg(mas->dev, "req %u=>%u sclk %lu, idx %d, div %d\n", speed_hz,
 				actual_hz, sclk_freq, *clk_idx, *clk_div);
-	ret = clk_set_rate(se->clk, sclk_freq);
+	ret = dev_pm_opp_set_rate(mas->dev, sclk_freq);
 	if (ret)
-		dev_err(mas->dev, "clk_set_rate failed %d\n", ret);
+		dev_err(mas->dev, "dev_pm_opp_set_rate failed %d\n", ret);
 	return ret;
 }
 
@@ -560,6 +560,12 @@ static int spi_geni_probe(struct platform_device *pdev)
 	if (!spi)
 		return -ENOMEM;
 
+	ret = dev_pm_opp_of_add_table(&pdev->dev);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "failed to init OPP table: %d\n", ret);
+		return ret;
+	}
+
 	platform_set_drvdata(pdev, spi);
 	mas = spi_master_get_devdata(spi);
 	mas->irq = irq;
@@ -625,6 +631,8 @@ static int __maybe_unused spi_geni_runtime_suspend(struct device *dev)
 	struct spi_master *spi = dev_get_drvdata(dev);
 	struct spi_geni_master *mas = spi_master_get_devdata(spi);
 
+	/* Drop the performance state vote */
+	dev_pm_opp_set_rate(dev, 0);
 	return geni_se_resources_off(&mas->se);
 }
 
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

