Return-Path: <SRS0=tewG=XJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E6EDC49ED6
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 04:03:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9DD920717
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 04:03:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="jTbC74sK";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="RfQit6iL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726068AbfINEDN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Sep 2019 00:03:13 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:45884 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbfINEDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Sep 2019 00:03:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1568433791; x=1599969791;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=9nckn0HIjsNajkSiaj0Zk8ZN1s8rY8CjA4EqUXmrUVw=;
  b=jTbC74sKFhlx4bpWlj9oeYArRpEIsfSlFoPJtx97+9hjXI4U0Ba1Q3m/
   PnSBON6J0PuGATeB13/eTWnJUL72U+Hq0yT1SS0YIfwuEcpJSqiKteHHW
   fUA0v9g8Wjvhrvxn9NFI4eOlGqA0z0xlkMkTmFQt6Evi8cHsCKvS+/bf+
   BrsPfSEIIgDb1xQ7HpiIhiKPAP/RNCgJ3FI471unjKOLi5//og2F1yS/W
   tEyDJHHtaYeyWaEfqRZNZT600x+7FkJBLe8wI/O+u4TDFNpxCXytIrhXR
   xGBbO51IeP8k4PWL7XgQJ+flUWoByL99dm/m2qoIsv0Vydx0Rmhl7P452
   w==;
IronPort-SDR: 15vkOVZIi2ROrr81AmfSOI8rQE0Xy6e2iwplmux+qA45vM7s9Jr0BCzpwOq+B9lTh9uRb/idyL
 TjpF0LX8wF3g9HNwQaT/ZxrjYfG+MBbbq3aAE8faoMWgswWclv1WrrNDpBMTxVdJPYQze6qMy6
 ScODOym0GW1fdbJTF4yaiHI9X9PVRCROX79KvwtcTqJMwMVKwZRopz8ingT56zQ2MANljrC14Y
 RZpoMwrPnUAECpD5mgeOLz52mNvUm7hBG75vBmEJYMtErWirT/oTzGlS7bDa/oQVKfrd+eZDX5
 ciE=
X-IronPort-AV: E=Sophos;i="5.64,503,1559491200"; 
   d="scan'208";a="119081298"
Received: from mail-dm3nam03lp2054.outbound.protection.outlook.com (HELO NAM03-DM3-obe.outbound.protection.outlook.com) ([104.47.41.54])
  by ob1.hgst.iphmx.com with ESMTP; 14 Sep 2019 12:03:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AfwsdhqVF53/JEezQDL7QdEmQkqVoAW8nMSsiw2Pla6IuxfeVgQtBKdc108RxFTS1kOXj9TaL2l8k518/9rqyESXUNf4v8HZeGBwTiBzaHxZisHa8+3gcQcg+rOi/Ye7KyIZ/UYAjc2cw3/YH650pHjvpZpndmNqBui4rWrsw3Jm1lq9cI/lVZ/Vp7M+deB6aqjCe/Gu1cydh/TT/Dlv8Alu1j34WbC1WtIs1QKXu5kmDgii8oc3y9ezNwiK+/U9dWStNBebVZPzBvj5Bu963+oAGjAxHVd7Nfhn2Nh3su7iVoVJcqwqtRuT9dUqM3gDsdH150Gp3xPGjGmg02crLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9nckn0HIjsNajkSiaj0Zk8ZN1s8rY8CjA4EqUXmrUVw=;
 b=fVdgMP/8yeMELgHBYCCnsDDb19/PozlBVAULKh9o8WMnJkFvQhGRdlrXU3deyoeRCvx76YX9Tazckkte/BlGwfWUGYbP61lrzsBD25V5I+2OgUtGhSGeWwPSvgmIAvmb7oGcWqSdx+8bFXtlVsbeJOzl4PuYnidsPwcQjXe3aBiAQ5JSumGv6rIJrMAePUDquEpiLy4mQ7VmQBisw10jX+V3GFJK2Ulblvl2yv8ydV5wIb67cfb2w2lUOHKUWuc2HncF7qvzXFusZOn+VppURuOMTtxD3lkLUTntLaq0IIcScmAohOs1ljRLWw9IQBHZUu02N9p8ChG+dpdMJ3nq7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9nckn0HIjsNajkSiaj0Zk8ZN1s8rY8CjA4EqUXmrUVw=;
 b=RfQit6iLn6BKypTC7oqcZwjWtnBXSP6lOcbAm4XdgReQyKELM7n0f9IhPv05TajMzXu5tHZnGwJ6Ibswm+XIhVCUUzmMpTvd6rF32jlNqYVtX6Pua0E6QgWP1PJSiHTzLFLcjldB5Yinhs2QiaYp/Np+AbGj8reuV6J+uaPFauw=
Received: from BYAPR04MB3990.namprd04.prod.outlook.com (52.135.215.29) by
 BYAPR04MB4357.namprd04.prod.outlook.com (20.176.252.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.21; Sat, 14 Sep 2019 04:03:08 +0000
Received: from BYAPR04MB3990.namprd04.prod.outlook.com
 ([fe80::a50d:40a0:cd7b:acbc]) by BYAPR04MB3990.namprd04.prod.outlook.com
 ([fe80::a50d:40a0:cd7b:acbc%5]) with mapi id 15.20.2263.021; Sat, 14 Sep 2019
 04:03:07 +0000
From:   Atish Patra <Atish.Patra@wdc.com>
To:     "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "palmer@sifive.com" <palmer@sifive.com>,
        "merker@debian.org" <merker@debian.org>
Subject: Re: [PATCH] riscv: modify the Image header to improve compatibility
 with the ARM64 header
Thread-Topic: [PATCH] riscv: modify the Image header to improve compatibility
 with the ARM64 header
Thread-Index: AQHVaqmp3clfNOHPsUKKgfwsILvnBqcqjUuA
Date:   Sat, 14 Sep 2019 04:03:07 +0000
Message-ID: <2e697e9c7966cf1a6cac415b6a247a8ba9f4de29.camel@wdc.com>
References: <alpine.DEB.2.21.9999.1909132005200.24255@viisi.sifive.com>
In-Reply-To: <alpine.DEB.2.21.9999.1909132005200.24255@viisi.sifive.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Atish.Patra@wdc.com; 
x-originating-ip: [122.171.172.160]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: adc2266a-bc83-4d3f-043e-08d738c8738c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB4357;
x-ms-traffictypediagnostic: BYAPR04MB4357:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <BYAPR04MB4357C35A8DDBB1A5D9C990FDFAB20@BYAPR04MB4357.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 01604FB62B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(346002)(396003)(376002)(366004)(39860400002)(51914003)(189003)(199004)(7736002)(229853002)(305945005)(6436002)(6306002)(6486002)(6512007)(6246003)(53936002)(71190400001)(71200400001)(118296001)(5660300002)(76116006)(36756003)(91956017)(486006)(86362001)(66476007)(64756008)(66446008)(66946007)(66556008)(476003)(2616005)(11346002)(446003)(6506007)(14454004)(25786009)(76176011)(966005)(99286004)(102836004)(26005)(186003)(2501003)(14444005)(256004)(3846002)(6116002)(316002)(2906002)(54906003)(110136005)(81156014)(81166006)(8676002)(8936002)(66066001)(478600001)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4357;H:BYAPR04MB3990.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: wV+VQe80tHT6V6gKt6OCv6fWuL4aaqARiStrniXoHeKGzM4rwMrtQfRwxGA4c9hYp6QCyhhZyPsMNlLfwbyQkcbTfRLK7OCxsJe0gxMz8zTowk+3UlEfFfu9TwcvbQ28QPsN0tacVgIeaL3VcQJT8XrSeF5VToM0mXbQuuEfLPQ2hq/iwUyfY3dNEuvLPDILnMCEGIZPxdPZ1An/v0bYHk961DaaCaWpl6j2wb+zF1digWHZTWfTskcXhqXoWkBkJTOzjgmNHf0IbOsMiZs38mLQ1p9N44liTyXcuEJb636c5qr3VUbsuf10rnPdgzJlm3wedVN6srIArOhUT7vmH0vhvGYDcQRDDfTLA43IcodEliPVRnOhS0kd5I+zxEXFEbZtS0RUCqvKzTUpxgzkY1awEqDvmbiG03JemtXbKYI=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <146FC49143E9C0489D1B2BB448E5094F@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adc2266a-bc83-4d3f-043e-08d738c8738c
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2019 04:03:07.6996
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: posH3fo2vORZRHo3zDpzHaH/TfiSeDxJg5ZE7hMD5NZms7vGr7msl6EPTtGAbtqWMy7EIj87TjxJ9jJdbR1e/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4357
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDE5LTA5LTEzIGF0IDIwOjA4IC0wNzAwLCBQYXVsIFdhbG1zbGV5IHdyb3RlOg0K
PiBQYXJ0IG9mIHRoZSBpbnRlbnRpb24gZHVyaW5nIHRoZSBkZWZpbml0aW9uIG9mIHRoZSBSSVND
LVYga2VybmVsDQo+IGltYWdlDQo+IGhlYWRlciB3YXMgdG8gbGF5IHRoZSBncm91bmR3b3JrIGZv
ciBhIGZ1dHVyZSBtZXJnZSB3aXRoIHRoZSBBUk02NA0KPiBpbWFnZSBoZWFkZXIuICBPbmUgZXJy
b3IgZHVyaW5nIG15IG9yaWdpbmFsIHJldmlldyB3YXMgbm90IG5vdGljaW5nDQo+IHRoYXQgdGhl
IFJJU0MtViBoZWFkZXIncyAibWFnaWMiIGZpZWxkIHdhcyBhdCBhIGRpZmZlcmVudCBzaXplIGFu
ZA0KPiBwb3NpdGlvbiB0aGFuIHRoZSBBUk02NCdzICJtYWdpYyIgZmllbGQuICBJZiB0aGUgZXhp
c3RpbmcgQVJNNjQgSW1hZ2UNCj4gaGVhZGVyIHBhcnNpbmcgY29kZSB3ZXJlIHRvIGF0dGVtcHQg
dG8gcGFyc2UgYW4gZXhpc3RpbmcgUklTQy1WDQo+IGtlcm5lbA0KPiBpbWFnZSBoZWFkZXIgZm9y
bWF0LCBpdCB3b3VsZCBzZWUgYSBtYWdpYyBudW1iZXIgMC4gIFRoaXMgaXMNCj4gdW5kZXNpcmFi
bGUsIHNpbmNlIGl0J3Mgb3VyIGludGVudGlvbiB0byBhbGlnbiBhcyBjbG9zZWx5IGFzIHBvc3Np
YmxlDQo+IHdpdGggdGhlIEFSTTY0IGhlYWRlciBmb3JtYXQuICBBbm90aGVyIHByb2JsZW0gd2Fz
IHRoYXQgdGhlIG9yaWdpbmFsDQo+ICJyZXMzIiBmaWVsZCB3YXMgbm90IGJlaW5nIGluaXRpYWxp
emVkIGNvcnJlY3RseSB0byB6ZXJvLg0KPiANCj4gQWRkcmVzcyB0aGVzZSBpc3N1ZXMgYnkgY3Jl
YXRpbmcgYSAzMi1iaXQgIm1hZ2ljMiIgZmllbGQgaW4gdGhlIFJJU0MtDQo+IFYNCj4gaGVhZGVy
IHdoaWNoIG1hdGNoZXMgdGhlIEFSTTY0ICJtYWdpYyIgZmllbGQuICBSSVNDLVYgYmluYXJpZXMg
d2lsbA0KPiBzdG9yZSAiUlNDXHgwNSIgaW4gdGhpcyBmaWVsZC4gIFRoZSBpbnRlbnRpb24gaXMg
dGhhdCB0aGUgdXNlIG9mIHRoZQ0KPiBleGlzdGluZyA2NC1iaXQgIm1hZ2ljIiBmaWVsZCBpbiB0
aGUgUklTQy1WIGhlYWRlciB3aWxsIGJlIGRlcHJlY2F0ZWQNCj4gb3ZlciB0aW1lLiAgSW5jcmVt
ZW50IHRoZSBtaW5vciB2ZXJzaW9uIG51bWJlciBvZiB0aGUgZmlsZSBmb3JtYXQgdG8NCj4gaW5k
aWNhdGUgdGhpcyBjaGFuZ2UsIGFuZCB1cGRhdGUgdGhlIGRvY3VtZW50YXRpb24gYWNjb3JkaW5n
bHkuICBGaXgNCj4gdGhlIGFzc2VtYmxlciBkaXJlY3RpdmVzIGluIGhlYWQuUyB0byBlbnN1cmUg
dGhhdCByZXNlcnZlZCBmaWVsZHMgYXJlDQo+IHByb3Blcmx5IHplcm8taW5pdGlhbGl6ZWQuDQo+
IA0KDQpUaGFua3MgZm9yIHRoZSBxdWljayBmaXguIElzIHRoZXJlIGEgcGxhbm5lZCB0aW1lbGlu
ZSB3aGVuIHdlIGNhbg0KcmVtb3ZlIHRoZSBkZXByZWNhdGVkIG1hZ2ljID8NCg0KSSB3YXMgcGxh
bm5pbmcgdG8gc2VuZCBhIFUtYm9vdCBoZWFkZXIgZG9jdW1lbnRhdGlvbiBwYXRjaCB0byBtYXRj
aA0KTGludXggb25lIGFueXdheXMuIERvIHlvdSB3YW50IG1lIHRoYXQgdG8gcmViYXNlIGJhc2Vk
IG9uIHRoaXMgcGF0Y2ggb3INCmFyZSB5b3UgcGxhbm5pbmcgdG8gc2VuZCBhIFUtYm9vdCBwYXRj
aCBhcyB3ZWxsID8NCg0KPiBTaWduZWQtb2ZmLWJ5OiBQYXVsIFdhbG1zbGV5IDxwYXVsLndhbG1z
bGV5QHNpZml2ZS5jb20+DQo+IFJlcG9ydGVkLWJ5OiBQYWxtZXIgRGFiYmVsdCA8cGFsbWVyQHNp
Zml2ZS5jb20+DQo+IENjOiBBdGlzaCBQYXRyYSA8YXRpc2gucGF0cmFAd2RjLmNvbT4NCj4gQ2M6
IEthcnN0ZW4gTWVya2VyIDxtZXJrZXJAZGViaWFuLm9yZz4NCj4gLS0tDQo+IFdpbGwgdHJ5IHRv
IGdldCB0aGlzIG1lcmdlZCBiZWZvcmUgdjUuMywgdG8gbWluaW1pemUgdGhlIGRlbHRhIHdpdGgN
Cj4gdGhlIA0KPiBBUk02NCBoZWFkZXIgaW4gdGhlIGZpbmFsIHJlbGVhc2UuDQo+IA0KPiAgRG9j
dW1lbnRhdGlvbi9yaXNjdi9ib290LWltYWdlLWhlYWRlci50eHQgfCAxMyArKysrKysrLS0tLS0t
DQo+ICBhcmNoL3Jpc2N2L2luY2x1ZGUvYXNtL2ltYWdlLmggICAgICAgICAgICB8IDEyICsrKysr
Ky0tLS0tLQ0KPiAgYXJjaC9yaXNjdi9rZXJuZWwvaGVhZC5TICAgICAgICAgICAgICAgICAgfCAg
NCArKy0tDQo+ICAzIGZpbGVzIGNoYW5nZWQsIDE1IGluc2VydGlvbnMoKyksIDE0IGRlbGV0aW9u
cygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vcmlzY3YvYm9vdC1pbWFnZS1o
ZWFkZXIudHh0DQo+IGIvRG9jdW1lbnRhdGlvbi9yaXNjdi9ib290LWltYWdlLWhlYWRlci50eHQN
Cj4gaW5kZXggMWI3M2ZlYTIzYjM5Li4xNGIxNDkyZjY4OWIgMTAwNjQ0DQo+IC0tLSBhL0RvY3Vt
ZW50YXRpb24vcmlzY3YvYm9vdC1pbWFnZS1oZWFkZXIudHh0DQo+ICsrKyBiL0RvY3VtZW50YXRp
b24vcmlzY3YvYm9vdC1pbWFnZS1oZWFkZXIudHh0DQoNClRoZXJlIGlzIGEgcGF0Y2ggYWxyZWFk
eSBxdWV1ZWQgdGhhdCBjaGFuZ2VkIHRoZSBmb3JtYXQgdG8gUmVTVC4gWW91DQpuZWVkIHRvIHJl
YmFzZSB0aGUgcGF0Y2ggYWNjb3JkaW5nbHkNCg0KaHR0cHM6Ly9sa21sLm9yZy9sa21sLzIwMTkv
Ny8yNi8xMzIxDQoNCj4gQEAgLTE4LDcgKzE4LDcgQEAgVGhlIGZvbGxvd2luZyA2NC1ieXRlIGhl
YWRlciBpcyBwcmVzZW50IGluDQo+IGRlY29tcHJlc3NlZCBMaW51eCBrZXJuZWwgaW1hZ2UuDQo+
ICAJdTMyIHJlczEgID0gMDsJCSAgLyogUmVzZXJ2ZWQgKi8NCj4gIAl1NjQgcmVzMiAgPSAwOyAg
ICAJICAvKiBSZXNlcnZlZCAqLw0KPiAgCXU2NCBtYWdpYyA9IDB4NTY0MzUzNDk1MjsgLyogTWFn
aWMgbnVtYmVyLCBsaXR0bGUgZW5kaWFuLA0KPiAiUklTQ1YiICovDQo+IC0JdTMyIHJlczM7CQkg
IC8qIFJlc2VydmVkIGZvciBhZGRpdGlvbmFsIFJJU0MtViBzcGVjaWZpYw0KPiBoZWFkZXIgKi8N
Cj4gKwl1MzIgbWFnaWMyID0gMHg1NjUzNDkwNTsgIC8qIE1hZ2ljIG51bWJlciAyLCBsaXR0bGUg
ZW5kaWFuLA0KPiAiUlNDXHgwNSIgKi8NCj4gIAl1MzIgcmVzNDsJCSAgLyogUmVzZXJ2ZWQgZm9y
IFBFIENPRkYgb2Zmc2V0ICovDQo+ICANCj4gIFRoaXMgaGVhZGVyIGZvcm1hdCBpcyBjb21wbGlh
bnQgd2l0aCBQRS9DT0ZGIGhlYWRlciBhbmQgbGFyZ2VseQ0KPiBpbnNwaXJlZCBmcm9tDQo+IEBA
IC0zNywxMyArMzcsMTQgQEAgTm90ZXM6DQo+ICAJQml0cyAxNjozMSAtIE1ham9yIHZlcnNpb24N
Cj4gIA0KPiAgICBUaGlzIHByZXNlcnZlcyBjb21wYXRpYmlsaXR5IGFjcm9zcyBuZXdlciBhbmQg
b2xkZXIgdmVyc2lvbiBvZiB0aGUNCj4gaGVhZGVyLg0KPiAtICBUaGUgY3VycmVudCB2ZXJzaW9u
IGlzIGRlZmluZWQgYXMgMC4xLg0KPiArICBUaGUgY3VycmVudCB2ZXJzaW9uIGlzIGRlZmluZWQg
YXMgMC4yLg0KPiAgDQo+IC0tIHJlczMgaXMgcmVzZXJ2ZWQgZm9yIG9mZnNldCB0byBhbnkgb3Ro
ZXIgYWRkaXRpb25hbCBmaWVsZHMuIFRoaXMNCj4gbWFrZXMgdGhlDQo+IC0gIGhlYWRlciBleHRl
bmRpYmxlIGluIGZ1dHVyZS4gT25lIGV4YW1wbGUgd291bGQgYmUgdG8gYWNjb21tb2RhdGUNCj4g
SVNBDQo+IC0gIGV4dGVuc2lvbiBmb3IgUklTQy1WIGluIGZ1dHVyZS4gRm9yIGN1cnJlbnQgdmVy
c2lvbiwgaXQgaXMgc2V0IHRvDQo+IGJlIHplcm8uDQo+ICstIFRoZSAibWFnaWMiIGZpZWxkIGlz
IGRlcHJlY2F0ZWQgYXMgb2YgdmVyc2lvbiAwLjIuICBJbiBhIGZ1dHVyZQ0KPiArICByZWxlYXNl
LCBpdCBtYXkgYmUgcmVtb3ZlZC4gIFRoaXMgb3JpZ2luYWxseSBzaG91bGQgaGF2ZSBtYXRjaGVk
DQo+IHVwDQo+ICsgIHdpdGggdGhlIEFSTTY0IGhlYWRlciAibWFnaWMiIGZpZWxkLCBidXQgdW5m
b3J0dW5hdGVseSBkb2VzIG5vdC4NCj4gKyAgVGhlICJtYWdpYzIiIGZpZWxkIHJlcGxhY2VzIGl0
LCBtYXRjaGluZyB1cCB3aXRoIHRoZSBBUk02NCBoZWFkZXIuDQo+ICANCj4gLS0gSW4gY3VycmVu
dCBoZWFkZXIsIHRoZSBmbGFnIGZpZWxkIGhhcyBvbmx5IG9uZSBmaWVsZC4NCj4gKy0gSW4gY3Vy
cmVudCBoZWFkZXIsIHRoZSBmbGFncyBmaWVsZCBoYXMgb25seSBvbmUgZmllbGQuDQo+ICAJQml0
IDA6IEtlcm5lbCBlbmRpYW5uZXNzLiAxIGlmIEJFLCAwIGlmIExFLg0KPiAgDQo+ICAtIEltYWdl
IHNpemUgaXMgbWFuZGF0b3J5IGZvciBib290IGxvYWRlciB0byBsb2FkIGtlcm5lbCBpbWFnZS4N
Cj4gQm9vdGluZyB3aWxsDQo+IGRpZmYgLS1naXQgYS9hcmNoL3Jpc2N2L2luY2x1ZGUvYXNtL2lt
YWdlLmgNCj4gYi9hcmNoL3Jpc2N2L2luY2x1ZGUvYXNtL2ltYWdlLmgNCj4gaW5kZXggZWYyOGUx
MDZmMjQ3Li4zNDRkYjUyNDQ1NDcgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvcmlzY3YvaW5jbHVkZS9h
c20vaW1hZ2UuaA0KPiArKysgYi9hcmNoL3Jpc2N2L2luY2x1ZGUvYXNtL2ltYWdlLmgNCj4gQEAg
LTMsNyArMyw4IEBADQo+ICAjaWZuZGVmIF9fQVNNX0lNQUdFX0gNCj4gICNkZWZpbmUgX19BU01f
SU1BR0VfSA0KPiAgDQo+IC0jZGVmaW5lIFJJU0NWX0lNQUdFX01BR0lDCSJSSVNDViINCj4gKyNk
ZWZpbmUgUklTQ1ZfSU1BR0VfTUFHSUMJIlJJU0NWXDBcMFwwIg0KPiArI2RlZmluZSBSSVNDVl9J
TUFHRV9NQUdJQzIJIlJTQ1x4MDUiDQo+ICANCj4gICNkZWZpbmUgUklTQ1ZfSU1BR0VfRkxBR19C
RV9TSElGVAkwDQo+ICAjZGVmaW5lIFJJU0NWX0lNQUdFX0ZMQUdfQkVfTUFTSwkweDENCj4gQEAg
LTIzLDcgKzI0LDcgQEANCj4gICNkZWZpbmUgX19IRUFEX0ZMQUdTCQkoX19IRUFEX0ZMQUcoQkUp
KQ0KPiAgDQo+ICAjZGVmaW5lIFJJU0NWX0hFQURFUl9WRVJTSU9OX01BSk9SIDANCj4gLSNkZWZp
bmUgUklTQ1ZfSEVBREVSX1ZFUlNJT05fTUlOT1IgMQ0KPiArI2RlZmluZSBSSVNDVl9IRUFERVJf
VkVSU0lPTl9NSU5PUiAyDQo+ICANCj4gICNkZWZpbmUgUklTQ1ZfSEVBREVSX1ZFUlNJT04gKFJJ
U0NWX0hFQURFUl9WRVJTSU9OX01BSk9SIDw8IDE2IHwgXA0KPiAgCQkJICAgICAgUklTQ1ZfSEVB
REVSX1ZFUlNJT05fTUlOT1IpDQo+IEBAIC0zOSw5ICs0MCw4IEBADQo+ICAgKiBAdmVyc2lvbjoJ
CXZlcnNpb24NCj4gICAqIEByZXMxOgkJcmVzZXJ2ZWQNCj4gICAqIEByZXMyOgkJcmVzZXJ2ZWQN
Cj4gLSAqIEBtYWdpYzoJCU1hZ2ljIG51bWJlcg0KPiAtICogQHJlczM6CQlyZXNlcnZlZCAod2ls
bCBiZSB1c2VkIGZvciBhZGRpdGlvbmFsIFJJU0MtVg0KPiBzcGVjaWZpYw0KPiAtICoJCQloZWFk
ZXIpDQo+ICsgKiBAbWFnaWM6CQlNYWdpYyBudW1iZXIgKFJJU0MtViBzcGVjaWZpYzsgZGVwcmVj
YXRlZCkNCj4gKyAqIEBtYWdpYzI6CQlNYWdpYyBudW1iZXIgMiAodG8gbWF0Y2ggdGhlIEFSTTY0
ICdtYWdpYycNCj4gZmllbGQgcG9zKQ0KPiAgICogQHJlczQ6CQlyZXNlcnZlZCAod2lsbCBiZSB1
c2VkIGZvciBQRSBDT0ZGIG9mZnNldCkNCj4gICAqDQo+ICAgKiBUaGUgaW50ZW50aW9uIGlzIGZv
ciB0aGlzIGhlYWRlciBmb3JtYXQgdG8gYmUgc2hhcmVkIGJldHdlZW4NCj4gbXVsdGlwbGUNCj4g
QEAgLTU4LDcgKzU4LDcgQEAgc3RydWN0IHJpc2N2X2ltYWdlX2hlYWRlciB7DQo+ICAJdTMyIHJl
czE7DQo+ICAJdTY0IHJlczI7DQo+ICAJdTY0IG1hZ2ljOw0KPiAtCXUzMiByZXMzOw0KPiArCXUz
MiBtYWdpYzI7DQo+ICAJdTMyIHJlczQ7DQo+ICB9Ow0KPiAgI2VuZGlmIC8qIF9fQVNTRU1CTFlf
XyAqLw0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9yaXNjdi9rZXJuZWwvaGVhZC5TIGIvYXJjaC9yaXNj
di9rZXJuZWwvaGVhZC5TDQo+IGluZGV4IDBmMWJhMTdlNDc2Zi4uNTJlZWMwYzFiZjMwIDEwMDY0
NA0KPiAtLS0gYS9hcmNoL3Jpc2N2L2tlcm5lbC9oZWFkLlMNCj4gKysrIGIvYXJjaC9yaXNjdi9r
ZXJuZWwvaGVhZC5TDQo+IEBAIC0zOSw5ICszOSw5IEBAIEVOVFJZKF9zdGFydCkNCj4gIAkud29y
ZCBSSVNDVl9IRUFERVJfVkVSU0lPTg0KPiAgCS53b3JkIDANCj4gIAkuZHdvcmQgMA0KPiAtCS5h
c2NpeiBSSVNDVl9JTUFHRV9NQUdJQw0KPiAtCS53b3JkIDANCj4gKwkuYXNjaWkgUklTQ1ZfSU1B
R0VfTUFHSUMNCj4gIAkuYmFsaWduIDQNCj4gKwkuYXNjaWkgUklTQ1ZfSU1BR0VfTUFHSUMyDQo+
ICAJLndvcmQgMA0KPiAgDQo+ICAuZ2xvYmFsIF9zdGFydF9rZXJuZWwNCg0KLS0gDQpSZWdhcmRz
LA0KQXRpc2gNCg==
