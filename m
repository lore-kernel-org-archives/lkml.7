Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A5B0C2D0B1
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 10:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1148020707
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 10:01:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="saAwJ+8r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbfLFKBo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 05:01:44 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:8960 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726070AbfLFKBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 05:01:44 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB69ue52015177;
        Fri, 6 Dec 2019 11:01:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=JDvwUMe8qpYb+uBxaJVZc0mpCE2XQdvwLFY8XvYg2+A=;
 b=saAwJ+8rZdLkql+hc3b+2cZki1ubgidsBHnPPTgwkt0LPtguj96enegFpl0vkcMIdesK
 GLCA9k6Fq0vcRY/OO7zMpBeAzfNaBHrwVtsd2sHMs4flsy+q84ApYxLhyhhNI8x7fknu
 J3c+5suj50W1o0HwyEdZ8p2JMMx9uccf+Q4q2IdbFHChENtozCWe1IS9HcSDY5f2Lg8N
 8AE6JadYHWKxogwIpS/WfifB3xQJcJtf5x4THqurzL5n/YYJi7L8fAWAj0zc0iTjdUuu
 R4+s/ocJRizUvMWfqqQxhKSebo4ybepLa6zaGajoGmu4+385jaF+dJrknTwVvdog5EsS XQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2wkf2y7tb2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 Dec 2019 11:01:16 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id CF1D7100038;
        Fri,  6 Dec 2019 11:01:15 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag6node2.st.com [10.75.127.17])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 95E072AD9C8;
        Fri,  6 Dec 2019 11:01:15 +0100 (CET)
Received: from localhost (10.75.127.46) by SFHDAG6NODE2.st.com (10.75.127.17)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 6 Dec 2019 11:01:14
 +0100
From:   Olivier Moysan <olivier.moysan@st.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>, <olivier.moysan@st.com>
CC:     <mark.rutland@arm.com>, <mcoquelin.stm32@gmail.com>,
        <lars@metafoo.de>, <devicetree@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <pmeerw@pmeerw.net>, <knaack.h@gmx.de>, <fabrice.gasnier@st.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v2] dt-bindings: iio: adc: convert sd modulator to json-schema
Date:   Fri, 6 Dec 2019 11:00:58 +0100
Message-ID: <20191206100058.26767-1-olivier.moysan@st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG1NODE1.st.com (10.75.127.1) To SFHDAG6NODE2.st.com
 (10.75.127.17)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-06_02:2019-12-05,2019-12-06 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the sigma delta modulator bindings
to DT schema format using json-schema.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
---
Changes since v1:
- add additionalProperties
- remove unit-address in example
---
 .../iio/adc/sigma-delta-modulator.txt         | 13 -------
 .../iio/adc/sigma-delta-modulator.yaml        | 37 +++++++++++++++++++
 2 files changed, 37 insertions(+), 13 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/sigma-delta-modulator.txt
 create mode 100644 Documentation/devicetree/bindings/iio/adc/sigma-delta-modulator.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/sigma-delta-modulator.txt b/Documentation/devicetree/bindings/iio/adc/sigma-delta-modulator.txt
deleted file mode 100644
index 59b92cd32552..000000000000
--- a/Documentation/devicetree/bindings/iio/adc/sigma-delta-modulator.txt
+++ /dev/null
@@ -1,13 +0,0 @@
-Device-Tree bindings for sigma delta modulator
-
-Required properties:
-- compatible: should be "ads1201", "sd-modulator". "sd-modulator" can be use
-	as a generic SD modulator if modulator not specified in compatible list.
-- #io-channel-cells = <0>: See the IIO bindings section "IIO consumers".
-
-Example node:
-
-	ads1202: adc {
-		compatible = "sd-modulator";
-		#io-channel-cells = <0>;
-	};
diff --git a/Documentation/devicetree/bindings/iio/adc/sigma-delta-modulator.yaml b/Documentation/devicetree/bindings/iio/adc/sigma-delta-modulator.yaml
new file mode 100644
index 000000000000..a390343d0c2a
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/sigma-delta-modulator.yaml
@@ -0,0 +1,37 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/sigma-delta-modulator.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Device-Tree bindings for sigma delta modulator
+
+maintainers:
+  - Arnaud Pouliquen <arnaud.pouliquen@st.com>
+
+properties:
+  compatible:
+    description: |
+      "sd-modulator" can be used as a generic SD modulator,
+      if the modulator is not specified in the compatible list.
+    enum:
+      - sd-modulator
+      - ads1201
+
+  '#io-channel-cells':
+    const: 0
+
+required:
+  - compatible
+  - '#io-channel-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    ads1202: adc {
+      compatible = "sd-modulator";
+      #io-channel-cells = <0>;
+    };
+
+...
-- 
2.17.1

