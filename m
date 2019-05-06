Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF71C04AAA
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 08:34:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86B682082F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 08:34:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="j2F9rWEu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbfEFIeN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 04:34:13 -0400
Received: from mail-eopbgr140044.outbound.protection.outlook.com ([40.107.14.44]:17635
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725890AbfEFIeN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 04:34:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BxHFfh3TZj1ishIC8frkyo4bCVDtUzddCv+dJsLqByk=;
 b=j2F9rWEuMVh0ooDL0mBxy43aWYwTGDiaoO3yEfajiiqqyGafa/PxGxglHdJ4N3RXfPYO6DN9jHaN0E+WDzop1BfghFxF7VAcwdSqiz6C6KBJag8vXu3JsU3l9ZMNmi/WnilTe7Q5HvuIGYfEIVB4cfzoXuYL1k6BBVnxPUy5eKw=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.92.158) by
 AM0PR04MB5698.eurprd04.prod.outlook.com (20.178.118.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.12; Mon, 6 May 2019 08:34:03 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c415:3cab:a042:2e13]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c415:3cab:a042:2e13%6]) with mapi id 15.20.1856.012; Mon, 6 May 2019
 08:34:03 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Peng Fan <peng.fan@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "srinivas.kandagatla@linaro.org" <srinivas.kandagatla@linaro.org>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "van.freenix@gmail.com" <van.freenix@gmail.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: RE: [PATCH 2/4] nvmem: imx: add i.MX8 nvmem driver
Thread-Topic: [PATCH 2/4] nvmem: imx: add i.MX8 nvmem driver
Thread-Index: AQHVA0ZmVVXDFSu4o0ao64I3BapSSaZdvqcg
Date:   Mon, 6 May 2019 08:34:03 +0000
Message-ID: <AM0PR04MB421139D3806F75ED9426C8DB80300@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <20190505134130.28071-1-peng.fan@nxp.com>
 <20190505134130.28071-2-peng.fan@nxp.com>
In-Reply-To: <20190505134130.28071-2-peng.fan@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 260696be-0e18-4916-2e39-08d6d1fd98ad
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB5698;
x-ms-traffictypediagnostic: AM0PR04MB5698:
x-microsoft-antispam-prvs: <AM0PR04MB56981C40740D4249808A760B80300@AM0PR04MB5698.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0029F17A3F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(39860400002)(376002)(136003)(366004)(199004)(189003)(53936002)(6246003)(86362001)(256004)(14444005)(66066001)(2201001)(110136005)(5660300002)(8936002)(186003)(25786009)(54906003)(4326008)(26005)(2501003)(7736002)(486006)(8676002)(11346002)(81166006)(316002)(44832011)(81156014)(446003)(71190400001)(476003)(305945005)(229853002)(71200400001)(76116006)(73956011)(66946007)(66476007)(55016002)(6116002)(3846002)(2906002)(14454004)(9686003)(66556008)(64756008)(66446008)(6436002)(33656002)(68736007)(99286004)(76176011)(7696005)(102836004)(6506007)(53546011)(52536014)(74316002)(7416002)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5698;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 7Z3l4QwumDYeOMMYVVxR6rr45xUlFjC0SG5CnMb2meCq1Q6XorapF6cZwH4wAqXDPE+nI4oBik1YRE6k9AiEO3wu6gZajYFgE8Y4Yc6nuyInqSRaYArNFextijlKxPKhYgLgxRQcYi81QWCzoIAHD/2nP679t9tMwGQSWxXVR8vkXKWXXGLqrbr/ashTVYkf2o2U3HGM+aTYswOMZTc5/tz3vsxYgisgqa9N6HAXnCBoxVk5SgwPcoRMS+MHSXMawbt11cG3fRP727lCCB/vilQDcTRzhoBLEU++9cN+HqZZYVBl5IE1fdPZWHNWSL7IwSCm4aCWk0mBKaXxMMePmFJ60raXK2m+PDVcvYE0qrE9h6O3WPnsRmQRQpDdOhBjj9SSZ2lJUbHJjGZUiUsNWOIbKdFaA6uKg51tswfR+JI=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 260696be-0e18-4916-2e39-08d6d1fd98ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2019 08:34:03.6582
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5698
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBQZW5nIEZhbg0KPiBTZW50OiBTdW5kYXksIE1heSA1LCAyMDE5IDk6MjggUE0NCj4g
U3ViamVjdDogW1BBVENIIDIvNF0gbnZtZW06IGlteDogYWRkIGkuTVg4IG52bWVtIGRyaXZlcg0K
PiANCj4gVGhpcyBwYXRjaCBhZGRzIGkuTVg4IG52bWVtIG9jb3RwIGRyaXZlciB0byBhY2Nlc3Mg
ZnVzZSB2aWEgUlBDIHRvIGkuTVg4DQo+IHN5c3RlbSBjb250cm9sbGVyLg0KPiANCj4gU2lnbmVk
LW9mZi1ieTogUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+DQoNCk9ubHkgYSBmZXcgbWlub3Ig
Y29tbWVudHMuDQpPdGhlcndpc2UsIHRoaXMgcGF0Y2ggbG9va3MgZ29vZCB0byBtZS4NCg0KRmly
c3QsIHRoZSBwYXRjaCB0aXRsZSBwcm9iYWJseSBiZXR0ZXIgdG8gYmU6DQpudm1lbTogaW14OiBh
ZGQgaS5NWDggU0NVIGJhc2VkIG9jb3RwIGRyaXZlciBzdXBwb3J0DQoNCj4gQ2M6IFNyaW5pdmFz
IEthbmRhZ2F0bGEgPHNyaW5pdmFzLmthbmRhZ2F0bGFAbGluYXJvLm9yZz4NCj4gQ2M6IFNoYXdu
IEd1byA8c2hhd25ndW9Aa2VybmVsLm9yZz4NCj4gQ2M6IFNhc2NoYSBIYXVlciA8cy5oYXVlckBw
ZW5ndXRyb25peC5kZT4NCj4gQ2M6IFBlbmd1dHJvbml4IEtlcm5lbCBUZWFtIDxrZXJuZWxAcGVu
Z3V0cm9uaXguZGU+DQo+IENjOiBGYWJpbyBFc3RldmFtIDxmZXN0ZXZhbUBnbWFpbC5jb20+DQo+
IENjOiBOWFAgTGludXggVGVhbSA8bGludXgtaW14QG54cC5jb20+DQo+IENjOiBsaW51eC1hcm0t
a2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcNCj4gLS0tDQo+ICBkcml2ZXJzL252bWVtL0tjb25m
aWcgICAgICAgICB8ICAgNyArKysNCj4gIGRyaXZlcnMvbnZtZW0vTWFrZWZpbGUgICAgICAgIHwg
ICAyICsNCj4gIGRyaXZlcnMvbnZtZW0vaW14LW9jb3RwLXNjdS5jIHwgMTM1DQo+ICsrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiAgMyBmaWxlcyBjaGFuZ2VkLCAx
NDQgaW5zZXJ0aW9ucygrKQ0KPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvbnZtZW0vaW14
LW9jb3RwLXNjdS5jDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lbS9LY29uZmlnIGIv
ZHJpdmVycy9udm1lbS9LY29uZmlnIGluZGV4DQo+IDUzMGQ1NzA3MjRjOS4uMGU3MDVjMDRiZDhj
IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL252bWVtL0tjb25maWcNCj4gKysrIGIvZHJpdmVycy9u
dm1lbS9LY29uZmlnDQo+IEBAIC0zNiw2ICszNiwxMyBAQCBjb25maWcgTlZNRU1fSU1YX09DT1RQ
DQo+ICAJICBUaGlzIGRyaXZlciBjYW4gYWxzbyBiZSBidWlsdCBhcyBhIG1vZHVsZS4gSWYgc28s
IHRoZSBtb2R1bGUNCj4gIAkgIHdpbGwgYmUgY2FsbGVkIG52bWVtLWlteC1vY290cC4NCj4gDQo+
ICtjb25maWcgTlZNRU1fSU1YX09DT1RQX1NDVQ0KPiArCXRyaXN0YXRlICJpLk1YOCBPbi1DaGlw
IE9UUCBDb250cm9sbGVyIHN1cHBvcnQiDQoNCmkuTVg4IFNDVSBPbi1DaGlwIE9UUCBDb250cm9s
bGVyIHN1cHBvcnQNCg0KPiArCWRlcGVuZHMgb24gSU1YX1NDVQ0KPiArCWhlbHANCj4gKwkgIFRo
aXMgaXMgYSBkcml2ZXIgZm9yIHRoZSBPbi1DaGlwIE9UUCBDb250cm9sbGVyIChPQ09UUCkNCg0K
U0NVIE9uLUNoaXAgT1RQDQoNCj4gKwkgIGF2YWlsYWJsZSBvbiBpLk1YOCBTb0NzLg0KPiArDQo+
ICBjb25maWcgTlZNRU1fTFBDMThYWF9FRVBST00NCj4gIAl0cmlzdGF0ZSAiTlhQIExQQzE4WFgg
RUVQUk9NIE1lbW9yeSBTdXBwb3J0Ig0KPiAgCWRlcGVuZHMgb24gQVJDSF9MUEMxOFhYIHx8IENP
TVBJTEVfVEVTVCBkaWZmIC0tZ2l0DQo+IGEvZHJpdmVycy9udm1lbS9NYWtlZmlsZSBiL2RyaXZl
cnMvbnZtZW0vTWFrZWZpbGUgaW5kZXgNCj4gMmVjZThmZmZmZGRhLi4zMGQ2NTNkMzRlNTcgMTAw
NjQ0DQo+IC0tLSBhL2RyaXZlcnMvbnZtZW0vTWFrZWZpbGUNCj4gKysrIGIvZHJpdmVycy9udm1l
bS9NYWtlZmlsZQ0KPiBAQCAtMTMsNiArMTMsOCBAQCBvYmotJChDT05GSUdfTlZNRU1fSU1YX0lJ
TSkJKz0NCj4gbnZtZW0taW14LWlpbS5vDQo+ICBudm1lbS1pbXgtaWltLXkJCQk6PSBpbXgtaWlt
Lm8NCj4gIG9iai0kKENPTkZJR19OVk1FTV9JTVhfT0NPVFApCSs9IG52bWVtLWlteC1vY290cC5v
DQo+ICBudm1lbS1pbXgtb2NvdHAteQkJOj0gaW14LW9jb3RwLm8NCj4gK29iai0kKENPTkZJR19O
Vk1FTV9JTVhfT0NPVFBfU0NVKQkrPSBudm1lbS1pbXgtb2NvdHAtc2N1Lm8NCj4gK252bWVtLWlt
eC1vY290cC1zY3UteQkJOj0gaW14LW9jb3RwLXNjdS5vDQo+ICBvYmotJChDT05GSUdfTlZNRU1f
TFBDMThYWF9FRVBST00pCSs9DQo+IG52bWVtX2xwYzE4eHhfZWVwcm9tLm8NCj4gIG52bWVtX2xw
YzE4eHhfZWVwcm9tLXkJOj0gbHBjMTh4eF9lZXByb20ubw0KPiAgb2JqLSQoQ09ORklHX05WTUVN
X0xQQzE4WFhfT1RQKQkrPSBudm1lbV9scGMxOHh4X290cC5vDQo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL252bWVtL2lteC1vY290cC1zY3UuYyBiL2RyaXZlcnMvbnZtZW0vaW14LW9jb3RwLXNjdS5j
DQo+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0IGluZGV4IDAwMDAwMDAwMDAwMC4uMDdlMWViYTM4NWFj
DQo+IC0tLSAvZGV2L251bGwNCj4gKysrIGIvZHJpdmVycy9udm1lbS9pbXgtb2NvdHAtc2N1LmMN
Cj4gQEAgLTAsMCArMSwxMzUgQEANCj4gKy8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwt
Mi4wKw0KPiArLyoNCj4gKyAqIGkuTVg4IE9DT1RQIGZ1c2Vib3ggZHJpdmVyDQo+ICsgKg0KPiAr
ICogQ29weXJpZ2h0IDIwMTkgTlhQDQo+ICsgKg0KPiArICogUGVuZyBGYW4gPHBlbmcuZmFuQG54
cC5jb20+DQo+ICsgKi8NCj4gKw0KPiArI2luY2x1ZGUgPGxpbnV4L2Zpcm13YXJlL2lteC9zY2ku
aD4NCj4gKyNpbmNsdWRlIDxsaW51eC9tb2R1bGUuaD4NCj4gKyNpbmNsdWRlIDxsaW51eC9udm1l
bS1wcm92aWRlci5oPg0KPiArI2luY2x1ZGUgPGxpbnV4L29mX2RldmljZS5oPg0KPiArI2luY2x1
ZGUgPGxpbnV4L3BsYXRmb3JtX2RldmljZS5oPg0KPiArI2luY2x1ZGUgPGxpbnV4L3NsYWIuaD4N
Cj4gKw0KPiArZW51bSBvY290cF9kZXZ0eXBlIHsNCj4gKwlJTVg4UVhQLA0KPiArfTsNCj4gKw0K
PiArc3RydWN0IG9jb3RwX2RldnR5cGVfZGF0YSB7DQo+ICsJaW50IGRldnR5cGU7DQo+ICsJaW50
IG5yZWdzOw0KPiArfTsNCj4gKw0KPiArc3RydWN0IG9jb3RwX3ByaXYgew0KPiArCXN0cnVjdCBk
ZXZpY2UgKmRldjsNCj4gKwljb25zdCBzdHJ1Y3Qgb2NvdHBfZGV2dHlwZV9kYXRhICpkYXRhOw0K
PiArCXN0cnVjdCBpbXhfc2NfaXBjICpudm1lbV9pcGM7DQo+ICt9Ow0KPiArDQo+ICtzdGF0aWMg
c3RydWN0IG9jb3RwX2RldnR5cGVfZGF0YSBpbXg4cXhwX2RhdGEgPSB7DQo+ICsJLmRldnR5cGUg
PSBJTVg4UVhQLA0KPiArCS5ucmVncyA9IDgwMCwNCj4gK307DQo+ICsNCj4gK3N0YXRpYyBpbnQg
aW14X3NjdV9vY290cF9yZWFkKHZvaWQgKmNvbnRleHQsIHVuc2lnbmVkIGludCBvZmZzZXQsDQo+
ICsJCQkgICAgICB2b2lkICp2YWwsIHNpemVfdCBieXRlcykNCj4gK3sNCj4gKwlzdHJ1Y3Qgb2Nv
dHBfcHJpdiAqcHJpdiA9IGNvbnRleHQ7DQo+ICsJdTMyIGNvdW50LCBpbmRleCwgbnVtX2J5dGVz
Ow0KPiArCXU4ICpidWYsICpwOw0KDQpJdCBzZWVtcyBidWYgaGFzIG5ldmVyIGJlZW4gdXNlZCBh
cyB1OC4NClNvIHByb2JhYmx5IGEgYmV0dGVyIHdheSBpczoNClUzMiAqYnVmOw0KVm9pZCAqcC4N
ClRoZW4gd2UgY2FuIHNhdmUgYWxsIHRoZSBleHBsaWNpdCBjb252ZXJzaW9uIG9mIHUzMi4NCg0K
PiArCWludCBpLCByZXQ7DQo+ICsNCj4gKwlpbmRleCA9IG9mZnNldCA+PiAyOw0KPiArCW51bV9i
eXRlcyA9IHJvdW5kX3VwKChvZmZzZXQgJSA0KSArIGJ5dGVzLCA0KTsNCj4gKwljb3VudCA9IG51
bV9ieXRlcyA+PiAyOw0KPiArDQo+ICsJaWYgKGNvdW50ID4gKHByaXYtPmRhdGEtPm5yZWdzIC0g
aW5kZXgpKQ0KPiArCQljb3VudCA9IHByaXYtPmRhdGEtPm5yZWdzIC0gaW5kZXg7DQo+ICsNCj4g
KwlwID0ga3phbGxvYyhudW1fYnl0ZXMsIEdGUF9LRVJORUwpOw0KPiArCWlmICghcCkNCj4gKwkJ
cmV0dXJuIC1FTk9NRU07DQo+ICsNCj4gKwlidWYgPSBwOw0KPiArDQo+ICsJZm9yIChpID0gaW5k
ZXg7IGkgPCAoaW5kZXggKyBjb3VudCk7IGkrKykgew0KPiArCQlpZiAocHJpdi0+ZGF0YS0+ZGV2
dHlwZSA9PSBJTVg4UVhQKSB7DQo+ICsJCQlpZiAoKGkgPiAyNzEpICYmIChpIDwgNTQ0KSkgew0K
PiArCQkJCSoodTMyICopYnVmID0gMDsNCj4gKwkJCQlidWYgKz0gNDsNCj4gKwkJCQljb250aW51
ZTsNCj4gKwkJCX0NCj4gKwkJfQ0KPiArDQo+ICsJCXJldCA9IGlteF9zY19taXNjX290cF9mdXNl
X3JlYWQocHJpdi0+bnZtZW1faXBjLCBpLA0KPiArCQkJCQkJKHUzMiAqKWJ1Zik7DQoNCklzIHRo
aXMgQVBJIGFscmVhZHkgaW4ga2VybmVsPw0KDQo+ICsJCWlmIChyZXQpIHsNCj4gKwkJCWtmcmVl
KHApOw0KPiArCQkJcmV0dXJuIHJldDsNCj4gKwkJfQ0KPiArCQlidWYgKz0gNDsNCj4gKwl9DQo+
ICsNCj4gKwlpbmRleCA9IG9mZnNldCAlIDQ7DQo+ICsJbWVtY3B5KHZhbCwgJnBbaW5kZXhdLCBi
eXRlcyk7DQo+ICsNCj4gKwlrZnJlZShwKTsNCj4gKw0KPiArCXJldHVybiAwOw0KPiArfQ0KPiAr
DQo+ICtzdGF0aWMgc3RydWN0IG52bWVtX2NvbmZpZyBpbXhfc2N1X29jb3RwX252bWVtX2NvbmZp
ZyA9IHsNCj4gKwkubmFtZSA9ICJpbXgtb2NvdHAiLA0KDQppbXgtc2N1LW9jdG9wDQoNCj4gKwku
cmVhZF9vbmx5ID0gdHJ1ZSwNCj4gKwkud29yZF9zaXplID0gNCwNCj4gKwkuc3RyaWRlID0gMSwN
Cj4gKwkub3duZXIgPSBUSElTX01PRFVMRSwNCj4gKwkucmVnX3JlYWQgPSBpbXhfc2N1X29jb3Rw
X3JlYWQsDQo+ICt9Ow0KPiArDQo+ICtzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCBp
bXhfc2N1X29jb3RwX2R0X2lkc1tdID0gew0KPiArCXsgLmNvbXBhdGlibGUgPSAiZnNsLGlteDhx
eHAtb2NvdHAiLCAodm9pZCAqKSZpbXg4cXhwX2RhdGEgfSwNCj4gKwl7IH0sDQo+ICt9Ow0KPiAr
TU9EVUxFX0RFVklDRV9UQUJMRShvZiwgaW14X3NjdV9vY290cF9kdF9pZHMpOw0KPiArDQo+ICtz
dGF0aWMgaW50IGlteF9zY3Vfb2NvdHBfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRl
dikgew0KPiArCXN0cnVjdCBkZXZpY2UgKmRldiA9ICZwZGV2LT5kZXY7DQo+ICsJc3RydWN0IG9j
b3RwX3ByaXYgKnByaXY7DQo+ICsJc3RydWN0IG52bWVtX2RldmljZSAqbnZtZW07DQo+ICsJaW50
IHJldDsNCj4gKw0KPiArCXByaXYgPSBkZXZtX2t6YWxsb2MoZGV2LCBzaXplb2YoKnByaXYpLCBH
RlBfS0VSTkVMKTsNCj4gKwlpZiAoIXByaXYpDQo+ICsJCXJldHVybiAtRU5PTUVNOw0KPiArDQo+
ICsJcmV0ID0gaW14X3NjdV9nZXRfaGFuZGxlKCZwcml2LT5udm1lbV9pcGMpOw0KPiArCWlmIChy
ZXQpDQo+ICsJCXJldHVybiByZXQ7DQo+ICsNCj4gKwlwcml2LT5kYXRhID0gb2ZfZGV2aWNlX2dl
dF9tYXRjaF9kYXRhKGRldik7DQo+ICsJcHJpdi0+ZGV2ID0gZGV2Ow0KPiArCWlteF9zY3Vfb2Nv
dHBfbnZtZW1fY29uZmlnLnNpemUgPSA0ICogcHJpdi0+ZGF0YS0+bnJlZ3M7DQo+ICsJaW14X3Nj
dV9vY290cF9udm1lbV9jb25maWcuZGV2ID0gZGV2Ow0KPiArCWlteF9zY3Vfb2NvdHBfbnZtZW1f
Y29uZmlnLnByaXYgPSBwcml2Ow0KPiArCW52bWVtID0gZGV2bV9udm1lbV9yZWdpc3RlcihkZXYs
ICZpbXhfc2N1X29jb3RwX252bWVtX2NvbmZpZyk7DQo+ICsNCj4gKwlyZXR1cm4gUFRSX0VSUl9P
Ul9aRVJPKG52bWVtKTsNCj4gK30NCj4gKw0KPiArc3RhdGljIHN0cnVjdCBwbGF0Zm9ybV9kcml2
ZXIgaW14X3NjdV9vY290cF9kcml2ZXIgPSB7DQo+ICsJLnByb2JlCT0gaW14X3NjdV9vY290cF9w
cm9iZSwNCj4gKwkuZHJpdmVyID0gew0KPiArCQkubmFtZQk9ICJpbXhfc2N1X29jb3RwIiwNCj4g
KwkJLm9mX21hdGNoX3RhYmxlID0gaW14X3NjdV9vY290cF9kdF9pZHMsDQo+ICsJfSwNCj4gK307
DQo+ICttb2R1bGVfcGxhdGZvcm1fZHJpdmVyKGlteF9zY3Vfb2NvdHBfZHJpdmVyKTsNCj4gKw0K
PiArTU9EVUxFX0FVVEhPUigiUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+Iik7DQo+ICtNT0RV
TEVfREVTQ1JJUFRJT04oImkuTVg4UU0gT0NPVFAgZnVzZSBib3ggZHJpdmVyIik7DQoNCmkuTVg4
IFNDVSBPQ09UUCBmdXNlIGJveCBkcml2ZXINCg0KUmVnYXJkcw0KRG9uZyBBaXNoZW5nDQoNCj4g
K01PRFVMRV9MSUNFTlNFKCJHUEwgdjIiKTsNCj4gLS0NCj4gMi4xNi40DQoNCg==
