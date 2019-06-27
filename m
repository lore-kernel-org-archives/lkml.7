Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB5B3C48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 08:11:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 937C32064A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 08:11:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="A8cp/Edw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbfF0ILk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 04:11:40 -0400
Received: from mail-eopbgr150053.outbound.protection.outlook.com ([40.107.15.53]:2886
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726293AbfF0ILj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 04:11:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=testarcselector01; d=microsoft.com; cv=none;
 b=CboDPA0u2HWSVdaaP+Df+cMpOoYieQNAXDsqrVWsbEmrJFdR+vPLOcjN1WhRWjX6ZRpZQw0pbJV8qx1hACImCsyvr/qBT+sTInHRW8uvcKFqYcEj3VecBQMb6aK5wBo6Ae1AQNOH6P4flvxifzTUwoSJy6FwCh2LTbZqOD+xa7M=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=testarcselector01;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OpXPcYBeYABkvaVhRdYDFSI3NN1EBjnFr6WUFBzSEU4=;
 b=moOUuVR7VxY5xCrcNteUPis53VUQYGC7yqsxY2nT606dvaYC+Z718Sbq4spnWBiU72QRR/L98RmuGjx+SFV3s7Jthd7WhcrNTKG9SlvKeGyCoNBk78s6nTh4w48aEmayjfuQnI2Tcy1TBI3pH5p6jtza1s7E5PmuNlpqwxmSQbU=
ARC-Authentication-Results: i=1; test.office365.com
 1;spf=none;dmarc=none;dkim=none;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OpXPcYBeYABkvaVhRdYDFSI3NN1EBjnFr6WUFBzSEU4=;
 b=A8cp/EdwMFkNq+yO7cSXppt98E93ZjoLbDWOuNV/jfaHjSn144gxXfJi3olVrRkoJYIBD5dkBbd1+pfrQ4m65GifVrpX3707q5scA8LlIx707LOfiC4JSkYzseCH2X2owqXCBIglegX2twIyZwRYfDzBrMRzoyZOcu0FJqe3LjQ=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3739.eurprd04.prod.outlook.com (52.134.67.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Thu, 27 Jun 2019 08:11:35 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::3945:fcda:5bdd:8191]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::3945:fcda:5bdd:8191%4]) with mapi id 15.20.2008.014; Thu, 27 Jun 2019
 08:11:35 +0000
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
Thread-Index: AQHVKcBeREE6S4ew/U+TyYIcUsyobqas4eqAgABJq2CAAJdTAIAA60fwgAB88QCAAACyYA==
Date:   Thu, 27 Jun 2019 08:11:35 +0000
Message-ID: <DB3PR0402MB39162DB95FA958AC1425BFFDF5FD0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <20190623123850.22584-1-Anson.Huang@nxp.com>
 <55abafbd-c010-32b5-6d76-26040830d5b0@linaro.org>
 <DB3PR0402MB3916AB9F2260B0E46CCDDEC0F5E20@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <9c017ba9-ac6b-480b-d1f3-120289343101@linaro.org>
 <DB3PR0402MB3916ED4AB17B6DDD2248DD44F5FD0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <8f8aa6e0-5f31-8047-14b5-0e1f65316453@linaro.org>
In-Reply-To: <8f8aa6e0-5f31-8047-14b5-0e1f65316453@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3d5cc1ff-5e8d-492a-32de-08d6fad7128d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3739;
x-ms-traffictypediagnostic: DB3PR0402MB3739:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <DB3PR0402MB3739B30A63C150BE33565C72F5FD0@DB3PR0402MB3739.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 008184426E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(346002)(39860400002)(376002)(136003)(189003)(199004)(6306002)(305945005)(6116002)(102836004)(486006)(256004)(3846002)(476003)(74316002)(81166006)(11346002)(81156014)(446003)(2201001)(229853002)(8936002)(76176011)(68736007)(44832011)(53546011)(66066001)(99286004)(316002)(2906002)(53936002)(6246003)(26005)(2501003)(110136005)(7696005)(186003)(7736002)(9686003)(6506007)(33656002)(55016002)(966005)(7416002)(8676002)(52536014)(45080400002)(66946007)(64756008)(66476007)(76116006)(14454004)(86362001)(71190400001)(478600001)(66556008)(66446008)(73956011)(71200400001)(4326008)(25786009)(6436002)(5660300002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3739;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: AlD9QqCkGnSQYgMHKwikhLLn4MJ1YbFnxb/gupeuHgAwNlG+MKKBUxw89fAA1T7qrKtptinaCCa3l4v4rjAh9pcFAs2Ez+fvMAQcgRQwiyJEc6+nFL15kmkdUsTXdOYPuFDo1hBaXNcYzW6T6lrx2mpO+WCXWbHG/ru67DTnkxG1FArzBvxF1bMDCHlhJj37AYt38px7IF9eM7ucIC4hwW4Kdgx6ZMYRAwwYS5XIy68k5jprCr0y/HOxrVnEPRg/H4eMJectCcwIM/FvUc4JlmjxGqdr+wbrER80YG8fwXlrDE2CHHHetvOOCqzNMWbstx4fYQFkoXjFgbQlcVwUsQMsi3dp0wk73aLMwp4rpDl1XQlecyYEFSTx31gwPoC4degnX43bKHF6Vq7PIH6vYq1idMZ6kkwM8Y2NMSn8gww=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d5cc1ff-5e8d-492a-32de-08d6fad7128d
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2019 08:11:35.5220
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: anson.huang@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3739
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIERhbmllbA0KDQo+IE9uIDI3LzA2LzIwMTkgMDI6NDMsIEFuc29uIEh1YW5nIHdyb3RlOg0K
PiA+IEhpLCBEYW5pZWwNCj4gPg0KPiA+PiBPbiAyNi8wNi8yMDE5IDAzOjQyLCBBbnNvbiBIdWFu
ZyB3cm90ZToNCj4gPj4+IEhpLCBEYW5pZWwNCj4gPj4+DQo+ID4+Pj4gT24gMjMvMDYvMjAxOSAx
NDozOCwgQW5zb24uSHVhbmdAbnhwLmNvbSB3cm90ZToNCj4gPj4+Pj4gRnJvbTogQW5zb24gSHVh
bmcgPEFuc29uLkh1YW5nQG54cC5jb20+DQo+ID4+Pj4+DQo+ID4+Pj4+IFN5c3RlbXMgd2hpY2gg
dXNlIHBsYXRmb3JtIGRyaXZlciBtb2RlbCBmb3IgY2xvY2sgZHJpdmVyIHJlcXVpcmUNCj4gPj4+
Pj4gdGhlIGNsb2NrIGZyZXF1ZW5jeSB0byBiZSBzdXBwbGllZCB2aWEgZGV2aWNlIHRyZWUgd2hl
biBzeXN0ZW0NCj4gPj4+Pj4gY291bnRlciBkcml2ZXIgaXMgZW5hYmxlZC4NCj4gPj4+Pj4NCj4g
Pj4+Pj4gVGhpcyBpcyBuZWNlc3NhcnkgYXMgaW4gdGhlIHBsYXRmb3JtIGRyaXZlciBtb2RlbCB0
aGUgb2ZfY2xrDQo+ID4+Pj4+IG9wZXJhdGlvbnMgZG8gbm90IHdvcmsgY29ycmVjdGx5IGJlY2F1
c2Ugc3lzdGVtIGNvdW50ZXIgZHJpdmVyIGlzDQo+ID4+Pj4+IGluaXRpYWxpemVkIGluIGVhcmx5
IHBoYXNlIG9mIHN5c3RlbSBib290IHVwLCBhbmQgY2xvY2sgZHJpdmVyDQo+ID4+Pj4+IHVzaW5n
IHBsYXRmb3JtIGRyaXZlciBtb2RlbCBpcyBOT1QgcmVhZHkgYXQgdGhhdCB0aW1lLCBpdCB3aWxs
DQo+ID4+Pj4+IGNhdXNlIHN5c3RlbSBjb3VudGVyIGRyaXZlciBpbml0aWFsaXphdGlvbiBmYWls
ZWQuDQo+ID4+Pj4+DQo+ID4+Pj4+IEFkZCB0aGUgb3B0aW5hbCBjbG9jay1mcmVxdWVuY3kgdG8g
dGhlIGRldmljZSB0cmVlIGJpbmRpbmdzIG9mIHRoZQ0KPiA+Pj4+PiBOWFAgc3lzdGVtIGNvdW50
ZXIsIHNvIHRoZSBmcmVxdWVuY3kgY2FuIGJlIGhhbmRlZCBpbiBhbmQgdGhlDQo+ID4+Pj4+IG9m
X2NsayBvcGVyYXRpb25zIGNhbiBiZSBza2lwcGVkLg0KPiA+Pj4+DQo+ID4+Pj4gSXNuJ3QgaXQg
cG9zc2libGUgdG8gY3JlYXRlIGEgZml4ZWQtY2xvY2sgYW5kIHJlZmVyIHRvIGl0PyBTbyBubw0K
PiA+Pj4+IG5lZWQgdG8gY3JlYXRlIGEgc3BlY2lmaWMgYWN0aW9uIGJlZm9yZSBjYWxsaW5nIHRp
bWVyX29mX2luaXQoKSA/DQo+ID4+Pj4NCj4gPj4+DQo+ID4+PiBBcyB0aGUgY2xvY2sgbXVzdCBi
ZSByZWFkeSBiZWZvcmUgdGhlIFRJTUVSX09GX0RFQ0xBUkUsIHNvIGFkZGluZyBhDQo+ID4+PiBD
TEtfT0ZfREVDTEFSRV9EUklWRVIgaW4gY2xvY2sgZHJpdmVyIHRvIE9OTFkgcmVnaXN0ZXIgYSBm
aXhlZC1jbG9jaz8NCj4gPj4+IFRoZSBzeXN0ZW0gY291bnRlcidzIGZyZXF1ZW5jeSBhcmUgZGlm
ZmVyZW50IG9uIGRpZmZlcmVudCBwbGF0Zm9ybXMsDQo+ID4+PiBzbyBhZGRpbmcgZml4ZWQgY2xv
Y2sgaW4gc3lzdGVtIGNvdW50ZXIgZHJpdmVyIGlzIE5PVCBhIGdvb2QgaWRlYSwNCj4gPj4+IE9O
TFkgdGhlIERUIG5vZGUgb3IgdGhlIGNsb2NrIGRyaXZlciBjYW4gY3JlYXRlIHRoaXMgZml4ZWQg
Y2xvY2sNCj4gPj4+IGFjY29yZGluZyB0bw0KPiA+PiBwbGF0Zm9ybXMsIGNhbiB5b3UgYWR2aXNl
IHdoZXJlIHRvIGNyZWF0ZSB0aGlzIGZpeGVkIGNsb2NrIGlzIGJldHRlcj8NCj4gPj4NCj4gPj4g
Q2FuIHlvdSBwb2ludCBtZSB0byBhIERUIHdpdGggdGhlICJueHAsc3lzY3RyLXRpbWVyIiA/DQo+
ID4NCj4gPiBUaGUgRFQgbm9kZSBvZiBzeXN0ZW0gY291bnRlciBpcyBuZXcgYWRkZWQgaW4gMy8z
IG9mIHRoaXMgcGF0Y2gNCj4gPiBzZXJpZXMsIGFsc28gY2FuIGJlIGZvdW5kIGZyb20gYmVsb3cg
bGluazoNCj4gPiBodHRwczovL2V1cjAxLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29t
Lz91cmw9aHR0cHMlM0ElMkYlMkZwYXRjDQo+ID4NCj4gaHdvcmsua2VybmVsLm9yZyUyRnBhdGNo
JTJGMTEwMTE3MDMlMkYmYW1wO2RhdGE9MDIlN0MwMSU3Q2Fuc29uLg0KPiBodWFuZyUNCj4gPg0K
PiA0MG54cC5jb20lN0M4Yjk1MTllY2NlYjM0NjcxMmJlODA4ZDZmYWQ2NzVlNCU3QzY4NmVhMWQz
YmMyYjRjNmYNCj4gYTkyY2Q5OQ0KPiA+DQo+IGM1YzMwMTYzNSU3QzAlN0MwJTdDNjM2OTcyMTk2
MzM4NDA1NTgyJmFtcDtzZGF0YT1zT1FRekRGeG9DcWUNCj4gVnVIRnVZUEhoDQo+ID4gRjhCZGoy
WnU5V1M3R28lMkZWOWxyV2E4JTNEJmFtcDtyZXNlcnZlZD0wDQo+IA0KPiBTb3JyeSwgSSB3YXMg
dW5jbGVhci4gSSBtZWFudCBhIHBhdGNoIHdpdGggdGhlIHRpbWVyIGRlZmluZWQgdXNpbmcgYSBj
bG9jayBhcw0KPiBkZWZpbmVkIGN1cnJlbnRseSBpbiB0aGUgYmluZGluZyAobm8gY2xvY2stZnJl
cXVlbmN5KS4NCg0KT0ssIGZvciBpLk1YOE1NLCB3ZSB1c2UgY2xvY2tzLCBjaGVjayBiZWxvdyBw
YXRjaCBzZXJpZXM6DQoNCmh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcGF0Y2gvMTEwMDg1
MTkvDQoNCmNvZGUgcGllY2UgYXMgYmVsb3c6DQoNCisJCQlzeXN0ZW1fY291bnRlcjogdGltZXJA
MzA2YTAwMDAgew0KKwkJCQljb21wYXRpYmxlID0gIm54cCxzeXNjdHItdGltZXIiOw0KKwkJCQly
ZWcgPSA8MHgzMDZhMDAwMCAweDMwMDAwPjsNCisJCQkJaW50ZXJydXB0cyA9IDxHSUNfU1BJIDQ3
IElSUV9UWVBFX0xFVkVMX0hJR0g+LA0KKwkJCQkJICAgICA8R0lDX1NQSSA0OCBJUlFfVFlQRV9M
RVZFTF9ISUdIPjsNCisJCQkJY2xvY2tzID0gPCZjbGsgSU1YOE1NX0NMS19TWVNfQ1RSPjsNCisJ
CQkJY2xvY2stbmFtZXMgPSAicGVyIjsNCisJCQl9Ow0KDQpUaGFua3MsDQpBbnNvbi4NCg0K
