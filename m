Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 921A8C48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 13:31:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F2D22147A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 13:31:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="TIuhJ2hM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727683AbfFZNbW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 09:31:22 -0400
Received: from mail-eopbgr70052.outbound.protection.outlook.com ([40.107.7.52]:25871
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727409AbfFZNbW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 09:31:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=testarcselector01; d=microsoft.com; cv=none;
 b=sVhr51lGJAbwtPAelVtr7vhYeuDELHWNLMRNCP7NTM3lxXwqhx1kzwjHqqN8CF7cJSEiruXza+0ebcxaSZwv1g4Wx4h6kJvWL/H+K12oKPtbDnK1nbnX5tYodLK52XFdBLXE5ZwZ2QUjc9sAXpqD91j2eFItpCmG6U2q6Mg2a6Y=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=testarcselector01;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ALV/bqVO/+nvE8MbblYUCYBZFeWPgKHucC3GE00XAU=;
 b=CSQN/f6b9nCOJPw27Fl9gHFFj7DAnTXD8ciBAk1MXbH6XgDZ3QnYBnRcql3Ej+YF7iYbmXv1TOf6Zqxu15qmvet7rcF1JgzXxs+FV7s4qM0czKMhP1R52v2d+Pgi4824IgWJX2UfEvsesFp5Yg0aWwdCyqnYYo4m42Dl49ROERg=
ARC-Authentication-Results: i=1; test.office365.com
 1;spf=none;dmarc=none;dkim=none;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ALV/bqVO/+nvE8MbblYUCYBZFeWPgKHucC3GE00XAU=;
 b=TIuhJ2hMjKcpcI1SzaJ+URL95llwj9kgVPbMbzT1LBrmRpDlJqqraMSnGJkJ3Lqhl0YV5+QVFzX/zklIWPjXCQfo9ydMIjOiSTf47ddx5pr2Fj1LowoWdRfpfEoimp1Oo9OKcKd2k7qwIHZlCl6LjwkyLHiosZP2H8hOyHUOb0Q=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB6097.eurprd04.prod.outlook.com (20.179.36.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Wed, 26 Jun 2019 13:31:15 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::2023:c0e5:8a63:2e47]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::2023:c0e5:8a63:2e47%5]) with mapi id 15.20.2008.014; Wed, 26 Jun 2019
 13:31:15 +0000
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
Thread-Index: AQHVGeZUO66GnquMY06cfK/cKOI4kaak3KcAgAc+vQCAAHeVAIABfs7A
Date:   Wed, 26 Jun 2019 13:31:15 +0000
Message-ID: <AM0PR04MB44814D3BD59033ECDDE3094C88E20@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <20190603083005.4304-1-peng.fan@nxp.com>
 <20190603083005.4304-3-peng.fan@nxp.com>
 <CABb+yY1wW-arSMQSYjrezXOZ0Ar_shAr78MOyUD3hBxXohWx3g@mail.gmail.com>
 <AM0PR04MB44813A4DE544E53EB7B6F02B88E30@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <CABb+yY38MAZqVOhjyV+GByPvpFcTfKbNG1rJ8YDRd1vi1F4fqg@mail.gmail.com>
In-Reply-To: <CABb+yY38MAZqVOhjyV+GByPvpFcTfKbNG1rJ8YDRd1vi1F4fqg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4736499c-aeed-4cc4-11df-08d6fa3a9056
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB6097;
x-ms-traffictypediagnostic: AM0PR04MB6097:
x-microsoft-antispam-prvs: <AM0PR04MB6097ADE2F65801218BC11CA788E20@AM0PR04MB6097.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 00808B16F3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(39860400002)(376002)(396003)(136003)(199004)(189003)(53754006)(305945005)(5660300002)(86362001)(476003)(9686003)(6916009)(6306002)(44832011)(8676002)(15650500001)(11346002)(2906002)(446003)(8936002)(486006)(102836004)(1411001)(55016002)(7736002)(6506007)(6246003)(66946007)(53936002)(99286004)(71200400001)(71190400001)(26005)(186003)(68736007)(6116002)(478600001)(53546011)(66066001)(966005)(81166006)(256004)(229853002)(7696005)(81156014)(3846002)(73956011)(6436002)(74316002)(7416002)(14454004)(25786009)(316002)(76116006)(64756008)(66446008)(52536014)(14444005)(4326008)(66556008)(76176011)(66476007)(54906003)(33656002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6097;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ms1e34GQQaeywkuIn/CJ+k93zBhc79HrYxQtN0Ie7u8Uvjc/PP5CxCYnvtaPEEHO3N5Ce9ntP/H232MdbYPZx0lZtxOPF9K0DtrSZjuVqMrYgdt1swhl5xNB+/i0UI2fKyeXBJR90DPAodCIzpQDxx1zg9hIfzuWDV619L47dl7NIfJbxhcQcQ1M2jtTQN5xEuVMqDfOWUXDsVvF8/2p6ynffTMUFxKIAY1MVjwSPZC07vbAVlP38zrMNvHdoLucUGziBVlZ1LjidVWQV6Jwep9/KMYsJThQNsVpNbUQE739p9zwfJkr6t1+CYQmMKVHeTwlCXg5jaamp2Jwp2XKa7rOhcLAbm66nw+Inhp2cKgg3vS/Ab/jm8x/nJfnawwAvMhieSZwgzp9DCuH63kOzd0SuG8zS1X2HReRb9nXZr8=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4736499c-aeed-4cc4-11df-08d6fa3a9056
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2019 13:31:15.4751
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: peng.fan@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6097
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpIaSBBbGwsDQoNCj4gU3ViamVjdDogUmU6IFtQQVRDSCBWMiAyLzJdIG1haWxib3g6IGludHJv
ZHVjZSBBUk0gU01DIGJhc2VkIG1haWxib3gNCj4gDQo+IE9uIFR1ZSwgSnVuIDI1LCAyMDE5IGF0
IDI6MzAgQU0gUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+IHdyb3RlOg0KPiA+DQo+ID4gSGkg
SmFzc2kNCj4gPg0KPiA+ID4gU3ViamVjdDogUmU6IFtQQVRDSCBWMiAyLzJdIG1haWxib3g6IGlu
dHJvZHVjZSBBUk0gU01DIGJhc2VkIG1haWxib3gNCj4gPiA+DQo+ID4gPiBPbiBNb24sIEp1biAz
LCAyMDE5IGF0IDM6MjggQU0gPHBlbmcuZmFuQG54cC5jb20+IHdyb3RlOg0KPiA+ID4gPg0KPiA+
ID4gPiBGcm9tOiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCj4gPiA+ID4NCj4gPiA+ID4g
VGhpcyBtYWlsYm94IGRyaXZlciBpbXBsZW1lbnRzIGEgbWFpbGJveCB3aGljaCBzaWduYWxzIHRy
YW5zbWl0dGVkDQo+ID4gPiA+IGRhdGEgdmlhIGFuIEFSTSBzbWMgKHNlY3VyZSBtb25pdG9yIGNh
bGwpIGluc3RydWN0aW9uLiBUaGUgbWFpbGJveA0KPiA+ID4gPiByZWNlaXZlciBpcyBpbXBsZW1l
bnRlZCBpbiBmaXJtd2FyZSBhbmQgY2FuIHN5bmNocm9ub3VzbHkgcmV0dXJuDQo+ID4gPiA+IGRh
dGEgd2hlbiBpdCByZXR1cm5zIGV4ZWN1dGlvbiB0byB0aGUgbm9uLXNlY3VyZSB3b3JsZCBhZ2Fp
bi4NCj4gPiA+ID4gQW4gYXN5bmNocm9ub3VzIHJlY2VpdmUgcGF0aCBpcyBub3QgaW1wbGVtZW50
ZWQuDQo+ID4gPiA+IFRoaXMgYWxsb3dzIHRoZSB1c2FnZSBvZiBhIG1haWxib3ggdG8gdHJpZ2dl
ciBmaXJtd2FyZSBhY3Rpb25zIG9uDQo+ID4gPiA+IFNvQ3Mgd2hpY2ggZWl0aGVyIGRvbid0IGhh
dmUgYSBzZXBhcmF0ZSBtYW5hZ2VtZW50IHByb2Nlc3NvciBvciBvbg0KPiA+ID4gPiB3aGljaCBz
dWNoIGEgY29yZSBpcyBub3QgYXZhaWxhYmxlLiBBIHVzZXIgb2YgdGhpcyBtYWlsYm94IGNvdWxk
DQo+ID4gPiA+IGJlIHRoZSBTQ1AgaW50ZXJmYWNlLg0KPiA+ID4gPg0KPiA+ID4gPiBNb2RpZmll
ZCBmcm9tIEFuZHJlIFByenl3YXJhJ3MgdjIgcGF0Y2ggaHR0cHM6Ly9sb3JlDQo+ID4gPiA+IC5r
ZXJuZWwub3JnJTJGcGF0Y2h3b3JrJTJGcGF0Y2glMkY4MTI5OTklMkYmYW1wO2RhdGE9MDIlN0Mw
DQo+IDElNw0KPiA+ID4gQ3BlbmcuZmENCj4gPiA+ID4NCj4gPiA+DQo+IG4lNDBueHAuY29tJTdD
MTIzNzY3N2NiMDEwNDRhZDcxNDUwOGQ2ZjU5ZjY0OGYlN0M2ODZlYTFkM2JjMmI0DQo+ID4gPiBj
NmZhOTJjZA0KPiA+ID4gPg0KPiA+ID4NCj4gOTljNWMzMDE2MzUlN0MwJTdDMCU3QzYzNjk2NjQ2
MjI3MjQ1Nzk3OCZhbXA7c2RhdGE9SHpnZXU0M201DQo+ID4gPiBaa2VSTXRMOEJ4DQo+ID4gPiA+
IGdVbTMlMkI2RkJPYmliMU9QSFBsU2NjRSUyQjAlM0QmYW1wO3Jlc2VydmVkPTANCj4gPiA+ID4N
Cj4gPiA+ID4gQ2M6IEFuZHJlIFByenl3YXJhIDxhbmRyZS5wcnp5d2FyYUBhcm0uY29tPg0KPiA+
ID4gPiBTaWduZWQtb2ZmLWJ5OiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCj4gPiA+ID4g
LS0tDQo+ID4gPiA+DQo+ID4gPiA+IFYyOg0KPiA+ID4gPiAgQWRkIGludGVycnVwdHMgbm90aWZp
Y2F0aW9uIHN1cHBvcnQuDQo+ID4gPiA+DQo+ID4gPiA+ICBkcml2ZXJzL21haWxib3gvS2NvbmZp
ZyAgICAgICAgICAgICAgICAgfCAgIDcgKysNCj4gPiA+ID4gIGRyaXZlcnMvbWFpbGJveC9NYWtl
ZmlsZSAgICAgICAgICAgICAgICB8ICAgMiArDQo+ID4gPiA+ICBkcml2ZXJzL21haWxib3gvYXJt
LXNtYy1tYWlsYm94LmMgICAgICAgfCAxOTANCj4gPiA+ICsrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrDQo+ID4gPiA+ICBpbmNsdWRlL2xpbnV4L21haWxib3gvYXJtLXNtYy1tYWlsYm94
LmggfCAgMTAgKysNCj4gPiA+ID4gIDQgZmlsZXMgY2hhbmdlZCwgMjA5IGluc2VydGlvbnMoKykN
Cj4gPiA+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL21haWxib3gvYXJtLXNtYy1tYWls
Ym94LmMgIGNyZWF0ZQ0KPiBtb2RlDQo+ID4gPiA+IDEwMDY0NCBpbmNsdWRlL2xpbnV4L21haWxi
b3gvYXJtLXNtYy1tYWlsYm94LmgNCj4gPiA+ID4NCj4gPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvbWFpbGJveC9LY29uZmlnIGIvZHJpdmVycy9tYWlsYm94L0tjb25maWcgaW5kZXgNCj4gPiA+
ID4gNTk1NTQyYmZhZTg1Li5jM2JkMGYxZGRjZDggMTAwNjQ0DQo+ID4gPiA+IC0tLSBhL2RyaXZl
cnMvbWFpbGJveC9LY29uZmlnDQo+ID4gPiA+ICsrKyBiL2RyaXZlcnMvbWFpbGJveC9LY29uZmln
DQo+ID4gPiA+IEBAIC0xNSw2ICsxNSwxMyBAQCBjb25maWcgQVJNX01IVQ0KPiA+ID4gPiAgICAg
ICAgICAgVGhlIGNvbnRyb2xsZXIgaGFzIDMgbWFpbGJveCBjaGFubmVscywgdGhlIGxhc3Qgb2Yg
d2hpY2ggY2FuDQo+IGJlDQo+ID4gPiA+ICAgICAgICAgICB1c2VkIGluIFNlY3VyZSBtb2RlIG9u
bHkuDQo+ID4gPiA+DQo+ID4gPiA+ICtjb25maWcgQVJNX1NNQ19NQk9YDQo+ID4gPiA+ICsgICAg
ICAgdHJpc3RhdGUgIkdlbmVyaWMgQVJNIHNtYyBtYWlsYm94Ig0KPiA+ID4gPiArICAgICAgIGRl
cGVuZHMgb24gT0YgJiYgSEFWRV9BUk1fU01DQ0MNCj4gPiA+ID4gKyAgICAgICBoZWxwDQo+ID4g
PiA+ICsgICAgICAgICBHZW5lcmljIG1haWxib3ggZHJpdmVyIHdoaWNoIHVzZXMgQVJNIHNtYyBj
YWxscyB0byBjYWxsIGludG8NCj4gPiA+ID4gKyAgICAgICAgIGZpcm13YXJlIGZvciB0cmlnZ2Vy
aW5nIG1haWxib3hlcy4NCj4gPiA+ID4gKw0KPiA+ID4gPiAgY29uZmlnIElNWF9NQk9YDQo+ID4g
PiA+ICAgICAgICAgdHJpc3RhdGUgImkuTVggTWFpbGJveCINCj4gPiA+ID4gICAgICAgICBkZXBl
bmRzIG9uIEFSQ0hfTVhDIHx8IENPTVBJTEVfVEVTVCBkaWZmIC0tZ2l0DQo+ID4gPiA+IGEvZHJp
dmVycy9tYWlsYm94L01ha2VmaWxlIGIvZHJpdmVycy9tYWlsYm94L01ha2VmaWxlIGluZGV4DQo+
ID4gPiA+IGMyMmZhZDZmNjk2Yi4uOTM5MThhODRjOTFiIDEwMDY0NA0KPiA+ID4gPiAtLS0gYS9k
cml2ZXJzL21haWxib3gvTWFrZWZpbGUNCj4gPiA+ID4gKysrIGIvZHJpdmVycy9tYWlsYm94L01h
a2VmaWxlDQo+ID4gPiA+IEBAIC03LDYgKzcsOCBAQCBvYmotJChDT05GSUdfTUFJTEJPWF9URVNU
KSAgICAgICs9DQo+IG1haWxib3gtdGVzdC5vDQo+ID4gPiA+DQo+ID4gPiA+ICBvYmotJChDT05G
SUdfQVJNX01IVSkgICs9IGFybV9taHUubw0KPiA+ID4gPg0KPiA+ID4gPiArb2JqLSQoQ09ORklH
X0FSTV9TTUNfTUJPWCkgICAgICs9IGFybS1zbWMtbWFpbGJveC5vDQo+ID4gPiA+ICsNCj4gPiA+
ID4gIG9iai0kKENPTkZJR19JTVhfTUJPWCkgKz0gaW14LW1haWxib3gubw0KPiA+ID4gPg0KPiA+
ID4gPiAgb2JqLSQoQ09ORklHX0FSTUFEQV8zN1hYX1JXVE1fTUJPWCkgICAgKz0NCj4gPiA+IGFy
bWFkYS0zN3h4LXJ3dG0tbWFpbGJveC5vDQo+ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21h
aWxib3gvYXJtLXNtYy1tYWlsYm94LmMNCj4gPiA+ID4gYi9kcml2ZXJzL21haWxib3gvYXJtLXNt
Yy1tYWlsYm94LmMNCj4gPiA+ID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gPiA+ID4gaW5kZXgg
MDAwMDAwMDAwMDAwLi5mZWY2ZTM4ZDhiOTgNCj4gPiA+ID4gLS0tIC9kZXYvbnVsbA0KPiA+ID4g
PiArKysgYi9kcml2ZXJzL21haWxib3gvYXJtLXNtYy1tYWlsYm94LmMNCj4gPiA+ID4gQEAgLTAs
MCArMSwxOTAgQEANCj4gPiA+ID4gKy8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4w
DQo+ID4gPiA+ICsvKg0KPiA+ID4gPiArICogQ29weXJpZ2h0IChDKSAyMDE2LDIwMTcgQVJNIEx0
ZC4NCj4gPiA+ID4gKyAqIENvcHlyaWdodCAyMDE5IE5YUA0KPiA+ID4gPiArICovDQo+ID4gPiA+
ICsNCj4gPiA+ID4gKyNpbmNsdWRlIDxsaW51eC9hcm0tc21jY2MuaD4NCj4gPiA+ID4gKyNpbmNs
dWRlIDxsaW51eC9kZXZpY2UuaD4NCj4gPiA+ID4gKyNpbmNsdWRlIDxsaW51eC9rZXJuZWwuaD4N
Cj4gPiA+ID4gKyNpbmNsdWRlIDxsaW51eC9pbnRlcnJ1cHQuaD4NCj4gPiA+ID4gKyNpbmNsdWRl
IDxsaW51eC9tYWlsYm94X2NvbnRyb2xsZXIuaD4gI2luY2x1ZGUNCj4gPiA+ID4gKzxsaW51eC9t
YWlsYm94L2FybS1zbWMtbWFpbGJveC5oPg0KPiA+ID4gPiArI2luY2x1ZGUgPGxpbnV4L21vZHVs
ZS5oPg0KPiA+ID4gPiArI2luY2x1ZGUgPGxpbnV4L3BsYXRmb3JtX2RldmljZS5oPg0KPiA+ID4g
PiArDQo+ID4gPiA+ICsjZGVmaW5lIEFSTV9TTUNfTUJPWF9VU0VfSFZDICAgQklUKDApDQo+ID4g
PiA+ICsjZGVmaW5lIEFSTV9TTUNfTUJPWF9VU0JfSVJRICAgQklUKDEpDQo+ID4gPiA+ICsNCj4g
PiA+IElSUSBiaXQgaXMgdW51c2VkIChhbmQgdW5uZWNlc3NhcnkgSU1PKQ0KPiA+ID4NCj4gPiA+
ID4gK3N0cnVjdCBhcm1fc21jX2NoYW5fZGF0YSB7DQo+ID4gPiA+ICsgICAgICAgdTMyIGZ1bmN0
aW9uX2lkOw0KPiA+ID4gPiArICAgICAgIHUzMiBmbGFnczsNCj4gPiA+ID4gKyAgICAgICBpbnQg
aXJxOw0KPiA+ID4gPiArfTsNCj4gPiA+ID4gKw0KPiA+ID4gPiArc3RhdGljIGludCBhcm1fc21j
X3NlbmRfZGF0YShzdHJ1Y3QgbWJveF9jaGFuICpsaW5rLCB2b2lkICpkYXRhKSB7DQo+ID4gPiA+
ICsgICAgICAgc3RydWN0IGFybV9zbWNfY2hhbl9kYXRhICpjaGFuX2RhdGEgPSBsaW5rLT5jb25f
cHJpdjsNCj4gPiA+ID4gKyAgICAgICBzdHJ1Y3QgYXJtX3NtY2NjX21ib3hfY21kICpjbWQgPSBk
YXRhOw0KPiA+ID4gPiArICAgICAgIHN0cnVjdCBhcm1fc21jY2NfcmVzIHJlczsNCj4gPiA+ID4g
KyAgICAgICB1MzIgZnVuY3Rpb25faWQ7DQo+ID4gPiA+ICsNCj4gPiA+ID4gKyAgICAgICBpZiAo
Y2hhbl9kYXRhLT5mdW5jdGlvbl9pZCAhPSBVSU5UX01BWCkNCj4gPiA+ID4gKyAgICAgICAgICAg
ICAgIGZ1bmN0aW9uX2lkID0gY2hhbl9kYXRhLT5mdW5jdGlvbl9pZDsNCj4gPiA+ID4gKyAgICAg
ICBlbHNlDQo+ID4gPiA+ICsgICAgICAgICAgICAgICBmdW5jdGlvbl9pZCA9IGNtZC0+YTA7DQo+
ID4gPiA+ICsNCj4gPiA+IE5vdCBzdXJlIGFib3V0IGNoYW5fZGF0YS0+ZnVuY3Rpb25faWQuICBX
aHkgcmVzdHJpY3QgZnJvbSBEVD8NCj4gPiA+ICdhMCcgaXMgdGhlIGZ1bmN0aW9uX2lkIHJlZ2lz
dGVyLCBsZXQgdGhlIHVzZXIgcGFzcyBmdW5jLWlkIHZpYSB0aGUgJ2EwJyBsaWtlDQo+IG90aGVy
DQo+ID4gPiB2YWx1ZXMgdmlhICdhWzEtN10nDQo+ID4NCj4gPiBNaXNzZWQgdG8gcmVwbHkgdGhp
cyBjb21tZW50Lg0KPiA+DQo+ID4gVGhlIGZpcm13YXJlIGRyaXZlciBtaWdodCBub3QgaGF2ZSBm
dW5jLWlkLCBzdWNoIGFzIFNDTUkvU0NQSS4NCj4gPiBTbyBhZGQgYW4gb3B0aW9uYWwgZnVuYy1p
ZCB0byBsZXQgc21jIG1haWxib3ggZHJpdmVyIGNvdWxkDQo+ID4gdXNlIHNtYyBTaVAgZnVuYyBp
ZC4NCj4gPg0KPiBUaGVyZSBpcyBubyBlbmQgdG8gY29uZm9ybWluZyB0byBwcm90b2NvbHMuIENv
bnRyb2xsZXIgZHJpdmVycyBzaG91bGQNCj4gYmUgd3JpdHRlbiBoYXZpbmcgbm8gcGFydGljdWxh
ciBjbGllbnQgaW4gbWluZC4NCg0KSWYgdGhlIGZ1bmMtaWQgbmVlZHMgYmUgcGFzc2VkIGZyb20g
dXNlciwgdGhlbiB0aGUgY2hhbl9pZCBzdWdnZXN0ZWQNCmJ5IFN1ZGVlcCBzaG91bGQgYWxzbyBi
ZSBwYXNzZWQgZnJvbSB1c2VyLCBub3QgaW4gbWFpbGJveCBkcml2ZXIuDQoNCkphc3NpLCBzbyBm
cm9tIHlvdXIgcG9pbnQsIGFybV9zbWNfc2VuZF9kYXRhIGp1c3Qgc2VuZCBhMCAtIGE2DQp0byBm
aXJtd2FyZSwgcmlnaHQ/DQoNClN1ZGVlcCwgQW5kcmUsIEZsb3JpYW4sDQoNCldoYXQncyB5b3Vy
IHN1Z2dlc3Rpb24/IFNDTUkgbm90IHN1cHBvcnQsIGRvIHlvdSBoYXZlDQpwbGFuIHRvIGFkZCBz
bWMgdHJhbnNwb3J0IGluIFNDTUk/DQoNClRoYW5rcywNClBlbmcuDQo=
