Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55F6CC432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 05:16:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20CFB2146E
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 05:16:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="eII/roRS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391532AbfIZFQn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 01:16:43 -0400
Received: from mail-eopbgr770071.outbound.protection.outlook.com ([40.107.77.71]:63559
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388115AbfIZFQm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 01:16:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RukCi7trHRJyM9rOPZAlZHp2/aP66XXT2+T7wTdUnka0wo+ppr/7i9EJxM3OGCAvzdbRkEsY1B7LOM8xls9FN9QtoGxYS1oz+Eg/NNS7A3StrDuGqt7AwX0jEva93ZWvT6LXh4ye/sKaADFrlalKg9/ksU9yPEopcYUzwr0PgPYaZ6ZZHFTdiRRFBjzZ3ggi/ciZhNwqXvrsdU35kl7Ba7hMIkoskkDvS9teEKriOOSgtR5qZtc6+Ivjbe3KFKhTTADF7e2Aln6ENCpfKb4sSWmOyc00TYVDyZ0vW0ABGfX9tt5PrsEhfArkvFd462IVta1M641KirYCrzG846wfkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nN6NwXBfFtn85lGXs1aqP90unR49CODvj5CUW+h4Hvc=;
 b=RuWyxCv2RmPZMg9x2CA0exwNq6xmBrHP2C6/QqGjC2wcIo2tWUnwTeOQ+AZp6VymjfVNCC8Xfd8FLi1o0Y1Jmz3HgUKYHIEZA+hzzUMiul4KlphFkbAmrSuv27kHpPEC0YdPsNtHbQacAQjWkn+9FmCGtUY/LoXKE9+kWcxWe3CpmhQHQuPwz0jnKZFgVKipIP3GWMEPnu3hf7Ouxvonk4Ir9NiYw2HdYTj4lIZiVoAA/A2hx/w8NVu4j9djzE/mc1Tbe3K8mWmAH1uuHJcauB7n9Hs27TFagQMaQR3BlNAW9n9uCh8/ZQhWI0ervWUiRV9LeqOp//XludFUyK9mDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.100) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=xilinx.com; dmarc=bestguesspass action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nN6NwXBfFtn85lGXs1aqP90unR49CODvj5CUW+h4Hvc=;
 b=eII/roRSnhO2t60MNCnE3sG4dPAjSRe54DmEMrjJHqj1bECagK7btY81GOtJaovUKH6Ctoo+fx30G8cOJHu7k09GBTvzZebP+XtMd7EPGGBMCK8G+O+oav+u3m8fMJczsKUiF2qsXwCuGeQDcdWvcCOxNtCT0ctvIqPt9JCtbSE=
Received: from BL0PR02CA0119.namprd02.prod.outlook.com (2603:10b6:208:35::24)
 by DM6PR02MB5596.namprd02.prod.outlook.com (2603:10b6:5:7b::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.23; Thu, 26 Sep
 2019 05:16:39 +0000
Received: from CY1NAM02FT025.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::200) by BL0PR02CA0119.outlook.office365.com
 (2603:10b6:208:35::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2305.15 via Frontend
 Transport; Thu, 26 Sep 2019 05:16:38 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 CY1NAM02FT025.mail.protection.outlook.com (10.152.75.148) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2284.25
 via Frontend Transport; Thu, 26 Sep 2019 05:16:38 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:37125 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1iDM8r-0007XH-3U; Wed, 25 Sep 2019 22:16:37 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1iDM8m-0007in-6T; Wed, 25 Sep 2019 22:16:32 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x8Q5GUaa020921;
        Wed, 25 Sep 2019 22:16:30 -0700
Received: from [10.140.6.59] (helo=xhdshubhraj40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1iDM8j-0007hs-Nj; Wed, 25 Sep 2019 22:16:30 -0700
From:   Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
To:     linux-kernel@vger.kernel.org
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org, arnd@arndb.de,
        gregkh@linuxfoundation.org, michal.simek@xilinx.com,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [RFC PATCHv2 1/3] dt-bindings: misc: Add dt bindings for flex noc Performance Monitor
Date:   Thu, 26 Sep 2019 10:46:24 +0530
Message-Id: <2de75a74ef4086090c532d3b80b7d6dcd115e45e.1569474867.git.shubhrajyoti.datta@xilinx.com>
X-Mailer: git-send-email 2.1.1
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(376002)(346002)(136003)(396003)(199004)(189003)(26005)(106002)(51416003)(305945005)(7696005)(186003)(5660300002)(126002)(486006)(8746002)(476003)(50226002)(2616005)(9786002)(6666004)(8676002)(44832011)(36386004)(5024004)(356004)(8936002)(14444005)(81156014)(118296001)(316002)(81166006)(48376002)(2906002)(426003)(70206006)(336012)(50466002)(2351001)(6916009)(47776003)(478600001)(70586007)(107886003)(36756003)(4326008)(2361001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB5596;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;A:1;MX:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1197bd73-8ae1-4035-05d8-08d74240b56f
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(4709080)(1401327)(4618075)(2017052603328);SRVR:DM6PR02MB5596;
X-MS-TrafficTypeDiagnostic: DM6PR02MB5596:
X-Microsoft-Antispam-PRVS: <DM6PR02MB5596C5828AB473C8D4E6E374AA860@DM6PR02MB5596.namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 0172F0EF77
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: ADocNE0RF5qtl1//WG0bWCGlL1/9VaBKKf3XcgwmE1aaUwuZbZj5PzdyTyXnoRJE8/YicW6UdNh30LiLqAkWc9LzMBD6AhlxGfd3ayBKXTF/ffJCJULjFo0TluJGjOcDLAnZmBjlDyNA9KoE28IalVfwk0moGBmO5vYquMUw4uWKq+amCCIrdgbI1tCCBjyI2wvtz5eqqFC1/hAzyT0upW1Um3ckGqXkXobNXW5debcfdl26PUIGjGN1xTyLDvrUAiGR9tjrmAAkByYjQkyt/cFX3hcNhKXztY/ljz/8dsuTWNU8ZvkC5Dp1dtkBgANqdTKn56uoSf2yNyxkrtJTFm339h9O1eh1wMREIZ9XEuZtKtPvv4vOEda+eNm2NY7kbspVdcPo3w6sXLJ0lewXupdqiI7pjYHxpnTonrN9rLI=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2019 05:16:38.3575
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1197bd73-8ae1-4035-05d8-08d74240b56f
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5596
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
