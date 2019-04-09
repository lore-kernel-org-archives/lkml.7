Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60BDAC10F13
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 02:07:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20526213F2
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 02:07:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="arTCTL05"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727201AbfDICHY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 22:07:24 -0400
Received: from mail-eopbgr130050.outbound.protection.outlook.com ([40.107.13.50]:15606
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726133AbfDICHY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 22:07:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+FoO1nLXdWSMjA3voJ1Epxs5CUrQ/lnRAM02sXYyQ5U=;
 b=arTCTL05iFMoo1B0N8e4m9uHPWAnkrYTEFt7ZMS3PW7PNhG8u6RzBw6mznx0WuKZzxeT6hxU/4Et5AlkUk5y1eYB8vHbL1VbSOss9HjeX7BcNooyrQajxAytHkRDHQB2EyfbNG/U+8BJo2FoA+cTjzYFzoSJkWvpxymySzKNI9g=
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com (52.135.138.152) by
 DB7PR04MB5242.eurprd04.prod.outlook.com (20.176.236.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.21; Tue, 9 Apr 2019 02:07:20 +0000
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::99f0:f8da:a123:e25]) by DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::99f0:f8da:a123:e25%3]) with mapi id 15.20.1771.016; Tue, 9 Apr 2019
 02:07:20 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     Stefan-gabriel Mirea <stefan-gabriel.mirea@nxp.com>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: RE: [PATCH V2 2/5] can: flexcan: add CAN FD mode support
Thread-Topic: [PATCH V2 2/5] can: flexcan: add CAN FD mode support
Thread-Index: AQHU3hMIFyY4rNIjS0Kc2R8JlKca+KYyqbcAgACE+JA=
Date:   Tue, 9 Apr 2019 02:07:20 +0000
Message-ID: <DB7PR04MB46181D2AC261EAB6DEECEFCCE62D0@DB7PR04MB4618.eurprd04.prod.outlook.com>
References: <20190319051512.14950-3-qiangqing.zhang@nxp.com>
 <385f7948-d12b-1fc2-2ed2-23d1e76034a0@nxp.com>
In-Reply-To: <385f7948-d12b-1fc2-2ed2-23d1e76034a0@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: mkl@pengutronix.de
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=qiangqing.zhang@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2aa086ef-1272-4930-85b0-08d6bc90192f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB7PR04MB5242;
x-ms-traffictypediagnostic: DB7PR04MB5242:
x-microsoft-antispam-prvs: <DB7PR04MB52423815053FA825FB1561B6E62D0@DB7PR04MB5242.eurprd04.prod.outlook.com>
x-forefront-prvs: 000227DA0C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(366004)(136003)(39860400002)(346002)(51444003)(54094003)(189003)(13464003)(199004)(6246003)(8936002)(99286004)(305945005)(55016002)(102836004)(71200400001)(9686003)(53546011)(97736004)(2906002)(6506007)(66066001)(14454004)(71190400001)(86362001)(74316002)(6436002)(478600001)(2201001)(229853002)(53936002)(7696005)(81156014)(81166006)(6116002)(33656002)(3846002)(316002)(110136005)(25786009)(7736002)(8676002)(5660300002)(76176011)(106356001)(52536014)(256004)(68736007)(26005)(14444005)(446003)(186003)(476003)(486006)(11346002)(105586002)(2501003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB5242;H:DB7PR04MB4618.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: q4kmf6X0WYutSM5Z+JY+DrpjmTMjT66MwqGd/idcjLfmJL4rwzi4SkjU6Yagt6fJLh4oNXz7xqwSXkLztwr8Oz5ARuVmJCT9IygTsO8eYaioU4g0cNIZjpTW/OPVZkzQQbp7YZMl8nJcdzekVexQPPU/i+01LH6+Ik9B96ZRlHsocydLP6Hwsyj1+PEcUGYwmH8Mt5syJUSszhuCnqVZgEVVpLVd6+tz4iGuJngO3wtruTdcjW+g3ikBOBY7SsfrcRbgU/kHjL5LwzuSQ3SjJUVweUlMdz5hu0RIQykaK7h2tSSGntw4lBvdmne0QiIz18IoNzRmsRmLcXYHRmjsNNHBCqjs4VMNrurFR26vHQ7PHSygMNk31sMsJ/DlxI80orJpSgrEuxcHKmIuU8uf6RCcRyqYIEq9AUw2dchXozc=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2aa086ef-1272-4930-85b0-08d6bc90192f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2019 02:07:20.2600
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5242
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpIaSBTdGVmYW4sDQoNClRoYW5rcyBmb3IgeW91ciB2YWxpZGF0aW9uISBDb3VsZCB5b3UgYWRk
IHlvdXIgdGVzdCB0YWcgaWYgeW91IGNhbiBzdWNjZXNzZnVsbHkgdmFsaWRhdGVkPw0KDQpDb21t
ZW50cyBpbi1saW5lZCBhYm91dCB5b3VyIHBvaW50cy4NCg0KQmVzdCBSZWdhcmRzLA0KSm9ha2lt
IFpoYW5nDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU3RlZmFuLWdh
YnJpZWwgTWlyZWENCj4gU2VudDogMjAxOcTqNNTCOcjVIDE6NDYNCj4gVG86IEpvYWtpbSBaaGFu
ZyA8cWlhbmdxaW5nLnpoYW5nQG54cC5jb20+OyBsaW51eC1jYW5Admdlci5rZXJuZWwub3JnOw0K
PiBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+
IFN1YmplY3Q6IFJlOiBbUEFUQ0ggVjIgMi81XSBjYW46IGZsZXhjYW46IGFkZCBDQU4gRkQgbW9k
ZSBzdXBwb3J0DQo+IA0KPiBIZWxsbyBKb2FraW0sDQo+IA0KPiBJIHN1Y2Nlc3NmdWxseSB2YWxp
ZGF0ZWQgeW91ciBDQU4gRkQgc3VwcG9ydCBvbiBhbiBTMzJWMjM0IGJhc2VkIGJvYXJkLg0KPiBI
ZXJlIGFyZSBzb21lIHBvaW50cyB3aGljaCBhcmUgbm90IHZlcnkgY2xlYXIgdG8gbWU6DQo+IA0K
PiBKb2FraW0gWmhhbmcgPHFpYW5ncWluZy56aGFuZ0BueHAuY29tPiB3cml0ZXM6DQo+ID4gKwkJ
cHJpdi0+d3JpdGUocmVnX21jciB8IEZMRVhDQU5fTUNSX0ZERU4sICZyZWdzLT5tY3IpOw0KPiAN
Cj4gQWNjb3JkaW5nIHRvIHRoZSBTMzJWMjM0IHJlZmVyZW5jZSBtYW51YWwgKG5vdCBzdXJlIGlm
IHRoaXMgYXBwbGllcyB0bw0KPiBpLk1YOFFNIGFzIHdlbGwpLCBDQU5fQ1RSTDFbU01QXSBjYW5u
b3QgYmUgYXNzZXJ0ZWQgd2hlbiBDQU4gRkQgaXMNCj4gZW5hYmxlZC4gSXMgaXQgc2FmZSB0byBj
b25maWd1cmUgdGhlIGludGVyZmFjZSB3aXRoIGJvdGggImZkIG9uIiBhbmQNCj4gInRyaXBsZS1z
YW1wbGluZyBvbiI/IElmIG5vdCwgZmxleGNhbl9vcGVuIHNob3VsZCByZXR1cm4gYW4gZXJyb3Ig
d2hlbiBib3RoDQo+IENBTl9DVFJMTU9ERV9GRCBhbmQgQ0FOX0NUUkxNT0RFXzNfU0FNUExFUyBh
cmUgc2V0IGluIGN0cmxtb2RlLg0KIA0KIFtKb2FraW0gWmhhbmddIFllcywgeW91IGFyZSByaWdo
dC4gSSBjaGVja2VkIGluIGkuTVg4UU0gcmVmZXJlbmNlIG1hbnVhbCwgQ0FOX0NUUkxNT0RFX0ZE
IGFuZCBDQU5fQ1RSTE1PREVfM19TQU1QTEVTIHNob3VsZCBub3Qgc2V0IHRvZ2V0aGVyLiBJIHdp
bGwgZml4IGl0IGluIFYzLg0KDQo+IEpvYWtpbSBaaGFuZyA8cWlhbmdxaW5nLnpoYW5nQG54cC5j
b20+IHdyaXRlczoNCj4gPiArCQlwcml2LT5vZmZsb2FkLmlzX2NhbmZkID0gdHJ1ZTsNCj4gDQo+
IFNob3VsZG4ndCBpc19jYW5mZCBiZSBhc3NpZ25lZCBmYWxzZSBpbiB0aGUgImVsc2UiIGJyYW5j
aD8gT3RoZXJ3aXNlLCBpc19jYW5mZA0KPiB3aWxsIHN0YXkgdHJ1ZSBhZnRlciB0aGUgZm9sbG93
aW5nIHNlcXVlbmNlOg0KPiANCj4gcm9vdEBzMzJ2MjM0ZXZiOn4jIGlwIGxpbmsgc2V0IGNhbjAg
dHlwZSBjYW4gYml0cmF0ZSA1MDAwMDAgZGJpdHJhdGUNCj4gMjAwMDAwMCBmZCBvbg0KPiByb290
QHMzMnYyMzRldmI6fiMgaXAgbGluayBzZXQgY2FuMCB1cA0KPiByb290QHMzMnYyMzRldmI6fiMg
aXAgbGluayBzZXQgY2FuMCBkb3duIHJvb3RAczMydjIzNGV2Yjp+IyBpcCBsaW5rIHNldA0KPiBj
YW4wIHR5cGUgY2FuIGJpdHJhdGUgNTAwMDAwIGZkIG9mZiByb290QHMzMnYyMzRldmI6fiMgaXAg
bGluayBzZXQgY2FuMCB1cA0KIA0KIFtKb2FraW0gWmhhbmddIEdvb2QgY2F0Y2ghIEkgd2lsbCBm
aXggaXQgaW4gVjMuDQoNCj4gTW9yZW92ZXIsIEkgd29uZGVyIGlmIHdlIGV2ZW4gbmVlZCBpc19j
YW5mZCwgYmVjYXVzZSBmcmFtZXMgc2hvdWxkIGJlIGZlZCB0bw0KPiB0aGUga2VybmVsIGFzIGNs
YXNzaWMgb3IgRkQgYmFzZWQgb25seSBvbiB0aGUgRURMIGJpdCBpbiB0aGUgQy9TIHdvcmQgb2Yg
dGhlIFJ4DQo+IE1CLCB0byBrZWVwIHRoZWlyIG9yaWdpbmFsIGZvcm1hdC4gVGhhdCBpcywgeW91
IG1heSBlaXRoZXIgcmVhZCBFREwgZnJvbSB3aXRoaW4NCj4gYSBuZXcgY2FsbGJhY2sgKGJ1dCBJ
IHRoaW5rIHRoYXQgbWFpbGJveF9yZWFkIHNob3VsZCByZW1haW4gdGhlIG9ubHkgb25lDQo+IHdo
aWNoIGJvdGggbG9ja3MgYW5kIHVubG9ja3MgdGhlDQo+IG1haWxib3hlcykgb3IgbGV0IG1haWxi
b3hfcmVhZCBjYWxsIGFsbG9jX2NhbihmZClfc2tiIGl0c2VsZi4NCg0KIFtKb2FraW0gWmhhbmdd
IFdlIGFkZGVkIGNhbiBmZCBzdXBwb3J0IGluIDQuOSBrZXJuZWwgd2hpY2ggbGV0IG1haWxib3hf
cmVhZCBjYWxsIGFsbG9jX2NhbihmZClfc2tiIGluIHRoZSBwYXN0LiBOb3cgdGhlIGRyaXZlciBh
bGxvY2F0ZSBza2IgYmVmb3JlIG1haWxib3hfcmVhZCBpbiByeF9vZmZsb2FkIGFuZCBhbHNvIHJl
YWQgdGhlIG92ZXJmbG93IGZyYW1lcy4NCiAgICAgICAgICAgICAgSSBhZGQgdGhlICJpc19jYW5m
ZCIgc2luY2UgSSBkb24ndCB3YW50IHRvIGNoYW5nZSB0aGUgcnhfb2ZmbG9hZCBmcmFtZXdvcmsg
dG9vIG11Y2guIEBta2xAcGVuZ3V0cm9uaXguZGUsIGNvdWxkIHlvdSBnaXZlIHNvbWUgYWR2aWNl
LCB3aGljaCBzb2x1dGlvbiBpcyBiZXR0ZXI/DQogICAgICAgICAgICAgIA0KPiBSZWdhcmRzLA0K
PiBTdGVmYW4NCg==
