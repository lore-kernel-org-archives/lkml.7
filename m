Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD74FC4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 21:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D63D222C2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 21:45:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Nra1Cemo";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ndkdAR8i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731566AbfJDVp6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 17:45:58 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:59372 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727548AbfJDVp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 17:45:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1570225557; x=1601761557;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=GsdOAMBWqQKtjvp7rGC8aXc/V0KDeh17dQ05YBgTriE=;
  b=Nra1CemoxLkRIE/OlEnKsG8RERQEuUwo4s9BaXeMdYAmSQYW4V1K9Ss3
   eV7jOYx9Yb3y5rymUu/lfBNvWCqvTSrX4PUv/mHZBpTrxbbuaccYK1TvL
   wX1N8BksH2bDOUjY/DaOIpmSr5eXyQpPUSWbNpY5oUVIxnZCIXkFav1FA
   JvXYSUuQA7uxvyA5gjiuBwMo9FIYvhzX2jqKykqO9C85ymi0hPpi5yWmY
   vppscKQJrFZdFMO13qTAe5gXR9wDywBxn9VOH0lVociMJw5ZCg2TLO9O/
   qApE1Re5WWAYQjlfk8aePET8LXG18Zd+hct7WVEIie6Jo/qot6KneKHhd
   g==;
IronPort-SDR: 68tG+3lOinD6NHX76la5nkT5xWRVnse3dtdfz6u9OZrU7M8AglKw95Dt9k+9Tv3bLNDrYP/v3z
 /ahVehlCZLJrlEVzXOa/zP1Y9TO9nPYmITrJW5g2xXfSo0SFSGQfHVlPqwRb9mhTyMnxGaC/zE
 AVJXVX42PK5SFujN2HGuFKXRFHatybAJzTDVy4g8XjS/2MTMWLQzu1ZX/zbr3Z2wnjaAmL7Gjt
 UPZfvE4kHUSqpZS9RDjt4FdTmppKLAxc62R/Y6eE8Qi360Y8IQVb5aqFK8b2/h/P6pD4qeDR9n
 /9w=
X-IronPort-AV: E=Sophos;i="5.67,257,1566835200"; 
   d="scan'208";a="119837120"
Received: from mail-by2nam03lp2051.outbound.protection.outlook.com (HELO NAM03-BY2-obe.outbound.protection.outlook.com) ([104.47.42.51])
  by ob1.hgst.iphmx.com with ESMTP; 05 Oct 2019 05:45:56 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gr7sTrhj/A02q62S+Dl/zMgHz6xhb3X5K2XZt0fr/i9mY6v2nmC+P4SwwRVXiOlgcZP80FnNzwJtwT377z0MMHW4LB0rNlQ2cBIUz+LulLTVjfaW6EhDonxPeU48NkXWL9V7Qk8wzyCGFQreZSupdwh0J0V+D0h6DIis/4wsbgDQcBtoJ4ahvhokZ+270K/wPqwGnJ2gIKP/QbWpETR/ghosBRHxC/yHa8rp2nxEXvyOjMlelBCaUSCotlcGGWC7q2+8W0Z4mgZznbmO4QwJwcjtdop/PjdaVmAykaYrsAxbiBWMvgceLczautpW87068FCvV9rCkUGrdkLdxlIupQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GsdOAMBWqQKtjvp7rGC8aXc/V0KDeh17dQ05YBgTriE=;
 b=kWqB8Orr5TjSeSTTGH7QPQER5Yz1nWZ/dyXKQwRSRHt0L0SAfJhc5CDnpney8lCEZ27JHIvEaDsaEzYQdLDGJEkB6n6TqielOBCTNu5VZIAr9RsP2dcEmwX4ZwJ3VzFQsNOmQjVsIw9NVLHRI/LqmhqA9LGYsJnEACDKGnVlPq9FPvXBE2RrNsYfrTGvd4ihMG5NyImlmJe8f0+ic8iUgzTuMQbsX71w4qwJYPwxOGKvuPBD9WGohjC7Wd4c5eaG5L90dhNg5QE7nnpNt0tWdLP8encKjltCa8KPWbWoZsmP9zzOZesco0oaVX8XsFIcMj7b/cqqwv6OkUgphkrYog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GsdOAMBWqQKtjvp7rGC8aXc/V0KDeh17dQ05YBgTriE=;
 b=ndkdAR8inlv84QkqHSQXb7fiPArnaZBfOJNuLB7m0Wxr+7gCkpVswwVws6QaNT+9PHrhrwpLGHWx6FJpykZVdvWzaNe4S5YoQcxVxhXhrdd8rK8dLJa+ImFksm8AY+KXPXcSr6HgPn/PV9xJojyqEBm9nJHvhAxpmLQuSN+nDtM=
Received: from BYAPR04MB3990.namprd04.prod.outlook.com (52.135.215.29) by
 BYAPR04MB5799.namprd04.prod.outlook.com (20.179.58.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.20; Fri, 4 Oct 2019 21:45:55 +0000
Received: from BYAPR04MB3990.namprd04.prod.outlook.com
 ([fe80::a50d:40a0:cd7b:acbc]) by BYAPR04MB3990.namprd04.prod.outlook.com
 ([fe80::a50d:40a0:cd7b:acbc%5]) with mapi id 15.20.2305.023; Fri, 4 Oct 2019
 21:45:54 +0000
From:   Atish Patra <Atish.Patra@wdc.com>
To:     "palmer@sifive.com" <palmer@sifive.com>,
        "schwab@suse.de" <schwab@suse.de>
CC:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "hch@lst.de" <hch@lst.de>, "jslaby@suse.com" <jslaby@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH] serial/sifive: select SERIAL_EARLYCON
Thread-Topic: [PATCH] serial/sifive: select SERIAL_EARLYCON
Thread-Index: AQHVZ5zswty3GF3Lq0WixhbTjk0muackeuqrgAAB/oCAABSJ3IAAaZoAgAUcroCAA8z7gIAAnw2AgAA6NpiAACEDgIAcS/yA
Date:   Fri, 4 Oct 2019 21:45:54 +0000
Message-ID: <e3d91f171a5a3bbbc7d4e0957bd843d63c9b587c.camel@wdc.com>
References: <mhng-5091669f-461c-4e62-a71c-e16957801fad@palmer-si-x1c4>
In-Reply-To: <mhng-5091669f-461c-4e62-a71c-e16957801fad@palmer-si-x1c4>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Atish.Patra@wdc.com; 
x-originating-ip: [199.255.44.170]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c7f4b246-cdd2-46bd-4b89-08d749143bee
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: BYAPR04MB5799:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <BYAPR04MB5799C5A96A76E6EB8E628EACFA9E0@BYAPR04MB5799.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 018093A9B5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(346002)(396003)(366004)(136003)(39860400002)(189003)(199004)(6436002)(476003)(229853002)(6486002)(6512007)(446003)(6306002)(3846002)(305945005)(11346002)(7736002)(2616005)(66446008)(4326008)(66476007)(64756008)(66946007)(478600001)(76116006)(71190400001)(71200400001)(102836004)(966005)(66556008)(14454004)(5660300002)(316002)(76176011)(36756003)(110136005)(25786009)(26005)(2501003)(6506007)(66066001)(118296001)(2906002)(14444005)(486006)(6246003)(256004)(6116002)(8936002)(99286004)(81166006)(81156014)(186003)(8676002)(86362001)(54906003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5799;H:BYAPR04MB3990.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zn8ChTfVy8CV8GDzEoGqt39u2bGrCCGXb27iFjAbAl1aG//kE9EQc0wxBD7ZUwBFf25pohDbxniiFYy0H6ySf8d8MJ60LfXV3J4rATRalTCwpU5bxZd8eqLd1kxHM0KAEydnU9cnLZE/zNm+yOiCAO1LtW6rywiUU9G7O5GrQqOwZUjxSkp3SRBTLUMv4MA4j3Tk5nyo8TpypZlbSEmzs18PaVy4CiD9pHcBUn6rO6MxUPuQEYb8aasQEdO/75bEFYelniuVSRbSClwLpJPy2b80I45Dxhbn7fnvl9CeaNwByXXIbTmL7uzkjyf/m9QUT8kBKw+yy8O6wbJ/vbklIT/cHf+Fv9w0yNILGmqpYtcfDTd+oJaCfLHTtzW19gEDTX9leUov2F6+nL6dp3pDBN+0qnlAMoNtT70Zet1ijkYKufpaO2uVOwQ6gSJbz6fIGuEsSUlTjZHO7Pwl+Q7E9A==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <95E894A3CD0C17429BA2C6F79F22071D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7f4b246-cdd2-46bd-4b89-08d749143bee
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2019 21:45:54.8281
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AatPjnPUVi2/b46SHqGGvFkri/ABltYtE6nTlCMaKBoMjdJMFieFei+27OOmekTQ17yKd3YSn+IlzRS5JlQUKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5799
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDE5LTA5LTE2IGF0IDE0OjM4IC0wNzAwLCBQYWxtZXIgRGFiYmVsdCB3cm90ZToN
Cj4gT24gTW9uLCAxNiBTZXAgMjAxOSAxMjo0MDoxMCBQRFQgKC0wNzAwKSwgc2Nod2FiQHN1c2Uu
ZGUgd3JvdGU6DQo+ID4gT24gU2VwIDE2IDIwMTksIFBhbG1lciBEYWJiZWx0IDxwYWxtZXJAc2lm
aXZlLmNvbT4gd3JvdGU6DQo+ID4gDQo+ID4gPiBPbiBTdW4sIDE1IFNlcCAyMDE5IDIzOjQyOjUz
IFBEVCAoLTA3MDApLCBDaHJpc3RvcGggSGVsbHdpZw0KPiA+ID4gd3JvdGU6DQo+ID4gPiA+IE9u
IEZyaSwgU2VwIDEzLCAyMDE5IGF0IDAxOjQwOjI3UE0gLTA3MDAsIFBhbG1lciBEYWJiZWx0IHdy
b3RlOg0KPiA+ID4gPiA+IE9wZW5FbWJlZGRlZCBwYXNzZXMgImVhcmx5Y29uPXNiaSIsIHdoaWNo
IEkgY2FuIGZpbmQgaW4gdGhlDQo+ID4gPiA+ID4gZG91bWVudGF0aW9uLg0KPiA+ID4gPiA+IEkg
Y2FuJ3QgZmluZCBhbnl0aGluZyBhYm91dCBqdXN0ICJlYXJseWNvbiIuICBJJ3ZlIHNlbnQgYQ0K
PiA+ID4gPiA+IHBhdGNoIGFkZGluZyBzYmkNCj4gPiA+ID4gPiB0byB0aGUgbGlzdCBvZiBlYXJs
eWNvbiBhcmd1bWVudHMuDQo+ID4gPiA+IA0KPiA+ID4gPiBlYXJseWNvbiB3aXRob3V0IGFyZ3Vt
ZW50cyBpcyBkb2N1bWVudGVkLCBhbHRob3VnaCBqdXN0IGZvcg0KPiA+ID4gPiBBUk02NC4NCj4g
PiA+ID4gSSBjYW4gc2VuZCBhIHBhdGNoIHRvIHVwZGF0ZSBpdCB0byBwcm9wZXJseSBjb3ZlciBh
bGwgRFQNCj4gPiA+ID4gcGxhdGZvcm1zDQo+ID4gPiA+IGluIGFkZGl0aW9uLg0KPiA+ID4gDQo+
ID4gPiBUaGFua3MuICBJJ3ZlIGtpbmQgb2YgbG9zdCB0cmFjayBvZiB0aGUgdGhyZWFkLCBidXQg
YXNzdW1pbmcgdGhhdA0KPiA+ID4gZG9lcyB0aGUNCj4gPiA+ICJhdXRvbWF0aWNhbGx5IHBpY2sg
YW4gZWFybHljb24iIHN0dWZmIHRoZW4gdGhhdCdzIHByb2JhYmx5IHdoYXQNCj4gPiA+IHdlIHNo
b3VsZA0KPiA+ID4gYmUgdXNpbmcgaW4gdGhlIGRpc3Ryb3MuDQo+ID4gDQo+ID4gRXhjZXB0IHRo
YXQgaXQgZG9lc24ndCB3b3JrLg0KPiANCj4gU29ycnksIG9uY2UgYWdhaW4gSSd2ZSBsb3N0IHRy
YWNrIG9mIHRoZSB0aHJlYWQuDQo+IA0KPiBUaGUgY29kZSBsb29rcyBnZW5lcmljLiAgVGhlIGRl
dmljZSB0cmVlIGluIGFyY2gvcmlzY3YgZm9yIHRoZSBIaUZpdmUNCj4gVW5sZWFzaGVkIA0KPiBk
b2Vzbid0IGhhdmUgYSBzdGRvdXQtcGF0aCBzZXQsIHdoaWNoIGlmIEkgdW5kZXJzdGFuZCBjb3Jy
ZWN0bHkgaXMNCj4gdXNlZCBieSB0aGUgDQo+IGF1dG9tYXRpYyBlYXJseWNvbiBzdHVmZiB0byBw
aWNrIGEgY29uc29sZS4gIEkgZ2F2ZSB0aGlzIGEgcXVpY2sgdGVzdA0KPiBvbiBRRU1VLCANCj4g
d2hpY2ggZmluZHMgYSAxNjU1MCBlYXJseWNvbiBmb3IgbWUuICBJIHVzZSBvcGVuZW1iZWRkZWQn
cw0KPiBxZW11cmlzY3Y2NCB0YXJnZXQsIA0KPiB0aGUgZm9sbG93aW5nIGRpZmYgdG8gbWFrZSBz
dXJlIEknbSBnZXR0aW5nIGFuIGVhcmx5Y29uDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy90
dHkvc2VyaWFsLzgyNTAvODI1MF9lYXJseS5jDQo+IGIvZHJpdmVycy90dHkvc2VyaWFsLzgyNTAv
ODI1MF9lYXJseS5jDQo+IGluZGV4IDVjZDhjMzZjOGZjYy4uNjEyOTA3MTRiYmNiIDEwMDY0NA0K
PiAtLS0gYS9kcml2ZXJzL3R0eS9zZXJpYWwvODI1MC84MjUwX2Vhcmx5LmMNCj4gKysrIGIvZHJp
dmVycy90dHkvc2VyaWFsLzgyNTAvODI1MF9lYXJseS5jDQo+IEBAIC0xMDYsNiArMTA2LDcgQEAg
c3RhdGljIHZvaWQgZWFybHlfc2VyaWFsODI1MF93cml0ZShzdHJ1Y3QgY29uc29sZQ0KPiAqY29u
c29sZSwNCj4gICAgICAgICBzdHJ1Y3QgZWFybHljb25fZGV2aWNlICpkZXZpY2UgPSBjb25zb2xl
LT5kYXRhOw0KPiAgICAgICAgIHN0cnVjdCB1YXJ0X3BvcnQgKnBvcnQgPSAmZGV2aWNlLT5wb3J0
Ow0KPiANCj4gKyAgICAgICB1YXJ0X2NvbnNvbGVfd3JpdGUocG9ydCwgIl9lXyIsIDMsIHNlcmlh
bF9wdXRjKTsNCj4gICAgICAgICB1YXJ0X2NvbnNvbGVfd3JpdGUocG9ydCwgcywgY291bnQsIHNl
cmlhbF9wdXRjKTsNCj4gIH0NCj4gDQo+IGFuZCBydW4gdGhpcyBjb21tYW5kIGxpbmUNCj4gDQo+
ICAgICAvaG9tZS9wYWxtZXIvd29yay9saW51eC9vcGVuZW1iZWRkZWQtcmlzY3Y2NC9idWlsZC90
bXAtDQo+IGdsaWJjL3dvcmsveDg2XzY0LWxpbnV4L3FlbXUtaGVscGVyLW5hdGl2ZS8xLjAtcjEv
cmVjaXBlLXN5c3Jvb3QtDQo+IG5hdGl2ZS91c3IvYmluL3FlbXUtc3lzdGVtLXJpc2N2NjQgLWRl
dmljZSB2aXJ0aW8tbmV0LQ0KPiBkZXZpY2UsbmV0ZGV2PW5ldDAsbWFjPTUyOjU0OjAwOjEyOjM1
OjAyIC1uZXRkZXYNCj4gdXNlcixpZD1uZXQwLGhvc3Rmd2Q9dGNwOjoyMjIyLToyMixob3N0Zndk
PXRjcDo6MjMyMy0NCj4gOjIzLHRmdHA9L2hvbWUvcGFsbWVyL3dvcmsvbGludXgvb3BlbmVtYmVk
ZGVkLXJpc2N2NjQvYnVpbGQvdG1wLQ0KPiBnbGliYy9kZXBsb3kvaW1hZ2VzL3FlbXVyaXNjdjY0
IC1kcml2ZQ0KPiBpZD1kaXNrMCxmaWxlPS9ob21lL3BhbG1lci93b3JrL2xpbnV4L29wZW5lbWJl
ZGRlZC1yaXNjdjY0L2J1aWxkL3RtcC0NCj4gZ2xpYmMvZGVwbG95L2ltYWdlcy9xZW11cmlzY3Y2
NC9jb3JlLWltYWdlLWZ1bGwtY21kbGluZS1xZW11cmlzY3Y2NC0NCj4gMjAxOTA3MTExNjI2NDQu
cm9vdGZzLmV4dDQsaWY9bm9uZSxmb3JtYXQ9cmF3IC1kZXZpY2UgdmlydGlvLWJsay0NCj4gZGV2
aWNlLGRyaXZlPWRpc2swIC1vYmplY3Qgcm5nLXJhbmRvbSxmaWxlbmFtZT0vZGV2L3VyYW5kb20s
aWQ9cm5nMA0KPiAtZGV2aWNlIHZpcnRpby1ybmctZGV2aWNlLHJuZz1ybmcwIC1zaG93LWN1cnNv
ciAtbW9uaXRvciBudWxsIC1kZXZpY2UNCj4gbG9hZGVyLGZpbGU9L2hvbWUvcGFsbWVyL3dvcmsv
bGludXgvbGludXgvYXJjaC9yaXNjdi9ib290L0ltYWdlLGFkZHI9DQo+IDB4ODAyMDAwMDAgIC1u
b2dyYXBoaWMgLW1hY2hpbmUgdmlydCAgLW0gNTEyIC1zZXJpYWwgbW9uOnN0ZGlvDQo+IC1zZXJp
YWwgbnVsbCAta2VybmVsIC9ob21lL3BhbG1lci93b3JrL2xpbnV4L29wZW5lbWJlZGRlZC0NCj4g
cmlzY3Y2NC9idWlsZC90bXAtZ2xpYmMvZGVwbG95L2ltYWdlcy9xZW11cmlzY3Y2NC9md19qdW1w
LmVsZiAtYXBwZW5kDQo+ICdyb290PS9kZXYvdmRhIHJ3IGhpZ2hyZXM9b2ZmICBjb25zb2xlPXR0
eVMwIG1lbT01MTJNIGlwPWRoY3ANCj4gZWFybHljb24gJw0KPiANCj4gd2hpY2ggZ2l2ZXMgbWUg
c29tZSBlYXJseSBzdHVmZiBhbmQgdGhlbiBzb21lIG5vbi1lYXJseSBzdHVmZg0KPiANCj4gX2Vf
WyAgICAwLjQwNzU3OV0gcHJpbnRrOiBjb25zb2xlIFt0dHlTMF0gZGlzYWJsZWQNCj4gX2VfWyAg
ICAwLjQwOTIwNV0gMTAwMDAwMDAudWFydDogdHR5UzAgYXQgTU1JTyAweDEwMDAwMDAwIChpcnEg
PSAxMCwNCj4gYmFzZV9iYXVkID0gMjMwNDAwKSBpcyBhIDE2NTUwQQ0KPiBbICAgIDAuNDEwNzIw
XSBwcmludGs6IGNvbnNvbGUgW3R0eVMwXSBlbmFibGVkDQo+IF9lX1sgICAgMC40MTA3MjBdIHBy
aW50azogY29uc29sZSBbdHR5UzBdIGVuYWJsZWQNCj4gWyAgICAwLjQxMTM5MV0gcHJpbnRrOiBi
b290Y29uc29sZSBbbnMxNjU1MGEwXSBkaXNhYmxlZA0KPiBfZV9bICAgIDAuNDExMzkxXSBwcmlu
dGs6IGJvb3Rjb25zb2xlIFtuczE2NTUwYTBdIGRpc2FibGVkDQo+IFsgICAgMC40MjA2NjRdIFtk
cm1dIHJhZGVvbiBrZXJuZWwgbW9kZXNldHRpbmcgZW5hYmxlZC4NCj4gWyAgICAwLjQyODA4Nl0g
cmFuZG9tOiBmYXN0IGluaXQgZG9uZQ0KPiBbICAgIDAuNDI5MzMxXSByYW5kb206IGNybmcgaW5p
dCBkb25lDQo+IFsgICAgMC40NDA2NzhdIGxvb3A6IG1vZHVsZSBsb2FkZWQNCj4gWyAgICAwLjQ0
NzYwN10gdmlydGlvX2JsayB2aXJ0aW8xOiBbdmRhXSAyNjI4MzAgNTEyLWJ5dGUgbG9naWNhbA0K
PiBibG9ja3MgKDEzNSBNQi8xMjggTWlCKQ0KPiBbICAgIDAuNDY5NDgzXSBsaWJwaHk6IEZpeGVk
IE1ESU8gQnVzOiBwcm9iZWQNCj4gDQo+IElmIHlvdSBkb24ndCBoYXZlIHNvbWV0aGluZyBsaWtl
ICIvY2hvc2VuL3N0ZG91dC1wYXRoID0gJnVhcnQwOyIgaW4NCj4geW91ciBkZXZpY2UgDQo+IHRy
ZWUsIHRoZW4gdGhhdCdzIHByb2JhYmx5IHRoZSBpc3N1ZS4gIEhlcmUncyB3aGVyZSBpdCdzIHNl
dCBpbg0KPiBDaHJpc3RvcGgncyANCj4gazIxMDoNCj4gDQo+ICAgICANCj4gaHR0cDovL2dpdC5p
bmZyYWRlYWQub3JnL3VzZXJzL2hjaC9yaXNjdi5naXQvYmxvYi9mMTBlNjQ4NzNlYWZjNjg1MTZi
ODg4NGMwNmI5MjkwYjk4ODc2MzNiOi9hcmNoL3Jpc2N2L2Jvb3QvZHRzL2tlbmRyeXRlL2tkMjEw
LmR0cyNsMjANCj4gDQo+IGJ1dCB3ZSBkb24ndCBzZXQgaXQgZm9yIHRoZSBIaUZpdmUgVW5sZWFz
aGVkLiAgSSdkIGNhbGwgdGhhdCBhIGJ1ZywNCj4gc29tZXRoaW5nIA0KPiBsaWtlIHRoaXMNCj4g
DQo+IGRpZmYgLS1naXQgYS9hcmNoL3Jpc2N2L2Jvb3QvZHRzL3NpZml2ZS9oaWZpdmUtdW5sZWFz
aGVkLWEwMC5kdHMNCj4gYi9hcmNoL3Jpc2N2L2Jvb3QvZHRzL3NpZml2ZS9oaWZpdmUtdW5sZWFz
aGVkLWEwMC5kdHMNCj4gaW5kZXggOTNkNjhjYmQ2NGZlLi42ZDBlYzc2ZDkzZmUgMTAwNjQ0DQo+
IC0tLSBhL2FyY2gvcmlzY3YvYm9vdC9kdHMvc2lmaXZlL2hpZml2ZS11bmxlYXNoZWQtYTAwLmR0
cw0KPiArKysgYi9hcmNoL3Jpc2N2L2Jvb3QvZHRzL3NpZml2ZS9oaWZpdmUtdW5sZWFzaGVkLWEw
MC5kdHMNCj4gQEAgLTEzLDYgKzEzLDcgQEANCj4gICAgICAgICBjb21wYXRpYmxlID0gInNpZml2
ZSxoaWZpdmUtdW5sZWFzaGVkLWEwMCIsICJzaWZpdmUsZnU1NDAtDQo+IGMwMDAiOw0KPiAgDQo+
ICAgICAgICAgY2hvc2VuIHsNCj4gKyAgICAgICAgICAgICAgIHN0ZG91dC1wYXRoID0gJnVhcnQw
Ow0KPiAgICAgICAgIH07DQo+ICANCj4gICAgICAgICBjcHVzIHsNCj4gDQo+IHNob3VsZCBmaXgg
aXQuICBMTUsgaWYgSSd2ZSBtaXN1bmRlcnN0b29kIHNvbWV0aGluZy4NCj4gDQoNCk9wZW5TQkkg
YWxyZWFkeSBhZGRzIHRoaXMgbm9kZSB0byBEVCBmb3IgVS1Cb290IHNlcmlhbCBjb25zb2xlLg0K
SSBoYXZlIHRlc3RlZCB0aGF0IGp1c3QgYWRkaW5nICJlYXJseWNvbiIgdG8gdGhlIGNvbW1hbmRs
aW5lIHdvcmtzIGFzDQpsb25nIGFzIHlvdSBhcmUgdXNpbmcgT3BlblNCSSBhbmQgU0VSSUFMX0VB
UkxZQ09OIGlzIGVuYWJsZWQuDQoNCklmIHRoaXMgZW50cnkgY2FuIGJlIGFkZGVkIHRvIGR0IHJl
c2lkaW5nIGluIGtlcm5lbCwgd2UgY2FuIHJlbW92ZSB0aGUNCmNvZGUgdGhhdCBhZGRzIHRoZSAi
c3Rkb3V0LXBhdGgiIGZyb20gT3BlblNCSS4NCg0KPiBfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXw0KPiBsaW51eC1yaXNjdiBtYWlsaW5nIGxpc3QNCj4gbGlu
dXgtcmlzY3ZAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPiBodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LXJpc2N2DQoNCi0tIA0KUmVnYXJkcywNCkF0aXNoDQo=
