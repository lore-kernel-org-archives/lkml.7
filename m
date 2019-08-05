Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F4A8C433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 11:24:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBDDC20856
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 11:24:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="u0YxpwRi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728399AbfHELYT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 07:24:19 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:61200 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727158AbfHELYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 07:24:19 -0400
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
IronPort-SDR: lnEMBYrW//Q4mzFhMXesJOpGGrtilnGCNkOevRtj1yv1p9hgF9r0yhahkNoYypIAjtvdqs4FnY
 AHPkjY9e0IeFiirDq4gYptZ4E9iTUimMTYRr9zHjsiuDdYwAR1i8ysbkXGgTzXHwWshixvQkDV
 YyQOXvX2vF2SedqimW4tXYb9Bml5djEqrpmS2wtzKR524bcXmZkGWjOkKcdv1QEexErrcgL6N2
 Zv/yFYpXiCSmz0N/0lGl0aNGn3E4RgvPC5r9sY0hkUqb2CADskiGkw/gJh1aJF4fVnyYbvfRFZ
 CSg=
X-IronPort-AV: E=Sophos;i="5.64,349,1559545200"; 
   d="scan'208";a="45351165"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 Aug 2019 04:24:17 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 5 Aug 2019 04:24:16 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 5 Aug 2019 04:24:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ck+98Yqf21R3v5MFZ12DgPf5Q6VcRMKQufx4Pm6hcQKvMD0BwFLuZ6JVK+2oMhjNdMy+wdgTOy9TLZFKCKieF7XAKpHwmSgRxhjmNVI+xYZcAT+Ozj9cR46RrOEsmK/1L4NS8ePSsPZt64RbH/MQxpqWAjrapS1G3C14LCkIho72ccYeZZqe0j0fSQX2AFR1POv1apmhaGGaCEkBKXlv781Ae/4gL/DgAaOdJ+h9Y+ldyFOmVoQmE4KG4xULyrOCEKcN5gCpuTN+SD3IP3ld9MJCnilFbxiepQ5V+ADkFM9PA8XezrwetYA71jxHAXgjyaVXlcD2tPXIeTgrpz4Ecg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=isGcizsNIVmLUebWP9IdPGPFhyk61Y/dsoPW2lxt2/4=;
 b=Lzb20hrShm4K3uUJr6btwDuyztUvIAUEeWSsiJU1nt/iWLDr4Of197fa1JvmM+dtIK1iffLHlSYfeAGWyezuF54EtX5Qv3GRJdRzDk5mJlroLYEf6UuNycqT4gIOfXbWk5NdvRgHkmJqV08IBEdWVGIuCYxTOvGVbaQrSYVxWq8Wi1wj7IRxl6AVlP+YFPrSTYY/NgYfus1hcMuJpAq5FuX2RFxlS8kHKjIgzbnNons6tRKglApDhGFzVVfuUNffrOuST5mE+mKdI+CbQEhiZR+tf5QqXFfieryziEBnzzDH89VFEokf/kmlaPO+r3zmBNVJkX8pceaQkxFTn7rzQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=microchip.com;dmarc=pass action=none
 header.from=microchip.com;dkim=pass header.d=microchip.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=isGcizsNIVmLUebWP9IdPGPFhyk61Y/dsoPW2lxt2/4=;
 b=u0YxpwRiPHwmO13l3iP3XrZ/04ZRt9ZCKnD3F9pZK/kdNHGl1sMhkvhfucF+6MT14LZ3InfDEA9QBiKiMNIk4X7RoOxrn2brQqNoJMKQzk0ft51jrFe8ZtDCrEBJmTkdTBYlJySBN2g2cQ/fmSaSud6D12gelUyftBKqn3+QDgA=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB3742.namprd11.prod.outlook.com (20.178.254.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.17; Mon, 5 Aug 2019 11:24:14 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::70c3:e929:4da2:60a5]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::70c3:e929:4da2:60a5%7]) with mapi id 15.20.2136.018; Mon, 5 Aug 2019
 11:24:14 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <vigneshr@ti.com>, <miquel.raynal@bootlin.com>, <richard@nod.at>
CC:     <marek.vasut@gmail.com>, <bbrezillon@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <tmaimon77@gmail.com>
Subject: Re: [PATCH v4 1/3] mtd: spi-nor: always use bounce buffer for
 register read/writes
Thread-Topic: [PATCH v4 1/3] mtd: spi-nor: always use bounce buffer for
 register read/writes
Thread-Index: AQHVSIVVg9Qji1Cq1EmeYAs+Xr0s4KbsSSOAgAAZyoCAAAycgA==
Date:   Mon, 5 Aug 2019 11:24:14 +0000
Message-ID: <d515c4ea-d7bb-f7a6-c025-b8c98d0d68cb@microchip.com>
References: <20190801162229.28897-1-vigneshr@ti.com>
 <20190801162229.28897-2-vigneshr@ti.com>
 <b125bf29-f1fd-6d33-4a7c-49cb94ef1488@microchip.com>
 <2b10c18a-e955-31b8-b3e0-c3df83508756@ti.com>
In-Reply-To: <2b10c18a-e955-31b8-b3e0-c3df83508756@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR07CA0264.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::31) To MN2PR11MB4448.namprd11.prod.outlook.com
 (2603:10b6:208:193::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b3a3b09a-1c5a-40b0-f507-08d7199771fe
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MN2PR11MB3742;
x-ms-traffictypediagnostic: MN2PR11MB3742:
x-microsoft-antispam-prvs: <MN2PR11MB37424AFFC764731F00FAB661F0DA0@MN2PR11MB3742.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 01208B1E18
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(346002)(376002)(136003)(366004)(189003)(199004)(386003)(256004)(14444005)(8676002)(186003)(4326008)(7736002)(102836004)(26005)(53936002)(52116002)(14454004)(99286004)(2906002)(6486002)(81156014)(66066001)(71190400001)(6436002)(316002)(110136005)(229853002)(6116002)(6506007)(6512007)(53546011)(54906003)(305945005)(3846002)(71200400001)(76176011)(68736007)(86362001)(478600001)(2201001)(66476007)(66556008)(64756008)(66446008)(5660300002)(25786009)(66946007)(486006)(476003)(31696002)(31686004)(446003)(36756003)(2501003)(81166006)(11346002)(2616005)(8936002)(6246003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3742;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: lZiw70TFiBgiHi4eBvFNO93sT6LWfINv6AeefG4zk+gjIkAFjFvfOjeHt9Wz2oU0unpAQVVuRCbb4Zv/gY9pK4vXNKwsifi5/ST2eFqw/WueM1BWLIXQO9eIVBJrNKW6w1Ol4CSGVJbx29Dvj2e4oXoLhrfQgr5mOu8xvRkGCaW2r1AXggVrbfR+XDcjwJIH9S1cWIqG5L4Ghi4rjZnCRiDZ9Tnr+3pousVkSFmHaMH/Lguazln7gFXcadTzOasCJNZJg1bB3tAyRoEK5cwBxWL5BJfLQoZFIhYaykrqOBaGdXBAKDr6bYueZjYOqINtg5WyGI3wTGd3AhUyhDWLe0LmtMZrqVxARYIYasHAf5ejbOJaCFyAWF068U1yhs11EXXUyuFFTQZUImd15mitTd/VHKYulht0Rfox2dXBBso=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7DBB723B6B1E1D4496E8AECABA9A2EDA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b3a3b09a-1c5a-40b0-f507-08d7199771fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2019 11:24:14.1853
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tudor.ambarus@microchip.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3742
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDA4LzA1LzIwMTkgMDE6MzggUE0sIFZpZ25lc2ggUmFnaGF2ZW5kcmEgd3JvdGU6DQo+
IEV4dGVybmFsIEUtTWFpbA0KPiANCj4gDQo+IA0KPiBPbiAwNS8wOC8xOSAyOjM2IFBNLCBUdWRv
ci5BbWJhcnVzQG1pY3JvY2hpcC5jb20gd3JvdGU6DQo+Pg0KPj4NCj4+IE9uIDA4LzAxLzIwMTkg
MDc6MjIgUE0sIFZpZ25lc2ggUmFnaGF2ZW5kcmEgd3JvdGU6DQo+Pj4gRXh0ZXJuYWwgRS1NYWls
DQo+Pj4NCj4+Pg0KPj4+IHNwaS1tZW0gbGF5ZXIgZXhwZWN0cyBhbGwgYnVmZmVycyBwYXNzZWQg
dG8gaXQgdG8gYmUgRE1BJ2FibGUuIEJ1dA0KPj4+IHNwaS1ub3IgbGF5ZXIgbW9zdGx5IGFsbG9j
YXRlcyBidWZmZXJzIG9uIHN0YWNrIGZvciByZWFkaW5nL3dyaXRpbmcgdG8NCj4+PiByZWdpc3Rl
cnMgYW5kIHRoZXJlZm9yZSBhcmUgbm90IERNQSdhYmxlLiBJbnRyb2R1Y2UgYm91bmNlIGJ1ZmZl
ciB0byBiZQ0KPj4+IHVzZWQgdG8gcmVhZC93cml0ZSB0byByZWdpc3RlcnMuIFRoaXMgZW5zdXJl
cyB0aGF0IGJ1ZmZlciBwYXNzZWQgdG8NCj4+PiBzcGktbWVtIGxheWVyIGR1cmluZyByZWdpc3Rl
ciByZWFkL3dyaXRlcyBpcyBETUEnYWJsZS4gV2l0aCB0aGlzIGNoYW5nZQ0KPj4+IG5vci0+Y21k
LWJ1ZiBpcyBubyBsb25nZXIgdXNlZCwgc28gZHJvcCBpdC4NCj4+Pg0KPj4+IFJldmlld2VkLWJ5
OiBCb3JpcyBCcmV6aWxsb24gPGJvcmlzLmJyZXppbGxvbkBjb2xsYWJvcmEuY29tPg0KPj4+IFNp
Z25lZC1vZmYtYnk6IFZpZ25lc2ggUmFnaGF2ZW5kcmEgPHZpZ25lc2hyQHRpLmNvbT4NCj4+PiAt
LS0NCj4+Pg0KPj4+IHY0Og0KPj4+IEF2b2lkIG1lbWNweSBkdXJpbmcgUkVBRElEDQo+Pj4NCj4+
PiB2MzogbmV3IHBhdGNoDQo+Pj4NCj4+PiAgZHJpdmVycy9tdGQvc3BpLW5vci9zcGktbm9yLmMg
fCA3MCArKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLQ0KPj4+ICBpbmNsdWRlL2xp
bnV4L210ZC9zcGktbm9yLmggICB8ICA3ICsrKy0NCj4+PiAgMiBmaWxlcyBjaGFuZ2VkLCA0NSBp
bnNlcnRpb25zKCspLCAzMiBkZWxldGlvbnMoLSkNCj4+Pg0KPj4+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL210ZC9zcGktbm9yL3NwaS1ub3IuYyBiL2RyaXZlcnMvbXRkL3NwaS1ub3Ivc3BpLW5vci5j
DQo+Pj4gaW5kZXggMDNjYzc4ODUxMWQ1Li5lMDIzNzZlMTEyN2IgMTAwNjQ0DQo+Pj4gLS0tIGEv
ZHJpdmVycy9tdGQvc3BpLW5vci9zcGktbm9yLmMNCj4+PiArKysgYi9kcml2ZXJzL210ZC9zcGkt
bm9yL3NwaS1ub3IuYw0KPj4NCj4+IGN1dA0KPj4NCj4+PiAgLyoqDQo+Pj4gQEAgLTE0MDQsOSAr
MTQwMSwxMSBAQCBzdGF0aWMgaW50IHdyaXRlX3NyX2NyKHN0cnVjdCBzcGlfbm9yICpub3IsIHU4
ICpzcl9jcikNCj4+PiAgew0KPj4+ICAJaW50IHJldDsNCj4+PiAgDQo+Pj4gKwltZW1jcHkobm9y
LT5ib3VuY2VidWYsIHNyX2NyLCAyKTsNCj4+DQo+PiBJJ20gdGhpbmtpbmcgb3V0IGxvdWQuIFRo
aXMgY2FuIGJlIGF2b2lkZWQgYnkgZm9yY2luZyBhbGwgdGhlIGNhbGxlcnMgdG8gdXNlDQo+PiBu
b3ItPmJvdW5jZWJ1Zi4gVGhhdCB3b3VsZCByZXN1bHQgaW4gYToNCj4+DQo+IA0KPiBJIGNhbiBt
YWtlIHRoaXMgY2hhbmdlIGFuZCBtYWtlIGFsbCBjYWxsZXJzIHVzZSBub3ItPmJvdW5jZWJ1ZiBp
biBuZXh0DQo+IHZlcnNpb24uDQo+IA0KDQpzaG91bGQgYmUgb2ssIGl0IHdpbGwgbm90IGNoYW5n
ZSB0aGUgZmxvdyBsb2dpYy4NCg0KPj4gc3RhdGljIGludCB3cml0ZV9zcihzdHJ1Y3Qgc3BpX25v
ciAqbm9yLCBzaXplX3QgbGVuKQ0KPj4NCj4+IHdyaXRlX3NyX2NyKCkgY2FuIGJlIHJlbW92ZWQu
IE1lbWNvcHlpbmcgMiBieXRlcyBpcyBhIHNtYWxsIHByaWNlIHRvIHBheSwgd2UgY2FuDQo+PiBr
ZWVwIHRoaW5ncyBhcyB0aGV5IGFyZSwgdG8gbm90IGJlIHRvbyBpbnZhc2l2ZS4gQnV0IGlmIHlv
dSB0aGluayB0aGF0IHRoaXMgaWRlYQ0KPj4gaXMgd29ydGggaXQsIHRlbGwuDQo+Pg0KPiANCj4g
U291bmRzIGdvb2QgdG8gbWUuIEJ1dCByZXBsYWNpbmcgd3JpdGVfc3JfY3IoKSB3aXRoIGFib3Zl
IGRlZmludGlvbiBvZg0KPiB3cml0ZV9zcigpIHNob3VsZCBiZSBhIHBhdGNoIElNTz4NCg0KSSds
bCBkbyBhIHBhdGNoIGFmdGVyIHdlIGZpbmlzaCB0byBpbnRlZ3JhdGUgdGhlIGJpZyBmYXQgY2hh
bmdlcy4NCg0KVGhhbmtzLA0KdGENCg==
