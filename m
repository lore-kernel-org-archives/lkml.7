Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3004C31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 14:07:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 650712171F
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 14:07:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="agef0fGB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406959AbfHIOHT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 10:07:19 -0400
Received: from mail-eopbgr00105.outbound.protection.outlook.com ([40.107.0.105]:1958
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726297AbfHIOHS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 10:07:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hqkx+/q2LHvTWC/7/mAi8Vkh9vkWwbcBmH2ChQEo4T7ejP109BmWm18U+XVNLdqyShdqCjpfS2cjHHrGMRHHvYWvs+zyVfEx7+Cnwqim+o826vNQJu1PW+XDJ+vBaaaXi2pfBDWiflxvJ0Tx+oGrffDElU5wHPH+7tv2i9+qf53x/fCP5RSNn8IvPynQAv25GrsbCnvpDoAFBEE3DGqOzCWqvbAk4rfnl8t5Rprpe3D12lwGg5Wxo2A5TLTrZ6Gj0tIQSueYmtzcuLd2NhRKfIOVMdU/fiJkHwwp6VSNwbVNYyY+6MVw2hNoJvDwp4HRAbz6Y9kxGnibllfb/58ymg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=chH+Y3xHAG2dV/7GhshlkXVzB3+JwtEP8Rbx90LLk9c=;
 b=N5gjj1ScDnT7pE9MbyhJDX0ZWVfgcf9yR6Bj2raHGrMLLWMajqDn4V78hhb3skWsC9Vt2IRtGj3qn3XPzwR5jmWFVuykZ6JYqzTk+iE5OewfW35AEOYjM5co/Ra3mJq+X66PEwnfymtwQIuX5q3IFuIOkohwfUxmjqvnZhJmOUzk2aL8URhUkbXQwcziByCyZer/9tvZmIxVoTucMbdQtdu2zRrYjmu+5Z6Tv3JLPHswRJcZ+klqsNzmtx4SRD+uHS5XbSDfzPbndooiI+aDT0KJkiHCGPN/jGh+gTF+5XmTe/TzWDeMlBq00H+EHJek71B3I9VirSW5uQuGHIxeJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=chH+Y3xHAG2dV/7GhshlkXVzB3+JwtEP8Rbx90LLk9c=;
 b=agef0fGBCorV9fEIWVTlORsG3l0GEGB7dRxYYVPHTQa8DnWgDCZunyVSSKJ6w4MXvY/OfQfskC+OaEokoiQPmR8dcP6M/wdk3Sn62YmNIR87sOxhEyz6CQ2puOpBwcsKGp9od4iYBtLMKpymyEbRYXdH+X8dR1fFqeG0PQvFKlQ=
Received: from VI1PR05MB6415.eurprd05.prod.outlook.com (20.179.27.139) by
 VI1PR05MB4157.eurprd05.prod.outlook.com (10.171.182.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.18; Fri, 9 Aug 2019 14:07:14 +0000
Received: from VI1PR05MB6415.eurprd05.prod.outlook.com
 ([fe80::f1b2:353a:da9b:c19a]) by VI1PR05MB6415.eurprd05.prod.outlook.com
 ([fe80::f1b2:353a:da9b:c19a%4]) with mapi id 15.20.2157.020; Fri, 9 Aug 2019
 14:07:14 +0000
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
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>
Subject: Re: [PATCH v3 03/21] ARM: dts: imx7-colibri: prepare module device
 tree for FlexCAN
Thread-Topic: [PATCH v3 03/21] ARM: dts: imx7-colibri: prepare module device
 tree for FlexCAN
Thread-Index: AQHVTPnGbE9U8cUOTEK0ccFwNcLdGaby3YiA
Date:   Fri, 9 Aug 2019 14:07:14 +0000
Message-ID: <84c580aadaf4e3007cc43e5f73163bf24af4a1ca.camel@toradex.com>
References: <20190807082556.5013-1-philippe.schenker@toradex.com>
         <20190807082556.5013-4-philippe.schenker@toradex.com>
In-Reply-To: <20190807082556.5013-4-philippe.schenker@toradex.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=marcel.ziswiler@toradex.com; 
x-originating-ip: [2a01:2a8:8501:4d00:ca5b:76ff:fedf:3c49]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c17acd6a-0c2e-4afd-b468-08d71cd2e134
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR05MB4157;
x-ms-traffictypediagnostic: VI1PR05MB4157:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR05MB41575A346C4E36E0FEE32C89FBD60@VI1PR05MB4157.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 01244308DF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(376002)(396003)(366004)(136003)(39850400004)(199004)(189003)(86362001)(8936002)(446003)(6512007)(53936002)(118296001)(25786009)(99286004)(7736002)(476003)(71190400001)(71200400001)(46003)(6246003)(76176011)(102836004)(6506007)(44832011)(256004)(36756003)(14444005)(2501003)(486006)(4326008)(2616005)(11346002)(186003)(66946007)(66476007)(66556008)(64756008)(66446008)(91956017)(76116006)(5660300002)(7416002)(14454004)(2201001)(81166006)(6116002)(2906002)(81156014)(6436002)(6486002)(110136005)(316002)(54906003)(229853002)(305945005)(8676002)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR05MB4157;H:VI1PR05MB6415.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 4dpXwK0L1wxprrwEX70C2vZBXsIz3mOFSW4iZDdk1NaCFNLNhvl5x5gyc2jR8kcLH3C0IQd/RxQwswPSZy00HKcq+2xAvDZk3OPdoZMWpBTWWhazn93hpMYzYpoMmHIQAqOipztHfA68PZxXCvwAZa3AYV3QdcdB2ew7pD+QWEci+ELqx0PA8vMtqYfescK4nFITahylgjWQdlxGztvJ8hL+a02QIdZroavM0mMAZXZFFyFcpattXq4xViU1VAVX+S0ta5ZPe+Fd897wlsflWxSgBokUfcrnU/NVO3DHROMAtsBFLnfG95TaG7RO9EP8vztF1ffNbISFBGbbmmxL8XniPg4vlsOFBidv2X+pxC+HHdW2FA+mBH7wRlY0n5Xc+TYZcihtajdsQmlqEBy+tnVwfFfZAk0R30gXM8jGxO0=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DCEC0E53FD0F3D46901555E1035A3587@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c17acd6a-0c2e-4afd-b468-08d71cd2e134
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2019 14:07:14.2242
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0qRZo+2E0KYhfqC6t8qG+xC6mhvxFCz2a/j44ABgMIF6klOxTyu4B9DChCJL2oQiwWqNJLxUpvm/A49LrW4Yy20myjckenR8vUkjCeOL3po=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4157
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDE5LTA4LTA3IGF0IDA4OjI2ICswMDAwLCBQaGlsaXBwZSBTY2hlbmtlciB3cm90
ZToNCj4gUHJlcGFyZSBGbGV4Q0FOIHVzZSBvbiBTT0RJTU0gNTUvNjMgMTc4LzE4OC4gVGhvc2Ug
U09ESU1NIHBpbnMgYXJlDQo+IGNvbXBhdGlibGUgZm9yIENBTiBidXMgdXNlIHdpdGggc2V2ZXJh
bCBtb2R1bGVzIGZyb20gdGhlIENvbGlicmkNCj4gZmFtaWx5Lg0KPiBBZGQgQmV0dGVyIGRyaXZl
c3RyZW5ndGggYW5kIGFsc28gYWRkIGZsZXhjYW4yLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogUGhp
bGlwcGUgU2NoZW5rZXIgPHBoaWxpcHBlLnNjaGVua2VyQHRvcmFkZXguY29tPg0KDQpBY2tlZC1i
eTogTWFyY2VsIFppc3dpbGVyIDxtYXJjZWwuemlzd2lsZXJAdG9yYWRleC5jb20+DQoNCj4gLS0t
DQo+IA0KPiBDaGFuZ2VzIGluIHYzOiBOb25lDQo+IENoYW5nZXMgaW4gdjI6IE5vbmUNCj4gDQo+
ICBhcmNoL2FybS9ib290L2R0cy9pbXg3LWNvbGlicmkuZHRzaSB8IDM1ICsrKysrKysrKysrKysr
KysrKysrKysrKy0tLQ0KPiAtLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDMwIGluc2VydGlvbnMoKyks
IDUgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMvaW14
Ny1jb2xpYnJpLmR0c2kNCj4gYi9hcmNoL2FybS9ib290L2R0cy9pbXg3LWNvbGlicmkuZHRzaQ0K
PiBpbmRleCBmN2M5Y2U1YmVkNDcuLjUyMDQ2MDg1Y2U2ZiAxMDA2NDQNCj4gLS0tIGEvYXJjaC9h
cm0vYm9vdC9kdHMvaW14Ny1jb2xpYnJpLmR0c2kNCj4gKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMv
aW14Ny1jb2xpYnJpLmR0c2kNCj4gQEAgLTExNyw2ICsxMTcsMTggQEANCj4gIAlmc2wsbWFnaWMt
cGFja2V0Ow0KPiAgfTsNCj4gIA0KPiArJmZsZXhjYW4xIHsNCj4gKwlwaW5jdHJsLW5hbWVzID0g
ImRlZmF1bHQiOw0KPiArCXBpbmN0cmwtMCA9IDwmcGluY3RybF9mbGV4Y2FuMT47DQo+ICsJc3Rh
dHVzID0gImRpc2FibGVkIjsNCj4gK307DQo+ICsNCj4gKyZmbGV4Y2FuMiB7DQo+ICsJcGluY3Ry
bC1uYW1lcyA9ICJkZWZhdWx0IjsNCj4gKwlwaW5jdHJsLTAgPSA8JnBpbmN0cmxfZmxleGNhbjI+
Ow0KPiArCXN0YXR1cyA9ICJkaXNhYmxlZCI7DQo+ICt9Ow0KPiArDQo+ICAmZ3BtaSB7DQo+ICAJ
cGluY3RybC1uYW1lcyA9ICJkZWZhdWx0IjsNCj4gIAlwaW5jdHJsLTAgPSA8JnBpbmN0cmxfZ3Bt
aV9uYW5kPjsNCj4gQEAgLTMzMCwxMiArMzQyLDExIEBADQo+ICANCj4gICZpb211eGMgew0KPiAg
CXBpbmN0cmwtbmFtZXMgPSAiZGVmYXVsdCI7DQo+IC0JcGluY3RybC0wID0gPCZwaW5jdHJsX2dw
aW8xICZwaW5jdHJsX2dwaW8yICZwaW5jdHJsX2dwaW8zDQo+ICZwaW5jdHJsX2dwaW80PjsNCj4g
KwlwaW5jdHJsLTAgPSA8JnBpbmN0cmxfZ3BpbzEgJnBpbmN0cmxfZ3BpbzIgJnBpbmN0cmxfZ3Bp
bzMNCj4gJnBpbmN0cmxfZ3BpbzQNCj4gKwkJICAgICAmcGluY3RybF9ncGlvNz47DQo+ICANCj4g
IAlwaW5jdHJsX2dwaW8xOiBncGlvMS1ncnAgew0KPiAgCQlmc2wscGlucyA9IDwNCj4gLQkJCU1Y
N0RfUEFEX0VORVQxX1JHTUlJX1JEM19fR1BJTzdfSU8zCTB4NzQNCj4gLyogU09ESU1NIDU1ICov
DQo+IC0JCQlNWDdEX1BBRF9FTkVUMV9SR01JSV9SRDJfX0dQSU83X0lPMgkweDc0DQo+IC8qIFNP
RElNTSA2MyAqLw0KPiAgCQkJTVg3RF9QQURfU0FJMV9SWF9TWU5DX19HUElPNl9JTzE2CTB4MTQg
LyoNCj4gU09ESU1NIDc3ICovDQo+ICAJCQlNWDdEX1BBRF9FUERDX0RBVEEwOV9fR1BJTzJfSU85
CQkweDE0DQo+IC8qIFNPRElNTSA4OSAqLw0KPiAgCQkJTVg3RF9QQURfRVBEQ19EQVRBMDhfX0dQ
SU8yX0lPOAkJMHg3NA0KPiAvKiBTT0RJTU0gOTEgKi8NCj4gQEAgLTQxNiw2ICs0MjcsMTMgQEAN
Cj4gIAkJPjsNCj4gIAl9Ow0KPiAgDQo+ICsJcGluY3RybF9ncGlvNzogZ3BpbzctZ3JwIHsgLyog
QWx0ZXJuYXRpdmVseSBDQU4xICovDQo+ICsJCWZzbCxwaW5zID0gPA0KPiArCQkJTVg3RF9QQURf
RU5FVDFfUkdNSUlfUkQzX19HUElPN19JTzMJMHgxNA0KPiAvKiBTT0RJTU0gNTUgKi8NCj4gKwkJ
CU1YN0RfUEFEX0VORVQxX1JHTUlJX1JEMl9fR1BJTzdfSU8yCTB4MTQNCj4gLyogU09ESU1NIDYz
ICovDQo+ICsJCT47DQo+ICsJfTsNCj4gKw0KPiAgCXBpbmN0cmxfaTJjMV9pbnQ6IGkyYzEtaW50
LWdycCB7IC8qIFBNSUMgLyBUT1VDSCAqLw0KPiAgCQlmc2wscGlucyA9IDwNCj4gIAkJCU1YN0Rf
UEFEX0dQSU8xX0lPMTNfX0dQSU8xX0lPMTMJMHg3OQ0KPiBAQCAtNDU5LDEwICs0NzcsMTcgQEAN
Cj4gIAkJPjsNCj4gIAl9Ow0KPiAgDQo+ICsJcGluY3RybF9mbGV4Y2FuMTogZmxleGNhbjEtZ3Jw
IHsNCj4gKwkJZnNsLHBpbnMgPSA8DQo+ICsJCQlNWDdEX1BBRF9FTkVUMV9SR01JSV9SRDNfX0ZM
RVhDQU4xX1RYCTB4NzkNCj4gLyogU09ESU1NIDU1ICovDQo+ICsJCQlNWDdEX1BBRF9FTkVUMV9S
R01JSV9SRDJfX0ZMRVhDQU4xX1JYCTB4NzkNCj4gLyogU09ESU1NIDYzICovDQo+ICsJCT47DQo+
ICsJfTsNCj4gKw0KPiAgCXBpbmN0cmxfZmxleGNhbjI6IGZsZXhjYW4yLWdycCB7DQo+ICAJCWZz
bCxwaW5zID0gPA0KPiAtCQkJTVg3RF9QQURfR1BJTzFfSU8xNF9fRkxFWENBTjJfUlgJMHg1OQ0K
PiAtCQkJTVg3RF9QQURfR1BJTzFfSU8xNV9fRkxFWENBTjJfVFgJMHg1OQ0KPiArCQkJTVg3RF9Q
QURfR1BJTzFfSU8xNF9fRkxFWENBTjJfUlgJMHg3OSAvKg0KPiBTT0RJTU0gMTg4ICovDQo+ICsJ
CQlNWDdEX1BBRF9HUElPMV9JTzE1X19GTEVYQ0FOMl9UWAkweDc5IC8qDQo+IFNPRElNTSAxNzgg
Ki8NCj4gIAkJPjsNCj4gIAl9Ow0K
