Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D011FC07542
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 06:29:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9520B2070D
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 06:29:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="rlXuPW/5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbfE0G3R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 02:29:17 -0400
Received: from mail-eopbgr20062.outbound.protection.outlook.com ([40.107.2.62]:52003
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726326AbfE0G3R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 02:29:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rFtLYzbCbSm//VSTccVakGpmfXw3GfWHxoL0uxG0NsU=;
 b=rlXuPW/5zGEjaURCWbKFWh7126BRye+2OHMpSjPvulR8XbJwfnyUmTq1wOUETKTOO6tfCbrmBWFrV1fffn7OH6R22XQykZgWLzOjmo/i9V4OBbOTJ9nnd8np3XqmyLkZBoQy53EaQnXHc0ps7zDJCrgEQT6W6JQINRbFTHaAEyY=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB4402.eurprd04.prod.outlook.com (52.135.148.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.18; Mon, 27 May 2019 06:29:11 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::3173:24:d401:2378]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::3173:24:d401:2378%6]) with mapi id 15.20.1922.021; Mon, 27 May 2019
 06:29:11 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     =?utf-8?B?QW5kcsOpIFByenl3YXJh?= <andre.przywara@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "van.freenix@gmail.com" <van.freenix@gmail.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH 0/2] mailbox: arm: introduce smc triggered mailbox
Thread-Topic: [PATCH 0/2] mailbox: arm: introduce smc triggered mailbox
Thread-Index: AQHVESt7O8zUR8j7k0mzGFqyu7YBg6Z4+DAAgAGZogCAA4nsgIAAa+GA
Date:   Mon, 27 May 2019 06:29:11 +0000
Message-ID: <AM0PR04MB4481665E2C99DEE66CCB2CA8881D0@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <20190523060437.11059-1-peng.fan@nxp.com>
 <4ba2b243-5622-bb27-6fc3-cd9457430e54@gmail.com>
 <20190524175658.GA5045@e107155-lin>
 <d0800650-b79b-4698-3a3e-60e83c85f2d1@arm.com>
In-Reply-To: <d0800650-b79b-4698-3a3e-60e83c85f2d1@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 83e38b07-fa5d-4f7b-b88e-08d6e26ca1d8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB4402;
x-ms-traffictypediagnostic: AM0PR04MB4402:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <AM0PR04MB4402BB7023CB4AE3701B5618881D0@AM0PR04MB4402.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0050CEFE70
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(366004)(136003)(39860400002)(346002)(199004)(189003)(81166006)(186003)(6436002)(81156014)(316002)(26005)(476003)(446003)(74316002)(486006)(8676002)(11346002)(256004)(229853002)(14444005)(86362001)(7736002)(102836004)(6116002)(3846002)(6306002)(44832011)(305945005)(6506007)(53546011)(9686003)(99286004)(7696005)(55016002)(2906002)(76176011)(76116006)(66556008)(64756008)(66476007)(66446008)(6246003)(110136005)(54906003)(45080400002)(66946007)(73956011)(7416002)(25786009)(478600001)(5660300002)(66066001)(14454004)(4326008)(52536014)(68736007)(53936002)(33656002)(71200400001)(71190400001)(15650500001)(8936002)(966005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4402;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: uzDUTkb9D8wAFTUGNkuxaPp9WJNhiq1sSlUMtUe7O4/vQ3AcNnppf22UIA54m/nPNub72jKBx0JWbYKNFzyHgeooqoX93aPY/AJ2wuqBVHcoDVq/ggOCS+wH0Vcqy31rN90NOLzm0lPx11gktk5LWGo10HPTYOqqT2xOTNLildjSlFfgF3o3daqwPlumuYYrcNm+2bpgO4cWUTHalE6lIX3MbTJTh0PZFfC5aRy/phjNIrXBW7aGAC5o5k5d8R3ebOTBBKQkFIzcRYzIpFDaaEcq0sZE+tCmIqFJhjacPviYvWDCk8Jda9fOfhALFE1riy2H+dxhKbsyGzYna6+hmFunkN0823a8Ybi76ligi8DomPqCkMRj3GyuocbAnBw0eZKjPSV0lzB427dAfnq3eBCQ/zDezQExFB18Nlq1wEg=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83e38b07-fa5d-4f7b-b88e-08d6e26ca1d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2019 06:29:11.7494
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: peng.fan@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4402
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5kcmUsDQoNCj4gU3ViamVjdDogUmU6IFtQQVRDSCAwLzJdIG1haWxib3g6IGFybTogaW50
cm9kdWNlIHNtYyB0cmlnZ2VyZWQgbWFpbGJveA0KPiANCj4gT24gMjQvMDUvMjAxOSAxODo1Niwg
U3VkZWVwIEhvbGxhIHdyb3RlOg0KPiA+IE9uIFRodSwgTWF5IDIzLCAyMDE5IGF0IDEwOjMwOjUw
QU0gLTA3MDAsIEZsb3JpYW4gRmFpbmVsbGkgd3JvdGU6DQo+IA0KPiBIaSwNCj4gDQo+ID4+IE9u
IDUvMjIvMTkgMTA6NTAgUE0sIFBlbmcgRmFuIHdyb3RlOg0KPiA+Pj4gVGhpcyBpcyBhIG1vZGlm
aWVkIHZlcnNpb24gZnJvbSBBbmRyZSBQcnp5d2FyYSdzIHBhdGNoIHNlcmllcw0KPiA+Pj4NCj4g
aHR0cHM6Ly9ldXIwMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBz
JTNBJTJGJTJGbG9yZS5rZQ0KPiBybmVsLm9yZyUyRnBhdGNod29yayUyRmNvdmVyJTJGODEyOTk3
JTJGJmFtcDtkYXRhPTAyJTdDMDElN0NwZQ0KPiBuZy5mYW4lNDBueHAuY29tJTdDMDJlZTk0ODcz
NzBjNGViOTE1ODAwOGQ2ZTIzNjNjYTAlN0M2ODZlYTFkMw0KPiBiYzJiNGM2ZmE5MmNkOTljNWMz
MDE2MzUlN0MwJTdDMCU3QzYzNjk0NTExOTk1OTUzNDU3NiZhbXA7c2RhDQo+IHRhPVU4RnpYM0ZY
MlBvRVpoUnVSTWhGYmthQW5iM2NxalpzYjklMkZUZHQ4T2Z1WSUzRCZhbXA7cmVzZXJ2ZQ0KPiBk
PTAuDQo+ID4+PiBbMV0gaXMgYSBkcmFmdCBpbXBsZW1lbnRhdGlvbiBvZiBpLk1YOE1NIFNDTUkg
QVRGIGltcGxlbWVudGF0aW9uDQo+ID4+PiB0aGF0IHVzZSBzbWMgYXMgbWFpbGJveCwgcG93ZXIv
Y2xrIGlzIGluY2x1ZGVkLCBidXQgb25seSBwYXJ0IG9mIGNsaw0KPiA+Pj4gaGFzIGJlZW4gaW1w
bGVtZW50ZWQgdG8gd29yayB3aXRoIGhhcmR3YXJlLCBwb3dlciBkb21haW4gb25seQ0KPiA+Pj4g
c3VwcG9ydHMgZ2V0IG5hbWUgZm9yIG5vdy4NCj4gPj4+DQo+ID4+PiBUaGUgdHJhZGl0aW9uYWwg
TGludXggbWFpbGJveCBtZWNoYW5pc20gdXNlcyBzb21lIGtpbmQgb2YgZGVkaWNhdGVkDQo+ID4+
PiBoYXJkd2FyZSBJUCB0byBzaWduYWwgYSBjb25kaXRpb24gdG8gc29tZSBvdGhlciBwcm9jZXNz
aW5nIHVuaXQsDQo+ID4+PiB0eXBpY2FsbHkgYSBkZWRpY2F0ZWQgbWFuYWdlbWVudCBwcm9jZXNz
b3IuDQo+ID4+PiBUaGlzIG1haWxib3ggZmVhdHVyZSBpcyB1c2VkIGZvciBpbnN0YW5jZSBieSB0
aGUgU0NNSSBwcm90b2NvbCB0bw0KPiA+Pj4gc2lnbmFsIGEgcmVxdWVzdCBmb3Igc29tZSBhY3Rp
b24gdG8gYmUgdGFrZW4gYnkgdGhlIG1hbmFnZW1lbnQNCj4gcHJvY2Vzc29yLg0KPiA+Pj4gSG93
ZXZlciBzb21lIFNvQ3MgZG9lcyBub3QgaGF2ZSBhIGRlZGljYXRlZCBtYW5hZ2VtZW50IGNvcmUg
dG8NCj4gPj4+IHByb3ZpZGUgdGhvc2Ugc2VydmljZXMuIEluIG9yZGVyIHRvIHNlcnZpY2UgVEVF
IGFuZCB0byBhdm9pZCBsaW51eA0KPiA+Pj4gc2h1dGRvd24gcG93ZXIgYW5kIGNsb2NrIHRoYXQg
dXNlZCBieSBURUUsIG5lZWQgbGV0IGZpcm13YXJlIHRvDQo+ID4+PiBoYW5kbGUgcG93ZXIgYW5k
IGNsb2NrLCB0aGUgZmlybXdhcmUgaGVyZSBpcyBBUk0gVHJ1c3RlZCBGaXJtd2FyZQ0KPiA+Pj4g
dGhhdCBjb3VsZCBhbHNvIHJ1biBTQ01JIHNlcnZpY2UuDQo+ID4+Pg0KPiA+Pj4gVGhlIGV4aXN0
aW5nIFNDTUkgaW1wbGVtZW50YXRpb24gdXNlcyBhIHJhdGhlciBmbGV4aWJsZSBzaGFyZWQNCj4g
Pj4+IG1lbW9yeSByZWdpb24gdG8gY29tbXVuaWNhdGUgY29tbWFuZHMgYW5kIHRoZWlyIHBhcmFt
ZXRlcnMsIGl0IHN0aWxsDQo+ID4+PiByZXF1aXJlcyBhIG1haWxib3ggdG8gYWN0dWFsbHkgdHJp
Z2dlciB0aGUgYWN0aW9uLg0KPiA+Pg0KPiA+PiBXZSBoYXZlIGhhZCBzb21ldGhpbmcgc2ltaWxh
ciBkb25lIGludGVybmFsbHkgd2l0aCBhIGNvdXBsZSBvZiBtaW5vcg0KPiA+PiBkaWZmZXJlbmNl
czoNCj4gPj4NCj4gPj4gLSBhIFNHSSBpcyB1c2VkIHRvIHNlbmQgU0NNSSBub3RpZmljYXRpb25z
L2RlbGF5ZWQgcmVwbGllcyB0byBzdXBwb3J0DQo+ID4+IGFzeW5jaHJvbmlzbSAocGF0Y2hlcyBh
cmUgaW4gdGhlIHdvcmtzIHRvIGFjdHVhbGx5IGFkZCB0aGF0IHRvIHRoZQ0KPiA+PiBMaW51eCBT
Q01JIGZyYW1ld29yaykuIFRoZXJlIGlzIG5vIGdvb2Qgc3VwcG9ydCBmb3IgU0dJIGluIHRoZSBr
ZXJuZWwNCj4gPj4gcmlnaHQgbm93IHNvIHdlIGhhY2tlZCB1cCBzb21ldGhpbmcgZnJvbSB0aGUg
ZXhpc3RpbmcgU01QIGNvZGUgYW5kDQo+ID4+IGFkZGluZyB0aGUgYWJpbGl0eSB0byByZWdpc3Rl
ciBvdXIgb3duIElQSSBoYW5kbGVycyAoU0hBTUUhKS4gVXNpbmcgYQ0KPiA+PiBQUEkgc2hvdWxk
IHdvcmsgYW5kIHNob3VsZCBhbGxvdyBmb3IgdXNpbmcgcmVxdWVzdF9pcnEoKSBBRkFJQ1QuDQo+
ID4+DQo+ID4NCj4gPiBXZSBoYXZlIGJlZW4gdGhpbmtpbmcgdGhpcyBzaW5jZSB3ZSB3ZXJlIGFz
a2VkIGlmIFNNQyBjYW4gYmUgdHJhbnNwb3J0Lg0KPiA+IEdlbmVyYWxseSBvdXQgb2YgMTYgU0dJ
cywgOCBhcmUgcmVzZXJ2ZWQgZm9yIHNlY3VyZSBzaWRlIGFuZA0KPiA+IG5vbi1zZWN1cmUgaGFz
IDguIE9mIHRoZXNlIDgsIElJVUMgNyBpcyBhbHJlYWR5IGJlaW5nIHVzZWQgYnkga2VybmVsLg0K
PiA+IFNvIHVubGVzcyB3ZSBtYW5hZ2UgdG8gZ2V0IHRoZSBsYXN0IG9uZSByZXNlcnZlZCBleGNs
dXNpdmUgdG8gU0NNSSwgaXQNCj4gPiBtYWtlcyBpdCBkaWZmaWN1bHQgdG8gYWRkIFNHSSBzdXBw
b3J0IGluIFNDTUkuDQo+ID4NCj4gPiBXZSBoYXZlIGJlZW4gdGVsbGluZyBwYXJ0bmVycy92ZW5k
b3JzIGFib3V0IHRoaXMgbGltaXRhdGlvbiBpZiB0aGV5DQo+ID4gdXNlIFNNQyBhcyB0cmFuc3Bv
cnQgYW5kIG5lZWQgdG8gaGF2ZSBkZWRpY2F0ZWQgaC93IGludGVycnVwdCBmb3IgdGhlDQo+ID4g
bm90aWZpY2F0aW9ucy4NCj4gPg0KPiA+IEFub3RoZXIgaXNzdWUgY291bGQgYmUgd2l0aCB2aXJ0
dWFsaXNhdGlvbih1c2luZyBIVkMpIGFuZCBFTCBoYW5kbGluZw0KPiA+IHNvIGNhbGxlZCBTQ01J
IFNHSS4gV2UgbmVlZCB0byB0aGluayBhYm91dCB0aG9zZSB0b28uIEkgd2lsbCB0cnkgdG8NCj4g
PiBnZXQgbW9yZSBpbmZvIG9uIHRoaXMgYW5kIGNvbWUgYmFjayBvbiB0aGlzLg0KPiANCj4gSSB0
aGluayByZWdhcmRsZXNzIG9mIHRoZSAqY3VycmVudCogZmVhc2liaWxpdHkgb2YgdXNpbmcgU0dJ
cyBpbiAqTGludXgqIHdlDQo+IHNob3VsZCBhdCBsZWFzdCBzcGVjaWZ5IGFuICJpbnRlcnJ1cHRz
IiBwcm9wZXJ0eSBpbiB0aGUgYmluZGluZywgdG8gYWxsb3cgZm9yDQo+IGZ1dHVyZSB1c2FnZS4g
V2UgbWlnaHQgY29weSB0aGUgcG11djMgd2F5IFsxXSBvZiBhbGxvd2luZyB0byBzcGVjaWZ5DQo+
IG11bHRpcGxlIFNQSSBpbnRlcnJ1cHRzIGFzIHdlbGwsIHRvIGdpdmUgbW9yZSBmbGV4aWJpbGl0
eS4NCg0KVGhpcyBuZWVkcyB0byBnbyB3aXRoIGFuIG9wdGlvbmFsIHByb3BlcnR5LCBhZ3JlZT8N
ClRoYXQgbWVhbnMgc21jIG1haWxib3ggbmVlZHMgdG8gc3VwcG9ydCBzeW5jaHJvbm91cyBhbmQg
YXN5bmNocm9ub3VzDQpjb21tdW5pY2F0aW9uLiBJJ2xsIHRyeSB0byBhZGQgdGhhdCBhbmQgd3Jp
dGUgc29tZSBwb3JvdHlwZSBjb2RlIHRvDQp2ZXJpZnkuDQoNClRoYW5rcywNClBlbmcuDQoNCj4g
QWZ0ZXIgYWxsIGFuIGltcGxlbWVudGF0aW9uIGNvdWxkIG9mZmxvYWQgdGhlIGFzeW5jaHJvbm91
cyBub3RpZmljYXRpb24gdG8gYQ0KPiBzZXBhcmF0ZSBjb3JlLCBhbmQgdGhhdCBjb3VsZCB1c2Ug
U1BJcywgZm9yIGluc3RhbmNlLg0KPiANCj4gQ2hlZXJzLA0KPiBBbmRyZS4NCj4gDQo+IFsxXSBE
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL3BtdS55YW1sOjQ1DQo=
