Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 247E8C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 17:50:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAA6B21741
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 17:50:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ZYWGZMB4";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="aOZf3A6l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728967AbfCXRuf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 13:50:35 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:60822 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728786AbfCXRue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 13:50:34 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 3C14360F3F; Sun, 24 Mar 2019 17:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553449833;
        bh=f576WJRZdAER16gXo+cqMq2KmttCbbIhAa3807kIAig=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZYWGZMB44ehGYlmZ/tDwEK37DTFZozyrISCxfXLOKHXQGKmNM09adMakFVBNzYfCz
         wTNMzJRZEKyA4fpMjuIYSY+8s/uhb8is8scMtNt8Lkt6gumK7rqD3HKwFo7OWHfezL
         F3ZnhvGmOgf3Nj8iDtSdq5kM4DLPAyL3zHRtoPR4=
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4C0B060DB2;
        Sun, 24 Mar 2019 17:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553449829;
        bh=f576WJRZdAER16gXo+cqMq2KmttCbbIhAa3807kIAig=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aOZf3A6l9307vg3+Nu86j47mIoB4WykoxKrgO+2lYqgZJHJqBAp265pdmZkRk5pC7
         3LmPC1/qd7XEsu9WrdC6Z9kt3e+N1fY0S4ZimnOL2EDU3nM7FY0ZlCfq9ZEMK9zsG2
         cHwdDh8STNv1EfYlBUXOGapnp2qJBPvGENZToBzk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4C0B060DB2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     bjorn.andersson@linaro.org, robh+dt@kernel.org,
        andy.gross@linaro.org, rnayak@codeaurora.org
Cc:     david.brown@linaro.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org,
        devicetree@vger.kernel.org, Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH v2 2/9] soc: qcom: rpmpd: Add support to set rpmpd state to max
Date:   Sun, 24 Mar 2019 23:20:00 +0530
Message-Id: <20190324175007.29040-3-sibis@codeaurora.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190324175007.29040-1-sibis@codeaurora.org>
References: <20190324175007.29040-1-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to set rpmpd state to max across SoCs.

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---
 drivers/soc/qcom/rpmpd.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/qcom/rpmpd.c b/drivers/soc/qcom/rpmpd.c
index 235d01870dd8..71fdfafad2ea 100644
--- a/drivers/soc/qcom/rpmpd.c
+++ b/drivers/soc/qcom/rpmpd.c
@@ -83,12 +83,14 @@ struct rpmpd {
 	const int res_type;
 	const int res_id;
 	struct qcom_smd_rpm *rpm;
+	unsigned int max_state;
 	__le32 key;
 };
 
 struct rpmpd_desc {
 	struct rpmpd **rpmpds;
 	size_t num_pds;
+	unsigned int max_state;
 };
 
 static DEFINE_MUTEX(rpmpd_lock);
@@ -114,6 +116,7 @@ static struct rpmpd *msm8996_rpmpds[] = {
 static const struct rpmpd_desc msm8996_desc = {
 	.rpmpds = msm8996_rpmpds,
 	.num_pds = ARRAY_SIZE(msm8996_rpmpds),
+	.max_state = MAX_RPMPD_STATE,
 };
 
 static const struct of_device_id rpmpd_match_table[] = {
@@ -225,8 +228,8 @@ static int rpmpd_set_performance(struct generic_pm_domain *domain,
 	int ret = 0;
 	struct rpmpd *pd = domain_to_rpmpd(domain);
 
-	if (state > MAX_RPMPD_STATE)
-		state = MAX_RPMPD_STATE;
+	if (state > pd->max_state)
+		state = pd->max_state;
 
 	mutex_lock(&rpmpd_lock);
 
@@ -287,6 +290,7 @@ static int rpmpd_probe(struct platform_device *pdev)
 		}
 
 		rpmpds[i]->rpm = rpm;
+		rpmpds[i]->max_state = desc->max_state;
 		rpmpds[i]->pd.power_off = rpmpd_power_off;
 		rpmpds[i]->pd.power_on = rpmpd_power_on;
 		rpmpds[i]->pd.set_performance_state = rpmpd_set_performance;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

