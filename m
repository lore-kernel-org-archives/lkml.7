Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BBFCC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 07:45:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC62F2177B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 07:45:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="DaoXZhtQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731075AbfDQHpu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 03:45:50 -0400
Received: from mail-eopbgr50045.outbound.protection.outlook.com ([40.107.5.45]:35238
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725848AbfDQHpu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 03:45:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P/SKM5vMB8OZ+sFj/dJsZYEPKcJWgrozsv4goSPR2bI=;
 b=DaoXZhtQoJP1xvLFgfxP+Kdg3tHhl7EEmrT2KVuuJiyJIf4NnZv0plx5ctrmJkUQSjvX6tOl10OMXnhx4Ev+3zBWJBVJ/5bmpc727u2zUd2bQrHYa9bTFOaWBWuHtGyY6+b9WfhEYEYFEvImyJoz/b4Gr50KuRacbQ2yw9tiltE=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.92.158) by
 AM0PR04MB4851.eurprd04.prod.outlook.com (20.176.215.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.19; Wed, 17 Apr 2019 07:45:04 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::8cda:4e52:8e87:8f0e]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::8cda:4e52:8e87:8f0e%2]) with mapi id 15.20.1792.021; Wed, 17 Apr 2019
 07:45:04 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "edubezval@gmail.com" <edubezval@gmail.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "agross@kernel.org" <agross@kernel.org>,
        "olof@lixom.net" <olof@lixom.net>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V12 3/5] thermal: imx_sc: add i.MX system controller
 thermal support
Thread-Topic: [PATCH V12 3/5] thermal: imx_sc: add i.MX system controller
 thermal support
Thread-Index: AQHU9AOd0xCeMx9rMkStRq/hkjSd7aY/tDYQ
Date:   Wed, 17 Apr 2019 07:45:04 +0000
Message-ID: <AM0PR04MB421105BBF1B9A90B255D1F7A80250@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1555384609-7030-1-git-send-email-Anson.Huang@nxp.com>
 <1555384609-7030-3-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1555384609-7030-3-git-send-email-Anson.Huang@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5980fe31-f3a0-43a4-8979-08d6c3089ace
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600140)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:AM0PR04MB4851;
x-ms-traffictypediagnostic: AM0PR04MB4851:
x-microsoft-antispam-prvs: <AM0PR04MB48519102E0F060CFF4A395A580250@AM0PR04MB4851.eurprd04.prod.outlook.com>
x-forefront-prvs: 0010D93EFE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(396003)(366004)(346002)(376002)(199004)(189003)(105586002)(52536014)(110136005)(71190400001)(97736004)(256004)(316002)(2906002)(71200400001)(81166006)(2201001)(3846002)(6116002)(106356001)(8936002)(68736007)(81156014)(486006)(76176011)(446003)(11346002)(26005)(186003)(8676002)(99286004)(86362001)(7696005)(6506007)(14454004)(2501003)(4326008)(7736002)(66066001)(229853002)(53936002)(102836004)(55016002)(74316002)(476003)(305945005)(6436002)(478600001)(5660300002)(25786009)(44832011)(6246003)(33656002)(7416002)(9686003)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4851;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: z/lSMBvRjoGnxB0ek5RA5lsl5Af1o6kjINkGPupQWx2nj/bMrzW+VCHuUcs247s6OyyCx2TLNg7S1JxojY+QZIOPhpJsaM9JHxfOZHbRjlng9L164qQV8alLjg1CYfNuk+CGmItHZTFG3vvOCGtboclAFPLZUIGq5S5zedGIcZx8Mt5OKeABo0iWya9am/ZVOYsUTYM409X1J0KmSoGRAikbV4gFd5rHY5QShPZofnCpWOAJrs+g4DVk2lwc6VIb8b+8iVnpn0I0sAXRi0wcUhIloAEf4I/dexn6XWaRE6rmvoCf4ma16ecoqNTglYldYzVsGYMxerJF3hDtHhTyqb3UAk4/kl+Lqnyw23UYiwq7GUcYug5vxMNuYucrCtLjiOAgSn/bRnHDdKRBeAOv0zVWJdKvo09CSM67Ygi/1mo=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5980fe31-f3a0-43a4-8979-08d6c3089ace
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2019 07:45:04.3024
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4851
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBBbnNvbiBIdWFuZw0KPiBTZW50OiBUdWVzZGF5LCBBcHJpbCAxNiwgMjAxOSAxMToy
MiBBTQ0KPiANCj4gaS5NWDhRWFAgaXMgYW4gQVJNdjggU29DIHdoaWNoIGhhcyBhIENvcnRleC1N
NCBzeXN0ZW0gY29udHJvbGxlciBpbnNpZGUsDQo+IHRoZSBzeXN0ZW0gY29udHJvbGxlciBpcyBp
biBjaGFyZ2Ugb2YgY29udHJvbGxpbmcgcG93ZXIsIGNsb2NrIGFuZCB0aGVybWFsDQo+IHNlbnNv
cnMgZXRjLi4NCj4gDQo+IFRoaXMgcGF0Y2ggYWRkcyBpLk1YIHN5c3RlbSBjb250cm9sbGVyIHRo
ZXJtYWwgZHJpdmVyIHN1cHBvcnQsIExpbnV4IGtlcm5lbCBoYXMNCj4gdG8gY29tbXVuaWNhdGUg
d2l0aCBzeXN0ZW0gY29udHJvbGxlciB2aWEgTVUgKG1lc3NhZ2UgdW5pdCkgSVBDIHRvIGdldCBl
YWNoDQo+IHRoZXJtYWwgc2Vuc29yJ3MgdGVtcGVyYXR1cmUsIGl0IHN1cHBvcnRzIG11bHRpcGxl
IHNlbnNvcnMgd2hpY2ggYXJlIHBhc3NlZA0KPiBmcm9tIGRldmljZSB0cmVlLCBwbGVhc2Ugc2Vl
IHRoZSBiaW5kaW5nIGRvYyBmb3IgZGV0YWlscy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEFuc29u
IEh1YW5nIDxBbnNvbi5IdWFuZ0BueHAuY29tPg0KPiAtLS0NCj4gQ2hhbmdlcyBzaW5jZSBWMTE6
DQo+IAktIG1vdmUgdGhlIEFQSSBvZiBnZXR0aW5nIHRoZXJtYWwgem9uZSBzZW5zb3IgSUQgdG8g
b2YtdGhlcm1hbC5jIGFzDQo+IGdlbmVyaWMgQVBJOw0KPiAJLSByZW1vdmUgdW5uZWNlc3Nhcnkg
X19wYWNrZWQuDQo+IC0tLQ0KPiAgZHJpdmVycy90aGVybWFsL0tjb25maWcgICAgICAgICAgfCAg
MTEgKysrKw0KPiAgZHJpdmVycy90aGVybWFsL01ha2VmaWxlICAgICAgICAgfCAgIDEgKw0KPiAg
ZHJpdmVycy90aGVybWFsL2lteF9zY190aGVybWFsLmMgfCAxMzcNCj4gKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrDQo+ICAzIGZpbGVzIGNoYW5nZWQsIDE0OSBpbnNlcnRp
b25zKCspDQo+ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy90aGVybWFsL2lteF9zY190aGVy
bWFsLmMNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3RoZXJtYWwvS2NvbmZpZyBiL2RyaXZl
cnMvdGhlcm1hbC9LY29uZmlnIGluZGV4DQo+IDY1M2FhMjcuLjRlNGZhN2UgMTAwNjQ0DQo+IC0t
LSBhL2RyaXZlcnMvdGhlcm1hbC9LY29uZmlnDQo+ICsrKyBiL2RyaXZlcnMvdGhlcm1hbC9LY29u
ZmlnDQo+IEBAIC0yMjMsNiArMjIzLDE3IEBAIGNvbmZpZyBJTVhfVEhFUk1BTA0KPiAgCSAgY3B1
ZnJlcSBpcyB1c2VkIGFzIHRoZSBjb29saW5nIGRldmljZSB0byB0aHJvdHRsZSBDUFVzIHdoZW4g
dGhlDQo+ICAJICBwYXNzaXZlIHRyaXAgaXMgY3Jvc3NlZC4NCj4gDQo+ICtjb25maWcgSU1YX1ND
X1RIRVJNQUwNCj4gKwl0cmlzdGF0ZSAiVGVtcGVyYXR1cmUgc2Vuc29yIGRyaXZlciBmb3IgTlhQ
IGkuTVggU29DcyB3aXRoIFN5c3RlbQ0KPiBDb250cm9sbGVyIg0KPiArCWRlcGVuZHMgb24gKEFS
Q0hfTVhDICYmIElNWF9TQ1UpIHx8IENPTVBJTEVfVEVTVA0KDQpDT01QSUxFX1RFU1Qgc2VlbXMg
d29uJ3Qgd29yayBhbmQgbWF5IGNhdXNlIGJ1aWxkIGlzc3VlIGR1ZSB0bw0KdGhlIGRlcGVuZGVu
Y3kgb2YgSU1YX1NDVS4NCg0KPiArCWRlcGVuZHMgb24gT0YNCj4gKwloZWxwDQo+ICsJICBTdXBw
b3J0IGZvciBUZW1wZXJhdHVyZSBNb25pdG9yIChURU1QTU9OKSBmb3VuZCBvbiBOWFAgaS5NWCBT
b0NzDQo+IHdpdGgNCj4gKwkgIHN5c3RlbSBjb250cm9sbGVyIGluc2lkZSwgTGludXgga2VybmVs
IGhhcyB0byBjb21tdW5pY2F0ZSB3aXRoIHN5c3RlbQ0KPiArCSAgY29udHJvbGxlciB2aWEgTVUg
KG1lc3NhZ2UgdW5pdCkgSVBDIHRvIGdldCB0ZW1wZXJhdHVyZSBmcm9tIHRoZXJtYWwNCj4gKwkg
IHNlbnNvci4gSXQgc3VwcG9ydHMgb25lIGNyaXRpY2FsIHRyaXAgcG9pbnQgYW5kIG9uZQ0KPiAr
CSAgcGFzc2l2ZSB0cmlwIHBvaW50IGZvciBlYWNoIHRoZXJtYWwgc2Vuc29yLg0KPiArDQoNClsu
Li5dDQoNCj4gK3N0YXRpYyBpbnQgaW14X3NjX3RoZXJtYWxfZ2V0X3RlbXAodm9pZCAqZGF0YSwg
aW50ICp0ZW1wKSB7DQo+ICsJc3RydWN0IGlteF9zY19tc2dfbWlzY19nZXRfdGVtcCBtc2c7DQo+
ICsJc3RydWN0IGlteF9zY19ycGNfbXNnICpoZHIgPSAmbXNnLmhkcjsNCj4gKwlzdHJ1Y3QgaW14
X3NjX3NlbnNvciAqc2Vuc29yID0gZGF0YTsNCj4gKwlpbnQgcmV0Ow0KPiArDQo+ICsJbXNnLmRh
dGEucmVxLnJlc291cmNlX2lkID0gc2Vuc29yLT5yZXNvdXJjZV9pZDsNCj4gKwltc2cuZGF0YS5y
ZXEudHlwZSA9IElNWF9TQ19DX1RFTVA7DQoNCklNWF9TQ19DX1RFTVAgZHVwbGljYXRlcyB3aXRo
IGVudW0gaW14X3NjX2N0cmwgd2UgYWxyZWFkeSBoYXZlLg0KaW5jbHVkZS9saW51eC9maXJtd2Fy
ZS9pbXgvdHlwZXMuaA0KDQpCdXQgSSBndWVzcyB5b3UncmUgbm90IHdhbnQgdG8gdXNlIGEgQ1RS
TCBoZXJlLg0KU28gcGxlYXNlIGZpeCB0aGUgbmFtZSBjb252ZW50aW9uLg0KDQo+ICsNCj4gKwlo
ZHItPnZlciA9IElNWF9TQ19SUENfVkVSU0lPTjsNCj4gKwloZHItPnN2YyA9IElNWF9TQ19SUENf
U1ZDX01JU0M7DQo+ICsJaGRyLT5mdW5jID0gSU1YX1NDX01JU0NfRlVOQ19HRVRfVEVNUDsNCj4g
KwloZHItPnNpemUgPSAyOw0KPiArDQo+ICsJcmV0ID0gaW14X3NjdV9jYWxsX3JwYyh0aGVybWFs
X2lwY19oYW5kbGUsICZtc2csIHRydWUpOw0KPiArCWlmIChyZXQpIHsNCj4gKwkJcHJfZXJyKCJy
ZWFkIHRlbXAgc2Vuc29yICVkIGZhaWxlZCwgcmV0ICVkXG4iLA0KPiArCQkJc2Vuc29yLT5yZXNv
dXJjZV9pZCwgcmV0KTsNCg0KVGhlIGVycm9yIG1lc3NhZ2UgaXMgbWVhbmluZ2xlc3MuDQpDYW4n
dCBjb252ZXJ0IHRvIGRldl9lcnI/DQoNCj4gKwkJcmV0dXJuIHJldDsNCj4gKwl9DQo+ICsNCj4g
KwkqdGVtcCA9IG1zZy5kYXRhLnJlc3AuY2Vsc2l1cyAqIDEwMDAgKyBtc2cuZGF0YS5yZXNwLnRl
bnRocyAqIDEwMDsNCj4gKw0KPiArCXJldHVybiAwOw0KPiArfQ0KPiArDQo+ICtzdGF0aWMgY29u
c3Qgc3RydWN0IHRoZXJtYWxfem9uZV9vZl9kZXZpY2Vfb3BzIGlteF9zY190aGVybWFsX29wcyA9
IHsNCj4gKwkuZ2V0X3RlbXAgPSBpbXhfc2NfdGhlcm1hbF9nZXRfdGVtcCwNCj4gK307DQo+ICsN
Cj4gK3N0YXRpYyBpbnQgaW14X3NjX3RoZXJtYWxfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2Rldmlj
ZSAqcGRldikgew0KPiArCXN0cnVjdCBkZXZpY2Vfbm9kZSAqbnAsICpjaGlsZDsNCj4gKwlpbnQg
cmV0Ow0KPiArDQo+ICsJcmV0ID0gaW14X3NjdV9nZXRfaGFuZGxlKCZ0aGVybWFsX2lwY19oYW5k
bGUpOw0KPiArCWlmIChyZXQpDQo+ICsJCXJldHVybiByZXQ7DQo+ICsNCj4gKwlucCA9IG9mX2Zp
bmRfbm9kZV9ieV9uYW1lKE5VTEwsICJ0aGVybWFsLXpvbmVzIik7DQo+ICsJaWYgKCFucCkNCj4g
KwkJcmV0dXJuIC1FTk9ERVY7DQo+ICsNCj4gKwlmb3JfZWFjaF9hdmFpbGFibGVfY2hpbGRfb2Zf
bm9kZShucCwgY2hpbGQpIHsNCj4gKwkJc3RydWN0IG9mX3BoYW5kbGVfYXJncyBzZW5zb3Jfc3Bl
Y3M7DQo+ICsJCXN0cnVjdCBpbXhfc2Nfc2Vuc29yICpzZW5zb3IgPQ0KPiArCQkJZGV2bV9remFs
bG9jKCZwZGV2LT5kZXYsIHNpemVvZigqc2Vuc29yKSwgR0ZQX0tFUk5FTCk7DQoNClVzdWFsbHkg
d2UgZG8gbm90IG1peCB0aGUgY29tcGxpY2F0ZWQgY29kZSBpbiB0aGUgZGVjbGFyZSBsaW5lLg0K
WW91IGNhbiBtb3ZlIHRoZSBkZWNsYXJhdGlvbnMgaW50byB0aGUgdG9wIGxldmVsIHRvIG1ha2Ug
Y29kZSBtb3JlIGNsZWFuLg0KDQo+ICsJCWlmICghc2Vuc29yKQ0KPiArCQkJcmV0dXJuIC1FTk9N
RU07DQo+ICsNCj4gKwkJcmV0ID0gdGhlcm1hbF96b25lX29mX2dldF9zZW5zb3JfaWQoY2hpbGQs
DQo+ICsJCQkJCQkgICAgJnNlbnNvcl9zcGVjcywNCg0KSXQgbG9va3MgYSBiaXQgc3RyYW5nZSB3
aHkgbmVlZCBzZW5zb3Jfc3BlY3MgYXMgeW91IGV2ZW4gZGlkIG5vdCB1c2UgaXQuDQoNClJlZ2Fy
ZHMNCkRvbmcgQWlzaGVuZw0KDQo+ICsJCQkJCQkgICAgJnNlbnNvci0+cmVzb3VyY2VfaWQpOw0K
PiArCQlpZiAocmV0IDwgMCkgew0KPiArCQkJZGV2X2VycigmcGRldi0+ZGV2LA0KPiArCQkJCSJm
YWlsZWQgdG8gZ2V0IHZhbGlkIHNlbnNvciByZXNvdXJjZSBpZDogJWRcbiIsDQo+ICsJCQkJcmV0
KTsNCj4gKwkJCWJyZWFrOw0KPiArCQl9DQo+ICsNCj4gKwkJc2Vuc29yLT50emQgPSBkZXZtX3Ro
ZXJtYWxfem9uZV9vZl9zZW5zb3JfcmVnaXN0ZXIoJnBkZXYtPmRldiwNCj4gKwkJCQkJCQkJICAg
c2Vuc29yLT5yZXNvdXJjZV9pZCwNCj4gKwkJCQkJCQkJICAgc2Vuc29yLA0KPiArCQkJCQkJCQkg
ICAmaW14X3NjX3RoZXJtYWxfb3BzKTsNCj4gKwkJaWYgKElTX0VSUihzZW5zb3ItPnR6ZCkpIHsN
Cj4gKwkJCWRldl9lcnIoJnBkZXYtPmRldiwgImZhaWxlZCB0byByZWdpc3RlciB0aGVybWFsIHpv
bmVcbiIpOw0KPiArCQkJcmV0ID0gUFRSX0VSUihzZW5zb3ItPnR6ZCk7DQo+ICsJCQlicmVhazsN
Cj4gKwkJfQ0KPiArCX0NCj4gKw0KPiArCXJldHVybiByZXQ7DQo+ICt9DQo+ICsNCj4gK3N0YXRp
YyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIGlteF9zY190aGVybWFsX3RhYmxlW10gPSB7DQo+
ICsJeyAuY29tcGF0aWJsZSA9ICJmc2wsaW14LXNjLXRoZXJtYWwiLCB9LA0KPiArCXt9DQo+ICt9
Ow0KPiArTU9EVUxFX0RFVklDRV9UQUJMRShvZiwgaW14X3NjX3RoZXJtYWxfdGFibGUpOw0KPiAr
DQo+ICtzdGF0aWMgc3RydWN0IHBsYXRmb3JtX2RyaXZlciBpbXhfc2NfdGhlcm1hbF9kcml2ZXIg
PSB7DQo+ICsJCS5wcm9iZSA9IGlteF9zY190aGVybWFsX3Byb2JlLA0KPiArCQkuZHJpdmVyID0g
ew0KPiArCQkJLm5hbWUgPSAiaW14LXNjLXRoZXJtYWwiLA0KPiArCQkJLm9mX21hdGNoX3RhYmxl
ID0gaW14X3NjX3RoZXJtYWxfdGFibGUsDQo+ICsJCX0sDQo+ICt9Ow0KPiArbW9kdWxlX3BsYXRm
b3JtX2RyaXZlcihpbXhfc2NfdGhlcm1hbF9kcml2ZXIpOw0KPiArDQo+ICtNT0RVTEVfQVVUSE9S
KCJBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4iKTsNCj4gK01PRFVMRV9ERVNDUklQ
VElPTigiVGhlcm1hbCBkcml2ZXIgZm9yIE5YUCBpLk1YIFNvQ3Mgd2l0aCBzeXN0ZW0NCj4gK2Nv
bnRyb2xsZXIiKTsgTU9EVUxFX0xJQ0VOU0UoIkdQTCB2MiIpOw0KPiAtLQ0KPiAyLjcuNA0KDQo=
