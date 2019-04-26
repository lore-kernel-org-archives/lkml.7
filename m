Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA7E5C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 00:50:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C9892084F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 00:50:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="a8LsG9ac"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730300AbfDZAu3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 20:50:29 -0400
Received: from mail-eopbgr40062.outbound.protection.outlook.com ([40.107.4.62]:3716
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727734AbfDZAu2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 20:50:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1yOoMvGNhVFf2gGyiTjquJABQaSD6SBOq+lNLEekwUo=;
 b=a8LsG9acgQHfNRWtCu+iS255QRq39G+dbGkkp/HQrKfhrAUbcqHkiPMoVIxyTaTC5f7KP5BkD4Fa6mdFBGQ2uEgPYPCKu4y0juWwYQjv8nV3Taezr5vVMHRD0Tm9iD0+OEHr6tntXYob68kllhRMuZFX/zU1kBoqwctBFs+zx3M=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3657.eurprd04.prod.outlook.com (52.134.69.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.17; Fri, 26 Apr 2019 00:50:23 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170%3]) with mapi id 15.20.1835.010; Fri, 26 Apr 2019
 00:50:23 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "gustavo@embeddedor.com" <gustavo@embeddedor.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 2/2] clk: imx: disable i.mx7ulp composite clock during
 initialization
Thread-Topic: [PATCH 2/2] clk: imx: disable i.mx7ulp composite clock during
 initialization
Thread-Index: AQHU+yZqSSaC+SqMKEqyvy0FwIJdyKZNkJKAgAAImxA=
Date:   Fri, 26 Apr 2019 00:50:23 +0000
Message-ID: <DB3PR0402MB3916BFD261A7F28D34719F37F53E0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1556169264-31683-1-git-send-email-Anson.Huang@nxp.com>
 <1556169264-31683-2-git-send-email-Anson.Huang@nxp.com>
 <155623699177.15276.12577395377027956830@swboyd.mtv.corp.google.com>
In-Reply-To: <155623699177.15276.12577395377027956830@swboyd.mtv.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 42e747ee-653a-4b5b-c986-08d6c9e12a57
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3657;
x-ms-traffictypediagnostic: DB3PR0402MB3657:
x-microsoft-antispam-prvs: <DB3PR0402MB365785CDEDA91AE17BC29A0FF53E0@DB3PR0402MB3657.eurprd04.prod.outlook.com>
x-forefront-prvs: 001968DD50
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(346002)(376002)(39860400002)(366004)(199004)(189003)(13464003)(52536014)(44832011)(486006)(33656002)(476003)(11346002)(14454004)(446003)(66066001)(6636002)(8936002)(6436002)(81166006)(55016002)(81156014)(9686003)(14444005)(256004)(25786009)(53936002)(8676002)(478600001)(99286004)(2906002)(4326008)(102836004)(186003)(26005)(6506007)(3846002)(5660300002)(53546011)(6116002)(7696005)(316002)(110136005)(2501003)(305945005)(68736007)(66946007)(66476007)(66556008)(71200400001)(74316002)(64756008)(6246003)(66446008)(71190400001)(97736004)(73956011)(76116006)(2201001)(76176011)(229853002)(86362001)(7736002)(7416002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3657;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: j8qIDgh56bs1q6jOcIQ1nWI0/8g/EYVU0d1alWxHxMWUWrdCqqpWgCMtwN/YYDvH7YAzVWabJsbZ8freXexo4KgswfR4SM1pIGh4iPriqGQMCwwkwy1PZutum8+oAWTNAmxpGhOyRdXZ5DtTeFq8Ce5XjEQWkbS15LPP3LNzG4z9GekQtobiyyIjwa1sA9R0NFJ0TrBTXIIygHAz6pGWkiza9SEsNSbqYhlI172YKbWM/IHr5syp9QeE4qqgDlGurulifIwT3shhSQNyDA+TH0pnvZWtboMQ5Dk33/0nBD5F0jTpOQ2zqBg1AcQu7lViwGZ8/kkxnDwJHqL0tIRJdygw4iHBCUhb7jIPYcwZYZfrhh5gFNisOk8TW54IM8flkKq3aAYeQJ2dbulzhAY58uHKhsy7dm0xuM8uStN9tTY=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42e747ee-653a-4b5b-c986-08d6c9e12a57
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2019 00:50:23.1802
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3657
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFN0ZXBoZW4NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTdGVw
aGVuIEJveWQgW21haWx0bzpzYm95ZEBrZXJuZWwub3JnXQ0KPiBTZW50OiBGcmlkYXksIEFwcmls
IDI2LCAyMDE5IDg6MDMgQU0NCj4gVG86IGZlc3RldmFtQGdtYWlsLmNvbTsgZ3VzdGF2b0BlbWJl
ZGRlZG9yLmNvbTsNCj4ga2VybmVsQHBlbmd1dHJvbml4LmRlOyBsaW51eC1hcm0ta2VybmVsQGxp
c3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LQ0KPiBjbGtAdmdlci5rZXJuZWwub3JnOyBsaW51eC1r
ZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiBtdHVycXVldHRlQGJheWxpYnJlLmNvbTsgcy5oYXVl
ckBwZW5ndXRyb25peC5kZTsgc2hhd25ndW9Aa2VybmVsLm9yZzsNCj4gQWlzaGVuZyBEb25nIDxh
aXNoZW5nLmRvbmdAbnhwLmNvbT47IEFuc29uIEh1YW5nDQo+IDxhbnNvbi5odWFuZ0BueHAuY29t
Pg0KPiBDYzogZGwtbGludXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT4NCj4gU3ViamVjdDogUmU6
IFtQQVRDSCAyLzJdIGNsazogaW14OiBkaXNhYmxlIGkubXg3dWxwIGNvbXBvc2l0ZSBjbG9jayBk
dXJpbmcNCj4gaW5pdGlhbGl6YXRpb24NCj4gDQo+IFF1b3RpbmcgQW5zb24gSHVhbmcgKDIwMTkt
MDQtMjQgMjI6MTk6MTIpDQo+ID4gaS5NWDdVTFAgcGVyaXBoZXJhbCBjbG9jayBPTkxZIGFsbG93
IHBhcmVudC9yYXRlIHRvIGJlIGNoYW5nZWQgd2l0aA0KPiA+IGNsb2NrIGdhdGVkLCBob3dldmVy
LCBkdXJpbmcgY2xvY2sgdHJlZSBpbml0aWFsaXphdGlvbiwgdGhlIHBlcmlwaGVyYWwNCj4gPiBj
bG9jayBjb3VsZCBiZSBlbmFibGVkIGJ5IGJvb3Rsb2FkZXIsIGJ1dCB0aGUgcHJlcGFyZSBjb3Vu
dCBpbiBjbG9jaw0KPiA+IHRyZWUgaXMgc3RpbGwgemVybywgc28gY2xvY2sgY29yZSBkcml2ZXIg
d2lsbCBhbGxvdyBwYXJlbnQvcmF0ZQ0KPiA+IGNoYW5nZWQgZXZlbiB3aXRoIENMS19TRVRfUkFU
RV9HQVRFL0NMS19TRVRfUEFSRU5UX0dBVEUNCj4gDQo+IFRoYXQncyBhIGJ1Zy4gQ2FuIHlvdSBz
ZW5kIGEgcGF0Y2ggdG8gZml4IHRoZSBjb3JlIGZyYW1ld29yayBjb2RlIHRvIGZhaWwgYW4NCj4g
YXNzaWduZWQgcmF0ZSBvciBwYXJlbnQgY2hhbmdlIGlmIHRob3NlIGZsYWdzIGFyZSBzZXQ/IE9y
IGlzIHRoYXQgYmVjYXVzZSB0aGUNCj4gY29yZSBkb2Vzbid0IHJlc3BlY3QgdGhlc2UgZmxhZ3Mg
d2hlbiB0aGV5J3JlIGJ1cmllZCBpbiB0aGUgbWlkZGxlIG9mIHRoZSBjbGsNCj4gdHJlZSBhbmQg
c29tZSByYXRlIG9yIHBhcmVudCBjaGFuZ2UgY29tZXMgaW4gYW5kIGFmZmVjdHMgdGhlIG1pZGRs
ZSBvZiB0aGUNCj4gdHJlZSB0aGF0IGhhcyB0aGUgZmxhZyBzZXQgb24gaXQ/DQoNClRoZSByZWFz
b24gaXMgdGhlIGNvcmUgZnJhbWV3b3JrIE9OTFkgY2hlY2tzIHRoZSBwcmVwYXJlIGNvdW50ICBh
bmQgdGhlIGZsYWdzDQp0byBkZXRlcm1pbmUgd2hldGhlciB0aGUgcGFyZW50L3JhdGUgY2hhbmdl
IGlzIGFsbG93ZWQsIGR1cmluZyBkcml2ZXIgcHJvYmUgcGhhc2UsDQp0aGUgY2xrIHByZXBhcmUg
Y291bnQgaXMgMCBieSBkZWZhdWx0IHNpbmNlIG5vIG9uZSBldmVyIHByZXBhcmUgaXQsIGJ1dCB0
aGUgZGVmYXVsdCBIVw0Kc3RhdHVzIG9mIHRoZSBjbGsgaXMgYWN0dWFsbHkgcHJlcGFyZWQvZW5h
YmxlZCwgc28gSFcgd2lsbCBwcmV2ZW50IHRoZSBwYXJlbnQvcmF0ZQ0KY2hhbmdlLCBhbmQgdGhl
IHJlZ2lzdGVyIHdyaXRlIHdpbGwgZmFpbCwgYnV0IGNvcmUgZnJhbWV3b3JrIGRvZXMgTk9UIGtu
b3cgdGhhdCwNCml0IGRvZXMgTk9UIHJlYWQgYmFjayB0aGUgcmVnaXN0ZXIgdmFsdWUgdG8gY2hl
Y2suDQoNCklmIHdhbnQgdG8gZml4IGl0IGZyb20gY29yZSBmcmFtZXdvcmssIEkgdGhpbmsgaXQg
c2hvdWxkIGNoZWNrIHRoZSBjbGsncyBIVyBzdGF0dXMgYnkNCmNhbGxpbmcgLmlzX2VuYWJsZWQo
KSBpbnN0ZWFkIG9mIHByZXBhcmVfY291bnQsIHRoYXQgY2FuIHJlZmxlY3QgdGhlIHJlYWwgSFcg
c3RhdHVzDQpkdXJpbmcgZHJpdmVyIHByb2JlIHBoYXNlLiBDaGVja2luZyB0aGUgcHJlcGFyZV9j
b3VudCBpcyBPSyBmb3IgbGF0ZXIgb3BlcmF0aW9ucw0KYnkgbW9kdWxlcyBjbGsgcGFyZW50L3Jh
dGUgY2hhbmdlIGFmdGVyIGNsb2NrIGJlaW5nIHByZXBhcmVkL3VucHJlcGFyZWQsIGJ1dCBpdA0K
ZG9lcyBOT1QgY292ZXIgdGhlIGNhc2Ugb2YgYXNzaWduaW5nIGNsb2NrIGZyb20gRFQgZHVyaW5n
IGRyaXZlciBwcm9iZSBwaGFzZSBJIHRoaW5rLg0KU28gZG8gd2UgbmVlZCB0byBmaXggaXQgZnJv
bSBjbGsgY29yZSBmcmFtZXdvcms/DQoNCiAgICAgICAgIC8qIHNvbWUgY2xvY2tzIG11c3QgYmUg
Z2F0ZWQgdG8gY2hhbmdlIHBhcmVudCAqLw0KICAgICAgICAgaWYgKHBhcmVudCAhPSBvbGRfcGFy
ZW50ICYmDQogICAgICAgICAgICAgKGNvcmUtPmZsYWdzICYgQ0xLX1NFVF9QQVJFTlRfR0FURSkg
JiYgY29yZS0+cHJlcGFyZV9jb3VudCkgew0KICAgICAgICAgICAgICAgICBwcl9kZWJ1ZygiJXM6
ICVzIG5vdCBnYXRlZCBidXQgd2FudHMgdG8gcmVwYXJlbnRcbiIsDQogICAgICAgICAgICAgICAg
ICAgICAgICAgIF9fZnVuY19fLCBjb3JlLT5uYW1lKTsNCiAgICAgICAgICAgICAgICAgcmV0dXJu
IE5VTEw7DQogICAgICAgICB9DQoNCj4gDQo+ID4gc2V0LCBidXQgdGhlIGNoYW5nZSB3aWxsIGZh
aWwgZHVlIHRvIEhXIE5PVCBhbGxvdyBwYXJlbnQvcmF0ZSBjaGFuZ2UNCj4gPiB3aXRoIGNsb2Nr
IGVuYWJsZWQuIEl0IHdpbGwgY2F1c2UgY2xvY2sgSFcgc3RhdHVzIG1pc21hdGNoIHdpdGggY2xv
Y2sNCj4gPiB0cmVlIGluZm8gYW5kIGxlYWQgdG8gZnVuY3Rpb24gaXNzdWUuIEJlbG93IGlzIGFu
IGV4YW1wbGU6DQo+ID4NCj4gPiB1c2RoYzAncyBwY2MgY2xvY2sgdmFsdWUgaXMgMHhDNTAwMDAw
MCBkdXJpbmcga2VybmVsIGJvb3QgdXAsIGl0IG1lYW5zDQo+ID4gdXNkaGMwIGNsb2NrIGlzIGVu
YWJsZWQsIGl0cyBwYXJlbnQgaXMgQVBMTF9QRkQxLiBJbiBEVCBmaWxlLCB0aGUNCj4gPiB1c2Ro
YzAgY2xvY2sgc2V0dGluZ3MgYXJlIGFzIGJlbG93Og0KPiA+DQo+ID4gYXNzaWduZWQtY2xvY2tz
ID0gPCZwY2MyIElNWDdVTFBfQ0xLX1VTREhDMD47IGFzc2lnbmVkLWNsb2NrLXBhcmVudHMgPQ0K
PiA+IDwmc2NnMSBJTVg3VUxQX0NMS19OSUMxX0RJVj47DQo+ID4NCj4gPiB3aGVuIGtlcm5lbCBi
b290IHVwLCB0aGUgY2xvY2sgdHJlZSBpbmZvIGlzIGFzIGJlbG93LCBidXQgdGhlIHVzZGhjMA0K
PiA+IFBDQyByZWdpc3RlciBpcyBzdGlsbCAweEM1MDAwMDAwLCB3aGljaCBtZWFucyBpdHMgcGFy
ZW50IGlzIHN0aWxsIGZyb20NCj4gPiBBUExMX1BGRDEsIHdoaWNoIGlzIGluY29ycmVjdCBhbmQg
Y2F1c2UgdXNkaGMwIE5PVCB3b3JrLg0KPiA+DQo+ID4gbmljMV9jbGsgICAgICAgMiAgICAgICAg
MiAgICAgICAgMCAgIDE3NjAwMDAwMCAgICAgICAgICAwICAgICAwICA1MDAwMA0KPiA+ICAgICB1
c2RoYzAgICAgICAgMCAgICAgICAgMCAgICAgICAgMCAgIDE3NjAwMDAwMCAgICAgICAgICAwICAg
ICAwICA1MDAwMA0KPiA+DQo+ID4gQWZ0ZXIgbWFraW5nIHN1cmUgdGhlIHBlcmlwaGVyYWwgY2xv
Y2sgaXMgZGlzYWJsZWQgZHVyaW5nIGNsb2NrIHRyZWUNCj4gPiBpbml0aWFsaXphdGlvbiwgdGhl
IHVzZGhjMCBpcyB3b3JraW5nLCBhbmQgdGhpcyBjaGFuZ2UgaXMgbmVjZXNzYXJ5DQo+ID4gZm9y
IGFsbCBpLk1YN1VMUCBwZXJpcGhlcmFsIGNsb2Nrcy4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6
IEFuc29uIEh1YW5nIDxBbnNvbi5IdWFuZ0BueHAuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJz
L2Nsay9pbXgvY2xrLWNvbXBvc2l0ZS03dWxwLmMgfCAxMyArKysrKysrKysrKysrDQo+ID4gIDEg
ZmlsZSBjaGFuZ2VkLCAxMyBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9jbGsvaW14L2Nsay1jb21wb3NpdGUtN3VscC5jDQo+ID4gYi9kcml2ZXJzL2Nsay9pbXgv
Y2xrLWNvbXBvc2l0ZS03dWxwLmMNCj4gPiBpbmRleCAwNjBmODYwLi4xYTA1NDExIDEwMDY0NA0K
PiA+IC0tLSBhL2RyaXZlcnMvY2xrL2lteC9jbGstY29tcG9zaXRlLTd1bHAuYw0KPiA+ICsrKyBi
L2RyaXZlcnMvY2xrL2lteC9jbGstY29tcG9zaXRlLTd1bHAuYw0KPiA+IEBAIC0zMiw2ICszMiw3
IEBAIHN0cnVjdCBjbGtfaHcgKmlteDd1bHBfY2xrX2NvbXBvc2l0ZShjb25zdCBjaGFyDQo+ICpu
YW1lLA0KPiA+ICAgICAgICAgc3RydWN0IGNsa19nYXRlICpnYXRlID0gTlVMTDsNCj4gPiAgICAg
ICAgIHN0cnVjdCBjbGtfbXV4ICptdXggPSBOVUxMOw0KPiA+ICAgICAgICAgc3RydWN0IGNsa19o
dyAqaHc7DQo+ID4gKyAgICAgICB1MzIgdmFsOw0KPiA+DQo+ID4gICAgICAgICBpZiAobXV4X3By
ZXNlbnQpIHsNCj4gPiAgICAgICAgICAgICAgICAgbXV4ID0ga3phbGxvYyhzaXplb2YoKm11eCks
IEdGUF9LRVJORUwpOyBAQCAtNzAsNg0KPiA+ICs3MSwxOCBAQCBzdHJ1Y3QgY2xrX2h3ICppbXg3
dWxwX2Nsa19jb21wb3NpdGUoY29uc3QgY2hhciAqbmFtZSwNCj4gPiAgICAgICAgICAgICAgICAg
Z2F0ZV9odyA9ICZnYXRlLT5odzsNCj4gPiAgICAgICAgICAgICAgICAgZ2F0ZS0+cmVnID0gcmVn
Ow0KPiA+ICAgICAgICAgICAgICAgICBnYXRlLT5iaXRfaWR4ID0gUENHX0NHQ19TSElGVDsNCj4g
PiArICAgICAgICAgICAgICAgLyoNCj4gPiArICAgICAgICAgICAgICAgICogbWFrZSBzdXJlIGNs
b2NrIGlzIGdhdGVkIGR1cmluZyBjbG9jayB0cmVlIGluaXRpYWxpemF0aW9uLA0KPiA+ICsgICAg
ICAgICAgICAgICAgKiB0aGUgSFcgT05MWSBhbGxvdyBjbG9jayBwYXJlbnQvcmF0ZSBjaGFuZ2Vk
IHdpdGggY2xvY2sgZ2F0ZWQsDQo+ID4gKyAgICAgICAgICAgICAgICAqIGR1cmluZyBjbG9jayB0
cmVlIGluaXRpYWxpemF0aW9uLCBjbG9ja3MgY291bGQgYmUgZW5hYmxlZA0KPiA+ICsgICAgICAg
ICAgICAgICAgKiBieSBib290bG9hZGVyLCBzbyB0aGUgSFcgc3RhdHVzIHdpbGwgbWlzbWF0Y2gg
d2l0aCBjbG9jayB0cmVlDQo+ID4gKyAgICAgICAgICAgICAgICAqIHByZXBhcmUgY291bnQsIHRo
ZW4gY2xvY2sgY29yZSBkcml2ZXIgd2lsbCBhbGxvdyBwYXJlbnQvcmF0ZQ0KPiA+ICsgICAgICAg
ICAgICAgICAgKiBjaGFuZ2Ugc2luY2UgdGhlIHByZXBhcmUgY291bnQgaXMgemVybywgYnV0IEhX
IGFjdHVhbGx5DQo+ID4gKyAgICAgICAgICAgICAgICAqIHByZXZlbnQgdGhlIHBhcmVudC9yYXRl
IGNoYW5nZSBkdWUgdG8gdGhlIGNsb2NrIGlzIGVuYWJsZWQuDQo+ID4gKyAgICAgICAgICAgICAg
ICAqLw0KPiANCj4gSXMgaXQgT0sgdG8gZm9yY2libHkgZ2F0ZSB0aGUgY2xrIGxpa2UgdGhpcyBh
dCBpbml0IHRpbWU/IElmIHNvLCB3aHkgY2FuJ3Qgd2UgZm9yY2UNCj4gdGhlIGNsayBvZmYgd2hl
biB3ZSBjaGFuZ2UgdGhlIHJhdGUgYW5kIHRoZW4gcmVzdG9yZSB0aGUgb24gc3RhdGUgYWZ0ZXIN
Cj4gY2hhbmdpbmcgdGhlIHJhdGU/IFRoYXQgd291bGQgYmUgbW9yZSAicm9idXN0IiB0aGFuIGRv
aW5nIGl0IG9uY2UgaGVyZS4gUGx1cw0KPiB0aGVuIHdlIGNvdWxkIHJlbW92ZSB0aGUgQ0xLX1NF
VF9SQVRFX0dBVEUgZmxhZy4NCg0KSXQgc2hvdWxkIGJlIE9LIHRvIGdhdGUgY2xrIGR1cmluZyBp
bml0IHRpbWUsIGJ1dCBJIG5lZWQgdG8gZG91YmxlIGNoZWNrIHdoZXRoZXIgaXQgd2lsbA0KaW1w
YWN0IHRoZSBlYXJseSB1YXJ0IGZ1bmN0aW9uLCBJIG1pc3NlZCB0aGlzIHBhcnQsIG90aGVyIGRy
aXZlcnMgYXJlIE9LIHNpbmNlIHRoZXkgd2lsbA0KZW5hYmxlIGNsb2NrIGJlZm9yZSBhY3RpdmUu
DQoNClllcywgd2UgY2FuIGZvcmNlIHRoZSBjbGsgb2ZmIHdoZW4gY2hhbmdpbmcgdGhlIHJhdGUg
YW5kIHRoZW4gcmVzdG9yZSB0aGVtIE9OLCBidXQgaXQNCmNhbiBPTkxZIGJlIGhhbmRsZWQgaW4g
bW9kdWxlIGRyaXZlcnMgYnkgY2FsbGluZyBjbGsgQVBJLCBpdCBjYW4gTk9UIGZpeCB0aGUgY2Fz
ZSBvZiAgDQphc3NpZ25lZC1jbG9jay1wYXJlbnRzIGFuZCBhc3NpZ25lZC1jbG9jay1yYXRlcyBp
biBEVCwgd2hpY2ggaXMgZHVyaW5nIGRyaXZlciBwcm9iZSBwaGFzZQ0KYnkgY29tbW9uIGNvZGUu
DQoNCkFuc29uDQoNCj4gDQo+ID4gKyAgICAgICAgICAgICAgIHZhbCA9IHJlYWRsX3JlbGF4ZWQo
cmVnKTsNCj4gPiArICAgICAgICAgICAgICAgdmFsICY9IH4oMSA8PCBQQ0dfQ0dDX1NISUZUKTsN
Cj4gPiArICAgICAgICAgICAgICAgd3JpdGVsX3JlbGF4ZWQodmFsLCByZWcpOw0KPiA+ICAgICAg
ICAgfQ0KPiA+DQo=
