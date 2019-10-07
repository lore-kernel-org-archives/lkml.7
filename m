Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B961C47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 18:57:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFFB5206C0
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 18:57:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="gCXJAhIi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728506AbfJGS5R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 14:57:17 -0400
Received: from mail-eopbgr750044.outbound.protection.outlook.com ([40.107.75.44]:40451
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728187AbfJGS5R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 14:57:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XdFIFYsnO6fBZqufkMrCrQgWwkvoaYaHP2XYsKCMeOjOEo9ifivbDRBrpJZQ+JyBARPHhQYiwLYngdEu5TYKUFN2hKJ3fkZMru3E/et+ML3ZCyRWMIGTPSF3my3alsaLkTfOB1w5fRjpts7y3SbxdhZQMs1IA2XJKhAadtfg3x8fuHCilFd8MK0svdR74YTvZz2iBvSu0IRrhNLTxYrufR1frSNhd6tvJtLT/b1rtqQFEUkqO7uRRMh5yN3I19B/6NfpIbYQlK7ZnikNHDSS+5w6YIl8UHJSw7K8hCiGCwoeuxaabPcoMCC0m7kexwNzaNILDh2Www93m4fjta58HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t53urfTa6DY0+QeDiLFIsdoOtQKtHDycgygWxu0GPqo=;
 b=krYC4yAmEGcKQaw87I/eDx6R8MKB0XwSri2BTo3fmS4gPpnrKpJF0mTqz4ZDQowwMep9R6+50b4c+0OduWV059paHHKo/3YFP0z1er5/n1IdFHKs3daO7sZP8NLRRb5yfp74I+l/KpZtRmhshCtOLqZA7B+FS8LJiB8tqtRafgZw1gKlCAyBJdBpmsi+B546w+J68NnRdCqDgd/VRFXZVAmSOySj2mwbc3dVDixvJAiid9vzIb7Wr7XD3CFQfnqYtXvVxvQVRKz3hKpFhcyye/rYuzZk+AWCDrHoZeFocHJrCBbLAIXZNvn8+BuwJjktLhRTyxHicAr7Y36T1zj+Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t53urfTa6DY0+QeDiLFIsdoOtQKtHDycgygWxu0GPqo=;
 b=gCXJAhIiA/1UWi+0dXcUVsCUxvwsnIEkKa3wu9eW5eqn7jr2WR+Ve9fbcvZwfN8d9ydgvmrwVWEppQQuX3Fej1U3FuAXmo2wkzi5c/js5K8gPJkETIw7+UJssj87TuSyFRVcK9aT3SIFGCE3XyhydMTOaTyadn/4zIsNMxhSbJA=
Received: from BYAPR02MB5992.namprd02.prod.outlook.com (20.179.89.80) by
 BYAPR02MB4133.namprd02.prod.outlook.com (20.176.249.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.24; Mon, 7 Oct 2019 18:57:13 +0000
Received: from BYAPR02MB5992.namprd02.prod.outlook.com
 ([fe80::dc47:4e37:db23:90e5]) by BYAPR02MB5992.namprd02.prod.outlook.com
 ([fe80::dc47:4e37:db23:90e5%3]) with mapi id 15.20.2327.025; Mon, 7 Oct 2019
 18:57:13 +0000
From:   Jolly Shah <JOLLYS@xilinx.com>
To:     Michal Simek <michals@xilinx.com>,
        Greg KH <gregkh@linuxfoundation.org>
CC:     "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "matt@codeblueprint.co.uk" <matt@codeblueprint.co.uk>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        Michal Simek <michals@xilinx.com>,
        Rajan Vaja <RAJANV@xilinx.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] dt-bindings: firmware: Add bindings for Versal
 firmware
Thread-Topic: [PATCH 1/2] dt-bindings: firmware: Add bindings for Versal
 firmware
Thread-Index: AQHVdWtshZwwGbsk+0uSb76OF2B3l6dKs9uAgAQOLICAANUGMA==
Date:   Mon, 7 Oct 2019 18:57:13 +0000
Message-ID: <BYAPR02MB59922496F636C8C89B26DA70B89B0@BYAPR02MB5992.namprd02.prod.outlook.com>
References: <1569613206-20189-1-git-send-email-jolly.shah@xilinx.com>
 <1569613206-20189-2-git-send-email-jolly.shah@xilinx.com>
 <20191004161825.GB854302@kroah.com>
 <765978d6-10b3-b0e3-cf69-3c23104a8b6f@xilinx.com>
In-Reply-To: <765978d6-10b3-b0e3-cf69-3c23104a8b6f@xilinx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=JOLLYS@xilinx.com; 
x-originating-ip: [149.199.62.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1131b65f-c058-455b-ffbc-08d74b582a6a
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: BYAPR02MB4133:|BYAPR02MB4133:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR02MB413349620A41F938A63C94D2B89B0@BYAPR02MB4133.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 01834E39B7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(366004)(346002)(396003)(136003)(39860400002)(199004)(13464003)(189003)(25786009)(7736002)(102836004)(14444005)(64756008)(66446008)(99286004)(66476007)(66556008)(66946007)(76116006)(74316002)(305945005)(33656002)(256004)(4326008)(7416002)(6246003)(316002)(53546011)(14454004)(76176011)(6506007)(229853002)(52536014)(186003)(81156014)(11346002)(6436002)(9686003)(81166006)(26005)(8676002)(54906003)(71190400001)(71200400001)(110136005)(66066001)(6116002)(478600001)(3846002)(5660300002)(2906002)(476003)(55016002)(486006)(446003)(7696005)(86362001)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB4133;H:BYAPR02MB5992.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VlDnp401fvWxNmGS7nygDFyXtyYK0IlJcaAWCr0sjVkHt3RPw4SSzYz0Xc3jUbk383uWvtH1fTPewMF82hSkViSn1wayNXJrNtq4Wcjw9le6dWm+99nic6+35yvCZGV5bC2QHpQQLtnIoZD7l3/of1R6Jymbzsw3/e13AWkEkG4JWQfUa6KVnc7LAA0+OG9ok1HLI9xmJT4daj85jKCUqPEGKciiuxJd/sT/NgPB4SG/Q6WmjOnJl5/bu2iSqH97HGYZ1pDY5oElOFDxePA4CMDxCHybJToiSZ+W6ImX2De2w5bEjYCJXIm9MHShlZJq/gVM509PctCy7xnScLfbFRg5SZ9OkI7gZu5TccWJZOGtVjoBD0xgxnOV6NjfwP3PNXPOkveZMucsTrGW1ONNOQFDIIoU6Pab70DFrWLbbvU=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1131b65f-c058-455b-ffbc-08d74b582a6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2019 18:57:13.5416
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WX3kheuQoRq0NQFb5ZHGYZMCGs9WbEhQSuUcUyLGYE/shSsvqLnpOef9/wMGysEa7PnzmqJzmbUJsIu1VPRySA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4133
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWljaGFsIGFuZCBHcmVnLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZy
b206IE1pY2hhbCBTaW1layA8bWljaGFsLnNpbWVrQHhpbGlueC5jb20+DQo+IFNlbnQ6IFN1bmRh
eSwgT2N0b2JlciAwNiwgMjAxOSAxMToxNCBQTQ0KPiBUbzogR3JlZyBLSCA8Z3JlZ2toQGxpbnV4
Zm91bmRhdGlvbi5vcmc+OyBKb2xseSBTaGFoIDxKT0xMWVNAeGlsaW54LmNvbT4NCj4gQ2M6IGFy
ZC5iaWVzaGV1dmVsQGxpbmFyby5vcmc7IG1pbmdvQGtlcm5lbC5vcmc7IG1hdHRAY29kZWJsdWVw
cmludC5jby51azsNCj4gc3VkZWVwLmhvbGxhQGFybS5jb207IGhrYWxsd2VpdDFAZ21haWwuY29t
OyBrZWVzY29va0BjaHJvbWl1bS5vcmc7DQo+IGRtaXRyeS50b3Jva2hvdkBnbWFpbC5jb207IE1p
Y2hhbCBTaW1layA8bWljaGFsc0B4aWxpbnguY29tPjsgUmFqYW4gVmFqYQ0KPiA8UkFKQU5WQHhp
bGlueC5jb20+OyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LQ0K
PiBrZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMS8yXSBkdC1i
aW5kaW5nczogZmlybXdhcmU6IEFkZCBiaW5kaW5ncyBmb3IgVmVyc2FsIGZpcm13YXJlDQo+IA0K
PiBPbiAwNC4gMTAuIDE5IDE4OjE4LCBHcmVnIEtIIHdyb3RlOg0KPiA+IE9uIEZyaSwgU2VwIDI3
LCAyMDE5IGF0IDEyOjQwOjA1UE0gLTA3MDAsIEpvbGx5IFNoYWggd3JvdGU6DQo+ID4+IFp5bnFN
UCBmaXJtd2FyZSBkcml2ZXIgY2FuIGJlIHVzZWQgZm9yIHZlcnNhbCBhbHNvLg0KPiA+PiBBZGQg
dmVyc2FsIGNvbXBhdGlibGUgc3RyaW5nIHRvIHp5bnFtcCBmaXJtd2FyZSBkcml2ZXINCj4gPj4g
ZG9jLg0KPiA+Pg0KPiA+PiBTaWduZWQtb2ZmLWJ5OiBKb2xseSBTaGFoIDxqb2xseS5zaGFoQHhp
bGlueC5jb20+DQo+ID4+IC0tLQ0KPiA+PiAgLi4uL2JpbmRpbmdzL2Zpcm13YXJlL3hpbGlueC94
bG54LHp5bnFtcC1maXJtd2FyZS50eHQgICAgfCAxNg0KPiArKysrKysrKysrKysrKystDQo+ID4+
ICAxIGZpbGUgY2hhbmdlZCwgMTUgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+Pg0K
PiA+PiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Zpcm13
YXJlL3hpbGlueC94bG54LHp5bnFtcC0NCj4gZmlybXdhcmUudHh0DQo+IGIvRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Zpcm13YXJlL3hpbGlueC94bG54LHp5bnFtcC0NCj4gZmly
bXdhcmUudHh0DQo+ID4+IGluZGV4IGE0ZmUxMzYuLjE4YzNhZWEgMTAwNjQ0DQo+ID4+IC0tLSBh
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9maXJtd2FyZS94aWxpbngveGxueCx6
eW5xbXAtDQo+IGZpcm13YXJlLnR4dA0KPiA+PiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvZmlybXdhcmUveGlsaW54L3hsbngsenlucW1wLQ0KPiBmaXJtd2FyZS50eHQN
Cj4gPj4gQEAgLTExLDcgKzExLDkgQEAgcG93ZXIgbWFuYWdlbWVudCBzZXJ2aWNlLCBGUEdBIHNl
cnZpY2UgYW5kIG90aGVyDQo+IHBsYXRmb3JtIG1hbmFnZW1lbnQNCj4gPj4gIHNlcnZpY2VzLg0K
PiA+Pg0KPiA+PiAgUmVxdWlyZWQgcHJvcGVydGllczoNCj4gPj4gLSAtIGNvbXBhdGlibGU6CU11
c3QgY29udGFpbjoJInhsbngsenlucW1wLWZpcm13YXJlIg0KPiA+PiArIC0gY29tcGF0aWJsZToJ
TXVzdCBjb250YWluIGFueSBvZiBiZWxvdzoNCj4gPj4gKwkJInhsbngsenlucW1wLWZpcm13YXJl
IiBmb3IgWnlucSBVbHRyYXNjYWxlKyBNUFNvQw0KPiA+PiArCQkieGxueCx2ZXJzYWwtZmlybXdh
cmUiIGZvciBWZXJzYWwNCj4gPj4gICAtIG1ldGhvZDoJVGhlIG1ldGhvZCBvZiBjYWxsaW5nIHRo
ZSBQTS1BUEkgZmlybXdhcmUgbGF5ZXIuDQo+ID4+ICAJCVBlcm1pdHRlZCB2YWx1ZXMgYXJlOg0K
PiA+PiAgCQkgIC0gInNtYyIgOiBTTUMgIzAsIGZvbGxvd2luZyB0aGUgU01DQ0MNCj4gPj4gQEAg
LTIxLDYgKzIzLDggQEAgUmVxdWlyZWQgcHJvcGVydGllczoNCj4gPj4gIEV4YW1wbGUNCj4gPj4g
IC0tLS0tLS0NCj4gPj4NCj4gPj4gK1p5bnEgVWx0cmFzY2FsZSsgTVBTb0MNCj4gPj4gKy0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0NCj4gPj4gIGZpcm13YXJlIHsNCj4gPj4gIAl6eW5xbXBfZmlybXdh
cmU6IHp5bnFtcC1maXJtd2FyZSB7DQo+ID4+ICAJCWNvbXBhdGlibGUgPSAieGxueCx6eW5xbXAt
ZmlybXdhcmUiOw0KPiA+PiBAQCAtMjgsMyArMzIsMTMgQEAgZmlybXdhcmUgew0KPiA+PiAgCQku
Li4NCj4gPj4gIAl9Ow0KPiA+PiAgfTsNCj4gPj4gKw0KPiA+PiArVmVyc2FsDQo+ID4+ICstLS0t
LS0NCj4gPj4gK2Zpcm13YXJlIHsNCj4gPj4gKwl2ZXJzYWxfZmlybXdhcmU6IHZlcnNhbC1maXJt
d2FyZSB7DQo+ID4+ICsJCWNvbXBhdGlibGUgPSAieGxueCx2ZXJzYWwtZmlybXdhcmUiOw0KPiA+
PiArCQltZXRob2QgPSAic21jIjsNCj4gPj4gKwkJLi4uDQo+ID4+ICsJfTsNCj4gPj4gK307DQo+
ID4+IC0tDQo+ID4+IDIuNy40DQo+ID4+DQo+ID4NCj4gPg0KPiA+IEZvciBuZXcgZHQgYmluZGlu
Z3MsIGRvbid0IHlvdSBoYXZlIHRvIGNjOiB0aGUgZHQgbWFpbnRhaW5lcnMgYW5kDQo+ID4gbWFp
bGluZyBsaXN0PyAgSSBjYW4ndCB0YWtlIHRoZSBwYXRjaCB1bnRpbCBJIGdldCBhbiBhY2sgZnJv
bSB0aGVtLg0KPiANCj4gWWVzIGR0IGd1eXMgc2hvdWxkIGJlIGluIENDIGFuZCBub3JtYWxseSBJ
IGFtIHRha2luZyB0aGlzIHZpYSBBUk0gc29jIHRyZWUuDQo+IA0KPiBKb2xseTogUGxlYXNlIHJl
c2VuZA0KPiANCg0KU29ycnkgbWlzc2VkIGl0IGVhcmxpZXIuIFNlbnQgdjIgaW5jbHVkaW5nIERU
IG1haW50YWluZXJzLg0KDQpUaGFua3MsDQpKb2xseSBTaGFoDQoNCj4gVGhhbmtzLA0KPiBNaWNo
YWwNCg==
