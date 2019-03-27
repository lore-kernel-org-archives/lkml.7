Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CDB8C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 05:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B63BD2075E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 05:05:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ggJ+AsXl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbfC0FFd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 01:05:33 -0400
Received: from mail-eopbgr30059.outbound.protection.outlook.com ([40.107.3.59]:32942
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725730AbfC0FFc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 01:05:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+HnlqR99s0CXU2oB8Fh4poGC05k9hXH95Lst0eqScUg=;
 b=ggJ+AsXl8O3lD6QAaDEiCWUHh7uBvn7+O1nir3CqQGLu+czr5cogDDtPL8GbWMO7npSSkva2DBdjTFNPGhOVgXopC87VONiXcfBgPdS9rIbSEoDTZW5Z6nnO8zflxNNwDW/d8FPs0nCeEux7HsJOrIw8CQPm3pO4P8cbGWTduBA=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3899.eurprd04.prod.outlook.com (52.134.71.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.16; Wed, 27 Mar 2019 05:05:28 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::f1b4:a1fb:cfd1:3f08]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::f1b4:a1fb:cfd1:3f08%7]) with mapi id 15.20.1730.019; Wed, 27 Mar 2019
 05:05:28 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>
CC:     Fabio Estevam <fabio.estevam@nxp.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] input: keyboard: snvs: make sure irq is handled correctly
Thread-Topic: [PATCH] input: keyboard: snvs: make sure irq is handled
 correctly
Thread-Index: AQHU5Edd/2+nSp1pAUqjt9pZVWLgMKYe4qeAgAAJLYA=
Date:   Wed, 27 Mar 2019 05:05:28 +0000
Message-ID: <DB3PR0402MB3916979BF8E1E94C29063F3EF5580@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1553654517-7810-1-git-send-email-Anson.Huang@nxp.com>
 <20190327042903.GA40550@dtor-ws>
In-Reply-To: <20190327042903.GA40550@dtor-ws>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d1fe4e5f-7119-4381-5dde-08d6b271d43a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3899;
x-ms-traffictypediagnostic: DB3PR0402MB3899:
x-microsoft-antispam-prvs: <DB3PR0402MB389934E6636D70ACEB5D6614F5580@DB3PR0402MB3899.eurprd04.prod.outlook.com>
x-forefront-prvs: 0989A7979C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(366004)(376002)(346002)(39850400004)(189003)(199004)(13464003)(33656002)(4326008)(106356001)(97736004)(7736002)(99286004)(305945005)(25786009)(44832011)(2351001)(68736007)(71190400001)(71200400001)(74316002)(105586002)(256004)(14444005)(6916009)(2906002)(478600001)(66066001)(5660300002)(3846002)(6116002)(53936002)(6246003)(54906003)(316002)(2501003)(14454004)(229853002)(1361003)(55016002)(9686003)(6436002)(8936002)(5640700003)(52536014)(8676002)(476003)(86362001)(7696005)(26005)(486006)(81166006)(76176011)(81156014)(11346002)(53546011)(446003)(102836004)(6506007)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3899;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 6S/Wx5mMiWij6FCW9Jb9vWSAVBCn1nN1tA45ozbaxYLu3L9Um//mT75ZI3nhEp4+F/s9gfy+rrkeXt288ebcdCt1sHjVd4MjV7GQ0G08YAkbvBvsTcspUhdrR+bBVqz3+fnU7IS7orYSMaVuSLOAZ4nFNE/hJZ3swTO0kzPJ5PsTmYCBzp1mEBC4Mo3V7g+KFafh47wiwKVrSy6PKS28pz6hVJ797n9rbIrSmUZLJowO8YZg9wzTKs9MY6qVbgZiVcvaJLDXbXPbZrpUK0NmtKXCQmSPoISOMbm5gLE74FKd4g7ag/uNAGclP2bSh/4O6Usv5c0C20fDIwx1v5SmfwUqpRJejdaDa9hGoeeqefgvT5ZZqM9KutMajvzEeWB2VTtWPQYNywJDVhdtSrrb9CCQhazkWMorINty/9+MFN4=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1fe4e5f-7119-4381-5dde-08d6b271d43a
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2019 05:05:28.0346
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3899
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIERtaXRyeQ0KDQpCZXN0IFJlZ2FyZHMhDQpBbnNvbiBIdWFuZw0KDQo+IC0tLS0tT3JpZ2lu
YWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IGRtaXRyeS50b3Jva2hvdkBnbWFpbC5jb20gW21haWx0
bzpkbWl0cnkudG9yb2tob3ZAZ21haWwuY29tXQ0KPiBTZW50OiAyMDE5xOoz1MIyN8jVIDEyOjI5
DQo+IFRvOiBBbnNvbiBIdWFuZyA8YW5zb24uaHVhbmdAbnhwLmNvbT4NCj4gQ2M6IEZhYmlvIEVz
dGV2YW0gPGZhYmlvLmVzdGV2YW1AbnhwLmNvbT47IGxpbnV4LWlucHV0QHZnZXIua2VybmVsLm9y
ZzsNCj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgZGwtbGludXgtaW14IDxsaW51eC1p
bXhAbnhwLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gaW5wdXQ6IGtleWJvYXJkOiBzbnZz
OiBtYWtlIHN1cmUgaXJxIGlzIGhhbmRsZWQNCj4gY29ycmVjdGx5DQo+IA0KPiBIaSBBbnNvbiwN
Cj4gDQo+IE9uIFdlZCwgTWFyIDI3LCAyMDE5IGF0IDAyOjQ3OjA2QU0gKzAwMDAsIEFuc29uIEh1
YW5nIHdyb3RlOg0KPiA+IFNOVlMgSVJRIGlzIHJlcXVlc3RlZCBiZWZvcmUgbmVjZXNzYXJ5IGRy
aXZlciBkYXRhIGluaXRpYWxpemVkLCBpZg0KPiA+IHRoZXJlIGlzIGEgcGVuZGluZyBJUlEgZHVy
aW5nIGRyaXZlciBwcm9iZSBwaGFzZSwga2VybmVsIE5VTEwgcG9pbnRlcg0KPiA+IHBhbmljIHdp
bGwgb2NjdXIgaW4gSVJRIGhhbmRsZXIuIFRvIGF2b2lkIHN1Y2ggc2NlbmFyaW8sIG5lZWQgdG8g
bW92ZQ0KPiA+IHRoZSBJUlEgcmVxdWVzdCB0byBhZnRlciBkcml2ZXIgZGF0YSBpbml0aWFsaXph
dGlvbiBkb25lLiBUaGlzIHBhdGNoDQo+ID4gaXMgaW5zcGlyZWQgYnkgTlhQJ3MgaW50ZXJuYWwg
a2VybmVsIHRyZWUuDQo+ID4NCj4gPiBGaXhlczogZDNkYzZlMjMyMjE1ICgiaW5wdXQ6IGtleWJv
YXJkOiBpbXg6IGFkZCBzbnZzIHBvd2VyIGtleQ0KPiA+IGRyaXZlciIpDQo+ID4gU2lnbmVkLW9m
Zi1ieTogQW5zb24gSHVhbmcgPEFuc29uLkh1YW5nQG54cC5jb20+DQo+ID4gLS0tDQo+ID4gIGRy
aXZlcnMvaW5wdXQva2V5Ym9hcmQvc252c19wd3JrZXkuYyB8IDE3ICsrKysrKysrLS0tLS0tLS0t
DQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDkgZGVsZXRpb25zKC0pDQo+
ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pbnB1dC9rZXlib2FyZC9zbnZzX3B3cmtleS5j
DQo+ID4gYi9kcml2ZXJzL2lucHV0L2tleWJvYXJkL3NudnNfcHdya2V5LmMNCj4gPiBpbmRleCBl
ZmZiNjMyLi42ZmY0MWZkIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvaW5wdXQva2V5Ym9hcmQv
c252c19wd3JrZXkuYw0KPiA+ICsrKyBiL2RyaXZlcnMvaW5wdXQva2V5Ym9hcmQvc252c19wd3Jr
ZXkuYw0KPiA+IEBAIC0xNDgsMTUgKzE0OCw2IEBAIHN0YXRpYyBpbnQgaW14X3NudnNfcHdya2V5
X3Byb2JlKHN0cnVjdA0KPiBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ID4gIAkJcmV0dXJuIGVy
cm9yOw0KPiA+ICAJfQ0KPiA+DQo+ID4gLQllcnJvciA9IGRldm1fcmVxdWVzdF9pcnEoJnBkZXYt
PmRldiwgcGRhdGEtPmlycSwNCj4gPiAtCQkJICAgICAgIGlteF9zbnZzX3B3cmtleV9pbnRlcnJ1
cHQsDQo+ID4gLQkJCSAgICAgICAwLCBwZGV2LT5uYW1lLCBwZGV2KTsNCj4gPiAtDQo+ID4gLQlp
ZiAoZXJyb3IpIHsNCj4gPiAtCQlkZXZfZXJyKCZwZGV2LT5kZXYsICJpbnRlcnJ1cHQgbm90IGF2
YWlsYWJsZS5cbiIpOw0KPiA+IC0JCXJldHVybiBlcnJvcjsNCj4gPiAtCX0NCj4gPiAtDQo+ID4g
IAllcnJvciA9IGlucHV0X3JlZ2lzdGVyX2RldmljZShpbnB1dCk7DQo+ID4gIAlpZiAoZXJyb3Ig
PCAwKSB7DQo+ID4gIAkJZGV2X2VycigmcGRldi0+ZGV2LCAiZmFpbGVkIHRvIHJlZ2lzdGVyIGlu
cHV0IGRldmljZVxuIik7DQo+IEBAIC0xNjYsNg0KPiA+ICsxNTcsMTQgQEAgc3RhdGljIGludCBp
bXhfc252c19wd3JrZXlfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZQ0KPiAqcGRldikNCj4g
PiAgCXBkYXRhLT5pbnB1dCA9IGlucHV0Ow0KPiA+ICAJcGxhdGZvcm1fc2V0X2RydmRhdGEocGRl
diwgcGRhdGEpOw0KPiA+DQo+ID4gKwllcnJvciA9IGRldm1fcmVxdWVzdF9pcnEoJnBkZXYtPmRl
diwgcGRhdGEtPmlycSwNCj4gPiArCQkJCSBpbXhfc252c19wd3JrZXlfaW50ZXJydXB0LA0KPiA+
ICsJCQkJIDAsIHBkZXYtPm5hbWUsIHBkZXYpOw0KPiA+ICsJaWYgKGVycm9yKSB7DQo+ID4gKwkJ
ZGV2X2VycigmcGRldi0+ZGV2LCAiaW50ZXJydXB0IG5vdCBhdmFpbGFibGUuXG4iKTsNCj4gPiAr
CQlyZXR1cm4gZXJyb3I7DQo+ID4gKwl9DQo+IA0KPiBJbnN0ZWFkIG9mIG1vdmluZyBkZXZtX3Jl
cXVlc3RfaXJxKCkgYXJvdW5kIGNvdWxkIHlvdSBzaW1wbHkgbW92ZQ0KPiBwZGF0YS0+aW5wdXQg
PSBpbnB1dCBhc3NpZ25tZW50IGhpZ2hlcj8gSXQgaXMgcGVyZmVjdGx5IGZpbmUgdG8gdHJ5DQo+
IGNhbGxpbmcgaW5wdXRfZXZlbnQoKSBvbiBpbnB1dCBkZXZpY2UgdGhhdCBpcyBhbGxvY2F0ZWQg
YnV0IG5vdCB5ZXQgcmVnaXN0ZXJlZC4NCg0KT0ssIG1ha2Ugc2Vuc2UuDQoNCj4gDQo+ID4gKw0K
PiA+ICAJZGV2aWNlX2luaXRfd2FrZXVwKCZwZGV2LT5kZXYsIHBkYXRhLT53YWtldXApOw0KPiAN
Cj4gVW5yZWxhdGVkIHN1Z2dlc3Rpb246DQo+IA0KPiBDYW4geW91IHRyeSBjYWxsaW5nIGRldl9w
bV9zZXRfd2FrZV9pcnEoJnBkZXYtPmRldiwgcGRhdGEtPmlycSkgaGVyZSBhbmQNCj4gSSB0aGlu
ayB5b3Ugd2lsbCBiZSBhYmxlIHRvIGdldCByaWQgb2Ygc3VzcGVuZC9yZXN1bWUgbWV0aG9kcyBp
biB0aGUgZHJpdmVyLg0KDQpPSywgSSB3aWxsIGxvb2sgaW50byBpdCwgYW5kIHNlbmQgYW5vdGhl
ciBwYXRjaCB0byBpbXByb3ZlIHRoaXMuDQoNClRoYW5rcy4NCkFuc29uDQoNCj4gDQo+IFRoYW5r
cy4NCj4gDQo+IC0tDQo+IERtaXRyeQ0K
