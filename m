Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53FF4CA9ECB
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 14:19:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09B4D20873
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 14:19:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="MiDOc6W4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbfJaOS7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 10:18:59 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:4172 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727549AbfJaOS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 10:18:58 -0400
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
IronPort-SDR: h+J4yDUsxqTWt7hs8JytK2MmfS7UC6tst0eAakfKiYj4/X2Ko94Ch2Eq8+uhCh5aRtBJ1+QeZW
 ohot+H18u/ce9WPdIsT8XrinypN2cSMpG5u4tQsSi7h36bZwJ0JceP8WBqwga3fsW7XFj2S9ji
 6p4HsPQ8wJTFo+e/LQAHSyl5TZ16LdGrrpwPnkrJ80FTVUhiZTPe3PvpUqwWGE+RWSiVttIy9K
 1HWBoOOXoovpTd2/p8ehqrqXNbbEp9S6A9HmmqnG08RNxQ93xE88/wtrK1eB989NEXXg32wIl1
 ofs=
X-IronPort-AV: E=Sophos;i="5.68,250,1569308400"; 
   d="scan'208";a="52344538"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 31 Oct 2019 07:18:56 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 31 Oct 2019 07:18:56 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 31 Oct 2019 07:18:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SEEa/h5eqgE0f8fprwb4Jife+HqGTua4QPYBJpTmmt/0SHwwhd++uhj++jZB1+A1U/q7c/8sOQTZnCk0vrIz29mHjEfqsigBFgXolVT4rg/ONfaAxIgAB29jmF7SFANaSfSHADXAEEBmwGjYjiw9/WaTzMS/Vv6EK3H3KGINUOB6MxD+eKe0Af1hNny0JDSr3/GmIdIPprS6HLuJjjMCJl42y+bs5rsHnDg89K4hKB6YMVGdBuKmtaOhbR7NHgKmi8LMGOkd9nn2cJq7jh4LTZChJixOAqidom1NdvMJ63FwWAGwaCcQOuUfowgG2QJq4704ti1kFTX7L8k5cua5Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9sfnO/UeJyPRbWxtRqsaUdYkn/ix/kb2Fe87owJDGIk=;
 b=k1NKJM3FTocT4U7DzLKUGjuDpEDRhE5y6mdtJQpRa3oDmmqprjRWABl8UGdpuQkQB2TQTR9xlKUn4aMjEMQq4iuUgisT14Pv4pXtopGC8gEABBowy65CfgfFuAwqiacJ7j0MksUS2qozzKoIfNNKgzApV0iTnPBELy1PbZtwn5YyboN4B7Zo2U5DrcbKTooqxVx/JwUXBRvHVrAvU268/nQBdNyFah7sdIlq09wMt9eWhTYw/wU+vr5U15bj8+t89fRxfwFo+Dyy0paW+v/FpASfjsaADcBhnLEqPtV+NtlqRbwMXQrdDXXhkqf2OLwDuE1MlXj6dk4vwW+GDe1ABQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9sfnO/UeJyPRbWxtRqsaUdYkn/ix/kb2Fe87owJDGIk=;
 b=MiDOc6W4Wq/Zy8JeT4shAVcfuKbrNmmmwHvj5Ozanxy3+69bwZ1cgcY2pxKy53dUe0mqXs6OeFLXD4WI74lchyhEFXbyoAVB/w1G9EQMgpju9qWVUjjzkqaxWgpoorNpyjifRFgGB+rTeUFXVzvch0x3xWdkWS2P39IH5ZWt6Uc=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB4429.namprd11.prod.outlook.com (52.135.37.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.24; Thu, 31 Oct 2019 14:18:55 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c09c:36c8:3301:4457]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c09c:36c8:3301:4457%5]) with mapi id 15.20.2408.018; Thu, 31 Oct 2019
 14:18:55 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <boris.brezillon@collabora.com>
CC:     <richard@nod.at>, <linux-mtd@lists.infradead.org>,
        <vigneshr@ti.com>, <linux-kernel@vger.kernel.org>,
        <miquel.raynal@bootlin.com>
Subject: Re: [PATCH v3 13/32] mtd: spi-nor: Print error messages inside Reg
 Ops methods
Thread-Topic: [PATCH v3 13/32] mtd: spi-nor: Print error messages inside Reg
 Ops methods
Thread-Index: AQHVjkpnjcYY5ylF10iDIRPzQ54Epqd0mZMAgAA2EQA=
Date:   Thu, 31 Oct 2019 14:18:55 +0000
Message-ID: <ff883ecb-104a-72c3-2169-5200bbd45bc6@microchip.com>
References: <20191029111615.3706-1-tudor.ambarus@microchip.com>
 <20191029111615.3706-14-tudor.ambarus@microchip.com>
 <20191031120518.5bac1caa@collabora.com>
In-Reply-To: <20191031120518.5bac1caa@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0501CA0017.eurprd05.prod.outlook.com
 (2603:10a6:800:92::27) To MN2PR11MB4448.namprd11.prod.outlook.com
 (2603:10b6:208:193::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [86.120.239.29]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e177e0b2-67f6-4a86-da7e-08d75e0d4320
x-ms-traffictypediagnostic: MN2PR11MB4429:
x-microsoft-antispam-prvs: <MN2PR11MB442955A70233A3ED756347B3F0630@MN2PR11MB4429.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 02070414A1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(346002)(39860400002)(376002)(396003)(189003)(199004)(5660300002)(2616005)(14444005)(99286004)(4326008)(478600001)(66476007)(66946007)(66556008)(64756008)(66446008)(316002)(2906002)(36756003)(102836004)(15650500001)(11346002)(3846002)(256004)(52116002)(6916009)(6246003)(446003)(6116002)(186003)(476003)(76176011)(229853002)(26005)(71190400001)(31686004)(8676002)(71200400001)(6486002)(25786009)(305945005)(386003)(6506007)(53546011)(7736002)(6436002)(486006)(6512007)(8936002)(81156014)(81166006)(14454004)(66066001)(86362001)(54906003)(31696002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB4429;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YmUUGriqOJJzaAtPOQHqcmPrPxCILa8Ztu9l3ejBV8SVRKxti7wDpb9LRTc8Y4YffjI8cPjek5r+YKy+JjiLYAT7VobAjcs3T+o9wR1e5TAXyAmJPP+T1cRyIdTwTzvSz/oMWhFRNmgfHQHjIV2g7OwY+FhrHRdCy/ElUPX70xRSG4oEkPptHzhijvdqKSw9Qd5HmG2WhMScy3TBQHOBnLnv0gWLbtG4MJFDLLgyzSX5OnSyvZAvceyPDHmzU/9HTLCQHE9KJtg/ddpR27TGF5xus9WfNVnw14QuQRL4U/qxyvHq5PEwcN89qm5XPV8kxMdLo/f1pCnNo7WV0gBnbTqRDqenIA/owBOkMOC4k+Zbw/vp/YT7ArjumBfLs1AgQUUTzqjB0+OM4d23YXFs3R2fVPtwucmvzJLwLUYPvgH7zMdEKnyf2SsyzDy1IaXy
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <55ACB0E5E4CD414ABF8B87655399BDBA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e177e0b2-67f6-4a86-da7e-08d75e0d4320
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2019 14:18:55.2125
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RMAo4U6mnD2q7U3EDcu39fTOn1dpmLxG+wr8PhRUOrcfKPnMH5JFClSFG43y81GRC6R+CuUDT2SS6RdMojLG0RVdLN7sUqDr6QLKtwNsSgY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4429
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDEwLzMxLzIwMTkgMDE6MDUgUE0sIEJvcmlzIEJyZXppbGxvbiB3cm90ZToNCj4gRXh0
ZXJuYWwgRS1NYWlsDQo+IA0KPiANCj4gT24gVHVlLCAyOSBPY3QgMjAxOSAxMToxNzowOSArMDAw
MA0KPiA8VHVkb3IuQW1iYXJ1c0BtaWNyb2NoaXAuY29tPiB3cm90ZToNCj4gDQo+PiBGcm9tOiBU
dWRvciBBbWJhcnVzIDx0dWRvci5hbWJhcnVzQG1pY3JvY2hpcC5jb20+DQo+Pg0KPj4gU3BhcmUg
dGhlIGNhbGxlcnMgb2YgcHJpbnRpbmcgZXJyb3IgbWVzc2FnZXMgYnkgdGhlbXNlbHZlcy4NCj4+
DQo+PiBTaWduZWQtb2ZmLWJ5OiBUdWRvciBBbWJhcnVzIDx0dWRvci5hbWJhcnVzQG1pY3JvY2hp
cC5jb20+DQo+PiAtLS0NCj4+ICBkcml2ZXJzL210ZC9zcGktbm9yL3NwaS1ub3IuYyB8IDE2NSAr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0NCj4+ICAxIGZpbGUgY2hh
bmdlZCwgMTIzIGluc2VydGlvbnMoKyksIDQyIGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL210ZC9zcGktbm9yL3NwaS1ub3IuYyBiL2RyaXZlcnMvbXRkL3NwaS1ub3Iv
c3BpLW5vci5jDQo+PiBpbmRleCBlNWVkOTAxMmNkNTAuLmJjNDZiOTQ2YWM3NyAxMDA2NDQNCj4+
IC0tLSBhL2RyaXZlcnMvbXRkL3NwaS1ub3Ivc3BpLW5vci5jDQo+PiArKysgYi9kcml2ZXJzL210
ZC9zcGktbm9yL3NwaS1ub3IuYw0KPj4gQEAgLTM5NCw2ICszOTQsOCBAQCBzdGF0aWMgc3NpemVf
dCBzcGlfbm9yX3dyaXRlX2RhdGEoc3RydWN0IHNwaV9ub3IgKm5vciwgbG9mZl90IHRvLCBzaXpl
X3QgbGVuLA0KPj4gICAqLw0KPj4gIHN0YXRpYyBpbnQgc3BpX25vcl93cml0ZV9lbmFibGUoc3Ry
dWN0IHNwaV9ub3IgKm5vcikNCj4+ICB7DQo+PiArCWludCByZXQ7DQo+PiArDQo+PiAgCWlmIChu
b3ItPnNwaW1lbSkgew0KPj4gIAkJc3RydWN0IHNwaV9tZW1fb3Agb3AgPQ0KPj4gIAkJCVNQSV9N
RU1fT1AoU1BJX01FTV9PUF9DTUQoU1BJTk9SX09QX1dSRU4sIDEpLA0KPj4gQEAgLTQwMSwxMCAr
NDAzLDE2IEBAIHN0YXRpYyBpbnQgc3BpX25vcl93cml0ZV9lbmFibGUoc3RydWN0IHNwaV9ub3Ig
Km5vcikNCj4+ICAJCQkJICAgU1BJX01FTV9PUF9OT19EVU1NWSwNCj4+ICAJCQkJICAgU1BJX01F
TV9PUF9OT19EQVRBKTsNCj4+ICANCj4+IC0JCXJldHVybiBzcGlfbWVtX2V4ZWNfb3Aobm9yLT5z
cGltZW0sICZvcCk7DQo+PiArCQlyZXQgPSBzcGlfbWVtX2V4ZWNfb3Aobm9yLT5zcGltZW0sICZv
cCk7DQo+PiArCX0gZWxzZSB7DQo+PiArCQlyZXQgPSBub3ItPmNvbnRyb2xsZXJfb3BzLT53cml0
ZV9yZWcobm9yLCBTUElOT1JfT1BfV1JFTiwNCj4+ICsJCQkJCQkgICAgIE5VTEwsIDApOw0KPj4g
IAl9DQo+PiAgDQo+PiAtCXJldHVybiBub3ItPmNvbnRyb2xsZXJfb3BzLT53cml0ZV9yZWcobm9y
LCBTUElOT1JfT1BfV1JFTiwgTlVMTCwgMCk7DQo+PiArCWlmIChyZXQpDQo+PiArCQlkZXZfZXJy
KG5vci0+ZGV2LCAiZXJyb3IgJWQgb24gV3JpdGUgRW5hYmxlXG4iLCByZXQpOw0KPiANCj4gSSB0
aG91Z2h0IHdlIGFncmVlZCBvbiB1c2luZyBkZXZfZXJyX29uY2UoKSBoZXJlIChhcHBsaWVzIHRv
IG90aGVyDQo+IGRldl9lcnIoKSBjYWxscykuIElmIGl0IGZhaWxzIG9uY2UgaXQncyB1bmxpa2Vs
eSB0byBzdWNjZWVkIG9uDQo+IHN1YnNlcXVlbnQgY2FsbHMsIGFuZCBJIGRvbid0IHRoaW5rIHNw
YW1taW5nIHRoZSBrZXJuZWwgbG9ncyBpcyB2ZXJ5DQo+IHVzZWZ1bC4NCj4gDQoNCkkgdXNlZCBk
ZXZfZXJyKCkgYW5kIG5vdCBkZXZfZXJyX29uY2UoKSBiZWNhdXNlIGlmIHNwaV9ub3Jfd3JpdGVf
ZW5hYmxlKCkgZmFpbHMsDQp3ZSBzdG9wIHRoZSBleGVjdXRpb24gYW5kIGp1c3QgcmV0dXJuIHRo
ZSBzcGlfbm9yX3dyaXRlX2VuYWJsZSgpJ3MgZXJyb3IuIFRoZQ0Ka2VybmVsIGxvZ3Mgd2lsbCBu
b3QgYmUgc3BhbW1lZCBiZWNhdXNlIGl0IHdpbGwgYmUganVzdCBhbiBlcnJvciByZXBvcnRlZC4N
Cg0KZGV2X2Vycl9vbmNlKCkgd291bGQgbWFrZSBzZW5zZSBpZiB3ZSBjaGFuZ2UgdGhlIG1ldGhv
ZCdzIHJldHVybiB0eXBlIGZyb20gaW50DQp0byB2b2lkLCBidXQgd2h5IHRvIGlnbm9yZSBwb3Nz
aWJsZSBlcnJvcnMgZnJvbSB3cml0ZSBlbmFibGUvZGlzYWJsZT8NCg0K
