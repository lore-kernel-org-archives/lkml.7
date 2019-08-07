Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD4CCC433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 05:54:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E904217D7
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 05:54:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="ZorF9sr+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbfHGFyQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 01:54:16 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:43444 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbfHGFyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 01:54:16 -0400
Received-SPF: Pass (esa4.microchip.iphmx.com: domain of
  Tudor.Ambarus@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa4.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="Tudor.Ambarus@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa4.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa4.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa4.microchip.iphmx.com; spf=Pass smtp.mailfrom=Tudor.Ambarus@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: AkRVGV3AmLF2vmDiBhOOn5TDMguXp/F/I8pBKgXJ4NWEK1M+5fb5YvsJzixZ3+OIFRyVFFLYxi
 VHYGS++/zks2DJySRgR0cFzKFMYaRqW/Vw1GC9rI5IYoQ+f+ASsA1XwwS3Jbyioc182zfVqNe9
 NRxEqnBGy6DUVOBNgG0GbnehvnehDHCTDF5boqu27QiSScJnjjFnN5R0vwVo8Cbfkg4FlRtBwe
 JvJrVab01GsVu4/RFHk6JYwbKdYoAu3qWAKvw3o/OwDp6kcTzOKOd8mC+fNmYPR9jGQd5WEfNA
 doA=
X-IronPort-AV: E=Sophos;i="5.64,356,1559545200"; 
   d="scan'208";a="43449305"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Aug 2019 22:54:14 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 6 Aug 2019 22:54:13 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 6 Aug 2019 22:54:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RHfIIRCoFepDG+zVtcO79G6gx/mRB0s5MZNwnJnP/QptWvmsA3ISJn7IzxFQ41SyusANy18QyrI3PLEoWOmfs+Vm1ub8mFs4ndR3x8vee2d/DXk9svFJVV1iqAb+eyAqnfJQbxAGYK61IisMGRIgrwfRqm8SQh3NK2qVex0GL5uTrbLs8ByTS0PaiamUdVxmWsM3x4fSGtWxz1iC/XfXN9rovuiThJzd+u0T/n+6ZwSZmWpCzuFk4DPr26ulLMU0rb1CKjomN/IPuP6Gp10ot7lmGvy8v7ZVVJeN7X8oGAF3xmzvMOtB1mSSZU8gDzQ9H6Se6rY1qTs3G9mWjMrf1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ze/3XoXw5VJmpxZyiNXB8Cb7Q4rmr7fQgEZPf+X3RFI=;
 b=fmS18p6eNk/GZ5X0ZiDE7IMUGkQT1ar7M6UTnUR63lBUcme6D+4xuchQAzYBXFW/XmyBbx3ndOKBygbX20X9664DiPHVuTXGnp+Wca0LiTQy1zqxfXsNhzOTYHeL14Izt8lweu1UXdHKu70Lvkx4U41lostmEbI5OIkmh8eMDtrpv0xlOtoqnETJjtwmXmRjcqkHpqNuNDxCbe1RCVuEHoLAgRbvBKCBUTMnAoZvN09+vmbwlC4fUgYk/haa6DjhWVBL/pu2dgSiMjIBucnad+1mFDVadJQEeSoTFUiPewZ94BGwRsSKC4EDBcnTiYDnFWw3XwBQTlLvpc/sPkcwgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=microchip.com;dmarc=pass action=none
 header.from=microchip.com;dkim=pass header.d=microchip.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ze/3XoXw5VJmpxZyiNXB8Cb7Q4rmr7fQgEZPf+X3RFI=;
 b=ZorF9sr+oJeY3+UaMbNoUs6TJEJl5gfM1+MJhZxpr5gqKGa6ofHhMVEi5C3bU0BGYRuOFEsavicivtJGToqQbI/OxKvCmBI/JeydJES/5sBETwypnm7AYWXWrBjnFJiIafJa1OC6EvuMJydVCwhCjX9QTlWULb+6eeAKZ1Zi9pE=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB3935.namprd11.prod.outlook.com (10.255.180.213) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.17; Wed, 7 Aug 2019 05:54:11 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::70c3:e929:4da2:60a5]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::70c3:e929:4da2:60a5%7]) with mapi id 15.20.2136.018; Wed, 7 Aug 2019
 05:54:11 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <vigneshr@ti.com>, <miquel.raynal@bootlin.com>, <richard@nod.at>
CC:     <marek.vasut@gmail.com>, <bbrezillon@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <tmaimon77@gmail.com>
Subject: Re: [PATCH v5 0/3] Merge m25p80 into spi-nor
Thread-Topic: [PATCH v5 0/3] Merge m25p80 into spi-nor
Thread-Index: AQHVTBVGOaYYiXIg0EaqOxIPYBmUqqbvMNuA
Date:   Wed, 7 Aug 2019 05:54:10 +0000
Message-ID: <f2e987e8-95bc-ab5f-433b-ab3aaa4a78c0@microchip.com>
References: <20190806051041.3636-1-vigneshr@ti.com>
In-Reply-To: <20190806051041.3636-1-vigneshr@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR04CA0083.eurprd04.prod.outlook.com
 (2603:10a6:803:64::18) To MN2PR11MB4448.namprd11.prod.outlook.com
 (2603:10b6:208:193::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [86.127.106.210]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bd27bfe1-77b3-40ad-f641-08d71afbab09
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MN2PR11MB3935;
x-ms-traffictypediagnostic: MN2PR11MB3935:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <MN2PR11MB39356597F262691C99BF65C7F0D40@MN2PR11MB3935.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01221E3973
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(136003)(376002)(396003)(346002)(61684003)(199004)(189003)(2616005)(81156014)(186003)(54906003)(110136005)(446003)(486006)(316002)(26005)(36756003)(66446008)(64756008)(6116002)(66556008)(66476007)(6512007)(3846002)(66946007)(4326008)(2906002)(5660300002)(25786009)(966005)(31696002)(6486002)(86362001)(71190400001)(53936002)(14444005)(102836004)(68736007)(229853002)(305945005)(256004)(386003)(11346002)(476003)(478600001)(6246003)(31686004)(52116002)(8676002)(53546011)(99286004)(6436002)(6306002)(6506007)(71200400001)(76176011)(66066001)(14454004)(8936002)(81166006)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3935;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: mNYAY21LrIUcrx+ru0o2UC1KnlToh3WgToxSRFAVB1hKVyjR09HPc3MkO7p7IDWIizfeORjqSn+Ympb8q+Mx/seFQcxxn26fjJQvPF9+8GIOeyqOduEJBU3kap5d5/5cgyr8p8+39PAi30swfhh69uK5EQri00CluRY+rPsrw/B9abSuxeMYl3IDqe98garowKr/2dTgPcZIC5pCBPTyDwbWQ0PKr+uaOC6CUzvQ4Oue91D9w46ESNpXSDUyTgt6XqfRKiR1Q0LuqHFOFsWM7RNRPJfeZbnGuA8d2yX3lrvYAOCFoGFJM4+u4KTWmC8re3e78eX2e7pRfcytYV+Yvitx25FqffykFZ84Qddz4wctRqG/rgzaVWpIZDNhWpa5rT8Px0ouBvOaDVxfeKHh7ME/4r1v8m08VE+UvxIeZ3E=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2CF1DAFC64C2484FA253944DD2D43C32@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: bd27bfe1-77b3-40ad-f641-08d71afbab09
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2019 05:54:10.8412
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tudor.ambarus@microchip.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3935
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDA4LzA2LzIwMTkgMDg6MTAgQU0sIFZpZ25lc2ggUmFnaGF2ZW5kcmEgd3JvdGU6DQo+
IEV4dGVybmFsIEUtTWFpbA0KPiANCj4gDQo+IFRoaXMgaXMgcmVwb3N0IG9mIHBhdGNoIDYgYW5k
IDcgc3BsaXQgZnJvbSBmcm9tIEJvcmlzIEJyZXppbGxvbidzIFgtWC1YDQo+IG1vZGUgc3VwcG9y
dCBzZXJpZXNbMV0NCj4gDQo+IEJhY2tncm91bmQgZnJvbSBjb3ZlciBsZXR0ZXIgZm9yIFJGQ1sx
XToNCj4gbTI1cDgwIGlzIGp1c3QgYSBzaW1wbGUgU1BJIE5PUiBjb250cm9sbGVyIGRyaXZlciAo
YSB3cmFwcGVyIGFyb3VuZCB0aGUNCj4gU1BJIG1lbSBBUEkpLiBOb3Qgb25seSBpdCBzaG91bGRu
J3QgYmUgbmFtZWQgYWZ0ZXIgYSBzcGVjaWZpYyBTUEkgTk9SDQo+IGNoaXAsIGJ1dCBpdCBhbHNv
IGRvZXNuJ3QgZGVzZXJ2ZSBhIHNwZWNpZmljIGRyaXZlciBJTU8sIGVzcGVjaWFsbHkgaWYNCj4g
dGhlIGVuZCBnb2FsIGlzIHRvIGdldCByaWQgb2YgU1BJIE5PUiBjb250cm9sbGVyIGRyaXZlcnMg
Zm91bmQgaW4NCj4gZHJpdmVycy9tdGQvc3BpLW5vci8gYW5kIHJlcGxhY2UgdGhlbSBieSBTUEkg
bWVtIGRyaXZlcnMgKHdoaWNoIHdvdWxkDQo+IGJlIHBsYWNlZCBpbiBkcml2ZXJzL3NwaS8pLiBX
aXRoIHRoaXMgc29sdXRpb24sIHdlIGRlY2xhcmUgdGhlIFNQSSBOT1INCj4gZHJpdmVyIGFzIGEg
c3BpX21lbV9kcml2ZXIsIGp1c3QgbGlrZSB0aGUgU1BJIE5BTkQgbGF5ZXIgaXMgZGVjbGFyZWQg
YXMNCj4gYSBzcGlfbWVtIGRyaXZlciAocGF0Y2ggMS8yKS4NCj4gVGhpcyBzb2x1dGlvbiBhbHNv
IGFsbG93cyB1cyB0byBjaGVjayBhdCBhIGZpbmVkLWdyYWluIGxldmVsICh0aGFua3MgdG8NCj4g
dGhlIHNwaV9tZW1fc3VwcG9ydHNfb3AoKSBmdW5jdGlvbikgd2hpY2ggb3BlcmF0aW9ucyBhcmUg
c3VwcG9ydGVkIGFuZA0KPiB3aGljaCBvbmVzIGFyZSBub3QsIHdoaWxlIHRoZSBvcmlnaW5hbCBt
MjVwODAgbG9naWMgd2FzIGJhc2luZyB0aGlzDQo+IGRlY2lzaW9uIG9uIHRoZSBTUElfe1JYLFRY
fV97RFVBTCxRVUFELE9DVE99IGZsYWdzIG9ubHkgKHBhdGNoIDIvMikuDQo+IA0KPiBbMV0gaHR0
cHM6Ly9wYXRjaHdvcmsub3psYWJzLm9yZy9jb3Zlci85ODI5MjYvDQo+IA0KPiBUZXN0ZWQgb24g
VEknIERSQTd4eCBFVk0gd2l0aCBUSSBRU1BJIGNvbnRyb2xsZXIgKGEgc3BpLW1lbSBkcml2ZXIp
IHdpdGgNCj4gRE1BIChzMjVmbDI1NiBhbmQgbXg2Nmw1MTIzNWwpIGZsYXNoLiBJIGRvbid0IHNl
ZSBhbnkgcGVyZm9ybWFuY2UNCj4gcmVncmVzc2lvbiBkdWUgdG8gYm91bmNlIGJ1ZmZlciBjb3B5
IGludHJvZHVjZWQgYnkgdGhpcyBzZXJpZXMNCj4gQWxzbyB0ZXN0ZWQgd2l0aCBjYWRlbmNlLXF1
YWRzcGkgKGEgc3BpLW5vciBkcml2ZXIpIGRyaXZlcg0KPiANCj4gQm9yaXMgQnJlemlsbG9uICgy
KToNCj4gICBtdGQ6IHNwaS1ub3I6IE1vdmUgbTI1cDgwIGNvZGUgaW4gc3BpLW5vci5jDQo+ICAg
bXRkOiBzcGktbm9yOiBSZXdvcmsgaHdjYXBzIHNlbGVjdGlvbiBmb3IgdGhlIHNwaS1tZW0gY2Fz
ZQ0KPiANCj4gVmlnbmVzaCBSYWdoYXZlbmRyYSAoMSk6DQo+ICAgbXRkOiBzcGktbm9yOiBhbHdh
eXMgdXNlIGJvdW5jZSBidWZmZXIgZm9yIHJlZ2lzdGVyIHJlYWQvd3JpdGVzDQo+IA0KPiAgZHJp
dmVycy9tdGQvZGV2aWNlcy9LY29uZmlnICAgfCAgMTggLQ0KPiAgZHJpdmVycy9tdGQvZGV2aWNl
cy9NYWtlZmlsZSAgfCAgIDEgLQ0KPiAgZHJpdmVycy9tdGQvZGV2aWNlcy9tMjVwODAuYyAgfCAz
NDcgLS0tLS0tLS0tLS0tLS0tDQo+ICBkcml2ZXJzL210ZC9zcGktbm9yL0tjb25maWcgICB8ICAg
MiArDQo+ICBkcml2ZXJzL210ZC9zcGktbm9yL3NwaS1ub3IuYyB8IDgxNCArKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrLS0tDQo+ICBpbmNsdWRlL2xpbnV4L210ZC9zcGktbm9yLmggICB8
ICAyNCArLQ0KPiAgNiBmaWxlcyBjaGFuZ2VkLCA3NzcgaW5zZXJ0aW9ucygrKSwgNDI5IGRlbGV0
aW9ucygtKQ0KPiAgZGVsZXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvbXRkL2RldmljZXMvbTI1cDgw
LmMNCj4gDQoNClRoZSBwYXRjaGVzIGFyZSBsb29raW5nIGdvb2QuIEknbGwgYmUgb3V0IG9mIG9m
ZmljZSBzdGFydGluZyB0b2RheSBhbmQgd2lsbA0KcmV0dXJuIG9uIE1vbmRheS4gSSdsbCBsZXQg
dGhlIDBkYXkgYm90IHJ1biBpdHMgdGVzdHMgYW5kIHRoZW4gSSB3aWxsIGRvIHNvbWUNCnRlc3Rz
IG9uIGEgZmxhc2ggb3IgdHdvLiBJIGludGVuZCB0byBhcHBseSB5b3VyIHBhdGNoZXMgb24gTW9u
ZGF5Lg0KDQpUaGFua3MsIFZpZ25lc2ghDQp0YQ0K
