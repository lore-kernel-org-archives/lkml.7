Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52AD2C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 11:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 159AD20862
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 11:49:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="VXpLXIOw";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="VXpLXIOw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbfLDLs7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 06:48:59 -0500
Received: from mail-eopbgr50060.outbound.protection.outlook.com ([40.107.5.60]:34755
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727809AbfLDLsi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 06:48:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5MOaSsR5jY0wtwz+PiDW06AIZcsZxDj0v9S4kmIV+VA=;
 b=VXpLXIOwxbrLMCWztCBz0TFzJaZ2wxbL+CDvNfwM8Kc1UGXjbAWwAbmDtiS1V2BiSPBZCwwoUKaaJUFXRVe/NsugxZJRCpMDGj3Yf08urWwM8/5kkRtVgQn2IXWliAYw+f1YIHwqFUX2UDjh8tNJ/O9RnukMB+Ttnw3qRjLPA8M=
Received: from VI1PR0801CA0090.eurprd08.prod.outlook.com
 (2603:10a6:800:7d::34) by HE1PR0801MB1706.eurprd08.prod.outlook.com
 (2603:10a6:3:84::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2495.22; Wed, 4 Dec
 2019 11:48:34 +0000
Received: from AM5EUR03FT025.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::205) by VI1PR0801CA0090.outlook.office365.com
 (2603:10a6:800:7d::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.12 via Frontend
 Transport; Wed, 4 Dec 2019 11:48:34 +0000
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
 15.20.2495.18 via Frontend Transport; Wed, 4 Dec 2019 11:48:33 +0000
Received: ("Tessian outbound 15590139dbb5:v37"); Wed, 04 Dec 2019 11:48:31 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 1593aa137f188207
X-CR-MTA-TID: 64aa7808
Received: from 27b0b5ea6d36.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 0C2DDF3E-45F2-4B29-920E-BD34AED50448.1;
        Wed, 04 Dec 2019 11:48:25 +0000
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 27b0b5ea6d36.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 04 Dec 2019 11:48:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IVxzEScDcWcNWXchJPU9fDRBCTskhoWv4+JEHSusRiEP2E0bGEzDCc0Sbm2qsq8JgyNXwiylJostSO/4qyMeFaF2E9vxHk6fUt23xfhj37u1dLcDNTLLATJueYTaBxevjDrXKX9Zebx8LeWbi25ayB+ACsq/AXG0+NfnW3CgqsI9H89MtmqehR8IWgL+0rb0PZmKSLRH6PBH28r8B0biL/gwk9FsR2edU/KQe2PqwVSy4j0hDdZg+q4u0hOYPWGU5SxUBbBuF4219Ml2uUwy+roY2sXU6/J/k98Kf6e0UklkGq7f8xYu8GzI5QEnTrH+m3iqP2yTCI3bZRuSgdUaBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5MOaSsR5jY0wtwz+PiDW06AIZcsZxDj0v9S4kmIV+VA=;
 b=F7e9Va60308TA9zXKwYBwOZrFcEl2MaXKt22lPxNnSO0Y0Au9FW72wuSnVZT4d1CqJIKZwooW/+7lLw6AquD4FSPiqQIYYvGs/VZsRpAWWTc1yR1KKQevWeNCpykqng0vjlsxR6/Ib6Qsex7cIRnPP+i472jFmUVrdjqI+lBUPbGJfNEpThlCKAaQjbxdeXodE5itigr5O3LnQbBRSidtylBWYaJKC7ICWraicRHAQLkT2F3BcCik4f6AsKR9u2WUkZKyHaa20sFJ39QkdpBynHVv/y9iZtroS8v/jzBQfC/t3gqZ02DuxQQeUcWhbFeYdy3vo8MB7nhDIUpemaF5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5MOaSsR5jY0wtwz+PiDW06AIZcsZxDj0v9S4kmIV+VA=;
 b=VXpLXIOwxbrLMCWztCBz0TFzJaZ2wxbL+CDvNfwM8Kc1UGXjbAWwAbmDtiS1V2BiSPBZCwwoUKaaJUFXRVe/NsugxZJRCpMDGj3Yf08urWwM8/5kkRtVgQn2IXWliAYw+f1YIHwqFUX2UDjh8tNJ/O9RnukMB+Ttnw3qRjLPA8M=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB4624.eurprd08.prod.outlook.com (20.178.13.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.17; Wed, 4 Dec 2019 11:48:23 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d%3]) with mapi id 15.20.2495.014; Wed, 4 Dec 2019
 11:48:23 +0000
From:   Mihail Atanassov <Mihail.Atanassov@arm.com>
To:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
CC:     Mihail Atanassov <Mihail.Atanassov@arm.com>, nd <nd@arm.com>,
        CK Hu <ck.hu@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 24/28] drm/mediatek: hdmi: Use drm_bridge_init()
Thread-Topic: [PATCH v2 24/28] drm/mediatek: hdmi: Use drm_bridge_init()
Thread-Index: AQHVqpi7pYXgRFSlykS2PKmc/BjiSw==
Date:   Wed, 4 Dec 2019 11:48:23 +0000
Message-ID: <20191204114732.28514-25-mihail.atanassov@arm.com>
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
X-MS-Office365-Filtering-Correlation-Id: 0b6da4ab-6b5b-4a41-efdf-08d778afe443
X-MS-TrafficTypeDiagnostic: VI1PR08MB4624:|VI1PR08MB4624:|HE1PR0801MB1706:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0801MB1706835B1D9BAC20AA62F7FD8F5D0@HE1PR0801MB1706.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:324;OLM:324;
x-forefront-prvs: 0241D5F98C
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(396003)(39860400002)(136003)(346002)(376002)(366004)(199004)(189003)(2351001)(305945005)(316002)(6436002)(81166006)(7736002)(6916009)(4326008)(186003)(99286004)(6486002)(66446008)(5640700003)(4744005)(66476007)(1076003)(66556008)(54906003)(2501003)(5660300002)(66946007)(64756008)(6512007)(86362001)(11346002)(2906002)(44832011)(2616005)(14454004)(50226002)(6506007)(36756003)(25786009)(81156014)(8676002)(3846002)(71190400001)(52116002)(26005)(478600001)(71200400001)(8936002)(102836004)(6116002)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB4624;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: Y2CFPPGxqO1fAvAD1HLdv1CyHaI8+Nz2Vc//xhcEkqXsz+FygNZK3wryNGtGFFdRqNLoZ6yz6h4I1vzI+pdcgAhm2sG8JM6uiZK5KG+W12cHzxQAgAP9HIpM0EUIJHJgX4fWfaBZHXb/zTcruF2VVaehsLQrRMU6Un1qftKnqSoZdNkd1isaPVEZ5JC/EXdM1SJNy08qI9+lYrHGfkXMcLF0wFSURZ90jzDbFy+lp4pSW7tG4Z3dbT1uDrSKF3YxEkfL8YQ9U7VdBdLrAuKpJ4WWCDGWH7sBtQwlDpExIx0Z4i8v3JlFVwVIr8kWICSkGBBxP/BdZe/J7UGjWaKvvj0mVLYvlu00LiP/FvWlkglPsL8cBWZr9xbjGkjQp0ZMZgTheY8LFW5xmhRbLv2C5yLjYoGtr6i/2jc+w3i/7um4dG7UAEuY6HtZKTYp8gTx
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4624
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT025.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(39860400002)(376002)(346002)(136003)(189003)(199004)(4326008)(2616005)(70206006)(70586007)(5660300002)(336012)(76130400001)(86362001)(1076003)(2906002)(14454004)(4744005)(2501003)(478600001)(6862004)(26826003)(23756003)(50466002)(11346002)(8936002)(22756006)(7736002)(36756003)(186003)(50226002)(81156014)(76176011)(99286004)(81166006)(316002)(6512007)(6486002)(36906005)(8746002)(54906003)(6116002)(3846002)(356004)(2351001)(5640700003)(26005)(102836004)(6506007)(25786009)(305945005)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0801MB1706;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Pass;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 4a18ad8e-9d7b-4f27-905c-08d778afddaa
NoDisclaimer: True
X-Forefront-PRVS: 0241D5F98C
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rlBFkNkTOhAct3mvXxhEG+NTIuH4f1TdWaSyt4S6WJZPK3+WBYvlpVwGWTIbRlgMaLisTR67E6ooN0ZXXxhWcLaSwvrcEuD+awjOLtOXWgGjqzynVGkoIweUwn54qvMA1CLHD40VdqiTQZ/pnt4SY0O/uEIoasER+HcuSVnwG3nnXcW1qoZd3B1XBuVep97aRbEoivmFlTaugqWxx+3vizAJlpCIyDCwgHHZLDr5IaRFMo2rTUIiukfdBlrFW0V3nuo/+yeII/du7k/lmZzoo2G1tZ8rjHygKB6AUjt0YkzCN8PYxwUExSlO/E7X+czX1tbBvNGW2ETiQWXCN6TEymmT3xFTyiqR+UbeC/SciSg7KrrV8NdEvHE1H9XMdh7b96NoePyk/MlAIgTwpLkWSPXAhLKUAkW3xJ9p2KctnrcIUmiHXYCpPutYSH2cT7hR
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2019 11:48:33.9871
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b6da4ab-6b5b-4a41-efdf-08d778afe443
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1706
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional change.

Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
---
 drivers/gpu/drm/mediatek/mtk_hdmi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.c b/drivers/gpu/drm/mediatek=
/mtk_hdmi.c
index f684947c5243..9761a80674d9 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi.c
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi.c
@@ -1708,8 +1708,8 @@ static int mtk_drm_hdmi_probe(struct platform_device =
*pdev)
=20
 	mtk_hdmi_register_audio_driver(dev);
=20
-	hdmi->bridge.funcs =3D &mtk_hdmi_bridge_funcs;
-	hdmi->bridge.of_node =3D pdev->dev.of_node;
+	drm_bridge_init(&hdmi->bridge, &pdev->dev, &mtk_hdmi_bridge_funcs,
+			NULL, NULL);
 	drm_bridge_add(&hdmi->bridge);
=20
 	ret =3D mtk_hdmi_clk_enable_audio(hdmi);
--=20
2.23.0

