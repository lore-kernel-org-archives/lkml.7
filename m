Return-Path: <SRS0=7h0X=2M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9B1EC2D0D4
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Dec 2019 08:33:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD2AE20733
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Dec 2019 08:33:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Fp3musXE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726048AbfLVIdq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Dec 2019 03:33:46 -0500
Received: from mail-eopbgr150087.outbound.protection.outlook.com ([40.107.15.87]:6551
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725853AbfLVIdp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Dec 2019 03:33:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WRfxznIBqRNDDgjxFZrcFigeDEMcVBCR1fRuqAy6+NZiZ1/aPbkOoUMoA3t9R9X0vyKKZgxm5TbWCN8UzLG+7362xU0icDONrlOHtvezFAXg4KPzvDGZsm7hORIxQwRR9s/wWt8F+c0o1Ety2IpqxUGZtBzU0d5nb1etrBu9H2j2MftrfYc0C/OcnTlDqRSqYzlRkbMTEmp8OzjKDZb3sD1OJZEvlmzwIqRJ28i/ocRtnbmkJs0pMg3dZAlcbFtRk4uD2w+ishU4NAKC9sI7Q5lQMqroS2TlF4Dwu2TcReGEaktF8EOaZJR3oaxWzSxnulsPfzyIHWzVGlfyg6y4TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wiuebbQxG4m+g5zj95Co2xPf+L1xEARNpxcqY/cLDuo=;
 b=jsVAfYPseUU9uCSCHSIFMXy4y8RF/LOBDsCX3MPupUAsofEDlMQB0hNRzIc/9rtaFvBL754c9AazvlX2qxA43CAawT4o/W0uz7kPCSlzRCkRGZj8pz57qbggmxVut2+XQRG6qgOJag6apvuviayyKDDgujNsGKkw2nJVchfi94cVdNAxIaGyWuunkMUkREu1cOia6avWQtnkI19EeHBx/3KDQinrM48L94yJnp45nJ72QA5X6QciuWpjv1vdO4svluuiwnvGLRGMkgBx/nJx7ZjYiFyMBX51cCnmQPLPhtu2t3ZA+iDgSQGoMnH7m8XZn8rC5rpndEZGwgKRTQbotQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wiuebbQxG4m+g5zj95Co2xPf+L1xEARNpxcqY/cLDuo=;
 b=Fp3musXE5lq01HwldVh4UU8bru0ml9nqCOIswHCmgTP+VIZX70RakAGW62TDK+Yc4OKg57xkXuAoXsIdx4yPrOTDrUFd3g+HQTvTjJa+dTP3zSoeOBNy+X0DikUTVysmS22jZ+NGZpAWc2bAFxHRpxNRHfRgDIXOYXSL9AEokCE=
Received: from DB7PR04MB5178.eurprd04.prod.outlook.com (20.176.234.92) by
 DB7PR04MB4091.eurprd04.prod.outlook.com (52.134.110.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.19; Sun, 22 Dec 2019 08:33:40 +0000
Received: from DB7PR04MB5178.eurprd04.prod.outlook.com
 ([fe80::1551:2aea:3229:156c]) by DB7PR04MB5178.eurprd04.prod.outlook.com
 ([fe80::1551:2aea:3229:156c%4]) with mapi id 15.20.2559.015; Sun, 22 Dec 2019
 08:33:40 +0000
From:   Jacky Bai <ping.bai@nxp.com>
To:     Adam Ford <aford173@gmail.com>,
        arm-soc <linux-arm-kernel@lists.infradead.org>
CC:     Peng Fan <peng.fan@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>
Subject: RE: [PATCH V2 0/7] soc: imx: Enable additional functionality of
 i.MX8M Mini
Thread-Topic: [PATCH V2 0/7] soc: imx: Enable additional functionality of
 i.MX8M Mini
Thread-Index: AQHVsc8x4RTvJU9lNECpxKqRtqzo7KfEvPUAgAEe+lA=
Date:   Sun, 22 Dec 2019 08:33:40 +0000
Message-ID: <DB7PR04MB5178EA739587B2DB084570B9872F0@DB7PR04MB5178.eurprd04.prod.outlook.com>
References: <20191213160542.15757-1-aford173@gmail.com>
 <CAHCN7xKuVCGqgRpixa9UPkWq92Gg=dm4XxAczBKAZCoMzcBVJg@mail.gmail.com>
In-Reply-To: <CAHCN7xKuVCGqgRpixa9UPkWq92Gg=dm4XxAczBKAZCoMzcBVJg@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ping.bai@nxp.com; 
x-originating-ip: [114.220.27.191]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c4d18664-3f7e-4e9f-e1ce-08d786b9a5d1
x-ms-traffictypediagnostic: DB7PR04MB4091:|DB7PR04MB4091:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB7PR04MB40912925CE1F0D178ECEAA13872F0@DB7PR04MB4091.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 02596AB7DA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(396003)(136003)(39860400002)(366004)(189003)(199004)(13464003)(2906002)(54906003)(71200400001)(66556008)(66946007)(66476007)(478600001)(76116006)(52536014)(33656002)(64756008)(5660300002)(66446008)(4326008)(7416002)(9686003)(86362001)(26005)(186003)(8676002)(81166006)(8936002)(6506007)(316002)(110136005)(55016002)(53546011)(81156014)(7696005);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4091;H:DB7PR04MB5178.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TXYSzY9HweQ8wfPfBYf6qcY2yLEYOxPJHYXQfw5sQYZnmV/cpQaCht2POyY9/X37gdosUIfNH/PpCtiyEQEw7c9BUOit2H1DKwhm91N6307WdQSS/CYs3dXGDCddjwJSq8RLJk27CDEgr+EFFrqasGUUhpxdD19NEpJaYKqqF0Ue1g7qdogc5+1xgP8ZcfjImLfno/BTN1jGSx7AUC6b604qihiwfZACHvjqBKRP0kq3vx8fHjtyMna8VJhCQkRKT9An54B+j9Yui6w/zecOl2pDzRchUCjgDwqyqo80Uqw3tN46/zOPLUx5ToOPnHZiOrB04h84uovz4Rj3YMKOUrH88Z0hGAv+6xRmEitptEuTVyTr+bI5o+XrhzUSblMu7fRq0KVp+x5UDxokRI2UfiToH3rKfyDrsqlEPDGI6b1aERo5aYiE13ttPUy5inB7rDrF93hZBseSACcraqanIUUqyZ9AaS70t50HGxu+gHZHqeIm9lB393AuijQGWFid
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4d18664-3f7e-4e9f-e1ce-08d786b9a5d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Dec 2019 08:33:40.3902
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w87p7M5o7M21VE3putApA/ffui0wo8MlX0PnoDHNOkawvfKoLOfKMNMkyauP6eJDII6zAQhQfSPRBlxLCfx1oQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4091
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBZGFtIEZvcmQgPGFmb3JkMTcz
QGdtYWlsLmNvbT4NCj4gU2VudDogU2F0dXJkYXksIERlY2VtYmVyIDIxLCAyMDE5IDExOjA3IFBN
DQo+IFRvOiBhcm0tc29jIDxsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc+DQo+
IENjOiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT47IEphY2t5IEJhaSA8cGluZy5iYWlAbnhw
LmNvbT47IFJvYg0KPiBIZXJyaW5nIDxyb2JoK2R0QGtlcm5lbC5vcmc+OyBNYXJrIFJ1dGxhbmQg
PG1hcmsucnV0bGFuZEBhcm0uY29tPjsNCj4gU2hhd24gR3VvIDxzaGF3bmd1b0BrZXJuZWwub3Jn
PjsgU2FzY2hhIEhhdWVyDQo+IDxzLmhhdWVyQHBlbmd1dHJvbml4LmRlPjsgUGVuZ3V0cm9uaXgg
S2VybmVsIFRlYW0NCj4gPGtlcm5lbEBwZW5ndXRyb25peC5kZT47IEZhYmlvIEVzdGV2YW0gPGZl
c3RldmFtQGdtYWlsLmNvbT47DQo+IGRsLWxpbnV4LWlteCA8bGludXgtaW14QG54cC5jb20+OyBk
ZXZpY2V0cmVlIDxkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZz47DQo+IExpbnV4IEtlcm5lbCBN
YWlsaW5nIExpc3QgPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+OyBMZW9uYXJkIENyZXN0
ZXoNCj4gPGxlb25hcmQuY3Jlc3RlekBueHAuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIFYy
IDAvN10gc29jOiBpbXg6IEVuYWJsZSBhZGRpdGlvbmFsIGZ1bmN0aW9uYWxpdHkgb2YNCj4gaS5N
WDhNIE1pbmkNCj4gDQo+IE9uIEZyaSwgRGVjIDEzLCAyMDE5IGF0IDEwOjA1IEFNIEFkYW0gRm9y
ZCA8YWZvcmQxNzNAZ21haWwuY29tPiB3cm90ZToNCj4gPg0KPiA+IFRoZSBHUEN2MiBjb250cm9s
bGVyIG9uIHRoZSBpLk1YOE0gTWluaSBpcyBjb21wYXRpYmxlIHdpdGggdGhlIGRyaXZlcg0KPiA+
IHVzZWQgZm9yIHRoZSBpLk1YOE1RIGV4Y2VwdCBmb3IgdGhlIHJlZ2lzdGVyIGxvY2F0aW9ucyBh
bmQgbmFtZXMuDQo+ID4gVGhlIEdQQ3YyIGNvbnRyb2xsZXIgaXMgdXNlZCB0byBlbmFibGUgYWRk
aXRpb25hbCBwZXJpcGVyYWxzIGN1cnJlbnRseQ0KPiA+IHVuYXZhaWxhYmxlIG9uIHRoZSBpLk1Y
OE0gTWluaS4gIEluIG9yZGVyIHRvIG1ha2UgdGhlbSBmdW5jdGlvbiwgdGhlDQo+ID4gR1BDdjIg
bmVlZHMgdG8gYmUgYWRhcHRlZCBzbyB0aGUgZHJpdmVycyBjYW4gYXNzb2NpYXRlIHRoZWlyIHBv
d2VyDQo+ID4gZG9tYWluIHRvIHRoZSBHUEN2MiB0byBlbmFibGUgdGhlbS4NCj4gPg0KPiA+IFRo
aXMgc2VyaWVzIG1ha2VzIG9uZSBpbmNsdWRlIGZpbGUgc2xpZ2h0bHkgbW9yZSBnZW5lcmljLCBh
ZGRzIHRoZQ0KPiA+IGlNWDhNIE1pbmkgZW50cmllcywgdXBkYXRlcyB0aGUgYmluZGluZ3MsIGFk
ZHMgdGhlbSB0byB0aGUgZGV2aWNlDQo+ID4gdHJlZSwgdGhlbiBhc3NvY2lhdGVzIHRoZSBuZXcg
cG93ZXIgZG9tYWluIHRvIGJvdGggdGhlIE9URyBhbmQgUENJZQ0KPiA+IGNvbnRyb2xsZXJzLg0K
PiA+DQo+ID4gU29tZSBwZXJpcGhlcmFscyBtYXkgbmVlZCBhZGRpdGlvbmFsIHBvd2VyIGRvbWFp
biBkcml2ZXJzIGluIHRoZQ0KPiA+IGZ1dHVyZSBkdWUgdG8gbGltaXRhdGlvbnMgb2YgdGhlIEdQ
QyBkcml2ZXIsIGJ1dCB0aGUgZHJpdmVycyBmb3IgVlBVDQo+ID4gYW5kIG90aGVycyBhcmUgbm90
IGF2YWlsYWJsZSB5ZXQuDQo+IA0KPiBCZWZvcmUgSSBkbyBhIFYzIHRvIGFkZHJlc3MgUm9iJ3Mg
Y29tbWVudHMsIEkgYW0gdGhpbmtpbmcgSSdsbCBkcm9wIHRoZSBpdGVtcw0KPiBvbiB0aGUgR1BD
IHRoYXQgSmFja3kgc3VnZ2VzdGVkIHdvdWxkIG5vdCB3b3JrLCBhbmQgd2UgZG9uJ3QgaGF2ZSBk
cml2ZXJzDQo+IGZvciB0aG9zZSBvdGhlciBwZXJpcGhlcmFscyAoR1BVLCBWUFUsIGV0Yy4pIGFu
eXdheS4gIE15IG1haW4gZ29hbCBoZXJlIHdhcw0KPiB0byB0cnkgYW5kIGdldCB0aGUgVVNCIE9U
RyBwb3J0cyB3b3JraW5nLCBzbyBJJ2QgbGlrZSB0byBlbmFibGVkIGVub3VnaCBvZiB0aGUNCj4g
aXRlbXMgb24gdGhlIEdQQyB0aGF0IGFyZSBzaW1pbGFyIHRvIHRoZSBpLk1YOE1RIGFuZCBsZWF2
ZSB0aGUgbW9yZQ0KPiBjaGFsbGVuZ2luZyBpdGVtcyB1bnRpbCB3ZSBoYXZlIGVpdGhlciBhIGJl
dHRlciBkcml2ZXIgYXZhaWxhYmxlIGFuZC9vciBhY3R1YWwNCj4gcGVyaXBoZXJhbCBzdXBwb3J0
IGNvbWluZy4gIEkgaGF2ZW4ndCBzZWVuIExDRElGIG9yIERTSSBkcml2ZXJzIHB1c2hlZA0KPiB1
cHN0cmVhbSB5ZXQsIHNvIEkgZG91YnQgd2UnbGwgc2VlIEdQVSBvciBWUFUgeWV0IHVudGlsIHRo
b3NlIGFyZSBkb25lLg0KPiANCj4gRG9lcyBhbnlvbmUgZnJvbSB0aGUgTlhQIHRlYW0gaGF2ZSBh
bnkgb3RoZXIgY29tbWVudHMvY29uY2VybnM/DQo+IA0KDQpJZiB5b3UgbG9vayBpbnRvIE5YUCdz
IHJlbGVhc2UgY29kZSwgeW91IHdpbGwgZmluZCB0aGF0IGl0IGlzIG5vdCBlYXN5IHRvIGhhbmRs
ZSB0aGUNCnBvd2VyIGRvbWFpbiBtb3JlIGdlbmVyaWNhbGx5IGluIEdQQ3YyIGRyaXZlciBmb3Ig
aW14OG1tLiBUaGF0J3MgdGhlIHJlYXNvbiB3aHkgd2UgdXNlDQpTSVAgc2VydmljZSB0byBoYW5k
bGUgYWxsIHRoZSBwb3dlciBkb21haW4gaW4gVEYtQS4gd2UgdHJpZWQgdG8gdXBzdHJlYW0gdGhl
IFNJUCB2ZXJzaW9uDQpwb3dlciBkb21haW4gdGhhdCBjYW4gYmUgcmV1c2VkIGZvciBhbGwgaS5N
WDhNLCBidXQgcmVqZWN0ZWQgYnkgQVJNIGd1eXMuIHRoZXkgdGhpbmsNCndlIG5lZWQgdG8gdXNl
IFNDTUkgdG8gaW1wbGVtZW50IGl0LiBhcyB0aGVyZSBpcyBubyBTQ01JIG92ZXIgU01DIGF2YWls
YWJsZSwgdXBzdHJlYW0gaXMNCm9uIHRoZSB3YXksIHNvIHRoZSBwb3dlciBkb21haW4gZm9yIGku
TVg4TU0vTU4gaXMgcGVuZGluZy4NCg0KQWN0dWFsbHksIEkgYW0gY29uZnVzZWQgd2h5IHdlIGNh
bid0IHVzZSBTSVAgc2VydmljZSwgZXZlbiBpZiB0aGUgU0NNSSBvdmVyIFNNQyBpcyByZWFkeSBp
bg0KdGhlIGZ1dHVyZSwgSXQgc2VlbXMgdGhlIFNNQ0MgZnVuY3Rpb24gSUQgc3RpbGwgbmVlZCB0
byBjaG9vc2UgZnJvbSBTSVAgc2VydmljZSBmdW5jdGlvbiBpZCBiYW5rLg0KDQpBbm90aGVyIGNv
bmNlcm4gZm9yIGFkZGluZyBwb3dlciBkb21haW4gc3VwcG9ydCBpbiBHUEN2MiBpcyB0aGF0LCBl
YWNoIHRpbWUgYSBuZXcNClNPQyBpcyBhZGRlZCwgd2UgbmVlZCB0byBhZGQgaHVuZHJlZCBsaW5l
cyBvZiBjb2RlIGluIEdQQ3YyIGRyaXZlci4gaXQgaXMgbm90IGEgYmVzdCB3YXkNCnRvIGtlZXAg
ZHJpdmVyIHJldXNlLiBUaGUgR1BDdjIgZHJpdmVyIGlzIG9yaWdpbmFsbHkgdXNlZCBmb3IgaS5N
WDdELCB0aGVuIHJldXNlZCBieSBpLk1YOE1RLA0KYXMgaS5NWDhNUSBoYXMgdmVyeSBzaW1wbGUg
cG93ZXIgZG9tYWluIGRlc2lnbiBhcyBpLk1YN0QuIEJ1dCBmb3IgaS5NWDhNTSwgaXQgaXMgbm90
IHRoZQ0KY2FzZS4NCg0KVGhlcmUgaXMgYW5vdGhlciBjb25jZXJuLCB3ZSBkb24ndCB3YW50IHRv
IGV4cG9ydCBHUEMgbW9kdWxlIHRvIHJpY2ggT1Mgc2lkZSwgaXQgaXMgbm90IGEgbXVzdC4NCg0K
QlINCkphY2t5IEJhaQ0KDQo+IGFkYW0NCj4gPg0KDQo+ID4gQWRhbSBGb3JkICg3KToNCj4gPiAg
IHNvYzogaW14OiBncGN2MjogUmVuYW1lIGlteDhtcS1wb3dlci5oIHRvIGlteDhtLXBvd2VyLmgN
Cj4gPiAgIHNvYzogaW14OiBncGN2MjogVXBkYXRlIGlteDhtLXBvd2VyLmggdG8gaW5jbHVkZSBp
TVg4TSBNaW5pDQo+ID4gICBzb2M6IGlteDogZ3BjdjI6IGFkZCBzdXBwb3J0IGZvciBpLk1YOE0g
TWluaSBTb0MNCj4gPiAgIGR0LWJpbmRpbmdzOiBpbXgtZ3BjdjI6IFVwZGF0ZSBiaW5kaW5ncyB0
byBzdXBwb3J0IGkuTVg4TSBNaW5pDQo+ID4gICBhcm02NDogZHRzOiBpbXg4bW06IGFkZCBHUEMg
cG93ZXIgZG9tYWlucw0KPiA+ICAgQVJNNjQ6IGR0czogaW14OG1tOiBGaXggY2xvY2tzIGFuZCBw
b3dlciBkb21haW4gZm9yIFVTQiBPVEcNCj4gPiAgIGFybTY0OiBkdHM6IGlteDhtbTogQWRkIFBD
SWUgc3VwcG9ydA0KPiA+DQo+ID4gIC4uLi9iaW5kaW5ncy9wb3dlci9mc2wsaW14LWdwY3YyLnR4
dCAgICAgICAgICB8ICAgNiArLQ0KPiA+ICBhcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9p
bXg4bW0uZHRzaSAgICAgfCAxMjcgKysrKysrKystDQo+ID4gIGFyY2gvYXJtNjQvYm9vdC9kdHMv
ZnJlZXNjYWxlL2lteDhtcS5kdHNpICAgICB8ICAgMiArLQ0KPiA+ICBkcml2ZXJzL3NvYy9pbXgv
Z3BjdjIuYyAgICAgICAgICAgICAgICAgICAgICAgfCAyNDYNCj4gKysrKysrKysrKysrKysrKyst
DQo+ID4gIC4uLi9wb3dlci97aW14OG1xLXBvd2VyLmggPT4gaW14OG0tcG93ZXIuaH0gICB8ICAx
NCArDQo+ID4gIDUgZmlsZXMgY2hhbmdlZCwgMzg3IGluc2VydGlvbnMoKyksIDggZGVsZXRpb25z
KC0pICByZW5hbWUNCj4gPiBpbmNsdWRlL2R0LWJpbmRpbmdzL3Bvd2VyL3tpbXg4bXEtcG93ZXIu
aCA9PiBpbXg4bS1wb3dlci5ofSAoNTclKQ0KPiA+DQo+ID4gLS0NCj4gPiAyLjIwLjENCj4gPg0K
