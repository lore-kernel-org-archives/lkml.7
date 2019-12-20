Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57642C2D0D2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 15:26:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2253F2146E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 15:26:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="QZNRc8JZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbfLTP0b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 10:26:31 -0500
Received: from mail-eopbgr30049.outbound.protection.outlook.com ([40.107.3.49]:19840
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727233AbfLTP0a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 10:26:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hLQxLjkhwovYOKq5Pwwl+HGgvTq0kUNQ1oTBCQZjXmXfiG/gChaYpA+2GkzXleVnN5v5XC7TOi5jG0EKQTuaZEjcphBvyPxPWJZZNl1cdRkC0auDDPmYWsXm68BlRgpfDGPLh7uGRH/nbgdBSa3WMp9TILwYIUi4sd3QrS59cBQJumK7cizIlRWBH7hitlDlKXcdbfdjeq+ysJF51WszRiQwvPcgJp0O1jcrznKmske+zrFySgOusohCfPMmLP4IBSs64YxLDJN1eGbUxLlL6vVATplQ0jpGk4BjfZ+RiyvDgVSo4hmuZoK8TrAedfglBi3ZSGhn6bTyhpbGcYHwIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9hcB23s9PRyBtuiePuuU27vSodo00NsjBxBIo9AykiA=;
 b=ODUyTY0wx8vjsjttdkCSxoXnRPGKrAd5thcAP//PBogu1G6Mx6ajxNw6WaE6ym+twkTh4Xvhn+Q3iA9JBp0+n4LcurSxsvgU5PV6YdhYmI7Z1U2p4k28CmbFl2Io1hRqNFoNwB3F6nSsI5/Te4UYJ3rPHAsMZMobOkOCIQEiNtXVVcjTnquqLKQG8zhwRDUuscaY8xWvIL1G2BccOrJT4gWchpuKnmsRyy6HHJdnY82X5Di7aG4MO8FHX7EGxjSGpWhl8x60MwMtP5KeJu0UBH8aecB4VXreE/ZSCo+fzI/D1PX++E8d7/h0rfgYGPQNhKW1Lv6BL9mZZ3/1D9oSTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9hcB23s9PRyBtuiePuuU27vSodo00NsjBxBIo9AykiA=;
 b=QZNRc8JZEb0oeUGnQUKUK2AAdA2NI0FemF7tCKF44CZ/U3qmXjCyADyv1HQaELnMjGRRsG5uw/0P947HiBRisQlLdY8JbEB4uVYzi9EDZuEF+9DPuSZVYnXs2qZC6Mg/yB9z1qEvojqJx+1v8ep6jj+NV2Ff1JJO3BL9ZpkGSDM=
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com (52.135.139.151) by
 DB7PR04MB4683.eurprd04.prod.outlook.com (52.135.139.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.16; Fri, 20 Dec 2019 15:26:26 +0000
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::b40b:46af:9458:f2df]) by DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::b40b:46af:9458:f2df%6]) with mapi id 15.20.2559.016; Fri, 20 Dec 2019
 15:26:26 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     Marc Zyngier <maz@kernel.org>
CC:     Lokesh Vutla <lokeshvutla@ti.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "jason@lakedaemon.net" <jason@lakedaemon.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        Andy Duan <fugang.duan@nxp.com>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH V3 2/2] drivers/irqchip: add NXP INTMUX interrupt
  multiplexer support
Thread-Topic: [PATCH V3 2/2] drivers/irqchip: add NXP INTMUX interrupt
  multiplexer support
Thread-Index: AQHVt0CZN4VDSg4vrkOd54zakVbswKfDIpPA
Date:   Fri, 20 Dec 2019 15:26:26 +0000
Message-ID: <DB7PR04MB4618A390C538DCD6929DE998E62D0@DB7PR04MB4618.eurprd04.prod.outlook.com>
References: <1576827431-31942-1-git-send-email-qiangqing.zhang@nxp.com>
 <1576827431-31942-3-git-send-email-qiangqing.zhang@nxp.com>
 <ad5165ba-24d7-ceeb-8794-cdbe4e564bd5@ti.com>
 <DB7PR04MB4618B9A227807CCF884910C6E62D0@DB7PR04MB4618.eurprd04.prod.outlook.com>
 <8bc6bcf113cce13816c62c166f091785@www.loen.fr>
In-Reply-To: <8bc6bcf113cce13816c62c166f091785@www.loen.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=qiangqing.zhang@nxp.com; 
x-originating-ip: [117.81.222.152]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e60574f5-2a06-403a-4eb5-08d78560faad
x-ms-traffictypediagnostic: DB7PR04MB4683:|DB7PR04MB4683:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB7PR04MB4683B6ABDF7E2811A79588B8E62D0@DB7PR04MB4683.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 025796F161
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(346002)(376002)(366004)(136003)(39860400002)(13464003)(199004)(189003)(4326008)(54906003)(2906002)(478600001)(7416002)(81166006)(8676002)(81156014)(66946007)(76116006)(66476007)(8936002)(66556008)(66446008)(64756008)(7696005)(4001150100001)(55016002)(9686003)(52536014)(5660300002)(186003)(6916009)(6506007)(53546011)(26005)(33656002)(86362001)(71200400001)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4683;H:DB7PR04MB4618.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Zz7mfc3/wZ480VOptjZrITc60MHGKux92GGxMHRglAgDDAU74Q6AaUXw1DEcEU0tIdV+sks+pALMkIHDkYL3jUsH07zcsnTXwdFcDGYWbHITmwYNIhAcpNdKHJVjwVkF3ayFTQGP2mCnkTSya6GPJbkc2sf0TBVnUScVKHLOKaz42cRtZMuP8r+dWjrSNwrZT2ck2pMtpsC9xiKJTLxy9JKHYm2YDoJodpMjISKy4mhbxgeqQse2ofWksjjPMT0fI6Glar3BuODi6CY1Hi2boxhZf0bGHAW7WGxaHZBKfdIBbUn2JtW1uTZDxId1aAMaPNC7dXZ5o5xKRXng+9M/sqovIAdGvlj8aiakcmTKxCXf7zTV3e/Ua165oU8wNKr5MhZ9qfAWq4cc37bmpU4w33C/SZPSYwMD39N3FWdOiTLt9jE5aQ+7hfy8h2OvoJWtMyZ/kNVAO27RUL9XFdS4t0Gs7Pr/NHNYtlHpwKqBV+DvO/2iyZB413PxLV6Ggx4Z
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e60574f5-2a06-403a-4eb5-08d78560faad
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2019 15:26:26.3352
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B6swJNWeNIQawWF2xdR8MK6C49qbHHzVooCFU4b9S9sie7LoYpGv7BrE8pEYmKqZFSEbGsW0T8k0lD+MT45gNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4683
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE1hcmMgWnluZ2llciA8bWF6
QGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDIwMTnlubQxMuaciDIw5pelIDIyOjIwDQo+IFRvOiBKb2Fr
aW0gWmhhbmcgPHFpYW5ncWluZy56aGFuZ0BueHAuY29tPg0KPiBDYzogTG9rZXNoIFZ1dGxhIDxs
b2tlc2h2dXRsYUB0aS5jb20+OyB0Z2x4QGxpbnV0cm9uaXguZGU7DQo+IGphc29uQGxha2VkYWVt
b24ubmV0OyByb2JoK2R0QGtlcm5lbC5vcmc7IG1hcmsucnV0bGFuZEBhcm0uY29tOw0KPiBzaGF3
bmd1b0BrZXJuZWwub3JnOyBzLmhhdWVyQHBlbmd1dHJvbml4LmRlOyBBbmR5IER1YW4NCj4gPGZ1
Z2FuZy5kdWFuQG54cC5jb20+OyBTLmouIFdhbmcgPHNoZW5naml1LndhbmdAbnhwLmNvbT47DQo+
IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGRsLWxpbnV4LWlteCA8bGludXgtaW14QG54
cC5jb20+Ow0KPiBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMu
aW5mcmFkZWFkLm9yZw0KPiBTdWJqZWN0OiBSRTogW1BBVENIIFYzIDIvMl0gZHJpdmVycy9pcnFj
aGlwOiBhZGQgTlhQIElOVE1VWCBpbnRlcnJ1cHQNCj4gbXVsdGlwbGV4ZXIgc3VwcG9ydA0KPiAN
Cj4gT24gMjAxOS0xMi0yMCAxNDoxMCwgSm9ha2ltIFpoYW5nIHdyb3RlOg0KPiA+PiAtLS0tLU9y
aWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+PiBGcm9tOiBMb2tlc2ggVnV0bGEgPGxva2VzaHZ1dGxh
QHRpLmNvbT4NCj4gDQo+IFsuLi5dDQo+IA0KPiA+PiBEb2VzIHRoZSB1c2VyIGNhcmUgdG8gd2hp
Y2ggY2hhbm5lbCBkb2VzIHRoZSBpbnRlcnJ1cHQgc291cmNlIGdvZXMNCj4gPj4gdG8/IElmIG5v
dCwgaW50ZXJydXB0LWNlbGxzIGluIERUIGNhbiBqdXN0IGJlIGEgc2luZ2xlIGVudHJ5IGFuZCB0
aGUNCj4gPj4gY2hhbm5lbCBzZWxlY3Rpb24gY2FuIGJlIGNvbnRyb2xsZWQgYnkgdGhlIGRyaXZl
ciBubz8gSSBhbSB0cnlpbmcgdG8NCj4gPj4gdW5kZXJzdGFuZCB3aHkgdXNlciBzaG91bGQgc3Bl
Y2lmeSB0aGUgY2hhbm5lbCBuby4NCj4gPiBIaSBMb2tlc2gsDQo+ID4NCj4gPiBJZiBhIGZpeGVk
IGNoYW5uZWwgaXMgc3BlY2lmaWVkIGluIHRoZSBkcml2ZXIsIGFsbCBpbnRlcnJ1cHQgc291cmNl
cw0KPiA+IHdpbGwgYmUgY29ubmVjdGVkIHRvIHRoaXMgY2hhbm5lbCwgYWZmZWN0aW5nIHRoZSBp
bnRlcnJ1cHQgcHJpb3JpdHkgdG8NCj4gPiBzb21lIGV4dGVudC4NCj4gPg0KPiA+IEZyb20gbXkg
cG9pbnQgb2YgdmlldywgYSBmaXhlZCBjaGFubmVsIGNvdWxkIGJlIGVub3VnaCBpZiBkb24ndCBj
YXJlDQo+ID4gaW50ZXJydXB0IHByaW9yaXR5Lg0KPiANCj4gSG9sZCBvbiBhIHNlYzoNCj4gDQo+
IElzIHRoZSBjaGFubmVsIHRvIHdoaWNoIGFuIGludGVycnVwdCBpcyByb3V0ZWQgdG8gcHJvZ3Jh
bW1hYmxlPyBXaGF0IGhhcyB0aGUNCj4gcHJpb3JpdHkgb2YgdGhlIGludGVycnVwdCB0byBkbyB3
aXRoIHRoaXM/IEhvdyBkb2VzIHRoaXMgYWZmZWN0IGludGVycnVwdA0KPiBkZWxpdmVyeT8NCj4g
DQo+IEl0IGxvb2tzIGxpa2UgdGhpcyBIVyBkb2VzIG1vcmUgdGhhdCB5b3UgaW5pdGlhbGx5IGV4
cGxhaW5lZC4uLg0KSGkgTWFyYywNCg0KVGhlIGNoYW5uZWwgdG8gd2hpY2ggYW4gaW50ZXJydXB0
IGlzIHJvdXRlZCB0byBpcyBub3QgcHJvZ3JhbW1hYmxlLiBFYWNoIGNoYW5uZWwgaGFzIHRoZSBz
YW1lIDMyIGludGVycnVwdCBzb3VyY2VzLg0KRWFjaCBjaGFubmVsIGhhcyBtYXNrLCB1bm1hc2sg
YW5kIHN0YXR1cyByZWdpc3Rlci4NCklmIHVzZSAxIGNoYW5uZWwsIDMyIGludGVycnVwdCBzb3Vy
Y2VzIGlucHV0IGFuZCAxIGludGVycnVwdCBvdXRwdXQuDQpJZiB1c2UgMiBjaGFubmVscywgMzIg
aW50ZXJydXB0IHNvdXJjZXMgaW5wdXQgYW5kIDIgaW50ZXJydXB0cyBvdXRwdXQuDQpBbmQgc28g
b24uIFlvdSBjYW4gc2VlIGFib3ZlIElOVE1VWCBibG9jayBkaWFncmFtLiBUaGlzIGlzIGhvdyBI
VyB3b3Jrcy4NCg0KRm9yIGV4YW1wbGU6DQoxKSB1c2UgMSBjaGFubmVsOg0KV2UgY2FuIGVuYWJs
ZSAwfjMxIGludGVycnVwdCBpbiBjaGFubmVsIDAuIEFuZCAxIGludGVycnVwdCBvdXRwdXQuIElm
IGdlbmVyYXRlIGludGVycnVwdCwgd2UgY2Fubm90IGZpZ3VyZSBvdXQgd2hpY2ggaGFsZiBoYXBw
ZW5lZCBmaXJzdC4NCjIpdXNlIDIgY2hhbm5lbHM6DQpXZSBjYW4gZW5hYmxlIDB+MTUgaW50ZXJy
dXB0IGluIGNoYW5uZWwgMCwgYW5kIGVuYWJsZSAxNn4zMSBpbiBjaGFubmVsIDEuIEFuZCAyIGlu
dGVycnVwdHMgb3V0cHV0LiBJZiBnZW5lcmF0ZSBpbnRlcnJ1cHQsIGF0IGxlYXN0IHdlIGNhbiBm
aW5kIGNoYW5uZWwgMCBvciBjaGFubmVsIDEgZmlyc3QuIFRoZW4gZmluZCAwfjE1IG9yIDE2fjMx
IGZpcnN0Lg0KDQpUaGlzIGlzIG15IHVuZGVyc3RhbmRpbmcgb2YgdGhlIGludGVycnVwdCBwcmlv
cml0eSBmcm9tIHRoaXMgaW50bXV4LCBJIGRvbid0IGtub3cgaWYgaXQgaXMgbXkgbWlzdW5kZXJz
dGFuZGluZy4NCg0KQmVzdCBSZWdhcmRzLA0KSm9ha2ltIFpoYW5nDQo+ICAgICAgICAgIE0uDQo+
IC0tDQo+IEphenogaXMgbm90IGRlYWQuIEl0IGp1c3Qgc21lbGxzIGZ1bm55Li4uDQo=
