Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46120C3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 04:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11E0F20578
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 04:12:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Sony.onmicrosoft.com header.i=@Sony.onmicrosoft.com header.b="CTxhSJfA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730769AbfIEEMy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 00:12:54 -0400
Received: from mail-eopbgr820107.outbound.protection.outlook.com ([40.107.82.107]:25050
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725209AbfIEEMx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 00:12:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mYYHk6hviWhl3b+DaoSQAwmnaybKIyBecwvEK1lSojBOGdkX4zAeotUlwKQMOQZGSH1b2dQ88ZRxDRLUTIPK9N/cNYGcVhacjtqbwvDZuKYpdsOL6DbPe+zkB8DEhDWOeNcoXVK5JcXtO6fcQ4ZqycBNNxaninGyxCoS9E0XkAlgzmcPVyL7EH5mzugWng68iAU8lz7FU4Jla4EGK/X88uGxI31Z/M6Jpyalw/2UVbjoFG/TwWjbLn2shbPr8cVDj2vThuH6eVF16o/cJrF/rK0lqStN6IpuFM9D1szH6hH/OJguGvg4myA4x5CSIZsYwIdA2ZgkbK0zvjZh8UtFWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sH7IsC74NEyNMg5+baMspBpjHxuX1QtFxg8l2qAP5Aw=;
 b=H9MwhFvCP/Vl6rJh9kpmBrHzgaAFLCxLymF0iE3mtn9kozEHw/tBi+cSeQER5+pMk0pvTFya20Glp8Zx5wutOwI1EPIi6LEpvIqvM+g5zXZo4+vkB+wCnrbem3BG4DLjgbY/AtRjfO6yuItLYzoi3MOxm0EbQtz9mTLi/uGNenSIc9Ou3/LVxnuHntncgKfnYbLLOzNKhzzuVKJeElSKlZIb8EKoGecjts8AyEcW9oK39u3I+ek3p0fctZB/YRHaiRUk7bA763mSuuZu/kJWupFHcD088jaT4YCL/tk348o1pGu9XI/0x/R1bB4w/GeeD4p5XBo3rJxZsc6QFJLZiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 117.103.190.106) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=sony.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=sony.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Sony.onmicrosoft.com;
 s=selector2-Sony-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sH7IsC74NEyNMg5+baMspBpjHxuX1QtFxg8l2qAP5Aw=;
 b=CTxhSJfAzi25R5+wEQUy3zjtBpPixAuC7b5Lo2aEN869bXLWSB7Qko5ZNb8Tqop87w2SRtYi+uampSoEcg/AnjvO3gk9/KDQ3jbeVYOM3SHDDQQG3dCHsjYqCL4dmm+p/rDx+pNvADtcHI3b817XFRaP6PJHA0Bbf6ES/aBSFaY=
Received: from BN6PR13CA0033.namprd13.prod.outlook.com (2603:10b6:404:13e::19)
 by MWHPR1301MB1966.namprd13.prod.outlook.com (2603:10b6:301:32::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2241.5; Thu, 5 Sep
 2019 04:12:07 +0000
Received: from SN1NAM02FT023.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::203) by BN6PR13CA0033.outlook.office365.com
 (2603:10b6:404:13e::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2263.5 via Frontend
 Transport; Thu, 5 Sep 2019 04:12:07 +0000
Authentication-Results: spf=pass (sender IP is 117.103.190.106)
 smtp.mailfrom=sony.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=sony.com;
Received-SPF: Pass (protection.outlook.com: domain of sony.com designates
 117.103.190.106 as permitted sender) receiver=protection.outlook.com;
 client-ip=117.103.190.106; helo=ap.sony.com;
Received: from ap.sony.com (117.103.190.106) by
 SN1NAM02FT023.mail.protection.outlook.com (10.152.72.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2241.14 via Frontend Transport; Thu, 5 Sep 2019 04:12:05 +0000
Received: from APYOKXHT105.ap.sony.com (117.103.191.223) by
 APYOKXEG102.ap.sony.com (117.103.190.106) with Microsoft SMTP Server (TLS) id
 14.3.468.0; Thu, 5 Sep 2019 04:11:58 +0000
Received: from APYOKXMS108.ap.sony.com ([169.254.3.47]) by
 APYOKXHT105.ap.sony.com ([117.103.191.223]) with mapi id 14.03.0468.000; Thu,
 5 Sep 2019 04:11:58 +0000
From:   <Jacky.Cao@sony.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <stern@rowland.harvard.edu>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Kento.A.Kobayashi@sony.com>, <Jacky.Cao@sony.com>
Subject: [PATCH v3] USB: dummy-hcd: fix power budget for SuperSpeed mode
Thread-Topic: [PATCH v3] USB: dummy-hcd: fix power budget for SuperSpeed mode
Thread-Index: AdVjnzygYGk1oEEuTFussd4DlSzUEg==
Date:   Thu, 5 Sep 2019 04:11:57 +0000
Message-ID: <16EA1F625E922C43B00B9D82250220500871CDE5@APYOKXMS108.ap.sony.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [43.82.17.73]
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:117.103.190.106;IPV:NLI;CTRY:JP;EFV:NLI;SFV:NSPM;SFS:(10019020)(396003)(39860400002)(136003)(376002)(346002)(2980300002)(199004)(189003)(246002)(110136005)(316002)(6116002)(2201001)(26005)(3846002)(106002)(305945005)(66066001)(54906003)(2906002)(47776003)(102836004)(478600001)(86362001)(8936002)(7736002)(70586007)(7636002)(70206006)(8676002)(33656002)(107886003)(186003)(7696005)(16586007)(23726003)(2876002)(2171002)(486006)(126002)(50466002)(4326008)(37786003)(5660300002)(356004)(55016002)(426003)(97756001)(55846006)(14444005)(476003)(336012)(46406003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR1301MB1966;H:ap.sony.com;FPR:;SPF:Pass;LANG:en;PTR:apyokxeg102.ap.sony.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 06cc3eea-642e-4cd2-437b-08d731b736d8
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(4709080)(1401327)(4618075)(2017052603328)(7193020);SRVR:MWHPR1301MB1966;
X-MS-TrafficTypeDiagnostic: MWHPR1301MB1966:
X-Microsoft-Antispam-PRVS: <MWHPR1301MB19661E157296CDCCDFAAD0E487BB0@MWHPR1301MB1966.namprd13.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:935;
X-Forefront-PRVS: 015114592F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: Zg07XwStwO711yOuj3sbVLx6gruaH7cLPT/MB2xgAFOfsGuY7wtWj+0/GXv/qCVuMicFbyItP+E8GhlS6g9ql4U+8gmB6OqRQV8Nm/I/ZPpgjpQJgH1i97GNeARQTeMHwqe/kzHMEq0FQcjDjtOmtWOXYka2ouxYFegBZGL0gYXsqDs6mNh+TfwKEFfMV6ymukWJwGLYd4uNuTNL8pAnqNg9A/yecBNUal3+RIH5eMJBfGYOoYVGJEqeJinteUXABCTFA3TtP/Ao8YfH/J1TqNXOxKLgFGEypQLpPT5cvRUMRP0JwvxufDzOC7YxvMBFMXP7BV7F8mrtrdGBp+XuMhhR7JuRj5v64uofo4cSu3tHC7onz2C2fGMkTgywjWUz0sOy0h+lkgTMlrv2yswLWtu+0Qcty2SzExtS9Wr16nE=
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2019 04:12:05.9525
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06cc3eea-642e-4cd2-437b-08d731b736d8
X-MS-Exchange-CrossTenant-Id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=66c65d8a-9158-4521-a2d8-664963db48e4;Ip=[117.103.190.106];Helo=[ap.sony.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1301MB1966
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The power budget for SuperSpeed mode should be 900 mA
according to USB specification, so set the power budget
to 900mA for dummy_start_ss which is only used for
SuperSpeed mode.

If the max power consumption of SuperSpeed device is
larger than 500 mA, insufficient available bus power
error happens in usb_choose_configuration function
when the device connects to dummy hcd.

Signed-off-by: Jacky Cao <Jacky.Cao@sony.com>
---
Changes in v3:
  - Rename POWER_BUDGET_3_0 to POWER_BUDGET_3
  - Update commit message from USB3.0 specification to USB specification

Changes in v2:
  - Fix whitespace damage

 drivers/usb/gadget/udc/dummy_hcd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/dummy_hcd.c b/drivers/usb/gadget/udc/dummy_hcd.c
index 8414fac..3d499d9 100644
--- a/drivers/usb/gadget/udc/dummy_hcd.c
+++ b/drivers/usb/gadget/udc/dummy_hcd.c
@@ -48,6 +48,7 @@
 #define DRIVER_VERSION	"02 May 2005"
 
 #define POWER_BUDGET	500	/* in mA; use 8 for low-power port testing */
+#define POWER_BUDGET_3	900	/* in mA */
 
 static const char	driver_name[] = "dummy_hcd";
 static const char	driver_desc[] = "USB Host+Gadget Emulator";
@@ -2432,7 +2433,7 @@ static int dummy_start_ss(struct dummy_hcd *dum_hcd)
 	dum_hcd->rh_state = DUMMY_RH_RUNNING;
 	dum_hcd->stream_en_ep = 0;
 	INIT_LIST_HEAD(&dum_hcd->urbp_list);
-	dummy_hcd_to_hcd(dum_hcd)->power_budget = POWER_BUDGET;
+	dummy_hcd_to_hcd(dum_hcd)->power_budget = POWER_BUDGET_3;
 	dummy_hcd_to_hcd(dum_hcd)->state = HC_STATE_RUNNING;
 	dummy_hcd_to_hcd(dum_hcd)->uses_new_polling = 1;
 #ifdef CONFIG_USB_OTG
-- 
2.7.4
