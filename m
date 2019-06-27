Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E283C48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 13:12:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3A502086D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 13:12:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="oCuNwp4r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbfF0NMC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 09:12:02 -0400
Received: from mail-eopbgr30069.outbound.protection.outlook.com ([40.107.3.69]:24386
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726443AbfF0NMC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 09:12:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jr1+A4CoIJZO4uRPJaMb7FmfoDx1VJWnsTWi4Yrj4kg=;
 b=oCuNwp4rYVbYTSgUSZeOYQK5XtG8vS0FGJDY3d2CaDcqBeJc2oBPiSfLAkM8hDXDCoqezciLRE/o70Po9v/44URCLbIR5XR92EAnsueHve6sivbujI2PFRGKFCXRmoeYFZL/Qd1memt9QmALQrC15hE3lMIwzOnCU4Ybp0leYkQ=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3674.eurprd04.prod.outlook.com (52.134.66.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.17; Thu, 27 Jun 2019 13:11:55 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::3945:fcda:5bdd:8191]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::3945:fcda:5bdd:8191%4]) with mapi id 15.20.2008.014; Thu, 27 Jun 2019
 13:11:55 +0000
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
Subject: RE: [PATCH RESEND V2 1/3] clocksource/drivers/sysctr: Add optional
 clock-frequency property
Thread-Topic: [PATCH RESEND V2 1/3] clocksource/drivers/sysctr: Add optional
 clock-frequency property
Thread-Index: AQHVKcBeREE6S4ew/U+TyYIcUsyobqavVD+AgAArhLA=
Date:   Thu, 27 Jun 2019 13:11:55 +0000
Message-ID: <DB3PR0402MB3916D17328CF69C09C74A3D8F5FD0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <20190623123850.22584-1-Anson.Huang@nxp.com>
 <bb362db6-9c50-5d2c-349a-4097dea0449f@linaro.org>
In-Reply-To: <bb362db6-9c50-5d2c-349a-4097dea0449f@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [183.192.20.60]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 00adc900-b886-4ace-98a6-08d6fb01073c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3674;
x-ms-traffictypediagnostic: DB3PR0402MB3674:
x-microsoft-antispam-prvs: <DB3PR0402MB3674B95C1E1280AC49183091F5FD0@DB3PR0402MB3674.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 008184426E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(366004)(39860400002)(396003)(376002)(189003)(199004)(33656002)(8676002)(229853002)(7416002)(186003)(256004)(486006)(44832011)(11346002)(476003)(4326008)(68736007)(2501003)(5660300002)(7736002)(6506007)(305945005)(99286004)(52536014)(478600001)(8936002)(2906002)(81166006)(81156014)(53936002)(53546011)(76116006)(7696005)(76176011)(66476007)(66446008)(64756008)(66556008)(66946007)(6246003)(73956011)(6436002)(26005)(316002)(25786009)(74316002)(102836004)(9686003)(55016002)(3846002)(6116002)(446003)(86362001)(2201001)(110136005)(66066001)(71200400001)(71190400001)(14454004)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3674;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 7jJNvxsyCTQ135scMd33xc4hLbEzGMbjmz09n/fSehcR33gMzau9DICezjTdesKe8T1EAnRSH5cEZqNx4BHBmSXg0rLOe0MSMi6a968wTkG5hgEkvKeVRBgyt1+2bfvMpiRSP8sm8TioRbaM/a9xux8bJGsBTLq+9gqrp89Q5qkVMNaSsFvi3D6zbvVSipDJZMZe9p1GkbvlaTtXgy0fClZ95qCCH/7yPJSQgYu/Mp+gPdE8utbZRdkKWbM5alyYIA4uYqzMuY/P3AgXormRhcBGx5O7/pu3Ssc6mh2DTqe/Nf0rnx+wGAYbE+tcaB/loY+hFSTL0IxFXQVJfIEaXDvPRqnB5qfHLs3s5E7Mcgn4oR8ZaO9tDNd012ALPylQeLb36LH3+0V23AM13hrXIqMHXZeYOeFrRqBj4c6NjA4=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00adc900-b886-4ace-98a6-08d6fb01073c
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2019 13:11:55.3665
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: anson.huang@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3674
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIERhbmllbA0KDQo+IE9uIDIzLzA2LzIwMTkgMTQ6MzgsIEFuc29uLkh1YW5nQG54cC5jb20g
d3JvdGU6DQo+ID4gRnJvbTogQW5zb24gSHVhbmcgPEFuc29uLkh1YW5nQG54cC5jb20+DQo+ID4N
Cj4gPiBTeXN0ZW1zIHdoaWNoIHVzZSBwbGF0Zm9ybSBkcml2ZXIgbW9kZWwgZm9yIGNsb2NrIGRy
aXZlciByZXF1aXJlIHRoZQ0KPiA+IGNsb2NrIGZyZXF1ZW5jeSB0byBiZSBzdXBwbGllZCB2aWEg
ZGV2aWNlIHRyZWUgd2hlbiBzeXN0ZW0gY291bnRlcg0KPiA+IGRyaXZlciBpcyBlbmFibGVkLg0K
PiA+DQo+ID4gVGhpcyBpcyBuZWNlc3NhcnkgYXMgaW4gdGhlIHBsYXRmb3JtIGRyaXZlciBtb2Rl
bCB0aGUgb2ZfY2xrDQo+ID4gb3BlcmF0aW9ucyBkbyBub3Qgd29yayBjb3JyZWN0bHkgYmVjYXVz
ZSBzeXN0ZW0gY291bnRlciBkcml2ZXIgaXMNCj4gPiBpbml0aWFsaXplZCBpbiBlYXJseSBwaGFz
ZSBvZiBzeXN0ZW0gYm9vdCB1cCwgYW5kIGNsb2NrIGRyaXZlciB1c2luZw0KPiA+IHBsYXRmb3Jt
IGRyaXZlciBtb2RlbCBpcyBOT1QgcmVhZHkgYXQgdGhhdCB0aW1lLCBpdCB3aWxsIGNhdXNlIHN5
c3RlbQ0KPiA+IGNvdW50ZXIgZHJpdmVyIGluaXRpYWxpemF0aW9uIGZhaWxlZC4NCj4gPg0KPiA+
IEFkZCB0aGUgb3B0aW5hbCBjbG9jay1mcmVxdWVuY3kgdG8gdGhlIGRldmljZSB0cmVlIGJpbmRp
bmdzIG9mIHRoZSBOWFANCj4gPiBzeXN0ZW0gY291bnRlciwgc28gdGhlIGZyZXF1ZW5jeSBjYW4g
YmUgaGFuZGVkIGluIGFuZCB0aGUgb2ZfY2xrDQo+ID4gb3BlcmF0aW9ucyBjYW4gYmUgc2tpcHBl
ZC4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEFuc29uIEh1YW5nIDxBbnNvbi5IdWFuZ0BueHAu
Y29tPg0KPiA+IC0tLQ0KPiA+IENoYW5nZXMgc2luY2UgVjE6DQo+ID4gCS0gaW1wcm92ZSBjb21t
aXQgbG9nLCBubyBjb250ZW50IGNoYW5nZS4NCj4gPiAtLS0NCj4gPiAgRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL3RpbWVyL254cCxzeXNjdHItdGltZXIudHh0IHwgNg0KPiA+ICsr
KysrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZm
IC0tZ2l0DQo+ID4gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdGltZXIvbnhw
LHN5c2N0ci10aW1lci50eHQNCj4gPiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy90aW1lci9ueHAsc3lzY3RyLXRpbWVyLnR4dA0KPiA+IGluZGV4IGQ1NzY1OTkuLmM5OTA3YTAg
MTAwNjQ0DQo+ID4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3RpbWVy
L254cCxzeXNjdHItdGltZXIudHh0DQo+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL3RpbWVyL254cCxzeXNjdHItdGltZXIudHh0DQo+ID4gQEAgLTE0LDYgKzE0LDEx
IEBAIFJlcXVpcmVkIHByb3BlcnRpZXM6DQo+ID4gIC0gY2xvY2tzIDogCSAgICBTcGVjaWZpZXMg
dGhlIGNvdW50ZXIgY2xvY2suDQo+ID4gIC0gY2xvY2stbmFtZXM6IAkgICAgU3BlY2lmaWVzIHRo
ZSBjbG9jaydzIG5hbWUgb2YgdGhpcyBtb2R1bGUNCj4gPg0KPiA+ICtPcHRpb25hbCBwcm9wZXJ0
aWVzOg0KPiA+ICsNCj4gPiArLSBjbG9jay1mcmVxdWVuY3kgOiBTcGVjaWZpZXMgc3lzdGVtIGNv
dW50ZXIgY2xvY2sgZnJlcXVlbmN5IGFuZCBpbmRpY2F0ZXMNCj4gc3lzdGVtDQo+ID4gKwkJICAg
IGNvdW50ZXIgZHJpdmVyIHRvIHNraXAgY2xvY2sgb3BlcmF0aW9ucy4NCj4gPiArDQo+IA0KPiBT
aG91bGRuJ3QgaXQgYmUgcmVxdWlyZWQgYW5kIG11dHVhbGx5IGV4Y2x1c2l2ZSB3aXRoIGNsb2Nr
cy9jbG9jay1uYW1lcz8NCj4NClllcywgbWFrZSBzZW5zZSwgSSBldmVyIHRob3VnaHQgYWJvdXQg
aXQgd2hlbiBkb2luZyB0aGlzIHBhdGNoLCBidXQgZXZlbnR1YWxseSBJIHBpY2tlZA0KdGhlIG9w
dGlvbmFsLi4ud2lsbCBmaXggaXQgaW4gbmV4dCB2ZXJzaW9uLg0KDQpUaGFua3MsDQpBbnNvbg0K
DQo+ID4gIEV4YW1wbGU6DQo+ID4NCj4gPiAgCXN5c3RlbV9jb3VudGVyOiB0aW1lckAzMDZhMDAw
MCB7DQo+ID4gQEAgLTIyLDQgKzI3LDUgQEAgRXhhbXBsZToNCj4gPiAgCQljbG9ja3MgPSA8JmNs
a184bT47DQo+ID4gIAkJY2xvY2stbmFtZXMgPSAicGVyIjsNCj4gPiAgCQlpbnRlcnJ1cHRzID0g
PEdJQ19TUEkgNDcgSVJRX1RZUEVfTEVWRUxfSElHSD47DQo+ID4gKwkJY2xvY2stZnJlcXVlbmN5
ID0gPDgzMzMzMzM+Ow0KPiA+ICAJfTsNCj4gPg0KPiANCj4gDQoNCg==
