Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE86AC43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 11:48:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7018220659
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 11:48:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="c9jMVbTc";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="c9jMVbTc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727810AbfLDLs1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 06:48:27 -0500
Received: from mail-eopbgr30062.outbound.protection.outlook.com ([40.107.3.62]:2909
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727769AbfLDLsV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 06:48:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E+gIcXwMEpaWbNQmu/uXel91VQjEKWqcp2Xv7hI8VDc=;
 b=c9jMVbTc0lbvCjlCdGsj/BZ0F7HpLPRahzoWiifeiZgKgdL+hAe0vaZyYvRhKVxyiboMOsgY77DyeyVqb3Qahzl25A/ix3lgDdsdjSCX5E9uhC4NowkZQf05kLhBK4uMkIVtupiFp364uPC5Os3y4He4Nfg9Al8QPTNRfcRn6H8=
Received: from VI1PR08CA0220.eurprd08.prod.outlook.com (2603:10a6:802:15::29)
 by AM6PR08MB3301.eurprd08.prod.outlook.com (2603:10a6:209:47::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2495.22; Wed, 4 Dec
 2019 11:48:18 +0000
Received: from AM5EUR03FT033.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::206) by VI1PR08CA0220.outlook.office365.com
 (2603:10a6:802:15::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.12 via Frontend
 Transport; Wed, 4 Dec 2019 11:48:18 +0000
Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT033.mail.protection.outlook.com (10.152.16.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18 via Frontend Transport; Wed, 4 Dec 2019 11:48:17 +0000
Received: ("Tessian outbound 92d30e517f5d:v37"); Wed, 04 Dec 2019 11:48:15 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 4ece2eb33055af6f
X-CR-MTA-TID: 64aa7808
Received: from a83b0422c187.4
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id FAFB5E4E-1174-4539-8B17-A85DE494B0F6.1;
        Wed, 04 Dec 2019 11:48:09 +0000
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id a83b0422c187.4
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 04 Dec 2019 11:48:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hsNUgPB5be3q+u2kjNpYqyOrjh19A+ZBQOk0vFj1jOjwjc+rFqk3gsLY8pwGubavO2igxfgeZVe8UVSpS3abFXdWPBSG6LBY9yv8kHtTutj87WHgusFlK20+kRTevLEgz1elLRZPiRUYKKvBC6jRGSXi9iuXBv5X5f6hfoGrhEmy1yw9ZRAJMYNH1XAqtaXxYiOWHh10eZ+B9wNIt64unWBrY30lpnOX4uYB9JfORZPubFHh5NjrFSMe9GNTCfo21WPf6CIk2EpAh1SlOa8Tr61nMwXMeqwsSM6JrhlZ8eK5bhZ5TJ0tzrzlxw1K0AMb7RNHMlJWd5amVWnjw00/Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E+gIcXwMEpaWbNQmu/uXel91VQjEKWqcp2Xv7hI8VDc=;
 b=eZmAWafuGxFKmDTVIuTq11MmpOQhk+m1lNBV8j53GX9aIzaoOgJ8NMjgC3T+fdq287nGaeVpo9CLVldltmntr8yjNcXjg8Bd4L0xCC2Su/MvV6xBUCv80UxrAP++MAeyKq0Ce98hFv0/7uMTZyZVfT9o6n0rU73OFQxYh+aBgqRDCSZHrgw1rfCNvkgZT/pmrXeddp7EmUffN9qe25uPeFAKoTF7tqkVogeeMjsVwAOQm6ZYSP13dPtsHodA+F6pJ6mA0nspc3woWUvlpgk+I44A3ujqMdNYhAtiPMp76uLsakwxpk2MIMw/bgzX7TJe4vpL2FRptQni9GYQyHqsHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E+gIcXwMEpaWbNQmu/uXel91VQjEKWqcp2Xv7hI8VDc=;
 b=c9jMVbTc0lbvCjlCdGsj/BZ0F7HpLPRahzoWiifeiZgKgdL+hAe0vaZyYvRhKVxyiboMOsgY77DyeyVqb3Qahzl25A/ix3lgDdsdjSCX5E9uhC4NowkZQf05kLhBK4uMkIVtupiFp364uPC5Os3y4He4Nfg9Al8QPTNRfcRn6H8=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB3085.eurprd08.prod.outlook.com (52.133.15.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.19; Wed, 4 Dec 2019 11:48:07 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d%3]) with mapi id 15.20.2495.014; Wed, 4 Dec 2019
 11:48:07 +0000
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
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 06/28] drm/bridge: lvds-encoder: Use drm_bridge_init()
Thread-Topic: [PATCH v2 06/28] drm/bridge: lvds-encoder: Use drm_bridge_init()
Thread-Index: AQHVqpixLTYeoXxq3k24Lvd2CHXKqA==
Date:   Wed, 4 Dec 2019 11:48:07 +0000
Message-ID: <20191204114732.28514-7-mihail.atanassov@arm.com>
References: <20191204114732.28514-1-mihail.atanassov@arm.com>
In-Reply-To: <20191204114732.28514-1-mihail.atanassov@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [217.140.106.55]
x-clientproxiedby: LNXP265CA0055.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5d::19) To VI1PR08MB4078.eurprd08.prod.outlook.com
 (2603:10a6:803:e5::28)
x-mailer: git-send-email 2.23.0
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a1f62486-2cfe-4875-9963-08d778afdaa3
X-MS-TrafficTypeDiagnostic: VI1PR08MB3085:|VI1PR08MB3085:|AM6PR08MB3301:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB3301C1E51083186A316ADDB48F5D0@AM6PR08MB3301.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:6790;OLM:6790;
x-forefront-prvs: 0241D5F98C
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(136003)(39860400002)(366004)(396003)(199004)(189003)(2501003)(1076003)(478600001)(4744005)(6436002)(6512007)(8936002)(6486002)(54906003)(44832011)(4326008)(316002)(50226002)(8676002)(5660300002)(2906002)(81156014)(81166006)(6116002)(3846002)(66946007)(66476007)(66556008)(66446008)(64756008)(11346002)(186003)(2616005)(14454004)(52116002)(76176011)(99286004)(2351001)(25786009)(86362001)(26005)(5640700003)(6916009)(102836004)(71200400001)(305945005)(7736002)(71190400001)(6506007)(36756003)(5024004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3085;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 5WwEJXi/rYpSxmxs9WPWYjLnVWnXyrs7wSFhsXfqqn+TINeuLsOYM7hf2l8Mg+AzWB+7iEaEhdyv7gRanHEXNn+Iqc8KcfrqnbVRpDeCIAtEPlbR+CEkFkydgSeGRz0asM0FWkyj+stN5P2wUjh0HONL6RO/kXYuLpph8wQyjkex+kbE83aUPI13EBN982G2KYyCtXZ52Ibv1qZLc0UD3vVsoUDDibUGAW9HXDLpmtfTF0wQ9GeEjFHa+Q84TyFXbJl+GsU6zOhJDUR0A5jF3LpLSw86rIx6sK6qmh40WRXpId0h3CuwTdN768pSrHE4vU1VMlBe8kh3krjlmlrwYnqxmON4BZtRxHa5gQP3x3OmCAAGQcD7rnelpedZyYw3L+ET+eR2N83P/vaSHr4IDptsPpxfILGJ76LCjMOi7Qe7mKwWpK0tFSEVq2wenQ+f
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3085
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT033.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(396003)(39860400002)(136003)(189003)(199004)(86362001)(316002)(8746002)(8676002)(356004)(3846002)(81166006)(81156014)(4326008)(26826003)(6862004)(76176011)(478600001)(186003)(5024004)(7736002)(11346002)(99286004)(36906005)(25786009)(2616005)(305945005)(14454004)(8936002)(6506007)(102836004)(50226002)(54906003)(26005)(1076003)(2906002)(336012)(6512007)(5640700003)(22756006)(50466002)(70586007)(2351001)(6116002)(5660300002)(6486002)(2501003)(36756003)(23756003)(76130400001)(70206006);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR08MB3301;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Pass;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 34f5fbeb-c1a6-4b40-8db5-08d778afd434
NoDisclaimer: True
X-Forefront-PRVS: 0241D5F98C
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1M17V7hLXaU2Vzlzi+bTxJMIvv00SqnLCBqRd7PehcCZr4iLjD/wQYiK3IEWfrw1qOmQzs4SyfGOSuM/8OSI6CQXPWJbU3RsF1ufijSlIUuoBQnvbp61CMcVRBB8OvwuCZjxIdp2Dk17pyFEsQUFRs2VId9nZtPxgRWyZivt+LfX3doM52QrlgMFwrRg7H4rIdD/JqIgphPEi8k9Q/HFHbnBGbBJkAo+dvI8XVUHoJDeNawxOImXzsndKutCUzAskZsATMRiedvJpxTKn0tJ9+1MxlVT+3qB/N7Mew5D/ht+fIn9mGiV/rCvUu7ydzGDqFxjSSIl7aevE2LNsTuQNNDjEUEtBWiZSQn25jRvBO7DeNX2lq8BdoNhPVkokzLKurO9r/AitS1U5uQVeHbEYHR4DXXeOquX8cIg3yppEEz0iVROPxYodTa52ShEttSX
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2019 11:48:17.8408
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1f62486-2cfe-4875-9963-08d778afdaa3
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3301
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional change.

Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
---
 drivers/gpu/drm/bridge/lvds-encoder.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/bridge/lvds-encoder.c b/drivers/gpu/drm/bridge=
/lvds-encoder.c
index e2132a8d5106..155406510416 100644
--- a/drivers/gpu/drm/bridge/lvds-encoder.c
+++ b/drivers/gpu/drm/bridge/lvds-encoder.c
@@ -112,11 +112,10 @@ static int lvds_encoder_probe(struct platform_device =
*pdev)
 		return PTR_ERR(lvds_encoder->panel_bridge);
=20
 	/* The panel_bridge bridge is attached to the panel's of_node,
-	 * but we need a bridge attached to our of_node for our user
-	 * to look up.
+	 * but we need a bridge attached to our of_node (in dev->of_node)
+	 * for our user to look up.
 	 */
-	lvds_encoder->bridge.of_node =3D dev->of_node;
-	lvds_encoder->bridge.funcs =3D &funcs;
+	drm_bridge_init(&lvds_encoder->bridge, dev, &funcs, NULL, NULL);
 	drm_bridge_add(&lvds_encoder->bridge);
=20
 	platform_set_drvdata(pdev, lvds_encoder);
--=20
2.23.0

