Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C321C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 17:00:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32F3F206C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 17:00:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="oK/DuX2W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727937AbfC0RAe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 13:00:34 -0400
Received: from mail-eopbgr140080.outbound.protection.outlook.com ([40.107.14.80]:41991
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727172AbfC0RAe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 13:00:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WpIOEMkbHWcZyOoTO5CvlvLyXVEsnmcK+8fDQMWue8Q=;
 b=oK/DuX2WwIVaoWGtsZXn5Zy7BY+yy0/7d9tAydX9Px3P/A7sFNergNgTzwPhX2HC+Gd2fOHf6dUCBT5idZIWb4VsDsR92vvO9BRve5goo3QLPrv/uDmBTlp00wQdTluJfDfROMQ4eLpitdaMFtIMkPU8bvx6SMzTP/rsLAvEtWc=
Received: from VI1PR04MB5533.eurprd04.prod.outlook.com (20.178.122.159) by
 VI1PR04MB4845.eurprd04.prod.outlook.com (20.177.49.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.15; Wed, 27 Mar 2019 17:00:28 +0000
Received: from VI1PR04MB5533.eurprd04.prod.outlook.com
 ([fe80::35aa:e13a:52ea:e5e6]) by VI1PR04MB5533.eurprd04.prod.outlook.com
 ([fe80::35aa:e13a:52ea:e5e6%4]) with mapi id 15.20.1730.019; Wed, 27 Mar 2019
 17:00:28 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        Richard Zhu <hongxing.zhu@nxp.com>
CC:     Fabio Estevam <fabio.estevam@nxp.com>,
        Cosmin Samoila <cosmin.samoila@nxp.com>,
        Robin Gong <yibin.gong@nxp.com>,
        Mircea Pop <mircea.pop@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Robert Chiras <robert.chiras@nxp.com>,
        Anson Huang <anson.huang@nxp.com>, Jun Li <jun.li@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        "robh@kernel.org" <robh@kernel.org>,
        Zening Wang <zening.wang@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        BOUGH CHEN <haibo.chen@nxp.com>,
        Horia Geanta <horia.geanta@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Peter Chen <peter.chen@nxp.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        Leo Zhang <leo.zhang@nxp.com>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>,
        Han Xu <han.xu@nxp.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        Iuliana Prodan <iuliana.prodan@nxp.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        Jacky Bai <ping.bai@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Peng Fan <peng.fan@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Viorel Suman <viorel.suman@nxp.com>
Subject: Re: [RFC 0/7] cpuidle: Add poking mechanism to support non-IPI wakeup
Thread-Topic: [RFC 0/7] cpuidle: Add poking mechanism to support non-IPI
 wakeup
Thread-Index: AQHU5J/uL6RBBX3AA0GxPKCBIrMc4KYfnrmAgAADs4CAAAJMgIAADy+A
Date:   Wed, 27 Mar 2019 17:00:28 +0000
Message-ID: <d31f84030f48f3dad9dd5d144724979543006406.camel@nxp.com>
References: <1553692845-20983-1-git-send-email-abel.vesa@nxp.com>
         <1553701479.2561.38.camel@pengutronix.de>
         <564216aa-1144-71de-e887-00c58f466bf5@arm.com>
         <1553702767.2561.40.camel@pengutronix.de>
In-Reply-To: <1553702767.2561.40.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [212.146.100.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4a664d03-5d5c-44ce-702b-08d6b2d5b70c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4845;
x-ms-traffictypediagnostic: VI1PR04MB4845:
x-microsoft-antispam-prvs: <VI1PR04MB48451AC41479E00F55866CC1EE580@VI1PR04MB4845.eurprd04.prod.outlook.com>
x-forefront-prvs: 0989A7979C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(366004)(346002)(396003)(136003)(199004)(189003)(44832011)(81156014)(5660300002)(476003)(186003)(2616005)(81166006)(25786009)(71190400001)(71200400001)(446003)(478600001)(6436002)(7416002)(86362001)(14454004)(36756003)(93886005)(486006)(4326008)(8676002)(76176011)(26005)(11346002)(8936002)(53546011)(102836004)(256004)(97736004)(14444005)(66066001)(6512007)(229853002)(6506007)(110136005)(6486002)(6116002)(3846002)(54906003)(68736007)(53936002)(7736002)(2906002)(118296001)(2501003)(305945005)(6636002)(106356001)(316002)(99286004)(105586002)(6246003)(50226002)(99106002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4845;H:VI1PR04MB5533.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /xgtGbZDrhLZjXWJh28Az1YUrcZdnYR9fY64Y12nacgd2xF0+418brgXPQKw438GB60MBR+n7ZzbxgSJTSab9/LIC6WnzH8Z0PNCXL8fpcXo/zKkvwsThFTucvGFu6m+38BWi0PJh/7uxEgiYkx/6qIOwVvimJgMFj66ABphxkkjYkPpLwMCxMGXOpZu65idRNKGVZK7Rsg4pnYA0BrCAQz8bMYpATGv5CfW77eEzRo82/PWa59AA6RJkuEU6+pgfN+QhER4ylH8gE9pLXRuTiZkcNODC7yDxBcMgUT0PNk/7J+3o+XEC1/HC6w0y0xYGiuAmk6gKlSldLfqm7c/TA9vQK5dUaRit59zFb+lUqUcJSvve5PsLJCviFop5bGAJwxuOXh6u/WthwqHshbX/l5rlofhdbreQ/NCRlcGfz4=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EA7658F140F4CE4784042BA68E59627F@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a664d03-5d5c-44ce-702b-08d6b2d5b70c
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2019 17:00:28.6916
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4845
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDE5LTAzLTI3IGF0IDE3OjA2ICswMTAwLCBMdWNhcyBTdGFjaCB3cm90ZToNCj4g
QW0gTWl0dHdvY2gsIGRlbiAyNy4wMy4yMDE5LCAxNTo1NyArMDAwMCBzY2hyaWViIE1hcmMgWnlu
Z2llcjoNCj4gPiBPbiAyNy8wMy8yMDE5IDE1OjQ0LCBMdWNhcyBTdGFjaCB3cm90ZToNCj4gPiA+
IEFtIE1pdHR3b2NoLCBkZW4gMjcuMDMuMjAxOSwgMTM6MjEgKzAwMDAgc2NocmllYiBBYmVsIFZl
c2E6DQo+ID4gPiA+IFRoaXMgd29yayBpcyBhIHdvcmthcm91bmQgSSdtIGxvb2tpbmcgaW50byAo
bW9yZSBhcyBhIGJhY2tncm91bmQgdGFzaykNCj4gPiA+ID4gaW4gb3JkZXIgdG8gYWRkIHN1cHBv
cnQgZm9yIGNwdWlkbGUgb24gaS5NWDhNUSBiYXNlZCBwbGF0Zm9ybXMuDQo+ID4gPiA+IA0KPiA+
ID4gPiBUaGUgbWFpbiBpZGVhIGhlcmUgaXMgZ2V0dGluZyBhcm91bmQgdGhlIG1pc3NpbmcgR0lD
IHdha2VfcmVxdWVzdCBzaWduYWwNCj4gPiA+ID4gKGR1ZSB0byBpbnRlZ3JhdGlvbiBkZXNpZ24g
aXNzdWUpIGJ5IHdha2luZyB1cCBhIGVhY2ggaW5kaXZpZHVhbCBjb3JlIHRocm91Z2gNCj4gPiA+
ID4gc29tZSBkZWRpY2F0ZWQgU1cgcG93ZXItdXAgYml0cyBpbnNpZGUgdGhlIHBvd2VyIGNvbnRy
b2xsZXIgKEdQQykgcmlnaHQgYmVmb3JlDQo+ID4gPiA+IGV2ZXJ5IElQSSBpcyByZXF1ZXN0ZWQg
Zm9yIHRoYXQgZWFjaCBpbmRpdmlkdWFsIGNvcmUuDQo+ID4gPiANCj4gPiA+IEp1c3QgYSBnZW5l
cmFsIGNvbW1lbnQsIHdpdGhvdXQgZ29pbmcgaW50byB0aGUgZGV0YWlscyBvZiB0aGlzIHNlcmll
czoNCj4gPiA+IHRoaXMgaXNzdWUgaXMgbm90IG9ubHkgYWZmZWN0aW5nIElQSXMsIGJ1dCBhbHNv
IE1TSXMgdGVybWluYXRlZCBhdCB0aGUNCj4gPiA+IEdJQy4gQ3VycmVudGx5IE1TSXMgYXJlIHRl
cm1pbmF0ZWQgYXQgdGhlIFBDSWUgY29yZSwgYnV0IHRlcm1pbmF0aW5nDQo+ID4gPiB0aGVtIGF0
IHRoZSBHSUMgaXMgY2xlYXJseSBwcmVmZXJhYmxlLCBhcyB0aGlzIGFsbG93cyBhc3NpZ25pbmcg
Q1BVDQo+ID4gPiBhZmZpbml0eSB0byBpbmRpdmlkdWFsIE1TSXMgYW5kIGxvd2VycyBJUlEgc2Vy
dmljZSBvdmVyaGVhZC4NCj4gPiA+IA0KPiA+ID4gSSdtIG5vdCBzdXJlIHdoYXQgdGhlIGNvbnNl
cXVlbmNlcyBhcmUgZm9yIHVwc3RyZWFtIExpbnV4IHN1cHBvcnQgeWV0LA0KPiA+ID4gYnV0IHdl
IHNob3VsZCBrZWVwIGluIG1pbmQgdGhhdCBoYXZpbmcgYSB3b3JrYXJvdW5kIGZvciBJUElzIGlz
IG9ubHkNCj4gPiA+IHNvbHZpbmcgcGFydCBvZiB0aGUgaXNzdWUuDQo+ID4gDQo+ID4gSWYgdGhp
cyBlcnJhdHVtIGlzIGFmZmVjdGluZyBtb3JlIHRoYW4ganVzdCBJUElzLCB0aGVuIGluZGVlZCBJ
IGRvbid0DQo+ID4gc2VlIGhvdyB0aGlzIHBhdGNoIHNlcmllcyBzb2x2ZXMgYW55dGhpbmcuDQo+
ID4gDQo+ID4gQnV0IHRoZSBlcnJhdHVtIGRvY3VtZW50YXRpb24gc2VlbXMgdG8gaW1wbHkgdGhh
dCBvbmx5IFNHSXMgYXJlDQo+ID4gYWZmZWN0ZWQsIGFuZCBnb2VzIGFzIGZhciBhcyBzdWdnZXN0
aW5nIHRvIHVzZSBhbiBleHRlcm5hbCBpbnRlcnJ1cHQNCj4gPiB3b3VsZCBzb2x2ZSBpdC4gSG93
IGNvbWVzIHRoaXMgaXMgbm90IHRoZSBjYXNlPyBPciBpcyBpdCB0aGF0IGFueXRoaW5nDQo+ID4g
ZGlyZWN0bHkgcm91dGVkIHRvIGEgcmVkaXN0cmlidXRvciBpcyBhbHNvIGFmZmVjdGVkPyBUaGlz
IHdvdWxkIGJyZWFrDQo+ID4gTFBJcyAoYW5kIHRodXMgTVNJcykgYW5kIFBQSXMgKHRoZSBDUFUg
dGltZXIsIGFtb25nIG90aGVycykuDQo+ID4gDQo+ID4gV2hhdCBpcyB0aGUgKmV4YWN0KiBzdGF0
dXMgb2YgdGhpcyB0aGluZz8gSSBoYXZlIHRoZSB1Z2x5IGZlZWxpbmcgdGhhdA0KPiA+IHRoZSB0
cnVlIHdvcmthcm91bmQgaXMganVzdCB0byBkaXNhYmxlIGNwdWlkbGUuDQo+IA0KPiBBcyBmYXIg
YXMgSSB1bmRlcnN0YW5kIHRoZSBlcnJhdHVtLCB0aGUgYmFzaWMgaXNzdWUgaXMgdGhhdCB0aGUg
R0lDDQo+IHdha2VfcmVxdWVzdCBzaWduYWxzIGFyZSBub3QgY29ubmVjdGVkIHRvIHRoZSBHUEMg
KHRoZSBDUFUvcGVyaXBoZXJhbA0KPiBwb3dlciBzZXF1ZW5jZXIpLiBUaGUgU1BJcyBhcmUgcm91
dGVkIHRocm91Z2ggdGhlIEdQQyBhbmQgdGh1cyBhcmUNCj4gdmlzaWJsZSBhcyB3YWtldXAgc291
cmNlcywgd2hpY2ggaXMgd2h5IHRoZSB3b3JrYXJvdW5kIG9mIHVzaW5nIGFuDQo+IGV4dGVybmFs
IFNQSSBhcyB3YWtldXAgdHJpZ2dlciBmb3IgdGhlIElQSSB3b3Jrcy4NCg0KV2UgaGFkIGEga2Vy
bmVsIHdvcmthcm91bmQgZm9yIElQSXMgaW4gb3VyIGludGVybmFsIHRyZWUgZm9yIGEgbG9uZw0K
dGltZSBhbmQgSSBkb24ndCB0aGluayB3ZSBkbyBhbnl0aGluZyBzcGVjaWFsIGZvciBQQ0kuIERv
ZXMgUENJIE1TSQ0KcmVhbGx5IGJ5cGFzcyB0aGUgR1BDIG9uIDhtcT8NCg0KQWRkaW5nIFJpY2hh
cmQvSmFja3ksIHRoZXkgbWlnaHQga25vdyBhYm91dCB0aGlzLg0KDQpUaGlzIHNlZW1zIGxpa2Ug
c29tZXRoaW5nIG9mIGEgY29ybmVyIGNhc2UgdG8gbWUsIGRvbid0IG1hbnkgaW14IGJvYXJkcw0K
c2hpcCB3aXRob3V0IFBDSTsgZXNwZWNpYWxseSBmb3IgbG93LXBvd2VyIHNjZW5hcmlvcz8gSWYg
cmVxdWlyZWQgaXQNCm1pZ2h0IGJlIHJlYXNvbmFibGUgdG8gYWRkIGFuIGFkZGl0aW9uYWwgd29y
a2Fyb3VuZCB0byBkaXNhYmxlIGFsbA0KY3B1aWRsZSBpZiBwY2kgbXNpcyBhcmUgdXNlZC4NCg0K
LS0NClJlZ2FyZHMsDQpMZW9uYXJkDQo=
