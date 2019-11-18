Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90F0CC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 17:40:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 654B42186D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 17:40:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="AJuFjxk8";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="FbyCmMAe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727295AbfKRRkJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 12:40:09 -0500
Received: from a27-18.smtp-out.us-west-2.amazonses.com ([54.240.27.18]:46920
        "EHLO a27-18.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726647AbfKRRkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 12:40:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1574098807;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
        bh=B/RmD7VcJmrMjOcsEv3+dqCX8OYxRrJfYKFZESL0rLc=;
        b=AJuFjxk8XNQZZrQo3ITf7j50C6u7pTjuzxhiXwfUQ3SvNRI2VCY+4DZEkaHgFojQ
        +lsttShY8ihTCBAg8v9RvkbzdiTtUwwo2QneT9ZuQDaJOY2HSPETP1wp4qlXjNEz/vv
        rQ8Mi31OK3MBRBFhN/EaUFUHewgy14XLycPa8rYQ=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1574098807;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID;
        bh=B/RmD7VcJmrMjOcsEv3+dqCX8OYxRrJfYKFZESL0rLc=;
        b=FbyCmMAeVBH7HG0PtpMHeGAQhm4UlA6dFvq3uPxrDiVu/8Uld/hy8JBcuBtBZijO
        2qVMWzy25DSOhc2PxL5V6rMRSYuREWq4p6OejccrzTRcQ+7E8G4ru0Er3bkbTUrHP1r
        ULPeZeN91rspOgbKMccc1K/uGja4Usk0aY7ODQRk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B9192C447B7
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     bjorn.andersson@linaro.org, robh+dt@kernel.org,
        ulf.hansson@linaro.org, rnayak@codeaurora.org
Cc:     agross@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        mark.rutland@arm.com, swboyd@chromium.org, dianders@chromium.org,
        Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH 2/6] dt-bindings: power: Add rpmh power-domain bindings for SM8150
Date:   Mon, 18 Nov 2019 17:40:07 +0000
Message-ID: <0101016e7f99a91d-6632f420-b2f2-4b71-9c97-a3974fcb8fa9-000000@us-west-2.amazonses.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20191118173944.27043-1-sibis@codeaurora.org>
References: <20191118173944.27043-1-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SES-Outgoing: 2019.11.18-54.240.27.18
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add RPMH power-domain bindings for the SM8150 family of SoCs.

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---
 .../devicetree/bindings/power/qcom,rpmpd.txt       |  1 +
 include/dt-bindings/power/qcom-rpmpd.h             | 14 ++++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/qcom,rpmpd.txt b/Documentation/devicetree/bindings/power/qcom,rpmpd.txt
index bc75bf49cdaea..f3bbaa4aef297 100644
--- a/Documentation/devicetree/bindings/power/qcom,rpmpd.txt
+++ b/Documentation/devicetree/bindings/power/qcom,rpmpd.txt
@@ -10,6 +10,7 @@ Required Properties:
 	* qcom,msm8998-rpmpd: RPM Power domain for the msm8998 family of SoC
 	* qcom,qcs404-rpmpd: RPM Power domain for the qcs404 family of SoC
 	* qcom,sdm845-rpmhpd: RPMh Power domain for the sdm845 family of SoC
+	* qcom,sm8150-rpmhpd: RPMh Power domain for the sm8150 family of SoC
  - #power-domain-cells: number of cells in Power domain specifier
 	must be 1.
  - operating-points-v2: Phandle to the OPP table for the Power domain.
diff --git a/include/dt-bindings/power/qcom-rpmpd.h b/include/dt-bindings/power/qcom-rpmpd.h
index f05f8b1808ec9..7d43bafc0026b 100644
--- a/include/dt-bindings/power/qcom-rpmpd.h
+++ b/include/dt-bindings/power/qcom-rpmpd.h
@@ -15,12 +15,26 @@
 #define SDM845_GFX	7
 #define SDM845_MSS	8
 
+/* SM8150 Power Domain Indexes */
+#define SM8150_MSS	0
+#define SM8150_EBI	1
+#define SM8150_LMX	2
+#define SM8150_LCX	3
+#define SM8150_GFX	4
+#define SM8150_MX	5
+#define SM8150_MX_AO	6
+#define SM8150_CX	7
+#define SM8150_CX_AO	8
+#define SM8150_MMCX	9
+#define SM8150_MMCX_AO	10
+
 /* SDM845 Power Domain performance levels */
 #define RPMH_REGULATOR_LEVEL_RETENTION	16
 #define RPMH_REGULATOR_LEVEL_MIN_SVS	48
 #define RPMH_REGULATOR_LEVEL_LOW_SVS	64
 #define RPMH_REGULATOR_LEVEL_SVS	128
 #define RPMH_REGULATOR_LEVEL_SVS_L1	192
+#define RPMH_REGULATOR_LEVEL_SVS_L2	224
 #define RPMH_REGULATOR_LEVEL_NOM	256
 #define RPMH_REGULATOR_LEVEL_NOM_L1	320
 #define RPMH_REGULATOR_LEVEL_NOM_L2	336
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

