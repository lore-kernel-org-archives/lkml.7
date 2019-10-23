Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22E8ECA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 17:43:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8B2421872
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 17:43:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="l0DnzAZB";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="HttcN/Z/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731632AbfJWRm7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 13:42:59 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:33161 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731112AbfJWRm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 13:42:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1571852578; x=1603388578;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=c4CudQ10WLvR/3PXKwCE+8VTs2ntB+heiRySI+1CkPg=;
  b=l0DnzAZBWN4sDLsDArbG4PGcdvCfd4NqmUvZMCDEHD7W6yduDBmA6SU8
   mP8cG1j0OUwF7ZBDI7JJrSWKc08OqMwCCM56bxUHKWzEEBPl7bgF8xGv/
   l38AXXHYU63JCKaYaPQ5gKtML/reZtKcYg4UJqc2SHDtazUqjOmoNSDPN
   IZYaufp7EhGPewE6TB9HJtsEiGM8ihQOqQs1OMXmEzFJo1bSy3DYdicaw
   1bkwhAnwkRJyGFBNXxbX695IgyB2SdaWGqTMVPbFZ9S95tj56arAqpUj9
   PgmNrDR2Otwi5mu09jULws8CbJ7z05Qd+EooZwZK6V5mef9FhBPFne2P1
   Q==;
IronPort-SDR: b42L00FJ8PWMTQKMlJglTeTbC5UN5HilxPnXApfFU4Pe9B7UoJsCzzSJCv5h5l+J/ThS5lmMSR
 zTSDbL4b7ev6X0FlpzK3PZIuXJVr9QVWXqxgqFdkXRWZvIXKeqUe+79+HOKPSHl7KpGwIYydIQ
 1hvNwdl51BAYQ3E/g9rcCCePLkaQx+yO1VTFdW8uAdrZ2ELPU9dQWSheCQM8JbyWtwVeCMwoes
 /c9+jKrBEOOobfFfNJIG9lFhgsOjQ4r+zZh3ZCmXlVO/XNI23DjrdsBOn2Q9jbPzWc3YMLM83V
 2j0=
X-IronPort-AV: E=Sophos;i="5.68,221,1569254400"; 
   d="scan'208";a="121186004"
Received: from mail-dm3nam05lp2053.outbound.protection.outlook.com (HELO NAM05-DM3-obe.outbound.protection.outlook.com) ([104.47.49.53])
  by ob1.hgst.iphmx.com with ESMTP; 24 Oct 2019 01:42:56 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hLzGopOSzrm0glUo0o/2Sm8BoLTqEVjHN0U06JgC4c/oMFyWI6UpCWkEZu+xaAKjBAQCC/JsxcYwssfTJEP1xmn0qEplYu2wNICH2YsBGINKpUf4hrub7NZL2EFaKRRXp/9TGOAFpuSa4jp6OJTk0JIrb09mTFeO7Pf4AUipM6kmtASTNRR0pC/uYfc9OfkD4hYJ5FZ4YGoC1RPPWOW7MsTzN8+kvXLRSck5ipFGU/uq4L0TjGuGpJwc5fLkPaAfCYnDv8rsNKRCvaFiMQElXixbUifJBDDczAxs+JqP9K81/8sqt1cUu+pqhSsUgFbd0NOTWhjbLibBN4Kh0W16xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c4CudQ10WLvR/3PXKwCE+8VTs2ntB+heiRySI+1CkPg=;
 b=M5x2zYt8N8JE5e+Nut1NsObgsSFSQWkaLV449hxzL049qHJ0GG9HH7K5ldc2sLUcOm4N3jlrO+jw60ybkbOk+qFeqWH3c6cl7Gl2i4XYGAzqIFpAsHrL0ucw90AiYFIgu1C3viTbTG5Yzq9wVNaQ7sna/Zs3KGwSnd6uNOfqJoQ45hbS2WI3A94zraLf1YJXUz6+6lvz7r5OoyJIx5JUsh9RZpP8zM1dviFzZ/xjEM9eCW4xnmcYvLEr6TIYG7LhKqdUfRAysJuaP/5xO6XpasHdT/XVM1UB33EdLe7T3pidmkYYwL0i/7byXkLbm2SZ6eNICvUPuyIAYEaa36c88Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c4CudQ10WLvR/3PXKwCE+8VTs2ntB+heiRySI+1CkPg=;
 b=HttcN/Z/xBnzRju/LxRb80/nVZTIPBlCTYK9ItSiaH0jlrgl/BJ8y2EvB1HgqIe9D//9E7GBU8xAbLi4x4dpPqX9K9CgWQDC6yWTZP7bOkRc0yLtdh9KSdHPTJZ/SWstFlZsKbTm3+WIW/ndUMP1M05/fASYyudexeODosZRHFE=
Received: from BYAPR04MB4901.namprd04.prod.outlook.com (52.135.232.206) by
 BYAPR04MB4310.namprd04.prod.outlook.com (52.135.205.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Wed, 23 Oct 2019 17:42:55 +0000
Received: from BYAPR04MB4901.namprd04.prod.outlook.com
 ([fe80::4933:8361:f5e3:a6c6]) by BYAPR04MB4901.namprd04.prod.outlook.com
 ([fe80::4933:8361:f5e3:a6c6%4]) with mapi id 15.20.2387.021; Wed, 23 Oct 2019
 17:42:55 +0000
From:   Alistair Francis <Alistair.Francis@wdc.com>
To:     "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>
CC:     "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Atish Patra <Atish.Patra@wdc.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "rkir@google.com" <rkir@google.com>,
        Anup Patel <Anup.Patel@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "anup@brainfault.org" <anup@brainfault.org>,
        "palmer@sifive.com" <palmer@sifive.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>
Subject: Re: [PATCH v2 2/2] RISC-V: defconfig: Enable Goldfish RTC driver
Thread-Topic: [PATCH v2 2/2] RISC-V: defconfig: Enable Goldfish RTC driver
Thread-Index: AQHVc2vLFlE68F2kkUyeFzcwcqAG+qdXYO6AgAKZbICADTsXgIAAOUoAgAAmwoCAARToAA==
Date:   Wed, 23 Oct 2019 17:42:54 +0000
Message-ID: <678b7a7a82adb389e34f023d282a7935f41e356a.camel@wdc.com>
References: <20190925063706.56175-3-anup.patel@wdc.com>
         <mhng-edb410db-fdd1-46f6-84c3-ae3b843f7e3a@palmer-si-x1c4>
         <MN2PR04MB606160F5306A5F3C5D97FB788D900@MN2PR04MB6061.namprd04.prod.outlook.com>
         <alpine.DEB.2.21.9999.1910221213490.28831@viisi.sifive.com>
         <17db4a6244d09abf867daf2a6c10de6a5cd58c89.camel@wdc.com>
         <alpine.DEB.2.21.9999.1910221751500.25457@viisi.sifive.com>
In-Reply-To: <alpine.DEB.2.21.9999.1910221751500.25457@viisi.sifive.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alistair.Francis@wdc.com; 
x-originating-ip: [199.255.44.174]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: dc16d029-ddc2-43c1-458d-08d757e06f87
x-ms-traffictypediagnostic: BYAPR04MB4310:
x-ms-exchange-purlcount: 2
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB43100FC6DD8954726486AFE8906B0@BYAPR04MB4310.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 019919A9E4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(136003)(39860400002)(346002)(396003)(376002)(51444003)(189003)(199004)(86362001)(54906003)(5660300002)(71200400001)(81166006)(81156014)(6512007)(99286004)(6916009)(305945005)(71190400001)(316002)(6486002)(25786009)(8676002)(966005)(4001150100001)(6436002)(36756003)(6306002)(2351001)(2906002)(8936002)(4326008)(14454004)(102836004)(186003)(256004)(486006)(7736002)(118296001)(14444005)(5640700003)(6116002)(76176011)(478600001)(476003)(229853002)(446003)(26005)(3846002)(11346002)(66946007)(76116006)(66476007)(6246003)(66556008)(64756008)(66446008)(6506007)(2501003)(2616005)(66066001);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4310;H:BYAPR04MB4901.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZFUr+OWmLxCfuwCgqjx2NRzPCqk5oWfHUj7Rd5YX5fvguNloCu7rPjo4B83KCz+ZwALubYu+JEsPNtV0mIm9MTZRTdq2bytxL5p12YL0o1gv+qRAZiirg7+XqaBlkAcIDrpJGI6E5bL+jzrUDRm9cCznj6Nfbw995sKZFWsWDuACOFuEDP7q5Rj65SoH24i4e5FesRDX4WhkGs5m2pHoaHPw/1hQME/1SqUjcJ3asuKX0uyVdgtZNGnraxX0/VkjRaHK0myUzSAlqF5Hl0H0hVAANmsNhbgQLc975lDvbCG3nWwIPKj6IjX3DhOTGbletcavZUl5oDNSrGbHkqRb+bzhKi/uzpWEB4wEHvy/5zS0xjO5PWjW5Do2W7MCYqi5h4tKs9NjtxIrZLF94Tbnp/RwAINu9ijuI/8iTbnQ13udwY1DYwQjW+sHkLAcEkKUS8wunrSU5qMNHRQ16goKudo6sqkbMiZI68X0zI9uULE=
Content-Type: text/plain; charset="utf-8"
Content-ID: <27FB96AE614D134FA6D3A0E23FD80F14@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc16d029-ddc2-43c1-458d-08d757e06f87
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2019 17:42:54.9332
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YvXS9v1xdX7Rr2ERJdyNs5ozpxCEM/zAs5KTfS9hggPEgia7mIPL4qlVT/49R2h0UrMe2a0OD2mGwMXNJH3V+oIKbjf/bLtjNaMcO0oZlqw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4310
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE5LTEwLTIyIGF0IDE4OjA2IC0wNzAwLCBQYXVsIFdhbG1zbGV5IHdyb3RlOg0K
PiBPbiBUdWUsIDIyIE9jdCAyMDE5LCBBbGlzdGFpciBGcmFuY2lzIHdyb3RlOg0KPiANCj4gPiBJ
IHRoaW5rIGl0IG1ha2VzZSBzZW5zZSBmb3IgdGhpcyB0byBnbyBpbnRvIExpbnV4IGZpcnN0Lg0K
PiA+IA0KPiA+IFRoZSBRRU1VIHBhdGNoZXMgYXJlIGdvaW5nIHRvIGJlIGFjY2VwdGVkLCBqdXN0
IHNvbWUgbml0IHBpY2tpbmcgdG8NCj4gPiBkbw0KPiA+IGZpcnN0IDopDQo+ID4gDQo+ID4gQWZ0
ZXIgdGhhdCB3ZSBoYXZlIHRvIHdhaXQgZm9yIGEgUFIgYW5kIHRoZW4gYSBRRU1VIHJlbGVhc2Ug
dW50aWwNCj4gPiBtb3N0DQo+ID4gcGVvcGxlIHdpbGwgc2VlIHRoZSBjaGFuZ2UgaW4gUUVNVS4g
SW4gdGhhdCB0aW1lIExpbnV4IDUuNCB3aWxsIGJlDQo+ID4gcmVsZWFzZWQsIGlmIHRoaXMgY2Fu
IG1ha2UgaXQgaW50byA1LjQgdGhlbiBldmVyeW9uZSB1c2luZyA1LjQgd2lsbA0KPiA+IGdldA0K
PiA+IHRoZSBuZXcgUlRDIGFzIHNvb24gYXMgdGhleSB1cGdyYWRlIFFFTVUgKFFFTVUgcHJvdmlk
ZXMgdGhlIGRldmljZQ0KPiA+IHRyZWUpLiBJZiB0aGlzIGhhcyB0byB3YWl0IHVudGlsIFFFTVUg
aGFzIHN1cHBvcnQgdGhlbiBpdCB3b24ndCBiZQ0KPiA+IHN1cHBvcnRlZCBmb3IgdXNlcnMgdW50
aWwgZXZlbiBsYXRlci4NCj4gPiANCj4gPiBVc2VycyBhcmUgZ2VuZXJhbGx5IHNsb3cgdG8gdXBk
YXRlIGtlcm5lbHMgKGJ1aWxkcm9vdCBpcyBzdGlsbA0KPiA+IHVzaW5nDQo+ID4gNS4xIGJ5IGRl
ZmF1bHQgZm9yIGV4YW1wbGUpIHNvIHRoZSBzb29uZXIgY2hhbmdlcyBsaWtlIHRoaXMgZ28gaW4N
Cj4gPiB0aGUNCj4gPiBiZXR0ZXIuDQo+IA0KPiBUaGUgZGVmY29uZmlncyBhcmUgcmVhbGx5IGp1
c3QgZm9yIGtlcm5lbCBkZXZlbG9wZXJzLiAgV2UgZXhwZWN0DQo+IHVzZXJzIHRvIA0KPiBkZWZp
bmUgdGhlaXIgb3duIEtjb25maWdzIGZvciB0aGVpciBvd24gbmVlZHMuDQoNCkZyb20gZXhwZXJp
ZW5jZSBtb3N0IHBlb3BsZSB1c2UgdGhlIGRlZmNvbmZpZywgYXQgbGVhc3QgYXMgYSBzdGFydGlu
Zw0KcG9pbnQuDQoNCj4gDQo+IElmIHVzaW5nIHRoZSBHb2xkZmlzaCBjb2RlIHJlYWxseSBpcyB3
aGF0IHdlIGFsbCB3YW50IHRvIGRvIChzZWUNCj4gYmVsb3cpLCANCj4gdGhlbiB0aGUga2VybmVs
IHBhdGNoIHRoYXQgc2hvdWxkIGdvIGluIHJpZ2h0IGF3YXkgLS0gd2hpY2ggYWxzbyBoYXMNCj4g
bm8gDQo+IGRlcGVuZGVuY2Ugb24gd2hhdCBRRU1VIGRvZXMgLS0gd291bGQgYmUgdGhlIGZpcnN0
IHBhdGNoIG9mIHRoaXMNCj4gc2VyaWVzOg0KPiANCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
bGludXgtcmlzY3YvMjAxOTA5MjUwNjM3MDYuNTYxNzUtMi1hbnVwLnBhdGVsQHdkYy5jb20vDQoN
Ck9rLCBzbyBpdCBsb29rcyBsaWtlIHRoaXMgcGF0Y2ggd2lsbCBiZSBhIDUuNSBwYXRjaCBub3Qg
YSA1LjQgcGF0Y2guIEl0DQpsb29rcyBsaWtlIHRoYXQgY2FuJ3QgYmUgaGVscGVkLiBJIGp1c3Qg
ZG9uJ3Qgd2FudCB0aGUgZGVmY29uZmlnIGNoYW5nZQ0Kd2FpdGluZyBvbiBRRU1VIGFzIEkgdGhp
bmsgdGhhdCBqdXN0IHNsb3dzIGV2ZXJ5dGhpbmcgZG93bi4NCg0KPiANCj4gQW5kIHRoYXQgc2hv
dWxkIGdvIGluIHZpYSB3aG9ldmVyIGlzIG1haW50YWluaW5nIHRoZSBHb2xkZmlzaCBkcml2ZXIs
DQo+IG5vdCANCj4gdGhlIFJJU0MtViB0cmVlLiAgKEl0IGxvb2tzIGxpa2UgZHJpdmVycy9wbGF0
Zm9ybS9nb2xkZmlzaCBpcw0KPiBjb21wbGV0ZWx5IA0KPiB1bm1haW50YWluZWQgLSBhIHJlZCBm
bGFnISAtIHNvIHByb2JhYmx5IHNvbWVvbmUgbmVlZHMgdG8gcGVyc3VhZGUNCj4gR3JlZyBvciAN
Cj4gQW5kcmV3IHRvIHRha2UgaXQuKQ0KPiANCj4gSW5jaWRlbnRhbGx5LCBqdXN0IGxvb2tpbmcg
YXQgZHJpdmVycy9wbGF0Zm9ybS9nb2xkZmlzaCwgdGhhdCBkcml2ZXINCj4gc2VlbXMgDQo+IHRv
IGJlIHNvbWUgc29ydCBvZiBHb29nbGUtc3BlY2lmaWMgUlBDIGRyaXZlci4gIEFyZSB5b3UgYWxs
IHJlYWxseQ0KPiBzdXJlIA0KPiB5b3Ugd2FudCB0byBlbmFibGUgdGhhdCBqdXN0IGZvciBhbiBS
VEM/ICBTZWVtcyBsaWtlIG92ZXJraWxsIC0gdGhlcmUNCj4gYXJlIA0KPiBtdWNoIHNpbXBsZXIg
UlRDcyBvdXQgdGhlcmUuDQoNCkkgd2FzIHVuZGVyIHRoZSBpbXByZXNzaW9uIHRoYXQgZXZlcnlv
bmUgd2FzIG9uIGJvYXJkIHdpdGggdGhpcyBnb2luZw0KaW4uIEluIFFFTVUgbGFuZCBpdCBkb2Vz
bid0IG1ha2Ugc2Vuc2UgdG8gYWRkIGl0IGlmIHRoZSBrZXJuZWwgaXNuJ3QNCmdvaW5nIHRvLCBz
byB3ZSBuZWVkIHRvIGJlIG9uIHRoZSBzYW1lIHBhZ2UgaGVyZS4NCg0KRnJvbSB0aGUgb3RoZXIg
ZGlzY3Vzc2lvbnMgaXQgbG9va3MgbGlrZSB5b3UgYXJlIGhhcHB5IHdpdGggdGhpcyBjaGFuZ2UN
Cm92ZXJhbGwgcmlnaHQ/DQoNCkFsaXN0YWlyDQoNCj4gDQo+IA0KPiAtIFBhdWwNCj4gDQo+IF9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQo+IGxpbnV4LXJp
c2N2IG1haWxpbmcgbGlzdA0KPiBsaW51eC1yaXNjdkBsaXN0cy5pbmZyYWRlYWQub3JnDQo+IGh0
dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtcmlzY3YNCg==
