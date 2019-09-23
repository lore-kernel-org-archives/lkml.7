Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FD66C3A5A2
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 01:17:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 155A721479
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 01:17:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="DJwMPcxw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390819AbfIWBRO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 21:17:14 -0400
Received: from mail-eopbgr20068.outbound.protection.outlook.com ([40.107.2.68]:34823
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387843AbfIWBRN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 21:17:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dOHBBvlcrINS2PdQgtVd2JKmLBEnOGn+/di26ec3KQBpBmDQYGDjTQdwYry86n07DAIaxKW36KsMFb35N4sUIfdwAh6PApHCZsUFWFCvxpMq0/J4l7pfknHptH8u9mFq6Gr8mtNKR50+x3UjikXJ91mDPwVS4u/PDNVRT6cpaeV5953W5K5jCbo5GMWizaBwL1o09O899I9uzSkySKGsctok7bcmccMu3oAKWfc95aClT7C9AS3WFUdbHxq5oPD1l/O2YzqkWAQ8RBORWTctZZSBjSgM4Gw2/qu2RRGTr2tlK1/BfMViF5ARVBz1QehR9pCoz19oUgzlB5wlBsU62A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5RWkkE+qNYv/wMXOcrPAKu7EyZ7G9XQtzMkAM07OuBw=;
 b=ZzTynZtnio8S+nXDvm/GmriM+AfktdPWru73CYsPZBIFC3Nj4pVn5DxAqkjRDO4ced4vd6CL3UuU/bdNwNl7g1GKoI8alPZYIiviooxnd7+zo1Nya0XGb8SCD3JOiJmMhGoK7d5DJ67wwecBawfPbTLqjrVPLFt9XpSKQEZ3b9TD5etmU1TDfZh67fd6H+QdwUD67BrgFcQ6+C8Ygyyb7VacaAQ/MXxK1mmiNWS37OSNqupcoFtsIJJnVj0iyxZNL6uUipeGL1LUeOsxyb0Iq05nneLuPqqVV5YiklbS74/IFcxOoltDS+5+fsqAaOVCxl2FxLcSInwM0t3SI1/jHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5RWkkE+qNYv/wMXOcrPAKu7EyZ7G9XQtzMkAM07OuBw=;
 b=DJwMPcxwLDRFtEFZ7KVfu9wLP7BeIlX6cu8scIkxJDzqxumNlVnyeW0gUUyoBNK60wGEkCmS2zgJ4XRY7Au5E4kMp3jKJ5QDYxBnWNNHMfUXSMYMYXoUta2bpmFqOQ37klY1791d17Gpy6UDtwQjB+VXjWC/P8nKGTeT4Ld2YkA=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5937.eurprd04.prod.outlook.com (20.178.114.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Mon, 23 Sep 2019 01:17:08 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::6ca2:ec08:2b37:8ab8]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::6ca2:ec08:2b37:8ab8%6]) with mapi id 15.20.2284.023; Mon, 23 Sep 2019
 01:17:08 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>
Subject: RE: [PATCH 2/2] nvmem: imx: scu: support write
Thread-Topic: [PATCH 2/2] nvmem: imx: scu: support write
Thread-Index: AQHVV89l2gZHrF0tR0yZfYtuVeLxmqceUPbwgAAs4wCAGiuDYA==
Date:   Mon, 23 Sep 2019 01:17:08 +0000
Message-ID: <AM0PR04MB4481D9B6CF392263E2BE7D8F88850@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <1566356496-30493-1-git-send-email-peng.fan@nxp.com>
 <1566356496-30493-2-git-send-email-peng.fan@nxp.com>
 <AM0PR04MB448144701DB63A3C9F05B3E488BA0@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <dd82e84d-ab22-9dd9-f895-776570f46fee@linaro.org>
In-Reply-To: <dd82e84d-ab22-9dd9-f895-776570f46fee@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d5c3a3d3-65a7-4d62-c015-08d73fc3c0d6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB5937;
x-ms-traffictypediagnostic: AM0PR04MB5937:|AM0PR04MB5937:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB593731361613925D1D05CC7C88850@AM0PR04MB5937.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0169092318
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(396003)(346002)(39860400002)(366004)(376002)(189003)(199004)(52536014)(3846002)(6116002)(7696005)(76176011)(6506007)(186003)(9686003)(316002)(54906003)(55016002)(2906002)(33656002)(229853002)(446003)(99286004)(6246003)(486006)(66066001)(4326008)(102836004)(44832011)(476003)(74316002)(11346002)(66446008)(64756008)(25786009)(66556008)(66946007)(76116006)(66476007)(14444005)(256004)(6436002)(305945005)(8676002)(2201001)(7736002)(110136005)(8936002)(26005)(478600001)(86362001)(5660300002)(14454004)(81166006)(2501003)(71200400001)(71190400001)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5937;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +u+CM8H6HUguHt29ZmTzU8BwLA1v5AOLk4JCmJpoHq8D1pgGOr2laUEhhug0K4glURap42dzcqfctYoAJV5/oClJ+1ha+gyejuMTgQiZbUqWYb3QFFPnQd+VRH/kz8j8I+CxFR15GRGGMoPPefl/Iz7qrmHCDASpT+L76jFMVwi1IM9vayjw1cq7IcUl8rBWksuhGZ1nfasWpWN/V9bynB/GtSoBotfSKCfjWy0FKlhjhJEAOPj6pSqrEiWZVY7ud9VUbpDg58eBpF4sByVRxuhTaeNUXd5pbWNXjh1+7F1VggaL5Jaiww7waUCtVbr+Q/vzlkBxgZHTb+kACZyeCWo7oBMhgier/8WS4E3wdv9RGdZe5DdExKZqmNgU8BXQSKe/PWyjDV7jxG0Ig4Em2bL9RUyOYETzdNSaEKcPthg=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5c3a3d3-65a7-4d62-c015-08d73fc3c0d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2019 01:17:08.1287
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EVnxqjiikXaQJDuW9w2pWwJFQZLzCPTuUvObqYDUAuBl96BjZsSEnhMsQDrjkpB32s5CuQ8740EXVzL/uLfjDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5937
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgU3Jpbml2YXMsDQoNCj4gPj4gU3ViamVjdDogW1BBVENIIDIvMl0gbnZtZW06IGlteDogc2N1
OiBzdXBwb3J0IHdyaXRlDQo+ID4NCj4gPiBQaW5nLi4NCj4gPg0KPiBUaGFua3MgZm9yIHlvdXIg
cGF0aWVuY2UhDQo+IEkgbm9ybWFsbHkgZG8gbm90IHRha2UgcGF0Y2hlcyBhZnRlciByYzUgZm9y
IG52bWVtLg0KPiBUaGVzZSB3aWxsIGJlIGFwcGxpZWQgYWZ0ZXIgcmMxIGlzIHJlbGVhc2VkIQ0K
DQpTb3JyeSB0byBwaW5nIGFnYWluLiBXaWxsIHlvdSBwaWNrIHVwIHNpbmNlIG1lcmdlIHdpbmRv
dyBpcyBvcGVuPw0KDQpUaGFua3MsDQpQZW5nLg0KDQo+IA0KPiBUaGFua3MsDQo+IHNyaW5pDQo+
ID4gVGhhbmtzLA0KPiA+IFBlbmcuDQo+ID4NCj4gPj4NCj4gPj4gRnJvbTogUGVuZyBGYW4gPHBl
bmcuZmFuQG54cC5jb20+DQo+ID4+DQo+ID4+IFRoZSBmdXNlIHByb2dyYW1taW5nIGZyb20gbm9u
LXNlY3VyZSB3b3JsZCBpcyBibG9ja2VkLCBzbyB3ZSBjb3VsZA0KPiA+PiBvbmx5IHVzZSBBcm0g
VHJ1c3RlZCBGaXJtd2FyZSBTSVAgY2FsbCB0byBsZXQgQVRGIHByb2dyYW0gZnVzZS4NCj4gPj4N
Cj4gPj4gQmVjYXVzZSB0aGVyZSBpcyBFQ0MgcmVnaW9uIHRoYXQgY291bGQgb25seSBiZSBwcm9n
cmFtbWVkIG9uY2UsIHNvDQo+ID4+IGFkZCBhIGhlbGVyIGluX2VjYyB0byBjaGVjayB0aGUgZWNj
IHJlZ2lvbi4NCj4gPj4NCj4gPj4gU2lnbmVkLW9mZi1ieTogUGVuZyBGYW4gPHBlbmcuZmFuQG54
cC5jb20+DQo+ID4+IC0tLQ0KPiA+Pg0KPiA+PiBUaGUgQVRGIHBhdGNoIHdpbGwgc29vbiBiZSBw
b3N0ZWQgdG8gQVRGIGNvbW11bml0eS4NCj4gPj4NCj4gPj4gICBkcml2ZXJzL252bWVtL2lteC1v
Y290cC1zY3UuYyB8IDczDQo+ID4+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKy0NCj4gPj4gICAxIGZpbGUgY2hhbmdlZCwgNzIgaW5zZXJ0aW9ucygrKSwgMSBkZWxl
dGlvbigtKQ0KPiA+Pg0KPiA+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lbS9pbXgtb2NvdHAt
c2N1LmMNCj4gPj4gYi9kcml2ZXJzL252bWVtL2lteC1vY290cC1zY3UuYyBpbmRleCAyZjMzOWQ3
NDMyZTYuLjBmMDY0ZjJlNzRhOA0KPiA+PiAxMDA2NDQNCj4gPj4gLS0tIGEvZHJpdmVycy9udm1l
bS9pbXgtb2NvdHAtc2N1LmMNCj4gPj4gKysrIGIvZHJpdmVycy9udm1lbS9pbXgtb2NvdHAtc2N1
LmMNCj4gPj4gQEAgLTcsNiArNyw3IEBADQo+ID4+ICAgICogUGVuZyBGYW4gPHBlbmcuZmFuQG54
cC5jb20+DQo+ID4+ICAgICovDQo+ID4+DQo+ID4+ICsjaW5jbHVkZSA8bGludXgvYXJtLXNtY2Nj
Lmg+DQo+ID4+ICAgI2luY2x1ZGUgPGxpbnV4L2Zpcm13YXJlL2lteC9zY2kuaD4NCj4gPj4gICAj
aW5jbHVkZSA8bGludXgvbW9kdWxlLmg+DQo+ID4+ICAgI2luY2x1ZGUgPGxpbnV4L252bWVtLXBy
b3ZpZGVyLmg+DQo+ID4+IEBAIC0xNCw2ICsxNSw5IEBADQo+ID4+ICAgI2luY2x1ZGUgPGxpbnV4
L3BsYXRmb3JtX2RldmljZS5oPg0KPiA+PiAgICNpbmNsdWRlIDxsaW51eC9zbGFiLmg+DQo+ID4+
DQo+ID4+ICsjZGVmaW5lIElNWF9TSVBfT1RQCQkJMHhDMjAwMDAwQQ0KPiA+PiArI2RlZmluZSBJ
TVhfU0lQX09UUF9XUklURQkJMHgyDQo+ID4+ICsNCj4gPj4gICBlbnVtIG9jb3RwX2RldnR5cGUg
ew0KPiA+PiAgIAlJTVg4UVhQLA0KPiA+PiAgIH07DQo+ID4+IEBAIC00NSw2ICs0OSw4IEBAIHN0
cnVjdCBpbXhfc2NfbXNnX21pc2NfZnVzZV9yZWFkIHsNCj4gPj4gICAJdTMyIHdvcmQ7DQo+ID4+
ICAgfSBfX3BhY2tlZDsNCj4gPj4NCj4gPj4gK3N0YXRpYyBERUZJTkVfTVVURVgoc2N1X29jb3Rw
X211dGV4KTsNCj4gPj4gKw0KPiA+PiAgIHN0YXRpYyBzdHJ1Y3Qgb2NvdHBfZGV2dHlwZV9kYXRh
IGlteDhxeHBfZGF0YSA9IHsNCj4gPj4gICAJLmRldnR5cGUgPSBJTVg4UVhQLA0KPiA+PiAgIAku
bnJlZ3MgPSA4MDAsDQo+ID4+IEBAIC03Myw2ICs3OSwyMyBAQCBzdGF0aWMgYm9vbCBpbl9ob2xl
KHZvaWQgKmNvbnRleHQsIHUzMiBpbmRleCkNCj4gPj4gICAJcmV0dXJuIGZhbHNlOw0KPiA+PiAg
IH0NCj4gPj4NCj4gPj4gK3N0YXRpYyBib29sIGluX2VjYyh2b2lkICpjb250ZXh0LCB1MzIgaW5k
ZXgpIHsNCj4gPj4gKwlzdHJ1Y3Qgb2NvdHBfcHJpdiAqcHJpdiA9IGNvbnRleHQ7DQo+ID4+ICsJ
Y29uc3Qgc3RydWN0IG9jb3RwX2RldnR5cGVfZGF0YSAqZGF0YSA9IHByaXYtPmRhdGE7DQo+ID4+
ICsJaW50IGk7DQo+ID4+ICsNCj4gPj4gKwlmb3IgKGkgPSAwOyBpIDwgZGF0YS0+bnVtX3JlZ2lv
bjsgaSsrKSB7DQo+ID4+ICsJCWlmIChkYXRhLT5yZWdpb25baV0uZmxhZyAmIEVDQ19SRUdJT04p
IHsNCj4gPj4gKwkJCWlmICgoaW5kZXggPj0gZGF0YS0+cmVnaW9uW2ldLnN0YXJ0KSAmJg0KPiA+
PiArCQkJICAgIChpbmRleCA8PSBkYXRhLT5yZWdpb25baV0uZW5kKSkNCj4gPj4gKwkJCQlyZXR1
cm4gdHJ1ZTsNCj4gPj4gKwkJfQ0KPiA+PiArCX0NCj4gPj4gKw0KPiA+PiArCXJldHVybiBmYWxz
ZTsNCj4gPj4gK30NCj4gPj4gKw0KPiA+PiAgIHN0YXRpYyBpbnQgaW14X3NjX21pc2Nfb3RwX2Z1
c2VfcmVhZChzdHJ1Y3QgaW14X3NjX2lwYyAqaXBjLCB1MzINCj4gd29yZCwNCj4gPj4gICAJCQkJ
ICAgICB1MzIgKnZhbCkNCj4gPj4gICB7DQo+ID4+IEBAIC0xMTYsNiArMTM5LDggQEAgc3RhdGlj
IGludCBpbXhfc2N1X29jb3RwX3JlYWQodm9pZCAqY29udGV4dCwNCj4gPj4gdW5zaWduZWQgaW50
IG9mZnNldCwNCj4gPj4gICAJaWYgKCFwKQ0KPiA+PiAgIAkJcmV0dXJuIC1FTk9NRU07DQo+ID4+
DQo+ID4+ICsJbXV0ZXhfbG9jaygmc2N1X29jb3RwX211dGV4KTsNCj4gPj4gKw0KPiA+PiAgIAli
dWYgPSBwOw0KPiA+Pg0KPiA+PiAgIAlmb3IgKGkgPSBpbmRleDsgaSA8IChpbmRleCArIGNvdW50
KTsgaSsrKSB7IEBAIC0xMjYsNiArMTUxLDcgQEANCj4gPj4gc3RhdGljIGludCBpbXhfc2N1X29j
b3RwX3JlYWQodm9pZCAqY29udGV4dCwgdW5zaWduZWQgaW50IG9mZnNldCwNCj4gPj4NCj4gPj4g
ICAJCXJldCA9IGlteF9zY19taXNjX290cF9mdXNlX3JlYWQocHJpdi0+bnZtZW1faXBjLCBpLCBi
dWYpOw0KPiA+PiAgIAkJaWYgKHJldCkgew0KPiA+PiArCQkJbXV0ZXhfdW5sb2NrKCZzY3Vfb2Nv
dHBfbXV0ZXgpOw0KPiA+PiAgIAkJCWtmcmVlKHApOw0KPiA+PiAgIAkJCXJldHVybiByZXQ7DQo+
ID4+ICAgCQl9DQo+ID4+IEBAIC0xMzQsMTggKzE2MCw2MyBAQCBzdGF0aWMgaW50IGlteF9zY3Vf
b2NvdHBfcmVhZCh2b2lkICpjb250ZXh0LA0KPiA+PiB1bnNpZ25lZCBpbnQgb2Zmc2V0LA0KPiA+
Pg0KPiA+PiAgIAltZW1jcHkodmFsLCAodTggKilwICsgb2Zmc2V0ICUgNCwgYnl0ZXMpOw0KPiA+
Pg0KPiA+PiArCW11dGV4X3VubG9jaygmc2N1X29jb3RwX211dGV4KTsNCj4gPj4gKw0KPiA+PiAg
IAlrZnJlZShwKTsNCj4gPj4NCj4gPj4gICAJcmV0dXJuIDA7DQo+ID4+ICAgfQ0KPiA+Pg0KPiA+
PiArc3RhdGljIGludCBpbXhfc2N1X29jb3RwX3dyaXRlKHZvaWQgKmNvbnRleHQsIHVuc2lnbmVk
IGludCBvZmZzZXQsDQo+ID4+ICsJCQkgICAgICAgdm9pZCAqdmFsLCBzaXplX3QgYnl0ZXMpDQo+
ID4+ICt7DQo+ID4+ICsJc3RydWN0IG9jb3RwX3ByaXYgKnByaXYgPSBjb250ZXh0Ow0KPiA+PiAr
CXN0cnVjdCBhcm1fc21jY2NfcmVzIHJlczsNCj4gPj4gKwl1MzIgKmJ1ZiA9IHZhbDsNCj4gPj4g
Kwl1MzIgdG1wOw0KPiA+PiArCXUzMiBpbmRleDsNCj4gPj4gKwlpbnQgcmV0Ow0KPiA+PiArDQo+
ID4+ICsJLyogYWxsb3cgb25seSB3cml0aW5nIG9uZSBjb21wbGV0ZSBPVFAgd29yZCBhdCBhIHRp
bWUgKi8NCj4gPj4gKwlpZiAoKGJ5dGVzICE9IDQpIHx8IChvZmZzZXQgJSA0KSkNCj4gPj4gKwkJ
cmV0dXJuIC1FSU5WQUw7DQo+ID4+ICsNCj4gPj4gKwlpbmRleCA9IG9mZnNldCA+PiAyOw0KPiA+
PiArDQo+ID4+ICsJaWYgKGluX2hvbGUoY29udGV4dCwgaW5kZXgpKQ0KPiA+PiArCQlyZXR1cm4g
LUVJTlZBTDsNCj4gPj4gKw0KPiA+PiArCWlmIChpbl9lY2MoY29udGV4dCwgaW5kZXgpKSB7DQo+
ID4+ICsJCXByX3dhcm4oIkVDQyByZWdpb24sIG9ubHkgcHJvZ3JhbSBvbmNlXG4iKTsNCj4gPj4g
KwkJbXV0ZXhfbG9jaygmc2N1X29jb3RwX211dGV4KTsNCj4gPj4gKwkJcmV0ID0gaW14X3NjX21p
c2Nfb3RwX2Z1c2VfcmVhZChwcml2LT5udm1lbV9pcGMsIGluZGV4LCAmdG1wKTsNCj4gPj4gKwkJ
bXV0ZXhfdW5sb2NrKCZzY3Vfb2NvdHBfbXV0ZXgpOw0KPiA+PiArCQlpZiAocmV0KQ0KPiA+PiAr
CQkJcmV0dXJuIHJldDsNCj4gPj4gKwkJaWYgKHRtcCkgew0KPiA+PiArCQkJcHJfd2FybigiRUND
IHJlZ2lvbiwgYWxyZWFkeSBoYXMgdmFsdWU6ICV4XG4iLCB0bXApOw0KPiA+PiArCQkJcmV0dXJu
IC1FSU87DQo+ID4+ICsJCX0NCj4gPj4gKwl9DQo+ID4+ICsNCj4gPj4gKwltdXRleF9sb2NrKCZz
Y3Vfb2NvdHBfbXV0ZXgpOw0KPiA+PiArDQo+ID4+ICsJYXJtX3NtY2NjX3NtYyhJTVhfU0lQX09U
UCwgSU1YX1NJUF9PVFBfV1JJVEUsIGluZGV4LCAqYnVmLA0KPiA+PiArCQkgICAgICAwLCAwLCAw
LCAwLCAmcmVzKTsNCj4gPj4gKw0KPiA+PiArCW11dGV4X3VubG9jaygmc2N1X29jb3RwX211dGV4
KTsNCj4gPj4gKw0KPiA+PiArCXJldHVybiByZXMuYTA7DQo+ID4+ICt9DQo+ID4+ICsNCj4gPj4g
ICBzdGF0aWMgc3RydWN0IG52bWVtX2NvbmZpZyBpbXhfc2N1X29jb3RwX252bWVtX2NvbmZpZyA9
IHsNCj4gPj4gICAJLm5hbWUgPSAiaW14LXNjdS1vY290cCIsDQo+ID4+IC0JLnJlYWRfb25seSA9
IHRydWUsDQo+ID4+ICsJLnJlYWRfb25seSA9IGZhbHNlLA0KPiA+PiAgIAkud29yZF9zaXplID0g
NCwNCj4gPj4gICAJLnN0cmlkZSA9IDEsDQo+ID4+ICAgCS5vd25lciA9IFRISVNfTU9EVUxFLA0K
PiA+PiAgIAkucmVnX3JlYWQgPSBpbXhfc2N1X29jb3RwX3JlYWQsDQo+ID4+ICsJLnJlZ193cml0
ZSA9IGlteF9zY3Vfb2NvdHBfd3JpdGUsDQo+ID4+ICAgfTsNCj4gPj4NCj4gPj4gICBzdGF0aWMg
Y29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCBpbXhfc2N1X29jb3RwX2R0X2lkc1tdID0gew0KPiA+
PiAtLQ0KPiA+PiAyLjE2LjQNCj4gPg0K
