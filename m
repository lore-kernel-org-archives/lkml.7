Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23B92C31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 08:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF35F20863
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 08:25:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ckFrTQGV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728869AbfFRIZq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 04:25:46 -0400
Received: from mail-eopbgr130075.outbound.protection.outlook.com ([40.107.13.75]:56697
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725913AbfFRIZq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 04:25:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U3A4FRdUf2IVNqKozwOhlR1B8Z8XBaM4LLFZtI8VkSw=;
 b=ckFrTQGVg4zrxzml3+Ua4Rcuv4MvPRE+eGGka2c6Bm4VHOCOyvS+OE19utPmLv5NIPncyqybhRN0uIiIDXWl7fACrkGHaidL+SQV6yXf4JQOltNdp4uhTGT2/fmgHt0h8KWi+NPLtgNDC7DvhyV4bGKGy1+NvaiYtEutpiYjIrw=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3788.eurprd04.prod.outlook.com (52.134.72.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.11; Tue, 18 Jun 2019 08:24:59 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::5835:e874:bd94:fec]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::5835:e874:bd94:fec%5]) with mapi id 15.20.1987.014; Tue, 18 Jun 2019
 08:24:59 +0000
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
Subject: RE: [PATCH] soc: imx: Add i.MX8MN SoC driver support
Thread-Topic: [PATCH] soc: imx: Add i.MX8MN SoC driver support
Thread-Index: AQHVH/Up3NdnX/doMEq9SuarUx0FjqahB/qAgAABlMA=
Date:   Tue, 18 Jun 2019 08:24:59 +0000
Message-ID: <DB3PR0402MB391691EEF083BA6BEF445235F5EA0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <20190611013125.3434-1-Anson.Huang@nxp.com>
 <20190618070334.GD29881@dragon>
In-Reply-To: <20190618070334.GD29881@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9b11e7e0-2ae4-4dd5-83f9-08d6f3c673e1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3788;
x-ms-traffictypediagnostic: DB3PR0402MB3788:
x-microsoft-antispam-prvs: <DB3PR0402MB37880749E35B59107F8D4D2BF5EA0@DB3PR0402MB3788.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 007271867D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(39860400002)(376002)(396003)(136003)(13464003)(199004)(189003)(2906002)(14444005)(54906003)(8936002)(186003)(3846002)(33656002)(6916009)(102836004)(99286004)(6116002)(256004)(11346002)(66446008)(66476007)(6246003)(73956011)(5660300002)(53546011)(66946007)(305945005)(66066001)(25786009)(478600001)(81166006)(76116006)(71190400001)(71200400001)(486006)(476003)(26005)(316002)(66556008)(64756008)(53936002)(8676002)(9686003)(7696005)(44832011)(74316002)(6506007)(7736002)(55016002)(14454004)(86362001)(6436002)(68736007)(4326008)(52536014)(76176011)(446003)(81156014)(229853002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3788;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 702YO6AwSzQI6FuJR39eN8dpP44Mub3MZNkUyqnkqOs1bjeAbPbAQspsugAMzvcCXePJAK2TLWIsFTZ1taH3weyAiwex3i0a7K1+S9Dc6tDr6le9yAGQxpGALlX3D9dKpXKDFa1zgVDGSqCMi23T0goa/6x6MY8nA2Rgp7h3wkHSIH5k7SL2jRgU0YasXkPLwkc0TqzG5BboUovX5xkkqZt/AdwYF/qJ92RodqS4NLmwsyTjiNxfRQpoIoh/Swc7PghYPDKm/tqj9+VpT7jdQgx+KKDHOxe3QRN8kle0hA2shcc92ZY72RPtBlH5hLY2fPQxhV2Y4mL0CNFYk4A/NuQMeXKoU9Xt7jbjckyy1Ef5618OaEgidiB+8jawspyjHoMFE7CTybYCWrfCwLCc0WpCd6dKOPpOhBn55PfJgBA=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b11e7e0-2ae4-4dd5-83f9-08d6f3c673e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2019 08:24:59.1398
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: anson.huang@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3788
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFNoYXduDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU2hhd24g
R3VvIDxzaGF3bmd1b0BrZXJuZWwub3JnPg0KPiBTZW50OiBUdWVzZGF5LCBKdW5lIDE4LCAyMDE5
IDM6MDQgUE0NCj4gVG86IEFuc29uIEh1YW5nIDxhbnNvbi5odWFuZ0BueHAuY29tPg0KPiBDYzog
cy5oYXVlckBwZW5ndXRyb25peC5kZTsga2VybmVsQHBlbmd1dHJvbml4LmRlOyBmZXN0ZXZhbUBn
bWFpbC5jb207DQo+IExlb25hcmQgQ3Jlc3RleiA8bGVvbmFyZC5jcmVzdGV6QG54cC5jb20+OyB2
aXJlc2gua3VtYXJAbGluYXJvLm9yZzsNCj4gQWJlbCBWZXNhIDxhYmVsLnZlc2FAbnhwLmNvbT47
IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsNCj4gbGludXgta2VybmVsQHZn
ZXIua2VybmVsLm9yZzsgZGwtbGludXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT4NCj4gU3ViamVj
dDogUmU6IFtQQVRDSF0gc29jOiBpbXg6IEFkZCBpLk1YOE1OIFNvQyBkcml2ZXIgc3VwcG9ydA0K
PiANCj4gT24gVHVlLCBKdW4gMTEsIDIwMTkgYXQgMDk6MzE6MjVBTSArMDgwMCwgQW5zb24uSHVh
bmdAbnhwLmNvbSB3cm90ZToNCj4gPiBGcm9tOiBBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdAbnhw
LmNvbT4NCj4gPg0KPiA+IFRoaXMgcGF0Y2ggYWRkcyBpLk1YOE1OIFNvQyBkcml2ZXIgc3VwcG9y
dDoNCj4gPg0KPiA+IHJvb3RAaW14OG1uZXZrOn4jIGNhdCAvc3lzL2RldmljZXMvc29jMC9mYW1p
bHkgRnJlZXNjYWxlIGkuTVgNCj4gPg0KPiA+IHJvb3RAaW14OG1uZXZrOn4jIGNhdCAvc3lzL2Rl
dmljZXMvc29jMC9tYWNoaW5lIE5YUCBpLk1YOE1OYW5vDQo+IEREUjQNCj4gPiBFVksgYm9hcmQN
Cj4gPg0KPiA+IHJvb3RAaW14OG1uZXZrOn4jIGNhdCAvc3lzL2RldmljZXMvc29jMC9zb2NfaWQg
aS5NWDhNTg0KPiA+DQo+ID4gcm9vdEBpbXg4bW5ldms6fiMgY2F0IC9zeXMvZGV2aWNlcy9zb2Mw
L3JldmlzaW9uDQo+ID4gMS4wDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBBbnNvbiBIdWFuZyA8
QW5zb24uSHVhbmdAbnhwLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9zb2MvaW14L3NvYy1p
bXg4LmMgfCAxMyArKysrKysrKysrKystDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxMiBpbnNlcnRp
b25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9zb2Mv
aW14L3NvYy1pbXg4LmMgYi9kcml2ZXJzL3NvYy9pbXgvc29jLWlteDguYw0KPiA+IGluZGV4IDM4
NDJkMDkuLjAyMzA5YTIgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9zb2MvaW14L3NvYy1pbXg4
LmMNCj4gPiArKysgYi9kcml2ZXJzL3NvYy9pbXgvc29jLWlteDguYw0KPiA+IEBAIC01NSw3ICs1
NSwxMiBAQCBzdGF0aWMgdTMyIF9faW5pdCBpbXg4bW1fc29jX3JldmlzaW9uKHZvaWQpDQo+ID4g
IAl2b2lkIF9faW9tZW0gKmFuYXRvcF9iYXNlOw0KPiA+ICAJdTMyIHJldjsNCj4gPg0KPiA+IC0J
bnAgPSBvZl9maW5kX2NvbXBhdGlibGVfbm9kZShOVUxMLCBOVUxMLCAiZnNsLGlteDhtbS1hbmF0
b3AiKTsNCj4gPiArCWlmIChvZl9tYWNoaW5lX2lzX2NvbXBhdGlibGUoImZzbCxpbXg4bW0iKSkN
Cj4gPiArCQlucCA9IG9mX2ZpbmRfY29tcGF0aWJsZV9ub2RlKE5VTEwsIE5VTEwsICJmc2wsaW14
OG1tLQ0KPiBhbmF0b3AiKTsNCj4gPiArCWVsc2UgaWYgKG9mX21hY2hpbmVfaXNfY29tcGF0aWJs
ZSgiZnNsLGlteDhtbiIpKQ0KPiA+ICsJCW5wID0gb2ZfZmluZF9jb21wYXRpYmxlX25vZGUoTlVM
TCwgTlVMTCwgImZzbCxpbXg4bW4tDQo+IGFuYXRvcCIpOw0KPiANCj4gQ2FuIHdlIGhhdmUgdGhp
cyBhbmF0b3AgY29tcGF0aWJsZSBpbiBpbXg4X3NvY19kYXRhLCBzbyB0aGF0IHdlIG1heSBzYXZl
DQo+IHRoZSBjYWxsIHRvIG9mX21hY2hpbmVfaXNfY29tcGF0aWJsZSgpPw0KDQpEbyB5b3UgbWVh
biBhZGRpbmcgYSB2YXJpYWJsZSBsaWtlICIgY29uc3QgY2hhciAqYW5hdG9wX2NvbXBhdCAiIGlu
IGlteDhfc29jX2RhdGUgc3RydWN0dXJlLA0KdGhlbiBpbml0aWFsaXplIGl0IGFjY29yZGluZyB0
byBTb0MgdHlwZSwgYW5kIGluIGlteDhtbV9zb2NfcmV2aXNpb24oKSwgZ2V0IHRvIHNvY19kYXRh
J3MgYW5hdGlvX2NvbXBhdCB0bw0KZmluZCB0aGUgYW5hdG9wIG5vZGU/IElmIHllcywgd2UgaGF2
ZSB0byBhZGQgc29tZSBjb2RlIHRvIGdldCB0aGUgc29jX2RhdGEgaW4gdGhpcyBmdW5jdGlvbiwg
b3IgbWF5YmUNCndlIGNhbiBwYXNzIGFuYXRvcCBjb21wYXRpYmxlIG5hbWUgYXMgLnNvY19yZXZp
c2lvbidzIHBhcmFtZXRlcj8NCg0Kc3RhdGljIGNvbnN0IHN0cnVjdCBpbXg4X3NvY19kYXRhIGlt
eDhtbl9zb2NfZGF0YSA9IHsNCiAgICAgICAgIC5uYW1lID0gImkuTVg4TU4iLA0KICAgICAgICAg
LnNvY19yZXZpc2lvbiA9IGlteDhtbV9zb2NfcmV2aXNpb24sDQogICAgICAgICAuYW5hdG9wX2Nv
bXBhdCA9ICJmc2wsaW14OG1uLWFuYXRvcCIsDQp9Ow0KDQpBbnNvbi4NCj4gDQo+IFNoYXduDQo+
IA0KPiA+ICsJZWxzZQ0KPiA+ICsJCW5wID0gTlVMTDsNCj4gPiAgCWlmICghbnApDQo+ID4gIAkJ
cmV0dXJuIDA7DQo+ID4NCj4gPiBAQCAtNzksOSArODQsMTUgQEAgc3RhdGljIGNvbnN0IHN0cnVj
dCBpbXg4X3NvY19kYXRhIGlteDhtbV9zb2NfZGF0YQ0KPiA9IHsNCj4gPiAgCS5zb2NfcmV2aXNp
b24gPSBpbXg4bW1fc29jX3JldmlzaW9uLCAgfTsNCj4gPg0KPiA+ICtzdGF0aWMgY29uc3Qgc3Ry
dWN0IGlteDhfc29jX2RhdGEgaW14OG1uX3NvY19kYXRhID0gew0KPiA+ICsJLm5hbWUgPSAiaS5N
WDhNTiIsDQo+ID4gKwkuc29jX3JldmlzaW9uID0gaW14OG1tX3NvY19yZXZpc2lvbiwgfTsNCj4g
PiArDQo+ID4gIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIGlteDhfc29jX21hdGNo
W10gPSB7DQo+ID4gIAl7IC5jb21wYXRpYmxlID0gImZzbCxpbXg4bXEiLCAuZGF0YSA9ICZpbXg4
bXFfc29jX2RhdGEsIH0sDQo+ID4gIAl7IC5jb21wYXRpYmxlID0gImZzbCxpbXg4bW0iLCAuZGF0
YSA9ICZpbXg4bW1fc29jX2RhdGEsIH0sDQo+ID4gKwl7IC5jb21wYXRpYmxlID0gImZzbCxpbXg4
bW4iLCAuZGF0YSA9ICZpbXg4bW5fc29jX2RhdGEsIH0sDQo+ID4gIAl7IH0NCj4gPiAgfTsNCj4g
Pg0KPiA+IC0tDQo+ID4gMi43LjQNCj4gPg0K
