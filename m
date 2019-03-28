Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E65BFC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 11:21:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A841F2173C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 11:21:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="YzEDfx8M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbfC1LVG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 07:21:06 -0400
Received: from mail-eopbgr10077.outbound.protection.outlook.com ([40.107.1.77]:22435
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725779AbfC1LVG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 07:21:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sRF+Xy0gBL+bjrNiKGapwZTt70xygZ56uIHTOPRDLXw=;
 b=YzEDfx8M0XO4GuWpyM7klOwod/zLkn+v5UNsIlDWk5dhT97YuwsQnvoG9K6o3d+3kvPXs01kw1ObFjNaZjxZgvJxpoN+Jk+9q3L3DjCmWbyuhQuhx9cQezzgbCwb8UM5Y99T7MXUU6MwAnsto9y39J2j6GrpNVD1UE1p6oKsG+A=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.92.158) by
 AM0PR04MB5075.eurprd04.prod.outlook.com (20.176.214.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.15; Thu, 28 Mar 2019 11:21:00 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::4514:91e2:16b7:ee2b]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::4514:91e2:16b7:ee2b%4]) with mapi id 15.20.1750.014; Thu, 28 Mar 2019
 11:21:00 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Marc Zyngier <marc.zyngier@arm.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>
CC:     Fabio Estevam <fabio.estevam@nxp.com>,
        Cosmin Samoila <cosmin.samoila@nxp.com>,
        Robin Gong <yibin.gong@nxp.com>,
        Mircea Pop <mircea.pop@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Robert Chiras <robert.chiras@nxp.com>,
        Anson Huang <anson.huang@nxp.com>, Jun Li <jun.li@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        "robh@kernel.org" <robh@kernel.org>,
        Zening Wang <zening.wang@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        BOUGH CHEN <haibo.chen@nxp.com>,
        Horia Geanta <horia.geanta@nxp.com>,
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
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Peng Fan <peng.fan@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Viorel Suman <viorel.suman@nxp.com>
Subject: RE: [RFC 0/7] cpuidle: Add poking mechanism to support non-IPI wakeup
Thread-Topic: [RFC 0/7] cpuidle: Add poking mechanism to support non-IPI
 wakeup
Thread-Index: AQHU5J/uL6RBBX3AA0GxPKCBIrMc4KYfnrmAgAADs4CAAAJMgIAADy+AgAAUXQCAAR4xkA==
Date:   Thu, 28 Mar 2019 11:21:00 +0000
Message-ID: <AM0PR04MB4211216AA60055524D1F46FC80590@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1553692845-20983-1-git-send-email-abel.vesa@nxp.com>
 <1553701479.2561.38.camel@pengutronix.de>
 <564216aa-1144-71de-e887-00c58f466bf5@arm.com>
 <1553702767.2561.40.camel@pengutronix.de>
 <d31f84030f48f3dad9dd5d144724979543006406.camel@nxp.com>
 <0ac4b527-2f79-4d21-7408-18c87cadb512@arm.com>
In-Reply-To: <0ac4b527-2f79-4d21-7408-18c87cadb512@arm.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cd401811-1435-4d7d-4827-08d6b36f7507
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB5075;
x-ms-traffictypediagnostic: AM0PR04MB5075:
x-microsoft-antispam-prvs: <AM0PR04MB50755445E63BBB5C332906DE80590@AM0PR04MB5075.eurprd04.prod.outlook.com>
x-forefront-prvs: 0990C54589
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(136003)(396003)(366004)(39860400002)(199004)(189003)(106356001)(4326008)(256004)(9686003)(7696005)(14454004)(76176011)(6506007)(102836004)(53546011)(25786009)(14444005)(53936002)(33656002)(5660300002)(26005)(478600001)(11346002)(99286004)(476003)(446003)(6246003)(105586002)(486006)(55016002)(71190400001)(71200400001)(110136005)(44832011)(54906003)(66066001)(186003)(2501003)(8676002)(8936002)(3846002)(81156014)(81166006)(6116002)(316002)(6436002)(93886005)(6636002)(97736004)(68736007)(2906002)(305945005)(52536014)(7736002)(74316002)(7416002)(229853002)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5075;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +S6iJJe1VnMFjbX135VqRqSQoXhTesj9gVX2eOtLLWpY7ND7YqkTjXJ1+OPM3cCqrq4Rc4aiz7gzA1+aGyQs4kkxAO2/kKcFI1DgqzgVcCvec7JHgq7cN5d+Ow5D/n4gJeCT2EaaEg6pQlfKQTPU+6QZvytHynx+94fi/n135bK8ji6UPpGiuHmwgeQTB+LPsJNUvmtDW5GnjksFrhXwqtEgDyH1Bq+xAyhATtK0AZNkl/jHhi8pDvzhcJUO088bIo+7GCS0AabUNIQf9K5N8knM6qrYf8UKJljGRTy1MnhJ89Fb1QfBSyZOzJijXEfXOdkxcIIERbtkzcGHsgsmSqn16HKGlfG2u8s40pH3fq5/feDny6IPRRTYh60KlQBc7lqZIPofcR7CYSfiZcn41Mzv5Wk8AYalH9rCFDuMcts=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd401811-1435-4d7d-4827-08d6b36f7507
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2019 11:21:00.4086
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5075
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBNYXJjIFp5bmdpZXIgW21haWx0bzptYXJjLnp5bmdpZXJAYXJtLmNvbV0NCj4gU2Vu
dDogVGh1cnNkYXksIE1hcmNoIDI4LCAyMDE5IDI6MTMgQU0NCj4gT24gMjcvMDMvMjAxOSAxNzow
MCwgTGVvbmFyZCBDcmVzdGV6IHdyb3RlOg0KPiA+IE9uIFdlZCwgMjAxOS0wMy0yNyBhdCAxNzow
NiArMDEwMCwgTHVjYXMgU3RhY2ggd3JvdGU6DQo+ID4+IEFtIE1pdHR3b2NoLCBkZW4gMjcuMDMu
MjAxOSwgMTU6NTcgKzAwMDAgc2NocmllYiBNYXJjIFp5bmdpZXI6DQo+ID4+PiBPbiAyNy8wMy8y
MDE5IDE1OjQ0LCBMdWNhcyBTdGFjaCB3cm90ZToNCj4gPj4+PiBBbSBNaXR0d29jaCwgZGVuIDI3
LjAzLjIwMTksIDEzOjIxICswMDAwIHNjaHJpZWIgQWJlbCBWZXNhOg0KPiA+Pj4+PiBUaGlzIHdv
cmsgaXMgYSB3b3JrYXJvdW5kIEknbSBsb29raW5nIGludG8gKG1vcmUgYXMgYSBiYWNrZ3JvdW5k
DQo+ID4+Pj4+IHRhc2spIGluIG9yZGVyIHRvIGFkZCBzdXBwb3J0IGZvciBjcHVpZGxlIG9uIGku
TVg4TVEgYmFzZWQgcGxhdGZvcm1zLg0KPiA+Pj4+Pg0KPiA+Pj4+PiBUaGUgbWFpbiBpZGVhIGhl
cmUgaXMgZ2V0dGluZyBhcm91bmQgdGhlIG1pc3NpbmcgR0lDIHdha2VfcmVxdWVzdA0KPiA+Pj4+
PiBzaWduYWwgKGR1ZSB0byBpbnRlZ3JhdGlvbiBkZXNpZ24gaXNzdWUpIGJ5IHdha2luZyB1cCBh
IGVhY2gNCj4gPj4+Pj4gaW5kaXZpZHVhbCBjb3JlIHRocm91Z2ggc29tZSBkZWRpY2F0ZWQgU1cg
cG93ZXItdXAgYml0cyBpbnNpZGUgdGhlDQo+ID4+Pj4+IHBvd2VyIGNvbnRyb2xsZXIgKEdQQykg
cmlnaHQgYmVmb3JlIGV2ZXJ5IElQSSBpcyByZXF1ZXN0ZWQgZm9yIHRoYXQgZWFjaA0KPiBpbmRp
dmlkdWFsIGNvcmUuDQo+ID4+Pj4NCj4gPj4+PiBKdXN0IGEgZ2VuZXJhbCBjb21tZW50LCB3aXRo
b3V0IGdvaW5nIGludG8gdGhlIGRldGFpbHMgb2YgdGhpcyBzZXJpZXM6DQo+ID4+Pj4gdGhpcyBp
c3N1ZSBpcyBub3Qgb25seSBhZmZlY3RpbmcgSVBJcywgYnV0IGFsc28gTVNJcyB0ZXJtaW5hdGVk
IGF0DQo+ID4+Pj4gdGhlIEdJQy4gQ3VycmVudGx5IE1TSXMgYXJlIHRlcm1pbmF0ZWQgYXQgdGhl
IFBDSWUgY29yZSwgYnV0DQo+ID4+Pj4gdGVybWluYXRpbmcgdGhlbSBhdCB0aGUgR0lDIGlzIGNs
ZWFybHkgcHJlZmVyYWJsZSwgYXMgdGhpcyBhbGxvd3MNCj4gPj4+PiBhc3NpZ25pbmcgQ1BVIGFm
ZmluaXR5IHRvIGluZGl2aWR1YWwgTVNJcyBhbmQgbG93ZXJzIElSUSBzZXJ2aWNlIG92ZXJoZWFk
Lg0KPiA+Pj4+DQo+ID4+Pj4gSSdtIG5vdCBzdXJlIHdoYXQgdGhlIGNvbnNlcXVlbmNlcyBhcmUg
Zm9yIHVwc3RyZWFtIExpbnV4IHN1cHBvcnQNCj4gPj4+PiB5ZXQsIGJ1dCB3ZSBzaG91bGQga2Vl
cCBpbiBtaW5kIHRoYXQgaGF2aW5nIGEgd29ya2Fyb3VuZCBmb3IgSVBJcw0KPiA+Pj4+IGlzIG9u
bHkgc29sdmluZyBwYXJ0IG9mIHRoZSBpc3N1ZS4NCj4gPj4+DQo+ID4+PiBJZiB0aGlzIGVycmF0
dW0gaXMgYWZmZWN0aW5nIG1vcmUgdGhhbiBqdXN0IElQSXMsIHRoZW4gaW5kZWVkIEkNCj4gPj4+
IGRvbid0IHNlZSBob3cgdGhpcyBwYXRjaCBzZXJpZXMgc29sdmVzIGFueXRoaW5nLg0KPiA+Pj4N
Cj4gPj4+IEJ1dCB0aGUgZXJyYXR1bSBkb2N1bWVudGF0aW9uIHNlZW1zIHRvIGltcGx5IHRoYXQg
b25seSBTR0lzIGFyZQ0KPiA+Pj4gYWZmZWN0ZWQsIGFuZCBnb2VzIGFzIGZhciBhcyBzdWdnZXN0
aW5nIHRvIHVzZSBhbiBleHRlcm5hbCBpbnRlcnJ1cHQNCj4gPj4+IHdvdWxkIHNvbHZlIGl0LiBI
b3cgY29tZXMgdGhpcyBpcyBub3QgdGhlIGNhc2U/IE9yIGlzIGl0IHRoYXQNCj4gPj4+IGFueXRo
aW5nIGRpcmVjdGx5IHJvdXRlZCB0byBhIHJlZGlzdHJpYnV0b3IgaXMgYWxzbyBhZmZlY3RlZD8g
VGhpcw0KPiA+Pj4gd291bGQgYnJlYWsgTFBJcyAoYW5kIHRodXMgTVNJcykgYW5kIFBQSXMgKHRo
ZSBDUFUgdGltZXIsIGFtb25nIG90aGVycykuDQo+ID4+Pg0KPiA+Pj4gV2hhdCBpcyB0aGUgKmV4
YWN0KiBzdGF0dXMgb2YgdGhpcyB0aGluZz8gSSBoYXZlIHRoZSB1Z2x5IGZlZWxpbmcNCj4gPj4+
IHRoYXQgdGhlIHRydWUgd29ya2Fyb3VuZCBpcyBqdXN0IHRvIGRpc2FibGUgY3B1aWRsZS4NCj4g
Pj4NCj4gPj4gQXMgZmFyIGFzIEkgdW5kZXJzdGFuZCB0aGUgZXJyYXR1bSwgdGhlIGJhc2ljIGlz
c3VlIGlzIHRoYXQgdGhlIEdJQw0KPiA+PiB3YWtlX3JlcXVlc3Qgc2lnbmFscyBhcmUgbm90IGNv
bm5lY3RlZCB0byB0aGUgR1BDICh0aGUgQ1BVL3BlcmlwaGVyYWwNCj4gPj4gcG93ZXIgc2VxdWVu
Y2VyKS4gVGhlIFNQSXMgYXJlIHJvdXRlZCB0aHJvdWdoIHRoZSBHUEMgYW5kIHRodXMgYXJlDQo+
ID4+IHZpc2libGUgYXMgd2FrZXVwIHNvdXJjZXMsIHdoaWNoIGlzIHdoeSB0aGUgd29ya2Fyb3Vu
ZCBvZiB1c2luZyBhbg0KPiA+PiBleHRlcm5hbCBTUEkgYXMgd2FrZXVwIHRyaWdnZXIgZm9yIHRo
ZSBJUEkgd29ya3MuDQo+ID4NCj4gPiBXZSBoYWQgYSBrZXJuZWwgd29ya2Fyb3VuZCBmb3IgSVBJ
cyBpbiBvdXIgaW50ZXJuYWwgdHJlZSBmb3IgYSBsb25nDQo+ID4gdGltZSBhbmQgSSBkb24ndCB0
aGluayB3ZSBkbyBhbnl0aGluZyBzcGVjaWFsIGZvciBQQ0kuIERvZXMgUENJIE1TSQ0KPiA+IHJl
YWxseSBieXBhc3MgdGhlIEdQQyBvbiA4bXE/DQo+IA0KPiBJZiB5b3UgaGF2ZSBhbiBJVFMsIGNl
cnRhaW5seS4gSWYgeW91IGRvbid0LCBpdCBkZXBlbmRzLiBNU0lzIGNhbiBoaXQgdGhlDQo+IGRp
c3RyaWJ1dG9yJ3MgTUJJIHJlZ2lzdGVycyBhbmQgZ2VuZXJhdGUgbm9uLXdpcmVkIFNQSXMsIHdo
aWNoIEkgYXNzdW1lIHdpbGwNCj4gYnlwYXNzIHRoZSBHUEMgYWx0b2dldGhlci4NCj4gDQoNClJp
Y2hhcmQgJiBKYWNreSwNCg0KQ2FuIHlvdSBkb3VibGUgY2hlY2sgaWYgdGhpcyBpc3N1ZSBhZmZl
Y3QgUENJIE1TSSBmdW5jdGlvbj8NCg0KUmVnYXJkcw0KRG9uZyBBaXNoZW5nDQoNCj4gPiBBZGRp
bmcgUmljaGFyZC9KYWNreSwgdGhleSBtaWdodCBrbm93IGFib3V0IHRoaXMuDQo+ID4NCj4gPiBU
aGlzIHNlZW1zIGxpa2Ugc29tZXRoaW5nIG9mIGEgY29ybmVyIGNhc2UgdG8gbWUsIGRvbid0IG1h
bnkgaW14DQo+ID4gYm9hcmRzIHNoaXAgd2l0aG91dCBQQ0k7IGVzcGVjaWFsbHkgZm9yIGxvdy1w
b3dlciBzY2VuYXJpb3M/IElmDQo+ID4gcmVxdWlyZWQgaXQgbWlnaHQgYmUgcmVhc29uYWJsZSB0
byBhZGQgYW4gYWRkaXRpb25hbCB3b3JrYXJvdW5kIHRvDQo+ID4gZGlzYWJsZSBhbGwgY3B1aWRs
ZSBpZiBwY2kgbXNpcyBhcmUgdXNlZC4NCj4gDQo+IEVzdGFibGlzaGluZyBhIGxpbmsgYmV0d2Vl
biBjcHVpZGxlIGFuZCBQQ0kgaW4gdGhlIGtlcm5lbCB3b3VsZCBiZSBwcmV0dHkNCj4gaW52YXNp
dmUsIGFuZCB0aGF0IHdvdWxkIGNvbWUgb24gdG9wIG9mIHdoYXQgdGhpcyBzZXJpZXMgYWxzbyBt
YW5kYXRlcy4NCj4gDQo+IEF0IHRoYXQgbGV2ZWwgb2YgYXBwYXJlbnQgYnJva2VubmVzcywgaXQg
aXMgZmFyIHNhZmVyIHRvIGdldCBjcHVpZGxlIG91dCBvZiB0aGUNCj4gcGljdHVyZSBhbHRvZ2V0
aGVyLCBhbmQgSSdkIHJhdGhlciBzZWUgdGhlc2UgcGF0Y2hlcyBpbiBhIHZlbmRvciB0cmVlIChm
b3Igb25jZSkuDQo+IA0KPiBUaGFua3MsDQo+IA0KPiAJTS4NCj4gLS0NCj4gSmF6eiBpcyBub3Qg
ZGVhZC4gSXQganVzdCBzbWVsbHMgZnVubnkuLi4NCg==
