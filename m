Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 240E7C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 04:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8DD42073F
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 04:43:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="XoWHmMXt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727318AbfITEm7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 00:42:59 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:54168 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726395AbfITEm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 00:42:58 -0400
Received-SPF: Pass (esa5.microchip.iphmx.com: domain of
  Tudor.Ambarus@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa5.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="Tudor.Ambarus@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa5.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa5.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa5.microchip.iphmx.com; spf=Pass smtp.mailfrom=Tudor.Ambarus@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: LIxxENpqWuRWV43cAx0uoDz5mVGs9Qcvo24Xv5fVpHCyhs816mZZMnpyFbonrNdgnfYoZSsI66
 20TlCBGLM/ouO07OHao1jAZ2d5xK4gGYAlc5d8CT7WTkaEp0lERbtitnxO9MVUP/Q+RykKZdUu
 SkARdvOwQRmxCRBM5Z+sHMOoxpDrGSLjbRMQkiQwXTqrWzp8qtKlMy0wwn+0SnX45GrkzzELZI
 d9gkbJThL1NhTAUPRlVtukfLxinkKYdqUlFcFEuyknV3Jjx9W+9QejNMUUQQotWJ7MYUg5KY1T
 NH0=
X-IronPort-AV: E=Sophos;i="5.64,527,1559545200"; 
   d="scan'208";a="48273344"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 Sep 2019 21:42:58 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 19 Sep 2019 21:42:56 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 19 Sep 2019 21:42:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i14/oZzAakvJPQVISzhZkpkQQ0SeZ+am45W2V/62/2rVvKHLTsoOwOCQq81GZn2OGqSjQDAAWj2tAjCeJvxuPb3y8eEWOblsLFBk6p4MU+eXydFYVTYnGfIR8qczGFgzRjqL7g3PmbQYVevudr7YLg/e1yLQDMrN03zP3T3AcU1SDHbVs/spg90ovRPgOzUA1O2BuoWbkPRCqbzKIaYrXXjltd+Gf40INencjc4/yPWNzKC1rckbfefyz/aDcWiWkq11Yd86/AUO/ugl07Bn/hNgj/gkeIJ9c6BeJQpMFGP7hhbRi5X9p0I/I5Y+jYwp0Tz+PTEC/A97RdwCwxOVdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1tQNxPEKjrYCnvC0Yrn3RhSnDeBBw6x4Bx5j2FIqAFA=;
 b=RBflWBL1H+TOYPIYw/PINzABAjymvjrntyVxmhuw99J6X2FQP29lobeEL74IAHOh3gnBc5vVRxTtsmi0+ojnmVv46fZ3q0LNAqwzaP4UDUMM5uLdqcnnoJnFNEKYfTWvW3gQl4VwFA91dR0tN8VHEXI2WjwqcfsPvkN46YheFHTcPWObXWxBnvvPj+TVvhZiZnVXqcjsyWQYGUMCXHdGXDkJwlSG/FKhFZHX8IZm1xL5fgDyIBAT6q2aG/tPjexcsf0KHPe++KRxUb/5ffseixGPaKJdllbXI48dXxbnG5ViOZBFh098cz/4xG2zsaT4nhpVDiUEHYq1Ixtknt9IIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1tQNxPEKjrYCnvC0Yrn3RhSnDeBBw6x4Bx5j2FIqAFA=;
 b=XoWHmMXtFUfPMGr3I51GKV+8GhgdBWMmpmShsbhCfnkd2tfOdA3N670v6lVp9JbEXVt5WYgDPuH4oLHYolDg7mqPwVlsYp3292GByGAlD3xkMVShDRVbsxsWySvrocxmWCvqTklnxZAlXluQJqRvAgWjFZGXk5bWPbKOxFo2CUY=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB3695.namprd11.prod.outlook.com (20.178.252.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.19; Fri, 20 Sep 2019 04:42:55 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c951:b15a:e4b3:30f7]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c951:b15a:e4b3:30f7%7]) with mapi id 15.20.2263.023; Fri, 20 Sep 2019
 04:42:55 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <vigneshr@ti.com>, <boris.brezillon@collabora.com>,
        <marek.vasut@gmail.com>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <linux-mtd@lists.infradead.org>
CC:     <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <joel@jms.id.au>, <andrew@aj.id.au>, <matthias.bgg@gmail.com>,
        <vz@mleia.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH 19/23] mtd: spi-nor: Rework
 spansion(_no)_read_cr_quad_enable()
Thread-Topic: [PATCH 19/23] mtd: spi-nor: Rework
 spansion(_no)_read_cr_quad_enable()
Thread-Index: AQHVbXBbffKexv8yJ0aKaPhVIe5RwqczRgmAgAC6x4A=
Date:   Fri, 20 Sep 2019 04:42:55 +0000
Message-ID: <9aa3cc95-33f1-74b5-d739-d4e7ef92d242@microchip.com>
References: <20190917155426.7432-1-tudor.ambarus@microchip.com>
 <20190917155426.7432-20-tudor.ambarus@microchip.com>
 <f811a9a6-4b88-e017-5cc6-ad758edbcab3@ti.com>
In-Reply-To: <f811a9a6-4b88-e017-5cc6-ad758edbcab3@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0901CA0085.eurprd09.prod.outlook.com
 (2603:10a6:800:7e::11) To MN2PR11MB4448.namprd11.prod.outlook.com
 (2603:10b6:208:193::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c5ba3ef4-8ed8-4cff-6be9-08d73d8500a8
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR11MB3695;
x-ms-traffictypediagnostic: MN2PR11MB3695:
x-microsoft-antispam-prvs: <MN2PR11MB36952425A353A9878BB3E73EF0880@MN2PR11MB3695.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0166B75B74
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(136003)(376002)(346002)(396003)(199004)(189003)(36756003)(110136005)(8936002)(54906003)(81166006)(4326008)(76176011)(81156014)(8676002)(446003)(11346002)(2906002)(5660300002)(478600001)(99286004)(229853002)(186003)(256004)(71190400001)(71200400001)(31686004)(2201001)(6116002)(316002)(31696002)(386003)(53546011)(86362001)(2501003)(305945005)(66556008)(66066001)(6486002)(7736002)(6246003)(102836004)(66946007)(25786009)(3846002)(66476007)(476003)(486006)(52116002)(26005)(14454004)(6506007)(66446008)(2616005)(6512007)(64756008)(7416002)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3695;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: lpHRKGhtAGQ+DmkK9SrwEeEz3Dw7UEoBgfpQg1fNb1BRljd4dN7VsmMdaB8iaqJogaxSZC3zgvwnESMxhlu6dSChOHwwg4lflScMd+RjIYYAmifFwf8nLKkr74PtYNwZdHKjszdCcv6VwdTfE1A5/Kl9vXb/csX02Dd1QPsHZ0QNCmt/zTO1C0KNb8u9tBs5eopilNzC1Ed/b2LJXPwsYgkVy0BwWIWmW1/VzPTACR5Rj2/wvzr8erIzE1qiugCHBiTBexsswYR7KfAYh4gH2kYDmJNWTr87ihXTDbrcqpv6XFxZlYVBy+39Me1NA3yqpuo1zY5XB+tnXhWcamrW3D7x/30iuKfK4WwqikgTACNDqAfEREVCVvshNJNvz7p5je8JFR9kgV13x6AB1D7f5MhLUyj/aSAlG3l1Z9opkps=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <24E54A8CF30EF742803303509F7A70A7@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c5ba3ef4-8ed8-4cff-6be9-08d73d8500a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2019 04:42:55.0634
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5uij9KwNbeFPEATt+34zvL7td4y5VVodem5GHTS6aGMexI6mk3Pq/LCemIyOm6eemDLikwTwwAf2tAz0LTzVGdHF0PWIJ52C5PqUl4iqzPk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3695
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDA5LzE5LzIwMTkgMDg6MzQgUE0sIFZpZ25lc2ggUmFnaGF2ZW5kcmEgd3JvdGU6DQo+
IA0KPiANCj4gT24gMTctU2VwLTE5IDk6MjUgUE0sIFR1ZG9yLkFtYmFydXNAbWljcm9jaGlwLmNv
bSB3cm90ZToNCj4+IEZyb206IFR1ZG9yIEFtYmFydXMgPHR1ZG9yLmFtYmFydXNAbWljcm9jaGlw
LmNvbT4NCj4+DQo+PiBNZXJnZToNCj4+IHNwYW5zaW9uX25vX3JlYWRfY3JfcXVhZF9lbmFibGUo
KQ0KPj4gc3BhbnNpb25fcmVhZF9jcl9xdWFkX2VuYWJsZSgpDQo+Pg0KPj4gaW4gc3BpX25vcl9z
cjJfYml0MV9xdWFkX2VuYWJsZSgpLg0KPj4NCj4+IEF2b2lkIGR1cGxpY2F0aW9uIG9mIGNvZGUg
YnkgdXNpbmcgc3BpX25vcl93cml0ZV8xNmJpdF9zcl9hbmRfY2hlY2soKSwNCj4+IHRoZSBTTk9S
X0ZfTk9fUkVBRF9DUiBjYXNlIGlzIHRyZWF0ZWQgdGhlcmUuDQo+Pg0KPj4gV2Ugbm93IGRvIHRo
ZSBSZWFkIEJhY2sgdGVzdCBldmVuIGZvciB0aGUgb2xkDQo+PiBzcGFuc2lvbl9ub19yZWFkX2Ny
X3F1YWRfZW5hYmxlKCkgY2FzZS4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBUdWRvciBBbWJhcnVz
IDx0dWRvci5hbWJhcnVzQG1pY3JvY2hpcC5jb20+DQo+PiAtLS0NCj4+ICBkcml2ZXJzL210ZC9z
cGktbm9yL3NwaS1ub3IuYyB8IDg5ICsrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0NCj4+ICBpbmNsdWRlL2xpbnV4L210ZC9zcGktbm9yLmggICB8ICA0ICstDQo+PiAg
MiBmaWxlcyBjaGFuZ2VkLCAyMiBpbnNlcnRpb25zKCspLCA3MSBkZWxldGlvbnMoLSkNCj4+DQo+
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tdGQvc3BpLW5vci9zcGktbm9yLmMgYi9kcml2ZXJzL210
ZC9zcGktbm9yL3NwaS1ub3IuYw0KPj4gaW5kZXggMmY3OTkyM2U3ZGI1Li44NjQ4NjY2ZmI5YmQg
MTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL210ZC9zcGktbm9yL3NwaS1ub3IuYw0KPj4gKysrIGIv
ZHJpdmVycy9tdGQvc3BpLW5vci9zcGktbm9yLmMNCj4+IEBAIC05MDcsNyArOTA3LDcgQEAgc3Rh
dGljIGludCBzcGlfbm9yX3dyaXRlXzE2Yml0X3NyX2FuZF9jaGVjayhzdHJ1Y3Qgc3BpX25vciAq
bm9yLCB1OCBzdGF0dXNfbmV3LA0KPj4gIAkJICogV3JpdGUgU3RhdHVzICgwMWgpIGNvbW1hbmQg
aXMgYXZhaWxhYmxlIGp1c3QgZm9yIHRoZSBjYXNlcw0KPj4gIAkJICogaW4gd2hpY2ggdGhlIFFF
IGJpdCBpcyBkZXNjcmliZWQgaW4gU1IyIGF0IEJJVCgxKS4NCj4+ICAJCSAqLw0KPj4gLQkJc3Jf
Y3JbMV0gPSBDUl9RVUFEX0VOX1NQQU47DQo+PiArCQlzcl9jclsxXSA9IFNSMl9RVUFEX0VOX0JJ
VDE7DQo+PiAgCX0gZWxzZSB7DQo+PiAgCQlzcl9jclsxXSA9IDA7DQo+PiAgCX0NCj4+IEBAIC0x
OTYzLDgxICsxOTYzLDM0IEBAIHN0YXRpYyBpbnQgc3BpX25vcl9zcjFfYml0Nl9xdWFkX2VuYWJs
ZShzdHJ1Y3Qgc3BpX25vciAqbm9yKQ0KPj4gIH0NCj4+ICANCj4+ICAvKioNCj4+IC0gKiBzcGFu
c2lvbl9ub19yZWFkX2NyX3F1YWRfZW5hYmxlKCkgLSBzZXQgUUUgYml0IGluIENvbmZpZ3VyYXRp
b24gUmVnaXN0ZXIuDQo+PiArICogc3BpX25vcl9zcjJfYml0MV9xdWFkX2VuYWJsZSgpIC0gc2V0
IHRoZSBRdWFkIEVuYWJsZSBCSVQoMSkgaW4gdGhlIFN0YXR1cw0KPj4gKyAqIFJlZ2lzdGVyIDIu
DQo+PiAgICogQG5vcjoJcG9pbnRlciB0byBhICdzdHJ1Y3Qgc3BpX25vcicNCj4+ICAgKg0KPj4g
LSAqIFNldCB0aGUgUXVhZCBFbmFibGUgKFFFKSBiaXQgaW4gdGhlIENvbmZpZ3VyYXRpb24gUmVn
aXN0ZXIuDQo+PiAtICogVGhpcyBmdW5jdGlvbiBzaG91bGQgYmUgdXNlZCB3aXRoIFFTUEkgbWVt
b3JpZXMgbm90IHN1cHBvcnRpbmcgdGhlIFJlYWQNCj4+IC0gKiBDb25maWd1cmF0aW9uIFJlZ2lz
dGVyICgzNWgpIGluc3RydWN0aW9uLg0KPj4gLSAqDQo+PiAtICogYml0IDEgb2YgdGhlIENvbmZp
Z3VyYXRpb24gUmVnaXN0ZXIgaXMgdGhlIFFFIGJpdCBmb3IgU3BhbnNpb24gbGlrZSBRU1BJDQo+
PiAtICogbWVtb3JpZXMuDQo+PiAtICoNCj4+IC0gKiBSZXR1cm46IDAgb24gc3VjY2VzcywgLWVy
cm5vIG90aGVyd2lzZS4NCj4+IC0gKi8NCj4+IC1zdGF0aWMgaW50IHNwYW5zaW9uX25vX3JlYWRf
Y3JfcXVhZF9lbmFibGUoc3RydWN0IHNwaV9ub3IgKm5vcikNCj4+IC17DQo+PiAtCXU4ICpzcl9j
ciA9IG5vci0+Ym91bmNlYnVmOw0KPj4gLQlpbnQgcmV0Ow0KPj4gLQ0KPj4gLQkvKiBLZWVwIHRo
ZSBjdXJyZW50IHZhbHVlIG9mIHRoZSBTdGF0dXMgUmVnaXN0ZXIuICovDQo+PiAtCXJldCA9IHNw
aV9ub3JfcmVhZF9zcihub3IsICZzcl9jclswXSk7DQo+PiAtCWlmIChyZXQpDQo+PiAtCQlyZXR1
cm4gcmV0Ow0KPj4gLQ0KPj4gLQlzcl9jclsxXSA9IENSX1FVQURfRU5fU1BBTjsNCj4+IC0NCj4+
IC0JcmV0dXJuIHNwaV9ub3Jfd3JpdGVfc3Iobm9yLCBzcl9jciwgMik7DQo+PiAtfQ0KPj4gLQ0K
Pj4gLS8qKg0KPj4gLSAqIHNwYW5zaW9uX3JlYWRfY3JfcXVhZF9lbmFibGUoKSAtIHNldCBRRSBi
aXQgaW4gQ29uZmlndXJhdGlvbiBSZWdpc3Rlci4NCj4+IC0gKiBAbm9yOglwb2ludGVyIHRvIGEg
J3N0cnVjdCBzcGlfbm9yJw0KPj4gLSAqDQo+PiAtICogU2V0IHRoZSBRdWFkIEVuYWJsZSAoUUUp
IGJpdCBpbiB0aGUgQ29uZmlndXJhdGlvbiBSZWdpc3Rlci4NCj4+IC0gKiBUaGlzIGZ1bmN0aW9u
IHNob3VsZCBiZSB1c2VkIHdpdGggUVNQSSBtZW1vcmllcyBzdXBwb3J0aW5nIHRoZSBSZWFkDQo+
PiAtICogQ29uZmlndXJhdGlvbiBSZWdpc3RlciAoMzVoKSBpbnN0cnVjdGlvbi4NCj4+IC0gKg0K
Pj4gLSAqIGJpdCAxIG9mIHRoZSBDb25maWd1cmF0aW9uIFJlZ2lzdGVyIGlzIHRoZSBRRSBiaXQg
Zm9yIFNwYW5zaW9uIGxpa2UgUVNQSQ0KPj4gLSAqIG1lbW9yaWVzLg0KPj4gKyAqIEJpdCAxIG9m
IHRoZSBTdGF0dXMgUmVnaXN0ZXIgMiBpcyB0aGUgUUUgYml0IGZvciBTcGFuc2lvbiBsaWtlIFFT
UEkgbWVtb3JpZXMuDQo+PiAgICoNCj4+ICAgKiBSZXR1cm46IDAgb24gc3VjY2VzcywgLWVycm5v
IG90aGVyd2lzZS4NCj4+ICAgKi8NCj4+IC1zdGF0aWMgaW50IHNwYW5zaW9uX3JlYWRfY3JfcXVh
ZF9lbmFibGUoc3RydWN0IHNwaV9ub3IgKm5vcikNCj4+ICtzdGF0aWMgaW50IHNwaV9ub3Jfc3Iy
X2JpdDFfcXVhZF9lbmFibGUoc3RydWN0IHNwaV9ub3IgKm5vcikNCj4+ICB7DQo+PiAtCXU4ICpz
cl9jciA9IG5vci0+Ym91bmNlYnVmOw0KPj4gIAlpbnQgcmV0Ow0KPj4gIA0KPj4gLQkvKiBDaGVj
ayBjdXJyZW50IFF1YWQgRW5hYmxlIGJpdCB2YWx1ZS4gKi8NCj4+IC0JcmV0ID0gc3BpX25vcl9y
ZWFkX2NyKG5vciwgJnNyX2NyWzFdKTsNCj4+IC0JaWYgKHJldCkNCj4+IC0JCXJldHVybiByZXQ7
DQo+PiAtDQo+PiAtCWlmIChzcl9jclsxXSAmIENSX1FVQURfRU5fU1BBTikNCj4+IC0JCXJldHVy
biAwOw0KPj4gKwlpZiAoIShub3ItPmZsYWdzICYgU05PUl9GX05PX1JFQURfQ1IpKSB7DQo+PiAr
CQkvKiBDaGVjayBjdXJyZW50IFF1YWQgRW5hYmxlIGJpdCB2YWx1ZS4gKi8NCj4+ICsJCXJldCA9
IHNwaV9ub3JfcmVhZF9jcihub3IsICZub3ItPmJvdW5jZWJ1ZlswXSk7DQo+PiArCQlpZiAocmV0
KQ0KPj4gKwkJCXJldHVybiByZXQ7DQo+PiAgDQo+PiAtCXNyX2NyWzFdIHw9IENSX1FVQURfRU5f
U1BBTjsNCj4+ICsJCWlmIChub3ItPmJvdW5jZWJ1ZlswXSAmIFNSMl9RVUFEX0VOX0JJVDEpDQo+
PiArCQkJcmV0dXJuIDA7DQo+PiArCX0NCj4+ICANCj4+ICAJLyogS2VlcCB0aGUgY3VycmVudCB2
YWx1ZSBvZiB0aGUgU3RhdHVzIFJlZ2lzdGVyLiAqLw0KPj4gLQlyZXQgPSBzcGlfbm9yX3JlYWRf
c3Iobm9yLCAmc3JfY3JbMF0pOw0KPj4gLQlpZiAocmV0KQ0KPj4gLQkJcmV0dXJuIHJldDsNCj4+
IC0NCj4+IC0JcmV0ID0gc3BpX25vcl93cml0ZV9zcihub3IsIHNyX2NyLCAyKTsNCj4+IC0JaWYg
KHJldCkNCj4+IC0JCXJldHVybiByZXQ7DQo+PiAtDQo+PiAtCS8qIFJlYWQgYmFjayBhbmQgY2hl
Y2sgaXQuICovDQo+PiAtCXJldCA9IHNwaV9ub3JfcmVhZF9jcihub3IsICZzcl9jclsxXSk7DQo+
PiArCXJldCA9IHNwaV9ub3JfcmVhZF9zcihub3IsICZub3ItPmJvdW5jZWJ1ZlswXSk7DQo+PiAg
CWlmIChyZXQpDQo+PiAgCQlyZXR1cm4gcmV0Ow0KPj4gIA0KPj4gLQlpZiAoIShzcl9jclsxXSAm
IENSX1FVQURfRU5fU1BBTikpIHsNCj4+IC0JCWRldl9lcnIobm9yLT5kZXYsICJTcGFuc2lvbiBR
dWFkIGJpdCBub3Qgc2V0XG4iKTsNCj4+IC0JCXJldHVybiAtRUlPOw0KPj4gLQl9DQo+PiAtDQo+
PiAtCXJldHVybiAwOw0KPiANCj4gWW91IG5lZWQgdG8gc2V0IFFFIGJpdCBoZXJlIGJlZm9yZSB3
cml0aW5nIHRvIENSIHJlZ2lzdGVyLiBUaGlzIGZ1bmN0aW9uDQo+IGRvZXMgbm90IGRvIHRoYXQu
Pg0KPj4gKwlyZXR1cm4gc3BpX25vcl93cml0ZV8xNmJpdF9zcl9hbmRfY2hlY2sobm9yLCBub3It
PmJvdW5jZWJ1ZlswXSwgMHhGRik7Pg0KPiBOZWl0aGVyIGRvZXMgc3BpX25vcl93cml0ZV8xNmJp
dF9zcl9hbmRfY2hlY2soKS4NCg0KcGZmLCB5b3UncmUgcmlnaHQsIEkgdGhvdWdodCBJIGRpZCBz
ZXQgaXQgaW4gc3BpX25vcl93cml0ZV8xNmJpdF9zcl9hbmRfY2hlY2soKSwNCmJ1dCBpbiBzcGlf
bm9yX3dyaXRlXzE2Yml0X3NyX2FuZF9jaGVjaygpIEkganVzdCByZWFkIHRoZSBDUiwgd2l0aG91
dCBzZXR0aW5nDQp0aGUgUUUgYml0LiBXaWxsIHJlc3BpbiB0aGUgZW50aXJlIHNlcmllcywgdGhh
bmtzIGZvciBjYXRjaGluZyB0aGlzIQ0KDQo+IFdlIG5lZWQgYSBmdW5jdGlvbiB0aGF0IGFsbG93
cyB0byBtb2RpZnkgU1IyL0NSIHJlZ2lzdGVyIGNvbnRlbnQgYXMgd2VsbA0KPiBzbyBhcyB0byBz
ZXQgUUUgYml0IHJpZ2h0Pw0KPiANCj4gUmVnYXJkcw0KPiBWaWduZXNoDQo+IA0KPj4gIH0NCj4+
ICANCj4+ICAvKioNCj4+IEBAIC0yMTE3LDcgKzIwNzAsNyBAQCBzdGF0aWMgaW50IHNwaV9ub3Jf
Y2xlYXJfc3JfYnAoc3RydWN0IHNwaV9ub3IgKm5vcikNCj4+ICAgKg0KPj4gICAqIFJlYWQtbW9k
aWZ5LXdyaXRlIGZ1bmN0aW9uIHRoYXQgY2xlYXJzIHRoZSBCbG9jayBQcm90ZWN0aW9uIGJpdHMg
ZnJvbSB0aGUNCj4+ICAgKiBTdGF0dXMgUmVnaXN0ZXIgd2l0aG91dCBhZmZlY3Rpbmcgb3RoZXIg
Yml0cy4gVGhlIGZ1bmN0aW9uIGlzIHRpZ2h0bHkNCj4+IC0gKiBjb3VwbGVkIHdpdGggdGhlIHNw
YW5zaW9uX3JlYWRfY3JfcXVhZF9lbmFibGUoKSBmdW5jdGlvbi4gQm90aCBhc3N1bWUgdGhhdA0K
Pj4gKyAqIGNvdXBsZWQgd2l0aCB0aGUgc3BpX25vcl9zcjJfYml0MV9xdWFkX2VuYWJsZSgpIGZ1
bmN0aW9uLiBCb3RoIGFzc3VtZSB0aGF0DQo+PiAgICogdGhlIFdyaXRlIFJlZ2lzdGVyIHdpdGgg
MTYgYml0cywgdG9nZXRoZXIgd2l0aCB0aGUgUmVhZCBDb25maWd1cmF0aW9uDQo+PiAgICogUmVn
aXN0ZXIgKDM1aCkgaW5zdHJ1Y3Rpb25zIGFyZSBzdXBwb3J0ZWQuDQo+PiAgICoNCj4+IEBAIC0y
MTM4LDcgKzIwOTEsNyBAQCBzdGF0aWMgaW50IHNwaV9ub3Jfc3BhbnNpb25fY2xlYXJfc3JfYnAo
c3RydWN0IHNwaV9ub3IgKm5vcikNCj4+ICAJICogV2hlbiB0aGUgY29uZmlndXJhdGlvbiByZWdp
c3RlciBRdWFkIEVuYWJsZSBiaXQgaXMgb25lLCBvbmx5IHRoZQ0KPj4gIAkgKiBXcml0ZSBTdGF0
dXMgKDAxaCkgY29tbWFuZCB3aXRoIHR3byBkYXRhIGJ5dGVzIG1heSBiZSB1c2VkLg0KPj4gIAkg
Ki8NCj4+IC0JaWYgKHNyX2NyWzFdICYgQ1JfUVVBRF9FTl9TUEFOKSB7DQo+PiArCWlmIChzcl9j
clsxXSAmIFNSMl9RVUFEX0VOX0JJVDEpIHsNCj4+ICAJCXJldCA9IHNwaV9ub3JfcmVhZF9zcihu
b3IsICZzcl9jclswXSk7DQo+PiAgCQlpZiAocmV0KQ0KPj4gIAkJCXJldHVybiByZXQ7DQo+PiBA
QCAtMzY0Miw3ICszNTk1LDcgQEAgc3RhdGljIGludCBzcGlfbm9yX3BhcnNlX2JmcHQoc3RydWN0
IHNwaV9ub3IgKm5vciwNCj4+ICAJCSAqIHN1cHBvcnRlZC4NCj4+ICAJCSAqLw0KPj4gIAkJbm9y
LT5mbGFncyB8PSBTTk9SX0ZfTk9fUkVBRF9DUjsNCj4+IC0JCWZsYXNoLT5xdWFkX2VuYWJsZSA9
IHNwYW5zaW9uX25vX3JlYWRfY3JfcXVhZF9lbmFibGU7DQo+PiArCQlmbGFzaC0+cXVhZF9lbmFi
bGUgPSBzcGlfbm9yX3NyMl9iaXQxX3F1YWRfZW5hYmxlOw0KPj4gIAkJYnJlYWs7DQo+PiAgDQo+
PiAgCWNhc2UgQkZQVF9EV09SRDE1X1FFUl9TUjFfQklUNjoNCj4+IEBAIC0zNjYzLDcgKzM2MTYs
NyBAQCBzdGF0aWMgaW50IHNwaV9ub3JfcGFyc2VfYmZwdChzdHJ1Y3Qgc3BpX25vciAqbm9yLA0K
Pj4gIAkJICogYXNzdW1wdGlvbiBvZiBhIDE2LWJpdCBXcml0ZSBTdGF0dXMgKDAxaCkgY29tbWFu
ZC4NCj4+ICAJCSAqLw0KPj4gIAkJbm9yLT5mbGFncyB8PSBTTk9SX0ZfSEFTXzE2QklUX1NSOw0K
Pj4gLQkJZmxhc2gtPnF1YWRfZW5hYmxlID0gc3BhbnNpb25fcmVhZF9jcl9xdWFkX2VuYWJsZTsN
Cj4+ICsJCWZsYXNoLT5xdWFkX2VuYWJsZSA9IHNwaV9ub3Jfc3IyX2JpdDFfcXVhZF9lbmFibGU7
DQo+PiAgCQlicmVhazsNCj4+ICANCj4+ICAJZGVmYXVsdDoNCj4+IEBAIC00NjI2LDcgKzQ1Nzks
NyBAQCBzdGF0aWMgdm9pZCBzcGlfbm9yX2luZm9faW5pdF9mbGFzaF9wYXJhbXMoc3RydWN0IHNw
aV9ub3IgKm5vcikNCj4+ICAJdTggaSwgZXJhc2VfbWFzazsNCj4+ICANCj4+ICAJLyogSW5pdGlh
bGl6ZSBsZWdhY3kgZmxhc2ggcGFyYW1ldGVycyBhbmQgc2V0dGluZ3MuICovDQo+PiAtCWZsYXNo
LT5xdWFkX2VuYWJsZSA9IHNwYW5zaW9uX3JlYWRfY3JfcXVhZF9lbmFibGU7DQo+PiArCWZsYXNo
LT5xdWFkX2VuYWJsZSA9IHNwaV9ub3Jfc3IyX2JpdDFfcXVhZF9lbmFibGU7DQo+PiAgCWZsYXNo
LT5zZXRfNGJ5dGUgPSBzcGFuc2lvbl9zZXRfNGJ5dGU7DQo+PiAgCWZsYXNoLT5zZXR1cCA9IHNw
aV9ub3JfZGVmYXVsdF9zZXR1cDsNCj4+ICAJLyogRGVmYXVsdCB0byAxNi1iaXQgV3JpdGUgU3Rh
dHVzICgwMWgpIENvbW1hbmQgKi8NCj4+IEBAIC00ODQ0LDcgKzQ3OTcsNyBAQCBzdGF0aWMgaW50
IHNwaV9ub3JfaW5pdChzdHJ1Y3Qgc3BpX25vciAqbm9yKQ0KPj4gIAlpbnQgZXJyOw0KPj4gIA0K
Pj4gIAlpZiAobm9yLT5jbGVhcl9zcl9icCkgew0KPj4gLQkJaWYgKG5vci0+Zmxhc2gucXVhZF9l
bmFibGUgPT0gc3BhbnNpb25fcmVhZF9jcl9xdWFkX2VuYWJsZSkNCj4+ICsJCWlmIChub3ItPmZs
YXNoLnF1YWRfZW5hYmxlID09IHNwaV9ub3Jfc3IyX2JpdDFfcXVhZF9lbmFibGUpDQo+PiAgCQkJ
bm9yLT5jbGVhcl9zcl9icCA9IHNwaV9ub3Jfc3BhbnNpb25fY2xlYXJfc3JfYnA7DQo+PiAgDQo+
PiAgCQllcnIgPSBub3ItPmNsZWFyX3NyX2JwKG5vcik7DQo+PiBkaWZmIC0tZ2l0IGEvaW5jbHVk
ZS9saW51eC9tdGQvc3BpLW5vci5oIGIvaW5jbHVkZS9saW51eC9tdGQvc3BpLW5vci5oDQo+PiBp
bmRleCAzYTgzNWRlOTBiNmEuLjU1OTBhMzZlYjQzZSAxMDA2NDQNCj4+IC0tLSBhL2luY2x1ZGUv
bGludXgvbXRkL3NwaS1ub3IuaA0KPj4gKysrIGIvaW5jbHVkZS9saW51eC9tdGQvc3BpLW5vci5o
DQo+PiBAQCAtMTQ0LDEwICsxNDQsOCBAQA0KPj4gICNkZWZpbmUgRlNSX1BfRVJSCQlCSVQoNCkJ
LyogUHJvZ3JhbSBvcGVyYXRpb24gc3RhdHVzICovDQo+PiAgI2RlZmluZSBGU1JfUFRfRVJSCQlC
SVQoMSkJLyogUHJvdGVjdGlvbiBlcnJvciBiaXQgKi8NCj4+ICANCj4+IC0vKiBDb25maWd1cmF0
aW9uIFJlZ2lzdGVyIGJpdHMuICovDQo+PiAtI2RlZmluZSBDUl9RVUFEX0VOX1NQQU4JCUJJVCgx
KQkvKiBTcGFuc2lvbiBRdWFkIEkvTyAqLw0KPj4gLQ0KPj4gIC8qIFN0YXR1cyBSZWdpc3RlciAy
IGJpdHMuICovDQo+PiArI2RlZmluZSBTUjJfUVVBRF9FTl9CSVQxCUJJVCgxKQ0KPj4gICNkZWZp
bmUgU1IyX1FVQURfRU5fQklUNwlCSVQoNykNCj4+ICANCj4+ICAvKiBTdXBwb3J0ZWQgU1BJIHBy
b3RvY29scyAqLw0KPj4NCj4gDQo=
