Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E56C7C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 12:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC62E223D1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 12:04:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="syEHckz5";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="syEHckz5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729513AbfKTMEO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 07:04:14 -0500
Received: from mail-eopbgr50045.outbound.protection.outlook.com ([40.107.5.45]:55574
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726689AbfKTMEO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 07:04:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TWgIEX2PHt+Q5+g5bQHryf+220ZL3KKgfgZbuq/dHBY=;
 b=syEHckz5/iLfc5y6l69NRckrZWnyy9LoZD1JfjRfx7i/3gf4RDnCfwotYL53/2hJ1fUwiT0uUUsK2cji2gp2aoK3KSYg38WtpOePzeDh81+PQTLgUk20j7v+lckxpmKE9fWcstYdbTY1RUhXQmSEoT9W5L0kWCkNEJfX7PsAVxo=
Received: from VI1PR08CA0187.eurprd08.prod.outlook.com (2603:10a6:800:d2::17)
 by AM0PR08MB5155.eurprd08.prod.outlook.com (2603:10a6:208:15f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.16; Wed, 20 Nov
 2019 12:04:06 +0000
Received: from DB5EUR03FT028.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::206) by VI1PR08CA0187.outlook.office365.com
 (2603:10a6:800:d2::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.17 via Frontend
 Transport; Wed, 20 Nov 2019 12:04:06 +0000
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
 15.20.2474.17 via Frontend Transport; Wed, 20 Nov 2019 12:04:06 +0000
Received: ("Tessian outbound a8f166c1f585:v33"); Wed, 20 Nov 2019 12:04:03 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 08fafed8e21ca22e
X-CR-MTA-TID: 64aa7808
Received: from 3adacec40614.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.10.53])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id DB86F84F-B9B3-45B9-AFDC-0F98D215173C.1;
        Wed, 20 Nov 2019 12:03:58 +0000
Received: from EUR03-DB5-obe.outbound.protection.outlook.com (mail-db5eur03lp2053.outbound.protection.outlook.com [104.47.10.53])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 3adacec40614.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 20 Nov 2019 12:03:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QpCdEg3fP90zhSGuYuHeVTlrOw4DNg+hc+Cid/VbIadPOzJeb1OYaL2SU5h/TBVTCS9oaZLhyRbBwmh1jW26PlYDgSRCdtIbU3deVoFhYD3JA2hoe3UN2dnNewitWkRRbve7D1B2gxDEGpKG0MEsQfklYr+Z1GUZrcg+TeybAWKwf3dAYbYQ280ME6rnzjsevlGkSfLBjCBjncgaPMxjekGYyOlIl7TgS7m4b55/f7BJjmiZrlT1YYwaRXfrdeYDSwB6IvKEBUcBnsE3diSHxMGzllU1/COk2xLI/8Unl155t7vXo7EMMhkE3l9a25h+oBaW+gxu2s01RmLOAXO/2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TWgIEX2PHt+Q5+g5bQHryf+220ZL3KKgfgZbuq/dHBY=;
 b=CwvjGdBPPoJe2pLxJfvtIdjwCapcGOq2jb8eoH52jt2saFTyfqRvmL2esk/VwR5IdbSyhdX6qEjLPzxKt8s6c93qLm60KnBBS+g6AIzrraPAy0o6dGJcX5p7oQDM2fbyCpxSpGDiTWSKu8rm4zSljIfO43xdebOB+Vn9aIXJ9nwQ4+vzrzNZDZU/hzcFOKwx1JdaEieqcWXhc7RdcP15gf5PfpPyz7Ia2yMfSetwcYRzoW+wa4DgNV9gUjjM0Od7jt9Sqr8LoVGazotplGdMO05bfQab1UuoVmLrLSCQt+ZQ0iyz4UhKSVZOi7yWDxzZBKWkRnFcqqSmmRXc0J7ByA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TWgIEX2PHt+Q5+g5bQHryf+220ZL3KKgfgZbuq/dHBY=;
 b=syEHckz5/iLfc5y6l69NRckrZWnyy9LoZD1JfjRfx7i/3gf4RDnCfwotYL53/2hJ1fUwiT0uUUsK2cji2gp2aoK3KSYg38WtpOePzeDh81+PQTLgUk20j7v+lckxpmKE9fWcstYdbTY1RUhXQmSEoT9W5L0kWCkNEJfX7PsAVxo=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB3871.eurprd08.prod.outlook.com (20.178.13.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.17; Wed, 20 Nov 2019 12:03:55 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d%3]) with mapi id 15.20.2451.031; Wed, 20 Nov 2019
 12:03:55 +0000
From:   Mihail Atanassov <Mihail.Atanassov@arm.com>
To:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
CC:     Mihail Atanassov <Mihail.Atanassov@arm.com>, nd <nd@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sean Paul <sean@poorly.run>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] drm/komeda: Remove unnecessary komeda_wb_connector_detect
Thread-Topic: [PATCH] drm/komeda: Remove unnecessary
 komeda_wb_connector_detect
Thread-Index: AQHVn5qV+pWuZV5Y1kWI3ajbAtzdnA==
Date:   Wed, 20 Nov 2019 12:03:55 +0000
Message-ID: <20191120120348.37340-1-mihail.atanassov@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [217.140.106.55]
x-clientproxiedby: LNXP123CA0024.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:d2::36) To VI1PR08MB4078.eurprd08.prod.outlook.com
 (2603:10a6:803:e5::28)
x-mailer: git-send-email 2.23.0
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 12843ec0-e9a1-4667-a090-08d76db1be33
X-MS-TrafficTypeDiagnostic: VI1PR08MB3871:|VI1PR08MB3871:|AM0PR08MB5155:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM0PR08MB51555EE9DC4F62A8D12016488F4F0@AM0PR08MB5155.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:139;OLM:139;
x-forefront-prvs: 02272225C5
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(346002)(39860400002)(376002)(366004)(189003)(199004)(6436002)(6486002)(81166006)(102836004)(6506007)(8936002)(8676002)(81156014)(2351001)(2906002)(186003)(5640700003)(1076003)(14454004)(54906003)(6512007)(2501003)(478600001)(26005)(316002)(386003)(99286004)(2616005)(6916009)(66066001)(486006)(36756003)(66556008)(66446008)(50226002)(476003)(4326008)(25786009)(66476007)(66946007)(64756008)(71200400001)(256004)(14444005)(86362001)(71190400001)(5660300002)(305945005)(7736002)(3846002)(6116002)(44832011)(52116002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3871;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: K7syOcYj4MRY06vDicNeTzymqa39FVoGMEPATGD9k5Ytroyz63jSdOt44/maK4Ypbho1A//GmC4dsOridZzPZumjhW+/iNUJOtMkQiD8HRZCLx5tOreru7b0g6R30goU2sWcu8NCwsVBO1k7RNsOtsE+brpquXU9KaNbXARRfUjAeCrWJ3j9Qhhan6yiIQdIeyRtmMMbLGMyiItLR0fLMLIDg3Yl91LzQAaUBovYCSQ8sslFmyiZsohKsuqztJkIq31RuJgcRdDxRYdgCa4RSB6SNM8AnY6O/t/D4zjRUkvMnsfml+gpZzDz3oaGW2YUZydyIMMsIRx299lsS69YMvYQ4pL1GLed2/6+dKGq87WpmJaU6GSzH3Wxh/A+0dSf4/YX9t9I96qqW4uo7Si4F1kH02iRoF/Zfijut5up1UZKrKf9n8ronfa4+l9p6f5F
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3871
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT028.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(376002)(39860400002)(346002)(396003)(1110001)(339900001)(189003)(199004)(81156014)(50226002)(2351001)(6512007)(47776003)(26826003)(14444005)(86362001)(1076003)(105606002)(8746002)(8936002)(126002)(478600001)(476003)(8676002)(4326008)(14454004)(25786009)(66066001)(99286004)(486006)(2616005)(81166006)(6862004)(23756003)(386003)(6506007)(305945005)(6486002)(336012)(76130400001)(5640700003)(186003)(3846002)(102836004)(26005)(54906003)(70586007)(70206006)(356004)(50466002)(2501003)(316002)(22756006)(36756003)(7736002)(6116002)(2906002)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB5155;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Fail;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: fcce571c-e4ca-40ae-194d-08d76db1b7b8
NoDisclaimer: True
X-Forefront-PRVS: 02272225C5
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yT6UVlyohHgHW8AjCJB0RGmgYFvYsj4LByKTVqsXAlfO/XESt3Bf76sx7AQYXJhoLQdAEk5nyqTNrjn+dOyaATfb1EKSpoL4KeGR4c4bXQi1Z+BQ2gcdB5NiFdTBfmtCleav6pH05rMdWleARMNh1UMOLUxxuwVuBKqNK725V5QW4oMK62akvsgZLhUN4QLuXpH3D985eIBXfEvfbrXXLLyPOHptx240jCCSRd3rgKpEoPspjHqWlutr4QjNeQP6BY4po68RsmMd4XRmW9fP5fXo7MIiPboR0tRGsVQo/Kt86YMISXvOS/Bhtshan3qHqnlYtDZAvW57DRDtni/UpQumrxPDrF/8g+LlZYGH6vYZZBZN6GGhpn7H1ZYRfICqLAvxX/UCHLUzFO3ApOMZm+/qa9bxAw/A/0dUVw0AT0x+322z3jOb8YBVADKcA0s5
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2019 12:04:06.3387
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12843ec0-e9a1-4667-a090-08d76db1be33
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5155
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The func is optional and the connector will report as always connected,
i.e. no change in behaviour.

Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
---
 drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c b/dri=
vers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
index e465cc4879c9..c89ecdba8c28 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
@@ -107,12 +107,6 @@ static const struct drm_connector_helper_funcs komeda_=
wb_conn_helper_funcs =3D {
 	.mode_valid	=3D komeda_wb_connector_mode_valid,
 };
=20
-static enum drm_connector_status
-komeda_wb_connector_detect(struct drm_connector *connector, bool force)
-{
-	return connector_status_connected;
-}
-
 static int
 komeda_wb_connector_fill_modes(struct drm_connector *connector,
 			       uint32_t maxX, uint32_t maxY)
@@ -128,7 +122,6 @@ static void komeda_wb_connector_destroy(struct drm_conn=
ector *connector)
=20
 static const struct drm_connector_funcs komeda_wb_connector_funcs =3D {
 	.reset			=3D drm_atomic_helper_connector_reset,
-	.detect			=3D komeda_wb_connector_detect,
 	.fill_modes		=3D komeda_wb_connector_fill_modes,
 	.destroy		=3D komeda_wb_connector_destroy,
 	.atomic_duplicate_state	=3D drm_atomic_helper_connector_duplicate_state,
--=20
2.23.0

