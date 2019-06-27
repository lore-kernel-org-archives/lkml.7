Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4E35C48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 12:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DAB320B7C
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 12:49:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Va9BmBj3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbfF0MtY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 08:49:24 -0400
Received: from mail-eopbgr40077.outbound.protection.outlook.com ([40.107.4.77]:46407
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726059AbfF0MtY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 08:49:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=testarcselector01; d=microsoft.com; cv=none;
 b=Exo7p75qBv4ys+sln9+HpecfJv3lb5Am9Ejkp2PnVFHoHvlW+oPqbq87mKRUFtCynkr+GtwH9h1LfuRZ7k1I7E/AgbSHMDQ0lfaDKMCYwGo73OMR3XcD3gXtQgeW4y9e6nwYEQrbeI/6GeO9830pKRn9Y2/uJg/P+rpVrFnix5Q=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=testarcselector01;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KdQAiHw4DTMgueWWA1ISjWDioAUejDLkYqwz+33bSeU=;
 b=qTmGpr7+rW9pjE9co+usvodYkE0kqPxKVBBOxXvRsk6EtrcAaVNDak9DIveFZQKPwCd0M0R3FjnaxbLjQUwtap1CWoSxL2qxHOuBBBOI0FiUS1ukFn42qfCp7xomVDBBjLVHqk7WTckcHaJjGCz/8k4TDii+Vt/b5GQadYngJfc=
ARC-Authentication-Results: i=1; test.office365.com
 1;spf=none;dmarc=none;dkim=none;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KdQAiHw4DTMgueWWA1ISjWDioAUejDLkYqwz+33bSeU=;
 b=Va9BmBj3BV9HKRFsWZvHveqxGnb+eh0pGoGZbpwaC+Fpplf8HvF4xnsPzanVDIg7hlTfJalcWRDQ6lAaZMUpbsvV2QtgiFBX77UDr0toa/l1ekq+7NTf4a8Rg+tPrzlcoSQ2pHIoCwcGw5EsLl/eM9HeS9A4+vTXo2Sm9WfnR9w=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3882.eurprd04.prod.outlook.com (52.134.72.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Thu, 27 Jun 2019 12:49:17 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::3945:fcda:5bdd:8191]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::3945:fcda:5bdd:8191%4]) with mapi id 15.20.2008.014; Thu, 27 Jun 2019
 12:49:17 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>,
        "ccaione@baylibre.com" <ccaione@baylibre.com>,
        "angus@akkea.ca" <angus@akkea.ca>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        "agx@sigxcpu.org" <agx@sigxcpu.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH RESEND V2 2/3] clocksource: imx-sysctr: Make timer work
 with clock driver using platform driver model
Thread-Topic: [PATCH RESEND V2 2/3] clocksource: imx-sysctr: Make timer work
 with clock driver using platform driver model
Thread-Index: AQHVKcBfH+xku/H7o0WEN8jGd5k+rqavdl+AgAACEDA=
Date:   Thu, 27 Jun 2019 12:49:17 +0000
Message-ID: <DB3PR0402MB3916A7348E71A33E4746D5FAF5FD0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <20190623123850.22584-1-Anson.Huang@nxp.com>
 <20190623123850.22584-2-Anson.Huang@nxp.com>
 <41ab1a50-f431-ec73-8444-11ecca1412d8@linaro.org>
In-Reply-To: <41ab1a50-f431-ec73-8444-11ecca1412d8@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [183.192.20.60]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 359d47d4-2820-476c-5483-08d6fafdddda
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3882;
x-ms-traffictypediagnostic: DB3PR0402MB3882:
x-microsoft-antispam-prvs: <DB3PR0402MB38826742ED76716FA26B896CF5FD0@DB3PR0402MB3882.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 008184426E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(366004)(346002)(376002)(396003)(189003)(199004)(44832011)(446003)(6436002)(4326008)(53936002)(25786009)(66066001)(7416002)(33656002)(305945005)(9686003)(478600001)(486006)(229853002)(68736007)(55016002)(110136005)(6116002)(3846002)(71190400001)(2501003)(476003)(71200400001)(256004)(7736002)(66556008)(64756008)(99286004)(66946007)(76176011)(2201001)(5660300002)(73956011)(6506007)(53546011)(66476007)(81156014)(7696005)(8676002)(316002)(76116006)(86362001)(186003)(74316002)(14454004)(8936002)(26005)(2906002)(6246003)(52536014)(102836004)(11346002)(81166006)(66446008)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3882;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 3oGtjZddYP9OfKQ7fZxqf2FIp3cWavQRP2PFrmYzHXKwjyXn8LBGnJ2vk0yqZ3wPzwByYrH4Gih79Mx69s0MtNMUNkj9dZvlLlmTSrpaySA6OtpL/8E5aPVzTNuwoyhDsiVU/80PsTpzmuvXfbZtRFcqw7xhwHtIBdexKKKtLY+PJRxtE0TvkCtDsyFCDPyw8/Y0RTEN3Fb2DhzzXvS2xuFXRNBiz4qY//ahFQqPCAZFD1AHh/+8124XiUr+acl8iQzdJhEC1+/eIZWkP9IhX7nJygwu3Z0rmo5tFae8JnXKd7yR9QlLFx6aho+CA/d752QJW81Kmrug33mr54TzaDRgKDVtje7OjRj1zaPor8lbPO16YYcRpnb9zXm9JO++4PUdm4BncIAy4m8BZewBPUPxgGWGNWuePYHwzYaR+iQ=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 359d47d4-2820-476c-5483-08d6fafdddda
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2019 12:49:17.4067
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: anson.huang@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3882
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIERhbmllbA0KDQo+IE9uIDIzLzA2LzIwMTkgMTQ6MzgsIEFuc29uLkh1YW5nQG54cC5jb20g
d3JvdGU6DQo+ID4gRnJvbTogQW5zb24gSHVhbmcgPEFuc29uLkh1YW5nQG54cC5jb20+DQo+ID4N
Cj4gPiBPbiBzb21lIGkuTVg4TSBwbGF0Zm9ybXMsIGNsb2NrIGRyaXZlciB1c2VzIHBsYXRmb3Jt
IGRyaXZlciBtb2RlbCBhbmQNCj4gPiBpdCBpcyBOT1QgcmVhZHkgZHVyaW5nIHRpbWVyIGluaXRp
YWxpemF0aW9uIHBoYXNlLCB0aGUgY2xvY2sNCj4gPiBvcGVyYXRpb25zIHdpbGwgZmFpbCBhbmQg
c3lzdGVtIGNvdW50ZXIgZHJpdmVyIHdpbGwgZmFpbCB0b28uIEFzIGFsbA0KPiA+IHRoZSBpLk1Y
OE0gcGxhdGZvcm1zJyBzeXN0ZW0gY291bnRlciBjbG9jayBhcmUgZnJvbSBPU0Mgd2hpY2ggaXMN
Cj4gPiBhbHdheXMgZW5hYmxlZCwgc28gaXQgaXMgbm8gbmVlZCB0byBlbmFibGUgY2xvY2sgZm9y
IHN5c3RlbSBjb3VudGVyDQo+ID4gZHJpdmVyLCB0aGUgT05MWSB0aGluZyBpcyB0byBwYXNzIGNs
b2NrIGZyZXF1ZW5jZSB0byBkcml2ZXIuDQo+ID4NCj4gPiBUbyBtYWtlIHN5c3RlbSBjb3VudGVy
IGRyaXZlciB3b3JrIGZvciB1cHBlciBzY2VuYXJpbywgYWRkIGFuIG9wdGlvbg0KPiA+IG9mIHNr
aXBwaW5nIG9mX2NsayBvcGVyYXRpb24gZm9yIHN5c3RlbSBjb3VudGVyIGRyaXZlciwgYW4gb3B0
aW9uYWwNCj4gPiBwcm9wZXJ0eSAiY2xvY2stZnJlcXVlbmN5IiBpcyBpbnRyb2R1Y2VkIHRvIHBh
c3MgdGhlIGZyZXF1ZW5jeSB2YWx1ZQ0KPiA+IHRvIHN5c3RlbSBjb3VudGVyIGRyaXZlciBhbmQg
aW5kaWNhdGUgZHJpdmVyIHRvIHNraXAgb2ZfY2xrDQo+ID4gb3BlcmF0aW9ucy4NCj4gPg0KPiA+
IFNpZ25lZC1vZmYtYnk6IEFuc29uIEh1YW5nIDxBbnNvbi5IdWFuZ0BueHAuY29tPg0KPiA+IC0t
LQ0KPiA+IENoYW5nZXMgc2luY2UgVjE6DQo+ID4gCS0gaW1wcm92ZSBjb21taXQgbG9nLCBubyBj
b250ZW50IGNoYW5nZS4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9jbG9ja3NvdXJjZS90aW1lci1p
bXgtc3lzY3RyLmMgfCA4ICsrKysrKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlv
bnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Nsb2Nrc291cmNlL3RpbWVyLWlt
eC1zeXNjdHIuYw0KPiA+IGIvZHJpdmVycy9jbG9ja3NvdXJjZS90aW1lci1pbXgtc3lzY3RyLmMN
Cj4gPiBpbmRleCBmZDdkNjgwLi44ZmYzZDdlIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvY2xv
Y2tzb3VyY2UvdGltZXItaW14LXN5c2N0ci5jDQo+ID4gKysrIGIvZHJpdmVycy9jbG9ja3NvdXJj
ZS90aW1lci1pbXgtc3lzY3RyLmMNCj4gPiBAQCAtMTI5LDYgKzEyOSwxNCBAQCBzdGF0aWMgdm9p
ZCBfX2luaXQgc3lzY3RyX2Nsb2NrZXZlbnRfaW5pdCh2b2lkKQ0KPiA+IHN0YXRpYyBpbnQgX19p
bml0IHN5c2N0cl90aW1lcl9pbml0KHN0cnVjdCBkZXZpY2Vfbm9kZSAqbnApICB7DQo+ID4gIAlp
bnQgcmV0ID0gMDsNCj4gPiArCXUzMiByYXRlOw0KPiA+ICsNCj4gPiArCWlmICghb2ZfcHJvcGVy
dHlfcmVhZF91MzIobnAsICJjbG9jay1mcmVxdWVuY3kiLA0KPiA+ICsJCQkJICAmcmF0ZSkpIHsN
Cj4gPiArCQl0b19zeXNjdHIub2ZfY2xrLnJhdGUgPSByYXRlOw0KPiA+ICsJCXRvX3N5c2N0ci5v
Zl9jbGsucGVyaW9kID0gRElWX1JPVU5EX1VQKHJhdGUsIEhaKTsNCj4gPiArCQl0b19zeXNjdHIu
ZmxhZ3MgJj0gflRJTUVSX09GX0NMT0NLOw0KPiA+ICsJfQ0KPiANCj4gUGxlYXNlIHRha2UgdGhl
IG9wcG9ydHVuaXR5IHRvIGFkZCB0aGUgVElNRVJfT0ZfQ0xPQ0tfRlJFUVVFTkNZIGZsYWcgaW4N
Cj4gdGltZXItb2YgYW5kIHRoZSBjb3JyZXNwb25kaW5nIGNvZGUgYWJvdmUuDQoNCk9LLCBzbyBh
bm90aGVyIHBhdGNoIGZvciB0aW1lci1vZiBpcyBuZWNlc3NhcnksIGlmIFRJTUVSX09GX0NMT0NL
X0ZSRVFVRU5DWSBmbGFnDQppcyBwcmVzZW50LCBqdXN0IHJlYWQgdGhlICJjbG9jay1mcmVxdWVu
Y3kiIGZyb20gRFQgaW5zdGVhZCBvZiBnZXR0aW5nIGNsb2NrIHJhdGUgZnJvbQ0KY2xvY2sgdHJl
ZSwgcmlnaHQ/IEkgdGhpbmsgdGhpcyBiZWNvbWVzIGEgY29tbW9uIGNhc2UgZm9yIHRpbWVyIGRy
aXZlciwgYXMgbW9yZSBhbmQgbW9yZQ0KcGxhdGZvcm1zIHdpbGwgdXNlIHBsYXRmb3JtIGRyaXZl
ciBtb2RlbCBmb3IgY2xvY2sgZHJpdmVyLCBpdCB3b3VsZCBiZSBnb29kIGlmIHRpbWVyLW9mIGNh
bg0KcHJvdmlkZSBzb2x1dGlvbi4NCg0KPiANCj4gVGhlbiBjaGVjayB0aGUgY2xvY2stZnJlcXVl
bmN5IHByZXNlbmNlIGFuZCBhZGQgVElNRVJfT0ZfQ0xPQ0sgb3INCj4gVElNRVJfT0ZfQ0xPQ0tf
RlJFUVVFTkNZIGZsYWcgdG8gdGhlIHRpbWVyLW9mIHN0cnVjdHVyZS4NCj4gDQo+IGVnOg0KPiAN
Cj4gICAgIHRvX3N5c2N0ci5mbGFncyB8PSBvZl9maW5kX3Byb3BlcnR5KG5wLCAiY2xvY2stZnJl
cXVlbmN5IiwgTlVMTCkgPw0KPiAJCVRJTUVSX09GX0NMT0NLX0ZSRVFVRU5DWSA6IFRJTUVSX09G
X0NMT0NLOw0KPiANCg0KT0suDQoNClRoYW5rcywNCkFuc29uLg0KDQo=
