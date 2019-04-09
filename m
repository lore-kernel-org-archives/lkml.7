Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F981C10F14
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 03:26:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEDC620880
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 03:26:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="tV9zb6fD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbfDID0Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 23:26:25 -0400
Received: from mail-eopbgr20063.outbound.protection.outlook.com ([40.107.2.63]:40830
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726487AbfDID0Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 23:26:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7jMTDPij5i/Q1eVGO5seZCWC4dOrx7fcA9i4aif7f1M=;
 b=tV9zb6fDfg9DwzF95tVX1a6wY/zGC1AE8nlCkU/AqF6Xom1kuWIjzlli8v+CPPDltRrwDxl6a247+saoaGTFPOjJpbv28t7cx0kJ4Uvm6fk0x9V/5Ep1g3TAEiyHL2vBwA/TQ9L27UsZXZSDlAjrcHhCgx+6wLZPx3QRzdTDzio=
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com (20.177.55.90) by
 VI1PR04MB3008.eurprd04.prod.outlook.com (10.170.228.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.19; Tue, 9 Apr 2019 03:26:15 +0000
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5d07:911b:18e1:1525]) by VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5d07:911b:18e1:1525%4]) with mapi id 15.20.1771.019; Tue, 9 Apr 2019
 03:26:15 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     Igor Plyatov <plyatov@gmail.com>,
        =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Andy Duan <fugang.duan@nxp.com>, Han Xu <han.xu@nxp.com>,
        Clark Wang <xiaoning.wang@nxp.com>
Subject: RE: Issues with i.MX SPI DMA transfers
Thread-Topic: Issues with i.MX SPI DMA transfers
Thread-Index: AQHU5MQedyysM/Gs0UKoyWKgyiIok6YgnCuAgAADPICAACYCkIAAHYGAgAEpjtCABnMWgIAAEhKQgAqpimA=
Date:   Tue, 9 Apr 2019 03:26:15 +0000
Message-ID: <VI1PR04MB454302BAF353124ED13747DC892D0@VI1PR04MB4543.eurprd04.prod.outlook.com>
References: <08fcbd65-510f-84f8-d6d6-ff56aa9ca9ad@gmail.com>
 <20190328065247.uz73lap7ljf5q3tb@pengutronix.de>
 <b8e80127-e377-9ef9-2447-b0126fdad7dc@gmail.com>
 <VI1PR04MB45438E01D91829849A4E0BB289590@VI1PR04MB4543.eurprd04.prod.outlook.com>
 <d7a2e5c5-4ee0-8c89-1bab-654db0ae38dd@gmail.com>
 <VI1PR04MB4543B1708FA151EED0CB722A89550@VI1PR04MB4543.eurprd04.prod.outlook.com>
 <95df9334-3d0c-7d13-e431-5a4aa2b9907e@gmail.com>
 <VI1PR04MB454305A56372466A38E9F81989560@VI1PR04MB4543.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB454305A56372466A38E9F81989560@VI1PR04MB4543.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 38448103-92f8-4112-ec99-08d6bc9b1fad
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(49563074)(7193020);SRVR:VI1PR04MB3008;
x-ms-traffictypediagnostic: VI1PR04MB3008:
x-microsoft-antispam-prvs: <VI1PR04MB3008E826541C9DBF805FBB1F892D0@VI1PR04MB3008.eurprd04.prod.outlook.com>
x-forefront-prvs: 000227DA0C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(346002)(39860400002)(376002)(396003)(189003)(199004)(45904002)(13464003)(106356001)(55016002)(3846002)(7416002)(33656002)(86362001)(305945005)(105586002)(6116002)(7736002)(6246003)(9686003)(4326008)(25786009)(53936002)(76176011)(74316002)(99936001)(478600001)(14454004)(2906002)(97736004)(446003)(66066001)(11346002)(229853002)(476003)(486006)(110136005)(54906003)(316002)(7696005)(186003)(26005)(6506007)(71200400001)(99286004)(66574012)(53546011)(102836004)(93886005)(14444005)(8936002)(52536014)(5660300002)(81166006)(81156014)(68736007)(5024004)(8676002)(6436002)(256004)(71190400001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3008;H:VI1PR04MB4543.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: eRnpfV9eUrJkzEH0kStVPIkqzTzlSfNwoPf5XCBd+QBaajOaugoUhEIejLTgQRuJBDV9ueGV+dElWcjTPBoF/aNfcPufBOtRC918XjzyUUofJMutRN1XMn48B3iLwKjgGK1iD66fPEWkfML4iyFZvPHIwELNAYuU0B6QmYHJaoXNGRXnazaibyY6+QjtkYhT3qdn8vsK/yhgFyN0R60QTkLxq1XdxL/7RCQbdvVjDAUr66mEbRa3qFwT0REF/1McE7tyC3xcrWHgohZM+61CzCSNnrQ3HqKzFmQg8GrBHvzEctJDxErvskRXpb6kyu77NyQA59apuBxQkO1yC94ctunyygyMdkkdz+5TZVpjHUobhWwFID2ViICMjeBVMG5B0wlPfkugzywbyI/ieimxsNwfQB7VOJBnyIdv58II1QM=
Content-Type: multipart/mixed;
        boundary="_003_VI1PR04MB454302BAF353124ED13747DC892D0VI1PR04MB4543eurp_"
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38448103-92f8-4112-ec99-08d6bc9b1fad
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2019 03:26:15.5807
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3008
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--_003_VI1PR04MB454302BAF353124ED13747DC892D0VI1PR04MB4543eurp_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGkgSWdvciwNCglQbGVhc2UgaGF2ZSBhIHRyeSB3aXRoIHRoZSBhdHRhY2hlZCBwYXRjaGVzLCBh
bmQgcmV2ZXJ0IDI1YWFhNzVkZjFlNiwgYWQwZDkyZDdiYTZhDQosIGRkNGI0ODdiMzJhMywgZGYw
NzEwMWUxYzRhIGJlZm9yZSBhcHBseS4gQmVzaWRlcyBYQ0gsIHR4IHRocmVzaCBzaG91bGQgYmUg
c2V0IHRvIDAgLA0Kbm93IG5vIGZhaWx1cmUgY2F1Z2h0IG9uIGVjc3BpNS4NCg0KPiAtLS0tLU9y
aWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBSb2JpbiBHb25nDQo+IFNlbnQ6IDIwMTnlubQ0
5pyIMuaXpSAxNjozMw0KPiBUbzogJ0lnb3IgUGx5YXRvdicgPHBseWF0b3ZAZ21haWwuY29tPjsg
VXdlIEtsZWluZS1Lw7ZuaWcNCj4gPHUua2xlaW5lLWtvZW5pZ0BwZW5ndXRyb25peC5kZT4NCj4g
Q2M6IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMu
aW5mcmFkZWFkLm9yZzsNCj4gbGludXgtc3BpQHZnZXIua2VybmVsLm9yZzsgZGwtbGludXgtaW14
IDxsaW51eC1pbXhAbnhwLmNvbT47IEZhYmlvIEVzdGV2YW0NCj4gPGZlc3RldmFtQGdtYWlsLmNv
bT47IFBlbmd1dHJvbml4IEtlcm5lbCBUZWFtIDxrZXJuZWxAcGVuZ3V0cm9uaXguZGU+Ow0KPiBT
YXNjaGEgSGF1ZXIgPHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU+OyBTaGF3biBHdW8NCj4gPHNoYXdu
Z3VvQGtlcm5lbC5vcmc+OyBNYXJrIEJyb3duIDxicm9vbmllQGtlcm5lbC5vcmc+Ow0KPiBkbWFl
bmdpbmVAdmdlci5rZXJuZWwub3JnOyBWaW5vZCBLb3VsIDx2a291bEBrZXJuZWwub3JnPjsgRGFu
IFdpbGxpYW1zDQo+IDxkYW4uai53aWxsaWFtc0BpbnRlbC5jb20+OyBBbmR5IER1YW4gPGZ1Z2Fu
Zy5kdWFuQG54cC5jb20+OyBIYW4gWHUNCj4gPGhhbi54dUBueHAuY29tPjsgQ2xhcmsgV2FuZyA8
eGlhb25pbmcud2FuZ0BueHAuY29tPg0KPiBTdWJqZWN0OiBSRTogSXNzdWVzIHdpdGggaS5NWCBT
UEkgRE1BIHRyYW5zZmVycw0KPiANCj4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+
IEZyb206IElnb3IgUGx5YXRvdiA8cGx5YXRvdkBnbWFpbC5jb20+DQo+ID4gU2VudDogMjAxOeW5
tDTmnIgy5pelIDE1OjIwDQo+ID4gVG86IFJvYmluIEdvbmcgPHlpYmluLmdvbmdAbnhwLmNvbT47
IFV3ZSBLbGVpbmUtS8O2bmlnDQo+ID4gPHUua2xlaW5lLWtvZW5pZ0BwZW5ndXRyb25peC5kZT4N
Cj4gPiBDYzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4gPiBsaW51eC1hcm0ta2Vy
bmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+ID4gbGludXgtc3BpQHZnZXIua2VybmVsLm9yZzsg
ZGwtbGludXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT47IEZhYmlvDQo+ID4gRXN0ZXZhbSA8ZmVz
dGV2YW1AZ21haWwuY29tPjsgUGVuZ3V0cm9uaXggS2VybmVsIFRlYW0NCj4gPiA8a2VybmVsQHBl
bmd1dHJvbml4LmRlPjsgU2FzY2hhIEhhdWVyIDxzLmhhdWVyQHBlbmd1dHJvbml4LmRlPjsgU2hh
d24NCj4gPiBHdW8gPHNoYXduZ3VvQGtlcm5lbC5vcmc+OyBNYXJrIEJyb3duIDxicm9vbmllQGtl
cm5lbC5vcmc+Ow0KPiA+IGRtYWVuZ2luZUB2Z2VyLmtlcm5lbC5vcmc7IFZpbm9kIEtvdWwgPHZr
b3VsQGtlcm5lbC5vcmc+OyBEYW4gV2lsbGlhbXMNCj4gPiA8ZGFuLmoud2lsbGlhbXNAaW50ZWwu
Y29tPjsgQW5keSBEdWFuIDxmdWdhbmcuZHVhbkBueHAuY29tPjsgSGFuIFh1DQo+ID4gPGhhbi54
dUBueHAuY29tPjsgQ2xhcmsgV2FuZyA8eGlhb25pbmcud2FuZ0BueHAuY29tPg0KPiA+IFN1Ympl
Y3Q6IFJlOiBJc3N1ZXMgd2l0aCBpLk1YIFNQSSBETUEgdHJhbnNmZXJzDQo+ID4NCj4gPiBEZWFy
IFJvYmluIEdvbmcsDQo+ID4NCj4gPg0KPiA+ID4+IFNvcnJ5Li4uYmVsb3cgYW5vdGhlciBzZG1h
IHBhdGNoKGFkMGQ5MmQ3YmE2YSkgbmVlZCB0byBiZSByZXZlcnRlZCwNCj4gPiA+PiBiZWNhdXNl
IHNwaSBkcml2ZXIgbWF5IGR5bmFtaWNhbGx5IGNoYW5nZSBidXJzdCBsZW5ndGguDQo+ID4NCj4g
Pg0KPiA+IG5vdyBJIGhhdmUgcmV2ZXJ0ZWQgcGF0Y2ggYWQwZDkyZDdiYTZhLg0KPiA+DQo+ID4g
UGF0Y2hlcyAwMDAxLWRtYS1lbmdpbmUtaW14LXNkbWEtYWRkLW1jdV8yX2Vjc3BpLXNjcmlwdC5w
YXRjaCBhbmQNCj4gPiAwMDAyLXNwaS1zcGktaW14LWZpeC1FUlIwMDkxNjUucGF0Y2ggYXJlIGFw
cGxpZWQuDQo+ID4NCj4gPg0KPiA+IEtlcm5lbCBsb2cgc2hvdyBtZXNzYWdlcw0KPiA+DQo+ID4g
W8KgwqAgMjkuMjAyNjM5XSBpbXgtc2RtYSAyMGVjMDAwLnNkbWE6IGxvYWRlZCBmaXJtd2FyZSAz
LjMgWw0KPiA+IDI5LjIzODU5NV0gc3BpX2lteCAyMDA4MDAwLnNwaTogcHJvYmVkIFvCoMKgIDI5
LjI0MjgwMl0gc3BpX2lteA0KPiA+IDIwMGMwMDAuc3BpOiBwcm9iZWQgW8KgwqAgMjkuMjQ1MjE3
XSBzcGlfaW14IDIwMTgwMDAuc3BpOiBwcm9iZWQNCj4gPg0KPiA+IFNQSSBETUEgdHJhbnNmZXJz
IHN0aWxsIG5vdCB3b3JrLg0KPiA+DQo+ID4gSWYgSSB0ZXN0IDMyIGJ5dGUgdHJhbnNmZXJzLCB0
aGVuIHRoZXkgd29yayBmaW5lLiBCdXQgNjQgYnl0ZQ0KPiA+IHRyYW5zZmVycyBmYWlscyBhbHdh
eXMgYW5kIEkgc2VlIGVycm9yIG1lc3NhZ2VzDQo+ID4NCj4gPiByb290QGNyNzp+IyBzcGlkZXZf
dGVzdCAtRCAvZGV2L3NwaWRldjQuMSAtcyAxMjAwMDAwIC1iIDggLVMgNjQgLUkgMQ0KPiA+IC1s
IHNwaSBtb2RlOiAweDIwIGJpdHMgcGVyIHdvcmQ6IDggbWF4IHNwZWVkOiAxMjAwMDAwIEh6ICgx
MjAwIEtIeikgWw0KPiA+IDQyMy42ODY3MzZdIHNwaV9tYXN0ZXIgc3BpNDogSS9PIEVycm9yIGlu
IERNQSBSWCBbwqAgNDIzLjY5MTM5Ml0gc3BpZGV2DQo+ID4gc3BpNC4xOiBTUEkgdHJhbnNmZXIg
ZmFpbGVkOiAtMTEwIFvCoCA0MjMuNjk2MzgyXSBzcGlfbWFzdGVyIHNwaTQ6DQo+ID4gZmFpbGVk
IHRvIHRyYW5zZmVyIG9uZSBtZXNzYWdlIGZyb20gcXVldWUgY2FuJ3Qgc2VuZCBzcGkgbWVzc2Fn
ZToNCj4gPiBDb25uZWN0aW9uIHRpbWVkIG91dCBBYm9ydGVkIChjb3JlIGR1bXBlZCkNCj4gPg0K
PiA+IEkgc3VwcG9zZSwgdHJhbnNmZXJzIHNob3J0ZXIgdGhlbiA2NCBieXRlcyBtYWRlIHdpdGgg
aGVscCBvZiBQSU8uDQo+ID4NCj4gPiBSb2JpbiwgaXMgdGhlcmUgYW55IGNoYW5jZSBmb3IgeW91
IHRvIGZpbmQgc29tZSB0aW1lIGFuZCBsb29rIGF0IHRoaXMNCj4gPiBpc3N1ZSBhZ2Fpbj8NCj4g
SSBoYXZlIHF1aWNrIHRlc3Qgd2l0aCBzcGlkZXZfdGVzdCBsb29wYmFjaywgYnV0IGRpZG4ndCBt
ZWV0IHlvdXIgZXJyb3IsIElzIHlvdXINCj4gY29kZSB0aGUgYWxtb3N0IGxhdGVzdCBjb2RlIGlu
IGxpbnV4LW5leHQgYXMgbWluZT8NCj4gDQo+IHJvb3RAaW14NnFwZGxzb2xveDp+IyBjYXQgL3By
b2MvaW50ZXJydXB0cyB8IGdyZXAgc2RtYQ0KPiAgNDg6ICAgICAgICAgMzcgICAgICAgR1BDICAg
MiBMZXZlbCAgICAgc2RtYQ0KPiAgLWx0QGlteDZxcGRsc29sb3g6fiMgLi9zcGlkZXZfdGVzdCAt
RCAvZGV2L3NwaWRldjAuMCAtcyAxMjAwMDAwIC1iIDggLVMgNjQgLUkNCj4gMSAtbCBzcGkgbW9k
ZTogMHgyMCBiaXRzIHBlciB3b3JkOiA4IG1heCBzcGVlZDogMTIwMDAwMCBIeiAoMTIwMCBLSHop
DQo+IHJvb3RAaW14NnFwZGxzb2xveDp+IyBjYXQgL3Byb2MvaW50ZXJydXB0cyB8IGdyZXAgc2Rt
YQ0KPiAgNDg6ICAgICAgICAgNDMgICAgICAgR1BDICAgMiBMZXZlbCAgICAgc2RtYQ0KPiAuL3Nw
aWRldl90ZXN0IC1EIC9kZXYvc3BpZGV2MC4wIC1zIDEyMDAwMDAgLWIgOCAtUyA1MTIgLUkgMSAt
bCBzcGkgbW9kZTogMHgyMCBiaXRzDQo+IHBlciB3b3JkOiA4IG1heCBzcGVlZDogMTIwMDAwMCBI
eiAoMTIwMCBLSHopDQo+IHRvdGFsOiB0eCAwLjVLQiwgcnggMC41S0INCj4gPg0KPiA+IEJlc3Qg
d2lzaGVzLg0KPiA+IC0tDQo+ID4gSWdvciBQbHlhdG92DQo=

--_003_VI1PR04MB454302BAF353124ED13747DC892D0VI1PR04MB4543eurp_
Content-Type: application/octet-stream;
	name="0005-dma-engine-imx-sdma-add-mcu_2_ecspi-script.patch"
Content-Description: 0005-dma-engine-imx-sdma-add-mcu_2_ecspi-script.patch
Content-Disposition: attachment;
	filename="0005-dma-engine-imx-sdma-add-mcu_2_ecspi-script.patch"; size=1369;
	creation-date="Tue, 09 Apr 2019 03:25:48 GMT";
	modification-date="Tue, 09 Apr 2019 03:25:48 GMT"
Content-Transfer-Encoding: base64

RnJvbSBmYmRmNDE1M2I0NzkwYTQzYTczOTZiNWM3OGE4NDhiNGQwNzM1ZjgwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBSb2JpbiBHb25nIDx5aWJpbi5nb25nQG54cC5jb20+CkRhdGU6
IFRodSwgMjggTWFyIDIwMTkgMTY6MzY6MTIgKzA4MDAKU3ViamVjdDogW1BBVENIIDUvNl0gZG1h
OiBlbmdpbmU6IGlteC1zZG1hOiBhZGQgbWN1XzJfZWNzcGkgc2NyaXB0CgpBZGQgbWN1XzJfZWNz
cGkgc2NyaXB0IHRvIGZpeCBlY3NwaSBlcnJhdGEgRVJSMDA5MTY1LgoKU2lnbmVkLW9mZi1ieTog
Um9iaW4gR29uZyA8eWliaW4uZ29uZ0BueHAuY29tPgotLS0KIGRyaXZlcnMvZG1hL2lteC1zZG1h
LmMgICAgICAgICAgICAgICAgICAgICB8IDMgKysrCiBpbmNsdWRlL2xpbnV4L3BsYXRmb3JtX2Rh
dGEvZG1hLWlteC1zZG1hLmggfCAxICsKIDIgZmlsZXMgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCsp
CgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9kbWEvaW14LXNkbWEuYyBiL2RyaXZlcnMvZG1hL2lteC1z
ZG1hLmMKaW5kZXggYWRjODJkOS4uMGNjNTJkYiAxMDA2NDQKLS0tIGEvZHJpdmVycy9kbWEvaW14
LXNkbWEuYworKysgYi9kcml2ZXJzL2RtYS9pbXgtc2RtYS5jCkBAIC05MDcsNiArOTA3LDkgQEAg
c3RhdGljIHZvaWQgc2RtYV9nZXRfcGMoc3RydWN0IHNkbWFfY2hhbm5lbCAqc2RtYWMsCiAJCWVt
aV8yX3BlciA9IHNkbWEtPnNjcmlwdF9hZGRycy0+bWN1XzJfYXRhX2FkZHI7CiAJCWJyZWFrOwog
CWNhc2UgSU1YX0RNQVRZUEVfQ1NQSToKKwkJcGVyXzJfZW1pID0gc2RtYS0+c2NyaXB0X2FkZHJz
LT5hcHBfMl9tY3VfYWRkcjsKKwkJZW1pXzJfcGVyID0gc2RtYS0+c2NyaXB0X2FkZHJzLT5tY3Vf
Ml9lY3NwaV9hZGRyOworCQlicmVhazsKIAljYXNlIElNWF9ETUFUWVBFX0VYVDoKIAljYXNlIElN
WF9ETUFUWVBFX1NTSToKIAljYXNlIElNWF9ETUFUWVBFX1NBSToKZGlmZiAtLWdpdCBhL2luY2x1
ZGUvbGludXgvcGxhdGZvcm1fZGF0YS9kbWEtaW14LXNkbWEuaCBiL2luY2x1ZGUvbGludXgvcGxh
dGZvcm1fZGF0YS9kbWEtaW14LXNkbWEuaAppbmRleCA2ZWFhNTNjLi5mNzk0ZmVlIDEwMDY0NAot
LS0gYS9pbmNsdWRlL2xpbnV4L3BsYXRmb3JtX2RhdGEvZG1hLWlteC1zZG1hLmgKKysrIGIvaW5j
bHVkZS9saW51eC9wbGF0Zm9ybV9kYXRhL2RtYS1pbXgtc2RtYS5oCkBAIC01MSw2ICs1MSw3IEBA
IHN0cnVjdCBzZG1hX3NjcmlwdF9zdGFydF9hZGRycyB7CiAJLyogRW5kIG9mIHYyIGFycmF5ICov
CiAJczMyIHpjYW5mZF8yX21jdV9hZGRyOwogCXMzMiB6cXNwaV8yX21jdV9hZGRyOworCXMzMiBt
Y3VfMl9lY3NwaV9hZGRyOwogCS8qIEVuZCBvZiB2MyBhcnJheSAqLwogfTsKIAotLSAKMi43LjQK
Cg==

--_003_VI1PR04MB454302BAF353124ED13747DC892D0VI1PR04MB4543eurp_
Content-Type: application/octet-stream;
	name="0006-spi-spi-imx-fix-ERR009165.patch"
Content-Description: 0006-spi-spi-imx-fix-ERR009165.patch
Content-Disposition: attachment;
	filename="0006-spi-spi-imx-fix-ERR009165.patch"; size=1635;
	creation-date="Tue, 09 Apr 2019 03:25:48 GMT";
	modification-date="Tue, 09 Apr 2019 03:25:48 GMT"
Content-Transfer-Encoding: base64

RnJvbSBhYTE5OGMzMjY1ZmI1NGQ0MjcxNWM1ZmE0YzI1ZDE1YTczYWQ5MzRjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBSb2JpbiBHb25nIDx5aWJpbi5nb25nQG54cC5jb20+CkRhdGU6
IFRodSwgMjggTWFyIDIwMTkgMTY6Mzg6MTMgKzA4MDAKU3ViamVjdDogW1BBVENIIDYvNl0gc3Bp
OiBzcGktaW14OiBmaXggRVJSMDA5MTY1CgpDaGFuZ2UgdG8gWENIICBtb2RlIGV2ZW4gaW4gZG1h
IG1vZGUsIHBsZWFzZSByZWZlciB0byBiZWxvdwplcnJhdGE6Cmh0dHBzOi8vd3d3Lm54cC5jb20v
ZG9jcy9lbi9lcnJhdGEvSU1YNkRRQ0UucGRmCgpTaWduZWQtb2ZmLWJ5OiBSb2JpbiBHb25nIDx5
aWJpbi5nb25nQG54cC5jb20+Ci0tLQogZHJpdmVycy9zcGkvc3BpLWlteC5jIHwgOCArKy0tLS0t
LQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkKCmRpZmYg
LS1naXQgYS9kcml2ZXJzL3NwaS9zcGktaW14LmMgYi9kcml2ZXJzL3NwaS9zcGktaW14LmMKaW5k
ZXggMDljOWExZS4uMDRhZjg0ZCAxMDA2NDQKLS0tIGEvZHJpdmVycy9zcGkvc3BpLWlteC5jCisr
KyBiL2RyaXZlcnMvc3BpL3NwaS1pbXguYwpAQCAtNTg1LDggKzU4NSw5IEBAIHN0YXRpYyBpbnQg
bXg1MV9lY3NwaV9wcmVwYXJlX3RyYW5zZmVyKHN0cnVjdCBzcGlfaW14X2RhdGEgKnNwaV9pbXgs
CiAJY3RybCB8PSBteDUxX2Vjc3BpX2Nsa2RpdihzcGlfaW14LCB0LT5zcGVlZF9oeiwgJmNsayk7
CiAJc3BpX2lteC0+c3BpX2J1c19jbGsgPSBjbGs7CiAKKwkvKiBFUlIwMDkxNjU6IHdvcmsgaW4g
WEhDIG1vZGUgYXMgUElPICovCiAJaWYgKHNwaV9pbXgtPnVzZWRtYSkKLQkJY3RybCB8PSBNWDUx
X0VDU1BJX0NUUkxfU01DOworCQljdHJsICY9IH5NWDUxX0VDU1BJX0NUUkxfU01DOwogCiAJd3Jp
dGVsKGN0cmwsIHNwaV9pbXgtPmJhc2UgKyBNWDUxX0VDU1BJX0NUUkwpOwogCkBAIC02MTcsNyAr
NjE4LDYgQEAgc3RhdGljIHZvaWQgbXg1MV9zZXR1cF93bWwoc3RydWN0IHNwaV9pbXhfZGF0YSAq
c3BpX2lteCkKIAkgKiBhbmQgZW5hYmxlIERNQSByZXF1ZXN0LgogCSAqLwogCXdyaXRlbChNWDUx
X0VDU1BJX0RNQV9SWF9XTUwoc3BpX2lteC0+d21sIC0gMSkgfAotCQlNWDUxX0VDU1BJX0RNQV9U
WF9XTUwoc3BpX2lteC0+d21sKSB8CiAJCU1YNTFfRUNTUElfRE1BX1JYVF9XTUwoc3BpX2lteC0+
d21sKSB8CiAJCU1YNTFfRUNTUElfRE1BX1RFREVOIHwgTVg1MV9FQ1NQSV9ETUFfUlhERU4gfAog
CQlNWDUxX0VDU1BJX0RNQV9SWFRERU4sIHNwaV9pbXgtPmJhc2UgKyBNWDUxX0VDU1BJX0RNQSk7
CkBAIC0xMjY1LDEwICsxMjY1LDYgQEAgc3RhdGljIGludCBzcGlfaW14X3NkbWFfaW5pdChzdHJ1
Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBzcGlfaW14X2RhdGEgKnNwaV9pbXgsCiB7CiAJaW50IHJl
dDsKIAotCS8qIHVzZSBwaW8gbW9kZSBmb3IgaS5teDZkbCBjaGlwIFRLVDIzODI4NSAqLwotCWlm
IChvZl9tYWNoaW5lX2lzX2NvbXBhdGlibGUoImZzbCxpbXg2ZGwiKSkKLQkJcmV0dXJuIDA7Ci0K
IAlzcGlfaW14LT53bWwgPSBzcGlfaW14LT5kZXZ0eXBlX2RhdGEtPmZpZm9fc2l6ZSAvIDI7CiAK
IAkvKiBQcmVwYXJlIGZvciBUWCBETUE6ICovCi0tIAoyLjcuNAoK

--_003_VI1PR04MB454302BAF353124ED13747DC892D0VI1PR04MB4543eurp_--
