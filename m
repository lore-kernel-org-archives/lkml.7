Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1084C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 13:17:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A04520727
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 13:17:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="m0/WXGV7";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="m0/WXGV7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728272AbfKZNRL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 08:17:11 -0500
Received: from mail-eopbgr130053.outbound.protection.outlook.com ([40.107.13.53]:42241
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728141AbfKZNQk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 08:16:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/GM8A9kiLcrCKYySajRO3pEQWg5CmJV0PJmVUtGtc3s=;
 b=m0/WXGV7+WeK7dFJRaRAB8RiT8iuPY2WAcn05vUzE7KGTlxtO1lHY0zvAFABq4Wrl8cnwZyEVsMVjqbXufWFMA61yzp2Wu+UWBsyJmeOuHZqUB2GgYjdf9Gosb5QZkDlJB3pYUhxGbKAq+LD1cENt9NYJ87t6bwhirCNCQLP69Q=
Received: from HE1PR0802CA0013.eurprd08.prod.outlook.com (2603:10a6:3:bd::23)
 by DB6PR0802MB2135.eurprd08.prod.outlook.com (2603:10a6:4:82::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.24; Tue, 26 Nov
 2019 13:16:36 +0000
Received: from VE1EUR03FT060.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::208) by HE1PR0802CA0013.outlook.office365.com
 (2603:10a6:3:bd::23) with Microsoft SMTP Server (version=TLS1_2,
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
 VE1EUR03FT060.mail.protection.outlook.com (10.152.19.187) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.17 via Frontend Transport; Tue, 26 Nov 2019 13:16:34 +0000
Received: ("Tessian outbound af6b7800e6cb:v33"); Tue, 26 Nov 2019 13:16:24 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: d2dc0a92ed9cf500
X-CR-MTA-TID: 64aa7808
Received: from 398b5090f33a.1 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.10.56])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id C2A6510B-80A7-41B4-B358-8DC4C502AFBF.1;
        Tue, 26 Nov 2019 13:16:18 +0000
Received: from EUR03-DB5-obe.outbound.protection.outlook.com (mail-db5eur03lp2056.outbound.protection.outlook.com [104.47.10.56])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 398b5090f33a.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 26 Nov 2019 13:16:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b/I1it62zpUWML41Zila59UIuH/3hDErEp0xNatJzZPHWA/0YmGXqjk0yUoZ3pVJICfI10P5c1Zu4QeaTpS73gVsSdDCiaAN7ivxW2ErYXO1Hv2Zd0LFMMmbKjW0EdwCoiQGjMMLa9dyOP1ssunzXumXEzXNkUVvydA/2Ph8/rEGJqRP5h69IZZ+6QSDAJC1rG0+6rKJWpOA/bvtd0wwmbJrIcBSNHR6gViYK3a75Xn9aqGTNmLCbO+5hMFTibBuTVBIK7Nb8M9HBN+yvr3sg8fW/v3ZMdHJ2SYXyuHAXmirmowXfxxDGGNrPttTesK9EmBy0mr0tvS67qI6dMDkgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/GM8A9kiLcrCKYySajRO3pEQWg5CmJV0PJmVUtGtc3s=;
 b=CWL5tHkqblAQGzjmX9otyD2uxT+BNmXfzPeJXCF85zisopRyHfpQkDgROcOppsDYjwRnwl2ZfKjOo6DdXBBO1BK6XyPOIRJ5HBtMIhhh6Td0OgZQNknG9nkmdIYsO1D3+ys5mlgPHdKdpDsjnJPwI4KBcZLtdo7STnm551xkscA6UBecThY021+NBQLJDYUkAtfiXTmVWXh11d7XAJ2lMBAAEGh2fOmfYepCC11+oPliBnz3jNfoEBGdsWI5zXsOLOnFum7hlXXgEdYfsAwzU3p8tcbGr39MCKzlZmSrPFSh2XrSFZzO9HFZTZI4uIx6GNWPdi4tKTbLYsa08gnJYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/GM8A9kiLcrCKYySajRO3pEQWg5CmJV0PJmVUtGtc3s=;
 b=m0/WXGV7+WeK7dFJRaRAB8RiT8iuPY2WAcn05vUzE7KGTlxtO1lHY0zvAFABq4Wrl8cnwZyEVsMVjqbXufWFMA61yzp2Wu+UWBsyJmeOuHZqUB2GgYjdf9Gosb5QZkDlJB3pYUhxGbKAq+LD1cENt9NYJ87t6bwhirCNCQLP69Q=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB4317.eurprd08.prod.outlook.com (20.179.28.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.16; Tue, 26 Nov 2019 13:16:17 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d%3]) with mapi id 15.20.2474.023; Tue, 26 Nov 2019
 13:16:16 +0000
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
Subject: [PATCH 18/30] drm/bridge: tc358767: Use drm_bridge_init()
Thread-Topic: [PATCH 18/30] drm/bridge: tc358767: Use drm_bridge_init()
Thread-Index: AQHVpFuvzbECXsJ4qkOALbl4JgCF4g==
Date:   Tue, 26 Nov 2019 13:16:16 +0000
Message-ID: <20191126131541.47393-19-mihail.atanassov@arm.com>
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
X-MS-Office365-Filtering-Correlation-Id: e9bbb99f-5b60-4cab-0ca3-08d77272dcdb
X-MS-TrafficTypeDiagnostic: VI1PR08MB4317:|VI1PR08MB4317:|DB6PR0802MB2135:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <DB6PR0802MB21354CD0C9CB2D491A253C0C8F450@DB6PR0802MB2135.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:376;OLM:376;
x-forefront-prvs: 0233768B38
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(1496009)(4636009)(39860400002)(366004)(346002)(376002)(136003)(396003)(189003)(199004)(5640700003)(86362001)(6512007)(71200400001)(2616005)(6486002)(71190400001)(2906002)(4326008)(6916009)(44832011)(446003)(11346002)(54906003)(66946007)(316002)(66446008)(64756008)(66556008)(66476007)(6436002)(4744005)(8936002)(186003)(26005)(5660300002)(102836004)(305945005)(14454004)(25786009)(99286004)(81166006)(50226002)(478600001)(2501003)(7736002)(6116002)(2351001)(76176011)(1076003)(52116002)(66066001)(256004)(8676002)(81156014)(6506007)(3846002)(386003)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB4317;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 8IWsceGY/aN95lJcl04ZEfdyoxpPUY0+AKQDjyOLPdXeZlgE3D3ED7DcL4/6STtUoEvKqtEPZXH69ioQTL3pEGd5oE3atGVJw/V5PS52UZdhozR2q9AKNxOQ19AtjBTGe7QAthvx77GQQ2WTv0MmwoCByXHCyuCYMnWTOr2CQ4fHQH1y/vFvQwD2UKTv1681WysRhMye8ko2BP0DS6jQNjsG1S242TpuIhzZsMBno0sF17Ryb3VQ096dO7xkwYUvxejfYMhpB0p8xGwljymmD8i0RgHNgJZGTEzBHYiOpL7AA0h/c/aNPQvHwGzIuByeaVqS62tb6NW+jyphw/ToUz/dwz0OFCtTmfReUI0V05eJjKPcyEH2LxRQDHKwPFJxP1zBq1AynxDBr+ZXeZXZpnxskWPbPs4Hv/ZOmZW7qgrY159onnpKTl9fpjqFN4sY
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4317
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT060.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(39860400002)(376002)(136003)(396003)(199004)(189003)(6512007)(2616005)(4326008)(6486002)(478600001)(102836004)(26826003)(2906002)(386003)(6506007)(50466002)(8676002)(8746002)(11346002)(8936002)(81156014)(81166006)(99286004)(6116002)(36756003)(14454004)(76176011)(50226002)(316002)(1076003)(4744005)(47776003)(70586007)(70206006)(5660300002)(2501003)(2351001)(86362001)(23756003)(3846002)(5640700003)(186003)(26005)(76130400001)(356004)(25786009)(54906003)(7736002)(22756006)(336012)(66066001)(6862004)(305945005)(446003)(106002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0802MB2135;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Pass;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: a9b3a778-d2be-4064-d6d6-08d77272d1b1
NoDisclaimer: True
X-Forefront-PRVS: 0233768B38
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LjTwJJzIyDK1230zSrRsuLfqUVlDvpphdO+HbloT1HTpWctuKoxxBEf7rilrA85RSVlaUyPy8cTKmsgChwvTzXLF8ZunL0Vdv3M+hD0T5Qx5wOZcT/9AE00n9oer15z8/o0iFQLxIZ6CYOGGgThGdqxyPeRoem8NylX7t9iwkLkd8+vYKpVkWFmH8FMDV73XcjdiW8IlkUUOCDVftCiFeJKIf2RXCGEbtMeaBV/Y1mqZ1OzpP/lrm00wp6WHWICZzrnJb5TuPniw83Kv10IhuYtNEoYZK8+2AFTkTgGCNqMvP7ONuS6WAl5/9oa7mnyzf8zh5O5V1Z0JBFZzdeZma1gE9U/Vn1n2hfI1YU0LneDR0vaEmHie+T4CyYJHcismrC9RS3sRbgrBBcCuGmNlIyHrHgiYabW9V/A1KYyb0R78klz/huZYMMYe0zBTf77U
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2019 13:16:34.5629
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9bbb99f-5b60-4cab-0ca3-08d77272dcdb
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0802MB2135
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional change.

Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
---
 drivers/gpu/drm/bridge/tc358767.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc3=
58767.c
index 8029478ffebb..7846c1925cbb 100644
--- a/drivers/gpu/drm/bridge/tc358767.c
+++ b/drivers/gpu/drm/bridge/tc358767.c
@@ -1671,8 +1671,7 @@ static int tc_probe(struct i2c_client *client, const =
struct i2c_device_id *id)
 	if (ret)
 		return ret;
=20
-	tc->bridge.funcs =3D &tc_bridge_funcs;
-	tc->bridge.of_node =3D dev->of_node;
+	drm_bridge_init(&tc->bridge, dev, &tc_bridge_funcs, NULL, NULL);
 	drm_bridge_add(&tc->bridge);
=20
 	i2c_set_clientdata(client, tc);
--=20
2.23.0

