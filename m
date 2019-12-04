Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA096C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 11:48:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CFE120862
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 11:48:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="BFOVFa+R";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="BFOVFa+R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727908AbfLDLsp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 06:48:45 -0500
Received: from mail-eopbgr80047.outbound.protection.outlook.com ([40.107.8.47]:26374
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727815AbfLDLsc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 06:48:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pok0SSk5Bh8w7qG9tzg8paAi0CtuxpzJ5qzAThY9f2U=;
 b=BFOVFa+RmEEICPsBCDlSSQqRbWaZhg1hEKmlKXAVfczokPPPCq2YeI7ea6JK5MUtdAyC08QdTV6uvf+VzlSL8FlETpwKm0IjrxRA6mg7ATFcWtvdVbpYzgU8hjR9FKW711Ma3qoT9JCydXcG0Y/lMc6o4RU/dy1VfTAkSqbgXJ8=
Received: from VI1PR0801CA0074.eurprd08.prod.outlook.com
 (2603:10a6:800:7d::18) by VI1PR08MB3536.eurprd08.prod.outlook.com
 (2603:10a6:803:79::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2495.22; Wed, 4 Dec
 2019 11:48:28 +0000
Received: from AM5EUR03FT025.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::207) by VI1PR0801CA0074.outlook.office365.com
 (2603:10a6:800:7d::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.12 via Frontend
 Transport; Wed, 4 Dec 2019 11:48:28 +0000
Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT025.mail.protection.outlook.com (10.152.16.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18 via Frontend Transport; Wed, 4 Dec 2019 11:48:28 +0000
Received: ("Tessian outbound 691822eda51f:v37"); Wed, 04 Dec 2019 11:48:19 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 59c96d7852f471fc
X-CR-MTA-TID: 64aa7808
Received: from c7e01adb9f43.3
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 5D48E4D9-3BC3-41A5-BAAA-9061C9E30BEF.1;
        Wed, 04 Dec 2019 11:48:14 +0000
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id c7e01adb9f43.3
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 04 Dec 2019 11:48:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NIFXnTjKWQLsH0BJcJOktvXQUjheEWFeUoBH7eN3xjvv8OMvDfIVSMm1Iw0f3MxMTlhMkZAjp/wb/r425OUlrn7sv3lRFYhxt7nDaqxyFgsRgrXglHHiaWh7EvBGHRPF1TdH67XkhFEFiRWvx8Bv7liS51LFZbznoPgVa4g0ieRb7lchqkQCpPzmahq2c+MqV6Y6yLFSUcx87SxOHlLSQNKavVE9B5TWowfBNW2Gj2tqlC+gE4f0Z8KOyo1VlJzReGoVbvCS7S1/+pDk81oHkq1dpR5B/khbXKkhQF8Xefx46gFNZ4UnTJHzTpqeBHKou6xB6KwXzOWOc6KgRqmLaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pok0SSk5Bh8w7qG9tzg8paAi0CtuxpzJ5qzAThY9f2U=;
 b=G535EVc/j2HQhiJielD7IBiiBuJcE6stNczH8MXmvBNMIalGSxFgzVwsnBpCM/V2ALh1skal10OlRVFRUBza8BaMeuihyP3cyy0cvqzzhVAGq3hWfMB59Te54EoI2RLCqfxD9yRfmP5iLnP8Oft9NiIxX0+TWiEdTnyW0k1RO8bjdathgkkyqHM9LCpWiDDbnlkF/BbIAZx+vqSj39+uRHVIXcgT6/RldngO2tEWa/xMb7WEm3E7f1ab2NAo4XFIaYcX/4bLYDH1pJ3Q66g6BqIMzXRqjxIJliALn6C1/W9q32jla4KR6AN9eclpHP6IjO4NoUSVIiPniZcmyXdXlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pok0SSk5Bh8w7qG9tzg8paAi0CtuxpzJ5qzAThY9f2U=;
 b=BFOVFa+RmEEICPsBCDlSSQqRbWaZhg1hEKmlKXAVfczokPPPCq2YeI7ea6JK5MUtdAyC08QdTV6uvf+VzlSL8FlETpwKm0IjrxRA6mg7ATFcWtvdVbpYzgU8hjR9FKW711Ma3qoT9JCydXcG0Y/lMc6o4RU/dy1VfTAkSqbgXJ8=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB3085.eurprd08.prod.outlook.com (52.133.15.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.19; Wed, 4 Dec 2019 11:48:12 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d%3]) with mapi id 15.20.2495.014; Wed, 4 Dec 2019
 11:48:12 +0000
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
Subject: [PATCH v2 12/28] gpu: drm: bridge: sii9234: Use drm_bridge_init()
Thread-Topic: [PATCH v2 12/28] gpu: drm: bridge: sii9234: Use
 drm_bridge_init()
Thread-Index: AQHVqpi1nuxUXRNmNkWRvMMZxB0aZQ==
Date:   Wed, 4 Dec 2019 11:48:12 +0000
Message-ID: <20191204114732.28514-13-mihail.atanassov@arm.com>
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
X-MS-Office365-Filtering-Correlation-Id: cd32b5dd-74aa-4ba6-efc4-08d778afe0c7
X-MS-TrafficTypeDiagnostic: VI1PR08MB3085:|VI1PR08MB3085:|VI1PR08MB3536:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <VI1PR08MB3536605429F94BA55F3FF1FC8F5D0@VI1PR08MB3536.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:949;OLM:949;
x-forefront-prvs: 0241D5F98C
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(136003)(39860400002)(366004)(396003)(199004)(189003)(2501003)(1076003)(478600001)(4744005)(6436002)(6512007)(8936002)(6486002)(54906003)(44832011)(4326008)(316002)(50226002)(8676002)(5660300002)(2906002)(81156014)(81166006)(6116002)(3846002)(66946007)(66476007)(66556008)(66446008)(64756008)(11346002)(186003)(2616005)(14454004)(52116002)(76176011)(99286004)(2351001)(25786009)(86362001)(26005)(5640700003)(6916009)(102836004)(71200400001)(305945005)(7736002)(71190400001)(6506007)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3085;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 7fP5YXDXUh3a+y67F8ckezTnsjy4i//b/OcxVdH9S5K+cwz4brcpKYcrdN0Rj2FR2XNcvKcMM9iBmPtx+1vOhNdBOZFjKEO+dj3euFJPu2jPJjr9cHs63Y+yl0IRw0raFA8WPv+Tj/VKL1Jz5n6vEDAUNMAGU7afR6kEbWqGE8jbuY72+lAOlvW8plJNz1wqt71tSTDdNl/aqReYL4E+72YPmJ3oqY19abWTUcG9bN3/nR9VophGAmULUadSd9U4pE1j++3HhDd/Rk2HQAUSQlFO3lXMoSDnfmAstb8OmJ9W4AL3va7n1cnkRRy/j9/eLRYQPd7m9Y+3gtu/WZfxEZQzmbH4nBhBvJdlUfyP/6hSP6iez9j8DyRQ+hHZbKId3zCJYtVYq6uwKCA3lPE7rPrBznDimRW0iu//fBSYTMhOC/SDyOZcwPu/V7OCF3It
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3085
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT025.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(376002)(39860400002)(136003)(346002)(396003)(199004)(189003)(8746002)(356004)(2616005)(6862004)(1076003)(86362001)(8936002)(6512007)(22756006)(4326008)(5640700003)(76176011)(36906005)(6506007)(26826003)(478600001)(102836004)(99286004)(26005)(2351001)(36756003)(81166006)(186003)(25786009)(11346002)(336012)(54906003)(70586007)(50466002)(81156014)(3846002)(305945005)(8676002)(316002)(7736002)(23756003)(70206006)(6486002)(2501003)(6116002)(5660300002)(14454004)(2906002)(4744005)(76130400001)(50226002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3536;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Pass;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 3aba484f-67f7-45d6-bcdc-08d778afd75b
NoDisclaimer: True
X-Forefront-PRVS: 0241D5F98C
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nfa4xb+1dR2SaxkEck+VMOWa88MdK8lK9cwI5/ft13w3fMX/sI1dLCNNKjkeESjean6kbRw+4+GGZJgIcT8tC1VDA6cIF/xB9hKxQgRGYeatAd5yFWsyJaEfhiy3QAZ/vPQVavP5DaJnLXcsSPMXVz9cbHcCLh3C4VYUDH4vZU7iFy5T+KVmdrm2+lORwqx8nvXnUAsSgiGwiE2QJhPPAR/fd7JkW+ZFqMmtpYhhZS2EQ8ro2qULEasBORSOsa0DCCGP49BiNbJtpZqVQAl75KPQOkkKJvkSe6c0Hkri/kUD1qf/Y6rm2d6mASYZ9vUimG/uZyRUfhljptnxmx+FR30LUnhdyGprm7S96OzYT/2dXJuza7Q4fRKdLt5TXG3GrFgo1jUT1RokGz4w249JWHVTHM+lQLWEnJcGdRyGNiKOWJ/JQvIWAtG2PldtPCaw
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2019 11:48:28.1253
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd32b5dd-74aa-4ba6-efc4-08d778afe0c7
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3536
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional change.

Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
---
 drivers/gpu/drm/bridge/sii9234.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/sii9234.c b/drivers/gpu/drm/bridge/sii9=
234.c
index f81f81b7051f..bfd3832baa1a 100644
--- a/drivers/gpu/drm/bridge/sii9234.c
+++ b/drivers/gpu/drm/bridge/sii9234.c
@@ -925,8 +925,7 @@ static int sii9234_probe(struct i2c_client *client,
=20
 	i2c_set_clientdata(client, ctx);
=20
-	ctx->bridge.funcs =3D &sii9234_bridge_funcs;
-	ctx->bridge.of_node =3D dev->of_node;
+	drm_bridge_init(&ctx->bridge, dev, &sii9234_bridge_funcs, NULL, NULL);
 	drm_bridge_add(&ctx->bridge);
=20
 	sii9234_cable_in(ctx);
--=20
2.23.0

