Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4F78C433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 15:13:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9E1F2089E
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 15:13:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="ksoRwsTT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733146AbfHFPNe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 11:13:34 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:23182 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728836AbfHFPNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 11:13:31 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x76F4FnT010382;
        Tue, 6 Aug 2019 10:13:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type;
 s=PODMain02222019; bh=Zx4rRZn8qtcClv4TwAgbQUTskJhNWkx1P3e+omBoh2s=;
 b=ksoRwsTT0DNwdn/ypLo8PtXnptqrUNWq1sCVVBBxAJpyRPDCnuDs6DPhTC7MPb0yX0KU
 xYeq/6crQD/DSLfHOi0WOZDPxuBwzjo5oKwS/+5fIoQGkhdTEGHpsSjB5coSPJiktED1
 Nz3vNinKV72JwVVKX7QXaShLsxzqVSFhGrBmXpya9gv+MKNNmiu2guYxKviKlVQ6uZCf
 rWIgyEcCj9cUxJdTIT+wL0w6nq/BJbzQsH77Z4dkt7vmvXsIeLz5KBRjQafjiQKAFvxo
 8dpeEPMj57IQhe8iBzwyOC07ihXrwJwRlPDjWXWvTuDkk2lkn2iHLLXG+59fss5kTgCQ hg== 
Authentication-Results: ppops.net;
        spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 2u57p4m6wt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 06 Aug 2019 10:13:24 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Tue, 6 Aug
 2019 16:13:21 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1591.10 via Frontend
 Transport; Tue, 6 Aug 2019 16:13:21 +0100
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 6A86A2A1;
        Tue,  6 Aug 2019 16:13:21 +0100 (BST)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <lee.jones@linaro.org>
CC:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH 1/2] mfd: madera: Update DT binding document to support clock supplies
Date:   Tue, 6 Aug 2019 16:13:20 +0100
Message-ID: <20190806151321.31137-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-SPF-Result: fail
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com include:spf.protection.outlook.com
 -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 priorityscore=1501
 spamscore=0 phishscore=0 impostorscore=0 mlxscore=0 suspectscore=1
 adultscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1906280000
 definitions=main-1908060149
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the 3 input clock sources for the chip into the device tree binding
document.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
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

