Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3E53C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 07:59:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9085023A45
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 07:59:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="NdAWyPoC";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="QJ5MDOXE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729436AbfHTH7G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 03:59:06 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:32233 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729198AbfHTH7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 03:59:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1566287946; x=1597823946;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=dmk0X4c+vWIP8FSIEOqatMdjm18nLLT4fLBCUiDEfek=;
  b=NdAWyPoCadtNyQ+ZJBFVxCbNTmNHEFl0/udIidnTiMeTHI8e8Nz4vxE2
   E2nMFz3ax4tT1rIlhPWUeFGX6+RxAiRTYawVYK+TkHImJfwoG8+Dipyes
   KaSzVhxznZ3eJTf2zAAAJ0xG/WSJMsR5OZRDSppC9ep3yjFXJWIJFOUsD
   BUt09GkAuAGcipT1WSy7VTo8yuhi6mDO43o/etcV/0m0Oj+yJwXOdxKCG
   ysn1QDabfafCbfRsjHJZWFtnT+K3wW+aZDpcV6vyDQib8dePzCQ1y9q9Y
   oSQpQtkBY93rOmzBjSCcQFUYO+Ml8YyOYxviM7n9k9SHo6+NDNyMekCcH
   A==;
IronPort-SDR: ZiO0eKxjXUR1iVtXItaTF2Svwa//FuTv1GLGPyHFn31MUjjQe9FJ2RATXwS1WJyzGP4KEi5IGN
 I4bhYUYFtt2abcsCm9l9qqKnZCJISolfl12VFYSLbhCfB/VtXXjSf2Ng8d5OJ7fsdelP5StZgo
 6sul0YJz7xAGzE0HT81Fs3JogjnsBga6mT/Iv50AG21s3YBLw7doU4Qmn1jlCnFecR0d0SCRZQ
 aZ4gS765C1EmnD7PZ0bjLZbuXtUcJi2yx0s2Fe08nzJKFCcHE+IBStckb625f+WL0Y4OqrsDWP
 hjQ=
X-IronPort-AV: E=Sophos;i="5.64,408,1559491200"; 
   d="scan'208";a="117812848"
Received: from mail-co1nam03lp2053.outbound.protection.outlook.com (HELO NAM03-CO1-obe.outbound.protection.outlook.com) ([104.47.40.53])
  by ob1.hgst.iphmx.com with ESMTP; 20 Aug 2019 15:59:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YklqI9506w0uey5EDpDJB9pXZQnpNg0vqxNSN5Is9tBXsz+M0vZOY+2K3xlsYmFaBqqpz99R6JoXYk9zYX6MJj8jt7uQJZa5FMb54oWXLXFZQnXLzH0MyWWWBtfjmCJeW/nOiCqhWyfybMKnBK68EI5n2/0wOkk9FwH8xboaNWGjLPKf8Q/rKbV3uCAkGMbS8ggnAODeyWig++h5XCoYMY33lB5AveMDnYL1TtB9ADNuNqXbWN4CtpXtzfEHHBbMBbi/Kjo4Pz9UBtZU7cNu7j1MgcSiDMD9Fs8WmWwWx5+OMq9I5Hs9nn7Cu8Wtka/KGojBKtfY72IlOL+hnJPdOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dmk0X4c+vWIP8FSIEOqatMdjm18nLLT4fLBCUiDEfek=;
 b=Hx8jJxLCPcarOxiNuPOwHyCdlrK92vh0CFnBqxkLcyiMydkvLzIQ85zsDNNPTZFT3Rp8dlG5QLwT2k546oui9reubKsX6yrAORwST2sLCirTRGJihTUhHb7MFOFX65cKfG9l4PIwsJ4lbqT5Z5oJ6AipXuRhK+d1xGPHT0NK2Y3vTmm2FRZ/2qfsZ2A0bUztDL4HrL8HhVqWwDwDgsCHnZjzL3Xq41s8NNnuJwh5dIcOY9gUWvkQjF/QVQ0fuE8/9d2AjHXktVHq6K4RrzlOH1lUAU3FBCLQYXrll0Pe/5fJ8NQpM6RZ6UmzpY2TFVNwrVWuJADqPKXFcgIU9T0Haw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dmk0X4c+vWIP8FSIEOqatMdjm18nLLT4fLBCUiDEfek=;
 b=QJ5MDOXEZSvDuNfpg1+n5cVuYVGoV8sIk4J9/MHST1acXk29rBlV/OwclF+ZN3PHX8POmwekhWds+5RrlFQnSaFDL1xRWIaWv6RC4nymOk9n2metMdr51CF7+qfmeDuo5zIiywxhBMjeTnavlS6iW6lwzJoJ8fxaWoKivNC88bA=
Received: from BYAPR04MB3990.namprd04.prod.outlook.com (52.135.215.29) by
 BYAPR04MB5445.namprd04.prod.outlook.com (20.178.51.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Tue, 20 Aug 2019 07:59:03 +0000
Received: from BYAPR04MB3990.namprd04.prod.outlook.com
 ([fe80::24ca:5178:5475:9a0e]) by BYAPR04MB3990.namprd04.prod.outlook.com
 ([fe80::24ca:5178:5475:9a0e%4]) with mapi id 15.20.2178.018; Tue, 20 Aug 2019
 07:59:03 +0000
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
Thread-Index: AQHVTU090lWiUiEQM02Uoz9V3NTipqb3o0CAgAaR3ACAAxJmAIACeCUA
Date:   Tue, 20 Aug 2019 07:59:02 +0000
Message-ID: <67e670a4600d7dc7ec3c7a7374e330b9a1dbe654.camel@wdc.com>
References: <20190807182316.28013-1-atish.patra@wdc.com>
         <20190812150215.GF26897@infradead.org>
         <3fb8d4f0383b005ecd932a69c4dd295a79b6fb1a.camel@wdc.com>
         <20190818181630.GA20217@infradead.org>
In-Reply-To: <20190818181630.GA20217@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Atish.Patra@wdc.com; 
x-originating-ip: [2601:646:8280:fdf0:69be:1cca:a557:65ea]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3c923876-919f-4f0b-a370-08d725444458
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BYAPR04MB5445;
x-ms-traffictypediagnostic: BYAPR04MB5445:
x-microsoft-antispam-prvs: <BYAPR04MB5445C577C89B554AA38DA043FAAB0@BYAPR04MB5445.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 013568035E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(136003)(376002)(366004)(346002)(39860400002)(199004)(189003)(25786009)(53936002)(14444005)(8676002)(476003)(186003)(11346002)(316002)(256004)(2501003)(6246003)(1730700003)(81156014)(81166006)(71190400001)(71200400001)(4326008)(446003)(46003)(86362001)(2616005)(102836004)(8936002)(478600001)(76176011)(5660300002)(36756003)(6916009)(229853002)(2351001)(7736002)(305945005)(99286004)(6116002)(6512007)(6506007)(2906002)(118296001)(76116006)(66946007)(54906003)(486006)(6436002)(66446008)(14454004)(5640700003)(66556008)(64756008)(66476007)(6486002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5445;H:BYAPR04MB3990.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: QPLUkU9bbM7a0HOnANasAz3a3q999QekBaZgegHN3GSB+VohAwW4JGpI/w1LzFdDvcKUiCmSByPIMJgM4cGgQFgWz55LsZ61g1Tsy8L8PNLMfLOdvJNFwHZtAk3gSiEsm1EWIS/ZHzJODu/i+/jnBo93gEHY+Uv//ZxGUIxFHzQalS1g8oLAxjYb6kqlIEl+NmhIcw1pI54y3GRR6O/5q8KfmhDnZh6lrJ/n+wlqV6QOHQuq1qbFEMoEeqT2K+wUNZGWXaIDffQ0IAM9qpet4yOFlhmyuZ8Ptjdxnn1+VP21w/K3dq9x8AwPDCmZgryUwwdBfjPTJDKaZTsbsA+nxgkALZ8JcqyrNzoX0ZRtmxsK1ZSiBD4/ccjt3OAaF6AZpwTm76WcTYDagt3r7ty+ASe89yUq5FAlcv3Oeh+xd5c=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <F5782799CBDB3F428B349E76D0F5B098@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c923876-919f-4f0b-a370-08d725444458
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2019 07:59:02.9328
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qQemwOSj6jpATzWbvhVS9R2SWNrYGzDIBtNL4duSP61+0rFSzXtUCHRo7gVTFP0yYVW2NxIlaRVc8rZb52fEEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5445
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU3VuLCAyMDE5LTA4LTE4IGF0IDExOjE2IC0wNzAwLCBoY2hAaW5mcmFkZWFkLm9yZyB3cm90
ZToNCj4gT24gRnJpLCBBdWcgMTYsIDIwMTkgYXQgMDc6MjE6NTJQTSArMDAwMCwgQXRpc2ggUGF0
cmEgd3JvdGU6DQo+ID4gPiA+ICsJaWYgKGlzYVswXSAhPSAnXDAnKSB7DQo+ID4gPiA+ICsJCS8q
IEFkZCByZW1haW5naW5nIGlzYSBzdHJpbmdzICovDQo+ID4gPiA+ICsJCWZvciAoZSA9IGlzYTsg
KmUgIT0gJ1wwJzsgKytlKSB7DQo+ID4gPiA+ICsjaWYgIWRlZmluZWQoQ09ORklHX1ZJUlRVQUxJ
WkFUSU9OKQ0KPiA+ID4gPiArCQkJaWYgKGVbMF0gIT0gJ2gnKQ0KPiA+ID4gPiArI2VuZGlmDQo+
ID4gPiA+ICsJCQkJc2VxX3dyaXRlKGYsIGUsIDEpOw0KPiA+ID4gPiArCQl9DQo+ID4gPiA+ICsJ
fQ0KPiA+ID4gDQo+ID4gPiBUaGlzIG9uZSBJIGRvbid0IGdldC4gIFdoeSBkbyB3ZSB3YW50IHRv
IGNoZWNrDQo+ID4gPiBDT05GSUdfVklSVFVBTElaQVRJT04/DQo+ID4gPiANCj4gPiANCj4gPiBJ
ZiBDT05GSUdfVklSVFVBTElaQVRJT04gaXMgbm90IGVuYWJsZWQsIGl0IHNob3VsZG4ndCBwcmlu
dCB0aGF0DQo+ID4gaHlwZXJ2aXNvciBleHRlbnNpb24gImgiIGluIGlzYSBleHRlbnNpb25zLg0K
PiANCj4gQ09ORklHX1ZJUlRVQUxJWkFUSU9OIGRvZXNuJ3QgY2hhbmdlIGFueXRoaW5nIGluIHRo
ZSBrZXJuZWxzDQo+IGNhcGFiaWxpdGllcywgaXQganVzdCBlbmFibGVzIG90aGVyIGNvbmZpZyBv
cHRpb25zLiANCg0KWWVzLiBCdXQgaXQgbXVzdCBiZSBlbmFibGVkIGlmIHZpcnR1YWxpemF0aW9u
IGlzIHN1cHBvcnRlZCBpbiBrZXJuZWwuDQpUaGUgaWRlYSB3YXMgdG8gbGV0IHVzZXJzcGFjZSBr
bm93IHRoYXQgaWYgdmlydHVhbGl6YXRpb24gY2FuIGJlIHVzZWQNCm9yIG5vdC4gDQoNCg0KPiAg
QnV0IG1vcmUNCj4gaW1wb3J0YW50bHkgdGhlICdoJyBleHRlbnNpb24gaXMgb25seSByZWxldmFu
dCBmb3IgUy1tb2RlIHNvZnR3YXJlDQo+IGFueXdheS4NCj4gDQoNCkRvIHlvdSB0aGluayB3ZSBz
aG91bGQganVzdCBwcmludCBhbGwgdGhlIGV4dGVuc2lvbnMgYXZhaWxhYmxlIGluIGlzYQ0Kc3Ry
aW5nIGFzIGl0IGlzID8NCg0KPiA+IFRoaXMgaXMganVzdCBhbiBpbmZvcm1hdGlvbiB0byB0aGUg
dXNlcnNwYWNlIHRoYXQgc29tZSBvZiB0aGUNCj4gPiBtYW5kYXRvcnkNCj4gPiBJU0EgZXh0ZW5z
aW9ucyAoIm1hZmRjc3UiKSBhcmUgbm90IHN1cHBvcnRlZCBpbiBrZXJuZWwgd2hpY2ggbWF5DQo+
ID4gbGVhZA0KPiA+IHRvIHVuZGVzaXJhYmxlIHJlc3VsdHMuDQo+IA0KPiBJIHRoaW5rIHdlIG5l
ZWQgdG8gc2l0IGRvd24gZGVjaWRlIHdoYXQgdGhlIHB1cnBvc2Ugb2YgL3Byb2MvY3B1aW5mbw0K
PiBpcy4gIElJUkMgb24gb3RoZXIgYXJjaGl0ZWN0dXJlcyBpcyBqdXN0IHByaW50cyB3aGF0IHRo
ZSBoYXJkd2FyZQ0KPiBzdXBwb3J0cywgbm90IHdoYXQgeW91IGNhbiBhY3R1YWxseSBtYWtlIHVz
ZSBvZi4gIEhvdyBlbHNlIHdvdWxkIHlvdQ0KPiBmaW5kIG91dCB0aGF0IHlvdSdkIG5lZWQgdG8g
ZW5hYmxlIG1vcmUga2VybmVsIG9wdGlvbnMgdG8gZnVsbHkNCj4gdXRpbGl6ZSB0aGUgaGFyZHdh
cmU/DQo+IA0KPiBBbHNvIHByaW50aW5nIHRoaXMgd2FybmluZyB0byB0aGUga2VybmVsIGxvZyB3
aGVuIHNvbWVvbmUgcmVhZHMgdGhlDQo+IHByb2NmcyBmaWxlIGlzIHZlcnkgc3RyYW5nZS4NCg0K
QWdyZWVkLiBNYXkgYmUgc29tZXRoaW5nIGxpa2UgdGhpcyA/DQoNCkxldCdzIHNheSBmL2QgaXMg
ZW5hYmxlZCBpbiBrZXJuZWwgYnV0IGNwdSBkb2Vzbid0IHN1cHBvcnQgaXQuDQoidW5zdXBwb3J0
ZWQgaXNhIiB3aWxsIG9ubHkgYXBwZWFyIGlmIHRoZXJlIGFyZSBhbnkgdW5zdXBwb3J0ZWQgaXNh
Lg0KDQpwcm9jZXNzb3IgICAgICAgOiAzDQpoYXJ0ICAgICAgICAgICAgOiA0DQppc2EgICAgICAg
ICAgICAgOiBydjY0aW1hYw0KdW5zdXBwb3J0ZWQgaXNhCTogZmQNCm1tdSAgICAgICAgICAgICA6
IHN2MzkNCnVhcmNoICAgICAgICAgICA6IHNpZml2ZSx1NTQtbWMNCg0KTWF5IGJlIEkgYW0ganVz
dCB0cnlpbmcgb3ZlciBvcHRpbWl6ZSBvbmUgY29ybmVyIGNhc2UgOikgOikuDQovcHJvYy9jcHVp
bmZvIHNob3VsZCBqdXN0IHByaW50IGFsbCB0aGUgaXNhIHN0cmluZy4gVGhhdCdzIGl0Lg0KDQpS
ZWdhcmRzLA0KQXRpc2gNCg==
