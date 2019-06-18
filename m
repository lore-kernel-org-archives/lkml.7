Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36091C31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 09:45:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 003D32070B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 09:45:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="heJV77Sz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729353AbfFRJpU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 05:45:20 -0400
Received: from mail-eopbgr30066.outbound.protection.outlook.com ([40.107.3.66]:11673
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729230AbfFRJpU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 05:45:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0H89k2AoZhrV0TSzPJzRfK3OJx5SjnZPRp/rdgl1/Bc=;
 b=heJV77SzxSJRtj0PwvnaesafTc27dHk4+QscRgZF2nU6hjLVng1DM29iMvENdR0XaQLaORdX5UifOZ8bEyfAibTwNKboL/vTk1R9iAUQfGudE6l9rd09/zgGqyXtoZkQjJdlrkv2p7MS2XgNk7FT6a6kHVw/9r+ixWc5ukTnVcA=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3641.eurprd04.prod.outlook.com (52.134.69.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.12; Tue, 18 Jun 2019 09:44:35 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::5835:e874:bd94:fec]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::5835:e874:bd94:fec%5]) with mapi id 15.20.1987.014; Tue, 18 Jun 2019
 09:44:35 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>
CC:     "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        Abel Vesa <abel.vesa@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V2 2/2] soc: imx8: Use existing of_root directly
Thread-Topic: [PATCH V2 2/2] soc: imx8: Use existing of_root directly
Thread-Index: AQHVIogDK1yz8od2k06kc5I/LWM47qahJ3qAgAAHn0A=
Date:   Tue, 18 Jun 2019 09:44:35 +0000
Message-ID: <DB3PR0402MB3916AF21E4C4199E083790A1F5EA0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <20190614080748.32997-1-Anson.Huang@nxp.com>
 <20190614080748.32997-2-Anson.Huang@nxp.com> <20190618091442.GM29881@dragon>
In-Reply-To: <20190618091442.GM29881@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 95f21d7a-63bf-4292-ee75-08d6f3d192f3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3641;
x-ms-traffictypediagnostic: DB3PR0402MB3641:
x-microsoft-antispam-prvs: <DB3PR0402MB36411B7D585F53306811BBF7F5EA0@DB3PR0402MB3641.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 007271867D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(376002)(39860400002)(346002)(366004)(13464003)(189003)(199004)(476003)(446003)(11346002)(5660300002)(9686003)(53936002)(55016002)(6246003)(3846002)(53546011)(54906003)(76176011)(44832011)(33656002)(486006)(66556008)(66946007)(7736002)(6506007)(6916009)(8936002)(305945005)(74316002)(25786009)(102836004)(73956011)(6436002)(4326008)(8676002)(81166006)(76116006)(7696005)(256004)(99286004)(66066001)(66476007)(6116002)(64756008)(186003)(66446008)(26005)(71200400001)(52536014)(68736007)(316002)(229853002)(71190400001)(2906002)(478600001)(14454004)(81156014)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3641;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: EU8P6xdtiXe+znPd2l12sbjJWCizeywZR/ZZAASl/yPLqaHAOAat45i8C9g25Sotv8BvEbxFiN1YCUPV237ly4bEcyOu59/BQoUgyl8EFNyIYGCJHLV4Dq7/RCV+MamuFyyqy1qD+jzeqCnLg6NJJTH2MSUapyf92CezHXf2Z5E2CZt5dAyZuENnv9OQt6ppePmcbuu99c0kbAM6P2574XvE6EXUqetwe+Ukzf5hX3rj0T9PAwrQvj9ZhYPiT7jnAT1Iwv8cdJRfHPpqPj2CPJgPlg5mE/UkuBO0Kjejmh4++WiPbPEj5tCmMQ7lyQo8ImXIF5cTxpDYleB6fWcqz9iuWclXpuGvB/yuHsdf3ADm2Vgk3bKrlFk0ewWGH8TBTt+7QDjKHVFQnoDxNGoRpJaQUNJ9Ri5Xbko9akDsctA=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95f21d7a-63bf-4292-ee75-08d6f3d192f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2019 09:44:35.6909
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: anson.huang@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3641
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFNoYXduDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU2hhd24g
R3VvIDxzaGF3bmd1b0BrZXJuZWwub3JnPg0KPiBTZW50OiBUdWVzZGF5LCBKdW5lIDE4LCAyMDE5
IDU6MTUgUE0NCj4gVG86IEFuc29uIEh1YW5nIDxhbnNvbi5odWFuZ0BueHAuY29tPg0KPiBDYzog
cy5oYXVlckBwZW5ndXRyb25peC5kZTsga2VybmVsQHBlbmd1dHJvbml4LmRlOyBmZXN0ZXZhbUBn
bWFpbC5jb207DQo+IExlb25hcmQgQ3Jlc3RleiA8bGVvbmFyZC5jcmVzdGV6QG54cC5jb20+OyB2
aXJlc2gua3VtYXJAbGluYXJvLm9yZzsNCj4gQWJlbCBWZXNhIDxhYmVsLnZlc2FAbnhwLmNvbT47
IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsNCj4gbGludXgta2VybmVsQHZn
ZXIua2VybmVsLm9yZzsgZGwtbGludXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT4NCj4gU3ViamVj
dDogUmU6IFtQQVRDSCBWMiAyLzJdIHNvYzogaW14ODogVXNlIGV4aXN0aW5nIG9mX3Jvb3QgZGly
ZWN0bHkNCj4gDQo+IE9uIEZyaSwgSnVuIDE0LCAyMDE5IGF0IDA0OjA3OjQ4UE0gKzA4MDAsIEFu
c29uLkh1YW5nQG54cC5jb20gd3JvdGU6DQo+ID4gRnJvbTogQW5zb24gSHVhbmcgPEFuc29uLkh1
YW5nQG54cC5jb20+DQo+ID4NCj4gPiBUaGVyZSBpcyBjb21tb24gb2Zfcm9vdCBmb3IgcmVmZXJl
bmNlLCBubyBuZWVkIHRvIGZpbmQgaXQgZnJvbSBEVA0KPiA+IGFnYWluLCB1c2Ugb2Zfcm9vdCBk
aXJlY3RseSB0byBtYWtlIGRyaXZlciBzaW1wbGUuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBB
bnNvbiBIdWFuZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4NCj4gPiBSZXZpZXdlZC1ieTogRG9uZyBB
aXNoZW5nIDxhaXNoZW5nLmRvbmdAbnhwLmNvbT4NCj4gDQo+IEl0IGNhbm5vdCBiZSBhcHBsaWVk
LiAgUGxlYXNlIHJlc2VuZCBieSBiYXNpbmcgb24gbXkgaW14L2RyaXZlcnMgYnJhbmNoLg0KDQpP
SywganVzdCByZXNlbnQsIHRoZXJlIGlzIGEgc29jIGRyaXZlciBwYXRjaCBpbiBsaW51eC1uZXh0
LCBwcmV2aW91c2x5IEkgZGlkIGl0IGJhc2VkIG9uIGl0Lg0KTm93IEkgY2hhbmdlIGl0IHRvIHlv
dXIgZ2l0IHJlcG8sIHlvdSBjb3VsZCBtZWV0IGNvbmZsaWN0IGR1cmluZyBtZXJnZS4NCg0KVGhh
bmtzLA0KQW5zb24NCg0KPiANCj4gU2hhd24NCj4gDQo+ID4gLS0tDQo+ID4gTm8gY2hhbmdlcy4N
Cj4gPiAtLS0NCj4gPiAgZHJpdmVycy9zb2MvaW14L3NvYy1pbXg4LmMgfCA5ICsrLS0tLS0tLQ0K
PiA+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQ0KPiA+
DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvc29jL2lteC9zb2MtaW14OC5jIGIvZHJpdmVycy9z
b2MvaW14L3NvYy1pbXg4LmMNCj4gPiBpbmRleCA1YzdmMzMwLi5iNDU5YmYyIDEwMDY0NA0KPiA+
IC0tLSBhL2RyaXZlcnMvc29jL2lteC9zb2MtaW14OC5jDQo+ID4gKysrIGIvZHJpdmVycy9zb2Mv
aW14L3NvYy1pbXg4LmMNCj4gPiBAQCAtMTA1LDcgKzEwNSw2IEBAIHN0YXRpYyBpbnQgX19pbml0
IGlteDhfc29jX2luaXQodm9pZCkgIHsNCj4gPiAgCXN0cnVjdCBzb2NfZGV2aWNlX2F0dHJpYnV0
ZSAqc29jX2Rldl9hdHRyOw0KPiA+ICAJc3RydWN0IHNvY19kZXZpY2UgKnNvY19kZXY7DQo+ID4g
LQlzdHJ1Y3QgZGV2aWNlX25vZGUgKnJvb3Q7DQo+ID4gIAljb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNl
X2lkICppZDsNCj4gPiAgCXUzMiBzb2NfcmV2ID0gMDsNCj4gPiAgCWNvbnN0IHN0cnVjdCBpbXg4
X3NvY19kYXRhICpkYXRhOw0KPiA+IEBAIC0xMTcsMTIgKzExNiwxMSBAQCBzdGF0aWMgaW50IF9f
aW5pdCBpbXg4X3NvY19pbml0KHZvaWQpDQo+ID4NCj4gPiAgCXNvY19kZXZfYXR0ci0+ZmFtaWx5
ID0gIkZyZWVzY2FsZSBpLk1YIjsNCj4gPg0KPiA+IC0Jcm9vdCA9IG9mX2ZpbmRfbm9kZV9ieV9w
YXRoKCIvIik7DQo+ID4gLQlyZXQgPSBvZl9wcm9wZXJ0eV9yZWFkX3N0cmluZyhyb290LCAibW9k
ZWwiLCAmc29jX2Rldl9hdHRyLQ0KPiA+bWFjaGluZSk7DQo+ID4gKwlyZXQgPSBvZl9wcm9wZXJ0
eV9yZWFkX3N0cmluZyhvZl9yb290LCAibW9kZWwiLA0KPiA+ICsmc29jX2Rldl9hdHRyLT5tYWNo
aW5lKTsNCj4gPiAgCWlmIChyZXQpDQo+ID4gIAkJZ290byBmcmVlX3NvYzsNCj4gPg0KPiA+IC0J
aWQgPSBvZl9tYXRjaF9ub2RlKGlteDhfc29jX21hdGNoLCByb290KTsNCj4gPiArCWlkID0gb2Zf
bWF0Y2hfbm9kZShpbXg4X3NvY19tYXRjaCwgb2Zfcm9vdCk7DQo+ID4gIAlpZiAoIWlkKSB7DQo+
ID4gIAkJcmV0ID0gLUVOT0RFVjsNCj4gPiAgCQlnb3RvIGZyZWVfc29jOw0KPiA+IEBAIC0xNDcs
OCArMTQ1LDYgQEAgc3RhdGljIGludCBfX2luaXQgaW14OF9zb2NfaW5pdCh2b2lkKQ0KPiA+ICAJ
CWdvdG8gZnJlZV9yZXY7DQo+ID4gIAl9DQo+ID4NCj4gPiAtCW9mX25vZGVfcHV0KHJvb3QpOw0K
PiA+IC0NCj4gPiAgCWlmIChJU19FTkFCTEVEKENPTkZJR19BUk1fSU1YX0NQVUZSRVFfRFQpKQ0K
PiA+ICAJCXBsYXRmb3JtX2RldmljZV9yZWdpc3Rlcl9zaW1wbGUoImlteC1jcHVmcmVxLWR0Iiwg
LTEsIE5VTEwsDQo+IDApOw0KPiA+DQo+ID4gQEAgLTE1OSw3ICsxNTUsNiBAQCBzdGF0aWMgaW50
IF9faW5pdCBpbXg4X3NvY19pbml0KHZvaWQpDQo+ID4gIAkJa2ZyZWUoc29jX2Rldl9hdHRyLT5y
ZXZpc2lvbik7DQo+ID4gIGZyZWVfc29jOg0KPiA+ICAJa2ZyZWUoc29jX2Rldl9hdHRyKTsNCj4g
PiAtCW9mX25vZGVfcHV0KHJvb3QpOw0KPiA+ICAJcmV0dXJuIHJldDsNCj4gPiAgfQ0KPiA+ICBk
ZXZpY2VfaW5pdGNhbGwoaW14OF9zb2NfaW5pdCk7DQo+ID4gLS0NCj4gPiAyLjcuNA0KPiA+DQo=
