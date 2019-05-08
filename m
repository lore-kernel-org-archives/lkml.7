Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCC1EC04AAB
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 07:55:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 940C320644
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 07:55:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="XKTsFeyI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbfEHHzW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 03:55:22 -0400
Received: from mail-eopbgr680055.outbound.protection.outlook.com ([40.107.68.55]:33765
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726387AbfEHHzN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 03:55:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i9obC+XnYY5Lp4T88fY4vsQArDN7Z+R5QlLUN8efwLs=;
 b=XKTsFeyIXaw2Z1YdXQ17DJrohjcy5/+6yNkp+rQ69AaMdjJ1cabKIGdhZiJX1rRnDWLHvUT19ovz03215VOzHu54wy3rJ5lIxNRlhGmYCR1J4bY91jJY/TL1aHQvn94XHZBvRwvuzHsjIRBmnljU1FFfrCP/wi5RGCw+lHaFsrM=
Received: from BYAPR02CA0055.namprd02.prod.outlook.com (2603:10b6:a03:54::32)
 by DM6PR02MB6026.namprd02.prod.outlook.com (2603:10b6:5:1f5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1878.20; Wed, 8 May
 2019 07:55:09 +0000
Received: from SN1NAM02FT003.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::209) by BYAPR02CA0055.outlook.office365.com
 (2603:10b6:a03:54::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1856.11 via Frontend
 Transport; Wed, 8 May 2019 07:55:09 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT003.mail.protection.outlook.com (10.152.73.29) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1856.11
 via Frontend Transport; Wed, 8 May 2019 07:55:08 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1hOHPw-0004Y5-AY; Wed, 08 May 2019 00:55:08 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1hOHPr-0005yM-6b; Wed, 08 May 2019 00:55:03 -0700
Received: from xsj-pvapsmtp01 (mailhub.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x487srAu027161;
        Wed, 8 May 2019 00:54:53 -0700
Received: from [172.23.64.8] (helo=xhdvnc108.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <anuragku@xilinx.com>)
        id 1hOHPh-0005sE-Gk; Wed, 08 May 2019 00:54:53 -0700
Received: by xhdvnc108.xilinx.com (Postfix, from userid 15427)
        id B0E4E6050A; Wed,  8 May 2019 13:24:52 +0530 (IST)
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
Subject: [PATCH v2 2/3] usb: gadget: send usb_gadget as an argument in get_config_params
Date:   Wed, 8 May 2019 13:24:50 +0530
Message-ID: <1557302091-7455-3-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1557302091-7455-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
References: <1557302091-7455-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(396003)(376002)(346002)(136003)(2980300002)(199004)(189003)(107886003)(81166006)(70586007)(7416002)(16586007)(110136005)(5660300002)(26005)(106002)(47776003)(8676002)(186003)(81156014)(54906003)(336012)(305945005)(426003)(90966002)(70206006)(4326008)(356004)(76176011)(51416003)(478600001)(36386004)(446003)(36756003)(2616005)(11346002)(19627235002)(50466002)(14444005)(63266004)(42186006)(50226002)(316002)(6266002)(8936002)(52956003)(48376002)(486006)(476003)(126002)(2906002)(103686004);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB6026;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 88906eeb-60be-4557-3b66-08d6d38a7de8
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4709054)(2017052603328);SRVR:DM6PR02MB6026;
X-MS-TrafficTypeDiagnostic: DM6PR02MB6026:
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM6PR02MB60265ADE05A1E372BCC9D521A7320@DM6PR02MB6026.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2043;
X-Forefront-PRVS: 0031A0FFAF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: RvEdIpmk/I5Z0YyFjcfVac/rO76foQlLGTVcoUoEnNXvHi7fLxECUS4M5hJWTT/LDrbkR3qr0AWhFNXuTvZIVy0Sc4SvJqyREmmjdPBz6S0HlkZPi4ob5U/WbNNCxOMhfhYmctgvP5l8ciPfLDg64VePmgKejwAqy1MQX54G+8b+RYtsHnJ2picGucI6CZATQ74pVKXaXszss1W7AFsMRkLbn1KDgdhXWNT9VzjyNwl/gZmRn/ky5uKRzFi0FEeL97M42K8OilmSpu7S4nQguuRzQp+E61BIl424mMCEs32+iRgJalQKquyVZcBhtXY9LHh5pmbVQthxeGhuNEv4qU3x8AKtV2GlyA0AUoY7pN7AuJY6LVsM6ekY0hwm1LkR7WaKj8MSqJGWiz+Sszmr6rwCMPToj8+UR1CTHMjZoQE=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2019 07:55:08.7219
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88906eeb-60be-4557-3b66-08d6d38a7de8
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6026
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

