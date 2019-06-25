Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BCF2C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 07:31:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E029320652
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 07:30:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="qKm8ikgc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729148AbfFYHa6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 03:30:58 -0400
Received: from mail-eopbgr70085.outbound.protection.outlook.com ([40.107.7.85]:23296
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726907AbfFYHa5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 03:30:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yvl32yqhaitB93jtgcsycHLpDyX4XHbcuKLognVxrLQ=;
 b=qKm8ikgc831gsavPnKzRD1zZc34xDYdqeKTV6qdEiQGcW+MGu+KK87K5ynuY9vxZKMWEOKf/ouxy6yZlZ4IuxZN5yxDvuERewWzGbtZ1GQ6gbPYK9CV4ZKBjLyUj4CBylj0HBEIYpZxPvZqQOPRset2kDKBAECoknUO6JKd+g70=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5234.eurprd04.prod.outlook.com (20.177.42.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Tue, 25 Jun 2019 07:30:51 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::2023:c0e5:8a63:2e47]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::2023:c0e5:8a63:2e47%5]) with mapi id 15.20.2008.014; Tue, 25 Jun 2019
 07:30:51 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        ", Sascha Hauer" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Andre Przywara <andre.przywara@arm.com>,
        "van.freenix@gmail.com" <van.freenix@gmail.com>
Subject: RE: [PATCH V2 2/2] mailbox: introduce ARM SMC based mailbox
Thread-Topic: [PATCH V2 2/2] mailbox: introduce ARM SMC based mailbox
Thread-Index: AQHVGeZUO66GnquMY06cfK/cKOI4kaak3KcAgAc+vQA=
Date:   Tue, 25 Jun 2019 07:30:51 +0000
Message-ID: <AM0PR04MB44813A4DE544E53EB7B6F02B88E30@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <20190603083005.4304-1-peng.fan@nxp.com>
 <20190603083005.4304-3-peng.fan@nxp.com>
 <CABb+yY1wW-arSMQSYjrezXOZ0Ar_shAr78MOyUD3hBxXohWx3g@mail.gmail.com>
In-Reply-To: <CABb+yY1wW-arSMQSYjrezXOZ0Ar_shAr78MOyUD3hBxXohWx3g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dbc9effc-f3b6-4fbe-87f9-08d6f93f0cee
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB5234;
x-ms-traffictypediagnostic: AM0PR04MB5234:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <AM0PR04MB52344C27FF1B80F7198C27B588E30@AM0PR04MB5234.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0079056367
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(346002)(376002)(39860400002)(396003)(189003)(199004)(6306002)(6246003)(74316002)(6116002)(66066001)(102836004)(966005)(55016002)(316002)(9686003)(76176011)(305945005)(54906003)(6436002)(7696005)(52536014)(8936002)(26005)(25786009)(14454004)(4326008)(7416002)(486006)(256004)(2906002)(7736002)(45080400002)(8676002)(86362001)(1411001)(53546011)(44832011)(478600001)(6506007)(5660300002)(33656002)(186003)(53936002)(81156014)(73956011)(81166006)(476003)(229853002)(71190400001)(71200400001)(66446008)(3846002)(66946007)(76116006)(99286004)(64756008)(6916009)(15650500001)(11346002)(446003)(66476007)(14444005)(68736007)(66556008);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5234;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 3dTlVOew64COnKtCuI4GR1QpNR4umbg7KJsk4Gu6XuAXpnqyaZ8yes3FaFsGBouu3jcwqFzw1ZrTKk47sAFoQc2QkL0aHAnkuZBKkQR/ynFSZ4TWWuAJ0IfjcBzeqQXkYCXwkO6FckZFg11gK5Oliaq2e26tDcUVnTvW3XVkv30XLDRG7HeMjwte4rhAsX8F1K4epOJiFoklr9v42H6UCpOEBU6DOWw/RKR7XadUOynRh08jopg3kxzLKGPZqS9qsRPE21BoSbDgE2mBHAleJ6B370TO5bdyHaCl41F3VxV/zNLdS0GZcVD+A8N7N75iIXqLFAGJgzPr47zLcaPoDLEk8yTbUTDHRCB1XR5U71AM5t9QOuiSQONV3F8Z2nEMbP7rFw4JNftiql+BVDtmopzwsGUlYkqF056/FngxV3w=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbc9effc-f3b6-4fbe-87f9-08d6f93f0cee
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2019 07:30:51.3719
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: peng.fan@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5234
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSmFzc2kNCg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIFYyIDIvMl0gbWFpbGJveDogaW50cm9k
dWNlIEFSTSBTTUMgYmFzZWQgbWFpbGJveA0KPiANCj4gT24gTW9uLCBKdW4gMywgMjAxOSBhdCAz
OjI4IEFNIDxwZW5nLmZhbkBueHAuY29tPiB3cm90ZToNCj4gPg0KPiA+IEZyb206IFBlbmcgRmFu
IDxwZW5nLmZhbkBueHAuY29tPg0KPiA+DQo+ID4gVGhpcyBtYWlsYm94IGRyaXZlciBpbXBsZW1l
bnRzIGEgbWFpbGJveCB3aGljaCBzaWduYWxzIHRyYW5zbWl0dGVkDQo+ID4gZGF0YSB2aWEgYW4g
QVJNIHNtYyAoc2VjdXJlIG1vbml0b3IgY2FsbCkgaW5zdHJ1Y3Rpb24uIFRoZSBtYWlsYm94DQo+
ID4gcmVjZWl2ZXIgaXMgaW1wbGVtZW50ZWQgaW4gZmlybXdhcmUgYW5kIGNhbiBzeW5jaHJvbm91
c2x5IHJldHVybiBkYXRhDQo+ID4gd2hlbiBpdCByZXR1cm5zIGV4ZWN1dGlvbiB0byB0aGUgbm9u
LXNlY3VyZSB3b3JsZCBhZ2Fpbi4NCj4gPiBBbiBhc3luY2hyb25vdXMgcmVjZWl2ZSBwYXRoIGlz
IG5vdCBpbXBsZW1lbnRlZC4NCj4gPiBUaGlzIGFsbG93cyB0aGUgdXNhZ2Ugb2YgYSBtYWlsYm94
IHRvIHRyaWdnZXIgZmlybXdhcmUgYWN0aW9ucyBvbiBTb0NzDQo+ID4gd2hpY2ggZWl0aGVyIGRv
bid0IGhhdmUgYSBzZXBhcmF0ZSBtYW5hZ2VtZW50IHByb2Nlc3NvciBvciBvbiB3aGljaA0KPiA+
IHN1Y2ggYSBjb3JlIGlzIG5vdCBhdmFpbGFibGUuIEEgdXNlciBvZiB0aGlzIG1haWxib3ggY291
bGQgYmUgdGhlIFNDUA0KPiA+IGludGVyZmFjZS4NCj4gPg0KPiA+IE1vZGlmaWVkIGZyb20gQW5k
cmUgUHJ6eXdhcmEncyB2MiBwYXRjaA0KPiA+IGh0dHBzOi8vZXVyMDEuc2FmZWxpbmtzLnByb3Rl
Y3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRmxvcmUNCj4gPiAua2VybmVsLm9y
ZyUyRnBhdGNod29yayUyRnBhdGNoJTJGODEyOTk5JTJGJmFtcDtkYXRhPTAyJTdDMDElNw0KPiBD
cGVuZy5mYQ0KPiA+DQo+IG4lNDBueHAuY29tJTdDMTIzNzY3N2NiMDEwNDRhZDcxNDUwOGQ2ZjU5
ZjY0OGYlN0M2ODZlYTFkM2JjMmI0DQo+IGM2ZmE5MmNkDQo+ID4NCj4gOTljNWMzMDE2MzUlN0Mw
JTdDMCU3QzYzNjk2NjQ2MjI3MjQ1Nzk3OCZhbXA7c2RhdGE9SHpnZXU0M201DQo+IFprZVJNdEw4
QngNCj4gPiBnVW0zJTJCNkZCT2JpYjFPUEhQbFNjY0UlMkIwJTNEJmFtcDtyZXNlcnZlZD0wDQo+
ID4NCj4gPiBDYzogQW5kcmUgUHJ6eXdhcmEgPGFuZHJlLnByenl3YXJhQGFybS5jb20+DQo+ID4g
U2lnbmVkLW9mZi1ieTogUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+DQo+ID4gLS0tDQo+ID4N
Cj4gPiBWMjoNCj4gPiAgQWRkIGludGVycnVwdHMgbm90aWZpY2F0aW9uIHN1cHBvcnQuDQo+ID4N
Cj4gPiAgZHJpdmVycy9tYWlsYm94L0tjb25maWcgICAgICAgICAgICAgICAgIHwgICA3ICsrDQo+
ID4gIGRyaXZlcnMvbWFpbGJveC9NYWtlZmlsZSAgICAgICAgICAgICAgICB8ICAgMiArDQo+ID4g
IGRyaXZlcnMvbWFpbGJveC9hcm0tc21jLW1haWxib3guYyAgICAgICB8IDE5MA0KPiArKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+ICBpbmNsdWRlL2xpbnV4L21haWxib3gvYXJt
LXNtYy1tYWlsYm94LmggfCAgMTAgKysNCj4gPiAgNCBmaWxlcyBjaGFuZ2VkLCAyMDkgaW5zZXJ0
aW9ucygrKQ0KPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9tYWlsYm94L2FybS1zbWMt
bWFpbGJveC5jICBjcmVhdGUgbW9kZQ0KPiA+IDEwMDY0NCBpbmNsdWRlL2xpbnV4L21haWxib3gv
YXJtLXNtYy1tYWlsYm94LmgNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21haWxib3gv
S2NvbmZpZyBiL2RyaXZlcnMvbWFpbGJveC9LY29uZmlnIGluZGV4DQo+ID4gNTk1NTQyYmZhZTg1
Li5jM2JkMGYxZGRjZDggMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9tYWlsYm94L0tjb25maWcN
Cj4gPiArKysgYi9kcml2ZXJzL21haWxib3gvS2NvbmZpZw0KPiA+IEBAIC0xNSw2ICsxNSwxMyBA
QCBjb25maWcgQVJNX01IVQ0KPiA+ICAgICAgICAgICBUaGUgY29udHJvbGxlciBoYXMgMyBtYWls
Ym94IGNoYW5uZWxzLCB0aGUgbGFzdCBvZiB3aGljaCBjYW4gYmUNCj4gPiAgICAgICAgICAgdXNl
ZCBpbiBTZWN1cmUgbW9kZSBvbmx5Lg0KPiA+DQo+ID4gK2NvbmZpZyBBUk1fU01DX01CT1gNCj4g
PiArICAgICAgIHRyaXN0YXRlICJHZW5lcmljIEFSTSBzbWMgbWFpbGJveCINCj4gPiArICAgICAg
IGRlcGVuZHMgb24gT0YgJiYgSEFWRV9BUk1fU01DQ0MNCj4gPiArICAgICAgIGhlbHANCj4gPiAr
ICAgICAgICAgR2VuZXJpYyBtYWlsYm94IGRyaXZlciB3aGljaCB1c2VzIEFSTSBzbWMgY2FsbHMg
dG8gY2FsbCBpbnRvDQo+ID4gKyAgICAgICAgIGZpcm13YXJlIGZvciB0cmlnZ2VyaW5nIG1haWxi
b3hlcy4NCj4gPiArDQo+ID4gIGNvbmZpZyBJTVhfTUJPWA0KPiA+ICAgICAgICAgdHJpc3RhdGUg
ImkuTVggTWFpbGJveCINCj4gPiAgICAgICAgIGRlcGVuZHMgb24gQVJDSF9NWEMgfHwgQ09NUElM
RV9URVNUIGRpZmYgLS1naXQNCj4gPiBhL2RyaXZlcnMvbWFpbGJveC9NYWtlZmlsZSBiL2RyaXZl
cnMvbWFpbGJveC9NYWtlZmlsZSBpbmRleA0KPiA+IGMyMmZhZDZmNjk2Yi4uOTM5MThhODRjOTFi
IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbWFpbGJveC9NYWtlZmlsZQ0KPiA+ICsrKyBiL2Ry
aXZlcnMvbWFpbGJveC9NYWtlZmlsZQ0KPiA+IEBAIC03LDYgKzcsOCBAQCBvYmotJChDT05GSUdf
TUFJTEJPWF9URVNUKSAgICAgICs9IG1haWxib3gtdGVzdC5vDQo+ID4NCj4gPiAgb2JqLSQoQ09O
RklHX0FSTV9NSFUpICArPSBhcm1fbWh1Lm8NCj4gPg0KPiA+ICtvYmotJChDT05GSUdfQVJNX1NN
Q19NQk9YKSAgICAgKz0gYXJtLXNtYy1tYWlsYm94Lm8NCj4gPiArDQo+ID4gIG9iai0kKENPTkZJ
R19JTVhfTUJPWCkgKz0gaW14LW1haWxib3gubw0KPiA+DQo+ID4gIG9iai0kKENPTkZJR19BUk1B
REFfMzdYWF9SV1RNX01CT1gpICAgICs9DQo+IGFybWFkYS0zN3h4LXJ3dG0tbWFpbGJveC5vDQo+
ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWFpbGJveC9hcm0tc21jLW1haWxib3guYw0KPiA+IGIv
ZHJpdmVycy9tYWlsYm94L2FybS1zbWMtbWFpbGJveC5jDQo+ID4gbmV3IGZpbGUgbW9kZSAxMDA2
NDQNCj4gPiBpbmRleCAwMDAwMDAwMDAwMDAuLmZlZjZlMzhkOGI5OA0KPiA+IC0tLSAvZGV2L251
bGwNCj4gPiArKysgYi9kcml2ZXJzL21haWxib3gvYXJtLXNtYy1tYWlsYm94LmMNCj4gPiBAQCAt
MCwwICsxLDE5MCBAQA0KPiA+ICsvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMA0K
PiA+ICsvKg0KPiA+ICsgKiBDb3B5cmlnaHQgKEMpIDIwMTYsMjAxNyBBUk0gTHRkLg0KPiA+ICsg
KiBDb3B5cmlnaHQgMjAxOSBOWFANCj4gPiArICovDQo+ID4gKw0KPiA+ICsjaW5jbHVkZSA8bGlu
dXgvYXJtLXNtY2NjLmg+DQo+ID4gKyNpbmNsdWRlIDxsaW51eC9kZXZpY2UuaD4NCj4gPiArI2lu
Y2x1ZGUgPGxpbnV4L2tlcm5lbC5oPg0KPiA+ICsjaW5jbHVkZSA8bGludXgvaW50ZXJydXB0Lmg+
DQo+ID4gKyNpbmNsdWRlIDxsaW51eC9tYWlsYm94X2NvbnRyb2xsZXIuaD4gI2luY2x1ZGUNCj4g
PiArPGxpbnV4L21haWxib3gvYXJtLXNtYy1tYWlsYm94Lmg+DQo+ID4gKyNpbmNsdWRlIDxsaW51
eC9tb2R1bGUuaD4NCj4gPiArI2luY2x1ZGUgPGxpbnV4L3BsYXRmb3JtX2RldmljZS5oPg0KPiA+
ICsNCj4gPiArI2RlZmluZSBBUk1fU01DX01CT1hfVVNFX0hWQyAgIEJJVCgwKQ0KPiA+ICsjZGVm
aW5lIEFSTV9TTUNfTUJPWF9VU0JfSVJRICAgQklUKDEpDQo+ID4gKw0KPiBJUlEgYml0IGlzIHVu
dXNlZCAoYW5kIHVubmVjZXNzYXJ5IElNTykNCj4gDQo+ID4gK3N0cnVjdCBhcm1fc21jX2NoYW5f
ZGF0YSB7DQo+ID4gKyAgICAgICB1MzIgZnVuY3Rpb25faWQ7DQo+ID4gKyAgICAgICB1MzIgZmxh
Z3M7DQo+ID4gKyAgICAgICBpbnQgaXJxOw0KPiA+ICt9Ow0KPiA+ICsNCj4gPiArc3RhdGljIGlu
dCBhcm1fc21jX3NlbmRfZGF0YShzdHJ1Y3QgbWJveF9jaGFuICpsaW5rLCB2b2lkICpkYXRhKSB7
DQo+ID4gKyAgICAgICBzdHJ1Y3QgYXJtX3NtY19jaGFuX2RhdGEgKmNoYW5fZGF0YSA9IGxpbmst
PmNvbl9wcml2Ow0KPiA+ICsgICAgICAgc3RydWN0IGFybV9zbWNjY19tYm94X2NtZCAqY21kID0g
ZGF0YTsNCj4gPiArICAgICAgIHN0cnVjdCBhcm1fc21jY2NfcmVzIHJlczsNCj4gPiArICAgICAg
IHUzMiBmdW5jdGlvbl9pZDsNCj4gPiArDQo+ID4gKyAgICAgICBpZiAoY2hhbl9kYXRhLT5mdW5j
dGlvbl9pZCAhPSBVSU5UX01BWCkNCj4gPiArICAgICAgICAgICAgICAgZnVuY3Rpb25faWQgPSBj
aGFuX2RhdGEtPmZ1bmN0aW9uX2lkOw0KPiA+ICsgICAgICAgZWxzZQ0KPiA+ICsgICAgICAgICAg
ICAgICBmdW5jdGlvbl9pZCA9IGNtZC0+YTA7DQo+ID4gKw0KPiBOb3Qgc3VyZSBhYm91dCBjaGFu
X2RhdGEtPmZ1bmN0aW9uX2lkLiAgV2h5IHJlc3RyaWN0IGZyb20gRFQ/DQo+ICdhMCcgaXMgdGhl
IGZ1bmN0aW9uX2lkIHJlZ2lzdGVyLCBsZXQgdGhlIHVzZXIgcGFzcyBmdW5jLWlkIHZpYSB0aGUg
J2EwJyBsaWtlIG90aGVyDQo+IHZhbHVlcyB2aWEgJ2FbMS03XScNCg0KTWlzc2VkIHRvIHJlcGx5
IHRoaXMgY29tbWVudC4NCg0KVGhlIGZpcm13YXJlIGRyaXZlciBtaWdodCBub3QgaGF2ZSBmdW5j
LWlkLCBzdWNoIGFzIFNDTUkvU0NQSS4NClNvIGFkZCBhbiBvcHRpb25hbCBmdW5jLWlkIHRvIGxl
dCBzbWMgbWFpbGJveCBkcml2ZXIgY291bGQNCnVzZSBzbWMgU2lQIGZ1bmMgaWQuDQoNClRoYW5r
cywNClBlbmcuDQoNCj4gDQo+IA0KPiA+ICsgICAgICAgaWYgKGNoYW5fZGF0YS0+ZmxhZ3MgJiBB
Uk1fU01DX01CT1hfVVNFX0hWQykNCj4gPiArICAgICAgICAgICAgICAgYXJtX3NtY2NjX2h2Yyhm
dW5jdGlvbl9pZCwgY21kLT5hMSwgY21kLT5hMiwNCj4gY21kLT5hMywgY21kLT5hNCwNCj4gPiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjbWQtPmE1LCBjbWQtPmE2LCBjbWQtPmE3LCAm
cmVzKTsNCj4gPiArICAgICAgIGVsc2UNCj4gPiArICAgICAgICAgICAgICAgYXJtX3NtY2NjX3Nt
YyhmdW5jdGlvbl9pZCwgY21kLT5hMSwgY21kLT5hMiwNCj4gY21kLT5hMywgY21kLT5hNCwNCj4g
PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjbWQtPmE1LCBjbWQtPmE2LCBjbWQtPmE3
LCAmcmVzKTsNCj4gPiArDQo+ID4gKyAgICAgICBpZiAoY2hhbl9kYXRhLT5pcnEpDQo+ID4gKyAg
ICAgICAgICAgICAgIHJldHVybiAwOw0KPiA+ICsNCj4gVGhpcyBpcnEgdGhpbmcgc2VlbXMgbGlr
ZSBvb2Igc2lnbmFsbGluZywgdGhhdCBpcywgYSBwcm90b2NvbCB0aGluZy4NCj4gQW5kIHRoZW4g
aXQgcHJvdmlkZXMgbGVzc2VyIGluZm8gdmlhIGNoYW5faXJxX2hhbmRsZXIgKHJldHVybnMgTlVM
TCkgdGhhbg0KPiByZXMuYTAgLSB3aGljaCBjYW4gYWx3YXlzIGJlIGlnbm9yZWQgaWYgbm90IG5l
ZWRlZC4NCj4gU28gdGhlIGlycSBzaG91bGQgYmUgaW1wbGVtZW50ZWQgaW4gdGhlIHVwcGVyIGxh
eWVyIGlmIHRoZSBwcm90b2NvbCBuZWVkcyBpdC4NCj4gDQo+ID4gKyAgICAgICBtYm94X2NoYW5f
cmVjZWl2ZWRfZGF0YShsaW5rLCAodm9pZCAqKXJlcy5hMCk7DQo+ID4gKw0KPiBUaGlzIGlzIGZp
bmUuDQo=
