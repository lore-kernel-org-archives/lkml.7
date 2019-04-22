Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 296AFC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 14:38:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBBF520685
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 14:38:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="wa4YJ9Nn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727810AbfDVOiQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 10:38:16 -0400
Received: from mail-eopbgr690076.outbound.protection.outlook.com ([40.107.69.76]:18348
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727780AbfDVOiP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 10:38:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fm8WsAXPfCynyXxKqOCU0ry+V0kG4EI7cufT9LF4u/k=;
 b=wa4YJ9NnS0vv3x8oUQcmj4BpQJbW+6theaBUyhH2ca/OIDmXiNP5Rmo3p2nCQQRLmmytNZ82x7iGMVVwuWxity5CoEwIUllqVvjn726VjEL0kJYgcfmGkCV/hfZVZc+wZWg/9KDxGAeclXFNRrydPxV2jkghjkpqI0OWYT4feVk=
Received: from BL0PR02CA0034.namprd02.prod.outlook.com (2603:10b6:207:3c::47)
 by SN6PR02MB4941.namprd02.prod.outlook.com (2603:10b6:805:99::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1813.14; Mon, 22 Apr
 2019 14:38:11 +0000
Received: from CY1NAM02FT006.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::208) by BL0PR02CA0034.outlook.office365.com
 (2603:10b6:207:3c::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1813.12 via Frontend
 Transport; Mon, 22 Apr 2019 14:38:11 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 CY1NAM02FT006.mail.protection.outlook.com (10.152.74.104) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1771.16
 via Frontend Transport; Mon, 22 Apr 2019 14:38:09 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:58313 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1hIa5A-0004P0-Vq; Mon, 22 Apr 2019 07:38:08 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1hIa55-0002k7-SS; Mon, 22 Apr 2019 07:38:03 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x3MEbudN023909;
        Mon, 22 Apr 2019 07:37:56 -0700
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1hIa4y-0002Zh-AO; Mon, 22 Apr 2019 07:37:56 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id 86D0F1214CF; Mon, 22 Apr 2019 20:07:55 +0530 (IST)
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
Subject: [PATCH v4 3/3] arm64: zynqmp: DT: Add Xilinx AMS node
Date:   Mon, 22 Apr 2019 20:07:50 +0530
Message-ID: <1555943870-15353-4-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1555943870-15353-1-git-send-email-manish.narani@xilinx.com>
References: <1555943870-15353-1-git-send-email-manish.narani@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(1496009)(2980300002)(189003)(199004)(51416003)(4326008)(36386004)(44832011)(52956003)(356004)(305945005)(426003)(6666004)(476003)(126002)(446003)(14444005)(6266002)(2616005)(11346002)(7416002)(2906002)(486006)(50226002)(76176011)(81156014)(81166006)(8676002)(8936002)(26005)(336012)(110136005)(90966002)(16586007)(5660300002)(103686004)(50466002)(54906003)(48376002)(106002)(42186006)(498600001)(47776003)(36756003)(2201001)(70206006)(186003)(63266004)(72206003)(70586007)(921003)(1121003)(83996005)(2101003)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB4941;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;MX:1;A:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 32915a8f-5199-476c-4f94-08d6c73024c4
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4709054)(2017052603328);SRVR:SN6PR02MB4941;
X-MS-TrafficTypeDiagnostic: SN6PR02MB4941:
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <SN6PR02MB494147DB5C2688B7B79BCDBFC1220@SN6PR02MB4941.namprd02.prod.outlook.com>
X-Forefront-PRVS: 00159D1518
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: PI6ptTXuqFdcWBW9qCqpymNWmBKovaaxv7uPE/MzUITo0fbfzdthv2gVGfUlk9LLJA23ugI8B5/UsV/P8Ye/lLAFx2Xo2kuzCoZKJxRCaZTQ7pM8zCZc23b/FpwAcpIsuhhc/6CNND9XgELmnQt2rNYcy2XxR8wlMarkWDq/cRTkXwdzm3zXG7fLGxDI+N9CNdv7aZlhWdV3uPYESIurewiVdOAfFlrJwqw7QABaSJ8lznD4Ua5OBw+JvKUfmMMN0DlSRjAZW1AP2F/+m5x3IJUo9TPLziSQOSemjPwkAsy8/pNXcFF5buMtPTW+p7194sBlZEEG+FbRoH/ZpPiSFSHFpjLbwxMzBHMZ4XCai3KVaGYaRkulQYDfILMGo2tcYuz58qs7wt4ME5lGTx6jC+oCJAh1/zFICco2CVzHZWY=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2019 14:38:09.5075
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32915a8f-5199-476c-4f94-08d6c73024c4
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4941
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Xilinx AMS includes an ADC as well as on-chip sensors that can be
used to sample external and monitor on-die operating conditions, such as
temperature and supply voltage levels.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index 9aa6734..f776913 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -625,5 +625,31 @@
 			reg = <0x0 0xfd4d0000 0x0 0x1000>;
 			timeout-sec = <10>;
 		};
+
+		xilinx_ams: ams@ffa50000 {
+			compatible = "xlnx,zynqmp-ams";
+			status = "disabled";
+			interrupt-parent = <&gic>;
+			interrupts = <0 56 4>;
+			interrupt-names = "ams-irq";
+			reg = <0x0 0xffa50000 0x0 0x800>;
+			reg-names = "ams-base";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			#io-channel-cells = <1>;
+			ranges = <0 0 0xffa50800 0x800>;
+
+			ams_ps: ams-ps@0,0 {
+				compatible = "xlnx,zynqmp-ams-ps";
+				status = "disabled";
+				reg = <0 0x400>;
+			};
+
+			ams_pl: ams-pl@1,0 {
+				compatible = "xlnx,zynqmp-ams-pl";
+				status = "disabled";
+				reg = <0x400 0x400>;
+			};
+		};
 	};
 };
-- 
2.1.1

