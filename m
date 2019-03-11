Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8D2BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 04:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8A74206DF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 04:33:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="QkTuLygt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727037AbfCKEdH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 00:33:07 -0400
Received: from mail-eopbgr730065.outbound.protection.outlook.com ([40.107.73.65]:56640
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725385AbfCKEdG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 00:33:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=np9o1Tw04K0KNXEu7Zy8WXdd5I38MDXwjT/B9rZ4aWw=;
 b=QkTuLygtAZn7dynOgQeV0w3pjtZroqEwbZ54872c1BEMdqvhF7SYoXfST7WOlFYy2Gw4vW04QkTdZWb6oIpKOZIJM4U+KxVsoW8+btbhb99/eNDrLL6fBd3wQSYQ4dgENu/kuqhEipKMCslp2kI44dkrzv8tNiY66uwWjRI0k2I=
Received: from MWHPR02MB2623.namprd02.prod.outlook.com (10.168.206.9) by
 MWHPR02MB2222.namprd02.prod.outlook.com (10.168.243.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.18; Mon, 11 Mar 2019 04:32:58 +0000
Received: from MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::c89d:e485:cb5e:89cf]) by MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::c89d:e485:cb5e:89cf%5]) with mapi id 15.20.1686.021; Mon, 11 Mar 2019
 04:32:58 +0000
From:   Naga Sureshkumar Relli <nagasure@xilinx.com>
To:     Vignesh Raghavendra <vigneshr@ti.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "bbrezillon@kernel.org" <bbrezillon@kernel.org>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "richard@nod.at" <richard@nod.at>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michal Simek <michals@xilinx.com>,
        "nagasuresh12@gmail.com" <nagasuresh12@gmail.com>
Subject: RE: [RFC PATCH 2/2] spi: spi-mem: Add support for Zynq QSPI
 controller
Thread-Topic: [RFC PATCH 2/2] spi: spi-mem: Add support for Zynq QSPI
 controller
Thread-Index: AQHUzzOoSBENcbUE5E66VjcEuxsjhqX2j+qAgAAInUCACp3tgIAEsX7g
Date:   Mon, 11 Mar 2019 04:32:58 +0000
Message-ID: <MWHPR02MB262362EC0116C64B84874740AF480@MWHPR02MB2623.namprd02.prod.outlook.com>
References: <1551337361-11665-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
 <48dafcc4-1b9d-9ce2-9228-78e73252781f@ti.com>
 <MWHPR02MB262310CF8152AE170FE7443CAF760@MWHPR02MB2623.namprd02.prod.outlook.com>
 <602dd5ed-48b6-2098-fc2a-e36192b6a8e7@ti.com>
In-Reply-To: <602dd5ed-48b6-2098-fc2a-e36192b6a8e7@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a8044280-d4fb-46a8-6a61-08d6a5daa3c8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:MWHPR02MB2222;
x-ms-traffictypediagnostic: MWHPR02MB2222:
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtNV0hQUjAyTUIyMjIyOzIzOm1MWEN3cHNGMDhIM1FBWUtoOUZ0QkVtN29y?=
 =?utf-8?B?VXY2SzFDUDZ4T21jTyt1TGNxMmxQVzZlU2hERWVNcjhyaTJ6WExaUCtvaEdj?=
 =?utf-8?B?VGlHMkRlN1BFcWltL0RZcnBzZXdXVWkvWUxFTFlTOGk0d3NuVkFpVkUvTko2?=
 =?utf-8?B?Y21CaFhxSG4rMm9vTkRFbGNGNEZZaXlsTlVaNnRSZ3BVd0M3VmhsMXVLSnJR?=
 =?utf-8?B?VHFnU0JQNlFCOVczekVzRFpZQ1BWUDdEd042dXJHNk1KTzUwc2swQ21BSVFn?=
 =?utf-8?B?bGFXTi9PMVBWb3dULzh5UHdTSXRkMlo2b2J6Tm5ldXVNOFIxaGZqUVBEV2VT?=
 =?utf-8?B?MVZSTzd6eElvMzBuK1NEc1ZvRU43ZUtzbW1vQjRSWjBJck1pc01xNE4zVlVq?=
 =?utf-8?B?eEVuU3doazU2S2g2bVFkUWt2UEY2cUd0YmxDWDU4YStpLzB0N0p5RlA5RW0v?=
 =?utf-8?B?SDJlSHUxR3l2VHRVVWdMbEkxMlNPQkpBWWtMS3lXb2g4eWxuQ0pHalRtL2pT?=
 =?utf-8?B?TTBRYyt1a1RaeTh0RDBIbXQ4S3o1SVZWd1pxem5QNzJjTm5jb2JMdElhbzAy?=
 =?utf-8?B?QWowNlJPL2NKUGZQNU5JUmtsTDNuU0FaTmJGTzlITTB2WU9xbjBCS24rZDFk?=
 =?utf-8?B?Ri9iaS9mOW5XNmYxdDlRUm43UzRuRW5ncWwrSmhxOHMvQVgvK1VmaGlwYWxT?=
 =?utf-8?B?cnVUdjFtcDNDdEEzL2lFMU9MRG1LRm5CazNkRUhiUVRFZUJTT0NhK01GYkZ4?=
 =?utf-8?B?TUJaTTB4S3ZWMW1BOHlaLzJuWUY1YzUwa0I3dTgwNUdhU2xUNC93NUNpaXNj?=
 =?utf-8?B?VjVxVE80UjdDZ1Q2aHdrVGp0M3dDWEZVbzRqcHpWbktodExZWFFBQzc5dWxy?=
 =?utf-8?B?enlGTStlQW5wbkdJNTE0ZHhWQlRCclg0OTBNRG5wNDlPRDN2b3Q2K1NTdVA5?=
 =?utf-8?B?M2JTaFVPTjkxZ1RYWDlCaDJ2Y2NwMzZBMXRRUEdHcXJnQjFxTnNIZ2cvS3F5?=
 =?utf-8?B?a1JPSHRjL3krZzBPQWJwbENhUEFSM095UXdTejVibFM3c0xPMHpKdE5pcVE3?=
 =?utf-8?B?NmVXRDJiY2c3a3pLSXYraUpFM29LOFE2bFk1cmtjMWFMeng5REtmZUIrVTZp?=
 =?utf-8?B?blB2aFA2YmhYa1RVVXlmVEdpRUlmN1o4S0pyZUE4VnhTMURSSDFFRkxkWUNN?=
 =?utf-8?B?aW1qSHV2dXIzcnZGWlZmc3RzWWNuNEV0b2U4Q2xuM0t2MTFjTUlOOUd2Mzha?=
 =?utf-8?B?MmlzbER1ZXNJNkM3cnFJVFBETzJoN3F2SXNFSTJncUJBTFNueXpVZWhQWkQy?=
 =?utf-8?B?MlZuU3ZHd0NBU3E0K3ovVDQ5WlJWY1lHMnZSTWwrZ2lkZlRrU2U5cHBUSnMr?=
 =?utf-8?B?QlZrb1MzbG9sUW0ySVJqeDA1SmpvVGVZQ1hWY0diUUtCNnlHZm9NcklHNTNv?=
 =?utf-8?B?T2dJRDJIaFVxQzkzWnZMRnY2UWl3SkpIbkJVVDRQdklvdFBiVUcrNytwQVpD?=
 =?utf-8?B?Ulh4WnFQSkkyeVk5TmdORGJ6RXBlYlUzZVVPZ0F5eCttRk1xZ3ZkUmpyRDNP?=
 =?utf-8?B?b3pnODA3bE90UnQwY2l5R3NrWG54bXA5Q2F4ZmlqdU5WOHo0dUtEZUNZVWtC?=
 =?utf-8?B?TW1oM1I3MUJXemtuWUI5NmdwajgxcS9OMUNHLzNBTnBJOGloa2VzbTFobVVY?=
 =?utf-8?B?OHZsL3lvdWxJTGNvd2ljb3B3dVE0SW1sTXF3NTRaOGFhbHRBRDdtaHFuenVY?=
 =?utf-8?B?NGc3TzV3OXl0aVlMNTVTUGxYU0MrNjM5NnhrQ0luYWlxNlZkUlVOWTFGRmx4?=
 =?utf-8?B?a2U1eXF5Wjlkeng3QVpZOThNV0NQdWpna0E2OVljUEtJT2hZbWhxN0RpVjZS?=
 =?utf-8?Q?zosZ1uvmrVY=3D?=
x-microsoft-antispam-prvs: <MWHPR02MB22229EEA8529F0A0F4EA1C54AF480@MWHPR02MB2222.namprd02.prod.outlook.com>
x-forefront-prvs: 09730BD177
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(376002)(396003)(346002)(366004)(189003)(199004)(13464003)(14454004)(7696005)(478600001)(102836004)(53546011)(14444005)(6116002)(6246003)(6346003)(105586002)(106356001)(33656002)(76176011)(3846002)(7416002)(6436002)(2501003)(71190400001)(2201001)(71200400001)(66066001)(186003)(6506007)(229853002)(316002)(8676002)(446003)(26005)(55016002)(476003)(486006)(2906002)(8936002)(25786009)(97736004)(68736007)(256004)(4326008)(86362001)(99286004)(53936002)(54906003)(110136005)(305945005)(93886005)(81156014)(81166006)(11346002)(5660300002)(74316002)(52536013)(9686003)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR02MB2222;H:MWHPR02MB2623.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=nagasure@xilinx.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: bfHm0/JWVncuiAvYkNO32T17cHhdv4jzOtKfgUK9qrL65ny+Yhh1v83zhPUgg48BOL19R3mKToNji0zH5hJbhObI+VItRsY+QQY9VWmT3UZB/MHDgMcTf91NX0Xe6rvYLOMFWKyWdfR5ybug/bENNBSCcbUWfPwlziu6ZJ6l1FSPnTmnfFSB3lEnUwdmTVYXHXdaCXetHKYIlMLij7RhgkSaSvQdWsPbyc1foWxufNXDDVMLiuDlQQFxmTA4OwVm88W63IU66hO18RjF3wybeOIw1IlFxdEhb7oiijkVkjOfdQxgv2Mk595a70YwHDX3WBPedckAsTCKR2H5aseWy+uo3QrkGidMNa576jdTTdjWcs3IlFs1jIj+TOg5qweoFa3A2+kUIF8GAANUJqnmT5S2jOB5eMMUQ4E/ajwzfZs=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8044280-d4fb-46a8-6a61-08d6a5daa3c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2019 04:32:58.7517
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2222
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgVmlnbmVzaCwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBsaW51
eC1zcGktb3duZXJAdmdlci5rZXJuZWwub3JnIDxsaW51eC1zcGktb3duZXJAdmdlci5rZXJuZWwu
b3JnPiBPbiBCZWhhbGYgT2YNCj4gVmlnbmVzaCBSYWdoYXZlbmRyYQ0KPiBTZW50OiBGcmlkYXks
IE1hcmNoIDgsIDIwMTkgMTA6MjAgQU0NCj4gVG86IE5hZ2EgU3VyZXNoa3VtYXIgUmVsbGkgPG5h
Z2FzdXJlQHhpbGlueC5jb20+OyBicm9vbmllQGtlcm5lbC5vcmc7DQo+IGJicmV6aWxsb25Aa2Vy
bmVsLm9yZw0KPiBDYzogbGludXgtc3BpQHZnZXIua2VybmVsLm9yZzsgZHdtdzJAaW5mcmFkZWFk
Lm9yZzsgbWFyZWsudmFzdXRAZ21haWwuY29tOw0KPiByaWNoYXJkQG5vZC5hdDsgbGludXgtbXRk
QGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IE1pY2hh
bCBTaW1law0KPiA8bWljaGFsc0B4aWxpbnguY29tPjsgbmFnYXN1cmVzaDEyQGdtYWlsLmNvbQ0K
PiBTdWJqZWN0OiBSZTogW1JGQyBQQVRDSCAyLzJdIHNwaTogc3BpLW1lbTogQWRkIHN1cHBvcnQg
Zm9yIFp5bnEgUVNQSSBjb250cm9sbGVyDQo+IA0KPiANCj4gDQo+IE9uIDAxLzAzLzE5IDQ6MzIg
UE0sIE5hZ2EgU3VyZXNoa3VtYXIgUmVsbGkgd3JvdGU6DQo+ID4+PiArc3RhdGljIGJvb2wgenlu
cV9xc3BpX3N1cHBvcnRzX29wKHN0cnVjdCBzcGlfbWVtICptZW0sDQo+ID4+PiArCQkJCSAgY29u
c3Qgc3RydWN0IHNwaV9tZW1fb3AgKm9wKQ0KPiA+Pj4gK3sNCj4gPj4+ICsJaW50IHJldDsNCj4g
Pj4+ICsNCj4gPj4+ICsJcmV0ID0genlucV9xc3BpX2NoZWNrX2J1c3dpZHRoKG9wLT5jbWQuYnVz
d2lkdGgpOw0KPiA+Pj4gKw0KPiA+Pj4gKwlpZiAob3AtPmFkZHIubmJ5dGVzKQ0KPiA+Pj4gKwkJ
cmV0IHw9IHp5bnFfcXNwaV9jaGVja19idXN3aWR0aChvcC0+YWRkci5idXN3aWR0aCk7DQo+ID4+
PiArDQo+ID4+PiArCWlmIChvcC0+ZHVtbXkubmJ5dGVzKQ0KPiA+Pj4gKwkJcmV0IHw9IHp5bnFf
cXNwaV9jaGVja19idXN3aWR0aChvcC0+ZHVtbXkuYnVzd2lkdGgpOw0KPiA+Pj4gKw0KPiA+Pj4g
KwlpZiAob3AtPmRhdGEubmJ5dGVzKQ0KPiA+Pj4gKwkJcmV0IHw9IHp5bnFfcXNwaV9jaGVja19i
dXN3aWR0aChvcC0+ZGF0YS5idXN3aWR0aCk7DQo+ID4+PiArDQo+ID4+PiArCWlmIChyZXQpDQo+
ID4+PiArCQlyZXR1cm4gZmFsc2U7DQo+ID4+PiArDQo+ID4+IHNwaV9tZW1fZGVmYXVsdF9zdXBw
b3J0c19vcCgpIGFscmVhZHkgaGFzIHRoaXMgY29kZS4NCj4gPj4gQ291bGQgeW91IGNoYW5nZSwg
c3BpX21lbV9zdXBwb3J0c19vcCgpIHRvIGNhbGwNCj4gPj4gc3BpX21lbV9kZWZhdWx0X3N1cHBv
cnRzX29wKCkgZmlyc3QgYmVmb3JlIGNvbnRyb2xsZXIgc3BlY2lmaWMNCj4gPj4gLT5zdXBwb3J0
c19vcCgpPyBTbyB0aGF0LCBhYm92ZSBjb2RlIGNhbiBiZSBkcm9wcGVkLg0KPiA+IE9rLCBJIHdp
bGwgdXBkYXRlIGl0Lg0KPiA+Pj4gKwkvKg0KPiA+Pj4gKwkgKiBUaGUgbnVtYmVyIG9mIGFkZHJl
c3MgYnl0ZXMgc2hvdWxkIGJlIGVxdWFsIHRvIG9yIGxlc3MgdGhhbiAzIGJ5dGVzLg0KPiA+Pj4g
KwkgKi8NCj4gPj4+ICsJaWYgKG9wLT5hZGRyLm5ieXRlcyA+IDMpDQo+ID4+PiArCQlyZXR1cm4g
ZmFsc2U7DQo+ID4+PiArDQo+ID4+IEhtbSwgaG93IGRvZXMgdGhlIGRyaXZlciBoYW5kbGUgZmxh
c2ggZGV2aWNlcyA+MTZNQiBpbiBzaXplPyBOb3Qgc3VwcG9ydGVkPw0KPiA+IFp5bnEgUVNQSSBj
b250cm9sbGVyIGRvZXNuJ3Qgc3VwcG9ydCA0IGJ5dGUgYWRkcmVzc2luZy4NCj4gPiBTbyB0byBz
dXBwb3J0ID4gMTZNQiBzaXplLCB3ZSBoYXZlIHRvIHVzZSBFQVIoZXh0ZW5kZWQgYWRkcmVzcyBy
ZWdpc3RlcikuDQo+ID4gQXMgaXQgaXMgaW5pdGlhbCB2ZXJzaW9uIG9mIGRyaXZlciwgSSBoYXZl
bid0IGFkZGVkIHRoaXMgY29kZS4gVGhpcyBuZWVkcyB0byBiZSBhZGRlZCBpbiBzcGktbm9yLmMu
DQo+ID4gUHJldmlvdXNseSBJIGhhdmUgc2VudCBhbiBSRkMgcGF0Y2ggdG8gc3VwcG9ydCBhbGwg
dGhlc2UuDQo+ID4gQnV0IEJvcmlzIHN1Z2dlc3RlZCB0byB1cHN0cmVhbSB0aGUgYmFzaWMgb25l
IGZpcnN0IHVuZGVyIHNwaS1tZW0gZnJhbWUgd29yay4NCj4gPiBOb3Qgb25seSB0aGlzIHN1cHBv
cnQsIHRoZXJlIGFyZSBvdGhlciBmZWF0dXJlcyBsaWtlIGR1YWwgcGFyYWxsZWwgYW5kIGR1YWwg
c3RhY2tlZC4NCj4gPiBBbGwgdGhlc2UgZmVhdHVyZXMgcmVxdWlyZSBhZGRpdGlvbmFsIHN1cHBv
cnQgZnJvbSBzcGktbm9yIGZyYW1ld29yay4NCj4gPiBXZSBoYXZlIGFub3RoZXIgUVNQSSBjb250
cm9sbGVyIG9uIFp5bnFNUCBTT0MsIHdoaWNoIGlzIGFsc28gc2ltaWxhcihidXQgaXQgc3VwcG9y
dHMNCj4gNEJ5dGUgYWRkcmVzc2luZykuDQo+ID4gU28gYnkgY29uc29saWRhdGluZyBhbGwgdGhl
c2UsIEkgc2VudCB0aGlzIHBhdGNoLg0KPiA+DQo+ID4gUGxlYXNlIGxldCBtZSBrbm93IHlvdXIg
c3VnZ2VzdGlvbiBvbiB0aGlzLg0KPiANCj4gU291bmRzIGZpbmUgdG8gbWUuIFN1cHBvcnQgZm9y
ID4gMTZNQiBmbGFzaCB1c2luZyBFQVIgY2FuIGNvbWUgbGF0ZXIuDQpUaGFua3MuDQpTaGFsbCBJ
IHdhaXQgZm9yIG90aGVycyB0byByZXZpZXcgb3IgZ28gYWhlYWQgYnkgYWRkcmVzc2luZyB5b3Vy
IHByZXZpb3VzIGNvbW1lbnRzPw0KDQpUaGFua3MsDQpOYWdhIFN1cmVzaGt1bWFyIFJlbGxpDQo+
IA0KPiAtLQ0KPiBSZWdhcmRzDQo+IFZpZ25lc2gNCg==
