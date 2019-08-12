Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6007CC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 10:33:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26593216F4
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 10:33:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="UT6l6SIS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727943AbfHLKd2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 06:33:28 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:57479 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727708AbfHLKd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 06:33:28 -0400
Received-SPF: Pass (esa1.microchip.iphmx.com: domain of
  Tudor.Ambarus@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa1.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="Tudor.Ambarus@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa1.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa1.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa1.microchip.iphmx.com; spf=Pass smtp.mailfrom=Tudor.Ambarus@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: t6DzPJvYyXAaYqX9zsO4ZhWZTgTFHg8XyfqxGAWDZjWnck+i+s6ei6B1F66IWSF3M2qb7l8g9J
 yRryxICZptsuQgJBUUf/wg1vZfUITrHWCi4fgvkDsNVDeFuhFxwNIZ+x8FkS5618bGW46eGRWg
 YzAtI5E7W8U9gHqj9GjncLBr9doj094AGYe9zivX2Wya2eS13049W1YoTDtoUaG8iNgTqynRDJ
 Dlp4Ib89dkW5T5grmVQxZo+4sr/I3iNZgGG6nYTJ87BaD1P+gAVAwSG5puAIgphq0rtdsHwx5q
 fEQ=
X-IronPort-AV: E=Sophos;i="5.64,377,1559545200"; 
   d="scan'208";a="46199172"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 Aug 2019 03:33:26 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 12 Aug 2019 03:33:26 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 12 Aug 2019 03:33:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=md1aVlNI63lImfQX5N7hHrXqdIAs++5CipnZtpu2JRzd9210o+owqIf6YYTnp69HvQFZq9cvKL7kQOwlgxpTi+aRxeblt4VQdnAsRlDVmnYRID4XahEjgu8C5vl66gh+86jxQKtTkRQzAq9KhwC8toG8KmHEpi4ZuOwzcq3i53a3WZBdIG4wroFhByDDmuHuAKblbwd3kO9hr32H7voCBbVyhwlGbHKOCoKK4ok7I1ToCmBPyRbWrEvYhvk1IBaEnmSE2bcPFF6ZInkYez7WxBcCR0jhk0BSqNSci5Z6STieljhzb1PKYEo8tZvyZydmjlce9rLckXM/9HAK2GlxCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WzwUosm1RW7n18nptLr9sEyFkN527VcLruNk5w83nXQ=;
 b=cY80SSdHOGsV2YvQPieLhOwcN9jqIRL3+lFDhSA711peFp8KRu68htY/aeyMy2HPM0K6jlGghIpwjhv3E+EtLWyeAyGlk4SFZBw3S7i7qmWjd24xH6Dab6JnYbs7DtPCL5KbhuHAoLnPZuIe83RDajsBv0yeMu02G+1mx2NVVoa1sj9NrxK1v5s+1FnYkmk9mU/AocXfyUazn11DcZ08aaIkHhbF3AGjWUVNjAzbM/xLMyYdt6gqx4MXoedRkmaNbwBzgv1oCvucRROqij4BSAGo0aVE79JKYC0fo9iOp+RFVvYOerlLCIwl89tp4JjL5Ss0EI9L1C6e3oJg0LVNkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WzwUosm1RW7n18nptLr9sEyFkN527VcLruNk5w83nXQ=;
 b=UT6l6SIS+o8ww9g0OOvgelKX69U5xRSI2/X7FvUlfneCQxE0pmSN7zQ0UbM5HlrRmPlDaYVcSKNy5CoCAUyJKmTr7BlBTGHTC6YphVLQiVZU9Ka+iqOmex4EYeAopjMpTbdp1pQ/ziqHbcK4R05fVrmEtukNNEaUSlyWAl8yZcE=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB3936.namprd11.prod.outlook.com (10.255.180.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.18; Mon, 12 Aug 2019 10:33:23 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::70c3:e929:4da2:60a5]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::70c3:e929:4da2:60a5%7]) with mapi id 15.20.2157.022; Mon, 12 Aug 2019
 10:33:23 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <vigneshr@ti.com>, <miquel.raynal@bootlin.com>, <richard@nod.at>
CC:     <marek.vasut@gmail.com>, <bbrezillon@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <tmaimon77@gmail.com>
Subject: Re: [PATCH v5 0/3] Merge m25p80 into spi-nor
Thread-Topic: [PATCH v5 0/3] Merge m25p80 into spi-nor
Thread-Index: AQHVTBVGOaYYiXIg0EaqOxIPYBmUqqb3WoYA
Date:   Mon, 12 Aug 2019 10:33:23 +0000
Message-ID: <10e5aeb8-c939-0c0c-704a-39d2cb2eb73d@microchip.com>
References: <20190806051041.3636-1-vigneshr@ti.com>
In-Reply-To: <20190806051041.3636-1-vigneshr@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1P190CA0008.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:2b::21) To MN2PR11MB4448.namprd11.prod.outlook.com
 (2603:10b6:208:193::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b0949e43-acb3-4230-c6e3-08d71f10805c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR11MB3936;
x-ms-traffictypediagnostic: MN2PR11MB3936:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <MN2PR11MB39360D846BD728A0BB387837F0D30@MN2PR11MB3936.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 012792EC17
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(39860400002)(366004)(396003)(376002)(189003)(199004)(86362001)(305945005)(66476007)(66556008)(81166006)(478600001)(64756008)(7736002)(31696002)(6246003)(36756003)(8676002)(53936002)(81156014)(66446008)(14454004)(966005)(14444005)(256004)(6116002)(3846002)(2906002)(71190400001)(71200400001)(4326008)(6306002)(66946007)(31686004)(99286004)(66066001)(476003)(76176011)(25786009)(2616005)(316002)(229853002)(486006)(6486002)(26005)(5660300002)(11346002)(52116002)(6436002)(446003)(110136005)(53546011)(6506007)(386003)(8936002)(102836004)(186003)(6512007)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3936;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 6aC7snEtf1UpnXMayOfXygD8YsCGG0FoaWXNgSmtlO0TpEDF8HogK0sa5cNK9rYEx6ISUCNUnyqxtiJzrb1fZ9nh5Sfwu1/3QB6YtOcMvh/W+FxxZ5ti+tL75/oTMHGRj13VvmrAhSBhh5dBMy7HsXkRMQY7CYYjf6S1Oz3IizGY8yzIda2YHREQ5tgWLj8TAjO+lWz8NHL7ukxdBIX98w3zVEkHAmdsTtKSwmQg1gpT00/YDaA/wWL2fBGPa4UWU66EO8gww3nG2YqOlhvP3sIwrnZ3lFlb5ouOvw8Nl8D002vN6OUOKiwfM+3QXIEd/AzlFkh6BtLutbnt2uH5zqu2ftuE+D68556AptUPi4i/As0lQoKDM9/+8cJPjifYkF9JVV8RiEkNl8UtsWIoBK6Cc36jNluKDx4UFN/lTh8=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <3B4C3036C196F645A69E0DC29DE2A1EF@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b0949e43-acb3-4230-c6e3-08d71f10805c
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2019 10:33:23.1834
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MwOkE2brxJ0ctOVkK3cWvHM0IsiYMbnJn2bO9gD6ps5eZwfZk8TwuZNm8uNVZ6kWgrNGzBZzzY6w5eXMiYnCtLvHAIFpU4XgwfdnHw3Z9Hs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3936
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
LmMNCj4gDQoNCkkgZGlkIGFuIGVyYXNlLXdyaXRlLXJlYWQtY2hlY2sgYW5kIGEgbXRkX3NwZWVk
dGVzdCBvbiBteDI1bDI1NjM1ZSBhbmQNCnNzdDI2dmYwNjRiIGZsYXNoZXMgdXNpbmcgYXRtZWwt
cXVhZHNwaSBkcml2ZXIsIGV2ZXJ5dGhpbmcgd2FzIG9rLg0KDQpJIHVwZGF0ZWQgcGF0Y2ggMy8z
IGFzIEkgc2FpZCBpbiBpdHMgdGhyZWFkLg0KDQpBbGwgYXBwbGllZCB0byBodHRwczovL2dpdC5r
ZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9tdGQvbGludXguZ2l0LA0Kc3BpLW5v
ci9uZXh0IGJyYW5jaC4NCg0KVGhhbmtzLA0KdGENCg==
