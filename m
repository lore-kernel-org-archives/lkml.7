Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FB0DC433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 11:51:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67B0820856
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 11:51:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="atNFzFSO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728579AbfHELvV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 07:51:21 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:15718 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727868AbfHELvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 07:51:20 -0400
Received-SPF: Pass (esa5.microchip.iphmx.com: domain of
  Tudor.Ambarus@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa5.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="Tudor.Ambarus@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa5.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa5.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa5.microchip.iphmx.com; spf=Pass smtp.mailfrom=Tudor.Ambarus@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: lifZH3wGHBRAdrYexc9ea0wZi/mxZJIoiwCRc8c8f4lep8If6WgDTiK60r405QvUFenVSlJV9q
 FzJFD6djYqp4QPGXYKDRuEOnkQZPWxr8+2aA8xfqETfNnEbg9/yPnmijv9I9O7NP/84y7oZh/S
 xZGX4m2lBeZ7rcvZAtDwe8G1z4sz4fH47zaxhF11J/BrWW3eCesJcI0LGyJwDeo0Ei0OncBj6G
 9kgTX9tBPh90fyHaQ/v12xCeJ9oqrwCKBHomRV30Nr15zQ9XTcIJY6PjUQXeCRT6ts2NrEtjSN
 kxw=
X-IronPort-AV: E=Sophos;i="5.64,349,1559545200"; 
   d="scan'208";a="42413242"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 Aug 2019 04:51:19 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 5 Aug 2019 04:51:18 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Mon, 5 Aug 2019 04:51:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hTKrv7i4DC4LA4pb8i396HuHEaf8BKG6VfpHKpF7VKqCrwYxXoDsyi1hfJE3yg3jGMN+GZtR0PnZ0qWplbEOmS6G6kI7QfJIxY9vjqDxz1tnI9qR+eWNhE2K7GG52Qg2XjE4VmWu4FNLMiMUHYrSdDQmAeeHWh1Saptso2T1giQMStrTkPgLlc5PYhqeIA2HOJ7n2pxFPBjD/YkcLRkFiO4SItmW2WwWwUWAkapKN/a8cyJeo2sQJDNwuJJmz1fx3txLnX+pm2zSdWz1VpdVRcXPIHgvuZq2+H7zjSsDusejmfuMweTHMZUW1btHNmZPWiSaQ+0jgF5qdymo20Nm9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VEuMaxV+bXkmxp6ViOS6Lds0F46bzYUEj0TvlPycnfs=;
 b=hHW2DI+asZ0jtYmNM0TUte14vRkScKl06a3pzkc+T3CRifNswLGmROLBbeoVCbv5SGiD5BoBEYmruHMkLhH3EjnmwlxqRUfaNhHsTh+K/+07da5ncNVddedu/Woq4DjnqGmWI/kRoP6OQwIfHLN8iSDOEpI0AO1j+TKT0bzGgcy66Mq8fdpzJxojnMi1OnwoJOliEG9yHWc7Mr3poH40oKQsOeGLM8aUigE75yWq1Frv0ObKMttG5pSaaWXh8Unw6+s/mcgG3zDOhwTtGwoKCNZCo8Ol2snDb/kQFGaOJt1IZ/6vBryfU52nTrOIykpnkSlCzAOSiYHNFPvEZjjsPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=microchip.com;dmarc=pass action=none
 header.from=microchip.com;dkim=pass header.d=microchip.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VEuMaxV+bXkmxp6ViOS6Lds0F46bzYUEj0TvlPycnfs=;
 b=atNFzFSO+owsA+ZHL14rPejf4BZPgkwXsdAjIp+64JM+47Hn/NK8rTbJ7CXPJY9lNPcp45kq8z2VAzEcR6kC/tNEi7iZ+Xl+6fQH9eqDTkKgNH7Rs8OqjK072bnspNbdYtlNEdKu9b+40d6dZOIiXDDqSAKS8D3+jWQGuftf6pM=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB3790.namprd11.prod.outlook.com (20.178.253.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.17; Mon, 5 Aug 2019 11:51:17 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::70c3:e929:4da2:60a5]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::70c3:e929:4da2:60a5%7]) with mapi id 15.20.2136.018; Mon, 5 Aug 2019
 11:51:17 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <vigneshr@ti.com>, <miquel.raynal@bootlin.com>, <richard@nod.at>
CC:     <marek.vasut@gmail.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <tmaimon77@gmail.com>,
        <bbrezillon@kernel.org>
Subject: Re: [PATCH v4 2/3] mtd: spi-nor: Move m25p80 code in spi-nor.c
Thread-Topic: [PATCH v4 2/3] mtd: spi-nor: Move m25p80 code in spi-nor.c
Thread-Index: AQHVSIVNR1h9SqkuukqZlfb/4kclfKbsXzAAgAAMhwCAAAtlgA==
Date:   Mon, 5 Aug 2019 11:51:17 +0000
Message-ID: <50066b1c-6c4c-4aa7-c03d-1d2876afa2c2@microchip.com>
References: <20190801162229.28897-1-vigneshr@ti.com>
 <20190801162229.28897-3-vigneshr@ti.com>
 <852ffdd1-a546-03db-3b60-47d60bd8d7cf@microchip.com>
 <c4aa9ee0-9deb-9432-5ae6-0c807092ef35@ti.com>
In-Reply-To: <c4aa9ee0-9deb-9432-5ae6-0c807092ef35@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1P189CA0014.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::27) To MN2PR11MB4448.namprd11.prod.outlook.com
 (2603:10b6:208:193::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4a932877-b881-48e9-6518-08d7199b395c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR11MB3790;
x-ms-traffictypediagnostic: MN2PR11MB3790:
x-microsoft-antispam-prvs: <MN2PR11MB37906F9ACFA115646902C128F0DA0@MN2PR11MB3790.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01208B1E18
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(136003)(39860400002)(396003)(346002)(189003)(199004)(6246003)(229853002)(2906002)(256004)(26005)(66066001)(2201001)(31686004)(25786009)(14444005)(53936002)(71190400001)(478600001)(66556008)(8936002)(6512007)(6116002)(66446008)(6436002)(81166006)(5660300002)(81156014)(64756008)(66476007)(66946007)(3846002)(71200400001)(446003)(110136005)(11346002)(316002)(7736002)(305945005)(76176011)(4326008)(52116002)(54906003)(8676002)(102836004)(53546011)(476003)(2616005)(186003)(6486002)(2501003)(386003)(6506007)(36756003)(486006)(68736007)(99286004)(31696002)(86362001)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3790;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: MiSITnm+dX3YKAPq4Kp0+Fuspa9t+YsSO+PR3m+MjLAgfbnXWEuciIQbDuzGgY8UU+cM7LEp7+e7wVtNujH4DGJamc948hbLezXSatwptQ8oVMTIejlWs3D9uKLpjtvJM85b40jF9vvJ0qUuBUIYEHiw9Mx1f5bvAdDeU1opmQVR9jPJGDQek8oB/LMIH3kz/SffqISftn7FWuru1g78PLRvrJx2CTcwTS/jaCdkcvRm1dJ3rsogRlnBtJ5196I0tGurmeFh7sWioIe3TePyGOM9SJWSOFHoKy0wcoDq4yy9b6iR2pb0Y6cluxnwuLZHc18Bv5taK8vEm7lM2aSFQB//IqLTakIB59uMJmZ2LqJeluINhc1GwKcB60wS3evLZ/VxLFuAbV/dqBM+6GwahrzZVSaaEXC+hE0seByNoSk=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9148F9C01450134FB27D8410B29BE24A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a932877-b881-48e9-6518-08d7199b395c
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2019 11:51:17.0945
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tudor.ambarus@microchip.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3790
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDA4LzA1LzIwMTkgMDI6MTAgUE0sIFZpZ25lc2ggUmFnaGF2ZW5kcmEgd3JvdGU6DQo+
IEV4dGVybmFsIEUtTWFpbA0KPiANCj4gDQo+IA0KPiBPbiAwNS8wOC8xOSAzOjU1IFBNLCBUdWRv
ci5BbWJhcnVzQG1pY3JvY2hpcC5jb20gd3JvdGU6DQo+Pg0KPj4NCj4+IE9uIDA4LzAxLzIwMTkg
MDc6MjIgUE0sIFZpZ25lc2ggUmFnaGF2ZW5kcmEgd3JvdGU6DQo+Pg0KPj4+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL210ZC9zcGktbm9yL3NwaS1ub3IuYyBiL2RyaXZlcnMvbXRkL3NwaS1ub3Ivc3Bp
LW5vci5jDQo+Pj4gaW5kZXggZTAyMzc2ZTExMjdiLi44NjY5NjJjNzE1YjQgMTAwNjQ0DQo+Pj4g
LS0tIGEvZHJpdmVycy9tdGQvc3BpLW5vci9zcGktbm9yLmMNCj4+PiArKysgYi9kcml2ZXJzL210
ZC9zcGktbm9yL3NwaS1ub3IuYw0KPj4+IEBAIC0xOSw2ICsxOSw3IEBADQo+Pg0KDQo+Pj4gIA0K
Pj4+IEBAIC02ODgsNiArMTAwMywxNiBAQCBzdGF0aWMgaW50IHNwaV9ub3JfZXJhc2Vfc2VjdG9y
KHN0cnVjdCBzcGlfbm9yICpub3IsIHUzMiBhZGRyKQ0KPj4+ICAJaWYgKG5vci0+ZXJhc2UpDQo+
Pj4gIAkJcmV0dXJuIG5vci0+ZXJhc2Uobm9yLCBhZGRyKTsNCj4+PiAgDQo+Pj4gKwlpZiAobm9y
LT5zcGltZW0pIHsNCj4+PiArCQlzdHJ1Y3Qgc3BpX21lbV9vcCBvcCA9DQo+Pj4gKwkJCVNQSV9N
RU1fT1AoU1BJX01FTV9PUF9DTUQobm9yLT5lcmFzZV9vcGNvZGUsIDEpLA0KPj4+ICsJCQkJICAg
U1BJX01FTV9PUF9BRERSKG5vci0+YWRkcl93aWR0aCwgYWRkciwgMSksDQo+Pj4gKwkJCQkgICBT
UElfTUVNX09QX05PX0RVTU1ZLA0KPj4+ICsJCQkJICAgU1BJX01FTV9PUF9OT19EQVRBKTsNCj4+
PiArDQo+Pj4gKwkJcmV0dXJuIHNwaV9tZW1fZXhlY19vcChub3ItPnNwaW1lbSwgJm9wKTsNCj4+
PiArCX0NCj4+PiArDQo+Pg0KPj4gdGhpcyBzaG91bGQgYmUgZG9uZSBiZWxvdyBpbiB0aGUgZnVu
Y3Rpb24sIGFmdGVyIG1hc2tpbmcgdGhlIGFkZHJlc3MuDQo+IA0KPiBOb3BlLiBJdCB3b3VsZCBo
YXZlIGJlZW4gdHJ1ZSBpZiBhZGRyIGJlZW4gc2VudCBhcyBwYXJ0IG9mIG9wLmRhdGEuYnVmLm91
dC4gDQo+IEJ1dCBzaW5jZSBhZGRyIGlzIGJlaW5nIHNlbmQgYXMgcGFydCBvZiBvcC5hZGRyLnZh
bCwgc3BpLW1lbS5jIHRha2VzIGNhcmUgb2YgdGhpcyBmb3Igc3BpX3RyYW5zZmVyKHMpDQo+IA0K
DQpJcyB0aGlzIHZhbGlkIGFsc28gZm9yIHRoZSBjb250cm9sbGVycyB0aGF0IGltcGxlbWVudCB0
aGUgY3Rsci0+bWVtX29wcz8NCg0KPj4NCj4+IFlvdSBhZGQgYSBkb3VibGUgc3BhY2UgYWZ0ZXIg
cmV0dXJuIGluOg0KPj4+ICsJcmV0dXJuICBub3ItPnJlYWRfcmVnKG5vciwgU1BJTk9SX09QX1JE
U1IyLCBzcjIsIDEpOw0KPj4NCj4gDQo+IEFoLCBXaWxsIGZpeA0KPiANCj4+IFRoZXJlIGFyZSBz
b21lIGNoZWNrcGF0Y2ggd2FybmluZ3MgdGhhdCB3ZSBjYW4gZml4IG5vdy4NCj4+DQo+IA0KPiBJ
IGRpZCBzZWUgd2FybmluZ3MgbGlrZToNCj4+DQo+PiBXQVJOSU5HOiBsaW5lIG92ZXIgODAgY2hh
cmFjdGVycw0KPj4gIzEwMjM6IEZJTEU6IGRyaXZlcnMvbXRkL3NwaS1ub3Ivc3BpLW5vci5jOjI1
NTQ6DQo+PiArCQkJCSAgIFNQSV9NRU1fT1BfREFUQV9JTihTUElfTk9SX01BWF9JRF9MRU4sIGlk
LCAxKSk7DQo+IA0KPiBJIHRoaW5rIGl0cyBva2F5IHRvIG92ZXJzaG9vdCA4MCBjaGFyIGxpbWl0
IGZvciBiZXR0ZXIgcmVhZGFiaWxpdHkuIA0KDQpvaw0KDQo+IExldCBtZSBrbm93IGlmIHlvdSB0
aGluayBvdGhlcndpc2U+IA0KPj4gRVJST1I6IHNwYWNlIHJlcXVpcmVkIGFmdGVyIHRoYXQgJywn
IChjdHg6VnhWKQ0KPj4gIzEyNzA6IEZJTEU6IGRyaXZlcnMvbXRkL3NwaS1ub3Ivc3BpLW5vci5j
OjQ4NDY6DQo+PiArCXsibXgyNWwyNTYzNWUifSx7Im14NjZsNTEyMzVsIn0sDQo+PiAJICAgICAg
ICAgICAgICAgXg0KPiANCj4gVGhpcyBhbmQgc2ltaWxhciB3YXJuaW5ncyBjYW4gYmUgZml4ZWQs
IGJ1dCB3aWxsIHRocm93IG9mZiBhbGlnbm1lbnQgd3J0IHByZXZpb3VzIGxpbmVzLg0KPiBUaGVy
ZWZvcmUgSSBsZXQgdGhlbSBiZSBhcyBpcy4NCg0Kb2sNCg0KQ2hlZXJzLHRhDQo=
