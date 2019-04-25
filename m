Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A14A4C282E1
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 10:15:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BD53214C6
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 10:15:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="wlFBbRZR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728043AbfDYKPk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 06:15:40 -0400
Received: from mail-eopbgr70043.outbound.protection.outlook.com ([40.107.7.43]:7623
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726810AbfDYKPj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 06:15:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E8p3ZK8/ghXO+zp74oYvJtYjiIJRLAmzHIsFTQwfF00=;
 b=wlFBbRZRvn6pPhDe5mdvZw7x2MP9r40tFMtbbXPuJ/v+k9bplgIuoQFUO/hODLiqA9oQFTaFoCT28tGfmj73sGp3GNZEfHXgSTSq436ZkrizqFIz2K+xcpwSO05ChLCD+UEWBSBeyzCqhJ5qA61dc/+mRGsHGxZMymHIPx4vzyk=
Received: from VI1PR04MB4333.eurprd04.prod.outlook.com (52.134.122.155) by
 VI1PR04MB5053.eurprd04.prod.outlook.com (20.177.50.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.16; Thu, 25 Apr 2019 10:15:33 +0000
Received: from VI1PR04MB4333.eurprd04.prod.outlook.com
 ([fe80::2cfb:4ff:c7f3:9a7]) by VI1PR04MB4333.eurprd04.prod.outlook.com
 ([fe80::2cfb:4ff:c7f3:9a7%6]) with mapi id 15.20.1835.010; Thu, 25 Apr 2019
 10:15:33 +0000
From:   Andy Tang <andy.tang@nxp.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Vabhav Sharma <vabhav.sharma@nxp.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Subject: RE: [EXT] Re: [PATCH v2] clk: qoriq: Add clockgen support for lx2160a
Thread-Topic: [EXT] Re: [PATCH v2] clk: qoriq: Add clockgen support for
 lx2160a
Thread-Index: AQHU+0v+B00Z51pg7EC3G4Yx/RLSjaZMpcWAgAABiCA=
Date:   Thu, 25 Apr 2019 10:15:33 +0000
Message-ID: <VI1PR04MB43336A0C62B956CA29A7E621F33D0@VI1PR04MB4333.eurprd04.prod.outlook.com>
References: <1556185703-26243-1-git-send-email-vabhav.sharma@nxp.com>
 <CAJZ5v0iwrjonKpA3Skkhkg3g5Pp9Qzx0v2GBYKdv7eM_jL4p8g@mail.gmail.com>
In-Reply-To: <CAJZ5v0iwrjonKpA3Skkhkg3g5Pp9Qzx0v2GBYKdv7eM_jL4p8g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=andy.tang@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3f7a82e7-cac8-4f09-21c7-08d6c966f3ad
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB5053;
x-ms-traffictypediagnostic: VI1PR04MB5053:
x-microsoft-antispam-prvs: <VI1PR04MB50536CF54C2BAF6541D2BFF4F33D0@VI1PR04MB5053.eurprd04.prod.outlook.com>
x-forefront-prvs: 0018A2705B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(396003)(366004)(136003)(376002)(199004)(189003)(54534003)(13464003)(52536014)(305945005)(256004)(66446008)(6636002)(102836004)(66476007)(476003)(33656002)(26005)(66946007)(186003)(66556008)(478600001)(64756008)(14444005)(97736004)(66066001)(3846002)(76116006)(73956011)(6116002)(2906002)(229853002)(5660300002)(8936002)(6436002)(486006)(25786009)(6506007)(71190400001)(446003)(7736002)(71200400001)(4326008)(8676002)(55016002)(74316002)(11346002)(7696005)(110136005)(54906003)(81156014)(6246003)(14454004)(99286004)(9686003)(44832011)(81166006)(86362001)(68736007)(76176011)(316002)(53546011)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5053;H:VI1PR04MB4333.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: jZ5Ju2jYKEEOBtVqImu9izjWLAjgagzyE+NcchPBQ6cDAwcrO99YEPbcDuBCIVvph7HF3uMrhoDSwVreMTYuEbtZk5ADMsAqzFEJP6Etky9xebuud0TsgNdR406my/UXJrJzreVPn7uDIu2ZrZrDgoau7Pw4+QobeA3PMC2hC05gKMOoyjvHuqoLS8v+4ZODIbN3TonYmUzGdbMqtxukaSTqygvwagcJB/mCE/JiLOGego13JQb6nunAGZLgrutYutRGCmhxmisaHQKcE4OZmijePigCEBA08wuZhHbOj4FjW9zItlJZtuNQWuLoKNQdTMloXfSMkorSi2GFYCxxdTTfkRPRM83hsOWTk46FvIUk9yWJPwXdipcqyK4W5sx41FqgGM0+exboDak70fDtoPIkCVfwi1w9cq4rjdiNZZ4=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f7a82e7-cac8-4f09-21c7-08d6c966f3ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2019 10:15:33.0630
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5053
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFJhZmFlbCBKLiBXeXNvY2tp
IDxyYWZhZWxAa2VybmVsLm9yZz4NCj4gU2VudDogMjAxOeW5tDTmnIgyNeaXpSAxODowNA0KPiBU
bzogVmFiaGF2IFNoYXJtYSA8dmFiaGF2LnNoYXJtYUBueHAuY29tPg0KPiBDYzogbGludXgta2Vy
bmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtY2xrQHZnZXIua2VybmVsLm9yZzsNCj4gbGludXgt
cG1Admdlci5rZXJuZWwub3JnOyBzYm95ZEBrZXJuZWwub3JnOyBtdHVycXVldHRlQGJheWxpYnJl
LmNvbTsNCj4gcmp3QHJqd3lzb2NraS5uZXQ7IHZpcmVzaC5rdW1hckBsaW5hcm8ub3JnOyBZb2dl
c2ggTmFyYXlhbiBHYXVyDQo+IDx5b2dlc2huYXJheWFuLmdhdXJAbnhwLmNvbT47IEFuZHkgVGFu
ZyA8YW5keS50YW5nQG54cC5jb20+DQo+IFN1YmplY3Q6IFtFWFRdIFJlOiBbUEFUQ0ggdjJdIGNs
azogcW9yaXE6IEFkZCBjbG9ja2dlbiBzdXBwb3J0IGZvciBseDIxNjBhDQo+IA0KPiBDYXV0aW9u
OiBFWFQgRW1haWwNCj4gDQo+IE9uIFRodSwgQXByIDI1LCAyMDE5IGF0IDExOjQ4IEFNIFZhYmhh
diBTaGFybWEgPHZhYmhhdi5zaGFybWFAbnhwLmNvbT4NCj4gd3JvdGU6DQo+ID4NCj4gPiBGcm9t
OiBZb2dlc2ggR2F1ciA8eW9nZXNobmFyYXlhbi5nYXVyQG54cC5jb20+DQo+ID4NCj4gPiBBZGQg
Y2xvY2tnZW4gc3VwcG9ydCBmb3IgbHgyMTYwYS4NCj4gPiBBZGRlZCBlbnRyeSBmb3IgY29tcGF0
ICdmc2wsbHgyMTYwYS1jbG9ja2dlbicuDQo+IA0KPiBXZWxsLCBpZiBJJ20gZXhwZWN0ZWQgdG8g
YXBwbHkgdGhpcywgdGhlIGFib3ZlIGlzIGEgYml0IHRlcnNlLg0KPiANCj4gSXQgbG9va3MgbGlr
ZSB0aGUgcGF0Y2ggbWFrZXMgdGhlIHFvcmlxLWNwdWZyZXEgZHJpdmVyIGhhbmRsZSBzb21lIG5l
dw0KPiBoYXJkd2FyZSwgYnV0IHRoZSBjaGFuZ2Vsb2cgZG9lc24ndCBzYXkgbXVjaCBhYm91dCB0
aGF0Lg0KPiANCj4gSSdtIGd1ZXNzaW5nIHRoYXQgdGhlIGNsb2NrZ2VuIHN1cHBvcnQgYWRkZWQg
aGVyZSBtYWtlcyBpdCBwb3NzaWJsZSBmb3INCj4gcW9yaXEtY3B1ZnJlcSB0byBoYW5kbGUgdGhp
cyBjaGlwLCBpcyB0aGF0IGNvcnJlY3Q/DQpZZXMsIHlvdXIgZ3Vlc3MgaXMgY29ycmVjdC4gVGhl
IGNwdWZyZXEgZmVhdHVyZSBpcyBiYXNlZCBvbiBjbG9jayBkcml2ZXIuDQpJdCBzaG91bGQgaGFk
IGJlZW4gc2VwYXJhdGVkIHRvIHR3byBwYXRjaGVzIGFuZCByZWR1Y2VkIHRoZSBjb25mdXNlLg0K
RG8gSSBuZWVkIHRvIHVwZGF0ZSB0aGUgY29tbWl0IG1lc3NhZ2Ugb3IgeW91IGp1c3QgdGFrZSBp
dD8NCg0KQlIsDQpBbmR5DQo+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IFRhbmcgWXVhbnRpYW4gPGFu
ZHkudGFuZ0BueHAuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFlvZ2VzaCBHYXVyIDx5b2dlc2hu
YXJheWFuLmdhdXJAbnhwLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBWYWJoYXYgU2hhcm1hIDx2
YWJoYXYuc2hhcm1hQG54cC5jb20+DQo+ID4gQWNrZWQtYnk6IFNjb3R0IFdvb2QgPG9zc0BidXNl
cnJvci5uZXQ+DQo+ID4gQWNrZWQtYnk6IFN0ZXBoZW4gQm95ZCA8c2JveWRAa2VybmVsLm9yZz4N
Cj4gPiBBY2tlZC1ieTogVmlyZXNoIEt1bWFyIDx2aXJlc2gua3VtYXJAbGluYXJvLm9yZz4NCj4g
PiAtLS0NCj4gPiBDaGFuZ2VzIGZvciB2MjoNCj4gPiAtIFN1YmplY3QgbGluZSB1cGRhdGVkDQo+
ID4NCj4gPiAgZHJpdmVycy9jbGsvY2xrLXFvcmlxLmMgICAgICAgICB8IDEyICsrKysrKysrKysr
Kw0KPiA+ICBkcml2ZXJzL2NwdWZyZXEvcW9yaXEtY3B1ZnJlcS5jIHwgIDEgKw0KPiA+ICAyIGZp
bGVzIGNoYW5nZWQsIDEzIGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2Nsay9jbGstcW9yaXEuYyBiL2RyaXZlcnMvY2xrL2Nsay1xb3JpcS5jIGluZGV4DQo+ID4g
M2Q1MWQ3Yy4uMWExNTIwMSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2Nsay9jbGstcW9yaXEu
Yw0KPiA+ICsrKyBiL2RyaXZlcnMvY2xrL2Nsay1xb3JpcS5jDQo+ID4gQEAgLTU3MCw2ICs1NzAs
MTcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBjbG9ja2dlbl9jaGlwaW5mbyBjaGlwaW5mb1tdID0g
ew0KPiA+ICAgICAgICAgICAgICAgICAuZmxhZ3MgPSBDR19WRVIzIHwgQ0dfTElUVExFX0VORElB
TiwNCj4gPiAgICAgICAgIH0sDQo+ID4gICAgICAgICB7DQo+ID4gKyAgICAgICAgICAgICAgIC5j
b21wYXQgPSAiZnNsLGx4MjE2MGEtY2xvY2tnZW4iLA0KPiA+ICsgICAgICAgICAgICAgICAuY211
eF9ncm91cHMgPSB7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgJmNsb2NrZ2VuMl9jbXV4
X2NnYTEyLCAmY2xvY2tnZW4yX2NtdXhfY2diDQo+ID4gKyAgICAgICAgICAgICAgIH0sDQo+ID4g
KyAgICAgICAgICAgICAgIC5jbXV4X3RvX2dyb3VwID0gew0KPiA+ICsgICAgICAgICAgICAgICAg
ICAgICAgIDAsIDAsIDAsIDAsIDEsIDEsIDEsIDEsIC0xDQo+ID4gKyAgICAgICAgICAgICAgIH0s
DQo+ID4gKyAgICAgICAgICAgICAgIC5wbGxfbWFzayA9IDB4MzcsDQo+ID4gKyAgICAgICAgICAg
ICAgIC5mbGFncyA9IENHX1ZFUjMgfCBDR19MSVRUTEVfRU5ESUFOLA0KPiA+ICsgICAgICAgfSwN
Cj4gPiArICAgICAgIHsNCj4gPiAgICAgICAgICAgICAgICAgLmNvbXBhdCA9ICJmc2wscDIwNDEt
Y2xvY2tnZW4iLA0KPiA+ICAgICAgICAgICAgICAgICAuZ3V0c19jb21wYXQgPSAiZnNsLHFvcmlx
LWRldmljZS1jb25maWctMS4wIiwNCj4gPiAgICAgICAgICAgICAgICAgLmluaXRfcGVyaXBoID0g
cDIwNDFfaW5pdF9wZXJpcGgsIEBAIC0xNDI3LDYgKzE0MzgsNw0KPiA+IEBAIENMS19PRl9ERUNM
QVJFKHFvcmlxX2Nsb2NrZ2VuX2xzMTA0M2EsICJmc2wsbHMxMDQzYS1jbG9ja2dlbiIsDQo+ID4g
Y2xvY2tnZW5faW5pdCk7ICBDTEtfT0ZfREVDTEFSRShxb3JpcV9jbG9ja2dlbl9sczEwNDZhLA0K
PiA+ICJmc2wsbHMxMDQ2YS1jbG9ja2dlbiIsIGNsb2NrZ2VuX2luaXQpOw0KPiA+IENMS19PRl9E
RUNMQVJFKHFvcmlxX2Nsb2NrZ2VuX2xzMTA4OGEsICJmc2wsbHMxMDg4YS1jbG9ja2dlbiIsDQo+
ID4gY2xvY2tnZW5faW5pdCk7ICBDTEtfT0ZfREVDTEFSRShxb3JpcV9jbG9ja2dlbl9sczIwODBh
LA0KPiA+ICJmc2wsbHMyMDgwYS1jbG9ja2dlbiIsIGNsb2NrZ2VuX2luaXQpOw0KPiA+ICtDTEtf
T0ZfREVDTEFSRShxb3JpcV9jbG9ja2dlbl9seDIxNjBhLCAiZnNsLGx4MjE2MGEtY2xvY2tnZW4i
LA0KPiA+ICtjbG9ja2dlbl9pbml0KTsNCj4gPiAgQ0xLX09GX0RFQ0xBUkUocW9yaXFfY2xvY2tn
ZW5fcDIwNDEsICJmc2wscDIwNDEtY2xvY2tnZW4iLA0KPiA+IGNsb2NrZ2VuX2luaXQpOyAgQ0xL
X09GX0RFQ0xBUkUocW9yaXFfY2xvY2tnZW5fcDMwNDEsDQo+ID4gImZzbCxwMzA0MS1jbG9ja2dl
biIsIGNsb2NrZ2VuX2luaXQpOw0KPiA+IENMS19PRl9ERUNMQVJFKHFvcmlxX2Nsb2NrZ2VuX3A0
MDgwLCAiZnNsLHA0MDgwLWNsb2NrZ2VuIiwNCj4gPiBjbG9ja2dlbl9pbml0KTsgZGlmZiAtLWdp
dCBhL2RyaXZlcnMvY3B1ZnJlcS9xb3JpcS1jcHVmcmVxLmMNCj4gPiBiL2RyaXZlcnMvY3B1ZnJl
cS9xb3JpcS1jcHVmcmVxLmMgaW5kZXggNDI5NWU1NC4uODFmMDI4OCAxMDA2NDQNCj4gPiAtLS0g
YS9kcml2ZXJzL2NwdWZyZXEvcW9yaXEtY3B1ZnJlcS5jDQo+ID4gKysrIGIvZHJpdmVycy9jcHVm
cmVxL3FvcmlxLWNwdWZyZXEuYw0KPiA+IEBAIC0yODQsNiArMjg0LDcgQEAgc3RhdGljIGNvbnN0
IHN0cnVjdCBvZl9kZXZpY2VfaWQgbm9kZV9tYXRjaGVzW10NCj4gX19pbml0Y29uc3QgPSB7DQo+
ID4gICAgICAgICB7IC5jb21wYXRpYmxlID0gImZzbCxsczEwNDZhLWNsb2NrZ2VuIiwgfSwNCj4g
PiAgICAgICAgIHsgLmNvbXBhdGlibGUgPSAiZnNsLGxzMTA4OGEtY2xvY2tnZW4iLCB9LA0KPiA+
ICAgICAgICAgeyAuY29tcGF0aWJsZSA9ICJmc2wsbHMyMDgwYS1jbG9ja2dlbiIsIH0sDQo+ID4g
KyAgICAgICB7IC5jb21wYXRpYmxlID0gImZzbCxseDIxNjBhLWNsb2NrZ2VuIiwgfSwNCj4gPiAg
ICAgICAgIHsgLmNvbXBhdGlibGUgPSAiZnNsLHA0MDgwLWNsb2NrZ2VuIiwgfSwNCj4gPiAgICAg
ICAgIHsgLmNvbXBhdGlibGUgPSAiZnNsLHFvcmlxLWNsb2NrZ2VuLTEuMCIsIH0sDQo+ID4gICAg
ICAgICB7IC5jb21wYXRpYmxlID0gImZzbCxxb3JpcS1jbG9ja2dlbi0yLjAiLCB9LA0KPiA+IC0t
DQo+ID4gMi43LjQNCj4gPg0K
