Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FCFDC2D0C4
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 01:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ACAF206EC
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 01:06:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="T3SunRuL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbfLKBGW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 20:06:22 -0500
Received: from mail-eopbgr20080.outbound.protection.outlook.com ([40.107.2.80]:10886
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726362AbfLKBGW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 20:06:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FVqLXKOrQzJK2OANme7zss5w1WCYHjm1x08B8d1JXt9jjzOGdotLa88SiQWYmT69hbzRqFRzoLNtbumyXhjCiCIqiyokYHrVOJ8XshRkOv2rrSv/eUIURwAvPiS7qIT0EByQk0wqNdbo28ZZOrnTKFbwyxeV7/AkJRmqgKQRXzd6cNVIrKnAkakMl71txvHFvmFBoFGjmTCtvFPX/oucdtm3TIMG4UdsP7vlPX87y5je4IpywjpgWc/1Fytsc9AprafACibWiDJbWq7COLCA1DBRa18JAnP/DDLp5alF6Zt5t7rUQT3s+QWRWJBMnbJlORfamXFCQjO4XlPrJsCX5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lP2NOVOLsq+AI4DJZBETqqWXxPuUTGlYLuEPgi11Fc8=;
 b=Ux8VZQT99jzwUT+flkhcEzHJSwC09alhbRJ/RaZBUcOEgwW5qh8jJ47+UoFRqInsBcQ+ks2g7gaFhi+MN4y/mC5JpE+bOimv8Gk+B3XJIJy0gIYTE+lgOxcxW7Tl6f7cbO1NPPAKz7b6xJyQygjHUSvfGEF2Gq6NK2GA6omTOCQVYJTjWd7p9acwU/D1MqNs7JMzSKJfT623+9YnluDoSXPhobkrTXl6jqn85PHc4vet4CISY4XJg6hgaz2hopxAgvTiHku1tOmbQHendTR/7MvshdrRLhyJzRK1aTktq/wKaNnPWUvYquwZGVG9MQcOUPuqHrrzXAGxO4FKj17acA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lP2NOVOLsq+AI4DJZBETqqWXxPuUTGlYLuEPgi11Fc8=;
 b=T3SunRuLE2uoNcRJikVzZCJlxbTDqKXvwqStdwFuDnwmqh6HMdxcXdu7B8GHJTSo0CV1L8K6BrwSxTG68bvR2E66nJlaTxV4y74f74eE1kGA08JR6rpKqOOLzhrHxiEWOS0QmPpgw/YiMLb5hdwWcsQfhHzAjeg0zk8kTi8DrRk=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3818.eurprd04.prod.outlook.com (52.134.71.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.14; Wed, 11 Dec 2019 01:06:17 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::b5ce:fe6b:6c06:fdb1]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::b5ce:fe6b:6c06:fdb1%6]) with mapi id 15.20.2516.018; Wed, 11 Dec 2019
 01:06:17 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 1/3] ARM: dts: imx6ul-14x14-evk: Add sensors' GPIO
 regulator
Thread-Topic: [PATCH 1/3] ARM: dts: imx6ul-14x14-evk: Add sensors' GPIO
 regulator
Thread-Index: AQHVikhFrshNJnCYpE+PA285m4wtLae0aMuQ
Date:   Wed, 11 Dec 2019 01:06:17 +0000
Message-ID: <DB3PR0402MB3916D3DB4C0CE0017FC2D4B1F55A0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1571906920-29966-1-git-send-email-Anson.Huang@nxp.com>
 <VI1PR04MB7023CD288FCC57806F067FD9EE5B0@VI1PR04MB7023.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB7023CD288FCC57806F067FD9EE5B0@VI1PR04MB7023.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 15fc07c5-c717-429c-19be-08d77dd65379
x-ms-traffictypediagnostic: DB3PR0402MB3818:|DB3PR0402MB3818:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB38183E1B1397BA05D21BA1BAF55A0@DB3PR0402MB3818.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 024847EE92
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(366004)(136003)(346002)(39860400002)(199004)(189003)(4326008)(186003)(26005)(8936002)(7696005)(44832011)(55016002)(53546011)(2906002)(66556008)(64756008)(9686003)(76116006)(33656002)(66476007)(8676002)(52536014)(478600001)(66446008)(54906003)(110136005)(6506007)(81156014)(66946007)(86362001)(316002)(71200400001)(81166006)(5660300002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3818;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rK9Ow2rWuvLI5y5L7F3yKKlUdFO81DFXaG6YwzlR/wqLfbYID9cpZ+ma/IgLCEH+860w9xw/r6hmYslwNXfRjODe5Uw88ncT+9Hh1O1FIMouZ9wowmUUkQS/KuIx8lr6R3Jb4a8VKcV0tsnNM6/Bny4KSzx4shsNBv+eVlmSozjk56Z7tFp+TKy+6dOStXkIyHe37XOSEas2WErJ6xvL80oi3mIcTaJeynpdDsQvjR2boKEWRtz2reHSAcpbb1MTVos+PnJm1h8ucqVhRxO5dJuxIJskjX0U7srO80DK6KPQefkeXOeBla75LjCTYmCxwQctO27/U3bK89GUszmEdt7bfsCBgI9JoH6CCHUbFQb2gA3ZtVjsS358lR23NPzjrs8kr6ntVKWZ86JdBwwRWIC1Uy12MLr2S3u+iZcRder3ge7M8IdaWdAc4DXW+H5oX52lOti56kDo5/P3Gen/xLezBZL5Zi2bJgHLwBN2mDnUM+A5Yf5V8dHgCCaECCde
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15fc07c5-c717-429c-19be-08d77dd65379
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2019 01:06:17.1963
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BCaaHA9awY1rthJBpTjgea/HzcOllJKqIjJnocFJPVo/PyqhJG+U/O/bQ5cUwORy/ej12Qf+C/dwesh4llL3Ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3818
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gU3ViamVjdDogUmU6IFtQQVRDSCAxLzNdIEFSTTogZHRzOiBpbXg2dWwtMTR4MTQtZXZr
OiBBZGQgc2Vuc29ycycgR1BJTw0KPiByZWd1bGF0b3INCj4gDQo+IE9uIDI0LjEwLjIwMTkgMTE6
NTEsIEFuc29uIEh1YW5nIHdyb3RlOg0KPiA+IE9uIGkuTVg2VUwgMTR4MTQgRVZLIGJvYXJkLCBz
ZW5zb3JzJyBwb3dlciBhcmUgY29udHJvbGxlZCBieQ0KPiA+IEdQSU81X0lPMDIsIGFkZCBHUElP
IHJlZ3VsYXRvciBmb3Igc2Vuc29ycyB0byBtYW5hZ2UgdGhlaXIgcG93ZXIuDQo+ID4NCj4gPiBT
aWduZWQtb2ZmLWJ5OiBBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4NCj4gDQo+IEZv
ciBtZSB0aGlzIGJyZWFrcyBuZXR3b3JrIGJvb3Qgb24gaW14NnVsIGV2aywgcmVsZXZhbnQgbG9n
IHNuaXBwZXQgaXMgdGhpczoNCj4gDQo+ICAgICAgZmVjIDIwYjQwMDAuZXRoZXJuZXQgZXRoMDog
VW5hYmxlIHRvIGNvbm5lY3QgdG8gcGh5DQo+ICAgICAgSVAtQ29uZmlnOiBGYWlsZWQgdG8gb3Bl
biBldGgwDQo+IA0KPiBMb29raW5nIGF0IHNjaGVtYXRpY3MgKFNQRi0yODYxNl9DMi5wZGYpIEkg
c2VlIHRoYXQgU05WU19UQU1QRVIyIHBpbiBpcw0KPiBjb25uZWN0ZWQgdG8gUEVSSV9QV1JFTiB3
aGljaCBjb250cm9scyBWUEVSSV8zVjMgd2hpY2ggaXMgdXNlZCBhY3Jvc3MNCj4gdGhlIGJvYXJk
Og0KPiAgICogU2Vuc29ycyAoVlNFTlNPUl8zVjMpDQo+ICAgKiBFdGhlcm5ldCAoVkVORVRfM1Yz
KQ0KPiAgICogQmx1ZXRvb3RoDQo+ICAgKiBDQU4NCj4gICAqIEFyZHVpbm8gaGVhZGVyDQo+ICAg
KiBDYW1lcmENCj4gDQo+IE1heWJlIHRoZXJlIGFyZSBib2FyZCByZXZpc2lvbiBkaWZmZXJlbmNl
cz8gQXMgZmFyIGFzIEkgY2FuIHRlbGwgdGhpcyByZWd1bGF0b3INCj4gaXMgbm90IHNwZWNpZmlj
IHRvIHNlbnNvcnMgc28gaXQgc2hvdWxkIGJlIGFsd2F5cyBvbi4NCg0KWW91IGFyZSBjb3JyZWN0
LCB0aGlzIHJlZ3VsYXRvciBjb250cm9scyBtYW55IG90aGVyIHBlcmlwaGVyYWxzLCBJIHNob3Vs
ZCBtYWtlIGl0IGFsd2F5cyBPTiBmb3Igbm93DQp0byBtYWtlIHN1cmUgTk9UIGJyZWFrIG90aGVy
IHBlcmlwaGVyYWwsIGFuZCBhZnRlciBhbGwgb3RoZXIgcGVyaXBoZXJhbHMgY29udHJvbGxlZA0K
YnkgdGhpcyByZWd1bGF0b3IgaGF2ZSBhZGRlZCB0aGlzIHJlZ3VsYXRvciBtYW5hZ2VtZW50LCB0
aGVuIHRoZSBhbHdheXMgT04gY2FuIGJlDQpyZW1vdmVkLg0KDQpUaGFua3MsDQpBbnNvbg0K
