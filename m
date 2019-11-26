Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B026C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 13:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C27E12084B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 13:17:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Bll5d6fm";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Bll5d6fm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727918AbfKZNRk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 08:17:40 -0500
Received: from mail-eopbgr80077.outbound.protection.outlook.com ([40.107.8.77]:11957
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727860AbfKZNQc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 08:16:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2w9IwS9h8Xe+mRvYuwjPJLzvhx/Jnmzx3UokA4i7RFI=;
 b=Bll5d6fmRH0yG0paS2A2N7B6RAMf48kNB26Z4sujqxvLwG3S4VprSzPy0jq+LhlfuYNmh0CBpgClxjYSP/tesDV52yQ1uZKkZpJdsGpWCxdjL5/bxf+CuJ9E5aWux3pX6lmcnnzo09Wdb5QMjxynnjJLId0oj0hl6Uci+8V38dQ=
Received: from HE1PR08CA0059.eurprd08.prod.outlook.com (2603:10a6:7:2a::30) by
 AM6PR08MB3222.eurprd08.prod.outlook.com (2603:10a6:209:43::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.21; Tue, 26 Nov 2019 13:16:26 +0000
Received: from VE1EUR03FT059.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::208) by HE1PR08CA0059.outlook.office365.com
 (2603:10a6:7:2a::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.17 via Frontend
 Transport; Tue, 26 Nov 2019 13:16:26 +0000
Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT059.mail.protection.outlook.com (10.152.19.60) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.17 via Frontend Transport; Tue, 26 Nov 2019 13:16:26 +0000
Received: ("Tessian outbound 712c40e503a7:v33"); Tue, 26 Nov 2019 13:16:08 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 31ebd2a57fed7892
X-CR-MTA-TID: 64aa7808
Received: from 687810ec6074.6 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.14.52])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 8D7AB900-D71B-489F-BCC2-9D29B41A4481.1;
        Tue, 26 Nov 2019 13:16:02 +0000
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04lp2052.outbound.protection.outlook.com [104.47.14.52])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 687810ec6074.6
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 26 Nov 2019 13:16:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aRl5LC4OSqCc4HYT+IQ5O44rk/AhPl8oNMvnHF5Iyd5WTEHGjtlJZfwIR1IndkBzkxwZwd5ankj3TcdN6WUtu13Y+NhSkSjaREtML7BBLrYqNE6ZoJ95QRPgEqr8jo0VWaehPHhz05s2aIxK7FKZTgMnHiqei4T6fQYC1VQM7rfQAa4rD5PI2hE9+aDskIy2PbcTKq4dqbFAdj/oPwKU4R43sjGebcKk9/gbfBJrPLD4JrwlwFdSqFE2tKOmd0jpAvnRMdASX1DFEouGzsVXdeuoGdyD+zPUW3ITvDxGq7H+DkNOX6kPB5+EviuNZuekgxjFfQEoQz1zsnMqKvrl9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2w9IwS9h8Xe+mRvYuwjPJLzvhx/Jnmzx3UokA4i7RFI=;
 b=XOePaeIU/cmAJtncV5spBHQV6aWoEPau30ZE4j9Phb8SE3Ixil7BaKto9AN0lFRTiVYkvJNL7Idxq0rqlLoZyll4fAt94Hm2jqhNS+/ECzvYys9hqEABXX0Mx48Fi06udhRIaZZcNjRzp+forwDhPqdil4I2LhaiKjJRcNbu0TIjp8FFIOXV+dL6ApteaJ0CQ4eEE1sqheMizT3jFF9ijkrtZkU+1cOzpWwfpZn+6CB/+Hf1s7uGEQMbh+omxqrDquAKFQkjSJibaE2JZ+eqAGIYbFdxFakySkxuV3tNtdvZmepW6yXecfYUU7MBZ1d005p9BQpZ4sBCx1+GWx5a3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2w9IwS9h8Xe+mRvYuwjPJLzvhx/Jnmzx3UokA4i7RFI=;
 b=Bll5d6fmRH0yG0paS2A2N7B6RAMf48kNB26Z4sujqxvLwG3S4VprSzPy0jq+LhlfuYNmh0CBpgClxjYSP/tesDV52yQ1uZKkZpJdsGpWCxdjL5/bxf+CuJ9E5aWux3pX6lmcnnzo09Wdb5QMjxynnjJLId0oj0hl6Uci+8V38dQ=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB4317.eurprd08.prod.outlook.com (20.179.28.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.16; Tue, 26 Nov 2019 13:16:00 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d%3]) with mapi id 15.20.2474.023; Tue, 26 Nov 2019
 13:16:00 +0000
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
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Matt Redfearn <matt.redfearn@thinci.com>,
        Rob Clark <robdclark@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 02/30] drm/bridge: adv7511: Use drm_bridge_init()
Thread-Topic: [PATCH 02/30] drm/bridge: adv7511: Use drm_bridge_init()
Thread-Index: AQHVpFulRTJQhgMARkmWRCm2W3cWxg==
Date:   Tue, 26 Nov 2019 13:16:00 +0000
Message-ID: <20191126131541.47393-3-mihail.atanassov@arm.com>
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
X-MS-Office365-Filtering-Correlation-Id: 98370d2e-6544-4312-5d24-08d77272d774
X-MS-TrafficTypeDiagnostic: VI1PR08MB4317:|VI1PR08MB4317:|AM6PR08MB3222:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB3222768604565E695A6E041D8F450@AM6PR08MB3222.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:376;OLM:376;
x-forefront-prvs: 0233768B38
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(366004)(346002)(376002)(136003)(396003)(189003)(199004)(5640700003)(86362001)(6512007)(71200400001)(2616005)(6486002)(71190400001)(2906002)(4326008)(6916009)(44832011)(446003)(11346002)(54906003)(66946007)(316002)(66446008)(64756008)(66556008)(66476007)(6436002)(7416002)(4744005)(8936002)(186003)(26005)(5660300002)(102836004)(305945005)(14454004)(25786009)(99286004)(81166006)(50226002)(478600001)(2501003)(7736002)(6116002)(2351001)(76176011)(1076003)(52116002)(66066001)(256004)(8676002)(81156014)(6506007)(3846002)(386003)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB4317;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: hUGY10/nULHWlcwgw/scw0/nznZBBFiHEgu1jAmQQe2wSWpQtdpIS564otz69+crfnJ5nPaL/FiXWeVW2HS/mBE1m1DfnQ6XxOSoH4661QlP54atbm7jX/BzklfIjMAFpFCA0uNNAYjF7aavQBiWTe86fG/2KwzIUww8Qn0RzguC6/1lq+Xx2I/xt8nihfGwY4Tp6ZSgHftAl1S74MMfLPLOLaGVw0vpNHmsdhdS8S0mrREv80cMQ387gBxsEHVXFZqV3V9QvOctRvua34rrW7S5HYlurD3L4a9j1+yyKKRQL76uvrWFTwG0wAWhJFjbds/0l4vTxaOmILkIlbRKpHtY0MjaZNndAIAA8vtlFt4h0zNarOp6S61w6XYcXU+qaVY6cr5IB5ijWC51uOo8h0V/F1xOIiYKdIY73Qy+G8e0EHVj7f5h2srajru9AP2u
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4317
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT059.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(39860400002)(376002)(396003)(136003)(199004)(189003)(23756003)(76130400001)(25786009)(6862004)(2351001)(8746002)(22756006)(336012)(81166006)(11346002)(8936002)(106002)(6486002)(4326008)(316002)(8676002)(2616005)(50226002)(70206006)(70586007)(99286004)(2501003)(54906003)(81156014)(5640700003)(5660300002)(36906005)(7736002)(86362001)(305945005)(76176011)(47776003)(66066001)(26005)(446003)(4744005)(26826003)(50466002)(186003)(478600001)(102836004)(6512007)(356004)(1076003)(386003)(3846002)(14454004)(6506007)(36756003)(2906002)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR08MB3222;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Pass;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 204063af-26b1-4d9f-3e1b-08d77272c7bd
NoDisclaimer: True
X-Forefront-PRVS: 0233768B38
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NhPyxVrsQz7gJDGJ7L4ZJHavzqgrxCG7XSunxL16woSj+epX2Wvb1eCtid72hBcOQ5orIf9i7/F7/Fzf7w7S77wuHP1vYq1SCd4ZG2sSovmAhni1lDDyR2k+OJLTWrlV3c97K6ZVU4dFp3Lwds6zYDvG2NpVniRhh2nIfmK+V6E/dlNCKkXjlR+wxpaEUHkG+b/yNHW50GsaxUQdS4nd5mav2KWkVKQAuradCWsQmv6gOqD0z/kD2Eoxa8rzNVcJNJK9buW6X2G7XjXThaK7zEMiktbF1S5U+yuf8oILDMzVT9aMKbWkgYExsiRH6AqhTMqpcg9TXPO/xPs60+kIdxzSMnPvL8/59Gu06eb0m5Jt36TS8wHEkfTxKCy7tXOMLuZNfpXZX90iHPid9GFKFf0/dyXa2x4DTNNSVlJP/psfK9fdwQq9wj2t2BAWabdE
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2019 13:16:26.1288
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98370d2e-6544-4312-5d24-08d77272d774
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3222
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional change.

Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
---
 drivers/gpu/drm/bridge/adv7511/adv7511_drv.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c b/drivers/gpu/drm=
/bridge/adv7511/adv7511_drv.c
index 9e13e466e72c..73600d8766f8 100644
--- a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
+++ b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
@@ -1216,9 +1216,8 @@ static int adv7511_probe(struct i2c_client *i2c, cons=
t struct i2c_device_id *id)
 	if (ret)
 		goto err_unregister_cec;
=20
-	adv7511->bridge.funcs =3D &adv7511_bridge_funcs;
-	adv7511->bridge.of_node =3D dev->of_node;
-
+	drm_bridge_init(&adv7511->bridge, dev, &adv7511_bridge_funcs,
+			NULL, NULL);
 	drm_bridge_add(&adv7511->bridge);
=20
 	adv7511_audio_init(dev, adv7511);
--=20
2.23.0

