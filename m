Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B620DC04AA8
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 09:33:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C40421734
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 09:33:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZqGrMsob"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbfEAJdw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 05:33:52 -0400
Received: from mail-eopbgr10059.outbound.protection.outlook.com ([40.107.1.59]:15686
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726014AbfEAJdv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 05:33:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sa58SZ418XHSTxX+C5qEk62ny1AteWRpmLAnD4dTM/w=;
 b=ZqGrMsobTZBRKMrS73MNi3CZC8qvQuKEo2canlygB6gVVY0o8ThZQ75xvPZOYKjmHCI7ug+LrK+9P8QzRh1G9jGibQdpkQ4ClNdTKPq87ripNPHg6CUvpAw76cmVM0PrKy8UT0cK7AeqbJZRvpO2LbIdaOdRXXjRWknV6fZ2uZs=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3804.eurprd04.prod.outlook.com (52.134.73.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.13; Wed, 1 May 2019 09:33:47 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170%3]) with mapi id 15.20.1856.008; Wed, 1 May 2019
 09:33:46 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] clk: imx: pllv3: Fix fall through build warning
Thread-Topic: [PATCH] clk: imx: pllv3: Fix fall through build warning
Thread-Index: AQHU/vfDJ+hnJuSvCk6GSL1CreUf2aZVA8+AgAD/5MA=
Date:   Wed, 1 May 2019 09:33:46 +0000
Message-ID: <DB3PR0402MB3916F59134DB9CF9837B43C1F53B0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1556589033-6080-1-git-send-email-Anson.Huang@nxp.com>
 <155664820799.168659.12393223246835475198@swboyd.mtv.corp.google.com>
In-Reply-To: <155664820799.168659.12393223246835475198@swboyd.mtv.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2fbc2997-6209-4341-ad6f-08d6ce181c5c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3804;
x-ms-traffictypediagnostic: DB3PR0402MB3804:
x-microsoft-antispam-prvs: <DB3PR0402MB3804A24BDF83658ABDC08D82F53B0@DB3PR0402MB3804.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:60;
x-forefront-prvs: 00246AB517
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(136003)(376002)(39860400002)(366004)(13464003)(199004)(189003)(66476007)(66946007)(446003)(2906002)(2501003)(66446008)(14444005)(66556008)(256004)(186003)(4326008)(64756008)(478600001)(33656002)(25786009)(229853002)(52536014)(55016002)(3846002)(6436002)(102836004)(26005)(6116002)(74316002)(76116006)(6246003)(476003)(305945005)(8676002)(53936002)(11346002)(73956011)(316002)(66066001)(68736007)(53546011)(14454004)(81156014)(110136005)(486006)(99286004)(2201001)(7736002)(5660300002)(76176011)(8936002)(71200400001)(71190400001)(81166006)(86362001)(6506007)(7416002)(9686003)(7696005)(44832011)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3804;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: D/JQjjpgciS/P6GWXWxj9ARH5VZYWzT6JaZ5XWUzn/yl2gFQCW+ZvBq00891+pMrEB76f+GKajVBIL3iljbHYi09eX3QaCkpE/sJnJGkhJyVgL+eCMHtemYK8R6HznD4XPx3kwSFbrOpXPgHdV9oH8k0th4soZfmadq0Z6S499K1bAQbSZo8rOu+AUXQ9zSh38xz7w9VVryxyxtkD5eCMOsbB/sYEY6qSYqPCQGdomDWP7YzgpstOdoOmRDrr8Ma9bP5HC+LEL3nzy9WMlxQr2nhuiKDfFV7G/50iqHx56YKz0jwRXB+oDqvqtyOPkAuEuztwZgHd+L6y1JP1/1uS7+274o4JGCIIgVLp4zLsmLCj2ygTApzYdlLFWa8DRw4kLB8zRkgqKKsPUZQ55QaLWuv5A84+P9noLhxYnQmxy4=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fbc2997-6209-4341-ad6f-08d6ce181c5c
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2019 09:33:46.8595
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3804
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFN0ZXBoZW4NCglJIHNhdyBHdXN0YXZvIGFscmVhZHkgc2VudCBvdXQgYSBwYXRjaCB0byBm
aXggdGhlc2UgdHdvIHdhcm5pbmdzLCBzbyBJIHdpbGwgTk9UIHNlbnQgdGhlIHBhdGNoIGFnYWlu
LCB0aGFua3MuDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU3RlcGhl
biBCb3lkIFttYWlsdG86c2JveWRAa2VybmVsLm9yZ10NCj4gU2VudDogV2VkbmVzZGF5LCBNYXkg
MSwgMjAxOSAyOjE3IEFNDQo+IFRvOiBmZXN0ZXZhbUBnbWFpbC5jb207IGtlcm5lbEBwZW5ndXRy
b25peC5kZTsgbGludXgtYXJtLQ0KPiBrZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgt
Y2xrQHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IG10
dXJxdWV0dGVAYmF5bGlicmUuY29tOw0KPiBzLmhhdWVyQHBlbmd1dHJvbml4LmRlOyBzaGF3bmd1
b0BrZXJuZWwub3JnOyBBbnNvbiBIdWFuZw0KPiA8YW5zb24uaHVhbmdAbnhwLmNvbT47IEd1c3Rh
dm8gQS4gUi4gU2lsdmEgPGd1c3Rhdm9AZW1iZWRkZWRvci5jb20+DQo+IENjOiBkbC1saW51eC1p
bXggPGxpbnV4LWlteEBueHAuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBjbGs6IGlteDog
cGxsdjM6IEZpeCBmYWxsIHRocm91Z2ggYnVpbGQgd2FybmluZw0KPiANCj4gUXVvdGluZyBBbnNv
biBIdWFuZyAoMjAxOS0wNC0yOSAxODo1NToxOCkNCj4gPiBGaXggYmVsb3cgZmFsbCB0aHJvdWdo
IGJ1aWxkIHdhcm5pbmc6DQo+ID4NCj4gPiBkcml2ZXJzL2Nsay9pbXgvY2xrLXBsbHYzLmM6NDUz
OjIxOiB3YXJuaW5nOg0KPiA+IHRoaXMgc3RhdGVtZW50IG1heSBmYWxsIHRocm91Z2ggWy1XaW1w
bGljaXQtZmFsbHRocm91Z2g9XQ0KPiA+DQo+ID4gICAgcGxsLT5kZW5vbV9vZmZzZXQgPSBQTExf
SU1YN19ERU5PTV9PRkZTRVQ7DQo+ID4gICAgICAgICAgICAgICAgICAgICAgXg0KPiA+IGRyaXZl
cnMvY2xrL2lteC9jbGstcGxsdjMuYzo0NTQ6Mjogbm90ZTogaGVyZQ0KPiA+ICAgY2FzZSBJTVhf
UExMVjNfQVY6DQo+ID4gICBefn5+DQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBBbnNvbiBIdWFu
ZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4NCj4gPiAtLS0NCj4gDQo+IEd1c3Rhdm8gc2F5cyB0aGVy
ZSBhcmUgdHdvIHdhcm5pbmdzLiBQbGVhc2UgY29tcGlsZSB0ZXN0IHdpdGggdGhlIHJpZ2h0DQo+
IG9wdGlvbnMsIGFkZCBSZXBvcnRlZC1ieSB0YWdzIHdoZW4geW91IGdldCBidWcgcmVwb3J0cyBm
cm9tIHNvbWVvbmUsIGFuZA0KPiBhZGQgYSBGaXhlcyB0YWcgYW5kIHRoZW4gcmVzZW5kLg0KPiAN
Cj4gPiAgZHJpdmVycy9jbGsvaW14L2Nsay1wbGx2My5jIHwgMSArDQo+ID4gIDEgZmlsZSBjaGFu
Z2VkLCAxIGluc2VydGlvbigrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xrL2lt
eC9jbGstcGxsdjMuYyBiL2RyaXZlcnMvY2xrL2lteC9jbGstcGxsdjMuYw0KPiA+IGluZGV4IGU4
OTJiOWEuLmZiZTRmZTAgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9jbGsvaW14L2Nsay1wbGx2
My5jDQo+ID4gKysrIGIvZHJpdmVycy9jbGsvaW14L2Nsay1wbGx2My5jDQo+ID4gQEAgLTQ1MSw2
ICs0NTEsNyBAQCBzdHJ1Y3QgY2xrICppbXhfY2xrX3BsbHYzKGVudW0gaW14X3BsbHYzX3R5cGUg
dHlwZSwNCj4gY29uc3QgY2hhciAqbmFtZSwNCj4gPiAgICAgICAgIGNhc2UgSU1YX1BMTFYzX0FW
X0lNWDc6DQo+ID4gICAgICAgICAgICAgICAgIHBsbC0+bnVtX29mZnNldCA9IFBMTF9JTVg3X05V
TV9PRkZTRVQ7DQo+ID4gICAgICAgICAgICAgICAgIHBsbC0+ZGVub21fb2Zmc2V0ID0gUExMX0lN
WDdfREVOT01fT0ZGU0VUOw0KPiA+ICsgICAgICAgICAgICAgICAvKiBmYWxsIHRocm91Z2ggKi8N
Cj4gPiAgICAgICAgIGNhc2UgSU1YX1BMTFYzX0FWOg0KPiA+ICAgICAgICAgICAgICAgICBvcHMg
PSAmY2xrX3BsbHYzX2F2X29wczsNCj4gPiAgICAgICAgICAgICAgICAgYnJlYWs7DQo=
