Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7B30C3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 08:30:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 392072077B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 08:30:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Sony.onmicrosoft.com header.i=@Sony.onmicrosoft.com header.b="o08y13nE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728781AbfIDIat (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 04:30:49 -0400
Received: from mail-eopbgr680116.outbound.protection.outlook.com ([40.107.68.116]:5005
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725840AbfIDIat (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 04:30:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KFfczGo2lONQCwXoVSpjyAl/ekI7YniRSKeQDhHpFp0pDQac7Krb540pwokyLT2kr1qmf3bbTUQoj93rHsk+YXai45rKukWR8jqIw4Mq+YvXWBdg44c1xpRr2O0HJGrQY2hnZadaXY0AbQgss5XEFZ+f53Rb0wRY0ksXyxkff9gQIWRF19BYPQg3cibZuoOn5RrIBV8TCkAJzZyFODFAf4SpVR++QGG5zIS+ay1jn4zsZCbFXlrYdpFUKNTAoC3i3zPw6f2a1EP/0LWiLTiGbS0w3Nm4PfwADfi3RCIFTH66jwZtVt5vm7fesF2c/nassUsyq/nyT1qNGxOH0IGdsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q9ioHEXD697AOLfM24gJNpp6HfTvbwAVwdMkIyzVaBA=;
 b=d9SNSsWl/4NAvK2FC2bMe7+7fFNd69ECkSvpzrIelhS901L65OhVF7ZtTwWv2v7W5gjUrmgHINjGFrPK5fkbO+BllNHfzzyZJ1lAr+2rPpZjOR3GKLMpuF0Lhf7aQFgOky+D3pgxVSt3tH3/CNATPWTC4jRcxYmxcU/CNm4GZlsHSy/p75JCbc6Duodmd40iOZqtw3iOB+u76GqRl33UUUJuz0iuGwDqw9ql8kL1kMKsFc16GN+0JecD+OyN//ZfQP/1xGMP5QFpzQCGDSuNyXSHuttLXtbB/IQmR/DJqCuQEMQExE433O0qy3yZcTXCa9RYowzDzKzAKrgnkkw+/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 117.103.190.106) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=sony.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=sony.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Sony.onmicrosoft.com;
 s=selector2-Sony-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q9ioHEXD697AOLfM24gJNpp6HfTvbwAVwdMkIyzVaBA=;
 b=o08y13nEJrnj18DNsO1Bub4n/eFeTt0EN1I6N2ACO409RWB6Ss+0NH+spkIsDBzX8UHT50H3xhkXmOt2ICTbhbar3P/2IPxBsU4XdSsuSJHEt5FoMG5+ZCkGp0rwHejhehvgQDLW3PJxYhBtqkSb/4AzgOY6+FdbAhnNM2kVa1A=
Received: from BN4PR13CA0023.namprd13.prod.outlook.com (2603:10b6:403:3::33)
 by MWHPR1301MB2109.namprd13.prod.outlook.com (2603:10b6:301:34::36) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2241.9; Wed, 4 Sep
 2019 08:30:40 +0000
Received: from SN1NAM02FT005.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::209) by BN4PR13CA0023.outlook.office365.com
 (2603:10b6:403:3::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2241.5 via Frontend
 Transport; Wed, 4 Sep 2019 08:30:40 +0000
Authentication-Results: spf=pass (sender IP is 117.103.190.106)
 smtp.mailfrom=sony.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=sony.com;
Received-SPF: Pass (protection.outlook.com: domain of sony.com designates
 117.103.190.106 as permitted sender) receiver=protection.outlook.com;
 client-ip=117.103.190.106; helo=ap.sony.com;
Received: from ap.sony.com (117.103.190.106) by
 SN1NAM02FT005.mail.protection.outlook.com (10.152.72.117) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2220.16 via Frontend Transport; Wed, 4 Sep 2019 08:30:39 +0000
Received: from APYOKXHT201.ap.sony.com (117.103.191.228) by
 APYOKXEG102.ap.sony.com (117.103.190.106) with Microsoft SMTP Server (TLS) id
 14.3.468.0; Wed, 4 Sep 2019 08:30:22 +0000
Received: from APYOKXMS108.ap.sony.com ([169.254.3.47]) by
 APYOKXHT201.ap.sony.com ([180.12.183.216]) with mapi id 14.03.0468.000; Wed,
 4 Sep 2019 08:30:22 +0000
From:   <Jacky.Cao@sony.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <Kento.A.Kobayashi@sony.com>, <Jacky.Cao@sony.com>
Subject: [PATCH v2] USB: dummy-hcd: fix power budget for SuperSpeed mode
Thread-Topic: [PATCH v2] USB: dummy-hcd: fix power budget for SuperSpeed mode
Thread-Index: AdVi+lvqkkWAGWsrQ2yXA32LynqHGA==
Date:   Wed, 4 Sep 2019 08:30:21 +0000
Message-ID: <16EA1F625E922C43B00B9D82250220500871C8E2@APYOKXMS108.ap.sony.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [43.82.17.73]
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:117.103.190.106;IPV:NLI;CTRY:JP;EFV:NLI;SFV:NSPM;SFS:(10019020)(39860400002)(396003)(136003)(346002)(376002)(2980300002)(189003)(199004)(4326008)(106002)(54906003)(246002)(110136005)(8676002)(47776003)(33656002)(66066001)(316002)(8936002)(16586007)(23726003)(2876002)(3846002)(70206006)(6116002)(107886003)(2906002)(55016002)(37786003)(5660300002)(70586007)(126002)(426003)(102836004)(336012)(86362001)(2201001)(478600001)(186003)(50466002)(14444005)(26005)(486006)(46406003)(55846006)(305945005)(7736002)(7636002)(356004)(476003)(7696005)(97756001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR1301MB2109;H:ap.sony.com;FPR:;SPF:Pass;LANG:en;PTR:apyokxeg102.ap.sony.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4fb1418a-9da6-4fe1-21c2-08d731122b20
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(4709080)(1401327)(4618075)(2017052603328)(7193020);SRVR:MWHPR1301MB2109;
X-MS-TrafficTypeDiagnostic: MWHPR1301MB2109:
X-Microsoft-Antispam-PRVS: <MWHPR1301MB21091846A7CD4D54DBD8EE8587B80@MWHPR1301MB2109.namprd13.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 0150F3F97D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: PzprZvmhHDoiu9GilLC3fTzLBuKqVLc8dg3keS324faYGu59N9+zLfQuvxS4kEch31WesK0uBzkviZs3V7xPG+YTvqfgc3jEkgIwO7QlZdCqk8jboMfzCCuyIaS9qxaPKTonp19tG1RFBVKBHsuk9GPazI07HkXwvBSL11Qps+AQbVkyjKPrP78w0FU2slXX2XMzgnEd9/5a9/7zLim/gvLVIa2NdAe4mfjH5bkQdqbgr7jsB+EFFWbet8GLn9Kl/+lKGNCGHCKG0RMQBcc1cZX0G20SoYjH81ZPe1Ss5DZmj84i+VQjieILGUYvuTbzs7FX3njjZN4/L6p2R6hMUFOIqSkP+zVXJkaaY7B0kHKUdN1Asg9sXZ7GfK+V8fVL9SDAF2a27YWbKzZMifHwwRxMJf4MPmTphK6VIjSMpSc=
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2019 08:30:39.4409
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fb1418a-9da6-4fe1-21c2-08d731122b20
X-MS-Exchange-CrossTenant-Id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=66c65d8a-9158-4521-a2d8-664963db48e4;Ip=[117.103.190.106];Helo=[ap.sony.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1301MB2109
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The power budget for SuperSpeed mode should be 900 mA
according to USB3.0 specification.

If the max power consumption of SuperSpeed device is
larger than 500 mA, insufficient available bus power
error happens in usb_choose_configuration function
when the device connects to dummy hcd.

Signed-off-by: Jacky Cao <Jacky.Cao@sony.com>
---
Changes in v2:
  - Fix whitespace damage

 drivers/usb/gadget/udc/dummy_hcd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/dummy_hcd.c b/drivers/usb/gadget/udc/dummy_hcd.c
index f04e91e..a373f49 100644
--- a/drivers/usb/gadget/udc/dummy_hcd.c
+++ b/drivers/usb/gadget/udc/dummy_hcd.c
@@ -50,6 +50,7 @@
 #define DRIVER_VERSION	"02 May 2005"
 
 #define POWER_BUDGET	500	/* in mA; use 8 for low-power port testing */
+#define POWER_BUDGET_3_0	900	/* in mA */
 
 static const char	driver_name[] = "dummy_hcd";
 static const char	driver_desc[] = "USB Host+Gadget Emulator";
@@ -2439,7 +2440,7 @@ static int dummy_start_ss(struct dummy_hcd *dum_hcd)
 	dum_hcd->rh_state = DUMMY_RH_RUNNING;
 	dum_hcd->stream_en_ep = 0;
 	INIT_LIST_HEAD(&dum_hcd->urbp_list);
-	dummy_hcd_to_hcd(dum_hcd)->power_budget = POWER_BUDGET;
+	dummy_hcd_to_hcd(dum_hcd)->power_budget = POWER_BUDGET_3_0;
 	dummy_hcd_to_hcd(dum_hcd)->state = HC_STATE_RUNNING;
 	dummy_hcd_to_hcd(dum_hcd)->uses_new_polling = 1;
 #ifdef CONFIG_USB_OTG
-- 
2.7.4
