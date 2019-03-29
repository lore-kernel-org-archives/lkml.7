Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4181FC4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 07:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0843C2173C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 07:45:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="f9t6aRe/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728981AbfC2HpH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 03:45:07 -0400
Received: from mail-eopbgr20072.outbound.protection.outlook.com ([40.107.2.72]:64105
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728887AbfC2HpG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 03:45:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HeDHElAp9lRdvoA6fkFHjCkVRs48C1lp2Lzb3AUZDmU=;
 b=f9t6aRe/TFDAd6g8vNDQQPRwTx/7LgZvDyhape/OP/euU5ftnufPdERor46jJeE14ZZLfOrC0WCnhYwVRjPwCsS/u+3Q+ZebLNLkgkgVafJM4plzROPWi+h2Y9TvutgYVuWWySSwnFhUop1deW3zGW5E5Iab3k0pvr4W/cW8d3A=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3946.eurprd04.prod.outlook.com (52.134.72.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.19; Fri, 29 Mar 2019 07:44:21 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::f1b4:a1fb:cfd1:3f08]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::f1b4:a1fb:cfd1:3f08%7]) with mapi id 15.20.1750.017; Fri, 29 Mar 2019
 07:44:21 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        Andy Gross <andy.gross@linaro.org>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "ezequiel@collabora.com" <ezequiel@collabora.com>,
        "stefan.wahren@i2se.com" <stefan.wahren@i2se.com>,
        "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
        "olof@lixom.net" <olof@lixom.net>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V9 1/4] dt-bindings: watchdog: add i.MX system controller
 watchdog
Thread-Topic: [PATCH V9 1/4] dt-bindings: watchdog: add i.MX system controller
 watchdog
Thread-Index: AQHU342DB8FETA5RyEWUAGDpn5oqoqYc1gOAgAVsCPA=
Date:   Fri, 29 Mar 2019 07:44:21 +0000
Message-ID: <DB3PR0402MB39161467D49348DC550CA28AF55A0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1553134884-1720-1-git-send-email-Anson.Huang@nxp.com>
 <1553134884-1720-2-git-send-email-Anson.Huang@nxp.com>
 <20190325203727.GA27661@bogus>
In-Reply-To: <20190325203727.GA27661@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6fbafc91-5af4-49ab-a028-08d6b41a5b45
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3946;
x-ms-traffictypediagnostic: DB3PR0402MB3946:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <DB3PR0402MB39467FD8959412E1823394BEF55A0@DB3PR0402MB3946.eurprd04.prod.outlook.com>
x-forefront-prvs: 0991CAB7B3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(366004)(396003)(346002)(376002)(13464003)(199004)(189003)(55016002)(99286004)(53936002)(7736002)(11346002)(3846002)(97736004)(6506007)(9686003)(105586002)(66066001)(53546011)(44832011)(8936002)(486006)(106356001)(478600001)(6246003)(6116002)(5660300002)(256004)(14454004)(102836004)(26005)(476003)(305945005)(71200400001)(71190400001)(33656002)(54906003)(6436002)(316002)(4326008)(446003)(8676002)(74316002)(81156014)(86362001)(7416002)(229853002)(186003)(2501003)(110136005)(76176011)(68736007)(81166006)(25786009)(52536014)(7696005)(2906002)(15866825006);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3946;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ZFIWiL2GHVVekKemOsMrzh7LALt5tNZFykBIdZl3HyZEa4hLqeoa0KjxjYKCKQz8GocuFMPWqrOVgQKgTzPrxvZEhZ9q9NrXGGN42DDt56iASYqyo2ovFOHVDZTtSpS2yNiodj568Iz0p7fU5gg+dAQiKW2d0FUjiuMirBaZP+divMHyHffqlseaZ7lt28k9jd3vRlSXTBFoyc60jZftTXa2givslOxrzp4j4LHtUmveArZuKoXoYEWIAgi73H9KMQVqVBL8TA6NNZB5amtNl3NkXO2hdXK2jsfNAJsIJl3rkuevmpIA6DbqHofpr90GbVS0ApWUMW4eVVXDoDU5eIIpo0NhC8bYwrw25FN9BibyQuWsEcSdq7EIfY+zC1rEensJmY8xOuIJ0nUpfER/pa8mxlUFgkbbBLtyVzGh0Ak=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fbafc91-5af4-49ab-a028-08d6b41a5b45
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2019 07:44:21.1261
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3946
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEd1ZW50ZXIvU2hhd24NCglTaW5jZSBEVCBoYXMgYmVlbiBhY2tlZCwgd291bGQgeW91IHBp
Y2sgdXAgdGhpcyBwYXRjaCBzZXJpZXMgaWYgbm8gYWRkaXRpb25hbCBjb21tZW50cz8NCg0KQmVz
dCBSZWdhcmRzIQ0KQW5zb24gSHVhbmcNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0K
PiBGcm9tOiBSb2IgSGVycmluZyBbbWFpbHRvOnJvYmhAa2VybmVsLm9yZ10NCj4gU2VudDogMjAx
OcTqM9TCMjbI1SA0OjM3DQo+IFRvOiBBbnNvbiBIdWFuZyA8YW5zb24uaHVhbmdAbnhwLmNvbT4N
Cj4gQ2M6IHdpbUBsaW51eC13YXRjaGRvZy5vcmc7IGxpbnV4QHJvZWNrLXVzLm5ldDsgbWFyay5y
dXRsYW5kQGFybS5jb207DQo+IHNoYXduZ3VvQGtlcm5lbC5vcmc7IHMuaGF1ZXJAcGVuZ3V0cm9u
aXguZGU7IGtlcm5lbEBwZW5ndXRyb25peC5kZTsNCj4gZmVzdGV2YW1AZ21haWwuY29tOyBjYXRh
bGluLm1hcmluYXNAYXJtLmNvbTsgd2lsbC5kZWFjb25AYXJtLmNvbTsNCj4gQWlzaGVuZyBEb25n
IDxhaXNoZW5nLmRvbmdAbnhwLmNvbT47IERhbmllbCBCYWx1dGENCj4gPGRhbmllbC5iYWx1dGFA
bnhwLmNvbT47IGhvcm1zK3JlbmVzYXNAdmVyZ2UubmV0LmF1OyBoZWlrb0BzbnRlY2guZGU7DQo+
IG1heGltZS5yaXBhcmRAYm9vdGxpbi5jb207IEFuZHkgR3Jvc3MgPGFuZHkuZ3Jvc3NAbGluYXJv
Lm9yZz47DQo+IGphZ2FuQGFtYXJ1bGFzb2x1dGlvbnMuY29tOyBiam9ybi5hbmRlcnNzb25AbGlu
YXJvLm9yZzsNCj4gZW5yaWMuYmFsbGV0Ym9AY29sbGFib3JhLmNvbTsgZXplcXVpZWxAY29sbGFi
b3JhLmNvbTsNCj4gc3RlZmFuLndhaHJlbkBpMnNlLmNvbTsgbWFyYy53LmdvbnphbGV6QGZyZWUu
ZnI7IG9sb2ZAbGl4b20ubmV0OyBsaW51eC0NCj4gd2F0Y2hkb2dAdmdlci5rZXJuZWwub3JnOyBk
ZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLQ0KPiBrZXJuZWxAbGlzdHMuaW5m
cmFkZWFkLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgZGwtbGludXgtaW14DQo+
IDxsaW51eC1pbXhAbnhwLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCBWOSAxLzRdIGR0LWJp
bmRpbmdzOiB3YXRjaGRvZzogYWRkIGkuTVggc3lzdGVtDQo+IGNvbnRyb2xsZXIgd2F0Y2hkb2cN
Cj4gDQo+IE9uIFRodSwgTWFyIDIxLCAyMDE5IGF0IDAyOjI2OjM4QU0gKzAwMDAsIEFuc29uIEh1
YW5nIHdyb3RlOg0KPiA+IEFkZCBpLk1YIHN5c3RlbSBjb250cm9sbGVyIHdhdGNoZG9nIGJpbmRp
bmcgZG9jLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQW5zb24gSHVhbmcgPEFuc29uLkh1YW5n
QG54cC5jb20+DQo+ID4gLS0tDQo+ID4gQ2hhbmdlcyBzaW5jZSBWODoNCj4gPiAJLSBhZGQgb3B0
aW9uYWwgcHJvcGVydHkgInRpbWVvdXQtc2VjIiBhY2NvcmRpbmcgdG8gZHJpdmVyIGNoYW5nZS4N
Cj4gPiAtLS0NCj4gPiAgLi4uL2JpbmRpbmdzL3dhdGNoZG9nL2ZzbC1pbXgtc2Mtd2R0LnR4dCAg
ICAgICAgICAgfCAyNA0KPiArKysrKysrKysrKysrKysrKysrKysrDQo+ID4gIDEgZmlsZSBjaGFu
Z2VkLCAyNCBpbnNlcnRpb25zKCspDQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvd2F0Y2hkb2cvZnNsLQ0KPiBpbXgtc2Mtd2R0LnR4dA0K
PiANCj4gSSBzdGlsbCB0aGluayB3aGF0J3MgaW4gQVRGIHNob3VsZCBiZSBkaXNjb3ZlcmFibGUs
IGJ1dDoNCj4gDQo+IEFja2VkLWJ5OiBSb2IgSGVycmluZyA8cm9iaEBrZXJuZWwub3JnPg0K
