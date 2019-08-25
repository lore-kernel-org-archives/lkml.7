Return-Path: <SRS0=9baz=WV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EAB9C3A5A1
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 12:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26F112070B
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 12:24:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="TyFCh/Cs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbfHYMX5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Aug 2019 08:23:57 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:9340 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbfHYMX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 08:23:56 -0400
Received-SPF: Pass (esa6.microchip.iphmx.com: domain of
  Tudor.Ambarus@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="Tudor.Ambarus@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa6.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa6.microchip.iphmx.com; spf=Pass smtp.mailfrom=Tudor.Ambarus@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: VWc84WJLbaUQa2Fuy04wdpDLc/bOQDrQqYlKixvrpW65VcV9/8q/FqYStNO5U2u9BYVNDhU0mx
 Auw2+++uBWftN/7jvGuKgkyhud21skFiUK6ZBR/HyY2+GJddPSXWmTF7P6JlTmhx3iBgne8wGq
 9c6cQ3n9yYdKXfz5xCi257TDHLB6bOOcRCSMZzEWZjsy8Uox8W8P9IJrR1JB8caD83j0zkAv7g
 gRZmsrCkfTNQeRwZ6Cu4X7JJcP9mwTPsBSIJOHhl/UCowZ7KF7a53aLXMaEm6SSyKMmUpmyjG9
 tN0=
X-IronPort-AV: E=Sophos;i="5.64,429,1559545200"; 
   d="scan'208";a="43599433"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Aug 2019 05:23:54 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sun, 25 Aug 2019 05:23:51 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Sun, 25 Aug 2019 05:23:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oQ5xIIKxSnnVCdxzB0JI+IKFt510k6NPxkHa/m8aIOAkmBe4b0zxJmjtwQWpBz9g72w4zAW+d8o4HpPV5VIpMVsuhNVEjavn1J3FqPxEgx4JfIodnPZXt/2uUODem7gUAadbFY8jaS7HWsOrI/VqV+Xi7WeR3S8ud6ffk5OszGVejznxJ+DGmqvk0gQmB9QUqWoWw3FXMOg4pYCwb+H4aCxKpOJavILCkdS8n4c6NurhBhxT4e2oLJ1f4vs2CHcULiUG8mk5xkZ1u0us3EMdGeT5lCrIx2TLULjtnaoA6rYpZ+9h+wEE3yAzxjZkV1LE66iZf9+j/NvgLU1fLoFijA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jWyxkvUJqilrNZ5RkcmVRYby34W4BlqmD4jNUBOAgOk=;
 b=IRVvH5QuBDGZtfr9JHSmxwkw2/X8kC33gjlvGpJi90UTtLRRSTTbwIxv3Jn89OOZuSD/JQ+RMksoSRg7kEK8DEKhlOOazJlmOeMzQhPdHSbI/dzrea6OD1wS9VZl66iAIBDnwqgyMmra88cFIPtu5rLb/ahyNkz9vBfhaH4I8TbenoQ5t1S2KQfnt5FunvfYSwwp3Xm+9lbNzHBdYDB13a8Wbh8Z4gqgC5D99LhaEoPgHTAlUebqIyv9grViOUNRaLghx+KfapBWUpTi2exI+L8D3T4MV1LD7TMhINLZSNhtpQt3U4QDP2OBr8rVtBUt0ufVINQGL3y8JUxFrcxj9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jWyxkvUJqilrNZ5RkcmVRYby34W4BlqmD4jNUBOAgOk=;
 b=TyFCh/CsumZ/8wwVgh3Qq1xgGYhJM6e6yj6pvGGIzYSEMAnE8HsBD5Q8Mu3ySyKmhtrZxHIfwm99YOOEABtPQULqn9ddKUJkKOQosgtAJFimb7lVv2t3I4GcpwLr/w9hMzeCUaPFmNU/Obr9g4xsXehzS3vdZfke22LXqzpx2tI=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB3936.namprd11.prod.outlook.com (10.255.180.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Sun, 25 Aug 2019 12:23:46 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::70c3:e929:4da2:60a5]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::70c3:e929:4da2:60a5%7]) with mapi id 15.20.2199.021; Sun, 25 Aug 2019
 12:23:45 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <boris.brezillon@collabora.com>
CC:     <marek.vasut@gmail.com>, <vigneshr@ti.com>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/7] mtd: spi-nor: Split spi_nor_init_params()
Thread-Topic: [PATCH v2 4/7] mtd: spi-nor: Split spi_nor_init_params()
Thread-Index: AQHVWnOOC9h2mNJjWkK/0S4j8FdZtqcLxS8AgAAFwgA=
Date:   Sun, 25 Aug 2019 12:23:45 +0000
Message-ID: <78202b39-1c40-dbaa-3ebc-3481ecbe4643@microchip.com>
References: <20190824120027.14452-1-tudor.ambarus@microchip.com>
 <20190824120027.14452-5-tudor.ambarus@microchip.com>
 <20190825140302.21ca2623@collabora.com>
In-Reply-To: <20190825140302.21ca2623@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR04CA0051.eurprd04.prod.outlook.com
 (2603:10a6:802:2::22) To MN2PR11MB4448.namprd11.prod.outlook.com
 (2603:10b6:208:193::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [86.127.53.184]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6a333c52-47f9-4cba-833a-08d72957131f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR11MB3936;
x-ms-traffictypediagnostic: MN2PR11MB3936:
x-microsoft-antispam-prvs: <MN2PR11MB39364E65A54E446CADC1E719F0A60@MN2PR11MB3936.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01401330D1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39850400004)(136003)(376002)(346002)(366004)(199004)(189003)(3846002)(6116002)(6436002)(8936002)(81166006)(81156014)(4326008)(36756003)(6246003)(66446008)(229853002)(53936002)(186003)(26005)(14444005)(256004)(76176011)(53546011)(99286004)(52116002)(25786009)(102836004)(6512007)(386003)(6506007)(66476007)(66556008)(8676002)(5660300002)(6486002)(86362001)(14454004)(7736002)(305945005)(446003)(316002)(31696002)(66946007)(64756008)(66066001)(478600001)(31686004)(476003)(54906003)(2616005)(11346002)(486006)(71200400001)(71190400001)(6916009)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3936;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: W3nkZytVppL1FcrjUItMviLncCNUi6Ll2SFP9iZpcoA3ioKJVu2z9tpF00V2ygWZdaJvQs17DgNqlUvxqgFd33CPn/WfUn1b7nucAHSCJOxOCmUXmt39jhMb4q2nAdDeHplo90tF1Rxp4da5v8p2yoOlVTxD2t2C7JVysQjfD5HTjQwrxexf/mOE6/tBKsVftcbTFIDxrp7R7UTyDy53yBngDC8BvMkohkXPkehtciPe4V+MSeqqIpk3YjkXuVmPeT3PFxTcKwgEELLs+qfNhn22N7gYBymF15OWGJEVUJVxnwPBw36ACyVWSH2f0kxm6m2nH2HaorT3jqWS2B4XuVoMHTvm9cHxHAX9DbIDVOXBF7oXVhxoLWZoJCVFF0xjX4cyhRhAFtscvfht2gPoyoil3pPddIigeL3Ec5iix78=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <2387C189842A8F479F1ABC599FD15317@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a333c52-47f9-4cba-833a-08d72957131f
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2019 12:23:45.7799
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +jJjxBMDVriFtPxZ8ZIX2t1eAnLUNckBKDB5IPGXZvpWFTsim6twwQfmq/kMVkiGqExxPNqPIUbDWGyKAR37467d1vWC4U6bMkBYoWx84lE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3936
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDA4LzI1LzIwMTkgMDM6MDMgUE0sIEJvcmlzIEJyZXppbGxvbiB3cm90ZToNCj4gRXh0
ZXJuYWwgRS1NYWlsDQo+IA0KPiANCj4gT24gU2F0LCAyNCBBdWcgMjAxOSAxMjowMDo0MyArMDAw
MA0KPiA8VHVkb3IuQW1iYXJ1c0BtaWNyb2NoaXAuY29tPiB3cm90ZToNCj4gDQo+PiBGcm9tOiBU
dWRvciBBbWJhcnVzIDx0dWRvci5hbWJhcnVzQG1pY3JvY2hpcC5jb20+DQo+Pg0KPj4gQWRkIGZ1
bmN0aW9ucyB0byBkZWxpbWl0IHdoYXQgdGhlIGNodW5rcyBvZiBjb2RlIGRvOg0KPj4NCj4+IHN0
YXRpYyB2b2lkIHNwaV9ub3JfaW5pdF9wYXJhbXMoKQ0KPj4gew0KPj4gCXNwaV9ub3JfbGVnYWN5
X2luaXRfcGFyYW1zKCkNCj4+IAlzcGlfbm9yX21hbnVmYWN0dXJlcl9pbml0X3BhcmFtcygpDQo+
PiAJc3BpX25vcl9zZmRwX2luaXRfcGFyYW1zKCkNCj4+IH0NCj4+DQo+PiBBZGQgZGVzY3JpcHRp
b25zIHRvIGFsbCBtZXRob2RzLg0KPj4NCj4+IHNwaV9ub3JfaW5pdF9wYXJhbXMoKSBiZWNvbWVz
IG9mIHR5cGUgdm9pZCwgYXMgYWxsIGl0cyBjaGlsZHJlbg0KPj4gcmV0dXJuIHZvaWQuDQo+Pg0K
Pj4gU2lnbmVkLW9mZi1ieTogVHVkb3IgQW1iYXJ1cyA8dHVkb3IuYW1iYXJ1c0BtaWNyb2NoaXAu
Y29tPg0KPj4gLS0tDQo+PiAgZHJpdmVycy9tdGQvc3BpLW5vci9zcGktbm9yLmMgfCA4MyArKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tDQo+PiAgMSBmaWxlIGNoYW5n
ZWQsIDYzIGluc2VydGlvbnMoKyksIDIwIGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL210ZC9zcGktbm9yL3NwaS1ub3IuYyBiL2RyaXZlcnMvbXRkL3NwaS1ub3Ivc3Bp
LW5vci5jDQo+PiBpbmRleCBjOTUxNGRmZDdkNmQuLjkzNDI0ZjkxNDE1OSAxMDA2NDQNCj4+IC0t
LSBhL2RyaXZlcnMvbXRkL3NwaS1ub3Ivc3BpLW5vci5jDQo+PiArKysgYi9kcml2ZXJzL210ZC9z
cGktbm9yL3NwaS1ub3IuYw0KPj4gQEAgLTQxODYsNyArNDE4NiwzNCBAQCBzdGF0aWMgdm9pZCBz
cGlfbm9yX21hbnVmYWN0dXJlcl9pbml0X3BhcmFtcyhzdHJ1Y3Qgc3BpX25vciAqbm9yKQ0KPj4g
IAkJbm9yLT5pbmZvLT5maXh1cHMtPmRlZmF1bHRfaW5pdChub3IpOw0KPj4gIH0NCj4+ICANCj4+
IC1zdGF0aWMgaW50IHNwaV9ub3JfaW5pdF9wYXJhbXMoc3RydWN0IHNwaV9ub3IgKm5vcikNCj4+
ICsvKioNCj4+ICsgKiBzcGlfbm9yX3NmZHBfaW5pdF9wYXJhbXMoKSAtIEluaXRpYWxpemUgdGhl
IGZsYXNoJ3MgcGFyYW1ldGVycyBhbmQgc2V0dGluZ3MNCj4+ICsgKiBiYXNlZCBvbiBKRVNEMjE2
IFNGRFAgc3RhbmRhcmQuDQo+PiArICogQG5vcjoJcG9pbnRlciB0byBhICdzdHJ1Y3Qgc3BpLW5v
cicuDQo+PiArICoNCj4+ICsgKiBUaGUgbWV0aG9kIGhhcyBhIHJvbGwtYmFjayBtZWNoYW5pc206
IGluIGNhc2UgdGhlIFNGRFAgcGFyc2luZyBmYWlscywgdGhlDQo+PiArICogbGVnYWN5IGZsYXNo
IHBhcmFtZXRlcnMgYW5kIHNldHRpbmdzIHdpbGwgYmUgcmVzdG9yZWQuDQo+PiArICovDQo+PiAr
c3RhdGljIHZvaWQgc3BpX25vcl9zZmRwX2luaXRfcGFyYW1zKHN0cnVjdCBzcGlfbm9yICpub3Ip
DQo+PiArew0KPj4gKwlzdHJ1Y3Qgc3BpX25vcl9mbGFzaF9wYXJhbWV0ZXIgc2ZkcF9wYXJhbXM7
DQo+PiArDQo+PiArCW1lbWNweSgmc2ZkcF9wYXJhbXMsICZub3ItPnBhcmFtcywgc2l6ZW9mKHNm
ZHBfcGFyYW1zKSk7DQo+PiArDQo+PiArCWlmIChzcGlfbm9yX3BhcnNlX3NmZHAobm9yLCAmc2Zk
cF9wYXJhbXMpKSB7DQo+PiArCQlub3ItPmFkZHJfd2lkdGggPSAwOw0KPj4gKwkJbm9yLT5mbGFn
cyAmPSB+U05PUl9GXzRCX09QQ09ERVM7DQo+PiArCX0gZWxzZSB7DQo+PiArCQltZW1jcHkoJm5v
ci0+cGFyYW1zLCAmc2ZkcF9wYXJhbXMsIHNpemVvZihub3ItPnBhcmFtcykpOw0KPj4gKwl9DQo+
PiArfQ0KPj4gKw0KPj4gKy8qKg0KPj4gKyAqIHNwaV9ub3JfbGVnYWN5X2luaXRfcGFyYW1zKCkg
LSBJbml0aWFsaXplIHRoZSBmbGFzaCdzIHBhcmFtZXRlcnMgYW5kIHNldHRpbmdzDQo+PiArICog
YmFzZWQgb24gbm9yLT5pbmZvIGRhdGEuDQo+PiArICogQG5vcjoJcG9pbnRlciB0byBhICdzdHJ1
Y3Qgc3BpLW5vcicuDQo+PiArICovDQo+PiArc3RhdGljIHZvaWQgc3BpX25vcl9sZWdhY3lfaW5p
dF9wYXJhbXMoc3RydWN0IHNwaV9ub3IgKm5vcikNCj4gDQo+IE5pdHBpY2s6IGhtLCBJJ20gbm90
IGEgYmlnIGZhbiBvZiB0aGUgJ2xlZ2FjeScgdGVybSBoZXJlIGFzIEknbSBub3Qgc3VyZQ0KPiBp
dCByZWZsZWN0cyB0aGUgcmVhbGl0eS4gSSBndWVzcyB0aGlzIGZ1bmN0aW9uIHdpbGwgc3RheSBh
cm91bmQsIGFuZA0KPiBldmVuIG5ldyBOT1JzIGFyZSBub3QgZ3VhcmFudGVlZCB0byBwcm92aWRl
IFNGRFAgdGFibGVzLiBIb3cgYWJvdXQNCj4gc3BpX25vcl9zZXRfZGVmYXVsdF9wYXJhbXMoKSBv
ciBzcGlfbm9yX2luZm9faW5pdF9wYXJhbXMoKT8NCg0KSSBjYW4gcmVuYW1lIGl0IHRvIHNwaV9u
b3JfaW5mb19pbml0X3BhcmFtcygpIHRvIGJlIGluIHN5bmMgd2l0aA0KICAgICAgICAgICAgICAg
ICAgIHNwaV9ub3JfbWFudWZhY3R1cmVyX2luaXRfcGFyYW1zKCkgYW5kDQogICAgICAgICAgICAg
ICAgICAgc3BpX25vcl9zZmRwX2luaXRfcGFyYW1zKCkNCg0Kb3IgSSBjYW4gcmVuYW1lIGFsbCB0
bzoNCnNwaV9ub3Jfc2V0X3BhcmFtcygpDQpzcGlfbm9yX3NldF9kZWZhdWx0X3BhcmFtcygpDQpz
cGlfbm9yX3NldF9tYW51ZmFjdHVyZXJfcGFyYW1zKCkNCnNwaV9ub3Jfc2V0X3NmZHBfcGFyYW1z
KCkNCg0KQm90aCBhcmUgb2ssIGJ1dCB0aGUgc2Vjb25kIG9wdGlvbiBzZWVtcyBiZXR0ZXIuIFdo
YXQgd291bGQgeW91IGNob29zZT8NCg0KPiANCj4gVGhhdCdzIGp1c3QgYSBzdWdnZXN0aW9uLCBz
byBoZXJlIGlzIG15DQo+IA0KPiBSZXZpZXdlZC1ieTogQm9yaXMgQnJlemlsbG9uIDxib3Jpcy5i
cmV6aWxsb25AY29sbGFib3JhLmNvbT4NCj4gDQo+IGluIGNhc2UgeW91IHdhbnQgdG8gaWdub3Jl
IGl0Lg0KPiANCj4+ICB7DQo+PiAgCXN0cnVjdCBzcGlfbm9yX2ZsYXNoX3BhcmFtZXRlciAqcGFy
YW1zID0gJm5vci0+cGFyYW1zOw0KPj4gIAlzdHJ1Y3Qgc3BpX25vcl9lcmFzZV9tYXAgKm1hcCA9
ICZwYXJhbXMtPmVyYXNlX21hcDsNCj4+IEBAIC00MjYwLDI1ICs0Mjg3LDQzIEBAIHN0YXRpYyBp
bnQgc3BpX25vcl9pbml0X3BhcmFtcyhzdHJ1Y3Qgc3BpX25vciAqbm9yKQ0KPj4gIAlzcGlfbm9y
X3NldF9lcmFzZV90eXBlKCZtYXAtPmVyYXNlX3R5cGVbaV0sIGluZm8tPnNlY3Rvcl9zaXplLA0K
Pj4gIAkJCSAgICAgICBTUElOT1JfT1BfU0UpOw0KPj4gIAlzcGlfbm9yX2luaXRfdW5pZm9ybV9l
cmFzZV9tYXAobWFwLCBlcmFzZV9tYXNrLCBwYXJhbXMtPnNpemUpOw0KPj4gK30NCj4+ICANCj4+
ICsvKioNCj4+ICsgKiBzcGlfbm9yX2luaXRfcGFyYW1zKCkgLSBJbml0aWFsaXplIHRoZSBmbGFz
aCdzIHBhcmFtZXRlcnMgYW5kIHNldHRpbmdzLg0KPj4gKyAqIEBub3I6CXBvaW50ZXIgdG8gYSAn
c3RydWN0IHNwaS1ub3InLg0KPj4gKyAqDQo+PiArICogVGhlIGZsYXNoIHBhcmFtZXRlcnMgYW5k
IHNldHRpbmdzIGFyZSBpbml0aWFsaXplZCBiYXNlZCBvbiBhIHNlcXVlbmNlIG9mDQo+PiArICog
Y2FsbHMgdGhhdCBhcmUgb3JkZXJlZCBieSBwcmlvcml0eToNCj4+ICsgKg0KPj4gKyAqIDEvIExl
Z2FjeSBmbGFzaCBwYXJhbWV0ZXJzIGluaXRpYWxpemF0aW9uLiBUaGUgaW5pdGlhbGl6YXRpb25z
IGFyZSBkb25lDQo+PiArICogICAgYmFzZWQgb24gbm9yLT5pbmZvIGRhdGE6DQo+PiArICoJCXNw
aV9ub3JfbGVnYWN5X2luaXRfcGFyYW1zKCkNCj4+ICsgKg0KPj4gKyAqIHdoaWNoIGNhbiBiZSBv
dmVyd3JpdHRlbiBieToNCj4+ICsgKiAyLyBNYW51ZmFjdHVyZXIgZmxhc2ggcGFyYW1ldGVycyBp
bml0aWFsaXphdGlvbi4gVGhlIGluaXRpYWxpemF0aW9ucyBhcmUNCj4+ICsgKiAgICBkb25lIGJh
c2VkIG9uIE1GUiByZWdpc3Rlciwgb3Igd2hlbiB0aGUgZGVjaXNpb25zIGNhbiBub3QgYmUgZG9u
ZSBzb2xlbHkNCj4+ICsgKiAgICBiYXNlZCBvbiBNRlIsIGJ5IHVzaW5nIHNwZWNpZmljIGZsYXNo
X2luZm8gdHdlZWtzLCAtPmRlZmF1bHRfaW5pdCgpOg0KPj4gKyAqCQlzcGlfbm9yX21hbnVmYWN0
dXJlcl9pbml0X3BhcmFtcygpDQo+PiArICoNCj4+ICsgKiB3aGljaCBjYW4gYmUgb3ZlcndyaXR0
ZW4gYnk6DQo+PiArICogMy8gU0ZEUCBmbGFzaCBwYXJhbWV0ZXJzIGluaXRpYWxpemF0aW9uLiBK
RVNEMjE2IFNGRFAgaXMgYSBzdGFuZGFyZCBhbmQNCj4+ICsgKiAgICBzaG91bGQgYmUgbW9yZSBh
Y2N1cmF0ZSB0aGF0IHRoZSBhYm92ZS4NCj4+ICsgKgkJc3BpX25vcl9zZmRwX2luaXRfcGFyYW1z
KCkNCj4+ICsgKg0KPj4gKyAqICAgIFBsZWFzZSBub3QgdGhhdCB0aGVyZSBpcyBhIC0+cG9zdF9i
ZnB0KCkgZml4dXAgaG9vayB0aGF0IGNhbiBvdmVyd3JpdGUgdGhlDQo+PiArICogICAgZmxhc2gg
cGFyYW1ldGVycyBhbmQgc2V0dGluZ3MgaW1lZGlhdGVseSBhZnRlciBwYXJzaW5nIHRoZSBCYXNp
YyBGbGFzaA0KPj4gKyAqICAgIFBhcmFtZXRlciBUYWJsZS4NCj4+ICsgKi8NCj4+ICtzdGF0aWMg
dm9pZCBzcGlfbm9yX2luaXRfcGFyYW1zKHN0cnVjdCBzcGlfbm9yICpub3IpDQo+PiArew0KPj4g
KwlzcGlfbm9yX2xlZ2FjeV9pbml0X3BhcmFtcyhub3IpOw0KPj4gIA0KPj4gIAlzcGlfbm9yX21h
bnVmYWN0dXJlcl9pbml0X3BhcmFtcyhub3IpOw0KPj4gIA0KPj4gLQlpZiAoKGluZm8tPmZsYWdz
ICYgKFNQSV9OT1JfRFVBTF9SRUFEIHwgU1BJX05PUl9RVUFEX1JFQUQpKSAmJg0KPj4gLQkgICAg
IShpbmZvLT5mbGFncyAmIFNQSV9OT1JfU0tJUF9TRkRQKSkgew0KPj4gLQkJc3RydWN0IHNwaV9u
b3JfZmxhc2hfcGFyYW1ldGVyIHNmZHBfcGFyYW1zOw0KPj4gLQ0KPj4gLQkJbWVtY3B5KCZzZmRw
X3BhcmFtcywgcGFyYW1zLCBzaXplb2Yoc2ZkcF9wYXJhbXMpKTsNCj4+IC0NCj4+IC0JCWlmIChz
cGlfbm9yX3BhcnNlX3NmZHAobm9yLCAmc2ZkcF9wYXJhbXMpKSB7DQo+PiAtCQkJbm9yLT5hZGRy
X3dpZHRoID0gMDsNCj4+IC0JCQlub3ItPmZsYWdzICY9IH5TTk9SX0ZfNEJfT1BDT0RFUzsNCj4+
IC0JCX0gZWxzZSB7DQo+PiAtCQkJbWVtY3B5KHBhcmFtcywgJnNmZHBfcGFyYW1zLCBzaXplb2Yo
KnBhcmFtcykpOw0KPj4gLQkJfQ0KPj4gLQl9DQo+PiAtDQo+PiAtCXJldHVybiAwOw0KPj4gKwlp
ZiAoKG5vci0+aW5mby0+ZmxhZ3MgJiAoU1BJX05PUl9EVUFMX1JFQUQgfCBTUElfTk9SX1FVQURf
UkVBRCkpICYmDQo+PiArCSAgICAhKG5vci0+aW5mby0+ZmxhZ3MgJiBTUElfTk9SX1NLSVBfU0ZE
UCkpDQo+PiArCQlzcGlfbm9yX3NmZHBfaW5pdF9wYXJhbXMobm9yKTsNCj4+ICB9DQo+PiAgDQo+
PiAgc3RhdGljIGludCBzcGlfbm9yX3NlbGVjdF9yZWFkKHN0cnVjdCBzcGlfbm9yICpub3IsDQo+
PiBAQCAtNDY5MywxMCArNDczOCw4IEBAIGludCBzcGlfbm9yX3NjYW4oc3RydWN0IHNwaV9ub3Ig
Km5vciwgY29uc3QgY2hhciAqbmFtZSwNCj4+ICAJICAgIG5vci0+aW5mby0+ZmxhZ3MgJiBTUElf
Tk9SX0hBU19MT0NLKQ0KPj4gIAkJbm9yLT5wYXJhbXMuZGlzYWJsZV9ibG9ja19wcm90ZWN0aW9u
ID0gc3BpX25vcl9jbGVhcl9zcl9icDsNCj4+ICANCj4+IC0JLyogUGFyc2UgdGhlIFNlcmlhbCBG
bGFzaCBEaXNjb3ZlcmFibGUgUGFyYW1ldGVycyB0YWJsZS4gKi8NCj4+IC0JcmV0ID0gc3BpX25v
cl9pbml0X3BhcmFtcyhub3IpOw0KPj4gLQlpZiAocmV0KQ0KPj4gLQkJcmV0dXJuIHJldDsNCj4+
ICsJLyogSW5pdCBmbGFzaCBwYXJhbWV0ZXJzIGJhc2VkIG9uIGZsYXNoX2luZm8gc3RydWN0IGFu
ZCBTRkRQICovDQo+PiArCXNwaV9ub3JfaW5pdF9wYXJhbXMobm9yKTsNCj4+ICANCj4+ICAJaWYg
KCFtdGQtPm5hbWUpDQo+PiAgCQltdGQtPm5hbWUgPSBkZXZfbmFtZShkZXYpOw0KPiANCj4gDQo+
IA0K
