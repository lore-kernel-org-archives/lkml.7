Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1D7AC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 07:35:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A9E8217F4
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 07:35:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZSngKyKf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732002AbfDAHfU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 03:35:20 -0400
Received: from mail-eopbgr30073.outbound.protection.outlook.com ([40.107.3.73]:35766
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731833AbfDAHfT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 03:35:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6xmoEI/UtKhw2lnQpHmMAI70+AO9+SI4gJjahRm7Gcs=;
 b=ZSngKyKfNHsSbsABRcV3M0gg3Txm1q11IIL9TVUn/+rQ06YLKRGw898FHT7PtbJrSUhKU9slptg87Np/mSe2FR0r+v0MZphLeJ9xg/lv5ZWYNIv3lgblnOzxc+hZzj25RzdGwVH+JWLse5RTcV1WVwGnXnN8MufsiwBfpFSW5vA=
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com (20.177.55.90) by
 VI1PR04MB5248.eurprd04.prod.outlook.com (20.177.51.213) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.15; Mon, 1 Apr 2019 07:35:14 +0000
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::114f:6d7f:7a68:9b23]) by VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::114f:6d7f:7a68:9b23%2]) with mapi id 15.20.1750.014; Mon, 1 Apr 2019
 07:35:14 +0000
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
Thread-Index: AQHU5MQedyysM/Gs0UKoyWKgyiIok6YgnCuAgAADPICAACYCkIAAHYGAgAEpjtA=
Date:   Mon, 1 Apr 2019 07:35:13 +0000
Message-ID: <VI1PR04MB4543B1708FA151EED0CB722A89550@VI1PR04MB4543.eurprd04.prod.outlook.com>
References: <08fcbd65-510f-84f8-d6d6-ff56aa9ca9ad@gmail.com>
 <20190328065247.uz73lap7ljf5q3tb@pengutronix.de>
 <b8e80127-e377-9ef9-2447-b0126fdad7dc@gmail.com>
 <VI1PR04MB45438E01D91829849A4E0BB289590@VI1PR04MB4543.eurprd04.prod.outlook.com>
 <d7a2e5c5-4ee0-8c89-1bab-654db0ae38dd@gmail.com>
In-Reply-To: <d7a2e5c5-4ee0-8c89-1bab-654db0ae38dd@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0827722e-6fd0-4521-6b6e-08d6b674944f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB5248;
x-ms-traffictypediagnostic: VI1PR04MB5248:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <VI1PR04MB5248C2E962FDA0802C69687489550@VI1PR04MB5248.eurprd04.prod.outlook.com>
x-forefront-prvs: 0994F5E0C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(39860400002)(396003)(346002)(136003)(31014005)(189003)(199004)(13464003)(7696005)(76176011)(14454004)(478600001)(7416002)(4326008)(5660300002)(256004)(25786009)(81156014)(106356001)(93886005)(186003)(8676002)(7736002)(3846002)(6306002)(9686003)(26005)(66066001)(486006)(45080400002)(6116002)(86362001)(105586002)(2906002)(74316002)(229853002)(446003)(55016002)(6436002)(6246003)(81166006)(102836004)(97736004)(476003)(53546011)(71200400001)(68736007)(53936002)(966005)(71190400001)(8936002)(54906003)(305945005)(33656002)(52536014)(11346002)(6506007)(316002)(99286004)(110136005)(5024004)(66574012);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5248;H:VI1PR04MB4543.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: pOS0WSeUaMnHrvq4IQBDsErmQrQD0GK7NbF5SEFK+ZYkez2kPjhkCdA1Fr8fl+O6RxBRD45JHaMaNI+uZu//eZY2kiTQj8du1QC78EZ5tqJGTITtsV9yQL17xbJMQGBKVwCDCS+xRZCutND6qxznXEX5VkUwjd1dO450hXbInMiop5uatByYw33CFeKgFPHY26NHac8R9AOKaOGX5KS2KHbmUGtKa+NjXaEiaLFTklCOIzJYT8HR+nLZddQ8F7OrSqTrt0D2KcFm2iWowRvGK5sDp0Wbl1jyeFrG1q7liEcxQcNVTkbKv/K+OOu5WRGsTpqWjgvHDYaebmc1cu1CupWjXxGqQPFwn3k1sx2VOfpBW4OQ4UzuJnwXF8kS1l3RXSbLywpNxFAGBA7gNNbUKHfdOLUnZ7BfeM9AZ3alrFI=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0827722e-6fd0-4521-6b6e-08d6b674944f
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2019 07:35:13.9137
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5248
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBJZ29yIFBseWF0b3YgPHBseWF0
b3ZAZ21haWwuY29tPg0KPiBTZW50OiAyMDE55bm0M+aciDI45pelIDE5OjA2DQo+IFRvOiBSb2Jp
biBHb25nIDx5aWJpbi5nb25nQG54cC5jb20+OyBVd2UgS2xlaW5lLUvDtm5pZw0KPiA8dS5rbGVp
bmUta29lbmlnQHBlbmd1dHJvbml4LmRlPg0KPiBDYzogbGludXgta2VybmVsQHZnZXIua2VybmVs
Lm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOw0KPiBsaW51eC1zcGlA
dmdlci5rZXJuZWwub3JnOyBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAuY29tPjsgRmFiaW8g
RXN0ZXZhbQ0KPiA8ZmVzdGV2YW1AZ21haWwuY29tPjsgUGVuZ3V0cm9uaXggS2VybmVsIFRlYW0g
PGtlcm5lbEBwZW5ndXRyb25peC5kZT47DQo+IFNhc2NoYSBIYXVlciA8cy5oYXVlckBwZW5ndXRy
b25peC5kZT47IFNoYXduIEd1bw0KPiA8c2hhd25ndW9Aa2VybmVsLm9yZz47IE1hcmsgQnJvd24g
PGJyb29uaWVAa2VybmVsLm9yZz47DQo+IGRtYWVuZ2luZUB2Z2VyLmtlcm5lbC5vcmc7IFZpbm9k
IEtvdWwgPHZrb3VsQGtlcm5lbC5vcmc+OyBEYW4gV2lsbGlhbXMNCj4gPGRhbi5qLndpbGxpYW1z
QGludGVsLmNvbT47IEFuZHkgRHVhbiA8ZnVnYW5nLmR1YW5AbnhwLmNvbT47IEhhbiBYdQ0KPiA8
aGFuLnh1QG54cC5jb20+OyBDbGFyayBXYW5nIDx4aWFvbmluZy53YW5nQG54cC5jb20+DQo+IFN1
YmplY3Q6IFJlOiBJc3N1ZXMgd2l0aCBpLk1YIFNQSSBETUEgdHJhbnNmZXJzDQo+IA0KPiBEZWFy
IFJvYmluLA0KPiANCj4gSSBoYXZlIGFwcGxpZWQgcGF0Y2hlcw0KPiAwMDAxLWRtYS1lbmdpbmUt
aW14LXNkbWEtYWRkLW1jdV8yX2Vjc3BpLXNjcmlwdC5wYXRjaCwNCj4gMDAwMi1zcGktc3BpLWlt
eC1maXgtRVJSMDA5MTY1LnBhdGNoIGFuZCBtYWRlIHRlc3RpbmcuDQo+IA0KPiBSZXN1bHRzIGFy
ZSBmb2xsb3dpbmc6DQo+IA0KPiByb290QGNyNzp+IyBzcGlkZXZfdGVzdCAtRCAvZGV2L3NwaWRl
djAuMCAtcyAxMjAwMDAwMCAtYiA4IC1TIDUxMiAtSQ0KPiAxMDAwMDAwMDAwMCAtbA0KPiBzcGkg
bW9kZTogMHgyMA0KPiBiaXRzIHBlciB3b3JkOiA4DQo+IG1heCBzcGVlZDogMTIwMDAwMDAgSHog
KDEyMDAwIEtIeikNCj4gW8KgIDEzMy45ODc3OThdIHNwaV9pbXggMjAwODAwMC5zcGk6IEkvTyBF
cnJvciBpbiBETUEgVFggW8KgIDEzMy45OTI4MTBdDQo+IHNwaWRldiBzcGkwLjA6IFNQSSB0cmFu
c2ZlciBmYWlsZWQ6IC0xMTAgW8KgIDEzMy45OTc4NjBdIHNwaV9tYXN0ZXIgc3BpMDogZmFpbGVk
DQo+IHRvIHRyYW5zZmVyIG9uZSBtZXNzYWdlIGZyb20gcXVldWUgY2FuJ3Qgc2VuZCBzcGkgbWVz
c2FnZTogQ29ubmVjdGlvbiB0aW1lZA0KPiBvdXQgQWJvcnRlZCAoY29yZSBkdW1wZWQpDQo+IA0K
PiByb290QGNyNzp+IyBzcGlkZXZfdGVzdCAtRCAvZGV2L3NwaWRldjEuMCAtcyAxMjAwMDAwMCAt
YiA4IC1TIDUxMiAtSQ0KPiAxMDAwMDAwMDAwMCAtbA0KPiBzcGkgbW9kZTogMHgyMA0KPiBiaXRz
IHBlciB3b3JkOiA4DQo+IG1heCBzcGVlZDogMTIwMDAwMDAgSHogKDEyMDAwIEtIeikNCj4gW8Kg
IDQ4My41MzA4MTVdIHNwaV9pbXggMjAwYzAwMC5zcGk6IEkvTyBFcnJvciBpbiBETUEgVFggW8Kg
IDQ4My41MzU4MjVdDQo+IHNwaWRldiBzcGkxLjA6IFNQSSB0cmFuc2ZlciBmYWlsZWQ6IC0xMTAg
W8KgIDQ4My41NDA4NzNdIHNwaV9tYXN0ZXIgc3BpMTogZmFpbGVkDQo+IHRvIHRyYW5zZmVyIG9u
ZSBtZXNzYWdlIGZyb20gcXVldWUgY2FuJ3Qgc2VuZCBzcGkgbWVzc2FnZTogQ29ubmVjdGlvbiB0
aW1lZA0KPiBvdXQgQWJvcnRlZCAoY29yZSBkdW1wZWQpDQo+IA0KPiByb290QGNyNzp+IyBzcGlk
ZXZfdGVzdCAtRCAvZGV2L3NwaWRldjQuMCAtcyAxMjAwMDAwMCAtYiA4IC1TIDUxMiAtSQ0KPiAx
MDAwMDAwMDAwMCAtbA0KPiBzcGkgbW9kZTogMHgyMA0KPiBiaXRzIHBlciB3b3JkOiA4DQo+IG1h
eCBzcGVlZDogMTIwMDAwMDAgSHogKDEyMDAwIEtIeikNCj4gW8KgwqAgOTQuMjI4Nzc0XSBzcGlf
aW14IDIwMTgwMDAuc3BpOiBJL08gRXJyb3IgaW4gRE1BIFRYIFvCoMKgIDk0LjIzMzc4OF0NCj4g
c3BpZGV2IHNwaTQuMDogU1BJIHRyYW5zZmVyIGZhaWxlZDogLTExMCBbwqDCoCA5NC4yMzg4Mzdd
IHNwaV9tYXN0ZXIgc3BpNDogZmFpbGVkDQo+IHRvIHRyYW5zZmVyIG9uZSBtZXNzYWdlIGZyb20g
cXVldWUgY2FuJ3Qgc2VuZCBzcGkgbWVzc2FnZTogQ29ubmVjdGlvbiB0aW1lZA0KPiBvdXQgQWJv
cnRlZCAoY29yZSBkdW1wZWQpDQo+IA0KPiBCZXN0IHdpc2hlcy4NCj4gDQo+IC0tDQo+IA0KPiBJ
Z29yIFBseWF0b3YNCj4gDQo+IA0KPiA+IEhpIElnb3IsDQpTb3JyeS4uLmJlbG93IGFub3RoZXIg
c2RtYSBwYXRjaChhZDBkOTJkN2JhNmEpIG5lZWQgdG8gYmUgcmV2ZXJ0ZWQsIGJlY2F1c2UNCnNw
aSBkcml2ZXIgbWF5IGR5bmFtaWNhbGx5IGNoYW5nZSBidXJzdCBsZW5ndGguDQo+ID4gCVBsZWFz
ZSBoYXZlIGEgdHJ5IHdpdGggdGhlIGF0dGFjaGVkIHBhdGNoLCBhc3N1bWUgeW91IGhhdmUgYWxy
ZWFkeQ0KPiA+IHVzZWQgdGhlIHNkbWEgZmlybXdhcmUgIEZyb20NCj4gPiBodHRwczovL2V1cjAx
LnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZnaXQu
DQo+ID4NCj4ga2VybmVsLm9yZyUyRnB1YiUyRnNjbSUyRmxpbnV4JTJGa2VybmVsJTJGZ2l0JTJG
ZmlybXdhcmUlMkZsaW51eC1maXJtDQo+IHcNCj4gPg0KPiBhcmUuZ2l0JTJGdHJlZSUyRmlteCUy
RnNkbWElMkZzZG1hLWlteDZxLmJpbiZhbXA7ZGF0YT0wMiU3QzAxJTdDDQo+IHlpYmluLg0KPiA+
DQo+IGdvbmclNDBueHAuY29tJTdDYzBkYThhMTEyMWY1NDk4YWU2YjgwOGQ2YjM2ZDVlNzAlN0M2
ODZlYTFkM2JjMg0KPiBiNGM2ZmE5DQo+ID4NCj4gMmNkOTljNWMzMDE2MzUlN0MwJTdDMSU3QzYz
Njg5MzY3OTY0NDYzMDAzNCZhbXA7c2RhdGE9amdaVjF0ajNNDQo+IGhGWGozWE4NCj4gPiBON01C
UXpxd3BFUEVvWmNxNlA1ZUJxRUJVbHclM0QmYW1wO3Jlc2VydmVkPTANCj4gPj4gLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4gRnJvbTogSWdvciBQbHlhdG92IDxwbHlhdG92QGdtYWls
LmNvbT4NCj4gPj4gU2VudDogMjAxOeW5tDPmnIgyOOaXpSAxNTowNA0KPiA+PiBUbzogVXdlIEts
ZWluZS1Lw7ZuaWcgPHUua2xlaW5lLWtvZW5pZ0BwZW5ndXRyb25peC5kZT4NCj4gPj4gQ2M6IGxp
bnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+ID4+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMu
aW5mcmFkZWFkLm9yZzsNCj4gPj4gbGludXgtc3BpQHZnZXIua2VybmVsLm9yZzsgZGwtbGludXgt
aW14IDxsaW51eC1pbXhAbnhwLmNvbT47IEZhYmlvDQo+ID4+IEVzdGV2YW0gPGZlc3RldmFtQGdt
YWlsLmNvbT47IFBlbmd1dHJvbml4IEtlcm5lbCBUZWFtDQo+ID4+IDxrZXJuZWxAcGVuZ3V0cm9u
aXguZGU+OyBTYXNjaGEgSGF1ZXIgPHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU+Ow0KPiBTaGF3bg0K
PiA+PiBHdW8gPHNoYXduZ3VvQGtlcm5lbC5vcmc+OyBNYXJrIEJyb3duIDxicm9vbmllQGtlcm5l
bC5vcmc+Ow0KPiA+PiBkbWFlbmdpbmVAdmdlci5rZXJuZWwub3JnOyBWaW5vZCBLb3VsIDx2a291
bEBrZXJuZWwub3JnPjsgRGFuDQo+ID4+IFdpbGxpYW1zIDxkYW4uai53aWxsaWFtc0BpbnRlbC5j
b20+OyBBbmR5IER1YW4gPGZ1Z2FuZy5kdWFuQG54cC5jb20+Ow0KPiA+PiBIYW4gWHUgPGhhbi54
dUBueHAuY29tPjsgUm9iaW4gR29uZyA8eWliaW4uZ29uZ0BueHAuY29tPjsgQ2xhcmsNCj4gV2Fu
Zw0KPiA+PiA8eGlhb25pbmcud2FuZ0BueHAuY29tPg0KPiA+PiBTdWJqZWN0OiBSZTogSXNzdWVz
IHdpdGggaS5NWCBTUEkgRE1BIHRyYW5zZmVycw0KPiA+Pg0KPiA+PiBEZWFyIFV3ZSwNCj4gPj4N
Cj4gPj4NCj4gPj4+IEhlbGxvIElnb3IsDQo+ID4+Pg0KPiA+Pj4gT24gV2VkLCBNYXIgMjcsIDIw
MTkgYXQgMDg6NDA6MDBQTSArMDMwMCwgSWdvciBQbHlhdG92IHdyb3RlOg0KPiA+Pj4+IHBsZWFz
ZSwgaGVscCB0byByZXNvbHZlIHR3byBpc3N1ZXMgd2l0aCBTUEkgRE1BIHRyYW5zZmVycyBhdCBp
Lk1YNlENCj4gPj4+PiBwbGF0Zm9ybS4NCj4gPj4+Pg0KPiA+Pj4+IEZpcnN0IGlzc3VlIGlzDQo+
ID4+Pj4gICDCoFsgNDQ2NS4wMDgwMDNdIHNwaV9tYXN0ZXIgc3BpMDogSS9PIEVycm9yIGluIERN
QSBSWA0KPiA+Pj4+DQo+ID4+Pj4gU2Vjb25kIGlzc3VlIGlzIGR1cGxpY2F0aW9uIGZvciBvbmUg
b2YgcmVjZWl2ZWQgYnl0ZXMuDQo+ID4+Pj4NCj4gPj4+PiBQcm9iYWJseSwgdGhlc2UgaXNzdWVz
IHJlbGF0ZWQgdG8gZWFjaCBvbmUuDQo+ID4+PiBUaGlzIGlzIHByb2JhYmx5IHRoZSBzYW1lIHBy
b2JsZW0gSSBoaXQgc29tZSB0aW1lIGFnby4gQ2hlY2sNCj4gPj4+IEVSUjAwOTE2NSBpbiB0aGUg
ZXJyYXRhLiBZb3UgZWl0aGVyIG5lZWQgdG8gZGlzYWJsZSBETUEgb3IgbmVlZCBhDQo+ID4+PiBm
aXhlZCBzZG1hLVNjcmlwdC4NCj4gPj4gZGlzYWJsaW5nIG9mIERNQSBpcyBub3QgYW4gb3B0aW9u
LCBiZWNhdXNlIGhpZ2ggdGhyb3VnaHB1dCByZXF1aXJlZA0KPiA+PiBmb3IgU1BJIGJ1cyB0byBj
b21tdW5pY2F0ZSB3aXRoIERTUHMuDQo+ID4+DQo+ID4+IEknbSBhd2FyZSBvZiBFUlIwMDkxNjUs
IGJ1dCBhcyBJIHdyaXRlIHNvbWUgbWludXRlcyBlYXJsaWVyIHRvIGxpc3QsDQo+ID4+IHNwaTAg
KGFsaWFzIGZvciBlY3NwaTEpIGFuZCBzcGkxIChhbGlhcyBmb3IgZWNzcGkyKSB3b3JrIGZsYXds
ZXNzLA0KPiA+PiB3aGlsZQ0KPiA+PiBzcGk0IChhbGlhcyBmb3IgZWNzcGk1KSBmYWlscyB2ZXJ5
IGZhc3QuDQo+ID4+DQo+ID4+IERvZXMgc2FtZSBTRE1BIHNjcmlwdCB1c2VkIGZvciBhbGwgU1BJ
IGludGVyZmFjZXMgb3Igc2NyaXB0cyBhcmUgZGlmZmVyZW50Pw0KPiA+Pg0KPiA+PiBCZXN0IHdp
c2hlcy4NCj4gPj4NCj4gPj4gLS0NCj4gPj4NCj4gPj4gSWdvciBQbHlhdG92DQo=
