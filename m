Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4B18C48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 01:42:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A52FC204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 01:42:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="L/0XFdCf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726423AbfFZBmz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 21:42:55 -0400
Received: from mail-eopbgr20062.outbound.protection.outlook.com ([40.107.2.62]:40846
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726307AbfFZBmy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 21:42:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tZVqGS9K5sTkvVIqgTU2Ye5pdZMkkBpRjs9hZxvDNeY=;
 b=L/0XFdCf6OuHo1+kvO4rhb7yuzIY7ih8d0aqWiJxxxbAZk1Qv3jyZQkZJl79Xg8ftjl9hnDCRlX7L6dbgBIFHjLgSSo/3LLO0Gl/E9y/sexs2ll9FOFqo/i79aZfwzTzA23Thf5B3teyHLguvHKUuoTq/mrLbzzamPD0S+GszdE=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3900.eurprd04.prod.outlook.com (52.134.71.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Wed, 26 Jun 2019 01:42:48 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::3945:fcda:5bdd:8191]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::3945:fcda:5bdd:8191%4]) with mapi id 15.20.2008.014; Wed, 26 Jun 2019
 01:42:48 +0000
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
Thread-Index: AQHVKcBeREE6S4ew/U+TyYIcUsyobqas4eqAgABJq2A=
Date:   Wed, 26 Jun 2019 01:42:48 +0000
Message-ID: <DB3PR0402MB3916AB9F2260B0E46CCDDEC0F5E20@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <20190623123850.22584-1-Anson.Huang@nxp.com>
 <55abafbd-c010-32b5-6d76-26040830d5b0@linaro.org>
In-Reply-To: <55abafbd-c010-32b5-6d76-26040830d5b0@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 01bbb761-a46f-46ff-3e22-08d6f9d7984b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3900;
x-ms-traffictypediagnostic: DB3PR0402MB3900:
x-microsoft-antispam-prvs: <DB3PR0402MB3900636172950BF8AFCEBB21F5E20@DB3PR0402MB3900.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 00808B16F3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(346002)(396003)(39860400002)(136003)(189003)(199004)(3846002)(6116002)(44832011)(81166006)(53936002)(110136005)(8936002)(486006)(74316002)(476003)(256004)(305945005)(68736007)(71200400001)(6436002)(229853002)(2501003)(316002)(9686003)(76176011)(2906002)(81156014)(55016002)(86362001)(6246003)(2201001)(7416002)(8676002)(4326008)(14454004)(33656002)(52536014)(478600001)(66946007)(64756008)(25786009)(5660300002)(66446008)(71190400001)(186003)(7736002)(66476007)(66556008)(76116006)(73956011)(11346002)(26005)(102836004)(446003)(7696005)(99286004)(6506007)(53546011)(66066001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3900;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: w453HTHzL6Zp40JvfUzUu3HLN5JQvqcwNQ+eHuJ+71SbcVo5AR/bALfGKUjX2kPs86BbrTKPoeuqR4rVDQ97z3Ez/UylJI8Pho/pM6CvpHSQaui2Yhq+QHRvP6Yg9nHLcjqhEQpc6fg5OvA/2kxFqI4YXStJbNFLLzdhBwRGReA91M0zOWY5+QM6PdBDApgvWOoxGsxTzOYx2gm7tlJG5wlQXnX2Nn3/LcgZ521GRHgOj+wEbbuHZe1VQU2Vkr13iTTLsBGew6tZoNTOe12ETZdoWRLbL5PO/cKlcQ+FD1Kdl+HhgRHESbh9oFS+y3u3sDSN7Napl8pgacXt3FKOa9rrPQc1Cf6uux2AmDKnwmX4n1a5cviiH4j7dca69wb0rq5rz5pC18TXsLutkArdJ9SoCyovWW2qHuFEYUusV4Y=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01bbb761-a46f-46ff-3e22-08d6f9d7984b
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2019 01:42:48.5468
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: anson.huang@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3900
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
ZC4NCj4gDQo+IElzbid0IGl0IHBvc3NpYmxlIHRvIGNyZWF0ZSBhIGZpeGVkLWNsb2NrIGFuZCBy
ZWZlciB0byBpdD8gU28gbm8gbmVlZCB0byBjcmVhdGUgYQ0KPiBzcGVjaWZpYyBhY3Rpb24gYmVm
b3JlIGNhbGxpbmcgdGltZXJfb2ZfaW5pdCgpID8NCj4gDQoNCkFzIHRoZSBjbG9jayBtdXN0IGJl
IHJlYWR5IGJlZm9yZSB0aGUgVElNRVJfT0ZfREVDTEFSRSwgc28gYWRkaW5nIGEgQ0xLX09GX0RF
Q0xBUkVfRFJJVkVSIGluDQpjbG9jayBkcml2ZXIgdG8gT05MWSByZWdpc3RlciBhIGZpeGVkLWNs
b2NrPyBUaGUgc3lzdGVtIGNvdW50ZXIncyBmcmVxdWVuY3kgYXJlIGRpZmZlcmVudCBvbiBkaWZm
ZXJlbnQNCnBsYXRmb3Jtcywgc28gYWRkaW5nIGZpeGVkIGNsb2NrIGluIHN5c3RlbSBjb3VudGVy
IGRyaXZlciBpcyBOT1QgYSBnb29kIGlkZWEsIE9OTFkgdGhlIERUIG5vZGUgb3IgdGhlDQpjbG9j
ayBkcml2ZXIgY2FuIGNyZWF0ZSB0aGlzIGZpeGVkIGNsb2NrIGFjY29yZGluZyB0byBwbGF0Zm9y
bXMsIGNhbiB5b3UgYWR2aXNlIHdoZXJlIHRvIGNyZWF0ZSB0aGlzIGZpeGVkDQpjbG9jayBpcyBi
ZXR0ZXI/DQoNClRoYW5rcywNCkFuc29uIA0KDQo=
