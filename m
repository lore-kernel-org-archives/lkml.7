Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 637ADC4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 00:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32B1E222CB
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 00:35:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="hqW13Fak"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389237AbfIZAfF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 20:35:05 -0400
Received: from mail-eopbgr150052.outbound.protection.outlook.com ([40.107.15.52]:56034
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389070AbfIZAfD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 20:35:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G4kEelbW/ZGGXyhN3APElIbZVe3rW4auFxtXGeA01Ui82D3d9n/33OizDfwc3E6M2sCfK2uCNu+cZRjyZmRty7NG+qpvVd/HLkOaAnu8HtIJCyAAqMZGeZ1lRPjknRIYCgMpNqnzU4ZeTBnUoPthRM049TCjzKI91WjPJw4UbFOSBouXGfpCRAMdF3CZXn4Gp3GHtC5nCNsrozrpjFjtIZJDLqs4MBE+7dkah6Aa5KPbsY7L5Q011BHcixQnmfL6pKc/3oVqCnq9w65B+IGaxgJb21R8yIGPorPyGonadPU/x4CCyfvY/djaU/11SJOnE0x0vl7Kea0RNoRpsD/GLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yWM+pGzWk+tdXhbVO/nMawLljwi+CaqOh7QRT8bxLrQ=;
 b=GOcM86D9Kf3TSON+zwhsS1y5N2JVUU5dPZz9d3EyOLbAlzHhDCwRcv1pd/Udlw4se45d5bqYbB5iQeVe4ZWSNzp/tf9tZdsVMIRVdsrhMnSn2qos6tZz2dWxUXuSyd2MOwCql1lk9CXaIdDhK6SapQkDGYrU9Vg1tmJ3Jz+0VniCdlz91cbI8/1hPzgAIooWTGqd/Vhu3LDoDyCvjBcGLTTE99e8QD+JSk1+QVDi4E1Dogdc5HieGJUBUYXVxsXqbAB0okByw6tacVnLNs1/i1QXutsp0/yVHEVcxn0tbF1iiyPhRUoAx2Sw6nKgOFxwzTtJFvyatcW4MBRGYKL9Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yWM+pGzWk+tdXhbVO/nMawLljwi+CaqOh7QRT8bxLrQ=;
 b=hqW13FakOrgZKzOsc7f6yaQp//Fszr+ksQAhSSgsMUUWiIUG7bP/b+X4mrFZ5rJnRxAf5IkbFhk3XTf0+6Nv2o2jSS+qH/UYajro6jfm9ftGi1HZIzea1H/wZ1liL4+KaRwDBg5ZF38k7fFrAJLvF65/UD5VJ5+xf4Dee5DRgxA=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3755.eurprd04.prod.outlook.com (52.134.71.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.22; Thu, 26 Sep 2019 00:34:59 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::8958:299c:bc54:2a38]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::8958:299c:bc54:2a38%7]) with mapi id 15.20.2284.028; Thu, 26 Sep 2019
 00:34:59 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>
CC:     "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] firmware: imx: Skip return value check for some special
 SCU firmware APIs
Thread-Topic: [PATCH] firmware: imx: Skip return value check for some special
 SCU firmware APIs
Thread-Index: AQHVc4lT/ErvPybCJUCbZ2x7mLGjsqc9G1eA
Date:   Thu, 26 Sep 2019 00:34:58 +0000
Message-ID: <DB3PR0402MB391628462C06E3BD28E1AC60F5860@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1569406066-16626-1-git-send-email-Anson.Huang@nxp.com>
 <VI1PR04MB70232DEA67972332611480CAEE870@VI1PR04MB7023.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB70232DEA67972332611480CAEE870@VI1PR04MB7023.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 37e6867d-1993-4bf2-d030-08d742195c8f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3755;
x-ms-traffictypediagnostic: DB3PR0402MB3755:|DB3PR0402MB3755:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB3755178641650E2BD5CA778DF5860@DB3PR0402MB3755.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0172F0EF77
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(39860400002)(376002)(346002)(396003)(136003)(189003)(199004)(6636002)(8936002)(55016002)(229853002)(66446008)(66946007)(86362001)(6306002)(66476007)(64756008)(256004)(74316002)(110136005)(7736002)(66066001)(25786009)(9686003)(6436002)(305945005)(76116006)(66556008)(316002)(44832011)(2906002)(2501003)(71190400001)(54906003)(6246003)(71200400001)(4326008)(5660300002)(14454004)(476003)(33656002)(8676002)(478600001)(3846002)(102836004)(6116002)(186003)(76176011)(966005)(7696005)(446003)(52536014)(11346002)(81166006)(81156014)(99286004)(53546011)(26005)(45080400002)(486006)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3755;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: bDgfMDRRSDfy4Pi1JJmgRewGAYelfYC6skqS8xu4N1veLcqqILXs+AiZWyhrZLwVgDJMQYNfLKcY9PHccA9IUEwXct5gEeIBQajBS8VlHASv/ZLtfD1wJvT7muBRXHxOavbBpswz6ZoZB2JK6PqTfaAQBEuA4xQuTflUlTqzJuISczazeXXAaTl7YYCFFAAfHidzm4jyy95HJ6E0EWRK5p7qnDit+GIXQx2tR2TjV6wp0UORMs3p2TesLApD2k1r1NeRU73ly420MUDUHHNJ4yWyd8msYAVhUGaFmfxQtiV3479TLPIFV44SIC7cTB5HnqHCXF2PaQ9kT6D3IeFQUGcPdyUOQCeTZJaohJUNJSigyw5pMXQo73mdnD7po77bwd9CAyEkyCEN8OhsLclcyW9Z27TlNn6zWfn4o4XRcVU=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37e6867d-1993-4bf2-d030-08d742195c8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2019 00:34:58.8860
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GvV7RK4dJmOJRtTIh1ZNAj970sicNvxO1llzrfcIepcy0aM9COjwWunT8S/xzdAfdbi2P4rqlcJ0olNYa1peIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3755
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIExlb25hcmQNCg0KPiBPbiAyNS4wOS4yMDE5IDEzOjA5LCBBbnNvbiBIdWFuZyB3cm90ZToN
Cj4gPiBUaGUgU0NVIGZpcm13YXJlIGRvZXMgTk9UIGFsd2F5cyBoYXZlIHJldHVybiB2YWx1ZSBz
dG9yZWQgaW4gbWVzc2FnZQ0KPiA+IGhlYWRlcidzIGZ1bmN0aW9uIGVsZW1lbnQgZXZlbiB0aGUg
QVBJIGhhcyByZXNwb25zZSBkYXRhLCB0aG9zZQ0KPiA+IHNwZWNpYWwgQVBJcyBhcmUgZGVmaW5l
ZCBhcyB2b2lkIGZ1bmN0aW9uIGluIFNDVSBmaXJtd2FyZSwgc28gdGhleQ0KPiA+IHNob3VsZCBi
ZSB0cmVhdGVkIGFzIHJldHVybiBzdWNjZXNzIGFsd2F5cy4NCj4gPg0KPiA+IFNpZ25lZC1vZmYt
Ynk6IEFuc29uIEh1YW5nIDxBbnNvbi5IdWFuZ0BueHAuY29tPg0KPiA+IC0tLQ0KPiA+IAktIFRo
aXMgcGF0Y2ggaXMgYmFzZWQgb24gdGhlIHBhdGNoIG9mDQo+ID4gaHR0cHM6Ly9ldXIwMS5zYWZl
bGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGcGF0Yw0KPiA+
DQo+IGh3b3JrLmtlcm5lbC5vcmclMkZwYXRjaCUyRjExMTI5NTUzJTJGJmFtcDtkYXRhPTAyJTdD
MDElN0NsZW9uYXINCj4gZC5jcmVzDQo+ID4NCj4gdGV6JTQwbnhwLmNvbSU3Q2MwY2VkNmNkMDdm
MDQwMjM5NzcwMDhkNzQxYTA3MzY3JTdDNjg2ZWExZDNiYzJiDQo+IDRjNmZhOTINCj4gPg0KPiBj
ZDk5YzVjMzAxNjM1JTdDMCU3QzAlN0M2MzcwNTAwMjk3MTIyMTY0NzImYW1wO3NkYXRhPUNjcSUy
RmIyUg0KPiBKZE1xbW5MNw0KPiA+IFZYcmw4WWhPbFV3QzdiV2lVRyUyQk5taXc0T3NTTSUzRCZh
bXA7cmVzZXJ2ZWQ9MA0KPiA+IC0tLQ0KPiA+ICAgZHJpdmVycy9maXJtd2FyZS9pbXgvaW14LXNj
dS5jIHwgMzQNCj4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLQ0KPiA+ICAgMSBm
aWxlIGNoYW5nZWQsIDMyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9maXJtd2FyZS9pbXgvaW14LXNjdS5jDQo+ID4gYi9kcml2ZXJz
L2Zpcm13YXJlL2lteC9pbXgtc2N1LmMgaW5kZXggODY5YmU3YS4uY2VkNWIxMiAxMDA2NDQNCj4g
PiAtLS0gYS9kcml2ZXJzL2Zpcm13YXJlL2lteC9pbXgtc2N1LmMNCj4gPiArKysgYi9kcml2ZXJz
L2Zpcm13YXJlL2lteC9pbXgtc2N1LmMNCj4gPiBAQCAtNzgsNiArNzgsMTEgQEAgc3RhdGljIGlu
dCBpbXhfc2NfbGludXhfZXJybWFwW0lNWF9TQ19FUlJfTEFTVF0gPQ0KPiB7DQo+ID4gICAJLUVJ
TywJIC8qIElNWF9TQ19FUlJfRkFJTCAqLw0KPiA+ICAgfTsNCj4gPg0KPiA+ICtzdGF0aWMgY29u
c3Qgc3RydWN0IGlteF9zY19ycGNfbXNnIHdoaXRlbGlzdFtdID0gew0KPiA+ICsJeyAuc3ZjID0g
SU1YX1NDX1JQQ19TVkNfTUlTQywgLmZ1bmMgPQ0KPiBJTVhfU0NfTUlTQ19GVU5DX1VOSVFVRV9J
RCB9LA0KPiA+ICsJeyAuc3ZjID0gSU1YX1NDX1JQQ19TVkNfTUlTQywgLmZ1bmMgPQ0KPiA+ICtJ
TVhfU0NfTUlTQ19GVU5DX0dFVF9CVVRUT05fU1RBVFVTIH0sIH07DQo+IA0KPiBVbnRpbCBub3cg
dGhpcyBsb3cgbGV2ZWwgSVBDIGNvZGUgZGlkbid0IHRyZWF0IGFueSBzdmMvZnVuYyBzcGVjaWFs
bHkgYW5kIHRoaXMNCj4gc2VlbXMgZ29vZC4NCj4gDQo+IFRoZSBpbXhfc2N1X2NhbGxfcnBjIGZ1
bmN0aW9uIGFscmVhZHkgaGFzIGFuIGhhdmVfcmVzcCBhcmd1bWVudCBhbmQNCj4gY2FsbGVycyBh
cmUgcmVzcG9uc2libGUgdG8gZmlsbCBpdC4gQ2FuJ3Qgd2UgZGVhbCB3aXRoIHRoaXMgYnkgYWRk
aW5nIGFuDQo+IGFkZGl0aW9uYWwgZXJyX3JldCBmbGFnIHBhc3NlZCBieSB0aGUgY2FsbGVyPw0K
DQpDYW4geW91IG1ha2UgaXQgbW9yZSBkZXRhaWw/IFRoZSBoYXZlX3Jlc3AgaXMgYSBib29sLCBz
byB3aGVyZSB0byBhZGQgdGhlIGZsYWc/DQpUaGUgY2FsbGVyIE9OTFkgcGFzc2VzIGlteF9zY19p
cGMsIGlteF9zY19ycGNfbXNnIGFuZCBoYXZlX3Jlc3AsIE9OTFkNCmlteF9zY19pcGMgY2FuIGFk
ZCBhIGZsYWcsIGlzIGl0IHdoYXQgeW91IG1lYW50PyANCg0KaW14X3NjdV9jYWxsX3JwYyhzdHJ1
Y3QgaW14X3NjX2lwYyAqc2NfaXBjLCB2b2lkICptc2csIGJvb2wgaGF2ZV9yZXNwKQ0KDQo+IA0K
PiBXZSBjYW4gYWRkIHdyYXBwZXIgZnVuY3Rpb25zIHRvIGF2b2lkIHRyZWUtd2lkZSBjaGFuZ2Vz
IGZvciBhbGwgY2FsbGVycy4NCg0KSSBhZ3JlZSwgbWF5YmUgd2UgY2FuIGFkZCBhIG5ldyBpbXhf
c2N1X2NhbGxfcnBjIGZ1bmN0aW9uIGZvciB0aG9zZSBzcGVjaWFsIEFQSXM/DQpUaGUgbmV3IEFQ
SSB3aWxsIGJlIE9OTFkgZm9yIHRob3NlIEFQSXMgd2l0aCByZXNwb25zZSBidXQgd2l0aG91dCBy
ZXR1cm4gdmFsdWUgY2hlY2ssDQp0aGVuIG90aGVyIGNhbGxlcnMgd2lsbCBOT1QgYmUgaW1wYWN0
ZWQsIHdoYXQgZG8geW91IHRoaW5rPw0KDQpUaGFua3MsDQpBbnNvbg0KDQo=
