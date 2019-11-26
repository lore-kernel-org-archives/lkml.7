Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E252C432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 13:16:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D825C2073F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 13:16:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="isZL5Hjp";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="isZL5Hjp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728214AbfKZNQt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 08:16:49 -0500
Received: from mail-eopbgr60040.outbound.protection.outlook.com ([40.107.6.40]:33101
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728139AbfKZNQj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 08:16:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ZaGqNH19yTAtwda+zKzHMpmANYqCLZgGbmyripuWOM=;
 b=isZL5Hjp6fmEIShdRNqbtk1s9m8jLA2hguCixE6wSSDDJn60D99TuI3OrOvIn/8q+eTkZlpYW2jia6G8fdTt89qlFlLsZCsNVBguxseQOR4GMGm+a0XW/KWEgeCZZUay7EE2G7G4w/ofc5J/lKClbL4X9uJeaPHMq4IopxvwDWY=
Received: from VI1PR08CA0100.eurprd08.prod.outlook.com (2603:10a6:800:d3::26)
 by AM6PR08MB3960.eurprd08.prod.outlook.com (2603:10a6:20b:ad::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2495.17; Tue, 26 Nov
 2019 13:16:36 +0000
Received: from DB5EUR03FT029.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::204) by VI1PR08CA0100.outlook.office365.com
 (2603:10a6:800:d3::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.17 via Frontend
 Transport; Tue, 26 Nov 2019 13:16:35 +0000
Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT029.mail.protection.outlook.com (10.152.20.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.17 via Frontend Transport; Tue, 26 Nov 2019 13:16:35 +0000
Received: ("Tessian outbound f7868d7ede10:v33"); Tue, 26 Nov 2019 13:16:32 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: aac1fcd0c00e6b7f
X-CR-MTA-TID: 64aa7808
Received: from ca8072fa316b.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.14.53])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id AB9D895B-6E73-4B15-BF4B-B77228907F38.1;
        Tue, 26 Nov 2019 13:16:27 +0000
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04lp2053.outbound.protection.outlook.com [104.47.14.53])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id ca8072fa316b.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 26 Nov 2019 13:16:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SlxdArcN4CwjBPfBGURSgQ9XQMCL8f2W4sA2xCZDbmK9aR6PtdQbywvU2Q022Dvp8K7/0c3lBKf6ppRccuyCUA35gDSQU16UpWJ9ZjVg75JwpXRphF2LTHuC7UkT00F/Sgx07RMjEF7HU5l2tjtVQuKeSQnSPj5Li5WpbkFKFqxLnvc+9R7wOKHPcjfXEmKYPHrJAjzQT5uHiYJtbyfI2IqtfCgI/VzAeepHhSD0KsStnAxLA3yXdY/n0ZeivYS2grwtHmDlkrsubi91oQdWWk9KiVf16+VPzkX8kRjpIoVpPt/c39nIuChi+79B3uoxs+8oJuGXlgQisnJEyg448A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ZaGqNH19yTAtwda+zKzHMpmANYqCLZgGbmyripuWOM=;
 b=laOOieiPnTczKtVdEHvPsv4apAfFMuK6NvrE0zuOM24pLBI3U0Bpf/wuOqPKU6WJKWSLl6oW93zP6zEmjq25hEeKtkZ4MIYd60UoUcR0GK2jEMfKTcJClUDuyucBHgA/lvjFN9ZNBCBwKWUu01VdoKQUpuSH22vvqMVYwQJ9YUxY/wATv6ia58g0YQX3Gs6ycferPIZpD5iCjSSmsz0IREi72NHYWZ9gOo1b+8tY7utNkbj+sBVe1swxvbfh/SLCDJqSlPajVUysCSGq+VXIU3OLVVv7V64IgkPKJ00vT9zYrldnoo/Fbf6pn+PtHAsF541bmBSb0ve6kIEpj0zmFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ZaGqNH19yTAtwda+zKzHMpmANYqCLZgGbmyripuWOM=;
 b=isZL5Hjp6fmEIShdRNqbtk1s9m8jLA2hguCixE6wSSDDJn60D99TuI3OrOvIn/8q+eTkZlpYW2jia6G8fdTt89qlFlLsZCsNVBguxseQOR4GMGm+a0XW/KWEgeCZZUay7EE2G7G4w/ofc5J/lKClbL4X9uJeaPHMq4IopxvwDWY=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB4317.eurprd08.prod.outlook.com (20.179.28.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.16; Tue, 26 Nov 2019 13:16:26 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d%3]) with mapi id 15.20.2474.023; Tue, 26 Nov 2019
 13:16:26 +0000
From:   Mihail Atanassov <Mihail.Atanassov@arm.com>
To:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
CC:     Mihail Atanassov <Mihail.Atanassov@arm.com>, nd <nd@arm.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Vincent Abriou <vincent.abriou@st.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 28/30] drm/sti: sti_vdo: Use drm_bridge_init()
Thread-Topic: [PATCH 28/30] drm/sti: sti_vdo: Use drm_bridge_init()
Thread-Index: AQHVpFu0SLTgMcz7kE2lTsCMHso8OA==
Date:   Tue, 26 Nov 2019 13:16:26 +0000
Message-ID: <20191126131541.47393-29-mihail.atanassov@arm.com>
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
X-MS-Office365-Filtering-Correlation-Id: 275764d4-fb7d-40c2-a6c2-08d77272dd26
X-MS-TrafficTypeDiagnostic: VI1PR08MB4317:|VI1PR08MB4317:|AM6PR08MB3960:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB3960524E69B87AD6393A05458F450@AM6PR08MB3960.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:376;OLM:376;
x-forefront-prvs: 0233768B38
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(1496009)(4636009)(39860400002)(366004)(346002)(376002)(136003)(396003)(189003)(199004)(5640700003)(86362001)(6512007)(71200400001)(2616005)(6486002)(71190400001)(2906002)(4326008)(6916009)(44832011)(446003)(11346002)(54906003)(66946007)(316002)(66446008)(64756008)(66556008)(66476007)(6436002)(4744005)(8936002)(186003)(26005)(5660300002)(102836004)(305945005)(14454004)(25786009)(99286004)(81166006)(50226002)(478600001)(2501003)(7736002)(6116002)(2351001)(76176011)(1076003)(52116002)(66066001)(256004)(5024004)(8676002)(81156014)(6506007)(3846002)(386003)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB4317;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: sGQjoHsgMzSRZQ/1K0IR2Stc7E/EtCzd339tCrDNQp8dS/llzJd8dfDqNI3h7VC7dS3kPk5lS7PC46XKJEJTvgO5yhbn5nqw4+ZMcAnITnKpFFE4pnW4WBQoC+wWmtFwhChYjTVjG7HT+2099uakDaC58Y3I0COEMA6iem/E1AOg8uF2/E6HP9xqubyo93+2oqHpxOk+5anBCZ8ywQ/l08K4GfYFiYDIgK0CPF/C+YU9N00Y9xzgYBWkas/MYgcUw6N4oWNQosw+kZqCRZqYKiYCoVpLiz9SNmdZc03y/7fpeRdckAhNs9PTDRjuKnLbtgpQnqRF7QwncwSSYy+peTyigjZ3b/fd+SB05WSt7QyqksIhVHtYSm4Otog9zndWtMruYkGfBZVkAT/8OwcPy23JWX+k1pJHVa0JwsjoS7UhKKCbfGvZOa/Ah6ligOq8
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4317
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT029.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(136003)(346002)(376002)(396003)(199004)(189003)(5660300002)(305945005)(2501003)(2906002)(50226002)(66066001)(7736002)(99286004)(26826003)(14454004)(186003)(316002)(25786009)(22756006)(54906003)(478600001)(106002)(102836004)(386003)(6506007)(47776003)(50466002)(26005)(36756003)(4744005)(76176011)(23756003)(4326008)(336012)(86362001)(81156014)(81166006)(5640700003)(6486002)(6512007)(2351001)(446003)(11346002)(2616005)(6862004)(76130400001)(5024004)(70206006)(70586007)(8936002)(3846002)(6116002)(356004)(8746002)(8676002)(1076003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR08MB3960;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Pass;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 0031a196-eeaf-4416-a93a-08d77272d730
NoDisclaimer: True
X-Forefront-PRVS: 0233768B38
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3C/BUffI5lEDX+zWKWXaHnK2ycTm576J3IKJXl7TdemBcs3L4dWhJ0M/+greZYkICpyBfB9mg9ZI5vG98Tucvif5+fHgW6CvovTe5J931rSJn35+1Le/Y0yZvC7+WnGvN18QxAuH/tPUYMf3sWtwVBH0/7Z3m234dw8NUpi0qDD0489nhFItrLLP4iNOD6zfqjlU1VCt8XLIQqIEmQO/4yG0h5xIUCuKz5nw9JGG4qzYXM7Z0gZd85yZr2rZTjO665UZmNgftOD9fFsedlJe7N3MqdPWTZSikkx/yui2RsylCqq0HUjixtezsFrMZKdiirT6EgUWvWdyxuZQJQGtWcd/aeOLKur5rxRWz7KLLB97SQ0SUiGvuTkJ5fiYy05u7bVc0lgzrznP22jWCSTkOUBCRcmK32vvQJpblq+spS10+4zvYAic8bIQH1BKBOHS
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2019 13:16:35.7800
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 275764d4-fb7d-40c2-a6c2-08d77272dd26
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3960
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional change.

Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
---
 drivers/gpu/drm/sti/sti_dvo.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/sti/sti_dvo.c b/drivers/gpu/drm/sti/sti_dvo.c
index 68289b0b063a..20a3956b33bc 100644
--- a/drivers/gpu/drm/sti/sti_dvo.c
+++ b/drivers/gpu/drm/sti/sti_dvo.c
@@ -462,9 +462,7 @@ static int sti_dvo_bind(struct device *dev, struct devi=
ce *master, void *data)
 	if (!bridge)
 		return -ENOMEM;
=20
-	bridge->driver_private =3D dvo;
-	bridge->funcs =3D &sti_dvo_bridge_funcs;
-	bridge->of_node =3D dvo->dev.of_node;
+	drm_bridge_init(bridge, &dvo->dev, &sti_dvo_bridge_funcs, NULL, dvo);
 	drm_bridge_add(bridge);
=20
 	err =3D drm_bridge_attach(encoder, bridge, NULL);
--=20
2.23.0

