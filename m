Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A030C31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 14:45:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2674521783
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 14:45:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="HG4Sr55l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436524AbfHIOpq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 10:45:46 -0400
Received: from mail-eopbgr30132.outbound.protection.outlook.com ([40.107.3.132]:45006
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726157AbfHIOpp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 10:45:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AxUmkMwHKHFTPMxHbLlABvbBrKpzL+DIf39rFLZ/o/J53nk6wyk0ElKJgUTwikXSed/kVdYICb2vp0yF2cBDSdbSmmBrKG1rMOpZ4H/b+wmo2ONaQVOxsCdBuBa/q7WBVF+ZFg9TZ2NSIKe+ViOIu2gM3kLsdSxiGY/k2eaXHQJtxBocYsRkpZUDdsbbMCkgOJ25n4zpJqRsd99+HLBZNcrmPJ/BtSmonLcU2F79bEOcYSfknvUwtSMrIgKuZDXLWH10DcxnNysrg1AA8bAAKwgEx2AN6riK/0U/aoiRPjVKJOSIERipOMS/Ym4zB1ByeA9bw/LUDWWWmINWr5fO2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U09dKJtLV2tXZCPVFvJ287v1muxVBul/GnN5ZT1n8X4=;
 b=Hkk37SV/DO38AMObM2UGwkd3ZSVqksCdcRrt58ytJMUG0Cd8MFEJ6jTOhs8nlTAAKcxZ+qNOoHKGyIuoT+9cDsal9fNzVRNjoylBxuT9cEYYhXPSmYV06LEQNTyDj+u9zVoRbCsFUjhFEiETsWVno7XBFZyzbLFpKl0CdlbFsTTLva6uUgZSEie4E/lAVonBA9RK7qmCAKdMK7xRTjJDtSKjY4t1SBA/NsqqOoGAXnv3U+CBvK5MyVMazzcCEtPdnz7sZdwdQNkqtf3yw768GtoOFyhlKaDfN7zw4dznCCKZQckApmJyt53YRzJqidJ+DEpSFoKhuiS0/uJwh3VNIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U09dKJtLV2tXZCPVFvJ287v1muxVBul/GnN5ZT1n8X4=;
 b=HG4Sr55lfeGHnqhYMVi8IzdUseNUUR7mhF9lPJEWCPgtjYMGP2ldgLKG15kfQvRabZelzCbpgn0ctRzoClJ1SyJyWsvC+Bfr3N1/As3bgU+RiHfoOWSLysaXIHu81Sx/rqPJeT6KwwvhPW6g3R2N6AssTJTL0qhg8XNeH4/TFLs=
Received: from VI1PR05MB6415.eurprd05.prod.outlook.com (20.179.27.139) by
 VI1PR05MB4399.eurprd05.prod.outlook.com (52.133.13.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.16; Fri, 9 Aug 2019 14:45:39 +0000
Received: from VI1PR05MB6415.eurprd05.prod.outlook.com
 ([fe80::f1b2:353a:da9b:c19a]) by VI1PR05MB6415.eurprd05.prod.outlook.com
 ([fe80::f1b2:353a:da9b:c19a%4]) with mapi id 15.20.2157.020; Fri, 9 Aug 2019
 14:45:39 +0000
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
        Oleksandr Suvorov <oleksandr.suvorov@toradex.com>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>
Subject: Re: [PATCH v3 05/21] ARM: dts: add recovery for I2C for iMX7
Thread-Topic: [PATCH v3 05/21] ARM: dts: add recovery for I2C for iMX7
Thread-Index: AQHVTPnI7F5mVF7STU6mUzhQ+mPLGqby6EQA
Date:   Fri, 9 Aug 2019 14:45:38 +0000
Message-ID: <139d316e0dd0e6a3f95e94aade8df825c5a2486b.camel@toradex.com>
References: <20190807082556.5013-1-philippe.schenker@toradex.com>
         <20190807082556.5013-6-philippe.schenker@toradex.com>
In-Reply-To: <20190807082556.5013-6-philippe.schenker@toradex.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=marcel.ziswiler@toradex.com; 
x-originating-ip: [2a01:2a8:8501:4d00:ca5b:76ff:fedf:3c49]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a050ed55-8249-437c-fb50-08d71cd83efe
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VI1PR05MB4399;
x-ms-traffictypediagnostic: VI1PR05MB4399:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR05MB43992751B6CB476400EF3121FBD60@VI1PR05MB4399.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-forefront-prvs: 01244308DF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39850400004)(396003)(376002)(136003)(366004)(346002)(199004)(189003)(66946007)(66446008)(91956017)(8676002)(53936002)(4326008)(6436002)(7736002)(76116006)(110136005)(66476007)(81156014)(54906003)(64756008)(81166006)(2906002)(6246003)(66556008)(478600001)(229853002)(6116002)(6506007)(14454004)(6512007)(305945005)(7416002)(36756003)(118296001)(25786009)(476003)(8936002)(6486002)(486006)(71190400001)(316002)(86362001)(2616005)(11346002)(71200400001)(99286004)(102836004)(2201001)(2501003)(46003)(446003)(256004)(5660300002)(186003)(76176011)(44832011);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR05MB4399;H:VI1PR05MB6415.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: tq2q9GiXP4g/Gsn7aU1uZm9JjClZpOWJUK5UMz0AgREQUiU42k16ULyuQK0wpZSxnpf2Cc1Ahy1vSGyn2WlDrYa6twaRER2yRiDPq5qKu9gmlWTAKiXNFUViWEgvXUK48cX7o1gJzKjj1lZhQiGF8IAcDacVKs9uMCoo3kZv9WJQUGLoQYn4X1iJJRYVMwJjp7SYW+Yf98jSqOmO0LM4QIkA7mDWK5iaV4s7eaa5xTIYlw/7tSoEAhqeoshiRMVHkPV8uiVMn4RrJ737kYfB2xD4t2E6gLMzaW7T7IKb/p2habe6tz5D01vc97tTRTalQc2A7Pm3MEWvtc9bvon5d0uYN8TZVoKSLz62eRnhIlARColteOphCzLhEMfQMhCS3YR9N0rtzaPiYUM+7gulmI26asgUKFohLT723yXOYP8=
Content-Type: text/plain; charset="utf-8"
Content-ID: <898E8C007F07464AB0BA1BA7D1CAD1D4@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a050ed55-8249-437c-fb50-08d71cd83efe
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2019 14:45:38.9857
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Soncw+fakUVBA8RX8Oxx1A+Bx55k92FMIkzOMpUTCzA9KYHe2AC/xg/KLz5eY9jmTcU7ZT6TSN1yIYqooRoJKVsIGb3TjytqvlX8dXSQQzA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4399
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDE5LTA4LTA3IGF0IDA4OjI2ICswMDAwLCBQaGlsaXBwZSBTY2hlbmtlciB3cm90
ZToNCj4gRnJvbTogT2xla3NhbmRyIFN1dm9yb3YgPG9sZWtzYW5kci5zdXZvcm92QHRvcmFkZXgu
Y29tPg0KPiANCj4gLSBhZGQgcmVjb3ZlcnkgbW9kZSBmb3IgYXBwbGljYWJsZSBpMmMgYnVzZXMg
Zm9yDQo+ICAgQ29saWJyaSBpTVg3IG1vZHVsZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE9sZWtz
YW5kciBTdXZvcm92IDxvbGVrc2FuZHIuc3V2b3JvdkB0b3JhZGV4LmNvbT4NCj4gU2lnbmVkLW9m
Zi1ieTogUGhpbGlwcGUgU2NoZW5rZXIgPHBoaWxpcHBlLnNjaGVua2VyQHRvcmFkZXguY29tPg0K
DQpBY2tlZC1ieTogTWFyY2VsIFppc3dpbGVyIDxtYXJjZWwuemlzd2lsZXJAdG9yYWRleC5jb20+
DQoNCj4gLS0tDQo+IA0KPiBDaGFuZ2VzIGluIHYzOiBOb25lDQo+IENoYW5nZXMgaW4gdjI6IE5v
bmUNCj4gDQo+ICBhcmNoL2FybS9ib290L2R0cy9pbXg3LWNvbGlicmkuZHRzaSB8IDI1ICsrKysr
KysrKysrKysrKysrKysrKysrLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAyMyBpbnNlcnRpb25zKCsp
LCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRzL2lt
eDctY29saWJyaS5kdHNpDQo+IGIvYXJjaC9hcm0vYm9vdC9kdHMvaW14Ny1jb2xpYnJpLmR0c2kN
Cj4gaW5kZXggYThkOTkyZjNlODk3Li4yNDgwNjIzYzkyZmYgMTAwNjQ0DQo+IC0tLSBhL2FyY2gv
YXJtL2Jvb3QvZHRzL2lteDctY29saWJyaS5kdHNpDQo+ICsrKyBiL2FyY2gvYXJtL2Jvb3QvZHRz
L2lteDctY29saWJyaS5kdHNpDQo+IEBAIC0xNDAsOCArMTQwLDEyIEBADQo+ICANCj4gICZpMmMx
IHsNCj4gIAljbG9jay1mcmVxdWVuY3kgPSA8MTAwMDAwPjsNCj4gLQlwaW5jdHJsLW5hbWVzID0g
ImRlZmF1bHQiOw0KPiArCXBpbmN0cmwtbmFtZXMgPSAiZGVmYXVsdCIsICJncGlvIjsNCj4gIAlw
aW5jdHJsLTAgPSA8JnBpbmN0cmxfaTJjMSAmcGluY3RybF9pMmMxX2ludD47DQo+ICsJcGluY3Ry
bC0xID0gPCZwaW5jdHJsX2kyYzFfcmVjb3ZlcnkgJnBpbmN0cmxfaTJjMV9pbnQ+Ow0KPiArCXNj
bC1ncGlvcyA9IDwmZ3BpbzEgNCBHUElPX0FDVElWRV9ISUdIPjsNCj4gKwlzZGEtZ3Bpb3MgPSA8
JmdwaW8xIDUgR1BJT19BQ1RJVkVfSElHSD47DQo+ICsNCj4gIAlzdGF0dXMgPSAib2theSI7DQo+
ICANCj4gIAljb2RlYzogc2d0bDUwMDBAYSB7DQo+IEBAIC0yNDIsOCArMjQ2LDExIEBADQo+ICAN
Cj4gICZpMmM0IHsNCj4gIAljbG9jay1mcmVxdWVuY3kgPSA8MTAwMDAwPjsNCj4gLQlwaW5jdHJs
LW5hbWVzID0gImRlZmF1bHQiOw0KPiArCXBpbmN0cmwtbmFtZXMgPSAiZGVmYXVsdCIsICJncGlv
IjsNCj4gIAlwaW5jdHJsLTAgPSA8JnBpbmN0cmxfaTJjND47DQo+ICsJcGluY3RybC0xID0gPCZw
aW5jdHJsX2kyYzRfcmVjb3Zlcnk+Ow0KPiArCXNjbC1ncGlvcyA9IDwmZ3BpbzcgOCBHUElPX0FD
VElWRV9ISUdIPjsNCj4gKwlzZGEtZ3Bpb3MgPSA8JmdwaW83IDkgR1BJT19BQ1RJVkVfSElHSD47
DQo+ICB9Ow0KPiAgDQo+ICAmbGNkaWYgew0KPiBAQCAtNTQwLDYgKzU0NywxMyBAQA0KPiAgCQk+
Ow0KPiAgCX07DQo+ICANCj4gKwlwaW5jdHJsX2kyYzRfcmVjb3Zlcnk6IGkyYzQtcmVjb3Zlcnln
cnAgew0KPiArCQlmc2wscGlucyA9IDwNCj4gKwkJCU1YN0RfUEFEX0VORVQxX1JHTUlJX1REMl9f
R1BJTzdfSU84CTB4NDAwDQo+IDAwMDdmDQo+ICsJCQlNWDdEX1BBRF9FTkVUMV9SR01JSV9URDNf
X0dQSU83X0lPOQkweDQwMA0KPiAwMDA3Zg0KPiArCQk+Ow0KPiArCX07DQo+ICsNCj4gIAlwaW5j
dHJsX2xjZGlmX2RhdDogbGNkaWYtZGF0LWdycCB7DQo+ICAJCWZzbCxwaW5zID0gPA0KPiAgCQkJ
TVg3RF9QQURfTENEX0RBVEEwMF9fTENEX0RBVEEwCQkweDc5DQo+IEBAIC03NDAsNiArNzU0LDEz
IEBADQo+ICAJCT47DQo+ICAJfTsNCj4gIA0KPiArCXBpbmN0cmxfaTJjMV9yZWNvdmVyeTogaTJj
MS1yZWNvdmVyeWdycCB7DQo+ICsJCWZzbCxwaW5zID0gPA0KPiArCQkJTVg3RF9QQURfTFBTUl9H
UElPMV9JTzA0X19HUElPMV9JTzQJMHg0MDANCj4gMDAwN2YNCj4gKwkJCU1YN0RfUEFEX0xQU1Jf
R1BJTzFfSU8wNV9fR1BJTzFfSU81CTB4NDAwDQo+IDAwMDdmDQo+ICsJCT47DQo+ICsJfTsNCj4g
Kw0KPiAgCXBpbmN0cmxfY2RfdXNkaGMxOiB1c2RoYzEtY2QtZ3JwIHsNCj4gIAkJZnNsLHBpbnMg
PSA8DQo+ICAJCQlNWDdEX1BBRF9MUFNSX0dQSU8xX0lPMDBfX0dQSU8xX0lPMAkweDU5DQo+IC8q
IENEICovDQo=
