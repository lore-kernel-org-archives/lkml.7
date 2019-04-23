Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19624C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 06:38:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C49E9214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 06:38:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="pA1yl993"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbfDWGiY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 02:38:24 -0400
Received: from mail-eopbgr700067.outbound.protection.outlook.com ([40.107.70.67]:64257
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725882AbfDWGiY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 02:38:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NijpWnQtQbQS8wlOZp511ql27gM5zNfzJwT7Uxl3cBI=;
 b=pA1yl993LIxz+GsKCYLNOxyTkOZPWiLt7MSZzZ2bXXfVvpO3jGi2l7Xer28Cc4EzFnc0d9HdiBaWqzGkHYwOj7TrWLgJSEiVIZ98V1UI1jVfDTivpqHhFEYqdEXpyPxXf/Te77MkaO7R+X63KUIrIQdyWg7EsvoZw/38q6KaD0o=
Received: from DM5PR02MB2187.namprd02.prod.outlook.com (10.168.174.14) by
 DM5PR02MB2649.namprd02.prod.outlook.com (10.168.198.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.12; Tue, 23 Apr 2019 06:38:20 +0000
Received: from DM5PR02MB2187.namprd02.prod.outlook.com
 ([fe80::807:aceb:5c03:e4db]) by DM5PR02MB2187.namprd02.prod.outlook.com
 ([fe80::807:aceb:5c03:e4db%5]) with mapi id 15.20.1835.010; Tue, 23 Apr 2019
 06:38:20 +0000
From:   Appana Durga Kedareswara Rao <appanad@xilinx.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        "wg@grandegger.com" <wg@grandegger.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        Michal Simek <michals@xilinx.com>
CC:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 0/6] net: can: xilinx_can: Bug fixes and Enhancements
Thread-Topic: [PATCH 0/6] net: can: xilinx_can: Bug fixes and Enhancements
Thread-Index: AQHU3X5pxtrhGyT8f0y/0R8BjEz816YUgSyAgAEkNOCAM9QFwA==
Date:   Tue, 23 Apr 2019 06:38:20 +0000
Message-ID: <DM5PR02MB2187137A63481B2BB2E12920DC230@DM5PR02MB2187.namprd02.prod.outlook.com>
References: <1552908766-26753-1-git-send-email-appana.durga.rao@xilinx.com>
 <d1cd73cc-e200-7c06-dd6e-3c5e2e35709c@pengutronix.de>
 <DM5PR02MB21875918C65EF8757E34C574DC420@DM5PR02MB2187.namprd02.prod.outlook.com>
In-Reply-To: <DM5PR02MB21875918C65EF8757E34C574DC420@DM5PR02MB2187.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=appanad@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7a63ec52-a1a6-44e0-2b65-08d6c7b646dc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DM5PR02MB2649;
x-ms-traffictypediagnostic: DM5PR02MB2649:
x-ms-exchange-purlcount: 2
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <DM5PR02MB26492326525A6508350862C1DC230@DM5PR02MB2649.namprd02.prod.outlook.com>
x-forefront-prvs: 0016DEFF96
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(396003)(376002)(366004)(346002)(199004)(189003)(13464003)(76176011)(3846002)(6116002)(5660300002)(7696005)(2501003)(71190400001)(71200400001)(99286004)(66066001)(97736004)(102836004)(446003)(53546011)(66556008)(66476007)(73956011)(74316002)(26005)(66946007)(6636002)(86362001)(76116006)(229853002)(66446008)(64756008)(305945005)(52536014)(486006)(476003)(6436002)(6506007)(2201001)(186003)(7736002)(11346002)(9686003)(966005)(68736007)(6306002)(478600001)(2906002)(53936002)(53386004)(6246003)(33656002)(14454004)(55016002)(14444005)(25786009)(256004)(4326008)(316002)(8676002)(81156014)(81166006)(8936002)(54906003)(110136005);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR02MB2649;H:DM5PR02MB2187.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: PrDPyjY7D2NtczvCfrhPbzCZX2XnfJGBVwUIzqN03p/aOye03eyHtBVSCi3F4lfCz8cIga+c/R8NpiGVKyyWA/BDm8bIr0W3iJW1Yx4Nv6JLflorVnh22Zjm/Ox0ByGDNA5Cjso+7s8FR8MUj7kETRQDpQRHk5Aif86AFnZXU//GhjkleUxgHaNS7PFvAbk6F+dDJb7qPnU+bQ9fw4Z0Z/NoJeeBefZpcrub+IJCtUotw2zuBqKlSgArc3CU0jtTJXiOLxiFk3rC4bdrUkAOT58f/Rhqhxzr8Z/PmtbVunxqdKL5e119IdjL4qgNZYvHgp/tFWS7/qaOXB3VhPpgsKFoTP8uLpKizIxf+rcnM+DRRq8wT+AXLTlfDuoeHC3D3ko2Rcy92DVeMr5GzjhBjzprDJ9Xbloc+19DvRaKvEU=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a63ec52-a1a6-44e0-2b65-08d6c7b646dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2019 06:38:20.4481
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB2649
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWFyYywNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBcHBhbmEg
RHVyZ2EgS2VkYXJlc3dhcmEgUmFvDQo+IFNlbnQ6IFRodXJzZGF5LCBNYXJjaCAyMSwgMjAxOSAx
MjowNiBQTQ0KPiBUbzogJ01hcmMgS2xlaW5lLUJ1ZGRlJyA8bWtsQHBlbmd1dHJvbml4LmRlPjsg
d2dAZ3JhbmRlZ2dlci5jb207DQo+IGRhdmVtQGRhdmVtbG9mdC5uZXQ7IE1pY2hhbCBTaW1layA8
bWljaGFsc0B4aWxpbnguY29tPg0KPiBDYzogbGludXgtY2FuQHZnZXIua2VybmVsLm9yZzsgbmV0
ZGV2QHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLQ0KPiBrZXJuZWxAbGlzdHMuaW5mcmFkZWFk
Lm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSRTogW1BBVENI
IDAvNl0gbmV0OiBjYW46IHhpbGlueF9jYW46IEJ1ZyBmaXhlcyBhbmQgRW5oYW5jZW1lbnRzDQo+
IA0KPiBIaSBNYXJjLA0KPiANCj4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+IEZy
b206IE1hcmMgS2xlaW5lLUJ1ZGRlIDxta2xAcGVuZ3V0cm9uaXguZGU+DQo+ID4gU2VudDogV2Vk
bmVzZGF5LCBNYXJjaCAyMCwgMjAxOSA2OjM5IFBNDQo+ID4gVG86IEFwcGFuYSBEdXJnYSBLZWRh
cmVzd2FyYSBSYW8gPGFwcGFuYWRAeGlsaW54LmNvbT47DQo+ID4gd2dAZ3JhbmRlZ2dlci5jb207
IGRhdmVtQGRhdmVtbG9mdC5uZXQ7IE1pY2hhbCBTaW1law0KPiA+IDxtaWNoYWxzQHhpbGlueC5j
b20+DQo+ID4gQ2M6IGxpbnV4LWNhbkB2Z2VyLmtlcm5lbC5vcmc7IG5ldGRldkB2Z2VyLmtlcm5l
bC5vcmc7IGxpbnV4LWFybS0NCj4gPiBrZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgt
a2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMC82XSBuZXQ6
IGNhbjogeGlsaW54X2NhbjogQnVnIGZpeGVzIGFuZA0KPiA+IEVuaGFuY2VtZW50cw0KPiA+DQo+
ID4gT24gMy8xOC8xOSAxMjozMiBQTSwgQXBwYW5hIER1cmdhIEtlZGFyZXN3YXJhIHJhbyB3cm90
ZToNCj4gPiA+IFRoaXMgcGF0Y2ggc2VyaWVzIGRvZXMgdGhlIGJlbG93DQo+ID4gPiAtLT4gQWRk
ZWQgc3VwcG9ydCBmb3IgQ0FORkQgRkQgZnJhbWVzIEZpeCBDaGVja3BhdGNoIHJlcG9ydGVkDQo+
ID4gPiAtLT4gd2FybmluZ3MgYW5kIGNoZWNrcw0KPiA+ID4NCj4gPiA+IEFwcGFuYSBEdXJnYSBL
ZWRhcmVzd2FyYSByYW8gKDYpOg0KPiA+ID4gICBuZXQ6IGNhbjogeGlsaW54X2NhbjogRml4IHN0
eWxlIGlzc3Vlcw0KPiA+ID4gICBuZXQ6IGNhbjogeGlsaW54X2NhbjogRml4IGZsYWdzIGZpZWxk
IGluaXRpYWxpemF0aW9uIGZvciBheGkgY2FuIGFuZA0KPiA+ID4gICAgIGNhbnBzDQo+ID4gPiAg
IG5ldDogY2FuOiB4aWxpbnhfY2FuOiBBZGQgY2FudHlwZSBwYXJhbWV0ZXIgaW4geGNhbl9kZXZ0
eXBlX2RhdGENCj4gPiA+ICAgICBzdHJ1Y3QNCj4gPiA+ICAgbmV0OiBjYW46IHhpbGlueF9jYW46
IEFkZCBzdXBwb3J0IGZvciBDQU5GRCBGRCBmcmFtZXMNCj4gPiA+ICAgbmV0OiBjYW46IHhpbGlu
eF9jYW46IEFkZCBTUERYIGxpY2Vuc2UNCj4gPiA+ICAgbmV0OiBjYW46IHhpbGlueF9jYW46IEZp
eCBrZXJuZWwgZG9jIHdhcm5pbmdzDQo+ID4gPg0KPiA+ID4gIGRyaXZlcnMvbmV0L2Nhbi94aWxp
bnhfY2FuLmMgfCAzMDMNCj4gPiA+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
Ky0tLS0tLS0NCj4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMjU3IGluc2VydGlvbnMoKyksIDQ2IGRl
bGV0aW9ucygtKQ0KPiA+DQo+ID4gQXBwbGllZCB0byBsaW51eC1jYW4tbmV4dC90ZXN0aW5nLCBi
dXQgaW4gb3JkZXIuIEZpcnN0IGZpeGVzIHRoYW4NCj4gPiBlbmhhbmNlbWVudHM6DQo+IA0KPiBU
aGFua3MuLi4NCj4gSSBjb3VsZG4ndCBmaW5kIHRoZSBwYXRjaGVzIGhlcmUNCj4gaHR0cHM6Ly9n
aXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvbWtsL2xpbnV4LWNhbi0NCj4g
bmV4dC5naXQvbG9nL2RyaXZlcnMvbmV0L2Nhbi94aWxpbnhfY2FuLmM/aD10ZXN0aW5nDQo+IEFt
IEkgcmVmZXJyaW5nIHdyb25nIHJlcG8vYnJhbmNoPz8NCg0KVGhlcmUgYXJlIGEgY291cGxlIG9m
IGJ1ZyBmaXhlcyBhdmFpbGFibGUgZm9yIHRoaXMgZHJpdmVyIG9uIHRvcCBvZiB0aGlzIHBhdGNo
IHNlcmllcy4NClBsZWFzZSBsZXQgbWUga25vdyB0aGUgYnJhbmNoIHdoZXJlIHRoaXMgcGF0Y2gg
c2VyaWVzIGdvdCBhcHBsaWVkLCB3aWxsIHNlbmQgdGhlIGJ1ZyBmaXhlcyBvbiB0b3Agb2YgdGhh
dCBicmFuY2guIA0KDQpSZWdhcmRzLA0KS2VkYXIuDQo+IA0KPiBSZWdhcmRzLA0KPiBLZWRhci4N
Cj4gPg0KPiA+ID4gMjQxODI2MzAyODU0IG5ldDogY2FuOiB4aWxpbnhfY2FuOiBGaXggc3R5bGUg
aXNzdWVzDQo+ID4gPiA3MGZiMjZmYWRjMjcgbmV0OiBjYW46IHhpbGlueF9jYW46IEZpeCBrZXJu
ZWwgZG9jIHdhcm5pbmdzDQo+ID4gPiA3YmViNjQzNTFmZjEgbmV0OiBjYW46IHhpbGlueF9jYW46
IEFkZCBTUERYIGxpY2Vuc2UgZGQ5NDkxMGJjZWFlIG5ldDoNCj4gPiA+IGNhbjogeGlsaW54X2Nh
bjogRml4IGZsYWdzIGZpZWxkIGluaXRpYWxpemF0aW9uIGZvciBheGkgY2FuIGFuZA0KPiA+ID4g
Y2FucHMNCj4gPiA+IDZiZDA1Y2VjZTU2NyBuZXQ6IGNhbjogeGlsaW54X2NhbjogQWRkIGNhbnR5
cGUgcGFyYW1ldGVyIGluDQo+ID4gPiB4Y2FuX2RldnR5cGVfZGF0YSBzdHJ1Y3QNCj4gPiA+IDM0
ZTI4MDE3MDczNiBuZXQ6IGNhbjogeGlsaW54X2NhbjogQWRkIHN1cHBvcnQgZm9yIENBTkZEIEZE
IGZyYW1lcw0KPiA+DQo+ID4gTWFyYw0KPiA+DQo+ID4gLS0NCj4gPiBQZW5ndXRyb25peCBlLksu
ICAgICAgICAgICAgICAgICAgfCBNYXJjIEtsZWluZS1CdWRkZSAgICAgICAgICAgfA0KPiA+IElu
ZHVzdHJpYWwgTGludXggU29sdXRpb25zICAgICAgICB8IFBob25lOiArNDktMjMxLTI4MjYtOTI0
ICAgICB8DQo+ID4gVmVydHJldHVuZyBXZXN0L0RvcnRtdW5kICAgICAgICAgIHwgRmF4OiAgICs0
OS01MTIxLTIwNjkxNy01NTU1IHwNCj4gPiBBbXRzZ2VyaWNodCBIaWxkZXNoZWltLCBIUkEgMjY4
NiAgfCBodHRwOi8vd3d3LnBlbmd1dHJvbml4LmRlICAgfA0KDQo=
