Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD229C432C1
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 11:23:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83AF721D82
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 11:23:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="NVSs3RDs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404515AbfIYLX1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 07:23:27 -0400
Received: from mail-eopbgr690080.outbound.protection.outlook.com ([40.107.69.80]:30946
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732365AbfIYLX1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 07:23:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H2NG9lpuEw86uJ+pfSKLlg3i3N/g55tICGPS2W63JLt0l8+3Dq2WcowQSh7YMpS6KsnO2wgsw4w+ha/QExNpraypn5Qj1LxdwNwRbgWd7HDw52NfZ6nwgaAipxwPSd8WonnEiPYuSYHmFkHdfHIsS5vNPhqKNuUhKpF28io68JsoO6F+pfLO5MHW5BZLzgICAOaQ90S7h7F5wDd0iUVBpK064RqEBHZGyvkv1WRwT8+/arU5NuTPd9S9GTIBhf40/M5t6cPH/9SbNMSjI9bT8qLpXsuehhYoaZSdpGet1DhNeyO54YvsMoju8bVOCF88aAfq1r0hu6ucn6SZFcmZAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nN6NwXBfFtn85lGXs1aqP90unR49CODvj5CUW+h4Hvc=;
 b=Xnmmd3INSM8EIQdTUl+aPH9OUsTjkNxl0AJv4WFtQ1seW9TYcYgIWcgZK2ALppt86Ur1wUxu70FhA5AsMRaM/D82/4+en7DLddwdWGIlJ1Erbo5EgR8s7sxJC8yPxAlg6oq12LZ2GfoNIpFqaj8LoYX7xNao6E0OjLBHlOqCQeToIQ2EZWOh8I93rZdZ65wwKmDnNPNLKEUeQznQLUA8zB4eopnRwo3CxKX6EYqHNhHvZiZcpxnLLq6MuVPWfgEOdTx1IbKuVJlUd43uJmldleByLZFLYLNFU+XEz7Qw2HmYA60Lxg3mImj5tQTRKp9HmN65u/9Whvthb/WQf5RunQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nN6NwXBfFtn85lGXs1aqP90unR49CODvj5CUW+h4Hvc=;
 b=NVSs3RDswedk0wdojfSeJehvpZBOmbjJ+VcBU23jjf/ozV9PJCKAUyBb1VlABA8J3HI9RxsVoPx6w7k3KeHcXwHNzoKn2SXUkf7FDHdtfUXnf8OAlMHZgFos3EC3+xFNTB69FGQXqHssTkLcRd0bpFnNuhfuRHRZCpzMmQaoHP0=
Received: from BL0PR02CA0059.namprd02.prod.outlook.com (2603:10b6:207:3d::36)
 by BYAPR02MB5255.namprd02.prod.outlook.com (2603:10b6:a03:66::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.26; Wed, 25 Sep
 2019 11:23:23 +0000
Received: from BL2NAM02FT036.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::207) by BL0PR02CA0059.outlook.office365.com
 (2603:10b6:207:3d::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2178.16 via Frontend
 Transport; Wed, 25 Sep 2019 11:23:23 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 BL2NAM02FT036.mail.protection.outlook.com (10.152.77.154) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2284.25
 via Frontend Transport; Wed, 25 Sep 2019 11:23:23 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:39658 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1iD5OE-00075I-CF; Wed, 25 Sep 2019 04:23:22 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1iD5O9-0004nc-8x; Wed, 25 Sep 2019 04:23:17 -0700
Received: from [10.140.6.59] (helo=xhdshubhraj40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1iD5O2-0004n8-Kx; Wed, 25 Sep 2019 04:23:11 -0700
From:   Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
To:     linux-kernel@vger.kernel.org
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org, arnd@arndb.de,
        gregkh@linuxfoundation.org, michal.simek@xilinx.com,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [RFC PATCH 1/2] dt-bindings: misc: Add dt bindings for flex noc Performance Monitor
Date:   Wed, 25 Sep 2019 16:53:06 +0530
Message-Id: <2de75a74ef4086090c532d3b80b7d6dcd115e45e.1569410216.git.shubhrajyoti.datta@xilinx.com>
X-Mailer: git-send-email 2.1.1
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(376002)(396003)(136003)(39860400002)(346002)(189003)(199004)(36756003)(486006)(51416003)(7696005)(70206006)(70586007)(118296001)(6916009)(2616005)(476003)(426003)(9786002)(5660300002)(107886003)(36386004)(4326008)(106002)(5024004)(14444005)(2361001)(336012)(186003)(316002)(48376002)(50226002)(126002)(47776003)(44832011)(305945005)(356004)(8746002)(6666004)(50466002)(8936002)(81166006)(81156014)(2351001)(2906002)(478600001)(26005)(8676002)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB5255;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;MX:1;A:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2b9c6c5a-02b2-4d9f-0ace-08d741aac6dc
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(4709080)(1401327)(4618075)(2017052603328);SRVR:BYAPR02MB5255;
X-MS-TrafficTypeDiagnostic: BYAPR02MB5255:
X-Microsoft-Antispam-PRVS: <BYAPR02MB52552F3D611B573D0C9A11AFAA870@BYAPR02MB5255.namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 01713B2841
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: BetaiznP+W67d78KLvJVmqg/1e7FbppA/2i0eF/nu0YZXdgmPGdDY+JAKKsLGxavL3AYmKgd2TwqZWMyXixfeZxodPGXjwks1j7eswmf6y9K7/UkXQXAx5CazH3DSmYcZ/xPLwjsNJ1XGDlG7hXwuj0zIu2xufTRqTubgGg+hkscqv1ZOTwsXRO8XcgmzhDsUlohvU8r9j1wnua6cvxae9RaRUFIegjozdNG8JHOFKCuFH8oK3hrJRJFz1BiFUxsgp4xYbo9Eh4AFZ948SsIl0EtgaDuvwe3waKR58Mk1UQ4DTQ8t1M9KJU0Uwzl9xfuM4jAcRsCuapQSz4JpJKgZ+T4YjYVO2cspg2TgfdX1f+RIJBaqmRulaY86At+71U+uM7ADipbucYyH+k1YwIMvmX/U3mr9b/8rtv3sPf2gv0=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2019 11:23:23.1028
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b9c6c5a-02b2-4d9f-0ace-08d741aac6dc
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5255
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dt bindings for flexnoc Performance Monitor.
The flexnoc counters for read and write response and requests are
supported.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
---
 .../devicetree/bindings/misc/xlnx,flexnoc.txt      | 24 ++++++++++++++++++=
++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/xlnx,flexnoc.txt

diff --git a/Documentation/devicetree/bindings/misc/xlnx,flexnoc.txt b/Docu=
mentation/devicetree/bindings/misc/xlnx,flexnoc.txt
new file mode 100644
index 0000000..6b533bc
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/xlnx,flexnoc.txt
@@ -0,0 +1,24 @@
+* Xilinx Flexnoc Performance Monitor driver
+
+The FlexNoc Performance Monitor has counters for monitoring
+the read and the write transaction counter.
+
+Required properties:
+- compatible: "xlnx,flexnoc-pm-2.7"
+- reg : Address and length of register sets for each device in
+       "reg-names"
+- reg-names : The names of the register addresses corresponding to the
+               registers filled in "reg"
+               - funnel: base address of the funnel registers
+               - baselpd: base address of the LPD PM registers
+               - basefpd: base address FPD PM registers
+
+Example:
+++++++++
+performance-monitor@f0920000 {
+               compatible =3D "xlnx,flexnoc-pm-2.7";
+               reg-names =3D "funnel", "baselpd", "basefpd";
+               reg =3D <0x0 0xf0920000 0x0 0x1000>,
+                       <0x0 0xf0980000 0x0 0x9000>,
+                       <0x0 0xf0b80000 0x0 0x9000>;
+};
--
2.1.1

This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
