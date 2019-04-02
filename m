Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AEEBC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 12:31:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CE1820883
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 12:31:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="c26qQZCV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731016AbfDBMbl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 08:31:41 -0400
Received: from mail-eopbgr750075.outbound.protection.outlook.com ([40.107.75.75]:7054
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728733AbfDBMbk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 08:31:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SlxihHyFCNXMiEVnYZ2GlNuA/ZY+GbEdR775cR0QXZw=;
 b=c26qQZCV4KGI4ujm9Heyn+7U1yE1JWtUTkvcip9bXVNzn/bwZAnx2FW37eqn5eDfXBRb2lSNKfkTQcR7J00H2UqsB6gvdZgu3BTcmDXPnWA/x2EhLIH3V5eNuEcFH/+UvkJrU/8rB6mfU80a9FVS+5Q7HxLFINL5gnWwMVWvw1A=
Received: from SN4PR0201CA0025.namprd02.prod.outlook.com
 (2603:10b6:803:2e::11) by BLUPR02MB1649.namprd02.prod.outlook.com
 (2a01:111:e400:525f::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1750.17; Tue, 2 Apr
 2019 12:31:37 +0000
Received: from SN1NAM02FT011.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::206) by SN4PR0201CA0025.outlook.office365.com
 (2603:10b6:803:2e::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1750.22 via Frontend
 Transport; Tue, 2 Apr 2019 12:31:37 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 SN1NAM02FT011.mail.protection.outlook.com (10.152.72.82) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1750.16
 via Frontend Transport; Tue, 2 Apr 2019 12:31:36 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:53240 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1hBIZk-0006CH-8J; Tue, 02 Apr 2019 05:31:36 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1hBIZf-0007V3-4U; Tue, 02 Apr 2019 05:31:31 -0700
Received: from [172.23.37.118] (helo=xhdnavam40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1hBIZb-0007U9-LR; Tue, 02 Apr 2019 05:31:28 -0700
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <atull@kernel.org>, <mdf@kernel.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <michal.simek@xilinx.com>,
        <rajanv@xilinx.com>, <jollys@xilinx.com>, <nava.manne@xilinx.com>,
        <linux-fpga@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <chinnikishore369@gmail.com>
Subject: [PATCH v4 0/3] Add Bitstream configuration support for ZynqMP 
Date:   Tue, 2 Apr 2019 18:01:20 +0530
Message-ID: <20190402123123.915-1-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.18.0
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(136003)(376002)(346002)(39860400002)(2980300002)(189003)(199004)(81156014)(16586007)(50226002)(106466001)(426003)(63266004)(81166006)(36756003)(6666004)(4744005)(1076003)(51416003)(48376002)(50466002)(5660300002)(2906002)(2201001)(356004)(36386004)(478600001)(9786002)(77096007)(126002)(26005)(476003)(336012)(186003)(7696005)(2616005)(4743002)(486006)(110136005)(316002)(106002)(305945005)(8676002)(8936002)(47776003)(921003)(83996005)(5001870100001)(1121003)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR02MB1649;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;MX:1;A:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 27e42c50-21ba-474e-057d-08d6b7672640
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4709054)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328);SRVR:BLUPR02MB1649;
X-MS-TrafficTypeDiagnostic: BLUPR02MB1649:
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BLUPR02MB1649A8CC1319F181C4EE65E5C2560@BLUPR02MB1649.namprd02.prod.outlook.com>
X-Forefront-PRVS: 0995196AA2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 1bwlrR1/V+b2xNB+p6rsodzP1SB1oVUttNk7j61/Z0n58wvb15g5kgo2cADvw4ydcoGZ4Xa/98aQWp4wv8i9XU6nKuPsS0kXkjY+Lz2MsyiHFfEm/sH63ppGIcMgtLQNTBdlpMTY7vyYyiw0hSTZfNA5ZaG8cuzscqmSe/gfHbmlBNuYpxZPaP/HyKZH7q7+I2ioFU2XIBc60sYgtYXCOrBMDH2iAzfcVAhB8vf/Y9Cs+3gVCV9wRiubsKB8VMtdIfNXSAaYX2an+8ehxJnt2mwWgA/yEYW6a2kPacH3oeubHibnS5VwT9PD0dJCEbWEQ8UHAyMvyljD6Ioz0ivO+9TL/2UjQ7A1JGytybaOSMwUBUVsbhTWh0s/3mRBCogPR+/sGFeB5zK4wie4fexBbb6VRfQqfveaSvmHorE+THM=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2019 12:31:36.7135
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27e42c50-21ba-474e-057d-08d6b7672640
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR02MB1649
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nava kishore Manne (3):
  firmware: xilinx: Add fpga API's
  dt-bindings: fpga: Add bindings for ZynqMP fpga driver
  fpga manager: Adding FPGA Manager support for Xilinx zynqmp

 .../bindings/fpga/xlnx,zynqmp-pcap-fpga.txt   |  25 +++
 drivers/firmware/xilinx/zynqmp.c              |  46 +++++
 drivers/fpga/Kconfig                          |   9 +
 drivers/fpga/Makefile                         |   1 +
 drivers/fpga/zynqmp-fpga.c                    | 159 ++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h          |  10 ++
 6 files changed, 250 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt
 create mode 100644 drivers/fpga/zynqmp-fpga.c

-- 
2.18.0

