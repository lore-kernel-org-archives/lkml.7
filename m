Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3FCAC04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 10:21:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 866BD20989
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 10:21:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Pg1ZmNck";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="dDDNsKgo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729023AbfEMKVB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 06:21:01 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:57030 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728995AbfEMKVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 06:21:00 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 3C52061213; Mon, 13 May 2019 10:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1557742859;
        bh=pTxKfV7jnNhbs9G5OwbSExrYyay9CyzmkzVeVD+63gU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Pg1ZmNckR2s1aT8dlG/91wAsaMvgOJUGLjirZuDQR/0k+1tUdmKyH5KZylJdMxaNu
         QxkiAk4oLBbqjiDSsted/JDvMv8thGqVMLgr1wIuHHa2g5eG4rP4KqQtDvpjDfFjok
         KNrcSs2gFqXfsEdNe0xAzBAxSUBubcJNFP5Alorw=
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 27AA4611CF;
        Mon, 13 May 2019 10:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1557742858;
        bh=pTxKfV7jnNhbs9G5OwbSExrYyay9CyzmkzVeVD+63gU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dDDNsKgoUDKuhDDmM42TY2sLWiqaX435mMoOkd3zTf6rpOdA2GUa48CKQ8CN3obzT
         KR8UaTQjKZPWdA91tI01NXAuq8ngPGtLe/FT9+AIys8KmOuu7SWEW4hsCv/812Vfr/
         r91C5ZnfZvTlMD7UPDcrLvMfCEf4gdvDqDckHcjU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 27AA4611CF
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     bjorn.andersson@linaro.org, robh+dt@kernel.org, agross@kernel.org
Cc:     david.brown@linaro.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, rnayak@codeaurora.org,
        marc.w.gonzalez@free.fr, Sibi Sankar <sibis@codeaurora.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v4 7/9] dt-bindings: power: Add rpm power domain bindings for msm8998
Date:   Mon, 13 May 2019 15:50:13 +0530
Message-Id: <20190513102015.26551-8-sibis@codeaurora.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190513102015.26551-1-sibis@codeaurora.org>
References: <20190513102015.26551-1-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add RPM power domain bindings for the msm8998 family of SoC

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---
 .../devicetree/bindings/power/qcom,rpmpd.txt         |  1 +
 include/dt-bindings/power/qcom-rpmpd.h               | 12 ++++++++++++
 2 files changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/qcom,rpmpd.txt b/Documentation/devicetree/bindings/power/qcom,rpmpd.txt
index 172ccf940c5c..eb35b22f9e23 100644
--- a/Documentation/devicetree/bindings/power/qcom,rpmpd.txt
+++ b/Documentation/devicetree/bindings/power/qcom,rpmpd.txt
@@ -6,6 +6,7 @@ which then translates it into a corresponding voltage on a rail
 Required Properties:
  - compatible: Should be one of the following
 	* qcom,msm8996-rpmpd: RPM Power domain for the msm8996 family of SoC
+	* qcom,msm8998-rpmpd: RPM Power domain for the msm8998 family of SoC
 	* qcom,qcs404-rpmpd: RPM Power domain for the qcs404 family of SoC
 	* qcom,sdm845-rpmhpd: RPMh Power domain for the sdm845 family of SoC
  - #power-domain-cells: number of cells in Power domain specifier
diff --git a/include/dt-bindings/power/qcom-rpmpd.h b/include/dt-bindings/power/qcom-rpmpd.h
index 450378662944..93e36d011527 100644
--- a/include/dt-bindings/power/qcom-rpmpd.h
+++ b/include/dt-bindings/power/qcom-rpmpd.h
@@ -36,6 +36,18 @@
 #define MSM8996_VDDSSCX		5
 #define MSM8996_VDDSSCX_VFC	6
 
+/* MSM8998 Power Domain Indexes */
+#define MSM8998_VDDCX		0
+#define MSM8998_VDDCX_AO	1
+#define MSM8998_VDDCX_VFL	2
+#define MSM8998_VDDMX		3
+#define MSM8998_VDDMX_AO	4
+#define MSM8998_VDDMX_VFL	5
+#define MSM8998_SSCCX		6
+#define MSM8998_SSCCX_VFL	7
+#define MSM8998_SSCMX		8
+#define MSM8998_SSCMX_VFL	9
+
 /* QCS404 Power Domains */
 #define QCS404_VDDMX		0
 #define QCS404_VDDMX_AO		1
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

