Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A734C0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 07:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D335021872
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 07:43:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="qtugD/z3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727657AbfHEHn5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 03:43:57 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:43983 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726394AbfHEHn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 03:43:57 -0400
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
IronPort-SDR: 4AAaTbLY7AqE+llloLaO5kHdo3k0Uy01J2l5PHth00RzH1hzE4zIsJPiMLBwLenBiGvL/E53uW
 6WNcN05aI4bCdRU4iwk/x+bmvHPGxHlA7z5gz6FhaR9ZjWYXE3AD8wKnXMB7sZmGBZ1T3rG0hW
 SzQiBaRwboD0af/XiFtmx0h0/PHVn/a/oB24OnpgsCnysS2y+igAULfTxzdog+sf0XaN+IlYoX
 pPq0SsmoL3LqvmfyKwI0h0Te1Ia6RJu56M5SWot6UJQHhCKWa+3nfNLkM8ac0YM8pMgDuYaGFb
 Ero=
X-IronPort-AV: E=Sophos;i="5.64,349,1559545200"; 
   d="scan'208";a="45331127"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 Aug 2019 00:43:55 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 5 Aug 2019 00:43:38 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Mon, 5 Aug 2019 00:43:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dSPppaXzSDF4vX5NAhu3aj3BkVH1ciaYBmbjcsr/0bxRzHpNsEHOQPC//tNPRXsx8JVpWj356FTRpYJVwbBieo9dVr+JZsPZ/1ysXtzt428skE4Iz4Wn9y9WE6/Cr5u5g/RqbR0YX5lJ3kkpWPgmQJL0vj/kdOPDu+Ev9MH7q2V48m7pwCMA9J+cUDQG8u7LgqhWFCTYgsBiis5T98EkGNeRKN42y8388hqX4HjpPHVYIPUZdmLN4brxe7CekiU8kiBnxbhJ7mapde+Huo+ohWSiO0eJfg2gfDT+Z9gT5gk2n4arzPGbESVX7hzatjmzwEGQoJCE2En0+RMM374i/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gk3rkc5mjDRjkS9tWeXPmVt+SP7IE95cd4lWvchRFLE=;
 b=XcXOAjMnSbqB5dX5zrz8vn1ItLuRw8XW7ZB9WofoVfH6cIELodVSgGaEBltPew9iA7kwEabgXdlNnna7KT8kKER4kDMaYwT80OWb78pt7mZqk8F/4PLkL2VIk5E/pOyZnJfqfMKHe0HUXsD00pGDFURoiS3kQ5jSbqA53uzLe4d/da8R2Kp98LBaPP0rujleDdJ0ZqDlf5zFQVygABhlxo5nRxcEy79GTdGYKm6xiSO/hECwpkUm7L4B4bPr5HbRzfquT7dFY3/9p2lq1wRhhAbvX01Iex9I/DGAASh8oNLhdYGAMYF+xUwvlY5eg6fHDAq6yMIFzxHwWU7I3cpwLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=microchip.com;dmarc=pass action=none
 header.from=microchip.com;dkim=pass header.d=microchip.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gk3rkc5mjDRjkS9tWeXPmVt+SP7IE95cd4lWvchRFLE=;
 b=qtugD/z3Oh9quLaDF63wEqmdhpXeAA3WuOl7EbOd6iiQG+IzfnwPyv6oLunpt/2T7CcXh9F4c1OIrT7S93iQMhTK/ohWUwYvqGsNZ1tx0YRP2eTw90Yywkl7JUMi4vyH1JaHS3WP0rj9gcbW10OkMc1pP7u1Sh1B1bzmJq40sso=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB4223.namprd11.prod.outlook.com (52.135.37.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.16; Mon, 5 Aug 2019 07:43:37 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::70c3:e929:4da2:60a5]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::70c3:e929:4da2:60a5%7]) with mapi id 15.20.2136.018; Mon, 5 Aug 2019
 07:43:37 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <boris.brezillon@collabora.com>
CC:     <marek.vasut@gmail.com>, <vigneshr@ti.com>, <dwmw2@infradead.org>,
        <computersforpeace@gmail.com>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/7] mtd: spi_nor: Rework quad_enable()
Thread-Topic: [PATCH 3/7] mtd: spi_nor: Rework quad_enable()
Thread-Index: AQHVR37TzKxNRrn8H0elIoBO1LpPu6bl1guAgAZd4wA=
Date:   Mon, 5 Aug 2019 07:43:36 +0000
Message-ID: <6e0cd8fc-b5c0-0cf5-5b1e-78ff0dfe7443@microchip.com>
References: <20190731090315.26798-1-tudor.ambarus@microchip.com>
 <20190731090315.26798-4-tudor.ambarus@microchip.com>
 <20190801082949.2f08feae@collabora.com>
In-Reply-To: <20190801082949.2f08feae@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR09CA0151.eurprd09.prod.outlook.com
 (2603:10a6:803:12c::35) To MN2PR11MB4448.namprd11.prod.outlook.com
 (2603:10b6:208:193::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8ade760a-5f52-41aa-2399-08d71978a003
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR11MB4223;
x-ms-traffictypediagnostic: MN2PR11MB4223:
x-microsoft-antispam-prvs: <MN2PR11MB4223A587DEA54552021427E6F0DA0@MN2PR11MB4223.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-forefront-prvs: 01208B1E18
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(376002)(136003)(346002)(39860400002)(199004)(189003)(52314003)(3846002)(2906002)(229853002)(6116002)(6436002)(54906003)(6486002)(8676002)(81156014)(86362001)(81166006)(99286004)(76176011)(31696002)(186003)(386003)(486006)(102836004)(71200400001)(71190400001)(2616005)(476003)(14444005)(316002)(8936002)(53546011)(52116002)(6506007)(26005)(256004)(478600001)(66476007)(64756008)(31686004)(66946007)(446003)(11346002)(66066001)(6512007)(14454004)(6916009)(5660300002)(66446008)(66556008)(6246003)(36756003)(68736007)(7736002)(25786009)(53936002)(305945005)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB4223;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: YtbCL+WyRpnYe0+ncJccYF06+KW0nI3i/pCEeqOaynDJD9r6GHpwHJeS4BFe8k9LHImfN63qXRwgI58c3M0QnTNSiVh7XXOBcp5984+w6J7LW7bs4vZrv1VPKt0JBFkA8UbaHx7R+FuoeqfeSrbArx6SAOg0rFSOHDA7R6duIUhizsnqQL9ynfwxTvo6HNNKRCdl2t2SgrK7OBdMng4ZFO9MlTbjEs6Z4wFDHAw7xiC4LZ8WMhUob9xz0l2cmQkEtcC4tdh6N20O6hpbHrxU+pbVsEoJYRNZ9auFcuduATupsGyT0LXY1DRce7UBrBRH1m2ORJQxG9JICsSpbZvU225UnxtzYQqL65ikSMWcofpQFVf916VWq1UqUEIUPeDGKuzZFShR20F2sKvWp0MsWDsCqOdZx7/w8K3cnB1bHhs=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C8BBF5BE3860AF45AB55E68A68B90264@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ade760a-5f52-41aa-2399-08d71978a003
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2019 07:43:36.9953
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tudor.ambarus@microchip.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDA4LzAxLzIwMTkgMDk6MjkgQU0sIEJvcmlzIEJyZXppbGxvbiB3cm90ZToNCj4gRXh0
ZXJuYWwgRS1NYWlsDQo+IA0KPiANCj4gT24gV2VkLCAzMSBKdWwgMjAxOSAwOTowMzozMSArMDAw
MA0KPiA8VHVkb3IuQW1iYXJ1c0BtaWNyb2NoaXAuY29tPiB3cm90ZToNCj4gDQo+PiBGcm9tOiBU
dWRvciBBbWJhcnVzIDx0dWRvci5hbWJhcnVzQG1pY3JvY2hpcC5jb20+DQo+Pg0KPj4gVGhlIGdv
YWwgaXMgdG8gbW92ZSB0aGUgcXVhZF9lbmFibGUgbWFudWZhY3R1cmVyIHNwZWNpZmljIGluaXQg
aW4gdGhlDQo+PiBub3ItPm1hbnVmYWN0dXJlci0+Zml4dXBzLT5kZWZhdWx0X2luaXQoKQ0KPj4N
Cj4+IFRoZSBsZWdhY3kvY29yZSBxdWFkX2VuYWJsZSgpIGltcGxlbWVudGF0aW9uIGlzIHNwYW5z
aW9uX3F1YWRfZW5hYmxlKCksDQo+PiBzZWxlY3QgdGhpcyBtZXRob2QgYnkgZGVmYXVsdC4NCj4+
DQo+PiBTZXQgc3BlY2lmaWMgbWFudWZhY3R1cmVyIGZpeHVwcy0+ZGVmYXVsdF9pbml0KCkgaG9v
a3MgdG8gb3ZlcndyaXRlDQo+PiB0aGUgZGVmYXVsdCBxdWFkX2VuYWJsZSgpIGltcGxlbWVudGF0
aW9uIHdoZW4gbmVlZGVkLg0KPj4NCj4+IEdldCByaWQgb2YgdGhlIHNwaV9ub3JfZmxhc2hfcGFy
YW1ldGVyIGludCAoKnF1YWRfZW5hYmxlKSgpIHBvaW50ZXIgdG8NCj4+IGZ1bmN0aW9uLCBhcyB3
ZSBhbHdheXMgY2hvb3NlIHRvIG92ZXJ3cml0ZSB0aGUgbm9yLT5xdWFkX2VuYWJsZSwNCj4+IGlm
IG5lZWRlZC4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBUdWRvciBBbWJhcnVzIDx0dWRvci5hbWJh
cnVzQG1pY3JvY2hpcC5jb20+DQo+PiAtLS0NCj4+ICBkcml2ZXJzL210ZC9zcGktbm9yL3NwaS1u
b3IuYyB8IDEwMyArKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0NCj4+
ICAxIGZpbGUgY2hhbmdlZCwgNTcgaW5zZXJ0aW9ucygrKSwgNDYgZGVsZXRpb25zKC0pDQo+Pg0K
Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbXRkL3NwaS1ub3Ivc3BpLW5vci5jIGIvZHJpdmVycy9t
dGQvc3BpLW5vci9zcGktbm9yLmMNCj4+IGluZGV4IDk0YWJhNWNlMTQ2Mi4uYTkwNmMzNjI2MGM4
IDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9tdGQvc3BpLW5vci9zcGktbm9yLmMNCj4+ICsrKyBi
L2RyaXZlcnMvbXRkL3NwaS1ub3Ivc3BpLW5vci5jDQo+PiBAQCAtMTAxLDggKzEwMSw2IEBAIHN0
cnVjdCBzcGlfbm9yX2ZsYXNoX3BhcmFtZXRlciB7DQo+PiAgCXN0cnVjdCBzcGlfbm9yX2h3Y2Fw
cwkJaHdjYXBzOw0KPj4gIAlzdHJ1Y3Qgc3BpX25vcl9yZWFkX2NvbW1hbmQJcmVhZHNbU05PUl9D
TURfUkVBRF9NQVhdOw0KPj4gIAlzdHJ1Y3Qgc3BpX25vcl9wcF9jb21tYW5kCXBhZ2VfcHJvZ3Jh
bXNbU05PUl9DTURfUFBfTUFYXTsNCj4+IC0NCj4+IC0JaW50ICgqcXVhZF9lbmFibGUpKHN0cnVj
dCBzcGlfbm9yICpub3IpOw0KPj4gIH07DQo+PiAgDQo+PiAgc3RydWN0IHNmZHBfcGFyYW1ldGVy
X2hlYWRlciB7DQo+PiBAQCAtMjI3NSw3ICsyMjczLDcgQEAgc3RhdGljIHZvaWQgZ2QyNXEyNTZf
ZGVmYXVsdF9pbml0KHN0cnVjdCBzcGlfbm9yICpub3IsDQo+PiAgCSAqIGluZGljYXRlIHRoZSBx
dWFkX2VuYWJsZSBtZXRob2QgZm9yIHRoaXMgY2FzZSwgd2UgbmVlZA0KPj4gIAkgKiBzZXQgaXQg
aW4gdGhlIGRlZmF1bHRfaW5pdCBmaXh1cCBob29rLg0KPj4gIAkgKi8NCj4+IC0JcGFyYW1zLT5x
dWFkX2VuYWJsZSA9IG1hY3Jvbml4X3F1YWRfZW5hYmxlOw0KPj4gKwlub3ItPnF1YWRfZW5hYmxl
ID0gbWFjcm9uaXhfcXVhZF9lbmFibGU7DQo+PiAgfQ0KPj4gIA0KPj4gIHN0YXRpYyBzdHJ1Y3Qg
c3BpX25vcl9maXh1cHMgZ2QyNXEyNTZfZml4dXBzID0gew0KPj4gQEAgLTM2MTgsMjQgKzM2MTYs
MjQgQEAgc3RhdGljIGludCBzcGlfbm9yX3BhcnNlX2JmcHQoc3RydWN0IHNwaV9ub3IgKm5vciwN
Cj4+ICAJLyogUXVhZCBFbmFibGUgUmVxdWlyZW1lbnRzLiAqLw0KPj4gIAlzd2l0Y2ggKGJmcHQu
ZHdvcmRzW0JGUFRfRFdPUkQoMTUpXSAmIEJGUFRfRFdPUkQxNV9RRVJfTUFTSykgew0KPj4gIAlj
YXNlIEJGUFRfRFdPUkQxNV9RRVJfTk9ORToNCj4+IC0JCXBhcmFtcy0+cXVhZF9lbmFibGUgPSBO
VUxMOw0KPj4gKwkJbm9yLT5xdWFkX2VuYWJsZSA9IE5VTEw7DQo+PiAgCQlicmVhazsNCj4+ICAN
Cj4+ICAJY2FzZSBCRlBUX0RXT1JEMTVfUUVSX1NSMl9CSVQxX0JVR0dZOg0KPj4gIAljYXNlIEJG
UFRfRFdPUkQxNV9RRVJfU1IyX0JJVDFfTk9fUkQ6DQo+PiAtCQlwYXJhbXMtPnF1YWRfZW5hYmxl
ID0gc3BhbnNpb25fbm9fcmVhZF9jcl9xdWFkX2VuYWJsZTsNCj4+ICsJCW5vci0+cXVhZF9lbmFi
bGUgPSBzcGFuc2lvbl9ub19yZWFkX2NyX3F1YWRfZW5hYmxlOw0KPj4gIAkJYnJlYWs7DQo+PiAg
DQo+PiAgCWNhc2UgQkZQVF9EV09SRDE1X1FFUl9TUjFfQklUNjoNCj4+IC0JCXBhcmFtcy0+cXVh
ZF9lbmFibGUgPSBtYWNyb25peF9xdWFkX2VuYWJsZTsNCj4+ICsJCW5vci0+cXVhZF9lbmFibGUg
PSBtYWNyb25peF9xdWFkX2VuYWJsZTsNCj4+ICAJCWJyZWFrOw0KPj4gIA0KPj4gIAljYXNlIEJG
UFRfRFdPUkQxNV9RRVJfU1IyX0JJVDc6DQo+PiAtCQlwYXJhbXMtPnF1YWRfZW5hYmxlID0gc3Iy
X2JpdDdfcXVhZF9lbmFibGU7DQo+PiArCQlub3ItPnF1YWRfZW5hYmxlID0gc3IyX2JpdDdfcXVh
ZF9lbmFibGU7DQo+PiAgCQlicmVhazsNCj4+ICANCj4+ICAJY2FzZSBCRlBUX0RXT1JEMTVfUUVS
X1NSMl9CSVQxOg0KPj4gLQkJcGFyYW1zLT5xdWFkX2VuYWJsZSA9IHNwYW5zaW9uX3JlYWRfY3Jf
cXVhZF9lbmFibGU7DQo+PiArCQlub3ItPnF1YWRfZW5hYmxlID0gc3BhbnNpb25fcmVhZF9jcl9x
dWFkX2VuYWJsZTsNCj4+ICAJCWJyZWFrOw0KPj4gIA0KPj4gIAlkZWZhdWx0Og0KPj4gQEAgLTQy
ODYsMTAgKzQyODQsNDEgQEAgc3RhdGljIGludCBzcGlfbm9yX3BhcnNlX3NmZHAoc3RydWN0IHNw
aV9ub3IgKm5vciwNCj4+ICAJcmV0dXJuIGVycjsNCj4+ICB9DQo+PiAgDQo+PiArc3RhdGljIHZv
aWQgbWFjcm9uaXhfc2V0X2RlZmF1bHRfaW5pdChzdHJ1Y3Qgc3BpX25vciAqbm9yKQ0KPj4gK3sN
Cj4+ICsJbm9yLT5xdWFkX2VuYWJsZSA9IG1hY3Jvbml4X3F1YWRfZW5hYmxlOw0KPj4gK30NCj4+
ICsNCj4+ICtzdGF0aWMgdm9pZCBzdF9taWNyb25fc2V0X2RlZmF1bHRfaW5pdChzdHJ1Y3Qgc3Bp
X25vciAqbm9yKQ0KPj4gK3sNCj4+ICsJbm9yLT5xdWFkX2VuYWJsZSA9IE5VTEw7DQo+PiArfQ0K
Pj4gKw0KPj4gK3N0YXRpYyB2b2lkIHNwaV9ub3JfbWZyX2luaXRfcGFyYW1zKHN0cnVjdCBzcGlf
bm9yICpub3IsDQo+PiArCQkJCSAgICBzdHJ1Y3Qgc3BpX25vcl9mbGFzaF9wYXJhbWV0ZXIgKnBh
cmFtcykNCj4gDQo+IFNvIG5vdyB3ZSBoYXZlIHNwaV9ub3JfbWZyX2luaXRfcGFyYW1zKCkgYW5k
DQo+IHNwaV9ub3JfbWFudWZhY3R1cmVyX2luaXRfcGFyYW1zKCksIHRoYXQncyBhIGJpdCBjb25m
dXNpbmcuIENhbid0IHdlDQo+IGp1c3QgaW5saW5lIHRoZSBiZWxvdyBjb2RlIGluIHRoZSBzcGlf
bm9yX21hbnVmYWN0dXJlcl9pbml0X3BhcmFtcygpDQo+IGZ1bmM/IEkgZ3Vlc3MgdGhpcyBmdW5j
IHdpbGwgYmUgcmVtb3ZlZCBhbnl3YXksIHNvIG1heWJlIGl0J3Mgbm90DQo+IHN1Y2ggYSBiaWcg
ZGVhbC4NCj4gDQoNCldpbGwgZG8uIHNwaV9ub3JfbWZyX2luaXRfcGFyYW1zKCkgd291bGQgaGF2
ZSBiZWVuIHJlbW92ZWQgYW55d2F5IHdoZW4gbW92aW5nDQp0aGUgbWFudWZhY3R1cmVyIHNwZWNp
ZmljIGNvZGUgb3V0IG9mIHRoZSBjb3JlLiBJIGNob3NlIHNlcGFyYXRlIGZ1bmN0aW9uIHRvDQp1
bmRlcmxpbmUgdGhhdCB0aGVzZSBzZWxlY3RzIGFyZSBkb25lIHNvbGVseSBiYXNlZCBvbiBKRURF
Q19NRlIsIHdoaWxlIHRoZQ0KZGVmYXVsdF9pbml0KCkgc2V0cyBkYXRhIHRoYXQgY2FuJ3QgYmUg
ZGVkdWNlZCBmcm9tIEpFREVDX01GUi4gQnV0IG1pZ2h0IGJlDQpjb25mdXNpbmcsIHNvIHdpbGwg
cmVtb3ZlIGl0Lg0KDQo+IFJldmlld2VkLWJ5OiBCb3JpcyBCcmV6aWxsb24gPGJvcmlzLmJyZXpp
bGxvbkBjb2xsYWJvcmEuY29tPg0KPiANCj4+ICt7DQo+PiArCXN3aXRjaCAoSkVERUNfTUZSKG5v
ci0+aW5mbykpIHsNCj4+ICsJY2FzZSBTTk9SX01GUl9NQUNST05JWDoNCj4+ICsJCW1hY3Jvbml4
X3NldF9kZWZhdWx0X2luaXQobm9yKTsNCj4+ICsJCWJyZWFrOw0KPj4gKw0KPj4gKwljYXNlIFNO
T1JfTUZSX1NUOg0KPj4gKwljYXNlIFNOT1JfTUZSX01JQ1JPTjoNCj4+ICsJCXN0X21pY3Jvbl9z
ZXRfZGVmYXVsdF9pbml0KG5vcik7DQo+PiArCQlicmVhazsNCj4+ICsNCj4+ICsJZGVmYXVsdDoN
Cj4+ICsJCWJyZWFrOw0KPj4gKwl9DQo+PiArfQ0KPj4gKw0KPj4gIHN0YXRpYyB2b2lkDQo+PiAg
c3BpX25vcl9tYW51ZmFjdHVyZXJfaW5pdF9wYXJhbXMoc3RydWN0IHNwaV9ub3IgKm5vciwNCj4+
ICAJCQkJIHN0cnVjdCBzcGlfbm9yX2ZsYXNoX3BhcmFtZXRlciAqcGFyYW1zKQ0KPj4gIHsNCj4+
ICsJLyogSW5pdCBmbGFzaCBwYXJhbWV0ZXJzIGJhc2VkIG9uIE1GUiAqLw0KPj4gKwlzcGlfbm9y
X21mcl9pbml0X3BhcmFtcyhub3IsIHBhcmFtcyk7DQo+PiArDQo+PiAgCWlmIChub3ItPmluZm8t
PmZpeHVwcyAmJiBub3ItPmluZm8tPmZpeHVwcy0+ZGVmYXVsdF9pbml0KQ0KPj4gIAkJcmV0dXJu
IG5vci0+aW5mby0+Zml4dXBzLT5kZWZhdWx0X2luaXQobm9yLCBwYXJhbXMpOw0KPj4gIH0NCj4+
IEBAIC00MzY5LDI1ICs0Mzk4LDYgQEAgc3RhdGljIGludCBzcGlfbm9yX2luaXRfcGFyYW1zKHN0
cnVjdCBzcGlfbm9yICpub3IsDQo+PiAgCQkJICAgICAgIFNQSU5PUl9PUF9TRSk7DQo+PiAgCXNw
aV9ub3JfaW5pdF91bmlmb3JtX2VyYXNlX21hcChtYXAsIGVyYXNlX21hc2ssIHBhcmFtcy0+c2l6
ZSk7DQo+PiAgDQo+PiAtCS8qIFNlbGVjdCB0aGUgcHJvY2VkdXJlIHRvIHNldCB0aGUgUXVhZCBF
bmFibGUgYml0LiAqLw0KPj4gLQlpZiAocGFyYW1zLT5od2NhcHMubWFzayAmIChTTk9SX0hXQ0FQ
U19SRUFEX1FVQUQgfA0KPj4gLQkJCQkgICBTTk9SX0hXQ0FQU19QUF9RVUFEKSkgew0KPj4gLQkJ
c3dpdGNoIChKRURFQ19NRlIoaW5mbykpIHsNCj4+IC0JCWNhc2UgU05PUl9NRlJfTUFDUk9OSVg6
DQo+PiAtCQkJcGFyYW1zLT5xdWFkX2VuYWJsZSA9IG1hY3Jvbml4X3F1YWRfZW5hYmxlOw0KPj4g
LQkJCWJyZWFrOw0KPj4gLQ0KPj4gLQkJY2FzZSBTTk9SX01GUl9TVDoNCj4+IC0JCWNhc2UgU05P
Ul9NRlJfTUlDUk9OOg0KPj4gLQkJCWJyZWFrOw0KPj4gLQ0KPj4gLQkJZGVmYXVsdDoNCj4+IC0J
CQkvKiBLZXB0IG9ubHkgZm9yIGJhY2t3YXJkIGNvbXBhdGliaWxpdHkgcHVycG9zZS4gKi8NCj4+
IC0JCQlwYXJhbXMtPnF1YWRfZW5hYmxlID0gc3BhbnNpb25fcXVhZF9lbmFibGU7DQo+PiAtCQkJ
YnJlYWs7DQo+PiAtCQl9DQo+PiAtCX0NCj4+IC0NCj4+ICAJc3BpX25vcl9tYW51ZmFjdHVyZXJf
aW5pdF9wYXJhbXMobm9yLCBwYXJhbXMpOw0KPj4gIA0KPj4gIAlpZiAoKGluZm8tPmZsYWdzICYg
KFNQSV9OT1JfRFVBTF9SRUFEIHwgU1BJX05PUl9RVUFEX1JFQUQpKSAmJg0KPj4gQEAgLTQ1Njks
NyArNDU3OSw2IEBAIHN0YXRpYyBpbnQgc3BpX25vcl9zZXR1cChzdHJ1Y3Qgc3BpX25vciAqbm9y
LA0KPj4gIAkJCSBjb25zdCBzdHJ1Y3Qgc3BpX25vcl9od2NhcHMgKmh3Y2FwcykNCj4+ICB7DQo+
PiAgCXUzMiBpZ25vcmVkX21hc2ssIHNoYXJlZF9tYXNrOw0KPj4gLQlib29sIGVuYWJsZV9xdWFk
X2lvOw0KPj4gIAlpbnQgZXJyOw0KPj4gIA0KPj4gIAkvKg0KPj4gQEAgLTQ2MTcsMjEgKzQ2MjYs
MjMgQEAgc3RhdGljIGludCBzcGlfbm9yX3NldHVwKHN0cnVjdCBzcGlfbm9yICpub3IsDQo+PiAg
DQo+PiAgCS8qIFNlbGVjdCB0aGUgU2VjdG9yIEVyYXNlIGNvbW1hbmQuICovDQo+PiAgCWVyciA9
IHNwaV9ub3Jfc2VsZWN0X2VyYXNlKG5vciwgbm9yLT5pbmZvLT5zZWN0b3Jfc2l6ZSk7DQo+PiAt
CWlmIChlcnIpIHsNCj4+ICsJaWYgKGVycikNCj4+ICAJCWRldl9lcnIobm9yLT5kZXYsDQo+PiAg
CQkJImNhbid0IHNlbGVjdCBlcmFzZSBzZXR0aW5ncyBzdXBwb3J0ZWQgYnkgYm90aCB0aGUgU1BJ
IGNvbnRyb2xsZXIgYW5kIG1lbW9yeS5cbiIpOw0KPj4gLQkJcmV0dXJuIGVycjsNCj4+IC0JfQ0K
Pj4gIA0KPj4gLQkvKiBFbmFibGUgUXVhZCBJL08gaWYgbmVlZGVkLiAqLw0KPj4gLQllbmFibGVf
cXVhZF9pbyA9IChzcGlfbm9yX2dldF9wcm90b2NvbF93aWR0aChub3ItPnJlYWRfcHJvdG8pID09
IDQgfHwNCj4+IC0JCQkgIHNwaV9ub3JfZ2V0X3Byb3RvY29sX3dpZHRoKG5vci0+d3JpdGVfcHJv
dG8pID09IDQpOw0KPj4gLQlpZiAoZW5hYmxlX3F1YWRfaW8gJiYgcGFyYW1zLT5xdWFkX2VuYWJs
ZSkNCj4+IC0JCW5vci0+cXVhZF9lbmFibGUgPSBwYXJhbXMtPnF1YWRfZW5hYmxlOw0KPj4gLQll
bHNlDQo+PiAtCQlub3ItPnF1YWRfZW5hYmxlID0gTlVMTDsNCj4+ICsJcmV0dXJuIGVycjsNCj4+
ICt9DQo+PiAgDQo+PiAtCXJldHVybiAwOw0KPj4gK3N0YXRpYyBpbnQgc3BpX25vcl9xdWFkX2Vu
YWJsZShzdHJ1Y3Qgc3BpX25vciAqbm9yKQ0KPj4gK3sNCj4+ICsJaWYgKCFub3ItPnF1YWRfZW5h
YmxlKQ0KPj4gKwkJcmV0dXJuIDA7DQo+PiArDQo+PiArCWlmICghKHNwaV9ub3JfZ2V0X3Byb3Rv
Y29sX3dpZHRoKG5vci0+cmVhZF9wcm90bykgPT0gNCB8fA0KPj4gKwkgICAgICBzcGlfbm9yX2dl
dF9wcm90b2NvbF93aWR0aChub3ItPndyaXRlX3Byb3RvKSA9PSA0KSkNCj4+ICsJCXJldHVybiAw
Ow0KPj4gKw0KPj4gKwlyZXR1cm4gbm9yLT5xdWFkX2VuYWJsZShub3IpOw0KPj4gIH0NCj4+ICAN
Cj4+ICBzdGF0aWMgaW50IHNwaV9ub3JfaW5pdChzdHJ1Y3Qgc3BpX25vciAqbm9yKQ0KPj4gQEAg
LTQ2NTAsMTIgKzQ2NjEsMTAgQEAgc3RhdGljIGludCBzcGlfbm9yX2luaXQoc3RydWN0IHNwaV9u
b3IgKm5vcikNCj4+ICAJCX0NCj4+ICAJfQ0KPj4gIA0KPj4gLQlpZiAobm9yLT5xdWFkX2VuYWJs
ZSkgew0KPj4gLQkJZXJyID0gbm9yLT5xdWFkX2VuYWJsZShub3IpOw0KPj4gLQkJaWYgKGVycikg
ew0KPj4gLQkJCWRldl9lcnIobm9yLT5kZXYsICJxdWFkIG1vZGUgbm90IHN1cHBvcnRlZFxuIik7
DQo+PiAtCQkJcmV0dXJuIGVycjsNCj4+IC0JCX0NCj4+ICsJZXJyID0gc3BpX25vcl9xdWFkX2Vu
YWJsZShub3IpOw0KPj4gKwlpZiAoZXJyKSB7DQo+PiArCQlkZXZfZXJyKG5vci0+ZGV2LCAicXVh
ZCBtb2RlIG5vdCBzdXBwb3J0ZWRcbiIpOw0KPj4gKwkJcmV0dXJuIGVycjsNCj4+ICAJfQ0KPj4g
IA0KPj4gIAlpZiAobm9yLT5hZGRyX3dpZHRoID09IDQgJiYgIShub3ItPmZsYWdzICYgU05PUl9G
XzRCX09QQ09ERVMpKSB7DQo+PiBAQCAtNDc4Miw2ICs0NzkxLDkgQEAgaW50IHNwaV9ub3Jfc2Nh
bihzdHJ1Y3Qgc3BpX25vciAqbm9yLCBjb25zdCBjaGFyICpuYW1lLA0KPj4gIAkgICAgbm9yLT5p
bmZvLT5mbGFncyAmIFNQSV9OT1JfSEFTX0xPQ0spDQo+PiAgCQlub3ItPmNsZWFyX3NyX2JwID0g
c3BpX25vcl9jbGVhcl9zcl9icDsNCj4+ICANCj4+ICsJLyogS2VwdCBvbmx5IGZvciBiYWNrd2Fy
ZCBjb21wYXRpYmlsaXR5IHB1cnBvc2UuICovDQo+PiArCW5vci0+cXVhZF9lbmFibGUgPSBzcGFu
c2lvbl9xdWFkX2VuYWJsZTsNCj4+ICsNCj4+ICAJLyogUGFyc2UgdGhlIFNlcmlhbCBGbGFzaCBE
aXNjb3ZlcmFibGUgUGFyYW1ldGVycyB0YWJsZS4gKi8NCj4+ICAJcmV0ID0gc3BpX25vcl9pbml0
X3BhcmFtcyhub3IsICZwYXJhbXMpOw0KPj4gIAlpZiAocmV0KQ0KPj4gQEAgLTQ4NTgsNyArNDg3
MCw2IEBAIGludCBzcGlfbm9yX3NjYW4oc3RydWN0IHNwaV9ub3IgKm5vciwgY29uc3QgY2hhciAq
bmFtZSwNCj4+ICAJICogLSBzZWxlY3Qgb3AgY29kZXMgZm9yIChGYXN0KSBSZWFkLCBQYWdlIFBy
b2dyYW0gYW5kIFNlY3RvciBFcmFzZS4NCj4+ICAJICogLSBzZXQgdGhlIG51bWJlciBvZiBkdW1t
eSBjeWNsZXMgKG1vZGUgY3ljbGVzICsgd2FpdCBzdGF0ZXMpLg0KPj4gIAkgKiAtIHNldCB0aGUg
U1BJIHByb3RvY29scyBmb3IgcmVnaXN0ZXIgYW5kIG1lbW9yeSBhY2Nlc3Nlcy4NCj4+IC0JICog
LSBzZXQgdGhlIFF1YWQgRW5hYmxlIGJpdCBpZiBuZWVkZWQgKHJlcXVpcmVkIGJ5IFNQSSB4LXkt
NCBwcm90b3MpLg0KPj4gIAkgKi8NCj4+ICAJcmV0ID0gc3BpX25vcl9zZXR1cChub3IsICZwYXJh
bXMsIGh3Y2Fwcyk7DQo+PiAgCWlmIChyZXQpDQo+IA0KPiANCj4gDQo=
