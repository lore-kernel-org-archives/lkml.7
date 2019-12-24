Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A5A2C2D0D0
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 17:36:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A7042071E
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 17:36:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="kDjCuJwW";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="kDjCuJwW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727513AbfLXRgG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Dec 2019 12:36:06 -0500
Received: from mail-eopbgr90040.outbound.protection.outlook.com ([40.107.9.40]:64000
        "EHLO FRA01-MR2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727158AbfLXRe5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 12:34:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WQXNbyJJUA+kccB4NHiZM6Z8Dct9s1nfwVvcMcnYYrU=;
 b=kDjCuJwWWSwKVle/pG9449SCtb/2j5jgeOzH8EIaQ5GyAZ6KfU7W7F2hjQJ1uuT7ptdq1nJpsIjWuHVHb+rBSQlxzUKKOwIgE2XfHS7YdGRc1fCNSukb1npPdyLQV3Bea40HPyacR1L0pMHt+SwfgWARVNMuqDbarkXPf/VruiE=
Received: from VI1PR08CA0204.eurprd08.prod.outlook.com (2603:10a6:800:d2::34)
 by PR2PR08MB4651.eurprd08.prod.outlook.com (2603:10a6:101:1c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2559.17; Tue, 24 Dec
 2019 17:34:53 +0000
Received: from VE1EUR03FT011.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::200) by VI1PR08CA0204.outlook.office365.com
 (2603:10a6:800:d2::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2559.15 via Frontend
 Transport; Tue, 24 Dec 2019 17:34:53 +0000
Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT011.mail.protection.outlook.com (10.152.18.134) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.14 via Frontend Transport; Tue, 24 Dec 2019 17:34:53 +0000
Received: ("Tessian outbound 4f3bc9719026:v40"); Tue, 24 Dec 2019 17:34:53 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: d38e904be3fd0896
X-CR-MTA-TID: 64aa7808
Received: from bdd2edd0996c.11
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 07E92312-9CCC-43B2-AE31-2E02211E93DA.1;
        Tue, 24 Dec 2019 17:34:47 +0000
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id bdd2edd0996c.11
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 24 Dec 2019 17:34:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nbfk5dnO8ov8aBQmxUFVsERzA/BdaAccgHdVuPM3QSjNlBri8ShI2S9cpLsBEH+dk9a+LG0xaXt3fjJxCWzdoFv1F900Ftlpd1/rdewQfzqoxEHDxh68qCjU5MrqfUfTMNHV4yxZsJHBXrWWoDyn7l3TQMS0Z4XR/aVojyJL28j+KvaPYlhN0FtdHO4L8Nf80jNsTrsOHwQ0k5JxrMR9NhWiaatDGeqKUPO/iq2qr6TFmv4AObTCwS42KRm2HtsB5rdfNLdDtLuNOqFjKTpZo+pJEPSfOLWbaLiCw10h9dcsXCtFwKFkcfCl+ttqSLv7eFOVI3bumZI7RE0hg8qbmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WQXNbyJJUA+kccB4NHiZM6Z8Dct9s1nfwVvcMcnYYrU=;
 b=HW7kJXx1izuTnOgw+4s1ruuLm8BAzT4EQe63+WPs0h5yPh52mjHfGQ2LmA++sBsD/c0ssU1dNWxjOjm3v5/g1j6hctwlSaGLoiHuUqbpTS+w7Bi7LN6qMpPbLho75Ev4k1MbmnDuvKxVpvYoidotyy8DnoTtNVhNKQ9wLQaEHPHemljr6H2oCBadWaZsQfNee2t1a4MaNim0LgtGR7QiNP6yxpz1rIDiJ5x4F5tDk+I/rvbzWhExQfAI8dr9/MHkOEPL1pWQ5cfqswzpa2acqZiLyKL2XY5OxKAzI4auHDRWsohaZAVRPwBrUf8jgimBvUvB/wXWQ2GxTSOSqBu6wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WQXNbyJJUA+kccB4NHiZM6Z8Dct9s1nfwVvcMcnYYrU=;
 b=kDjCuJwWWSwKVle/pG9449SCtb/2j5jgeOzH8EIaQ5GyAZ6KfU7W7F2hjQJ1uuT7ptdq1nJpsIjWuHVHb+rBSQlxzUKKOwIgE2XfHS7YdGRc1fCNSukb1npPdyLQV3Bea40HPyacR1L0pMHt+SwfgWARVNMuqDbarkXPf/VruiE=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB2672.eurprd08.prod.outlook.com (10.170.238.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.16; Tue, 24 Dec 2019 17:34:41 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::3d0a:7cde:7f1f:fe7c]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::3d0a:7cde:7f1f:fe7c%7]) with mapi id 15.20.2559.017; Tue, 24 Dec 2019
 17:34:41 +0000
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
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH v3 22/35] drm/bridge: dw-hdmi: Use drm_bridge_init()
Thread-Topic: [PATCH v3 22/35] drm/bridge: dw-hdmi: Use drm_bridge_init()
Thread-Index: AQHVuoBswUteUei9z06pJQdMSXVMkQ==
Date:   Tue, 24 Dec 2019 17:34:41 +0000
Message-ID: <20191224173408.25624-23-mihail.atanassov@arm.com>
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
X-MS-Office365-Filtering-Correlation-Id: 853750c1-8006-4f2f-c093-08d78897960e
X-MS-TrafficTypeDiagnostic: VI1PR08MB2672:|VI1PR08MB2672:|PR2PR08MB4651:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <PR2PR08MB4651A4E77FAAAD6E52949FD78F290@PR2PR08MB4651.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:176;OLM:176;
x-forefront-prvs: 0261CCEEDF
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(39860400002)(396003)(136003)(366004)(199004)(189003)(186003)(26005)(7416002)(52116002)(6506007)(6486002)(81166006)(6512007)(81156014)(8676002)(8936002)(44832011)(54906003)(478600001)(316002)(6916009)(2906002)(4326008)(2616005)(36756003)(1076003)(66446008)(64756008)(66556008)(66476007)(66946007)(4744005)(5660300002)(71200400001)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB2672;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: VO0a6uxjoyROXRiYT+fhB7vWYJl0Kx2xWNa2ea4FjZ9/TobFkHG9yA3ASmtFxVlir7UTeXHzeArDP0DjkEV3QwnNUEBl+sEgXFcGRqD83BVlUy2bAUeCgriy8f8G5hRCOZ1pT+j9OtiYFmiCDA3bI3EiO9j4T7P8c08/lKC6JpvSWOQ5EBlIVk4Yr0WEd3wUmMlR7mQxTcAsRFI90ZoRAJq1xNO3zZPxjfux4zBL+v3/4FcexPqFXuvzLCbBmZytAOsFnQkoVDCrgXR47IdSPXbBKX17ziLKp1Fzm25WuVQnsBWlpAvvKItpZg8p1zfcFxsOM/c+6zHsJLEnH22l/n5jon7X8TaiPX+JZjICWZ1TJwt+NQDZEhpE6832IubuX+RY5IY0QSRPY2EyxPv4bqmQkCznlHpRemitL9dX5j5HkGYAtt3MWS22DQCXuoZT
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB2672
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT011.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(346002)(376002)(136003)(396003)(189003)(199004)(356004)(2616005)(4744005)(478600001)(26826003)(1076003)(336012)(5660300002)(26005)(2906002)(6512007)(8936002)(6506007)(186003)(54906003)(6862004)(76130400001)(8676002)(316002)(86362001)(36756003)(81166006)(70206006)(81156014)(107886003)(4326008)(6486002)(70586007)(36906005);DIR:OUT;SFP:1101;SCL:1;SRVR:PR2PR08MB4651;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Pass;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: f263c7e3-133f-4396-34e3-08d788978e9e
NoDisclaimer: True
X-Forefront-PRVS: 0261CCEEDF
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9vHXWxnmeLQNsoTwNMl6bbvmBKYzmihB5IYS4za+JHk4sbgUwUI2PeaP2Td+/2B2CSbft/+M3tIoqPIqhqJFmQwz3wQ2T8D7svb/aW1l8pTib1C5hs+h/4Q28fs2jXUXU0aLfVrKDPZquOY20oQ/jA0JtNaQRSI5jI9NLtfpp7ss5K87L+boZS+FsI3Q+gj+VHP1OtLVZ96JEKZyT1LV3+bi+5HqmGioKuVwF4uSpNIFI6MdVL8Ql99gDzhU1DvnvMoIvq+gtBYus9k8rQnD+C3EnLV/JB59JWNZXx3u5xsALTjSS8WGG+RXmEbEo93iCO/abYkvsbZQ2MEiUcJ750VxhhoYwSAwHnPizdS5Ejtkks9tK1QBrsThunlvpzbBX4YvI33BTReqNSK+FtkOhzUD7d6EvddgyLDUZ+kqKtEuh2okRFdEdUJhpj/amH9p
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2019 17:34:53.4112
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 853750c1-8006-4f2f-c093-08d78897960e
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR2PR08MB4651
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
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/br=
idge/synopsys/dw-hdmi.c
index 946aa1af8841..55a2a2f58783 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -2900,10 +2900,7 @@ __dw_hdmi_probe(struct platform_device *pdev,
 			hdmi->ddc =3D NULL;
 	}
=20
-	hdmi->bridge.funcs =3D &dw_hdmi_bridge_funcs;
-#ifdef CONFIG_OF
-	hdmi->bridge.of_node =3D pdev->dev.of_node;
-#endif
+	drm_bridge_init(&hdmi->bridge, &pdev->dev, &dw_hdmi_bridge_funcs, NULL);
=20
 	memset(&pdevinfo, 0, sizeof(pdevinfo));
 	pdevinfo.parent =3D dev;
--=20
2.24.0

