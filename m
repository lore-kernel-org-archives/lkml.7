Return-Path: <SRS0=9baz=WV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0ECEC3A5A1
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 14:27:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80BB42080C
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 14:27:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="i5111ycM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728493AbfHYO1p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Aug 2019 10:27:45 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:55839 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728382AbfHYO1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 10:27:45 -0400
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
IronPort-SDR: DLA63h3g81/T/e82VgWA+0rLS2FM2SEEk+gvaBBeodudc2Rs6Ou/cpYtqc6UxUb436nJkBFkiW
 eWjsZSoJ6NzJ2o2Jln7Ep4dqywdWVs0wIq/BJz19bwqwuen/8aDsGiTXxejdlBLSXlRfRGaxSo
 j2ce3wbO7wuX7EVmdVbJciEJdAIYIt//DPiL9L0HohcPfEjmU/95j2TbVV7N0phLjiv2oLI/D6
 Gsaf4KrZsHezPhih/g2FpkWGrkoARTop6fttnIWx3tnV1egXcr/AlxVg/91jf+spYcMoTbSSTo
 T0Q=
X-IronPort-AV: E=Sophos;i="5.64,429,1559545200"; 
   d="scan'208";a="46515582"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Aug 2019 07:27:43 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sun, 25 Aug 2019 07:27:41 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Sun, 25 Aug 2019 07:27:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BWbsZs5Rp6fBfHGuN1THybS/FNYbE3n8qgvPSRZpGkowkBE/uIjl3Buuk4JCfysFli40+5H2F9NmTjZvCK6b/rnOPFtLDJXkjJoA8ELchwMFjlWt5Od1fCnJHBCA0R09BoZYEacixa3P5WhkJxahgl1EpuR++itToPU1lhJvUibIhQWXITEFHGG4+EN4h1p6HsqUA3j3PyIgZ7ASN26CchRLq4EputIkkCJw1nnLt6dTPAuTU2gXr90imvl7YyHidhnXyyeQe/Js44ve96koScILfqiYOuZzkF7IX7UshNA6DIfYK88FqJyU6YxLL/SRrxNr3PabLnERRG+UsT8RzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eOT9H4AQ4oQ4FmWWB9fds+T6jR5iM6e/l9D5fTbAllo=;
 b=X9iA/T9P7huPwGXlQz/znXavNgOgPp4rZ3Bhl87CurbfjvCWEn14mkjkw9JpDVDtjJ7t5N6exUNTeqZ+zP71FQfmHMlfgkSUbHwVLM9s10ROxPpfDCyMxHAAXUhKpro8YDdXFa7hAA0PXOCshjvyji1xDEVCgHx6faBi3p+tlhAbKe/pxQpWHNJc1jg7TCq80wE5X0mFUqFyuWFgH/c/qX57AEo9VkAaaF7SL9OKyYJe5QYH6gUlnexlVChZZ9vRGuPxvFt62cZ3vbeeienYB9hzoiAATSv6aJfMev2wcxqE/NM69hQGQ0haXxE41MnkZL0Ead4brhAUTEwMTruI4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eOT9H4AQ4oQ4FmWWB9fds+T6jR5iM6e/l9D5fTbAllo=;
 b=i5111ycMoTC7/aput5zNigV0ibsqu4HpQumspIouAlwspStFhInBotxvHwXm5Xzo3CZ/z+1XK5C37vNd7gCTFh4a4Fd6ePU3MqVBWtUXmPdBFdN++nnl/q7dUF7w6WWxkhAHIp0vGbH3vrOMlQy2ecW6EJCKQwNX+Fi3De6gKRo=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB3838.namprd11.prod.outlook.com (20.178.252.202) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Sun, 25 Aug 2019 14:27:39 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::70c3:e929:4da2:60a5]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::70c3:e929:4da2:60a5%7]) with mapi id 15.20.2199.021; Sun, 25 Aug 2019
 14:27:39 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <boris.brezillon@collabora.com>
CC:     <marek.vasut@gmail.com>, <vigneshr@ti.com>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] mtd: spi-nor: add Global Block Unlock support
Thread-Topic: [PATCH v2 1/2] mtd: spi-nor: add Global Block Unlock support
Thread-Index: AQHVWndBGiXUgYKWckGGG7tH1Lap/acL0hmAgAAbbAA=
Date:   Sun, 25 Aug 2019 14:27:39 +0000
Message-ID: <42ab7f11-741d-a3f3-0a83-36a1b7600f0f@microchip.com>
References: <20190824122700.23558-1-tudor.ambarus@microchip.com>
 <20190824122700.23558-2-tudor.ambarus@microchip.com>
 <20190825144921.66139a65@collabora.com>
In-Reply-To: <20190825144921.66139a65@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0101CA0071.eurprd01.prod.exchangelabs.com
 (2603:10a6:800:1f::39) To MN2PR11MB4448.namprd11.prod.outlook.com
 (2603:10b6:208:193::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [86.127.53.184]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eda596bb-0a6c-48f6-6d32-08d7296861d1
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR11MB3838;
x-ms-traffictypediagnostic: MN2PR11MB3838:
x-microsoft-antispam-prvs: <MN2PR11MB383844975FDF33F7310201B1F0A60@MN2PR11MB3838.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 01401330D1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(366004)(136003)(39850400004)(376002)(199004)(189003)(54906003)(36756003)(2616005)(305945005)(476003)(66066001)(5660300002)(14454004)(6436002)(53546011)(316002)(4326008)(6506007)(8936002)(26005)(7736002)(31696002)(3846002)(99286004)(386003)(486006)(52116002)(76176011)(186003)(6486002)(11346002)(446003)(102836004)(86362001)(25786009)(31686004)(6512007)(478600001)(6116002)(256004)(14444005)(71200400001)(8676002)(2906002)(71190400001)(66476007)(229853002)(66946007)(81166006)(64756008)(66446008)(6246003)(66556008)(81156014)(6916009)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3838;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: m6HUKhX+3s1Vj+0uwAriD7MuMJ/v/wOC6P8ngOaoyRwaThyaKDG2nQ3b+6n/7iAHLSQqwhgiFgmwfZz+b56F1G6POOlhBaCceDEkvCkaDz9RCRU9DZYqyU5bBPKoK060DJ4Ea7oKrGq3a2G65ElPtHuOPUFvZBaAVhNzcuyAGLRun1EjhiIoRJ1yCRuN0CnXPsUXrdPNzr0XlxxnRORkpZ0LP6pRRl4W1KsMDraSmg1Mds9wBzuI+Zm0izmLMAnlrDlh5OQqEYhgoazAU7fHMyVremy+ZnMAQo1uA/5VEPTNtIVYRUytrDXkiAayYNyPvbwgzcgcFK4ukbOQtBcNVgE5q+AIy3Dy6bzz3bf39TuCry4Rhn55jZVfqek4hfO4l8T2xM/aFRVSy+64arKJLa3XAV6Om6PnEnRyntlvbxQ=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <9C0C60E9C6FDF540A1DAA6086EA9E82D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: eda596bb-0a6c-48f6-6d32-08d7296861d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2019 14:27:39.2895
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tCReSk9OsFbH4tFUYJbFiivcc+U1PvUISP0+cDu0zFH4ld7UlFeWVJYlqUdypuAdt8r/LrVJD8GaehX+oIk3K54Rht0SsbjXhJOJv1hYWYk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3838
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDA4LzI1LzIwMTkgMDM6NDkgUE0sIEJvcmlzIEJyZXppbGxvbiB3cm90ZToNCj4gRXh0
ZXJuYWwgRS1NYWlsDQo+IA0KPiANCj4gT24gU2F0LCAyNCBBdWcgMjAxOSAxMjoyNzoxMiArMDAw
MA0KPiA8VHVkb3IuQW1iYXJ1c0BtaWNyb2NoaXAuY29tPiB3cm90ZToNCj4gDQo+PiBGcm9tOiBU
dWRvciBBbWJhcnVzIDx0dWRvci5hbWJhcnVzQG1pY3JvY2hpcC5jb20+DQo+Pg0KPj4gVG8gYXZv
aWQgaW5hZHZlcnRlbnQgd3JpdGVzIGR1cmluZyBwb3dlci11cCwgc29tZSBmbGFzaGVzIGFyZQ0K
Pj4gd3JpdGUtcHJvdGVjdGVkIGJ5IGRlZmF1bHQgYWZ0ZXIgYSBwb3dlci1vbiByZXNldCBjeWNs
ZS4NCj4+IEEgR2xvYmFsIEJsb2NrLVByb3RlY3Rpb24gVW5sb2NrIGNvbW1hbmQgb2ZmZXJzIGEg
c2luZ2xlDQo+PiBjb21tYW5kIGN5Y2xlIHRoYXQgdW5sb2NrcyB0aGUgZW50aXJlIG1lbW9yeSBh
cnJheS4gVGhpcyBpcw0KPj4gaWRlbnRpY2FsIHdpdGggd2hhdCBvdGhlciBub3IgZmxhc2hlcyBh
cmUgZG9pbmcgYnkgY2xlYXJpbmcNCj4+IHRoZSBibG9jayBwcm90ZWN0aW9uIGJpdHMgZnJvbSB0
aGUgc3RhdHVzIHJlZ2lzdGVyOiBkaXNhYmxlDQo+PiB0aGUgd3JpdGUgcHJvdGVjdGlvbiBhZnRl
ciBhIHBvd2VyLW9uIHJlc2V0IGN5Y2xlLg0KPj4NCj4+IFdlIGNhbid0IGRldGVybWluZSB0aGlz
IHB1cmVseSBieSBtYW51ZmFjdHVyZXIgdHlwZSBhbmQgaXQncyBub3QNCj4+IGF1dG9kZXRlY3Rh
YmxlIGJ5IGFueXRoaW5nIGxpa2UgU0ZEUCwgc28gbWFrZSBhIG5ldyBmbGFnIGZvciBpdDoNCj4+
IFVOTE9DS19HTE9CQUxfQkxPQ0suDQo+Pg0KPj4gTm90ZSB0aGF0IHRoZSBHbG9iYWwgQmxvY2sg
VW5sb2NrIGNvbW1hbmQgaGFzIGRpZmZlcmVudCBuYW1lcw0KPj4gZGVwZW5kaW5nIG9uIHRoZSBt
YW51ZmFjdHVyZXIsIGJ1dCBhbHdheXMgdGhlIHNhbWUgY29tbWFuZCB2YWx1ZToNCj4+IDB4OTgu
IE1hY3Jvbml4J3MgTVgyNVUxMjgzNUYgbmFtZXMgaXQgR2FuZyBCbG9jayBVbmxvY2ssDQo+PiBX
aW5ib3VuZCdzIFcyNVExMjhGViBuYW1lcyBpdCBHbG9iYWwgQmxvY2sgVW5sb2NrIGFuZA0KPj4g
TWljcm9jaGlwJ3MgU1NUMjZWRjA2NEIgbmFtZXMgaXQgR2xvYmFsIEJsb2NrIFByb3RlY3Rpb24g
VW5sb2NrLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IFR1ZG9yIEFtYmFydXMgPHR1ZG9yLmFtYmFy
dXNAbWljcm9jaGlwLmNvbT4NCj4+IC0tLQ0KPj4gdjI6IHRoZSBjaGVjayBmb3IgVU5MT0NLX0dM
T0JBTF9CTE9DSyBzaG91bGQgYmUgZG9uZSB0aGUgZmlyc3QNCj4+IHRoaW5nIGluIHNwaV9ub3Jf
ZGlzYWJsZV9ibG9ja19wcm90ZWN0aW9uKCkuIFdlIHVzZSBpdCBmb3IgYSBmYXN0ZXINCj4+IHRo
cm91Z2hwdXQsIGEgc2luZ2xlIGNvbW1hbmQgY3ljbGUgdGhhdCB1bmxvY2tzIHRoZSBlbnRpcmUg
bWVtb3J5DQo+PiBhcnJheS4gRml4IGl0Lg0KPj4NCj4+ICBkcml2ZXJzL210ZC9zcGktbm9yL3Nw
aS1ub3IuYyB8IDQ2ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0N
Cj4+ICBpbmNsdWRlL2xpbnV4L210ZC9zcGktbm9yLmggICB8ICAxICsNCj4+ICAyIGZpbGVzIGNo
YW5nZWQsIDQ2IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4+DQo+PiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9tdGQvc3BpLW5vci9zcGktbm9yLmMgYi9kcml2ZXJzL210ZC9zcGktbm9yL3Nw
aS1ub3IuYw0KPj4gaW5kZXggMTg5NmQzNmE3ZDExLi5jMGJhNmZlNjI0NjEgMTAwNjQ0DQo+PiAt
LS0gYS9kcml2ZXJzL210ZC9zcGktbm9yL3NwaS1ub3IuYw0KPj4gKysrIGIvZHJpdmVycy9tdGQv
c3BpLW5vci9zcGktbm9yLmMNCj4+IEBAIC0xOTYsNyArMTk2LDcgQEAgc3RydWN0IGZsYXNoX2lu
Zm8gew0KPj4gIAl1MTYJCXBhZ2Vfc2l6ZTsNCj4+ICAJdTE2CQlhZGRyX3dpZHRoOw0KPj4gIA0K
Pj4gLQl1MTYJCWZsYWdzOw0KPj4gKwl1MzIJCWZsYWdzOw0KPj4gICNkZWZpbmUgU0VDVF80SwkJ
CUJJVCgwKQkvKiBTUElOT1JfT1BfQkVfNEsgd29ya3MgdW5pZm9ybWx5ICovDQo+PiAgI2RlZmlu
ZSBTUElfTk9SX05PX0VSQVNFCUJJVCgxKQkvKiBObyBlcmFzZSBjb21tYW5kIG5lZWRlZCAqLw0K
Pj4gICNkZWZpbmUgU1NUX1dSSVRFCQlCSVQoMikJLyogdXNlIFNTVCBieXRlIHByb2dyYW1taW5n
ICovDQo+PiBAQCAtMjMzLDYgKzIzMyw3IEBAIHN0cnVjdCBmbGFzaF9pbmZvIHsNCj4+ICAjZGVm
aW5lIFNQSV9OT1JfU0tJUF9TRkRQCUJJVCgxMykJLyogU2tpcCBwYXJzaW5nIG9mIFNGRFAgdGFi
bGVzICovDQo+PiAgI2RlZmluZSBVU0VfQ0xTUgkJQklUKDE0KQkvKiB1c2UgQ0xTUiBjb21tYW5k
ICovDQo+PiAgI2RlZmluZSBTUElfTk9SX09DVEFMX1JFQUQJQklUKDE1KQkvKiBGbGFzaCBzdXBw
b3J0cyBPY3RhbCBSZWFkICovDQo+PiArI2RlZmluZSBVTkxPQ0tfR0xPQkFMX0JMT0NLCUJJVCgx
NikJLyogVW5sb2NrIGdsb2JhbCBibG9jayBwcm90ZWN0aW9uICovDQo+IA0KPiBMZXQncyBhZGQg
dGhlIGNvcnJlc3BvbmRpbmcgU05PUl9GXyBmbGFnIHNvIHRoYXQgbWFudWZhY3R1cmVyL3NmZHAg
aW5pdA0KPiBjYW4gc2V0IHRoZSBmbGFnIGRpcmVjdGx5Lg0KDQpOb3QgcmVhbGx5IG5lZWRlZCwg
YmVjYXVzZSB3ZSBjYW4ndCBkZXRlcm1pbmUgdGhpcyBieSBwYXJzaW5nIFNGRFAsIHRoZXJlIGlz
IG5vDQpmaWVsZCBpbiBTRkRQIHRvIGluZGljYXRlIHRoaXMgc3VwcG9ydC4gWW91IGNhbid0IHNl
dCB0aGlzIGF0IG1hbnVmYWN0dXJlcg0KbGV2ZWwsIGJlY2F1c2UgaXQgaXMgbm90IGEgcGVyLW1h
bnVmYWN0dXJlciB0aGluZy4gU29tZSBmbGFzaGVzIGNhbiBzdXBwb3J0IGl0LA0Kc29tZSBub3Qg
ZXZlbiBpZiBhbGwgZnJvbSB0aGUgc2FtZSBtYW51ZmFjdHVyZXIuIFNvIHRoaXMgZ2xvYmFsIHVu
bG9jayBjb21tYW5kDQppdCdzIGF0IHRoZSBwZXItY2hpcCBsZXZlbCwgYW5kIGZvciB0aGUgbW9t
ZW50IHdlIHNob3VsZCBrZWVwIHRoaXMgZmxhZyBqdXN0IGluDQp0aGUgZmxhc2hfaW5mbydzIGZs
YWdzLg0K
