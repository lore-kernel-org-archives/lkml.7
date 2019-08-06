Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F17FC433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 09:17:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF1CF20B1F
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 09:17:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="B5RPb+vg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732410AbfHFJRM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 05:17:12 -0400
Received: from mail-eopbgr150083.outbound.protection.outlook.com ([40.107.15.83]:28525
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732079AbfHFJRM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 05:17:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A+bOYeGQOvWtru5iTgrQjphmyV/dlvAD7aXTSz4SyDQDFGFf+t3/DHUhWMRqrDGhGLPo+1o1xzSFMFWhCZBl8poW/VYW+WZBkcmqVVhfJDC4/hlVEkismGHriA5T/uctQOsheY5YuoLT33FxU5sSNPudbe9+wsoWVFomEqyO/pCPiGvwrvA73ak/8W8mWJVdv4A/J7ro6HasZ89/Vx5zYy4JptEfkjwArsPJu0CzQS8gc0sE+uPYoNXs0gqOD3bNZLvWDKd4Je+gHUQWoxPgaVq9W/aScExO4eRKMK54p4Ndw1G8OAsAzSjbwQ0ERLHXh+V60Bwan63hvnF45jdjBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zJsuXJRtZrnN4NxkETC75H9wdjZOR2+xl+7WvS4uADg=;
 b=cdQewf5YRLjrrXJYNmyGt7mzM5HqBYy38WbLeTcZTNzwfw8KiTjSm/mIGSOkYqKFdctSjuSAcukpSlr56vhjmspv7TD8VdySow0pOj11bW4N2o3/Z50c9FQ2xGG8ckfElFRRBU7aAdQ2ZYpfvhbDgjC/wSz5GEGH7Ah9ayJSKcZfDi4KnQQAguYszp4Lo4Je/XdrY1jjJgv6yxMTGvu57pd761XjWKhZSoHJIpP+G/MZTxo8+pi3OvfRZNJJW7RsoT3U1nDtsyeuqvcRhwfwRcWyUnYjFygjGUl7ZzY+b5GCtIs3436X8pEbgl3+rC+DpXiiRxS4LZfiVy9E93w4qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=nxp.com;dmarc=pass action=none header.from=nxp.com;dkim=pass
 header.d=nxp.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zJsuXJRtZrnN4NxkETC75H9wdjZOR2+xl+7WvS4uADg=;
 b=B5RPb+vgiyhSP3QEyVG5ItYkeSqJ6Lx6su9I3HbsmNK/xq3rlxpSp7zPciW9+aqZOENqhILterFpizlAZgRHlUHXROTm5lWKw349rTb25iXlpLFmmvo5xPAKgSCS5K3WV29MpmVBEdp10SgNXye+U/6CIDt418usvLN1TgmgW3Q=
Received: from VI1PR04MB4094.eurprd04.prod.outlook.com (52.133.13.160) by
 VI1PR04MB6030.eurprd04.prod.outlook.com (20.179.24.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.17; Tue, 6 Aug 2019 09:17:07 +0000
Received: from VI1PR04MB4094.eurprd04.prod.outlook.com
 ([fe80::c85e:7409:9270:3c3c]) by VI1PR04MB4094.eurprd04.prod.outlook.com
 ([fe80::c85e:7409:9270:3c3c%7]) with mapi id 15.20.2136.018; Tue, 6 Aug 2019
 09:17:07 +0000
From:   Daniel Baluta <daniel.baluta@nxp.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Fancy Fang <chen.fang@nxp.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        Jacky Bai <ping.bai@nxp.com>, Jun Li <jun.li@nxp.com>,
        "agx@sigxcpu.org" <agx@sigxcpu.org>, Abel Vesa <abel.vesa@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Anson Huang <anson.huang@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        Peng Fan <peng.fan@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH 2/2] clk: imx8mq: Unregister clks when of_clk_add_provider
 failed
Thread-Topic: [PATCH 2/2] clk: imx8mq: Unregister clks when
 of_clk_add_provider failed
Thread-Index: AQHVTCQFiMf7Z6GBnEmButhUFBiCbabt1yYA
Date:   Tue, 6 Aug 2019 09:17:07 +0000
Message-ID: <01256fbd0ec5c14e30027be902e89b65ab921970.camel@nxp.com>
References: <20190806064614.20294-1-Anson.Huang@nxp.com>
         <20190806064614.20294-2-Anson.Huang@nxp.com>
In-Reply-To: <20190806064614.20294-2-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0cca0302-0f35-47ca-b4ec-08d71a4edac7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB6030;
x-ms-traffictypediagnostic: VI1PR04MB6030:
x-microsoft-antispam-prvs: <VI1PR04MB60301B80ACB8F7F4F83E9B24F9D50@VI1PR04MB6030.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-forefront-prvs: 0121F24F22
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(346002)(376002)(39860400002)(366004)(136003)(199004)(189003)(26005)(6512007)(478600001)(486006)(76176011)(11346002)(476003)(446003)(14454004)(2616005)(68736007)(6486002)(6506007)(25786009)(66446008)(5660300002)(64756008)(86362001)(71200400001)(186003)(76116006)(256004)(14444005)(91956017)(4744005)(71190400001)(66476007)(66946007)(66556008)(2501003)(7736002)(50226002)(305945005)(8936002)(81166006)(81156014)(8676002)(110136005)(2906002)(102836004)(66066001)(7416002)(53936002)(2201001)(6246003)(44832011)(4326008)(99286004)(6116002)(229853002)(3846002)(118296001)(6436002)(316002)(36756003)(99106002)(921003)(32563001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB6030;H:VI1PR04MB4094.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: s4d+oj7CC1eHCjJKPP7t4y5gJmH3D9U+MedriCqYvbfcx2WyFtHmtElcewzqiGXboPlgshxuwznPj5bLfJCMphzlxaGkikR6XuEQF9vn2CHlZINEXHgpmHjOKwtRyDWYP0oid0TRlag7R6VAFqRHtn4A9lf09EtsCoeRobzLl+jM5wr5DDmZChubTgKn+j8xuMaM2HZyYgShgBAdT8ukX80tCQQ+i9p9yJfJVRy1jX/W+XLwvja/7WtZ12fpgsqiy+0wHYg00/WnGUekh9gG3oAHFzEYkwS9+WKwRCyl2gE+kUwWw35KqzcKIwS4pRAnPXKVj1G9z6H/U17eJQ0tI6DY68BZRH3ud5rFNJ/tqMu7hQ/nv0ftrOQPQh/AsMEPFdUFBrk9OHGJI2rae2PlqrBrBIuso0+yNocbg0es7e8=
Content-Type: text/plain; charset="utf-8"
Content-ID: <440199482DA6994BA78BD8BEFD5D9B37@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cca0302-0f35-47ca-b4ec-08d71a4edac7
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2019 09:17:07.4807
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: daniel.baluta@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6030
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE5LTA4LTA2IGF0IDE0OjQ2ICswODAwLCBBbnNvbi5IdWFuZ0BueHAuY29tIHdy
b3RlOg0KPiBGcm9tOiBBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4NCj4gDQo+IFdo
ZW4gb2ZfY2xrX2FkZF9wcm92aWRlciBmYWlsZWQsIGFsbCBjbGtzIHNob3VsZCBiZSB1bnJlZ2lz
dGVyZWQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdAbnhw
LmNvbT4NCg0KUmV2aWV3ZWQtYnk6IERhbmllbCBCYWx1dGEgPGRhbmllbC5iYWx1dGFAbnhwLmNv
bT4NCg0KPiAtLS0NCj4gIGRyaXZlcnMvY2xrL2lteC9jbGstaW14OG1xLmMgfCAxMCArKysrKysr
KystDQo+ICAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+
IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jbGsvaW14L2Nsay1pbXg4bXEuYyBiL2RyaXZlcnMv
Y2xrL2lteC9jbGstDQo+IGlteDhtcS5jDQo+IGluZGV4IDA0MzAyZjIuLjgxYTAyNDkgMTAwNjQ0
DQo+IC0tLSBhL2RyaXZlcnMvY2xrL2lteC9jbGstaW14OG1xLmMNCj4gKysrIGIvZHJpdmVycy9j
bGsvaW14L2Nsay1pbXg4bXEuYw0KPiBAQCAtNTYyLDEwICs1NjIsMTggQEAgc3RhdGljIGludCBp
bXg4bXFfY2xvY2tzX3Byb2JlKHN0cnVjdA0KPiBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICAJ
Y2xrX2RhdGEuY2xrX251bSA9IEFSUkFZX1NJWkUoY2xrcyk7DQo+ICANCj4gIAllcnIgPSBvZl9j
bGtfYWRkX3Byb3ZpZGVyKG5wLCBvZl9jbGtfc3JjX29uZWNlbGxfZ2V0LA0KPiAmY2xrX2RhdGEp
Ow0KPiAtCVdBUk5fT04oZXJyKTsNCj4gKwlpZiAoZXJyIDwgMCkgew0KPiArCQlkZXZfZXJyKGRl
diwgImZhaWxlZCB0byByZWdpc3RlciBjbGtzIGZvciBpLk1YOE1RXG4iKTsNCj4gKwkJZ290byB1
bnJlZ2lzdGVyX2Nsa3M7DQo+ICsJfQ0KPiAgDQo+ICAJaW14X3JlZ2lzdGVyX3VhcnRfY2xvY2tz
KHVhcnRfY2xrcyk7DQo+ICANCj4gKwlyZXR1cm4gMDsNCj4gKw0KPiArdW5yZWdpc3Rlcl9jbGtz
Og0KPiArCWlteF91bnJlZ2lzdGVyX2Nsb2NrcyhjbGtzLCBBUlJBWV9TSVpFKGNsa3MpKTsNCj4g
Kw0KPiAgCXJldHVybiBlcnI7DQo+ICB9DQo+ICANCg==
