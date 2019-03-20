Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B190BC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 09:50:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 806522146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 09:50:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="lwZOXMzN";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="O+Wd36r+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbfCTJuS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 05:50:18 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:51360 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727839AbfCTJuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 05:50:16 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E8C9E61515; Wed, 20 Mar 2019 09:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553075415;
        bh=vE4lNkXde4s9Lm5OFadg0y4mx23Es0CYK64WiLr/7g4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lwZOXMzNQW6TC5FUINxATlpLD+kZuDTBx7m1Pz/gsjrDZXdqUWGwiGmenoTr2Jf0M
         o951PLPa0lQ6ETUdPgSYW9sBL/KE9nVuLi9ULLpb9rMCuk5TnbzCgFNb446d42ovqM
         8g4qfHPzb6gbXiyfBLi3rahD0LHYL4Jp9d9A45WA=
Received: from blr-ubuntu-173.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 463F16141B;
        Wed, 20 Mar 2019 09:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553075413;
        bh=vE4lNkXde4s9Lm5OFadg0y4mx23Es0CYK64WiLr/7g4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O+Wd36r+fgMWjg6mHIFPwMi8wL4Y9F6LPyEUukwDiSvgFFLFWolFhfGbSu4BsdU9B
         w9gsYMWvkb5alCJhKxkn3buxIoJW1bbQAFzCYxaaVD7edDPRwlzAmLr3miZbpFRkXT
         5SpaiMTCnDXgrv8lxhVdllkWu7FW11jP/GKrJUfU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 463F16141B
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
Subject: [RFC v2 09/11] drm/msm/dpu: Use OPP API to set clk/perf state
Date:   Wed, 20 Mar 2019 15:19:16 +0530
Message-Id: <20190320094918.20234-10-rnayak@codeaurora.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190320094918.20234-1-rnayak@codeaurora.org>
References: <20190320094918.20234-1-rnayak@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some qualcomm platforms DPU needs to express a perforamnce state
requirement on a power domain depennding on the clock rates.
Use OPP table from DT to register with OPP framework and use
dev_pm_opp_set_rate() to set the clk/perf state.

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c | 7 ++++++-
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c       | 9 +++++++++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c
index 9f20f397f77d..db21a86b242b 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c
@@ -15,6 +15,7 @@
 #include <linux/debugfs.h>
 #include <linux/errno.h>
 #include <linux/mutex.h>
+#include <linux/pm_opp.h>
 #include <linux/sort.h>
 #include <linux/clk.h>
 #include <linux/bitmap.h>
@@ -298,7 +299,11 @@ static int _dpu_core_perf_set_core_clk_rate(struct dpu_kms *kms, u64 rate)
 		rate = core_clk->max_rate;
 
 	core_clk->rate = rate;
-	return msm_dss_clk_set_rate(core_clk, 1);
+
+	if (dev_pm_opp_get_opp_table(&kms->pdev->dev))
+		return dev_pm_opp_set_rate(&kms->pdev->dev, core_clk->rate);
+	else
+		return msm_dss_clk_set_rate(core_clk, 1);
 }
 
 static u64 _dpu_core_perf_get_core_clk_rate(struct dpu_kms *kms)
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
index 885bf88afa3e..684bd6982aaf 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
@@ -22,6 +22,7 @@
 #include <linux/debugfs.h>
 #include <linux/of_irq.h>
 #include <linux/dma-buf.h>
+#include <linux/pm_opp.h>
 
 #include "msm_drv.h"
 #include "msm_mmu.h"
@@ -1014,6 +1015,12 @@ static int dpu_bind(struct device *dev, struct device *master, void *data)
 	if (!dpu_kms)
 		return -ENOMEM;
 
+	dev_pm_opp_set_clkname(dev, "core");
+
+	ret = dev_pm_opp_of_add_table(dev);
+	if (ret)
+		dev_err(dev, "failed to init OPP table: %d\n", ret);
+
 	mp = &dpu_kms->mp;
 	ret = msm_dss_parse_clock(pdev, mp);
 	if (ret) {
@@ -1040,6 +1047,7 @@ static void dpu_unbind(struct device *dev, struct device *master, void *data)
 	struct dpu_kms *dpu_kms = platform_get_drvdata(pdev);
 	struct dss_module_power *mp = &dpu_kms->mp;
 
+	dev_pm_opp_of_remove_table(dev);
 	msm_dss_put_clk(mp->clk_config, mp->num_clk);
 	devm_kfree(&pdev->dev, mp->clk_config);
 	mp->num_clk = 0;
@@ -1078,6 +1086,7 @@ static int __maybe_unused dpu_runtime_suspend(struct device *dev)
 		return rc;
 	}
 
+	dev_pm_opp_set_rate(dev, 0);
 	rc = msm_dss_enable_clk(mp->clk_config, mp->num_clk, false);
 	if (rc)
 		DPU_ERROR("clock disable failed rc:%d\n", rc);
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

