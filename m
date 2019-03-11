Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA90EC10F0C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 09:47:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A16BE2084D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 09:47:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="s2rzJwET"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727258AbfCKJq7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 05:46:59 -0400
Received: from mail-eopbgr700048.outbound.protection.outlook.com ([40.107.70.48]:33312
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726897AbfCKJq7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 05:46:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U6D9bs1zxBGna5rlmlDEAM3+I5EjJKtDJAeUugRcaQU=;
 b=s2rzJwET2xmPLvbHnJ0YzMK2LJIbSKS7G4kgeEIyOD96Yl3tE0mHZ9/mxj5fLrMWwEzPUXF5w++Q5zYDe90CjhGOdP0AZQ4Qd5MHSnofEsYZ1vvJqcrfnF5XBWOVnu0QD6Lo7XynKlBRhACYiyfe4Ly9jdWCNCI8E9mEqe3352M=
Received: from BN3PR03CA0081.namprd03.prod.outlook.com
 (2a01:111:e400:7a4d::41) by MWHPR03MB3135.namprd03.prod.outlook.com
 (2603:10b6:301:3c::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1686.18; Mon, 11 Mar
 2019 09:46:52 +0000
Received: from SN1NAM02FT013.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::202) by BN3PR03CA0081.outlook.office365.com
 (2a01:111:e400:7a4d::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1686.18 via Frontend
 Transport; Mon, 11 Mar 2019 09:46:51 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; gmx.de; dkim=none (message not signed)
 header.d=none;gmx.de; dmarc=bestguesspass action=none header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 SN1NAM02FT013.mail.protection.outlook.com (10.152.72.98) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1686.19
 via Frontend Transport; Mon, 11 Mar 2019 09:46:50 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x2B9koEP021977
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 11 Mar 2019 02:46:50 -0700
Received: from linux.analog.com (10.50.1.179) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.408.0; Mon, 11 Mar 2019
 05:46:49 -0400
From:   Stefan Popa <stefan.popa@analog.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>
CC:     <mark.rutland@arm.com>, <knaack.h@gmx.de>, <lars@metafoo.de>,
        <pmeerw@pmeerw.net>, <Michael.Hennerich@analog.com>,
        <gregkh@linuxfoundation.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stefan.popa@analog.com>
Subject: [PATCH v2 2/2] dt-bindings: iio: imu: adis16480: Document external clock
Date:   Mon, 11 Mar 2019 11:46:37 +0200
Message-ID: <1552297597-26640-1-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(376002)(346002)(39860400002)(396003)(2980300002)(189003)(199004)(2616005)(126002)(50226002)(426003)(47776003)(478600001)(14444005)(476003)(5660300002)(26005)(77096007)(72206003)(51416003)(106002)(7696005)(2906002)(4326008)(8676002)(53416004)(44832011)(48376002)(305945005)(106466001)(7636002)(107886003)(186003)(246002)(54906003)(110136005)(36756003)(16586007)(486006)(8936002)(336012)(50466002)(7416002)(356004)(316002)(6666004);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR03MB3135;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2fe9eafb-ba56-4e15-89d3-08d6a6067cdb
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4608103)(4709054)(2017052603328)(7153060);SRVR:MWHPR03MB3135;
X-MS-TrafficTypeDiagnostic: MWHPR03MB3135:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB3135;20:JqwV+MQFLmatC0iCftyfEvShuDCDlsg6AmnPMaT4OSKgJE7hEIrdAeAyd2lQ9xhnJlMytiFN9vr8EVZIdjIq3z5zlkEeKyObsAj4gZHd2VvuulGV/VzFwdQqj5iVTU/vs0JIC0JYbT7LkJ+NmOHlBbNU8/rWUpyjpRhpRfVrgI9jWj8sSef7jNFCV36Z+/W7ZNUZePUJ53Ws6ud2Sa/rGehmSHEczPyjntq+ayXY9C/mAXKPmBQ/z1rNdjLuBKQRTNBol6+TX/dIMCRWANxKA4kkYt5W/GggS5n+RpXdLTBTo4aop0du9nADb8WMRzdKsH8gcNK3Ju6DzUgPWMSI9FEWfeMF7KntPGLla23qiYxTet0iP4ePRi/shLcWJNFDDHFdfq6ybktkZzaqp9K97I3ml4Mj5sPqHo1BIx/DACN2ojZdmY9zmpYf697gAbcsnZesnOKTqZAAXw5YGHz8Kj6Inq8BqKWXwhjTWsh/0HwtqmaYoXVpXw9a4pXvdSaR
X-Microsoft-Antispam-PRVS: <MWHPR03MB31359FBE0D9739C673CDE7319D480@MWHPR03MB3135.namprd03.prod.outlook.com>
X-Forefront-PRVS: 09730BD177
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR03MB3135;23:5XeDtNIBTiglrKLQFpumXD8wtt4CYz+A90mnWpLg3?=
 =?us-ascii?Q?Bhc9yjXeaHLzTt/LTAc15KsyIl9VPglA4kVYfwCsUTbekx1/ZvN6KJcIZIxD?=
 =?us-ascii?Q?JRzmmge1Cmjh4szwElUBaiLN8DpH+ebUMuv8vtBaUgF+bWnA/s7rrX80f0VZ?=
 =?us-ascii?Q?pggGqNI1o4ji6QtcRmzSJyoT3woUVZmX/T5zYsgZEygr0Egjc+w/XNTatzJJ?=
 =?us-ascii?Q?4C0paWEEm1vVfB5iIJtsZwTHDVWssOhIRQ4JjsK/QO6Om/Lhi4LXWIqrFKJe?=
 =?us-ascii?Q?SZ1ErNW3kGAKzhA82wFVgldmiwdA7+MW3E35wmHD7Rte0LaEKalBV8w8qBk6?=
 =?us-ascii?Q?up+rA/wat6ZCqcAt2KNBzzI+6gEr5eYQg3mmxRwvwfj+MQy0yyncAtV7+bDv?=
 =?us-ascii?Q?Glk0cjuR2aVcryTxX08c7BTE9hFtA/0ivtfjulStCBrUYg4d1SayaZPt0FdN?=
 =?us-ascii?Q?RvCv/4yycxLk0i7P4d9PeY/lwCz+G/DR8yladKVJU1437zhAyPlC/311vR0W?=
 =?us-ascii?Q?RksJyj/zwSTtfx2IFl2SbW7zytaTogBv0KOB9Xxohqn1Sv40hAULe3dnMygy?=
 =?us-ascii?Q?oaqbmlRdf8+sgWtyHR0/EBjdrYwtX/GGIvkrlmv7KiMoiRRzkrbxHgiTa5GG?=
 =?us-ascii?Q?QqkRoIVb06cPZ9VI6ufcHlHnr6Q4oFtuDrhTaxLV4fsIw+t6aBb6r6qeYjDy?=
 =?us-ascii?Q?rTvDhTu+aHpu1ScIgMOdamqZqj+H+AknVE+wfQsk4J0G4QI0uAnRu4XRegKR?=
 =?us-ascii?Q?+TrPpjwbZCrlx/4NIAi0wccJ53DJrFyWDlVZCgZ05ylszs7dfWvnewNQrzjW?=
 =?us-ascii?Q?saW5MGJR6TDfh9mUpij+nIqLG233X/CL7Z6C3gR5kcIIKOlsG0CktS0eDjIF?=
 =?us-ascii?Q?yp81sm3VI0/AIWa36W8dInoyXwJB1Hu0LzRVvp7D9765YKgoP8KCJcZF4DH/?=
 =?us-ascii?Q?5o73XR9MN48qmVBwdaqPKj5OIPyvzYxhQdc2gu3Ca7RLpbJAswRKJnykOAz+?=
 =?us-ascii?Q?AvJf8zI67AUBAMFzgETH7YgrgW7XgCbvnYkZsGD9rzXAQ=3D=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: ZgNoSApyjCu2SSaPZ/X+nngOSenFbfgiui6g50CHgWEzacwYphPyk/j2oxOiiy4JSMnoe8wxvOWLpqrYWbiNfMX6gaKMi8U4xn8EYKK2qKfxAwdLO9dZYwgzsbaSGm0Y2BZf6n7fyMa7TKxZnp+TY8mUM/DJWLaYfmA0OnwNA2HJoZ7NhTe+41aFSxe42Tz0Gx6JpNOplXBU8MKvDDEnpc1CEkJSmGnDJ1NZqT7jc0hK5lwAGw4J3SC86OIXodVzvu2B+4MDoUxyIsA4J+j0si9d3zkK0foLim1QBm5ULD+1LUsqLyoaSIcO1tc3wUo2bsHKG5RisNN+yGYb77ylE2y6kCwLfXZBvoljZh9HliNPU1CmMdkwAA/RVQJQHypfp9DyeDAdoQ9XE2ltHVh9GMfcwTTuYAPML0A8wakQ3LY=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2019 09:46:50.9467
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fe9eafb-ba56-4e15-89d3-08d6a6067cdb
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR03MB3135
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
Changes in v2:
	- Mentioned that both "clocks" and "clock-names" fields should be left
	  empty for internal clock to be used.

 .../devicetree/bindings/iio/imu/adi,adis16480.txt  | 36 ++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/imu/adi,adis16480.txt b/Documentation/devicetree/bindings/iio/imu/adi,adis16480.txt
index 39ab016..ed7783f 100644
--- a/Documentation/devicetree/bindings/iio/imu/adi,adis16480.txt
+++ b/Documentation/devicetree/bindings/iio/imu/adi,adis16480.txt
@@ -34,6 +34,39 @@ Optional properties:
 	signal.
 - reset-gpios: must be the device tree identifier of the RESET pin. As the line
 	is active low, it should be marked GPIO_ACTIVE_LOW.
+- clocks: phandle to the external clock. Should be set according to
+	"clock-names".
+	If this field is left empty together with the "clock-names" field, then
+	the internal clock is used.
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
+	If this field is left empty together with the "clocks" field, then the
+	internal clock is used.
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
 
@@ -46,4 +79,7 @@ Example:
 		interrupts = <25 IRQF_TRIGGER_FALLING>;
 		interrupt-parent = <&gpio>;
 		interrupt-names = "DIO2";
+		clocks = <&adis16495_sync>;
+		clock-names = "sync";
+		adi,ext-clk-pin = "DIO1";
 	};
-- 
2.7.4

