Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ABA7C432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 13:17:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 506D82071E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 13:17:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Uf+LCmyp";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Uf+LCmyp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728307AbfKZNR1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 08:17:27 -0500
Received: from mail-eopbgr60088.outbound.protection.outlook.com ([40.107.6.88]:3649
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728106AbfKZNQe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 08:16:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1DpZqtyyKVj6Kcjcgie43kZcxVAkBsJ624+DdPaI1+U=;
 b=Uf+LCmypiVOATtAtYZBxWOwk5Q5N8mEWy83Pc22UotkN9beM3Ri7Wq+5G8GQ3u9cWq28QwLhpLm61IrHYzIhPVQmXjXDaABBdVPowzjCMASzmSX2vyag2/UFSSkTn7oVyYmnnggu5e1ZuzTXxAOBTfjoH9LpZELbD4CIQViq7AA=
Received: from AM4PR08CA0049.eurprd08.prod.outlook.com (2603:10a6:205:2::20)
 by AM0PR08MB3107.eurprd08.prod.outlook.com (2603:10a6:208:60::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.19; Tue, 26 Nov
 2019 13:16:30 +0000
Received: from AM5EUR03FT062.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::203) by AM4PR08CA0049.outlook.office365.com
 (2603:10a6:205:2::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2495.17 via Frontend
 Transport; Tue, 26 Nov 2019 13:16:30 +0000
Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT062.mail.protection.outlook.com (10.152.17.120) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.17 via Frontend Transport; Tue, 26 Nov 2019 13:16:30 +0000
Received: ("Tessian outbound 712c40e503a7:v33"); Tue, 26 Nov 2019 13:16:28 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: e28e9e5fee13d3ba
X-CR-MTA-TID: 64aa7808
Received: from 223e0bbf9727.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.14.59])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 636165A2-C54B-402C-8EC5-9B0BB4C9163C.1;
        Tue, 26 Nov 2019 13:16:23 +0000
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04lp2059.outbound.protection.outlook.com [104.47.14.59])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 223e0bbf9727.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 26 Nov 2019 13:16:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IDQe9v0/w2uX3ZHhUu+UICIcaDS0/jntibpXvW9lY5/YlPX2XyMWVa3q0IHK5P+zD/lczMbgDqNOYi29n4tHdiUpe5RR1b9aUE+TZlwgjZDpLxVchkUVspbslqUqdhlkgSgwRxDLxcOs4GmfUf3yWtFz5IEMemlmTZSx3bi2JBvMrh+V3u6O+hNvvCZgqieVjD3cnqGoKQTcEO4rrw4YVGetxqFcIG83pRbkt+kv8Gdot29gPfmioMRqu4XAgFeGNW8YCcDjTlLrO0tm2hQmgu9tPc6BKgyta3ZxergGDmHtleOjaD4MZ2a/fFYUOtXilGXAjc+gma3KGN2HlEaQ9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1DpZqtyyKVj6Kcjcgie43kZcxVAkBsJ624+DdPaI1+U=;
 b=Hbyq1QI2XeKHujzGC9KWc8zKbnIGsunVQfzRF+mTgpn4AJhC2iy5m6xtuOraxT0WAuq9cXDrr/h8wD9WB/aAiBwOlEQqmYM211W9i9HIiKNTnoh7pSLLtBd2h9CJ6O5xYPFl9OGGTJo+m79AVhic1Kez5trrd4gIcQxkAZCx21h+bX4aGKCc0MxZQLSVxMtlsVlqDFR9JQBJpWOWMrhgJbVq75IhCBSZ2R7SRU8+22PshDlC+QyZatGKFHLlhUD1s2rJtlzFFDMG0XjtyMNnVy7aakMX33Z0Y2EiKHHdMrthK4dHIJ+AXmy7WAlQAjSSdntNZ08q92amelvLK4pOpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1DpZqtyyKVj6Kcjcgie43kZcxVAkBsJ624+DdPaI1+U=;
 b=Uf+LCmypiVOATtAtYZBxWOwk5Q5N8mEWy83Pc22UotkN9beM3Ri7Wq+5G8GQ3u9cWq28QwLhpLm61IrHYzIhPVQmXjXDaABBdVPowzjCMASzmSX2vyag2/UFSSkTn7oVyYmnnggu5e1ZuzTXxAOBTfjoH9LpZELbD4CIQViq7AA=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB4317.eurprd08.prod.outlook.com (20.179.28.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.16; Tue, 26 Nov 2019 13:16:21 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d%3]) with mapi id 15.20.2474.023; Tue, 26 Nov 2019
 13:16:21 +0000
From:   Mihail Atanassov <Mihail.Atanassov@arm.com>
To:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
CC:     Mihail Atanassov <Mihail.Atanassov@arm.com>, nd <nd@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 23/30] drm/i2c: tda998x: Use drm_bridge_init()
Thread-Topic: [PATCH 23/30] drm/i2c: tda998x: Use drm_bridge_init()
Thread-Index: AQHVpFuytOzD+HDrhUWMxCyybPn/Ag==
Date:   Tue, 26 Nov 2019 13:16:21 +0000
Message-ID: <20191126131541.47393-24-mihail.atanassov@arm.com>
References: <20191126131541.47393-1-mihail.atanassov@arm.com>
In-Reply-To: <20191126131541.47393-1-mihail.atanassov@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [217.140.106.55]
x-clientproxiedby: LO2P265CA0453.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:e::33) To VI1PR08MB4078.eurprd08.prod.outlook.com
 (2603:10a6:803:e5::28)
x-mailer: git-send-email 2.23.0
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 416a2504-1ad7-427b-7853-08d77272d9fd
X-MS-TrafficTypeDiagnostic: VI1PR08MB4317:|VI1PR08MB4317:|AM0PR08MB3107:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM0PR08MB310735973053D71C36B3BF428F450@AM0PR08MB3107.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:176;OLM:176;
x-forefront-prvs: 0233768B38
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(1496009)(4636009)(39860400002)(366004)(346002)(376002)(136003)(396003)(189003)(199004)(5640700003)(86362001)(6512007)(71200400001)(2616005)(6486002)(71190400001)(2906002)(4326008)(6916009)(44832011)(446003)(11346002)(54906003)(66946007)(316002)(66446008)(64756008)(66556008)(66476007)(6436002)(4744005)(8936002)(186003)(26005)(5660300002)(102836004)(305945005)(14454004)(25786009)(99286004)(81166006)(50226002)(478600001)(2501003)(7736002)(6116002)(2351001)(76176011)(1076003)(52116002)(66066001)(256004)(8676002)(81156014)(6506007)(3846002)(386003)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB4317;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: itY43bm3CXp2OL9QAjnj7+0ohgrj6ZStZVkPUfL3ITn+0ylAQj3POqvzIyV05/SujjeZhfSTrIr5WnEnRKd6TM2t3fUeJkePhQiLSqHQTOaHwQX45GEISLraWtzpg27UHnDV7zsNFqtmuYB+7weHr5p0Ar9VYggxnjdf3CFey/bhF0u3OSAscmnZcb7sNQOZTTpSAbRG3G8oBoLGe5HDik8mgdun5GY3kWSja1pQxujQ7wP6xMXUtr+357+sBy1mCx9kbN4c44JJ+Wzo4Z6woaEAqrVA31K3UWmTaF2OZPI4035djolbfT0JaXi514vmJkkYHoamTX1xDto11nOyoGtqAVOBvovmocbmKWXBnK2S3cPCT+whxuJhgbzXqxSCyqVqm1jFntQhvrvjY3z+i03gc1KOEr/tc9AMwFQCyOVb5bP7iQvmkdK1hYyiEZ+1
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4317
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT062.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(136003)(376002)(346002)(199004)(189003)(50466002)(66066001)(8746002)(8676002)(76176011)(81166006)(81156014)(47776003)(356004)(446003)(186003)(2501003)(305945005)(386003)(26005)(36756003)(6116002)(3846002)(102836004)(2906002)(50226002)(22756006)(8936002)(1076003)(478600001)(6512007)(6486002)(5640700003)(25786009)(106002)(54906003)(76130400001)(316002)(4326008)(6506007)(36906005)(2351001)(23756003)(86362001)(2616005)(336012)(11346002)(26826003)(6862004)(4744005)(5660300002)(70586007)(70206006)(7736002)(99286004)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB3107;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Pass;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 8c16d75b-a447-43af-b585-08d77272d48b
NoDisclaimer: True
X-Forefront-PRVS: 0233768B38
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: so6iteMdJgPSD33gMxn9nGn4ut0OBmYD9QNiuSnFLEmkqfbOfSmSGFChBXI0TSaZ69GoGVQvu73oSfOnTGD1E7wYjMdfQ+2jWLhWL7s+CfwnGE0w+HluK5gMTdONgVrctUHfl0U05ySmSPH4IxoVmJvcSF+TpEERI0JNR5Fvt/Q49PYalSHjNDR0XvMSn1fjYtTFsRAGH1FbljlEMbUa4ri0S8GFkVL0YleQphmEJSgzm1+ngC0Oa5ts+/MjjZtsvbqC0sjwiqht9E9IH9P2JEbLhuc4I45He3amdCSMbv0278Q9tVwiOofkmtGWyf0YBOEp6PWA8+WxNSHWoubUzrQVKk02kNICJ5MVuPUdZzkrVUt9TitG4nFHYksKmMRj2B3NKTKheJrkgGGJ46fxh/w1GdRDMXv8oKNYnVFqBw08zuA4pkfkldKFNk1Z32so
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2019 13:16:30.4729
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 416a2504-1ad7-427b-7853-08d77272d9fd
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3107
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional change.

Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
---
 drivers/gpu/drm/i2c/tda998x_drv.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998=
x_drv.c
index a63790d32d75..f7dfa694aff7 100644
--- a/drivers/gpu/drm/i2c/tda998x_drv.c
+++ b/drivers/gpu/drm/i2c/tda998x_drv.c
@@ -1974,11 +1974,7 @@ static int tda998x_create(struct device *dev)
 			goto fail;
 	}
=20
-	priv->bridge.funcs =3D &tda998x_bridge_funcs;
-#ifdef CONFIG_OF
-	priv->bridge.of_node =3D dev->of_node;
-#endif
-
+	drm_bridge_init(&priv->bridge, dev, &tda998x_bridge_funcs, NULL, NULL);
 	drm_bridge_add(&priv->bridge);
=20
 	return 0;
--=20
2.23.0

