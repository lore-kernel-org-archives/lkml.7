Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0832BC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 13:16:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C308A2071E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 13:16:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="ufx+yy1E";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="ufx+yy1E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbfKZNQU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 08:16:20 -0500
Received: from mail-eopbgr30075.outbound.protection.outlook.com ([40.107.3.75]:54485
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727333AbfKZNQR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 08:16:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IdtA94mAshVXUemmMQnmXJ2MlYnOXP7KGT14dEW+wMo=;
 b=ufx+yy1E9PF1dxAolcA+WO3sszn0/nuzUUBUz8OtWkKEWGQAF6KCVQkTWa8AHDzco/AyVmlVfXMaX9aj4/AjA851TOejuQybxlalg2oqgscyP5F6THgBl4TmK/fatB4IyT4kLGJSsbU1+OMIWArOMdmoPL4wLDuMPs71VXlRtiQ=
Received: from DB6PR0802CA0032.eurprd08.prod.outlook.com (2603:10a6:4:a3::18)
 by VI1PR08MB5360.eurprd08.prod.outlook.com (2603:10a6:803:132::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.21; Tue, 26 Nov
 2019 13:16:14 +0000
Received: from VE1EUR03FT019.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::201) by DB6PR0802CA0032.outlook.office365.com
 (2603:10a6:4:a3::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.17 via Frontend
 Transport; Tue, 26 Nov 2019 13:16:14 +0000
Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT019.mail.protection.outlook.com (10.152.18.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.17 via Frontend Transport; Tue, 26 Nov 2019 13:16:13 +0000
Received: ("Tessian outbound fee635499979:v33"); Tue, 26 Nov 2019 13:16:10 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 6f32ef004a750f8f
X-CR-MTA-TID: 64aa7808
Received: from 687810ec6074.12 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.14.52])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 9DF367BD-3954-4A4F-80A4-5D274BA0F92C.1;
        Tue, 26 Nov 2019 13:16:05 +0000
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04lp2052.outbound.protection.outlook.com [104.47.14.52])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 687810ec6074.12
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 26 Nov 2019 13:16:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C7DokPhzIyUsSD+HTofdA63KgF9Dv4ulNcpIXh/wfs6W0G3WNB/0VIUNTIOqqdvKdGRdBlbTkV5MjyA9VVgmto4B/robcGXeI32MNxzg/BHTJZriFGlsM60NndtJh0iAY1A7MabZwkv5a1x4yy7W403so7vIev3J6S09/iTrLlPainVP/Ci6qlF+kf27nFnqc7bsEX1e+0ikqWDFiUi/WohqNl0FmUO82/BRmfF9mowURLijoi0NgZb03T5Sk5NcW1G8bx2o4ZmCW5iFfwwLu7Otqb3JXCdlIH8jzNgUEYA5Gm8Q3723sZE0ZLibP69iCK7tiviHFG0cAlpUxyEhjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IdtA94mAshVXUemmMQnmXJ2MlYnOXP7KGT14dEW+wMo=;
 b=hFEuHie9sV68NX8FHv3ZhFeET7TNN8tx133gKDCzDf8UhBYXg9r8iOExEpmzzCH2nK1cvUrTU6s6cQXmteIbelx21G3BT1c4kWEPqejb9EUWvYicc5CRni+dI9bug81SqX+IZ378tMPCUq0jnYI7AEtjtZFhTuQeTsfmC5KhxMpcE91nCCf3KZXac+VMlUZ6teVILn4G6V0aKDp06PKLLRDegMcyFSfU+HeW1OzFJZayxRSELOtPjg3PRh2HM1yFTW1KpikqRNJN9mLL0hv5JebplKhV4G+/H/C4PUAqqHknnRN+YMl4aFMJ04XhkZFCRZLN53HLSU+GDE/DoKLmWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IdtA94mAshVXUemmMQnmXJ2MlYnOXP7KGT14dEW+wMo=;
 b=ufx+yy1E9PF1dxAolcA+WO3sszn0/nuzUUBUz8OtWkKEWGQAF6KCVQkTWa8AHDzco/AyVmlVfXMaX9aj4/AjA851TOejuQybxlalg2oqgscyP5F6THgBl4TmK/fatB4IyT4kLGJSsbU1+OMIWArOMdmoPL4wLDuMPs71VXlRtiQ=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB4317.eurprd08.prod.outlook.com (20.179.28.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.16; Tue, 26 Nov 2019 13:16:03 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d%3]) with mapi id 15.20.2474.023; Tue, 26 Nov 2019
 13:16:03 +0000
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
Subject: [PATCH 05/30] drm/bridge: cdns: Use drm_bridge_init()
Thread-Topic: [PATCH 05/30] drm/bridge: cdns: Use drm_bridge_init()
Thread-Index: AQHVpFunfH94LB/Of02Me66l+5EISA==
Date:   Tue, 26 Nov 2019 13:16:03 +0000
Message-ID: <20191126131541.47393-6-mihail.atanassov@arm.com>
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
X-MS-Office365-Filtering-Correlation-Id: 16973a8a-ff07-4474-702c-08d77272d017
X-MS-TrafficTypeDiagnostic: VI1PR08MB4317:|VI1PR08MB4317:|VI1PR08MB5360:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <VI1PR08MB5360F0626B6BCF353DDB19F88F450@VI1PR08MB5360.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:669;OLM:669;
x-forefront-prvs: 0233768B38
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(366004)(346002)(376002)(136003)(396003)(189003)(199004)(5640700003)(86362001)(6512007)(71200400001)(2616005)(6486002)(71190400001)(2906002)(4326008)(6916009)(44832011)(446003)(11346002)(54906003)(66946007)(316002)(66446008)(64756008)(66556008)(66476007)(6436002)(4744005)(8936002)(186003)(26005)(5660300002)(102836004)(305945005)(14454004)(25786009)(99286004)(81166006)(50226002)(478600001)(2501003)(7736002)(6116002)(2351001)(76176011)(1076003)(52116002)(66066001)(256004)(8676002)(81156014)(6506007)(3846002)(386003)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB4317;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: Z2F59TblmaSmxIdPDaLfjNldy8W1wcU/EOpogwnc7F0Ygdm698rPsa1KjzMLVH+8g+4amDp0DmzgBNjYOQQTRTqOmxrIiOU2SfiLOKJoYiDyLSHV2Fqr9ZZumTe3p5qiw2ccTZeTtDf8reqEHA0uJOzQn4RrtiXeq5rnkiZBco5kF7KT4I9O3ISDN/vLHnLQrfzFND1c2J3vWIOZFpsMK4TxXJvdGjfTnxdbBFtU60ABgzkOwSWkm7SaGAN1xBMya6G7HHPXf+3EidH8v+ox6/YYUM704D0HEdreOV8nv807XOGiCNbjHOlK1+NqG3W8ih6NQunVxe5lccc/U/qVbQRrRN0PdQPHYSlXNOPFOUmhdl2XAUn/kU9FW/Jvz7FDu+Lbw8Ma9PtNVIrt+slj4pPlUqFSAHiYNC6qKX8veRc0+MIYSAAZSvur1Pa9snNS
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4317
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT019.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(376002)(396003)(346002)(136003)(199004)(189003)(36906005)(5660300002)(76130400001)(99286004)(54906003)(22756006)(106002)(2501003)(2906002)(305945005)(6486002)(6512007)(316002)(1076003)(70206006)(70586007)(4744005)(7736002)(446003)(2351001)(8746002)(81156014)(478600001)(86362001)(356004)(14454004)(2616005)(6116002)(81166006)(336012)(11346002)(6862004)(5640700003)(50226002)(47776003)(3846002)(8936002)(8676002)(186003)(6506007)(102836004)(25786009)(386003)(76176011)(23756003)(36756003)(26005)(26826003)(4326008)(50466002)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB5360;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Pass;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: a688f0ef-d3c3-4ee0-d189-08d77272c9b2
NoDisclaimer: True
X-Forefront-PRVS: 0233768B38
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DBpWp+q9dBX4DBU6IWMDVBWmnuqehE/Sc1fjuk0r3bCJT+QFEq6SDVXy5z8nA+3sX+KYUjpjxQcipXY+zFSEKeZKplq2/lFXpvHpjbxwqP6ns/10UsSJ9Ey+lyJysEhDpAETvAJzaOxy0XuIxy7hRKloveN2i5d4VgXs0qMAxIF9HHyvUU4yJHkSaTmD8u+8uIg4XNhwTNB01cRIZ5nRs46BqCJUmZ38o6IBAZgr96oGjcdEUaa88rlA66sAdc3qSiAVxm/VHhnT+b87laf/Zs1RYZkug8thaAfAwi3VPF61Rpw+nBafgfDBQ6XYnTuHnVb+4d+NfZbGzzBfJYTCfN8bpGXhMIfL65T3Gmax8NNvxQa2ll6bizcw7aBAA/mQVFlKtFJ9h/m+iu0gL4ZGuhOJppJR1a3ZqPPLfnjnjVhteUn1yU6jG31TLM2NmVLt
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2019 13:16:13.8158
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16973a8a-ff07-4474-702c-08d77272d017
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB5360
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional change.

Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
---
 drivers/gpu/drm/bridge/cdns-dsi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/cdns-dsi.c b/drivers/gpu/drm/bridge/cdn=
s-dsi.c
index 3a5bd4e7fd1e..58b2aa8b6c24 100644
--- a/drivers/gpu/drm/bridge/cdns-dsi.c
+++ b/drivers/gpu/drm/bridge/cdns-dsi.c
@@ -1233,8 +1233,8 @@ static int cdns_dsi_drm_probe(struct platform_device =
*pdev)
 	 * CDNS_DPI_INPUT.
 	 */
 	input->id =3D CDNS_DPI_INPUT;
-	input->bridge.funcs =3D &cdns_dsi_bridge_funcs;
-	input->bridge.of_node =3D pdev->dev.of_node;
+	drm_bridge_init(&input->bridge, &pdev->dev, &cdns_dsi_bridge_funcs,
+			NULL, NULL);
=20
 	/* Mask all interrupts before registering the IRQ handler. */
 	writel(0, dsi->regs + MCTL_MAIN_STS_CTL);
--=20
2.23.0

