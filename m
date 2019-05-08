Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EB45C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 07:55:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B70720644
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 07:55:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="OYY9k6qP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbfEHHzO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 03:55:14 -0400
Received: from mail-eopbgr790054.outbound.protection.outlook.com ([40.107.79.54]:43904
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726163AbfEHHzN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 03:55:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D/WFehwEYs6b90jeMmUSFsVHIm7NpMcDB3cnb9MxZNQ=;
 b=OYY9k6qP/MyV1Fg/nQ6zTm9XzrRZCT02gXwDAoRnyNH2qobfTvH1APFsJ8qRjN3nE5Hk8r82hO40lKVu/roonhxXqw7Zd9v79upuHqBTKD3mAqJqZ+Y8F61UrYw3oQ2Fr54u98jqOpTBl7+q1X7FfIInuT+laciCEFirYZh5YHU=
Received: from SN4PR0201CA0010.namprd02.prod.outlook.com
 (2603:10b6:803:2b::20) by DM5PR02MB3832.namprd02.prod.outlook.com
 (2603:10b6:4:b1::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1856.11; Wed, 8 May
 2019 07:55:10 +0000
Received: from CY1NAM02FT018.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::204) by SN4PR0201CA0010.outlook.office365.com
 (2603:10b6:803:2b::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1878.20 via Frontend
 Transport; Wed, 8 May 2019 07:55:09 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT018.mail.protection.outlook.com (10.152.75.183) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1856.11
 via Frontend Transport; Wed, 8 May 2019 07:55:09 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1hOHPw-0004Y7-Jd; Wed, 08 May 2019 00:55:08 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1hOHPr-0005yM-F6; Wed, 08 May 2019 00:55:03 -0700
Received: from xsj-pvapsmtp01 (maildrop.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x487ss6u027165;
        Wed, 8 May 2019 00:54:54 -0700
Received: from [172.23.64.8] (helo=xhdvnc108.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <anuragku@xilinx.com>)
        id 1hOHPh-0005sH-R9; Wed, 08 May 2019 00:54:54 -0700
Received: by xhdvnc108.xilinx.com (Postfix, from userid 15427)
        id 031AE604D8; Wed,  8 May 2019 13:24:53 +0530 (IST)
From:   Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Felipe Balbi <balbi@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "Claus H. Stovgaard" <cst@phaseone.com>
CC:     <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <v.anuragkumar@gmail.com>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Subject: [PATCH v2 3/3] usb: dwc3: gadget: Add support for disabling U1 and U2 entries
Date:   Wed, 8 May 2019 13:24:51 +0530
Message-ID: <1557302091-7455-4-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1557302091-7455-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
References: <1557302091-7455-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(39860400002)(376002)(136003)(396003)(2980300002)(199004)(189003)(186003)(76176011)(7416002)(52956003)(2906002)(36756003)(63266004)(16586007)(110136005)(54906003)(14444005)(305945005)(26005)(356004)(42186006)(36386004)(316002)(5660300002)(6306002)(6266002)(51416003)(426003)(81166006)(81156014)(8676002)(106002)(336012)(103686004)(107886003)(70206006)(47776003)(50466002)(446003)(2616005)(48376002)(8936002)(70586007)(478600001)(90966002)(476003)(966005)(4326008)(486006)(11346002)(50226002)(126002)(6606295002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR02MB3832;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6f162e7d-a7ad-4779-0d7e-08d6d38a7e53
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4709054)(2017052603328);SRVR:DM5PR02MB3832;
X-MS-TrafficTypeDiagnostic: DM5PR02MB3832:
X-MS-Exchange-PUrlCount: 1
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM5PR02MB383245982195E8CAB72DDC6FA7320@DM5PR02MB3832.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1751;
X-Forefront-PRVS: 0031A0FFAF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: STCG6/S4kPT2ba1gmDmTmH41OlTjm3WqMrUOopJ3XQSIRNkMypmIF/oZx9S8L3fXO+pjnMYXe0QAZqq4Uo6V4saGeT5LOZDA6Me0X1x00XDZodlS65JYIJJkDh2ao+ArHEfnv1UTQZRe9XA3zDdDvSNi2QNZ0Zd2woFmngAaM2yiStpRZi9Ejt3ecXtRX/HBL1m5npmSDapmNQaqG4zfBJsRTA5+cYQvl+deOpA3O/xPyqxTmHBBxgL40719ilGPDzLj/VtR0ytggpQ9hmBLMAxNnJju7UP/3Xlw9dHqfjIDSTNNWvXBKXY/bQijL0Por7W65yo47H9V6qHfP/m0jJuKI26Ryl+F7QZ9VHDK5t0Xkjk/hmgyVsmiIv7y44NFi+/FECe/7kWsM0e8tOv8hgKNRr8gp/s0w43Od6m7FCs=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2019 07:55:09.1257
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f162e7d-a7ad-4779-0d7e-08d6d38a7e53
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB3832
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gadget applications may have a requirement to disable the U1 and U2
entry based on the usecase. Below are few usecases where the disabling
U1/U2 entries may be possible.

Usecase 1:
When combining dwc3 with an redriver for a USB Type-C device solution, it
sometimes have problems with leaving U1/U2 for certain hosts, resulting in
link training errors and reconnects. For this U1/U2 state entries may be
avoided.

Usecase 2:
When performing performance benchmarking on mass storage gadget the
U1 and U2 entries can be disabled.

Usecase 3:
When periodic transfers like ISOC transfers are used with bInterval
of 1 which doesn't require the link to enter into U1 or U2 state entry
(since ping is issued from host for every uframe interval). In this
case the U1 and U2 entry can be disabled.

Disablement of U1/U2 can be done by setting U1DevExitLat and U2DevExitLat
values to 0 in the BOS descriptor. Host on seeing 0 value for U1DevExitLat
and U2DevExitLat, it doesn't send SET_SEL requests to the gadget. There
may be some hosts which may send SET_SEL requests even after seeing 0 in
the UxDevExitLat of BOS descriptor. To aviod U1/U2 entries for these type
of hosts, dwc3 controller can be programmed to reject those U1/U2 requests
by not enabling ACCEPTUxENA bits in DCTL register.

This patch updates the same.

Signed-off-by: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Signed-off-by: Claus H. Stovgaard <cst@phaseone.com>
---
 Changes in v2
	1. As suggested by Thinh Nguyen changed the "snps,dis_u1_entry_quirk"
	   to "snps,dis-u1-entry-quirk"
	2. Merged the changes done by Claus H. Stovgaard in ep0.c for rejecting
	   U1/U2 requests into this patch. Changes done by Claus can be found
	   here https://marc.info/?l=linux-kernel&m=155722068820568&w=2
	3. Changed the commit message.
---
 drivers/usb/dwc3/core.c   |  4 ++++
 drivers/usb/dwc3/core.h   |  4 ++++
 drivers/usb/dwc3/ep0.c    |  9 ++++++++-
 drivers/usb/dwc3/gadget.c | 19 +++++++++++++++++++
 drivers/usb/dwc3/gadget.h |  6 ++++++
 5 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index a1b126f..180239b 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1285,6 +1285,10 @@ static void dwc3_get_properties(struct dwc3 *dwc)
 				"snps,dis_u2_susphy_quirk");
 	dwc->dis_enblslpm_quirk = device_property_read_bool(dev,
 				"snps,dis_enblslpm_quirk");
+	dwc->dis_u1_entry_quirk = device_property_read_bool(dev,
+				"snps,dis-u1-entry-quirk");
+	dwc->dis_u2_entry_quirk = device_property_read_bool(dev,
+				"snps,dis-u2-entry-quirk");
 	dwc->dis_rxdet_inp3_quirk = device_property_read_bool(dev,
 				"snps,dis_rxdet_inp3_quirk");
 	dwc->dis_u2_freeclk_exists_quirk = device_property_read_bool(dev,
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 1528d39..fa398e2 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -1015,6 +1015,8 @@ struct dwc3_scratchpad_array {
  * @dis_u2_susphy_quirk: set if we disable usb2 suspend phy
  * @dis_enblslpm_quirk: set if we clear enblslpm in GUSB2PHYCFG,
  *                      disabling the suspend signal to the PHY.
+ * @dis_u1_entry_quirk: set if link entering into U1 state needs to be disabled.
+ * @dis_u2_entry_quirk: set if link entering into U2 state needs to be disabled.
  * @dis_rxdet_inp3_quirk: set if we disable Rx.Detect in P3
  * @dis_u2_freeclk_exists_quirk : set if we clear u2_freeclk_exists
  *			in GUSB2PHYCFG, specify that USB2 PHY doesn't
@@ -1206,6 +1208,8 @@ struct dwc3 {
 	unsigned		dis_u3_susphy_quirk:1;
 	unsigned		dis_u2_susphy_quirk:1;
 	unsigned		dis_enblslpm_quirk:1;
+	unsigned		dis_u1_entry_quirk:1;
+	unsigned		dis_u2_entry_quirk:1;
 	unsigned		dis_rxdet_inp3_quirk:1;
 	unsigned		dis_u2_freeclk_exists_quirk:1;
 	unsigned		dis_del_phy_power_chg_quirk:1;
diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
index 8efde17..8e94efc 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -379,6 +379,8 @@ static int dwc3_ep0_handle_u1(struct dwc3 *dwc, enum usb_device_state state,
 	if ((dwc->speed != DWC3_DSTS_SUPERSPEED) &&
 			(dwc->speed != DWC3_DSTS_SUPERSPEED_PLUS))
 		return -EINVAL;
+	if (dwc->dis_u1_entry_quirk)
+		return -EINVAL;
 
 	reg = dwc3_readl(dwc->regs, DWC3_DCTL);
 	if (set)
@@ -401,6 +403,8 @@ static int dwc3_ep0_handle_u2(struct dwc3 *dwc, enum usb_device_state state,
 	if ((dwc->speed != DWC3_DSTS_SUPERSPEED) &&
 			(dwc->speed != DWC3_DSTS_SUPERSPEED_PLUS))
 		return -EINVAL;
+	if (dwc->dis_u2_entry_quirk)
+		return -EINVAL;
 
 	reg = dwc3_readl(dwc->regs, DWC3_DCTL);
 	if (set)
@@ -626,7 +630,10 @@ static int dwc3_ep0_set_config(struct dwc3 *dwc, struct usb_ctrlrequest *ctrl)
 			 * nothing is pending from application.
 			 */
 			reg = dwc3_readl(dwc->regs, DWC3_DCTL);
-			reg |= (DWC3_DCTL_ACCEPTU1ENA | DWC3_DCTL_ACCEPTU2ENA);
+			if (!dwc->dis_u1_entry_quirk)
+				reg |= DWC3_DCTL_ACCEPTU1ENA;
+			if (!dwc->dis_u2_entry_quirk)
+				reg |= DWC3_DCTL_ACCEPTU2ENA;
 			dwc3_writel(dwc->regs, DWC3_DCTL, reg);
 		}
 		break;
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index e293400..f2d3112 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2073,6 +2073,24 @@ static int dwc3_gadget_stop(struct usb_gadget *g)
 	return 0;
 }
 
+static void dwc3_gadget_config_params(struct usb_gadget *g,
+				      struct usb_dcd_config_params *params)
+{
+	struct dwc3		*dwc = gadget_to_dwc(g);
+
+	/* U1 Device exit Latency */
+	if (dwc->dis_u1_entry_quirk)
+		params->bU1devExitLat = 0;
+	else
+		params->bU1devExitLat = DWC3_DEFAULT_U1_DEV_EXIT_LAT;
+
+	/* U2 Device exit Latency */
+	if (dwc->dis_u2_entry_quirk)
+		params->bU2DevExitLat = 0;
+	else
+		params->bU2DevExitLat = DWC3_DEFAULT_U2_DEV_EXIT_LAT;
+}
+
 static void dwc3_gadget_set_speed(struct usb_gadget *g,
 				  enum usb_device_speed speed)
 {
@@ -2142,6 +2160,7 @@ static const struct usb_gadget_ops dwc3_gadget_ops = {
 	.udc_start		= dwc3_gadget_start,
 	.udc_stop		= dwc3_gadget_stop,
 	.udc_set_speed		= dwc3_gadget_set_speed,
+	.get_config_params	= dwc3_gadget_config_params,
 };
 
 /* -------------------------------------------------------------------------- */
diff --git a/drivers/usb/dwc3/gadget.h b/drivers/usb/dwc3/gadget.h
index 3ed738e..5faf4d1 100644
--- a/drivers/usb/dwc3/gadget.h
+++ b/drivers/usb/dwc3/gadget.h
@@ -48,6 +48,12 @@ struct dwc3;
 /* DEPXFERCFG parameter 0 */
 #define DWC3_DEPXFERCFG_NUM_XFER_RES(n)	((n) & 0xffff)
 
+/* U1 Device exit Latency */
+#define DWC3_DEFAULT_U1_DEV_EXIT_LAT	0x0A	/* Less then 10 microsec */
+
+/* U2 Device exit Latency */
+#define DWC3_DEFAULT_U2_DEV_EXIT_LAT	0x1FF	/* Less then 511 microsec */
+
 /* -------------------------------------------------------------------------- */
 
 #define to_dwc3_request(r)	(container_of(r, struct dwc3_request, request))
-- 
2.1.1

