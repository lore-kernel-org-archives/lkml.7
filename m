Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB4BEC352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 07:31:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60DD821783
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 07:31:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Pjrbklwz";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="H+OqlqOh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733024AbfJAHbM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 03:31:12 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:44371 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732905AbfJAHbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 03:31:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1569915071; x=1601451071;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=JsOIRtKVEobbstGQwgENrnkW3F6tkvwiKE1dlIe5aYk=;
  b=PjrbklwzokOkdNOhB/NB0LVEweLCSkUbsFe0M+lj9r1oFeg0WuUp9qtq
   lwTv9BGPHdnb4vT31DYNBCrAzWj5QWQYMOXGsWp9CAARnrsiJvBzOgCGv
   9PScGKg67nrAeJ9usnlZARwqQOcYeciBDsQPXdtUv9A4YwSBHIJ7eU8lu
   9nmZmQ6zamdNY/5W2ZfaWcV09VkXAq0gRmwGx5jPEO8AeMhVHCJW9qQmq
   ngGvBSIj14tRoA4mafTr8La6wc98nqC/x13/OPIiKb8+RFrnRKhXPDqJd
   eUlEEo1EUSyZn/tW7qPfFKyVhJF0PeLRK0P53g7c1/VDhuyT6kR8J6Op+
   w==;
IronPort-SDR: JFJ5tS+xZrfR8Az5XxwzZHI7+h67ddLy10OK+DUqHn0M7NDI3xBNiLA+FOx7pLVkbWb98eYik1
 0pjnF3MXFfyX4cekPg9IwqGU1CQxHumk5XEq5AFXxRceQ/I05ycnTyzoTnPRQmy1Q8PicxeCqi
 SVa6vaafUIsLk8klaj7tEHN3q9gt6uhyBrfRAS+xo3rax+JrVe99Anzh/Xe4fVl+WmDPj2vOcg
 FYCeBdE5hCGI6981r1+TP0zACKMLgEehFAQCDSmIu+7QywcE0MB/2OJMb+Q8VPzg+4Nm7/ycsQ
 85E=
X-IronPort-AV: E=Sophos;i="5.64,570,1559491200"; 
   d="scan'208";a="119507794"
Received: from mail-cys01nam02lp2054.outbound.protection.outlook.com (HELO NAM02-CY1-obe.outbound.protection.outlook.com) ([104.47.37.54])
  by ob1.hgst.iphmx.com with ESMTP; 01 Oct 2019 15:31:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aa2d59LszCBGEr/1voxAg/TGhCyUY6ru/vtxjlZ/i547dvQPJtncayEMKpdwKByKKASIWYA7xFjU0C5nO5dehXxRrubg+xO0hC6puBWmmWqHUozt8XL6KpTBfoc6AOrdWBbayzF2KgLF9QErwkTFBLheX04ApqYyzlxVfFVzBgkWR+DRmW5MoymD3ZiHta+oz5Q9sD1gsttWEhyzQyT+ksntnD0oS84YlZSef/k/0d/g0QzLC61CqEFoZa63fR4lz8nRVtbxQxMhBgNO3oBS0l8Boj2tOXSugANpvR6gbs6fggdBO+EWBubtZEROWsUvVnCdGZfxCyMrcR6e5M7Yeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JsOIRtKVEobbstGQwgENrnkW3F6tkvwiKE1dlIe5aYk=;
 b=JcoGVNn7LHr2VRC1K/RWZ0Fl/KaHj48mJ19NhciaIAZc7aqK73lEjgUSh2NAltS927CP3l2ZQhKbs905LtFFxVZohbMoYrkTGwIC2QGhNHQPSKIN2cZVRpslCyRZdWvTwHJzvcHYgGhbbcwNWbhZKyJXNQoiz25JSjEdSmg0GH0YVMTGPIfFVIuQG24tbyXpBkqjgXq3YYkPwyKcWDq2MNqobmDQ7DABUyKxGQPMkfhPm5T5YcAkgAtTR/sDLlFFp818ckITgLFG+fYzIAGHQn20TMlaLzBTYsuvujQedOpKf4W62W6VvA5vZRQFOCBa4TbAy4gOmmSetifPLM4KDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JsOIRtKVEobbstGQwgENrnkW3F6tkvwiKE1dlIe5aYk=;
 b=H+OqlqOhA5LKDFnfBTsSZKBOWnJDAWl9boWkv64lod0PcJu39YqtKWc9njxiR1WJUm5dMz5vSiEYmerkHYkLP/ZxBDiqTE8mVKyzxw4Yj0Gs58wSomevyeemBYg9os1bAzigh4mDcaxgQnIRcMO/wlNUcgdDov6H3yCKM56p6l0=
Received: from BYAPR04MB3990.namprd04.prod.outlook.com (52.135.215.29) by
 BYAPR04MB4085.namprd04.prod.outlook.com (52.135.214.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.20; Tue, 1 Oct 2019 07:31:09 +0000
Received: from BYAPR04MB3990.namprd04.prod.outlook.com
 ([fe80::a50d:40a0:cd7b:acbc]) by BYAPR04MB3990.namprd04.prod.outlook.com
 ([fe80::a50d:40a0:cd7b:acbc%5]) with mapi id 15.20.2305.022; Tue, 1 Oct 2019
 07:31:08 +0000
From:   Atish Patra <Atish.Patra@wdc.com>
To:     "alankao@andestech.com" <alankao@andestech.com>
CC:     "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "gary@garyguo.net" <gary@garyguo.net>,
        "rppt@linux.ibm.com" <rppt@linux.ibm.com>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "anup@brainfault.org" <anup@brainfault.org>,
        "palmer@sifive.com" <palmer@sifive.com>,
        "allison@lohutok.net" <allison@lohutok.net>
Subject: Re: [PATCH v2 0/3] Add support for SBI v0.2
Thread-Topic: [PATCH v2 0/3] Add support for SBI v0.2
Thread-Index: AQHVdMfWU3eO8hvHu0yu+KSplvbFjqdAGZ+AgAAKwwCABRu6AIAAKrMA
Date:   Tue, 1 Oct 2019 07:31:08 +0000
Message-ID: <ea8b0ec60fad631716beea27118fb2c4e18644a6.camel@wdc.com>
References: <20190927000915.31781-1-atish.patra@wdc.com>
         <20190927221913.GA4700@infradead.org>
         <8683f51f26708a468bcdf16a48db1cffac6c28d8.camel@wdc.com>
         <20191001045815.GA6572@andestech.com>
In-Reply-To: <20191001045815.GA6572@andestech.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Atish.Patra@wdc.com; 
x-originating-ip: [73.162.108.221]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a9c6fbc0-b726-452e-0d34-08d74641538d
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: BYAPR04MB4085:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <BYAPR04MB40851F8227E937E6F20DD54FFA9D0@BYAPR04MB4085.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0177904E6B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(346002)(396003)(366004)(136003)(376002)(199004)(189003)(54906003)(6486002)(7416002)(6116002)(3846002)(316002)(4326008)(6512007)(2906002)(305945005)(6436002)(7736002)(118296001)(229853002)(25786009)(6306002)(6916009)(36756003)(86362001)(2501003)(6246003)(5640700003)(5660300002)(14454004)(66066001)(478600001)(64756008)(66446008)(476003)(2351001)(966005)(71190400001)(71200400001)(11346002)(26005)(446003)(8936002)(2616005)(256004)(1730700003)(486006)(81156014)(66556008)(102836004)(81166006)(76176011)(6506007)(99286004)(76116006)(66476007)(8676002)(14444005)(186003)(66946007);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4085;H:BYAPR04MB3990.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WjjNWJuR3HzI1qtfHh7lYg4YlsouMsSn5p2BX6PCU20ZMcDoxvpPX2dJH4N3Ch8i73C0rMDwbUgPCScFxJmn6XHLz8SpvOmxcvpW3f5xFPvuzlUDvsqZbedgBqpWEow3n+rnePQxY/FuF3O3GzmNUkuVaFCXFrEuw4T/GOEEOupeoiVfjc6fxOoedLUJY0ahteZYJ0yLO4DD4oVqYNa1h++75dUDFpX6gWCNB2S08yIS1jV4K6rdMTqXc1Fbxh+BkGfPlNZCdh0+CZYqJGVX0y8g4yGcR9jGk1BbEiqSnUfgLUm8zyla7NvetsgJD00kcDH0lqWY60GWBM6SBw8Vmr9vpSSEYqwi5RWFEuNNaUKNbyuWPM+pbkhBBOle1YFMTAg3db5BeU99ABWa39tV9+NqkhVnhYR61tJJ+fktmrl3cTYQX0RewHcCewzwldxIyHxjGL2oFtBjV02lByOguw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <7F6740829601FE409E071CFA2AD3C18D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9c6fbc0-b726-452e-0d34-08d74641538d
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2019 07:31:08.0528
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S0b4aPXe/C7yTSjPp5D5sQHimMlWS2hjf4MdvzcuLtobpPEcFAR0wa63Ev7EgF/xKRLlffbCezXJJ7QBXfkCmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4085
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE5LTEwLTAxIGF0IDEyOjU4ICswODAwLCBBbGFuIEthbyB3cm90ZToNCj4gT24g
RnJpLCBTZXAgMjcsIDIwMTkgYXQgMTA6NTc6NDVQTSArMDAwMCwgQXRpc2ggUGF0cmEgd3JvdGU6
DQo+ID4gT24gRnJpLCAyMDE5LTA5LTI3IGF0IDE1OjE5IC0wNzAwLCBDaHJpc3RvcGggSGVsbHdp
ZyB3cm90ZToNCj4gPiA+IE9uIFRodSwgU2VwIDI2LCAyMDE5IGF0IDA1OjA5OjEyUE0gLTA3MDAs
IEF0aXNoIFBhdHJhIHdyb3RlOg0KPiA+ID4gPiBUaGUgU3VwZXJ2aXNvciBCaW5hcnkgSW50ZXJm
YWNlKFNCSSkgc3BlY2lmaWNhdGlvblsxXSBub3cNCj4gPiA+ID4gZGVmaW5lcyBhDQo+ID4gPiA+
IGJhc2UgZXh0ZW5zaW9uIHRoYXQgcHJvdmlkZXMgZXh0ZW5kYWJpbGl0eSB0byBhZGQgZnV0dXJl
DQo+ID4gPiA+IGV4dGVuc2lvbnMNCj4gPiA+ID4gd2hpbGUgbWFpbnRhaW5pbmcgYmFja3dhcmQg
Y29tcGF0aWJpbGl0eSB3aXRoIHByZXZpb3VzDQo+ID4gPiA+IHZlcnNpb25zLg0KPiA+ID4gPiBU
aGUgbmV3IHZlcnNpb24gaXMgZGVmaW5lZCBhcyAwLjIgYW5kIG9sZGVyIHZlcnNpb24gaXMgbWFy
a2VkDQo+ID4gPiA+IGFzDQo+ID4gPiA+IDAuMS4NCj4gPiA+ID4gDQo+ID4gPiA+IFRoaXMgc2Vy
aWVzIGFkZHMgc3VwcG9ydCB2MC4yIGFuZCBhIHVuaWZpZWQgY2FsbGluZyBjb252ZW50aW9uDQo+
ID4gPiA+IGltcGxlbWVudGF0aW9uIGJldHdlZW4gMC4xIGFuZCAwLjIuIEl0IGFsc28gYWRkcyBt
aW5pbWFsIFNCSQ0KPiA+ID4gPiBmdW5jdGlvbnMNCj4gPiA+ID4gZnJvbSAwLjIgYXMgd2VsbCB0
byBrZWVwIHRoZSBzZXJpZXMgbGVhbi4gDQo+ID4gPiANCj4gPiA+IFNvIGJlZm9yZSB3ZSBkbyB0
aGlzIGdhbWUgY2FuIGJlIHBsZWFzZSBtYWtlIHN1cmUgd2UgaGF2ZSBhIGNsZWFuDQo+ID4gPiAw
LjINCj4gPiA+IGVudmlyb25tZW50IHRoYXQgbmV2ZXIgdXNlcyB0aGUgbGVnYWN5IGV4dGVuc2lv
bnMgYXMgZGlzY3Vzc2VkDQo+ID4gPiBiZWZvcmU/DQo+ID4gPiBXaXRob3V0IHRoYXQgYWxsIHRo
aXMgd29yayBpcyByYXRoZXIgZnV0aWxlLg0KPiA+ID4gDQo+ID4gDQo+ID4gQXMgcGVyIG91ciBk
aXNjdXNzaW9uIG9mZmxpbmUsIGhlcmUgYXJlIHRoaW5ncyBuZWVkIHRvIGJlIGRvbmUgdG8NCj4g
PiBhY2hpZXZlIHRoYXQuDQo+ID4gDQo+ID4gMS4gUmVwbGFjZSB0aW1lciwgc2ZlbmNlIGFuZCBp
cGkgd2l0aCBiZXR0ZXIgYWx0ZXJuYXRpdmUgQVBJcw0KPiA+IAktIHNiaV9zZXRfdGltZXIgd2ls
bCBiZSBzYW1lIGJ1dCB3aXRoIG5ldyBjYWxsaW5nIGNvbnZlbnRpb24NCj4gPiAJLSBzZW5kX2lw
aSBhbmQgc2ZlbmNlXyogYXBpcyBjYW4gYmUgbW9kaWZpZWQgaW4gc3VjaCBhIHdheSB0aGF0DQo+
ID4gCQktIHdlIGRvbid0IGhhdmUgdG8gdXNlIHVucHJpdmlsZWdlZCBsb2FkIGFueW1vcmUNCj4g
PiAJCS0gTWFrZSBpdCBzY2FsYWJsZQ0KPiA+IA0KPiA+IDIuIERyb3AgY2xlYXJfaXBpLCBjb25z
b2xlLCBhbmQgc2h1dGRvd24gaW4gMC4yLg0KPiA+IA0KPiA+IFdlIHdpbGwgaGF2ZSBhIG5ldyBr
ZXJuZWwgY29uZmlnIChMRUdBQ1lfU0JJKSB0aGF0IGNhbiBiZSBtYW51YWxseQ0KPiA+IGVuYWJs
ZWQgaWYgb2xkZXIgZmlybXdhcmUgbmVlZCB0byBiZSB1c2VkLiBCeSBkZWZhdWx0LCBMRUdBQ1lf
U0JJDQo+ID4gd2lsbA0KPiA+IGJlIGRpc2FibGVkIGFuZCBrZXJuZWwgd2l0aCBuZXcgU0JJIHdp
bGwgYmUgYnVpbHQuIFdlIHdpbGwgaGF2ZSB0bw0KPiA+IHNldA0KPiA+IGEgZmxhZyBkYXkgaW4g
YSB5ZWFyIG9yIHNvIHdoZW4gd2UgY2FuIHJlbW92ZSB0aGUgTEVHQUNZX1NCSQ0KPiA+IGNvbXBs
ZXRlbHkuDQo+ID4gDQo+ID4gTGV0IHVzIGtub3cgaWYgaXQgaXMgbm90IGFuIGFjY2VwdGFibGUg
YXBwcm9hY2ggdG8gYW55Ym9keS4NCj4gPiBJIHdpbGwgcG9zdCBhIFJGQyBwYXRjaCB3aXRoIG5l
dyBhbHRlcm5hdGUgdjAuMiBBUElzIHNvbWV0aW1lIG5leHQNCj4gPiB3ZWVrLg0KPiA+IA0KPiAN
Cj4gV2lsbCB0aGlzIGxlZ2FjeSBvcHRpb24gYmUgY29tcGF0aWJsZSB3aWxsIGJibD8gIHNheXMs
IHZlcnNpb24gMS4wLjANCj4gb3INCj4gYW55IGVhcmxpZXIgb25lcz8NCj4gDQoNClllcy4gVGhl
IGNvbmZpZyBvcHRpb24gd2lsbCBqdXN0IG5lZWQgdG8gYmUgZW5hYmxlZCBpbiBrZXJuZWwgdG8g
bWFrZQ0KaXQgY29tcGF0aWJsZSB3aXRoIGJibCBvciBvbGRlciBvcGVuc2JpIHZlcnNpb25zLg0K
DQpFdmVudHVhbGx5LCB3ZSB3aWxsIGdldCByaWQgb2YgdGhlIGxlZ2FjeSBvbmVzIHNvbWV0aW1l
IGluIGZ1dHVyZSB3aGVuDQpldmVyeWJvZHkgaGFzIG1pZ3JhdGVkIHRvIHVwZGF0ZWQgY29tcGF0
aWJsZSB2ZXJzaW9uIChhdCBsZWFzdCBhIHllYXINCm9yIHNvKS4NCg0KPiA+ID4gX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCj4gPiA+IGxpbnV4LXJpc2N2
IG1haWxpbmcgbGlzdA0KPiA+ID4gbGludXgtcmlzY3ZAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPiA+
ID4gaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1yaXNj
dg0KPiA+IA0KPiA+IC0tIA0KPiA+IFJlZ2FyZHMsDQo+ID4gQXRpc2gNCg0KLS0gDQpSZWdhcmRz
LA0KQXRpc2gNCg==
