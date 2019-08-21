Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF40AC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 18:06:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 951ED214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 18:06:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="S+ugcXV5";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="WK0jp5Zh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728286AbfHUSGH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 14:06:07 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:44670 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbfHUSGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 14:06:06 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 3BD7460DB4; Wed, 21 Aug 2019 18:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1566410766;
        bh=CaM47E+jHxWdx1PakdsEDGXID3inWAqQsaFwjMJf4v0=;
        h=From:To:Cc:Subject:Date:From;
        b=S+ugcXV59A0Tq0WoK+ytc/Vq0BdlyWOdm0Mx0CckJRHyhDjkDbIQw+hbV74rgNfh6
         q1t3trCcr/x4eCwY2dmUR+eyYiCyu1aZqaHcjIeHvDU77c2OFLZuTiwLuztcWlg/Vm
         NfPb//s7c8CxMOxh4oeIKFMg0ZPVZ6flsIlP2c3Y=
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E177A608CC;
        Wed, 21 Aug 2019 18:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1566410765;
        bh=CaM47E+jHxWdx1PakdsEDGXID3inWAqQsaFwjMJf4v0=;
        h=From:To:Cc:Subject:Date:From;
        b=WK0jp5Zhu2nANQYLeEK7xT2m/qQZktsGf/NyHxylJkraBXhBiRwxdYL8GJIO24C9w
         JgCnFEQMxqdSgIqw9T0Z6Ar96+PwGKmN+4sUGpsttNVC8QJ+fShqi2EVKQ/HfkNN5l
         EoCE5YwxYk0u0NgPqn3+KoeBBy4sag54OxtMnb2w=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E177A608CC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     bjorn.andersson@linaro.org
Cc:     agross@kernel.org, ohad@wizery.com, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        rnayak@codeaurora.org, Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH] remoteproc: qcom: q6v5-mss: fixup q6v5_pds_enable error handling
Date:   Wed, 21 Aug 2019 23:35:48 +0530
Message-Id: <20190821180548.9458-1-sibis@codeaurora.org>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dev_pm_domain_attach_by_name will return NULL if the requested
power-domain is not a part device node. This could result in
NULL pointer de-reference in q6v5_pds_enable. Fix this by
checking for IS_ERR_OR_NULL and forward the appropriate error
code.

Fixes: 4760a896be88e ("remoteproc: q6v5-mss: Vote for rpmh power domains")
Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---
 drivers/remoteproc/qcom_q6v5_mss.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom_q6v5_mss.c
index 8fcf9d28dd731..de919f2e8b949 100644
--- a/drivers/remoteproc/qcom_q6v5_mss.c
+++ b/drivers/remoteproc/qcom_q6v5_mss.c
@@ -1282,8 +1282,8 @@ static int q6v5_pds_attach(struct device *dev, struct device **devs,
 
 	for (i = 0; i < num_pds; i++) {
 		devs[i] = dev_pm_domain_attach_by_name(dev, pd_names[i]);
-		if (IS_ERR(devs[i])) {
-			ret = PTR_ERR(devs[i]);
+		if (IS_ERR_OR_NULL(devs[i])) {
+			ret = PTR_ERR(devs[i]) ? : -ENODATA;
 			goto unroll_attach;
 		}
 	}
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

