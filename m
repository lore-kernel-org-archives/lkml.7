Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A57C2C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 03:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 636DF21473
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 03:25:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="QWUloYdh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbfDIDZQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 23:25:16 -0400
Received: from mail-eopbgr00045.outbound.protection.outlook.com ([40.107.0.45]:1958
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726464AbfDIDZP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 23:25:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wfGfXFmyd6e0lkpWoxkIitbi+X8yUACOMs42hyst25U=;
 b=QWUloYdhpbx3KrO+XKixQQkR2aJt0IIpiA6jK/v3Z7dGAXNm2m1atvBN7qYastS9kV+G6OItUSI3VDl2ePbD2CWx7TPZ8+llUMtSTZSu1Sj6fIX1iDKARxyL1AUVaTaPYOh293WDNbvhgvuVjxUk4Il8ZOCgeMMoUyIKO2e/tmo=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.92.158) by
 AM0PR04MB5089.eurprd04.prod.outlook.com (52.134.89.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.19; Tue, 9 Apr 2019 03:25:10 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::8cda:4e52:8e87:8f0e]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::8cda:4e52:8e87:8f0e%2]) with mapi id 15.20.1771.016; Tue, 9 Apr 2019
 03:25:10 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>, Peng Fan <peng.fan@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V6 4/4] rtc: imx-sc: add rtc alarm support
Thread-Topic: [PATCH V6 4/4] rtc: imx-sc: add rtc alarm support
Thread-Index: AQHU7n4FMdKcp4NQJ0ukn8zURCHpWaYzKXfg
Date:   Tue, 9 Apr 2019 03:25:10 +0000
Message-ID: <AM0PR04MB4211CEA77AB034B5DCF71FE2802D0@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1554777487-31075-1-git-send-email-Anson.Huang@nxp.com>
 <1554777487-31075-4-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1554777487-31075-4-git-send-email-Anson.Huang@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0287eabb-303f-41c7-6bf5-08d6bc9af8fe
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB5089;
x-ms-traffictypediagnostic: AM0PR04MB5089:
x-microsoft-antispam-prvs: <AM0PR04MB5089ADFC3108EEB02AAE868B802D0@AM0PR04MB5089.eurprd04.prod.outlook.com>
x-forefront-prvs: 000227DA0C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(346002)(376002)(39860400002)(136003)(189003)(199004)(26005)(6506007)(4326008)(71190400001)(2501003)(44832011)(446003)(2201001)(14454004)(97736004)(476003)(102836004)(186003)(76176011)(33656002)(53546011)(86362001)(11346002)(66066001)(71200400001)(53936002)(6246003)(478600001)(110136005)(316002)(25786009)(7416002)(3846002)(6116002)(486006)(7696005)(55016002)(7736002)(8936002)(8676002)(81156014)(81166006)(9686003)(6436002)(229853002)(14444005)(5660300002)(256004)(68736007)(2906002)(106356001)(99286004)(105586002)(74316002)(305945005)(52536014)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5089;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: TaMp1xXyt1W8AFKeuKN+2xcG93xLKp3QUOJ3Itn3PkE9ylvMGq199pEr0vNMBQlw80aJ8xbdL+RK9tNfHQbVIfNEB/ADR0HgKKDprWw0AwBCBfSAFgEcQMUZdRtfbW6oTSHsMs0tTElMpB6FA+InzewbDy9nMqhwmBeBgTpUdfXZHOJM6FZlVdzL+vkSUs+lEHLFfkyfQQjEffm/W+g5z2UyI+YZE1i0a2UhzdarEZyQV5o49sX3/xVOWjEd6+ziy+hsAuOW3jT7W+4cYF8JeTpDAmWuYZ9e+B+rBAxONZu/ha78YM6q/p5iPo520YJlvlHJEx3gHb4nRSACPP30TgQs/LVJ/DiniiG7LS+0+cybtfqvF241kxWRSjF4a0MLaaJ8g5E654fVEThPgmH7LSW8OAAU7HLdHQFQPHoENA4=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0287eabb-303f-41c7-6bf5-08d6bc9af8fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2019 03:25:10.6461
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5089
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBBbnNvbiBIdWFuZw0KPiBTZW50OiBUdWVzZGF5LCBBcHJpbCA5LCAyMDE5IDEwOjQ0
IEFNDQo+IFN1YmplY3Q6IFtQQVRDSCBWNiA0LzRdIHJ0YzogaW14LXNjOiBhZGQgcnRjIGFsYXJt
IHN1cHBvcnQNCj4gDQo+IEFkZCBpLk1YIHN5c3RlbSBjb250cm9sbGVyIFJUQyBhbGFybSBzdXBw
b3J0LCB0aGUgUlRDIGFsYXJtIGlzIGltcGxlbWVudGVkDQo+IHZpYSBTSVAoc2lsaWNvbiBwcm92
aWRlcikgcnVudGltZSBzZXJ2aWNlIGNhbGwgYW5kIEFSTS1UcnVzdGVkLUZpcm13YXJlIHdpbGwN
Cj4gY29tbXVuaWNhdGUgd2l0aCBzeXN0ZW0gY29udHJvbGxlciB2aWEgTVUobWVzc2FnZSB1bml0
KSBJUEMgdG8gc2V0IFJUQw0KPiBhbGFybS4gV2hlbiBSVEMgYWxhcm0gZmlyZXMsIHN5c3RlbSBj
b250cm9sbGVyIHdpbGwgZ2VuZXJhdGUgYSBjb21tb24gTVUNCj4gaXJxIGV2ZW50IGFuZCBub3Rp
Znkgc3lzdGVtIGNvbnRyb2xsZXIgUlRDIGRyaXZlciB0byBoYW5kbGUgdGhlIGlycSBldmVudC4N
Cj4gDQo+IFNpZ25lZC1vZmYtYnk6IEFuc29uIEh1YW5nIDxBbnNvbi5IdWFuZ0BueHAuY29tPg0K
PiAtLS0NCj4gQ2hhbmdlcyBzaW5jZSBWNToNCj4gCS0gbW92ZSB0aGUgaXJxIGFsYXJtIGVuYWJs
ZSBSUEMgdG8gaW14LXNjdS1pcnEgZHJpdmVyLCBhbmQgcnRjIGRyaXZlciBqdXN0DQo+IGNhbGwg
dGhlDQo+IAkgIEFQSSB0byBlbmFibGUvZGlzYWJsZSBhbGFybS4NCj4gLS0tDQo+ICBkcml2ZXJz
L3J0Yy9ydGMtaW14LXNjLmMgfCA4NA0KPiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCA4NCBpbnNlcnRpb25zKCspDQo+
IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ydGMvcnRjLWlteC1zYy5jIGIvZHJpdmVycy9ydGMv
cnRjLWlteC1zYy5jIGluZGV4DQo+IDE5NjQyYmYuLjNlYjRkYjAgMTAwNjQ0DQo+IC0tLSBhL2Ry
aXZlcnMvcnRjL3J0Yy1pbXgtc2MuYw0KPiArKysgYi9kcml2ZXJzL3J0Yy9ydGMtaW14LXNjLmMN
Cj4gQEAgLTMsNiArMyw3IEBADQo+ICAgKiBDb3B5cmlnaHQgMjAxOCBOWFAuDQo+ICAgKi8NCj4g
DQo+ICsjaW5jbHVkZSA8ZHQtYmluZGluZ3MvZmlybXdhcmUvaW14L3JzcmMuaD4NCj4gICNpbmNs
dWRlIDxsaW51eC9hcm0tc21jY2MuaD4NCj4gICNpbmNsdWRlIDxsaW51eC9maXJtd2FyZS9pbXgv
c2NpLmg+DQo+ICAjaW5jbHVkZSA8bGludXgvbW9kdWxlLmg+DQo+IEBAIC0xMSwxMSArMTIsMTUg
QEANCj4gICNpbmNsdWRlIDxsaW51eC9ydGMuaD4NCj4gDQo+ICAjZGVmaW5lIElNWF9TQ19USU1F
Ul9GVU5DX0dFVF9SVENfU0VDMTk3MAk5DQo+ICsjZGVmaW5lIElNWF9TQ19USU1FUl9GVU5DX1NF
VF9SVENfQUxBUk0JCTgNCj4gICNkZWZpbmUgSU1YX1NDX1RJTUVSX0ZVTkNfU0VUX1JUQ19USU1F
CQk2DQo+IA0KPiAgI2RlZmluZSBJTVhfU0lQX1NSVEMJCQkweEMyMDAwMDAyDQo+ICAjZGVmaW5l
IElNWF9TSVBfU1JUQ19TRVRfVElNRQkJMHgwDQo+IA0KPiArI2RlZmluZSBTQ19JUlFfR1JPVVBf
UlRDICAgIDINCj4gKyNkZWZpbmUgU0NfSVJRX1JUQyAgICAgICAgICAxDQo+ICsNCj4gIHN0YXRp
YyBzdHJ1Y3QgaW14X3NjX2lwYyAqcnRjX2lwY19oYW5kbGU7ICBzdGF0aWMgc3RydWN0IHJ0Y19k
ZXZpY2UNCj4gKmlteF9zY19ydGM7DQo+IA0KPiBAQCAtMjQsNiArMjksMTYgQEAgc3RydWN0IGlt
eF9zY19tc2dfdGltZXJfZ2V0X3J0Y190aW1lIHsNCj4gIAl1MzIgdGltZTsNCj4gIH0gX19wYWNr
ZWQ7DQo+IA0KPiArc3RydWN0IGlteF9zY19tc2dfdGltZXJfcnRjX3NldF9hbGFybSB7DQo+ICsJ
c3RydWN0IGlteF9zY19ycGNfbXNnIGhkcjsNCj4gKwl1MTYgeWVhcjsNCj4gKwl1OCBtb247DQo+
ICsJdTggZGF5Ow0KPiArCXU4IGhvdXI7DQo+ICsJdTggbWluOw0KPiArCXU4IHNlYzsNCj4gK30g
X19wYWNrZWQ7DQo+ICsNCj4gIHN0YXRpYyBpbnQgaW14X3NjX3J0Y19yZWFkX3RpbWUoc3RydWN0
IGRldmljZSAqZGV2LCBzdHJ1Y3QgcnRjX3RpbWUgKnRtKSAgew0KPiAgCXN0cnVjdCBpbXhfc2Nf
bXNnX3RpbWVyX2dldF9ydGNfdGltZSBtc2c7IEBAIC02MCw5ICs3NSw3NCBAQCBzdGF0aWMNCj4g
aW50IGlteF9zY19ydGNfc2V0X3RpbWUoc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgcnRjX3Rp
bWUgKnRtKQ0KPiAgCXJldHVybiByZXMuYTA7DQo+ICB9DQo+IA0KPiArc3RhdGljIGludCBpbXhf
c2NfcnRjX2FsYXJtX2lycV9lbmFibGUoc3RydWN0IGRldmljZSAqZGV2LCB1bnNpZ25lZCBpbnQN
Cj4gK2VuYWJsZSkgew0KPiArCWlteF9zY3VfaXJxX2VuYWJsZShTQ19JUlFfR1JPVVBfUlRDLCBT
Q19JUlFfUlRDLCBlbmFibGUpOw0KPiArDQo+ICsJcmV0dXJuIDA7DQo+ICt9DQo+ICsNCj4gK3N0
YXRpYyBpbnQgaW14X3NjX3J0Y19yZWFkX2FsYXJtKHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0
IHJ0Y193a2Fscm0NCj4gKyphbHJtKSB7DQoNCkkgc3RpbGwgdGhpbmsgaGVyZSBuZWVkcyBhIGRv
YyBleHBsYWluIHdoeSBuZWVkcyB0aGlzIGFuZCB3aHkgaXQncyBzYWZlIHRvIGRvIHRoYXQuDQpP
dGhlcndpc2U6DQpSZXZpZXdlZC1ieTogRG9uZyBBaXNoZW5nIDxhaXNoZW5nLmRvbmdAbnhwLmNv
bT4NCg0KPiArCXJldHVybiAwOw0KPiArfQ0KPiArDQo+ICtzdGF0aWMgaW50IGlteF9zY19ydGNf
c2V0X2FsYXJtKHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IHJ0Y193a2Fscm0NCj4gKyphbHJt
KSB7DQo+ICsJc3RydWN0IGlteF9zY19tc2dfdGltZXJfcnRjX3NldF9hbGFybSBtc2c7DQo+ICsJ
c3RydWN0IGlteF9zY19ycGNfbXNnICpoZHIgPSAmbXNnLmhkcjsNCj4gKwlpbnQgcmV0Ow0KPiAr
CXN0cnVjdCBydGNfdGltZSAqYWxybV90bSA9ICZhbHJtLT50aW1lOw0KPiArDQo+ICsJaGRyLT52
ZXIgPSBJTVhfU0NfUlBDX1ZFUlNJT047DQo+ICsJaGRyLT5zdmMgPSBJTVhfU0NfUlBDX1NWQ19U
SU1FUjsNCj4gKwloZHItPmZ1bmMgPSBJTVhfU0NfVElNRVJfRlVOQ19TRVRfUlRDX0FMQVJNOw0K
PiArCWhkci0+c2l6ZSA9IDM7DQo+ICsNCj4gKwltc2cueWVhciA9IGFscm1fdG0tPnRtX3llYXIg
KyAxOTAwOw0KPiArCW1zZy5tb24gPSBhbHJtX3RtLT50bV9tb24gKyAxOw0KPiArCW1zZy5kYXkg
PSBhbHJtX3RtLT50bV9tZGF5Ow0KPiArCW1zZy5ob3VyID0gYWxybV90bS0+dG1faG91cjsNCj4g
Kwltc2cubWluID0gYWxybV90bS0+dG1fbWluOw0KPiArCW1zZy5zZWMgPSBhbHJtX3RtLT50bV9z
ZWM7DQo+ICsNCj4gKwlyZXQgPSBpbXhfc2N1X2NhbGxfcnBjKHJ0Y19pcGNfaGFuZGxlLCAmbXNn
LCB0cnVlKTsNCj4gKwlpZiAocmV0KSB7DQo+ICsJCWRldl9lcnIoZGV2LCAic2V0IHJ0YyBhbGFy
bSBmYWlsZWQsIHJldCAlZFxuIiwgcmV0KTsNCj4gKwkJcmV0dXJuIHJldDsNCj4gKwl9DQo+ICsN
Cj4gKwlyZXQgPSBpbXhfc2NfcnRjX2FsYXJtX2lycV9lbmFibGUoZGV2LCBhbHJtLT5lbmFibGVk
KTsNCj4gKwlpZiAocmV0KSB7DQo+ICsJCWRldl9lcnIoZGV2LCAiZW5hYmxlIHJ0YyBhbGFybSBm
YWlsZWQsIHJldCAlZFxuIiwgcmV0KTsNCj4gKwkJcmV0dXJuIHJldDsNCj4gKwl9DQo+ICsNCj4g
KwlyZXR1cm4gMDsNCj4gK30NCj4gKw0KPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBydGNfY2xhc3Nf
b3BzIGlteF9zY19ydGNfb3BzID0gew0KPiAgCS5yZWFkX3RpbWUgPSBpbXhfc2NfcnRjX3JlYWRf
dGltZSwNCj4gIAkuc2V0X3RpbWUgPSBpbXhfc2NfcnRjX3NldF90aW1lLA0KPiArCS5yZWFkX2Fs
YXJtID0gaW14X3NjX3J0Y19yZWFkX2FsYXJtLA0KPiArCS5zZXRfYWxhcm0gPSBpbXhfc2NfcnRj
X3NldF9hbGFybSwNCj4gKwkuYWxhcm1faXJxX2VuYWJsZSA9IGlteF9zY19ydGNfYWxhcm1faXJx
X2VuYWJsZSwgfTsNCj4gKw0KPiArc3RhdGljIGludCBpbXhfc2NfcnRjX2FsYXJtX3NjX25vdGlm
eShzdHJ1Y3Qgbm90aWZpZXJfYmxvY2sgKm5iLA0KPiArCQkJCQl1bnNpZ25lZCBsb25nIGV2ZW50
LCB2b2lkICpncm91cCkNCg0KTm90IG5lY2Vzc2FyeSB0byBoYXZlIHN1Y2ggYSBsb25nIGZ1bmN0
aW9uIG5hbWUuDQpJbXhfc2NfcnRjX2FsYXJtX25vdGlmeSgpIHNob3VsZCBiZSBvaw0KDQpSZWdh
cmRzDQpEb25nIEFpc2hlbmcNCg0KPiArew0KPiArCS8qIGlnbm9yZSBub24tcnRjIGlycSAqLw0K
PiArCWlmICghKChldmVudCAmIFNDX0lSUV9SVEMpICYmICgqKHU4ICopZ3JvdXAgPT0gU0NfSVJR
X0dST1VQX1JUQykpKQ0KPiArCQlyZXR1cm4gMDsNCj4gKw0KPiArCXJ0Y191cGRhdGVfaXJxKGlt
eF9zY19ydGMsIDEsIFJUQ19JUlFGIHwgUlRDX0FGKTsNCj4gKw0KPiArCXJldHVybiAwOw0KPiAr
fQ0KPiArDQo+ICtzdGF0aWMgc3RydWN0IG5vdGlmaWVyX2Jsb2NrIGlteF9zY19ydGNfYWxhcm1f
c2Nfbm90aWZpZXIgPSB7DQo+ICsJLm5vdGlmaWVyX2NhbGwgPSBpbXhfc2NfcnRjX2FsYXJtX3Nj
X25vdGlmeSwNCj4gIH07DQo+IA0KPiAgc3RhdGljIGludCBpbXhfc2NfcnRjX3Byb2JlKHN0cnVj
dCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpIEBAIC03Myw2ICsxNTMsOA0KPiBAQCBzdGF0aWMgaW50
IGlteF9zY19ydGNfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gIAlpZiAo
cmV0KQ0KPiAgCQlyZXR1cm4gcmV0Ow0KPiANCj4gKwlkZXZpY2VfaW5pdF93YWtldXAoJnBkZXYt
PmRldiwgdHJ1ZSk7DQo+ICsNCj4gIAlpbXhfc2NfcnRjID0gZGV2bV9ydGNfYWxsb2NhdGVfZGV2
aWNlKCZwZGV2LT5kZXYpOw0KPiAgCWlmIChJU19FUlIoaW14X3NjX3J0YykpDQo+ICAJCXJldHVy
biBQVFJfRVJSKGlteF9zY19ydGMpOw0KPiBAQCAtODcsNiArMTY5LDggQEAgc3RhdGljIGludCBp
bXhfc2NfcnRjX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UNCj4gKnBkZXYpDQo+ICAJCXJl
dHVybiByZXQ7DQo+ICAJfQ0KPiANCj4gKwlpbXhfc2N1X2lycV9yZWdpc3Rlcl9ub3RpZmllcigm
aW14X3NjX3J0Y19hbGFybV9zY19ub3RpZmllcik7DQo+ICsNCj4gIAlyZXR1cm4gMDsNCj4gIH0N
Cj4gDQo+IC0tDQo+IDIuNy40DQoNCg==
