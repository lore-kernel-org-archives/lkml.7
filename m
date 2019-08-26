Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D55AC3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 21:31:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9FFA2186A
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 21:30:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="F/7YWmpN";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="L0B5m7oq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728692AbfHZVa6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 17:30:58 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:48769 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728673AbfHZVa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 17:30:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1566855057; x=1598391057;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=5BJupO2P2MXByAB7nW3DTmi/HATfgl2wmvbsUkO9Q30=;
  b=F/7YWmpN+0ftE2KgiuZrRZSc/fs8hqhE28BMQqjtnb8ZSybmqQDU+cnC
   qA1poReEGQoq65UAcuT4vcWtFGbEBn/wHpjU6foenPJyNIzkY0bC1aOvr
   A+5W8IKmdYwv1RsCJhThOEFpAwIcUsGvehFV/+qox0vVds4Zww9ae0uGE
   yyO0WIa3D9gUFMIAvRnRcfUbQC9tSnUnAatX9acTk0uVxgJRM1h3xbNTv
   6yEFY/+6jfX21vR6rf6lzoW9Z8EXuq/p0vGBHfShDKaBSdi5KCPgFutRb
   qzH+h5LPQ0aEggF0nUI+u1DZi6SQAlxZpJlXoAR0C41DF0eZ3KQC0JctK
   w==;
IronPort-SDR: 9T1w6kcOFBskE180WkZ42D98KBypI25kNMM0kPusZcrXy47w5+K/Kl2GwqO6RK79Q+wUafUOlv
 lhIU+StDcKAxYd8tY389zs8lTI4n+sFCOSCOX6fWrgc+phIYnTIDMuIgs/M/WYXYubaV/rhZ23
 mG3X11WL5PBgF1+aaE3jfEX0UTWZUj9V9pFy1npRXtoD29MfRPnTAtZ02Uac0TP2YBgARWVXIA
 oCZ/U/VcKjKhdusj4j647yWZtvAav4s8a09rSf0+ruO7MQdGvnQLr3tqh0fFntI9J+HdVlkY1V
 0pA=
X-IronPort-AV: E=Sophos;i="5.64,433,1559491200"; 
   d="scan'208";a="223351873"
Received: from mail-co1nam05lp2051.outbound.protection.outlook.com (HELO NAM05-CO1-obe.outbound.protection.outlook.com) ([104.47.48.51])
  by ob1.hgst.iphmx.com with ESMTP; 27 Aug 2019 05:30:56 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ligIkPFpTz/773MnDzsqR4JwUzK/kh0/x3D44pEO9+9ZY0hMO7ul9V3TUlZ6GrcbM54VNczHvI19YS85FCDjG9u3cG2OObodVyEUmWGaSauvffvKU04OId3hTJgCfzVdwBa33/jkPeEQYGuL2QnuTfgtSpAfDmgBmP3vgICqO4CzOY/fU9z403JPC5dn6qEEmJSjA+lA7SA75hwlr+XU5Z1Z3oUw6J2ryc4DDzZeE7pXbpjbgEFLGeW+S6VMhqLv/L9vmzmJOIkhLRmHKFsFetw7d9OrbNL+VCykacT4HWg7wV1B6LmwOT+xF4ikedGC1ldsDBUCUe39rg0E8vsOqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5BJupO2P2MXByAB7nW3DTmi/HATfgl2wmvbsUkO9Q30=;
 b=dz31MgY+0V+sKRAYGoEJSztab6o8Pw5fz2IX1Ks1+p5+VlVVCA2f4KxTGO/Pt7WrRvso49D0M7F523uzxMHeh+aVlHgcASyAhMsee+v9qTwuQOubEZpEZQgv4oa1dJ5UVJ1M7RQ3axLfzwK3LNCG/MHutMRCbCr1WzStTOhIH4LpXba2d39LKc+euCIIYkV11gm7rp7qw6aMJHSxTDX1ogNwGK9ZtYsLb9wbahPaQPDcX2uwrQnR9oOSnqDFQPxgjg342XSucVa6EztyIuDFxhznt/yf96DKCceK2q88I5pFKcAstmD1MUNHgRQC0x76fn9JXyn0Z/iuwrsNrC6ksg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5BJupO2P2MXByAB7nW3DTmi/HATfgl2wmvbsUkO9Q30=;
 b=L0B5m7oqDlECS9+QR0mF+hHrZVWZoLWw1Q2APhRvDOXIbOCyaO6hZY5A760kJ9w/xPMF/qZZM4ZZGCYlfRIc4kcfEsKmoZcBZU2yyW12QqzpuVjmPe7T4r/sexQ1CFqbymImpX/a4Awi5APq7KCwArfQitbxYsl2JSXkAme+NJY=
Received: from DM6PR04MB4908.namprd04.prod.outlook.com (20.176.109.81) by
 DM6PR04MB5099.namprd04.prod.outlook.com (20.176.110.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Mon, 26 Aug 2019 21:30:56 +0000
Received: from DM6PR04MB4908.namprd04.prod.outlook.com
 ([fe80::99f2:1c81:ffbd:c597]) by DM6PR04MB4908.namprd04.prod.outlook.com
 ([fe80::99f2:1c81:ffbd:c597%7]) with mapi id 15.20.2178.022; Mon, 26 Aug 2019
 21:30:56 +0000
From:   Alistair Francis <Alistair.Francis@wdc.com>
To:     "anup@brainfault.org" <anup@brainfault.org>,
        "palmer@sifive.com" <palmer@sifive.com>
CC:     "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Atish Patra <Atish.Patra@wdc.com>,
        "hch@infradead.org" <hch@infradead.org>,
        Anup Patel <Anup.Patel@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] RISC-V: Fix FIXMAP area corruption on RV32 systems
Thread-Topic: [PATCH] RISC-V: Fix FIXMAP area corruption on RV32 systems
Thread-Index: AQHVVCiwkrMhoC888UyZ9cBEv4GnHKcBOo8AgACv9oCADBSMgIAAAq+A
Date:   Mon, 26 Aug 2019 21:30:55 +0000
Message-ID: <90b3e0574528bbacc0392079d4df94a1b377f7ea.camel@wdc.com>
References: <mhng-7a475a74-60cb-4e3f-bcae-6cd6299bb173@palmer-si-x1c4>
In-Reply-To: <mhng-7a475a74-60cb-4e3f-bcae-6cd6299bb173@palmer-si-x1c4>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alistair.Francis@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2c40e6d9-64e4-4854-db22-08d72a6cae00
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DM6PR04MB5099;
x-ms-traffictypediagnostic: DM6PR04MB5099:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR04MB5099CD221EAD80322E4B2DCC90A10@DM6PR04MB5099.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 01415BB535
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(396003)(366004)(346002)(376002)(136003)(189003)(199004)(71200400001)(71190400001)(66946007)(66446008)(64756008)(66556008)(66476007)(54906003)(81166006)(5660300002)(2906002)(14444005)(256004)(91956017)(76116006)(14454004)(36756003)(305945005)(66066001)(7736002)(478600001)(2501003)(26005)(316002)(53936002)(6512007)(186003)(2616005)(446003)(486006)(476003)(11346002)(86362001)(6436002)(6486002)(4326008)(76176011)(6116002)(118296001)(102836004)(229853002)(25786009)(53546011)(8936002)(6506007)(99286004)(8676002)(6246003)(3846002)(110136005)(81156014);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR04MB5099;H:DM6PR04MB4908.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: fRH398s6NbXdlxBNfZ7uiOcGR2VYCFUu5biJkgXZ1FbLl4XcdZ8ddZqg98Kz9t0H4Mmn/m6UpMWT3yu0nADTuXlb0AB0ZzJIxIWlU/9x4cFsvrrtE/4d+8Sl7on62AzGSX2xtZH1+8Ya6GWzGVzGFNNg/w2Td9jM4y7HpchSCOWg4sOox6jc2C36TngX8nx8mLI0wwKOt9KW2EUnVeJaub/VpdTheABa0xaEXyprCheIoKyP01/ybhZeEo3NbdZlNisIrxwMflX1sMm5I0t1pkE841i2tDzhgkXDKM8Y9j4tM/sX/mEBUyra8iy1dHXhyj/06E4zz9UTqiePcN+8CQjyI4Xfm+QplzIB/+IBYEmHjrKB1b3XkUKThBVA2UDY6eTubSizQMEnGxw/wAeF326F9pK+eXqZIsDoDGfxB8w=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0844F0D5BBE00A4F902ED4508409B335@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c40e6d9-64e4-4854-db22-08d72a6cae00
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2019 21:30:55.7972
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z29GVfNUDD1J/FvD0N9gWzBKlwPnidaKy9RFG5z4HrgEWLJp6y2EZeSGaz2As/ym3HFNnG00pLi8dUHcTsAcU66J3IY1N+Y6KUcvLS6HSQQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5099
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDE5LTA4LTI2IGF0IDE0OjE3IC0wNzAwLCBQYWxtZXIgRGFiYmVsdCB3cm90ZToN
Cj4gT24gU3VuLCAxOCBBdWcgMjAxOSAyMTo0OTowMSBQRFQgKC0wNzAwKSwgYW51cEBicmFpbmZh
dWx0Lm9yZyB3cm90ZToNCj4gPiBPbiBTdW4sIEF1ZyAxOCwgMjAxOSBhdCAxMTo0OSBQTSBDaHJp
c3RvcGggSGVsbHdpZyA8DQo+ID4gaGNoQGluZnJhZGVhZC5vcmc+IHdyb3RlOg0KPiA+ID4gPiAr
I2RlZmluZSBGSVhBRERSX1RPUCAgICAgIChWTUFMTE9DX1NUQVJUKQ0KPiA+ID4gDQo+ID4gPiBO
aXQ6IG5vIG5lZWQgZm9yIHRoZSBicmFjZXMsIHRoZSBkZWZpbml0aW9ucyBiZWxvdyBkb24ndCB1
c2UgaXQNCj4gPiA+IGVpdGhlci4NCj4gPiANCj4gPiBTdXJlLCBJIHdpbGwgdXBkYXRlIGFuZCBz
ZW5kIHYyIHNvb24uDQo+ID4gDQo+ID4gPiA+ICsjaWZkZWYgQ09ORklHXzY0QklUDQo+ID4gPiA+
ICsjZGVmaW5lIEZJWEFERFJfU0laRSAgICAgUE1EX1NJWkUNCj4gPiA+ID4gKyNlbHNlDQo+ID4g
PiA+ICsjZGVmaW5lIEZJWEFERFJfU0laRSAgICAgUEdESVJfU0laRQ0KPiA+ID4gPiArI2VuZGlm
DQo+ID4gPiA+ICsjZGVmaW5lIEZJWEFERFJfU1RBUlQgICAgKEZJWEFERFJfVE9QIC0gRklYQURE
Ul9TSVpFKQ0KPiA+ID4gPiArDQo+ID4gPiA+ICAvKg0KPiA+ID4gPiAtICogVGFzayBzaXplIGlz
IDB4NDAwMDAwMDAwMCBmb3IgUlY2NCBvciAweGI4MDAwMDAgZm9yIFJWMzIuDQo+ID4gPiA+ICsg
KiBUYXNrIHNpemUgaXMgMHg0MDAwMDAwMDAwIGZvciBSVjY0IG9yIDB4OWZjMDAwMDAgZm9yIFJW
MzIuDQo+ID4gPiA+ICAgKiBOb3RlIHRoYXQgUEdESVJfU0laRSBtdXN0IGV2ZW5seSBkaXZpZGUg
VEFTS19TSVpFLg0KPiA+ID4gPiAgICovDQo+ID4gPiA+ICAjaWZkZWYgQ09ORklHXzY0QklUDQo+
ID4gPiA+ICAjZGVmaW5lIFRBU0tfU0laRSAoUEdESVJfU0laRSAqIFBUUlNfUEVSX1BHRCAvIDIp
DQo+ID4gPiA+ICAjZWxzZQ0KPiA+ID4gPiAtI2RlZmluZSBUQVNLX1NJWkUgVk1BTExPQ19TVEFS
VA0KPiA+ID4gPiArI2RlZmluZSBUQVNLX1NJWkUgRklYQUREUl9TVEFSVA0KPiA+ID4gPiAgI2Vu
ZGlmDQo+ID4gPiANCj4gPiA+IE1lbnRpb25pbmcgdGhlIGFkZHJlc3NlcyBpcyBhIGxpdHRsZSB3
ZWlyZC4gIElNSE8gdGhpcyB3b3VsZCBiZQ0KPiA+ID4gYSBtdWNoIG5pY2VyIHBsYWNlIHRvIGV4
cGxhaW4gdGhlIGhpZ2gtbGV2ZWwgbWVtb3J5IGxheW91dCwNCj4gPiA+IGluY2x1ZGluZw0KPiA+
ID4gbWF5YmUgYSBsaXR0bGUgQVNDSUkgYXJ0LiAgQWxzbyB3ZSBjb3VsZCBoYXZlIG9uZSAjaWZk
ZWYNCj4gPiA+IENPTkZJR182NEJJVA0KPiA+ID4gZm9yIGJvdGggcmVsYXRlZCB2YWx1ZXMuICBM
YXN0IGJ1dCBub3QgbGVhc3QgaW5zdGVhZCBvZiBzYXlpbmcNCj4gPiA+IHRoYXQNCj4gPiA+IHNv
bWV0aGluZyBzaG91bGQgYmUgZGl2aWRhYmxlIGl0IHdvdWxkIGJlIG5pY2UgdG8gaGF2ZSBhDQo+
ID4gPiBCVUlMRF9CVUdfT04NCj4gPiA+IHRvIGVuZm9yY2UgaXQuDQo+ID4gPiANCj4gPiA+IEVp
dGhlciB3YXkgd2UgYXJlIGxhdGUgaW4gdGhlIGN5Y2xlLCBzbyBJIGd1ZXNzIHRoaXMgaXMgb2sg
Zm9yDQo+ID4gPiBub3c6DQo+ID4gPiANCj4gPiA+IFJldmlld2VkLWJ5OiBDaHJpc3RvcGggSGVs
bHdpZyA8aGNoQGxzdC5kZT4NCj4gPiA+IA0KPiA+ID4gQnV0IEknZCBsb3ZlIHRvIHNlZSB0aGlz
IGFyZWEgaW1wcm92ZWQgYSBsaXR0bGUgZnVydGhlciBhcyBpdCBpcw0KPiA+ID4gZnVsbA0KPiA+
ID4gb2YgbWluZSBmaWVsZHMuDQo+ID4gDQo+ID4gSSBhZ3JlZSB3aXRoIHlvdS4gV2UgYWxzbyBo
YXZlIFNwYXJzZW1lbSBhbmQgS0FTQU4gcGF0Y2hlcyB3aGljaA0KPiA+IHRvdWNoIHZpcnR1YWwg
bWVtb3J5IGxheW91dCBzbyBpdCdzIGltcG9ydGFudCB0byBoYXZlIHZpcnR1YWwNCj4gPiBtZW1v
cnkgbGF5b3V0DQo+ID4gZG9jdW1lbnRlZCBjbGVhcmx5LiBJIGNhbiBhZGQgdGhlIHJlcXVpcmVk
IGRvY3VtZW50YXRpb24gYXMNCj4gPiBzZXBhcmF0ZSBwYXRjaC4NCj4gDQo+IERvY3VtZW50YXRp
b24gaXMgZ3JlYXQsIGJ1dCBpZiB3ZSBkb2N1bWVudCBzb21ldGhpbmcgdGhhdCBpcyBicm9rZW4N
Cj4gdGhlbiBpdCdzIA0KPiBzdGlsbCBicm9rZW4gOikNCg0KSSdtIGNvbmZ1c2VkIGhlcmUuIFdo
YXQgaXMgYnJva2VuPw0KDQpSaWdodCBub3cgUlYzMiBkb2VzIG5vdCB3b3JrIHdpdGggdGhlIDUu
MyBrZXJuZWwgYW5kIHRoaXMgcGF0Y2ggZml4ZXMNCnRoZSByZWdyZXNzaW9uLg0KDQo+IA0KPiBJ
IHRoaW5rIHRoaXMgbmVlZHMgdG8ganVzdCBiZSByZWRvbmUgLS0gd2Uga2VlcCBydW5uaW5nIGlu
dG8gaXNzdWVzDQo+IGhlcmUgYW5kIA0KPiBmaXhpbmcgdGhlbSwgYnV0IHRoZXJlIGFyZSBwcm9i
YWJseSBtb3JlIGlzc3VlcyBhbmQgaXQnbGwgcHJvYmFibHkgYmUNCj4gZmFzdGVyIHRvIA0KPiBq
dXN0IHRoaW5rIHRocm91Z2ggdGhlIG1lbW9yeSBtYXAgdGhhbiB0byBrZWVwIGZpeGluZyBidWdz
IGFzIHRoZXkNCj4gY3JvcCB1cC4gIA0KPiBUaGlzIHdhcyBvbmUgb2YgdGhlIGFyZWFzIG9mIHRo
ZSBwb3J0IEkgZGlkbid0IHJld3JpdGUgYXMgcGFydCBvZiB0aGUNCj4gdXBzdHJlYW0gDQo+IHN1
Ym1pc3Npb24gcHJvY2VzcywgYW5kIGFzIGEgcmVzdWx0IGl0J3MgcHJldHR5IGNydXN0eS4NCg0K
SSBjYW4ndCBzcGVhayBmb3IgcmV3cml0aW5nIHRoZSBjb2RlLCBidXQgdGhhdCBzZWVtcyBsaWtl
IHNvbWV0aGluZw0KdGhhdCBzaG91bGQgaGFwcGVuIGluIHRoZSA1LjQgbWVyZ2Ugd2luZG93IHJp
Z2h0PyBXaXRoIFJDNiBhbHJlYWR5IG91dCANCnRoaXMgcGF0Y2ggc2VlbXMgbGlrZSB0aGUgb25s
eSBvcHRpb24gZm9yIDUuMy4gVW5sZXNzIHdlIGFyZSBqdXN0IGdvaW5nDQp0byBkcm9wIFJWMzIg
c3VwcG9ydCBmcm9tIExpbnV4IGluIHRoZSA1LjMgcmVsZWFzZT8NCg0KQWxpc3RhaXINCg0KPiAN
Cj4gPiBJIHRoaW5rIHRoZSBiZXN0IHBsYWNlIHRvIGFkZCBBU0NJSSBhcnQgd291bGQgYmUgYXNt
L3BndGFibGUuaA0KPiA+IHdoZXJlIGFsbA0KPiA+IHZpcnR1YWwgbWVtb3J5IHJlbGF0ZWQgZGVm
aW5lcyBhcmUgcGxhY2VkLiBTdWdnZXN0aW9ucz8/DQo=
