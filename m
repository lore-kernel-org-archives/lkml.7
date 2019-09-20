Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC3AC49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 07:33:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECCDD208C0
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 07:33:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="pwiKCA9s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395071AbfITHdn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 03:33:43 -0400
Received: from mail-eopbgr130079.outbound.protection.outlook.com ([40.107.13.79]:33104
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2394985AbfITHdm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 03:33:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TilosVcDss59N/v9c7Qr31JH85W5GUmJovMhZXmkcYYoX+cNwkX6frzC/s1MkOeAl3Pw59CMerFiP/LnyUscyc8v86j8Hf3oOIJqGF93IDtslmp0uXD5o2yFbsINXtI8t941zEURjXvQ0kPXH9M92XK1tgB2GptCByfB9MpvAZV1Cxn0TYr7Gpd0s79FVMjzNRH2Om9I1AWf8mcIJT4LCI6R7fPWt4LudsHUQdwUQVdoHxUHsoIBO5+NK43lwDc1yrHfgp42+6Z+w+AA1EVZ+2fBzJK2oK4vSmFm+chf4CqtrKpPzWr/xnvj2kqFb2uwSxDfOkloc/lW/5XSWkizAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MZQJlfOWHBy0WuOpDNNJhcoqZwasyhHBZ9xppbiYJSA=;
 b=RsNjA5QsB00Sgk4xcHhDtWPhKRMgwtOQWpJbUi37NQVW1GTzLZy2ZZyGqWuKEL1/42AtTUNlcNi9tBxg8bp01k+tRlOrpvZJyHNK7gB52yDd/Ir9HN07Q8kNzZgfF87wi2Bwyv4il+rvPhvQZztsFHPGa6dPnc3jFLDe4pG00MMixvR9ylrDHqgVNYrUVKctFRaLp9z+8dtZZIiVlqXaW3bUczF/3DCcZ0Pls9dkn6Fsi14hKTOzUaXmeIJVXQJQ/2d2FWD9nyhHok8zi3YXJuy/ZxaEO5IwGcYR4HPILd0iflaGwgI6qrQKtvJkdHgiMzoyLxRLB/zmxe2EYz88Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MZQJlfOWHBy0WuOpDNNJhcoqZwasyhHBZ9xppbiYJSA=;
 b=pwiKCA9sTSVvV/BCixucZTR625/MhatoQ/qdtEiOeAHtPSVeAn0N9tmAeRyFQ/G36rXLVXiGQyvK2DVlHiL13PVIiUSpCOZ5/DiqqIkfjKcZDBtbX0Yt2fvumEdYHwGV+/Vnevpep6EeAtvCHqP91VGbKXjUhvB31+v42mDVVbw=
Received: from VI1PR0402MB3600.eurprd04.prod.outlook.com (52.134.5.23) by
 VI1PR0402MB2895.eurprd04.prod.outlook.com (10.175.24.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.23; Fri, 20 Sep 2019 07:33:36 +0000
Received: from VI1PR0402MB3600.eurprd04.prod.outlook.com
 ([fe80::f919:a62a:998c:6e9a]) by VI1PR0402MB3600.eurprd04.prod.outlook.com
 ([fe80::f919:a62a:998c:6e9a%6]) with mapi id 15.20.2284.009; Fri, 20 Sep 2019
 07:33:36 +0000
From:   Andy Duan <fugang.duan@nxp.com>
To:     Philipp Puschmann <philipp.puschmann@emlix.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Robin Gong <yibin.gong@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "jslaby@suse.com" <jslaby@suse.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [EXT] [PATCH v3] serial: imx: adapt rx buffer and dma periods
Thread-Topic: [EXT] [PATCH v3] serial: imx: adapt rx buffer and dma periods
Thread-Index: AQHVbvmzoURW9oife0iGKep4oJxlpacz42bggABCYYCAAAcrgA==
Date:   Fri, 20 Sep 2019 07:33:36 +0000
Message-ID: <VI1PR0402MB3600A07887B73FA9EB310524FF880@VI1PR0402MB3600.eurprd04.prod.outlook.com>
References: <20190919145114.13006-1-philipp.puschmann@emlix.com>
 <VI1PR0402MB3600CA068AEBAC63D3CE6A4CFF880@VI1PR0402MB3600.eurprd04.prod.outlook.com>
 <ac67f010-1b2c-6996-f542-ab955ca86489@emlix.com>
In-Reply-To: <ac67f010-1b2c-6996-f542-ab955ca86489@emlix.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=fugang.duan@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e36e0c04-9a04-40e3-079a-08d73d9cd92f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR0402MB2895;
x-ms-traffictypediagnostic: VI1PR0402MB2895:|VI1PR0402MB2895:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0402MB28952E8C81ABD4870E5B41F1FF880@VI1PR0402MB2895.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0166B75B74
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(39860400002)(136003)(396003)(366004)(54534003)(199004)(51914003)(189003)(6116002)(478600001)(8676002)(476003)(66066001)(3846002)(256004)(316002)(186003)(7416002)(102836004)(14444005)(71200400001)(52536014)(486006)(6506007)(8936002)(81166006)(71190400001)(81156014)(110136005)(229853002)(33656002)(86362001)(6246003)(55016002)(14454004)(66446008)(64756008)(66946007)(25786009)(66476007)(54906003)(76116006)(74316002)(66556008)(4326008)(99286004)(9686003)(2906002)(5660300002)(6436002)(305945005)(11346002)(7736002)(7696005)(26005)(2501003)(446003)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB2895;H:VI1PR0402MB3600.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: nnkm5HRgJZfrHqNyZVMj2I4tm8r5L6IBJttz4v81GDTM7KlJx0F+YaTlXw9ZQv97Ovl7PvFnfbcAbBVoqjBIScnozeADLgCOi+IlyQo99dtvdIqfqIZCncBxNXXLIewLDie+5P9+6KGNhZWrENT3B8x4T55gLO7JZYhJnjr815by+F5L28jOMg0TC6ssEXksrtT14pmXUH8BvVPQ9cm5XHGShNpfF0pQWFr5u+Yqmm3+0Za5x/WEJfAd88IYllAsRiswJ27VbTPftAILbh1TCQLy0BA3Ynfei/zlIn6h00b3T0fV1LKAsIAid5LI74yeEBcQS8u5+79m9HNFKvdwUORnIqSjaayuJ1FcMNeBF5P5Qeg/Syhewh5cWEKrjUff5kr6xPk/DbT7y17cKlyW+QHGnGiNc3lLjVGM+rf0X9Q=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e36e0c04-9a04-40e3-079a-08d73d9cd92f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2019 07:33:36.2046
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3GoqBWKAdevF/hxIYpylXNk3NQQfbRrVlk/y499yV2qgaw4iAljcKc4AD75ybfEwq8fQVZULB6fVNC2dnnLMwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2895
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogUGhpbGlwcCBQdXNjaG1hbm4gPHBoaWxpcHAucHVzY2htYW5uQGVtbGl4LmNvbT4gU2Vu
dDogRnJpZGF5LCBTZXB0ZW1iZXIgMjAsIDIwMTkgMzowNiBQTQ0KPiBBbSAyMC4wOS4xOSB1bSAw
NTo0MiBzY2hyaWViIEFuZHkgRHVhbjoNCj4gPiBGcm9tOiBQaGlsaXBwIFB1c2NobWFubiA8cGhp
bGlwcC5wdXNjaG1hbm5AZW1saXguY29tPiBTZW50OiBUaHVyc2RheSwNCj4gPiBTZXB0ZW1iZXIg
MTksIDIwMTkgMTA6NTEgUE0NCj4gPj4gVXNpbmcgb25seSA0IERNQSBwZXJpb2RzIGZvciBVQVJU
IFJYIGlzIHZlcnkgZmV3IGlmIHdlIGhhdmUgYSBoaWdoDQo+ID4+IGZyZXF1ZW5jeSBvZiBzbWFs
bCB0cmFuc2ZlcnMgLSBsaWtlIGluIG91ciBjYXNlIHVzaW5nIEJsdWV0b290aCB3aXRoDQo+ID4+
IG1hbnkgc21hbGwgcGFja2V0cyB2aWEgVUFSVCAtIGNhdXNpbmcgbWFueSBkbWEgdHJhbnNmZXJz
IGJ1dCBpbiBlYWNoDQo+ID4+IG9ubHkgZmlsbGluZyBhIGZyYWN0aW9uIG9mIGEgc2luZ2xlIGJ1
ZmZlci4gU3VjaCBhIGNhc2UgbWF5IGxlYWQgdG8NCj4gPj4gdGhlIHNpdHVhdGlvbiB0aGF0IERN
QSBSWCB0cmFuc2ZlciBpcyB0cmlnZ2VyZWQgYnV0IG5vIGZyZWUgYnVmZmVyIGlzDQo+ID4+IGF2
YWlsYWJsZS4gV2hlbiB0aGlzIGhhcHBlbnMgZG1hIGNoYW5uZWwgaXN0IHN0b3BwZWQgLSB3aXRo
IHRoZSBwYXRjaA0KPiA+PiAiZG1hZW5naW5lOiBpbXgtc2RtYTogZml4IGRtYSBmcmVlemVzIiB0
ZW1wb3JhcmlseSBvbmx5IC0gd2l0aCB0aGUNCj4gPj4gcG9zc2libGUgY29uc2VxdWVuY2VzIHRo
YXQ6DQo+ID4+IHdpdGggZGlzYWJsZWQgaHcgZmxvdyBjb250cm9sOg0KPiA+PiAgIElmIGVub3Vn
aCBkYXRhIGlzIGluY29taW5nIG9uIFVBUlQgcG9ydCB0aGUgUlggRklGTyBydW5zIG92ZXIgYW5k
DQo+ID4+ICAgY2hhcmFjdGVycyB3aWxsIGJlIGxvc3QuIFdoYXQgdGhlbiBoYXBwZW5zIGRlcGVu
ZHMgb24gdXBwZXIgbGF5ZXIuDQo+ID4+DQo+ID4+IHdpdGggZW5hYmxlZCBodyBmbG93IGNvbnRy
b2w6DQo+ID4+ICAgSWYgZW5vdWdoIGRhdGEgaXMgaW5jb21pbmcgb24gVUFSVCBwb3J0IHRoZSBS
WCBGSUZPIHJlYWNoZXMgYSBsZXZlbA0KPiA+PiAgIHdoZXJlIENUUyBpcyBkZWFzc2VydGVkIGFu
ZCByZW1vdGUgZGV2aWNlIHNlbmRpbmcgdGhlIGRhdGEgc3RvcHMuDQo+ID4+ICAgSWYgaXQgZmFp
bHMgdG8gc3RvcCB0aW1lbHkgdGhlIGkuTVgnIFJYIEZJRk8gbWF5IHJ1biBvdmVyIGFuZCBkYXRh
DQo+ID4+ICAgZ2V0IGxvc3QuIE90aGVyd2lzZSBpdCdzIGludGVybmFsIFRYIGJ1ZmZlciBtYXkg
Z2V0dGluZyBmaWxsZWQgdG8NCj4gPj4gICBhIHBvaW50IHdoZXJlIGl0IHJ1bnMgb3ZlciBhbmQg
ZGF0YSBpcyBhZ2FpbiBsb3N0LiBJdCBkZXBlbmRzIG9uDQo+ID4+ICAgdGhlIHJlbW90ZSBkZXZp
Y2UgaG93IHRoaXMgY2FzZSBpcyBoYW5kbGVkIGFuZCBpZiBpdCBpcyByZWNvdmVyYWJsZS4NCj4g
Pj4NCj4gPj4gT2J2aW91c2x5IHdlIHdhbnQgdG8gYXZvaWQgaGF2aW5nIG5vIGZyZWUgYnVmZmVy
cyBhdmFpbGFibGUuIFNvIHdlDQo+ID4+IGRlY3JlYXNlIHRoZSBzaXplIG9mIHRoZSBidWZmZXJz
IGFuZCBpbmNyZWFzZSB0aGVpciBudW1iZXIgYW5kIHRoZSB0b3RhbA0KPiBidWZmZXIgc2l6ZS4N
Cj4gPj4NCj4gPj4gU2lnbmVkLW9mZi1ieTogUGhpbGlwcCBQdXNjaG1hbm4gPHBoaWxpcHAucHVz
Y2htYW5uQGVtbGl4LmNvbT4NCj4gPj4gUmV2aWV3ZWQtYnk6IEx1Y2FzIFN0YWNoIDxsLnN0YWNo
QHBlbmd1dHJvbml4LmRlPg0KPiA+PiAtLS0NCj4gPj4NCj4gPj4gQ2hhbmdlbG9nIHYzOg0KPiA+
PiAgLSBlbmhhbmNlIGRlc2NyaXB0aW9uDQo+ID4+DQo+ID4+IENoYW5nZWxvZyB2MjoNCj4gPj4g
IC0gc3BsaXQgdGhpcyBwYXRjaCBmcm9tIHNlcmllcyAiRml4IFVBUlQgRE1BIGZyZWV6ZXMgZm9y
IGlNWDYiDQo+ID4+ICAtIGFkZCBSZXZpZXdlZC1ieSB0YWcNCj4gPj4NCj4gPj4gIGRyaXZlcnMv
dHR5L3NlcmlhbC9pbXguYyB8IDUgKystLS0NCj4gPj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2Vy
dGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+ID4+DQo+ID4+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L3R0eS9zZXJpYWwvaW14LmMgYi9kcml2ZXJzL3R0eS9zZXJpYWwvaW14LmMNCj4gPj4gaW5kZXgg
ODdjNThmOWY2MzkwLi41MWRjMTk4MzNlYWIgMTAwNjQ0DQo+ID4+IC0tLSBhL2RyaXZlcnMvdHR5
L3NlcmlhbC9pbXguYw0KPiA+PiArKysgYi9kcml2ZXJzL3R0eS9zZXJpYWwvaW14LmMNCj4gPj4g
QEAgLTEwMzQsOCArMTAzNCw2IEBAIHN0YXRpYyB2b2lkIGlteF91YXJ0X3RpbWVvdXQoc3RydWN0
IHRpbWVyX2xpc3QNCj4gKnQpDQo+ID4+ICAgICAgICAgfQ0KPiA+PiAgfQ0KPiA+Pg0KPiA+PiAt
I2RlZmluZSBSWF9CVUZfU0laRSAgICAoUEFHRV9TSVpFKQ0KPiA+PiAtDQo+ID4+ICAvKg0KPiA+
PiAgICogVGhlcmUgYXJlIHR3byBraW5kcyBvZiBSWCBETUEgaW50ZXJydXB0cyhzdWNoIGFzIGlu
IHRoZSBNWDZRKToNCj4gPj4gICAqICAgWzFdIHRoZSBSWCBETUEgYnVmZmVyIGlzIGZ1bGwuDQo+
ID4+IEBAIC0xMTE4LDcgKzExMTYsOCBAQCBzdGF0aWMgdm9pZCBpbXhfdWFydF9kbWFfcnhfY2Fs
bGJhY2sodm9pZA0KPiA+PiAqZGF0YSkgIH0NCj4gPj4NCj4gPj4gIC8qIFJYIERNQSBidWZmZXIg
cGVyaW9kcyAqLw0KPiA+PiAtI2RlZmluZSBSWF9ETUFfUEVSSU9EUyA0DQo+ID4+ICsjZGVmaW5l
IFJYX0RNQV9QRVJJT0RTIDE2DQo+ID4+ICsjZGVmaW5lIFJYX0JVRl9TSVpFICAgIChQQUdFX1NJ
WkUgLyA0KQ0KPiA+Pg0KPiA+IFdoeSB0byBkZWNyZWFzZSB0aGUgRE1BIFJYIGJ1ZmZlciBzaXpl
IGhlcmUgPw0KPiA+DQo+ID4gVGhlIGN1cnJlbnQgRE1BIGltcGxlbWVudGF0aW9uIHN1cHBvcnQg
RE1BIGN5Y2xpYyBtb2RlLCBvbmUgU0RNQSBCRA0KPiA+IHJlY2VpdmUgb25lIEJsdWV0b290aCBm
cmFtZSBjYW4gYnJpbmcgYmV0dGVyIHBlcmZvcm1hbmNlLg0KPiA+IEFzIHlvdSBrbm93LCBmb3Ig
TDJDQVAsIGEgbWF4aW11bSB0cmFuc21pc3Npb24gdW5pdCAoTVRVKSBhc3NvY2lhdGVkDQo+ID4g
d2l0aCB0aGUgbGFyZ2VzdCBCYXNlYmFuZCBwYXlsb2FkIGlzIDM0MSBieXRlcyBmb3IgREg1IHBh
Y2tldHMuDQo+ID4NCj4gPiBTbyBJIHN1Z2dlc3QgdG8gaW5jcmVhc2UgUlhfQlVGX1NJWkUgYWxv
bmcgd2l0aCBSWF9ETUFfUEVSSU9EUyB0bw0KPiBmZWFzaWJsZSB2YWx1ZS4NCj4gDQo+IEkgZGVi
dWdnZWQgYW5kIGRldmVsb3BlZCB0aGlzIHBhdGNoZXMgb24gYSBzeXN0ZW0gd2l0aCBhIDQuMTUg
a2VybmVsLiBXaGVuDQo+IHByZXBhcmVkIGZvciB1cHN0cmVhbSBpIGhhdmUgYWRhcHRlZCBzb21l
IGRldGFpbHMgYW5kIG1pc3NlZCBhIGltcG9ydGFudA0KPiB0aGluZyBoZXJlLiBJdCBzaG91bGQg
c2F5Og0KPiANCj4gKyNkZWZpbmUgUlhfQlVGX1NJWkUgICAgKFJYX0RNQV9QRVJJT0RTICogUEFH
RV9TSVpFIC8gNCkNCj4gDQo+IFllcywgaSB3YW50ZWQgdG8gaW5jcmVhc2UgdGhlIHRvdGFsIGJ1
ZmZlciBzaXplIHRvbywgZXZlbiB3cm90ZSBpdCBpbiB0aGUNCj4gZGVzY3JpcHRpb24uDQo+IEkg
d2lsbCBwcmVwYXJlIGEgdmVyc2lvbiA0LCB0aGFua3MgZm9yIHRoZSBoaW50Lg0KDQpPa2F5LCB0
aGFuayB5b3UgZm9yIHN1Ym1pdCB0aGUgU0RNQS91YXJ0IHBhdGNoIHNldC4NCg0KPiANCj4gSnVz
dCBmb3IgaW5mbzogQSBzaW5nbGUgUlggRE1BIHBlcmlvZCBha2EgYnVmZmVyIGNhbiBiZSBmaWxs
ZWQgd2l0aCBtdXRsaXBsZQ0KPiBwYWNrZXRzIGluIHJlZ2FyZCBvZiB0aGUgdXBwZXIgbGF5ZXIs
IGhlcmUgQlQuDQoNClllcywgdGhhdCBkZXBlbmRzIG9uIHN5c3RlbSBsb2FkaW5nLiANCg0KPiAN
Cj4gDQo+IFJlZ2FyZHMsDQo+IFBoaWxpcHANCj4gPg0KPiA+IEFuZHkNCj4gPg0KPiA+PiAgc3Rh
dGljIGludCBpbXhfdWFydF9zdGFydF9yeF9kbWEoc3RydWN0IGlteF9wb3J0ICpzcG9ydCkgIHsN
Cj4gPj4gLS0NCj4gPj4gMi4yMy4wDQo+ID4NCg==
