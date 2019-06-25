Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9B12C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 07:54:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7198020659
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 07:54:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="3qW2VgCI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727887AbfFYHyA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 03:54:00 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:51549 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726777AbfFYHx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 03:53:59 -0400
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
X-IronPort-AV: E=Sophos;i="5.63,415,1557212400"; 
   d="scan'208";a="38762188"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Jun 2019 00:53:58 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex03.mchp-main.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 25 Jun 2019 00:54:02 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Tue, 25 Jun 2019 00:53:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/BEFb3qHZ7fxUXHyvbyLY6Js/BQDUjQ4ENe41GLGg58=;
 b=3qW2VgCIcvrBNHqbDQKOvAZXawzQxZMUuuUt70f0vSMTh8xPYV+PfGti8LBG5yTYQTx7Gr4zIZlmUAMZ23USI5lBj7H5XrJWA38Gea6YaMGoyjpaq6HSwvqZv9IVpAZYzYSlD9JYtslE4yuokTvw3urj6X1G9IDqrwQ+6ytAnbI=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB1889.namprd11.prod.outlook.com (10.175.100.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Tue, 25 Jun 2019 07:53:50 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::e581:f807:acdc:cb36]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::e581:f807:acdc:cb36%9]) with mapi id 15.20.2008.017; Tue, 25 Jun 2019
 07:53:50 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <Eugeniy.Paltsev@synopsys.com>, <marex@denx.de>,
        <linux-mtd@lists.infradead.org>
CC:     <miquel.raynal@bootlin.com>, <dwmw2@infradead.org>,
        <marek.vasut@gmail.com>, <linux-snps-arc@lists.infradead.org>,
        <richard@nod.at>, <Alexey.Brodkin@synopsys.com>,
        <linux-kernel@vger.kernel.org>, <computersforpeace@gmail.com>
Subject: Re: [PATCH] mtd: spi-nor: add support for sst26wf016, sst26wf032
 memory
Thread-Topic: [PATCH] mtd: spi-nor: add support for sst26wf016, sst26wf032
 memory
Thread-Index: AQHVHUfULV5f3c0l6EGHxaXBBI7PvaanjSsAgAOlG4CAAOlhAA==
Date:   Tue, 25 Jun 2019 07:53:50 +0000
Message-ID: <927c5fe0-9e6a-f6bb-80e5-835bc3c8cbca@microchip.com>
References: <20190607154308.20899-1-Eugeniy.Paltsev@synopsys.com>
 <aab6510e-9608-584e-1556-613bb0be482e@microchip.com>
 <305636da161f6c204e39936696301c226c1c95f9.camel@synopsys.com>
In-Reply-To: <305636da161f6c204e39936696301c226c1c95f9.camel@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR04CA0135.eurprd04.prod.outlook.com
 (2603:10a6:803:f0::33) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:101::18)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 12c1b12d-971d-46ea-244d-08d6f94242df
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BN6PR11MB1889;
x-ms-traffictypediagnostic: BN6PR11MB1889:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <BN6PR11MB18894266632840456ADC50A0F0E30@BN6PR11MB1889.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0079056367
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(39860400002)(136003)(366004)(189003)(199004)(305945005)(6486002)(6436002)(2201001)(7736002)(4326008)(229853002)(14454004)(6116002)(3846002)(14444005)(256004)(86362001)(31696002)(2906002)(966005)(6512007)(6306002)(72206003)(53936002)(11346002)(446003)(486006)(476003)(2616005)(6246003)(53546011)(6506007)(386003)(102836004)(54906003)(110136005)(316002)(99286004)(31686004)(76176011)(52116002)(81156014)(8936002)(8676002)(36756003)(81166006)(26005)(2501003)(186003)(66446008)(64756008)(66556008)(66476007)(66066001)(5660300002)(68736007)(71190400001)(71200400001)(25786009)(7416002)(66946007)(73956011)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1889;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: U5O/ZrcH67QyTrxuhLmuOhuypX8hDTbtBtMX69FisAGO5+j4hL21DLlEabEP6Tl41nSOul7HprJ5jqkzILfnBun5vm0TKJeL0IW9Mio8lmo3mebsi/l1wIwWAWRzduzVKErY3EUJAMFWGLpKte3uxNEADibW7SHMi4o+vhmLBwZrS91xNp0Fh7dZ5NLIaQALwQZtlp3RBdx/oXuWRP+q9md/87U1d26xKzSaM0QcoFKhOPh1f7pbO2TU0fxvKAYzk3KfMS7HlJZkhC2f98PBbPN6wwVyGusv2S+pKfpSMCvU4OtuLRbdkACyYf1+PNfxJVuk6eaV0hDi3bU+/ssr4sohcbqlLKDDVQ9Sjj+l5WceUj40YrXjVgRUTdSX+LWxIUtLg77uQkC+Dmed7wgslSYlqySS3SFCVPcfJrKJrR0=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DFF2834F5B4A7C44970D84CB21E333E8@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 12c1b12d-971d-46ea-244d-08d6f94242df
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2019 07:53:50.7534
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tudor.ambarus@microchip.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1889
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEV1Z2VuaXksDQoNCk9uIDA2LzI0LzIwMTkgMDg6NTggUE0sIEV1Z2VuaXkgUGFsdHNldiB3
cm90ZToNCj4gRXh0ZXJuYWwgRS1NYWlsDQo+IA0KPiANCj4gSGkgVHVkb3IsDQo+IA0KPiBPbiBT
YXQsIDIwMTktMDYtMjIgYXQgMTA6MTggKzAwMDAsIFR1ZG9yLkFtYmFydXNAbWljcm9jaGlwLmNv
bSB3cm90ZToNCj4+IEhpLCBFdWdlbml5LA0KPj4NCj4+IE9uIDA2LzA3LzIwMTkgMDY6NDMgUE0s
IEV1Z2VuaXkgUGFsdHNldiB3cm90ZToNCj4+PiBFeHRlcm5hbCBFLU1haWwNCj4+Pg0KPj4+DQo+
Pj4gVGhpcyBjb21taXQgYWRkcyBzdXBwb3J0IGZvciB0aGUgU1NUIHNzdDI2d2YwMTYgYW5kIHNz
dDI2d2YwMzINCj4+PiBmbGFzaCBtZW1vcnkgSUMuDQo+Pg0KPj4gUGxlYXNlIHNwZWNpZnkgaWYg
eW91IHRlc3RlZCBib3RoIGZsYXNoZXMsIHdpdGggMS0xLTEsIDEtMS0yIGFuZCAxLTEtNCByZWFk
cy4NCj4+IExldCB1cyBrbm93IHdoaWNoIGNvbnRyb2xsZXIgeW91IHVzZWQuIEkgYXNrIGZvciB0
aGVzZSB0byBiZSBzdXJlIHRoYXQgd2UgZG9uJ3QNCj4+IGFkZCBmbGFzaGVzIHRoYXQgYXJlIGJy
b2tlbiBmcm9tIGRheSBvbmUuDQo+Pg0KPj4+IFNpZ25lZC1vZmYtYnk6IEV1Z2VuaXkgUGFsdHNl
diA8RXVnZW5peS5QYWx0c2V2QHN5bm9wc3lzLmNvbT4NCj4+PiAtLS0NCj4+PiAgZHJpdmVycy9t
dGQvc3BpLW5vci9zcGktbm9yLmMgfCAyICsrDQo+Pj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2Vy
dGlvbnMoKykNCj4+Pg0KPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL210ZC9zcGktbm9yL3NwaS1u
b3IuYyBiL2RyaXZlcnMvbXRkL3NwaS1ub3Ivc3BpLW5vci5jDQo+Pj4gaW5kZXggNzMxNzJkN2Y1
MTJiLi4yMjQyNzU0NjFhMmMgMTAwNjQ0DQo+Pj4gLS0tIGEvZHJpdmVycy9tdGQvc3BpLW5vci9z
cGktbm9yLmMNCj4+PiArKysgYi9kcml2ZXJzL210ZC9zcGktbm9yL3NwaS1ub3IuYw0KPj4+IEBA
IC0xOTQ1LDYgKzE5NDUsOCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGZsYXNoX2luZm8gc3BpX25v
cl9pZHNbXSA9IHsNCj4+PiAgCXsgInNzdDI1d2YwNDBiIiwgSU5GTygweDYyMTYxMywgMCwgNjQg
KiAxMDI0LCAgOCwgU0VDVF80SykgfSwNCj4+PiAgCXsgInNzdDI1d2YwNDAiLCAgSU5GTygweGJm
MjUwNCwgMCwgNjQgKiAxMDI0LCAgOCwgU0VDVF80SyB8IFNTVF9XUklURSkgfSwNCj4+PiAgCXsg
InNzdDI1d2YwODAiLCAgSU5GTygweGJmMjUwNSwgMCwgNjQgKiAxMDI0LCAxNiwgU0VDVF80SyB8
IFNTVF9XUklURSkgfSwNCj4+PiArCXsgInNzdDI2d2YwMTYiLCAgSU5GTygweGJmMjY1MSwgMCwg
NjQgKiAxMDI0LCAzMiwgU0VDVF80SyB8IFNQSV9OT1JfRFVBTF9SRUFEIHwgU1BJX05PUl9RVUFE
X1JFQUQpIH0sDQo+Pg0KPj4gSSBjb25maXJtIHRoYXQgdGhlIGFib3ZlIGlzIGNvcnJlY3QuDQo+
Pg0KPj4+ICsJeyAic3N0MjZ3ZjAzMiIsICBJTkZPKDB4YmYyNjIyLCAwLCA2NCAqIDEwMjQsIDY0
LCBTRUNUXzRLIHwgU1BJX05PUl9EVUFMX1JFQUQgfCBTUElfTk9SX1FVQURfUkVBRCkgfSwNCj4+
DQo+PiBUaGVyZSBhcmUgc3N0MjZ3ZjAzMiBmbGFzaGVzIHRoYXQgZG9uJ3Qgc3VwcG9ydCBTUElO
T1JfT1BfUkVBRF8xXzFfMiAoMHgzYikgYW5kDQo+PiBTUElOT1JfT1BfUkVBRF8xXzFfNCAoMHg2
YiksIGNoZWNrDQo+PiBodHRwczovL3VybGRlZmVuc2UucHJvb2Zwb2ludC5jb20vdjIvdXJsP3U9
aHR0cHMtM0FfX3BkZjEuYWxsZGF0YXNoZWV0LmNvbV9kYXRhc2hlZXQtMkRwZGZfdmlld18zOTIw
NjNfU1NUX1NTVDI2V0YwMzIuaHRtbCZkPUR3SUdhUSZjPURQTDZfWF82SmtYRng3QVhXcUIwdGcm
cj1abEpOMU1yaVBVVGtCS0NyUFN4NjdHbWFwbEVVR2NBRWs5eVB0Q0xkVVhJJm09WUtPQUZoVHNt
Y3hWTk9teTZETzY3V1laWWRvNnhZYTdvamViSUJVLUstYyZzPWsyeVJxV2xYQmxsZkcyUjJIdnFU
d0FqR1lDbXZqR205dG1WWXh6RGdfd0EmZT0gLg0KPj4gWW91DQo+PiBjYW4ndCBhZGQgU1BJX05P
Ul9EVUFMX1JFQUQgYW5kIFNQSV9OT1JfUVVBRF9SRUFEIGlmIDB4M2IgYW5kIDB4NmIgY29tbWFu
ZHMgYXJlDQo+PiBub3Qgc3VwcG9ydGVkLiBDaGVjayBzcGlfbm9yX2luaXRfcGFyYW1zKCkuDQo+
IA0KPiBZZXAsIHRoYW5rcyBmb3IgcG9pbnRpbmcuDQo+IFdlIGFyZSB1c2luZyAnc3N0MjZ3ZjAx
NmInIG9uIEhTREsgZGV2Ym9hcmQuIEkgYWRkZWQgJ3NzdDI2d2YwMzInIHRvIG1ha2UgZmxhc2gg
dXBncmFkZSBlYXNpZXIsDQo+IGJ1dCBJIGRvbid0IGNoZWNrIGNhcmVmdWxseSBlbm91Z2ggdGhh
dCBpdCBoYXMgY29tcGxldGVseSBkaWZmZXJlbnQgY29udHJvbCBsb2dpYyBhbmQgbm90IG9ubHkg
c2l6ZS4NCj4gSSdkIGJldHRlciBkcm9wICdzc3QyNndmMDMyJyBpbiB2MiBwYXRjaCByZXNwaW4g
YXMgdW50ZXN0ZWQuIA0KDQpvaw0KDQo+IA0KPiBJbiB0aGlzIHNldHVwIHdlIHVzZSAic25wcyxk
dy1hcGItc3NpIiBTUEkgY29udHJvbGxlciBhbmQgd2UgZG9uJ3QgdXNlIGR1YWwvcXVhZCBJTy4g
U2hvdWxkIEkNCj4gZHJvcCAoU1BJX05PUl9EVUFMX1JFQUQgfCBTUElfTk9SX1FVQURfUkVBRCkg
Zm9yICJzc3QyNndmMDE2IiBpbiB2MiByZXNwaW4/DQoNCldlIGNhbiBrZWVwIHRoZW0uIFBsZWFz
ZSBzcGVjaWZ5IGluIHRoZSBjb21taXQgbWVzc2FnZSB3aGF0IHdhcyB0ZXN0ZWQgYW5kIHNheQ0K
dGhhdCB0aGUgZmxhc2gncyBkYXRhc2hlZXQgYWR2ZXJ0aXNlcyBib3RoIGR1YWwgYW5kIHF1YWQg
cmVhZHMuIFdlIHdpbGwgZ2l2ZSBhDQpiZW5lZml0IG9mIGEgZG91YnQgdG8gdGhlIGZsYXNoIG1h
bnVmYWN0dXJlci4NCg0KVGhhbmtzLA0KdGENCj4gDQo+Pg0KPj4gQ2hlZXJzLA0KPj4gdGENCg==
