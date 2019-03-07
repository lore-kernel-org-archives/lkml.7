Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D010C10F03
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 15:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDA2520643
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 15:29:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="GpyElGXe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbfCGP3e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 10:29:34 -0500
Received: from mail-eopbgr760043.outbound.protection.outlook.com ([40.107.76.43]:12256
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726207AbfCGP3e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 10:29:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D39DnnMBHoC6J6je8tfkFf7qjQ2chsBCBjg8HlhBB2M=;
 b=GpyElGXe33YRT+trZCCHNqrkaUuwsnvuixpfkFH9qJQ9AG140NqJW04BSmbldYyADaiGzgQ9MLL1qO91TqC9OTj8+IiCA4TjCheBNOlTLSTXHB5fzT1nUVcdYLPO1fNFurK1rJSJhZDtWC3CPE50A9UY7B5VyC6LEP3GLtIHMp8=
Received: from DM6PR03CA0055.namprd03.prod.outlook.com (2603:10b6:5:100::32)
 by CO2PR03MB2263.namprd03.prod.outlook.com (2603:10b6:102:a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1665.19; Thu, 7 Mar
 2019 15:29:28 +0000
Received: from CY1NAM02FT025.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::203) by DM6PR03CA0055.outlook.office365.com
 (2603:10b6:5:100::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1665.18 via Frontend
 Transport; Thu, 7 Mar 2019 15:29:28 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; gmx.de; dkim=none (message not signed)
 header.d=none;gmx.de; dmarc=bestguesspass action=none header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 CY1NAM02FT025.mail.protection.outlook.com (10.152.75.148) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1643.11
 via Frontend Transport; Thu, 7 Mar 2019 15:29:27 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x27FTQf9019485
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 7 Mar 2019 07:29:26 -0800
Received: from linux.analog.com (10.32.224.122) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.408.0; Thu, 7 Mar 2019
 10:29:25 -0500
From:   Stefan Popa <stefan.popa@analog.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>
CC:     <mark.rutland@arm.com>, <knaack.h@gmx.de>, <lars@metafoo.de>,
        <pmeerw@pmeerw.net>, <Michael.Hennerich@analog.com>,
        <gregkh@linuxfoundation.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stefan.popa@analog.com>
Subject: [PATCH 2/2] dt-bindings: iio: imu: adis16480: Document external clock
Date:   Thu, 7 Mar 2019 17:29:19 +0200
Message-ID: <1551972559-15148-1-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(136003)(376002)(346002)(396003)(2980300002)(189003)(199004)(50466002)(2616005)(36756003)(426003)(126002)(316002)(48376002)(8936002)(54906003)(107886003)(186003)(51416003)(77096007)(26005)(305945005)(7636002)(14444005)(8676002)(476003)(47776003)(110136005)(486006)(53416004)(50226002)(16586007)(72206003)(106466001)(7696005)(106002)(7416002)(356004)(478600001)(6666004)(44832011)(2906002)(4326008)(5660300002)(336012)(246002);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR03MB2263;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 68665768-0aa9-4180-1155-08d6a311afea
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4608103)(4709054)(2017052603328)(7153060);SRVR:CO2PR03MB2263;
X-MS-TrafficTypeDiagnostic: CO2PR03MB2263:
X-Microsoft-Exchange-Diagnostics: 1;CO2PR03MB2263;20:l+u/Z90s8yjRMJFjBELVYSCH1Wbk7mP5Fcnvo9PQIeByJaMoS7/BGJVlFcimyNN96GduKuopD2V9YMgUy80ZVtNIfQL9DRCIET4RD6rqLXIUkghQZwTU3ZhOUk6YBiCYg83lidDZqSibFYiOyNYvVvHENMP3rvnn7ZpdDbIkca3z/e73BlPlti04plR+j9KIjJ7jOxIXspssozRgWDMa9RZBSWUTEPKPk3BtBXb3YZ9dYaeI2SApm810l500zWLoo4ni3UySSqmVG9+oJuNNIdjTmZ9Ix+B+VQd6Ex7KRLemkaDJ4BHmRqTz0y+uDVdGsiFbukVOL7uBh0SDyQMBqi3aJFsVgJQm+kTMjtxTfbk03hkZcC7Aq6XfMewkiaBGkAnaGTj/SN9nc4A7sd67sLRjUyNa8bEJ8wS7M9hDcxEEuO1e1GZMBDzFeFrDYkEH/l59LWprwHAsaxTcnwbP2vwLY2i3dVq+rqvwaia8EE7k13+V0cdVljt1lgcoaR9Q
X-Microsoft-Antispam-PRVS: <CO2PR03MB2263BA9CF89CCAB7C482ABD49D4C0@CO2PR03MB2263.namprd03.prod.outlook.com>
X-Forefront-PRVS: 096943F07A
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CO2PR03MB2263;23:4ak0X+a9EXmdFf/bP0TJknW5YDEKmt2ykgDaOxauM?=
 =?us-ascii?Q?vSzJH2sRlI5+ZpZnygdKaTKp1EWcVQpDiXriYV7y/lfxJV2hymA7BiiaqDRC?=
 =?us-ascii?Q?rTiJbJgjrTJtBIbO94t10esimTrmzROjzXiiqlzZ1kLwEza1CLsqQOR6U/6s?=
 =?us-ascii?Q?OHtPwrz7F8DWBWsVTO8pMrx0Sw/OlUaOrWIOc/Z65ovEExI12gwRNz8AYb6E?=
 =?us-ascii?Q?nVFMp5pnHWOCc8UlnR6HxBcce3aZiybBUQg0+wmb0zT136grMCJVVrq7FxIU?=
 =?us-ascii?Q?pc28PvOfBbPQp9GyLFOu3zQtapZuvM5laYKVu/dRDkXtnYlubT/kVIvVkOIv?=
 =?us-ascii?Q?vNsHIF8BesodloriC/x7Fd35TvC8og4qjnA2lvobtAZ6DQQACetLHqMT/U9V?=
 =?us-ascii?Q?rNh2Y71HG74UHYDanWhdv3A17ZQ2ID3eqxgkUhbnJHQEeYlnAWZRpxEE+xuG?=
 =?us-ascii?Q?gCmdNLZauZClf/l6ZpzEHLn2A9Dy0+5JUcign3npUfTvEB/nyzsct/BVR+o6?=
 =?us-ascii?Q?miecM7YhBZtd4PM1+1s2yu06tQwqP3vKvFetF6kYNbg7qqt45IIuMq/On7uC?=
 =?us-ascii?Q?NsiKJcwaAvVn/kClB+7BJy1Jved3drQPCW5ksbs5Dudf+IlU6naiyZIZex0I?=
 =?us-ascii?Q?10oSL+GNeBWWvj72uNJsHe0FDa6N3rFBKss6i7uwqcMuBsYLu0wNiHOBtS49?=
 =?us-ascii?Q?VXOVdVY8zTBApRRO+riHAkveUOZLIM0JXfyBDNXpsLSaeJHAV+//ZXQ4uWck?=
 =?us-ascii?Q?2TxephigqovRrRl61dWP+ZWF7CUI1dNXP50sZ+G8Sro/nsimggZPZwuJBmsV?=
 =?us-ascii?Q?FGZ255AkNYhboeQax8z5QFP+698v7FROK37CtkKnHrTLC9ZbUQK5J2o+wwin?=
 =?us-ascii?Q?HMxl1rlLB3fq31D5TbiwwDkQyPGUdA9JnGfKZsKZSal5lEshGTyKF38frYNO?=
 =?us-ascii?Q?XzTstUxD+u5ZIadZW/y0hdMHrPFATOe5pSHq9KsrvOx5CoCNck/43zOQ54Xe?=
 =?us-ascii?Q?yOJZhYJ/MYXJZ71kWDuKOKrg/Q2czYNaQKjcL4wS2wH9A=3D=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: WPqnljI1GPrLEAuQg7tWuB0yZhQOH87ZtTHPD5DMrqkueFNqoy/yfVCnFLBmLN/yzgQGXVjHXQfNUfjCdwEzMZQ3nr6gN1UjSJn1/i8fBkxnrkjYeA8vkYTg8MLjQHBTi45Qu7Wdxm//xXrDiMNgFdOgVh3bdMjH3Y2BnPTmlKT8zSSxcXBHMxdRSkRR2PbBQ3RFCLuQ65979DWiLK1X+z2nCHnff0p8RWK4gSAnNokEHqnM0NmkbP3VmXRhbyFaoTnEH0gVOtS54S74FYMKjA+RpD78rl9OFsbB8ysZ9XQXf3YcFmU8Iv2uh6TZ4bd1Bo2k1QEQE6SQbl4slFlWaQSdkAHb7tFudN/pD9WwelXkxdLy8nZybMrnpMm7I6vEUB4MQQIXu3AjgVwk7y79rCI5kKwewahkP5ICWqnoHB8=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2019 15:29:27.0459
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68665768-0aa9-4180-1155-08d6a311afea
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR03MB2263
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for optional use of external clock. All devices
supported by this driver can work with an external clock in sync mode.
Another mode, called Pulse Per Second (PPS) is supported only by adis1649x
devices. The mode is selected by using the "clock-names" property.

The pin which is used as external clock input is selected by using a
custom optional property called "adi,ext-clk-pin". If this field is left
empty, DIO2 is assigned as default external clock input pin.

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
 .../devicetree/bindings/iio/imu/adi,adis16480.txt  | 34 ++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/imu/adi,adis16480.txt b/Documentation/devicetree/bindings/iio/imu/adi,adis16480.txt
index 39ab016..9e2fcd4 100644
--- a/Documentation/devicetree/bindings/iio/imu/adi,adis16480.txt
+++ b/Documentation/devicetree/bindings/iio/imu/adi,adis16480.txt
@@ -34,6 +34,37 @@ Optional properties:
 	signal.
 - reset-gpios: must be the device tree identifier of the RESET pin. As the line
 	is active low, it should be marked GPIO_ACTIVE_LOW.
+- clocks: phandle to the external clock. Should be set according to
+	"clock-names".
+	If this field is left empty, the internal clock is used.
+- clock-names: The name of the external clock to be used. Valid values are:
+	* sync: In sync mode, the internal clock is disabled and the frequency
+		of the external clock signal establishes therate of data
+		collection and processing. See Fig 14 and 15 in the datasheet.
+		The clock-frequency must be:
+		* 3000 to 4500 Hz for adis1649x devices.
+		* 700 to 2400 Hz for adis1648x devices.
+	* pps: In Pulse Per Second (PPS) Mode, the rate of data collection and
+	       production is equal to the product of the external clock
+	       frequency and the scale factor in the SYNC_SCALE register, see
+	       Table 154 in the datasheet.
+	       The clock-frequency must be:
+	       * 1 to 128 Hz for adis1649x devices.
+	       * This mode is not supported by adis1648x devices.
+	If this field is left empty, the internal clock is used.
+- adi,ext-clk-pin: The DIOx line to be used as an external clock input.
+	Valid values are:
+	* DIO1
+	* DIO2
+	* DIO3
+	* DIO4
+	Each DIOx pin supports only one function at a time (data ready line
+	selection or external clock input). When a single pin has two
+	two assignments, the enable bit for the lower priority function
+	automatically resets to zero (disabling the lower priority function).
+	Data ready has highest priority.
+	If this field is left empty, DIO2 is assigned as default external clock
+	input pin.
 
 Example:
 
@@ -46,4 +77,7 @@ Example:
 		interrupts = <25 IRQF_TRIGGER_FALLING>;
 		interrupt-parent = <&gpio>;
 		interrupt-names = "DIO2";
+		clocks = <&adis16495_sync>;
+		clock-names = "sync";
+		adi,ext-clk-pin = "DIO1";
 	};
-- 
2.7.4

