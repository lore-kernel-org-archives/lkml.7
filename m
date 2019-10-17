Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D0B1FA3728
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 00:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33D0021928
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 00:47:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="p1HrmS8q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403760AbfJQArr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 20:47:47 -0400
Received: from mail-eopbgr30056.outbound.protection.outlook.com ([40.107.3.56]:45701
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725877AbfJQArq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 20:47:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EcLUiNTTthdnyqfsipp0P5Vv6i3rZa6CnjixHSdhiJEmUn0rrm+jdWSkyHfs2ldaiSudBjLWRpsS3oA56F3eib9CQM+/iym2CziTf17rM8RR0C9yfXO1UtU5wpNY3rV+R24uFC6BYfp8HPXBgK9jeWYIUZy4SBDRjKISM2ZbtTyEflSf/N2bL+JwWYEPzDUHu5ojXAPcX5UHeSHkUTmQTDADQcFUM7TSemPNgmIWx7FTBzS8Cg09PHLvXHaQAN9QSHbAD4Ls66SOXw+bdDrvCbwbr0O0ygoDBwbfa2YtHHZW+Vpx+8n4/S2ClzqbMrjFbcIhrr69Pwc7oeLgKmi95g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dN/v4vvROZcEHKdn11ndJSORGhK465+jRgb+mhzYm0s=;
 b=k5cDTql7/wthdBWWfvVBZY1tVvR8KvOilmi9Opk3kupM1EGtdYhINnZA9nYzdr/Sm0ZNV6iuaAIxaHgD31XXCtne9jWpxifx6czL/xs32iq0ZZWP3u4duqoISdIz6rd0XcJenkRpYKbd8PxXSfSdR+3gMvEoHye12kN5EYr8qVyhlnMi1Q/R/n6AzixaSW/duiT1yBgaa6y8jm/7u4MS45HtVqKE0ZQpeYA0hLKQWty9tYvbK7kVcaL/yvaz1vo9YHB1ybd2X4pKmbmi0CuPWpCzRZMZn5he/9jVF+QvNfxN/QGJH7XWdd1BzKsonR8QklMMQ8hKLxUv0YmR5470EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dN/v4vvROZcEHKdn11ndJSORGhK465+jRgb+mhzYm0s=;
 b=p1HrmS8qnWqugfwC7w6/eVeNyiUwBng4Yp5V0qKN0v8/daGB0Km7qd7bFEYDam6PEA9AD7zjaOmPIDpUFySGLR6ONTb7wv1KJsmc2MTgfanUfR8X9MlMcuumSGUkZ1BOjucLtcEAa50zn1XAQhwukukiV5py1solAq4KQjQ30yc=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5810.eurprd04.prod.outlook.com (20.178.117.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.18; Thu, 17 Oct 2019 00:47:43 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::843c:e722:27cb:74e1]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::843c:e722:27cb:74e1%5]) with mapi id 15.20.2347.023; Thu, 17 Oct 2019
 00:47:43 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>, Abel Vesa <abel.vesa@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>
Subject: RE: [PATCH] clk: imx: imx8mn: drop unused pll enum
Thread-Topic: [PATCH] clk: imx: imx8mn: drop unused pll enum
Thread-Index: AQHVgyb7rQc7WB2ptUeNJcHfwDTOYKddtCsAgABNP2A=
Date:   Thu, 17 Oct 2019 00:47:42 +0000
Message-ID: <AM0PR04MB4481574F8F7DA3E50E1F6408886D0@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <1571122989-29361-1-git-send-email-peng.fan@nxp.com>
 <20191016200646.CF8032064B@mail.kernel.org>
In-Reply-To: <20191016200646.CF8032064B@mail.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c3a33b1c-4934-4a3f-7abc-08d7529b9e9a
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: AM0PR04MB5810:|AM0PR04MB5810:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB5810F7D7F06BC780D2E1598A886D0@AM0PR04MB5810.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1468;
x-forefront-prvs: 01930B2BA8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(366004)(39860400002)(396003)(136003)(189003)(199004)(8676002)(186003)(11346002)(446003)(7696005)(99286004)(4001150100001)(4744005)(86362001)(3846002)(6116002)(66556008)(66946007)(66446008)(71200400001)(76176011)(71190400001)(6506007)(52536014)(2906002)(2201001)(81166006)(486006)(81156014)(4326008)(476003)(66476007)(64756008)(102836004)(8936002)(25786009)(66066001)(6436002)(6246003)(76116006)(229853002)(305945005)(44832011)(7736002)(33656002)(9686003)(478600001)(74316002)(256004)(5660300002)(316002)(26005)(110136005)(2501003)(55016002)(14454004)(54906003)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5810;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bMTBYC+/T9Tbr7iRb/U03hKWO7NmijEcLERfhKAl8jsiDQntfwzx8SsSBZLqzGff0cLJ8kVSnx/XT69H+ufwuDKIUH4iO74/685vfcTeb0Pzdk2Xnmb/SESdZYmM1bPvHZ0rIYOgMwqBCec9wM3Cy1X5g25rirMF0b7URZ3Ma4qhAeFV2RwuWI5aWQGTO1ltvGDFeT6y0dBUKxxGNAOZPXIC5QviQhxlWTXa4Bj7pTDpsyvnxbHazYIibq7EQ9RyCIf3LC+xRjQ43VWWygFpS/5St1DMyFXEFJfsGxUxlOyqk+qpFj8Aho8r3FYHBHyBEQ9j23l3lInPlxw7462ViVTayFrso15XcViBbyFHg9I/AYmNHA9O5eEagrr7eEi6zgzQr8atBiqduB5sPadNmuoY/OZAe18McZseEFeur14=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3a33b1c-4934-4a3f-7abc-08d7529b9e9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2019 00:47:42.9607
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W3YJ8KePngxAkPpiOQiKN95jtwoyNxXb59IprXjH523ehBuJ+dzBD/rj8h6jPt/JY+sNjTo9VRG5f+qbnBuvDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5810
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1BBVENIXSBjbGs6IGlteDogaW14OG1uOiBkcm9wIHVudXNlZCBwbGwg
ZW51bQ0KPiANCj4gUXVvdGluZyBQZW5nIEZhbiAoMjAxOS0xMC0xNSAwMDowNTo1MykNCj4gPiBG
cm9tOiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCj4gPg0KPiA+IFRoZSBQTEwgZW51bSBk
ZWZpbml0aW9uIGlzIG5vdCB1c2VkLCBzbyBkcm9wIGl0Lg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1i
eTogUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+DQo+ID4gLS0tDQo+IA0KPiBXYXMgaXQgZXZl
ciB1c2VkPw0KDQpTZWVtcyBuby4gSXQgbWlnaHQgYmUgYWRkZWQgYnkgbWlzdGFrZW4uIA0KDQo+
IA0KPiBBcHBsaWVkIHRvIGNsay1uZXh0DQoNClRoYW5rcywNClBlbmcuDQoNCg==
