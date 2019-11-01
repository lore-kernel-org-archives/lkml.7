Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 175D8CA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 06:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E315C208CB
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 06:06:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="N66EEaVg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729387AbfKAGGO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 02:06:14 -0400
Received: from mail-eopbgr800058.outbound.protection.outlook.com ([40.107.80.58]:51024
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727995AbfKAGGN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 02:06:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ne07BTbih/2+IaF9XoCuyq65G3mC0SLybFkL3Anv0TPK1/feBx03hiEnBc+o6w7B9b8nCziDvuNyxzz49MuNdQ4NAbBxQ3deWbFZh6VwteVSvoUXcbgiFV0WHEviMl5tCREurZ9uRsNsb5qqx3qssUkN/86BQ3N1eesFh9biiGRB1bLPVaXb/tutiGhzFQF92pcmWn7uIMqvy6SHZuq1HR2wu2+hnGdBtTzQzJSQE9eIKhZIJkMwRLOWylZc8vRb7RJZliAf40oNMp370Q978thyyS39DHsqANT0rT9KBQ6rn3QNjTspG4qAw3Ml7kpmRnaxx6s0wfgYb5umcg/Ilw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qzXvD+IcJGqNn9EqJ780uC5HVrfKOntSd7rWjYG8Csg=;
 b=R6lVbzxAECWfiKWxjiRmhzqAgLb6izDwKpMt8l97+u0FciJ4Qk9eQyX1jlzIOQo5C5kFDIOhsX+z1CZlxWVwPW021bJAf7dMfd5FxtfNAXUdkkaaG1Djx0Kdj/tMnRFEQRsmedkP1JwJWN4uJZMPvKvrnZvcysvGsAINc5nNztWw9sFatesb67cS4SRhisJmDA539+YS5P1ORb5e7HIOUV3Bf9Z6N4/8ZidTOo2jTG1OjkWuu6LepnP+qOFNBqtLuFj+1Z7pcs4SFbwSPXqQOmrxsVeeK7JfAqUp8OoW0uQvbzTLQ26wGMu/KwBRcBCAX6sZJpQ+R9e1XC5iW/L/ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qzXvD+IcJGqNn9EqJ780uC5HVrfKOntSd7rWjYG8Csg=;
 b=N66EEaVgw2Te8HM65AfDbmTqD/03yQh9tispybXrsgDhaUP6WuPv4O4UG3je+DopQkSzbZxmRPXomQ6ea31u0PbPGIq5icuxQuVJxiW1uw5FfADux675Q+OvrUpOrYAFnavTxazMXwc1aNwlDJulBCIC8c/gLruYfcd53ckZw8Q=
Received: from SN4PR0201CA0051.namprd02.prod.outlook.com
 (2603:10b6:803:20::13) by CH2PR02MB6727.namprd02.prod.outlook.com
 (2603:10b6:610:ac::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2408.18; Fri, 1 Nov
 2019 06:06:10 +0000
Received: from SN1NAM02FT006.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::202) by SN4PR0201CA0051.outlook.office365.com
 (2603:10b6:803:20::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2408.21 via Frontend
 Transport; Fri, 1 Nov 2019 06:06:10 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT006.mail.protection.outlook.com (10.152.72.68) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2387.20
 via Frontend Transport; Fri, 1 Nov 2019 06:06:10 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1iQQ4X-0005mX-Nn; Thu, 31 Oct 2019 23:06:09 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1iQQ4S-0007dN-Is; Thu, 31 Oct 2019 23:06:04 -0700
Received: from xsj-pvapsmtp01 (mail.xilinx.com [149.199.38.66] (may be forged))
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id xA165wT3005661;
        Thu, 31 Oct 2019 23:05:58 -0700
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1iQQ4L-0007Zu-ML; Thu, 31 Oct 2019 23:05:57 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id E355E121380; Fri,  1 Nov 2019 11:35:56 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        adrian.hunter@intel.com, michal.simek@xilinx.com,
        jolly.shah@xilinx.com, nava.manne@xilinx.com,
        rajan.vaja@xilinx.com, manish.narani@xilinx.com
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        git@xilinx.com
Subject: [PATCH v5 2/8] dt-bindings: mmc: arasan: Update Documentation for the input clock
Date:   Fri,  1 Nov 2019 11:35:47 +0530
Message-Id: <1572588353-110682-3-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1572588353-110682-1-git-send-email-manish.narani@xilinx.com>
References: <1572588353-110682-1-git-send-email-manish.narani@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(396003)(39860400002)(346002)(376002)(199004)(189003)(36756003)(6666004)(16586007)(316002)(8676002)(36386004)(2906002)(48376002)(81166006)(50466002)(103686004)(8936002)(81156014)(42186006)(356004)(106002)(70586007)(70206006)(4326008)(476003)(478600001)(486006)(47776003)(51416003)(50226002)(126002)(26005)(2616005)(186003)(107886003)(11346002)(76176011)(6266002)(5660300002)(44832011)(426003)(336012)(446003)(305945005)(42866002);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR02MB6727;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d576206d-ae71-4bb1-598a-08d75e9197a2
X-MS-TrafficTypeDiagnostic: CH2PR02MB6727:
X-Microsoft-Antispam-PRVS: <CH2PR02MB672774A070CC56A62D9001CAC1620@CH2PR02MB6727.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 020877E0CB
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FqsK8ePPEcInVTZs3GAK8aMjWCCQLZI/uLFsp1+JzO5Yf3AgKjZXeG8VZyEgoHjzpT+UedaLG7ZOhKDU+odHmchtQ3z7c8uvLZsoTFyfeevpvi/1vzRgad6tiaxw3Dc4Ln95FdHQ69/I1Z3VE4FvtWDur40cpx50vGVnrhuZS9FRZ7GEl1xyx6+iVov5Fdc2xcinxbeTP/KbDrFiVBEVW9euypSV2MIc6XPZDMh2JqdBqU6Vhvn8R/vumc8IOJEHlzUWtlTlGS2AONbEVg+PSVqus3+CMMgsDKg+m1paPBNqJu9CkolVlw/d3+icXDDLfIfnda+DUSKGpY9gL2A7uIEyVmCzGGlZEx44EF7ijlPAuXRIdo/Tv/thK1DUiJPlyboJzQJm11vymxhmc5KGBFmcNCEvR+nl8WT611MKWnZ1o1vMmaxO2vbejksx98Y1
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2019 06:06:10.2111
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d576206d-ae71-4bb1-598a-08d75e9197a2
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6727
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for an optional input clock which is essentially used
in sampling the input data coming from the card.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/mmc/arasan,sdhci.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
index 7ca0aa7ccc0b..b51e40b2e0c5 100644
--- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
+++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
@@ -38,9 +38,9 @@ Optional Properties:
   - clock-output-names: If specified, this will be the name of the card clock
     which will be exposed by this device.  Required if #clock-cells is
     specified.
-  - #clock-cells: If specified this should be the value <0>.  With this property
-    in place we will export a clock representing the Card Clock.  This clock
-    is expected to be consumed by our PHY.  You must also specify
+  - #clock-cells: If specified this should be the value <0> or <1>. With this
+    property in place we will export one or two clocks representing the Card
+    Clock. These clocks are expected to be consumed by our PHY.
   - xlnx,fails-without-test-cd: when present, the controller doesn't work when
     the CD line is not connected properly, and the line is not connected
     properly. Test mode can be used to force the controller to function.
-- 
2.17.1

