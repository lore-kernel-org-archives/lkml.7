Return-Path: <SRS0=9baz=WV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 298DBC3A5A1
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 13:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D57212070B
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 13:08:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="j2LDf98e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727884AbfHYNIO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Aug 2019 09:08:14 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:39510 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbfHYNIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 09:08:14 -0400
Received-SPF: Pass (esa2.microchip.iphmx.com: domain of
  Tudor.Ambarus@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="Tudor.Ambarus@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa2.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa2.microchip.iphmx.com; spf=Pass smtp.mailfrom=Tudor.Ambarus@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: xeFwvD9ZFjK0XXs7Sp7BMfTa98NUbkJW+cKO1KP4r9rQ7rNu0o3ohXcunwvXQEEY9cjm+ACPCs
 wxYd9OFeL6nNn1CaPCnzdNJeUObYj1ZayXMlge6vvx/nkDOVGPJSgrDe0YE2rLa4xxRR5xL/Bb
 Tn7ZZt0d/dpxshyYAdMd74zA74qPTllKNHVuvRUB0J18pThOxHZjz/BOa/iXmkdK2+rlUaMNfz
 D7Z5FfMGMgK7B6RsW/YmyeZLRrAixCCvMSeS1BxKmooFTMFh0nv2QVp+KCZJ/Fo6spE/J8dOgw
 XkQ=
X-IronPort-AV: E=Sophos;i="5.64,429,1559545200"; 
   d="scan'208";a="46445426"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Aug 2019 06:08:12 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sun, 25 Aug 2019 06:08:09 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Sun, 25 Aug 2019 06:08:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ewFplqx6pqevMyySbWS53GbmriBzdSr10t6cca8kcEmp7Qx1eDJk4tyEeBfH9Bv4RtXrfl2ZVsAKHllDAUL74gsfb41Oba5B1cxb0j7ev+zlur81lRaCE5nwrDZwausxfXiGomylSGa4Ca8nTvd0PcG9LfepRgr1soXGF47h3QF07sR/Ol5J3s1qBqme91TD/lBhFJUZKbk3tCxiFONPEq12QHgdZ7enk51/pmYUEl3KUzCoxt9SGihTIQKEyh5oKQR+kkZj6Qjx6nAettxuIiDCDfILCGX1PhkJ/feUkwewbba47L5jROzSFb9XIUurEmPlwMTdPAByGKxDGbHthw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n5dZaU3jp+eWsCx+xbjQgVB1GDia4fZGLko6fzk8g+k=;
 b=ij1EMzwTLqI8jKu5tpAHpUnkNUBrf6SPXA172RMaL+aY6w2qSUceJcIwHcgyL8GVMxURpyGL3biHj8jwJTBDpBY8+YBz6UBB4Dy07HPIr552Zgt9ZKg1rKjkZ0XIw2pGsIu85Pm0G7Agt9RoEFL69mRWV0a6MNZj+MJyotX2aofd9RFFheC3WRE8rLvWNxE/5PO9Rromw7mJN4JQaL17pKJKyrcHO0Qvj0+Ya5LXpym6tiK5izhodfCk83cKw2Q9/18YeowChGeiQgAyvW47lhMKSqHceMR3TYV2/FNFiiyW3xCs04+UuU4pqq5wsumfWZq+B0yqjdWn86vOdDOIOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n5dZaU3jp+eWsCx+xbjQgVB1GDia4fZGLko6fzk8g+k=;
 b=j2LDf98e4Z0H+uDvyZ5ykuy0ucKfdqApB6VuwIHsxXcCQMN32ENm30HZuMK64oGu++OY7cVPGkA+M5wim+HxWnF5H0QDWy+7p5AojCje4U8wMjYaVChkIJ9gZjICddGOKi2mLbYV6otFtCKfWQJ0q+krUc0/zkX/Dfb6kTJPn1M=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB3630.namprd11.prod.outlook.com (20.178.253.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Sun, 25 Aug 2019 13:08:08 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::70c3:e929:4da2:60a5]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::70c3:e929:4da2:60a5%7]) with mapi id 15.20.2199.021; Sun, 25 Aug 2019
 13:08:08 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <boris.brezillon@collabora.com>
CC:     <marek.vasut@gmail.com>, <vigneshr@ti.com>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/7] mtd: spi_nor: Move manufacturer quad_enable() in
 ->default_init()
Thread-Topic: [PATCH v2 3/7] mtd: spi_nor: Move manufacturer quad_enable() in
 ->default_init()
Thread-Index: AQHVWnONChlfDI2lKEuSOGQMw5/1e6cLwLkAgAAWnQA=
Date:   Sun, 25 Aug 2019 13:08:07 +0000
Message-ID: <f847222f-238d-f76c-398c-cf20f892bc08@microchip.com>
References: <20190824120027.14452-1-tudor.ambarus@microchip.com>
 <20190824120027.14452-4-tudor.ambarus@microchip.com>
 <20190825134704.677c83d6@collabora.com>
In-Reply-To: <20190825134704.677c83d6@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR08CA0121.eurprd08.prod.outlook.com
 (2603:10a6:800:d4::23) To MN2PR11MB4448.namprd11.prod.outlook.com
 (2603:10b6:208:193::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [86.127.53.184]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 04f258ae-8a7c-4cfa-1fd1-08d7295d45e7
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR11MB3630;
x-ms-traffictypediagnostic: MN2PR11MB3630:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <MN2PR11MB3630BD53CCB80F9601191125F0A60@MN2PR11MB3630.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 01401330D1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(136003)(366004)(346002)(39850400004)(199004)(189003)(53936002)(305945005)(8936002)(25786009)(102836004)(31686004)(14444005)(6246003)(71200400001)(71190400001)(4326008)(6512007)(6506007)(386003)(53546011)(446003)(256004)(8676002)(81156014)(229853002)(5660300002)(6486002)(6436002)(6306002)(81166006)(66446008)(64756008)(7736002)(31696002)(66556008)(66066001)(36756003)(486006)(54906003)(66476007)(66946007)(99286004)(478600001)(186003)(14454004)(76176011)(6916009)(11346002)(476003)(86362001)(2616005)(2906002)(52116002)(26005)(6116002)(966005)(3846002)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3630;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 1QkcMxpK3b6MMc9pB/W5ar9q5uo/4WUIrTHOo+qIg1Nue1dvYmzNWRJvLN+JWQHIRycfPPaGXJbHB2bDNCzGjPu5iTxBytBYmThWf0Tdwxozh1IvPV4VT1PYQr1NqKI7bgxIa9gefGjRz8U+OSYyCejUMcId0mC2bzN8ChjLZSldxq/10RKd/yux5gK8DX6LMRZ7bAmS8sjxp/T4l+/MEckDW8JoY33j1l+4KTbohbzcXXk4+tuObDcit/gRgw7rXDFzwUM8UJ++9bVF/P1TTZJaZZHJ0ODtsddFWYP2xa+AV2Bw+l4R5duCGGbvmy5cxmmPJfukfBgK3SoZT/jUDGyUAr1EPPX8WUw09EiMX5Ns3hiP42RDNcqXi+hZDqFofBqbNYB0zvgUBEOVCuWS8hTIUFdDMZ9w2yHNhFNtQL8=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <613A3ABC402649498D4185DDF0BBA57E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 04f258ae-8a7c-4cfa-1fd1-08d7295d45e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2019 13:08:07.9625
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BQQCHmmmgndaece3mD6sc+roAxpJLX90dpcxuABPZ8OCMHl1vcCfRt/FPJ+XdeliLqb6MbnoUz+Jg5DMBf/t9qvzU84tkmG6YxMmKtJDApw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3630
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDA4LzI1LzIwMTkgMDI6NDcgUE0sIEJvcmlzIEJyZXppbGxvbiB3cm90ZToNCj4gRXh0
ZXJuYWwgRS1NYWlsDQo+IA0KPiANCj4gT24gU2F0LCAyNCBBdWcgMjAxOSAxMjowMDo0MSArMDAw
MA0KPiA8VHVkb3IuQW1iYXJ1c0BtaWNyb2NoaXAuY29tPiB3cm90ZToNCj4gDQo+PiBGcm9tOiBU
dWRvciBBbWJhcnVzIDx0dWRvci5hbWJhcnVzQG1pY3JvY2hpcC5jb20+DQo+Pg0KPj4gVGhlIGdv
YWwgaXMgdG8gbW92ZSB0aGUgcXVhZF9lbmFibGUgbWFudWZhY3R1cmVyIHNwZWNpZmljIGluaXQg
aW4gdGhlDQo+PiBub3ItPm1hbnVmYWN0dXJlci0+Zml4dXBzLT5kZWZhdWx0X2luaXQoKQ0KPj4N
Cj4+IFRoZSBsZWdhY3kgcXVhZF9lbmFibGUoKSBpbXBsZW1lbnRhdGlvbiBpcyBzcGFuc2lvbl9x
dWFkX2VuYWJsZSgpLA0KPj4gc2VsZWN0IHRoaXMgbWV0aG9kIGJ5IGRlZmF1bHQuDQo+Pg0KPj4g
U2V0IHNwZWNpZmljIG1hbnVmYWN0dXJlciBmaXh1cHMtPmRlZmF1bHRfaW5pdCgpIGhvb2tzIHRv
IG92ZXJ3cml0ZQ0KPj4gdGhlIGRlZmF1bHQgcXVhZF9lbmFibGUoKSBpbXBsZW1lbnRhdGlvbiB3
aGVuIG5lZWRlZC4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBUdWRvciBBbWJhcnVzIDx0dWRvci5h
bWJhcnVzQG1pY3JvY2hpcC5jb20+DQo+PiAtLS0NCj4+ICBkcml2ZXJzL210ZC9zcGktbm9yL3Nw
aS1ub3IuYyB8IDQ4ICsrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0N
Cj4+ICAxIGZpbGUgY2hhbmdlZCwgMjkgaW5zZXJ0aW9ucygrKSwgMTkgZGVsZXRpb25zKC0pDQo+
Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbXRkL3NwaS1ub3Ivc3BpLW5vci5jIGIvZHJpdmVy
cy9tdGQvc3BpLW5vci9zcGktbm9yLmMNCj4+IGluZGV4IDI3OTUxZTVhMDFlMi4uYzk1MTRkZmQ3
ZDZkIDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9tdGQvc3BpLW5vci9zcGktbm9yLmMNCj4+ICsr
KyBiL2RyaXZlcnMvbXRkL3NwaS1ub3Ivc3BpLW5vci5jDQo+PiBAQCAtNDE1MCwxMyArNDE1MCwz
OCBAQCBzdGF0aWMgaW50IHNwaV9ub3JfcGFyc2Vfc2ZkcChzdHJ1Y3Qgc3BpX25vciAqbm9yLA0K
Pj4gIAlyZXR1cm4gZXJyOw0KPj4gIH0NCj4+ICANCj4+ICtzdGF0aWMgdm9pZCBtYWNyb25peF9z
ZXRfZGVmYXVsdF9pbml0KHN0cnVjdCBzcGlfbm9yICpub3IpDQo+PiArew0KPj4gKwlub3ItPnBh
cmFtcy5xdWFkX2VuYWJsZSA9IG1hY3Jvbml4X3F1YWRfZW5hYmxlOw0KPiANCj4gU2luY2UgaXQn
cyBub3cgc3VwcG9zZWQgdG8gYmUgdGhlIGRlZmF1bHQgUUUgaW1wbGVtZW50YXRpb24gSSdkDQo+
IHJlY29tbWVuZCByZW5hbWluZyB0aGUgZnVuY3Rpb24gaW50byBkZWZhdWx0X3F1YWRfZW5hYmxl
KCkgKHRoaXMgY2FuIGJlDQo+IGRvbmUgaW4gYSBzZXBhcmF0ZSBwYXRjaCkuDQoNCllvdSBhcmUg
cmVmZXJyaW5nIHRvIHNwYW5zaW9uX3F1YWRfZW5hYmxlLiBZZXMsIHlvdSBtYWRlIGEgcGF0Y2gg
dGhhdCBzdG9wcw0KcHJlZml4aW5nIGdlbmVyaWMgZnVuY3Rpb25zIHdpdGggYSBtYW51ZmFjdHVy
ZXIgbmFtZSwgd2lsbCBmb2xsb3cuDQpodHRwczovL3BhdGNod29yay5vemxhYnMub3JnL3BhdGNo
LzEwMDkyNjQvDQoNCj4gDQo+IFJldmlld2VkLWJ5OiBCb3JpcyBCcmV6aWxsb24gPGJvcmlzLmJy
ZXppbGxvbkBjb2xsYWJvcmEuY29tPg0KPiANCj4+ICt9DQo+PiArDQo+PiArc3RhdGljIHZvaWQg
c3RfbWljcm9uX3NldF9kZWZhdWx0X2luaXQoc3RydWN0IHNwaV9ub3IgKm5vcikNCj4+ICt7DQo+
PiArCW5vci0+cGFyYW1zLnF1YWRfZW5hYmxlID0gTlVMTDsNCj4+ICt9DQo+PiArDQo+PiAgLyoq
DQo+PiAgICogc3BpX25vcl9tYW51ZmFjdHVyZXJfaW5pdF9wYXJhbXMoKSAtIEluaXRpYWxpemUg
dGhlIGZsYXNoJ3MgcGFyYW1ldGVycyBhbmQNCj4+IC0gKiBzZXR0aW5ncyBiYXNlZCBvbiAtPmRl
ZmF1bHRfaW5pdCgpIGhvb2suDQo+PiArICogc2V0dGluZ3MgYmFzZWQgb24gTUZSIHJlZ2lzdGVy
IGFuZCAtPmRlZmF1bHRfaW5pdCgpIGhvb2suDQo+PiAgICogQG5vcjoJcG9pbnRlciB0byBhICdz
dHJ1Y3Qgc3BpLW5vcicuDQo+PiAgICovDQo+PiAgc3RhdGljIHZvaWQgc3BpX25vcl9tYW51ZmFj
dHVyZXJfaW5pdF9wYXJhbXMoc3RydWN0IHNwaV9ub3IgKm5vcikNCj4+ICB7DQo+PiArCS8qIElu
aXQgZmxhc2ggcGFyYW1ldGVycyBiYXNlZCBvbiBNRlIgKi8NCj4+ICsJc3dpdGNoIChKRURFQ19N
RlIobm9yLT5pbmZvKSkgew0KPj4gKwljYXNlIFNOT1JfTUZSX01BQ1JPTklYOg0KPj4gKwkJbWFj
cm9uaXhfc2V0X2RlZmF1bHRfaW5pdChub3IpOw0KPj4gKwkJYnJlYWs7DQo+PiArDQo+PiArCWNh
c2UgU05PUl9NRlJfU1Q6DQo+PiArCWNhc2UgU05PUl9NRlJfTUlDUk9OOg0KPj4gKwkJc3RfbWlj
cm9uX3NldF9kZWZhdWx0X2luaXQobm9yKTsNCj4+ICsJCWJyZWFrOw0KPj4gKw0KPj4gKwlkZWZh
dWx0Og0KPj4gKwkJYnJlYWs7DQo+PiArCX0NCj4+ICsNCj4+ICAJaWYgKG5vci0+aW5mby0+Zml4
dXBzICYmIG5vci0+aW5mby0+Zml4dXBzLT5kZWZhdWx0X2luaXQpDQo+PiAgCQlub3ItPmluZm8t
PmZpeHVwcy0+ZGVmYXVsdF9pbml0KG5vcik7DQo+PiAgfQ0KPj4gQEAgLTQxNjgsNiArNDE5Myw5
IEBAIHN0YXRpYyBpbnQgc3BpX25vcl9pbml0X3BhcmFtcyhzdHJ1Y3Qgc3BpX25vciAqbm9yKQ0K
Pj4gIAljb25zdCBzdHJ1Y3QgZmxhc2hfaW5mbyAqaW5mbyA9IG5vci0+aW5mbzsNCj4+ICAJdTgg
aSwgZXJhc2VfbWFzazsNCj4+ICANCj4+ICsJLyogSW5pdGlhbGl6ZSBsZWdhY3kgZmxhc2ggcGFy
YW1ldGVycyBhbmQgc2V0dGluZ3MuICovDQo+PiArCXBhcmFtcy0+cXVhZF9lbmFibGUgPSBzcGFu
c2lvbl9xdWFkX2VuYWJsZTsNCj4+ICsNCj4+ICAJLyogU2V0IFNQSSBOT1Igc2l6ZXMuICovDQo+
PiAgCXBhcmFtcy0+c2l6ZSA9ICh1NjQpaW5mby0+c2VjdG9yX3NpemUgKiBpbmZvLT5uX3NlY3Rv
cnM7DQo+PiAgCXBhcmFtcy0+cGFnZV9zaXplID0gaW5mby0+cGFnZV9zaXplOw0KPj4gQEAgLTQy
MzMsMjQgKzQyNjEsNiBAQCBzdGF0aWMgaW50IHNwaV9ub3JfaW5pdF9wYXJhbXMoc3RydWN0IHNw
aV9ub3IgKm5vcikNCj4+ICAJCQkgICAgICAgU1BJTk9SX09QX1NFKTsNCj4+ICAJc3BpX25vcl9p
bml0X3VuaWZvcm1fZXJhc2VfbWFwKG1hcCwgZXJhc2VfbWFzaywgcGFyYW1zLT5zaXplKTsNCj4+
ICANCj4+IC0JLyogU2VsZWN0IHRoZSBwcm9jZWR1cmUgdG8gc2V0IHRoZSBRdWFkIEVuYWJsZSBi
aXQuICovDQo+PiAtCWlmIChwYXJhbXMtPmh3Y2Fwcy5tYXNrICYgKFNOT1JfSFdDQVBTX1JFQURf
UVVBRCB8DQo+PiAtCQkJCSAgIFNOT1JfSFdDQVBTX1BQX1FVQUQpKSB7DQo+PiAtCQlzd2l0Y2gg
KEpFREVDX01GUihpbmZvKSkgew0KPj4gLQkJY2FzZSBTTk9SX01GUl9NQUNST05JWDoNCj4+IC0J
CQlwYXJhbXMtPnF1YWRfZW5hYmxlID0gbWFjcm9uaXhfcXVhZF9lbmFibGU7DQo+PiAtCQkJYnJl
YWs7DQo+PiAtDQo+PiAtCQljYXNlIFNOT1JfTUZSX1NUOg0KPj4gLQkJY2FzZSBTTk9SX01GUl9N
SUNST046DQo+PiAtCQkJYnJlYWs7DQo+PiAtDQo+PiAtCQlkZWZhdWx0Og0KPj4gLQkJCS8qIEtl
cHQgb25seSBmb3IgYmFja3dhcmQgY29tcGF0aWJpbGl0eSBwdXJwb3NlLiAqLw0KPj4gLQkJCXBh
cmFtcy0+cXVhZF9lbmFibGUgPSBzcGFuc2lvbl9xdWFkX2VuYWJsZTsNCj4+IC0JCQlicmVhazsN
Cj4+IC0JCX0NCj4+IC0JfQ0KPj4gIA0KPj4gIAlzcGlfbm9yX21hbnVmYWN0dXJlcl9pbml0X3Bh
cmFtcyhub3IpOw0KPj4gIA0KPiANCj4gDQo+IA0K
