Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35A79C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 08:33:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0EFE2084C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 08:33:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="SKmgsPYm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729510AbfDBId2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 04:33:28 -0400
Received: from mail-eopbgr20077.outbound.protection.outlook.com ([40.107.2.77]:27928
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725884AbfDBId2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 04:33:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gbB9r2hDpM58Ht2zDBjAuu5lNyHBzwCL1492q20n1Yg=;
 b=SKmgsPYmh30ICKjClJZafIrMO64T6qIS4ZSLPtq1aAIejGf3n7rtNTltuSjO34l9cFJmpXVXRYeWU6ldrWyTl/bZjxJzlkpEie684xzFojrSTxQF0yODyaidEQZvtqpun49taSpd/ElTL/m8Ytn1nsBdba1X9M2oED95FD9yhAI=
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com (20.177.55.90) by
 VI1PR04MB4142.eurprd04.prod.outlook.com (52.133.14.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.17; Tue, 2 Apr 2019 08:32:44 +0000
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::114f:6d7f:7a68:9b23]) by VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::114f:6d7f:7a68:9b23%2]) with mapi id 15.20.1750.014; Tue, 2 Apr 2019
 08:32:44 +0000
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
Thread-Index: AQHU5MQedyysM/Gs0UKoyWKgyiIok6YgnCuAgAADPICAACYCkIAAHYGAgAEpjtCABnMWgIAAEhKQ
Date:   Tue, 2 Apr 2019 08:32:44 +0000
Message-ID: <VI1PR04MB454305A56372466A38E9F81989560@VI1PR04MB4543.eurprd04.prod.outlook.com>
References: <08fcbd65-510f-84f8-d6d6-ff56aa9ca9ad@gmail.com>
 <20190328065247.uz73lap7ljf5q3tb@pengutronix.de>
 <b8e80127-e377-9ef9-2447-b0126fdad7dc@gmail.com>
 <VI1PR04MB45438E01D91829849A4E0BB289590@VI1PR04MB4543.eurprd04.prod.outlook.com>
 <d7a2e5c5-4ee0-8c89-1bab-654db0ae38dd@gmail.com>
 <VI1PR04MB4543B1708FA151EED0CB722A89550@VI1PR04MB4543.eurprd04.prod.outlook.com>
 <95df9334-3d0c-7d13-e431-5a4aa2b9907e@gmail.com>
In-Reply-To: <95df9334-3d0c-7d13-e431-5a4aa2b9907e@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f13bd1a1-dfd9-4f35-be9d-08d6b745c764
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VI1PR04MB4142;
x-ms-traffictypediagnostic: VI1PR04MB4142:
x-microsoft-antispam-prvs: <VI1PR04MB4142376C5A3F9699AF33CC7D89560@VI1PR04MB4142.eurprd04.prod.outlook.com>
x-forefront-prvs: 0995196AA2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(366004)(346002)(136003)(39860400002)(13464003)(199004)(189003)(45904002)(446003)(54906003)(9686003)(52536014)(5660300002)(305945005)(11346002)(66066001)(68736007)(93886005)(110136005)(14454004)(86362001)(486006)(25786009)(476003)(26005)(106356001)(316002)(478600001)(6436002)(2906002)(105586002)(76176011)(7696005)(256004)(33656002)(3846002)(99286004)(53546011)(6506007)(229853002)(186003)(6116002)(81156014)(7416002)(102836004)(97736004)(74316002)(4326008)(55016002)(53936002)(7736002)(8676002)(6246003)(81166006)(71190400001)(71200400001)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4142;H:VI1PR04MB4543.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 0e0vMrZkWfZSrjxphEX3ClVY530b5YViRRWS+6CY8kJgOYkcxdTuh1Uja2+IpqzMDlTDpncRdoH6GaTAcUKlQubf6I2SiczOrySdUtIq9bnoUTk3Zf0dur/n2DocHPdB/Z4g68a+GSwon7O9BvzPNySAYLTmDppg2Ij4UAc6LTMDqtq0DrrPLLUfdZnY82aPFZOVpBmqXowdTse2i+/FnQWd5RwY4nelMF35jI3ZbLhTZwXsz5GFI5xoxXfd6HAWmGBnpGbkTTB6rJaEm1PCTCVGRk1Ik1nr99oTWt2JwvaK7VilHqKpbryBGf1H2cIb4uL3vZKIW/SSJoB95gFPbk4Bu3h3hPe/HWa+mynC0bKe+oecXWeRs+uAQqk0JK3mSDrnkW4cgZFdFe0SNoJFqX1IS3GYr6imNuTjYg6ur/s=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f13bd1a1-dfd9-4f35-be9d-08d6b745c764
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2019 08:32:44.4267
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4142
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBJZ29yIFBseWF0b3YgPHBseWF0
b3ZAZ21haWwuY29tPg0KPiBTZW50OiAyMDE55bm0NOaciDLml6UgMTU6MjANCj4gVG86IFJvYmlu
IEdvbmcgPHlpYmluLmdvbmdAbnhwLmNvbT47IFV3ZSBLbGVpbmUtS8O2bmlnDQo+IDx1LmtsZWlu
ZS1rb2VuaWdAcGVuZ3V0cm9uaXguZGU+DQo+IENjOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwu
b3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+IGxpbnV4LXNwaUB2
Z2VyLmtlcm5lbC5vcmc7IGRsLWxpbnV4LWlteCA8bGludXgtaW14QG54cC5jb20+OyBGYWJpbyBF
c3RldmFtDQo+IDxmZXN0ZXZhbUBnbWFpbC5jb20+OyBQZW5ndXRyb25peCBLZXJuZWwgVGVhbSA8
a2VybmVsQHBlbmd1dHJvbml4LmRlPjsNCj4gU2FzY2hhIEhhdWVyIDxzLmhhdWVyQHBlbmd1dHJv
bml4LmRlPjsgU2hhd24gR3VvDQo+IDxzaGF3bmd1b0BrZXJuZWwub3JnPjsgTWFyayBCcm93biA8
YnJvb25pZUBrZXJuZWwub3JnPjsNCj4gZG1hZW5naW5lQHZnZXIua2VybmVsLm9yZzsgVmlub2Qg
S291bCA8dmtvdWxAa2VybmVsLm9yZz47IERhbiBXaWxsaWFtcw0KPiA8ZGFuLmoud2lsbGlhbXNA
aW50ZWwuY29tPjsgQW5keSBEdWFuIDxmdWdhbmcuZHVhbkBueHAuY29tPjsgSGFuIFh1DQo+IDxo
YW4ueHVAbnhwLmNvbT47IENsYXJrIFdhbmcgPHhpYW9uaW5nLndhbmdAbnhwLmNvbT4NCj4gU3Vi
amVjdDogUmU6IElzc3VlcyB3aXRoIGkuTVggU1BJIERNQSB0cmFuc2ZlcnMNCj4gDQo+IERlYXIg
Um9iaW4gR29uZywNCj4gDQo+IA0KPiA+PiBTb3JyeS4uLmJlbG93IGFub3RoZXIgc2RtYSBwYXRj
aChhZDBkOTJkN2JhNmEpIG5lZWQgdG8gYmUgcmV2ZXJ0ZWQsDQo+ID4+IGJlY2F1c2Ugc3BpIGRy
aXZlciBtYXkgZHluYW1pY2FsbHkgY2hhbmdlIGJ1cnN0IGxlbmd0aC4NCj4gDQo+IA0KPiBub3cg
SSBoYXZlIHJldmVydGVkIHBhdGNoIGFkMGQ5MmQ3YmE2YS4NCj4gDQo+IFBhdGNoZXMgMDAwMS1k
bWEtZW5naW5lLWlteC1zZG1hLWFkZC1tY3VfMl9lY3NwaS1zY3JpcHQucGF0Y2ggYW5kDQo+IDAw
MDItc3BpLXNwaS1pbXgtZml4LUVSUjAwOTE2NS5wYXRjaCBhcmUgYXBwbGllZC4NCj4gDQo+IA0K
PiBLZXJuZWwgbG9nIHNob3cgbWVzc2FnZXMNCj4gDQo+IFvCoMKgIDI5LjIwMjYzOV0gaW14LXNk
bWEgMjBlYzAwMC5zZG1hOiBsb2FkZWQgZmlybXdhcmUgMy4zDQo+IFvCoMKgIDI5LjIzODU5NV0g
c3BpX2lteCAyMDA4MDAwLnNwaTogcHJvYmVkDQo+IFvCoMKgIDI5LjI0MjgwMl0gc3BpX2lteCAy
MDBjMDAwLnNwaTogcHJvYmVkDQo+IFvCoMKgIDI5LjI0NTIxN10gc3BpX2lteCAyMDE4MDAwLnNw
aTogcHJvYmVkDQo+IA0KPiBTUEkgRE1BIHRyYW5zZmVycyBzdGlsbCBub3Qgd29yay4NCj4gDQo+
IElmIEkgdGVzdCAzMiBieXRlIHRyYW5zZmVycywgdGhlbiB0aGV5IHdvcmsgZmluZS4gQnV0IDY0
IGJ5dGUgdHJhbnNmZXJzDQo+IGZhaWxzIGFsd2F5cyBhbmQgSSBzZWUgZXJyb3IgbWVzc2FnZXMN
Cj4gDQo+IHJvb3RAY3I3On4jIHNwaWRldl90ZXN0IC1EIC9kZXYvc3BpZGV2NC4xIC1zIDEyMDAw
MDAgLWIgOCAtUyA2NCAtSSAxIC1sDQo+IHNwaSBtb2RlOiAweDIwDQo+IGJpdHMgcGVyIHdvcmQ6
IDgNCj4gbWF4IHNwZWVkOiAxMjAwMDAwIEh6ICgxMjAwIEtIeikNCj4gW8KgIDQyMy42ODY3MzZd
IHNwaV9tYXN0ZXIgc3BpNDogSS9PIEVycm9yIGluIERNQSBSWA0KPiBbwqAgNDIzLjY5MTM5Ml0g
c3BpZGV2IHNwaTQuMTogU1BJIHRyYW5zZmVyIGZhaWxlZDogLTExMA0KPiBbwqAgNDIzLjY5NjM4
Ml0gc3BpX21hc3RlciBzcGk0OiBmYWlsZWQgdG8gdHJhbnNmZXIgb25lIG1lc3NhZ2UgZnJvbSBx
dWV1ZQ0KPiBjYW4ndCBzZW5kIHNwaSBtZXNzYWdlOiBDb25uZWN0aW9uIHRpbWVkIG91dA0KPiBB
Ym9ydGVkIChjb3JlIGR1bXBlZCkNCj4gDQo+IEkgc3VwcG9zZSwgdHJhbnNmZXJzIHNob3J0ZXIg
dGhlbiA2NCBieXRlcyBtYWRlIHdpdGggaGVscCBvZiBQSU8uDQo+IA0KPiBSb2JpbiwgaXMgdGhl
cmUgYW55IGNoYW5jZSBmb3IgeW91IHRvIGZpbmQgc29tZSB0aW1lIGFuZCBsb29rIGF0IHRoaXMN
Cj4gaXNzdWUgYWdhaW4/DQpJIGhhdmUgcXVpY2sgdGVzdCB3aXRoIHNwaWRldl90ZXN0IGxvb3Bi
YWNrLCBidXQgZGlkbid0IG1lZXQgeW91ciBlcnJvciwNCklzIHlvdXIgY29kZSB0aGUgYWxtb3N0
IGxhdGVzdCBjb2RlIGluIGxpbnV4LW5leHQgYXMgbWluZT8NCg0Kcm9vdEBpbXg2cXBkbHNvbG94
On4jIGNhdCAvcHJvYy9pbnRlcnJ1cHRzIHwgZ3JlcCBzZG1hDQogNDg6ICAgICAgICAgMzcgICAg
ICAgR1BDICAgMiBMZXZlbCAgICAgc2RtYQ0KIC1sdEBpbXg2cXBkbHNvbG94On4jIC4vc3BpZGV2
X3Rlc3QgLUQgL2Rldi9zcGlkZXYwLjAgLXMgMTIwMDAwMCAtYiA4IC1TIDY0IC1JIDEgLWwNCnNw
aSBtb2RlOiAweDIwDQpiaXRzIHBlciB3b3JkOiA4DQptYXggc3BlZWQ6IDEyMDAwMDAgSHogKDEy
MDAgS0h6KQ0Kcm9vdEBpbXg2cXBkbHNvbG94On4jIGNhdCAvcHJvYy9pbnRlcnJ1cHRzIHwgZ3Jl
cCBzZG1hDQogNDg6ICAgICAgICAgNDMgICAgICAgR1BDICAgMiBMZXZlbCAgICAgc2RtYQ0KLi9z
cGlkZXZfdGVzdCAtRCAvZGV2L3NwaWRldjAuMCAtcyAxMjAwMDAwIC1iIDggLVMgNTEyIC1JIDEg
LWwNCnNwaSBtb2RlOiAweDIwDQpiaXRzIHBlciB3b3JkOiA4DQptYXggc3BlZWQ6IDEyMDAwMDAg
SHogKDEyMDAgS0h6KQ0KdG90YWw6IHR4IDAuNUtCLCByeCAwLjVLQg0KPiANCj4gQmVzdCB3aXNo
ZXMuDQo+IC0tDQo+IElnb3IgUGx5YXRvdg0K
