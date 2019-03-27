Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1438EC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 00:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC02A20811
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 00:14:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="gbyeWR+c";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="hTyk/I8B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731798AbfC0AKV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 20:10:21 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:34702 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730333AbfC0AKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 20:10:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1553645419; x=1585181419;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=qetdiKkUYEiIIAQxweMv2u8ydDKbFu0c11ISkIwgzt0=;
  b=gbyeWR+cu78O72R7EuDybL55LUzOBJZZ6kbXQfG+/3eZg4uMtXqDRY+D
   sy2osNX/wigBmiGui3jLrwNknpzEZVkCh+POjf2FEazbA5rtvRfXOaPmn
   HxaK2BigGA3z3kQm8xuZxm0ol4jHimQPSb7eMWmUmhl41HfIRZpDWPJJX
   yA/e6nugaz3SkjAkZTBiy0RMkIrMNTFwgQaMgfwF+9g474wOAWShfXdga
   R9192tsj8yPiwn/j3/MpB3V/Lqoykm3tglFVAWGc1ainxnz8e8/qO2f/r
   +eUGtd+J+drM6AoGVH3Fz2Ts3s1oVFNOy0exKJgametF+2vu42arNSMDR
   w==;
X-IronPort-AV: E=Sophos;i="5.60,274,1549900800"; 
   d="scan'208";a="209944927"
Received: from mail-bl2nam02lp2054.outbound.protection.outlook.com (HELO NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.54])
  by ob1.hgst.iphmx.com with ESMTP; 27 Mar 2019 08:10:17 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qetdiKkUYEiIIAQxweMv2u8ydDKbFu0c11ISkIwgzt0=;
 b=hTyk/I8BpvH/f0BC6trIwLZo6HsYjvzA7x262tcOOZIa0LzxOyp7YayNEQ8COA7A1Ab7QqG7Ob2rwSX6oXM1kMTSVS/d0V2ddIShjHB69CMcb0kupDzi9A8rZYgRmM34ToYjk33WNgROmqtvfnilAj+4JgSsTH/Bqds6E2A/Zl0=
Received: from BYAPR04MB4901.namprd04.prod.outlook.com (52.135.232.206) by
 BYAPR04MB4453.namprd04.prod.outlook.com (52.135.237.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.16; Wed, 27 Mar 2019 00:10:14 +0000
Received: from BYAPR04MB4901.namprd04.prod.outlook.com
 ([fe80::44e8:bd21:17b:348c]) by BYAPR04MB4901.namprd04.prod.outlook.com
 ([fe80::44e8:bd21:17b:348c%4]) with mapi id 15.20.1750.014; Wed, 27 Mar 2019
 00:10:14 +0000
From:   Alistair Francis <Alistair.Francis@wdc.com>
To:     "anup@brainfault.org" <anup@brainfault.org>,
        "palmer@sifive.com" <palmer@sifive.com>
CC:     "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "alankao@andestech.com" <alankao@andestech.com>,
        Anup Patel <Anup.Patel@wdc.com>,
        "rppt@linux.ibm.com" <rppt@linux.ibm.com>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "hch@infradead.org" <hch@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Atish Patra <Atish.Patra@wdc.com>
Subject: Re: [PATCH v2] RISC-V: Always compile mm/init.c with cmodel=medany
Thread-Topic: [PATCH v2] RISC-V: Always compile mm/init.c with cmodel=medany
Thread-Index: AQHU4stf3ADUNp6rhEGQZMtUXoGrnqYb5+cAgAADuYCAAURPAIABbRkA
Date:   Wed, 27 Mar 2019 00:10:14 +0000
Message-ID: <a8f36469d3ac9dbb6e0621207fecb9afd70567f0.camel@wdc.com>
References: <mhng-8e00a3e3-5a69-4828-b7bb-2bf000199b48@palmer-si-x1c4>
In-Reply-To: <mhng-8e00a3e3-5a69-4828-b7bb-2bf000199b48@palmer-si-x1c4>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alistair.Francis@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d9863dbf-32db-4522-ca97-08d6b2489616
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BYAPR04MB4453;
x-ms-traffictypediagnostic: BYAPR04MB4453:
x-ms-exchange-purlcount: 2
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB4453697983CDB52976C5ECF490580@BYAPR04MB4453.namprd04.prod.outlook.com>
x-forefront-prvs: 0989A7979C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(376002)(366004)(39860400002)(396003)(189003)(199004)(72206003)(3846002)(11346002)(76176011)(446003)(6436002)(81156014)(53936002)(2616005)(8676002)(229853002)(86362001)(476003)(81166006)(478600001)(6116002)(105586002)(68736007)(6306002)(6512007)(118296001)(6486002)(7736002)(305945005)(110136005)(54906003)(316002)(2906002)(486006)(2501003)(102836004)(26005)(5660300002)(97736004)(53546011)(71190400001)(966005)(4326008)(14454004)(6506007)(8936002)(25786009)(66066001)(106356001)(36756003)(186003)(71200400001)(256004)(6246003)(99286004);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4453;H:BYAPR04MB4901.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: OWyJoRULL+hOLFGaaDlju7w0Mty+l8S74sO5B1fA/VdtiGXbXGlCvDLrLSZ4kTVX6V8W0DMuJkliIJ55LiOFqWVgw56HINHOIklQCHiOfjf3sPV+t/SRH3pNtKE8Rhr0rH+5iVGcBHiwxKgLMJeu2dexwz2K5FhZ8YPKeeJ9I1sYOgohG7KK7mb2z0YJeQCvNGTq9GcDmq37nK7smkgOGl9VLPXqIRt4m1O7f8Mf0g0q3WH95E2kuDDjvU30r6TRRv9u+aJ5JeFuwZcDlofOPrYz1LFKM9FNqZMEQWG6pDi4t79KSYCAWRp9CktnaTC3ysJVBHxqIW3PTz2plHAmtYe+WzkchZW3m8yRK5Tao4igoLaU0H20A9ihk5rUACOrGGU9WdbsR1sa4V/GxSmofSWHYRyKObM7j7NNgy1SmFw=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7E583B1A38CAFE4EA9B307C08A03570D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9863dbf-32db-4522-ca97-08d6b2489616
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2019 00:10:14.3938
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4453
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDE5LTAzLTI1IGF0IDE5OjIyIC0wNzAwLCBQYWxtZXIgRGFiYmVsdCB3cm90ZToN
Cj4gT24gTW9uLCAyNSBNYXIgMjAxOSAwMDowMTo0NSBQRFQgKC0wNzAwKSwgYW51cEBicmFpbmZh
dWx0Lm9yZyB3cm90ZToNCj4gPiBPbiBNb24sIE1hciAyNSwgMjAxOSBhdCAxMjoxOCBQTSBDaHJp
c3RvcGggSGVsbHdpZyA8DQo+ID4gaGNoQGluZnJhZGVhZC5vcmc+IHdyb3RlOg0KPiA+ID4gT24g
TW9uLCBNYXIgMjUsIDIwMTkgYXQgMDE6MjU6NTBQTSArMDgwMCwgQWxhbiBLYW8gd3JvdGU6DQo+
ID4gPiA+IEhpIEFudXAsDQo+ID4gPiA+IA0KPiA+ID4gPiBTb3JyeSBmb3IgYmVpbmcgbGF0ZSB0
byB0aGUgcGFydHkuICBJIHRoaW5rIG9uZSBtb3JlIHRoaW5nDQo+ID4gPiA+IHNob3VsZA0KPiA+
ID4gPiBtb3ZlIHRvZ2V0aGVyIHdpdGggc2V0dXBfdm0oKToNCj4gPiA+IA0KPiA+ID4gQWgsIEkg
d29uZGVkIGFib3V0IHRoYXQgeWVzdGVyZGF5IGJ1dCB3YXNuJ3Qgc3VyZS4gIE1heWJlIG5vdHJh
Y2UNCj4gPiA+IGlzIGEgbGl0dGxlIGNsZWFuZXI/ICBFaXRoZXIgd2F5IHdlIHNob3VsZCBwcm9i
YWJseSBkb2N1bWVudCBib3RoDQo+ID4gPiB0aGUgbWNtb2RlbCBhbmQgbm90cmFjZSBhc3N1bXB0
aW9ucyBpbiBzb3VyY2UgY29tbWVudHMgZm9yIHRoZQ0KPiA+ID4gbmV4dA0KPiA+ID4gcGVyc29u
IHRvdWNoaW5nIHRoaXMgY29kZS4NCj4gPiANCj4gPiBUaGUgc2V0dXBfdm0oKSBzaG91bGQgYmUg
YWxsb3dlZCB0byBjYWxsIG90aGVyIGZ1bmN0aW9ucyB3aXRoaW4NCj4gPiBtbS9pbml0LmMNCj4g
PiBzbyBsZXQncyBnbyB3aXRoIGZpbGUtbGV2ZWwgbm90cmFjZSAoanVzdCBsaWtlIGhvdyBpdCB3
YXMgZG9uZSkgZm9yDQo+ID4ga2VybmVsL3NldHVwLmMNCj4gPiANCj4gPiBJIGNlcnRhaW5seSBh
ZGQgY29tbWVudHMgZm9yIHNldHVwX3ZtKCkgYmFzZWQgb24gYWxsIG91ciBmaW5kaW5ncw0KPiA+
IHNvIGZhci4NCj4gDQo+IFNvcnJ5IGZvciBiZWluZyBzbG93IGhlcmUsIGJ1dCB0aGlzIGlzIHRo
ZSByaWdodCBhcHByb2FjaDogc2V0dXBfdm0NCj4gaXMgY2FsbGVkDQo+IGJlZm9yZSByZWxvY2F0
ZSwgd2hpY2ggbWVhbnMgdGhlIHBhZ2UgdGFibGVzIHdvbid0IGJlIHNldCB1cA0KPiBjb3JyZWN0
bHkgZm9yDQo+IGFic29sdXRlIGFkZHJlc3NpbmcuICBXZSBpbnN0ZWFkIGJ1aWxkIHNldHVwX3Zt
IHdpdGggbWVkYW55LCB3aGljaA0KPiBjYXVzZXMgYWxsDQo+IGFkZHJlc3NpbmcgdG8gYmUgUEMt
cmVsYXRpdmUuICBUaGlzIGlzIGFsbCBhIGJpdCBvZiBhIGhhY2ssIGJ1dCBpdCdzDQo+IHRoZSBv
bmx5DQo+IHdheSB3ZSBoYXZlIHRvIGRvIHRoaXMgcmlnaHQgbm93Lg0KPiANCj4gWW91IHNob3Vs
ZCBiZSBhYmxlIHRvIGFkZCBhIHByZXByb2Nlc3NvciAjZXJyb3IgdG8gY2hlY2sgdGhlIGNvZGUN
Cj4gbW9kZWwgd2l0aCANCj4gc29tZXRoaW5nIGxpa2UgdGhpcw0KPiANCj4gZGlmZiAtLWdpdCBh
L2FyY2gvcmlzY3YvbW0vaW5pdC5jIGIvYXJjaC9yaXNjdi9tbS9pbml0LmMNCj4gaW5kZXggYjM3
OWE3NWFjNmE2Li5kNmZkZTZhZjhkNzUgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvcmlzY3YvbW0vaW5p
dC5jDQo+ICsrKyBiL2FyY2gvcmlzY3YvbW0vaW5pdC5jDQo+IEBAIC0xNzIsNiArMTcyLDkgQEAg
dm9pZCBfX3NldF9maXhtYXAoZW51bSBmaXhlZF9hZGRyZXNzZXMgaWR4LA0KPiBwaHlzX2FkZHJf
dCBwaHlzLCBwZ3Byb3RfdCBwcm90KQ0KPiAgICAgICAgIH0NCj4gIH0NCj4gDQo+ICsjaWZuZGVm
IF9fcmlzY3ZfY21vZGVsX21lZGFueQ0KPiArI2Vycm9yICJzZXR1cF92bSgpIGlzIGNhbGxlZCBm
cm9tIGhlYWQuUyBiZWZvcmUgcmVsb2NhdGUgYW5kIG11c3QNCj4gbm90IG1ha2UgYW55IGFic29s
dXRlIHJlZmVyZW5jZXMuIg0KPiArI2VuZGlmDQo+ICBhc21saW5rYWdlIHZvaWQgX19pbml0IHNl
dHVwX3ZtKHZvaWQpDQo+ICB7DQo+ICAgICAgICAgZXh0ZXJuIGNoYXIgX3N0YXJ0Ow0KPiANCj4g
TWFya2luZyB0aGlzIG5vdHJhY2UgaXMgdGhlIHJpZ2h0IHRoaW5nIHRvIGRvLCBhcyBpdCBjYW4n
dCBjYWxsIGludG8NCj4gYW55IA0KPiBmdW5jdGlvbnMgdGhhdCBhcmVuJ3QgbWVkYW55ICh0aGVy
ZSdzIHByb2JhYmx5IG90aGVyIGlzc3VlcyBhcyB3ZWxsLA0KPiBzaW5jZSB0aGlzIA0KPiBpcyBz
byBlYXJseSkuDQo+IA0KPiBTb3JyeSBJIG1pc3NlZCB0aGlzIHRoZSBmaXJzdCB0aW1lIGFyb3Vu
ZCwgSSB3YXNuJ3QgcGF5aW5nIGVub3VnaA0KPiBhdHRlbnRpb24uDQo+IA0KPiBDYW4gc29tZW9u
ZSBhZGQgaW5zdHJ1Y3Rpb25zIGZvciAzMi1iaXQgYm9vdHMgdG8gdGhlIFFFTVUgd2lraT8gIEl0
DQo+IHNvdW5kcyBsaWtlIA0KPiBpdCdzIHRpbWUgdG8gYWRkIHRoYXQgdG8gdGhlIHRlc3Rpbmcg
bGlzdC4uLg0KDQpEb25lIQ0KDQpodHRwczovL3dpa2kucWVtdS5vcmcvRG9jdW1lbnRhdGlvbi9Q
bGF0Zm9ybXMvUklTQ1YNCg0KQWxpc3RhaXINCg0KPiANCj4gVGhhbmtzIGZvciBkaWdnaW5nIGlu
IHRvIHRoaXMhDQo+IA0KPiA+IFJlZ2FyZHMsDQo+ID4gQW51cA0KPiANCj4gX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCj4gbGludXgtcmlzY3YgbWFpbGlu
ZyBsaXN0DQo+IGxpbnV4LXJpc2N2QGxpc3RzLmluZnJhZGVhZC5vcmcNCj4gaHR0cDovL2xpc3Rz
LmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1yaXNjdg0K
