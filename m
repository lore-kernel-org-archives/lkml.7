Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89380C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 11:41:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51EF52467B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 11:41:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="s6xJ69dO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbfLSLlD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 06:41:03 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:25976 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726884AbfLSLk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 06:40:59 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBJBeEg5021232;
        Thu, 19 Dec 2019 06:40:29 -0500
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by mx0a-00128a01.pphosted.com with ESMTP id 2wvtfdm8wt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Dec 2019 06:40:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cABfMUjBGI8y8fq63aLZ+npQbaN9ifd/IE5JE2cyClMGqhew5bNVLvROZSnnHxZngmmrLbLiRs77vBKKaekmicKc+g/4K9ypMls8R2oWJSH8KCLNoV1FRocilLcZ3q1Yes/Zv+maa2QZH6sxDkvDxeRs24d1RFVUrEahWYoEOeFCEPW+SaAwdL1oEbF4U43OOlcjZwlTWpv4Xdv4vjDNqFYqND4VXAtK+BOV1mNWFPxOqXjO9LKi6RmBpNX8NJ+/flwPmMb/QnBGEHxFUlhmcvejGcC2TvAIkwDDENJAAqKqpHQAFBGYWUJ4S1EPJrMNZ47pUHliuVrsOij9/khulw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cDAZS867f1xy79611rXXkKV+TjIzthUVD6KbTMQ9ERs=;
 b=HXRVUsTh0jt90kbLmpqdISd7GZZq4Fi6+Sx7IQiZ4vUMeVB/AZZ/VOjP1qkTnRr5Puf3eqdfIyceMZISdmyPRNOoPYfUt/XuRA0QcXAZIWq4VsYLtP2KLdj3XG8iIVS+qY9Rm7LaoW2W7uFV6+/Yfgs9qWJjnl1paYGb914BesgOkr4tVzZAnDUJ6U3ZGju529uDZNtFEg00Jupn248TIqCrStll/DWzX0YS8SgtqiXpSirQnvJrfBhxuzMZzTIXdWYVoqw6d6kOy8gWH+g6WaSjCiX3uHwLpJdDj0TZyQAHCPiU7u1TgtLXbIbzQRntYsmFaUSDrLHh71CpEpm74g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cDAZS867f1xy79611rXXkKV+TjIzthUVD6KbTMQ9ERs=;
 b=s6xJ69dOlG2epMAxprmQGr0IU/Y8s0k1rY1FChBHbHIFofNLuN14UU/iFx49daHPLU+HTO+lzIbLRK95mELleoOQyfYM3fkcuyuCMu96ikfubWHls6aFECJIHZwqggDEDBAO6Z010JDlNgflK8cZim6j11Kb9XrMmwPt50vrCjU=
Received: from SN6PR16CA0049.namprd16.prod.outlook.com (2603:10b6:805:ca::26)
 by BN8PR03MB4692.namprd03.prod.outlook.com (2603:10b6:408:68::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2538.18; Thu, 19 Dec
 2019 11:40:27 +0000
Received: from SN1NAM02FT026.eop-nam02.prod.protection.outlook.com
 (2603:10b6:805:ca:cafe::9a) by SN6PR16CA0049.outlook.office365.com
 (2603:10b6:805:ca::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2559.14 via Frontend
 Transport; Thu, 19 Dec 2019 11:40:27 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 SN1NAM02FT026.mail.protection.outlook.com (10.152.72.97) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2559.14
 via Frontend Transport; Thu, 19 Dec 2019 11:40:27 +0000
Received: from SCSQMBX10.ad.analog.com (scsqmbx10.ad.analog.com [10.77.17.5])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id xBJBePti013823
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Thu, 19 Dec 2019 03:40:26 -0800
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQMBX10.ad.analog.com (10.77.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 19 Dec 2019 03:40:24 -0800
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Thu, 19 Dec 2019 03:40:24 -0800
Received: from ben-Latitude-E6540.ad.analog.com ([10.48.65.203])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id xBJBe814004004;
        Thu, 19 Dec 2019 06:40:20 -0500
From:   Beniamin Bia <beniamin.bia@analog.com>
To:     <linux-hwmon@vger.kernel.org>
CC:     <Michael.Hennerich@analog.com>, <linux-kernel@vger.kernel.org>,
        <jdelvare@suse.com>, <linux@roeck-us.net>, <mark.rutland@arm.com>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>,
        <devicetree@vger.kernel.org>, <biabeniamin@outlook.com>,
        Beniamin Bia <beniamin.bia@analog.com>
Subject: [PATCH v2 2/3] dt-binding: hwmon: Add documentation for ADM1177
Date:   Thu, 19 Dec 2019 13:41:26 +0200
Message-ID: <20191219114127.21905-2-beniamin.bia@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191219114127.21905-1-beniamin.bia@analog.com>
References: <20191219114127.21905-1-beniamin.bia@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(39860400002)(136003)(199004)(189003)(356004)(107886003)(7696005)(6916009)(70206006)(70586007)(2906002)(246002)(54906003)(7636002)(186003)(336012)(316002)(26005)(426003)(8936002)(966005)(478600001)(44832011)(1076003)(8676002)(86362001)(4326008)(5660300002)(36756003)(2616005);DIR:OUT;SFP:1101;SCL:1;SRVR:BN8PR03MB4692;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9410d7b5-7bbf-4227-772b-08d784783e42
X-MS-TrafficTypeDiagnostic: BN8PR03MB4692:
X-Microsoft-Antispam-PRVS: <BN8PR03MB4692DBC3971D709DCE80AE88F0520@BN8PR03MB4692.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0256C18696
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1cPh2TT6CyeqwGH3tdUxVFYHu4b9Ltm0BY8jmlH0Ox5TPzGp1YOzWspdln9JjChpOKt6VBjS6DOrSbA1LyL3Vlw5mKsgRzWy8hHMwjn9r4nuOos9WUppJcvA98s+TeUKmHm4wXQEzU9WnB/ikgvNq4jLwqR1mOQqVssV4WKDKmsY4t55Lyx2FrmAwLIy8VT/4euHw03wCNOl3ty7xQgL5bxbfuFm5Ao10ypcjEW1sNubBHcCzyYcVfz3SO8AIFRJ2oRv6cEAfcJpvDDVAGELoIY2XGLqcv4GgDhC1BGAEE/luRQf9eiWVhnPkRO+5M/HE2AnlNgo2s34ynAF3LHezqMsAoBjPDZxY30qnWbbCzeGr+HTs0w0EI6hHAUaD4Iq44SHZEKFqjX50lfmpjfmFzbR1BYQhaED0D8ofFSYblXJOqL79cgE7A73GHbiYIcB/71xLYeBylh9RxbWyy+HIhB/zMtspVY2kWUJUq2LCpE=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2019 11:40:27.0528
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9410d7b5-7bbf-4227-772b-08d784783e42
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR03MB4692
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-19_01:2019-12-17,2019-12-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 clxscore=1015 impostorscore=0 phishscore=0 spamscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912190101
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Documentation for ADM1177 was added.

Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
---
Changes in v2:
-adi,r-sense-micro-ohms: replaced by shunt-resistor-micro-ohms 
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

