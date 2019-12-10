Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23379C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 14:49:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E29F120637
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 14:49:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="REGoGmLC";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="REGoGmLC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727558AbfLJOtG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 09:49:06 -0500
Received: from mail-eopbgr30046.outbound.protection.outlook.com ([40.107.3.46]:10883
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727145AbfLJOtG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 09:49:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IvyIvzUUMHtUX/N2I7JhhQuDjupNz+W2QiZdhaBGEQs=;
 b=REGoGmLCO8/nPI5EwpEVh3V9kBDKVvT+DbRCM7S9MyddwTXN3PjR27rMiHnNFWI6PcvMGJp5JCLGZvO/A4djCCCKnpCKHaARK8fV9E1osY810qPEg2IFMlzdT8/FFjKRHMCsYIcRakmt3RLVZfAD2sILsuAjqDAiZK3LR3ddShU=
Received: from VE1PR08CA0017.eurprd08.prod.outlook.com (2603:10a6:803:104::30)
 by DB6PR0802MB2310.eurprd08.prod.outlook.com (2603:10a6:4:85::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.13; Tue, 10 Dec
 2019 14:49:02 +0000
Received: from DB5EUR03FT037.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::204) by VE1PR08CA0017.outlook.office365.com
 (2603:10a6:803:104::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.13 via Frontend
 Transport; Tue, 10 Dec 2019 14:49:01 +0000
Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT037.mail.protection.outlook.com (10.152.20.215) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18 via Frontend Transport; Tue, 10 Dec 2019 14:49:01 +0000
Received: ("Tessian outbound d87d9aeb44be:v37"); Tue, 10 Dec 2019 14:49:01 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 5f724c0bb73d8c47
X-CR-MTA-TID: 64aa7808
Received: from 445d2a11b348.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id FD8AED19-F1B6-4D35-9E3F-21B5C18A8AB8.1;
        Tue, 10 Dec 2019 14:48:53 +0000
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 445d2a11b348.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 10 Dec 2019 14:48:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DmihBiXosk/ddG3dxm9opeYAp4JmikPqIg684r/iZhxbrEg1yp/oTHDMlZHGrkSX2t44JGh7JEfoIIr4fgp38kd0cdd8B2hEBHin5aSMGw7cbCeVgJIeaEf0NPxrnbyOPfFDMEXzvo58fiscYmDRRJdjKVl+52ItLBjdTikSGiVFmewV+0Lc2R77ZvyAChOWLx3/FPl1mBbLMmIJeTV+XtVeHtL7xsOXhItbduZ46tv4E4RbYE7tzEiKZljAMytsWVdafgunC3FIrpAVjU/59asFQNK9wOI+upW74gD7QibuJwF0ksOK/0uoVQBSvccMIkYEXtnZkMmWFGeGbD5k2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IvyIvzUUMHtUX/N2I7JhhQuDjupNz+W2QiZdhaBGEQs=;
 b=Eta3CCcRqiHXyMzO2TCCS1duYlKUs9qGQ3x+FF6FkzC6zw7PqlWwD9Zeol/vS2Dnn65dC8Zb/QnkdPoB0OgEK7fVmscRx29Y00NSKp6+kowehaZSyUOJqyndWMHSlyUMXeSeNMYaKyhLjkiPyIJGEGCSGkmE4K1xroh9NrqhY0Dq9C/Wd9IU30MaVrpVkhRTnRdRRiyDn4i9NZsFQEd1wSpmNpyrsZCdzj/1bIxCHKNLe+3DEsR/z6fBzlr0mh8uaefWiZ2g0R7xc7mRcew8UhmWitngtcBFggeBs1tD+RNx/pkXC73wfVe4ypPnw9kMNaI03sDmUdRc4ysBBvcZEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IvyIvzUUMHtUX/N2I7JhhQuDjupNz+W2QiZdhaBGEQs=;
 b=REGoGmLCO8/nPI5EwpEVh3V9kBDKVvT+DbRCM7S9MyddwTXN3PjR27rMiHnNFWI6PcvMGJp5JCLGZvO/A4djCCCKnpCKHaARK8fV9E1osY810qPEg2IFMlzdT8/FFjKRHMCsYIcRakmt3RLVZfAD2sILsuAjqDAiZK3LR3ddShU=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB3742.eurprd08.prod.outlook.com (20.178.80.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.12; Tue, 10 Dec 2019 14:48:50 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::3d0a:7cde:7f1f:fe7c]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::3d0a:7cde:7f1f:fe7c%7]) with mapi id 15.20.2516.018; Tue, 10 Dec 2019
 14:48:50 +0000
From:   Mihail Atanassov <Mihail.Atanassov@arm.com>
To:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
CC:     Mihail Atanassov <Mihail.Atanassov@arm.com>, nd <nd@arm.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Linux Walleij <linux.walleij@linaro.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] drm/bridge: panel: export drm_panel_bridge_connector
Thread-Topic: [PATCH] drm/bridge: panel: export drm_panel_bridge_connector
Thread-Index: AQHVr2juqWlk00ywj0COPSlRR1t0mw==
Date:   Tue, 10 Dec 2019 14:48:49 +0000
Message-ID: <20191210144834.27491-1-mihail.atanassov@arm.com>
References: <20191207140353.23967-5-sam@ravnborg.org>
In-Reply-To: <20191207140353.23967-5-sam@ravnborg.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [217.140.106.54]
x-clientproxiedby: LO2P265CA0327.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a4::27) To VI1PR08MB4078.eurprd08.prod.outlook.com
 (2603:10a6:803:e5::28)
x-mailer: git-send-email 2.23.0
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6fabb45a-7a8e-4255-1603-08d77d80186c
X-MS-TrafficTypeDiagnostic: VI1PR08MB3742:|VI1PR08MB3742:|DB6PR0802MB2310:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <DB6PR0802MB2310E963ECF06C407F1B9DC08F5B0@DB6PR0802MB2310.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:3513;OLM:3513;
x-forefront-prvs: 02475B2A01
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(346002)(376002)(366004)(396003)(136003)(189003)(199004)(64756008)(4744005)(1076003)(186003)(66446008)(8676002)(66946007)(6916009)(6506007)(81166006)(66476007)(66556008)(478600001)(86362001)(26005)(6486002)(52116002)(44832011)(71200400001)(7416002)(6512007)(36756003)(316002)(8936002)(5660300002)(4326008)(81156014)(2616005)(54906003)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3742;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: Roj4P4BVdRkBRhcmu3avTM7Kotie3/qfek5Ssl/QWP0LPQriYK+dSZkpXNafBVBZ0T/R/s3UuHW0Dvrz2hUiqRIVctHe4f3iha34brY5+4NuB2LoTp78ZjIYojk6H4c1M7PKJtken3aV+g8EyIniCqfSeVScAqJOLaieazkWXWSyeH+Wmc7eVDSAIFL10spZeaqKEEF+4shavsMzcBKsnJg6UYdYAMB4IKpX6uWWdiBXRWawjdddr6vPUGWy2U+nSn09iNNj7D2PTwel/SnaWssuF2R9HuNlN+helii4GSc12O9Ky6QxPypulv0nKREK0h0fKUANIQUEwiELSGEzKtuMoCCEFNn/iegymmGBFSwSzIzw2MDCfrq4PBqgEH3upGaBl88uDs8LjPS7SK525WGxDysBXoX4swznIdAcQ4tHO2/tGBR+zlvbLoA9JY6I
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3742
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT037.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(39860400002)(376002)(136003)(346002)(199004)(189003)(8936002)(86362001)(356004)(6486002)(6512007)(26826003)(2906002)(336012)(81156014)(4326008)(6506007)(81166006)(5660300002)(8676002)(6862004)(2616005)(76130400001)(316002)(4744005)(36756003)(70206006)(70586007)(54906003)(478600001)(186003)(1076003)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0802MB2310;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Pass;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 6d291ec5-5932-4cce-6d8a-08d77d80112a
NoDisclaimer: True
X-Forefront-PRVS: 02475B2A01
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mnb7XqDtYJ76OvNiAv4K2GBYspoyHI5M4bW9JpaPJUL19pTCUVwFh1PRcUsZHAyTiipBOzX64VaUdDw2+muTJNofOuEXnjw6s+qTI6GXj1e5kkR/0ddTMFd8TI8IWGFd72PaqJ4K0S1hRMacfNPhiAqlWUE5rcqgl3FP2c/zD2OiNaOl3mpHzdbLLG1iad9OsZ46HDrSazDrgbwNdtT4J4UtlEhN3T4RpZMEtbuoR3JZgOpHHR1R2qzq43EMtBVliZ5jAOfT8eqn2yC0y7R12BaCNPiLviOVqkKFw5KR5+nzjkzeFxa90PSZIQwBUIqyP38kW17kyHFdFJdExPWsfFO4L2SK92KtpKkOXsDlixu3xj6N9lGg4pNxxViMOgzEOF+Cf/r5dWUm4QXOoAwHTtHR4rkYdAoFjXeSg2YShtTY8dOe1foATzTtDIh5Pffw
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2019 14:49:01.4616
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fabb45a-7a8e-4255-1603-08d77d80186c
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0802MB2310
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function was unexported and was causing link failures for pl111 (and
probably the other user tve200) in a module build.

Fixes: d383fb5f8add ("drm: get drm_bridge_panel connector via helper")
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Linux Walleij <linux.walleij@linaro.org>
Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
---
 drivers/gpu/drm/bridge/panel.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/bridge/panel.c b/drivers/gpu/drm/bridge/panel.=
c
index 1443897f999b..f66777e24968 100644
--- a/drivers/gpu/drm/bridge/panel.c
+++ b/drivers/gpu/drm/bridge/panel.c
@@ -306,3 +306,4 @@ struct drm_connector *drm_panel_bridge_connector(struct=
 drm_bridge *bridge)
=20
 	return &panel_bridge->connector;
 }
+EXPORT_SYMBOL(drm_panel_bridge_connector);
--=20
2.23.0

