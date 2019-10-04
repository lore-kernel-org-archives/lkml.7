Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F14C3C4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 14:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C535F222CB
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 14:35:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="L/c4Fkar";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="L/c4Fkar"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389207AbfJDOfO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 10:35:14 -0400
Received: from mail-eopbgr00083.outbound.protection.outlook.com ([40.107.0.83]:21038
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389162AbfJDOfN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 10:35:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MQr2G/Kqwc17l+b9AgiMhs9TFIDdPxarqe0SC9pnd0o=;
 b=L/c4FkarPoBRW8CWg/8+oGLszDUMbULNJJN4psgAUZ/nArmV5vFQQdEhvE50JsQzJ17IdM9ay7+fTA7/Ocsz6mUMtD6npwgLMwB4l6zPV1cfnzf1Mb+7KO+tA2rjC6dZj9qW7IYwf/gA2WpxlPKg/tzP40zrfY+NUoIDBCXch2E=
Received: from VI1PR08CA0143.eurprd08.prod.outlook.com (2603:10a6:800:d5::21)
 by DB8PR08MB5115.eurprd08.prod.outlook.com (2603:10a6:10:eb::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2327.23; Fri, 4 Oct
 2019 14:34:56 +0000
Received: from AM5EUR03FT025.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::207) by VI1PR08CA0143.outlook.office365.com
 (2603:10a6:800:d5::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2305.20 via Frontend
 Transport; Fri, 4 Oct 2019 14:34:56 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT025.mail.protection.outlook.com (10.152.16.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2305.15 via Frontend Transport; Fri, 4 Oct 2019 14:34:53 +0000
Received: ("Tessian outbound 081de437afc7:v33"); Fri, 04 Oct 2019 14:34:42 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: b281391d09dab027
X-CR-MTA-TID: 64aa7808
Received: from 1341f0c0c52e.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.4.50])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id EC9F5286-A553-4FC7-91D5-BBE4AEBCD382.1;
        Fri, 04 Oct 2019 14:34:36 +0000
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-am5eur02lp2050.outbound.protection.outlook.com [104.47.4.50])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 1341f0c0c52e.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 04 Oct 2019 14:34:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mkwIv6pgI4SC2keqCO67pTpAokzQsdB4r/Ti4I5rWxfLSJthWRTHKMjHrFp10HCuNE93MFCeagUcLlBBq44kCe3H/btTR5MtereZ6A6fXLsOC5vEDT8++hkAhxUMeQ/I4KFClKR5VeVFboYhJlC8UNeERQ6zeJRpnVJntJvBaXmWLj75Gxr0aTNOJ93nLykyb4B4dDne2CirCrmlD9ash1aJQIjNvf5Hk7J7h5f1mlgXnkLTDdPKFT77cRjO6upDi/sbAbAaSnspR2E+Lw9AL8TGDyRSRt4ZQJgH6grphYP9NEkXM5PR4R/bQ5jCdoAH9fcYZWWgk2TSwmnLBaWIig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MQr2G/Kqwc17l+b9AgiMhs9TFIDdPxarqe0SC9pnd0o=;
 b=eKob8wTEt92Rpg8u1dSOvsFyI4eLyPD48z05FucBhzuYtBm/H4xqYdoOXkyZzKck7+vr+RcL5E1s8WA4cGIR+ivkN6iYQrl614iRKZrBX1OJrd3LBs0OLr/yHmcnFIq6W1gddsoXsNBwzVa3lZAKMc2E8zkcf3KmhazWEOcb1DZhuKEwGgjGTaqUjx2spaubnZFUI1QeHX6CrK+mHJhb2l7MgKjSS9UhbbAg1/C/6QkZNmFCPtPnbDecEF6MC+4BXZcR1ylr40AR38kUzUVvRNi5ySS0QtRFF82QOBsxrV5Lc9sMOas4+rD7R5QHAk04aEkIEBtuhYP1oteIruDLQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MQr2G/Kqwc17l+b9AgiMhs9TFIDdPxarqe0SC9pnd0o=;
 b=L/c4FkarPoBRW8CWg/8+oGLszDUMbULNJJN4psgAUZ/nArmV5vFQQdEhvE50JsQzJ17IdM9ay7+fTA7/Ocsz6mUMtD6npwgLMwB4l6zPV1cfnzf1Mb+7KO+tA2rjC6dZj9qW7IYwf/gA2WpxlPKg/tzP40zrfY+NUoIDBCXch2E=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB4288.eurprd08.prod.outlook.com (20.179.25.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.20; Fri, 4 Oct 2019 14:34:34 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::7d25:d1f2:e3eb:868b]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::7d25:d1f2:e3eb:868b%6]) with mapi id 15.20.2305.023; Fri, 4 Oct 2019
 14:34:34 +0000
From:   Mihail Atanassov <Mihail.Atanassov@arm.com>
To:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
CC:     Mihail Atanassov <Mihail.Atanassov@arm.com>, nd <nd@arm.com>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maxime Ripard <mripard@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>,
        Russell King <linux@armlinux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/3] drm/komeda: Support for drm_bridge endpoints
Thread-Topic: [PATCH 0/3] drm/komeda: Support for drm_bridge endpoints
Thread-Index: AQHVesDXsGC2pRfd7UunGC+bnCP1Fg==
Date:   Fri, 4 Oct 2019 14:34:34 +0000
Message-ID: <20191004143418.53039-1-mihail.atanassov@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [217.140.106.52]
x-clientproxiedby: LNXP265CA0001.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5e::13) To VI1PR08MB4078.eurprd08.prod.outlook.com
 (2603:10a6:803:e5::28)
x-mailer: git-send-email 2.23.0
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 4ce4a14b-da93-4c5f-224c-08d748d80564
X-MS-Office365-Filtering-HT: Tenant
X-MS-TrafficTypeDiagnostic: VI1PR08MB4288:|VI1PR08MB4288:|DB8PR08MB5115:
X-MS-Exchange-PUrlCount: 1
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <DB8PR08MB51158AE3759206FF9E5D38788F9E0@DB8PR08MB5115.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:10000;OLM:10000;
x-forefront-prvs: 018093A9B5
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(396003)(346002)(39860400002)(366004)(376002)(136003)(199004)(189003)(1076003)(66066001)(14454004)(66556008)(102836004)(2906002)(966005)(5660300002)(478600001)(36756003)(26005)(50226002)(3846002)(2501003)(6116002)(66446008)(386003)(186003)(64756008)(6506007)(66476007)(8936002)(66946007)(14444005)(2616005)(4326008)(256004)(44832011)(6306002)(81166006)(6512007)(99286004)(486006)(6436002)(5640700003)(8676002)(6486002)(86362001)(25786009)(71190400001)(476003)(6916009)(7736002)(305945005)(71200400001)(2351001)(54906003)(316002)(52116002)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB4288;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: MD+cO4484pqWb8wKXKtEuZSsIbsdYtxs0PBTmhnbFDknWPxOGVyp1ePH+ff+D35UDcE8YqXbVdnCjv34CuF7gJcoNG9yEzrfqpkHokODcWguOlgrqv7xfF8a4SQcL0IQ7oZxdj7xkoFxTROHtNHfM0ikEvzerf7nfW/gmvDCTAvTDdpxohq05QxKDNBnP5jKaEl3LXmgbneRq7oqU33ppjAI7i3OS8lp3hUtBCJpOu1ymGbeIf9o0DJaxPMHMIzf+RHXhXScWT3UFKa1ZNhYJrIDdPqphoDl9NNfViu2pll3L7PMEsyDpxGoOdEXH4skQ4GaLM4YvYSx+2FLU4psAPVvprYOrKAV0ClIpNKwfQoLswux383QRcXJplb75yabeTyyWsGh09UFD063eDF32R53H2gsL9t29yo1yOxj0sHtu91MD2/CEoB0nSLkv/aL6X/ymFsRAKEsf7yTfrlUkg==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4288
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT025.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(376002)(39860400002)(136003)(346002)(396003)(189003)(199004)(66066001)(36906005)(305945005)(7736002)(336012)(26005)(102836004)(23756003)(386003)(6506007)(186003)(316002)(50466002)(4326008)(6862004)(99286004)(47776003)(5640700003)(6486002)(2501003)(63350400001)(6512007)(6306002)(3846002)(6116002)(966005)(26826003)(478600001)(14454004)(50226002)(8936002)(486006)(8746002)(81156014)(8676002)(2906002)(25786009)(356004)(81166006)(2351001)(22756006)(70206006)(70586007)(36756003)(76130400001)(14444005)(1076003)(5660300002)(2616005)(476003)(86362001)(126002)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR08MB5115;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 9bab6445-39fb-46db-6fa4-08d748d7f9db
NoDisclaimer: True
X-Forefront-PRVS: 018093A9B5
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3pfb4u+syZBlFNxxSwWRpYfFH4XLXc0A+HJnTe3xjGhY4JzBvTm98CglUO04UdQcIxVjr90WONl8MenOwBWj4B6llPZKozHO/kgyEJndoCd4D11Dn3mvvkEBamQ3/ANCRYV8Dsj8GMtDhfj9CNJuCD0OI6ZaR6tjCsnW5G2bIog7IQvRwJ+MGW8OFz1FRPSRaAFub9BiX0PvhQ4urBw+uXm4qxn0hjZeWJA4I1pgu/GkUA7TFC6tJrwgOR6NV6ni72wHo0SB0sUmT5Ihinf0GLGtpOZDs3UswCdVx9yzlh3jqMBWznJFdig67Q3apuWmnQXFbMxW48BGF1NbtZ+Q2XwbFJTOSmY1J1EiaiOn6Zcg2yC+Zg1BGMMPPUOO6JgquJobMP7uDIpI7LT77fOjJfNpc+L1P7XQ5x77SAmKWfJaZr49/PvEqWs0h5j93o5dr5saXLqJ2niSzPC+4FUG8A==
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2019 14:34:53.5978
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ce4a14b-da93-4c5f-224c-08d748d80564
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5115
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

This series attempts to add support for endpoints (in the DT sense)
whose drivers only have a drm_bridge interface, unlike the tda998x,
which uses the component framework and provides all of drm_encoder,
drm_bridge, drm_connector.

1 & 2 should be fairly non-contentious, and I believe are valuable
enough on their own as they remove some pointer chasing and a few
allocations at the top level of komeda.

3 is the meat of this series, where I add the drm_bridge endpoint code.
This was tested with ti_tfp410 on the back end of a D71. I've tagged it
with an RFC since I drew inspiration from tilcdc, which does similar
shenanigans to detect tda998x vs non-tda998x, and is hence a precedent
for including similar handling, but I wasn't sure if there's a more well
established pattern.

Note that I opted not to remove the previous way of doing things for
tda998x, even though it could work with the drm_bridge handling
directly, since AFAIUI, device links haven't been implemented for
drm_bridge (see [1] for an attempt at doing that that never landed, and
I'm not aware of any refcounting having been added since), and therefore
getting a drm_bridge driver rmmod'ed while in use would be Bad(tm).

[1] https://lore.kernel.org/lkml/20180426223139.16740-1-peda@axentia.se/

Cc: Liviu Dudau <liviu.dudau@arm.com>
Cc: Brian Starkey <brian.starkey@arm.com>
Cc: James (Qian) Wang <james.qian.wang@arm.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: David Airlie <airlied@linux.ie>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Sean Paul <sean@poorly.run>


Mihail Atanassov (3):
  drm/komeda: Consolidate struct komeda_drv allocations
  drm/komeda: Memory manage struct komeda_drv in probe/remove
  drm/komeda: Allow non-component drm_bridge only endpoints

 .../gpu/drm/arm/display/komeda/komeda_dev.c   |  21 +--
 .../gpu/drm/arm/display/komeda/komeda_dev.h   |   9 +-
 .../gpu/drm/arm/display/komeda/komeda_drv.c   | 118 ++++++++-----
 .../gpu/drm/arm/display/komeda/komeda_kms.c   | 159 ++++++++++++++++--
 .../gpu/drm/arm/display/komeda/komeda_kms.h   |   9 +-
 5 files changed, 243 insertions(+), 73 deletions(-)

--=20
2.23.0

