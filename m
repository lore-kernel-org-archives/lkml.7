Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA25BECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 14:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7298B2133F
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 14:45:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ICD79ETW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727201AbfJAOpH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 10:45:07 -0400
Received: from mail-eopbgr70084.outbound.protection.outlook.com ([40.107.7.84]:34918
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727051AbfJAOpH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 10:45:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FCKjlRlFk3TA8TCaneS7sIi7VoftPea6mC+tyGxK9xqcAwRdQBsqfvVZ6CzVSnpMJGGv3JpdNRMErO1ZABBpJ+PLK04AxZgOkNnC2a9SWjVbCfofSeT/cjW+xivb8UeWP52aitwq+KiNdmBGVXAPNVEBSe4hqALXJC7jHyWLy+LxdKowN+edsAbf+AFcNrXChcA02ZIRcN/mlAyg8tVCaVZ6pzomXU3pYNUJq46aNDvP1fqKwXj7NCZdgKlvlNeL3lpkXJaunSTxkRQn34GIQNRZFn0pPQ+ZrgV3fbgF3XVPgUOz9wg4LzYxMuuBew05UdNxho7URAKnONTBoHZ7Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fpk5bg8yHFceEbfXDU5pRhdled4cpLLpzt0VL11XZoE=;
 b=b9+gOeE8VPCNW+sI4HJJLaCdiy7cyX742U+7VWHztaj1+NNEjohgFF4PKYpr9EfI8tbvX+XmbnKciccj8SjO1FtluTdL4GAArU2rrdl+QPs899eYT+FAXYujaNTu09MuQ7aALx8K/xTWyNK9s93SdeVkstSYdHNOlXty+mPwm7hVhWg72DYPAvHJ6YZxXrI4WAnaf7t5Yl5wvwKxCFG8vessPbJENMS1h7bmP86r1epOpaRmZqrl/QCBSop3uXFZE7w/+EGLUemIjjkIwnXYi6xwYiN4qoKLN/wq6zNiUITjxL2UC4KS4diJsj/pTpH9fQdy2tHQtsNVc1SaGLtj6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fpk5bg8yHFceEbfXDU5pRhdled4cpLLpzt0VL11XZoE=;
 b=ICD79ETWMJtWg/DvUB9wkvJ6RQpayoQerHpl3mOKZpxDKfvmX8oDbetkooJyvi1e2dovpq4kep9iRVut7GDTY6tICZbjZqdKlnR6vl9VrqOy/x5rGbM7+X6mASqTkclGzQ+7fzTKiWxnbULY2VX9O4WPa6rT3XgMPHh39De+lgU=
Received: from VI1PR04MB4094.eurprd04.prod.outlook.com (52.133.13.160) by
 VI1PR04MB4991.eurprd04.prod.outlook.com (20.177.49.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.17; Tue, 1 Oct 2019 14:45:01 +0000
Received: from VI1PR04MB4094.eurprd04.prod.outlook.com
 ([fe80::6ced:919:ea4f:5000]) by VI1PR04MB4094.eurprd04.prod.outlook.com
 ([fe80::6ced:919:ea4f:5000%6]) with mapi id 15.20.2305.017; Tue, 1 Oct 2019
 14:45:01 +0000
From:   Daniel Baluta <daniel.baluta@nxp.com>
To:     "broonie@kernel.org" <broonie@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "yuehaibing@huawei.com" <yuehaibing@huawei.com>,
        "pierre-louis.bossart@linux.intel.com" 
        <pierre-louis.bossart@linux.intel.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "hulkci@huawei.com" <hulkci@huawei.com>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "perex@perex.cz" <perex@perex.cz>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
Subject: Re: [PATCH] ASoC: SOF: imx: fix reverse CONFIG_SND_SOC_SOF_OF
 dependency
Thread-Topic: [PATCH] ASoC: SOF: imx: fix reverse CONFIG_SND_SOC_SOF_OF
 dependency
Thread-Index: AQHVeGNxrQzh2sOFKEyKM74n1aPArKdF3NMA
Date:   Tue, 1 Oct 2019 14:45:01 +0000
Message-ID: <100bf3142f6043e5d1615d2f99677938770e7c4b.camel@nxp.com>
References: <20191001142026.1124917-1-arnd@arndb.de>
In-Reply-To: <20191001142026.1124917-1-arnd@arndb.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 69a33f01-701e-4a7e-d354-08d7467df078
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: VI1PR04MB4991:|VI1PR04MB4991:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB4991E9145DD1DB459AEA751FF99D0@VI1PR04MB4991.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0177904E6B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(4636009)(39860400002)(366004)(376002)(136003)(346002)(396003)(199004)(189003)(5660300002)(36756003)(91956017)(6512007)(256004)(76116006)(4326008)(229853002)(6486002)(81166006)(110136005)(316002)(25786009)(14454004)(8936002)(6116002)(81156014)(54906003)(118296001)(6436002)(3846002)(6246003)(50226002)(478600001)(11346002)(2616005)(66066001)(486006)(476003)(2906002)(446003)(186003)(66556008)(44832011)(2501003)(102836004)(26005)(305945005)(6506007)(7736002)(64756008)(66446008)(99286004)(71200400001)(66476007)(66946007)(86362001)(8676002)(71190400001)(7416002)(76176011)(99106002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4991;H:VI1PR04MB4094.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kUCTygm93eDpLDRMO7AXuGrmMIlCa6C86+AMXzWYMTYTvBTJHrnUtsGR/kn9U1CQztXnXTJNLV8BNOeOp/vUABA8FBkGN/Puu3HsAFNb27qdYLOozLrMnuoJgekKqT82cRiro824xGo2WqbBSOT6HrAa2M+OXuIK8fovA0w3lk+5tcR+/6uyYe0Pj6vM2KS+JIa+yaXBycElwlH1NWsY3wMQkH0j9/zQaRJHLrmuawsJkNs0gi4bISFkC5j6sYbFQRCB7mSDnlm+BxSJ0QN0w6bhT9kL5Qv9x2K8YXzZv7atB+zcX3PMG8bfo9HUYX95nhzcYg3VgVDHgoC0NUP0G+3Vqpsm+OJ5LcoaYm7wDuDJWPEbEsZ36w3nOXwaojJrYoZtlNhK5X6YC2XLXJyNpjvwMcvAlXmrNh8Y15UcplM=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2201E3394F70494086F1E44768C0FC7B@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69a33f01-701e-4a7e-d354-08d7467df078
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2019 14:45:01.4451
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N/wCaJCl/p8Kz0edEcCdjElILRQmMXzVBmhmqK98e8FsF7j2ChE1i1FOJhdDI2+voX27yjK5lIMPRrFpSKshVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4991
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE5LTEwLTAxIGF0IDE2OjIwICswMjAwLCBBcm5kIEJlcmdtYW5uIHdyb3RlOg0K
PiBDT05GSUdfU05EX1NPQ19TT0ZfSU1YIGRlcGVuZHMgb24gQ09ORklHX1NORF9TT0NfU09GLCBi
dXQgaXMgaW4NCj4gdHVybiByZWZlcmVuY2VkIGJ5IHRoZSBzb2Ytb2YtZGV2IGRyaXZlci4gVGhp
cyBjcmVhdGVzIGEgcmV2ZXJzZQ0KPiBkZXBlbmRlbmN5IHRoYXQgbWFuaWZlc3RzIGluIGEgbGlu
ayBlcnJvciB3aGVuIENPTkZJR19TTkRfU09DX1NPRl9PRg0KPiBpcyBidWlsdC1pbiBidXQgQ09O
RklHX1NORF9TT0NfU09GX0lNWD1tOg0KPiANCj4gc291bmQvc29jL3NvZi9zb2Ytb2YtZGV2Lm86
KC5kYXRhKzB4MTE4KTogdW5kZWZpbmVkIHJlZmVyZW5jZSB0bw0KPiBgc29mX2lteDhfb3BzJw0K
PiANCj4gTWFrZSB0aGUgbGF0dGVyIGEgJ2Jvb2wnIHN5bWJvbCBhbmQgY2hhbmdlIHRoZSBNYWtl
ZmlsZSBzbyB0aGUgaW14OA0KPiBkcml2ZXIgaXMgY29tcGlsZWQgdGhlIHNhbWUgd2F5IGFzIHRo
ZSBkcml2ZXIgdXNpbmcgaXQuDQo+IA0KPiBBIG5pY2VyIHdheSB3b3VsZCBiZSB0byByZXZlcnNl
IHRoZSBsYXllcmluZyBhbmQgbW92ZSBhbGwNCj4gdGhlIGlteCBzcGVjaWZpYyBiaXRzIG9mIHNv
Zi1vZi1kZXYuYyBpbnRvIHRoZSBpbXggZHJpdmVyDQo+IGl0c2VsZiwgd2hpY2ggY2FuIHRoZW4g
Y2FsbCBpbnRvIHRoZSBjb21tb24gY29kZS4gRG9pbmcgdGhpcw0KPiB3b3VsZCBuZWVkIG1vcmUg
dGVzdGluZyBhbmQgY2FuIGJlIGRvbmUgaWYgd2UgYWRkIGFub3RoZXINCj4gZHJpdmVyIGxpa2Ug
dGhlIGZpcnN0IG9uZS4NCj4gDQo+IEZpeGVzOiBmNGRmNGU0MDQyYjAgKCJBU29DOiBTT0Y6IGlt
eDg6IEZpeCBDT01QSUxFX1RFU1QgZXJyb3IiKQ0KPiBGaXhlczogMjAyYWNjNTY1YTFmICgiQVNv
QzogU09GOiBpbXg6IEFkZCBpLk1YOCBIVyBzdXBwb3J0IikNCj4gU2lnbmVkLW9mZi1ieTogQXJu
ZCBCZXJnbWFubiA8YXJuZEBhcm5kYi5kZT4NCg0KQWNrZWQtYnk6IERhbmllbCBCYWx1dGEgPGRh
bmllbC5iYWx1dGFAbnhwLmNvbT4NCg0KSW5kZWVkIHdlIHdpbGwgbmVlZCB0byBzb21laG93IGF2
b2lkIGdldHRpbmcgc29mX2lteDhfb3BzIGZyb20gDQpzb2Ytb2YtZGV2LmMgYnkgZGlyZWN0bHkg
cmVmZXJlbmNpbmcgaXQuIA0KDQpXaWxsIGtlZXAgdGhpcyBpbiBtaW5kIGZvciB0aGUgbmV4dCBw
bGF0Zm9ybS4NCg0KVGhhbmtzIGEgbG90IEFybmQhDQoNCj4gLS0tDQo+ICBzb3VuZC9zb2Mvc29m
L2lteC9LY29uZmlnICB8IDIgKy0NCj4gIHNvdW5kL3NvYy9zb2YvaW14L01ha2VmaWxlIHwgNCAr
KystDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkN
Cj4gDQo+IGRpZmYgLS1naXQgYS9zb3VuZC9zb2Mvc29mL2lteC9LY29uZmlnIGIvc291bmQvc29j
L3NvZi9pbXgvS2NvbmZpZw0KPiBpbmRleCA1YWNhZTc1ZjU3NTAuLmEzODkxNjU0YTFmYyAxMDA2
NDQNCj4gLS0tIGEvc291bmQvc29jL3NvZi9pbXgvS2NvbmZpZw0KPiArKysgYi9zb3VuZC9zb2Mv
c29mL2lteC9LY29uZmlnDQo+IEBAIC0xMiw3ICsxMiw3IEBAIGNvbmZpZyBTTkRfU09DX1NPRl9J
TVhfVE9QTEVWRUwNCj4gIGlmIFNORF9TT0NfU09GX0lNWF9UT1BMRVZFTA0KPiAgDQo+ICBjb25m
aWcgU05EX1NPQ19TT0ZfSU1YOA0KPiAtCXRyaXN0YXRlICJTT0Ygc3VwcG9ydCBmb3IgaS5NWDgi
DQo+ICsJYm9vbCAiU09GIHN1cHBvcnQgZm9yIGkuTVg4Ig0KPiAgCWRlcGVuZHMgb24gSU1YX1ND
VQ0KPiAgCWRlcGVuZHMgb24gSU1YX0RTUA0KPiAgCWhlbHANCj4gZGlmZiAtLWdpdCBhL3NvdW5k
L3NvYy9zb2YvaW14L01ha2VmaWxlIGIvc291bmQvc29jL3NvZi9pbXgvTWFrZWZpbGUNCj4gaW5k
ZXggNmVmOTA4ZThjODA3Li45ZThmMzVkZjBmZjIgMTAwNjQ0DQo+IC0tLSBhL3NvdW5kL3NvYy9z
b2YvaW14L01ha2VmaWxlDQo+ICsrKyBiL3NvdW5kL3NvYy9zb2YvaW14L01ha2VmaWxlDQo+IEBA
IC0xLDQgKzEsNiBAQA0KPiAgIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogKEdQTC0yLjAgT1Ig
QlNELTMtQ2xhdXNlKQ0KPiAgc25kLXNvZi1pbXg4LW9ianMgOj0gaW14OC5vDQo+ICANCj4gLW9i
ai0kKENPTkZJR19TTkRfU09DX1NPRl9JTVg4KSArPSBzbmQtc29mLWlteDgubw0KPiAraWZkZWYg
Q09ORklHX1NORF9TT0NfU09GX0lNWDgNCj4gK29iai0kKENPTkZJR19TTkRfU09DX1NPRl9PRikg
Kz0gc25kLXNvZi1pbXg4Lm8NCj4gK2VuZGlmDQo=
