Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF5D8C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 14:46:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6064D21743
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 14:46:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="cX0VkzKb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436543AbfHIOq6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 10:46:58 -0400
Received: from mail-eopbgr150110.outbound.protection.outlook.com ([40.107.15.110]:44997
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726342AbfHIOq5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 10:46:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AASEWaM7ddPi8/vQyPzmsXYzbjgRI+jCovtcCJbT/K890fCzH3pvxFe3R2Vc7Fad+HiZuvEBO9BM/i85587nKj4u3MnS10tEgf3ZpS08eJ8z2dTkVpV+L2aMuNFqYRiNQzj405NItssnWNJ22Lr2cZZi4OBNsYZWrbsQFfnht70siVn/+uq19dnXvItIeOFq3w95alclI2/GXZ5LRsN2YEjK+ddzQKJnUrc4TFZE1DIlgkjAclKh6t4ruji9FlQIBrb0DbdpDD14EOeq7WoXOMC0rx+L1yjTZeVygdynNG0v8K3qX8HKTfVB+ZE0O1PvenW7wHxOHdp34RvWJkxBmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t8FGAAqSOIVt6+GeFtwH5HAoWHQ2RZx2+2GiCrZ6l+o=;
 b=IiwZA0k+Z7vCH2hlcm5c+h0pEn42wPdLjUgjsE44zJGtkqH7C6Pe1pswC5KnFxUsu1USqwX5eFmAv99nuPDsQdhX11UuKX7NGc1yVYy+D2iyQ2iTxbm3p9sRFlqTVLQSkX8lDw1wqEXsB1ArtXX983ToPmfz0zsisQSobR5XsLPj8wpqgqpQDCcL0Im4Pn9Iaz5clwa94KVRQFr+yeHT0UssrG+qQomtK0jZBNJBocScVezCa595KkYqpkxN/xd0ljq8ymcLgg7yqWlZ8SWelvFNQW3cTWmTwhNyVAYauIVXnikanQhmpHFJ73lT/qZ5LTKERXE4iVs1hGGPAz8wsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t8FGAAqSOIVt6+GeFtwH5HAoWHQ2RZx2+2GiCrZ6l+o=;
 b=cX0VkzKbpXQIN376ilJq8ULarp6bkl7/CqzCHv/Au5mOxkuNR7o3Bu+18jE2hOGxv0LSW9cbR9U1tqkLOh/miFfqrXrKtD5PPLw6GaAQfaycYB4bMOIHxysoN2QRLFAWS+ICU1M+LRj4m17qm7wKN5JO4WX+Z2LROqMYCQYZits=
Received: from VI1PR05MB6415.eurprd05.prod.outlook.com (20.179.27.139) by
 VI1PR05MB5440.eurprd05.prod.outlook.com (20.177.200.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.18; Fri, 9 Aug 2019 14:46:49 +0000
Received: from VI1PR05MB6415.eurprd05.prod.outlook.com
 ([fe80::f1b2:353a:da9b:c19a]) by VI1PR05MB6415.eurprd05.prod.outlook.com
 ([fe80::f1b2:353a:da9b:c19a%4]) with mapi id 15.20.2157.020; Fri, 9 Aug 2019
 14:46:49 +0000
From:   Marcel Ziswiler <marcel.ziswiler@toradex.com>
To:     Max Krummenacher <max.krummenacher@toradex.com>,
        "stefan@agner.ch" <stefan@agner.ch>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "michal.vokac@ysoft.com" <michal.vokac@ysoft.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Stefan Agner <stefan.agner@toradex.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>
Subject: Re: [PATCH v3 06/21] ARM: dts: imx7-colibri: add GPIO wakeup key
Thread-Topic: [PATCH v3 06/21] ARM: dts: imx7-colibri: add GPIO wakeup key
Thread-Index: AQHVTPnJ+SDlOD7jtU+c0RxdN58MfKby6JcA
Date:   Fri, 9 Aug 2019 14:46:48 +0000
Message-ID: <8088ec7589bea82c185253466dee2276e763d2ce.camel@toradex.com>
References: <20190807082556.5013-1-philippe.schenker@toradex.com>
         <20190807082556.5013-7-philippe.schenker@toradex.com>
In-Reply-To: <20190807082556.5013-7-philippe.schenker@toradex.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=marcel.ziswiler@toradex.com; 
x-originating-ip: [2a01:2a8:8501:4d00:ca5b:76ff:fedf:3c49]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a0518f0f-46da-4fd3-d173-08d71cd868a9
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR05MB5440;
x-ms-traffictypediagnostic: VI1PR05MB5440:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR05MB5440E20445A4D11BE1D5731CFBD60@VI1PR05MB5440.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 01244308DF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(366004)(39850400004)(136003)(376002)(346002)(199004)(189003)(99286004)(6486002)(2906002)(6116002)(5660300002)(229853002)(44832011)(486006)(14444005)(256004)(46003)(86362001)(6436002)(478600001)(476003)(2616005)(71190400001)(71200400001)(11346002)(446003)(14454004)(2201001)(6506007)(186003)(102836004)(76176011)(2501003)(7416002)(64756008)(4326008)(6246003)(66946007)(53936002)(316002)(25786009)(305945005)(91956017)(76116006)(66446008)(7736002)(6512007)(81166006)(36756003)(8676002)(81156014)(54906003)(110136005)(66556008)(66476007)(118296001)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR05MB5440;H:VI1PR05MB6415.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ZP1MyXzz8WVwvROCp/CFmSPfN30ZJiFrOK7Gxa2DaK0f50jzT4sX+r8T3gwr7IEyI406luzASq39/XbPL3vkKbsx4n6l9x2r0WsSeW7nTXg+k+U1B0f+EYjtG4uOHWVRbJAJ5dhAo4xki4ac+3nyOgeJ8eP9pYffk2as02NtJhlkndoHML2VFRZmVSKSspm6lg90WrKAT/B+rJYtoSVsJmZ2BjYL7HBlUHW5no7hdv1/FyRlaniDfq+8YiULRF5TiqctimFAk7kTMOxx9gA19hL4+hb5ASrFDuKg8Z2KXWkwfU3M/xN+OXLSMQnceUXwxAQUJM1B8gS3c6U+b8P658A+Csprl9b2W5uzoni2w790SSPK54yswODrN8Vy20KyqOGDiETCN/hAX0UV2CFtrEfEVpLRDdc553Bbl8zbYjg=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D4D46136C27E614B8CD7EB6377F8E038@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0518f0f-46da-4fd3-d173-08d71cd868a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2019 14:46:48.9058
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d82dEVO4my3EKtk6+WPzFvU6YBGiZSTkP5bSmgtsuntd3r9FbyVrbZKTjbn92DkYRQnp3tNcFDr/eS9ivhvCNGof7IFdhBkclbdl0xU0N0U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5440
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDE5LTA4LTA3IGF0IDA4OjI2ICswMDAwLCBQaGlsaXBwZSBTY2hlbmtlciB3cm90
ZToNCj4gRnJvbTogU3RlZmFuIEFnbmVyIDxzdGVmYW4uYWduZXJAdG9yYWRleC5jb20+DQo+IA0K
PiBBZGQgd2FrZXVwIEdQSU8ga2V5IHdoaWNoIGlzIGFibGUgdG8gd2FrZSB0aGUgc3lzdGVtIGZy
b20gc2xlZXANCj4gbW9kZXMgKGUuZy4gU3VzcGVuZC10by1NZW1vcnkpLg0KPiANCj4gU2lnbmVk
LW9mZi1ieTogU3RlZmFuIEFnbmVyIDxzdGVmYW4uYWduZXJAdG9yYWRleC5jb20+DQo+IFNpZ25l
ZC1vZmYtYnk6IFBoaWxpcHBlIFNjaGVua2VyIDxwaGlsaXBwZS5zY2hlbmtlckB0b3JhZGV4LmNv
bT4NCg0KQWNrZWQtYnk6IE1hcmNlbCBaaXN3aWxlciA8bWFyY2VsLnppc3dpbGVyQHRvcmFkZXgu
Y29tPg0KDQo+IC0tLQ0KPiANCj4gQ2hhbmdlcyBpbiB2MzogTm9uZQ0KPiBDaGFuZ2VzIGluIHYy
OiBOb25lDQo+IA0KPiAgYXJjaC9hcm0vYm9vdC9kdHMvaW14Ny1jb2xpYnJpLWV2YWwtdjMuZHRz
aSB8IDE0ICsrKysrKysrKysrKysrDQo+ICBhcmNoL2FybS9ib290L2R0cy9pbXg3LWNvbGlicmku
ZHRzaSAgICAgICAgIHwgIDcgKysrKysrLQ0KPiAgMiBmaWxlcyBjaGFuZ2VkLCAyMCBpbnNlcnRp
b25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9k
dHMvaW14Ny1jb2xpYnJpLWV2YWwtdjMuZHRzaQ0KPiBiL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDct
Y29saWJyaS1ldmFsLXYzLmR0c2kNCj4gaW5kZXggM2YyNzQ2MTY5MTgxLi5kNGRiYzRmYzFhZGYg
MTAwNjQ0DQo+IC0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDctY29saWJyaS1ldmFsLXYzLmR0
c2kNCj4gKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvaW14Ny1jb2xpYnJpLWV2YWwtdjMuZHRzaQ0K
PiBAQCAtNTIsNiArNTIsMjAgQEANCj4gIAkJY2xvY2stZnJlcXVlbmN5ID0gPDE2MDAwMDAwPjsN
Cj4gIAl9Ow0KPiAgDQo+ICsJZ3Bpby1rZXlzIHsNCj4gKwkJY29tcGF0aWJsZSA9ICJncGlvLWtl
eXMiOw0KPiArCQlwaW5jdHJsLW5hbWVzID0gImRlZmF1bHQiOw0KPiArCQlwaW5jdHJsLTAgPSA8
JnBpbmN0cmxfZ3Bpb2tleXM+Ow0KPiArDQo+ICsJCXBvd2VyIHsNCj4gKwkJCWxhYmVsID0gIldh
a2UtVXAiOw0KPiArCQkJZ3Bpb3MgPSA8JmdwaW8xIDEgR1BJT19BQ1RJVkVfSElHSD47DQo+ICsJ
CQlsaW51eCxjb2RlID0gPEtFWV9XQUtFVVA+Ow0KPiArCQkJZGVib3VuY2UtaW50ZXJ2YWwgPSA8
MTA+Ow0KPiArCQkJZ3Bpby1rZXksd2FrZXVwOw0KPiArCQl9Ow0KPiArCX07DQo+ICsNCj4gIAlw
YW5lbDogcGFuZWwgew0KPiAgCQljb21wYXRpYmxlID0gImVkdCxldDA1NzA5MGRodSI7DQo+ICAJ
CWJhY2tsaWdodCA9IDwmYmw+Ow0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMvaW14
Ny1jb2xpYnJpLmR0c2kNCj4gYi9hcmNoL2FybS9ib290L2R0cy9pbXg3LWNvbGlicmkuZHRzaQ0K
PiBpbmRleCAyNDgwNjIzYzkyZmYuLjE2ZDFhMWVkMWFmZiAxMDA2NDQNCj4gLS0tIGEvYXJjaC9h
cm0vYm9vdC9kdHMvaW14Ny1jb2xpYnJpLmR0c2kNCj4gKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMv
aW14Ny1jb2xpYnJpLmR0c2kNCj4gQEAgLTc0MSwxMiArNzQxLDE3IEBADQo+ICANCj4gIAlwaW5j
dHJsX2dwaW9fbHBzcjogZ3BpbzEtZ3JwIHsNCj4gIAkJZnNsLHBpbnMgPSA8DQo+IC0JCQlNWDdE
X1BBRF9MUFNSX0dQSU8xX0lPMDFfX0dQSU8xX0lPMQkweDU5DQo+ICAJCQlNWDdEX1BBRF9MUFNS
X0dQSU8xX0lPMDJfX0dQSU8xX0lPMgkweDU5DQo+ICAJCQlNWDdEX1BBRF9MUFNSX0dQSU8xX0lP
MDNfX0dQSU8xX0lPMwkweDU5DQo+ICAJCT47DQo+ICAJfTsNCj4gIA0KPiArCXBpbmN0cmxfZ3Bp
b2tleXM6IGdwaW9rZXlzZ3JwIHsNCj4gKwkJZnNsLHBpbnMgPSA8DQo+ICsJCQlNWDdEX1BBRF9M
UFNSX0dQSU8xX0lPMDFfX0dQSU8xX0lPMQkweDE5DQo+ICsJCT47DQo+ICsJfTsNCj4gKw0KPiAg
CXBpbmN0cmxfaTJjMTogaTJjMS1ncnAgew0KPiAgCQlmc2wscGlucyA9IDwNCj4gIAkJCU1YN0Rf
UEFEX0xQU1JfR1BJTzFfSU8wNV9fSTJDMV9TREEJMHg0MDANCj4gMDAwN2YNCg==
