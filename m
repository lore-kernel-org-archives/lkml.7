Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3542C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 12:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B683320449
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 12:39:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="DwmUxbag";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="aajOAR0Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729687AbfC0MjF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 08:39:05 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:56106 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbfC0MjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 08:39:05 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id DE51861156; Wed, 27 Mar 2019 12:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553690344;
        bh=Ej1zYVw7dX4Ob/Y0alBO9xVTD7M63G8I/HLJTzwMuwo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DwmUxbagqTWG13w3xBlcjKkjPzZVI3PPJk883jc6UCvQMdR7TlWrDr7yFSQlVuDel
         ZKNPCDMr+gUNllzqVPu2XUQSI4Et1/0ICdnZTYGDAz64Bt12ihkuqiHxdoWMxKlN7u
         CTVky0CYqhr0Q+LDgESFncX7Pt2a/q9PPAQq/+lg=
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DC59A60E41;
        Wed, 27 Mar 2019 12:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553690342;
        bh=Ej1zYVw7dX4Ob/Y0alBO9xVTD7M63G8I/HLJTzwMuwo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aajOAR0Qh+mkLO8LAN7RDpnYru1U1SReRaPYhj4L1bvcTrlU3HBA4yujRLR2kDb1C
         IJFu8DCua1mlrUuZmRNt/sdbyseY802rNjdlq2ZobUjeh04Npmq+pR+/MB3ik2I6L4
         cxel+G+RkYnmJFeqFNn9NbpLILHFr9yPrr89/snw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DC59A60E41
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     bjorn.andersson@linaro.org, robh+dt@kernel.org,
        andy.gross@linaro.org, rnayak@codeaurora.org
Cc:     david.brown@linaro.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org,
        devicetree@vger.kernel.org, Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH v3 3/9] soc: qcom: rpmpd: Modify corner defining macros
Date:   Wed, 27 Mar 2019 18:08:26 +0530
Message-Id: <20190327123832.11566-4-sibis@codeaurora.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190327123832.11566-1-sibis@codeaurora.org>
References: <20190327123832.11566-1-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Andersson <bjorn.andersson@linaro.org>

QCS404 uses individual resource type magic for each power-domain, so
adjust the macros slightly to make them reusable for this.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
[sibi: Extend rpmpd corner pair to a generic rpmpd pair]
Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---
 drivers/soc/qcom/rpmpd.c | 39 +++++++++++++++++----------------------
 1 file changed, 17 insertions(+), 22 deletions(-)

diff --git a/drivers/soc/qcom/rpmpd.c b/drivers/soc/qcom/rpmpd.c
index 94015ece40e9..ca736ceb969c 100644
--- a/drivers/soc/qcom/rpmpd.c
+++ b/drivers/soc/qcom/rpmpd.c
@@ -17,8 +17,8 @@
 #define domain_to_rpmpd(domain) container_of(domain, struct rpmpd, pd)
 
 /* Resource types */
-#define RPMPD_SMPA 0x61706d73
-#define RPMPD_LDOA 0x616f646c
+#define RPMPD_SMPA 0x61706d73 /* smpa */
+#define RPMPD_LDOA 0x616f646c /* ldoa */
 
 /* Operation Keys */
 #define KEY_CORNER		0x6e726f63 /* corn */
@@ -27,46 +27,41 @@
 
 #define MAX_8996_RPMPD_STATE	6
 
-#define DEFINE_RPMPD_CORNER_SMPA(_platform, _name, _active, r_id)		\
+#define DEFINE_RPMPD_PAIR(_platform, _name, _active, r_type, r_key,	\
+			  r_id)						\
 	static struct rpmpd _platform##_##_active;			\
 	static struct rpmpd _platform##_##_name = {			\
 		.pd = {	.name = #_name,	},				\
 		.peer = &_platform##_##_active,				\
-		.res_type = RPMPD_SMPA,					\
+		.res_type = RPMPD_##r_type,				\
 		.res_id = r_id,						\
-		.key = KEY_CORNER,					\
+		.key = KEY_##r_key,					\
 	};								\
 	static struct rpmpd _platform##_##_active = {			\
 		.pd = { .name = #_active, },				\
 		.peer = &_platform##_##_name,				\
 		.active_only = true,					\
-		.res_type = RPMPD_SMPA,					\
+		.res_type = RPMPD_##r_type,				\
 		.res_id = r_id,						\
-		.key = KEY_CORNER,					\
+		.key = KEY_##r_key,					\
 	}
 
-#define DEFINE_RPMPD_CORNER_LDOA(_platform, _name, r_id)			\
+#define DEFINE_RPMPD_CORNER(_platform, _name, r_type, r_id)		\
 	static struct rpmpd _platform##_##_name = {			\
 		.pd = { .name = #_name, },				\
-		.res_type = RPMPD_LDOA,					\
+		.res_type = RPMPD_##r_type,				\
 		.res_id = r_id,						\
 		.key = KEY_CORNER,					\
 	}
 
-#define DEFINE_RPMPD_VFC(_platform, _name, r_id, r_type)		\
+#define DEFINE_RPMPD_VFC(_platform, _name, r_type, r_id)		\
 	static struct rpmpd _platform##_##_name = {			\
 		.pd = { .name = #_name, },				\
-		.res_type = r_type,					\
+		.res_type = RPMPD_##r_type,				\
 		.res_id = r_id,						\
 		.key = KEY_FLOOR_CORNER,				\
 	}
 
-#define DEFINE_RPMPD_VFC_SMPA(_platform, _name, r_id)			\
-	DEFINE_RPMPD_VFC(_platform, _name, r_id, RPMPD_SMPA)
-
-#define DEFINE_RPMPD_VFC_LDOA(_platform, _name, r_id)			\
-	DEFINE_RPMPD_VFC(_platform, _name, r_id, RPMPD_LDOA)
-
 struct rpmpd_req {
 	__le32 key;
 	__le32 nbytes;
@@ -96,12 +91,12 @@ struct rpmpd_desc {
 static DEFINE_MUTEX(rpmpd_lock);
 
 /* msm8996 RPM Power domains */
-DEFINE_RPMPD_CORNER_SMPA(msm8996, vddcx, vddcx_ao, 1);
-DEFINE_RPMPD_CORNER_SMPA(msm8996, vddmx, vddmx_ao, 2);
-DEFINE_RPMPD_CORNER_LDOA(msm8996, vddsscx, 26);
+DEFINE_RPMPD_PAIR(msm8996, vddcx, vddcx_ao, SMPA, CORNER, 1);
+DEFINE_RPMPD_PAIR(msm8996, vddmx, vddmx_ao, SMPA, CORNER, 2);
+DEFINE_RPMPD_CORNER(msm8996, vddsscx, LDOA, 26);
 
-DEFINE_RPMPD_VFC_SMPA(msm8996, vddcx_vfc, 1);
-DEFINE_RPMPD_VFC_LDOA(msm8996, vddsscx_vfc, 26);
+DEFINE_RPMPD_VFC(msm8996, vddcx_vfc, SMPA, 1);
+DEFINE_RPMPD_VFC(msm8996, vddsscx_vfc, LDOA, 26);
 
 static struct rpmpd *msm8996_rpmpds[] = {
 	[MSM8996_VDDCX] =	&msm8996_vddcx,
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

