Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86F39C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 07:18:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48A0E20833
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 07:18:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="HIkYI97v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbfDOHSZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 03:18:25 -0400
Received: from mail-eopbgr760058.outbound.protection.outlook.com ([40.107.76.58]:3298
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725798AbfDOHSY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 03:18:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j5YiH5PJEovf7iM82VAbKE6BAOfhfmV1W+gur+IlPzw=;
 b=HIkYI97vycDfCUHSVKYt/+VRgyHYp97y6PCiHeYTggbXF3YsGaWF+uh7z+rR2sw6XQk4dhIivMOpMqPgnZw+7N4ClHT4YVpAIu5Vsulmo15dGr6219diAW743oKOtSDDYl9hPzZI4WOHR36zvLn57gRg77l+4noV8/g67pUquUQ=
Received: from SN6PR02CA0019.namprd02.prod.outlook.com (2603:10b6:805:a2::32)
 by BY2PR02MB154.namprd02.prod.outlook.com (2a01:111:e400:2c20::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.1792.17; Mon, 15
 Apr 2019 07:18:20 +0000
Received: from SN1NAM02FT051.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::201) by SN6PR02CA0019.outlook.office365.com
 (2603:10b6:805:a2::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1792.16 via Frontend
 Transport; Mon, 15 Apr 2019 07:18:19 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT051.mail.protection.outlook.com (10.152.73.103) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1771.16
 via Frontend Transport; Mon, 15 Apr 2019 07:18:19 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1hFvsg-0007BT-PK; Mon, 15 Apr 2019 00:18:18 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1hFvsb-0006pC-Lq; Mon, 15 Apr 2019 00:18:13 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x3F7ICM6029682;
        Mon, 15 Apr 2019 00:18:12 -0700
Received: from [172.23.37.118] (helo=xhdnavam40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1hFvsZ-0006nQ-Fw; Mon, 15 Apr 2019 00:18:11 -0700
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <atull@kernel.org>, <mdf@kernel.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <michal.simek@xilinx.com>,
        <rajanv@xilinx.com>, <jollys@xilinx.com>, <nava.manne@xilinx.com>,
        <linux-fpga@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <chinnikishore369@gmail.com>
Subject: [PATCH v5 0/3]Add Bitstream configuration support for ZynqMP  
Date:   Mon, 15 Apr 2019 12:47:45 +0530
Message-ID: <20190415071748.32275-1-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.18.0
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(376002)(39860400002)(346002)(136003)(2980300002)(189003)(199004)(478600001)(2906002)(50466002)(106002)(47776003)(81166006)(48376002)(8676002)(356004)(36756003)(16586007)(6666004)(4744005)(305945005)(486006)(5660300002)(316002)(81156014)(8936002)(336012)(426003)(63266004)(106466001)(2616005)(26005)(77096007)(50226002)(186003)(7696005)(51416003)(126002)(476003)(110136005)(9786002)(1076003)(36386004)(2201001)(921003)(2101003)(83996005)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR02MB154;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0fed832d-5a45-486d-eff7-08d6c172896b
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600140)(711020)(4605104)(4709054)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328);SRVR:BY2PR02MB154;
X-MS-TrafficTypeDiagnostic: BY2PR02MB154:
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BY2PR02MB154ED740E3EFAAC7C32857CC22B0@BY2PR02MB154.namprd02.prod.outlook.com>
X-Forefront-PRVS: 000800954F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: aEsdxrTcz+pROQbym4kmazqsl80aFBTszCFajSbSUWz1c/sjZI4tqR38podzMs+T9KubX2NkUmw+E4OJAH3R5Tzs/zRFb6DQQtXpg3Y2yr9E4yvnFl4VolqGrQjXyyFTz+ygR3UHS70VUlKysWRr8kSSHRAQkNMlfKfl538hu/vdQgENfz5XuQPDZlZGKghPBytPj4j/3R1B4unytxfKkO/w2rTgle0pYQoph1+AEMN5mxS+zvylMiingECyOH4zWrOH7S85u/G31eAR2qCKcrI9ClPnZr8kugKceV8VNF7KUoqvV+6F/oGtmJP0i4zPfgdxOrR4V4ofTCXVbm2Jvj0p+/zs0buKFlaM7TC2ceLaHYTLq+3px2oh0fnecKov+zjq7pWUsG8hG91dzhspcAMbF41MBOCyXTwuejuarik=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2019 07:18:19.1895
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fed832d-5a45-486d-eff7-08d6c172896b
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR02MB154
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nava kishore Manne (3):
  firmware: xilinx: Add fpga API's
  dt-bindings: fpga: Add bindings for ZynqMP fpga driver
  fpga manager: Adding FPGA Manager support for Xilinx zynqmp

 .../bindings/fpga/xlnx,zynqmp-pcap-fpga.txt   |  25 +++
 drivers/firmware/xilinx/zynqmp.c              |  45 +++++
 drivers/fpga/Kconfig                          |   9 +
 drivers/fpga/Makefile                         |   1 +
 drivers/fpga/zynqmp-fpga.c                    | 159 ++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h          |  12 ++
 6 files changed, 251 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt
 create mode 100644 drivers/fpga/zynqmp-fpga.c

-- 
2.18.0

