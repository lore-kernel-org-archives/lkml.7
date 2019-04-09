Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9832BC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 07:36:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32C272083E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 07:36:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="DHpMqzEL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbfDIHgd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 03:36:33 -0400
Received: from mail-eopbgr00073.outbound.protection.outlook.com ([40.107.0.73]:13166
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726205AbfDIHgd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 03:36:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nIln8v+qggtQSAGuxpRxZ7vWPG7U0i/aoEbR+Ai6GJA=;
 b=DHpMqzELLiRzvxkuzWPHQulCsgr09ZS1OOz4EmrKKRzB+mms0E8Iq4lUOy7vk9uC+qL/WdUQrxO4Wx0RKFHdBYWYU2u0CjcAo7SL2Ec6uSxe0M4vjGO5kEzVgZ9cOcqpZPTPsVF+AzgocpmaQIiGbuK4X2qyDeVb+vPfDeEgzEU=
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com (52.135.138.152) by
 DB7PR04MB4027.eurprd04.prod.outlook.com (52.134.107.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.14; Tue, 9 Apr 2019 07:36:30 +0000
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::99f0:f8da:a123:e25]) by DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::99f0:f8da:a123:e25%3]) with mapi id 15.20.1771.016; Tue, 9 Apr 2019
 07:36:30 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     Stefan-gabriel Mirea <stefan-gabriel.mirea@nxp.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
CC:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V2 2/5] can: flexcan: add CAN FD mode support
Thread-Topic: [PATCH V2 2/5] can: flexcan: add CAN FD mode support
Thread-Index: AQHU3hMIFyY4rNIjS0Kc2R8JlKca+KYyqbcAgACE+JCAAFo6gIAAA44g
Date:   Tue, 9 Apr 2019 07:36:29 +0000
Message-ID: <DB7PR04MB46185B04DA6F714FF120A3A8E62D0@DB7PR04MB4618.eurprd04.prod.outlook.com>
References: <20190319051512.14950-3-qiangqing.zhang@nxp.com>
 <385f7948-d12b-1fc2-2ed2-23d1e76034a0@nxp.com>
 <DB7PR04MB46181D2AC261EAB6DEECEFCCE62D0@DB7PR04MB4618.eurprd04.prod.outlook.com>
 <VI1PR0402MB286355821F5C81122A7C86E2DF2D0@VI1PR0402MB2863.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR0402MB286355821F5C81122A7C86E2DF2D0@VI1PR0402MB2863.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=qiangqing.zhang@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7788d6e6-8fff-4d56-5750-08d6bcbe14f1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DB7PR04MB4027;
x-ms-traffictypediagnostic: DB7PR04MB4027:
x-microsoft-antispam-prvs: <DB7PR04MB4027DC8FD42415DA376DBA2DE62D0@DB7PR04MB4027.eurprd04.prod.outlook.com>
x-forefront-prvs: 000227DA0C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(136003)(376002)(366004)(346002)(13464003)(199004)(189003)(97736004)(54906003)(2906002)(6246003)(66066001)(229853002)(110136005)(71190400001)(26005)(186003)(3846002)(6116002)(99286004)(4326008)(102836004)(68736007)(71200400001)(53546011)(6506007)(106356001)(25786009)(105586002)(6436002)(476003)(486006)(11346002)(446003)(76176011)(7696005)(93886005)(33656002)(14444005)(256004)(8936002)(8676002)(52536014)(5660300002)(316002)(81156014)(9686003)(81166006)(74316002)(14454004)(305945005)(53936002)(7736002)(478600001)(86362001)(55016002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4027;H:DB7PR04MB4618.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ghEo51XHPyOCqqcCHJDfVAqFYi0A5ZyZYYUiKXTAp7vY2rl1Fx73lYxYIykyzb1j17wfzAZXO9GQi8VTRvC4LnoFKJALtqwpnla/HVERICzJS7FSMDuvU8LA2HosxkiHmFDlrt/EqOqg3+2VXPiz64oDZMnWLuBIL5F5fcEnLsOCJbYIYkbvs+B48OyTJZLDgqnokE0glxLEO1hAuIyYxmCpfO/v6FqUhXzxCy7fxiVWi4jjZiihelXDgqijzg9pvYzu1Br2xQADZUZoDmsCBW/bL46JiFdSOjeUOjfx4Unc9gA8iKAEGCRzBG3CTQTACkIGUyzHJqkl6xWkqCmTG+y9IlaJtQOSAOBagSw2UmX675M2kmeUfdf2BasSZzrY/SaMjTs6XnHfn6kgokw3mwDMDVsLcYSAmFsJyLTZwng=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7788d6e6-8fff-4d56-5750-08d6bcbe14f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2019 07:36:29.8961
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4027
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFN0ZWZhbi1nYWJyaWVsIE1p
cmVhDQo+IFNlbnQ6IDIwMTnE6jTUwjnI1SAxNTowNQ0KPiBUbzogSm9ha2ltIFpoYW5nIDxxaWFu
Z3FpbmcuemhhbmdAbnhwLmNvbT47IE1hcmMgS2xlaW5lLUJ1ZGRlDQo+IDxta2xAcGVuZ3V0cm9u
aXguZGU+DQo+IENjOiBsaW51eC1jYW5Admdlci5rZXJuZWwub3JnOyBuZXRkZXZAdmdlci5rZXJu
ZWwub3JnOw0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJFOiBb
UEFUQ0ggVjIgMi81XSBjYW46IGZsZXhjYW46IGFkZCBDQU4gRkQgbW9kZSBzdXBwb3J0DQo+IA0K
PiA+IEZyb206IEpvYWtpbSBaaGFuZw0KPiA+IFNlbnQ6IFR1ZXNkYXksIEFwcmlsIDksIDIwMTkg
NTowNyBBTQ0KPiA+IEhpIFN0ZWZhbiwNCj4gPg0KPiA+IFRoYW5rcyBmb3IgeW91ciB2YWxpZGF0
aW9uISBDb3VsZCB5b3UgYWRkIHlvdXIgdGVzdCB0YWcgaWYgeW91IGNhbg0KPiA+IHN1Y2Nlc3Nm
dWxseSB2YWxpZGF0ZWQ/DQo+IA0KPiBTdXJlLCBubyBwcm9ibGVtLiBQbGVhc2Ugbm90ZSB0aGF0
IEkgbmVlZGVkIHRvIHJlcGxhY2UgImZsZXhjYW5fcmVhZCIgYW5kDQo+ICJmbGV4Y2FuX3dyaXRl
IiB3aXRoICJwcml2LT5yZWFkIiBhbmQgInByaXYtPndyaXRlIiByZXNwZWN0aXZlbHksIGluIFBB
VENIIFYyDQo+IDQvNS4NCg0KICBIaSBTdGVmYW4sDQoNCiAgSSBtYWRlIGEgbWlzdGFrZSBoZXJl
LCB0aGFuayB5b3UgZm9yIHBvaW50aW5nIG91dC4gSSB3aWxsIGZpeCBpdCBpbiBWMy4NCg0KPiA+
ICBbSm9ha2ltIFpoYW5nXSBXZSBhZGRlZCBjYW4gZmQgc3VwcG9ydCBpbiA0Ljkga2VybmVsIHdo
aWNoIGxldA0KPiA+IG1haWxib3hfcmVhZCBjYWxsIGFsbG9jX2NhbihmZClfc2tiIGluIHRoZSBw
YXN0LiBOb3cgdGhlIGRyaXZlcg0KPiA+IGFsbG9jYXRlIHNrYiBiZWZvcmUgbWFpbGJveF9yZWFk
IGluIHJ4X29mZmxvYWQgYW5kIGFsc28gcmVhZCB0aGUgb3ZlcmZsb3cNCj4gZnJhbWVzLg0KPiA+
ICAgICAgICAgICAgICAgSSBhZGQgdGhlICJpc19jYW5mZCIgc2luY2UgSSBkb24ndCB3YW50IHRv
IGNoYW5nZSB0aGUNCj4gPiByeF9vZmZsb2FkIGZyYW1ld29yayB0b28gbXVjaC4gQG1rbEBwZW5n
dXRyb25peC5kZSwgY291bGQgeW91IGdpdmUNCj4gPiBzb21lIGFkdmljZSwgd2hpY2ggc29sdXRp
b24gaXMgYmV0dGVyPw0KPiANCj4gVGhpcyBpcyBtb3JlIG9mIGEgZnVuY3Rpb25hbGl0eSBpc3N1
ZS4gRm9yIGV4YW1wbGUsIGNhbmR1bXAgZnJvbSBjYW51dGlscyA0LjAuNg0KPiBuZXZlciBzaG93
cyBDQU4gRkQgZnJhbWVzLCBidXQgc2hvdWxkIHN0aWxsIGJlIGFibGUgdG8gc2hvdyB0aGUgQ0FO
IDIuMCBvbmVzDQo+IHJlZ2FyZGxlc3Mgb2Ygd2hldGhlciAiZmQgb24iIHdhcyBzdXBwbGllZC4g
SSBzdWdnZXN0IHRoZSBmb2xsb3dpbmcgc2VwYXJhdGlvbjoNCj4gDQo+IGNhbl9yeF9vZmZsb2Fk
X29mZmxvYWRfb25lOg0KPiAJc3RydWN0IHNrX2J1ZmYgKnNrYiA9IE5VTEw7DQo+IAkuLi4NCj4g
CWJvb2wgZHJvcCA9IHVubGlrZWx5KHNrYl9xdWV1ZV9sZW4oJm9mZmxvYWQtPnNrYl9xdWV1ZSkg
Pg0KPiAJCQkgICAgIG9mZmxvYWQtPnNrYl9xdWV1ZV9sZW5fbWF4KTsNCj4gDQo+IAlpZiAob2Zm
bG9hZC0+bWFpbGJveF9yZWFkKG9mZmxvYWQsIGRyb3AsICZza2IsICZ0aW1lc3RhbXAsIG4pICYm
ICFza2IpDQo+IAkJb2ZmbG9hZC0+ZGV2LT5zdGF0cy5yeF9kcm9wcGVkKys7DQo+IA0KPiAJaWYg
KHNrYikgew0KPiAJCXN0cnVjdCBjYW5fcnhfb2ZmbG9hZF9jYiAqY2IgPSBjYW5fcnhfb2ZmbG9h
ZF9nZXRfY2Ioc2tiKTsNCj4gDQo+IAkJY2ItPnRpbWVzdGFtcCA9IHRpbWVzdGFtcDsNCj4gCX0N
Cj4gDQo+IAlyZXR1cm4gc2tiOw0KPiANCj4gZmxleGNhbl9tYWlsYm94X3JlYWQ6DQo+IAkuLi4N
Cj4gCWlmICghZHJvcCkgew0KPiAJCWlmIChyZWdfY3RybCAmIEZMRVhDQU5fTUJfQ05UX0VETCkN
Cj4gCQkJKnNrYiA9IGFsbG9jX2NhbmZkX3NrYihvZmZsb2FkLT5kZXYsICZjZik7DQo+IAkJZWxz
ZQ0KPiAJCQkqc2tiID0gYWxsb2NfY2FuX3NrYihvZmZsb2FkLT5kZXYsDQo+IAkJCQkJICAgICAo
c3RydWN0IGNhbl9mcmFtZSAqKikmY2YpOw0KPiAJfQ0KPiAJaWYgKCpza2IpIHsNCj4gCQkvKiB1
c2UgY2YgKi8NCj4gCQkuLi4NCj4gCX0NCj4gCS8qIG1hcmsgYXMgcmVhZCAqLw0KPiANCj4gQWx0
aG91Z2ggbm90IHZpc2libGUgaW4gdGhlIEZsZXhDQU4gY2FzZSwgdGhlIHNvY2tldCBidWZmZXJz
IHdvdWxkIGJlIGFsc28NCj4gZnJlZWQgZnJvbSBpbnNpZGUgbWFpbGJveF9yZWFkIGlmIGVycm9y
cyB3ZXJlIGVuY291bnRlcmVkIGFmdGVyIGFsbG9jYXRpb24uDQogIA0KIFRoaXMgaXMgYSBnb29k
IHNvbHV0aW9uLCBJIHdpbGwgYWRkIGl0IGluIFYzLiBUaGFuayB5b3UgdmVyeSBtdWNoLg0KDQpC
ZXN0IFJlZ2FyZHMsDQpKb2FraW0gWmhhbmcNCg0KPiBSZWdhcmRzLA0KPiBTdGVmYW4NCg==
