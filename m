Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 028BAC31E40
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 01:13:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4FC5214C6
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 01:13:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ersQ3ADq";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="iRO2sZuM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727800AbfHGBNT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 21:13:19 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:61929 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727527AbfHGBNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 21:13:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1565140399; x=1596676399;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=y9DXexklj4DH4N+MEDF/aqzOQagA02It45aZlweZBWg=;
  b=ersQ3ADqU4+ymUABgArAfifBrlUVDZcetDCl3AngErK5g2FoIzm2+nX6
   SjnXeYmMuBGKucZQ3+/s5lhfPQCKk8LYTDLdNr5evAx01kpWNINY9Dykb
   lHg2IoVbdONTjElRqcZHHsxbZzWIFpbMekR3iQyRHobajIGzhnKg8nK7P
   GZr7tA3MYs1STVpIKZYrZWnD59HXRRlodDoVxnICrXSYfKKvR3u57xopM
   pL3B/RLghBFG9wvS2Odgcd6P5tpJ8wIOrcVeqf0MdRmvVMTWxI7B7AJz2
   MngTFHq4aUFURgpLrWpC3DpKFX9FH9vwnujnQIRCzEoUL9g5Lh3P/jQQr
   A==;
IronPort-SDR: Xkm9nTVt77sCI4yrw2HiO6CT1C7V1TADxyR9uBoHtNCWQnTOobz7bRVMARW79FA3ukkezVevOC
 CzhAGkrJKmhnC+22b5PnJPOcZkzOTZanN6YgCVrAmkZ2ND8y6OYSGUiviwLgJGBxDG7W8zbUyP
 7UMFwZCd1io+3yZaW4Co5+XIMo/5JhwfORlzYXYFEShiL+xwY7fT/c7nKWOKAuqTFyhdP1KrrC
 LMU3VcqPyLMw/Xvgb6L7vljrIkiXBmgHa9azt1lnMdkXriWctBFgfHP7jEKhcGtdQH5PsfbgEr
 Puo=
X-IronPort-AV: E=Sophos;i="5.64,353,1559491200"; 
   d="scan'208";a="115200113"
Received: from mail-by2nam01lp2050.outbound.protection.outlook.com (HELO NAM01-BY2-obe.outbound.protection.outlook.com) ([104.47.34.50])
  by ob1.hgst.iphmx.com with ESMTP; 07 Aug 2019 09:13:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gxPOTjKZwsZ+Y0C2qDM2h3CNM0nJjMa2J3c5guiAKcnSiflMsBBRQpQS8/JrqnhyfC3o5u6gKLIzqqWzCb7Sc5EjH98RB+3PLgXvamxixpwC6t4PEHmeF6tyE7K9MXwyJrOtmKw3LLxGCwvogNmKTOl68lPiEwNuRBTuefotLZSZ8o1QKqk0+nBMPCQj/rXMu2X+wA6fk1EYSFK27gr0bw2fDRiIH05gGh0S8rPKF1QkJXAJMHFZP1A72QmTR1hErAeB2ey0z3CSzd4wWFosIWdWeqPaW4qXHLgLyx1hUB+Jw7bJrvqQrAC7OaLf4/8BXWF2NN+SXgdgXm9+g9d/jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y9DXexklj4DH4N+MEDF/aqzOQagA02It45aZlweZBWg=;
 b=Jt32pD8CQ1o95QcHqp1OUrV1PBxiw9znUf84VaXaVV0CtQJk/NQKhbQq6Inu/OlH05x/HVlReuxYFlab/UgGCo+N60rgvsLE7Kr0Ox2S5fVCB3AluF6mVyDsE5ZYxZ8hqQLWqZ7xf3M+OONJBwA80jcOtHtckFgWwhkgVQ5k7FVqP85Eo1aD+Oeaiuv1xHdX3wUOeMQU6AMh2IwTFiqcziDtLXl3VaG8lFrmvIGG5kojM5NmHqF8asuplJ5Hs42a5RHaslMFgIBTaEuIs/+HicgzLGRWr9heGicSSGgcSaBYnihwC5qE0zzMBQ2yAdSSksrRvFIXwtZzvaXWBQccow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=wdc.com;dmarc=pass action=none header.from=wdc.com;dkim=pass
 header.d=wdc.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y9DXexklj4DH4N+MEDF/aqzOQagA02It45aZlweZBWg=;
 b=iRO2sZuMQ+0virrKO1riY0Pdcx/Q/qeKPd+wUswxZZNiGgou5dmxDRb3/dcao+BMYoyPDJk9twrUFJRUXPNvuF0dzSShfhAvLehEXdFh1DVtKd2bZt6PQSh9AfHCvvAZKJFZUYT75UliWzjk/p05O/IMFYGRQq9gy+VKSOf2qDM=
Received: from BYAPR04MB3782.namprd04.prod.outlook.com (52.135.214.142) by
 BYAPR04MB6104.namprd04.prod.outlook.com (20.178.234.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.15; Wed, 7 Aug 2019 01:13:16 +0000
Received: from BYAPR04MB3782.namprd04.prod.outlook.com
 ([fe80::ac9a:967e:70a5:e926]) by BYAPR04MB3782.namprd04.prod.outlook.com
 ([fe80::ac9a:967e:70a5:e926%7]) with mapi id 15.20.2115.005; Wed, 7 Aug 2019
 01:13:16 +0000
From:   Atish Patra <Atish.Patra@wdc.com>
To:     "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>
CC:     "info@metux.net" <info@metux.net>,
        "allison@lohutok.net" <allison@lohutok.net>,
        "palmer@sifive.com" <palmer@sifive.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        Anup Patel <Anup.Patel@wdc.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "johan@kernel.org" <johan@kernel.org>,
        "tiny.windzz@gmail.com" <tiny.windzz@gmail.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "gary@garyguo.net" <gary@garyguo.net>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v3 3/5] RISC-V: Fix unsupported isa string info.
Thread-Topic: [PATCH v3 3/5] RISC-V: Fix unsupported isa string info.
Thread-Index: AQHVSARDLwisRSZSxEGpcN8B9TVet6buzP8AgAAdjQA=
Date:   Wed, 7 Aug 2019 01:13:16 +0000
Message-ID: <1e23ef1face9d323fda4b756811f922caa5f7689.camel@wdc.com>
References: <20190801005843.10343-1-atish.patra@wdc.com>
         <20190801005843.10343-4-atish.patra@wdc.com>
         <alpine.DEB.2.21.9999.1908061625190.13971@viisi.sifive.com>
In-Reply-To: <alpine.DEB.2.21.9999.1908061625190.13971@viisi.sifive.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Atish.Patra@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4acb7e1e-8db5-4781-da02-08d71ad46d76
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB6104;
x-ms-traffictypediagnostic: BYAPR04MB6104:
x-microsoft-antispam-prvs: <BYAPR04MB6104FEFFDBBF1163CF9BFA58FAD40@BYAPR04MB6104.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 01221E3973
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(346002)(376002)(396003)(39860400002)(366004)(189003)(199004)(6916009)(99286004)(11346002)(446003)(476003)(2616005)(71190400001)(71200400001)(486006)(68736007)(316002)(7736002)(54906003)(2906002)(305945005)(14454004)(5660300002)(3846002)(6116002)(8936002)(8676002)(81156014)(7416002)(14444005)(2351001)(81166006)(256004)(118296001)(76116006)(4326008)(64756008)(66446008)(66556008)(66476007)(66946007)(86362001)(25786009)(66066001)(2501003)(478600001)(36756003)(186003)(53936002)(102836004)(6506007)(5640700003)(229853002)(6436002)(76176011)(6486002)(6512007)(26005)(6246003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB6104;H:BYAPR04MB3782.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 8SQSCmcA9mINJrSVu3q9pESjf/zLo3OKKGxeRB3jL6mCslme3IP8REUJBiM+Bl9TQgA9SrBYxetGHIo9LXBm/sr/iyMarJii6tik7120g3wvGD/fs3mS3PX1caA3XWbF10CfjAtHluf51RB5awaCugMraoPpi2e+LuSbs5kT0lhAl+Mjj8xYsh9HDcNE8GsgpEtQm9PtNMOsXM54Bylgde8I1WGaYVX1g7D0eQQWsSf5JGSKJL07N5Wpn83SwlBOP2Ew7Z3ZY37O10V1l+mkKS2+b/B6mFurNa9jDxtrmud6LgfH+3H8snsveL/HI8HKnRvCW4nNybmmKXh8cW1ETefTwweM+kXjZ8/7SzFOp9dbu3mzXHu7PspgPGbrSGvBwmx2R5e0Bc0es53OgKa6yLCm30dyqwZpiAztuIhMfsw=
Content-Type: text/plain; charset="utf-8"
Content-ID: <491CCE35E6E1AF498E1AE2926EFFB451@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4acb7e1e-8db5-4781-da02-08d71ad46d76
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2019 01:13:16.6050
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Atish.Patra@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB6104
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE5LTA4LTA2IGF0IDE2OjI3IC0wNzAwLCBQYXVsIFdhbG1zbGV5IHdyb3RlOg0K
PiBPbiBXZWQsIDMxIEp1bCAyMDE5LCBBdGlzaCBQYXRyYSB3cm90ZToNCj4gDQo+ID4gQ3VycmVu
dGx5LCBrZXJuZWwgcHJpbnRzIGEgaW5mbyB3YXJuaW5nIGlmIGFueSBvZiB0aGUgZXh0ZW5zaW9u
cw0KPiA+IGZyb20gIm1hZmRjc3UiIGlzIG1pc3NpbmcgaW4gZGV2aWNlIHRyZWUuIFRoaXMgaXMg
bm90IGVudGlyZWx5DQo+ID4gY29ycmVjdCBhcyBMaW51eCBjYW4gYm9vdCB3aXRoICJmIG9yIGQi
IGV4dGVuc2lvbnMgaWYga2VybmVsIGlzDQo+ID4gY29uZmlndXJlZCBhY2NvcmRpbmdseS4gTW9y
ZW92ZXIsIGl0IHdpbGwgY29udGludWUgdG8gcHJpbnQgdGhlDQo+ID4gaW5mbyBzdHJpbmcgZm9y
IGZ1dHVyZSBleHRlbnNpb25zIHN1Y2ggYXMgaHlwZXJ2aXNvciBhcyB3ZWxsIHdoaWNoDQo+ID4g
aXMgbWlzbGVhZGluZy4gL3Byb2MvY3B1aW5mbyBhbHNvIGRvZXNuJ3QgcHJpbnQgYW55IG90aGVy
DQo+ID4gZXh0ZW5zaW9ucw0KPiA+IGV4Y2VwdCAibWFmZGNzdSIuDQo+ID4gDQo+ID4gTWFrZSBz
dXJlIHRoYXQgaW5mbyBsb2cgaXMgb25seSBwcmludGVkIG9ubHkgaWYga2VybmVsIGlzDQo+ID4g
Y29uZmlndXJlZA0KPiA+IHRvIGhhdmUgYW55IG1hbmRhdG9yeSBleHRlbnNpb25zIGJ1dCBkZXZp
Y2UgdHJlZSBkb2Vzbid0IGRlc2NyaWJlDQo+ID4gaXQuDQo+ID4gQWxsIHRoZSBleHRlbnNpb25z
IHByZXNlbnQgaW4gZGV2aWNlIHRyZWUgYW5kIGZvbGxvdyB0aGUgb3JkZXINCj4gPiBkZXNjcmli
ZWQgaW4gdGhlIFJJU0MtViBzcGVjaWZpY2F0aW9uIChleGNlcHQgJ1MnKSBhcmUgcHJpbnRlZCB2
aWENCj4gPiAvcHJvYy9jcHVpbmZvIGFsd2F5cy4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBB
dGlzaCBQYXRyYSA8YXRpc2gucGF0cmFAd2RjLmNvbT4NCj4gDQo+IEkgdGVzdGVkIHRoaXMgcGF0
Y2ggYWZ0ZXIgZHJvcHBpbmcgdGhlIENPTkZJR19JU0FfUklTQ1ZfQyB0ZXN0IChzZWUgDQo+IGJl
bG93KS4gIFJ1bm5pbmcgImNhdCAvcHJvYy9jcHVpbmZvIiBnZW5lcmF0ZWQgdGhlIGZvbGxvd2lu
ZyBrZXJuZWwgDQo+IHdhcm5pbmdzOg0KPiAgICAgICAgICAgDQo+IFsgICA3My40MTI2MjZdIHVu
c3VwcG9ydGVkIElTQSBleHRlbnNpb25zICJzdSIgaW4gZGV2aWNlIHRyZWUgZm9yIGNwdQ0KPiBb
MF0NCj4gWyAgIDczLjQxODQxN10gdW5zdXBwb3J0ZWQgSVNBIGV4dGVuc2lvbnMgInN1IiBpbiBk
ZXZpY2UgdHJlZSBmb3IgY3B1DQo+IFsxXQ0KPiBbICAgNzMuNDI0OTEyXSB1bnN1cHBvcnRlZCBJ
U0EgZXh0ZW5zaW9ucyAic3UiIGluIGRldmljZSB0cmVlIGZvciBjcHUNCj4gWzJdDQo+IFsgICA3
My40MzE0MjVdIHVuc3VwcG9ydGVkIElTQSBleHRlbnNpb25zICJzdSIgaW4gZGV2aWNlIHRyZWUg
Zm9yIGNwdQ0KPiBbM10NCj4gDQoNCnllYWguIEkganVzdCB0ZXN0ZWQgaW4gUUVNVS4gSXQgc2Vl
bXMgdGhhdCBRRU1VIGhhcyANCiJydjY0aW1hZmRjc3UiIGFzIGlzYSBzdHJpbmcgaW4gaXRzIERU
LiBUaGF0J3Mgd2h5IEkgbmV2ZXIgc2F3IHRoaXMuDQoNCj4gU2VlbXMgbGlrZSB0aGUgInN1IiBz
aG91bGQgYmUgZHJvcHBlZCBmcm9tIG1hbmRhdG9yeV9leHQuICBXaGF0IGRvDQo+IHlvdSANCj4g
dGhpbms/DQo+IA0KDQpZdXAuIEFzIERUIGJpbmRpbmcgb25seSBtZW50aW9uIGltYWZkYywgbWFu
ZGF0b3J5IGV4dGVuc2lvbnMgc2hvdWxkDQpjb250YWluIG9ubHkgdGhhdCBhbmQganVzdCBjb25z
aWRlciAic3UiIGV4dGVuc2lvbnMgYXJlIGNvbnNpZGVyZWQgYXMNCmltcGxpY2l0IGFzIHdlIGFy
ZSBydW5uaW5nIExpbnV4LiANCg0KRG8geW91IHRoaW5rIFFFTVUgRFQgc2hvdWxkIGJlIHVwZGF0
ZWQgdG8gcmVmbGVjdCB0aGF0ID8NCg0KPiA+IC0tLQ0KPiA+ICBhcmNoL3Jpc2N2L2tlcm5lbC9j
cHUuYyB8IDQ3ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0NCj4gPiAtLS0t
DQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAzNyBpbnNlcnRpb25zKCspLCAxMCBkZWxldGlvbnMoLSkN
Cj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9yaXNjdi9rZXJuZWwvY3B1LmMgYi9hcmNoL3Jp
c2N2L2tlcm5lbC9jcHUuYw0KPiA+IGluZGV4IDdkYTNjNmE5M2FiZC4uOWIxZDQ1NTBmYmU2IDEw
MDY0NA0KPiA+IC0tLSBhL2FyY2gvcmlzY3Yva2VybmVsL2NwdS5jDQo+ID4gKysrIGIvYXJjaC9y
aXNjdi9rZXJuZWwvY3B1LmMNCj4gPiBAQCAtNyw2ICs3LDcgQEANCj4gPiAgI2luY2x1ZGUgPGxp
bnV4L3NlcV9maWxlLmg+DQo+ID4gICNpbmNsdWRlIDxsaW51eC9vZi5oPg0KPiA+ICAjaW5jbHVk
ZSA8YXNtL3NtcC5oPg0KPiA+ICsjaW5jbHVkZSA8YXNtL2h3Y2FwLmg+DQo+ID4gIA0KPiA+ICAv
Kg0KPiA+ICAgKiBSZXR1cm5zIHRoZSBoYXJ0IElEIG9mIHRoZSBnaXZlbiBkZXZpY2UgdHJlZSBu
b2RlLCBvciAtRU5PREVWDQo+ID4gaWYgdGhlIG5vZGUNCj4gPiBAQCAtNDYsMTEgKzQ3LDE0IEBA
IGludCByaXNjdl9vZl9wcm9jZXNzb3JfaGFydGlkKHN0cnVjdA0KPiA+IGRldmljZV9ub2RlICpu
b2RlKQ0KPiA+ICANCj4gPiAgI2lmZGVmIENPTkZJR19QUk9DX0ZTDQo+ID4gIA0KPiA+IC1zdGF0
aWMgdm9pZCBwcmludF9pc2Eoc3RydWN0IHNlcV9maWxlICpmLCBjb25zdCBjaGFyICpvcmlnX2lz
YSkNCj4gPiArc3RhdGljIHZvaWQgcHJpbnRfaXNhKHN0cnVjdCBzZXFfZmlsZSAqZiwgY29uc3Qg
Y2hhciAqb3JpZ19pc2EsDQo+ID4gKwkJICAgICAgdW5zaWduZWQgbG9uZyBjcHVpZCkNCj4gPiAg
ew0KPiA+IC0Jc3RhdGljIGNvbnN0IGNoYXIgKmV4dCA9ICJtYWZkY3N1IjsNCj4gPiArCXN0YXRp
YyBjb25zdCBjaGFyICptYW5kYXRvcnlfZXh0ID0gIm1hZmRjc3UiOw0KPiA+ICAJY29uc3QgY2hh
ciAqaXNhID0gb3JpZ19pc2E7DQo+ID4gIAljb25zdCBjaGFyICplOw0KPiA+ICsJY2hhciB1bnN1
cHBvcnRlZF9pc2FbMjZdID0gezB9Ow0KPiA+ICsJaW50IGluZGV4ID0gMDsNCj4gPiAgDQo+ID4g
IAkvKg0KPiA+ICAJICogTGludXggZG9lc24ndCBzdXBwb3J0IHJ2MzJlIG9yIHJ2MTI4aSwgYW5k
IHdlIG9ubHkgc3VwcG9ydA0KPiA+IGJvb3RpbmcNCj4gPiBAQCAtNzAsMjcgKzc0LDUwIEBAIHN0
YXRpYyB2b2lkIHByaW50X2lzYShzdHJ1Y3Qgc2VxX2ZpbGUgKmYsIGNvbnN0DQo+ID4gY2hhciAq
b3JpZ19pc2EpDQo+ID4gIAlpc2EgKz0gNTsNCj4gPiAgDQo+ID4gIAkvKg0KPiA+IC0JICogQ2hl
Y2sgdGhlIHJlc3Qgb2YgdGhlIElTQSBzdHJpbmcgZm9yIHZhbGlkIGV4dGVuc2lvbnMsDQo+ID4g
cHJpbnRpbmcgdGhvc2UNCj4gPiAtCSAqIHdlIGZpbmQuICBSSVNDLVYgSVNBIHN0cmluZ3MgZGVm
aW5lIGFuIG9yZGVyLCBzbyB3ZSBvbmx5DQo+ID4gcHJpbnQgdGhlDQo+ID4gKwkgKiBSSVNDLVYg
SVNBIHN0cmluZ3MgZGVmaW5lIGFuIG9yZGVyLCBzbyB3ZSBvbmx5IHByaW50IGFsbCB0aGUNCj4g
PiAgCSAqIGV4dGVuc2lvbiBiaXRzIHdoZW4gdGhleSdyZSBpbiBvcmRlci4gSGlkZSB0aGUgc3Vw
ZXJ2aXNvcg0KPiA+IChTKQ0KPiA+ICAJICogZXh0ZW5zaW9uIGZyb20gdXNlcnNwYWNlIGFzIGl0
J3Mgbm90IGFjY2Vzc2libGUgZnJvbSB0aGVyZS4NCj4gPiArCSAqIFRocm93IGEgd2FybmluZyBv
bmx5IGlmIGFueSBtYW5kYXRvcnkgZXh0ZW5zaW9ucyBhcmUgbm90DQo+ID4gYXZhaWxhYmxlDQo+
ID4gKwkgKiBhbmQga2VybmVsIGlzIGNvbmZpZ3VyZWQgdG8gaGF2ZSB0aGF0IG1hbmRhdG9yeSBl
eHRlbnNpb25zLg0KPiA+ICAJICovDQo+ID4gLQlmb3IgKGUgPSBleHQ7ICplICE9ICdcMCc7ICsr
ZSkgew0KPiA+IC0JCWlmIChpc2FbMF0gPT0gZVswXSkgew0KPiA+ICsJZm9yIChlID0gbWFuZGF0
b3J5X2V4dDsgKmUgIT0gJ1wwJzsgKytlKSB7DQo+ID4gKwkJaWYgKGlzYVswXSAhPSBlWzBdKSB7
DQo+ID4gKyNpZiBkZWZpbmVkKENPTkZJR19JU0FfUklTQ1ZfQykNCj4gDQo+IFRoZXJlJ3Mgbm8g
S2NvbmZpZyBvcHRpb24gYnkgdGhpcyBuYW1lLCBhbmQgd2UncmUgcmVxdWlyaW5nDQo+IGNvbXBy
ZXNzZWQgDQoNClNvcnJ5LiBUaGlzIHdhcyBhIHR5cG8uIEl0IHNob3VsZCBoYXZlIGJlZW4gQ09O
RklHX1JJU0NWX0lTQV9DLg0KDQo+IGluc3RydWN0aW9uIHN1cHBvcnQgYXMgcGFydCBvZiB0aGUg
UklTQy1WIExpbnV4IGJhc2VsaW5lLiAgQ291bGQgeW91DQo+IHNoYXJlIA0KPiB0aGUgcmF0aW9u
YWxlIGJlaGluZCB0aGlzPyAgDQoNCkkgdGhpbmsgSSBhZGRlZCB0aGlzIGNoZWNrIGF0IHRoZSBj
b25maWcgZmlsZS4gTG9va2luZyBhdCB0aGUgS2NvbmZpZywNClJJU0NWX0lTQV9DIGlzIGFsd2F5
cyBlbmFibGVkLiBTbyB3ZSBjYW4gZHJvcCB0aGlzLg0KDQpSZWdhcmRzLA0KQXRpc2gNCj4gTG9v
a3MgdG8gbWUgbGlrZSB0aGlzIHNob3VsZCBiZSBkcm9wcGVkLg0KPiANCj4gDQo+ID4gKwkJCWlm
IChpc2FbMF0gPT0gJ2MnKQ0KPiA+ICsJCQkJY29udGludWU7DQo+ID4gKyNlbmRpZg0KPiA+ICsj
aWYgZGVmaW5lZChDT05GSUdfRlApDQo+ID4gKwkJCWlmICgoaXNhWzBdID09ICdmJykgfHwgKGlz
YVswXSA9PSAnZCcpKQ0KPiA+ICsJCQkJY29udGludWU7DQo+ID4gKyNlbmRpZg0KPiA+ICsJCQl1
bnN1cHBvcnRlZF9pc2FbaW5kZXhdID0gZVswXTsNCj4gPiArCQkJaW5kZXgrKzsNCj4gPiArCQl9
DQo+ID4gKwkJLyogT25seSB3cml0ZSBpZiBwYXJ0IG9mIGlzYSBzdHJpbmcgKi8NCj4gPiArCQlp
ZiAoaXNhWzBdICE9ICdcMCcpIHsNCj4gPiAgCQkJaWYgKGlzYVswXSAhPSAncycpDQo+ID4gIAkJ
CQlzZXFfd3JpdGUoZiwgaXNhLCAxKTsNCj4gPiAtDQo+ID4gIAkJCWlzYSsrOw0KPiA+ICAJCX0N
Cj4gPiAgCX0NCj4gPiArCWlmIChpc2FbMF0gIT0gJ1wwJykgew0KPiA+ICsJCS8qIEFkZCByZW1h
aW5naW5nIGlzYSBzdHJpbmdzICovDQo+ID4gKwkJZm9yIChlID0gaXNhOyAqZSAhPSAnXDAnOyAr
K2UpIHsNCj4gPiArI2lmICFkZWZpbmVkKENPTkZJR19WSVJUVUFMSVpBVElPTikNCj4gPiArCQkJ
aWYgKGVbMF0gIT0gJ2gnKQ0KPiA+ICsjZW5kaWYNCj4gPiArCQkJCXNlcV93cml0ZShmLCBlLCAx
KTsNCj4gPiArCQl9DQo+ID4gKwl9DQo+ID4gIAlzZXFfcHV0cyhmLCAiXG4iKTsNCj4gPiAgDQo+
ID4gIAkvKg0KPiA+ICAJICogSWYgd2Ugd2VyZSBnaXZlbiBhbiB1bnN1cHBvcnRlZCBJU0EgaW4g
dGhlIGRldmljZSB0cmVlIHRoZW4NCj4gPiBwcmludA0KPiA+ICAJICogYSBiaXQgb2YgaW5mbyBk
ZXNjcmliaW5nIHdoYXQgd2VudCB3cm9uZy4NCj4gPiAgCSAqLw0KPiA+IC0JaWYgKGlzYVswXSAh
PSAnXDAnKQ0KPiA+IC0JCXByX2luZm8oInVuc3VwcG9ydGVkIElTQSBcIiVzXCIgaW4gZGV2aWNl
IHRyZWVcbiIsDQo+ID4gb3JpZ19pc2EpOw0KPiA+ICsJaWYgKHVuc3VwcG9ydGVkX2lzYVswXSkN
Cj4gPiArCQlwcl9pbmZvKCJ1bnN1cHBvcnRlZCBJU0EgZXh0ZW5zaW9ucyBcIiVzXCIgaW4gZGV2
aWNlDQo+ID4gdHJlZSBmb3IgY3B1IFslbGRdXG4iLA0KPiA+ICsJCQl1bnN1cHBvcnRlZF9pc2Es
IGNwdWlkKTsNCj4gPiAgfQ0KPiA+ICANCj4gPiAgc3RhdGljIHZvaWQgcHJpbnRfbW11KHN0cnVj
dCBzZXFfZmlsZSAqZiwgY29uc3QgY2hhciAqbW11X3R5cGUpDQo+ID4gQEAgLTEzNCw3ICsxNjEs
NyBAQCBzdGF0aWMgaW50IGNfc2hvdyhzdHJ1Y3Qgc2VxX2ZpbGUgKm0sIHZvaWQgKnYpDQo+ID4g
IAlzZXFfcHJpbnRmKG0sICJwcm9jZXNzb3JcdDogJWx1XG4iLCBjcHVfaWQpOw0KPiA+ICAJc2Vx
X3ByaW50ZihtLCAiaGFydFx0XHQ6ICVsdVxuIiwgY3B1aWRfdG9faGFydGlkX21hcChjcHVfaWQp
KTsNCj4gPiAgCWlmICghb2ZfcHJvcGVydHlfcmVhZF9zdHJpbmcobm9kZSwgInJpc2N2LGlzYSIs
ICZpc2EpKQ0KPiA+IC0JCXByaW50X2lzYShtLCBpc2EpOw0KPiA+ICsJCXByaW50X2lzYShtLCBp
c2EsIGNwdV9pZCk7DQo+ID4gIAlpZiAoIW9mX3Byb3BlcnR5X3JlYWRfc3RyaW5nKG5vZGUsICJt
bXUtdHlwZSIsICZtbXUpKQ0KPiA+ICAJCXByaW50X21tdShtLCBtbXUpOw0KPiA+ICAJaWYgKCFv
Zl9wcm9wZXJ0eV9yZWFkX3N0cmluZyhub2RlLCAiY29tcGF0aWJsZSIsICZjb21wYXQpDQo+ID4g
LS0gDQo+ID4gMi4yMS4wDQo+ID4gDQo+ID4gDQo+IA0KPiAtIFBhdWwNCg0K
