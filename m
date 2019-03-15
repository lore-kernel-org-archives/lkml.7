Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B1C3C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 12:58:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D32DC218C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 12:58:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ASJqRIlK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729094AbfCOM61 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 08:58:27 -0400
Received: from mail-eopbgr50066.outbound.protection.outlook.com ([40.107.5.66]:35271
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728157AbfCOM6X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 08:58:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dzPE0veJThlaI/SpeO7TkZxv0mdi+vCbwRaOD7dWg7A=;
 b=ASJqRIlKlegCbQFyCT6a5OtVw7SERtPTUF7ARkmL+IKoRyI442LCSD5537QbpShUUoUyuDnl4FHMge2SiRfihPZ1h8qoPQvDWOZMgFGQVBxG7bEWWGXv62ck5tY4lu2TBffEfy1R5vAgJYQTJ08LD5lyPXZ4I7MyY8Zk1xLMYFs=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB6563.eurprd04.prod.outlook.com (20.179.254.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.13; Fri, 15 Mar 2019 12:58:18 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::a51f:134d:b530:f185]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::a51f:134d:b530:f185%5]) with mapi id 15.20.1709.011; Fri, 15 Mar 2019
 12:58:18 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Aisheng Dong <aisheng.dong@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "van.freenix@gmail.com" <van.freenix@gmail.com>
Subject: RE: [PATCH 2/2] ARM: imx: mach-imx7ulp: warn when imx_soc_device_init
 fail
Thread-Topic: [PATCH 2/2] ARM: imx: mach-imx7ulp: warn when
 imx_soc_device_init fail
Thread-Index: AQHU2Xv55ycgcbWqOUOiTJMdwKpBc6YMfvcAgAArCTA=
Date:   Fri, 15 Mar 2019 12:58:18 +0000
Message-ID: <AM0PR04MB44817A913A33ECEC6D572D7E88440@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <20190313091757.16410-1-peng.fan@nxp.com>
 <20190313091757.16410-2-peng.fan@nxp.com>
 <AM0PR04MB4211FE93F235498D795C2FED80440@AM0PR04MB4211.eurprd04.prod.outlook.com>
In-Reply-To: <AM0PR04MB4211FE93F235498D795C2FED80440@AM0PR04MB4211.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [121.236.246.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d9961561-f2ec-4f5f-3c4f-08d6a945e58d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB6563;
x-ms-traffictypediagnostic: AM0PR04MB6563:
x-microsoft-antispam-prvs: <AM0PR04MB6563FF136CE6A91B78458FAD88440@AM0PR04MB6563.eurprd04.prod.outlook.com>
x-forefront-prvs: 09778E995A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(366004)(376002)(136003)(39860400002)(13464003)(199004)(189003)(305945005)(7736002)(86362001)(81156014)(4326008)(9686003)(8936002)(2201001)(76176011)(55016002)(6436002)(8676002)(446003)(7696005)(81166006)(11346002)(74316002)(476003)(486006)(6246003)(52536014)(68736007)(71200400001)(71190400001)(53936002)(229853002)(478600001)(25786009)(2906002)(106356001)(105586002)(102836004)(6116002)(3846002)(186003)(256004)(14444005)(33656002)(14454004)(99286004)(66066001)(110136005)(44832011)(5660300002)(97736004)(2501003)(53546011)(316002)(26005)(6506007)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6563;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: jVdvGpL3/9iYVdON52MOv9rhLDDFmPS9q+NJ04n0g40Ls0FPicmASns2Re8cq3VWS8Qa/BADBUmrfKoIDRtQEBZpgLmAjbKPo7NctUipu3YMas69F8WC4r4/wU3wqDIAw69JtLW1LUZw+e0Xrai5u3d9VreT6ki5jFR1L1w7fQjNNLKJufNfu7Aadyvx25Z5ejP/ZkW2jyNPGJDxMyYll38UbfZmYxucjY2fMf7caYwmEDNDHViYwcS12JzPnC07PWUq7u5A1V471jFUnHS+6pEIFKGL8yBUtXff0zr6K6KdpoZRxywRqiVgsJjHD01ue0DB4RQLAyLkkp88Mu8xp68olilHX0BR/AANTPQThXY52t3WvY9gb+MGSweIxAncI0Denb+/XzUTqLFtfel7WmRejGdbm+3qiJFYyP7Y+o0=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9961561-f2ec-4f5f-3c4f-08d6a945e58d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2019 12:58:18.7609
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6563
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQWlzaGVuZyBEb25nDQo+
IFNlbnQ6IDIwMTnE6jPUwjE1yNUgMTg6MjINCj4gVG86IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAu
Y29tPjsgc2hhd25ndW9Aa2VybmVsLm9yZzsNCj4gcy5oYXVlckBwZW5ndXRyb25peC5kZTsga2Vy
bmVsQHBlbmd1dHJvbml4LmRlOyBmZXN0ZXZhbUBnbWFpbC5jb207DQo+IGRsLWxpbnV4LWlteCA8
bGludXgtaW14QG54cC5jb20+OyBBbnNvbiBIdWFuZyA8YW5zb24uaHVhbmdAbnhwLmNvbT47DQo+
IGFybmRAYXJuZGIuZGU7IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsNCj4g
bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBDYzogdmFuLmZyZWVuaXhAZ21haWwuY29t
DQo+IFN1YmplY3Q6IFJFOiBbUEFUQ0ggMi8yXSBBUk06IGlteDogbWFjaC1pbXg3dWxwOiB3YXJu
IHdoZW4NCj4gaW14X3NvY19kZXZpY2VfaW5pdCBmYWlsDQo+IA0KPiA+IEZyb206IFBlbmcgRmFu
DQo+ID4NCj4gPiBbUEFUQ0ggMi8yXSBBUk06IGlteDogbWFjaC1pbXg3dWxwOiB3YXJuIHdoZW4g
aW14X3NvY19kZXZpY2VfaW5pdCBmYWlsDQo+IA0KPiBBUk06IGlteDogaW14N3VscDogLi4uDQoN
Ck9rLg0KPiANCj4gPiBGb2xsb3cgb3RoZXIgaS5NWDYvNyBtYWNoaW5jZSBjb2RlIHRvIGNoZWNr
IHJldHVybiB2YWx1ZSBvZg0KPiA+IGlteF9zb2NfZGV2aWNlX2luaXQgYW5kIHdhcm4gd2hlbiBm
YWlsLg0KPiA+DQo+ID4gQWxzbyBkcm9wIG9mX3BsYXRmb3JtX2RlZmF1bHRfcG9wdWxhdGUsIGJl
Y2F1c2UNCj4gPiAiYXJjaF9pbml0Y2FsbF9zeW5jKG9mX3BsYXRmb3JtX2RlZmF1bHRfcG9wdWxh
dGVfaW5pdCk7IiBjb3VsZCBiZSB1c2VkDQo+ID4gdG8gcG9wdWxhdGUgdGhlIGRldmljZSB0cmVl
Lg0KPiA+DQo+IA0KPiBUaGlzIGNvdWxkIGJlIGluIHNlcGFyYXRlIHBhdGNoLg0KDQpJJ2xsIGRv
IGl0IGluIHYyIGFmdGVyIHdlIGFncmVlIHRoZSBjaGFuZ2UgaW4gdGhlIGZpcnN0IHBhdGNoLg0K
DQo+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPg0KPiA+
IC0tLQ0KPiA+ICBhcmNoL2FybS9tYWNoLWlteC9tYWNoLWlteDd1bHAuYyB8IDcgKysrKysrLQ0K
PiA+ICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4N
Cj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vbWFjaC1pbXgvbWFjaC1pbXg3dWxwLmMNCj4gPiBi
L2FyY2gvYXJtL21hY2gtaW14L21hY2gtaW14N3VscC5jDQo+ID4gaW5kZXggMTFhYzcxYWFmOTY1
Li42ZDgyM2YwNWQ5YWEgMTAwNjQ0DQo+ID4gLS0tIGEvYXJjaC9hcm0vbWFjaC1pbXgvbWFjaC1p
bXg3dWxwLmMNCj4gPiArKysgYi9hcmNoL2FybS9tYWNoLWlteC9tYWNoLWlteDd1bHAuYw0KPiA+
IEBAIC01MywxMSArNTMsMTYgQEAgc3RhdGljIHZvaWQgX19pbml0IGlteDd1bHBfc2V0X3Jldmlz
aW9uKHZvaWQpDQo+ID4NCj4gPiAgc3RhdGljIHZvaWQgX19pbml0IGlteDd1bHBfaW5pdF9tYWNo
aW5lKHZvaWQpICB7DQo+ID4gKwlzdHJ1Y3QgZGV2aWNlICpzb2NfZGV2Ow0KPiA+ICsNCj4gPiAr
CXNvY19kZXYgPSBpbXhfc29jX2RldmljZV9pbml0KCk7DQo+ID4gKwlpZiAoc29jX2RldiA9PSBO
VUxMKQ0KPiA+ICsJCXByX3dhcm4oImZhaWxlZCB0byBpbml0aWFsaXplIHNvYyBkZXZpY2VcbiIp
Ow0KPiA+ICsNCj4gDQo+IFNob3VsZCB0aGlzIGJlIHVuZGVyIHNldCByZXZpc2lvbj8NCg0KSnVz
dCBmb2xsb3cgb3RoZXIgaS5NWDYvNyBwbGF0Zm9ybXMgcHJhY3RpY2UsIEkgY291bGQgbW92ZQ0K
dGhpcyB1bmRlciBzZXQgcmV2aXNpb24gaW4gdjIgaWYgeW91IHByZWZlci4NCg0KVGhhbmtzLA0K
UGVuZy4NCg0KPiANCj4gUmVnYXJkcw0KPiBEb25nIEFpc2hlbmcNCj4gDQo+ID4gIAlpbXg3dWxw
X3BtX2luaXQoKTsNCj4gPg0KPiA+ICAJbXhjX3NldF9jcHVfdHlwZShNWENfQ1BVX0lNWDdVTFAp
Ow0KPiA+ICAJaW14N3VscF9zZXRfcmV2aXNpb24oKTsNCj4gPiAtCW9mX3BsYXRmb3JtX2RlZmF1
bHRfcG9wdWxhdGUoTlVMTCwgTlVMTCwgaW14X3NvY19kZXZpY2VfaW5pdCgpKTsNCj4gPiAgfQ0K
PiA+DQo+ID4gIHN0YXRpYyBjb25zdCBjaGFyICpjb25zdCBpbXg3dWxwX2R0X2NvbXBhdFtdIF9f
aW5pdGNvbnN0ID0gew0KPiA+IC0tDQo+ID4gMi4xNi40DQoNCg==
