Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74BB4C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 12:57:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 290A62080A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 12:57:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="RPQnLjTo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730109AbfGOM5b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 08:57:31 -0400
Received: from mail-eopbgr740047.outbound.protection.outlook.com ([40.107.74.47]:34976
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730012AbfGOM5a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 08:57:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZIO1bTuU9EhR8oVycPyPt8zD6kt72JFjkxNM4B2o0aK5OUmewHCJQDWWqalu3qSZlGAqyYoDDQUq0ie5i+YmV5x0siPUygzEV52nyW6sLCtv1UtEjNJ3lM8BGhd24kjge+cqCBYi5PzR46Td/Lo9fnDziEQ/ODxnS3utOzMuCu+XuVC2qL+ljLHdmDbHxz4g0N/ATjWiyxQX8K6CS5JQqqqh2DexzML707ypBAyVLmE6TU/19E442JYNQo2K0oIR2xoB3mRAyP6lHzFiY8Xtf7iMmz8HbMUr52yKEb03/moTmU4OZ7sAFc8RnKFZp+S+xnjtGxzuD/MQzUYjghOm/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QjXjc5fLJnVa0frPm4DsebrDGhhZiFxdN/K2WeXWtyE=;
 b=OJffMsTTBNNNrIzjHgsiO/sepTAq/TA9bEglSwtzFjq6tNjf6KMM3kCMrZVJRwgzP0hbKa07xyo65CPraLlkzm+uTAxPm7KILvJg/2M91drnTDGGFvQROo9dzhtTIjjimaPmFKL53pjdCY7ptvcWxPvItGpTi3OJfmHdWt9PN9ZLjCbikR0qAWaf5VVeBSaGmVCFo2/R5O278lm4F1lF36YxhU7PrTJtpWU42wAugEs/0Ax2drd5f1PAZOnDqIxFC02I5niLS8FIH8OjAgNuv2IYl+KEJDluTdfhm2DakLxrvD7SmExQLPBHrkaTmKorkdwBxhHEeVUZxEtg+pukWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=amd.com;dmarc=pass action=none header.from=amd.com;dkim=pass
 header.d=amd.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QjXjc5fLJnVa0frPm4DsebrDGhhZiFxdN/K2WeXWtyE=;
 b=RPQnLjTogCZVo5b7N6UKdFsGsVcFMzXGvJOsgpl/FAX/XbuR8NFgNuOQHHmmdlRPOwV/9APxVBFK6WSD1aYqNbLCE42dEicwQlEpdJeWRTq2yDiZcMZGnCHtwNq62pdt7gf7S7o9na9bpoj9VCq4LnD3kKJh3OolO3HsMqMidn4=
Received: from BYAPR12MB3560.namprd12.prod.outlook.com (20.178.197.10) by
 BYAPR12MB3480.namprd12.prod.outlook.com (20.178.196.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.14; Mon, 15 Jul 2019 12:57:26 +0000
Received: from BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::b134:9f:3a1e:2b5a]) by BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::b134:9f:3a1e:2b5a%5]) with mapi id 15.20.2073.012; Mon, 15 Jul 2019
 12:57:26 +0000
From:   "Kazlauskas, Nicholas" <Nicholas.Kazlauskas@amd.com>
To:     Paul Menzel <pmenzel+amd-gfx@molgen.mpg.de>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>
CC:     "Wentland, Harry" <Harry.Wentland@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/display: Remove check for 0 kHz clock values
Thread-Topic: [PATCH] drm/amd/display: Remove check for 0 kHz clock values
Thread-Index: AQHVOvj2rMeHlBdfxk6+06vMnGXVqqbLo76A
Date:   Mon, 15 Jul 2019 12:57:25 +0000
Message-ID: <36b486b8-05e6-afb3-f544-5ec1d32a4aa2@amd.com>
References: <32619ed4-8a27-4e9c-5b99-ba826f1d163e@molgen.mpg.de>
In-Reply-To: <32619ed4-8a27-4e9c-5b99-ba826f1d163e@molgen.mpg.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YTXPR0101CA0018.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::31) To BYAPR12MB3560.namprd12.prod.outlook.com
 (2603:10b6:a03:ae::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Nicholas.Kazlauskas@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.55.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0549248a-014d-4817-7a91-08d70923fc4f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR12MB3480;
x-ms-traffictypediagnostic: BYAPR12MB3480:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <BYAPR12MB34803E0204EC9ECAF81ECA3EECCF0@BYAPR12MB3480.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1060;
x-forefront-prvs: 00997889E7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(376002)(136003)(346002)(396003)(39860400002)(199004)(189003)(76176011)(478600001)(31696002)(66066001)(14454004)(52116002)(2906002)(2616005)(476003)(68736007)(25786009)(7736002)(186003)(446003)(11346002)(386003)(53546011)(6506007)(14444005)(102836004)(256004)(966005)(36756003)(8676002)(305945005)(26005)(6116002)(6436002)(8936002)(31686004)(3846002)(6246003)(4326008)(6486002)(229853002)(486006)(81166006)(81156014)(110136005)(316002)(54906003)(86362001)(71200400001)(71190400001)(66946007)(66476007)(66556008)(64756008)(66446008)(5660300002)(99286004)(6306002)(53936002)(6636002)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB3480;H:BYAPR12MB3560.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: l0KaLbdqZvWAbmwZRFFuvAHjXE4bm4ITfxI4VdGBVs7tEp4nq512v/LYOq1P5k674hsktBAcSisNhhRjQgIvp9MVSGyK+4cOX3Z7uLO8+iC2Zyfhqe9WYwZ3q6mvsbiv9PpVkIZ8pQ98me0oIEcdHvOHuiaDUB4A2J45g4L5i6GSawi1JDSAJW/EMrRI2HaUiWd7y4EQ1TvFEr1mw752EdNoyk5Jfldnhl0eqyv9wWqGpzl9gcn4Z8wJCuMM0Cdma+XYkrCl8xoZ99tKcVJZtJbU6yJ48/A+wvmFx/bzX76HvscQOLw8R5H8ia0Ac9iTMv4W86UzjAcCCFbvh3QWVkuJoeP0SuRgDv9MbCu1uHdWsji/18K+p73CKeFwuRXVDYJ8/16wBQ5C6bWFiXkhCc7z2VpCN2uhwJED4uVbn54=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5921CEE4CCC06242B46FEB5ECE0EF139@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0549248a-014d-4817-7a91-08d70923fc4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2019 12:57:25.9975
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nkazlaus@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3480
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNy8xNS8xOSA2OjM0IEFNLCBQYXVsIE1lbnplbCB3cm90ZToNCj4gIEZyb20gMDljMTk1MjQ2
Njc1MjAzMzcyMmIwMmQ5YzdlNTUzMmUxOTgyZjZkOSBNb24gU2VwIDE3IDAwOjAwOjAwIDIwMDEN
Cj4gRnJvbTogUGF1bCBNZW56ZWwgPHBtZW56ZWxAbW9sZ2VuLm1wZy5kZT4NCj4gRGF0ZTogU2F0
LCAxMyBKdWwgMjAxOSAyMDozMzo0OSArMDIwMA0KPiANCj4gVGhpcyBiYXNpY2FsbHkgcmV2ZXJ0
cyBjb21taXQgMDA4OTM2ODFhMGZmNCAoZHJtL2FtZC9kaXNwbGF5OiBSZWplY3QNCj4gUFBMaWIg
Y2xvY2sgdmFsdWVzIGlmIHRoZXkgYXJlIGludmFsaWQpLg0KPiANCj4gMCBrSHogdmFsdWVzIGFy
ZSBhIHRoaW5nIG9uIGF0IGxlYXN0IHRoZSBib2FyZHMgYmVsb3cuDQo+IA0KPiAxLiAgTVNJIE1T
LTdBMzcvQjM1ME0gTU9SVEFSIChNUy03QTM3KSwgQklPUyAxLkcxIDA1LzE3LzIwMTgNCj4gMi4g
IE1TSSBCNDUwTSBNb3J0YXIsIDI0MDBHIG9uIDQuMTkuOA0KPiAzLiAgR2lnYWJ5dGUgVGVjaG5v
bG9neSBDby4sIEx0ZC4gWDQ3MCBBT1JVUyBVTFRSQSBHQU1JTkcvWDQ3MCBBT1JVUw0KPiAgICAg
IFVMVFJBIEdBTUlORy1DRiwgQklPUyBGMzAgMDQvMTYvMjAxOQ0KPiANCj4gQXNzZXJ0aW5nIGlu
c3RlYWQgb2YgZ2l2aW5nIGEgdXNlZnVsIGVycm9yIG1lc3NhZ2UgdG8gdGhlIHVzZXIsIHNvIHRo
ZXkNCj4gY2FuIHVuZGVyc3RhbmQgd2hhdCBpcyBnb2luZyBvbiBhbmQgaG93IHRvIHBvc3NpYmxl
IGZpeCB0aGluZ3MsIG1pZ2h0IGJlDQo+IGdvb2QgZm9yIGRldmVsb3BtZW50LCBidXQgaXMgYSBi
YWQgdXNlciBleHBlcmllbmNlLCBzbyBzaG91bGQgbm90IGJlIG9uDQo+IHByb2R1Y3Rpb24gc3lz
dGVtcy4gU28sIHJlbW92ZSB0aGUgY2hlY2sgZm9yIG5vdy4NCj4gDQo+IEZpeGVzOiBodHRwczov
L2J1Z3MuZnJlZWRlc2t0b3Aub3JnL3Nob3dfYnVnLmNnaT9pZD0xMDcyOTYNCj4gVGVzdGVkOiBN
U0kgTVMtN0EzNy9CMzUwTSBNT1JUQVIgKE1TLTdBMzcpDQo+IFNpZ25lZC1vZmYtYnk6IFBhdWwg
TWVuemVsIDxwbWVuemVsQG1vbGdlbi5tcGcuZGU+DQoNClRoZSB0d28gYXNzZXJ0aW9ucyBzaG91
bGQgcHJvYmFibHkganVzdCBiZSByZXBsYWNlZCB3aXRoIA0KRENfTE9HX0RFQlVHKC4uLikgaW5z
dGVhZCAtIHRoaXMgd2lsbCBkcm9wIHRoZSBjYWxsc3RhY2sgb24gYm9vdCBmb3IgDQpwcm9kdWN0
aW9uIHN5c3RlbXMuDQoNCkRyb3BwaW5nIHRoZSB3aG9sZSB2YWxpZGF0aW9uIGFsc28gbWVhbnMg
dGhhdCB3ZSdyZSBnb2luZyB0byBiZSB0YWtpbmcgDQp0aGUgdGFibGUgYXMtaXMgYW5kIG92ZXJy
aWRpbmcgdGhlIGRlZmF1bHRzIC0gd2hpY2ggaXNuJ3Qgc29tZXRoaW5nIHdlJ2QgDQphY3R1YWxs
eSB3YW50IHRvIGRvLg0KDQpJIGRvIHRoaW5rIGl0J3MgZmluZSB0byBqdXN0IHJlZHVjZSB0aGlz
IHRvIGEgZGVidWcgbWVzc2FnZSBzaW5jZSB5b3UnZCANCnNlZSB0aGlzIG9uIGFueSAyNDAwRy9B
TTQgKGFzIGZhciBhcyBJJ20gYXdhcmUpLCBhbmQgb25seSBmb3IgdGhlIGZDTEsgDQp0YWJsZSAo
dGhlIHRhYmxlcyBhbHdheXMgY29tZSBmcm9tIFBQTElCL1NNVSkuDQoNCk5pY2hvbGFzIEthemxh
dXNrYXMNCg0KPiAtLS0NCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY2FsY3Mv
ZGNuX2NhbGNzLmMgfCA1IC0tLS0tDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDUgZGVsZXRpb25zKC0p
DQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2NhbGNz
L2Rjbl9jYWxjcy5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2NhbGNzL2Rjbl9j
YWxjcy5jDQo+IGluZGV4IDFiNGI1MTY1N2Y1ZS4uZWRhYWFlNTc1NGZlIDEwMDY0NA0KPiAtLS0g
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY2FsY3MvZGNuX2NhbGNzLmMNCj4gKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2NhbGNzL2Rjbl9jYWxjcy5jDQo+IEBA
IC0xMzYyLDExICsxMzYyLDYgQEAgc3RhdGljIGJvb2wgdmVyaWZ5X2Nsb2NrX3ZhbHVlcyhzdHJ1
Y3QgZG1fcHBfY2xvY2tfbGV2ZWxzX3dpdGhfdm9sdGFnZSAqY2xrcykNCj4gICAJaWYgKGNsa3Mt
Pm51bV9sZXZlbHMgPT0gMCkNCj4gICAJCXJldHVybiBmYWxzZTsNCj4gICANCj4gLQlmb3IgKGkg
PSAwOyBpIDwgY2xrcy0+bnVtX2xldmVsczsgaSsrKQ0KPiAtCQkvKiBFbnN1cmUgdGhhdCB0aGUg
cmVzdWx0IGlzIHNhbmUgKi8NCj4gLQkJaWYgKGNsa3MtPmRhdGFbaV0uY2xvY2tzX2luX2toeiA9
PSAwKQ0KPiAtCQkJcmV0dXJuIGZhbHNlOw0KPiAtDQo+ICAgCXJldHVybiB0cnVlOw0KPiAgIH0N
Cj4gICANCj4gDQo+IA0KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXw0KPiBhbWQtZ2Z4IG1haWxpbmcgbGlzdA0KPiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZw0KPiBodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2FtZC1nZngNCj4gDQoNCg==
