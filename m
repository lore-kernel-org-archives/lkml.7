Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05882C2BC73
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 11:48:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB6812077B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 11:48:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="9OEguOUS";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="9OEguOUS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbfLDLsj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 06:48:39 -0500
Received: from mail-eopbgr50065.outbound.protection.outlook.com ([40.107.5.65]:19872
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727811AbfLDLsb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 06:48:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=277eEL94M2rHw20NJBX8K+BY/jR4YETRuPROMMFpHfU=;
 b=9OEguOUSXrUhree8CriPiY6s3c9MizKcJJ5E3NAkkGnfDoXiwPhbJ+eAeoTN+6AxpPey4UJSB1u5K1rF9vEHQxq1g4AxpAWnqP2L+KEU8PgqcYl6GVz4KCeBxNhLAkwDp7q02wHfwVV2xl3CwBZk7nkrb4nLGxFu9ttBZ8qYAzg=
Received: from VI1PR08CA0114.eurprd08.prod.outlook.com (2603:10a6:800:d4::16)
 by AM6PR08MB5111.eurprd08.prod.outlook.com (2603:10a6:20b:e9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2495.22; Wed, 4 Dec
 2019 11:48:27 +0000
Received: from DB5EUR03FT046.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::204) by VI1PR08CA0114.outlook.office365.com
 (2603:10a6:800:d4::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.12 via Frontend
 Transport; Wed, 4 Dec 2019 11:48:27 +0000
Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT046.mail.protection.outlook.com (10.152.21.230) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18 via Frontend Transport; Wed, 4 Dec 2019 11:48:27 +0000
Received: ("Tessian outbound 15590139dbb5:v37"); Wed, 04 Dec 2019 11:48:23 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: aff8d852d7b057c0
X-CR-MTA-TID: 64aa7808
Received: from cee6bfb0cd5a.3
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id BB0E1048-3CA9-4E60-8D8F-500B2DE3F9C6.1;
        Wed, 04 Dec 2019 11:48:17 +0000
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id cee6bfb0cd5a.3
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 04 Dec 2019 11:48:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i9Tzayu0YvEHowV76imO9YBN/LMc5dqfDtDz2qaN5rIvpeIHZyyRR57WhIsq1lfve5XZ2ERSiJ27b8UZa4rM3hHlUytJE+ZmK2NP3TJH/yhW6F2tejlPQA6ZBDNWD10mnL1pNWU8GzkZZW9BmvgwMQP/+dHvJcG0nX6l4Y+XUlFyYfjXCGcccDkMMbK8/x5Wy2JLt8dNRmueudt8JuF8X1kYlDfUOT3cWSg+I7ONV8E1jn+kvHFbFaYZqhUm8zOtkFEn4nvwWfgtLgIdJ9PmH0L00iVIdJpfu+3wG5YO/Kcy2fXGzBjz93FRpOZEvLTDdqUJFObtZqznz/yQlMJYVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=277eEL94M2rHw20NJBX8K+BY/jR4YETRuPROMMFpHfU=;
 b=iiMHoW838J6LdTs7mQpESHb/TRiEqFWC5zyIjyilj9T3hPwlCJN4moiv5mIvbk/4eE773QX+Ya9DdkfUI6TImaNmBesSeMwSdOaerKv/LcWQIFQB35c7+3E35qjD9AlulRYRlESJArjy7jKNK4CdcrBBpAieV2u0ZfCLrXAe7DFO3Ub780VVDOiQ2T7nuifvRDsUMr9TALrbYxYqvdz/KkuLa3SC8W/yipa/2i83n8OyA+FYsYcucbr4DSCtP6t8JvBCgG+V5P/mReeM07/7/8/rmtOJ9lg/OTgdyCDQmhgZCPMVOjHUN8r7llFSjhn1Y+zRX1gq2KcUio7prkFmhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=277eEL94M2rHw20NJBX8K+BY/jR4YETRuPROMMFpHfU=;
 b=9OEguOUSXrUhree8CriPiY6s3c9MizKcJJ5E3NAkkGnfDoXiwPhbJ+eAeoTN+6AxpPey4UJSB1u5K1rF9vEHQxq1g4AxpAWnqP2L+KEU8PgqcYl6GVz4KCeBxNhLAkwDp7q02wHfwVV2xl3CwBZk7nkrb4nLGxFu9ttBZ8qYAzg=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB3085.eurprd08.prod.outlook.com (52.133.15.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.19; Wed, 4 Dec 2019 11:48:15 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d%3]) with mapi id 15.20.2495.014; Wed, 4 Dec 2019
 11:48:15 +0000
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
        Sam Ravnborg <sam@ravnborg.org>,
        =?iso-8859-1?Q?Yannick_Fertr=E9?= <yannick.fertre@st.com>,
        Matt Redfearn <matt.redfearn@thinci.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 15/28] drm/bridge/synopsys: dsi: Use drm_bridge_init()
Thread-Topic: [PATCH v2 15/28] drm/bridge/synopsys: dsi: Use drm_bridge_init()
Thread-Index: AQHVqpi20m8UMeuMP0uFEkKVZse2Uw==
Date:   Wed, 4 Dec 2019 11:48:15 +0000
Message-ID: <20191204114732.28514-16-mihail.atanassov@arm.com>
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
X-MS-Office365-Filtering-Correlation-Id: 725e00c9-ec63-40d4-a6ef-08d778afe04b
X-MS-TrafficTypeDiagnostic: VI1PR08MB3085:|VI1PR08MB3085:|AM6PR08MB5111:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB51113D3104F4E2E6319FBEE98F5D0@AM6PR08MB5111.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:176;OLM:176;
x-forefront-prvs: 0241D5F98C
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(136003)(39860400002)(366004)(396003)(199004)(189003)(2501003)(1076003)(478600001)(4744005)(6436002)(6512007)(8936002)(6486002)(54906003)(44832011)(4326008)(316002)(50226002)(8676002)(5660300002)(2906002)(81156014)(81166006)(7416002)(6116002)(3846002)(66946007)(66476007)(66556008)(66446008)(64756008)(11346002)(186003)(2616005)(14454004)(52116002)(76176011)(99286004)(2351001)(25786009)(86362001)(26005)(5640700003)(6916009)(102836004)(71200400001)(305945005)(7736002)(71190400001)(6506007)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3085;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: W1f1kzgPQZHNASqNUNXsfvB/q+87dp0YqHKVJDkkMvQDuMaUXqPJ7jTznn94zseOZHWE3ZB7arcZP3jb3j5JhihF4LJq4+2HZGJHDmaBkmOhw5bYVU++QzV/Zg3lHGvgeS26fcoSGmA8O/0G0aDzDlTUxYYZELsRqSFQFV0gQVfIyLaFD5nV7ja0U4bRX+lSTBMc8gSL8+mf1VIgwT3E/xx4cGQAqdlBOXvWli+x4DAGyG5AOJVhrD1jicqaSOPTuFb81vMwbISHe+40YiQaUfjuflcDahZrMqE1ghAoOXpqXm+3afsId1PMwVwKzD4rcBKMco3Aw+FpT3gTINheKVcYurC5Q2yLeNOLTdFz9HwfegACW6Ex/oSYCXE1wL1qRtZrYzRfaZCQ1iwwoAqmAeBoHjrohkrNoMPwhU/ZxidZwY3KCA/0sFN9rScf3e4q
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3085
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT046.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(136003)(346002)(376002)(396003)(189003)(199004)(22756006)(70586007)(6506007)(7736002)(316002)(4744005)(99286004)(8746002)(11346002)(2616005)(50226002)(305945005)(76176011)(81166006)(26005)(336012)(5660300002)(76130400001)(8676002)(8936002)(356004)(1076003)(102836004)(14454004)(2351001)(6862004)(81156014)(6486002)(186003)(4326008)(70206006)(36756003)(86362001)(2501003)(25786009)(6512007)(478600001)(54906003)(2906002)(26826003)(6116002)(3846002)(50466002)(23756003)(5640700003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR08MB5111;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Pass;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 6daec329-5048-4b17-6dc6-08d778afd918
NoDisclaimer: True
X-Forefront-PRVS: 0241D5F98C
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AKinkxuaiAB3QtrHhZ7X6wnIB1eqytzdGjmOQ3ETPJ5FRUPCmMJp2W3QJmGIs/GXzjcVGZYDEcg1bmhkH7nYxexCy63tuyL0AnmZv1dbpeQq6I/3N0UTrY/eH90PrSD9sEoNKBPAISMt+YRVThbGEbsKlu31XWZQmmOLeQCURHyodT/U9j99JVFHH2Dqu+vwRjJN9OODgjCYIdEMtn/maDBhH5KbmgTpcI7ClHpQGQAxh/zp9vzyqREeJ0SVpjGe5bezbRO3wkgLYU5DSRi3GAuwF/73gWl3U3lNIudrJi5lJZuGTifv63Jsv4EHNO3rlBWb29bbsakvxbWvxJ+i0RFaBQxQQPwONzlDQzKciO/5HH7yQZx5GbvdJ681sYr15QuVgSMcCn0M1nGtDBzorzXqr+TqmD3QRoKwO6Xiwpgq/s84xRGEz1ix1fXpy4MO
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2019 11:48:27.3348
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 725e00c9-ec63-40d4-a6ef-08d778afe04b
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5111
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional change.

Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c b/drivers/gpu/dr=
m/bridge/synopsys/dw-mipi-dsi.c
index b6e793bb653c..051f9aaf5867 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
@@ -1052,11 +1052,8 @@ __dw_mipi_dsi_probe(struct platform_device *pdev,
 		return ERR_PTR(ret);
 	}
=20
-	dsi->bridge.driver_private =3D dsi;
-	dsi->bridge.funcs =3D &dw_mipi_dsi_bridge_funcs;
-#ifdef CONFIG_OF
-	dsi->bridge.of_node =3D pdev->dev.of_node;
-#endif
+	drm_bridge_init(&dsi->bridge, &pdev->dev, &dw_mipi_dsi_bridge_funcs,
+			NULL, dsi);
=20
 	return dsi;
 }
--=20
2.23.0

