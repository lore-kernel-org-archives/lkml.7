Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D1C0C47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 09:09:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF3AB2133F
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 09:09:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="SPla2cCm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729699AbfJIJJx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 05:09:53 -0400
Received: from mail-eopbgr60087.outbound.protection.outlook.com ([40.107.6.87]:17796
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725914AbfJIJJx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 05:09:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aP5GCm2KN1AsnB+qNkptNGygmZ0JbpVIlb4ybKscSNguK7gAKNn9HRcmlhDyMvpkP7MTDwGc2V1Qo1KkD1p84qMGf2oHk6g6VEZ3Q8l0Z03ygVm85ZVCmgI2TA+Y3uphhPYVeQCXIQCwYFO22v4340hRJmLXSLGR0XsNlvDfsKE4H1JCAPIniumiwWTvKnKFEHpL6tDjpi9sNNj4NDO7EEUYbzc2Tn7Q/Jfx1R9/kre7/4iakUoJImzNc0fGfPxwgTSMDSTV2noDNJTWikCMRFPFJjRUfeIUlL6epAHA0ctQvT+uc1+acNJLOWXzMsbG9mkOK9UJRl6Kh0qMy5qDJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cQnoNyQDLHB0rGETJXVu0dgZDOUaGkIPw/+dFDbVTYU=;
 b=XhmrrEm0I44Y7esg56Z/B38OY+TA2FPNP6v9WEdskEi9V0KD0U1f2V8O9rvHp2FeJpB8LJ7ou6kssVLGvMailZll02CTla1DyJ1PoEj9Q0bLnVFs66hQ0d0LKPukymg01gCdQo05WxwtCSDd//0y/cefhqwdDa9dkEtRCvHdnvaXWmL2YdODVCBVub47e92lWW7Veo+Xlg8qHMMx7OUj4kNPUfONEX8I3ECdaG8AW0QtWLW2474cnEuwNomv+gc7wAnZDFJYZFhlClw7ZwQBDEEY6mlPcEnrIMiF9JWu8y34RHodABA50C9pgzSUiACuPhQCGfO3FasVC/fq8Baxgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cQnoNyQDLHB0rGETJXVu0dgZDOUaGkIPw/+dFDbVTYU=;
 b=SPla2cCmrwB2l5Pb5jtSAGO9/64tC6uLUJFB+m4P+WLGkRkQLm9O4Vx4Upc9vNjggZDlcn17sMXgLv5UYz8KlmCZY7MHLPCsjMpYIsAGfutSJ+B3Y9KaJhCd9TkI7GKw/a+4EhqsbUtpIw3OljT+WlLYycmvlNiXNuBWcLoLbT8=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3785.eurprd04.prod.outlook.com (52.134.71.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.23; Wed, 9 Oct 2019 09:09:48 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::d469:ad51:2bec:19f0]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::d469:ad51:2bec:19f0%6]) with mapi id 15.20.2347.016; Wed, 9 Oct 2019
 09:09:48 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Marco Felsch <m.felsch@pengutronix.de>
CC:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V2] firmware: imx: Skip return value check for some
 special SCU firmware APIs
Thread-Topic: [PATCH V2] firmware: imx: Skip return value check for some
 special SCU firmware APIs
Thread-Index: AQHVfK0Yhw8grvoW2E2n3r70yUmdBKdSBrWAgAAAKnA=
Date:   Wed, 9 Oct 2019 09:09:48 +0000
Message-ID: <DB3PR0402MB3916595DFC84910873FBA91AF5950@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1570410959-32563-1-git-send-email-Anson.Huang@nxp.com>
 <20191009090043.4yq4l7iac3zgytnp@pengutronix.de>
In-Reply-To: <20191009090043.4yq4l7iac3zgytnp@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bcaaae6d-87b5-43ff-08ae-08d74c986f44
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: DB3PR0402MB3785:|DB3PR0402MB3785:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB378541D74BAA42B28A87FF49F5950@DB3PR0402MB3785.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 018577E36E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(136003)(346002)(376002)(366004)(396003)(199004)(189003)(6916009)(6116002)(64756008)(256004)(26005)(74316002)(99286004)(66946007)(3846002)(186003)(71200400001)(305945005)(102836004)(7696005)(71190400001)(76176011)(6506007)(53546011)(66556008)(66476007)(66446008)(86362001)(81166006)(44832011)(316002)(8676002)(54906003)(14444005)(81156014)(476003)(446003)(11346002)(76116006)(7736002)(486006)(8936002)(25786009)(6246003)(478600001)(966005)(4326008)(229853002)(6436002)(66066001)(55016002)(9686003)(45080400002)(33656002)(6306002)(5660300002)(14454004)(52536014)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3785;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zIXJpQSjq4xgNdVyaROOg7g5/lxIiDWnhH82PrNNwZIGoX5ZR3PkIUnCvbIc9rsur8WZvf9ER9najBHWtZvCZhATS002lS3Ty/ZAwnCVwRISRedvC9O+Mk9R1Ezvp5Kj/0n+0rAxFhjmEuDnbZLvRnwubtMfBz5B3jXfZvEseJsOU3Xew3FAfs/It0EsdgAx+rfFHJTNKpoi4lRF/UmI+JI/tdeuWZI0Fhk/ZsyFvtunbFf3g/pl+w3LRr8omwGB3SAKpXnrNZB0aO0k5CxRpeyfogB4FsNXfv6/ZJ5YZDPKFZf1QiA3PSZzg1NKQnHkVD023CusZuDW6p6GSaZA4LKWenHmdQPNb/1qixJ6yJ7fM5rIvHcD+Sv4twCOSMV4JrQ38DyTMv5sW3BkYQDnYbNsNS6qWoz8auJn45mZOX0=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcaaae6d-87b5-43ff-08ae-08d74c986f44
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2019 09:09:48.1264
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fOQwInaRTlbWdukXLqSXQhgCeof7NucaJxE30xZefZzDgCTrf2B3crf8n6gIlF8pX83A+CcAgGr9C1XuNge8+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3785
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIE1hcmNvDQoNCj4gT24gMTktMTAtMDcgMDk6MTUsIEFuc29uIEh1YW5nIHdyb3RlOg0KPiA+
IFRoZSBTQ1UgZmlybXdhcmUgZG9lcyBOT1QgYWx3YXlzIGhhdmUgcmV0dXJuIHZhbHVlIHN0b3Jl
ZCBpbiBtZXNzYWdlDQo+ID4gaGVhZGVyJ3MgZnVuY3Rpb24gZWxlbWVudCBldmVuIHRoZSBBUEkg
aGFzIHJlc3BvbnNlIGRhdGEsIHRob3NlDQo+ID4gc3BlY2lhbCBBUElzIGFyZSBkZWZpbmVkIGFz
IHZvaWQgZnVuY3Rpb24gaW4gU0NVIGZpcm13YXJlLCBzbyB0aGV5DQo+ID4gc2hvdWxkIGJlIHRy
ZWF0ZWQgYXMgcmV0dXJuIHN1Y2Nlc3MgYWx3YXlzLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTog
QW5zb24gSHVhbmcgPEFuc29uLkh1YW5nQG54cC5jb20+DQo+ID4gLS0tDQo+ID4gQ2hhbmdlcyBz
aW5jZSBWMToNCj4gPiAJLSBVc2UgZGlyZWN0IEFQSSBjaGVjayBpbnN0ZWFkIG9mIGNhbGxpbmcg
YW5vdGhlciBmdW5jdGlvbiB0byBjaGVjay4NCj4gPiAJLSBUaGlzIHBhdGNoIGlzIGJhc2VkIG9u
DQo+ID4gaHR0cHM6Ly9ldXIwMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJs
PWh0dHBzJTNBJTJGJTJGcGF0Yw0KPiA+DQo+IGh3b3JrLmtlcm5lbC5vcmclMkZwYXRjaCUyRjEx
MTI5NTUzJTJGJmFtcDtkYXRhPTAyJTdDMDElN0NhbnNvbi4NCj4gaHVhbmclDQo+ID4NCj4gNDBu
eHAuY29tJTdDYmVmZDI4NDlhMTI0NDYyY2FhNGEwOGQ3NGM5NzJkYzklN0M2ODZlYTFkM2JjMmI0
YzZmDQo+IGE5MmNkOTkNCj4gPg0KPiBjNWMzMDE2MzUlN0MwJTdDMCU3QzYzNzA2MjA4NDUwNjg4
OTQzMSZhbXA7c2RhdGE9N2ZXOGhaQjRBYVVLDQo+IDlRVEtUSlFSNw0KPiA+IEx1VjJuR282ZSUy
RnFiJTJGcW1uNHlrcXVrJTNEJmFtcDtyZXNlcnZlZD0wDQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMv
ZmlybXdhcmUvaW14L2lteC1zY3UuYyB8IDE2ICsrKysrKysrKysrKysrKy0NCj4gPiAgMSBmaWxl
IGNoYW5nZWQsIDE1IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPg0KPiA+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2Zpcm13YXJlL2lteC9pbXgtc2N1LmMNCj4gPiBiL2RyaXZlcnMvZmly
bXdhcmUvaW14L2lteC1zY3UuYyBpbmRleCA4NjliZTdhLi4wM2I0M2I3IDEwMDY0NA0KPiA+IC0t
LSBhL2RyaXZlcnMvZmlybXdhcmUvaW14L2lteC1zY3UuYw0KPiA+ICsrKyBiL2RyaXZlcnMvZmly
bXdhcmUvaW14L2lteC1zY3UuYw0KPiA+IEBAIC0xNjIsNiArMTYyLDcgQEAgc3RhdGljIGludCBp
bXhfc2N1X2lwY193cml0ZShzdHJ1Y3QgaW14X3NjX2lwYw0KPiAqc2NfaXBjLCB2b2lkICptc2cp
DQo+ID4gICAqLw0KPiA+ICBpbnQgaW14X3NjdV9jYWxsX3JwYyhzdHJ1Y3QgaW14X3NjX2lwYyAq
c2NfaXBjLCB2b2lkICptc2csIGJvb2wNCj4gPiBoYXZlX3Jlc3ApICB7DQo+ID4gKwl1aW50OF90
IHNhdmVkX3N2Yywgc2F2ZWRfZnVuYzsNCj4gPiAgCXN0cnVjdCBpbXhfc2NfcnBjX21zZyAqaGRy
Ow0KPiA+ICAJaW50IHJldDsNCj4gPg0KPiA+IEBAIC0xNzEsOCArMTcyLDExIEBAIGludCBpbXhf
c2N1X2NhbGxfcnBjKHN0cnVjdCBpbXhfc2NfaXBjICpzY19pcGMsDQo+IHZvaWQgKm1zZywgYm9v
bCBoYXZlX3Jlc3ApDQo+ID4gIAltdXRleF9sb2NrKCZzY19pcGMtPmxvY2spOw0KPiA+ICAJcmVp
bml0X2NvbXBsZXRpb24oJnNjX2lwYy0+ZG9uZSk7DQo+ID4NCj4gPiAtCWlmIChoYXZlX3Jlc3Ap
DQo+ID4gKwlpZiAoaGF2ZV9yZXNwKSB7DQo+ID4gIAkJc2NfaXBjLT5tc2cgPSBtc2c7DQo+ID4g
KwkJc2F2ZWRfc3ZjID0gKChzdHJ1Y3QgaW14X3NjX3JwY19tc2cgKiltc2cpLT5zdmM7DQo+IA0K
PiBXaHkgZG8gd2UgbmVlZCB0byBjaGVjayB0aGUgc3ZjIHRvbz8NCg0KSXQgaXMgYmVjYXVzZSB0
aGUgU0NVIGZpcm13YXJlIEFQSSBoYXMgbWFueSBkaWZmZXJlbnQgY2F0ZWdvcnkgY2FsbGVkIFNW
QywgZWFjaCBjYXRlZ29yeSBoYXMNCm1hbnkgZGlmZmVyZW50IGZ1bmN0aW9uLCBhbmQgdGhlIGZ1
bmN0aW9uIHZhbHVlIGNvdWxkIGJlIHNhbWUgaW4gZWFjaCBjYXRlZ29yeSwNCmZvciBleGFtcGxl
LCB0aGVyZSBhcmUgSVJRLCBQTSwgTUlTQyBldGMuIFNWQyBjYXRlZ29yeSwgYW5kIGVhY2ggb2Yg
dGhlbSBjb3VsZCBoYXZlIGZ1bmN0aW9uDQp0eXBlIGRlZmluZWQgYXMgMCwgMSwgMiAuLi4uIFRo
YXQgaXMgd2h5IEkgbmVlZCB0byBzYXZlIGJvdGggU1ZDIGFuZCBGVU5DIHRvIGlkZW50aWZ5IHRo
ZSBTQ1UgRlcNCkFQSS4gU2VlIGJlbG93OiANCg0KUE0gU1ZDOg0KI2RlZmluZSBQTV9GVU5DX1NF
VF9QQVJUSVRJT05fUE9XRVJfTU9ERSAxVSAvKiBJbmRleCBmb3IgcG1fc2V0X3BhcnRpdGlvbl9w
b3dlcl9tb2RlKCkgUlBDIGNhbGwgKi8NCiNkZWZpbmUgUE1fRlVOQ19HRVRfU1lTX1BPV0VSX01P
REUgMlUgLyogSW5kZXggZm9yIHBtX2dldF9zeXNfcG93ZXJfbW9kZSgpIFJQQyBjYWxsICovDQoj
ZGVmaW5lIFBNX0ZVTkNfU0VUX1JFU09VUkNFX1BPV0VSX01PREUgM1UgLyogSW5kZXggZm9yIHBt
X3NldF9yZXNvdXJjZV9wb3dlcl9tb2RlKCkgUlBDIGNhbGwgKi8NCg0KTUlTQyBTVkM6DQojZGVm
aW5lIE1JU0NfRlVOQ19TRVRfQ09OVFJPTCAxVSAvKiBJbmRleCBmb3IgbWlzY19zZXRfY29udHJv
bCgpIFJQQyBjYWxsICovDQojZGVmaW5lIE1JU0NfRlVOQ19HRVRfQ09OVFJPTCAyVSAvKiBJbmRl
eCBmb3IgbWlzY19nZXRfY29udHJvbCgpIFJQQyBjYWxsICovDQojZGVmaW5lIE1JU0NfRlVOQ19T
RVRfTUFYX0RNQV9HUk9VUCA0VSAvKiBJbmRleCBmb3IgbWlzY19zZXRfbWF4X2RtYV9ncm91cCgp
IFJQQyBjYWxsICovDQoNCj4gDQo+ID4gKwkJc2F2ZWRfZnVuYyA9ICgoc3RydWN0IGlteF9zY19y
cGNfbXNnICopbXNnKS0+ZnVuYzsNCj4gDQo+IE5pdHBpY2ssIHNob3VsZCB3ZSBjYWxsIGl0IHJl
cXVlc3RlZF9mdW5jL3JlcV9mdW5jPw0KDQpPSywgSSB3aWxsIGNoYW5nZSB0aGVtIElmIEkgaGF2
ZSB0byBzZW50IG91dCBhIG5ldyB2ZXJzaW9uLCBvdGhlcndpc2UsIEkgdGhpbmsgdGhlIHNhdmVk
X2Z1bmMgYW5kIHNhdmVkX3N2Yw0Kc2hvdWxkIGFsc28gYmUgZmluZS4NCg0KVGhhbmtzLA0KQW5z
b24NCg==
