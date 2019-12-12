Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32B45C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 10:07:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1970206A5
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 10:07:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Pg/JkBGt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728527AbfLLKHo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 05:07:44 -0500
Received: from mail-eopbgr130051.outbound.protection.outlook.com ([40.107.13.51]:59406
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728394AbfLLKHo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 05:07:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UHOnhM6RFMo40bOebV1n1B57AEuTl1W5G3RLTLLIg+4X9cCxtOsFxfv1lxLV6f3R/j61lAcMsZ+NFUusSWeZqotXXswuunr3llvxXE0j0GPX8KCVuXvtY3bhVe8TP+0yaGhkepgwVEnJlE7uMl8lslexNtZNp6V/LgZMHGeJ+9cGbU+3eK+ygHRqhLXA9BJzAFcFcqln9bnZzUgtAbSrq1JSLT/m04POEBXl2Rkik7EaNqkYRYxZZFpieil9Wntvoyz9mZt2HLlBGVbaDXOQy/G4Ubu/cwyO4HoCLVeebJoRSmxrNlQwN6uQSdh5z1h//Jgug2IPuihO+emJ7wEmdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sfP97DmUT+sgNX5BL5pIB2byu5auRd36+YgRVZsU3+8=;
 b=WACkFjUo55b9savdKf6BHW3Yg9Xa36/uqrvkYBtWxEEJogedNTizPU+6tBw3viFIMn6vBC6g8FXmgqaL4hVPOujGDjutpnut9CTVpS3wLM0U/FQxIb32MXszCPlkbDeRqEx9BiJG/pDgdPUHkGdYgMKiV8g/LK+4RI8zbJjDFpakp7wel8yQNRNQPYW1uNgGp+LswtKzDx3yxMQcPyZOBzRaTSuIMIlyEwzutOdjh6FibrPQpTtKrqdC2GGEKaX4LfpXvEVwOW+hZ18bCbWsGLIMyxZP8jnf/re9S5CpL7WSrzyM+wfcvfgYgv9aYSNN91q5rohPZNxZ1q9yXBzlHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sfP97DmUT+sgNX5BL5pIB2byu5auRd36+YgRVZsU3+8=;
 b=Pg/JkBGtD7c4oqXzsxcWT2fILS7P0n/u9bFHC3OUHMMDWm1hvBYXz6JN3k1Iy0+csLz57uzt1BhisI8PAE9tyI3EZkk0ULmT1nJuxhXneLTdz0S+Pomd1bxi4k7cbBxAVIPusNCHfWX1DwaQlcy+TAuAfhI6QgU50FI7UQZvL9A=
Received: from VI1PR04MB4062.eurprd04.prod.outlook.com (52.133.12.32) by
 VI1PR04MB5152.eurprd04.prod.outlook.com (20.177.50.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.17; Thu, 12 Dec 2019 10:07:39 +0000
Received: from VI1PR04MB4062.eurprd04.prod.outlook.com
 ([fe80::20fe:3e38:4eec:ea03]) by VI1PR04MB4062.eurprd04.prod.outlook.com
 ([fe80::20fe:3e38:4eec:ea03%7]) with mapi id 15.20.2516.018; Thu, 12 Dec 2019
 10:07:39 +0000
From:   Alison Wang <alison.wang@nxp.com>
To:     Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
CC:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Igor Opaniuk <igor.opaniuk@toradex.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH] ASoC: sgtl5000: Revert "ASoC: sgtl5000: Fix of
 unmute outputs on probe"
Thread-Topic: [EXT] Re: [PATCH] ASoC: sgtl5000: Revert "ASoC: sgtl5000: Fix of
 unmute outputs on probe"
Thread-Index: AQHVsLyIRDFbzLs7vEuxsFkXl6DgTKe2NokAgAAA1bCAAAyIYA==
Date:   Thu, 12 Dec 2019 10:07:39 +0000
Message-ID: <VI1PR04MB4062C67906888DA8142C17E1F4550@VI1PR04MB4062.eurprd04.prod.outlook.com>
References: <20191212071847.45561-1-alison.wang@nxp.com>
 <CAGgjyvHHzPWjRTqxYmGCmk3qa6=kOezHywVDFomgD6UNj-zwpQ@mail.gmail.com>
 <VI1PR04MB40627CDD5F0C17D8DCDCFFE2F4550@VI1PR04MB4062.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB40627CDD5F0C17D8DCDCFFE2F4550@VI1PR04MB4062.eurprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=alison.wang@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f9bf08a2-d650-49bf-fa02-08d77eeb1ea2
x-ms-traffictypediagnostic: VI1PR04MB5152:|VI1PR04MB5152:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <VI1PR04MB5152793A65018DE4C04D509DF4550@VI1PR04MB5152.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0249EFCB0B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(376002)(396003)(346002)(136003)(39860400002)(13464003)(189003)(199004)(478600001)(44832011)(2906002)(186003)(4326008)(55016002)(26005)(9686003)(86362001)(2940100002)(5660300002)(52536014)(71200400001)(76116006)(316002)(66476007)(8936002)(66946007)(81156014)(66556008)(81166006)(64756008)(54906003)(6506007)(53546011)(7696005)(33656002)(66446008)(8676002)(6916009);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5152;H:VI1PR04MB4062.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: G/n1uaZN0D/ZI4W6Y5rWRaebdqtarFe5GyHB9Vz5eZ4hkomM8Mteh5jsGgV+SmNZpxBF9Jlc2qbcS+8pMDSS0Gd82XzElY/DXMZC/UbUYBFkCGh0g1F9wPNtZ9xBPaRlGUgYLnb6KgvOIrhv/qq7a9iemvzTxaAfJ4237mPMM6uND4sZiZh+5ty0qNLO060DQ0nuoXAYb11PJepuE/OmGI4eJmprKt53V/QFYfqd2esvBia5572hUVTBeHO0lXHvje73RShmGJOxaUy9xXgCspEdFaW7lygAHSxGJmK2X2BqoHQnC/ckAySiGZotxB6Of/ncO6Jlq2RCJC159pv3fGQwafLH/bEEgVOqDFS46a9MyAsKWJW28GfYmv6IRnQtFnYVM0JsnD9FGlOkum0IuGHa2YpKn8V+ZlAL5bzd5yMxs5tVsPi2790x4cxYMnn0X8GwH9K4nBCMF304cn0kBEORx+Lj9BftzFsxiffI4SXzWzUiXUJiZM/wDUTIcXMj
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9bf08a2-d650-49bf-fa02-08d77eeb1ea2
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2019 10:07:39.1386
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rGjr0VhrpUPa1vJYPjMeKQocAf86vTO4pMaXtJcddpgIEpmsThngzyFzmZz7J+Y/z2r5Czs+nGu31IMPqUfWbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5152
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIE9sZWtzYW5kciwNCg0KSW4geW91ciBwYXRjaCwgb3V0cHV0cyBhbmQgQURDIGFyZSBtdXRl
ZCBvbiBkcml2ZXIgcHJvYmluZy4gSSBkb24ndCBrbm93IHdoZW4gYW5kDQp3aGVyZSB0aGV5IGNh
biBiZSB1bm11dGVkIGluIHRoZSBrZXJuZWwgYmVmb3JlIHBsYXlpbmcgaW4gdGhlIGFwcGxpY2F0
aW9uLg0KDQpDb3VsZCB5b3UgcGxlYXNlIGdpdmUgbWUgc29tZSBpZGVhcz8NCg0KDQpCZXN0IFJl
Z2FyZHMsDQpBbGlzb24gV2FuZw0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZy
b206IEFsaXNvbiBXYW5nDQo+IFNlbnQ6IFRodXJzZGF5LCBEZWNlbWJlciAxMiwgMjAxOSA1OjI1
IFBNDQo+IFRvOiBPbGVrc2FuZHIgU3V2b3JvdiA8b2xla3NhbmRyLnN1dm9yb3ZAdG9yYWRleC5j
b20+DQo+IENjOiBNYXJjZWwgWmlzd2lsZXIgPG1hcmNlbC56aXN3aWxlckB0b3JhZGV4LmNvbT47
IElnb3IgT3Bhbml1aw0KPiA8aWdvci5vcGFuaXVrQHRvcmFkZXguY29tPjsgZmVzdGV2YW1AZ21h
aWwuY29tOyBicm9vbmllQGtlcm5lbC5vcmc7DQo+IGxnaXJkd29vZEBnbWFpbC5jb207IGFsc2Et
ZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZzsNCj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0K
PiBTdWJqZWN0OiBSRTogW0VYVF0gUmU6IFtQQVRDSF0gQVNvQzogc2d0bDUwMDA6IFJldmVydCAi
QVNvQzogc2d0bDUwMDA6IEZpeCBvZg0KPiB1bm11dGUgb3V0cHV0cyBvbiBwcm9iZSINCj4gDQo+
IEhpLCBPbGVrc2FuZHIsDQo+IA0KPiBJIHRoaW5rIEkgaGF2ZSBleHBsYWluZWQgdGhlIHJlYXNv
biBpbiBteSBlbWFpbCB3aGljaCBzZW50IHRvIHlvdSB5ZXN0ZXJkYXkuIEkNCj4gYXR0YWNoZWQg
aXQgdG9vLg0KPiBBY2NvcmRpbmcgdG8gbXkgdGVzdCBvbiB0aGUgYm9hcmRzLCBNVVRFX0xPLCBN
VVRFX0hQIGFuZCBNVVRFX0FEQyBhcmUNCj4gYWxsIG11dGVkIHdoZW4gcGxheWluZyB0aGUgc291
bmQuDQo+IA0KPiBDb3VsZCB5b3UgZ2l2ZSBtZSBzb21lIGlkZWFzIGFib3V0IHRoaXMgaXNzdWU/
DQo+IA0KPiANCj4gQmVzdCBSZWdhcmRzLEkNCj4gQWxpc29uIFdhbmcNCj4gDQo+IA0KPiA+IC0t
LS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gRnJvbTogT2xla3NhbmRyIFN1dm9yb3YgPG9s
ZWtzYW5kci5zdXZvcm92QHRvcmFkZXguY29tPg0KPiA+IFNlbnQ6IFRodXJzZGF5LCBEZWNlbWJl
ciAxMiwgMjAxOSA1OjExIFBNDQo+ID4gVG86IEFsaXNvbiBXYW5nIDxhbGlzb24ud2FuZ0BueHAu
Y29tPg0KPiA+IENjOiBNYXJjZWwgWmlzd2lsZXIgPG1hcmNlbC56aXN3aWxlckB0b3JhZGV4LmNv
bT47IElnb3IgT3Bhbml1aw0KPiA+IDxpZ29yLm9wYW5pdWtAdG9yYWRleC5jb20+OyBmZXN0ZXZh
bUBnbWFpbC5jb207IGJyb29uaWVAa2VybmVsLm9yZzsNCj4gPiBsZ2lyZHdvb2RAZ21haWwuY29t
OyBPbGVrc2FuZHIgU3V2b3Jvdg0KPiA8b2xla3NhbmRyLnN1dm9yb3ZAdG9yYWRleC5jb20+Ow0K
PiA+IGFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVs
Lm9yZw0KPiA+IFN1YmplY3Q6IFtFWFRdIFJlOiBbUEFUQ0hdIEFTb0M6IHNndGw1MDAwOiBSZXZl
cnQgIkFTb0M6IHNndGw1MDAwOiBGaXggb2YNCj4gPiB1bm11dGUgb3V0cHV0cyBvbiBwcm9iZSIN
Cj4gPg0KPiA+IENhdXRpb246IEVYVCBFbWFpbA0KPiA+DQo+ID4gQWxpc29uLCBjb3VsZCB5b3Ug
cGxlYXNlIGV4cGxhaW4sIHdoYXQgcmVhc29uIHRvIHJldmVydCB0aGlzIGZpeD8gQWxsIHRoZXNl
DQo+IGJsb2Nrcw0KPiA+IGhhdmUgdGhlaXIgb3duIGNvbnRyb2wgYW5kIHVubXV0ZSBvbiBkZW1h
bmQuDQo+ID4gV2h5IGRvIHlvdSBzdGFuZCBvbiB1bmNvbmRpdGlvbmFsIHVubXV0aW5nIG9mIG91
dHB1dHMgYW5kIEFEQyBvbiBkcml2ZXINCj4gPiBwcm9iaW5nPw0KPiA+DQo+ID4gT24gVGh1LCBE
ZWMgMTIsIDIwMTkgYXQgOToyMCBBTSBBbGlzb24gV2FuZyA8YWxpc29uLndhbmdAbnhwLmNvbT4N
Cj4gPiB3cm90ZToNCj4gPiA+DQo+ID4gPiBUaGlzIHJldmVydHMgY29tbWl0IDYzMWJjOGYwMTM0
YWU5NjIwZDg2YTk2YjhjNWY5NDQ1ZDkxYTJkY2EuDQo+ID4gPg0KPiA+ID4gSW4gY29tbWl0IDYz
MWJjOGYwMTM0YSwgc25kX3NvY19jb21wb25lbnRfdXBkYXRlX2JpdHMgaXMgdXNlZCBpbnN0ZWFk
DQo+ID4gPiBvZiBzbmRfc29jX2NvbXBvbmVudF93cml0ZS4gQWx0aG91Z2ggRU5fSFBfWkNEIGFu
ZCBFTl9BRENfWkNEIGFyZQ0KPiA+ID4gZW5hYmxlZCBpbiBBTkFfQ1RSTCByZWdpc3RlciwgTVVU
RV9MTywgTVVURV9IUCBhbmQgTVVURV9BREMgYml0cw0KPiBhcmUNCj4gPiA+IHJlbWFpbmVkIGFz
IHRoZSBkZWZhdWx0IHZhbHVlLiBJdCBjYXVzZXMgTE8sIEhQIGFuZCBBREMgYXJlIGFsbCBtdXRl
ZA0KPiA+ID4gYWZ0ZXIgZHJpdmVyIHByb2JlLg0KPiA+ID4NCj4gPiA+IFRoZSBwYXRjaCBpcyB0
byByZXZlcnQgdGhpcyBjb21taXQsIHNuZF9zb2NfY29tcG9uZW50X3dyaXRlIGlzIHN0aWxsDQo+
ID4gPiB1c2VkIGFuZCBNVVRFX0xPLCBNVVRFX0hQIGFuZCBNVVRFX0FEQyBhcmUgc2V0IGFzIHpl
cm8gKHVubXV0ZWQpLg0KPiA+ID4NCj4gPiA+IFNpZ25lZC1vZmYtYnk6IEFsaXNvbiBXYW5nIDxh
bGlzb24ud2FuZ0BueHAuY29tPg0KPiA+ID4gLS0tDQo+ID4gPiAgc291bmQvc29jL2NvZGVjcy9z
Z3RsNTAwMC5jIHwgNiArKystLS0NCj4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25z
KCspLCAzIGRlbGV0aW9ucygtKQ0KPiA+ID4NCj4gPiA+IGRpZmYgLS1naXQgYS9zb3VuZC9zb2Mv
Y29kZWNzL3NndGw1MDAwLmMgYi9zb3VuZC9zb2MvY29kZWNzL3NndGw1MDAwLmMNCj4gPiA+IGlu
ZGV4IGFhMWY5NjMuLjBiMzVmY2EgMTAwNjQ0DQo+ID4gPiAtLS0gYS9zb3VuZC9zb2MvY29kZWNz
L3NndGw1MDAwLmMNCj4gPiA+ICsrKyBiL3NvdW5kL3NvYy9jb2RlY3Mvc2d0bDUwMDAuYw0KPiA+
ID4gQEAgLTE0NTgsNyArMTQ1OCw2IEBAIHN0YXRpYyBpbnQgc2d0bDUwMDBfcHJvYmUoc3RydWN0
DQo+ID4gc25kX3NvY19jb21wb25lbnQgKmNvbXBvbmVudCkNCj4gPiA+ICAgICAgICAgaW50IHJl
dDsNCj4gPiA+ICAgICAgICAgdTE2IHJlZzsNCj4gPiA+ICAgICAgICAgc3RydWN0IHNndGw1MDAw
X3ByaXYgKnNndGw1MDAwID0NCj4gPiBzbmRfc29jX2NvbXBvbmVudF9nZXRfZHJ2ZGF0YShjb21w
b25lbnQpOw0KPiA+ID4gLSAgICAgICB1bnNpZ25lZCBpbnQgemNkX21hc2sgPSBTR1RMNTAwMF9I
UF9aQ0RfRU4gfA0KPiA+IFNHVEw1MDAwX0FEQ19aQ0RfRU47DQo+ID4gPg0KPiA+ID4gICAgICAg
ICAvKiBwb3dlciB1cCBzZ3RsNTAwMCAqLw0KPiA+ID4gICAgICAgICByZXQgPSBzZ3RsNTAwMF9z
ZXRfcG93ZXJfcmVncyhjb21wb25lbnQpOw0KPiA+ID4gQEAgLTE0ODYsOCArMTQ4NSw5IEBAIHN0
YXRpYyBpbnQgc2d0bDUwMDBfcHJvYmUoc3RydWN0DQo+ID4gc25kX3NvY19jb21wb25lbnQgKmNv
bXBvbmVudCkNCj4gPiA+ICAgICAgICAgICAgICAgIDB4MWYpOw0KPiA+ID4gICAgICAgICBzbmRf
c29jX2NvbXBvbmVudF93cml0ZShjb21wb25lbnQsDQo+ID4gU0dUTDUwMDBfQ0hJUF9QQURfU1RS
RU5HVEgsDQo+ID4gPiByZWcpOw0KPiA+ID4NCj4gPiA+IC0gICAgICAgc25kX3NvY19jb21wb25l
bnRfdXBkYXRlX2JpdHMoY29tcG9uZW50LA0KPiA+IFNHVEw1MDAwX0NISVBfQU5BX0NUUkwsDQo+
ID4gPiAtICAgICAgICAgICAgICAgemNkX21hc2ssIHpjZF9tYXNrKTsNCj4gPiA+ICsgICAgICAg
c25kX3NvY19jb21wb25lbnRfd3JpdGUoY29tcG9uZW50LA0KPiA+IFNHVEw1MDAwX0NISVBfQU5B
X0NUUkwsDQo+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICBTR1RMNTAwMF9IUF9aQ0RfRU4g
fA0KPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgU0dUTDUwMDBfQURDX1pDRF9FTik7DQo+
ID4gPg0KPiA+ID4gICAgICAgICBzbmRfc29jX2NvbXBvbmVudF91cGRhdGVfYml0cyhjb21wb25l
bnQsDQo+ID4gU0dUTDUwMDBfQ0hJUF9NSUNfQ1RSTCwNCj4gPiA+ICAgICAgICAgICAgICAgICAg
ICAgICAgIFNHVEw1MDAwX0JJQVNfUl9NQVNLLA0KPiA+ID4gLS0NCj4gPiA+IDIuOS41DQo+ID4g
Pg0KPiA+DQo+ID4NCj4gPiAtLQ0KPiA+IEJlc3QgcmVnYXJkcw0KPiA+IE9sZWtzYW5kciBTdXZv
cm92DQo+ID4NCj4gPiBUb3JhZGV4IEFHDQo+ID4gQWx0c2FnZW5zdHJhc3NlIDUgfCA2MDQ4IEhv
cncvTHV6ZXJuIHwgU3dpdHplcmxhbmQgfCBUOiArNDEgNDEgNTAwDQo+ID4gNDgwMCAobWFpbiBs
aW5lKQ0K
