Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 271C8C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 08:22:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCB482339E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 08:22:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="mU4f6SfQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbfHUIWZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 04:22:25 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:31855 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbfHUIWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 04:22:25 -0400
Received-SPF: Pass (esa3.microchip.iphmx.com: domain of
  Tudor.Ambarus@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="Tudor.Ambarus@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa3.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa3.microchip.iphmx.com; spf=Pass smtp.mailfrom=Tudor.Ambarus@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: gi+GMHunzjHB69NO11jpQ/9x3IT/WGEqOAhRhur0coirPBZecPML2Or/mGZ93GiUjf0w8Pg13I
 jFbVUH17K8weFmJHBAh4pD4pyG7Fg4pdH3j6Z2WpTsEa5Bq50WW7e3Lo9lDuTui9qhBe4O3pBK
 5cVVkedb86ZEdnyQLPBtckkEZ0bLAFA2v71n+gLa1ShBgcQ2vPlAG0x1W/nmg3qyUcjDQrbjT/
 Kh4kafRe3fQU0yCyd5y44aVqOdcY91npQaMU/7jbuGW3qxjmdD1KczTXbhZaxytLAOIP376X2u
 x5I=
X-IronPort-AV: E=Sophos;i="5.64,412,1559545200"; 
   d="scan'208";a="46037599"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Aug 2019 01:22:24 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 21 Aug 2019 01:22:23 -0700
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5 via Frontend
 Transport; Wed, 21 Aug 2019 01:22:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tja1wHDwQ8o/ynq/wFAeO3IDVrUD1Sm7YTgyuR1SCKct+749S4hbr5gTJliX2XMi1madJ9LEqhKt7ZD7P25/oeL31D28vrzXp/UdAyMwjW4PifzMOtx4aVP0m4MMc1Flk5D1H3iJYOpnbIIY2juuMR2uVZQWX0VdcCoiW///hN+cuIcx4Zau5rYNndfEw/Geq8b+yaPRQu4MwH5PaE8A6MuOPgyerYlrenHR5K9AluHMZgU37RmplwNjuLW5eU9tT4xvFSnLdRP5liBsDbM9D+QwZahcME+2Pw2IFbLdHTQeIOnLugYwJXzz965KhhKwg0b/v/NNwyt7PGN++/C/ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xqON4Mow7rodsFak/2Tl4GhYVtuDUhbrJdc5rZcefU4=;
 b=cvJJpwTl4oxiDRqsOCv/GYuHV/35N8q8deJffZZRyxzA0NMp60ISDnXajINN0esh4F0xlt4torO2k3Ld2l5V00HtNSVkl8/xF9XnX1xmt4JYGMt4XcuwQt9ILrULdjxUd7MpRE3bEWxdQNF0A+1wWC425bWd/95kCsVZLjocMeoCQdHk3uANfdr7xyNXjTqBuXvC2VsB+DNb5wGTVXYG1GdNCo51uEnN36DydghqWZe+AmeYkjI8+YmjM4x/AiSeTBULYS9b8B0DqtC5XFdMUlbEPKStc2VMjJToN8aWIsSpNgGxrbp5ZDuQFAM8seTAp+wSCKu8X2i8COyGjbJD3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xqON4Mow7rodsFak/2Tl4GhYVtuDUhbrJdc5rZcefU4=;
 b=mU4f6SfQT7PHbZTOg5OnHbN98qPAkh3ALh+Qcgy8RA/+Ed9HFB9wPrEg7n7WCyblBGOnNw8omnvRfCGLYaPZ4ZDWRuzCJ3aVdmT0pi3X0pC3eDXD3+cyfeq3boB8BW9t3hLNUw0w1W1vHRMy7a/24Rk5/sdu3cDarxAVMUoPQk8=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB3918.namprd11.prod.outlook.com (10.255.180.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.18; Wed, 21 Aug 2019 08:22:19 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::70c3:e929:4da2:60a5]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::70c3:e929:4da2:60a5%7]) with mapi id 15.20.2178.020; Wed, 21 Aug 2019
 08:22:19 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <thor.thayer@linux.intel.com>, <marek.vasut@gmail.com>,
        <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND] mtd: spi-nor: Fix Cadence QSPI RCU Schedule Stall
Thread-Topic: [RESEND] mtd: spi-nor: Fix Cadence QSPI RCU Schedule Stall
Thread-Index: AQHVU7xeH2z0neoGB0mjYqq1QJRJg6cFS5cA
Date:   Wed, 21 Aug 2019 08:22:19 +0000
Message-ID: <5f0349e4-e412-99a5-ea86-f8fb572b0ed7@microchip.com>
References: <1565909736-11379-1-git-send-email-thor.thayer@linux.intel.com>
In-Reply-To: <1565909736-11379-1-git-send-email-thor.thayer@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR07CA0245.eurprd07.prod.outlook.com
 (2603:10a6:802:58::48) To MN2PR11MB4448.namprd11.prod.outlook.com
 (2603:10b6:208:193::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e147a8fa-774c-41ee-8ae3-08d72610af35
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR11MB3918;
x-ms-traffictypediagnostic: MN2PR11MB3918:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <MN2PR11MB39183F3BC3B113C8F861AA53F0AA0@MN2PR11MB3918.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0136C1DDA4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(39860400002)(396003)(346002)(376002)(199004)(189003)(45904002)(66446008)(66476007)(64756008)(102836004)(486006)(52116002)(8936002)(36756003)(110136005)(446003)(2616005)(81156014)(316002)(81166006)(8676002)(6116002)(3846002)(31686004)(2501003)(2906002)(26005)(966005)(11346002)(54906003)(76176011)(186003)(478600001)(71200400001)(71190400001)(14454004)(25786009)(66946007)(2201001)(6306002)(53936002)(6246003)(229853002)(99286004)(4326008)(476003)(5660300002)(6506007)(6486002)(386003)(53546011)(256004)(66066001)(86362001)(6436002)(305945005)(7736002)(14444005)(6512007)(66556008)(31696002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3918;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: x9NWJ7BL0ieXDoyyQ+9dOMGtM0/OD4aiKBCuxNptE0GKu5LRD9jd2i/1FDDINGqbSsvMYPzHZrll1sqdW4sBTDEVk3w6zArDDFxbtP59nHPRpkEA0ERdu1+2Saa3iPqI7hJfBj2ZDV/I6YDP5MsqjluCI5pv+gNIAkHL+b42+YRMSOE/pI54RFv7WzQOET6D8H9P7ugleX33DEuBFza//iWfAxQDIjppT8tuCCEZQmjCWjJg+xBWBnHlQc3CP0SIpReZq/ULOJNM/a94wWpn6JduZKggTsYoAebcMWt6IYqyxf6RHoEiN6b7Ip29C4tZ3I6bhJjXCkhvvif5kEVwhKqZdlflwZ0FUUXBBkAyOhqKEH2w3hRFkIJZfuxxGj6TcdeXQfpvtb7J0bdw2KNjdXb/FyMh23Y3O4S84wbFlPs=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <4E178AC7E696054FB75B16F39D0D077C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e147a8fa-774c-41ee-8ae3-08d72610af35
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2019 08:22:19.8487
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cdTOJvulnbRwJPENudh/O2fOCOXMApQDxfgy7WQBGCmOkppq7AvJshXRpv/KHfF3bo+6pslMX9ILVX9eL+15vKPi0XLvoRVNGChfdY+S2+w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3918
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDA4LzE2LzIwMTkgMDE6NTUgQU0sIHRob3IudGhheWVyQGxpbnV4LmludGVsLmNvbSB3
cm90ZToNCj4gRXh0ZXJuYWwgRS1NYWlsDQo+IA0KPiANCj4gRnJvbTogVGhvciBUaGF5ZXIgPHRo
b3IudGhheWVyQGxpbnV4LmludGVsLmNvbT4NCj4gDQo+IFRoZSBjdXJyZW50IENhZGVuY2UgUVNQ
SSBkcml2ZXIgc29tZXRpbWVzIGNhdXNlZCBhDQo+ICJyY3Vfc2NoZWQgc2VsZi1kZXRlY3RlZCBz
dGFsbCIgd2hpbGUgd3JpdGluZyBsYXJnZSBmaWxlcy4NCj4gDQo+IFN0YWxsIFJlcG9ydDoNCj4g
JyMgbXRkX2RlYnVnIHdyaXRlIC9kZXYvbXRkMSAwIDQ4ODE2NDY0IGJsb2IuaW1nDQo+IFsgMTgx
NS40NTQyMjddIHJjdTogSU5GTzogcmN1X3NjaGVkIHNlbGYtZGV0ZWN0ZWQgc3RhbGwgb24gQ1BV
DQo+IFsgMTgxNS40NTk3ODldIHJjdTogICAgIDAtLi4uLjogKDIwOTkgdGlja3MgdGhpcyBHUCkg
aWRsZT04YzYvMS8weDQwMDAwMDAyDQo+ICBzb2Z0aXJxPTY0OTIvNjQ5MiBmcXM9OTM1DQo+IFsg
MTgxNS40Njg0NDJdIHJjdTogICAgICAodD0yMTAwIGppZmZpZXMgZz04NzQ5IHE9MjQ3KQ0KPiAJ
PHNuaXA+IChhYmJyZXZpYXRlZCBiYWNrdHJhY2UpDQo+IFsgMTgxNS43NzIwODZdIFs8YzA1YTNl
YTA+XSAoY3FzcGlfZXhlY19mbGFzaF9jbWQpIChjcXNwaV9yZWFkX3JlZykNCj4gWyAxODE1Ljc4
NjIwM10gWzxjMDVhNTQ4OD5dIChjcXNwaV9yZWFkX3JlZykgZnJvbSAocmVhZF9zcikNCj4gWyAx
ODE1LjgwMzc5MF0gWzxjMDVhMDMzMD5dIChyZWFkX3NyKSBmcm9tDQo+IAkoc3BpX25vcl93YWl0
X3RpbGxfcmVhZHlfd2l0aF90aW1lb3V0KQ0KPiBbIDE4MTUuODE2NjEwXSBbPGMwNWExODJjPl0g
KHNwaV9ub3Jfd2FpdF90aWxsX3JlYWR5X3dpdGhfdGltZW91dCkgZnJvbQ0KPiAJKHNwaV9ub3Jf
d3JpdGUrMHgxMDQvMHgxZDApDQo+IFsgMTgxNS44MzY3OTFdIFs8YzA1YTFhNDQ+XSAoc3BpX25v
cl93cml0ZSkgZnJvbSAocGFydF93cml0ZSsweDUwLzB4NTgpDQo+IAk8c25pcD4NCj4gWyAxODE1
Ljk5Nzk2MV0gY2FkZW5jZS1xc3BpIGZmODA5MDAwLnNwaTogRmxhc2ggY29tbWFuZCBleGVjdXRp
b24gdGltZWQgb3V0Lg0KPiBbIDE4MTYuMDA0NzMzXSBlcnJvciAtMTEwIHJlYWRpbmcgU1INCj4g
ZmlsZV90b19mbGFzaDogd3JpdGUsIHNpemUgMHgyZThlMTUwLCBuIDB4MmU4ZTE1MA0KPiB3cml0
ZSgpOiBDb25uZWN0aW9uIHRpbWVkIG91dA0KPiANCj4gVGhpcyB3YXMgY2F1c2VkIGJ5IGEgdGln
aHQgbG9vcCBpbiBjcXNwaV93YWl0X2Zvcl9iaXQoKS4gRml4IGJ5IHVzaW5nDQo+IHJlYWRsX3Jl
bGF4ZWRfcG9sbF90aW1lb3V0KCkgd2hpY2ggc2xlZXBzIDEwdXMgd2hpbGUgcG9sbGluZyBhIHJl
Z2lzdGVyLg0KPiANCj4gRml0IG9udG8gODAgY2hhcmFjdGVyIGxpbmUgYnkgdHJ1bmNhdGluZyB0
aGUgYm9vbCBjbGVhciBwYXJhbWV0ZXINCj4gDQo+IEZpeGVzOiAxNDA2MjM0MTA1MzYgKCJtdGQ6
IHNwaS1ub3I6IEFkZCBkcml2ZXIgZm9yIENhZGVuY2UgUXVhZCBTUEkgRmxhc2ggQ29udHJvbGxl
ciIpDQo+IFNpZ25lZC1vZmYtYnk6IFRob3IgVGhheWVyIDx0aG9yLnRoYXllckBsaW51eC5pbnRl
bC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9tdGQvc3BpLW5vci9jYWRlbmNlLXF1YWRzcGkuYyB8
IDE5ICsrKysrLS0tLS0tLS0tLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMo
KyksIDE0IGRlbGV0aW9ucygtKQ0KPiANCg0KDQpTaW5jZSB0aGUgYnVnIHdhcyBub3QgaW50cm9k
dWNlZCBpbiB0aGUgcHJldmlvdXMgcmVsZWFzZSBhbmQgd2UgYXJlIHF1aXRlIGxhdGUNCmZvciBt
dGQvZml4ZXMsDQoNCkFwcGxpZWQgdG8gaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xp
bnV4L2tlcm5lbC9naXQvbXRkL2xpbnV4LmdpdCwNCnNwaS1ub3IvbmV4dCBicmFuY2guDQoNClRo
YW5rcywNCnRhDQo=
