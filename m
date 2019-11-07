Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 923DBC5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 11:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CF0821D6C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 11:42:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="DbhV45SV";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="DbhV45SV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388382AbfKGLm4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 06:42:56 -0500
Received: from mail-eopbgr150044.outbound.protection.outlook.com ([40.107.15.44]:34819
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388302AbfKGLmz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 06:42:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hdEv+rpc6/qvleFAe3PSD5v3Qd51wjznRg/0aKpB75s=;
 b=DbhV45SVQ5sL8qYSzLQMIxD0HljUXf8wIRfthvGzTfpLQLwh5qjCJd1oqvEf3VKgip6FoJOJ/3e3ZHV7xMt6foWaS7HEt7zrsgT3I5ax15vAK4Re0iO3ZjTfoQrL4gi1OadYyVlsthr3wA5jt/FUfZPwEqHy/GvC3bk+CrbC7T0=
Received: from VE1PR08CA0032.eurprd08.prod.outlook.com (2603:10a6:803:104::45)
 by AM0PR08MB5060.eurprd08.prod.outlook.com (2603:10a6:208:15e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2408.24; Thu, 7 Nov
 2019 11:42:50 +0000
Received: from DB5EUR03FT028.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::206) by VE1PR08CA0032.outlook.office365.com
 (2603:10a6:803:104::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2430.22 via Frontend
 Transport; Thu, 7 Nov 2019 11:42:50 +0000
Authentication-Results: spf=fail (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: Fail (protection.outlook.com: domain of arm.com does not
 designate 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT028.mail.protection.outlook.com (10.152.20.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.21 via Frontend Transport; Thu, 7 Nov 2019 11:42:50 +0000
Received: ("Tessian outbound 0939a6bab6b1:v33"); Thu, 07 Nov 2019 11:42:47 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 2becc7e6f318a98b
X-CR-MTA-TID: 64aa7808
Received: from c990ab8b960a.2 (cr-mta-lb-1.cr-mta-net [104.47.10.54])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id A55E4A59-CB71-49AE-B389-EEA9751D9034.1;
        Thu, 07 Nov 2019 11:42:42 +0000
Received: from EUR03-DB5-obe.outbound.protection.outlook.com (mail-db5eur03lp2054.outbound.protection.outlook.com [104.47.10.54])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id c990ab8b960a.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384);
    Thu, 07 Nov 2019 11:42:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QjL8f58YFKsPXiZL3S+VMSxOPvEuEAgLMjBN9LMo95uXRqWFs19iYYzrgFlsWp/RGjpabBNN9IpC/Q1vmbdWzUXkyv3Ahkdy9IwOzqrUV5BXr2X8vkmz9jyvk7s2whQIO4Er1rQugAby4kplQzd6iv0FH/qqiWQDQ3l4UAAgqy1rYycEHxdvfVETQ2DgxFMWM8gzxLwkxNUzW9AzClens/9cFobKJbDCOVfKCDI8L0l3fGS/sUEcaln3IA7uRfscfT6JXCw/Fa0pEB5radaZMzDEs0FTOrLo7m3jyuaErgjTwakNM1MXRyrxjfyNn6kR8OOqhV7joGsWyGDQJ10FxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hdEv+rpc6/qvleFAe3PSD5v3Qd51wjznRg/0aKpB75s=;
 b=hF/N2w9jPzWVDVLhdCGq4aM36c+nPOrwe0lcJWE6TINJaRQPYiS510kZwaJ6fGKCWebrud6Ithq8GTOYLR41VJe67Xl5oBznmfOinhJc2eWGklJNwsPi7tQshuxA7RqMIcU48X1RfyExOSaaOfkRrgVOx711g9ev+2p4tb0rAcYvHm4LVBiPGQzomoLJ+rtPZogDy+HEYYFBvI3yd6cLV0ouRxn4l8V9X7hgVhy0febrbgTE87rQmXB8fRHZMgBqQpyT3hfMziQ9Wnt1yXiEvoF1tjt5G5L9AgMpFIyeZVSqXhBFofoh49zLPp6XWYBlj4EzDaUb3wtYo8kIlAYQrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hdEv+rpc6/qvleFAe3PSD5v3Qd51wjznRg/0aKpB75s=;
 b=DbhV45SVQ5sL8qYSzLQMIxD0HljUXf8wIRfthvGzTfpLQLwh5qjCJd1oqvEf3VKgip6FoJOJ/3e3ZHV7xMt6foWaS7HEt7zrsgT3I5ax15vAK4Re0iO3ZjTfoQrL4gi1OadYyVlsthr3wA5jt/FUfZPwEqHy/GvC3bk+CrbC7T0=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB4351.eurprd08.prod.outlook.com (20.179.27.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Thu, 7 Nov 2019 11:42:40 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d%3]) with mapi id 15.20.2408.028; Thu, 7 Nov 2019
 11:42:40 +0000
From:   Mihail Atanassov <Mihail.Atanassov@arm.com>
To:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
CC:     Mihail Atanassov <Mihail.Atanassov@arm.com>, nd <nd@arm.com>,
        Mihail Atanassov <Mihail.Atanassov@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sean Paul <sean@poorly.run>, Liviu Dudau <Liviu.Dudau@arm.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 4/5] drm/komeda: Add option to print WARN- and INFO-level
 IRQ events
Thread-Topic: [PATCH v2 4/5] drm/komeda: Add option to print WARN- and
 INFO-level IRQ events
Thread-Index: AQHVlWB1Q0f+vy2V1k2vOdtTiirrgQ==
Date:   Thu, 7 Nov 2019 11:42:40 +0000
Message-ID: <20191107114155.54307-5-mihail.atanassov@arm.com>
References: <20191107114155.54307-1-mihail.atanassov@arm.com>
In-Reply-To: <20191107114155.54307-1-mihail.atanassov@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [217.140.106.55]
x-clientproxiedby: LO2P265CA0146.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9::14) To VI1PR08MB4078.eurprd08.prod.outlook.com
 (2603:10a6:803:e5::28)
x-mailer: git-send-email 2.23.0
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 831f6f1f-9582-433e-5fcf-08d763779e1d
X-MS-TrafficTypeDiagnostic: VI1PR08MB4351:|VI1PR08MB4351:|AM0PR08MB5060:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM0PR08MB5060586E0DEE485DEBF6B6BB8F780@AM0PR08MB5060.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:1388;OLM:1388;
x-forefront-prvs: 0214EB3F68
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(366004)(346002)(396003)(39860400002)(376002)(136003)(189003)(199004)(11346002)(316002)(54906003)(446003)(476003)(50226002)(71200400001)(6512007)(305945005)(6916009)(2906002)(8936002)(2616005)(44832011)(4326008)(6436002)(66066001)(256004)(486006)(86362001)(26005)(71190400001)(36756003)(52116002)(2351001)(14444005)(6506007)(99286004)(6486002)(102836004)(2501003)(76176011)(386003)(186003)(6116002)(14454004)(66946007)(66476007)(66556008)(64756008)(66446008)(25786009)(478600001)(1076003)(3846002)(8676002)(81166006)(81156014)(7736002)(5640700003)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB4351;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: elWFsN2V9a1CqgiI+GP4h/WKFoNbsOG3+MaqvodtFPnx2KJ6KQCrL3is6DZpaWjbpvllnAl6KSVpmrfmNRiOp2dYrKG9XeBqbWQrtTnhHHg7i85L9Lw3JjaeyAQjFhIZjugyDtU0xpSH3IYf2hykze7AD9o/jYNnZJJMnESqEL/uLzk4R+3bSRv77NRAs0K3FzgW+ons8+6EIt9pGkurUKzztACDen9TkdOcJS8CyBOjSv9H7m+dhhlXhTwVfPkdlmQLfByTIRSH6dJ8G0a88aqIhhVjv+PKlmdcMDp/Im9qhHV2S6gRKR0WK0cYc6QPU02OzoY+k1jmiXkWDk+HOmtjS0fQkfwi/s1um/8EMEA9BIz9FdvXJRud3gEOaT1v6gdHac4auSJZvIg7pRY1S5uL2Z3rC2NLNEDEgMWDHEP6LRLuofuJPGoB9QtSGlfm
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4351
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT028.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(346002)(376002)(39860400002)(396003)(1110001)(339900001)(189003)(199004)(105606002)(26826003)(478600001)(26005)(76176011)(2351001)(8936002)(186003)(47776003)(14454004)(8746002)(50226002)(66066001)(6486002)(99286004)(336012)(5660300002)(76130400001)(14444005)(5640700003)(6506007)(386003)(102836004)(356004)(1076003)(6512007)(446003)(11346002)(81166006)(8676002)(70586007)(486006)(126002)(7736002)(22756006)(476003)(81156014)(2616005)(6862004)(70206006)(316002)(305945005)(50466002)(2906002)(36756003)(2501003)(86362001)(3846002)(6116002)(54906003)(25786009)(4326008)(23756003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB5060;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Fail;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: a90ed5b8-f7c6-46f0-6b5b-08d763779838
NoDisclaimer: True
X-Forefront-PRVS: 0214EB3F68
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6EznPzmq8zS/spciRNcXV/ak9BVCBKztHTG1N7s+gE5RxshEvHwwuj0UyWosSE64BjdB4ErJcdWQZdY9LnuHTaee0j0fvUJgO9JQCjN024fodZGQC7vrtLLlmmi8S8h52FckrFKApei16zyqcGop6l3mYXfPFT0IoeCg+ZIELKd9Ij9blVgvQP8ojenT5M6C0dnKjV9PWpD52x6VMk40pOL4b1Z9C/QTw6E+GszKhbRAc9GJeT6wFEUFTNZhuqf2VRjHps7h6ypwSAi5HMnrJb8Lqe9WPmDcheIusgGIdyG7ThgT5FSeaTputbAE3CT3NDJOf6XDdu7+lJANJHuCIHH71+/wk75tLvqIQ4XADYj/ABrVAA2m61oWhiyQx3R3BJZu3K121jUEOZsXWVIobTt5b33e4eZXY7uye3tte8VZpSuRZqHLiPL5VILWzRFD
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2019 11:42:50.0537
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 831f6f1f-9582-433e-5fcf-08d763779e1d
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5060
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extra detail (normally off) almost never hurts.

Reviewed-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.co=
m>
Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
---
 drivers/gpu/drm/arm/display/komeda/komeda_dev.h   | 11 +++++++++++
 drivers/gpu/drm/arm/display/komeda/komeda_event.c |  4 ++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h b/drivers/gpu/=
drm/arm/display/komeda/komeda_dev.h
index 4809000c1efb..d9fc9c48859a 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
@@ -51,6 +51,13 @@
=20
 #define KOMEDA_WARN_EVENTS	KOMEDA_ERR_CSCE
=20
+#define KOMEDA_INFO_EVENTS ({0 \
+			    | KOMEDA_EVENT_VSYNC \
+			    | KOMEDA_EVENT_FLIP \
+			    | KOMEDA_EVENT_EOW \
+			    | KOMEDA_EVENT_MODE \
+			    })
+
 /* malidp device id */
 enum {
 	MALI_D71 =3D 0,
@@ -211,6 +218,10 @@ struct komeda_dev {
 	u16 err_verbosity;
 	/* Print a single line per error per frame with error events. */
 #define KOMEDA_DEV_PRINT_ERR_EVENTS BIT(0)
+	/* Print a single line per warning per frame with error events. */
+#define KOMEDA_DEV_PRINT_WARN_EVENTS BIT(1)
+	/* Print a single line per info event per frame with error events. */
+#define KOMEDA_DEV_PRINT_INFO_EVENTS BIT(2)
 	/* Dump DRM state on an error or warning event. */
 #define KOMEDA_DEV_PRINT_DUMP_STATE_ON_EVENT BIT(8)
 };
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_event.c b/drivers/gp=
u/drm/arm/display/komeda/komeda_event.c
index de99a588ed75..7fd624761a2b 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_event.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_event.c
@@ -124,6 +124,10 @@ void komeda_print_events(struct komeda_events *evts, s=
truct drm_device *dev)
=20
 	if (err_verbosity & KOMEDA_DEV_PRINT_ERR_EVENTS)
 		print_evts |=3D KOMEDA_ERR_EVENTS;
+	if (err_verbosity & KOMEDA_DEV_PRINT_WARN_EVENTS)
+		print_evts |=3D KOMEDA_WARN_EVENTS;
+	if (err_verbosity & KOMEDA_DEV_PRINT_INFO_EVENTS)
+		print_evts |=3D KOMEDA_INFO_EVENTS;
=20
 	if (evts_mask & print_evts) {
 		char msg[256];
--=20
2.23.0

