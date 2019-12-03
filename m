Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B348C43215
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 13:59:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCCF9206DF
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 13:59:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="vlcZbDAv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbfLCN7O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 08:59:14 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:53824 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725848AbfLCN7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 08:59:14 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB3DhODw010266;
        Tue, 3 Dec 2019 08:56:29 -0500
Received: from nam03-co1-obe.outbound.protection.outlook.com (mail-co1nam03lp2054.outbound.protection.outlook.com [104.47.40.54])
        by mx0a-00128a01.pphosted.com with ESMTP id 2wkk57rqq4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Dec 2019 08:56:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gMQyU2EvAdKD/QtMFIsusDxQS47/Q7Ghu+yPe6SpFMHoVUe334GNuKWnJkvrcWUpogvRXIHh/vOgU6CXfLvx0/uhih4cb01re8rEHmXZ+vw/lnCrj1kWdt8uOGvqoGjzI63fVtLkttP7hwTH8/zRDbBU+3EY0t9tExjmiYF+vbZANqo4LBvuvmHVw2oRzDKm4wIt2p6QWJDTYiRWB8wyrkAw+Tdi52Tx0N4tkZgLWtvJn53UyU91Tbx4kbL4JqHT30ixGpQKXy4EMxhboTaOZJHidXH16pOOKcVG5hcDNnv6kq5p+XWM7BViRjK55sawQf2mYZF1axpxM7AeEJ5g9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V+1ROGsajjfQJz2L3uK7kSFwtaG5TFqA7otMAggWe6s=;
 b=N59mDTmTo5Ik3DsuQM+nNKbG3ROcEO12PCtLITyIprvffFWmno9q/hGN4RQz3uu7Iw3t6ZSpr7stYwBp7bqSfe8FcOvjij2wLe+ouivqHtgNbjJfrcOmt1wb7/bzxX3dvbJyHaEUFj2R/mTJnWFMug2ZsU6y9E2ubr6LB85rbhIg+SE+W1se+9yy2N2CIT6tRwLQaqShEDjZXndSlbXmmS5I0LDmd9viqBJjUOYRbe2+Hg6YbFnTx06zNiiZEcUPLolUzBCg1k38N2GsZn8pc3X1Gv2tzWI1TkTjOCc7bzqTePa1Fl/wjox+XiVz5ajPF51Al0fefPzEzOl9s5keDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.55) smtp.rcpttodomain=suse.com smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V+1ROGsajjfQJz2L3uK7kSFwtaG5TFqA7otMAggWe6s=;
 b=vlcZbDAvH1LiSuGwPMmtcXsb2+TAfisX8emfaDEoPslu8yi8x18yBOOWtYcJ2LhVMCUC7D/iOgFaecckqZTT1kvNe6+Puj7hlO8cj8tHCZqr+/d+cTMmTCHfXkDRu9PD7kJ81YtF3hvVba0DDsQuDh+HJBsKzFnWMIj8oUheIyc=
Received: from CY4PR03CA0006.namprd03.prod.outlook.com (2603:10b6:903:33::16)
 by DM6PR03MB5017.namprd03.prod.outlook.com (2603:10b6:5:1ee::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.12; Tue, 3 Dec
 2019 13:56:27 +0000
Received: from BL2NAM02FT053.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::206) by CY4PR03CA0006.outlook.office365.com
 (2603:10b6:903:33::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2495.18 via Frontend
 Transport; Tue, 3 Dec 2019 13:56:26 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 BL2NAM02FT053.mail.protection.outlook.com (10.152.76.225) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2474.17
 via Frontend Transport; Tue, 3 Dec 2019 13:56:25 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id xB3DuPT0007904
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Tue, 3 Dec 2019 05:56:25 -0800
Received: from ben-Latitude-E6540.ad.analog.com (10.48.65.231) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Tue, 3 Dec 2019 08:56:25 -0500
From:   Beniamin Bia <beniamin.bia@analog.com>
To:     <linux-hwmon@vger.kernel.org>
CC:     <Michael.Hennerich@analog.com>, <linux-kernel@vger.kernel.org>,
        <jdelvare@suse.com>, <linux@roeck-us.net>, <mark.rutland@arm.com>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>,
        <devicetree@vger.kernel.org>, <biabeniamin@outlook.com>,
        Beniamin Bia <beniamin.bia@analog.com>
Subject: [PATCH 2/3] dt-binding: iio: Add documentation for ADM1177
Date:   Tue, 3 Dec 2019 15:57:10 +0200
Message-ID: <20191203135711.13972-2-beniamin.bia@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191203135711.13972-1-beniamin.bia@analog.com>
References: <20191203135711.13972-1-beniamin.bia@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(346002)(39860400002)(136003)(396003)(189003)(199004)(7636002)(6666004)(356004)(1076003)(2906002)(246002)(5660300002)(36756003)(6916009)(8676002)(50226002)(86362001)(305945005)(2351001)(8936002)(106002)(54906003)(107886003)(6306002)(26005)(186003)(446003)(426003)(2616005)(336012)(478600001)(48376002)(11346002)(51416003)(966005)(7696005)(316002)(16586007)(44832011)(50466002)(4326008)(70206006)(76176011)(70586007);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR03MB5017;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ff24f76f-51ba-41bb-7c95-08d777f8969a
X-MS-TrafficTypeDiagnostic: DM6PR03MB5017:
X-Microsoft-Antispam-PRVS: <DM6PR03MB50175279AD4728BE97D98D99F0420@DM6PR03MB5017.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 02408926C4
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GZ+AiZ+kTWYvo8j0fIQv/jxZSQrQ7Skl01YzV3H5zwr0/mOi8tRH5mq2JlCDAlEYL2aTEE1MnmPeqHMANmeeJ+L2BwduMSgifhfzI31tgZWoD5NqUYME3+OXU1f5vqBcPvwLZ+HZJoGqWRtvr94dYVSHTW38zi/DjQW6EPcopLAuq7gD+hsDAWrZNGE+yd9zx59njYwv6n3jb0XevBV2kZXbNVNdGgs4UKKnzn/1paQlkJqxp3ima2urnWXJap9YGJM+Zlbx3GcZZXEGk0GShd0Mxcw1nNjWCeHmz4H9sfSylwKtqKw4LVycoJqIdInufs4D5TtZiwdidwFwMbpQKAyoUmUZuahggG4/qoLn/CKWDj8eUsM8UApPRr14eeWoSyckCU6Vf8EZK8Kj8GMsKgYBljPNdvAY6ZNwznHL2JAnZcvvZP17FrytbCjddTZZkdMhHXZJB4RaBJWu1ya3DjXZTpxC3dmKMi5mX4O3q9c=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2019 13:56:25.7955
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff24f76f-51ba-41bb-7c95-08d777f8969a
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5017
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-03_03:2019-12-02,2019-12-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 phishscore=0
 priorityscore=1501 impostorscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912030108
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Documentation for ADM1177 was added.

Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
---
 .../bindings/hwmon/adi,adm1177.yaml           | 65 +++++++++++++++++++
 1 file changed, 65 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/adi,adm1177.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/adi,adm1177.yaml b/Documentation/devicetree/bindings/hwmon/adi,adm1177.yaml
new file mode 100644
index 000000000000..abd9354217ba
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/adi,adm1177.yaml
@@ -0,0 +1,65 @@
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
+  adi,r-sense-micro-ohms:
+    description:
+      The value of curent sense resistor in microohms.
+
+  adi,shutdown-threshold-microamp:
+    description:
+      Specifies the current level at which an over current alert occurs.
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
+  - adi,r-sense-micro-ohms
+  - adi,shutdown-threshold-microamp
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
+                adi,r-sense-micro-ohms = <50000>; /* 50 mOhm */
+                adi,shutdown-threshold-microamp = <1059000>; /* 1.059 A */
+                adi,vrange-high-enable;
+        };
+    };
+...
-- 
2.17.1

