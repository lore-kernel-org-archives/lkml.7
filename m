Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CABFC19759
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 03:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5587C20679
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 03:25:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="KbKIog0d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729641AbfHBDZC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 23:25:02 -0400
Received: from mail-eopbgr60049.outbound.protection.outlook.com ([40.107.6.49]:14581
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729012AbfHBDZB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 23:25:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c4YCgF9np39tsq1fvfuQH25gkKSty8kwG5Uy8HgYqgxTIMoPm9IPhM0SxffyiWbj25QPKuXmweX3Q8WzYoZCaGanT7yYCjry/wdZCIHz6PCHFMJklh7isZvKhxVLJ+KbQ52GSOXT+rCdjN2acxz5ctPxxm3E4TJGuFKt/qCrw0xYbhnO2GC/lkl3e+UsLyclmR1N4VedSSbBzOIFUqZ9vWL7q6MknaOQQ4dSRXMbJX2Z0qGcUnFvLmSjzSTvbnKBBKzXAr7NrDljpkc206rsq85gCjzRbef6JCg95Si+0I5hPQcRFGYwyfXJfkUZ+MR7OkLjj8QnPtPsogPJkvYmZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oiaA9NV6JrFsDl50HPScvL6VtJJVNrWzH34JU4CcAqo=;
 b=WSIsPEPXPbN5dWNMFTz3zCqd5yZD4nrzB/LSJpvCnLsNwPaBncuQLp7wnI5Se0H/2tWX5lwBSub+uds3VlvuwGLNskZpCaYmwUmG4Kt5W/P2oU3u/k9y6ihhaTOiiVU+ZTe4EESdw4sYqGcxu+FUst9tq+OD/ZLCR7sgvPmTRd0i72EQlU6oRMm9HqFUiK1wy9/r2HA/swV3Eldki4EwuSNmWTtIFEAF9EQiRtvRGssjIRmIbrySb2iMIELCndw4ur96ZdBnJmbXsxhl/jvtwx47sG0+ruE+XrKnkb2bDb735pwvqG/pXj2/LhpycmIZCqNyCeCyEWmDlyv23imW7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=nxp.com;dmarc=pass action=none header.from=nxp.com;dkim=pass
 header.d=nxp.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oiaA9NV6JrFsDl50HPScvL6VtJJVNrWzH34JU4CcAqo=;
 b=KbKIog0dXBelPoMathNmLOZDk+mP0qBghJT7BwVEMRJYDfwpSzbLHF+mLomRE1Kz2SalzpjQ/XjrBYFoMgiSbSheimwzYod81MADmfHusN9o0BmsdDy1QS0O2NXSGZ6Xt27C7mea2+WIPzSOL8NlnCexCAnIBxBnqCpHb7MXJpA=
Received: from AM0PR0402MB3570.eurprd04.prod.outlook.com (52.133.46.11) by
 AM0PR0402MB3810.eurprd04.prod.outlook.com (52.133.39.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.14; Fri, 2 Aug 2019 03:24:16 +0000
Received: from AM0PR0402MB3570.eurprd04.prod.outlook.com
 ([fe80::19ee:c210:d6cd:561f]) by AM0PR0402MB3570.eurprd04.prod.outlook.com
 ([fe80::19ee:c210:d6cd:561f%6]) with mapi id 15.20.2136.010; Fri, 2 Aug 2019
 03:24:16 +0000
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     Daniel Baluta <daniel.baluta@gmail.com>
CC:     "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [EXT] Re: [PATCH v3] mailbox: imx: add support for imx v1 mu
Thread-Topic: [EXT] Re: [PATCH v3] mailbox: imx: add support for imx v1 mu
Thread-Index: AQHVR4BTcg+IJWjJWkmRXLNrIcnNiKbmYQaAgADM5XA=
Date:   Fri, 2 Aug 2019 03:24:16 +0000
Message-ID: <AM0PR0402MB3570B875F7104A31BB2E3C518CD90@AM0PR0402MB3570.eurprd04.prod.outlook.com>
References: <1564563107-23736-1-git-send-email-hongxing.zhu@nxp.com>
 <CAEnQRZCz=fu7-2PmH+RGgnRgzeDCeR+A+wPbhjq2wQ2CZ3oQYg@mail.gmail.com>
In-Reply-To: <CAEnQRZCz=fu7-2PmH+RGgnRgzeDCeR+A+wPbhjq2wQ2CZ3oQYg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=hongxing.zhu@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d1d42969-0ca2-4feb-3f1e-08d716f8e63c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM0PR0402MB3810;
x-ms-traffictypediagnostic: AM0PR0402MB3810:
x-microsoft-antispam-prvs: <AM0PR0402MB3810023B34B6EFC188D269198CD90@AM0PR0402MB3810.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 011787B9DD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(366004)(39860400002)(346002)(376002)(396003)(51914003)(13464003)(189003)(199004)(4326008)(3846002)(76116006)(66446008)(64756008)(66556008)(66476007)(66946007)(486006)(476003)(25786009)(5024004)(2906002)(102836004)(86362001)(66066001)(6916009)(256004)(14444005)(11346002)(33656002)(6506007)(446003)(15650500001)(52536014)(55016002)(186003)(54906003)(478600001)(68736007)(76176011)(99286004)(6246003)(7696005)(53546011)(74316002)(9686003)(71200400001)(71190400001)(5660300002)(81156014)(81166006)(8936002)(316002)(305945005)(7736002)(8676002)(6436002)(53936002)(229853002)(26005)(6116002)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR0402MB3810;H:AM0PR0402MB3570.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: FU0hcxrNhnbbpuQgvFQMxZIr+EdNC/W4ZRBfZzdaqFfdSaE6KWYVmzUq5y8CmnrCrNsjkg74WRhDjKq+fy27VMuck+bmBXh0EgdT4Jm6BWfMTJjdm9/qKXrw1gp+xug7e1xpFLZqn6igaiZ4Ubp/eXmYSS8qwPOIH7lipRg/p7o5ygfSjLfSFfdxvC/wLvi/1neMrhE9DIx08I6AAvyQ46UgNZTkZyD/Oy3UuJgb28BQj84cYnfXltifjfnh/txIndC4LTGpPdqma6ttyJcWsx5uCe80Wewp/kJ18RdUxEqfqjTYBlaXb0c3MBUPnn8S2NWraqmvX+7CBCwmIz7lpRENKykNf+F6tS5tHVuMfQTPr8dXiMVqhEADfjwDP6YFirhJrUYpixSYbvdQiwT3bPVJ8N07jk2AgZJdmSGQR2U=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1d42969-0ca2-4feb-3f1e-08d716f8e63c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2019 03:24:16.5933
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hongxing.zhu@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3810
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBEYW5pZWwgQmFsdXRhIDxkYW5p
ZWwuYmFsdXRhQGdtYWlsLmNvbT4NCj4gU2VudDogMjAxOeW5tDjmnIgx5pelIDIyOjQ3DQo+IFRv
OiBSaWNoYXJkIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+DQo+IENjOiBqYXNzaXNpbmdoYnJh
ckBnbWFpbC5jb207IE9sZWtzaWogUmVtcGVsIDxvLnJlbXBlbEBwZW5ndXRyb25peC5kZT47DQo+
IEFpc2hlbmcgRG9uZyA8YWlzaGVuZy5kb25nQG54cC5jb20+OyBMaW51eCBLZXJuZWwgTWFpbGlu
ZyBMaXN0DQo+IDxsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPjsgbGludXgtYXJtLWtlcm5l
bA0KPiA8bGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnPjsgZGwtbGludXgtaW14
IDxsaW51eC1pbXhAbnhwLmNvbT4NCj4gU3ViamVjdDogW0VYVF0gUmU6IFtQQVRDSCB2M10gbWFp
bGJveDogaW14OiBhZGQgc3VwcG9ydCBmb3IgaW14IHYxIG11DQo+IA0KPiBIaSBSaWNoYXJkLA0K
PiANCj4gVGhhbmtzIGZvciB0aGUgcGF0Y2guIFBsZWFzZSBhbHdheXMgYWRkIGxpbnV4LWlteEBu
eHAuY29tIG1haWxpbmcgbGlzdCBmb3IgaW14DQo+IHJlbGF0ZWQgcGF0Y2hlcy4gSSBtaXNzZWQg
aXQuDQo+IA0KW1JpY2hhcmQgWmh1XSBPa2F5LCByb2dlciB0aGF0Lg0KDQo+IEZldyBjb21tZW50
cyBpbmxpbmUuDQo+IA0KPiBQbGVhc2UgYWxzbyB1cGRhdGUgaW4gYSBzZXBhcmF0ZSBwYXRjaCBh
dHRhY2hlZCB0byB0aGlzIHNlcmllcyB0aGUgZGV2aWN0cmVlDQo+IGJpbmRpbmdzIGRvYyBEb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWFpbGJveC9mc2wsbXUudHh0DQo+IGJ5IGFk
ZGluZyBkZXNjcmlwdGlvbiBmb3IgbXg3dWxwLW11DQo+IA0KPiA8c25pcD4NCltSaWNoYXJkIFpo
dV0gT2theSwgdGhlIGJpbmRpbmcgZG9jIHdvdWxkIGJlIGFkZGVkIGxhdGVyLg0KPiANCj4gPiBU
aGVyZSBpcyBhIHZlcnNpb24xLjAgTVUgb24gaS5NWDdVTFAgcGxhdGZvcm0uDQo+IA0KPiBzcGFj
ZSBiZXR3ZWVuIHZlcnNpb24gYW5kIDEuMA0KPiANCltSaWNoYXJkIFpodV0gT2theS4NCg0KPiA+
IE9uZSBuZXcgdmVyc2lvbiBJRCByZWdpc3RlciBpcyBhZGRlZCwgYW5kIGl0J3Mgb2Zmc2V0IGlz
IDAuDQo+ID4gVFJuIHJlZ2lzdGVycyBhcmUgZGVmaW5lZCBhdCB0aGUgb2Zmc2V0IDB4MjAgfiAw
eDJDLg0KPiA+IFJSbiByZWdpc3RlcnMgYXJlIGRlZmluZWQgYXQgdGhlIG9mZnNldCAweDQwIH4g
MHg0Qy4NCj4gPiBTUi9DUiByZWdpc3RlcnMgYXJlIGRlZmluZWQgYXQgMHg2MC8weDY0Lg0KPiA+
IEV4dGVuZCB0aGlzIGRyaXZlciB0byBzdXBwb3J0IGl0Lg0KPiANCj4gRG8geW91IGhhdmUgYSBs
aXR0bGUgYml0IG9mIGhpc3RvcnkgYWJvdXQgTVUgdmVyc2lvbmluZz8gU28gdGhlcmUgd2FzOg0K
PiANCj4gKiB2ZXJzaW9uIDAuNSBvbiBpLk1YNi1lcw0KPiAqIHZlcnNpb24gMS4wIG9uIGkuTVg3
VUxQDQo+IA0KPiBOZXh0LCBpcyB0aGlzIDEuMCBjb21wYXRiaWxlIHdpdGggaS5NWDggcmlnaHQ/
DQo+IA0KW1JpY2hhcmQgWmh1XSBPbmx5IGkuTVg3VUxQIGhhcyB0aGUgdmVyc2lvbiAxLjAgTVUu
DQppLk1YOCBoYXMgdGhlIHNhbWUgdmVyc2lvbiBNVSB0aGF0IGkuTVg2LWVzIGhhdmUuDQpJTUhP
LCBJIGRvbid0IGtub3cgd2h5IGRlc2lnbiB0ZWFtIGRvIGl0IHRoaXMgd2F5Lg0KDQo+IEFsc28s
IGNhbiB5b3UgcGxlYXNlIHJlYmFzZSB5b3VyIHBhdGNoIG9uIG15IDIgYnVnZml4ZXMgYXR0YWNo
ZWQ/DQpbUmljaGFyZCBaaHVdIE9rYXksIG5vIHByb2JsZW0uIEkgd291bGQgc2VuZCB0aGUgdjQg
dmVyc2lvbiBvdXQgbGF0ZXIgYWZ0ZXIgcmViYXNlIHlvdXIgMiBidWdmaXhlcyBwYXRjaGVzLg0K
PiANCj4gdGhhbmtzLA0KPiBEYW5pZWwuDQo=
