Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0089AC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 12:27:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2D9220643
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 12:27:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="B0BXcffU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbfCGM1b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 07:27:31 -0500
Received: from mail-eopbgr80078.outbound.protection.outlook.com ([40.107.8.78]:10512
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726127AbfCGM1a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 07:27:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bPUMbobZaXQGnciMyrp7xxH1xXrsk2uXV4hf7NnYt4I=;
 b=B0BXcffUupR8hn8KViTVQJUci6p63rKGAeuL9cvO/Xjk4oZhSAFXVXO3vtT92+gLzS/UAJ79zMa1sBS2B/NWoUOQpfkDVbqivRCcm1DZdZqVQHsb5xbRk8lENJmrVz508gd7jJlZL1XRo7d+9NYWhCBzUWSjcFE5/3TNqaHKq54=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.92.158) by
 AM0PR04MB4323.eurprd04.prod.outlook.com (52.134.91.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.16; Thu, 7 Mar 2019 12:26:47 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::50ed:d1b5:c043:3b79]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::50ed:d1b5:c043:3b79%2]) with mapi id 15.20.1686.018; Thu, 7 Mar 2019
 12:26:47 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Anson Huang <anson.huang@nxp.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        Andy Gross <andy.gross@linaro.org>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
        "olof@lixom.net" <olof@lixom.net>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V7 3/3] firmware: imx: imx-scu: register build-in child
 devices
Thread-Topic: [PATCH V7 3/3] firmware: imx: imx-scu: register build-in child
 devices
Thread-Index: AQHU07jXPBZZiF4EkESKmz+aUFgRp6X+xWmAgAFUKPA=
Date:   Thu, 7 Mar 2019 12:26:47 +0000
Message-ID: <AM0PR04MB421143FF6BAC09F364D748E5804C0@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1551834095-19950-1-git-send-email-Anson.Huang@nxp.com>
 <1551834095-19950-3-git-send-email-Anson.Huang@nxp.com>
 <90ff94d9-6f15-5353-c5a1-f2ec5ee744ad@roeck-us.net>
In-Reply-To: <90ff94d9-6f15-5353-c5a1-f2ec5ee744ad@roeck-us.net>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2136588b-e043-4f03-149d-08d6a2f82ad4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4323;
x-ms-traffictypediagnostic: AM0PR04MB4323:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtBTTBQUjA0TUI0MzIzOzIzOkNYYkZyUHBlK1NrOTFkbG1CMkNhYWNmYTFU?=
 =?utf-8?B?Z3FLVTFWaEJaaW5zQjdxQ0U2dU9BR084clh0OTI2ZTFjdWhxS21Dck5GdHdD?=
 =?utf-8?B?OE5xMmtHd24zNkJLanZuQjlJa3doOFNOaGF5NWNLUDM5SldZamtaU1E5ci9S?=
 =?utf-8?B?WkY3cHNhQjRHWmM5QVVUaW4xYjN4OXRvMmJ3anFSTDc1WnNwVHR4Uk0xelF4?=
 =?utf-8?B?UTU3Q0tZYVNZWnpWZnFXbjdsbmNxNEpJK2piUkM0VmhOa3ZROEs3cUMrM2Zt?=
 =?utf-8?B?YitIbUFGQ0YwRkd2cEI4VEtMQTJpK0M4MmZyK3cyL28rWjFmZFI1THN0aks5?=
 =?utf-8?B?VlloYXV4OGIxdEhPS21OcHZpemdDKzBKR2F5TFZ2ODU1WEFOcTNXWFNFL0to?=
 =?utf-8?B?MlhUSTIxNVR1MFdvckFoclZGVzN3eWFrOWx4d29yS0FVeVM4UU1oVXluRU9T?=
 =?utf-8?B?QU1ia1pxT2Q0RmFsZU9iR3lxTG93a3VtNXpLTlNEdHlyNGF5a3c4MjloWm1h?=
 =?utf-8?B?Q1BSd3hqalJrVUs1UzFVSlNua21GTW1LdTZ5NHZ5dnlOUGQwOU02VWk3K3BW?=
 =?utf-8?B?TkVoaGJibXBMblZKQVB1Vlgvclh3aXZVZGt5SWFIMXRMZldZUjlhcE1keXMx?=
 =?utf-8?B?Ty9Md0RUSHhMZXZiSmtLTDNBSnZUaDBUVzduWWlTY1MvVFVMQ1p0YlFhTFJ0?=
 =?utf-8?B?T3pkQU1JdHpzTWdXZi82YkNLU0ltNWh3Yy94K05qNEVYcTlEWWpaRUcvazZX?=
 =?utf-8?B?TlRkd3VZNWVKMmRtaWswUTgwbEJUMmN6RVZCMllMSnJhTHVnVjhDWlVqbGF0?=
 =?utf-8?B?Ti8xeHZRNUd4Y2RkNmFOOGluQnFqeXltQkwwNEdJd1hGalNGaThDaFJjQW13?=
 =?utf-8?B?U0c5VVoyR3RFMXY3Z0k3NTI4b0FDT2FGcU82dmxCb0JlYnFqcUYrbC9CN1Ax?=
 =?utf-8?B?NG9sM0lPT3RFM3U5c0pDSkdpN0NTOVR2WnRBRFpuRzNxaHdKaTRRSkMrRTVa?=
 =?utf-8?B?Z2laNnVaNG1vRWFpVGlqY20vbmNEejRERDE0WVBSajA0SUVjM28wVEF3MGpQ?=
 =?utf-8?B?SC9PZC9vdTRvdDZwSnUxQzhIaGFBcXVFcnpoZzVxQVdQTGZ0RU1FVi9hTUIw?=
 =?utf-8?B?R0V2a0lWS3ZqOU50ZVFYWEk5V3dyZnJoUGNvWmlSWmZuZTZpck9CVktSZFVI?=
 =?utf-8?B?RlJKeXRmK01rcW1PdGJkQXdMMjVhRUdiMDdLd21PME5oRmlVeXFXVCtYQ2xw?=
 =?utf-8?B?YjEzUEN0MzlhbTErK1dGVkJLY1VTNmlVN2ZWQ3hELzFsVTU1UThheThvRkFE?=
 =?utf-8?B?UXgwSnRCUGZqTXJMOE1oMTBPVm9oVmtoTkoyUW5JaXFLa1hibi9Xc2c1K3Z1?=
 =?utf-8?B?aDF0bGxwVkl5QXk4cS9SNVUrdDBoK3JZeE9LanpPS0hlQ2JySU9LMUdBVGZj?=
 =?utf-8?B?eEFvMkpzd0tFSGQ4S28vaHp4WEdIZkNnUkpHU1UvUGpSSFVYS3VjRlJDbHha?=
 =?utf-8?B?cTA3d1A0YXc5OURLSTFjNFBJZk4xSHhway9oaXpnUnR2RTVNM202VWc2TUg4?=
 =?utf-8?B?V3NucElkYTIwUDZ0VmxtRlZ4OW8zN09YMmV3cW0yZTZDQXByVDlHRzRJeGQv?=
 =?utf-8?B?eG1CWWZ4SWxKVk10VElpMStpVUdIY2FIejNHMElzRDhXa29rRmhtdTgwdG0x?=
 =?utf-8?B?Q0QrOGg1eU9POGoyazBLQXRtdW1hVUM5TXIvbGN2bnhwK0s2MS9NQ3UzMUt5?=
 =?utf-8?Q?QLt1wE6SOLrx9DwQMsILZRwJ9IHOaw02hDRlw=3D?=
x-microsoft-antispam-prvs: <AM0PR04MB4323467AD52E359A214B50AB804C0@AM0PR04MB4323.eurprd04.prod.outlook.com>
x-forefront-prvs: 096943F07A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(376002)(346002)(396003)(39860400002)(199004)(189003)(6436002)(305945005)(52536013)(478600001)(5660300002)(8676002)(7736002)(99286004)(74316002)(4326008)(76176011)(81156014)(8936002)(186003)(25786009)(81166006)(446003)(11346002)(476003)(66066001)(7696005)(106356001)(2906002)(105586002)(14454004)(6246003)(2501003)(26005)(102836004)(6506007)(486006)(7416002)(9686003)(316002)(33656002)(68736007)(55016002)(53936002)(256004)(6116002)(3846002)(44832011)(86362001)(97736004)(110136005)(2201001)(229853002)(71190400001)(71200400001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4323;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 4gh3LoHZPf3Ip7dxaRb0VayvAyM6G0shGMzPRwLfsGl/EdE7Vw8Nre3+UdC+MCbvl5K8DhMIw4y+07ALE8ZY3G+buU9eD+CqdUsBkJ8equf5KBLI+eloYFMcV1gY7kWaxknhqVWaQNEjtdD6+OySgOrIwSkvhaVMCL8Hv3fm1CYL6WNZ+adKJ5k88v/C3c/4lhYSnQj4G8WXNVlOl3EHoaGTkDb/PN9c2cYl0EBkX1ZqjYLNfnCKHfiYE/FuIyYi5riCSHFcRJJ/RzCc9q617rAQAKO++LTYKi98N8YZ+4ZgVSbBAkfuaOiKNxpyTBoT/V7D1HIEYi84sIG13626HJtrGVFVn1XUHWjrooFt5/xsU1mwrEdjySwJ0aL0n4elZ9kIHbU9zSIWR5Qlxzy8j02ZbST8J3dFaFgeH6ZeSjA=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2136588b-e043-4f03-149d-08d6a2f82ad4
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2019 12:26:47.2183
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4323
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wy4uLl0NCg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Zpcm13YXJlL2lteC9pbXgtc2N1LmMN
Cj4gPiBiL2RyaXZlcnMvZmlybXdhcmUvaW14L2lteC1zY3UuYyBpbmRleCAyYmIxYTE5Li5kZjc1
ZWFkIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZmlybXdhcmUvaW14L2lteC1zY3UuYw0KPiA+
ICsrKyBiL2RyaXZlcnMvZmlybXdhcmUvaW14L2lteC1zY3UuYw0KLi4uDQo+ID4gKwkvKiByZWdp
c3RlciBTQ1UgY2hpbGQgZGV2aWNlcyB3aGljaCBhcmUgTk9UIGluIGRldmljZSB0cmVlICovDQo+
ID4gKwljaGlsZF9wZGV2ID0gcGxhdGZvcm1fZGV2aWNlX3JlZ2lzdGVyX2RhdGEoZGV2LCAiaW14
LXNjLXdkdCIsDQo+ID4gKwkJCQlQTEFURk9STV9ERVZJRF9OT05FLCBOVUxMLCAwKTsNCj4gPiAr
CWlmIChJU19FUlIoY2hpbGRfcGRldikpDQo+ID4gKwkJZGV2X3dhcm4oZGV2LCAiZmFpbGVkIHRv
IHJlZ2lzdGVyIHNjdSB3YXRjaGRvZyBkZXZpY2UgJWxkIVxuIiwNCj4gPiArCQkJIFBUUl9FUlIo
Y2hpbGRfcGRldikpOw0KPiA+ICsNCj4gDQo+IEkganVzdCByZWFsaXplZCAuLi4gc2luY2UgdGhp
cyBpcyBub3QgYSBkZXZtXyBmdW5jdGlvbiwgd2Ugbm93IGFsc28gbmVlZCBlcnJvcg0KPiBoYW5k
bGluZyAoaWYgZGV2bV9vZl9wbGF0Zm9ybV9wb3B1bGF0ZSgpIGZhaWxzKSBhbmQgYSByZW1vdmUg
ZnVuY3Rpb24uDQo+IFNvcnJ5IGZvciB0aGF0IC0gSSBzaG91bGQgaGF2ZSBub3RpY2VkIGVhcmxp
ZXIuDQo+IA0KDQpJdCBsb29rcyBzdHJhbmdlIHRvIG1lIHRoYXQgaW5zdGFudGlhdGUgdGhlIHdh
dGNoZG9nIGRldmljZSBpbiBTQ1UgZHJpdmVyIHdoaWNoDQphY3R1YWxseSBkb2VzIG5vdCB1c2Ug
U0NVLg0KDQpGb3IgbWUsIGl0J3MgYWN0dWFsbHkgYSB3YXRjaGRvZyBwcm92aWRlZCBieSBBVEYg
ZmlybXdhcmUsIG5vdCBTQ1UuDQpJIGV4cGxhaW5lZCB0aGlzIHRvIFJvYiBpbiBhbm90aGVyIG1h
aWwuDQpMZXQncyBzZWUgUm9iJ3MgY29tbWVudHMgb24gaXQuDQoNCklmIFJvYiBhZ3JlZXMsIHdl
IGNhbiBtb3ZlIHdhdGNoZG9nIG5vZGUgb3V0IG9mIFNDVSBhbmQgYWxzbyBkbyBub3QNCm5lZWQg
aW5zdGFudGlhdGUgaXQgaW4gU0NVIGRyaXZlci4NCg0KUmVnYXJkcw0KRG9uZyBBaXNoZW5nDQoN
Cj4gR3VlbnRlcg0KPiANCj4gPiAgIAlyZXR1cm4gZGV2bV9vZl9wbGF0Zm9ybV9wb3B1bGF0ZShk
ZXYpOw0KPiA+ICAgfQ0KPiA+DQo+ID4NCg0K
