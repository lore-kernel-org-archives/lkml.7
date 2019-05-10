Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6A59C04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 07:07:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D3D2217F9
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 07:07:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="AAmH5bDO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbfEJHHp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 03:07:45 -0400
Received: from mail-eopbgr790042.outbound.protection.outlook.com ([40.107.79.42]:15733
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727109AbfEJHHo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 03:07:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a2Kt05l1F/7gKWFNhbIcmCAbZsNtjha8mRDgjwXLg1s=;
 b=AAmH5bDOtZvKED4Hqh9qkW+XXRnhTwvphRNwywXev/Z79iYUbhU7lV/lgP25FSWR2h1bJWljpoVPeHaeK2s3ZVP8jBuZrtocOldmc5VPg21YDgbmUK3+IOvvr/C4/JjtgaSBfSdTXSmBQceo8ckC2k5eo3OnUXJhpYV21nMQL20=
Received: from MN2PR02CA0015.namprd02.prod.outlook.com (2603:10b6:208:fc::28)
 by SN1PR02MB3838.namprd02.prod.outlook.com (2603:10b6:802:24::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1878.20; Fri, 10 May
 2019 07:07:41 +0000
Received: from CY1NAM02FT054.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::202) by MN2PR02CA0015.outlook.office365.com
 (2603:10b6:208:fc::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1878.21 via Frontend
 Transport; Fri, 10 May 2019 07:07:41 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 CY1NAM02FT054.mail.protection.outlook.com (10.152.74.100) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1856.11
 via Frontend Transport; Fri, 10 May 2019 07:07:40 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:59123 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1hOzd5-0003Ns-Di; Fri, 10 May 2019 00:07:39 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1hOzd0-0004bk-9H; Fri, 10 May 2019 00:07:34 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x4A77USA004224;
        Fri, 10 May 2019 00:07:30 -0700
Received: from [172.23.64.8] (helo=xhdvnc108.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <anuragku@xilinx.com>)
        id 1hOzcv-0004aP-V5; Fri, 10 May 2019 00:07:30 -0700
Received: by xhdvnc108.xilinx.com (Postfix, from userid 15427)
        id 24C846050B; Fri, 10 May 2019 12:37:29 +0530 (IST)
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
Subject: [PATCH v3 2/3] usb: gadget: send usb_gadget as an argument in get_config_params
Date:   Fri, 10 May 2019 12:37:27 +0530
Message-ID: <1557472048-10536-3-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1557472048-10536-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
References: <1557472048-10536-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(39860400002)(136003)(2980300002)(189003)(199004)(81156014)(2906002)(51416003)(8676002)(63266004)(103686004)(70206006)(476003)(36756003)(70586007)(81166006)(47776003)(90966002)(126002)(11346002)(426003)(446003)(336012)(186003)(478600001)(4326008)(16586007)(110136005)(48376002)(50466002)(2616005)(486006)(106002)(54906003)(107886003)(6266002)(316002)(42186006)(36386004)(8936002)(19627235002)(14444005)(5660300002)(305945005)(50226002)(76176011)(52956003)(26005)(7416002)(356004)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR02MB3838;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;MX:1;A:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eb3435d8-b48c-4bab-1607-08d6d516310b
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4709054)(2017052603328);SRVR:SN1PR02MB3838;
X-MS-TrafficTypeDiagnostic: SN1PR02MB3838:
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <SN1PR02MB3838396C37F10005E971306DA70C0@SN1PR02MB3838.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2043;
X-Forefront-PRVS: 0033AAD26D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 3aFJm+d+pkyDAav2DgtmoqqytWeAqY+wHxTbkWh3QoSHhg9l6C2iFeVe+kUtUu5CkZfKojbmKAnBHYTpHEtUj1ugYuT21of5SuXuDmlnm9Hup93t0gwoD7Z82kucM4eS2wZUY3ipbECiCIQCh2zrJUPhGzOU1bId0dkfy+Z4m1fGN2qfS0wKqmkqMRJERs/YXR1IbQSDNdULyIAnADUB5yFCHqYewKqFgg+3XYFunv7tsAUgXPt17q7NyKUhPgs/xgsvst+PUy+jLjrkhhCWRGwbM7hjO0KSWahZXwLOGPikJHgM6zUXd+ZApxktAiqOzImptJ6J+AGDvk8lWffBwotyag1sMN3WsofuNE58MrJwQDdmlPRWyTdwYBtY/qKlvH+X9iR1Ubv73dDI92ayv+YzKdQg9M9UFW0OAAtftBs=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2019 07:07:40.2396
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb3435d8-b48c-4bab-1607-08d6d516310b
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR02MB3838
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
 Changes in v3:
	- None

 Changes in v2:
	- None
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

