Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAB9BC04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 07:07:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97EFC217D6
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 07:07:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="ArqFqxvf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbfEJHHx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 03:07:53 -0400
Received: from mail-eopbgr680045.outbound.protection.outlook.com ([40.107.68.45]:48864
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727111AbfEJHHp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 03:07:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EeD8pFmCJJjZYjHcLHGEp1CDCmB5e0TiIXSH20sH4VY=;
 b=ArqFqxvfTRhRHFc/XqL8GsOcqyABcePKXqh5Cf+nyoq6fNP9kzlrmveqosCEZeraVfqFn1dKW0rfr8OGt5L/zsRuFUGSaEqgMrn1Fv+kJq0+tLoz03bvVUKu+sTlncgxhNEGHMVwTxmvsh2jL4L9WUea7IdpVdxrp2i6w9fxDV0=
Received: from CY4PR02CA0024.namprd02.prod.outlook.com (2603:10b6:903:18::34)
 by CO1PR02MB159.namprd02.prod.outlook.com (2a01:111:e400:101e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.1856.11; Fri, 10
 May 2019 07:07:41 +0000
Received: from SN1NAM02FT042.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::209) by CY4PR02CA0024.outlook.office365.com
 (2603:10b6:903:18::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1878.21 via Frontend
 Transport; Fri, 10 May 2019 07:07:40 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 SN1NAM02FT042.mail.protection.outlook.com (10.152.73.149) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1856.11
 via Frontend Transport; Fri, 10 May 2019 07:07:40 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:59147 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1hOzd5-0003Nu-Pk; Fri, 10 May 2019 00:07:39 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1hOzd0-0004bk-LW; Fri, 10 May 2019 00:07:34 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x4A77Uuk007918;
        Fri, 10 May 2019 00:07:30 -0700
Received: from [172.23.64.8] (helo=xhdvnc108.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <anuragku@xilinx.com>)
        id 1hOzcw-0004aV-3s; Fri, 10 May 2019 00:07:30 -0700
Received: by xhdvnc108.xilinx.com (Postfix, from userid 15427)
        id 4C98760514; Fri, 10 May 2019 12:37:29 +0530 (IST)
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
Subject: [PATCH v3 3/3] usb: dwc3: gadget: Add support for disabling U1 and U2 entries
Date:   Fri, 10 May 2019 12:37:28 +0530
Message-ID: <1557472048-10536-4-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1557472048-10536-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
References: <1557472048-10536-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(136003)(396003)(346002)(376002)(2980300002)(199004)(189003)(4326008)(36386004)(47776003)(103686004)(486006)(966005)(478600001)(63266004)(7416002)(14444005)(50226002)(36756003)(6306002)(81156014)(8676002)(81166006)(110136005)(6266002)(48376002)(336012)(54906003)(50466002)(51416003)(8936002)(106002)(305945005)(126002)(5660300002)(476003)(446003)(26005)(107886003)(11346002)(2616005)(356004)(42186006)(426003)(316002)(90966002)(16586007)(52956003)(70586007)(70206006)(76176011)(2906002)(186003)(5001870100001)(6606295002);DIR:OUT;SFP:1101;SCL:1;SRVR:CO1PR02MB159;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;A:1;MX:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 964d6c9a-a494-4c53-1260-08d6d51630ed
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4709054)(2017052603328);SRVR:CO1PR02MB159;
X-MS-TrafficTypeDiagnostic: CO1PR02MB159:
X-MS-Exchange-PUrlCount: 1
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <CO1PR02MB159167C5095645EA3F0956CA70C0@CO1PR02MB159.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1751;
X-Forefront-PRVS: 0033AAD26D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: VdLWNIPeudEK+zFxA0WywOc7M8g2Q0+GGO3P5BITMLiLRaPnXqMIxY+mu1toARBKIPs3PTQk4SdKh0KnGxvh2SXQWbofrdOBSR7MFEJ9vqEpythcKDtql19P4/Nqn1sstddV9BFvJVjKT/WwR6ijPuORFjeG9CTBR3SBd9itTxEjiDgWFPAdyMiyIYQMSo1y3TCHNYbup60Ck969EyOdc3LQjoQCqk/7kUoAVnCDi0j7Yj0OsGuQfFxx3gBOefwfmQpA6RqMNZaJYWJ8QPPkw0JSrEH1U6CRkX0RbdwV78tPCT5simvbsUcODV1nMVFJ/o2djbXwCNJT4PBhf0hcKwif46O6BK9pA36EV0FHolqoVachm9+j2mKxfRdOx2RkAeDalqZVLilQEQVMGaIOmJ5EeMyI3oj5Vlzbfmbvf84=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2019 07:07:40.2030
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 964d6c9a-a494-4c53-1260-08d6d51630ed
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR02MB159
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
 Changes in v3:
	1. As suggested by Thinh Nguyen modified the logic for rejecting only
	   SET_FEATURE(enable U1/U2) from host.
	2. Used cpu_to_le16() before assigning the value to bU2DevExitLat.

 Changes in v2:
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
 drivers/usb/dwc3/gadget.c | 20 ++++++++++++++++++++
 drivers/usb/dwc3/gadget.h |  6 ++++++
 5 files changed, 42 insertions(+), 1 deletion(-)

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
index 8efde17..3996b9c 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -379,6 +379,8 @@ static int dwc3_ep0_handle_u1(struct dwc3 *dwc, enum usb_device_state state,
 	if ((dwc->speed != DWC3_DSTS_SUPERSPEED) &&
 			(dwc->speed != DWC3_DSTS_SUPERSPEED_PLUS))
 		return -EINVAL;
+	if (set && dwc->dis_u1_entry_quirk)
+		return -EINVAL;
 
 	reg = dwc3_readl(dwc->regs, DWC3_DCTL);
 	if (set)
@@ -401,6 +403,8 @@ static int dwc3_ep0_handle_u2(struct dwc3 *dwc, enum usb_device_state state,
 	if ((dwc->speed != DWC3_DSTS_SUPERSPEED) &&
 			(dwc->speed != DWC3_DSTS_SUPERSPEED_PLUS))
 		return -EINVAL;
+	if (set && dwc->dis_u2_entry_quirk)
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
index e293400..30b2e63 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2073,6 +2073,25 @@ static int dwc3_gadget_stop(struct usb_gadget *g)
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
+		params->bU2DevExitLat =
+				cpu_to_le16(DWC3_DEFAULT_U2_DEV_EXIT_LAT);
+}
+
 static void dwc3_gadget_set_speed(struct usb_gadget *g,
 				  enum usb_device_speed speed)
 {
@@ -2142,6 +2161,7 @@ static const struct usb_gadget_ops dwc3_gadget_ops = {
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

