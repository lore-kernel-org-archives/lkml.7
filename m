Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B380ECE58A
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 13:46:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4177B2190F
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 13:46:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="NqGRuMzX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388713AbfJANq0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 09:46:26 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:57524 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726152AbfJANqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 09:46:25 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x91DibK0023820;
        Tue, 1 Oct 2019 08:46:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=PODMain02222019;
 bh=SGANgmWUPAq86u24cu2/DX7hnIuJbxNqU+ibLBvdpTE=;
 b=NqGRuMzX+oPB4mYwZ4oCZA4GpJPNxu4D4r6A/m7wwCXPCKAIZ/yY6Sr6NqDBWDUETRN4
 7nU1xMiPkng1SQog5IaEwLSMJOKCRkwbLox/Cs5Q/vxPb+3QPfT7jC9ykoBfpSJdhPfO
 vDFJSV80aC9vZcgDZSKh72lnx/RM4gnivBFcMmzY55FEw8IGSZbA5QHbvEzmhz/VCmXo
 C5gTnUsAie46MHzN8lLI4MzGTGxnoqUzPIuSqOHF1o4AJgz3ZbcIXIk2BJwAbInko8DE
 1XLYmMw1e17Xl0iVAANrlE6Vuga8MrG8DvbaXdSpB7oI/hyHL+JIQ94cFRlYtPX5IL2s aQ== 
Authentication-Results: ppops.net;
        spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 2va4x4ncr7-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 01 Oct 2019 08:46:19 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Tue, 1 Oct
 2019 14:46:17 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1591.10 via Frontend
 Transport; Tue, 1 Oct 2019 14:46:17 +0100
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id DAF102D4;
        Tue,  1 Oct 2019 13:46:17 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <lee.jones@linaro.org>
CC:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH v3 2/3] mfd: madera: Update DT binding document to support clock supplies
Date:   Tue, 1 Oct 2019 14:46:16 +0100
Message-ID: <20191001134617.12093-2-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20191001134617.12093-1-ckeepax@opensource.cirrus.com>
References: <20191001134617.12093-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-SPF-Result: fail
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com include:spf.protection.outlook.com
 -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 malwarescore=0 adultscore=0 phishscore=0 impostorscore=0
 priorityscore=1501 suspectscore=1 bulkscore=0 mlxscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910010125
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the 3 input clock sources for the chip into the device tree binding
document.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

No changes since v2.

Thanks,
Charles

 Documentation/devicetree/bindings/mfd/madera.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/madera.txt b/Documentation/devicetree/bindings/mfd/madera.txt
index cad0f28005027..47e2b8bc60519 100644
--- a/Documentation/devicetree/bindings/mfd/madera.txt
+++ b/Documentation/devicetree/bindings/mfd/madera.txt
@@ -67,6 +67,14 @@ Optional properties:
     As defined in bindings/gpio.txt.
     Although optional, it is strongly recommended to use a hardware reset
 
+  - clocks: Should reference the clocks supplied on MCLK1, MCLK2 and MCLK3
+  - clock-names: May contain up to three strings:
+      "mclk1" for the clock supplied on MCLK1, recommended to be a high
+      quality audio reference clock
+      "mclk2" for the clock supplied on MCLK2, required to be an always on
+      32k clock
+      "mclk3" for the clock supplied on MCLK3
+
   - MICBIASx : Initial data for the MICBIAS regulators, as covered in
     Documentation/devicetree/bindings/regulator/regulator.txt.
     One for each MICBIAS generator (MICBIAS1, MICBIAS2, ...)
-- 
2.11.0

