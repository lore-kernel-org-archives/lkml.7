Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 774CEC3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 08:36:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 370F72082C
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 08:36:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=micron.com header.i=@micron.com header.b="c0rJMW+O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727201AbfHSIgT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 04:36:19 -0400
Received: from mail-eopbgr680055.outbound.protection.outlook.com ([40.107.68.55]:28133
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725768AbfHSIgS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 04:36:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YH4zLeLk1bz9nIqLnR8FPhGaQToVFYgJelUE5FCAcKMOnLV2TTg2NoIxw4xUo9MQUpCRC2vSTqq/rUkQ5Lta2KjPd3Dnw1j4HC/I+ifKZgQQKLvUeC+6Dmk+ig7drht5M08mJRSznvaiFQA+1W1MLLO+Psu8dqYk+rAjm1OJn2dic1M1mF1cw02ci6ry67clz31qGxK3QcYaZjeKTd4zHg0cT0hjbLtULkiqMJmpTcr97/lkdhmRVVFewayfjRZrJHELTpAnnTzksu1rdUHnjbihxfy98xLMVB7ydJugGM0fBKoUsBxfm2zpmaS5ii3NKUHiXsKuPi/DUQ4UR8hSrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aYGd7kmcuvHpWOEGKJ8zC+OR+51b7BV9nH+wyLcvBi8=;
 b=Aw+MmWcliF830sgD6j5sGcDie8GG/H2PDhe7O+c+AKmNOdgHj+gGuGkC/SvEsO/PgNT7oELzwM+pR1KyVORRckpCz91K5DrbyURbCuiEJdl/3pTbUHJ0z1rLkcwJwWrXSpFfGq0k6PRCG87frrstEB2X+vFdMDSyFQjXfAKOHgm/1Sy7iGKCzqlVSnEdUgGtZhcQPNfJrYXQseEOmRiuYb4hbdP5gEx7py0FGsPYhbH3YtOlViME2ypnuKVONqlIbZ+ElRbQzWssQj1ZxkSQnUo5S0hwgdc+lHGU+uV3IK6dYy0Dwe3IghS3GsTeHWGr+dKOjfRVnU99IdGYCnsllg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=micron.com; dmarc=pass action=none header.from=micron.com;
 dkim=pass header.d=micron.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aYGd7kmcuvHpWOEGKJ8zC+OR+51b7BV9nH+wyLcvBi8=;
 b=c0rJMW+ObSlnCgfHllmcg1CA3o3lq1QKjVBTVTzqopFdwUv8Qr+1JIT4St8mQtLs3RwJcGMbsl22Uzl4g5WD81hj5r/G40ZJ+irrnRdDPJ/u2f9onjKrHAhGxGfaL/3Xk7WMxt6lRCZyh7IZxCaxSItY9jLYBNif9AQfdpe3qeU=
Received: from MN2PR08MB5951.namprd08.prod.outlook.com (20.179.85.220) by
 MN2PR08MB6302.namprd08.prod.outlook.com (52.132.170.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Mon, 19 Aug 2019 08:36:12 +0000
Received: from MN2PR08MB5951.namprd08.prod.outlook.com
 ([fe80::7548:c632:9c57:9252]) by MN2PR08MB5951.namprd08.prod.outlook.com
 ([fe80::7548:c632:9c57:9252%6]) with mapi id 15.20.2178.016; Mon, 19 Aug 2019
 08:36:12 +0000
From:   "Shivamurthy Shastri (sshivamurthy)" <sshivamurthy@micron.com>
To:     'Miquel Raynal' <miquel.raynal@bootlin.com>
CC:     Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jeff Kletsky <git-commits@allycomm.com>,
        Chuanhong Guo <gch981213@gmail.com>,
        liaoweixiong <liaoweixiong@allwinnertech.com>
Subject: RE: [EXT] Re: [PATCH 2/8] mtd: nand: move support functions for ONFI
 to nand/onfi.c
Thread-Topic: [EXT] Re: [PATCH 2/8] mtd: nand: move support functions for ONFI
 to nand/onfi.c
Thread-Index: AQHVTP8CxZaP+1UG+ESMKrv/Of4Vi6b3b3UA
Date:   Mon, 19 Aug 2019 08:36:11 +0000
Message-ID: <MN2PR08MB5951FC43B93D6B1868D5AD6EB8A80@MN2PR08MB5951.namprd08.prod.outlook.com>
References: <20190722055621.23526-1-sshivamurthy@micron.com>
        <20190722055621.23526-3-sshivamurthy@micron.com>
 <20190807110332.748d2c14@xps13>
In-Reply-To: <20190807110332.748d2c14@xps13>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=sshivamurthy@micron.com; 
x-originating-ip: [165.225.81.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4757e1f3-c1e2-405b-41a6-08d724804a8c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MN2PR08MB6302;
x-ms-traffictypediagnostic: MN2PR08MB6302:|MN2PR08MB6302:|MN2PR08MB6302:
x-microsoft-antispam-prvs: <MN2PR08MB630215803D5F3093E795ABB5B8A80@MN2PR08MB6302.namprd08.prod.outlook.com>
x-ms-exchange-transport-forked: True
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-forefront-prvs: 0134AD334F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(376002)(346002)(396003)(39860400002)(366004)(189003)(199004)(446003)(5660300002)(229853002)(6246003)(8676002)(99286004)(54906003)(7416002)(6916009)(66066001)(81166006)(486006)(55016002)(316002)(11346002)(86362001)(8936002)(7736002)(74316002)(14454004)(7696005)(476003)(53936002)(76176011)(478600001)(305945005)(81156014)(9686003)(102836004)(186003)(6436002)(52536014)(26005)(6506007)(55236004)(256004)(14444005)(76116006)(4326008)(66446008)(64756008)(66556008)(66476007)(66946007)(2906002)(33656002)(25786009)(3846002)(6116002)(71190400001)(71200400001)(66574012);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR08MB6302;H:MN2PR08MB5951.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: micron.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /c2ILox4VfPug8A/ozGCG/reVQmHiRKUTmuoJRPVKGtFwrp3nF/pYzOYeu9eW8wHU+E8GkVHZKRUtLoOhkQYG8CDbfOXBpiruz/DflgJBG00m0kwyDJ4jQxyq5ltayhVGT4/fOarBZeUNey8zJBRltjE6V6HAPUDKHu2OoNQ2WwU+ogLqQHVTRJ2EpDL3+595eUqK682giDResjaFOzabv96CG1KS7+HTTShRjrWhVsw4RufjjHH8RN4dzLFJ2eBHDpgcRtCltZpnTufTZNQbhqB4ZFfpFdoa+S5ibNELWpGd/ZrMHQieC+/BRwkjhkBgYBCA1zR1jaUzbN1LM5+e9wWl2a110H1wLIih5TIOF0Y9kijJyoS1leD8oHhSfgdJL+cOj7oCQzjGw4KGJ5+qx5EcCsglZ03wskMNSkJyp0=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4757e1f3-c1e2-405b-41a6-08d724804a8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2019 08:36:11.8695
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ++d/HfjqpT8pxzdtYgqDe8qinEMcHIwM8qFIUJnoGgGxheFa+bH/KmpnCm2f+bdKVON1wxwN7cRfLN/MknO5xQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR08MB6302
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWlxdWVsLA0KDQo+IA0KPiBIaSBzaGl2YS5saW51eHdvcmtzQGdtYWlsLmNvbSwNCj4gDQo+
IHNoaXZhLmxpbnV4d29ya3NAZ21haWwuY29tIHdyb3RlIG9uIE1vbiwgMjIgSnVsIDIwMTkgMDc6
NTY6MTUgKzAyMDA6DQo+IA0KPiA+IEZyb206IFNoaXZhbXVydGh5IFNoYXN0cmkgPHNzaGl2YW11
cnRoeUBtaWNyb24uY29tPg0KPiANCj4gIm10ZDogbmFuZDogbW92ZSBPTkZJIHNwZWNpZmljIGhl
bHBlcnMgdG8gbmFuZC9vbmZpLmMiPw0KDQpJIHdpbGwgdXNlIHRoaXMuDQoNCj4gDQo+ID4NCj4g
PiBUaGVzZSBmdW5jdGlvbnMgYXJlIHN1cHBvcnQgZnVuY3Rpb25zIGZvciBlbmFibGluZyBPTkZJ
IHN0YW5kYXJkIGFuZA0KPiA+IGNvbW1vbiBiZXR3ZWVuIHJhdyBOQU5EIGFuZCBTUEkgTkFORC4N
Cj4gDQo+ICINCj4gVGhlc2UgYXJlIE9ORkkgc3BlY2lmaWMgaGVscGVycyB0aGF0IG1pZ2h0IGJl
IHNoYXJlZCBiZXR3ZWVuIHJhdyBhbmQNCj4gU1BJIE5BTkQgbG9naWNzLCBtb3ZlIHRoZW0gdG8g
YSBnZW5lcmljIHBsYWNlLg0KPiANCj4gV2hpbGUgYXQgaXQsIGFkZCBrZXJuZWwgZG9jIG9uIHRo
ZSBmdW5jdGlvbiBwYXJhbWV0ZXJzLg0KPiAiDQo+IA0KDQpJIHdpbGwgdXNlIHRoaXMuDQoNCj4g
Pg0KPiA+IFNpZ25lZC1vZmYtYnk6IFNoaXZhbXVydGh5IFNoYXN0cmkgPHNzaGl2YW11cnRoeUBt
aWNyb24uY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL210ZC9uYW5kL01ha2VmaWxlICAgICAg
ICB8ICAyICstDQo+ID4gIGRyaXZlcnMvbXRkL25hbmQvb25maS5jICAgICAgICAgIHwgODkNCj4g
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiAgZHJpdmVycy9tdGQvbmFuZC9y
YXcvbmFuZF9iYXNlLmMgfCAxOCAtLS0tLS0tDQo+ID4gIGRyaXZlcnMvbXRkL25hbmQvcmF3L25h
bmRfb25maS5jIHwgNDMgLS0tLS0tLS0tLS0tLS0tDQo+ID4gIDQgZmlsZXMgY2hhbmdlZCwgOTAg
aW5zZXJ0aW9ucygrKSwgNjIgZGVsZXRpb25zKC0pDQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBk
cml2ZXJzL210ZC9uYW5kL29uZmkuYw0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbXRk
L25hbmQvTWFrZWZpbGUgYi9kcml2ZXJzL210ZC9uYW5kL01ha2VmaWxlDQo+ID4gaW5kZXggN2Vj
ZDgwYzBhNjZlLi4yMjE5NDVjMjIzYzMgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9tdGQvbmFu
ZC9NYWtlZmlsZQ0KPiA+ICsrKyBiL2RyaXZlcnMvbXRkL25hbmQvTWFrZWZpbGUNCj4gPiBAQCAt
MSw2ICsxLDYgQEANCj4gPiAgIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMA0KPiA+
DQo+ID4gLW5hbmRjb3JlLW9ianMgOj0gY29yZS5vIGJidC5vDQo+ID4gK25hbmRjb3JlLW9ianMg
Oj0gY29yZS5vIGJidC5vIG9uZmkubw0KPiA+ICBvYmotJChDT05GSUdfTVREX05BTkRfQ09SRSkg
Kz0gbmFuZGNvcmUubw0KPiA+DQo+ID4gIG9iai15CSs9IG9uZW5hbmQvDQo+ID4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvbXRkL25hbmQvb25maS5jIGIvZHJpdmVycy9tdGQvbmFuZC9vbmZpLmMNCj4g
PiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiA+IGluZGV4IDAwMDAwMDAwMDAwMC4uN2FhZjM2ZGZj
NWUwDQo+ID4gLS0tIC9kZXYvbnVsbA0KPiA+ICsrKyBiL2RyaXZlcnMvbXRkL25hbmQvb25maS5j
DQo+ID4gQEAgLTAsMCArMSw4OSBAQA0KPiA+ICsvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjog
R1BMLTIuMA0KPiA+ICsNCj4gPiArI2RlZmluZSBwcl9mbXQoZm10KSAgICAgIm5hbmQtb25maTog
IiBmbXQNCj4gPiArDQo+ID4gKyNpbmNsdWRlIDxsaW51eC9tdGQvb25maS5oPg0KPiA+ICsjaW5j
bHVkZSA8bGludXgvbXRkL25hbmQuaD4NCj4gPiArDQo+ID4gKy8qKg0KPiA+ICsgKiBvbmZpX2Ny
YzE2KCkgLSBDaGVjayBDUkMgb2YgT05GSSB0YWJsZQ0KPiANCj4gVGhlcmUgaXMgbm8gY2hlY2sg
aW4gdGhpcyBmdW5jdGlvbi4NCj4gDQo+ICAgICAgICAgICAgICAgICAgICAgIERlcml2ZSB0aGUg
Q1JDIG9mIGFuIE9ORkkgdGFibGUNCg0Kb2theS4NCg0KPiANCj4gPiArICogQGNyYzogYmFzZSBD
UkMNCj4gPiArICogQHA6IGJ1ZmZlciBwb2ludGluZyB0byBPTkZJIHRhYmxlDQo+ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBeIHRoZQ0KPiA+ICsgKiBAbGVuOiBsZW5ndGggb2YgT05GSSB0
YWJsZQ0KPiAgICAgICAgICAgICAgICAgICAgICBedGhlDQo+ID4gKyAqDQo+ID4gKyAqIFJldHVy
bjogQ1JDIG9mIHRoZSBPTkZJIHRhYmxlDQo+ICAgICAgIEByZXR1cm46IHRoZSBDUkMgb2YgdGhl
IGdpdmVuIE9ORkkgdGFibGUNCj4gDQo+ID4gKyAqLw0KPiA+ICt1MTYgb25maV9jcmMxNih1MTYg
Y3JjLCB1OCBjb25zdCAqcCwgc2l6ZV90IGxlbikNCj4gPiArew0KPiA+ICsJaW50IGk7DQo+ID4g
Kw0KPiA+ICsJd2hpbGUgKGxlbi0tKSB7DQo+ID4gKwkJY3JjIF49ICpwKysgPDwgODsNCj4gPiAr
CQlmb3IgKGkgPSAwOyBpIDwgODsgaSsrKQ0KPiA+ICsJCQljcmMgPSAoY3JjIDw8IDEpIF4gKChj
cmMgJiAweDgwMDApID8gMHg4MDA1IDogMCk7DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICsJcmV0dXJu
IGNyYzsNCj4gPiArfQ0KPiA+ICtFWFBPUlRfU1lNQk9MX0dQTChvbmZpX2NyYzE2KTsNCj4gPiAr
DQo+ID4gKy8qKg0KPiA+ICsgKiBuYW5kX2JpdF93aXNlX21ham9yaXR5KCkgLSBSZWNvdmVyIGRh
dGEgd2l0aCBiaXQtd2lzZSBtYWpvcml0eQ0KPiA+ICsgKiBAc3JjYnVmczogYnVmZmVyIHBvaW50
aW5nIHRvIE9ORkkgdGFibGUNCj4gPiArICogQG5zcmNidWZzOiBsZW5ndGggb2YgT05GSSB0YWJs
ZQ0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgXnRoZQ0KPiA+ICsgKiBAZHN0YnVmOiB2YWxp
ZCBPTkZJIHRhYmxlIHRvIGJlIHJldHVybmVkDQo+ID4gKyAqIEBidWZzaXplOiBsZW5ndGggb2cg
dmFsaWQgT05GSSB0YWJsZQ0KPiAgICAgICAgICAgICAgICAgICAgICAgIG9mIHRoZSB2YWxpZC4u
Lg0KPiA+ICsgKg0KPiANCj4gRXh0cmEgbGluZQ0KPiANCj4gPiArICovDQo+ID4gK3ZvaWQgbmFu
ZF9iaXRfd2lzZV9tYWpvcml0eShjb25zdCB2b2lkICoqc3JjYnVmcywNCj4gPiArCQkJICAgIHVu
c2lnbmVkIGludCBuc3JjYnVmcywNCj4gPiArCQkJICAgIHZvaWQgKmRzdGJ1ZiwNCj4gPiArCQkJ
ICAgIHVuc2lnbmVkIGludCBidWZzaXplKQ0KPiA+ICt7DQo+ID4gKwlpbnQgaSwgaiwgazsNCj4g
PiArDQo+ID4gKwlmb3IgKGkgPSAwOyBpIDwgYnVmc2l6ZTsgaSsrKSB7DQo+ID4gKwkJdTggdmFs
ID0gMDsNCj4gPiArDQo+ID4gKwkJZm9yIChqID0gMDsgaiA8IDg7IGorKykgew0KPiA+ICsJCQl1
bnNpZ25lZCBpbnQgY250ID0gMDsNCj4gPiArDQo+ID4gKwkJCWZvciAoayA9IDA7IGsgPCBuc3Jj
YnVmczsgaysrKSB7DQo+ID4gKwkJCQljb25zdCB1OCAqc3JjYnVmID0gc3JjYnVmc1trXTsNCj4g
PiArDQo+ID4gKwkJCQlpZiAoc3JjYnVmW2ldICYgQklUKGopKQ0KPiA+ICsJCQkJCWNudCsrOw0K
PiA+ICsJCQl9DQo+ID4gKw0KPiA+ICsJCQlpZiAoY250ID4gbnNyY2J1ZnMgLyAyKQ0KPiA+ICsJ
CQkJdmFsIHw9IEJJVChqKTsNCj4gPiArCQl9DQo+ID4gKw0KPiA+ICsJCSgodTggKilkc3RidWYp
W2ldID0gdmFsOw0KPiA+ICsJfQ0KPiA+ICt9DQo+ID4gK0VYUE9SVF9TWU1CT0xfR1BMKG5hbmRf
Yml0X3dpc2VfbWFqb3JpdHkpOw0KPiA+ICsNCj4gPiArLyoqDQo+ID4gKyAqIHNhbml0aXplX3N0
cmluZygpIC0gU2FuaXRpemUgT05GSSBzdHJpbmdzIHNvIHdlIGNhbiBzYWZlbHkgcHJpbnQgdGhl
bQ0KPiANCj4gSXQgaXMgdXNlZCBieSBKRURFQyBsb2dpYyBzbyB0aGlzIHNob3VsZCBiZSBtb3Zl
ZCBlbHNld2hlcmUgYW5kIG5vdA0KPiByZWZlciB0byBhbnkgT05GSSBuYW1pbmcuDQoNCm9rYXks
IEkgd2lsbCBtb3ZlIHRoaXMuDQoNCj4gDQo+ID4gKyAqIEBzOiBzdHJpbmcgdG8gYmUgc2FuaXRp
emVkDQo+ID4gKyAqIEBsZW46IGxlbmd0aCBvZiB0aGUgc3RyaW5nDQo+ID4gKyAqDQo+ID4gKyAq
Lw0KPiA+ICt2b2lkIHNhbml0aXplX3N0cmluZyh1OCAqcywgc2l6ZV90IGxlbikNCj4gPiArew0K
PiA+ICsJc3NpemVfdCBpOw0KPiA+ICsNCj4gPiArCS8qIE51bGwgdGVybWluYXRlICovDQo+ID4g
KwlzW2xlbiAtIDFdID0gMDsNCj4gPiArDQo+ID4gKwkvKiBSZW1vdmUgbm9uIHByaW50YWJsZSBj
aGFycyAqLw0KPiA+ICsJZm9yIChpID0gMDsgaSA8IGxlbiAtIDE7IGkrKykgew0KPiA+ICsJCWlm
IChzW2ldIDwgJyAnIHx8IHNbaV0gPiAxMjcpDQo+ID4gKwkJCXNbaV0gPSAnPyc7DQo+ID4gKwl9
DQo+ID4gKw0KPiA+ICsJLyogUmVtb3ZlIHRyYWlsaW5nIHNwYWNlcyAqLw0KPiA+ICsJc3RyaW0o
cyk7DQo+ID4gK30NCj4gPiArRVhQT1JUX1NZTUJPTF9HUEwoc2FuaXRpemVfc3RyaW5nKTsNCj4g
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tdGQvbmFuZC9yYXcvbmFuZF9iYXNlLmMNCj4gYi9kcml2
ZXJzL210ZC9uYW5kL3Jhdy9uYW5kX2Jhc2UuYw0KPiA+IGluZGV4IDZlY2QxYzQ5NmNlMy4uYzE5
ODgyOWJjZDc5IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbXRkL25hbmQvcmF3L25hbmRfYmFz
ZS5jDQo+ID4gKysrIGIvZHJpdmVycy9tdGQvbmFuZC9yYXcvbmFuZF9iYXNlLmMNCj4gPiBAQCAt
NDM3NSwyNCArNDM3NSw2IEBAIHN0YXRpYyB2b2lkIG5hbmRfc2V0X2RlZmF1bHRzKHN0cnVjdCBu
YW5kX2NoaXANCj4gKmNoaXApDQo+ID4gIAkJY2hpcC0+YnVmX2FsaWduID0gMTsNCj4gPiAgfQ0K
PiA+DQo+ID4gLS8qIFNhbml0aXplIE9ORkkgc3RyaW5ncyBzbyB3ZSBjYW4gc2FmZWx5IHByaW50
IHRoZW0gKi8NCj4gPiAtdm9pZCBzYW5pdGl6ZV9zdHJpbmcodWludDhfdCAqcywgc2l6ZV90IGxl
bikNCj4gPiAtew0KPiA+IC0Jc3NpemVfdCBpOw0KPiA+IC0NCj4gPiAtCS8qIE51bGwgdGVybWlu
YXRlICovDQo+ID4gLQlzW2xlbiAtIDFdID0gMDsNCj4gPiAtDQo+ID4gLQkvKiBSZW1vdmUgbm9u
IHByaW50YWJsZSBjaGFycyAqLw0KPiA+IC0JZm9yIChpID0gMDsgaSA8IGxlbiAtIDE7IGkrKykg
ew0KPiA+IC0JCWlmIChzW2ldIDwgJyAnIHx8IHNbaV0gPiAxMjcpDQo+ID4gLQkJCXNbaV0gPSAn
Pyc7DQo+ID4gLQl9DQo+ID4gLQ0KPiA+IC0JLyogUmVtb3ZlIHRyYWlsaW5nIHNwYWNlcyAqLw0K
PiA+IC0Jc3RyaW0ocyk7DQo+ID4gLX0NCj4gPiAtDQo+ID4gIC8qDQo+ID4gICAqIG5hbmRfaWRf
aGFzX3BlcmlvZCAtIENoZWNrIGlmIGFuIElEIHN0cmluZyBoYXMgYSBnaXZlbiB3cmFwYXJvdW5k
DQo+IHBlcmlvZA0KPiA+ICAgKiBAaWRfZGF0YTogdGhlIElEIHN0cmluZw0KPiA+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL210ZC9uYW5kL3Jhdy9uYW5kX29uZmkuYw0KPiBiL2RyaXZlcnMvbXRkL25h
bmQvcmF3L25hbmRfb25maS5jDQo+ID4gaW5kZXggMGI4NzliZDBhNjhjLi4yZThlZGZhNjM2ZWYg
MTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9tdGQvbmFuZC9yYXcvbmFuZF9vbmZpLmMNCj4gPiAr
KysgYi9kcml2ZXJzL210ZC9uYW5kL3Jhdy9uYW5kX29uZmkuYw0KPiA+IEBAIC0xNiwxOCArMTYs
NiBAQA0KPiA+DQo+ID4gICNpbmNsdWRlICJpbnRlcm5hbHMuaCINCj4gPg0KPiA+IC11MTYgb25m
aV9jcmMxNih1MTYgY3JjLCB1OCBjb25zdCAqcCwgc2l6ZV90IGxlbikNCj4gPiAtew0KPiA+IC0J
aW50IGk7DQo+ID4gLQl3aGlsZSAobGVuLS0pIHsNCj4gPiAtCQljcmMgXj0gKnArKyA8PCA4Ow0K
PiA+IC0JCWZvciAoaSA9IDA7IGkgPCA4OyBpKyspDQo+ID4gLQkJCWNyYyA9IChjcmMgPDwgMSkg
XiAoKGNyYyAmIDB4ODAwMCkgPyAweDgwMDUgOiAwKTsNCj4gPiAtCX0NCj4gPiAtDQo+ID4gLQly
ZXR1cm4gY3JjOw0KPiA+IC19DQo+ID4gLQ0KPiA+ICAvKiBQYXJzZSB0aGUgRXh0ZW5kZWQgUGFy
YW1ldGVyIFBhZ2UuICovDQo+ID4gIHN0YXRpYyBpbnQgbmFuZF9mbGFzaF9kZXRlY3RfZXh0X3Bh
cmFtX3BhZ2Uoc3RydWN0IG5hbmRfY2hpcCAqY2hpcCwNCj4gPiAgCQkJCQkgICAgc3RydWN0IG5h
bmRfb25maV9wYXJhbXMgKnApDQo+ID4gQEAgLTEwMywzNyArOTEsNiBAQCBzdGF0aWMgaW50DQo+
IG5hbmRfZmxhc2hfZGV0ZWN0X2V4dF9wYXJhbV9wYWdlKHN0cnVjdCBuYW5kX2NoaXAgKmNoaXAs
DQo+ID4gIAlyZXR1cm4gcmV0Ow0KPiA+ICB9DQo+ID4NCj4gPiAtLyoNCj4gPiAtICogUmVjb3Zl
ciBkYXRhIHdpdGggYml0LXdpc2UgbWFqb3JpdHkNCj4gPiAtICovDQo+ID4gLXN0YXRpYyB2b2lk
IG5hbmRfYml0X3dpc2VfbWFqb3JpdHkoY29uc3Qgdm9pZCAqKnNyY2J1ZnMsDQo+ID4gLQkJCQkg
ICB1bnNpZ25lZCBpbnQgbnNyY2J1ZnMsDQo+ID4gLQkJCQkgICB2b2lkICpkc3RidWYsDQo+ID4g
LQkJCQkgICB1bnNpZ25lZCBpbnQgYnVmc2l6ZSkNCj4gPiAtew0KPiA+IC0JaW50IGksIGosIGs7
DQo+ID4gLQ0KPiA+IC0JZm9yIChpID0gMDsgaSA8IGJ1ZnNpemU7IGkrKykgew0KPiA+IC0JCXU4
IHZhbCA9IDA7DQo+ID4gLQ0KPiA+IC0JCWZvciAoaiA9IDA7IGogPCA4OyBqKyspIHsNCj4gPiAt
CQkJdW5zaWduZWQgaW50IGNudCA9IDA7DQo+ID4gLQ0KPiA+IC0JCQlmb3IgKGsgPSAwOyBrIDwg
bnNyY2J1ZnM7IGsrKykgew0KPiA+IC0JCQkJY29uc3QgdTggKnNyY2J1ZiA9IHNyY2J1ZnNba107
DQo+ID4gLQ0KPiA+IC0JCQkJaWYgKHNyY2J1ZltpXSAmIEJJVChqKSkNCj4gPiAtCQkJCQljbnQr
KzsNCj4gPiAtCQkJfQ0KPiA+IC0NCj4gPiAtCQkJaWYgKGNudCA+IG5zcmNidWZzIC8gMikNCj4g
PiAtCQkJCXZhbCB8PSBCSVQoaik7DQo+ID4gLQkJfQ0KPiA+IC0NCj4gPiAtCQkoKHU4ICopZHN0
YnVmKVtpXSA9IHZhbDsNCj4gPiAtCX0NCj4gPiAtfQ0KPiA+IC0NCj4gPiAgLyoNCj4gPiAgICog
Q2hlY2sgaWYgdGhlIE5BTkQgY2hpcCBpcyBPTkZJIGNvbXBsaWFudCwgcmV0dXJucyAxIGlmIGl0
IGlzLCAwIG90aGVyd2lzZS4NCj4gPiAgICovDQo+IA0KPiBUaGFua3MsDQo+IE1pcXXDqGwNCg0K
VGhhbmtzLA0KU2hpdmENCg==
