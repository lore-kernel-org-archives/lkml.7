Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCDFACA9EBD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 01:29:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8640420B7C
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 01:29:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="aL+lKuKq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729354AbfJ1B3h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 21:29:37 -0400
Received: from mail-eopbgr70043.outbound.protection.outlook.com ([40.107.7.43]:12574
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727099AbfJ1B3h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 21:29:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dvdYW6kP3NfcpFEp8UKcMLHpBUC4hjYBca6g3wVLa5puIpRtzrWZlyxSzXlWP18u+WpKrMr/xnxlOHWfLdvyV/VWyJ/+31P0PGBs4Cf2yam/6Pnb1tQ+6aB4Ofa3SBpoI6xZQYTMOEE66qK2c4f3v/6oN8q1OwIeSa5YP6CZh9IH+Iw+/9JH7FGQAn5bxouNPH1SrY/y3ljbVx0f39XVj7iW1ar2RxX1Vi35IGjZggGR20XRYgAoxCg4Nt6vaUnT4Z9somY6mNBpdHRVbDT1yIUc59zsPHu4O00UVGlJ8sSzyXYvq/dES8BLHcrvOPw8jHIkVVsEpQvOf7EEDswy0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b7WGYUz/2vMaHOb+JPlyee7shf80hGHvuSoxA35boT8=;
 b=hGCFPUWHjHJzsS4+AoMGi1YTzwhKIfQ1d1cwvkqi/6dk/cooq5Y4tb/IdGBk+uYXt9pjBOo7wjAbqKQMfONMJkFxKlL1mABG6Efg5Y3wZ5lJATqqfJoyTTWOJXQFOdkBcqlKy05MY1dtT+PSGIxAhligsbiPjrExeno17AzAKIpGJH/bzfTRKRFlbRIo2eR4PkKdKXQzaSpNsRtTq/jPLWpwinRYXeOHuacXcXwdpX6gP+ecsnnyPy2lbA138PU8ZjlP8iOUqwYFn2qDqb49LpGlM2IrL0NYGo96RDYbSnEPAonEmqDcKhFm8KWlNVCwC5I1T0tdTEVmOgtS0b5Quw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b7WGYUz/2vMaHOb+JPlyee7shf80hGHvuSoxA35boT8=;
 b=aL+lKuKqqtr8FxusaXJmGK4u+eW8UIyvQQU8+yYVffeBcn6OEBMsxWvB+YRYCvNeb/wCItZ96E+qXVmKwBRwWaiMBHEqb5uZ+1E7vmW/L43J6Gyj3Tl/Y/4vrjUDZP6mFrRpAz8JEHNY33ZloCG+RoFWcO/Jygqg+eawd7d3DuI=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3818.eurprd04.prod.outlook.com (52.134.71.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20; Mon, 28 Oct 2019 01:29:33 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::d469:ad51:2bec:19f0]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::d469:ad51:2bec:19f0%6]) with mapi id 15.20.2387.025; Mon, 28 Oct 2019
 01:29:33 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>, Jun Li <jun.li@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "ccaione@baylibre.com" <ccaione@baylibre.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        "jon@solid-run.com" <jon@solid-run.com>,
        "baruch@tkos.co.il" <baruch@tkos.co.il>,
        "angus@akkea.ca" <angus@akkea.ca>, "pavel@ucw.cz" <pavel@ucw.cz>,
        "agx@sigxcpu.org" <agx@sigxcpu.org>,
        Troy Kisky <troy.kisky@boundarydevices.com>,
        Gary Bisson <gary.bisson@boundarydevices.com>,
        "dafna.hirschfeld@collabora.com" <dafna.hirschfeld@collabora.com>,
        Richard Hu <richard.hu@technexion.com>,
        "andradanciu1997@gmail.com" <andradanciu1997@gmail.com>,
        "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Peng Fan <peng.fan@nxp.com>, Andy Duan <fugang.duan@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 1/5] arm64: dts: imx8qxp: Move usdhc clocks assignment to
 board DT
Thread-Topic: [PATCH 1/5] arm64: dts: imx8qxp: Move usdhc clocks assignment to
 board DT
Thread-Index: AQHVg8fdGEBsUBy5akS/O25W4TlgXads5MOAgAJw9VA=
Date:   Mon, 28 Oct 2019 01:29:32 +0000
Message-ID: <DB3PR0402MB3916A2258E1E8B4690CC1B7DF5660@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1571192067-19600-1-git-send-email-Anson.Huang@nxp.com>
 <20191026120902.GL14401@dragon>
In-Reply-To: <20191026120902.GL14401@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ffdf5021-5e14-44cf-ea35-08d75b464935
x-ms-traffictypediagnostic: DB3PR0402MB3818:|DB3PR0402MB3818:|DB3PR0402MB3818:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB381877025C8927C2E0BDA805F5660@DB3PR0402MB3818.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0204F0BDE2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(346002)(396003)(376002)(366004)(39860400002)(189003)(199004)(229853002)(66946007)(55016002)(6116002)(66556008)(86362001)(66446008)(76116006)(4744005)(14454004)(25786009)(64756008)(5660300002)(81166006)(81156014)(8676002)(478600001)(4326008)(8936002)(6246003)(7416002)(52536014)(74316002)(7736002)(33656002)(186003)(6506007)(76176011)(446003)(7696005)(26005)(9686003)(6436002)(6916009)(256004)(102836004)(99286004)(316002)(2906002)(71200400001)(54906003)(71190400001)(305945005)(476003)(486006)(3846002)(66066001)(11346002)(44832011)(66476007)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3818;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: L9YM5f/YxpUcuI3naitHo3UxuU2uwLeGqGrwjqT+6NxRCtMU1gYd6hW7ga7TD7eZ/O7BQ2ucRoEEDYfyu2ZWoNI5+5wwtCqoI2DWseUe1gmhTNIRKX83Erscv9xvOIEiyup478WshYg3Jc363VvPO8x/JUPX/V7/kz54gRn19GaTthtw7sVOXWzNRa58lhypU0UHi2r5rQR8pWnjauHjzm6M8HWeEM0APekHL5G9+6MVyZLfRaeHi/Gm2XbD7BCDPbccKHzsE1IgEQGK/1LuXgh9m+rnhdeoVVrCcUvkloXcGmIIk0Z8pS/ZrnRDHfQbjVRLm664A90UcGf2dgJOYHvuX2sTSXZm88z1OXD+BZu7Sz9ABQ7yqoGtbJHIUK3kExJjJFwd8A6zv5YUB479jdcaJLyvsdJ3HMBUl96uF/66VDMFdJSd33nfg7LoM4ui
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffdf5021-5e14-44cf-ea35-08d75b464935
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2019 01:29:32.7314
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9Gvt96HYRpYRsqLi/r8tpiQoXvSjkJF1rEg7g8pAOYWagQFjXvpKv60MLG5VaRUWWoqPCPg8l/FgzcmbmZn/DA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3818
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFNoYXduDQoNCj4gT24gV2VkLCBPY3QgMTYsIDIwMTkgYXQgMTA6MTQ6MjNBTSArMDgwMCwg
QW5zb24gSHVhbmcgd3JvdGU6DQo+ID4gdXNkaGMncyBjbG9jayByYXRlIGlzIGRpZmZlcmVudCBh
Y2NvcmRpbmcgdG8gZGlmZmVyZW50IGRldmljZXMNCj4gPiBjb25uZWN0ZWQsIHNvIGNsb2NrIHJh
dGUgYXNzaWdubWVudCBzaG91bGQgYmUgcGxhY2VkIGluIGJvYXJkIERUDQo+ID4gYWNjb3JkaW5n
IHRvIGRpZmZlcmVudCBkZXZpY2VzIGNvbm5lY3RlZCBvbiBlYWNoIHVzZGhjIHBvcnQuDQo+IA0K
PiBJIHRoaW5rIGl0IHNob3VsZCBiZSBmaW5lIHRoYXQgd2UgaGF2ZSBhIHJlYXNvbmFibGUgZGVm
YXVsdCBzZXR0aW5ncyBpbiBzb2MuZHRzaSwNCj4gYW5kIGJvYXJkcyB0aGF0IG5lZWQgYSBkaWZm
ZXJlbnQgc2V0dXAgY2FuIG92ZXJ3cml0ZSB0aGUgc2V0dGluZ3MgaW4NCj4gYm9hcmQuZHRzLg0K
DQpTb21lb25lIHdhcyBjb21wbGFpbmluZyBhYm91dCB0aGUgdXNkaGMgY2xvY2sgYXNzaWdubWVu
dCBpbiBzb2MuZHRzaSwgYmVjYXVzZSBzb21lDQp1c2RoYyBub2RlcyBhcmUgaGF2aW5nIGNsb2Nr
IGFzc2lnbm1lbnRzIHdoaWxlIHNvbWUgYXJlIE5PVC4gVGhhdCBpcyB3aHkgSSBkaWQgdGhpcw0K
cGF0Y2ggc2V0LiBJIGFncmVlIHRoYXQgd2UgY2FuIGhhdmUgZGVmYXVsdCBzZXR0aW5ncyBpbiBz
b2MuZHRzaSwgc28gZG8geW91IHRoaW5rIGl0IG1ha2VzDQpzZW5zZSB0byBhZGQgZGVmYXVsdCBj
bG9jayBhc3NpZ25tZW50IHRvIGFsbCB1c2RoYyBub2Rlcz8gSWYgeWVzLCBJIHdpbGwgcmVkbyB0
aGUgcGF0Y2gNCnNldC4NCg0KVGhhbmtzLA0KQW5zb24uIA0KDQo=
