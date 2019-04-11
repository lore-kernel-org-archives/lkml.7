Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 156C3C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 08:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF9AA20873
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 08:12:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="b8AoaIfO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbfDKIMz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 04:12:55 -0400
Received: from mail-eopbgr50045.outbound.protection.outlook.com ([40.107.5.45]:34176
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726121AbfDKIMy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 04:12:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uF3dHjpwJx1lqRcZ7cWajhKmeRQAzC/zjwGMipU/J04=;
 b=b8AoaIfOjDVlX+GpG8KDoVXnDnnTopAR0vqTjMEaLRvEmx3xQt966OrmY2ITSw+16m44AkSDXVWJIESVaRy62xJzqZEj4UYJlf4HO2VEamneo5A7FCgfnUZpTVSRKpZ2p7ygZ0cgvd4FW+OQ9cDTx+doMPV1oRANE4Tvgf6LpxM=
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com (52.135.138.152) by
 DB7PR04MB5948.eurprd04.prod.outlook.com (20.178.106.213) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.16; Thu, 11 Apr 2019 08:12:10 +0000
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::99f0:f8da:a123:e25]) by DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::99f0:f8da:a123:e25%3]) with mapi id 15.20.1792.009; Thu, 11 Apr 2019
 08:12:10 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        "wg@grandegger.com" <wg@grandegger.com>,
        "davem@davemloft.net" <davem@davemloft.net>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH] can: dev: clean up CAN ctrlmode when close CAN
 device
Thread-Topic: [EXT] Re: [PATCH] can: dev: clean up CAN ctrlmode when close CAN
 device
Thread-Index: AQHU72Z9hNDj4CvO1EGET8+N4jv3IKY0/IsAgAAH+tCAAKg+gIAAeBjggABew4CAABnCkA==
Date:   Thu, 11 Apr 2019 08:12:10 +0000
Message-ID: <DB7PR04MB461835BC43470079FE72BF38E62F0@DB7PR04MB4618.eurprd04.prod.outlook.com>
References: <20190410062533.31535-1-qiangqing.zhang@nxp.com>
 <39d8ef33-50c3-9b7a-88e1-8ef3a7fbac70@pengutronix.de>
 <DB7PR04MB4618D14BE595F3BDE46CBE17E62E0@DB7PR04MB4618.eurprd04.prod.outlook.com>
 <ad4c0921-3275-b466-95b4-a63944d5b71f@pengutronix.de>
 <DB7PR04MB4618D30C746B397F8C5308BAE62F0@DB7PR04MB4618.eurprd04.prod.outlook.com>
 <35c15351-5ae1-0826-1b05-95fe53272244@pengutronix.de>
In-Reply-To: <35c15351-5ae1-0826-1b05-95fe53272244@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=qiangqing.zhang@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f1674e0e-21ef-4f9c-e629-08d6be556582
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB7PR04MB5948;
x-ms-traffictypediagnostic: DB7PR04MB5948:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DB7PR04MB5948EEF807AFA43DC2A509D6E62F0@DB7PR04MB5948.eurprd04.prod.outlook.com>
x-forefront-prvs: 00046D390F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(136003)(376002)(39860400002)(396003)(13464003)(189003)(199004)(7736002)(102836004)(476003)(446003)(486006)(11346002)(7696005)(6436002)(53936002)(97736004)(76176011)(6246003)(71190400001)(186003)(2906002)(14444005)(53386004)(106356001)(74316002)(256004)(6116002)(3846002)(105586002)(66066001)(71200400001)(9686003)(6306002)(26005)(53546011)(6506007)(55016002)(305945005)(52536014)(99286004)(93886005)(14454004)(5660300002)(25786009)(508600001)(8936002)(81156014)(68736007)(966005)(86362001)(2201001)(229853002)(8676002)(110136005)(81166006)(2501003)(316002)(33656002)(54906003)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB5948;H:DB7PR04MB4618.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: XwAgJlK4P5JjRdBDZZ9XQ2KFybhL01bLypLyXOIJ7UDi5EI2JSy1hT4t9GyJQBOOB2Jgp+s/jlKR+W1TNEd7shq/wiIOqjL///8FUqYPKyeKuy9ihtGXcWs/EQOOMfj5d59P6cOWEw7gbSOrnKU13Fj1WUbHhXskks19coayy1ZKlLHPAhzqeX9QBAXbwjHhxxn23kaviwar2uzl149fuTbp5bckSHuNurKjlXFalAFeAIeUKzjsf8Dmyn5FJe7rfeHF0JGfrUQpjBLISfWEEgRkX6i69u784lsvi5WtIwlPHqA6z6eh/wSE0lndqJFEIsL9XC9JC4o0uqb3hVsLdls8WGkTfKUB6pBG4B5k9+48E/Ln0AIvx2iv2hi84dNjGojZaJmjFv0oUOO7cd8Ibak5rRVTEg3BUxjRZwe6Qsc=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1674e0e-21ef-4f9c-e629-08d6be556582
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2019 08:12:10.3288
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5948
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE1hcmMgS2xlaW5lLUJ1ZGRl
IDxta2xAcGVuZ3V0cm9uaXguZGU+DQo+IFNlbnQ6IDIwMTnlubQ05pyIMTHml6UgMTQ6MzkNCj4g
VG86IEpvYWtpbSBaaGFuZyA8cWlhbmdxaW5nLnpoYW5nQG54cC5jb20+OyB3Z0BncmFuZGVnZ2Vy
LmNvbTsNCj4gZGF2ZW1AZGF2ZW1sb2Z0Lm5ldA0KPiBDYzogZGwtbGludXgtaW14IDxsaW51eC1p
bXhAbnhwLmNvbT47IGxpbnV4LWNhbkB2Z2VyLmtlcm5lbC5vcmc7DQo+IG5ldGRldkB2Z2VyLmtl
cm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtF
WFRdIFJlOiBbUEFUQ0hdIGNhbjogZGV2OiBjbGVhbiB1cCBDQU4gY3RybG1vZGUgd2hlbiBjbG9z
ZQ0KPiBDQU4gZGV2aWNlDQo+IA0KPiBPbiA0LzExLzE5IDM6MTYgQU0sIEpvYWtpbSBaaGFuZyB3
cm90ZToNCj4gPj4gV2hhdGV2ZXIgbW9kZSB5b3UgZW5hYmxlIHZpYSB1c2VyIHNwYWNlIHVzZSB1
c2VyIHNwYWNlIHRvIGRpc2FibGUNCj4gPj4gdGhlbSBhZ2Fpbi4NCj4gPg0KPiA+IFRoYW5rIHlv
dSBmb3IgeW91ciBkZXRhaWxlZCBleHBsYW5hdGlvbi4gQnV0IGluIGZsZXhjYW4gZHJpdmVyLCBp
dA0KPiA+IGp1c3Qgc2V0IHJlZ2lzdGVyIGJpdCB3aGVuIG1vZGUgb24gYW5kIGRvIG5vdCBjbGVh
ciByZWdpc3RlciBiaXQgd2hlbg0KPiA+IG1vZGUgb2ZmLCBlLmcuIGxvb3BiYWNrLCBsaXN0ZW5u
b2x5LCAzIHNhbXBsZXMuLi4uDQo+IA0KPiBMZXQncyBzZWU6DQo+IA0KPiA+IAlyZWcgPSBwcml2
LT5yZWFkKCZyZWdzLT5jdHJsKTsNCj4gDQo+IFRoZSBjdHJsIHJlZyBpcyByZWFkDQo+IA0KPiA+
IAlyZWcgJj0gfihGTEVYQ0FOX0NUUkxfUFJFU0RJVigweGZmKSB8DQo+ID4gCQkgRkxFWENBTl9D
VFJMX1JKVygweDMpIHwNCj4gPiAJCSBGTEVYQ0FOX0NUUkxfUFNFRzEoMHg3KSB8DQo+ID4gCQkg
RkxFWENBTl9DVFJMX1BTRUcyKDB4NykgfA0KPiA+IAkJIEZMRVhDQU5fQ1RSTF9QUk9QU0VHKDB4
NykgfA0KPiA+IAkJIEZMRVhDQU5fQ1RSTF9MUEIgfA0KPiA+IAkJIEZMRVhDQU5fQ1RSTF9TTVAg
fA0KPiA+IAkJIEZMRVhDQU5fQ1RSTF9MT00pOw0KPiANCj4gLi4uLnRoZSBsb29wYmFjayBtb2Rl
LCAzIHNhbXBsZSBtb2RlIGFuZCBsaXN0ZW4gb25seSBtb2RlIGJpdHMgYXJlIG1hc2tlZA0KPiBv
dXQuLi4uDQo+IA0KPiA+IAlyZWcgfD0gRkxFWENBTl9DVFJMX1BSRVNESVYoYnQtPmJycCAtIDEp
IHwNCj4gPiAJCUZMRVhDQU5fQ1RSTF9QU0VHMShidC0+cGhhc2Vfc2VnMSAtIDEpIHwNCj4gPiAJ
CUZMRVhDQU5fQ1RSTF9QU0VHMihidC0+cGhhc2Vfc2VnMiAtIDEpIHwNCj4gPiAJCUZMRVhDQU5f
Q1RSTF9SSlcoYnQtPnNqdyAtIDEpIHwNCj4gPiAJCUZMRVhDQU5fQ1RSTF9QUk9QU0VHKGJ0LT5w
cm9wX3NlZyAtIDEpOw0KPiA+DQo+ID4gCWlmIChwcml2LT5jYW4uY3RybG1vZGUgJiBDQU5fQ1RS
TE1PREVfTE9PUEJBQ0spDQo+ID4gCQlyZWcgfD0gRkxFWENBTl9DVFJMX0xQQjsNCj4gPiAJaWYg
KHByaXYtPmNhbi5jdHJsbW9kZSAmIENBTl9DVFJMTU9ERV9MSVNURU5PTkxZKQ0KPiA+IAkJcmVn
IHw9IEZMRVhDQU5fQ1RSTF9MT007DQo+ID4gCWlmIChwcml2LT5jYW4uY3RybG1vZGUgJiBDQU5f
Q1RSTE1PREVfM19TQU1QTEVTKQ0KPiA+IAkJcmVnIHw9IEZMRVhDQU5fQ1RSTF9TTVA7DQo+IA0K
PiAuLi5hbmQgdGhlIGJpdHMgYXJlIHNldCwgaWYgZW5hYmxlZCBieSB1c2VyIHNwYWNlLi4uDQo+
IA0KPiA+IAluZXRkZXZfZGJnKGRldiwgIndyaXRpbmcgY3RybD0weCUwOHhcbiIsIHJlZyk7DQo+
ID4gCXByaXYtPndyaXRlKHJlZywgJnJlZ3MtPmN0cmwpOw0KPiANCj4gLi4uYW5kIHdyaXR0ZW4g
dG8gdGhlIHJlZ2lzdGVyLg0KPiANCj4gU28gYWxsIHRocmVlIGJpdHMgd2lsbCBiZSB1bnNldCwg
aWYgdW5zZXQgYnkgdXNlciBzcGFjZSwgcmlnaHQ/DQoNCk9oLCBJIHNlZS4gVGhhbmsgeW91IQ0K
DQpCZXN0IFJlZ2FyZHMsDQpKb2FraW0gWmhhbmcNCj4gDQo+ID4gV2hlbiB3ZSBjb25maWd1cmUg
bW9kZSBvZmYgYWZ0ZXIgY29uZmlndXJlZCBtb2RlIG9uIGluIHRoZSB1c2VyIHNwYWNlLA0KPiA+
IGNvcnJlc3BvbmRpbmcgYml0IHdpbGwgbm90IGNoYW5nZS4gSXMgdGhpcyBzaG91bGQgYmUgaW1w
cm92ZWQgaW4NCj4gPiBmbGV4Y2FuIGRyaXZlcj8NCj4gDQo+IFRoYXQgc2hvdWxkIHdvcmsuIElm
IGl0IGRvZXNuJ3Qgd29yaywgd2UgbmVlZCBhIGZpeC4NCj4gDQo+IHJlZ2FyZHMsDQo+IE1hcmMN
Cj4gDQo+IC0tDQo+IFBlbmd1dHJvbml4IGUuSy4gICAgICAgICAgICAgICAgICB8IE1hcmMgS2xl
aW5lLUJ1ZGRlICAgICAgICAgICB8DQo+IEluZHVzdHJpYWwgTGludXggU29sdXRpb25zICAgICAg
ICB8IFBob25lOiArNDktMjMxLTI4MjYtOTI0ICAgICB8DQo+IFZlcnRyZXR1bmcgV2VzdC9Eb3J0
bXVuZCAgICAgICAgICB8IEZheDogICArNDktNTEyMS0yMDY5MTctNTU1NSB8DQo+IEFtdHNnZXJp
Y2h0IEhpbGRlc2hlaW0sIEhSQSAyNjg2ICB8IGh0dHA6Ly93d3cucGVuZ3V0cm9uaXguZGUgICB8
DQoNCg==
