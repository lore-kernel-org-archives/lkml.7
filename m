Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E48DC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 09:12:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2B8320989
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 09:12:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="T4+JkBBf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbfCSJMY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 05:12:24 -0400
Received: from mail-eopbgr10059.outbound.protection.outlook.com ([40.107.1.59]:15847
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726647AbfCSJMY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 05:12:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dq3JI1Qncewxt9mr52P0cf9BsChB3Lt9garfFOgWq2g=;
 b=T4+JkBBfOwI1Tx5iVct0vZ/vN5wuW64qI8Sc0vsV7UtdKScRtJyG6Bb+frejOni+1wYseTPrspZwjRUnPUZB3Lzz4F4DX+VYk27cwuxHEX6fzotP7Ro1BL4nKrnAJ9i56zkckl1VzOIJCtSBT7V7D8yDw5M571DhSN9kW23rJDE=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3673.eurprd04.prod.outlook.com (52.134.70.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.14; Tue, 19 Mar 2019 09:11:39 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::f1b4:a1fb:cfd1:3f08]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::f1b4:a1fb:cfd1:3f08%6]) with mapi id 15.20.1709.015; Tue, 19 Mar 2019
 09:11:39 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>
CC:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "stefan@agner.ch" <stefan@agner.ch>,
        "otavio@ossystems.com.br" <otavio@ossystems.com.br>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "schnitzeltony@gmail.com" <schnitzeltony@gmail.com>,
        "jan.tuerk@emtrion.com" <jan.tuerk@emtrion.com>,
        Robin Gong <yibin.gong@nxp.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH RESEND V6 0/5] Add i.MX7ULP EVK PWM backlight support
Thread-Topic: [PATCH RESEND V6 0/5] Add i.MX7ULP EVK PWM backlight support
Thread-Index: AQHU3iLBE3J6DkOMWUeqgsrQO1bJTqYSm1sAgAAPCFA=
Date:   Tue, 19 Mar 2019 09:11:38 +0000
Message-ID: <DB3PR0402MB39165E52E113BAB7B66AFB24F5400@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1552979097-5814-1-git-send-email-Anson.Huang@nxp.com>
 <20190319081446.m5eboi4v54er3niv@pengutronix.de>
In-Reply-To: <20190319081446.m5eboi4v54er3niv@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.69]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 31071746-388a-4889-4113-08d6ac4ae51a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3673;
x-ms-traffictypediagnostic: DB3PR0402MB3673:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DB3PR0402MB367382A67E7305FD8D793C2EF5400@DB3PR0402MB3673.eurprd04.prod.outlook.com>
x-forefront-prvs: 0981815F2F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(366004)(376002)(39860400002)(136003)(199004)(189003)(13464003)(54534003)(6436002)(186003)(86362001)(11346002)(6116002)(3846002)(476003)(6916009)(81156014)(97736004)(446003)(486006)(8936002)(966005)(45080400002)(102836004)(6506007)(26005)(55016002)(99286004)(53546011)(4326008)(7416002)(25786009)(7696005)(14454004)(6246003)(105586002)(2906002)(6306002)(81166006)(106356001)(9686003)(76176011)(53936002)(33656002)(478600001)(68736007)(305945005)(74316002)(66574012)(71190400001)(44832011)(54906003)(7736002)(316002)(71200400001)(66066001)(256004)(229853002)(5660300002)(8676002)(52536014);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3673;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: lftZLMtMtt55WyjR/ZrMyouL9iZGfpN4Z7RSQr+WBi8+1N8/va4GsdkF1WjR7l6sWFMLJK/FD2bmnaBU1YjOIn1scnEwtkIupCan0DMAr3oNQDD6OvAnHgQ9kGuZ+ZY/psKgM4YwZfCPNXLg4YDcoBGCQH7jGXdaRUVdNJgvKN9jAoiYhtLn+JxQbx6/x4UE+EMkr3w4bx7umv6Z76J/qsSw7wMH2AT5Wf1LAPvAIdOlEE/XD46KEV2c1SO4aqN0IYYiFBeIlxjuZmW8nYkZZkCs0QHf5qhXqL3kCef0NU2NGHzcyQjprzbaJjEFAcOTTWLGjfsumabBgFxc9rz7/QY6aAcfosfuz2fRZzggLwpjfHTQ+Ul7cU7D2Drp5MZPlUhVebMyYTirGuBmtnDHs9guAtPqsIRng3cmHDK6a5Q=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31071746-388a-4889-4113-08d6ac4ae51a
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2019 09:11:38.9013
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3673
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCkJlc3QgUmVnYXJkcyENCkFuc29uIEh1YW5nDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4gRnJvbTogVXdlIEtsZWluZS1Lw7ZuaWcgW21haWx0bzp1LmtsZWluZS1rb2Vu
aWdAcGVuZ3V0cm9uaXguZGVdDQo+IFNlbnQ6IDIwMTnlubQz5pyIMTnml6UgMTY6MTUNCj4gVG86
IEFuc29uIEh1YW5nIDxhbnNvbi5odWFuZ0BueHAuY29tPg0KPiBDYzogdGhpZXJyeS5yZWRpbmdA
Z21haWwuY29tOyByb2JoK2R0QGtlcm5lbC5vcmc7IG1hcmsucnV0bGFuZEBhcm0uY29tOw0KPiBz
aGF3bmd1b0BrZXJuZWwub3JnOyBzLmhhdWVyQHBlbmd1dHJvbml4LmRlOyBrZXJuZWxAcGVuZ3V0
cm9uaXguZGU7DQo+IGZlc3RldmFtQGdtYWlsLmNvbTsgbGludXhAYXJtbGludXgub3JnLnVrOyBz
dGVmYW5AYWduZXIuY2g7DQo+IG90YXZpb0Bvc3N5c3RlbXMuY29tLmJyOyBMZW9uYXJkIENyZXN0
ZXogPGxlb25hcmQuY3Jlc3RlekBueHAuY29tPjsNCj4gc2Nobml0emVsdG9ueUBnbWFpbC5jb207
IGphbi50dWVya0BlbXRyaW9uLmNvbTsgUm9iaW4gR29uZw0KPiA8eWliaW4uZ29uZ0BueHAuY29t
PjsgbGludXgtcHdtQHZnZXIua2VybmVsLm9yZzsNCj4gZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5v
cmc7IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgtDQo+IGtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmc7IGRsLWxpbnV4LWlteCA8bGludXgtaW14QG54cC5jb20+DQo+IFN1
YmplY3Q6IFJlOiBbUEFUQ0ggUkVTRU5EIFY2IDAvNV0gQWRkIGkuTVg3VUxQIEVWSyBQV00gYmFj
a2xpZ2h0DQo+IHN1cHBvcnQNCj4gDQo+IE9uIFR1ZSwgTWFyIDE5LCAyMDE5IGF0IDA3OjA5OjU2
QU0gKzAwMDAsIEFuc29uIEh1YW5nIHdyb3RlOg0KPiA+IGkuTVg3VUxQIEVWSyBib2FyZCBoYXMg
TUlQSS1EU0kgZGlzcGxheSwgaXRzIGJhY2tsaWdodCBpcyBzdXBwbGllZCBieQ0KPiA+IFRQTSBQ
V00gbW9kdWxlLCB0aGlzIHBhdGNoIHNldCBlbmFibGVzIGkuTVg3VUxQIFRQTSBQV00gZHJpdmVy
DQo+IHN1cHBvcnQNCj4gPiBhbmQgYWxzbyBhZGQgYmFja2xpZ2h0IHN1cHBvcnQgZm9yIE1JUEkt
RFNJIGRpc3BsYXkuDQo+IA0KPiBHaXZlbiB0aGF0IHlvdSBhY3R1YWxseSBjaGFuZ2VkIHNvbWV0
aGluZyBjb21wYXJlZCB0byB2NiwgdGhpcyBpcyBub3QgYQ0KPiByZXNlbmQgYnV0IHY3LiBBbHNv
IEkgc3VnZ2VzdCB0byBwcmFjdGlzZSBhIGJpdCBvZiBwYXRpZW5jZSBiZWZvcmUgc2VuZGluZyBv
dXQNCj4gYSBuZXcgcmV2aXNpb24gdG8gcHJldmVudCBwZW9wbGUgc3RpbGwgbG9va2luZyBhdCB0
aGUgcHJldmlvdXMgcm91bmQuIEkganVzdA0KPiBnYXZlIGZlZWRiYWNrIHRvIHRoZSBvcmlnaW5h
bCB2NiB3aGljaCB5b3Ugb2J2aW91c2x5IGRpZG4ndCBhZGRyZXNzIDotfA0KPiANCj4gQWxzbyBh
IGhpZ2hsZXZlbCBjaGFuZ2Vsb2cgZm9yIHRoZSBzZXJpZXMgKGhlcmUgc29tZXRoaW5nIGxpa2U6
ICJQcm9wZXJseQ0KPiBzZXBhcmF0ZSBkdCBjaGFuZ2VzIGludG8gc29jLXNwZWNpZmljIGFuZCBt
YWNoaW5lLXNwZWNpZmljIGNoYW5nZXMiKSBpcw0KPiBoZWxwZnVsLg0KDQpPSywgd2lsbCBwYXkg
YXR0ZW50aW9uIHRvIHRoYXQsIHRoZSByZXNlbmQgaXMganVzdCBiZWNhdXNlIHRoZSBwYXRjaCBj
b250ZW50IGlzIE5PVA0KQ2hhbmdlZCwganVzdCByZS1vcmdhbml6ZSB0aGUgRFQgcGF0Y2guDQoN
CkFsc28sIEkgdW5kZXJzdGFuZCB0aGF0IHNlbmRpbmcgdGhlIHBhdGNoIHZlcnNpb24gdG9vIHF1
aWNrbHkgd2lsbCByZXN1bHQgaW4gdG9vIG1hbnkNClBhdGNoIHZlcnNpb24gaW4gdGhpcyB0aHJl
YWQsIGJ1dCBJIGp1c3Qgd2FudCB0byBhZGRyZXNzIHRoZSBjb21tZW50cyBBU0FQIHdoZW4gSQ0K
SGF2ZSB0aW1lLCBob3BlIHRoYXQgZG9lcyBOT1QgYm90aGVyIHJldmlld2VyIHRvbyBtdWNoLi4u
DQoNClRoYW5rcyBmb3IgeW91ciBwYXRpZW5jZSENCkFuc29uLg0KDQo+IA0KPiBCZXN0IHJlZ2Fy
ZHMNCj4gVXdlDQo+IA0KPiAtLQ0KPiBQZW5ndXRyb25peCBlLksuICAgICAgICAgICAgICAgICAg
ICAgICAgICAgfCBVd2UgS2xlaW5lLUvDtm5pZyAgICAgICAgICAgIHwNCj4gSW5kdXN0cmlhbCBM
aW51eCBTb2x1dGlvbnMgICAgICAgICAgICAgICAgIHwNCj4gaHR0cHM6Ly9ldXIwMS5zYWZlbGlu
a3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHAlM0ElMkYlMkZ3d3cucA0KPiBlbmd1
dHJvbml4LmRlJTJGJmFtcDtkYXRhPTAyJTdDMDElN0NhbnNvbi5odWFuZyU0MG54cC5jb20lN0M0
ZjENCj4gZmY5NGUyZTJhNDQxOTlkMzgwOGQ2YWM0MmY5MTYlN0M2ODZlYTFkM2JjMmI0YzZmYTky
Y2Q5OWM1YzMwMTYzNSUNCj4gN0MwJTdDMCU3QzYzNjg4NTgwMDk3ODc5MDgyNCZhbXA7c2RhdGE9
cCUyRkszc3VydXVCRlJQblc4blolMg0KPiBCRlpwbFYycjBpMjJONkpxNEhpN0RCd3A0JTNEJmFt
cDtyZXNlcnZlZD0wICB8DQo=
