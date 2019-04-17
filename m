Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E282C282DC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 13:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6F9220872
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 13:42:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="RDB2GUoX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732282AbfDQNmN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 09:42:13 -0400
Received: from mail-eopbgr130082.outbound.protection.outlook.com ([40.107.13.82]:16026
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729395AbfDQNmN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 09:42:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y20LrX2yKxt1wq3uJp0BMuGsb69uAajaAqh08NQU0mE=;
 b=RDB2GUoX8deD4u+1SZ4xhNZj2DnuZLMD1MU2kvU2bDKGBFvQjy3VjRq4S6y5/fqoCuILBCZlRyHBuj7L8pSKqMSdFFpRx5IyGzFmFOMRU+vXh4xByLeEBE+fefNnahqONqh7zf8u7d5EZn+9qPnBbA+1GKTBcFyoP7Q6gizAb94=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3930.eurprd04.prod.outlook.com (52.134.71.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.11; Wed, 17 Apr 2019 13:42:02 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170%3]) with mapi id 15.20.1813.011; Wed, 17 Apr 2019
 13:42:02 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Aisheng Dong <aisheng.dong@nxp.com>,
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
Thread-Index: AQHU9AOc8iXKmYQeMUm4+FbUnbYclKY/+ukAgABUQSA=
Date:   Wed, 17 Apr 2019 13:42:02 +0000
Message-ID: <DB3PR0402MB39163877C25E5BE7E10C96B7F5250@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1555384609-7030-1-git-send-email-Anson.Huang@nxp.com>
 <1555384609-7030-3-git-send-email-Anson.Huang@nxp.com>
 <AM0PR04MB421105BBF1B9A90B255D1F7A80250@AM0PR04MB4211.eurprd04.prod.outlook.com>
In-Reply-To: <AM0PR04MB421105BBF1B9A90B255D1F7A80250@AM0PR04MB4211.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.69]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 35d88181-dc3e-4a7a-7fde-08d6c33a78fd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600140)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3930;
x-ms-traffictypediagnostic: DB3PR0402MB3930:
x-microsoft-antispam-prvs: <DB3PR0402MB39309C8357D09DF567399518F5250@DB3PR0402MB3930.eurprd04.prod.outlook.com>
x-forefront-prvs: 0010D93EFE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(39860400002)(396003)(136003)(346002)(199004)(189003)(13464003)(256004)(2501003)(102836004)(4326008)(2906002)(74316002)(14454004)(478600001)(186003)(6506007)(7696005)(2201001)(11346002)(316002)(68736007)(26005)(446003)(25786009)(86362001)(76176011)(7416002)(476003)(99286004)(44832011)(110136005)(66066001)(33656002)(6116002)(3846002)(105586002)(6246003)(71200400001)(71190400001)(106356001)(55016002)(486006)(53936002)(9686003)(305945005)(97736004)(7736002)(8936002)(81166006)(81156014)(52536014)(229853002)(8676002)(5660300002)(6436002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3930;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: muFDmkDKAVPTdRUfcYhFzLSU+l25rYhoG9J+iuAc4GDJ7Q5mF6wBURBQmdBVp7wXi8zFcW7T/Hb38yD5iv3h/72XOAkB5in7uiIIs8siclnbaVwcf9ATSaNIe0thIu41O1/gamkzI/nLsF7ehyzo3R4Al2cF4mNr7bA2D+R0IT5PwWUw4qIpRkkBABERwQNWF2bayEmeg8bHXJelCprvFD1kwSbzo8UyMhkWGGQBo5iFmpsPX3AszN+eONpZtK4WRcLUE/VTd/TczOpoC1ddHgL87kQq0GhOSB+R9KLxfw03fR7BhHHFTCuadTR+mOxB9K1sBg5uoVYye9EQmW8f09McbuQkKJ4k1af0Z2orjhbRtVXJJ+fLos6abGsYdcjHb93oEGkIxtv/UedIpVNPbxqgx4OVXWUbnQN0QPfGnqE=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35d88181-dc3e-4a7a-7fde-08d6c33a78fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2019 13:42:02.2791
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3930
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkJlc3QgUmVnYXJkcyENCkFuc29uIEh1YW5nDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdl
LS0tLS0NCj4gPiBGcm9tOiBBbnNvbiBIdWFuZw0KPiA+IFNlbnQ6IFR1ZXNkYXksIEFwcmlsIDE2
LCAyMDE5IDExOjIyIEFNDQo+ID4NCj4gPiBpLk1YOFFYUCBpcyBhbiBBUk12OCBTb0Mgd2hpY2gg
aGFzIGEgQ29ydGV4LU00IHN5c3RlbSBjb250cm9sbGVyDQo+ID4gaW5zaWRlLCB0aGUgc3lzdGVt
IGNvbnRyb2xsZXIgaXMgaW4gY2hhcmdlIG9mIGNvbnRyb2xsaW5nIHBvd2VyLCBjbG9jaw0KPiA+
IGFuZCB0aGVybWFsIHNlbnNvcnMgZXRjLi4NCj4gPg0KPiA+IFRoaXMgcGF0Y2ggYWRkcyBpLk1Y
IHN5c3RlbSBjb250cm9sbGVyIHRoZXJtYWwgZHJpdmVyIHN1cHBvcnQsIExpbnV4DQo+ID4ga2Vy
bmVsIGhhcyB0byBjb21tdW5pY2F0ZSB3aXRoIHN5c3RlbSBjb250cm9sbGVyIHZpYSBNVSAobWVz
c2FnZSB1bml0KQ0KPiA+IElQQyB0byBnZXQgZWFjaCB0aGVybWFsIHNlbnNvcidzIHRlbXBlcmF0
dXJlLCBpdCBzdXBwb3J0cyBtdWx0aXBsZQ0KPiA+IHNlbnNvcnMgd2hpY2ggYXJlIHBhc3NlZCBm
cm9tIGRldmljZSB0cmVlLCBwbGVhc2Ugc2VlIHRoZSBiaW5kaW5nIGRvYyBmb3INCj4gZGV0YWls
cy4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEFuc29uIEh1YW5nIDxBbnNvbi5IdWFuZ0BueHAu
Y29tPg0KPiA+IC0tLQ0KPiA+IENoYW5nZXMgc2luY2UgVjExOg0KPiA+IAktIG1vdmUgdGhlIEFQ
SSBvZiBnZXR0aW5nIHRoZXJtYWwgem9uZSBzZW5zb3IgSUQgdG8gb2YtdGhlcm1hbC5jIGFzDQo+
ID4gZ2VuZXJpYyBBUEk7DQo+ID4gCS0gcmVtb3ZlIHVubmVjZXNzYXJ5IF9fcGFja2VkLg0KPiA+
IC0tLQ0KPiA+ICBkcml2ZXJzL3RoZXJtYWwvS2NvbmZpZyAgICAgICAgICB8ICAxMSArKysrDQo+
ID4gIGRyaXZlcnMvdGhlcm1hbC9NYWtlZmlsZSAgICAgICAgIHwgICAxICsNCj4gPiAgZHJpdmVy
cy90aGVybWFsL2lteF9zY190aGVybWFsLmMgfCAxMzcNCj4gPiArKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysNCj4gPiAgMyBmaWxlcyBjaGFuZ2VkLCAxNDkgaW5zZXJ0aW9u
cygrKQ0KPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy90aGVybWFsL2lteF9zY190aGVy
bWFsLmMNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3RoZXJtYWwvS2NvbmZpZyBiL2Ry
aXZlcnMvdGhlcm1hbC9LY29uZmlnIGluZGV4DQo+ID4gNjUzYWEyNy4uNGU0ZmE3ZSAxMDA2NDQN
Cj4gPiAtLS0gYS9kcml2ZXJzL3RoZXJtYWwvS2NvbmZpZw0KPiA+ICsrKyBiL2RyaXZlcnMvdGhl
cm1hbC9LY29uZmlnDQo+ID4gQEAgLTIyMyw2ICsyMjMsMTcgQEAgY29uZmlnIElNWF9USEVSTUFM
DQo+ID4gIAkgIGNwdWZyZXEgaXMgdXNlZCBhcyB0aGUgY29vbGluZyBkZXZpY2UgdG8gdGhyb3R0
bGUgQ1BVcyB3aGVuIHRoZQ0KPiA+ICAJICBwYXNzaXZlIHRyaXAgaXMgY3Jvc3NlZC4NCj4gPg0K
PiA+ICtjb25maWcgSU1YX1NDX1RIRVJNQUwNCj4gPiArCXRyaXN0YXRlICJUZW1wZXJhdHVyZSBz
ZW5zb3IgZHJpdmVyIGZvciBOWFAgaS5NWCBTb0NzIHdpdGggU3lzdGVtDQo+ID4gQ29udHJvbGxl
ciINCj4gPiArCWRlcGVuZHMgb24gKEFSQ0hfTVhDICYmIElNWF9TQ1UpIHx8IENPTVBJTEVfVEVT
VA0KPiANCj4gQ09NUElMRV9URVNUIHNlZW1zIHdvbid0IHdvcmsgYW5kIG1heSBjYXVzZSBidWls
ZCBpc3N1ZSBkdWUgdG8gdGhlDQo+IGRlcGVuZGVuY3kgb2YgSU1YX1NDVS4NCg0KSSBmb3Jnb3Qg
dGhpcyBvbmUsIHdpbGwgZml4IGl0IGluIG5leHQgdmVyc2lvbi4NCg0KPiANCj4gPiArCWRlcGVu
ZHMgb24gT0YNCj4gPiArCWhlbHANCj4gPiArCSAgU3VwcG9ydCBmb3IgVGVtcGVyYXR1cmUgTW9u
aXRvciAoVEVNUE1PTikgZm91bmQgb24gTlhQIGkuTVgNCj4gU29Dcw0KPiA+IHdpdGgNCj4gPiAr
CSAgc3lzdGVtIGNvbnRyb2xsZXIgaW5zaWRlLCBMaW51eCBrZXJuZWwgaGFzIHRvIGNvbW11bmlj
YXRlIHdpdGgNCj4gc3lzdGVtDQo+ID4gKwkgIGNvbnRyb2xsZXIgdmlhIE1VIChtZXNzYWdlIHVu
aXQpIElQQyB0byBnZXQgdGVtcGVyYXR1cmUgZnJvbQ0KPiB0aGVybWFsDQo+ID4gKwkgIHNlbnNv
ci4gSXQgc3VwcG9ydHMgb25lIGNyaXRpY2FsIHRyaXAgcG9pbnQgYW5kIG9uZQ0KPiA+ICsJICBw
YXNzaXZlIHRyaXAgcG9pbnQgZm9yIGVhY2ggdGhlcm1hbCBzZW5zb3IuDQo+ID4gKw0KPiANCj4g
Wy4uLl0NCj4gDQo+ID4gK3N0YXRpYyBpbnQgaW14X3NjX3RoZXJtYWxfZ2V0X3RlbXAodm9pZCAq
ZGF0YSwgaW50ICp0ZW1wKSB7DQo+ID4gKwlzdHJ1Y3QgaW14X3NjX21zZ19taXNjX2dldF90ZW1w
IG1zZzsNCj4gPiArCXN0cnVjdCBpbXhfc2NfcnBjX21zZyAqaGRyID0gJm1zZy5oZHI7DQo+ID4g
KwlzdHJ1Y3QgaW14X3NjX3NlbnNvciAqc2Vuc29yID0gZGF0YTsNCj4gPiArCWludCByZXQ7DQo+
ID4gKw0KPiA+ICsJbXNnLmRhdGEucmVxLnJlc291cmNlX2lkID0gc2Vuc29yLT5yZXNvdXJjZV9p
ZDsNCj4gPiArCW1zZy5kYXRhLnJlcS50eXBlID0gSU1YX1NDX0NfVEVNUDsNCj4gDQo+IElNWF9T
Q19DX1RFTVAgZHVwbGljYXRlcyB3aXRoIGVudW0gaW14X3NjX2N0cmwgd2UgYWxyZWFkeSBoYXZl
Lg0KPiBpbmNsdWRlL2xpbnV4L2Zpcm13YXJlL2lteC90eXBlcy5oDQo+IA0KPiBCdXQgSSBndWVz
cyB5b3UncmUgbm90IHdhbnQgdG8gdXNlIGEgQ1RSTCBoZXJlLg0KPiBTbyBwbGVhc2UgZml4IHRo
ZSBuYW1lIGNvbnZlbnRpb24uDQoNClVzaW5nIHRoZSBkZWZpbml0aW9uIGluIHR5cGVzLmggaXMg
Y29ycmVjdCwgSSB3aWxsIHJlbW92ZSBsb2NhbCBkZWZpbml0aW9uLg0KDQo+IA0KPiA+ICsNCj4g
PiArCWhkci0+dmVyID0gSU1YX1NDX1JQQ19WRVJTSU9OOw0KPiA+ICsJaGRyLT5zdmMgPSBJTVhf
U0NfUlBDX1NWQ19NSVNDOw0KPiA+ICsJaGRyLT5mdW5jID0gSU1YX1NDX01JU0NfRlVOQ19HRVRf
VEVNUDsNCj4gPiArCWhkci0+c2l6ZSA9IDI7DQo+ID4gKw0KPiA+ICsJcmV0ID0gaW14X3NjdV9j
YWxsX3JwYyh0aGVybWFsX2lwY19oYW5kbGUsICZtc2csIHRydWUpOw0KPiA+ICsJaWYgKHJldCkg
ew0KPiA+ICsJCXByX2VycigicmVhZCB0ZW1wIHNlbnNvciAlZCBmYWlsZWQsIHJldCAlZFxuIiwN
Cj4gPiArCQkJc2Vuc29yLT5yZXNvdXJjZV9pZCwgcmV0KTsNCj4gDQo+IFRoZSBlcnJvciBtZXNz
YWdlIGlzIG1lYW5pbmdsZXNzLg0KPiBDYW4ndCBjb252ZXJ0IHRvIGRldl9lcnI/DQoNClRoZSBl
cnJvciBtZXNzYWdlIGlzIGp1c3QgdG8gaW5kaWNhdGUgd2hldGhlciB0aGUgU0NVIGNhbGwgc3Vj
Y2VzcyBvciBOT1QsIEkgY2FuIGNvdmVydA0KdG8gZGV2X2VyciB1c2luZyBiZWxvdyBjaGFuZ2U6
DQoNCmRldl9lcnIoJnNlbnNvci0+dHpkLT5kZXZpY2UsIC4uLi4uLik7DQoNCj4gDQo+ID4gKwkJ
cmV0dXJuIHJldDsNCj4gPiArCX0NCj4gPiArDQo+ID4gKwkqdGVtcCA9IG1zZy5kYXRhLnJlc3Au
Y2Vsc2l1cyAqIDEwMDAgKyBtc2cuZGF0YS5yZXNwLnRlbnRocyAqIDEwMDsNCj4gPiArDQo+ID4g
KwlyZXR1cm4gMDsNCj4gPiArfQ0KPiA+ICsNCj4gPiArc3RhdGljIGNvbnN0IHN0cnVjdCB0aGVy
bWFsX3pvbmVfb2ZfZGV2aWNlX29wcyBpbXhfc2NfdGhlcm1hbF9vcHMgPSB7DQo+ID4gKwkuZ2V0
X3RlbXAgPSBpbXhfc2NfdGhlcm1hbF9nZXRfdGVtcCwgfTsNCj4gPiArDQo+ID4gK3N0YXRpYyBp
bnQgaW14X3NjX3RoZXJtYWxfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikgew0K
PiA+ICsJc3RydWN0IGRldmljZV9ub2RlICpucCwgKmNoaWxkOw0KPiA+ICsJaW50IHJldDsNCj4g
PiArDQo+ID4gKwlyZXQgPSBpbXhfc2N1X2dldF9oYW5kbGUoJnRoZXJtYWxfaXBjX2hhbmRsZSk7
DQo+ID4gKwlpZiAocmV0KQ0KPiA+ICsJCXJldHVybiByZXQ7DQo+ID4gKw0KPiA+ICsJbnAgPSBv
Zl9maW5kX25vZGVfYnlfbmFtZShOVUxMLCAidGhlcm1hbC16b25lcyIpOw0KPiA+ICsJaWYgKCFu
cCkNCj4gPiArCQlyZXR1cm4gLUVOT0RFVjsNCj4gPiArDQo+ID4gKwlmb3JfZWFjaF9hdmFpbGFi
bGVfY2hpbGRfb2Zfbm9kZShucCwgY2hpbGQpIHsNCj4gPiArCQlzdHJ1Y3Qgb2ZfcGhhbmRsZV9h
cmdzIHNlbnNvcl9zcGVjczsNCj4gPiArCQlzdHJ1Y3QgaW14X3NjX3NlbnNvciAqc2Vuc29yID0N
Cj4gPiArCQkJZGV2bV9remFsbG9jKCZwZGV2LT5kZXYsIHNpemVvZigqc2Vuc29yKSwNCj4gR0ZQ
X0tFUk5FTCk7DQo+IA0KPiBVc3VhbGx5IHdlIGRvIG5vdCBtaXggdGhlIGNvbXBsaWNhdGVkIGNv
ZGUgaW4gdGhlIGRlY2xhcmUgbGluZS4NCj4gWW91IGNhbiBtb3ZlIHRoZSBkZWNsYXJhdGlvbnMg
aW50byB0aGUgdG9wIGxldmVsIHRvIG1ha2UgY29kZSBtb3JlIGNsZWFuLg0KDQpPSy4gTWF5YmUg
YmVjYXVzZSBJIHJlZmVyIHRvIHRoZSBjb2RlIGRyaXZlcnMvdGhlcm1hbC9vZi10aGVybWFsLmM6
DQoNCnRoZXJtYWxfem9uZV9vZl9zZW5zb3JfcmVnaXN0ZXIoKSwNCg0KSSBjYW4gbW92ZSBpdCB0
byB0aGUgYmVnaW5uaW5nIG9mIGZ1bmN0aW9uLg0KDQo+IA0KPiA+ICsJCWlmICghc2Vuc29yKQ0K
PiA+ICsJCQlyZXR1cm4gLUVOT01FTTsNCj4gPiArDQo+ID4gKwkJcmV0ID0gdGhlcm1hbF96b25l
X29mX2dldF9zZW5zb3JfaWQoY2hpbGQsDQo+ID4gKwkJCQkJCSAgICAmc2Vuc29yX3NwZWNzLA0K
PiANCj4gSXQgbG9va3MgYSBiaXQgc3RyYW5nZSB3aHkgbmVlZCBzZW5zb3Jfc3BlY3MgYXMgeW91
IGV2ZW4gZGlkIG5vdCB1c2UgaXQuDQoNCkl0IGlzIGJlY2F1c2UgcGFyc2luZyB0aGUgcGhhbmRs
ZSBhcmd1bWVudHMgbmVlZHMgaXQsIHN1Y2ggYXMgdGhlIHRoZXJtYWxfem9uZV9vZl9zZW5zb3Jf
cmVnaXN0ZXIoKQ0KZnVuY3Rpb24gbmVlZHMgdGhpcyBwb2ludGVyIHRvIGJlIHBhc3NlZCBiYWNr
IHRvIGNoZWNrIHRoZSBlbGVtZW50cyBhcmUgdmFsaWQgb3IgTk9ULCBzbyB0aGUgQVBJIGRvZXMN
Ck5PVCBkZWZpbmUgaXQgYXMgbG9jYWwgc3RydWN0dXJlLiBUaGUgQVBJIE5PVCBqdXN0IHJldHVy
biB0aGUgc2Vuc29yIGlkLCBidXQgYWxzbyB0aGUgb2ZfcGhhbmRsZV9hcmdzIGFkZHJlc3MsDQph
bHRob3VnaCB3ZSBkbyBOT1QgbmVlZCBpdCBhdCBhbGwgaGVyZS4NCg0KVGhhbmtzLg0KQW5zb24u
IA0KDQo+IA0KPiBSZWdhcmRzDQo+IERvbmcgQWlzaGVuZw0KPiANCj4gPiArCQkJCQkJICAgICZz
ZW5zb3ItPnJlc291cmNlX2lkKTsNCj4gPiArCQlpZiAocmV0IDwgMCkgew0KPiA+ICsJCQlkZXZf
ZXJyKCZwZGV2LT5kZXYsDQo+ID4gKwkJCQkiZmFpbGVkIHRvIGdldCB2YWxpZCBzZW5zb3IgcmVz
b3VyY2UgaWQ6ICVkXG4iLA0KPiA+ICsJCQkJcmV0KTsNCj4gPiArCQkJYnJlYWs7DQo+ID4gKwkJ
fQ0KPiA+ICsNCj4gPiArCQlzZW5zb3ItPnR6ZCA9DQo+IGRldm1fdGhlcm1hbF96b25lX29mX3Nl
bnNvcl9yZWdpc3RlcigmcGRldi0+ZGV2LA0KPiA+ICsJCQkJCQkJCSAgIHNlbnNvci0NCj4gPnJl
c291cmNlX2lkLA0KPiA+ICsJCQkJCQkJCSAgIHNlbnNvciwNCj4gPiArDQo+ICZpbXhfc2NfdGhl
cm1hbF9vcHMpOw0KPiA+ICsJCWlmIChJU19FUlIoc2Vuc29yLT50emQpKSB7DQo+ID4gKwkJCWRl
dl9lcnIoJnBkZXYtPmRldiwgImZhaWxlZCB0byByZWdpc3RlciB0aGVybWFsDQo+IHpvbmVcbiIp
Ow0KPiA+ICsJCQlyZXQgPSBQVFJfRVJSKHNlbnNvci0+dHpkKTsNCj4gPiArCQkJYnJlYWs7DQo+
ID4gKwkJfQ0KPiA+ICsJfQ0KPiA+ICsNCj4gPiArCXJldHVybiByZXQ7DQo+ID4gK30NCj4gPiAr
DQo+ID4gK3N0YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIGlteF9zY190aGVybWFsX3Rh
YmxlW10gPSB7DQo+ID4gKwl7IC5jb21wYXRpYmxlID0gImZzbCxpbXgtc2MtdGhlcm1hbCIsIH0s
DQo+ID4gKwl7fQ0KPiA+ICt9Ow0KPiA+ICtNT0RVTEVfREVWSUNFX1RBQkxFKG9mLCBpbXhfc2Nf
dGhlcm1hbF90YWJsZSk7DQo+ID4gKw0KPiA+ICtzdGF0aWMgc3RydWN0IHBsYXRmb3JtX2RyaXZl
ciBpbXhfc2NfdGhlcm1hbF9kcml2ZXIgPSB7DQo+ID4gKwkJLnByb2JlID0gaW14X3NjX3RoZXJt
YWxfcHJvYmUsDQo+ID4gKwkJLmRyaXZlciA9IHsNCj4gPiArCQkJLm5hbWUgPSAiaW14LXNjLXRo
ZXJtYWwiLA0KPiA+ICsJCQkub2ZfbWF0Y2hfdGFibGUgPSBpbXhfc2NfdGhlcm1hbF90YWJsZSwN
Cj4gPiArCQl9LA0KPiA+ICt9Ow0KPiA+ICttb2R1bGVfcGxhdGZvcm1fZHJpdmVyKGlteF9zY190
aGVybWFsX2RyaXZlcik7DQo+ID4gKw0KPiA+ICtNT0RVTEVfQVVUSE9SKCJBbnNvbiBIdWFuZyA8
QW5zb24uSHVhbmdAbnhwLmNvbT4iKTsNCj4gPiArTU9EVUxFX0RFU0NSSVBUSU9OKCJUaGVybWFs
IGRyaXZlciBmb3IgTlhQIGkuTVggU29DcyB3aXRoIHN5c3RlbQ0KPiA+ICtjb250cm9sbGVyIik7
IE1PRFVMRV9MSUNFTlNFKCJHUEwgdjIiKTsNCj4gPiAtLQ0KPiA+IDIuNy40DQoNCg==
