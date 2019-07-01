Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09336C0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 09:04:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5BE6208E4
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 09:04:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="IXwtjcXk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728308AbfGAJEX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 05:04:23 -0400
Received: from mail-eopbgr70044.outbound.protection.outlook.com ([40.107.7.44]:26340
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728184AbfGAJEW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 05:04:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J/B9Nz9HnfTsn4Z3VA0S3HC5f/shWdUvQluN+kCLvw4=;
 b=IXwtjcXkGlkktyYYK17ZS0Y4pXAyLdeoLQ3NeyssX/pfbrDpDjxmWGqMpE9UbKeD3vtDXOA+GhOBgPFbRtEjx4A65zWBNbKRCCOJWxrkwcc+lwcHd2ZUUSkHLag3VGpZuNn+jGhIiXsaUC4kml2A3MUlwF5hKuUuagwGZDhLx5I=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3689.eurprd04.prod.outlook.com (52.134.69.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.20; Mon, 1 Jul 2019 09:04:15 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::3945:fcda:5bdd:8191]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::3945:fcda:5bdd:8191%4]) with mapi id 15.20.2032.019; Mon, 1 Jul 2019
 09:04:15 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        "ccaione@baylibre.com" <ccaione@baylibre.com>,
        "angus@akkea.ca" <angus@akkea.ca>,
        "agx@sigxcpu.org" <agx@sigxcpu.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V3 1/5] clocksource: timer-of: Support getting clock
 frequency from DT
Thread-Topic: [PATCH V3 1/5] clocksource: timer-of: Support getting clock
 frequency from DT
Thread-Index: AQHVLWMnlUeFgfBl7ke07hMOkfGtpKa1e32AgAAAXbA=
Date:   Mon, 1 Jul 2019 09:04:14 +0000
Message-ID: <DB3PR0402MB3916A54972EE7887FCB18A23F5F90@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <20190628033041.8513-1-Anson.Huang@nxp.com>
 <17a7bde4-e5e0-a746-52a5-1075ce263152@linaro.org>
In-Reply-To: <17a7bde4-e5e0-a746-52a5-1075ce263152@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5c4f9899-f24f-4c02-6f73-08d6fe031767
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3689;
x-ms-traffictypediagnostic: DB3PR0402MB3689:
x-microsoft-antispam-prvs: <DB3PR0402MB36891C8954AD0D3D3A979953F5F90@DB3PR0402MB3689.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 00851CA28B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(346002)(136003)(396003)(376002)(39860400002)(199004)(189003)(7696005)(7736002)(6506007)(14454004)(229853002)(2501003)(8936002)(81156014)(81166006)(8676002)(76176011)(74316002)(186003)(305945005)(26005)(86362001)(102836004)(53546011)(7416002)(476003)(256004)(44832011)(486006)(446003)(11346002)(25786009)(2906002)(53936002)(33656002)(71200400001)(3846002)(6116002)(71190400001)(52536014)(4326008)(99286004)(316002)(9686003)(5660300002)(66066001)(68736007)(110136005)(6246003)(478600001)(2201001)(66476007)(66556008)(64756008)(66446008)(73956011)(66946007)(6436002)(76116006)(55016002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3689;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: R2Yv5x/9JAA7yGSQMi04Un/qvOv7K53FiNL9zWSop9uVx3yIdKFzIoI11xf5fYfDyt3eZklUJYGxiiTMBUCOwtS4lOiQitGtQ4PrIbPgrqACmX3o0nj0K/9urMLb+iIQo6ITvy8KioZCbsIhB3Nipdbo8b6SBV4XN9+tz9ZsTv5UTI9pdoj/i+xAVD/be08AY1xf2p1eicmRaLn5cGHJpPAKUBusg8QanUlh3BhXqIRaHUMpPStn4r9bVhtmEpjCUUt16S86+sI40OpV/MaSe60xOinZTh749AkgGwhn+trTaIiZQOS+ThvMrdm3n3x5zuQiR/bt9J5lX/zHtQjIxF/eKv0lkz59U0D4ZjJ81yktg7MLbxFi+2gud0nhIy+BONFAniskA3z0Zo4HMq53W2dx5VLTovTFRdP63nM0U2M=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c4f9899-f24f-4c02-6f73-08d6fe031767
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2019 09:04:14.8986
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: anson.huang@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3689
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIERhbmllbA0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggVjMgMS81XSBjbG9ja3NvdXJjZTog
dGltZXItb2Y6IFN1cHBvcnQgZ2V0dGluZyBjbG9jaw0KPiBmcmVxdWVuY3kgZnJvbSBEVA0KPiAN
Cj4gDQo+IEhpIEFuc29uLA0KPiANCj4gdGhhbmtzIGZvciB0YWtpbmcgY2FyZSBvZiBhZGRpbmcg
dGhlIGNsb2NrLWZyZXF1ZW5jeSBoYW5kbGluZyBpbiB0aGUgdGltZXItb2YuDQoNClN1cmUuDQoN
Cj4gDQo+IE9uIDI4LzA2LzIwMTkgMDU6MzAsIEFuc29uLkh1YW5nQG54cC5jb20gd3JvdGU6DQo+
ID4gRnJvbTogQW5zb24gSHVhbmcgPEFuc29uLkh1YW5nQG54cC5jb20+DQo+ID4NCj4gPiBNb3Jl
IGFuZCBtb3JlIHBsYXRmb3JtcyB1c2UgcGxhdGZvcm0gZHJpdmVyIG1vZGVsIGZvciBjbG9jayBk
cml2ZXIsIHNvDQo+ID4gdGhlIGNsb2NrIGRyaXZlciBpcyBOT1QgcmVhZHkgZHVyaW5nIHRpbWVy
IGluaXRpYWxpemF0aW9uIHBoYXNlLCBpdA0KPiA+IHdpbGwgY2F1c2UgdGltZXIgaW5pdGlhbGl6
YXRpb24gZmFpbGVkLg0KPiA+DQo+ID4gVG8gc3VwcG9ydCB0aG9zZSBwbGF0Zm9ybXMgd2l0aCB1
cHBlciBzY2VuYXJpbywgaW50cm9kdWNpbmcgYSBuZXcgZmxhZw0KPiA+IFRJTUVSX09GX0NMT0NL
X0ZSRVFVRU5DWSB3aGljaCBpcyBtdXR1YWxseSBleGNsdXNpdmUgd2l0aA0KPiA+IFRJTUVSX09G
X0NMT0NLIGZsYWcgdG8gc3VwcG9ydCBnZXR0aW5nIHRpbWVyIGNsb2NrIGZyZXF1ZW5jeSBmcm9t
IERULA0KPiA+IHRoZW4gb2ZfY2xrIG9wZXJhdGlvbnMgY2FuIGJlIHNraXBwZWQuDQo+ID4NCj4g
PiBVc2VyIG5lZWRzIHRvIHNlbGVjdCBlaXRoZXIgVElNRVJfT0ZfQ0xPQ0tfRlJFUVVFTkNZIG9y
DQo+IFRJTUVSX09GX0NMT0NLDQo+ID4gZmxhZyBpZiB3YW50IHRvIHVzZSB0aW1lci1vZiBkcml2
ZXIgdG8gaW5pdGlhbGl6ZSB0aGUgY2xvY2sgcmF0ZSwgYW5kDQo+ID4gdGhlIGNvcnJlc3BvbmRp
bmcgY2xvY2sgbmFtZSBvciBwcm9wZXJ0eSBuYW1lIG5lZWRzIHRvIGJlIHNwZWNpZmllZC4NCj4g
Pg0KPiA+IFNpZ25lZC1vZmYtYnk6IEFuc29uIEh1YW5nIDxBbnNvbi5IdWFuZ0BueHAuY29tPg0K
PiA+IC0tLQ0KPiA+IE5ldyBwYXRjaDoNCj4gPiAJLSBBZGQgbmV3IGZsYWcgb2YgVElNRVJfT0Zf
Q0xPQ0tfRlJFUVVFTkNZLCBtdXR1YWxseSBleGNsdXNpdmUNCj4gd2l0aCBUSU1FUl9PRl9DTE9D
SywgdG8gc3VwcG9ydA0KPiA+IAkgIGdldHRpbmcgY2xvY2sgZnJlcXVlbmN5IGZyb20gRFQgZGly
ZWN0bHk7DQo+ID4gCS0gQWRkIHByb3BfbmFtZSB0byBvZl90aW1lcl9jbGsgc3RydWN0dXJlLCBp
ZiB1c2luZw0KPiBUSU1FUl9PRl9DTE9DS19GUkVRVUVOQ1kgZmxhZywgdXNlciBuZWVkcw0KPiA+
IAkgIHRvIHBhc3MgdGhlIHByb3BlcnR5IG5hbWUgZm9yIHRpbWVyLW9mIGRyaXZlciB0byBnZXQg
Y2xvY2sgZnJlcXVlbmN5DQo+IGZyb20gRFQsIHRoaXMgaXMgdG8gYXZvaWQNCj4gPiAJICB0aGUg
Y291cGxlIG9mIHRpbWVyLW9mIGRyaXZlciBhbmQgRFQsIHNvIHRpbWVyLW9mIGRyaXZlciBkb2Vz
IE5PVA0KPiB1c2UgYSBmaXhlZCBwcm9wZXJ0eSBuYW1lLg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJz
L2Nsb2Nrc291cmNlL3RpbWVyLW9mLmMgfCAyMyArKysrKysrKysrKysrKysrKysrKysrKw0KPiA+
IGRyaXZlcnMvY2xvY2tzb3VyY2UvdGltZXItb2YuaCB8ICA4ICsrKysrLS0tDQo+ID4gIDIgZmls
ZXMgY2hhbmdlZCwgMjggaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2Nsb2Nrc291cmNlL3RpbWVyLW9mLmMNCj4gPiBiL2RyaXZlcnMv
Y2xvY2tzb3VyY2UvdGltZXItb2YuYyBpbmRleCA4MDU0MjI4Li5jOTFhOGI2IDEwMDY0NA0KPiA+
IC0tLSBhL2RyaXZlcnMvY2xvY2tzb3VyY2UvdGltZXItb2YuYw0KPiA+ICsrKyBiL2RyaXZlcnMv
Y2xvY2tzb3VyY2UvdGltZXItb2YuYw0KPiA+IEBAIC0xNjEsNiArMTYxLDIxIEBAIHN0YXRpYyBf
X2luaXQgaW50IHRpbWVyX29mX2Jhc2VfaW5pdChzdHJ1Y3QNCj4gZGV2aWNlX25vZGUgKm5wLA0K
PiA+ICAJcmV0dXJuIDA7DQo+ID4gIH0NCj4gPg0KPiA+ICtzdGF0aWMgX19pbml0IGludCB0aW1l
cl9vZl9jbGtfZnJlcXVlbmN5X2luaXQoc3RydWN0IGRldmljZV9ub2RlICpucCwNCj4gPiArCQkJ
CQkgICAgICBzdHJ1Y3Qgb2ZfdGltZXJfY2xrICpvZl9jbGspIHsNCj4gPiArCWludCByZXQ7DQo+
ID4gKwl1MzIgcmF0ZTsNCj4gPiArDQo+ID4gKwlyZXQgPSBvZl9wcm9wZXJ0eV9yZWFkX3UzMihu
cCwgb2ZfY2xrLT5wcm9wX25hbWUsICZyYXRlKTsNCj4gPiArCWlmICghcmV0KSB7DQo+ID4gKwkJ
b2ZfY2xrLT5yYXRlID0gcmF0ZTsNCj4gPiArCQlvZl9jbGstPnBlcmlvZCA9IERJVl9ST1VORF9V
UChyYXRlLCBIWik7DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICsJcmV0dXJuIHJldDsNCj4gPiArfQ0K
PiA+ICsNCj4gPiAgaW50IF9faW5pdCB0aW1lcl9vZl9pbml0KHN0cnVjdCBkZXZpY2Vfbm9kZSAq
bnAsIHN0cnVjdCB0aW1lcl9vZiAqdG8pDQo+ID4gew0KPiA+ICAJaW50IHJldCA9IC1FSU5WQUw7
DQo+ID4gQEAgLTE3OCw2ICsxOTMsMTEgQEAgaW50IF9faW5pdCB0aW1lcl9vZl9pbml0KHN0cnVj
dCBkZXZpY2Vfbm9kZSAqbnAsDQo+IHN0cnVjdCB0aW1lcl9vZiAqdG8pDQo+ID4gIAkJaWYgKHJl
dCkNCj4gPiAgCQkJZ290byBvdXRfZmFpbDsNCj4gPiAgCQlmbGFncyB8PSBUSU1FUl9PRl9DTE9D
SzsNCj4gPiArCX0gZWxzZSBpZiAodG8tPmZsYWdzICYgVElNRVJfT0ZfQ0xPQ0tfRlJFUVVFTkNZ
KSB7DQo+ID4gKwkJcmV0ID0gdGltZXJfb2ZfY2xrX2ZyZXF1ZW5jeV9pbml0KG5wLCAmdG8tPm9m
X2Nsayk7DQo+ID4gKwkJaWYgKHJldCkNCj4gPiArCQkJZ290byBvdXRfZmFpbDsNCj4gPiArCQlm
bGFncyB8PSBUSU1FUl9PRl9DTE9DS19GUkVRVUVOQ1k7DQo+ID4gIAl9DQo+IA0KPiAvKiBQcmUt
Y29uZGl0aW9uICovDQo+IA0KPiBpZiAodG8tPmZsYWdzICYgKFRJTUVSX09GX0NMT0NLIHwgVElN
RVJfT0ZfQ0xPQ0tfRlJFUVVFTkNZKSkNCj4gCXJldHVybiAtRUlOVkFMOw0KPiANCj4gWyAuLi4g
XQ0KPiANCj4gaWYgKHRvLT5mbGFncyAmIFRJTUVSX09GX0NMT0NLKSB7DQo+IH0NCj4gDQo+IGlm
ICh0by0+ZmxhZ3MgJiBUSU1FUl9PRl9DTE9DS19GUkVRVUVOQ1kpIHsgfQ0KPiANCg0KQWgsIG1h
a2Ugc2Vuc2UsIHRoZXkgYXJlIGV4Y2x1c2l2ZSwgd2lsbCBhZGQgaXQgaW4gbmV4dCB2ZXJzaW9u
Lg0KDQo+ID4gIAlpZiAodG8tPmZsYWdzICYgVElNRVJfT0ZfSVJRKSB7DQo+ID4gQEAgLTIwMSw2
ICsyMjEsOSBAQCBpbnQgX19pbml0IHRpbWVyX29mX2luaXQoc3RydWN0IGRldmljZV9ub2RlICpu
cCwNCj4gc3RydWN0IHRpbWVyX29mICp0bykNCj4gPiAgCWlmIChmbGFncyAmIFRJTUVSX09GX0NM
T0NLKQ0KPiA+ICAJCXRpbWVyX29mX2Nsa19leGl0KCZ0by0+b2ZfY2xrKTsNCj4gPg0KPiA+ICsJ
aWYgKGZsYWdzICYgVElNRVJfT0ZfQ0xPQ0tfRlJFUVVFTkNZKQ0KPiA+ICsJCXRvLT5vZl9jbGsu
cmF0ZSA9IDA7DQo+ID4gKw0KPiA+ICAJaWYgKGZsYWdzICYgVElNRVJfT0ZfQkFTRSkNCj4gPiAg
CQl0aW1lcl9vZl9iYXNlX2V4aXQoJnRvLT5vZl9iYXNlKTsNCj4gPiAgCXJldHVybiByZXQ7DQo+
ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xvY2tzb3VyY2UvdGltZXItb2YuaA0KPiA+IGIvZHJp
dmVycy9jbG9ja3NvdXJjZS90aW1lci1vZi5oIGluZGV4IGE1NDc4ZjMuLmYxYTA4M2UgMTAwNjQ0
DQo+ID4gLS0tIGEvZHJpdmVycy9jbG9ja3NvdXJjZS90aW1lci1vZi5oDQo+ID4gKysrIGIvZHJp
dmVycy9jbG9ja3NvdXJjZS90aW1lci1vZi5oDQo+ID4gQEAgLTQsOSArNCwxMCBAQA0KPiA+DQo+
ID4gICNpbmNsdWRlIDxsaW51eC9jbG9ja2NoaXBzLmg+DQo+ID4NCj4gPiAtI2RlZmluZSBUSU1F
Ul9PRl9CQVNFCTB4MQ0KPiA+IC0jZGVmaW5lIFRJTUVSX09GX0NMT0NLCTB4Mg0KPiA+IC0jZGVm
aW5lIFRJTUVSX09GX0lSUQkweDQNCj4gPiArI2RlZmluZSBUSU1FUl9PRl9CQVNFCQkJMHgxDQo+
ID4gKyNkZWZpbmUgVElNRVJfT0ZfQ0xPQ0sJCQkweDINCj4gPiArI2RlZmluZSBUSU1FUl9PRl9J
UlEJCQkweDQNCj4gPiArI2RlZmluZSBUSU1FUl9PRl9DTE9DS19GUkVRVUVOQ1kJMHg4DQo+ID4N
Cj4gPiAgc3RydWN0IG9mX3RpbWVyX2lycSB7DQo+ID4gIAlpbnQgaXJxOw0KPiA+IEBAIC0yNiw2
ICsyNyw3IEBAIHN0cnVjdCBvZl90aW1lcl9iYXNlIHsgIHN0cnVjdCBvZl90aW1lcl9jbGsgew0K
PiA+ICAJc3RydWN0IGNsayAqY2xrOw0KPiA+ICAJY29uc3QgY2hhciAqbmFtZTsNCj4gPiArCWNv
bnN0IGNoYXIgKnByb3BfbmFtZTsNCj4gDQo+IEZvciB0aGUgbW9tZW50LCBrZWVwIGl0IGhhcmRj
b2RlZCB3aXRoICJjbG9jay1mcmVxdWVuY3kiIGRpcmVjdGx5IGluIHRoZQ0KPiBmdW5jdGlvbi4N
Cg0KT0ssIHRoZW4gSSB3aWxsIE5PVCBhZGQgYW55IGR0LWJpbmRpbmcgZm9yIHRoaXMgcHJvcGVy
dHkuIFRoZSByZWFzb24gdG8gdXNlIHByb3BfbmFtZQ0KaW5zdGVhZCBvZiBoYXJkY29kZSBpcyBJ
IGRvbid0IHdhbnQgdG8gY3JlYXRlIGEgYmluZGluZyBkb2MganVzdCBmb3IgdGhpcyBwcm9wZXJ0
eS4NCg0KVGhhbmtzLA0KQW5zb24uIA0KDQo=
