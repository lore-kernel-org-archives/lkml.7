Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ACF2C2D0D2
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 17:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 576822071E
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 17:35:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="iyX2tu8Z";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="iyX2tu8Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbfLXRfG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Dec 2019 12:35:06 -0500
Received: from mail-eopbgr70047.outbound.protection.outlook.com ([40.107.7.47]:42286
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727173AbfLXRe7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 12:34:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A/0zJrf0XLA5Sb326x6RiVHw/NRaNDEgL3SBCtwP5Uc=;
 b=iyX2tu8ZBr+uKxvw1orgKBSywVv7JJkcmE1nBeHOvOJuy2nBMIkUH9YmWwVdkiHGbhwpdBF2GQAo7RPFrI7UgWUP0s327AJ6HW5guCFzGz9shhAdDeBDH9VxtlizQVyD5tb1m82L0JTJHczoKpCSARLnWyDpa8t4aFiXMv7qoDw=
Received: from AM4PR08CA0067.eurprd08.prod.outlook.com (2603:10a6:205:2::38)
 by HE1PR0802MB2489.eurprd08.prod.outlook.com (2603:10a6:3:d8::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2559.14; Tue, 24 Dec
 2019 17:34:55 +0000
Received: from AM5EUR03FT023.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::208) by AM4PR08CA0067.outlook.office365.com
 (2603:10a6:205:2::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2559.14 via Frontend
 Transport; Tue, 24 Dec 2019 17:34:55 +0000
Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT023.mail.protection.outlook.com (10.152.16.169) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.14 via Frontend Transport; Tue, 24 Dec 2019 17:34:55 +0000
Received: ("Tessian outbound e09e55c05044:v40"); Tue, 24 Dec 2019 17:34:55 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: c5c018cc780c467e
X-CR-MTA-TID: 64aa7808
Received: from bdd2edd0996c.13
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id E7E4FB5C-74A2-44E8-97CE-33F88B8EF429.1;
        Tue, 24 Dec 2019 17:34:49 +0000
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id bdd2edd0996c.13
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 24 Dec 2019 17:34:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fZ/x9HQP95ngnCj3aDhViIv8Cw82dEArBgifZBzDevWZtDuZHFkImPizPWh22j8KBI5ty4RGCcfg3tzL8XnjHyxcf3adDDZ+bf1Ko+5afabqbudquK6IRUfZq06Py+64owCUgtZ0oTfKIvv8K2Yj2Ebh4b3JnmhUB/OSYJ/wE5P0D680OhQe5LGmsDIHrlZG3yR5qDQ4jiHzubl9IGuKgt7x1Q5QgQTv7jgEflUZIfHf5g1MYV/DcaZppbWASDp5z+vQzoCdz5NISKm8ZJcf5F7xfVw7YnFO2FneaZG1s9SsODm6sMOpalVtCsxclzl+JKk3C0Ba3vOE7rlK38vDZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A/0zJrf0XLA5Sb326x6RiVHw/NRaNDEgL3SBCtwP5Uc=;
 b=DIQ7zQfd36eEiBaMbrCoRMDgmGlLznoltXMBGxlaGf/7zqQlHjt55/bnsm1TdG+ovWv/G+xi/PY/LlGHgPzFjwYiBnGu30ag5bRu2eP4K4+vr44KCQUqk+tFEA6qq3tNcDcVwkQkaWUMFgFhLeOduQPoO36X2YA9+R6kBkBvf39O0LsixbgFkm/AV2jUEnBWiHP3TUgu3EyXDpqtcODIst6DeSv+vFCaNGv64HE80I7iak6NRTSeaiQlBj5o5VNnOrc3XGpsGXFFsEyhsUmLYyPUycyLhPW8Fj1G65T2RjUmZeLSl8GToPLQrEGcwFQnyWi5JGVP1ahWwnmLxqHHrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A/0zJrf0XLA5Sb326x6RiVHw/NRaNDEgL3SBCtwP5Uc=;
 b=iyX2tu8ZBr+uKxvw1orgKBSywVv7JJkcmE1nBeHOvOJuy2nBMIkUH9YmWwVdkiHGbhwpdBF2GQAo7RPFrI7UgWUP0s327AJ6HW5guCFzGz9shhAdDeBDH9VxtlizQVyD5tb1m82L0JTJHczoKpCSARLnWyDpa8t4aFiXMv7qoDw=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB2672.eurprd08.prod.outlook.com (10.170.238.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.16; Tue, 24 Dec 2019 17:34:44 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::3d0a:7cde:7f1f:fe7c]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::3d0a:7cde:7f1f:fe7c%7]) with mapi id 15.20.2559.017; Tue, 24 Dec 2019
 17:34:43 +0000
From:   Mihail Atanassov <Mihail.Atanassov@arm.com>
To:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
CC:     Mihail Atanassov <Mihail.Atanassov@arm.com>, nd <nd@arm.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH v3 25/35] drm/bridge: tc358767: Use drm_bridge_init()
Thread-Topic: [PATCH v3 25/35] drm/bridge: tc358767: Use drm_bridge_init()
Thread-Index: AQHVuoBtcoOxVV09yUKPt+/sYYv9JQ==
Date:   Tue, 24 Dec 2019 17:34:43 +0000
Message-ID: <20191224173408.25624-26-mihail.atanassov@arm.com>
References: <20191224173408.25624-1-mihail.atanassov@arm.com>
In-Reply-To: <20191224173408.25624-1-mihail.atanassov@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [217.140.106.53]
x-clientproxiedby: LNXP123CA0023.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:d2::35) To VI1PR08MB4078.eurprd08.prod.outlook.com
 (2603:10a6:803:e5::28)
x-mailer: git-send-email 2.24.0
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: da67d389-e960-485d-c50b-08d788979716
X-MS-TrafficTypeDiagnostic: VI1PR08MB2672:|VI1PR08MB2672:|HE1PR0802MB2489:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0802MB2489F900C1F6C1E573F2BE698F290@HE1PR0802MB2489.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:376;OLM:376;
x-forefront-prvs: 0261CCEEDF
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(39860400002)(396003)(136003)(366004)(199004)(189003)(186003)(26005)(52116002)(6506007)(6486002)(81166006)(6512007)(81156014)(8676002)(8936002)(44832011)(54906003)(478600001)(316002)(6916009)(2906002)(4326008)(2616005)(36756003)(1076003)(66446008)(64756008)(66556008)(66476007)(66946007)(4744005)(5660300002)(71200400001)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB2672;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: miEMQwkbu6tN+vQF6GwVUJ6BXnM77jOqDJ/I5ufL7A8uVh2oe6pzJCjxBZHzpeSLrv6fW+g8vJ0z2tkF0kEbJoZOpe5HA6C5LXmr+xh2UTkaZ+nJvN+8IpWfaCi8NSVhZcNJG65052W2HkvPYfMClqRq1EzhQOJELHYY7exBlA1n4c7+zF0m4f1FefgOwE5Xef/wHfhSvknfoKEz49cBrpFxvnFXgTTNoVHAn4SNYosqyKJD3sm3qzgRHxWFqVQ2pqUk2zEJxzCMkUf+i5MqOnu/CB9yUwlE1difuPqTHH5tnc8Tdoqca6+pLfKabgN5WxnuOaK508ZCHWn6tk8uPlNHxbvbdztdF2GKlalCgiC6VmuSJuUYO99bVb42lQg51EfMB7cpLhG+APRAVNskrQuGh6ZtQk0IDAg2PjU8LL4sQfthOTHF8tyqzO1u2EGo
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB2672
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT023.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(376002)(396003)(346002)(199004)(189003)(26005)(36756003)(336012)(70586007)(186003)(76130400001)(356004)(6512007)(70206006)(26826003)(81156014)(54906003)(81166006)(6506007)(5660300002)(316002)(6486002)(2616005)(478600001)(107886003)(8936002)(4744005)(4326008)(8676002)(2906002)(86362001)(6862004)(1076003)(36906005);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0802MB2489;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Pass;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: af1d5dfb-2add-4d48-4f67-08d788979012
NoDisclaimer: True
X-Forefront-PRVS: 0261CCEEDF
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1GLzHvaMoiQCAeCXVu68Tjoq8wtUWrSnuQuwmToMN2bf99Xe/lGB9P4l0kLMAPF/VJzdkZLqnTDDrOnSzSEv/pvT+s3Rh4kZsGk4rrnOS1QEQrp4ho/6gV1nuvwdqCQoEIkdNmY32EW3vkF1rNQq1SfAINrQeeL2axPaEsy3imvtFs+WLwoG52VJO4AZmywyHlvvKay8bxxZG/4Iu3heW/1fRQSEidoMScwFxpdCavjhvIx2988L5Uht0k+TkTaeM49ImxKxtfyGIZZHSyYdGDYbyHl+qGtivVSuIN67wrRe2pgXLrvdiXtG6qXptvsQKPuINyGpRwYv7ELGzLII5vJYIFvChrJwRF7Q4FxWO4fBEg/gVFPm4e463yD8lhj1YzazVhBFivX6ejtXSJvsiKr2NVibiuJsFCKEvzyBFTMwPPX7kR/nSE7xA3/hJIYP
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2019 17:34:55.1935
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da67d389-e960-485d-c50b-08d788979716
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0802MB2489
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional change.

v3:
 - drop driver_private argument (Laurent)

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
---
 drivers/gpu/drm/bridge/tc358767.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc3=
58767.c
index ab1524c00777..7f60c6d85fb2 100644
--- a/drivers/gpu/drm/bridge/tc358767.c
+++ b/drivers/gpu/drm/bridge/tc358767.c
@@ -1671,8 +1671,7 @@ static int tc_probe(struct i2c_client *client, const =
struct i2c_device_id *id)
 	if (ret)
 		return ret;
=20
-	tc->bridge.funcs =3D &tc_bridge_funcs;
-	tc->bridge.of_node =3D dev->of_node;
+	drm_bridge_init(&tc->bridge, dev, &tc_bridge_funcs, NULL);
 	drm_bridge_add(&tc->bridge);
=20
 	i2c_set_clientdata(client, tc);
--=20
2.24.0

