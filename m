Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97D9DC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 23:28:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60AC620838
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 23:28:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="J1ZS5Z0Z";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="kslwnAaE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405354AbfIFX2D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 19:28:03 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:41583 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405332AbfIFX2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 19:28:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1567812480; x=1599348480;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=eRTeb5EIshydrRtcSle0mMUayCoMqd+2T3AQmoDL0w0=;
  b=J1ZS5Z0Zbpcf1vxKNk73DROUJdGWCF8uXdn2irKzC0W25FZnPvH0JCwb
   LgKevqkKkAKOoy79C1NKHGigaw59GKt4GwxEhiCHUPQM49S29Y1xs9nlE
   Dmww81ce8ddue5PILuyjBQEnLom8CZgQ3GHev5VTZzjRB2Uq8jgWhQ4y+
   MMZTBx3fMNQ5841i8INcPojnHTInf2vJuzPKAZcwShijVuJsFhk8IXBZ2
   2jdph3a8XVLrmiq8luhnIr5UCED8R3sUi4+AfyNz/BJvI92W0LYvFLtFV
   kvL6LRqjxjs6ccF6mIDwKXTuNFPRe2MJ31bba0lMSNxL/sFU4LWJMF0FH
   A==;
IronPort-SDR: 0IEWEDKaUOZh5xvQzd2lumKCIRc0L+5UqiEDl9H5Y/I3wB4cZk6uHbmSSkzAsH3EiDRg8GocyK
 CsFkop845P3BtiwLP8mi5aEwGGv0/75vE8vykV5yE4Gv+qeAW5XWFESdxGVvRSUAnp7zYDZDOy
 fD9WL1/Ctk3E11sZR4+GtOa1i6QG/0BPG5JkpS9marMskTne0/7aK9Pnf81Hu2ZLAAr1ejPtco
 iWKaZyHpnKTZxgbX2bIVABwOuusFoSo4JtcApOFDA4bLL4fGQ1JBzFduGrZaltBLSu0TrqjE3s
 9w4=
X-IronPort-AV: E=Sophos;i="5.64,474,1559491200"; 
   d="scan'208";a="224456537"
Received: from mail-sn1nam04lp2056.outbound.protection.outlook.com (HELO NAM04-SN1-obe.outbound.protection.outlook.com) ([104.47.44.56])
  by ob1.hgst.iphmx.com with ESMTP; 07 Sep 2019 07:27:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fE+7JAbabY+VXiUZGtaU0Sb/snpNYHh4/+NjUIXURBWmiCbfiePe+t5ZTIg8u/1s867BgXHirDTBc1tGW0LcbU8II0ol7Lu+FgQj+Mnhc20M6lighviALr5tavANtNnfE2o3cLk/FJ9uuGDAui22WvFB45aHDNBb8mcAH/i2jnl30zygNMpcOvpsT4RbseZSWQ+hNoN20dD1ySN3luqziCyd0LclLmrE3O3FkZmpZtsTfOMVbb+KH6a8igdJC8NF0n5wR1W/TVV+7jy8V6JYPIWVugtBljqRAsj6ppBpFZ2eIz5+8IUtWz0tQv3C9h8LA82w1DlTlHOuoMB0WYSKFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eRTeb5EIshydrRtcSle0mMUayCoMqd+2T3AQmoDL0w0=;
 b=A8mEK5kPd2SIDmJo9l2+KoATsjS+YC/XpV1y6kPiObPy+0DN65EjvQSO3af61xpRLTTFwRu8tKF8+09gUdjVRPxUmZbVkW93VC0121hLsEep5R8AjVCafTE0U7wwfHSsSFsEYXDUp2VafxIFCkA55C62tOEd731QoLIPWwPtWXRbURiBiIThk9HpyQcSlyh1Pksdtf646EigPN0b91b+BLAI0LCBsmGVMGEPD0x4euVzs7zCXly0eY0/uIW51cr6x7V9HJFlhPqV3FTi/wXu1QKpYnKxrE4tv5pj/zpKoCyifF7FiIecreH/MvU319eiZHbfo3CzWVB46i7gxpeezA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eRTeb5EIshydrRtcSle0mMUayCoMqd+2T3AQmoDL0w0=;
 b=kslwnAaE6RotTmo6q9kp+LqSXw+55UIZ4jBL1bbnDlZTPmA2D2jL2jN/u8PCMZnj3gxtrPai3OV8oH86KCxW1ryst06EMPwX9Rhn6/nEQbCmDyR+kfjurrejhrq2rZHAF/M3AoSJX6k8JwCHpqSMHzIj0kXdLeh0+A9l9IKG1qs=
Received: from BYAPR04MB3990.namprd04.prod.outlook.com (52.135.215.29) by
 BYAPR04MB4790.namprd04.prod.outlook.com (52.135.240.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.15; Fri, 6 Sep 2019 23:27:57 +0000
Received: from BYAPR04MB3990.namprd04.prod.outlook.com
 ([fe80::a50d:40a0:cd7b:acbc]) by BYAPR04MB3990.namprd04.prod.outlook.com
 ([fe80::a50d:40a0:cd7b:acbc%5]) with mapi id 15.20.2241.014; Fri, 6 Sep 2019
 23:27:57 +0000
From:   Atish Patra <Atish.Patra@wdc.com>
To:     "hch@infradead.org" <hch@infradead.org>
CC:     "anup@brainfault.org" <anup@brainfault.org>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "palmer@sifive.com" <palmer@sifive.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "johan@kernel.org" <johan@kernel.org>
Subject: Re: [v5 PATCH] RISC-V: Fix unsupported isa string info.
Thread-Topic: [v5 PATCH] RISC-V: Fix unsupported isa string info.
Thread-Index: AQHVTU090lWiUiEQM02Uoz9V3NTipqb3o0CAgAaR3ACAAxJmAIACeCUAgBu7KwA=
Date:   Fri, 6 Sep 2019 23:27:57 +0000
Message-ID: <4615b682352a2e67094d327fa058ec7dd287423f.camel@wdc.com>
References: <20190807182316.28013-1-atish.patra@wdc.com>
         <20190812150215.GF26897@infradead.org>
         <3fb8d4f0383b005ecd932a69c4dd295a79b6fb1a.camel@wdc.com>
         <20190818181630.GA20217@infradead.org>
         <67e670a4600d7dc7ec3c7a7374e330b9a1dbe654.camel@wdc.com>
In-Reply-To: <67e670a4600d7dc7ec3c7a7374e330b9a1dbe654.camel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Atish.Patra@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e72815e2-f58c-48b3-01d2-08d73321d996
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB4790;
x-ms-traffictypediagnostic: BYAPR04MB4790:
x-microsoft-antispam-prvs: <BYAPR04MB47903A49E1B12B9B50B67B2BFABA0@BYAPR04MB4790.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0152EBA40F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(376002)(396003)(136003)(346002)(39860400002)(189003)(199004)(7736002)(256004)(14444005)(229853002)(6436002)(102836004)(4326008)(186003)(2616005)(6486002)(476003)(25786009)(26005)(6116002)(99286004)(3846002)(11346002)(2501003)(305945005)(486006)(2906002)(14454004)(66066001)(118296001)(2351001)(81156014)(478600001)(8676002)(81166006)(1730700003)(6246003)(36756003)(54906003)(53936002)(8936002)(86362001)(76176011)(66946007)(66446008)(64756008)(66476007)(316002)(71200400001)(71190400001)(76116006)(6916009)(66556008)(6506007)(5640700003)(446003)(5660300002)(6512007);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4790;H:BYAPR04MB3990.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Y9l+oMXzbdWjvmCnVTXYfjDX4FuzuJN5eB/ATFVDup76xQ7KMMug/E343RTLnwC8hiwNpUUDkWoMvUOztSqYwTFErAF+lBO3wbG80MRHVw1bGfw6d0t2bER/vMh4Ao+jtVBMDTp0cRSQ0dvnEmqor198o5hN7Cz7aLnWF6UIhtBEeWEC8CZQIN89t45zSC9AKlYlEbIpuPihvbLbq1RbYjFjpoUdrk0E+o0xKiDAQCQZMtD4aRPs+fg4kbBkxfqD9wUfc5lDw0uOo2DbrWK++quOrZazs8L6tDmQ7HJO/zI3gWK17VO96Yz7tBbRjQJiP0OyGQaDtU0dtBgFyvugKSVNHfL8m5ZuGiIPxCS2WH4hDeHPS6FwmDR4aGjcGPrR58CeVFkB1eKb87ARY2I5/alSiMaByQQSnWZykHsGEg0=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <1AF896A2C5A15E4FA9FCA442E9C323D6@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e72815e2-f58c-48b3-01d2-08d73321d996
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2019 23:27:57.1939
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o+hf7C3hLZnIqwwEiDnCztzn/r5QnutmHxHQLhEmih4Wb9tUW9ewT6YzPGHIgnpGvQPKHSRdTtEzyD/qNNtOAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4790
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE5LTA4LTIwIGF0IDAwOjU5IC0wNzAwLCBBdGlzaCBQYXRyYSB3cm90ZToNCj4g
T24gU3VuLCAyMDE5LTA4LTE4IGF0IDExOjE2IC0wNzAwLCBoY2hAaW5mcmFkZWFkLm9yZyB3cm90
ZToNCj4gPiBPbiBGcmksIEF1ZyAxNiwgMjAxOSBhdCAwNzoyMTo1MlBNICswMDAwLCBBdGlzaCBQ
YXRyYSB3cm90ZToNCj4gPiA+ID4gPiArCWlmIChpc2FbMF0gIT0gJ1wwJykgew0KPiA+ID4gPiA+
ICsJCS8qIEFkZCByZW1haW5naW5nIGlzYSBzdHJpbmdzICovDQo+ID4gPiA+ID4gKwkJZm9yIChl
ID0gaXNhOyAqZSAhPSAnXDAnOyArK2UpIHsNCj4gPiA+ID4gPiArI2lmICFkZWZpbmVkKENPTkZJ
R19WSVJUVUFMSVpBVElPTikNCj4gPiA+ID4gPiArCQkJaWYgKGVbMF0gIT0gJ2gnKQ0KPiA+ID4g
PiA+ICsjZW5kaWYNCj4gPiA+ID4gPiArCQkJCXNlcV93cml0ZShmLCBlLCAxKTsNCj4gPiA+ID4g
PiArCQl9DQo+ID4gPiA+ID4gKwl9DQo+ID4gPiA+IA0KPiA+ID4gPiBUaGlzIG9uZSBJIGRvbid0
IGdldC4gIFdoeSBkbyB3ZSB3YW50IHRvIGNoZWNrDQo+ID4gPiA+IENPTkZJR19WSVJUVUFMSVpB
VElPTj8NCj4gPiA+ID4gDQo+ID4gPiANCj4gPiA+IElmIENPTkZJR19WSVJUVUFMSVpBVElPTiBp
cyBub3QgZW5hYmxlZCwgaXQgc2hvdWxkbid0IHByaW50IHRoYXQNCj4gPiA+IGh5cGVydmlzb3Ig
ZXh0ZW5zaW9uICJoIiBpbiBpc2EgZXh0ZW5zaW9ucy4NCj4gPiANCj4gPiBDT05GSUdfVklSVFVB
TElaQVRJT04gZG9lc24ndCBjaGFuZ2UgYW55dGhpbmcgaW4gdGhlIGtlcm5lbHMNCj4gPiBjYXBh
YmlsaXRpZXMsIGl0IGp1c3QgZW5hYmxlcyBvdGhlciBjb25maWcgb3B0aW9ucy4gDQo+IA0KPiBZ
ZXMuIEJ1dCBpdCBtdXN0IGJlIGVuYWJsZWQgaWYgdmlydHVhbGl6YXRpb24gaXMgc3VwcG9ydGVk
IGluIGtlcm5lbC4NCj4gVGhlIGlkZWEgd2FzIHRvIGxldCB1c2Vyc3BhY2Uga25vdyB0aGF0IGlm
IHZpcnR1YWxpemF0aW9uIGNhbiBiZSB1c2VkDQo+IG9yIG5vdC4gDQo+IA0KPiANCj4gPiAgQnV0
IG1vcmUNCj4gPiBpbXBvcnRhbnRseSB0aGUgJ2gnIGV4dGVuc2lvbiBpcyBvbmx5IHJlbGV2YW50
IGZvciBTLW1vZGUgc29mdHdhcmUNCj4gPiBhbnl3YXkuDQo+ID4gDQo+IA0KPiBEbyB5b3UgdGhp
bmsgd2Ugc2hvdWxkIGp1c3QgcHJpbnQgYWxsIHRoZSBleHRlbnNpb25zIGF2YWlsYWJsZSBpbiBp
c2ENCj4gc3RyaW5nIGFzIGl0IGlzID8NCj4gDQo+ID4gPiBUaGlzIGlzIGp1c3QgYW4gaW5mb3Jt
YXRpb24gdG8gdGhlIHVzZXJzcGFjZSB0aGF0IHNvbWUgb2YgdGhlDQo+ID4gPiBtYW5kYXRvcnkN
Cj4gPiA+IElTQSBleHRlbnNpb25zICgibWFmZGNzdSIpIGFyZSBub3Qgc3VwcG9ydGVkIGluIGtl
cm5lbCB3aGljaCBtYXkNCj4gPiA+IGxlYWQNCj4gPiA+IHRvIHVuZGVzaXJhYmxlIHJlc3VsdHMu
DQo+ID4gDQo+ID4gSSB0aGluayB3ZSBuZWVkIHRvIHNpdCBkb3duIGRlY2lkZSB3aGF0IHRoZSBw
dXJwb3NlIG9mDQo+ID4gL3Byb2MvY3B1aW5mbw0KPiA+IGlzLiAgSUlSQyBvbiBvdGhlciBhcmNo
aXRlY3R1cmVzIGlzIGp1c3QgcHJpbnRzIHdoYXQgdGhlIGhhcmR3YXJlDQo+ID4gc3VwcG9ydHMs
IG5vdCB3aGF0IHlvdSBjYW4gYWN0dWFsbHkgbWFrZSB1c2Ugb2YuICBIb3cgZWxzZSB3b3VsZA0K
PiA+IHlvdQ0KPiA+IGZpbmQgb3V0IHRoYXQgeW91J2QgbmVlZCB0byBlbmFibGUgbW9yZSBrZXJu
ZWwgb3B0aW9ucyB0byBmdWxseQ0KPiA+IHV0aWxpemUgdGhlIGhhcmR3YXJlPw0KPiA+IA0KPiA+
IEFsc28gcHJpbnRpbmcgdGhpcyB3YXJuaW5nIHRvIHRoZSBrZXJuZWwgbG9nIHdoZW4gc29tZW9u
ZSByZWFkcyB0aGUNCj4gPiBwcm9jZnMgZmlsZSBpcyB2ZXJ5IHN0cmFuZ2UuDQo+IA0KPiBBZ3Jl
ZWQuIE1heSBiZSBzb21ldGhpbmcgbGlrZSB0aGlzID8NCj4gDQo+IExldCdzIHNheSBmL2QgaXMg
ZW5hYmxlZCBpbiBrZXJuZWwgYnV0IGNwdSBkb2Vzbid0IHN1cHBvcnQgaXQuDQo+ICJ1bnN1cHBv
cnRlZCBpc2EiIHdpbGwgb25seSBhcHBlYXIgaWYgdGhlcmUgYXJlIGFueSB1bnN1cHBvcnRlZCBp
c2EuDQo+IA0KPiBwcm9jZXNzb3IgICAgICAgOiAzDQo+IGhhcnQgICAgICAgICAgICA6IDQNCj4g
aXNhICAgICAgICAgICAgIDogcnY2NGltYWMNCj4gdW5zdXBwb3J0ZWQgaXNhCTogZmQNCj4gbW11
ICAgICAgICAgICAgIDogc3YzOQ0KPiB1YXJjaCAgICAgICAgICAgOiBzaWZpdmUsdTU0LW1jDQo+
IA0KPiBNYXkgYmUgSSBhbSBqdXN0IHRyeWluZyBvdmVyIG9wdGltaXplIG9uZSBjb3JuZXIgY2Fz
ZSA6KSA6KS4NCj4gL3Byb2MvY3B1aW5mbyBzaG91bGQganVzdCBwcmludCBhbGwgdGhlIGlzYSBz
dHJpbmcuIFRoYXQncyBpdC4NCj4gDQoNClBpbmcgPw0KDQo+IFJlZ2FyZHMsDQo+IEF0aXNoDQoN
Ci0tIA0KUmVnYXJkcywNCkF0aXNoDQo=
