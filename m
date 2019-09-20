Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB46CC49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 05:26:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A97342086A
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 05:26:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="WubN7Xfz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407257AbfITFXb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 01:23:31 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:40252 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391495AbfITFXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 01:23:30 -0400
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
IronPort-SDR: CPVOfobjbAvwT/NF9DlL7QYo/26jpxI75ES9vjrLrR35SoQhNvQFmnOWSSIAHXlHGDjIZc1OMd
 fpGDQ+tTVd267cRj/7ka8RlLgRgWrZ9dSZjVOfdMX7ck0RyEh9tBcdY28t19KlVH9zgG7u5CfW
 ZQJhuBzugx54SegJWykl1ZHgGalfhMcW9qWrcekpydekW3kADKWVBWV2BYZSnQxARoEbGiHsHc
 FRlAPjSdOnUSnGIUZah8yBQ4nstUMif4QgXjkoAUaT2jFHrBBVIoS3BAIfh+AxL2HapDYvyT+L
 nyU=
X-IronPort-AV: E=Sophos;i="5.64,527,1559545200"; 
   d="scan'208";a="51221959"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 Sep 2019 22:23:28 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 19 Sep 2019 22:23:28 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5 via Frontend
 Transport; Thu, 19 Sep 2019 22:23:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BCbPi9aLFQs4TTtyFJC8Drdc69m9emXYsWxD1mV1SkN1c8JIClf/JV7VbSN+2ei8xp5QVZTD2BiGX7ajwJF3XSJl5Junhb+IFn9ioI4Heif65HTpAhD2tTEHeYVY0EsePTjrtJEWXnHBekel4UyrFn7U+ztbn0rpA9MIH6a0p0UF5vZ3LGfxMBmNJZXt+0AmIX7Octyo8y79KAHQLTtgb7X4r+w1xvsxy0bvZiDvbZ4MHfSTOlbyvywXbRHHb4FV7Q4c3yRXWTBrkLXvQRtXI2zCebaE0+k3V0UPyWyBzzwN4pVp/w9nMTmXSsNKl14U+C8hB9rT7URqvoWyusgszg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AaOemcgOXJ1MG2hxzAouc6CXqsDMmP0ta0KYa6QkY7I=;
 b=lCF01A1xXZNHFx3Wb1hvu2ToxpCDVGRBT/0EeaLSxtAZFspGXGNNuL5HKHFed2qlHD4Qv1hD5Qf7SCVRINh2AVKaueq6FYFR+56LNK+jTFWQGSrw6EpRCt6/bWpe7s0WMgjakFSSwaUNRVDxBqSOX3vK2MSHK8UY4BV7Z5QU7gNJbYaFbITAi3W5H8Q9MBhl3EJ4bUXH+kVuyc377VZ96yO9YfMxI7KRMRX0qwX1796eHWO7oa/hSFDdEveZyt9hxk8dWWvTR2FMXzHyJ+9q0miAkAMDvti9hmjI8ibOF7GHs18MnrzdtYFgQ3nvEK721G+puHR5LdZo6JoYYPi1Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AaOemcgOXJ1MG2hxzAouc6CXqsDMmP0ta0KYa6QkY7I=;
 b=WubN7XfzN64R49QaAIUaK0LhmoRqO4xZMAXhEOI16PPGMNeuiJVs26VgHBNazSNabH80r2p/Qkhs6GdKnmmweZnHkADq48h6WpBruVYcodH3HpQUyIg+qPDNpufqnaQLNLL0IhI0ky5+t9eZKt2W3l2VnyZAJfIG6COtR4heKcM=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB3790.namprd11.prod.outlook.com (20.178.253.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.17; Fri, 20 Sep 2019 05:23:26 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c951:b15a:e4b3:30f7]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c951:b15a:e4b3:30f7%7]) with mapi id 15.20.2263.023; Fri, 20 Sep 2019
 05:23:26 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <vigneshr@ti.com>, <boris.brezillon@collabora.com>,
        <marek.vasut@gmail.com>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <linux-mtd@lists.infradead.org>
CC:     <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <joel@jms.id.au>, <andrew@aj.id.au>, <matthias.bgg@gmail.com>,
        <vz@mleia.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH 17/23] mtd: spi-nor: Fix clearing of QE bit on
 lock()/unlock()
Thread-Topic: [PATCH 17/23] mtd: spi-nor: Fix clearing of QE bit on
 lock()/unlock()
Thread-Index: AQHVbXBXffWwZrBoIkKrGGyrhA4/GaczE40AgAD4lQA=
Date:   Fri, 20 Sep 2019 05:23:26 +0000
Message-ID: <06a6e4e8-6802-3f85-ec3c-6295cd703c85@microchip.com>
References: <20190917155426.7432-1-tudor.ambarus@microchip.com>
 <20190917155426.7432-18-tudor.ambarus@microchip.com>
 <dceca616-2b98-9bc8-73e4-32fb06fc753d@ti.com>
In-Reply-To: <dceca616-2b98-9bc8-73e4-32fb06fc753d@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR08CA0186.eurprd08.prod.outlook.com
 (2603:10a6:800:d2::16) To MN2PR11MB4448.namprd11.prod.outlook.com
 (2603:10b6:208:193::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c0cac818-8de3-4874-6805-08d73d8aa9f9
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR11MB3790;
x-ms-traffictypediagnostic: MN2PR11MB3790:
x-microsoft-antispam-prvs: <MN2PR11MB37900B6CB67A8F69ED04A320F0880@MN2PR11MB3790.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0166B75B74
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(136003)(376002)(346002)(366004)(199004)(189003)(54906003)(71200400001)(316002)(6506007)(3846002)(386003)(476003)(102836004)(446003)(71190400001)(186003)(53546011)(486006)(229853002)(66446008)(99286004)(2616005)(6246003)(6116002)(52116002)(305945005)(11346002)(31686004)(7736002)(4326008)(66556008)(5660300002)(2501003)(6436002)(86362001)(66476007)(81156014)(81166006)(8936002)(110136005)(14454004)(25786009)(2201001)(256004)(7416002)(66066001)(6512007)(36756003)(8676002)(76176011)(26005)(14444005)(64756008)(2906002)(478600001)(66946007)(31696002)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3790;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ZvOAhhsGaIPRHiKwLZyw5Kj+71YuARSIsiUQE2y8O/gyJc1HpjD6YTc20hQySt29uyO9Ne/HXSlH7jbyplXAPUeFp7WO9KGPpgAy40e4syIQC7nnhjk0VVW1Nz4T6DJIFnLBeJOT/yWuyMA9vJB4LeJ/9NPlsOp4WHgQAYc05y5JjbJ4dHZdwwlHgbTKgJ9mjzZ5Pa3Ji+Hm//npbqPH3GKTA8wR9kQIDblD5OHGJIiwpCzs6+DKrBNydXo4S09WngUNl2dxVLuLjr6z5dHQYdTT53v+BvBBBra6NcjHsvoGYGpVCNVf+czL4imv0s/LZ68hruo6J7HmEumXrGo+Wlp3g0dXLYs6PT3f5I0MGi/nUrujZTZhaNyA+W9i5fSkz22aKUxSgZptsEanvMfkCwT9n5AtNvLPxGxlzngo8fA=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <C2F6B467087FEE42995F694D31906562@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c0cac818-8de3-4874-6805-08d73d8aa9f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2019 05:23:26.4389
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9PzirPctoByOqdv7vJqix1HJ7MgDqMLB7PSmQPXDFmcT7pS/udGktDjkuqVlL99g68j6C6rH043rutTyZrKqkAbsxP8hWlx44UaOfOEf0QM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3790
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFZpZ25lc2gsDQoNCk9uIDA5LzE5LzIwMTkgMDU6MzMgUE0sIFZpZ25lc2ggUmFnaGF2ZW5k
cmEgd3JvdGU6DQo+IEV4dGVybmFsIEUtTWFpbA0KPiANCj4gDQo+IEhpIFR1ZG9yDQo+IA0KPiBb
Li4uXQ0KPiANCj4gT24gMTctU2VwLTE5IDk6MjUgUE0sIFR1ZG9yLkFtYmFydXNAbWljcm9jaGlw
LmNvbSB3cm90ZToNCj4+ICtzdGF0aWMgaW50IHNwaV9ub3Jfd3JpdGVfMTZiaXRfc3JfYW5kX2No
ZWNrKHN0cnVjdCBzcGlfbm9yICpub3IsIHU4IHN0YXR1c19uZXcsDQo+PiArCQkJCQkgICAgdTgg
bWFzaykNCj4+ICt7DQo+PiArCWludCByZXQ7DQo+PiArCXU4ICpzcl9jciA9IG5vci0+Ym91bmNl
YnVmOw0KPj4gKwl1OCBjcl93cml0dGVuOw0KPj4gKw0KPj4gKwkvKiBNYWtlIHN1cmUgd2UgZG9u
J3Qgb3ZlcndyaXRlIHRoZSBjb250ZW50cyBvZiBTdGF0dXMgUmVnaXN0ZXIgMi4gKi8NCj4+ICsJ
aWYgKCEobm9yLT5mbGFncyAmIFNOT1JfRl9OT19SRUFEX0NSKSkgew0KPiANCj4gQXNzdW1pbmcg
U05PUl9GX05PX1JFQURfQ1IgaXMgbm90IHNldC4uLg0KPiANCj4+ICsJCXJldCA9IHNwaV9ub3Jf
cmVhZF9jcihub3IsICZzcl9jclsxXSk7DQo+PiArCQlpZiAocmV0KQ0KPj4gKwkJCXJldHVybiBy
ZXQ7DQo+PiArCX0gZWxzZSBpZiAobm9yLT5mbGFzaC5xdWFkX2VuYWJsZSkgew0KPj4gKwkJLyoN
Cj4+ICsJCSAqIElmIHRoZSBTdGF0dXMgUmVnaXN0ZXIgMiBSZWFkIGNvbW1hbmQgKDM1aCkgaXMg
bm90DQo+PiArCQkgKiBzdXBwb3J0ZWQsIHdlIHNob3VsZCBhdCBsZWFzdCBiZSBzdXJlIHdlIGRv
bid0DQo+PiArCQkgKiBjaGFuZ2UgdGhlIHZhbHVlIG9mIHRoZSBTUjIgUXVhZCBFbmFibGUgYml0
Lg0KPj4gKwkJICoNCj4+ICsJCSAqIFdlIGNhbiBzYWZlbHkgYXNzdW1lIHRoYXQgd2hlbiB0aGUg
UXVhZCBFbmFibGUgbWV0aG9kIGlzDQo+PiArCQkgKiBzZXQsIHRoZSB2YWx1ZSBvZiB0aGUgUUUg
Yml0IGlzIG9uZSwgYXMgYSBjb25zZXF1ZW5jZSBvZiB0aGUNCj4+ICsJCSAqIG5vci0+Zmxhc2gu
cXVhZF9lbmFibGUoKSBjYWxsLg0KPj4gKwkJICoNCj4+ICsJCSAqIFdlIGNhbiBzYWZlbHkgYXNz
dW1lIHRoYXQgdGhlIFF1YWQgRW5hYmxlIGJpdCBpcyBwcmVzZW50IGluDQo+PiArCQkgKiB0aGUg
U3RhdHVzIFJlZ2lzdGVyIDIgYXQgQklUKDEpLiBBY2NvcmRpbmcgdG8gdGhlIEpFU0QyMTYNCj4+
ICsJCSAqIHJldkIgc3RhbmRhcmQsIEJGUFQgRFdPUkRTWzE1XSwgYml0cyAyMjoyMCwgdGhlIDE2
LWJpdA0KPj4gKwkJICogV3JpdGUgU3RhdHVzICgwMWgpIGNvbW1hbmQgaXMgYXZhaWxhYmxlIGp1
c3QgZm9yIHRoZSBjYXNlcw0KPj4gKwkJICogaW4gd2hpY2ggdGhlIFFFIGJpdCBpcyBkZXNjcmli
ZWQgaW4gU1IyIGF0IEJJVCgxKS4NCj4+ICsJCSAqLw0KPj4gKwkJc3JfY3JbMV0gPSBDUl9RVUFE
X0VOX1NQQU47DQo+PiArCX0gZWxzZSB7DQo+PiArCQlzcl9jclsxXSA9IDA7DQo+PiArCX0NCj4+
ICsNCj4gDQo+IENSX1FVQURfRU5fU1BBTiB3aWxsIG5vdCBiZSBpbiBzcl9jclsxXSB3aGVuIHdl
IHJlYWNoIGhlcmUuIFNvIGNvZGUNCj4gd29uJ3QgZW5hYmxlIHF1YWQgbW9kZS4NCj4gDQoNCkkg
Z2V0IHRoZSBwcm9ibGVtIG5vdy4gc3BpX25vcl93cml0ZV8xNmJpdF9zcl9hbmRfY2hlY2soKSBk
b2VzIG5vdCBtb2RpZnkgdGhlDQp2YWx1ZSBvZiB0aGUgUUUgYml0LCB3aGljaCBpcyBnb29kIGlu
IHRoZSBsb2NrL3VubG9jaygpIGNhc2UuIFdlIHdhbnQgdG8NCmxvY2svdW5sb2NrKCkgd2l0aG91
dCBlbmFibGluZyBvciBkaXNhYmxpbmcgdGhlIFF1YWQgTW9kZS4NCg0KQXMgeW91IGZvdW5kLCB0
aGUgcHJvYmxlbSBjb21lcyBsYXRlciBpbiBzcGlfbm9yX3NyMl9iaXQxX3F1YWRfZW5hYmxlKCkg
YmVjYXVzZQ0KSSB1c2UgdGhlcmUgc3BpX25vcl93cml0ZV8xNmJpdF9zcl9hbmRfY2hlY2soKSB3
aGljaCBrZWVwcyB0aGUgdmFsdWUgb2YgdGhlIFFFDQpiaXQsIHdpdGhvdXQgc2V0dGluZyBpdCB0
byBvbmUsIHNvIHRoZSBzcGlfbm9yX3NyMl9iaXQxX3F1YWRfZW5hYmxlKCkgZGlkIG5vdA0KZW5h
YmxlIHRoZSBRdWFkIE1vZGUgaWYgbm90IHByZXZpb3VzbHkgZW5hYmxlZC4NCg0KV2hhdCBJJ2xs
IGRvIGlzIHRvIGludHJvZHVjZSBhIG5ldyBhcmd1bWVudCB0bzoNCnN0YXRpYyBpbnQgc3BpX25v
cl93cml0ZV8xNmJpdF9zcl9hbmRfY2hlY2soc3RydWN0IHNwaV9ub3IgKm5vciwgdTggc3RhdHVz
X25ldywNCgkJCQkJICAgIHU4IG1hc2ssIGJvb2wgc2V0X3F1YWRfZW5hYmxlKQ0KDQphbmQgZG8g
YQ0KaWYgKHNldF9xdWFkX2VuYWJsZSkNCglzcl9jclsxXSB8PSBDUl9RVUFEX0VOX1NQQU47DQph
ZnRlciBpbml0aWFsaXppbmcgc3JfY3JbMV0NCg0KVGhlIGxvY2svdW5sb2NrKCkgbWV0aG9kcyB3
aWxsIGNhbGwgdGhlIGZ1bmN0aW9uIHdpdGggc2V0X3F1YWRfZW5hYmxlIGJlaW5nDQpmYWxzZSAo
d2UgZG9uJ3Qgd2FudCB0byBtb2RpZnkgdGhlIFFFIHZhbHVlKSwgYW5kIHRoZQ0Kc3BpX25vcl9z
cjJfYml0MV9xdWFkX2VuYWJsZSgpIHdpbGwgY2FsbCBpdCB3aXRoIHNldF9xdWFkX2VuYWJsZSBi
ZWluZyB0cnVlLCB3ZQ0Kd2FudCB0byBzZXQgUUUgdG8gb25lICh3ZSBkb24ndCBjYXJlIG9mIHRo
ZSBRRSBiaXQgcHJldmlvdXMgdmFsdWUpLg0KDQpXZSdsbCBhdm9pZCBjb2RlIGR1cGxpY2F0aW9u
LCBsb2NrL3VubG9jaygpIGFuZCBzcGlfbm9yX3NyMl9iaXQxX3F1YWRfZW5hYmxlKCkNCmNhbGxp
bmcgdGhlIHNhbWUgbWV0aG9kLg0KDQpDaGVlcnMsDQp0YQ0K
