Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7989AC19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 23:07:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4487A206B8
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 23:07:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="VzrwmW/T";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="HXJdQK/r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390221AbfHAXHm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 19:07:42 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:21226 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731936AbfHAXHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 19:07:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1564700860; x=1596236860;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=JkDeCuNZLDQxMhX+hkEOeAeXDWX8KAfgeLMkHiH4v54=;
  b=VzrwmW/TASDwwaVmLRvJWK/XIKM7NOSYYMsjGGJofu5Dn0Wr6zig3xA+
   usiGWWtczTrFurezngvR4S8Vh0ekFXWHCVqBRNWuo8oKqd9bDf/CIBV++
   qoqxNgMdGkmzMCkk3g2kJ8hAyHwvsOgDvOcImBq768DMYEB0ssB0kY9pm
   +s1IPAcpY4gCWn0mPufrAGq2MXWbbbgk2DkAc70vxB4jGOG/NH/f8+2nn
   0a91VGwap8H3IMSffIP8ZMuaPWJARrerCXVf3as/A6gbzdH2dgVgLkEef
   LZ1NTE/bCe4w02zZ5gTytJtG1NQuSKRHtcxqXnoKJVzkZz1UEY5IwjzzN
   w==;
IronPort-SDR: i37UlXkPCCzX8PMoX/hOdykA4IurLYiqp2iLRYZqbHH9i53ZQ9eCgQDjbPNvYPE1RhVwVsfaiI
 M/bE8Ohz4H093zNKz+TKdyr6mCxSbxDabFRiaSxBQkIE6Hftu9EEr3s6BvF8ieAYNZSUWn4o2l
 cW93K4yRfFW2B/wsxWv2CqLIxr7717WAw+TsMBBZpqwqp0YE3Ytx0RmhRx5ZEm6nYewIvTX+8d
 qt2ke3A83fLJGNKQ1PTd9PTTNN6IqbqPluRqbVQD8+7ZbT23YteB53Jjk3OR6CmCj6jPm0DVSs
 IzQ=
X-IronPort-AV: E=Sophos;i="5.64,336,1559491200"; 
   d="scan'208";a="114750636"
Received: from mail-co1nam05lp2055.outbound.protection.outlook.com (HELO NAM05-CO1-obe.outbound.protection.outlook.com) ([104.47.48.55])
  by ob1.hgst.iphmx.com with ESMTP; 02 Aug 2019 07:07:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UL7FSxvw4DVddt43JXXkk8E5ZMQ3ynyGh0vXD9CelO6orbb/bK/jbGjZS16SwhzfvjmcjSGhtW6ymUfTxf9xD52GHXvLnImAXImqlOmJIpN6KxBfbAsWFynGB7cIWhPGQ0cwo1UFYtGCc9caX3gVHy2mNHdv5h2Zb8gT47BQ4j3xRF4QjIJlC0uuMLl9FcFgm0uT/vZSnrPNS1Lj50ZVljJay+Sxz+x/Ps4FLlwFlq0DJnDsSYp20milMO5IWtegZHUSx8rf6iARw30XctslXRpDnxEjkFysknAO62d3gQY6NS0zmFrpzOVP0L3v1lQr0Rj+qSMaw/8Ta7dVdkyr2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JkDeCuNZLDQxMhX+hkEOeAeXDWX8KAfgeLMkHiH4v54=;
 b=BaVyd+FXpWahj0lFfx0qnb3woMRe6AqYI3p4oUtXRgKUgGS+41cn39j2MkMyaDY5wpsfVrUKt/jzomnESWRWcX//OqBLMCjV7B5fscj+8x9G6f8NA5J9ivmBneWjfxzMpcUp1CG2A7ZwKSKP7rxKpEluBmTB2i5LIg5ZNVsQNhfAl/mn5B+P8vVb7yiZyvWhvBlxPa9jP8/WJzTTZ36f42cin/LBM4JBQzsaUTTOhWDrpn00mnsuLESy5CuKutFXR3IipIDvDsyi9fo4KJt8ofqhEnc/FBLtRm1lOl69jAcSZrzFqtOs2g2Y8vkBq63ZXxqJbKwVv3ZgRvFO+lZ24w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=wdc.com;dmarc=pass action=none header.from=wdc.com;dkim=pass
 header.d=wdc.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JkDeCuNZLDQxMhX+hkEOeAeXDWX8KAfgeLMkHiH4v54=;
 b=HXJdQK/rh3+XgdDw7Va/DHEKVJP6KqnuADIlso951Y4trIDD762MymwrbhgTtwtFik6pu8s70vl1JZJEvVllTsuDAFIIK55LOQrCV8VOFCRlWVtAyCLgtDkPu9jpPLY9GGE3cV3ZAYVuIsnAa9A1UelccPB+sWkdf+6gWWeh8XM=
Received: from BYAPR04MB3782.namprd04.prod.outlook.com (52.135.214.142) by
 BYAPR04MB4901.namprd04.prod.outlook.com (52.135.232.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.15; Thu, 1 Aug 2019 23:07:36 +0000
Received: from BYAPR04MB3782.namprd04.prod.outlook.com
 ([fe80::ac9a:967e:70a5:e926]) by BYAPR04MB3782.namprd04.prod.outlook.com
 ([fe80::ac9a:967e:70a5:e926%7]) with mapi id 15.20.2115.005; Thu, 1 Aug 2019
 23:07:36 +0000
From:   Atish Patra <Atish.Patra@wdc.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "info@metux.net" <info@metux.net>,
        "palmer@sifive.com" <palmer@sifive.com>,
        "allison@lohutok.net" <allison@lohutok.net>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        Anup Patel <Anup.Patel@wdc.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "johan@kernel.org" <johan@kernel.org>,
        "tiny.windzz@gmail.com" <tiny.windzz@gmail.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "gary@garyguo.net" <gary@garyguo.net>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v3 5/5] dt-bindings: Update the riscv,isa string
 description
Thread-Topic: [PATCH v3 5/5] dt-bindings: Update the riscv,isa string
 description
Thread-Index: AQHVSAREeMdpzzXGsU+2Z9vvOg2BbKbmcbCAgAB6FQA=
Date:   Thu, 1 Aug 2019 23:07:36 +0000
Message-ID: <40ec671a2ef7204ad890b2ca43ec92d6981d6344.camel@wdc.com>
References: <20190801005843.10343-1-atish.patra@wdc.com>
         <20190801005843.10343-6-atish.patra@wdc.com>
         <CAL_JsqLqxN1+fvrdD24Ho6s7gB+pGy-0sZaL-jJqkYZ2yC4JEA@mail.gmail.com>
In-Reply-To: <CAL_JsqLqxN1+fvrdD24Ho6s7gB+pGy-0sZaL-jJqkYZ2yC4JEA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Atish.Patra@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 63615853-7c76-4652-2a7b-08d716d50acb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB4901;
x-ms-traffictypediagnostic: BYAPR04MB4901:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <BYAPR04MB490134D5D79906C90306F9B0FADE0@BYAPR04MB4901.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:439;
x-forefront-prvs: 01165471DB
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(396003)(39860400002)(346002)(376002)(136003)(189003)(199004)(81166006)(478600001)(25786009)(53546011)(66574012)(71200400001)(6506007)(6306002)(71190400001)(7736002)(6486002)(6436002)(14454004)(8676002)(81156014)(102836004)(76176011)(256004)(99286004)(316002)(26005)(8936002)(14444005)(229853002)(6512007)(6246003)(186003)(36756003)(76116006)(64756008)(66066001)(2906002)(66946007)(66476007)(305945005)(486006)(86362001)(54906003)(68736007)(11346002)(966005)(66556008)(476003)(446003)(6116002)(3846002)(53936002)(4326008)(118296001)(2616005)(5660300002)(66446008)(7416002)(142933001);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4901;H:BYAPR04MB3782.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 5PeyMbYMGFIComLkvM2fjgkFjjR3KF28EcS9f42xTFDlCuT54x2mMtCludK9uhTRu6jgPvrSB8JIzQfnxSDzIzQsfpHofxclYU4f/Zk7xlMZ685eMUELPZi66LND8ky70RzjaCNhSmkOkb3g6TDV+NaRnwgYCR60yqo439qWtkMVnFbDtRGQqtkAX9NjatIyMhlGGwt8otldBACwXo3QYY/SyENUDjqXyFhSg4Z+QZEVoD4c3hYfH15S9UJr2Bk/nLtRh/0GZOjmVwU+sj2nwFIlOmSCn/+XKPVAKo/mbwxQcxlt4QvbfqSLBg3RZNIbVLICr54F+dUbnWW7Te+7YPNSEdfEEoltJopOlA6XGjZV3Vex95/FHGZH9vgS2uZITxHLeCmy7hvkwyOWKDq6YevZpN33WkMJJIWq5G0+QvQ=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A06B902F88D8304FB2DF845FCCEB3719@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63615853-7c76-4652-2a7b-08d716d50acb
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2019 23:07:36.0686
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Atish.Patra@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4901
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDE5LTA4LTAxIGF0IDA5OjUwIC0wNjAwLCBSb2IgSGVycmluZyB3cm90ZToNCj4g
T24gV2VkLCBKdWwgMzEsIDIwMTkgYXQgNjo1OCBQTSBBdGlzaCBQYXRyYSA8YXRpc2gucGF0cmFA
d2RjLmNvbT4NCj4gd3JvdGU6DQo+ID4gU2luY2UgdGhlIFJJU0MtViBzcGVjaWZpY2F0aW9uIHN0
YXRlcyB0aGF0IElTQSBkZXNjcmlwdGlvbiBzdHJpbmdzDQo+ID4gYXJlDQo+ID4gY2FzZS1pbnNl
bnNpdGl2ZSwgdGhlcmUncyBubyBmdW5jdGlvbmFsIGRpZmZlcmVuY2UgYmV0d2VlbiBtaXhlZC0N
Cj4gPiBjYXNlLA0KPiA+IHVwcGVyLWNhc2UsIGFuZCBsb3dlci1jYXNlIElTQSBzdHJpbmdzLiBU
aHVzLCB0byBzaW1wbGlmeSBwYXJzaW5nLA0KPiA+IHNwZWNpZnkgdGhhdCB0aGUgbGV0dGVycyBw
cmVzZW50IGluICJyaXNjdixpc2EiIG11c3QgYmUgYWxsDQo+ID4gbG93ZXJjYXNlLg0KPiA+IA0K
PiA+IFN1Z2dlc3RlZC1ieTogUGF1bCBXYWxtc2xleSA8cGF1bC53YWxtc2xleUBzaWZpdmUuY29t
Pg0KPiA+IFNpZ25lZC1vZmYtYnk6IEF0aXNoIFBhdHJhIDxhdGlzaC5wYXRyYUB3ZGMuY29tPg0K
PiA+IC0tLQ0KPiA+ICBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcmlzY3YvY3B1
cy55YW1sIHwgNCArKystDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDEg
ZGVsZXRpb24oLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL3Jpc2N2L2NwdXMueWFtbA0KPiA+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL3Jpc2N2L2NwdXMueWFtbA0KPiA+IGluZGV4IGM4OTkxMTFhYTVlMy4uNGYw
YWNiMDAxODVhIDEwMDY0NA0KPiA+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9yaXNjdi9jcHVzLnlhbWwNCj4gPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3MvcmlzY3YvY3B1cy55YW1sDQo+ID4gQEAgLTQ2LDEwICs0NiwxMiBAQCBwcm9wZXJ0
aWVzOg0KPiA+ICAgICAgICAgICAgLSBydjY0aW1hZmRjDQo+ID4gICAgICBkZXNjcmlwdGlvbjoN
Cj4gPiAgICAgICAgSWRlbnRpZmllcyB0aGUgc3BlY2lmaWMgUklTQy1WIGluc3RydWN0aW9uIHNl
dCBhcmNoaXRlY3R1cmUNCj4gPiAtICAgICAgc3VwcG9ydGVkIGJ5IHRoZSBoYXJ0LiAgVGhlc2Ug
YXJlIGRvY3VtZW50ZWQgaW4gdGhlIFJJU0MtVg0KPiA+ICsgICAgICBzdXBwb3J0ZWQgYnkgdGhl
IGhhcnQuIFRoZXNlIGFyZSBkb2N1bWVudGVkIGluIHRoZSBSSVNDLVYNCj4gPiAgICAgICAgVXNl
ci1MZXZlbCBJU0EgZG9jdW1lbnQsIGF2YWlsYWJsZSBmcm9tDQo+ID4gICAgICAgIGh0dHBzOi8v
cmlzY3Yub3JnL3NwZWNpZmljYXRpb25zLw0KPiA+IA0KPiA+ICsgICAgICBMZXR0ZXJzIGluIHRo
ZSByaXNjdixpc2Egc3RyaW5nIG11c3QgYmUgYWxsIGxvd2VyY2FzZS4NCj4gPiArDQo+IA0KPiBU
aGUgc2NoZW1hcyBhcmUgY2FzZSBzZW5zaXRpdmUgdGhpcyBsb29rcyBwcmV0dHkgcG9pbnRsZXNz
IHdpdGhvdXQNCj4gdGhlDQo+IGNvbnRleHQgb2YgdGhlIGNvbW1pdCBtc2cuIENhbiB5b3UgcHJl
Zml4IHdpdGggJ1doaWxlIHRoZQ0KPiBzcGVjaWZpY2F0aW9uIGlzIGNhc2UgaW5zZW5zaXRpdmUs
ICINCj4gDQoNClN1cmUuIEhvdyBhYm91dCB0aGlzID8NCg0KIldoaWxlIHRoZSBhYm92ZSBpc2Eg
c3RyaW5ncyBpbiBJU0Egc3BlY2lmaWNhdGlvbiBhcmUgY2FzZSBpbnNlbnNpdGl2ZSwNCmxldHRl
cnMgaW4gdGhlIHJpc2N2LGlzYSBzdHJpbmcgbXVzdCBiZSBhbGwgbG93ZXJjYXNlIHRvIHNpbXBs
aWZ5DQpwYXJzaW5nLiINCg0KDQo+IEZvciBzb21lIGJhY2tncm91bmQsIEZEVCBnZW5lcmFsbHkg
YWx3YXlzIGhhcyBiZWVuIGNhc2Ugc2Vuc2l0aXZlIHRvbw0KPiAoZHRjIHdvbid0IG1lcmdlL292
ZXJyaWRlIG5vZGVzL3Byb3BlcnRpZXMgd2l0aCBkaWZmZXJpbmcgY2FzZSkuIEl0J3MNCj4gcmVh
bGx5IG9ubHkgc29tZSBvbGRlciB0cnVlIE9GIHN5c3RlbXMgdGhhdCB3ZXJlIGNhc2UgaW5zZW5z
aXRpdmUuDQo+IFRoZQ0KPiBrZXJuZWwgaGFkIGEgbWl4dHVyZSBvZiBjYXNlIHNlbnNpdGl2ZSBh
bmQgaW5zZW5zaXRpdmUgY29tcGFyaXNvbnMNCj4gc29tZXdoYXQgZGVwZW5kaW5nIG9uIHRoZSBh
cmNoIGFuZCB3aGV0aGVyIG9mX3Byb3BfY21wL29mX25vZGVfY21wIG9yDQo+IHN0cipjbXAgZnVu
Y3Rpb25zIHdlcmUgdXNlZC4gVGhlcmUncyBiZWVuIGEgbG90IG9mIGNsZWFuLXVwIGFuZCBub3cN
Cj4gbW9zdCBjb21wYXJpc29ucyBhcmUgY2FzZSBzZW5zaXRpdmUgd2l0aCBvbmx5IFNwYXJjIGhh
dmluZyBzb21lDQo+IGRldmlhdGlvbi4NCj4gDQo+IFJvYg0KDQotLSANClJlZ2FyZHMsDQpBdGlz
aA0K
