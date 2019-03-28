Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D02F7C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 07:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9409C20657
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 07:21:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="BMGgQjQj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbfC1HVe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 03:21:34 -0400
Received: from mail-eopbgr70057.outbound.protection.outlook.com ([40.107.7.57]:33867
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725779AbfC1HVd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 03:21:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l0MlZX3xDqyDbUYm4ylLpVHVh+0ZhHQpkQh1xCqju+c=;
 b=BMGgQjQjf3TmKPZmbPlG+Augehwdaga9fdH5jk7mb4IhAeVDFNWOQmY9QxMenWaFHhiJDFV6bVwnD4d70LohBDi27sOJy0Eva0pLw0dQEcKK9m1r+OTfiO1R0AIpcFxhGuO7oSEQRkwPjnY71FWeau1z3LfwcqpUeSBwP6bnlCI=
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com (20.177.55.90) by
 VI1PR04MB4911.eurprd04.prod.outlook.com (20.177.49.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.15; Thu, 28 Mar 2019 07:21:28 +0000
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::114f:6d7f:7a68:9b23]) by VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::114f:6d7f:7a68:9b23%2]) with mapi id 15.20.1750.014; Thu, 28 Mar 2019
 07:21:28 +0000
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
Thread-Index: AQHU5MQedyysM/Gs0UKoyWKgyiIok6YgnCuAgAADPICAAAKMcA==
Date:   Thu, 28 Mar 2019 07:21:27 +0000
Message-ID: <VI1PR04MB45433F57929ABE7B5F8803B989590@VI1PR04MB4543.eurprd04.prod.outlook.com>
References: <08fcbd65-510f-84f8-d6d6-ff56aa9ca9ad@gmail.com>
 <20190328065247.uz73lap7ljf5q3tb@pengutronix.de>
 <b8e80127-e377-9ef9-2447-b0126fdad7dc@gmail.com>
In-Reply-To: <b8e80127-e377-9ef9-2447-b0126fdad7dc@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b94eec70-fb35-4889-c120-08d6b34dfe66
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4911;
x-ms-traffictypediagnostic: VI1PR04MB4911:
x-microsoft-antispam-prvs: <VI1PR04MB49114049A569212DCA1AB00189590@VI1PR04MB4911.eurprd04.prod.outlook.com>
x-forefront-prvs: 0990C54589
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(366004)(136003)(396003)(39860400002)(189003)(199004)(31014005)(13464003)(7416002)(102836004)(53936002)(55016002)(7696005)(26005)(2906002)(97736004)(6436002)(186003)(68736007)(305945005)(33656002)(486006)(14454004)(105586002)(81156014)(3846002)(7736002)(8676002)(6116002)(81166006)(74316002)(53546011)(256004)(229853002)(99286004)(446003)(25786009)(4326008)(11346002)(66066001)(9686003)(478600001)(316002)(476003)(110136005)(54906003)(76176011)(52536014)(106356001)(8936002)(71190400001)(71200400001)(6506007)(66574012)(86362001)(5660300002)(6246003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4911;H:VI1PR04MB4543.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: apDXOqd/es56MwqkvQ2cDNYPw11n9CPOL3CzA1gSNdkMxRBdaUkE0b2LkxB1f2mz8NsTUWpGCvIA+6Qgo32ar6sVCaNHvhIscvD93xcPbWyMoCfXkRORs5HPQrDGjcZtJj8Drwd32ZvibmP0iQtyCUoEU7ru49BCLa0DABTqswx1mTrMwtuuFn1U+qhqbpmHGClhvWQKcflNYL1FrNMo1Bjt16aYYPFQM9vQ9bKXuNOVY8GXaWo2AH5iN+F4MwSVN7FfE24o+dBxvU9pzUSpWWqalKWM4iXTOPf13/unvGl+6+VvTA4VkbdUSFuXYy9OEJt54o8OCPn11rv3StQHC7GIwtb+FYi5US2rUwF32A25UcdEFTMew6P2YZdN8JizhWLFDWe9Ppst4++2MG2qXY8bYxigg+PYypQS5yGtkm8=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b94eec70-fb35-4889-c120-08d6b34dfe66
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2019 07:21:28.0904
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4911
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSWdvciBQbHlhdG92IDxw
bHlhdG92QGdtYWlsLmNvbT4NCj4gU2VudDogMjAxOeW5tDPmnIgyOOaXpSAxNTowNA0KPiBUbzog
VXdlIEtsZWluZS1Lw7ZuaWcgPHUua2xlaW5lLWtvZW5pZ0BwZW5ndXRyb25peC5kZT4NCj4gQ2M6
IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5m
cmFkZWFkLm9yZzsNCj4gbGludXgtc3BpQHZnZXIua2VybmVsLm9yZzsgZGwtbGludXgtaW14IDxs
aW51eC1pbXhAbnhwLmNvbT47IEZhYmlvIEVzdGV2YW0NCj4gPGZlc3RldmFtQGdtYWlsLmNvbT47
IFBlbmd1dHJvbml4IEtlcm5lbCBUZWFtIDxrZXJuZWxAcGVuZ3V0cm9uaXguZGU+Ow0KPiBTYXNj
aGEgSGF1ZXIgPHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU+OyBTaGF3biBHdW8NCj4gPHNoYXduZ3Vv
QGtlcm5lbC5vcmc+OyBNYXJrIEJyb3duIDxicm9vbmllQGtlcm5lbC5vcmc+Ow0KPiBkbWFlbmdp
bmVAdmdlci5rZXJuZWwub3JnOyBWaW5vZCBLb3VsIDx2a291bEBrZXJuZWwub3JnPjsgRGFuIFdp
bGxpYW1zDQo+IDxkYW4uai53aWxsaWFtc0BpbnRlbC5jb20+OyBBbmR5IER1YW4gPGZ1Z2FuZy5k
dWFuQG54cC5jb20+OyBIYW4gWHUNCj4gPGhhbi54dUBueHAuY29tPjsgUm9iaW4gR29uZyA8eWli
aW4uZ29uZ0BueHAuY29tPjsgQ2xhcmsgV2FuZw0KPiA8eGlhb25pbmcud2FuZ0BueHAuY29tPg0K
PiBTdWJqZWN0OiBSZTogSXNzdWVzIHdpdGggaS5NWCBTUEkgRE1BIHRyYW5zZmVycw0KPiANCj4g
RGVhciBVd2UsDQo+IA0KPiANCj4gPiBIZWxsbyBJZ29yLA0KPiA+DQo+ID4gT24gV2VkLCBNYXIg
MjcsIDIwMTkgYXQgMDg6NDA6MDBQTSArMDMwMCwgSWdvciBQbHlhdG92IHdyb3RlOg0KPiA+PiBw
bGVhc2UsIGhlbHAgdG8gcmVzb2x2ZSB0d28gaXNzdWVzIHdpdGggU1BJIERNQSB0cmFuc2ZlcnMg
YXQgaS5NWDZRDQo+ID4+IHBsYXRmb3JtLg0KPiA+Pg0KPiA+PiBGaXJzdCBpc3N1ZSBpcw0KPiA+
PiAgwqBbIDQ0NjUuMDA4MDAzXSBzcGlfbWFzdGVyIHNwaTA6IEkvTyBFcnJvciBpbiBETUEgUlgN
Cj4gPj4NCj4gPj4gU2Vjb25kIGlzc3VlIGlzIGR1cGxpY2F0aW9uIGZvciBvbmUgb2YgcmVjZWl2
ZWQgYnl0ZXMuDQo+ID4+DQo+ID4+IFByb2JhYmx5LCB0aGVzZSBpc3N1ZXMgcmVsYXRlZCB0byBl
YWNoIG9uZS4NCj4gPiBUaGlzIGlzIHByb2JhYmx5IHRoZSBzYW1lIHByb2JsZW0gSSBoaXQgc29t
ZSB0aW1lIGFnby4gQ2hlY2sgRVJSMDA5MTY1DQo+ID4gaW4gdGhlIGVycmF0YS4gWW91IGVpdGhl
ciBuZWVkIHRvIGRpc2FibGUgRE1BIG9yIG5lZWQgYSBmaXhlZA0KPiA+IHNkbWEtU2NyaXB0Lg0K
PiANCj4gZGlzYWJsaW5nIG9mIERNQSBpcyBub3QgYW4gb3B0aW9uLCBiZWNhdXNlIGhpZ2ggdGhy
b3VnaHB1dCByZXF1aXJlZCBmb3IgU1BJIGJ1cw0KPiB0byBjb21tdW5pY2F0ZSB3aXRoIERTUHMu
DQo+IA0KPiBJJ20gYXdhcmUgb2YgRVJSMDA5MTY1LCBidXQgYXMgSSB3cml0ZSBzb21lIG1pbnV0
ZXMgZWFybGllciB0byBsaXN0LA0KPiBzcGkwIChhbGlhcyBmb3IgZWNzcGkxKSBhbmQgc3BpMSAo
YWxpYXMgZm9yIGVjc3BpMikgd29yayBmbGF3bGVzcywgd2hpbGUNCj4gc3BpNCAoYWxpYXMgZm9y
IGVjc3BpNSkgZmFpbHMgdmVyeSBmYXN0Lg0KPiANCj4gRG9lcyBzYW1lIFNETUEgc2NyaXB0IHVz
ZWQgZm9yIGFsbCBTUEkgaW50ZXJmYWNlcyBvciBzY3JpcHRzIGFyZSBkaWZmZXJlbnQ/DQpObyBk
aWZmZXJlbnQgaGFuZGxlIGluc2lkZSBzZG1hIHNjcmlwdCBmb3IgZGlmZmVyZW50IGVjc3BpIHBv
cnQuIEFncmVlIFV3ZSwgeW91cg0KZHVwbGljYXRlIGRhdGEgY2F1Z2h0IHNlZW1zIGxpa2UgRVJS
MDA5MTY1LiBBbnl3YXkgSSdsbCBjcmVhdGUgZWNzcGkgcGF0Y2ggZm9yIHlvdQ0KdG8gdHJ5IGlu
IHRoZXNlIGRheXMuDQo+IA0KPiBCZXN0IHdpc2hlcy4NCj4gDQo+IC0tDQo+IA0KPiBJZ29yIFBs
eWF0b3YNCg0K
