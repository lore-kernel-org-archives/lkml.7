Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F9AC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 14:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAAE420685
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 14:38:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="OQgZtekh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727861AbfDVOiV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 10:38:21 -0400
Received: from mail-eopbgr810071.outbound.protection.outlook.com ([40.107.81.71]:1857
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726098AbfDVOiR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 10:38:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dw92e3kVaMmqM7Vmf8Ys6HckmOuTJjdthtAHaLvaoWg=;
 b=OQgZtekheLaWhPM/EhEnWTPnavVPZxsWrqMG/eldyS1w/sdC+yurKZOkuiKWx7/BU2pgIDMhXBYrxU5qN5UHk/CKp/JHdw03x6T2NI/aHZPCL2HG26rSmc8+QS631mNvjtj1chL1PQDNDcP9Ud/iWD/HBd0gKlGLHFrsrZ18Cr0=
Received: from SN6PR02CA0025.namprd02.prod.outlook.com (2603:10b6:805:a2::38)
 by BL2PR02MB498.namprd02.prod.outlook.com (2a01:111:e400:c2e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1813.16; Mon, 22 Apr
 2019 14:38:11 +0000
Received: from SN1NAM02FT028.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::200) by SN6PR02CA0025.outlook.office365.com
 (2603:10b6:805:a2::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1813.12 via Frontend
 Transport; Mon, 22 Apr 2019 14:38:10 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 SN1NAM02FT028.mail.protection.outlook.com (10.152.72.105) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1771.16
 via Frontend Transport; Mon, 22 Apr 2019 14:38:09 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:58321 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1hIa5B-0004P1-1H; Mon, 22 Apr 2019 07:38:09 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1hIa55-0002k7-Tz; Mon, 22 Apr 2019 07:38:03 -0700
Received: from xsj-pvapsmtp01 (smtp-fallback.xilinx.com [149.199.38.66] (may be forged))
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x3MEbuK1012432;
        Mon, 22 Apr 2019 07:37:56 -0700
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1hIa4y-0002Ze-8P; Mon, 22 Apr 2019 07:37:56 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id 6D4461212BC; Mon, 22 Apr 2019 20:07:55 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     <jic23@kernel.org>, <knaack.h@gmx.de>, <lars@metafoo.de>,
        <pmeerw@pmeerw.net>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <michal.simek@xilinx.com>, <manish.narani@xilinx.com>,
        <Jisheng.Zhang@synaptics.com>, <olof@lixom.net>,
        <dinguyen@kernel.org>, <amit.kucheria@linaro.org>,
        <stefan.popa@analog.com>, <dmurphy@ti.com>,
        <marcus.folkesson@gmail.com>, <tmaimon77@gmail.com>,
        <ricardo@ribalda.com>, <xc-racer2@live.ca>,
        <contact@artur-rojek.eu>, <geert@linux-m68k.org>,
        <smohanad@codeaurora.org>, <charles-antoine.couret@essensium.com>,
        <stefan@agner.ch>, <max.krummenacher@toradex.com>,
        <lee.jones@linaro.org>
CC:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 0/3] Add Xilinx AMS Driver
Date:   Mon, 22 Apr 2019 20:07:47 +0530
Message-ID: <1555943870-15353-1-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(1496009)(136003)(376002)(346002)(396003)(39860400002)(2980300002)(199004)(189003)(476003)(70206006)(106002)(6266002)(8936002)(2616005)(426003)(63266004)(36756003)(44832011)(26005)(70586007)(336012)(14444005)(5660300002)(316002)(42186006)(90966002)(16586007)(126002)(186003)(110136005)(50226002)(52956003)(54906003)(50466002)(486006)(48376002)(6666004)(356004)(8676002)(47776003)(72206003)(4326008)(478600001)(2201001)(51416003)(7416002)(81166006)(2906002)(305945005)(36386004)(81156014)(103686004)(921003)(42866002)(1121003)(5001870100001)(2101003)(83996005);DIR:OUT;SFP:1101;SCL:1;SRVR:BL2PR02MB498;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;A:1;MX:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dd9da7d6-7bdd-4428-fb5d-08d6c7302485
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4709054)(2017052603328);SRVR:BL2PR02MB498;
X-MS-TrafficTypeDiagnostic: BL2PR02MB498:
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BL2PR02MB498E493C0D35E77A7A9DBA5C1220@BL2PR02MB498.namprd02.prod.outlook.com>
X-Forefront-PRVS: 00159D1518
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: eZpSBOBqI8+g49zP+NdHQ4Hk4QeYuUFlksaX4rpH1HhbnQkvoPrafA9XjvQl0+aR32cymMPQ7Zm/eRe9G2DmCyq2yYo5BGH9DXFVRU6erf+zF0Ss9n8bf124x49vQitVmJR1N+V0lYOA27n35/XZ4s7vdb0ZpQIAwfaCL6nFL0AsoHDW6Yg7Q4euINplzjNc+/livld52683rZ99GE0NDh2tG5Zjah09lSlycPl5IQw9ztRtvPBX+c07LRgG9rMYrJQ4fOtYrJtdKZIW1DHLoqd5VV5dgzWFD0rdqCEmUdMYrMBKuSOZ9V6r8Sbbkb+kqYL+eiXrpPq4JIx+FH38sllGYcjG+0wLne2iEuZE3tZKHC5uGk+QOgXDGGQ9/ryKSDZU9EAp8E2UcSYbcx7OLm5jGAhh3UVjvVV8Um/KUdY=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2019 14:38:09.5324
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd9da7d6-7bdd-4428-fb5d-08d6c7302485
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2PR02MB498
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Xilinx AMS driver which is used for Xilinx's ZynqMP AMS controller.
This AMS driver is used to report various interface voltages and temperatures
across the system.
This driver will be used by iio-hwmon to repport voltages and temperatures
across the system by using various channel interfaces.
This driver handles AMS module including PS-Sysmon & PL-Sysmon. The binding
documentation is added for understanding of AMS, PS, PL Sysmon Channels.

Changes in v2:
	- Added documentation for sysfs (Patch-2)
	- Addressed code style review comments
	- Patch-2 (Now it is Patch-3)
		- Arranged the includes in alphabetical order
		- Removed the wrapper 'ams_pl_write_reg()' and used writel
		  instead
		- Removed the unnecessary delay of 1ms and used polling of EOC
		  instead
		- Removed spin_lock and used mutex only.
		- Used request_irq() instead of devm_request_irq() and handled
		  respective error conditions
		- Moved contents of xilinx-ams.h to inline with xilinx-ams.c
	- Patch-1
		- Addressed Documentation style comments

Changes in v3:
	- Updated bindings document with the suggested modification in v2 review
	- Removed documentation for sysfs
	- Removed extended names for channels in the Xilinx AMS driver
	- Modified dts to use ranges for child nodes
	- Reduced address and size cells to 32-bit instead of 64-bit

Changes in v4:
	- Updated bindings document with the suggested modification in v3 review
	- Changed the Device Tree property 'ranges' for child nodes
	- Used Channel Numbers as 'reg' value in DT to avoid confusion
	- Removed unused NULL arguments as suggested in v3 patch review
	- Addressed comments on Device Tree property naming

Manish Narani (3):
  dt-bindings: iio: adc: Add Xilinx AMS binding documentation
  iio: adc: Add Xilinx AMS driver
  arm64: zynqmp: DT: Add Xilinx AMS node

 .../devicetree/bindings/iio/adc/xilinx-ams.txt     |  183 +++
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi             |   26 +
 drivers/iio/adc/Kconfig                            |   10 +
 drivers/iio/adc/Makefile                           |    1 +
 drivers/iio/adc/xilinx-ams.c                       | 1341 ++++++++++++++++++++
 5 files changed, 1561 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/xilinx-ams.txt
 create mode 100644 drivers/iio/adc/xilinx-ams.c

-- 
2.1.1

