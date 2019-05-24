Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1C6EC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 05:53:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8694C2081C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 05:53:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="L3QA65NQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388865AbfEXFxi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 01:53:38 -0400
Received: from mail-eopbgr80088.outbound.protection.outlook.com ([40.107.8.88]:27310
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388258AbfEXFxi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 01:53:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R3jNrJbSE+OLLbjY/ZhGMPVrdaaXS8U8WtMRqD0FeTw=;
 b=L3QA65NQL00ZRideaw6x8NbkSNUuobOwvN7BX7JcXPG2MLaVdPMYUzQfgpgf2uqB0Zh0Y2/SN7fOPiJ/5Eji5eog/nkifTXXHd3u0FhpKjVb23xS2rErQWm6yoMUwqVEgyl9sfCWpGvSFtw1769wdAWdHjG+RwLOVcEtN1zPMzg=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3882.eurprd04.prod.outlook.com (52.134.72.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.18; Fri, 24 May 2019 05:53:33 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::5835:e874:bd94:fec]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::5835:e874:bd94:fec%5]) with mapi id 15.20.1922.017; Fri, 24 May 2019
 05:53:33 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>
CC:     "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 1/2] soc: imx: soc-imx8: Avoid unnecessary of_node_put()
 in error handling
Thread-Topic: [PATCH 1/2] soc: imx: soc-imx8: Avoid unnecessary of_node_put()
 in error handling
Thread-Index: AQHVD7YvdNtmZ2uz6UeyYdwfC+FzEKZ4qg6AgAEgPbA=
Date:   Fri, 24 May 2019 05:53:33 +0000
Message-ID: <DB3PR0402MB3916A92814AC8B5E66DA2C3CF5020@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1558430013-18346-1-git-send-email-Anson.Huang@nxp.com>
 <20190523124044.GT9261@dragon>
In-Reply-To: <20190523124044.GT9261@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5214ef71-8460-48f9-321c-08d6e00c2812
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3882;
x-ms-traffictypediagnostic: DB3PR0402MB3882:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <DB3PR0402MB388207AF674DF4ACAE9D22D6F5020@DB3PR0402MB3882.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0047BC5ADE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(39860400002)(136003)(346002)(376002)(13464003)(189003)(199004)(6306002)(4326008)(102836004)(6506007)(316002)(6246003)(9686003)(7736002)(53546011)(8936002)(6916009)(229853002)(478600001)(76116006)(33656002)(55016002)(64756008)(25786009)(66066001)(66946007)(73956011)(8676002)(66556008)(66446008)(66476007)(81166006)(476003)(446003)(81156014)(6436002)(11346002)(14454004)(5660300002)(74316002)(2906002)(44832011)(54906003)(68736007)(486006)(86362001)(3846002)(76176011)(7696005)(256004)(26005)(52536014)(6116002)(186003)(966005)(99286004)(71190400001)(71200400001)(53936002)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3882;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 6w3ZCUflHoT3YNMuO7+Y4xHTWhSb/MWLl81gBV0awS/AknieNqI7zYToksg1a5SW01Ont+rhrwLU0BQ8dOKPTg9/JolA3XqfGGkKyjVf4JKwf0gW9t12JWfwCrHZtzEO//5Nme+z4PkoPDOxM08zyFx07t0YIbqOxJLe0hV5LLvIzkMRaC1kUh54O2ne/m1d8xH3jFMn6sCmzamaUidwEBgPcuxXxZ4RNhp3Up52iq553wmOknJUE9Cz8AFf0ZGrTLVLEXKiGwg0I/te2Inip0Ncn11jVB1dtXULH4MRnms4NxOCQVYYIJJiP9OGRv2SD50I/yFwZ+D0ELXUEQwaz8LrrU1ahtNLElmejJq8IBmAVNSrIeK+xs06PUid/tm0BeLEXPZHOPbo1++mvqdXB8GNn238Phz/6BUxPnCI8UI=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5214ef71-8460-48f9-321c-08d6e00c2812
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2019 05:53:33.4075
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: anson.huang@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3882
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFNoYXduDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU2hhd24g
R3VvIFttYWlsdG86c2hhd25ndW9Aa2VybmVsLm9yZ10NCj4gU2VudDogVGh1cnNkYXksIE1heSAy
MywgMjAxOSA4OjQxIFBNDQo+IFRvOiBBbnNvbiBIdWFuZyA8YW5zb24uaHVhbmdAbnhwLmNvbT4N
Cj4gQ2M6IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU7IGtlcm5lbEBwZW5ndXRyb25peC5kZTsgZmVz
dGV2YW1AZ21haWwuY29tOw0KPiBMZW9uYXJkIENyZXN0ZXogPGxlb25hcmQuY3Jlc3RlekBueHAu
Y29tPjsgQWJlbCBWZXNhDQo+IDxhYmVsLnZlc2FAbnhwLmNvbT47IHZpcmVzaC5rdW1hckBsaW5h
cm8ub3JnOyBsaW51eC1hcm0tDQo+IGtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC1r
ZXJuZWxAdmdlci5rZXJuZWwub3JnOyBkbC1saW51eC1pbXgNCj4gPGxpbnV4LWlteEBueHAuY29t
Pg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDEvMl0gc29jOiBpbXg6IHNvYy1pbXg4OiBBdm9pZCB1
bm5lY2Vzc2FyeQ0KPiBvZl9ub2RlX3B1dCgpIGluIGVycm9yIGhhbmRsaW5nDQo+IA0KPiBPbiBU
dWUsIE1heSAyMSwgMjAxOSBhdCAwOToxODo0M0FNICswMDAwLCBBbnNvbiBIdWFuZyB3cm90ZToN
Cj4gPiBvZl9ub2RlX3B1dCgpIGlzIGNhbGxlZCBhZnRlciBvZl9tYXRjaF9ub2RlKCkgc3VjY2Vz
c2Z1bGx5IGNhbGxlZCwNCj4gPiB0aGVuIGluIHRoZSBmb2xsb3dpbmcgZXJyb3IgaGFuZGxpbmcs
IG9mX25vZGVfcHV0KCkgaXMgY2FsbGVkIGFnYWluDQo+ID4gd2hpY2ggaXMgdW5uZWNlc3Nhcnks
IHRoaXMgcGF0Y2ggYWRqdXN0cyB0aGUgbG9jYXRpb24gb2Ygb2Zfbm9kZV9wdXQoKQ0KPiA+IHRv
IGF2b2lkIHN1Y2ggc2NlbmFyaW8uDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBBbnNvbiBIdWFu
ZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4NCj4gDQo+IEFnYWluLCB0aGVyZSBhcmUgJz0yMCcgaW4g
dGhlIHBhdGNoIGNvbnRlbnQgYW5kIEkgY2Fubm90IGFwcGx5IGl0Lg0KDQpJIHJlc2VudCB0aGUg
cGF0Y2ggc2V0LCBwbGVhc2UgcGljayB0aGVtIHVwLCB0aGFua3MuDQoNCmh0dHBzOi8vcGF0Y2h3
b3JrLmtlcm5lbC5vcmcvcGF0Y2gvMTA5NTkxMDEvDQpodHRwczovL3BhdGNod29yay5rZXJuZWwu
b3JnL3BhdGNoLzEwOTU5MDk5Lw0KDQpBbnNvbi4NCg0KPiANCj4gU2hhd24NCj4gDQo+ID4gLS0t
DQo+ID4gIGRyaXZlcnMvc29jL2lteC9zb2MtaW14OC5jIHwgNCArKy0tDQo+ID4gIDEgZmlsZSBj
aGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9zb2MvaW14L3NvYy1pbXg4LmMgYi9kcml2ZXJzL3NvYy9pbXgvc29jLWlt
eDguYw0KPiA+IGluZGV4IGIxYmQ4ZTIuLjk0NGFkZDIgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVy
cy9zb2MvaW14L3NvYy1pbXg4LmMNCj4gPiArKysgYi9kcml2ZXJzL3NvYy9pbXgvc29jLWlteDgu
Yw0KPiA+IEBAIC04Niw4ICs4Niw2IEBAIHN0YXRpYyBpbnQgX19pbml0IGlteDhfc29jX2luaXQo
dm9pZCkNCj4gPiAgCWlmICghaWQpDQo+ID4gIAkJZ290byBmcmVlX3NvYzsNCj4gPg0KPiA+IC0J
b2Zfbm9kZV9wdXQocm9vdCk7DQo+ID4gLQ0KPiA+ICAJZGF0YSA9IGlkLT5kYXRhOw0KPiA+ICAJ
aWYgKGRhdGEpIHsNCj4gPiAgCQlzb2NfZGV2X2F0dHItPnNvY19pZCA9IGRhdGEtPm5hbWU7DQo+
ID4gQEAgLTEwNiw2ICsxMDQsOCBAQCBzdGF0aWMgaW50IF9faW5pdCBpbXg4X3NvY19pbml0KHZv
aWQpDQo+ID4gIAlpZiAoSVNfRU5BQkxFRChDT05GSUdfQVJNX0lNWF9DUFVGUkVRX0RUKSkNCj4g
PiAgCQlwbGF0Zm9ybV9kZXZpY2VfcmVnaXN0ZXJfc2ltcGxlKCJpbXgtY3B1ZnJlcS1kdCIsIC0x
LCBOVUxMLA0KPiAwKTsNCj4gPg0KPiA+ICsJb2Zfbm9kZV9wdXQocm9vdCk7DQo+ID4gKw0KPiA+
ICAJcmV0dXJuIDA7DQo+ID4NCj4gPiAgZnJlZV9yZXY6DQo+ID4gLS0NCj4gPiAyLjcuNA0KPiA+
DQo=
