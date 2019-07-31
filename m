Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 071BDC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 00:35:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B191220665
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 00:35:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="dBVZpiuB";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="yHkwNk5E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726665AbfGaAfA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 20:35:00 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:38922 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbfGaAe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 20:34:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1564533319; x=1596069319;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=3MetdInZ0WXq/vRjEpP92VtQ0JemjZ9FQvZQE9X5sgo=;
  b=dBVZpiuBqzU7aIxBPxd7RpR9UDpSsULGeelBI8O7lKJLCdsfiQoEFtHm
   zLZbVOVO+vqCz+gel0r/NrS9MGEVsdrtod7sn2RQNYsvRW21QfTLWTltW
   4Gdk6FOpH9dwOoGLk4cy/e6vwVP10Wo+TCwq7h0dD6g+EUBUnhvXnFUBv
   1j+hcN+PCgSzT8DugJTDy5qJaT6RsZIHabka1mAxtwnQyenOcbrRAnOXO
   QHxEHhRySogOc/YWx6zeb1Nb/3Tbg1NHRCOB8mq80Kr4PWXK/btWP/Z3K
   v/Aw3upOWSMf+WV1q8qqgEwCUimzt3XunMmcVF7/dOwPTYpv/uLj+ZoDz
   A==;
IronPort-SDR: YZgUTS6vAL0wyZVefZ8Or1Sz6iDj3dFlcTRLWmF9JNUqY3RFKLAeGOYe5u+f/P0kM0BML9SkZz
 ddZevAL5iCb6FyynZZTiJFnvcyXgrKs2GXOm8d3OqhFZEG+jvTXWxcynJC5GNDg/JBYhvofWpF
 z4wVIVJUm0DI+JDxWIPokTGU6qGQgt6nI91+dzn0+PuvcGiOR5uii/KqfyJR76ZYJD4QqUV3zo
 giKUFMoZlnTc3cn00x0ktaXU+Cc9fXWPVikcp5eD7Sb2ISK1nIlgdFaa96iCEwQ1oc5QkQ/qCG
 slw=
X-IronPort-AV: E=Sophos;i="5.64,327,1559491200"; 
   d="scan'208";a="214726862"
Received: from mail-by2nam05lp2058.outbound.protection.outlook.com (HELO NAM05-BY2-obe.outbound.protection.outlook.com) ([104.47.50.58])
  by ob1.hgst.iphmx.com with ESMTP; 31 Jul 2019 08:35:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MDRwvNTGdIKklZ1Rk8sS4i4UKaibbGlSyJOM5qQDrf3ZydmVPJOQpGqNS4MpXTpUGlu8DB+Lfbbze088yybLTm5516q4zW5Lj/XO+rMucVbjM+r8AGxXVNeyK5slE4mQzV093+Q2g5y2pVlZglKWM5ZiFMMeqFnV8C75NaPfH2UHvUNyNNSkrGVo9mieaup5xTynAdKLkM8ZjblI/555j68RakCvxWfJyvF2Y7ULgpC+q6+0oe2ZAaifGjIySYuoaGnLrNFs+yN5b8M+cibB2msGdK1DgKMpjYyazLEPwkLVgqFqZ17FOcy2WbFRIZAJ+HGXipQJMrznNEX/BDbELw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3MetdInZ0WXq/vRjEpP92VtQ0JemjZ9FQvZQE9X5sgo=;
 b=kc1qmMU2fXg/Q67AVbxxDo3PNKb66U+EFxdvHbEvXpKnGYkilGpnYu0bHIo9zG1gL3PkZo2GOZ3c2MfMFmalnMoZg3CC9a135tM9N9hX3X59aJKmYS/uxZ2HmOR16HyObqc2hB/v+8pA/58g/tYvlSuDj8aXR/IDWgj4EziyjZDP+SFjjOwXZeGvsgw6vRBcOG5st3a+MNnl4l2BB5X7PTHb7d16+32+sFrptxy6sDOvnPu+pMTrWVbd0AsFDKpQfhdhvr3gmwcDiM89/2HXS/iuEfbieVz7uYzn963x/S/yT19wZBgbUNcQa08S2PaESVeH0hvvb5Yrja8qwY4oGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=wdc.com;dmarc=pass action=none header.from=wdc.com;dkim=pass
 header.d=wdc.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3MetdInZ0WXq/vRjEpP92VtQ0JemjZ9FQvZQE9X5sgo=;
 b=yHkwNk5E927zVeSbQl4J4gwxmnNsQCyprBXdcgCp4YPQ+xHkpE6g5kpGcbAOZhGoxBoekYY9X8N11qQBgZGhUISDObLDm6f+LVGY/oP6ln9YxSWo0wXYK2BkT6uXoMFhd9i72VV/fr/P5SJeYy12F5+bPtyfJo0qHPUGbR9NDFk=
Received: from BYAPR04MB3782.namprd04.prod.outlook.com (52.135.214.142) by
 BYAPR04MB6231.namprd04.prod.outlook.com (20.178.235.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.15; Wed, 31 Jul 2019 00:34:57 +0000
Received: from BYAPR04MB3782.namprd04.prod.outlook.com
 ([fe80::ac9a:967e:70a5:e926]) by BYAPR04MB3782.namprd04.prod.outlook.com
 ([fe80::ac9a:967e:70a5:e926%7]) with mapi id 15.20.2115.005; Wed, 31 Jul 2019
 00:34:57 +0000
From:   Atish Patra <Atish.Patra@wdc.com>
To:     "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>
CC:     "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Anup Patel <Anup.Patel@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "johan@kernel.org" <johan@kernel.org>,
        "anup@brainfault.org" <anup@brainfault.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "alankao@andestech.com" <alankao@andestech.com>,
        "palmer@sifive.com" <palmer@sifive.com>,
        "allison@lohutok.net" <allison@lohutok.net>
Subject: Re: [PATCH 3/4] RISC-V: Support case insensitive ISA string parsing.
Thread-Topic: [PATCH 3/4] RISC-V: Support case insensitive ISA string parsing.
Thread-Index: AQHVQ+refROWkRWGQ0GJqrWaHX74e6bdXtyAgAAaDYCAABM8AIAAMKIAgABcAYCAAAOGAIAAAveAgAPQpgCAAfB4AIAAB1QA
Date:   Wed, 31 Jul 2019 00:34:57 +0000
Message-ID: <021f5c82273d643b28567a3dd05254492d53bf5c.camel@wdc.com>
References: <20190726194638.8068-1-atish.patra@wdc.com>
          <20190726194638.8068-3-atish.patra@wdc.com>
          <alpine.DEB.2.21.9999.1907261346560.26670@viisi.sifive.com>
          <a8a6be2c-2dcb-fe58-2c32-e3baa357819c@wdc.com>
          <alpine.DEB.2.21.9999.1907261625220.26670@viisi.sifive.com>
         <MN2PR04MB6061790AFE4E0AAA838678028DC30@MN2PR04MB6061.namprd04.prod.outlook.com>
          <alpine.DEB.2.21.9999.1907270043190.26998@viisi.sifive.com>
          <CAAhSdy0Eycc0ORSnh6LJeC_D_x9yLOkoc7OkPNuN6qOcZEGVWg@mail.gmail.com>
          <alpine.DEB.2.21.9999.1907270108420.26998@viisi.sifive.com>
         <8ed4d461ffe5ac41b475d22b38019578b29a8d09.camel@wdc.com>
         <alpine.DEB.2.21.9999.1907301611040.4874@viisi.sifive.com>
In-Reply-To: <alpine.DEB.2.21.9999.1907301611040.4874@viisi.sifive.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Atish.Patra@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3cc3651f-0f8c-48ef-5a9a-08d7154eea22
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB6231;
x-ms-traffictypediagnostic: BYAPR04MB6231:
x-microsoft-antispam-prvs: <BYAPR04MB623179624F7EE3E5196F2015FADF0@BYAPR04MB6231.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 011579F31F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(366004)(376002)(346002)(39860400002)(396003)(189003)(199004)(66556008)(3846002)(6116002)(66946007)(4326008)(66476007)(64756008)(2906002)(6512007)(66446008)(66066001)(53936002)(229853002)(478600001)(118296001)(186003)(25786009)(76176011)(26005)(99286004)(36756003)(6506007)(7416002)(76116006)(102836004)(305945005)(14454004)(71200400001)(2501003)(256004)(7736002)(6436002)(68736007)(316002)(5640700003)(2351001)(14444005)(2616005)(11346002)(476003)(446003)(486006)(81156014)(6916009)(5660300002)(8936002)(81166006)(6246003)(54906003)(71190400001)(6486002)(8676002)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB6231;H:BYAPR04MB3782.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: EnBq2rZO6+GleWZXjqYhY99pKSIRyh5iIcdxi+t64Qu8IxHXTYR3RBvn3zXUbVTm07DyIFG98TjB63KT7e3V2EHoXp1N/USDyTVDRztQq3QXfGmHoaBaCPz4NKi67zhvYPHqcSQyHw0CTYaHy+Wb2TL2nDvmJAjedQE1Qvh/5MXcZ2ukcSghRQQpxOpZlXAwTsHHLgNd2FG2pl1HWCxu/6BEiLhyxFuiDvs8OXyrYaBpGwaP87LwvCtQXHMl2Tm2TUq9EVEp03jYtHLpA087706IjYCyGuNzwung0ktsiBn2mF3mlZ59UX7+zOgTIGAUK0+WtW6bZ0PDy6np5+sXKHBNyYZxKXV/qctdXXQ9nQMxJ1wchs/o+3JBnQruqlrFC1DBrynG97Y3pFVTSsFlF5DOVpMFdgQ+65edXvTcJYo=
Content-Type: text/plain; charset="utf-8"
Content-ID: <78F5DFFDA7A3B3408CE1699C068FB1F6@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cc3651f-0f8c-48ef-5a9a-08d7154eea22
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2019 00:34:57.4767
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Atish.Patra@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB6231
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE5LTA3LTMwIGF0IDE3OjA4IC0wNzAwLCBQYXVsIFdhbG1zbGV5IHdyb3RlOg0K
PiBPbiBNb24sIDI5IEp1bCAyMDE5LCBBdGlzaCBQYXRyYSB3cm90ZToNCj4gDQo+ID4gVGhlIHlh
bWwgZG9jdW1lbnQgZGlkIG5vdCBzcGVjaWZ5IGFueXRoaW5nIGFib3V0IGFsbCBpc2Etc3RyaW5n
cw0KPiA+IGhhcyB0byANCj4gPiBiZSBsb3dlcmNhc2UgdW5sZXNzIEkgbWlzc2VkIHNvbWV0aGlu
Zy4gVGhlIHR3byBlbnVtIHZhbHVlcyBhcmUNCj4gPiBhbGwgDQo+ID4gbG93ZXJjYXNlIGJ1dCB0
aGUgZGVzY3JpcHRpb24gc2F5cyBhbGwgSVNBIHN0cmluZ3MgYXJlIGRvY3VtZW50ZWQNCj4gPiBp
biBJU0EgDQo+ID4gc3BlY2lmaWNhdGlvbiB3aGljaCBkZXNjcmliZXMgdGhlIElTQSBzdHJpbmdz
IHRvIGJlIGNhc2UNCj4gPiBpbnNlbnNpdGl2ZS4gDQo+ID4gSU1ITywgdGhpcyBjcmVhdGVzIGNv
bmZ1c2lvbiByZXN1bHRpbmcgdGhlIHBhdGNoLg0KPiANCj4gSWYgaXQncyBoZWxwZnVsIGluIHVu
ZGVyc3RhbmRpbmcgbXkgZWFybGllciBjb21tZW50cywgSSBkb24ndCB0aGluaw0KPiB0aGF0IA0K
PiB5b3VyIHBhdGNoZXMgd2VyZSAid3JvbmcsIiBvciBhbnl0aGluZyBsaWtlIHRoYXQuICBBbmQg
eW91J3JlIHJpZ2h0DQo+IHRoYXQgDQo+IHRoZSBEVCBZQU1MIGJpbmRpbmcgZG9lcyBub3QgdW5l
cXVpdm9jYWxseSBzdGF0ZSB0aGF0IGFsbCBmdXR1cmUNCj4gYWRkaXRpb25zIA0KPiB0byB0aGUg
cmlzY3YsaXNhIHN0cmluZyBtdXN0IGJlIGluIGxvd2VyY2FzZS4gIEJ1dCB0byBiZSBjbGVhciwg
dGhlDQo+IERUIA0KPiBZQU1MIHNjaGVtYSBkZWZpbmVzIGV4YWN0bHkgd2hhdCBpcyBjdXJyZW50
bHkgcGVybWlzc2libGUgZm9yDQo+IHJpc2N2LGlzYSANCj4gc3RyaW5ncyBpbiBrZXJuZWwtb3Jp
ZW50ZWQgRFQgZGF0YSwgYW5kIHJpZ2h0IG5vdywgYWxsIG9mIHRoZQ0KPiBwZXJtaXNzaWJsZSAN
Cj4gdmFsdWVzIGFyZSBsb3dlcmNhc2UuDQo+IA0KDQpHb2luZyBmb3J3YXJkLCB5YW1sIHNjaGVt
YSBzaG91bGQgZGVmaW5lIG9ubHkgdGhlIG1hbmRhdG9yeSBpc2Egc3RyaW5ncw0KKGkuZS4gcnY2
NGltYWZkYykgb3IgdGhlIGxpc3Qgc2hvdWxkIGJlIHVwZGF0ZWQgYXMgd2Uga2VlcCBhZGRpbmcg
bmV3DQpleHRlbnNpb25zIChpLmUuIHJ2NjRpbWFmZGNoIHdpdGgga3ZtIHBhdGNoZXMpLg0KDQoN
Cj4gR29vZCBMaW51eCBrZXJuZWwgcGF0Y2hlcyBhcmUgZHJpdmVuIGJ5IGNsZWFyIGZ1bmN0aW9u
YWwNCj4gbW90aXZhdGlvbnMuICANCj4gTGlrZSwgIlRoZSBjdXJyZW50IGtlcm5lbCBjcmFzaGVz
IG9yIGRvZXNuJ3Qgc3VwcG9ydCB0aGUgaGFyZHdhcmUgaW4gDQo+IHNpdHVhdGlvbiBYOyB0aHVz
IHdlIGNoYW5nZSB0aGUga2VybmVsIHRvIGFkZCBmZWF0dXJlIG9yIGJ1Z2ZpeA0KPiBZLiIgIEFu
ZCANCj4gaW4gdGhlIGtlcm5lbCwgc29sdXRpb25zIHRoYXQgaW52b2x2ZSBmZXdlciBsaW5lcyBv
ZiBjb2RlIGFyZQ0KPiBnZW5lcmFsbHkgDQo+IHByZWZlcnJlZCB0byBzb2x1dGlvbnMgdGhhdCBp
bnZvbHZlIG1vcmUgbGluZXMgb2YgY29kZSAtIG1vcmUgYnVncywNCj4gbW9yZSANCj4gbm9pc2Us
IGV0Yy4gIA0KPiANCg0KSSBjb21wbGV0ZWx5IGFncmVlIHdpdGggeW91IG9uIHRoaXMuDQoNCj4g
V2hlcmUgdGhlc2UgY2FzZS1pbnNlbnNpdGl2aXR5IHBhcnNpbmcgcGF0Y2hlcyBmYWxsIHNob3J0
LCBpbiBteQ0KPiBvcGluaW9uLCANCj4gaXMgdGhhdCB0aGV5IGRvbid0IGhhdmUgc3Ryb25nIGZ1
bmN0aW9uYWwgbW90aXZhdGlvbnMuICBUaGVyZSdzIGJlZW4NCj4gYSANCj4gcHJlY2VkZW50IGZv
ciBhIGZldyB5ZWFycyBub3cgaW4gdGhlIG1haW5saW5lIGtlcm5lbCB0aGF0IHRoZSBSSVNDLVYN
Cj4gSVNBIA0KPiBzdHJpbmcgaXMgYWxsIGxvd2VyY2FzZS4gIEkndmUgYXNrZWQgeW91IGFuZCBB
bnVwIGZvciBzaXR1YXRpb25zDQo+IHdoZXJlIA0KPiB0aGF0IHByZWNlZGVudCBpc24ndCBzdWZm
aWNpZW50IHRvIGhhbmRsZSBmdW5jdGlvbmFsaXR5IHRoYXQncw0KPiBkZXNjcmliZWQgDQo+IGlu
IHRoZSBSSVNDLVYgc3BlY2lmaWNhdGlvbiwgb3IgdG8gcGhyYXNlIGl0IGRpZmZlcmVudGx5LCAi
d2hhdA0KPiBicmVha3MgaWYgDQo+IHdlIGRvbid0IG1ha2UgdGhpcyBjaGFuZ2U/IiAgU28gZmFy
IG5vIG9uZSdzIGJlZW4gYWJsZSB0byBjaXRlDQo+IGFueXRoaW5nIA0KPiBoZXJlLiAgVGhlcmUn
cyBqdXN0IGEgcmVwZWF0ZWQgYXBwZWFsIHRvIGF1dGhvcml0eSB0byB0aGUgc2VjdGlvbiBvZg0K
PiB0aGUgDQo+IFJJU0MtViBzcGVjaWZpY2F0aW9uIHRoYXQgc3RhdGVzIHRoYXQgIlt0XWhlIElT
QSBuYW1pbmcgc3RyaW5ncyBhcmUNCj4gY2FzZSANCj4gaW5zZW5zaXRpdmUuIiAgQXMgeW91IGNh
biBwcm9iYWJseSBzZW5zZSwgdGhpcyBkb2Vzbid0IHNlZW0gbGlrZSBhDQo+IHN0cm9uZyANCj4g
anVzdGlmaWNhdGlvbiBmb3IgY2hhbmdpbmcgdGhlIGV4aXN0aW5nIGJlaGF2aW9yLiAgRnJvbSBh
IGZ1bmN0aW9uYWwNCj4gcG9pbnQgDQo+IG9mIHZpZXcsIGlmIGNhc2UgZG9lc24ndCBtYXR0ZXIs
IHdoeSBjYXJlIGlmIHRoZSBEVCBkYXRhIGFuZCBrZXJuZWwNCj4gb25seSANCj4gc3VwcG9ydCBs
b3dlcmNhc2Ugc3RyaW5ncz8gIEFuIGFsbC1sb3dlcmNhc2Ugc3RyaW5nIHNob3VsZCBiZQ0KPiBm
dW5jdGlvbmFsbHkgDQo+IGVxdWl2YWxlbnQgdG8gYW4gYWxsLXVwcGVyY2FzZSBvciBtaXhlZC1j
YXNlIHN0cmluZy4gIFNpbmNlIHRoZXJlJ3MNCj4gbm8gDQo+IGZ1bmN0aW9uYWwgcG9pbnQgdG8g
dGhlIGNoYW5nZXMsY2F1c2UgbXlzdGVyaW91cyBEVCBwYXJzaW5nIHByb2JsZW1zLg0KPiAgd2h5
IGFkZCBtb3JlIGNvZGUgdG8gdGhlIGtlcm5lbD8NCj4gDQoNClRoZXJlIHdhcyBubyBpbW1lZGlh
dGUgZnVuY3Rpb25hbCByZXF1aXJlbWVudCBidXQgdG8gaGF2ZSBhIG1vcmUgZnV0dXJlDQpwcm9v
ZiBjb2RlLiBBcyBJIHNhaWQgZWFybGllciwgdGhlIGlkZWEgb2YgdGhlIHBhdGNoIGNhbWUgZnJv
bSB0aGUNCmNvbmZ1c2lvbiBjcmVhdGVkIGJ5IGRpc2NyZXBhbmNpZXMgYmV0d2VlbiB0d28gZGlm
ZmVyZW50IHBpZWNlIG9mDQpkb2N1bWVudGF0aW9uL3NwZWNpZmljYXRpb24uIEFzIGxvbmcgdGhv
c2UgYXJlIHJlc29sdmVkLCBhYnNvbHV0ZWx5IG5vDQpuZWVkIG9mIHRoaXMgcGF0Y2guDQoNCg0K
PiBMYXRlciBpbiB5b3VyIEUtbWFpbCwgaXQgc291bmRzIGxpa2UgeW91IHVsdGltYXRlbHkgYWdy
ZWUgd2l0aCB0aGVzZQ0KPiBiYXNpYyANCj4gY29uY2x1c2lvbnMuICBJZiB0aGF0J3Mgc28sIEkg
ZG9uJ3QgdW5kZXJzdGFuZCB0aGUgYW1vdW50IG9mIGVmZm9ydA0KPiB0aGF0IA0KPiB5b3UgYW5k
IEFudXAgaGF2ZSBwdXQgaW50byBwdXNoaW5nIGJhY2sgaGVyZS4gIFRoZXJlJ3Mgbm90aGluZw0K
PiBwZXJzb25hbCANCj4gYWJvdXQgdGhlc2UgcmV2aWV3IGNvbW1lbnRzLiAgSWYgdGhlcmUncyBz
b21lIG1ldGEtcHJvYmxlbSBoZXJlDQo+IHRoYXQncyANCj4gdW5yZWxhdGVkIHRvIHRoZSB0ZWNo
bmljYWwgbWVyaXQgb2YgdGhlIHBhdGNoZXMsIHBsZWFzZSBzZW5kIGENCj4gcHJpdmF0ZSANCj4g
RS1tYWlsLiAgT3RoZXJ3aXNlLCBpZiB5b3UgZGlzYWdyZWUgd2l0aCB0aGUgZnVuY3Rpb25hbCBj
b25jbHVzaW9ucw0KPiBpbiB0aGUgDQo+IHByZXZpb3VzIHBhcmFncmFwaCwgbGV0J3MgaGFzaCB0
aGUgaXNzdWVzIG91dCBoZXJlLg0KPiANCj4gPiBJIGFtIGZpbmUgd2l0aCBkcm9wcGluZyB0aGlz
IHBhdGNoIGlmIHlhbWwgY2xlYXJseSBkb2N1bWVudCB0aGUNCj4gPiBjYXNlIA0KPiA+IHNlbnNp
dGl0dmUgdGhpbmcuDQo+IA0KPiBHcmVhdCEgIElmIHlvdSBzdGlsbCB0aGluayBzbyBub3csIGxl
dCdzIHJlc29sdmUgdGhpcyBpc3N1ZSB3aXRoIGEgDQo+IG9uZS1saW5lIHBhdGNoIHRvIHRoZSBE
VCBZQU1MIHNjaGVtYSB0byBub3RlIHRoYXQgcmlzY3YsaXNhIERUDQo+IHN0cmluZyANCj4gdmFs
dWVzIHNob3VsZCBiZSBhbGwgbG93ZXJjYXNlLiAgV2lsbCB5b3Ugc2VuZCBhIHBhdGNoPw0KPiAN
Cg0KWWVhaC4gU2VuZGluZyBpdCByaWdodCBub3cuDQoNClJlZ2FyZHMsDQpBdGlzaA0KPiANCj4g
LSBQYXVsDQoNCg==
