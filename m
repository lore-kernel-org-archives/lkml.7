Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B095C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 10:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D86F20873
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 10:20:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="jMW4EVCX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbfEBKUn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 06:20:43 -0400
Received: from mail-eopbgr820081.outbound.protection.outlook.com ([40.107.82.81]:11320
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726231AbfEBKUm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 06:20:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nErA9Gi6a7HA1SvAFAogtav2olwJyC7a2e/Rk7IhEIs=;
 b=jMW4EVCXWFxihYtLlJzkv6s+qWWV7OV69nsd3DiaxuQ3x1Ditk27Kf5fxTj4cUNnBHkfcMk8YnVzW7VXsSiRUuWoceew9mpSiDHvIvr5Gn3kLICubVULW9nqqN3o+z+BMLw+pVmVd1w5c2Y1NK350WF8irfm7vQTRAQXymGZ3Ls=
Received: from BL0PR02CA0021.namprd02.prod.outlook.com (2603:10b6:207:3c::34)
 by SN4PR0201MB3406.namprd02.prod.outlook.com (2603:10b6:803:48::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1835.15; Thu, 2 May
 2019 10:20:39 +0000
Received: from CY1NAM02FT054.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::202) by BL0PR02CA0021.outlook.office365.com
 (2603:10b6:207:3c::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1856.10 via Frontend
 Transport; Thu, 2 May 2019 10:20:39 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT054.mail.protection.outlook.com (10.152.74.100) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1856.11
 via Frontend Transport; Thu, 2 May 2019 10:20:38 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1hM8pS-0004RX-4Y; Thu, 02 May 2019 03:20:38 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1hM8pN-0001np-0j; Thu, 02 May 2019 03:20:33 -0700
Received: from xsj-pvapsmtp01 (xsj-mail.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x42AKQf6023314;
        Thu, 2 May 2019 03:20:26 -0700
Received: from [172.23.64.8] (helo=xhdvnc108.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <anuragku@xilinx.com>)
        id 1hM8pF-0001mk-W2; Thu, 02 May 2019 03:20:26 -0700
Received: by xhdvnc108.xilinx.com (Postfix, from userid 15427)
        id 2AEA6604FE; Thu,  2 May 2019 15:50:25 +0530 (IST)
From:   Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Felipe Balbi <balbi@kernel.org>
CC:     <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <v.anuragkumar@gmail.com>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Subject: [PATCH 2/3] usb: gadget: send usb_gadget as an argument in get_config_params
Date:   Thu, 2 May 2019 15:50:22 +0530
Message-ID: <1556792423-4833-3-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1556792423-4833-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
References: <1556792423-4833-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(376002)(396003)(136003)(346002)(2980300002)(189003)(199004)(478600001)(50466002)(70586007)(48376002)(6666004)(90966002)(356004)(36386004)(76176011)(51416003)(5660300002)(305945005)(14444005)(19627235002)(47776003)(107886003)(11346002)(2616005)(4326008)(446003)(476003)(126002)(486006)(426003)(336012)(103686004)(16586007)(42186006)(6266002)(81166006)(8936002)(81156014)(8676002)(316002)(50226002)(2906002)(70206006)(36756003)(63266004)(54906003)(52956003)(110136005)(26005)(106002)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN4PR0201MB3406;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b3108167-edd3-4529-6b40-08d6cee7d2e2
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4709054)(2017052603328);SRVR:SN4PR0201MB3406;
X-MS-TrafficTypeDiagnostic: SN4PR0201MB3406:
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <SN4PR0201MB3406AB576A53E09A389BDF4EA7340@SN4PR0201MB3406.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1468;
X-Forefront-PRVS: 0025434D2D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: QQM7kJygwgnO04EBTOf9RsshmV8HDCqssKdkH1c/3qSH5hkuMSiRZ8ZQ2sB+tAa84K9rvSbLyVBzJauxM1Q8S42jbLNXcg8ZTUp3yNTCj2OdXD+rfyxcUfvmmEl1eih6lX+XBNjwGY0OV3URIPyo8hRjXxQXFwQXWRRTwzJwxk2NSemlpYaVA1PLpuFonoPPPSG1oXYQwBjQ8ZTWxuI5P6cUYLjJLbkBDIoWp2ag5+vp19Vrh8FoUZ6R4xjGDTjfxgS7k8hlk8VbPv/tWwCxaNHbbSGRiswEu9FpLWAczE3/M3GRyBs5/YdUJuWzMhzfFQwrJoWJGUGN75RFOe1BOo8mPaw650SHguowsrIvSoU/76li8R3T+Jq2/t5OVKFTiuJj9+ZuLreDs8/uuGxGG2JOxbx+l1ebRVBL31dJRBw=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2019 10:20:38.6131
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3108167-edd3-4529-6b40-08d6cee7d2e2
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0201MB3406
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Passing struct usb_gadget * as an extra argument in get_config_params
makes gadget drivers to easily update the U1DevExitLat & U2DevExitLat
values based on the values passed from the device tree. This patch
does the same

Signed-off-by: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
---
 drivers/usb/gadget/composite.c | 2 +-
 include/linux/usb/gadget.h     | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/composite.c b/drivers/usb/gadget/composite.c
index b8a1584..9118b42 100644
--- a/drivers/usb/gadget/composite.c
+++ b/drivers/usb/gadget/composite.c
@@ -653,7 +653,7 @@ static int bos_desc(struct usb_composite_dev *cdev)
 
 		/* Get Controller configuration */
 		if (cdev->gadget->ops->get_config_params) {
-			cdev->gadget->ops->get_config_params(
+			cdev->gadget->ops->get_config_params(cdev->gadget,
 				&dcd_config_params);
 		} else {
 			dcd_config_params.bU1devExitLat =
diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
index 7595056..fb19141 100644
--- a/include/linux/usb/gadget.h
+++ b/include/linux/usb/gadget.h
@@ -310,7 +310,8 @@ struct usb_gadget_ops {
 	int	(*pullup) (struct usb_gadget *, int is_on);
 	int	(*ioctl)(struct usb_gadget *,
 				unsigned code, unsigned long param);
-	void	(*get_config_params)(struct usb_dcd_config_params *);
+	void	(*get_config_params)(struct usb_gadget *,
+				     struct usb_dcd_config_params *);
 	int	(*udc_start)(struct usb_gadget *,
 			struct usb_gadget_driver *);
 	int	(*udc_stop)(struct usb_gadget *);
-- 
2.1.1

