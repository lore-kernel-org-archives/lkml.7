Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBCC6C33C99
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 10:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88B112081E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 10:58:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="PQj/zWbo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727919AbgAGK6q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 05:58:46 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:64698 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727857AbgAGK6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 05:58:44 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 007Aw4WS026227;
        Tue, 7 Jan 2020 05:58:12 -0500
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by mx0a-00128a01.pphosted.com with ESMTP id 2xaneaeu6s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Jan 2020 05:58:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BrpdcTOSXfvmjBm7f0sU1YNH0BQTHrNFMac7aczIMjYRI21EoODQzHg2h8aZh2hJ+m3Mp9IKrJ4AF++k2UIWj8UpeND4Ynmm0PQPe+RJHsGv6DuXJUdQyeccXGKFWqwbuPxg/1s2GfnLUDTr0LHKX0804HWoEmIuPLrWe20G2V21Jfo0PgbpI1EABjfJgYoGXIVmWUHCyQHf+qCIjABbfK9K6cMd+JtwZO5kx1RL0J1R+H2gvR1qcThn1vWphsOiA5bisJ4hMUmpD2W5+GyXpPIubvlwgsOpzmdZ0nn1t5QzzHC3O7cnePp+grJkQ+pA8FYWHJVoT817KKs13f2/Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/w43bNGP1KTpzQOQlde9YYZ1rTv4uuaVx1hOmF5i6RM=;
 b=fZuHNh2diT32F0nccuKwS/XoIbfv5u1iBDuBivRpQ9LMGXKEnAA2IGko2wF1pK3+AsDCTxaLnhw7XzSH1L8CE6g/jsKUJffEJY0IIehWsSI0/n6i6qNInGGxE+ppjSKfw+W9xAz5Dar7mfkCRxEnKkchJfP/s5jav7sgoTgrInqU08CWDzHk1qgUSr5iJRJzdsQCiyQu2i61DHYoY8avwgDpYmqXhClYbYyd6j5rVBx16ewWURgDmfVS7pYvKZLclk2dHkUaMSMkRdOJzoGfd7mey9q4BmYYueS2od1urh0RjtQRtflU0iuyD7jCFNNwXid1XyBBKhGaqdxtAccc1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/w43bNGP1KTpzQOQlde9YYZ1rTv4uuaVx1hOmF5i6RM=;
 b=PQj/zWbooavZxMy1zYAdhlDXxQ/vzN43CY22rL1RmXZM4rDct4Iycx+BdlaLuP6POgvlYNPtBCVDu+578HSK+cWAofnLFvt63my4NATdZADbPSkxgQM8J/RGyil0V+3S5NrPfujYKtmdnoyUjFLA0tRxRwXjMWzoqksLSTnmxjM=
Received: from BN3PR03CA0078.namprd03.prod.outlook.com
 (2a01:111:e400:7a4d::38) by BYAPR03MB4310.namprd03.prod.outlook.com
 (2603:10b6:a03:c1::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2602.13; Tue, 7 Jan
 2020 10:58:09 +0000
Received: from CY1NAM02FT019.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::204) by BN3PR03CA0078.outlook.office365.com
 (2a01:111:e400:7a4d::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2602.12 via Frontend
 Transport; Tue, 7 Jan 2020 10:58:09 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 CY1NAM02FT019.mail.protection.outlook.com (10.152.75.177) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2602.11
 via Frontend Transport; Tue, 7 Jan 2020 10:58:09 +0000
Received: from ASHBMBX8.ad.analog.com (ashbmbx8.ad.analog.com [10.64.17.5])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id 007Aw8f4011473
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Tue, 7 Jan 2020 02:58:08 -0800
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Tue, 7 Jan 2020
 05:58:07 -0500
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Tue, 7 Jan 2020 02:58:07 -0800
Received: from ben-Latitude-E6540.ad.analog.com ([10.48.65.231])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 007Avvmn002960;
        Tue, 7 Jan 2020 05:58:03 -0500
From:   Beniamin Bia <beniamin.bia@analog.com>
To:     <linux-hwmon@vger.kernel.org>
CC:     <Michael.Hennerich@analog.com>, <linux-kernel@vger.kernel.org>,
        <jdelvare@suse.com>, <linux@roeck-us.net>, <mark.rutland@arm.com>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>,
        <devicetree@vger.kernel.org>, <biabeniamin@outlook.com>,
        Beniamin Bia <beniamin.bia@analog.com>
Subject: [PATCH v3 2/3] dt-binding: hwmon: Add documentation for ADM1177
Date:   Tue, 7 Jan 2020 12:59:28 +0200
Message-ID: <20200107105929.18938-2-beniamin.bia@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200107105929.18938-1-beniamin.bia@analog.com>
References: <20200107105929.18938-1-beniamin.bia@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(39860400002)(376002)(346002)(136003)(189003)(199004)(7636002)(966005)(2616005)(86362001)(44832011)(4326008)(6916009)(5660300002)(1076003)(54906003)(336012)(26005)(36756003)(426003)(186003)(478600001)(356004)(6666004)(7696005)(246002)(2906002)(107886003)(8676002)(8936002)(70206006)(70586007)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB4310;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 47d145a4-f998-4854-4767-08d793607b57
X-MS-TrafficTypeDiagnostic: BYAPR03MB4310:
X-Microsoft-Antispam-PRVS: <BYAPR03MB4310CB29011A53ECA416844FF03F0@BYAPR03MB4310.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 027578BB13
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /HfVkCLlujx2uYkwNF6CietrQ4Zu4fRzPiTucfs8nb/ggzXXQxFUK4lxNdAB9I9Qpe2uSmrDVFZfaoKTJpSv21ajRhwN/L9GaarExBSEDqA+Qp0rhVgak9v7GS8e2OuPZrdibAvvgLXmUb/Z/KReUiwfqogomkYeB4pFMVAMQR/zPSWbOl51wZ2rJY+uGtZXjUlASuD50iabsp2aOCHmb3njcFrdO/7ZzD4bpAP1kfxVQgpzdlcEISuYT6EWWATHNOmYRsaWxAyxCr78nupgkR/jzFQEvI8U+SohQ4yIi5dhjRDajdRecwlHIrWCBM25hkPWeVxOQ3ThNM2wHSS2lOOEBfmMNkgs4tqL5nZAesQ+VdOBLC7hR5WM7eoQme1DB6ZgrqY035RFokY95Jgn1M0mJMOgLpKELyvCWvWR60CIXZPZC5L3mNAM4k9KYLCGazA+FpRTOhTc1Bv9lVjrNiEbTPDvf+NlD0hPtykN3EU=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2020 10:58:09.0271
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47d145a4-f998-4854-4767-08d793607b57
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB4310
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2020-01-07_02:2020-01-06,2020-01-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 adultscore=0 impostorscore=0 mlxscore=0 lowpriorityscore=0
 spamscore=0 malwarescore=0 phishscore=0 suspectscore=0 mlxlogscore=999
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001070088
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Documentation for ADM1177 was added.

Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changes in v3:
-nothing changed

 .../bindings/hwmon/adi,adm1177.yaml           | 66 +++++++++++++++++++
 1 file changed, 66 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/adi,adm1177.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/adi,adm1177.yaml b/Documentation/devicetree/bindings/hwmon/adi,adm1177.yaml
new file mode 100644
index 000000000000..65ef95328bc6
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/adi,adm1177.yaml
@@ -0,0 +1,66 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/hwmon/adi,adm1177.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices ADM1177 Hot Swap Controller and Digital Power Monitor
+
+maintainers:
+  - Michael Hennerich <michael.hennerich@analog.com>
+  - Beniamin Bia <beniamin.bia@analog.com>
+
+description: |
+  Analog Devices ADM1177 Hot Swap Controller and Digital Power Monitor
+  https://www.analog.com/media/en/technical-documentation/data-sheets/ADM1177.pdf
+
+properties:
+  compatible:
+    enum:
+      - adi,adm1177
+
+  reg:
+    maxItems: 1
+
+  avcc-supply:
+    description:
+      Phandle to the Avcc power supply
+
+  shunt-resistor-micro-ohms:
+    description:
+      The value of curent sense resistor in microohms. If not provided,
+      the current reading and overcurrent alert is disabled.
+
+  adi,shutdown-threshold-microamp:
+    description:
+      Specifies the current level at which an over current alert occurs.
+      If not provided, the overcurrent alert is configured to max ADC range
+      based on shunt-resistor-micro-ohms.
+
+  adi,vrange-high-enable:
+    description:
+      Specifies which internal voltage divider to be used. A 1 selects
+      a 7:2 voltage divider while a 0 selects a 14:1 voltage divider.
+    type: boolean
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c0 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        pwmon@5a {
+                compatible = "adi,adm1177";
+                reg = <0x5a>;
+		shunt-resistor-micro-ohms = <50000>; /* 50 mOhm */
+                adi,shutdown-threshold-microamp = <1059000>; /* 1.059 A */
+                adi,vrange-high-enable;
+        };
+    };
+...
-- 
2.17.1

