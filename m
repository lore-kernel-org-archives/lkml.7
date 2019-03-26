Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE2D7C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 11:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3CF72075D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 11:53:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="mYsjohHj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731445AbfCZLxB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 07:53:01 -0400
Received: from mail-eopbgr140059.outbound.protection.outlook.com ([40.107.14.59]:16563
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725975AbfCZLxB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 07:53:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jZUXJTKhFczrJfqlIZn8QI3KYlEc1j0VRmHl+Xl+EkM=;
 b=mYsjohHjzGe1j/VlX5/p/aSeS9wcQVvAktwzrMd+rQn7r7CfxZ6PURzMI/I3qw4TQMTvdcxWKvn0ZHpDXjvlMQ0I3+y2QHuKQ7j48XXISRFsXs0KymEws8iKXKvNi4E6aLcfXwehwKow5W/yTpFF1E6LWer5HRatUxXn5EsCcak=
Received: from VI1PR04MB5134.eurprd04.prod.outlook.com (20.177.50.159) by
 VI1PR04MB2128.eurprd04.prod.outlook.com (10.166.43.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.18; Tue, 26 Mar 2019 11:52:41 +0000
Received: from VI1PR04MB5134.eurprd04.prod.outlook.com
 ([fe80::80a9:797d:58c0:1295]) by VI1PR04MB5134.eurprd04.prod.outlook.com
 ([fe80::80a9:797d:58c0:1295%3]) with mapi id 15.20.1730.019; Tue, 26 Mar 2019
 11:52:41 +0000
From:   Laurentiu Tudor <laurentiu.tudor@nxp.com>
To:     Steven Price <steven.price@arm.com>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        Ying Zhang <ying.zhang22455@nxp.com>
CC:     "upstream-release@linux.nxdi.nxp.com" 
        <upstream-release@linux.nxdi.nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leo Li <leoyang.li@nxp.com>, dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [RESEND] i2c: imx: defer probing on dma channel request
Thread-Topic: [RESEND] i2c: imx: defer probing on dma channel request
Thread-Index: AQHU4x+p/rwFVSG6cE2tH9IQ48eyYqYclZ+AgAE49QA=
Date:   Tue, 26 Mar 2019 11:52:41 +0000
Message-ID: <7c702cc4-4bb6-02e8-6c2d-1686de503c85@nxp.com>
References: <20190325153016.12626-1-laurentiu.tudor@nxp.com>
 <873b5aeb-e20a-de6b-515e-bc8fcc263452@arm.com>
In-Reply-To: <873b5aeb-e20a-de6b-515e-bc8fcc263452@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=laurentiu.tudor@nxp.com; 
x-originating-ip: [212.146.100.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 67f3f318-2d41-47db-5dab-08d6b1e18d41
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB2128;
x-ms-traffictypediagnostic: VI1PR04MB2128:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <VI1PR04MB212819D7C78D5577B1B60FA7EC5F0@VI1PR04MB2128.eurprd04.prod.outlook.com>
x-forefront-prvs: 09888BC01D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(366004)(376002)(39860400002)(396003)(51914003)(199004)(189003)(66066001)(6246003)(8936002)(6636002)(105586002)(8676002)(44832011)(68736007)(81166006)(7736002)(2501003)(81156014)(305945005)(106356001)(53936002)(36756003)(31686004)(256004)(14444005)(25786009)(71200400001)(71190400001)(99286004)(76176011)(4326008)(102836004)(6506007)(53546011)(186003)(6486002)(6306002)(6512007)(2906002)(3846002)(26005)(6436002)(6116002)(110136005)(54906003)(966005)(446003)(97736004)(478600001)(14454004)(5660300002)(31696002)(316002)(86362001)(486006)(476003)(11346002)(2616005)(229853002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB2128;H:VI1PR04MB5134.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: aIg4BUbKgTDnn9Qri/LAKQhJkwXAyj9bWhotV0lN5lboKXCcFQspXB8KynxHD/9enh5y+zLJwMTVrnTRZk4CnYPkQMCX2573nzwOfoNxJWdm3Q9EHb4A7OKFoq0AY4vivQTgoxQk8C3UG5FYju2I/8GEODL8D8X/SroS8uaESKxZvI0ikMiCXs4FkArmrizo1gdbi145IQwBiEylb0rNpX1PuHI4891La0+XOvsP1BnUa9ny7H/SVkXTdTQJPe2SOP4CcI9xFJNfnaF5B/7iop7FNPhgR2ycgvjnKBJSlWRQbgP51eeX0RbBvAzMEeeI9wWckQJ2oVgmQ8vY+4ryA0rYRTtRfQrBxKf67cA0IMzyX6ZTmp/dl/shBzUyLCjLbub/0d1+30Jr2syxDu80rMxp/z/syVR/ixn+p4fiDYk=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3C8F1440CFA3E043A3530EFD5C69E812@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67f3f318-2d41-47db-5dab-08d6b1e18d41
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2019 11:52:41.4142
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB2128
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgU3RldmUsDQoNClRoYW5rcyBmb3IgdGhlIHJldmlldyEgRmV3IGNvbW1lbnRzIGlubGluZS4N
Cg0KT24gMjUuMDMuMjAxOSAxOToxMiwgU3RldmVuIFByaWNlIHdyb3RlOg0KPiBPbiAyNS8wMy8y
MDE5IDE1OjMwLCBsYXVyZW50aXUudHVkb3JAbnhwLmNvbSB3cm90ZToNCj4+IEZyb206IExhdXJl
bnRpdSBUdWRvciA8bGF1cmVudGl1LnR1ZG9yQG54cC5jb20+DQo+Pg0KPj4gSWYgdGhlIGRtYSBj
b250cm9sbGVyIGlzIG5vdCB5ZXQgcHJvYmVkLCBkZWZlciBpMmMgcHJvYmUuDQo+PiBUaGUgZXJy
b3IgcGF0aCBpbiBwcm9iZSB3YXMgc2xpZ2h0bHkgbW9kaWZpZWQgKG5vIGZ1bmN0aW9uYWwgY2hh
bmdlKQ0KPiANCj4gVGhlcmUgaXMgYSBmdW5jdGlvbmFsIGNoYW5nZSBmb3IgY2FzZXMgbGlrZToN
Cj4gDQo+PiAJcmV0ID0gcG1fcnVudGltZV9nZXRfc3luYygmcGRldi0+ZGV2KTsNCj4+IAlpZiAo
cmV0IDwgMCkNCj4+IAkJZ290byBycG1fZGlzYWJsZTsNCj4gDQo+IC4uLmFzIHJwbV9kaXNhYmxl
IHdpbGwgbm8gbG9uZ2VyIGZhbGwgdGhyb3VnaCB0byB0aGUgY2FsbCBvZg0KPiBjbGtfZGlzYWJs
ZV91bnByZXBhcmUoKS4NCg0KR29vZCBwb2ludCwgSSBtaXNzZWQgdGhhdC4NCg0KPj4gdG8gYXZv
aWQgdHJpZ2dlcmluZyB0aGlzIFdBUk5fT04oKToNCj4+ICJjZy1wbGwwLWRpdjEgYWxyZWFkeSBk
aXNhYmxlZA0KPj4gV0FSTklORzogQ1BVOiAxIFBJRDogMSBhdCBkcml2ZXJzL2Nsay9jbGsuYzo4
MjggY2xrX2NvcmVfZGlzYWJsZSsweGE4LzB4YjAiDQo+IA0KPiBJJ20gYWxzbyBub3Qgc3VyZSBo
b3cgdGhpcyBXQVJOX09OIHdhcyBoaXQuIGkyY19pbXhfcHJvYmUoKSBjYWxscw0KPiBjbGtfcHJl
cGFyZV9lbmFibGUoKSB3aGljaCBzaG91bGQgaW5jcmVtZW50IHRoZSByZWZlcmVuY2UgY291bnQu
IFNvIGl0DQo+IHNob3VsZCBhbHdheXMgYmUgcG9zc2libGUgdG8gZGVjcmVtZW10IHRoZSBlbmFi
bGVfY291bnQuIFdoYXQgYW0gSSBtaXNzaW5nPw0KDQpJIGFtIG5vIGxvbmdlciBhYmxlIHRvIHJl
cGxpY2F0ZSB0aGlzLiBQZXJoYXBzIGluIHRoZSBtZWFuIHRpbWUgY2hhbmdlcyANCmluIHRoZSBj
bGsgY29yZSBmaXhlZCB0aGlzIGNvcm5lciBjYXNlLg0KDQo+PiBTaWduZWQtb2ZmLWJ5OiBMYXVy
ZW50aXUgVHVkb3IgPGxhdXJlbnRpdS50dWRvckBueHAuY29tPg0KPj4gLS0tDQo+PiAgIGRyaXZl
cnMvaTJjL2J1c3Nlcy9pMmMtaW14LmMgfCAyMSArKysrKysrKysrKysrLS0tLS0tLS0NCj4+ICAg
MSBmaWxlIGNoYW5nZWQsIDEzIGluc2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0pDQo+Pg0KPj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvaTJjL2J1c3Nlcy9pMmMtaW14LmMgYi9kcml2ZXJzL2kyYy9i
dXNzZXMvaTJjLWlteC5jDQo+PiBpbmRleCA0MmZlZDQwMTk4YTAuLjRlMzRiMTU3Mjc1NiAxMDA2
NDQNCj4+IC0tLSBhL2RyaXZlcnMvaTJjL2J1c3Nlcy9pMmMtaW14LmMNCj4+ICsrKyBiL2RyaXZl
cnMvaTJjL2J1c3Nlcy9pMmMtaW14LmMNCj4+IEBAIC0xMTExLDcgKzExMTEsOCBAQCBzdGF0aWMg
aW50IGkyY19pbXhfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4+ICAgCQkJ
CXBkZXYtPm5hbWUsIGkyY19pbXgpOw0KPj4gICAJaWYgKHJldCkgew0KPj4gICAJCWRldl9lcnIo
JnBkZXYtPmRldiwgImNhbid0IGNsYWltIGlycSAlZFxuIiwgaXJxKTsNCj4+IC0JCWdvdG8gY2xr
X2Rpc2FibGU7DQo+PiArCQljbGtfZGlzYWJsZV91bnByZXBhcmUoaTJjX2lteC0+Y2xrKTsNCj4+
ICsJCXJldHVybiByZXQ7DQo+PiAgIAl9DQo+PiAgIA0KPj4gICAJLyogSW5pdCBxdWV1ZSAqLw0K
Pj4gQEAgLTExNjEsMTkgKzExNjIsMjUgQEAgc3RhdGljIGludCBpMmNfaW14X3Byb2JlKHN0cnVj
dCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+PiAgIAlwbV9ydW50aW1lX21hcmtfbGFzdF9idXN5
KCZwZGV2LT5kZXYpOw0KPj4gICAJcG1fcnVudGltZV9wdXRfYXV0b3N1c3BlbmQoJnBkZXYtPmRl
dik7DQo+PiAgIA0KPj4gKwkvKiBJbml0IERNQSBjb25maWcgaWYgc3VwcG9ydGVkICovDQo+PiAr
CXJldCA9IGkyY19pbXhfZG1hX3JlcXVlc3QoaTJjX2lteCwgcGh5X2FkZHIpOw0KPj4gKwlpZiAo
cmV0KSB7DQo+PiArCQlpZiAocmV0ICE9IC1FUFJPQkVfREVGRVIpDQo+PiArCQkJZGV2X2luZm8o
JnBkZXYtPmRldiwgImNhbid0IHVzZSBETUEsIHVzaW5nIFBJTyBpbnN0ZWFkLlxuIik7DQo+PiAr
CQllbHNlDQo+PiArCQkJZ290byBkZWxfYWRhcHRlcjsNCj4+ICsJfQ0KPj4gKw0KPiANCj4gVGhp
cyBjYW4gYmUgc2ltcGxpZmllZCBieSByZXZlcnNpbmcgdGhlIGNvbmRpdGlvbjoNCg0KV2VsbCwg
aW4gdGhlIG1lYW4gdGltZSBJIGp1c3QgZm91bmQgb3V0IHRoYXQgdGhpcyBjb21taXQgWzFdIGZp
eGVzIHRoZSANCmlzc3VlIEkgd2FzIHNlZWluZyBzbyBJIHRoaW5rIHRoZSBwYXRjaCBpcyBubyBs
b25nZXIgbmVlZGVkLg0KDQpbMV0gDQpodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGlu
dXgva2VybmVsL2dpdC93c2EvbGludXguZ2l0L2NvbW1pdC8/aD1pMmMvZm9yLW5leHQmaWQ9ZTFh
YjlhNDY4ZTNiMQ0KDQotLS0NCkJlc3QgUmVnYXJkcywgTGF1cmVudGl1
