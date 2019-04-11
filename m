Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2160C10F11
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 01:17:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A77520873
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 01:17:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="IGLl0lvS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbfDKBR2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 21:17:28 -0400
Received: from mail-eopbgr80051.outbound.protection.outlook.com ([40.107.8.51]:62769
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726181AbfDKBR1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 21:17:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LfPl2yAmCkuUGLOAjANldb9z7jPx5iKG36ByPXra9FQ=;
 b=IGLl0lvS7sBBJVVvtiw6vkzH+aaHs2miwRxifyQ4doAQWd9PTXy1kr6d1eRpJVpJB5KWtRx9tH0fKXXr+xlu+5Yg+dcpfNMCmJhkHxV3IL3iIOBxotGX0LcA7DCv7wyS3BkQBarD1ETJ9IgtRocklEsqv3UbD1xRG2AgK2mwcKU=
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com (52.135.138.152) by
 DB7PR04MB5401.eurprd04.prod.outlook.com (20.178.104.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.16; Thu, 11 Apr 2019 01:16:43 +0000
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::99f0:f8da:a123:e25]) by DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::99f0:f8da:a123:e25%3]) with mapi id 15.20.1792.009; Thu, 11 Apr 2019
 01:16:43 +0000
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
Thread-Index: AQHU72Z9hNDj4CvO1EGET8+N4jv3IKY0/IsAgAAH+tCAAKg+gIAAeBjg
Date:   Thu, 11 Apr 2019 01:16:43 +0000
Message-ID: <DB7PR04MB4618D30C746B397F8C5308BAE62F0@DB7PR04MB4618.eurprd04.prod.outlook.com>
References: <20190410062533.31535-1-qiangqing.zhang@nxp.com>
 <39d8ef33-50c3-9b7a-88e1-8ef3a7fbac70@pengutronix.de>
 <DB7PR04MB4618D14BE595F3BDE46CBE17E62E0@DB7PR04MB4618.eurprd04.prod.outlook.com>
 <ad4c0921-3275-b466-95b4-a63944d5b71f@pengutronix.de>
In-Reply-To: <ad4c0921-3275-b466-95b4-a63944d5b71f@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=qiangqing.zhang@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: be0b784d-4ec6-4cae-bfe3-08d6be1b5be4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DB7PR04MB5401;
x-ms-traffictypediagnostic: DB7PR04MB5401:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DB7PR04MB5401810956C26658C540063EE62F0@DB7PR04MB5401.eurprd04.prod.outlook.com>
x-forefront-prvs: 00046D390F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(346002)(366004)(376002)(136003)(13464003)(199004)(189003)(476003)(71190400001)(76176011)(305945005)(102836004)(52536014)(5660300002)(7736002)(6506007)(53546011)(14444005)(74316002)(508600001)(2501003)(186003)(26005)(66066001)(7696005)(99286004)(486006)(446003)(11346002)(105586002)(110136005)(2201001)(106356001)(97736004)(33656002)(68736007)(71200400001)(54906003)(25786009)(256004)(93886005)(4326008)(316002)(6246003)(53386004)(9686003)(55016002)(966005)(6306002)(53936002)(14454004)(6116002)(229853002)(2906002)(81166006)(81156014)(3846002)(8936002)(86362001)(8676002)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB5401;H:DB7PR04MB4618.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: rGFPRGjDMHf7WfQKhvOBslpUs8E3FYaaQIGI1uU+M+eGDrz0WE9ovOk5AY25jaUy8eVCF9YYu8rcqDRzSTQuhfbLqSqEV/KIFecZSuAkFLe+G7mXjaNKzhg6yDTlAMxDvxe+V/DVik+FuZKT0903cLjKbMUw4//8jCBfxPEBq06DDBxhOvgvVOzepCfodORNGVMeE61xZ9DkyF17r1LH3vrOafDtNMXUmUIaWMZo8b5UJ7H0CftOd73XjsaaIsNQHdRqvJKqXct/5S0FPaLUfj9FjsiwrMfS0/lFo1qa5+6SL8olJci7ABm2QMx0Pk2uTJvnVjLjfvnioOLhV9InX8Ig2WmJtWM/4QhLolICd29JlYU5T8hWgxSnHq1nGU9r1yBWlASc3E2SZxnqw/4iDX4wgBIZkvtG/K3LuFgNP/M=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be0b784d-4ec6-4cae-bfe3-08d6be1b5be4
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2019 01:16:43.3895
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5401
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE1hcmMgS2xlaW5lLUJ1ZGRl
IDxta2xAcGVuZ3V0cm9uaXguZGU+DQo+IFNlbnQ6IDIwMTnlubQ05pyIMTHml6UgMTo1MA0KPiBU
bzogSm9ha2ltIFpoYW5nIDxxaWFuZ3FpbmcuemhhbmdAbnhwLmNvbT47IHdnQGdyYW5kZWdnZXIu
Y29tOw0KPiBkYXZlbUBkYXZlbWxvZnQubmV0DQo+IENjOiBkbC1saW51eC1pbXggPGxpbnV4LWlt
eEBueHAuY29tPjsgbGludXgtY2FuQHZnZXIua2VybmVsLm9yZzsNCj4gbmV0ZGV2QHZnZXIua2Vy
bmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW0VY
VF0gUmU6IFtQQVRDSF0gY2FuOiBkZXY6IGNsZWFuIHVwIENBTiBjdHJsbW9kZSB3aGVuIGNsb3Nl
DQo+IENBTiBkZXZpY2UNCj4gDQo+IE9uIDQvMTAvMTkgOTo1NSBBTSwgSm9ha2ltIFpoYW5nIHdy
b3RlOg0KPiA+DQo+ID4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+IEZyb206IE1h
cmMgS2xlaW5lLUJ1ZGRlIDxta2xAcGVuZ3V0cm9uaXguZGU+DQo+ID4+IFNlbnQ6IDIwMTnlubQ0
5pyIMTDml6UgMTU6MTkNCj4gPj4gVG86IEpvYWtpbSBaaGFuZyA8cWlhbmdxaW5nLnpoYW5nQG54
cC5jb20+OyB3Z0BncmFuZGVnZ2VyLmNvbTsNCj4gPj4gZGF2ZW1AZGF2ZW1sb2Z0Lm5ldA0KPiA+
PiBDYzogZGwtbGludXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT47IGxpbnV4LWNhbkB2Z2VyLmtl
cm5lbC5vcmc7DQo+ID4+IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2Vy
Lmtlcm5lbC5vcmcNCj4gPj4gU3ViamVjdDogW0VYVF0gUmU6IFtQQVRDSF0gY2FuOiBkZXY6IGNs
ZWFuIHVwIENBTiBjdHJsbW9kZSB3aGVuIGNsb3NlDQo+ID4+IENBTiBkZXZpY2UNCj4gPj4NCj4g
Pj4gT24gNC8xMC8xOSA4OjI3IEFNLCBKb2FraW0gWmhhbmcgd3JvdGU6DQo+ID4+PiBDQU4gZHJp
dmVyIGFsd2F5cyB3cml0ZXMgcmVnaXN0ZXJzIGFjY29yZGluZyB0byAiY3RybG1vZGUiLCBhbmQg
bm93DQo+ID4+PiBDQU4gZnJhbWV3b3JrIHdpbGwga2VlcCBDQU4gY3RybG1vZGUgYWZ0ZXIgZGV2
aWNlIGNsb3NlZC4NCj4gPj4+DQo+ID4+PiBlLmcuIHdpdGggZm9sbG93aW5nIHNlcXVlbmNlczoN
Cj4gPj4+IDEpaXAgbGluayBzZXQgY2FuMCB0eXBlIGNhbiBiaXRyYXRlIDEwMDAwMDAgbG9vcGJh
Y2sgb24gMilpcCBsaW5rDQo+ID4+PiBzZXQNCj4gPj4+IGNhbjAgdXAgMylpcCBsaW5rIHNldCBj
YW4wIGRvd24gNClpcCBsaW5rIHNldCBjYW4wIHR5cGUgY2FuIGJpdHJhdGUNCj4gPj4+IDEwMDAw
MDAgNSlpcCBsaW5rIHNldCBjYW4wIHVwDQo+ID4+Pg0KPiA+Pj4gQWZ0ZXIgdGhpcyBzZXF1ZW5j
ZSwgd2UgbWF5IHdhbnQgdG8gdGVzdCBsb29wYmFjayBmb3IgdGhlIGZpcnN0IHRpbWUNCj4gPj4+
IGFuZCBub3QgdG8gdGVzdCBsb29wYmFjayBzZWNvbmQgdGltZS4gSG93ZXZlciwgQ0FOIGRldmlj
ZSBzdGlsbCBrZWVwDQo+ID4+PiAiY3RybG1vZGUiIGFzIGxvb3BiYWNrIG9uLg0KPiA+Pg0KPiA+
PiBUaGVuIHlvdSBzaG91bGQgY29uZmlndXJlIGxvb3BiYWNrIG9mZiBpbiB1c2Vyc3BhY2UuDQo+
ID4NCj4gPiAgR290IGl0LiBUaGFuayB5b3UuDQo+ID4NCj4gPj4+IFRoaXMgcGF0Y2ggaW50ZW5k
cyB0byBjbGVhbiB1cCBDQU4gY3RybG1vZGUgd2hlbiBjbG9zZSBDQU4gZGV2aWNlLg0KPiA+Pj4g
V2UgY2FuIHNldCB3aGljaCBjdHJsbW9kZSB3ZSBuZWVkIHdoZW4gb3BlbiBDQU4gZGV2aWNlIGFn
YWluLg0KPiA+Pg0KPiA+PiBDb25zaWRlciBhIENBTkZEIGRldmljZSwgd2hlcmUgQ0FORkQgaGFz
IGJlZW4gZW5hYmxlZC4gSXQgd2lsbCBmZWVsDQo+ID4+IHZlcnkgd2VpcmQgaWYgdGhlIGludGVy
ZmFjZSBsb29zZXMgdGhlIENBTkZEIHByb3BlcnR5IGJ5IGp1c3QgYSBpZmRvd247IGlmdXAuDQo+
ID4NCj4gPiBZZXMsIHlvdSBhcmUgcmlnaHQuIEJ1dCBmZCBtb2RlIHNob3VsZCBjb21wYXRpYmxl
IHdpdGggbm9ybWFsIGNhbi4NCj4gDQo+IENBTkZEIHdhcyBqdXN0IGFuIGV4YW1wbGUuIFRha2Ug
Q0FOX0NUUkxNT0RFX09ORV9TSE9UIGFzIGFub3RoZXINCj4gZXhhbXBsZS4gWW91IGRvbid0IHdh
bnQgeW91ciBuZXR3b3JrIGRldmljZSBzZXR0aW5ncyB0byB2YW5pc2ggaWYgeW91IHN3aXRjaA0K
PiB0aGUgaW50ZXJmYWNlIG9mZiBhbmQgb24gYWdhaW4uDQo+IA0KPiA+IFdoZW4gSSB3YW50IHRv
IHN3aXRjaCB0byBub3JtYWwgY2FuIGZyb20gZmQgbW9kZS4gWW91IG1lYW4gdGhhdCB3ZQ0KPiA+
IHNob3VsZCBjb25maWd1cmUgZmQgb2ZmIGluIHVzZXJzcGFjZSBhcyB3ZSBtYXkgd3JpdGUgc29t
ZSBzcGVjaWZpYw0KPiA+IHJlZ2lzdGVycyBvbmx5IGJ5IGZkIG1vZGU/DQo+IA0KPiBXaGF0ZXZl
ciBtb2RlIHlvdSBlbmFibGUgdmlhIHVzZXIgc3BhY2UgdXNlIHVzZXIgc3BhY2UgdG8gZGlzYWJs
ZSB0aGVtDQo+IGFnYWluLg0KDQpUaGFuayB5b3UgZm9yIHlvdXIgZGV0YWlsZWQgZXhwbGFuYXRp
b24uIEJ1dCBpbiBmbGV4Y2FuIGRyaXZlciwgaXQganVzdCBzZXQgcmVnaXN0ZXIgYml0IHdoZW4g
bW9kZSBvbiBhbmQgZG8gbm90IGNsZWFyDQpyZWdpc3RlciBiaXQgd2hlbiBtb2RlIG9mZiwgZS5n
LiBsb29wYmFjaywgbGlzdGVubm9seSwgMyBzYW1wbGVzLi4uLg0KV2hlbiB3ZSBjb25maWd1cmUg
bW9kZSBvZmYgYWZ0ZXIgY29uZmlndXJlZCBtb2RlIG9uIGluIHRoZSB1c2VyIHNwYWNlLCBjb3Jy
ZXNwb25kaW5nIGJpdCB3aWxsIG5vdCBjaGFuZ2UuIElzIHRoaXMgc2hvdWxkIGJlIGltcHJvdmVk
IGluIGZsZXhjYW4gZHJpdmVyPw0KIA0KQmVzdCBSZWdhcmRzLA0KSm9ha2ltIFpoYW5nDQo+IE1h
cmMNCj4gDQo+IC0tDQo+IFBlbmd1dHJvbml4IGUuSy4gICAgICAgICAgICAgICAgICB8IE1hcmMg
S2xlaW5lLUJ1ZGRlICAgICAgICAgICB8DQo+IEluZHVzdHJpYWwgTGludXggU29sdXRpb25zICAg
ICAgICB8IFBob25lOiArNDktMjMxLTI4MjYtOTI0ICAgICB8DQo+IFZlcnRyZXR1bmcgV2VzdC9E
b3J0bXVuZCAgICAgICAgICB8IEZheDogICArNDktNTEyMS0yMDY5MTctNTU1NSB8DQo+IEFtdHNn
ZXJpY2h0IEhpbGRlc2hlaW0sIEhSQSAyNjg2ICB8IGh0dHA6Ly93d3cucGVuZ3V0cm9uaXguZGUg
ICB8DQoNCg==
