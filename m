Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 817FBC04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 08:46:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FAAD20879
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 08:46:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="fRSStEGR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbfENIqA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 04:46:00 -0400
Received: from mail-eopbgr30063.outbound.protection.outlook.com ([40.107.3.63]:20981
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725916AbfENIqA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 04:46:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nnx3HLvpY+SYB1SFaSAsRKBv07rHpXbxw/n8NpTlID8=;
 b=fRSStEGRO0iWliTG/nTCtSUitYOl3P9Ca1R9bakPCWT/7W0TMJA+/jXC0Nx811BWsoaKqj94i+u5mQahs9SivPvQHhkSl8/qUC2vgVC8Trgbfsf3VtjG/iePMYjpIO43h3NpqOOZ4YDiGlTKumH8xA7L05DqDHE6dh6DGzwi0ME=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3867.eurprd04.prod.outlook.com (52.134.65.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.25; Tue, 14 May 2019 08:45:55 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::d035:3bd0:a56a:189d]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::d035:3bd0:a56a:189d%2]) with mapi id 15.20.1900.010; Tue, 14 May 2019
 08:45:55 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Daniel Baluta <daniel.baluta@gmail.com>
CC:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "agross@kernel.org" <agross@kernel.org>,
        "olof@lixom.net" <olof@lixom.net>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
        "dinguyen@kernel.org" <dinguyen@kernel.org>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "robh@kernel.org" <robh@kernel.org>, Abel Vesa <abel.vesa@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: RE: [PATCH RESEND 1/2] soc: imx: Add SCU SoC info driver support
Thread-Topic: [PATCH RESEND 1/2] soc: imx: Add SCU SoC info driver support
Thread-Index: AQHVCTfaYqtO/eSQ1UCSJJ4U0eiBlKZpHh8AgACXn+CAAJi7gIAAActg
Date:   Tue, 14 May 2019 08:45:55 +0000
Message-ID: <DB3PR0402MB39162FD34C212598380B530CF5080@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1557716049-22744-1-git-send-email-Anson.Huang@nxp.com>
 <CAEnQRZDSTuUMrc9AC1S2zfo0PdQ-v35GmNrf70Zoasid_XMJzw@mail.gmail.com>
 <DB3PR0402MB3916A46BFFE5E6F3D4832A33F50F0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAEnQRZB0fs2g=h4pq97t+E9U9LOxSafYhx07Xia_J+snjqefEw@mail.gmail.com>
In-Reply-To: <CAEnQRZB0fs2g=h4pq97t+E9U9LOxSafYhx07Xia_J+snjqefEw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [183.192.18.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3a4aa5c0-460e-42d7-df51-08d6d848946c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3867;
x-ms-traffictypediagnostic: DB3PR0402MB3867:
x-microsoft-antispam-prvs: <DB3PR0402MB38676002DD267965F806EEE4F5080@DB3PR0402MB3867.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:293;
x-forefront-prvs: 0037FD6480
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(366004)(39860400002)(136003)(199004)(189003)(13464003)(54906003)(99286004)(316002)(6916009)(25786009)(81166006)(81156014)(4326008)(8676002)(8936002)(55016002)(71190400001)(71200400001)(66066001)(52536014)(33656002)(68736007)(5660300002)(53936002)(229853002)(66446008)(76116006)(6436002)(66556008)(66476007)(66946007)(256004)(478600001)(53546011)(7736002)(14454004)(74316002)(9686003)(6506007)(26005)(305945005)(186003)(102836004)(44832011)(2906002)(6116002)(11346002)(3846002)(76176011)(7696005)(7416002)(6246003)(486006)(476003)(64756008)(86362001)(73956011)(446003)(15866825006);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3867;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /5BwR22dF8296OduRE6hP/+AcfSiD0DxDhcyzXLmhvN72Jhut72sum760PzANEeeBaL5NU8sYoe1BrjUpTeV81tMzRGuVzCsKYJA13CX2ctCrCse4Fiu625lnMcR6VGTTAD05DYxo3dZ1E4medwgtUX4flx6/4G+PGEwGu94TcxRZnZU1+u+K47EHknkvsocXlCQOCf8M5JBIUjqIApE/QfKOjNwxdkuDGqoYOF2FyiWZFLLai5HF3aNENSqB5Vr12ZnwTgCd7KKCQasyMl33mqT4FNR24ROUJdrC7c8rDB+yhaR+Ag85fe4yhIZ7z8q/x6jjlZgLBafR++BrakIYMK6BS6Dtt+fmvzIsoTOvH+Ilr8k0Ez5AaOcvpV5/LlEp8CessTeas65WB9QeLXXgTGh1IuoYT/vUTAvFNRQo5k=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a4aa5c0-460e-42d7-df51-08d6d848946c
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2019 08:45:55.7230
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3867
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGFuaWVsIEJhbHV0YSBb
bWFpbHRvOmRhbmllbC5iYWx1dGFAZ21haWwuY29tXQ0KPiBTZW50OiBUdWVzZGF5LCBNYXkgMTQs
IDIwMTkgNDozOSBQTQ0KPiBUbzogQW5zb24gSHVhbmcgPGFuc29uLmh1YW5nQG54cC5jb20+DQo+
IENjOiBjYXRhbGluLm1hcmluYXNAYXJtLmNvbTsgd2lsbC5kZWFjb25AYXJtLmNvbTsNCj4gc2hh
d25ndW9Aa2VybmVsLm9yZzsgcy5oYXVlckBwZW5ndXRyb25peC5kZTsga2VybmVsQHBlbmd1dHJv
bml4LmRlOw0KPiBmZXN0ZXZhbUBnbWFpbC5jb207IG1heGltZS5yaXBhcmRAYm9vdGxpbi5jb207
IGFncm9zc0BrZXJuZWwub3JnOw0KPiBvbG9mQGxpeG9tLm5ldDsgaG9ybXMrcmVuZXNhc0B2ZXJn
ZS5uZXQuYXU7DQo+IGphZ2FuQGFtYXJ1bGFzb2x1dGlvbnMuY29tOyBiam9ybi5hbmRlcnNzb25A
bGluYXJvLm9yZzsgTGVvbmFyZCBDcmVzdGV6DQo+IDxsZW9uYXJkLmNyZXN0ZXpAbnhwLmNvbT47
IG1hcmMudy5nb256YWxlekBmcmVlLmZyOw0KPiBkaW5ndXllbkBrZXJuZWwub3JnOyBlbnJpYy5i
YWxsZXRib0Bjb2xsYWJvcmEuY29tOyBBaXNoZW5nIERvbmcNCj4gPGFpc2hlbmcuZG9uZ0BueHAu
Y29tPjsgcm9iaEBrZXJuZWwub3JnOyBBYmVsIFZlc2ENCj4gPGFiZWwudmVzYUBueHAuY29tPjsg
bC5zdGFjaEBwZW5ndXRyb25peC5kZTsgbGludXgtYXJtLQ0KPiBrZXJuZWxAbGlzdHMuaW5mcmFk
ZWFkLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgZGwtbGludXgtaW14DQo+IDxs
aW51eC1pbXhAbnhwLmNvbT47IERhbmllbCBCYWx1dGEgPGRhbmllbC5iYWx1dGFAbnhwLmNvbT4N
Cj4gU3ViamVjdDogUmU6IFtQQVRDSCBSRVNFTkQgMS8yXSBzb2M6IGlteDogQWRkIFNDVSBTb0Mg
aW5mbyBkcml2ZXIgc3VwcG9ydA0KPiANCj4gT24gVHVlLCBNYXkgMTQsIDIwMTkgYXQgMjozNCBB
TSBBbnNvbiBIdWFuZyA8YW5zb24uaHVhbmdAbnhwLmNvbT4NCj4gd3JvdGU6DQo+ID4NCj4gPiBI
aSwgRGFuaWVsDQo+ID4NCj4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiBG
cm9tOiBEYW5pZWwgQmFsdXRhIFttYWlsdG86ZGFuaWVsLmJhbHV0YUBnbWFpbC5jb21dDQo+ID4g
PiBTZW50OiBNb25kYXksIE1heSAxMywgMjAxOSAxMDozMCBQTQ0KPiA+ID4gVG86IEFuc29uIEh1
YW5nIDxhbnNvbi5odWFuZ0BueHAuY29tPg0KPiA+ID4gQ2M6IGNhdGFsaW4ubWFyaW5hc0Bhcm0u
Y29tOyB3aWxsLmRlYWNvbkBhcm0uY29tOw0KPiA+ID4gc2hhd25ndW9Aa2VybmVsLm9yZzsgcy5o
YXVlckBwZW5ndXRyb25peC5kZTsNCj4ga2VybmVsQHBlbmd1dHJvbml4LmRlOw0KPiA+ID4gZmVz
dGV2YW1AZ21haWwuY29tOyBtYXhpbWUucmlwYXJkQGJvb3RsaW4uY29tOyBhZ3Jvc3NAa2VybmVs
Lm9yZzsNCj4gPiA+IG9sb2ZAbGl4b20ubmV0OyBob3JtcytyZW5lc2FzQHZlcmdlLm5ldC5hdTsN
Cj4gPiA+IGphZ2FuQGFtYXJ1bGFzb2x1dGlvbnMuY29tOyBiam9ybi5hbmRlcnNzb25AbGluYXJv
Lm9yZzsgTGVvbmFyZA0KPiA+ID4gQ3Jlc3RleiA8bGVvbmFyZC5jcmVzdGV6QG54cC5jb20+OyBt
YXJjLncuZ29uemFsZXpAZnJlZS5mcjsNCj4gPiA+IGRpbmd1eWVuQGtlcm5lbC5vcmc7IGVucmlj
LmJhbGxldGJvQGNvbGxhYm9yYS5jb207IEFpc2hlbmcgRG9uZw0KPiA+ID4gPGFpc2hlbmcuZG9u
Z0BueHAuY29tPjsgcm9iaEBrZXJuZWwub3JnOyBBYmVsIFZlc2ENCj4gPiA+IDxhYmVsLnZlc2FA
bnhwLmNvbT47IGwuc3RhY2hAcGVuZ3V0cm9uaXguZGU7IGxpbnV4LWFybS0NCj4gPiA+IGtlcm5l
bEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiA+
ID4gZGwtbGludXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT47IERhbmllbCBCYWx1dGENCj4gPiA+
IDxkYW5pZWwuYmFsdXRhQG54cC5jb20+DQo+ID4gPiBTdWJqZWN0OiBSZTogW1BBVENIIFJFU0VO
RCAxLzJdIHNvYzogaW14OiBBZGQgU0NVIFNvQyBpbmZvIGRyaXZlcg0KPiA+ID4gc3VwcG9ydA0K
PiA+ID4NCj4gPiA+IDxzbmlwPg0KPiA+ID4NCj4gPiA+ID4gKw0KPiA+ID4gPiArc3RhdGljIHUz
MiBpbXg4cXhwX3NvY19yZXZpc2lvbih2b2lkKSB7DQo+ID4gPiA+ICsgICAgICAgc3RydWN0IGlt
eF9zY19tc2dfbWlzY19nZXRfc29jX2lkIG1zZzsNCj4gPiA+ID4gKyAgICAgICBzdHJ1Y3QgaW14
X3NjX3JwY19tc2cgKmhkciA9ICZtc2cuaGRyOw0KPiA+ID4gPiArICAgICAgIHUzMiByZXYgPSAw
Ow0KPiA+ID4gPiArICAgICAgIGludCByZXQ7DQo+ID4gPiA+ICsNCj4gPiA+ID4gKyAgICAgICBo
ZHItPnZlciA9IElNWF9TQ19SUENfVkVSU0lPTjsNCj4gPiA+ID4gKyAgICAgICBoZHItPnN2YyA9
IElNWF9TQ19SUENfU1ZDX01JU0M7DQo+ID4gPiA+ICsgICAgICAgaGRyLT5mdW5jID0gSU1YX1ND
X01JU0NfRlVOQ19HRVRfQ09OVFJPTDsNCj4gPiA+ID4gKyAgICAgICBoZHItPnNpemUgPSAzOw0K
PiA+ID4gPiArDQo+ID4gPiA+ICsgICAgICAgbXNnLmRhdGEuc2VuZC5jb250cm9sID0gSU1YX1ND
X0NfSUQ7DQo+ID4gPiA+ICsgICAgICAgbXNnLmRhdGEuc2VuZC5yZXNvdXJjZSA9IElNWF9TQ19S
X1NZU1RFTTsNCj4gPiA+ID4gKw0KPiA+ID4gPiArICAgICAgIHJldCA9IGlteF9zY3VfY2FsbF9y
cGMoc29jX2lwY19oYW5kbGUsICZtc2csIHRydWUpOw0KPiA+ID4gPiArICAgICAgIGlmIChyZXQp
IHsNCj4gPiA+ID4gKyAgICAgICAgICAgICAgIGRldl9lcnIoJmlteF9zY3Vfc29jX3BkZXYtPmRl
diwNCj4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgImdldCBzb2MgaW5mbyBmYWlsZWQs
IHJldCAlZFxuIiwgcmV0KTsNCj4gPiA+ID4gKyAgICAgICAgICAgICAgIHJldHVybiByZXY7DQo+
ID4gPg0KPiA+ID4gU28geW91IHJldHVybiAwIChyZXYgID0gMCkgaGVyZSBpbiBjYXNlIG9mIGVy
cm9yPyBUaGlzIGRvZXNuJ3Qgc2VlbSB0byBiZQ0KPiByaWdodC4NCj4gPiA+IE1heWJlIHJldHVy
biByZXQ/DQo+ID4NCj4gPiBUaGlzIGlzIGludGVudGlvbmFsLCBzaW1pbGFyIHdpdGggY3VycmVu
dCBpLk1YOE1RIHNvYyBpbmZvIGRyaXZlciwNCj4gPiB3aGVuIGdldHRpbmcgcmV2aXNpb24gZmFp
bGVkLCBqdXN0IHJldHVybiAwIGFzIHJldmlzaW9uIGluZm8gYW5kIGl0IHdpbGwgc2hvdw0KPiAi
dW5rbm93biIgaW4gc3lzZnMuDQo+IA0KPiBPaywgSSB1bmRlcnN0YW5kLiBMZXRzIG1ha2UgdGhp
cyBjbGVhciBmcm9tIHRoZSBzb3VyY2UgY29kZS4NCj4gDQo+ICAgIHJldCA9IGlteF9zY3VfY2Fs
bF9ycGMoc29jX2lwY19oYW5kbGUsICZtc2csIHRydWUpOw0KPiArICAgICAgIGlmIChyZXQpIHsN
Cj4gKyAgICAgICAgICAgICAgIGRldl9lcnIoJmlteF9zY3Vfc29jX3BkZXYtPmRldiwNCj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgImdldCBzb2MgaW5mbyBmYWlsZWQsIHJldCAlZFxuIiwgcmV0
KTsNCj4gICAgICAgICAgICAgICAgIC8qIHJldHVybmluZyAwIG1lYW5zIGdldHRpbmcgcmV2aXNp
b24gZmFpbGVkICovDQo+ICsgICAgICAgICAgICAgICByZXR1cm4gMDsNCj4gKyAgICAgICB9DQoN
Ck9LLCB3aWxsIGFkZCBhIGNvbW1lbnQgaW4gVjIuDQoNCkFuc29uLg0KDQo=
