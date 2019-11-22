Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E869C43215
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 07:17:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 369DA2071B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 07:17:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="KpaVAc3b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbfKVHRB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 02:17:01 -0500
Received: from mail-eopbgr820047.outbound.protection.outlook.com ([40.107.82.47]:2417
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726018AbfKVHRA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 02:17:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bMAGEUiU8AmA+uCdo4Au0MCdsMN5hzNPP8qP+kcjG5b5leJaip1lrV0LqjO8/K1mvG8DigLOLqMQfBo1DcVGlcIaPJgPKWwO15heY5/uiyYs8UzXLzUPt3CTjwzgxdXbymLjilm7+zW5jP2k1/l+EXrvb0nw67c8B4OJ7CdgdKXwC1BGa+rzy+uv/HDqXYXVUCsju5mAhWXn8szUd4Iotqfnm28i1SG07yNGnp5urwWpJvnoombftAkthLPWi5Lz3wUsSPlLnFDN5JjKo3iHl2Gu2oXdufqCxSM+9aY0jxDawcMDgEBJzvCPyOGjfuXCgOtCe1yy+TGQO0Wq1L63uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zZp+A7ELKFeZgY9socOS9iVOzilU4skxwLpoogmFyIU=;
 b=OjqoSolKzcgxu1Kiiz1DNj7Lf+NTUACwVtmbeqcMyZCe+RM8FE8FVaZ+gWDcCvMbM5mEasGvPG7r6V2dkL2WcJDsD7yl/Wjmx90MrZuFfX0JDnQ+9uol9WwBwMzjDmEIyTvrtuGEgyaoBVE/+e9w4LY4yxS0wuv8N5d/wQl6SyKjLZaEbU4eYUkd2jqPhhqekHX9pc9UCxu9dTpMmp5NUUDS90mtr3Pfr/Ze95cknGhM10xRVzsF0yyTsDWh3sfit3a5oKG9Hsf+iJEvgWfT1zKJmrRQE+AKlclrhiJFGqMXGMERNxLvyEu6VbBnOg6lo7ZgLwd8IFh2O512UgfVhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zZp+A7ELKFeZgY9socOS9iVOzilU4skxwLpoogmFyIU=;
 b=KpaVAc3b1bVRCnPzZf2L0i7Q+8Ab1MOvCfoDJSubUihhQapIjcukzo+RcoT3bw5+LvL9cujUBrK63MyJk/yWGiuSzc0NN2xIYa0qLK6NdB4W4IH18YsTPycCsxlsc4Gn/13yewQ6pp2bCNaCd9xiWFewdc0tZ6XL/kdDe7C0U8U=
Received: from BN6PR02CA0043.namprd02.prod.outlook.com (2603:10b6:404:5f::29)
 by SN6PR02MB5216.namprd02.prod.outlook.com (2603:10b6:805:70::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.19; Fri, 22 Nov
 2019 07:16:07 +0000
Received: from BL2NAM02FT006.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::208) by BN6PR02CA0043.outlook.office365.com
 (2603:10b6:404:5f::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.17 via Frontend
 Transport; Fri, 22 Nov 2019 07:16:07 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT006.mail.protection.outlook.com (10.152.76.239) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2474.17
 via Frontend Transport; Fri, 22 Nov 2019 07:16:07 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1iY3Ak-0003F3-Ov; Thu, 21 Nov 2019 23:16:06 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1iY3Af-00057D-IE; Thu, 21 Nov 2019 23:16:01 -0800
Received: from xsj-pvapsmtp01 (mailhost.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id xAM7G0w0029390;
        Thu, 21 Nov 2019 23:16:00 -0800
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1iY3Ad-000574-UO; Thu, 21 Nov 2019 23:16:00 -0800
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id 3C301121387; Fri, 22 Nov 2019 12:45:59 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, git@xilinx.com,
        Manish Narani <manish.narani@xilinx.com>
Subject: [PATCH] dt-bindings: mmc: Correct the type of the clk phase properties
Date:   Fri, 22 Nov 2019 12:45:57 +0530
Message-Id: <1574406957-85248-1-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(376002)(346002)(396003)(39860400002)(199004)(189003)(186003)(70206006)(70586007)(8936002)(48376002)(106002)(2616005)(44832011)(50466002)(50226002)(36386004)(6266002)(81156014)(81166006)(107886003)(8676002)(103686004)(47776003)(305945005)(356004)(478600001)(2906002)(51416003)(4326008)(316002)(426003)(36756003)(26005)(16586007)(42186006)(5660300002)(336012);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB5216;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0b981a66-bca0-4513-13b3-08d76f1bd809
X-MS-TrafficTypeDiagnostic: SN6PR02MB5216:
X-Microsoft-Antispam-PRVS: <SN6PR02MB52168FD28B6923A260DC0C1EC1490@SN6PR02MB5216.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 02296943FF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: phyDmrxCE0qzzzHGiPJcUELYw/T+4XaT4HfphWoLFITCR5iZDRc0Be/VJqqP2Q254uEFf9Mlr69C14RhEIHMF62gfvcKxEESlwcaz+cYZT3f2alOXEGxWmBnqMa6rBZpq70SGD1P2IuxouN5iPiIW2eWGE18hmZFQV70vKBHlmXeOAy8FR4lLVCK5ddSJPsMJ77XjlKb1kE/2c8GTMBUGipb8gL6sTG2CgtnmnbhaStGuUxISpgufvN2Zp1eyQClNuwHfKVNgu4PKR9NkOtWd+Mvaa1pu0+zrMKhy4LVgoK4v+12xZD7mHapkIuI9O3aKRjcneO93bpXA7NblVGr9Yj3llIxddmmD4L83P6WjDzX2ue1bVOKLCqg03sPgDri7cWTC+Jk3wceICzl4Q0nUaAa3XJwS4rliepEPCQC9faMJCzNs8sZu/3y1g0Q5aJu
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2019 07:16:07.3756
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b981a66-bca0-4513-13b3-08d76f1bd809
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB5216
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The clock phase properties are having two uint32 values. The minItems
and maxItems are set to 2 for the same. So the property type should be
'uint32-array' and not 'uint32'. Modify it to correct the same.

Reported-by: Rob Herring <robh@kernel.org>
Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 .../devicetree/bindings/mmc/mmc-controller.yaml | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
index 305b2016bc17..b130450c3b34 100644
--- a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
+++ b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
@@ -334,16 +334,17 @@ patternProperties:
       - reg
 
   "^clk-phase-(legacy|sd-hs|mmc-(hs|hs[24]00|ddr52)|uhs-(sdr(12|25|50|104)|ddr50))$":
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32-array
     minItems: 2
     maxItems: 2
-    allOf:
-      - $ref: /schemas/types.yaml#/definitions/uint32
-      - minimum: 0
-        maximum: 359
-    description:
-      Set the clock (phase) delays which are to be configured in the
-      controller while switching to particular speed mode. These values
-      are in pair of degrees.
+    items:
+      minimum: 0
+      maximum: 359
+      description:
+        Set the clock (phase) delays which are to be configured in the
+        controller while switching to particular speed mode. These values
+        are in pair of degrees.
 
 dependencies:
   cd-debounce-delay-ms: [ cd-gpios ]
-- 
2.17.1

