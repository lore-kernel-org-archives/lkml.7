Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E330FC3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 07:52:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B252322DBF
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 07:52:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Sony.onmicrosoft.com header.i=@Sony.onmicrosoft.com header.b="Sykmw2aY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729149AbfIDHwV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 03:52:21 -0400
Received: from mail-eopbgr770110.outbound.protection.outlook.com ([40.107.77.110]:5177
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727787AbfIDHwV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 03:52:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jNNFXb0dwMEHRKxDCnUFinFWzdj9zaEuG4lP1/5gFXGt9vBOS+LaC4TSGyyZccyjo77+3Ge/sB1AASZ4ZECFpQjROAglrAvSfAjxoY7WDY330tb/NLJxGvt5QUJ6UIIqOnljjZyu+PRV1XvicqRFo4DEs1NoqkZHcI8U7BGe/qcPuQ2bqO/M5rIOpfs/RDinm1Ea6o19xxfO2Vu7WAEJtRlgjKveR7ZNSz3ijfZ3xFq0sX4UWWXnr3LPkxhM2sSwaopOrFid2KgDEyB3D43ZdUi/dW44HN8ywBTdbjwcCvPLAHkJcN+f2Sos36hz+FqZMttdgnyWefLO5WQEVKUVmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XIiXu3V3lbGbAEYCw6x24NclHTzaccTY6qVabhrl8KA=;
 b=j1sXXuBuAyry0T1vDh4ABJ+PfhCtD3S/87+1bV41cLvrqBhvVaDOa0GiKT3wiOCEIWDr50UnvhursUZMmaqNPGJHobZ/uUVxeUDd1U3ZpxTR6Zfc2oqwfhgaNddeoOUPU8vdQndrLx0w/Qe1cNtm8M/1uWhhQ5SK9efVbozYQ9UEN6tmjfzG2G0xDbPXNhaCJlIZGVR89iiFHTZ6y1sJBY/DTQ3qMEDBPixA+qaCOUunz4/uNktgxUMt4A7oNB8DcWe45I21Hg+KIUBh8R7Mhelpdkr3w/PC0rCMMEgGjHqo8x7mVA+894UncOnNOjd2y0Es2nq6FVcbwTHGfaDfuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 117.103.190.106) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=sony.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=sony.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Sony.onmicrosoft.com;
 s=selector2-Sony-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XIiXu3V3lbGbAEYCw6x24NclHTzaccTY6qVabhrl8KA=;
 b=Sykmw2aYSYWBdjdxSsBDsj//KwG30JE6OeFFwfpV6Q4LHT9dQwUzUEtUa3DPglPhV5QBuJwXBs3zjMJb/OK5ybeW1qdgi2YHbHeJ5wOkfux+dKHew3QhP+B56TXoivLnmIzPIARe4QP66LQTWjcob3NKw9lXRQSxqNm0y3y/sn0=
Received: from BN6PR1301CA0033.namprd13.prod.outlook.com
 (2603:10b6:405:29::46) by DM5PR13MB1834.namprd13.prod.outlook.com
 (2603:10b6:3:131::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2263.5; Wed, 4 Sep
 2019 07:52:19 +0000
Received: from SN1NAM02FT046.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::208) by BN6PR1301CA0033.outlook.office365.com
 (2603:10b6:405:29::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2241.9 via Frontend
 Transport; Wed, 4 Sep 2019 07:52:17 +0000
Authentication-Results: spf=pass (sender IP is 117.103.190.106)
 smtp.mailfrom=sony.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=sony.com;
Received-SPF: Pass (protection.outlook.com: domain of sony.com designates
 117.103.190.106 as permitted sender) receiver=protection.outlook.com;
 client-ip=117.103.190.106; helo=ap.sony.com;
Received: from ap.sony.com (117.103.190.106) by
 SN1NAM02FT046.mail.protection.outlook.com (10.152.72.191) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2220.16 via Frontend Transport; Wed, 4 Sep 2019 07:52:16 +0000
Received: from APYOKXHT102.ap.sony.com (117.103.191.215) by
 APYOKXEG102.ap.sony.com (117.103.190.106) with Microsoft SMTP Server (TLS) id
 14.3.468.0; Wed, 4 Sep 2019 07:52:01 +0000
Received: from APYOKXMS108.ap.sony.com ([169.254.3.47]) by
 APYOKXHT102.ap.sony.com ([117.103.191.215]) with mapi id 14.03.0468.000; Wed,
 4 Sep 2019 07:52:01 +0000
From:   <Jacky.Cao@sony.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <Kento.A.Kobayashi@sony.com>, <Jacky.Cao@sony.com>
Subject: [PATCH] USB: dummy-hcd: fix power budget for SuperSpeed mode
Thread-Topic: [PATCH] USB: dummy-hcd: fix power budget for SuperSpeed mode
Thread-Index: AdVi9W5+0ODcBoGLQOCjqUMWZobPyw==
Date:   Wed, 4 Sep 2019 07:52:00 +0000
Message-ID: <16EA1F625E922C43B00B9D82250220500871C862@APYOKXMS108.ap.sony.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [43.82.17.73]
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:117.103.190.106;IPV:NLI;CTRY:JP;EFV:NLI;SFV:NSPM;SFS:(10019020)(376002)(396003)(346002)(39860400002)(136003)(2980300002)(189003)(199004)(50466002)(47776003)(2906002)(33656002)(26005)(70206006)(70586007)(106002)(66066001)(186003)(7696005)(46406003)(102836004)(16586007)(54906003)(110136005)(356004)(3846002)(246002)(478600001)(316002)(6116002)(23726003)(86362001)(5660300002)(2876002)(2201001)(8936002)(8676002)(14444005)(37786003)(126002)(486006)(97756001)(476003)(426003)(336012)(4326008)(107886003)(55846006)(7636002)(7736002)(305945005)(55016002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR13MB1834;H:ap.sony.com;FPR:;SPF:Pass;LANG:en;PTR:APYOKXEG102.ap.sony.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 47f8355b-78e7-470b-400a-08d7310ccec9
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(4709080)(1401327)(4618075)(2017052603328)(7193020);SRVR:DM5PR13MB1834;
X-MS-TrafficTypeDiagnostic: DM5PR13MB1834:
X-Microsoft-Antispam-PRVS: <DM5PR13MB1834D90430AE45DA1D5727C887B80@DM5PR13MB1834.namprd13.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 0150F3F97D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 7anNtDLcx83Kj+7pzgoHnjB33zfFYn5LPm/3L7lza662VQCZKTqR6byqXf98z12EAjem4nOV+HlGoNJc6TnJy2rO08XXDJmoWxc8BIIGlSbq0ydslAIP9TeaQ2XlbmaGmvgXrKDqCJLHKwUCgFtPhvlvQYqPAxYLzdkq+5ILe7FDg1YtX6qUCTISZprxHZVUJ/R1mih0+wLzaxJ9FIuKtj7w6W+fLXe6TBBmwWudEpQ5havqoLz41QozlrBmCWNo7Rpotay3EXTvUiqmlaeX9J6BNGMXcNyXgzA2BPH12+GNQdrIfzPTFs7N3D2nKh6YcjNk/fW3Sgip/bM0VSt08AjBaAT4nKeYRQvRgvTHcWnldQYm4H61L4LgYu9DeoX2//gFUMHhPWRhrwGYZZdIKixzcr7hcVJavI73AlB9os8=
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2019 07:52:16.1958
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47f8355b-78e7-470b-400a-08d7310ccec9
X-MS-Exchange-CrossTenant-Id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=66c65d8a-9158-4521-a2d8-664963db48e4;Ip=[117.103.190.106];Helo=[ap.sony.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR13MB1834
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The power budget for SuperSpeed mode should be 900 mA
according to USB3.0 specification, so set the power
budget to 900 mA for dummy_start_ss which is only used
for SuperSpeed mode.

If the max power consumption of SuperSpeed device is
larger than 500 mA, insufficient available bus power
error happens in usb_choose_configuration function
when the device connects to dummy hcd.

Signed-off-by: Jacky Cao <Jacky.Cao@sony.com>
---
drivers/usb/gadget/udc/dummy_hcd.c | 3 ++-
1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/dummy_hcd.c b/drivers/usb/gadget/udc/dummy_hcd.c
index 8414fac..52f2cf5 100644
--- a/drivers/usb/gadget/udc/dummy_hcd.c
+++ b/drivers/usb/gadget/udc/dummy_hcd.c
@@ -48,6 +48,7 @@
#define DRIVER_VERSION "02 May 2005"

 #define POWER_BUDGET  500  /* in mA; use 8 for low-power port testing */
+#define POWER_BUDGET_3_0  900  /* in mA */

 static const char  driver_name[] = "dummy_hcd";
static const char  driver_desc[] = "USB Host+Gadget Emulator";
@@ -2432,7 +2433,7 @@ static int dummy_start_ss(struct dummy_hcd *dum_hcd)
     dum_hcd->rh_state = DUMMY_RH_RUNNING;
     dum_hcd->stream_en_ep = 0;
     INIT_LIST_HEAD(&dum_hcd->urbp_list);
-     dummy_hcd_to_hcd(dum_hcd)->power_budget = POWER_BUDGET;
+     dummy_hcd_to_hcd(dum_hcd)->power_budget = POWER_BUDGET_3_0;
     dummy_hcd_to_hcd(dum_hcd)->state = HC_STATE_RUNNING;
     dummy_hcd_to_hcd(dum_hcd)->uses_new_polling = 1;
#ifdef CONFIG_USB_OTG
-- 
2.7.4
