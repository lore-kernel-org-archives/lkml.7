Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2062C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 07:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3B3A2075B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 07:55:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="A2z+Cv3U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729170AbfDJHzq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 03:55:46 -0400
Received: from mail-eopbgr10068.outbound.protection.outlook.com ([40.107.1.68]:17541
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726667AbfDJHzp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 03:55:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hO1O+irTek4+YdZxYZN7ZeUK9cjyIvDJDx6Mcm7nc9o=;
 b=A2z+Cv3U24teMsXNK6WBVDPIyYiVbR2yJO4JLYX+Wqc9hFPZrF9SE0W4NOK7wXSdfKHo6lUZkWGC2KzP3qLExWyUJJk6XFG1hXa2Wd6oA1dbKiQSQgQB3WBwI6u4zjjoQ3soJEk5GDAAnGStdj1oiPrkq071icCuLGwSpYSwYP8=
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com (52.135.138.152) by
 DB7PR04MB5177.eurprd04.prod.outlook.com (20.176.236.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.14; Wed, 10 Apr 2019 07:55:40 +0000
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::99f0:f8da:a123:e25]) by DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::99f0:f8da:a123:e25%3]) with mapi id 15.20.1792.009; Wed, 10 Apr 2019
 07:55:40 +0000
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
Thread-Index: AQHU72Z9hNDj4CvO1EGET8+N4jv3IKY0/IsAgAAH+tA=
Date:   Wed, 10 Apr 2019 07:55:40 +0000
Message-ID: <DB7PR04MB4618D14BE595F3BDE46CBE17E62E0@DB7PR04MB4618.eurprd04.prod.outlook.com>
References: <20190410062533.31535-1-qiangqing.zhang@nxp.com>
 <39d8ef33-50c3-9b7a-88e1-8ef3a7fbac70@pengutronix.de>
In-Reply-To: <39d8ef33-50c3-9b7a-88e1-8ef3a7fbac70@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=qiangqing.zhang@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: da1cd9bd-eaf8-49b4-f8b4-08d6bd89ecfe
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB7PR04MB5177;
x-ms-traffictypediagnostic: DB7PR04MB5177:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DB7PR04MB51773503E73FA47C119CADF5E62E0@DB7PR04MB5177.eurprd04.prod.outlook.com>
x-forefront-prvs: 00032065B2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(136003)(346002)(366004)(396003)(13464003)(199004)(189003)(25786009)(86362001)(26005)(6436002)(229853002)(97736004)(68736007)(478600001)(105586002)(2201001)(106356001)(52536014)(6506007)(71200400001)(186003)(76176011)(102836004)(5660300002)(71190400001)(53546011)(66066001)(2906002)(14444005)(256004)(446003)(9686003)(6246003)(11346002)(7736002)(8936002)(476003)(53386004)(33656002)(966005)(3846002)(486006)(8676002)(2501003)(110136005)(4326008)(54906003)(6116002)(305945005)(55016002)(316002)(99286004)(6306002)(81166006)(81156014)(74316002)(14454004)(53936002)(7696005);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB5177;H:DB7PR04MB4618.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 8+WRICvnX7bNcUjFNmwLTV2uJ5UieQqVh2+aRJccHKrMabRvsBTZmTa2uN8jlUKGYcAWID3Ys7YJrnn9uApbFKT1AlVFZR6Chv2gnLkHOonuFG7euVNwj5kpMn+ZJ0su2Mq9f5OsL9rTl4AOKcPmwnuFRvGKJqb9TxR/2KZi3ptYcJWWg0eoFt5Gso5sxYHl0a8nAyp9b6ZlHTa66jzbI4/o+7MofSDsX2VBGcrY6nUlDBit5aQPPdLgdIPGwKRLKbFwEA4EdzTGz8SjTkXAWCLFuh8jalT1NKF2Yicjw9HSZvv+JatzH9XzU4j/XMBxVjpBZrwZa1TDI5UEsS3bxTCx8Y9OfdZq+/qCSiyV8GC0nalyOdR1Dd63b8OalrxDbAeEa+LhjclrS2ATz1JXpxWSYcGc+UIyspTeKg0uNEk=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da1cd9bd-eaf8-49b4-f8b4-08d6bd89ecfe
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2019 07:55:40.2384
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5177
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE1hcmMgS2xlaW5lLUJ1ZGRl
IDxta2xAcGVuZ3V0cm9uaXguZGU+DQo+IFNlbnQ6IDIwMTnlubQ05pyIMTDml6UgMTU6MTkNCj4g
VG86IEpvYWtpbSBaaGFuZyA8cWlhbmdxaW5nLnpoYW5nQG54cC5jb20+OyB3Z0BncmFuZGVnZ2Vy
LmNvbTsNCj4gZGF2ZW1AZGF2ZW1sb2Z0Lm5ldA0KPiBDYzogZGwtbGludXgtaW14IDxsaW51eC1p
bXhAbnhwLmNvbT47IGxpbnV4LWNhbkB2Z2VyLmtlcm5lbC5vcmc7DQo+IG5ldGRldkB2Z2VyLmtl
cm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogW0VYVF0g
UmU6IFtQQVRDSF0gY2FuOiBkZXY6IGNsZWFuIHVwIENBTiBjdHJsbW9kZSB3aGVuIGNsb3NlIENB
Tg0KPiBkZXZpY2UNCj4gDQo+IE9uIDQvMTAvMTkgODoyNyBBTSwgSm9ha2ltIFpoYW5nIHdyb3Rl
Og0KPiA+IENBTiBkcml2ZXIgYWx3YXlzIHdyaXRlcyByZWdpc3RlcnMgYWNjb3JkaW5nIHRvICJj
dHJsbW9kZSIsIGFuZCBub3cNCj4gPiBDQU4gZnJhbWV3b3JrIHdpbGwga2VlcCBDQU4gY3RybG1v
ZGUgYWZ0ZXIgZGV2aWNlIGNsb3NlZC4NCj4gPg0KPiA+IGUuZy4gd2l0aCBmb2xsb3dpbmcgc2Vx
dWVuY2VzOg0KPiA+IDEpaXAgbGluayBzZXQgY2FuMCB0eXBlIGNhbiBiaXRyYXRlIDEwMDAwMDAg
bG9vcGJhY2sgb24gMilpcCBsaW5rIHNldA0KPiA+IGNhbjAgdXAgMylpcCBsaW5rIHNldCBjYW4w
IGRvd24gNClpcCBsaW5rIHNldCBjYW4wIHR5cGUgY2FuIGJpdHJhdGUNCj4gPiAxMDAwMDAwIDUp
aXAgbGluayBzZXQgY2FuMCB1cA0KPiA+DQo+ID4gQWZ0ZXIgdGhpcyBzZXF1ZW5jZSwgd2UgbWF5
IHdhbnQgdG8gdGVzdCBsb29wYmFjayBmb3IgdGhlIGZpcnN0IHRpbWUNCj4gPiBhbmQgbm90IHRv
IHRlc3QgbG9vcGJhY2sgc2Vjb25kIHRpbWUuIEhvd2V2ZXIsIENBTiBkZXZpY2Ugc3RpbGwga2Vl
cA0KPiA+ICJjdHJsbW9kZSIgYXMgbG9vcGJhY2sgb24uDQo+IA0KPiBUaGVuIHlvdSBzaG91bGQg
Y29uZmlndXJlIGxvb3BiYWNrIG9mZiBpbiB1c2Vyc3BhY2UuDQoNCiBHb3QgaXQuIFRoYW5rIHlv
dS4NCg0KPiA+IFRoaXMgcGF0Y2ggaW50ZW5kcyB0byBjbGVhbiB1cCBDQU4gY3RybG1vZGUgd2hl
biBjbG9zZSBDQU4gZGV2aWNlLiBXZQ0KPiA+IGNhbiBzZXQgd2hpY2ggY3RybG1vZGUgd2UgbmVl
ZCB3aGVuIG9wZW4gQ0FOIGRldmljZSBhZ2Fpbi4NCj4gDQo+IENvbnNpZGVyIGEgQ0FORkQgZGV2
aWNlLCB3aGVyZSBDQU5GRCBoYXMgYmVlbiBlbmFibGVkLiBJdCB3aWxsIGZlZWwgdmVyeQ0KPiB3
ZWlyZCBpZiB0aGUgaW50ZXJmYWNlIGxvb3NlcyB0aGUgQ0FORkQgcHJvcGVydHkgYnkganVzdCBh
IGlmZG93bjsgaWZ1cC4NCg0KWWVzLCB5b3UgYXJlIHJpZ2h0LiBCdXQgZmQgbW9kZSBzaG91bGQg
Y29tcGF0aWJsZSB3aXRoIG5vcm1hbCBjYW4uIFdoZW4gSSB3YW50IHRvIHN3aXRjaCB0byBub3Jt
YWwgY2FuIGZyb20gZmQgbW9kZS4NCllvdSBtZWFuIHRoYXQgd2Ugc2hvdWxkIGNvbmZpZ3VyZSBm
ZCBvZmYgaW4gdXNlcnNwYWNlIGFzIHdlIG1heSB3cml0ZSBzb21lIHNwZWNpZmljIHJlZ2lzdGVy
cyBvbmx5IGJ5IGZkIG1vZGU/DQoNCg0KQmVzdCBSZWdhcmRzLA0KSm9ha2ltIFpoYW5nDQo+ID4N
Cj4gPiBTaWduZWQtb2ZmLWJ5OiBKb2FraW0gWmhhbmcgPHFpYW5ncWluZy56aGFuZ0BueHAuY29t
Pg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL25ldC9jYW4vZGV2LmMgfCAxICsNCj4gPiAgMSBmaWxl
IGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9u
ZXQvY2FuL2Rldi5jIGIvZHJpdmVycy9uZXQvY2FuL2Rldi5jIGluZGV4DQo+ID4gYzA1ZTRkNTBk
NDNkLi40ZjY5YThmMTZiYTMgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9uZXQvY2FuL2Rldi5j
DQo+ID4gKysrIGIvZHJpdmVycy9uZXQvY2FuL2Rldi5jDQo+ID4gQEAgLTg3MCw2ICs4NzAsNyBA
QCB2b2lkIGNsb3NlX2NhbmRldihzdHJ1Y3QgbmV0X2RldmljZSAqZGV2KQ0KPiA+ICAJc3RydWN0
IGNhbl9wcml2ICpwcml2ID0gbmV0ZGV2X3ByaXYoZGV2KTsNCj4gPg0KPiA+ICAJY2FuY2VsX2Rl
bGF5ZWRfd29ya19zeW5jKCZwcml2LT5yZXN0YXJ0X3dvcmspOw0KPiA+ICsJcHJpdi0+Y3RybG1v
ZGUgPSAwOw0KPiA+ICAJY2FuX2ZsdXNoX2VjaG9fc2tiKGRldik7DQo+ID4gIH0NCj4gPiAgRVhQ
T1JUX1NZTUJPTF9HUEwoY2xvc2VfY2FuZGV2KTsNCj4gPg0KPiANCj4gTWFyYw0KPiANCj4gLS0N
Cj4gUGVuZ3V0cm9uaXggZS5LLiAgICAgICAgICAgICAgICAgIHwgTWFyYyBLbGVpbmUtQnVkZGUg
ICAgICAgICAgIHwNCj4gSW5kdXN0cmlhbCBMaW51eCBTb2x1dGlvbnMgICAgICAgIHwgUGhvbmU6
ICs0OS0yMzEtMjgyNi05MjQgICAgIHwNCj4gVmVydHJldHVuZyBXZXN0L0RvcnRtdW5kICAgICAg
ICAgIHwgRmF4OiAgICs0OS01MTIxLTIwNjkxNy01NTU1IHwNCj4gQW10c2dlcmljaHQgSGlsZGVz
aGVpbSwgSFJBIDI2ODYgIHwgaHR0cDovL3d3dy5wZW5ndXRyb25peC5kZSAgIHwNCg0K
