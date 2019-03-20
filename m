Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAB0AC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 09:49:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7732F2146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 09:49:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="cozizOBO";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="cozizOBO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727602AbfCTJts (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 05:49:48 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:50316 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbfCTJtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 05:49:45 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id BEE3861110; Wed, 20 Mar 2019 09:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553075383;
        bh=6K/mOBjwq4m7bf70C+pKlJIhBb1FQQx0UG/7mUG4KO4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cozizOBOAhpHZfTp+WVFQlO/Ic5NMirM/LNjRv5s9byRfT6W7a0ZWyGMFEV0SKL03
         YSgBkVIvFsvJ/IEsmsP7ppJ+WqsmCZUIBtkIchooQkJNtv8L7ELIPluOOWGOTMZ4UC
         g3OHHv38NVB8I3SekGkHZ5kdAODth/r7y4Q0kZpw=
Received: from blr-ubuntu-173.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 92A6960E3F;
        Wed, 20 Mar 2019 09:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553075383;
        bh=6K/mOBjwq4m7bf70C+pKlJIhBb1FQQx0UG/7mUG4KO4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cozizOBOAhpHZfTp+WVFQlO/Ic5NMirM/LNjRv5s9byRfT6W7a0ZWyGMFEV0SKL03
         YSgBkVIvFsvJ/IEsmsP7ppJ+WqsmCZUIBtkIchooQkJNtv8L7ELIPluOOWGOTMZ4UC
         g3OHHv38NVB8I3SekGkHZ5kdAODth/r7y4Q0kZpw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 92A6960E3F
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
Subject: [RFC v2 02/11] OPP: Make dev_pm_opp_set_rate() with freq=0 as valid
Date:   Wed, 20 Mar 2019 15:19:09 +0530
Message-Id: <20190320094918.20234-3-rnayak@codeaurora.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190320094918.20234-1-rnayak@codeaurora.org>
References: <20190320094918.20234-1-rnayak@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For devices with performance state, we use dev_pm_opp_set_rate()
to set the appropriate clk rate and the performance state.
We do need a way to *remove* the performance state vote when
we idle the device and turn the clocks off. Use dev_pm_opp_set_rate()
with freq=0 to achieve this.

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/opp/core.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index bc9a7762dd4c..d6acc880676e 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -708,18 +708,24 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 	struct clk *clk;
 	int ret;
 
-	if (unlikely(!target_freq)) {
-		dev_err(dev, "%s: Invalid target frequency %lu\n", __func__,
-			target_freq);
-		return -EINVAL;
-	}
-
 	opp_table = _find_opp_table(dev);
 	if (IS_ERR(opp_table)) {
 		dev_err(dev, "%s: device opp doesn't exist\n", __func__);
 		return PTR_ERR(opp_table);
 	}
 
+	if (unlikely(!target_freq)) {
+		if (opp_table->required_opp_tables) {
+			/* drop the performance state vote */
+			dev_pm_genpd_set_performance_state(dev, 0);
+			return 0;
+		} else {
+			dev_err(dev, "%s: Invalid target frequency %lu\n", __func__,
+				target_freq);
+			return -EINVAL;
+		}
+	}
+
 	clk = opp_table->clk;
 	if (IS_ERR(clk)) {
 		dev_err(dev, "%s: No clock available for the device\n",
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

