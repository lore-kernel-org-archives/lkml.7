Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F225AC432C3
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 01:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C343620684
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 01:36:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="mNhH/Cmy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbfLDBga (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 20:36:30 -0500
Received: from mail-eopbgr60050.outbound.protection.outlook.com ([40.107.6.50]:4215
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726115AbfLDBg3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 20:36:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L0lNDnqQHYzF+3YOz3+wzQbBG4HBdzggjmIpTTjiesXnr05q3brhh4hgHJigx1GmItTGAN5+4Z5Qg+nCYsjDIYpZaRTdJwH6JJXQjLBLvPBEr+/55DIFjZKpzsLMZbUx2BlSj6J62uxc5K+LoOrzOG829qnkGan+2srFVxpxerNpHttptsZdjnsoMseKm/vfRyN73X+WsRs9MAyAI8TzJdmOhC5zOy7HGIMPdalQ0sjsuEG+etygvEWo38vESMrazt/vio9aQxEKITAJmkPwIjKJKTxumk91Ja3GByNEiSL+Usowtudk465LL7ECOhO3eAUOWGx5P8jIylrDdXDTBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6BJhSYNQOmD3xItaNZuM7y3MV/fLW4F5EQmy3o6TyR8=;
 b=VQqg7Y3roARSHnOCybOPr0UhWh6LJ76yN7lpV3etigurAj5RxsC2v1owUTZoScOhKgpBrHkuUcqdRFDwWQ2rwYsdSa3xQHXC0vGIc7t3tBLwqwjOQ9PSOA3VDKrgF8yALZOwXDB/6E62hqv4cy14p74ShB3d+EZxzBOuD5xZtuH78phD/R5PU+wAuUZzRpdPabGxHQ6UxEC2xgikFdnK2lFKoNQ+Bzuze+/ITBLyZw/0k5i6INEB5Ktb7WSuI7BksgntE66Xqa/CLvVHDKKHBsj1DwjpeXB11NDYa1/+xGcFV/JWAwcBgA3mXEOuONVP1hyBwpMAHUBF+ujdexx4Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6BJhSYNQOmD3xItaNZuM7y3MV/fLW4F5EQmy3o6TyR8=;
 b=mNhH/Cmyn88L+p7FABLgbNdbflx5+f+TQGzxN4WgBZaJSrHIOewnasEvH4gp80lCKU+9uFcCkIUwm6II1Ane5CzRRe6X41kWZ9jjsso6YQhwd15TigfF2aFI3JrdmrYeiUCLKQAxg4283ZJGUJjAQ5bKNp2+gnNDDrKejnARS78=
Received: from DB7PR04MB5195.eurprd04.prod.outlook.com (20.176.236.27) by
 DB7PR04MB5209.eurprd04.prod.outlook.com (20.176.232.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.12; Wed, 4 Dec 2019 01:36:23 +0000
Received: from DB7PR04MB5195.eurprd04.prod.outlook.com
 ([fe80::742b:b817:f90f:f444]) by DB7PR04MB5195.eurprd04.prod.outlook.com
 ([fe80::742b:b817:f90f:f444%3]) with mapi id 15.20.2495.014; Wed, 4 Dec 2019
 01:36:23 +0000
From:   Wen He <wen.he_1@nxp.com>
To:     Michael Walle <michael@walle.cc>, Rob Herring <robh@kernel.org>
CC:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Leo Li <leoyang.li@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] Re: [v10 1/2] dt/bindings: clk: Add YAML schemas for
 LS1028A Display Clock bindings
Thread-Topic: [EXT] Re: [v10 1/2] dt/bindings: clk: Add YAML schemas for
 LS1028A Display Clock bindings
Thread-Index: AQHVpQum4BUIKQaBGUahPFwO9cJxQqenN/AAgAAt6ACAAdYhkA==
Date:   Wed, 4 Dec 2019 01:36:23 +0000
Message-ID: <DB7PR04MB5195F13A2EBEB903D0CA1DD9E25D0@DB7PR04MB5195.eurprd04.prod.outlook.com>
References: <20191127101525.44516-1-wen.he_1@nxp.com>
 <20191202184758.GA8408@bogus> <e876f247860d728498df37705e7dfba2@walle.cc>
In-Reply-To: <e876f247860d728498df37705e7dfba2@walle.cc>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=wen.he_1@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 804357cc-1dfa-470c-b217-08d7785a5ef7
x-ms-traffictypediagnostic: DB7PR04MB5209:|DB7PR04MB5209:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB7PR04MB52090091ADF33CB61C7B0CB1E25D0@DB7PR04MB5209.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0241D5F98C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(136003)(366004)(396003)(39860400002)(199004)(189003)(13464003)(446003)(8936002)(8676002)(11346002)(6306002)(14454004)(74316002)(81156014)(33656002)(99286004)(2906002)(81166006)(14444005)(256004)(86362001)(3846002)(6116002)(25786009)(6436002)(54906003)(110136005)(229853002)(6246003)(9686003)(316002)(52536014)(76176011)(102836004)(53546011)(6506007)(26005)(4326008)(64756008)(66476007)(66446008)(7736002)(66556008)(66946007)(76116006)(71200400001)(55016002)(45080400002)(71190400001)(186003)(7696005)(305945005)(478600001)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB5209;H:DB7PR04MB5195.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: M1sY9mg99Lz4ldvM6u2ilL0OPIvJPSPMocSJghoKET6P24VJ3DOW+JRmoOKmmLlmT2W+ur/+p4q6WV77zmuDGuDDuNxExMTkKSYI5yhfp5N8AfzcwfB5ddLiiD9EywphwZ20IfeZgbBaUqE8OqObyPLxsioNvOfiDtFpcz5IwVnuZt8VT2etWhFYxzftOaXwfeQvgVEoyF4eBLNWuO+uGClWd1KyJ2UQJ/m7xTmtYGYXm2jwMnM+/VdN4ftEE85r3tCRfpFykSg7gUsoLRxphcZkqAagjeiP1Ys/djVxmnFZ7y0JOq0nKZswaq9a+un5wBcAnTU52EICOOJMVWRAIan70pAGE9i8nxrAIs7HRzsg7r0Ypb6XhZiCkDSN9WAa4CAwZQc07gIZVHrVgDsRxsEvQ6fgAj5hlAkwbxINjviMJV7YEVR4MnTP1fzkoPkTeVcLbHNqlJtPNyj4N69mqZDlclXG8xu0JG6BX0mQcxflQzCiPtjyEZY4wi3ornkU
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 804357cc-1dfa-470c-b217-08d7785a5ef7
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2019 01:36:23.0896
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2J3Z0AMaiAqAenBehufqZIV5AgimU879VZZwBn5OoyiTwpXxiOqWVkRRO1WW619fwPN/125WJlFv7egI+cu7Ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5209
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWljaGFlbCBXYWxsZSA8
bWljaGFlbEB3YWxsZS5jYz4NCj4gU2VudDogMjAxOcTqMTLUwjPI1SA1OjMyDQo+IFRvOiBSb2Ig
SGVycmluZyA8cm9iaEBrZXJuZWwub3JnPg0KPiBDYzogV2VuIEhlIDx3ZW4uaGVfMUBueHAuY29t
PjsgTWljaGFlbCBUdXJxdWV0dGUNCj4gPG10dXJxdWV0dGVAYmF5bGlicmUuY29tPjsgU3RlcGhl
biBCb3lkIDxzYm95ZEBrZXJuZWwub3JnPjsgTWFyaw0KPiBSdXRsYW5kIDxtYXJrLnJ1dGxhbmRA
YXJtLmNvbT47IExlbyBMaSA8bGVveWFuZy5saUBueHAuY29tPjsNCj4gZGV2aWNldHJlZUB2Z2Vy
Lmtlcm5lbC5vcmc7IGxpbnV4LWNsa0B2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LWtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogW0VYVF0gUmU6IFt2MTAgMS8yXSBkdC9iaW5kaW5n
czogY2xrOiBBZGQgWUFNTCBzY2hlbWFzIGZvciBMUzEwMjhBDQo+IERpc3BsYXkgQ2xvY2sgYmlu
ZGluZ3MNCj4gDQo+IENhdXRpb246IEVYVCBFbWFpbA0KPiANCj4gQW0gMjAxOS0xMi0wMiAxOTo0
Nywgc2NocmllYiBSb2IgSGVycmluZzoNCj4gPiBPbiBXZWQsIE5vdiAyNywgMjAxOSBhdCAwNjox
NToyNFBNICswODAwLCBXZW4gSGUgd3JvdGU6DQo+ID4+IExTMTAyOEEgaGFzIGEgY2xvY2sgZG9t
YWluIFBYTENMSzAgdXNlZCBmb3IgcHJvdmlkZSBwaXhlbCBjbG9ja3MgdG8NCj4gPj4gRGlzcGxh
eSBvdXRwdXQgaW50ZXJmYWNlLiBBZGQgYSBZQU1MIHNjaGVtYSBmb3IgdGhpcy4NCj4gPj4NCj4g
Pj4gU2lnbmVkLW9mZi1ieTogV2VuIEhlIDx3ZW4uaGVfMUBueHAuY29tPg0KPiA+PiBTaWduZWQt
b2ZmLWJ5OiBNaWNoYWVsIFdhbGxlIDxtaWNoYWVsQHdhbGxlLmNjPg0KPiA+PiAtLS0NCj4gPj4g
Y2hhbmdlIGluIHYxMDoNCj4gPj4gICAgICAgICAtIEFkZCBvcHRpb25hbCBmZWlsZCAndmNvLWZy
ZXF1ZW5jeScuDQo+ID4+DQo+ID4+ICAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9jbG9jay9mc2ws
cGxsZGlnLnlhbWwgfCA1NA0KPiA+PiArKysrKysrKysrKysrKysrKysrDQo+ID4+ICAxIGZpbGUg
Y2hhbmdlZCwgNTQgaW5zZXJ0aW9ucygrKQ0KPiA+PiAgY3JlYXRlIG1vZGUgMTAwNjQ0DQo+ID4+
IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9jbG9jay9mc2wscGxsZGlnLnlhbWwN
Cj4gPj4NCj4gPj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9jbG9jay9mc2wscGxsZGlnLnlhbWwNCj4gPj4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3MvY2xvY2svZnNsLHBsbGRpZy55YW1sDQo+ID4+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0
DQo+ID4+IGluZGV4IDAwMDAwMDAwMDAwMC4uZWU1YjVjNjFhNDcxDQo+ID4+IC0tLSAvZGV2L251
bGwNCj4gPj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Nsb2NrL2Zz
bCxwbGxkaWcueWFtbA0KPiA+PiBAQCAtMCwwICsxLDU0IEBADQo+ID4+ICsjIFNQRFgtTGljZW5z
ZS1JZGVudGlmaWVyOiBHUEwtMi4wDQo+ID4+ICslWUFNTCAxLjINCj4gPj4gKy0tLQ0KPiA+PiAr
JGlkOg0KPiA+PiAraHR0cHM6Ly9ldXIwMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNv
bS8/dXJsPWh0dHAlM0ElMkYlMkZkZXYNCj4gPj4NCj4gK2ljZXRyZWUub3JnJTJGc2NoZW1hcyUy
RmJpbmRpbmdzJTJGY2xvY2slMkZmc2wlMkNwbGxkaWcueWFtbCUyMyZhbXANCj4gOw0KPiA+Pg0K
PiArZGF0YT0wMiU3QzAxJTdDd2VuLmhlXzElNDBueHAuY29tJTdDYzIzNWFmYzg4ZDg0NGEyMDAy
ZWYwOGQ3Nw0KPiA3NmYxYjMzDQo+ID4+DQo+ICslN0M2ODZlYTFkM2JjMmI0YzZmYTkyY2Q5OWM1
YzMwMTYzNSU3QzAlN0MwJTdDNjM3MTA5MTkxMzk3NzUNCj4gMzk4OCZhbXANCj4gPj4NCj4gKztz
ZGF0YT1WVG1ualo3dHlMQ211MjFkeW1sYTh4VWxwdldYTVlBMEE2RnRjT2c5dTlVJTNEJmFtcDty
ZXMNCj4gZXJ2ZWQ9MA0KPiA+PiArJHNjaGVtYToNCj4gPj4gK2h0dHBzOi8vZXVyMDEuc2FmZWxp
bmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwJTNBJTJGJTJGZGV2DQo+ID4+DQo+
ICtpY2V0cmVlLm9yZyUyRm1ldGEtc2NoZW1hcyUyRmNvcmUueWFtbCUyMyZhbXA7ZGF0YT0wMiU3
QzAxJTdDd2UNCj4gbi5oZV8NCj4gPj4NCj4gKzElNDBueHAuY29tJTdDYzIzNWFmYzg4ZDg0NGEy
MDAyZWYwOGQ3Nzc2ZjFiMzMlN0M2ODZlYTFkM2JjMmINCj4gNGM2ZmE5Mg0KPiA+Pg0KPiArY2Q5
OWM1YzMwMTYzNSU3QzAlN0MwJTdDNjM3MTA5MTkxMzk3NzUzOTg4JmFtcDtzZGF0YT1DRFZYYmNn
DQo+IDlxaWtrWGo2DQo+ID4+ICtiSUFUVHRyQkdXTyUyRllVSG82Wll4NWVycXFScE0lM0QmYW1w
O3Jlc2VydmVkPTANCj4gPj4gKw0KPiA+PiArdGl0bGU6IE5YUCBRb3JJUSBMYXllcnNjYXBlIExT
MTAyOEEgRGlzcGxheSBQSVhFTCBDbG9jayBCaW5kaW5nDQo+ID4+ICsNCj4gPj4gK21haW50YWlu
ZXJzOg0KPiA+PiArICAtIFdlbiBIZSA8d2VuLmhlXzFAbnhwLmNvbT4NCj4gPj4gKw0KPiA+PiAr
ZGVzY3JpcHRpb246IHwNCj4gPj4gKyAgTlhQIExTMTAyOEEgaGFzIGEgY2xvY2sgZG9tYWluIFBY
TENMSzAgdXNlZCBmb3IgdGhlIERpc3BsYXkgb3V0cHV0DQo+ID4+ICsgIGludGVyZmFjZSBpbiB0
aGUgZGlzcGxheSBjb3JlLCBhcyBpbXBsZW1lbnRlZCBpbiBUU01DIENMTjI4SFBNIFBMTC4NCj4g
Pj4gKyAgd2hpY2ggZ2VuZXJhdGUgYW5kIG9mZmVycyBwaXhlbCBjbG9ja3MgdG8gRGlzcGxheS4N
Cj4gPj4gKw0KPiA+PiArcHJvcGVydGllczoNCj4gPj4gKyAgY29tcGF0aWJsZToNCj4gPj4gKyAg
ICBjb25zdDogZnNsLGxzMTAyOGEtcGxsZGlnDQo+ID4+ICsNCj4gPj4gKyAgcmVnOg0KPiA+PiAr
ICAgIG1heEl0ZW1zOiAxDQo+ID4+ICsNCj4gPj4gKyAgJyNjbG9jay1jZWxscyc6DQo+ID4+ICsg
ICAgY29uc3Q6IDANCj4gPj4gKw0KPiA+PiArICB2Y28tZnJlcXVlbmN5Og0KPiA+DQo+ID4gTmVl
ZHMgdmVuZG9yIHByZWZpeCBhbmQgdW5pdCBzdWZmaXg6DQo+ID4NCj4gPiBmc2wsdmNvLWh6DQo+
ID4NCj4gPiBPciB5b3UgY291bGQgcGVyaGFwcyBqdXN0IHVzZSAnY2xvY2stZnJlcXVlbmN5Jy4N
Cj4gDQo+IE9rLCBmc2wsdmNvLWh6IHNvdW5kcyBnb29kLiBjbG9jay1mcmVxdWVuY3kgc291bmRz
IGxpa2UgaXQgaXMgdGhlIG91dHB1dC4NCg0KWWVzLCBmc2wsdmNvLWh6IHNvdW5kcyBnb29kLCBJ
IHdpbGwgdXBkYXRlIGl0IGluIG5leHQgdmVyc2lvbiBwYXRjaC4NCg0KVGhhbmtzLA0KV2VuDQo+
IA0KPiAtbWljaGFlbA0KPiANCj4gPj4gKyAgICAgJHJlZjogJy9zY2hlbWFzL3R5cGVzLnlhbWwj
L2RlZmluaXRpb25zL3VpbnQzMicNCj4gPj4gKyAgICAgZGVzY3JpcHRpb246IE9wdGlvbmFsIGZv
ciBWQ08gZnJlcXVlbmN5IG9mIHRoZSBQTEwgaW4gSGVydHouDQo+ID4+ICsgICAgICAgIFRoZSBW
Q08gZnJlcXVlbmN5IG9mIHRoaXMgUExMIGNhbm5vdCBiZSBjaGFuZ2VkIGR1cmluZw0KPiA+PiBy
dW50aW1lDQo+ID4+ICsgICAgICAgIG9ubHkgYXQgc3RhcnR1cC4gVGhlcmVmb3JlLCB0aGUgb3V0
cHV0IGZyZXF1ZW5jaWVzIGFyZSB2ZXJ5DQo+ID4+ICsgICAgICAgIGxpbWl0ZWQgYW5kIG1pZ2h0
IG5vdCBldmVuIGNsb3NlbHkgbWF0Y2ggdGhlIHJlcXVlc3RlZA0KPiA+PiBmcmVxdWVuY3kuDQo+
ID4+ICsgICAgICAgIFRvIHdvcmsgYXJvdW5kIHRoaXMgcmVzdHJpY3Rpb24gdGhlIHVzZXIgbWF5
IHNwZWNpZnkgaXRzIG93bg0KPiA+PiArICAgICAgICBkZXNpcmVkIFZDTyBmcmVxdWVuY3kgZm9y
IHRoZSBQTEwuIFRoZSBmcmVxdWVuY3kgaGFzIHRvIGJlDQo+ID4+ICsgaW4NCj4gPj4gdGhlDQo+
ID4+ICsgICAgICAgIHJhbmdlIG9mIDY1MDAwMDAwMCB0byAxMzAwMDAwMDAwLg0KPiA+PiArICAg
ICAgICBJZiBub3Qgc2V0LCB0aGUgZGVmYXVsdCBmcmVxdWVuY3kgaXMgMTE4ODAwMDAwMC4NCj4g
Pg0KPiA+IEEgYnVuY2ggb2YgY29uc3RyYWludHMgeW91J3ZlIGxpc3RlZCBoZXJlIHRoYXQgc2hv
dWxkIGJlIHNjaGVtYSByYXRoZXINCj4gPiB0aGFuIGZyZWVmb3JtIHRleHQ6DQo+ID4NCj4gPiBt
aW5pbXVtOiA2NTAwMDAwMDANCj4gPiBtYXhpbXVtOiAxMzAwMDAwMDAwDQo+ID4gZGVmYXVsdDog
MTE4ODAwMDAwMA0KPiA+DQo+ID4+ICsNCj4gPj4gK3JlcXVpcmVkOg0KPiA+PiArICAtIGNvbXBh
dGlibGUNCj4gPj4gKyAgLSByZWcNCj4gPj4gKyAgLSBjbG9ja3MNCj4gPj4gKyAgLSAnI2Nsb2Nr
LWNlbGxzJw0KPiA+PiArDQo+ID4+ICtleGFtcGxlczoNCj4gPj4gKyAgIyBEaXNwbGF5IFBJWEVM
IENsb2NrIG5vZGU6DQo+ID4+ICsgIC0gfA0KPiA+PiArICAgIGRwY2xrOiBjbG9jay1kaXNwbGF5
QGYxZjAwMDAgew0KPiA+PiArICAgICAgICBjb21wYXRpYmxlID0gImZzbCxsczEwMjhhLXBsbGRp
ZyI7DQo+ID4+ICsgICAgICAgIHJlZyA9IDwweDAgMHhmMWYwMDAwIDB4MCAweGZmZmY+Ow0KPiA+
PiArICAgICAgICAjY2xvY2stY2VsbHMgPSA8MD47DQo+ID4+ICsgICAgICAgIGNsb2NrcyA9IDwm
b3NjXzI3bT47DQo+ID4+ICsgICAgfTsNCj4gPj4gKw0KPiA+PiArLi4uDQo+ID4+IC0tDQo+ID4+
IDIuMTcuMQ0KPiA+Pg0K
