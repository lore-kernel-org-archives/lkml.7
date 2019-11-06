Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B48BC5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 07:08:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 264D9206DF
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 07:08:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="RJKoBNoP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731420AbfKFHID (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 02:08:03 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:33610 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731206AbfKFHIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 02:08:02 -0500
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
IronPort-SDR: 0KHS4T2Cxhabbwr/cjWQxgKjZXDk9eMaA7+2O0mqixCRrt5f2tU+ZPNmgtUp5B4HOpb3dtd2BT
 ttPgqH4r66AcTZNHGcEMXzQiGodI1tqJnI3D/fQUQn1En2UdEnu7rxX/DCzDsxy5z3jVDmOvdt
 pO4uruA2FwvAjtrbUnyqE5wFKL5Kar31Mqgo242a/ZdcnUKOPju1/mKKjvQGQy3upHQDoITJee
 ZkPWzFa68PvoNtyLJheRDneyj8uGdIsexV6Et0NrP40rMPPZEd6AkB6JYvOkYH+H7t0q9npvVD
 GWc=
X-IronPort-AV: E=Sophos;i="5.68,272,1569308400"; 
   d="scan'208";a="53067295"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Nov 2019 00:08:01 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 6 Nov 2019 00:07:22 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 6 Nov 2019 00:07:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VHb9KTY4RAXgszRRXMIfQSjxLP+c1fpLmI+Gi/EuXgm23CJWiqJQ2W/kVp9I3LLrrowJUHvazluoEEWBNYXVPTrTMmovW9lQEq2Dip9S4eepTur4qAVwonZrpGy4TpZtTVSVbe5bwMQP2ywIv4H/JfHxwdFFdabDFfM+tP5dkD1l3lcX/Qygec40B2sEpm2iwb6XV2s/SyiIfGlBFk4MBS0SoTm2aN5nIbM5IFtrAbwQaRHD3DTnKTr/7ZIWTzHioapwd6ESM9YBgMhlFyiiwUwCqGVE2C4f7X/+15MQgNDmjoMS3/qUDHhh+a+E28aYtZqZ+g5eq8SXrhG1oyBbQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YMsaRRGP2+MR/zPfEcRiut6gHr3+Gnnxz97PACCSJOU=;
 b=RO6CaDp8UT4HtqG5Q/Y7/WWJdI8wQ0oPF3B6YThqX8iI7+jK1jxPjxh3cHTETsvOjDdxNCEpyoZqz8H4M83kmnYlwmF0AfNkEkIaG4xLEPNrEOvNtyETRQUCUxBxYewBdcDgXE1Pjq1Khl4cYRSiiBlP6gVBu8cugJOsiXgvr15PsF8nQBFGWXmqU53wvQJG/3kppUvgbMIZG4yom9gORmuP/xPfFSBn7nPadrIx7xJONpVe5A+QerPbBLErCZMu8cSDpGWYtzgDH802fFlHt7DODi11V5Q4Gl23QebNX/h0yowpUk/iMml/SxcQGf18ZW7SrJSA1wYI4vux2j90pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YMsaRRGP2+MR/zPfEcRiut6gHr3+Gnnxz97PACCSJOU=;
 b=RJKoBNoPbsUiUB5uoSDOmHYOhkz0AAUUlTQ/gv1TgCynNSKnFLwjXxKx/qX6ccPJzTelw3k7iK7+mYX5a7AJ0zaAvpVn0w7oEjcmPLzpDjY1UojXwI9MFhP1gy80CP8yfG/H9KHMNgPVuD7P6mw4lHBVAt+Rut6f/TTe1bTgoFI=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB3839.namprd11.prod.outlook.com (20.178.254.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Wed, 6 Nov 2019 07:07:21 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c09c:36c8:3301:4457]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c09c:36c8:3301:4457%5]) with mapi id 15.20.2408.024; Wed, 6 Nov 2019
 07:07:21 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <vigneshr@ti.com>, <boris.brezillon@collabora.com>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 01/20] mtd: spi-nor: Use dev_dbg insted of dev_err for
 low level info
Thread-Topic: [PATCH v4 01/20] mtd: spi-nor: Use dev_dbg insted of dev_err for
 low level info
Thread-Index: AQHVkW/xBgAv7ThozEyzMFjaioqIiKd8gdYAgAE86QA=
Date:   Wed, 6 Nov 2019 07:07:21 +0000
Message-ID: <baac5e0e-4e85-8a88-b8e5-43bd644de7c8@microchip.com>
References: <20191102112316.20715-1-tudor.ambarus@microchip.com>
 <20191102112316.20715-2-tudor.ambarus@microchip.com>
 <bc98d845-1994-69a8-a655-81ba1bb9253f@ti.com>
In-Reply-To: <bc98d845-1994-69a8-a655-81ba1bb9253f@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0902CA0057.eurprd09.prod.outlook.com
 (2603:10a6:802:1::46) To MN2PR11MB4448.namprd11.prod.outlook.com
 (2603:10b6:208:193::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [86.120.239.29]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9ac96868-ab16-489b-0c27-08d76287f790
x-ms-traffictypediagnostic: MN2PR11MB3839:
x-microsoft-antispam-prvs: <MN2PR11MB3839AE5ECCA0020338618ABBF0790@MN2PR11MB3839.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 02135EB356
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(396003)(136003)(346002)(376002)(199004)(189003)(66556008)(6512007)(86362001)(66476007)(6486002)(478600001)(64756008)(66446008)(25786009)(53546011)(102836004)(8676002)(386003)(6506007)(14454004)(26005)(8936002)(81166006)(81156014)(486006)(52116002)(446003)(11346002)(476003)(2616005)(186003)(36756003)(229853002)(7736002)(316002)(110136005)(54906003)(6436002)(66066001)(31696002)(76176011)(305945005)(2501003)(99286004)(6246003)(2906002)(256004)(14444005)(6116002)(3846002)(5660300002)(4326008)(71190400001)(31686004)(71200400001)(66946007);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3839;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GeVFF62+Rn9DODWIKf9TpDQUYxrHQY6+G7xMJ8JtjfDsBhZUY7mguWBjs/hNw5aUd1qbRGIov6dejg6THAxXZbdqQKlUE61eJpL11UfGXt6qEtklYIxegdEL5StIwugVkkodXAK0wRGTZNgYulIvDIXauMqe6XWMKI6T8qTgD3yEhSvpxJt18Y8BWjtoTkCmduNiFvCSMyrEvrwlSSRZg/upR1Bj1CIkfblIaC8zxIhJvB0APsEPQv7sC2HZsCmo03j4G/WrDTkaixzvUexI8hgd2dkdlMalAOBpz8KLW5vP1Q0mWzhHjvRQjAPkI9iDTIuvJr3to4va/exZpnHgFCLB+hX/DC5sVeYqHKwcbJAnMY7mEZglgJJMYepA0IBEgAI6LW4wXLRcjSSuHnWc7mZ6Jb4shzun4cTHuqMV8GOPUWwjblvXTwibMYaS4yWB
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <733F7DCDABD27C41A9A8121F29C207FA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ac96868-ab16-489b-0c27-08d76287f790
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2019 07:07:21.3332
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7XVupPXO0AKPdWO1nxyAg67FV1cpymDfFKW7EbLtVTIk0sZ4HWawl2D9DhkPk5507fO2yP+cewiXNJ1MNQrB80d59LNvI/2As+ugzQNPi/w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3839
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDExLzA1LzIwMTkgMDI6MTIgUE0sIFZpZ25lc2ggUmFnaGF2ZW5kcmEgd3JvdGU6DQo+
IEV4dGVybmFsIEUtTWFpbA0KPiANCj4gDQo+IEhpLA0KPiANCj4gT24gMDIvMTEvMTkgNDo1MyBQ
TSwgVHVkb3IuQW1iYXJ1c0BtaWNyb2NoaXAuY29tIHdyb3RlOg0KPj4gRnJvbTogVHVkb3IgQW1i
YXJ1cyA8dHVkb3IuYW1iYXJ1c0BtaWNyb2NoaXAuY29tPg0KPj4NCj4+IFdoYXQgbW9zdCB1c2Vy
cyBjYXJlIGFib3V0IGlzICJteSBkZXYgaXMgbm90IHdvcmtpbmcgcHJvcGVybHkiLg0KPj4gQWxs
IGxvdyBsZXZlbCBpbmZvcm1hdGlvbiBzaG91bGQgYmUgZGlzY292ZXJlZCB3aGVuIGFjdGl2YXRp
bmcNCj4+IHRoZSBkZWJ1ZyB0cmFjZXMuDQo+Pg0KPj4gS2VlcCBlcnJvciBtZXNzYWdlcyBmb3Ig
anVzdCB0aHJlZSBjYXNlczoNCj4+IC0gd2hlbiB0aGUgSkVERUMgSUQgaXMgbm90IHJlY29nbml6
ZWQNCj4+IC0gd2hlbiB0aGUgcmVzdW1lKCkgY2FsbCBmYWlscw0KPj4gLSB3aGVuIHRoZSBzcGlf
bm9yX2NoZWNrKCkgZmFpbHMuDQo+Pg0KPj4gU3VnZ2VzdGVkLWJ5OiBCb3JpcyBCcmV6aWxsb24g
PGJvcmlzLmJyZXppbGxvbkBjb2xsYWJvcmEuY29tPg0KPj4gU2lnbmVkLW9mZi1ieTogVHVkb3Ig
QW1iYXJ1cyA8dHVkb3IuYW1iYXJ1c0BtaWNyb2NoaXAuY29tPg0KPj4gLS0tDQo+PiAgZHJpdmVy
cy9tdGQvc3BpLW5vci9zcGktbm9yLmMgfCA1MiArKysrKysrKysrKysrKysrKysrKystLS0tLS0t
LS0tLS0tLS0tLS0tLS0tDQo+PiAgMSBmaWxlIGNoYW5nZWQsIDI2IGluc2VydGlvbnMoKyksIDI2
IGRlbGV0aW9ucygtKQ0KPj4NCj4gWy4uLl0NCj4+ICANCj4+IEBAIC02NzksOSArNjc5LDkgQEAg
c3RhdGljIGludCBzcGlfbm9yX3NyX3JlYWR5KHN0cnVjdCBzcGlfbm9yICpub3IpDQo+PiAgCWlm
IChub3ItPmZsYWdzICYgU05PUl9GX1VTRV9DTFNSICYmDQo+PiAgCSAgICBub3ItPmJvdW5jZWJ1
ZlswXSAmIChTUl9FX0VSUiB8IFNSX1BfRVJSKSkgew0KPj4gIAkJaWYgKG5vci0+Ym91bmNlYnVm
WzBdICYgU1JfRV9FUlIpDQo+PiAtCQkJZGV2X2Vycihub3ItPmRldiwgIkVyYXNlIEVycm9yIG9j
Y3VycmVkXG4iKTsNCj4+ICsJCQlkZXZfZGJnKG5vci0+ZGV2LCAiRXJhc2UgRXJyb3Igb2NjdXJy
ZWRcbiIpOw0KPj4gIAkJZWxzZQ0KPj4gLQkJCWRldl9lcnIobm9yLT5kZXYsICJQcm9ncmFtbWlu
ZyBFcnJvciBvY2N1cnJlZFxuIik7DQo+PiArCQkJZGV2X2RiZyhub3ItPmRldiwgIlByb2dyYW1t
aW5nIEVycm9yIG9jY3VycmVkXG4iKTsNCj4+ICANCj4+ICAJCXNwaV9ub3JfY2xlYXJfc3Iobm9y
KTsNCj4+ICAJCXJldHVybiAtRUlPOw0KPj4gQEAgLTcxNCwxMiArNzE0LDEyIEBAIHN0YXRpYyBp
bnQgc3BpX25vcl9mc3JfcmVhZHkoc3RydWN0IHNwaV9ub3IgKm5vcikNCj4+ICANCj4+ICAJaWYg
KG5vci0+Ym91bmNlYnVmWzBdICYgKEZTUl9FX0VSUiB8IEZTUl9QX0VSUikpIHsNCj4+ICAJCWlm
IChub3ItPmJvdW5jZWJ1ZlswXSAmIEZTUl9FX0VSUikNCj4+IC0JCQlkZXZfZXJyKG5vci0+ZGV2
LCAiRXJhc2Ugb3BlcmF0aW9uIGZhaWxlZC5cbiIpOw0KPj4gKwkJCWRldl9kYmcobm9yLT5kZXYs
ICJFcmFzZSBvcGVyYXRpb24gZmFpbGVkLlxuIik7DQo+PiAgCQllbHNlDQo+PiAtCQkJZGV2X2Vy
cihub3ItPmRldiwgIlByb2dyYW0gb3BlcmF0aW9uIGZhaWxlZC5cbiIpOw0KPj4gKwkJCWRldl9k
Ymcobm9yLT5kZXYsICJQcm9ncmFtIG9wZXJhdGlvbiBmYWlsZWQuXG4iKTsNCj4+ICANCj4+ICAJ
CWlmIChub3ItPmJvdW5jZWJ1ZlswXSAmIEZTUl9QVF9FUlIpDQo+PiAtCQkJZGV2X2Vycihub3It
PmRldiwNCj4+ICsJCQlkZXZfZGJnKG5vci0+ZGV2LA0KPj4gIAkJCSJBdHRlbXB0ZWQgdG8gbW9k
aWZ5IGEgcHJvdGVjdGVkIHNlY3Rvci5cbiIpOw0KPj4NCj4gDQo+IFNpbmNlLCB3ZSBhcmUgc3Bl
Y2lmaWNhbGx5IHBhcnNpbmcgRlNSIGJpdHMgdG8ga25vdyB0aGUgcmVhc29uIGZvcg0KPiBmYWls
dXJlLCBJIHRoaW5rIHdlIHNob3VsZCB1c2UgZGV2X2VycigpcyBoZXJlLg0KPiBJIHNwZWNpZmlj
YWxseSBsaWtlIHRoZSBsYXN0IG9uZSB3aGljaCBpbmZvcm1zIHRoZSB1c2VyIHRoYXQNCj4gcHJv
Z3JhbS9lcmFzZSBvcGVyYXRpb24gZmFpbGVkIGFzIHNlY3RvciB3YXMgd3JpdGUgcHJvdGVjdGVk
Lg0KPiANCg0KWWVwLCB3aWxsIHVzZSBkZXZfZXJyIHRvIHJlcG9ydCBlcmFzZS9wcm9ncmFtIGVy
cm9ycyBpbiBib3RoIHNwaV9ub3Jfc3JfcmVhZHkoKQ0KYW5kIHNwaV9ub3JfZnNyX3JlYWR5KCks
IHRvZ2V0aGVyIHdpdGggdGhlIGF0dGVtcHQgb2YgbW9kaWZ5aW5nIGEgcHJvdGVjdGVkIHNlY3Rv
ci4NCg0KVGhhbmtzIQ0KDQo+IFJlc3QgbG9va3MgZmluZSB0byBtZToNCj4gDQo+IFJldmlld2Vk
LWJ5OiBWaWduZXNoIFJhZ2hhdmVuZHJhIDx2aWduZXNockB0aS5jb20+DQo+IA0KPiBSZWdhcmRz
DQo+IFZpZ25lc2gNCj4gDQo+PiAgCQlzcGlfbm9yX2NsZWFyX2Zzcihub3IpOw0KPj4gQEAgLTc3
MCw3ICs3NzAsNyBAQCBzdGF0aWMgaW50IHNwaV9ub3Jfd2FpdF90aWxsX3JlYWR5X3dpdGhfdGlt
ZW91dChzdHJ1Y3Qgc3BpX25vciAqbm9yLA0KPj4gIAkJY29uZF9yZXNjaGVkKCk7DQo+PiAgCX0N
Cj4+ICANCj4+IC0JZGV2X2Vycihub3ItPmRldiwgImZsYXNoIG9wZXJhdGlvbiB0aW1lZCBvdXRc
biIpOw0KPj4gKwlkZXZfZGJnKG5vci0+ZGV2LCAiZmxhc2ggb3BlcmF0aW9uIHRpbWVkIG91dFxu
Iik7DQo+PiAgDQo+PiAgCXJldHVybiAtRVRJTUVET1VUOw0KPj4gIH0NCj4+IEBAIC04MDcsNyAr
ODA3LDcgQEAgc3RhdGljIGludCBzcGlfbm9yX3dyaXRlX3NyX2NyKHN0cnVjdCBzcGlfbm9yICpu
b3IsIGNvbnN0IHU4ICpzcl9jcikNCj4+ICAJfQ0KPj4gIA0KPj4gIAlpZiAocmV0KSB7DQo+PiAt
CQlkZXZfZXJyKG5vci0+ZGV2LA0KPj4gKwkJZGV2X2RiZyhub3ItPmRldiwNCj4+ICAJCQkiZXJy
b3Igd2hpbGUgd3JpdGluZyBjb25maWd1cmF0aW9uIHJlZ2lzdGVyXG4iKTsNCj4+ICAJCXJldHVy
biAtRUlOVkFMOw0KPj4gIAl9DQo+PiBAQCAtMTc3MSw3ICsxNzcxLDcgQEAgc3RhdGljIGludCBt
YWNyb25peF9xdWFkX2VuYWJsZShzdHJ1Y3Qgc3BpX25vciAqbm9yKQ0KPj4gIAkJcmV0dXJuIHJl
dDsNCj4+ICANCj4+ICAJaWYgKCEobm9yLT5ib3VuY2VidWZbMF0gJiBTUl9RVUFEX0VOX01YKSkg
ew0KPj4gLQkJZGV2X2Vycihub3ItPmRldiwgIk1hY3Jvbml4IFF1YWQgYml0IG5vdCBzZXRcbiIp
Ow0KPj4gKwkJZGV2X2RiZyhub3ItPmRldiwgIk1hY3Jvbml4IFF1YWQgYml0IG5vdCBzZXRcbiIp
Ow0KPj4gIAkJcmV0dXJuIC1FSU5WQUw7DQo+PiAgCX0NCj4+ICANCj4+IEBAIC0xODE5LDcgKzE4
MTksNyBAQCBzdGF0aWMgaW50IHNwYW5zaW9uX3F1YWRfZW5hYmxlKHN0cnVjdCBzcGlfbm9yICpu
b3IpDQo+PiAgCQlyZXR1cm4gcmV0Ow0KPj4gIA0KPj4gIAlpZiAoIShub3ItPmJvdW5jZWJ1Zlsw
XSAmIENSX1FVQURfRU5fU1BBTikpIHsNCj4+IC0JCWRldl9lcnIobm9yLT5kZXYsICJTcGFuc2lv
biBRdWFkIGJpdCBub3Qgc2V0XG4iKTsNCj4+ICsJCWRldl9kYmcobm9yLT5kZXYsICJTcGFuc2lv
biBRdWFkIGJpdCBub3Qgc2V0XG4iKTsNCj4+ICAJCXJldHVybiAtRUlOVkFMOw0KPj4gIAl9DQo+
PiAgDQo+PiBAQCAtMTg5Nyw3ICsxODk3LDcgQEAgc3RhdGljIGludCBzcGFuc2lvbl9yZWFkX2Ny
X3F1YWRfZW5hYmxlKHN0cnVjdCBzcGlfbm9yICpub3IpDQo+PiAgCQlyZXR1cm4gcmV0Ow0KPj4g
IA0KPj4gIAlpZiAoIShzcl9jclsxXSAmIENSX1FVQURfRU5fU1BBTikpIHsNCj4+IC0JCWRldl9l
cnIobm9yLT5kZXYsICJTcGFuc2lvbiBRdWFkIGJpdCBub3Qgc2V0XG4iKTsNCj4+ICsJCWRldl9k
Ymcobm9yLT5kZXYsICJTcGFuc2lvbiBRdWFkIGJpdCBub3Qgc2V0XG4iKTsNCj4+ICAJCXJldHVy
biAtRUlOVkFMOw0KPj4gIAl9DQo+PiAgDQo+PiBAQCAtMTkzNSw3ICsxOTM1LDcgQEAgc3RhdGlj
IGludCBzcjJfYml0N19xdWFkX2VuYWJsZShzdHJ1Y3Qgc3BpX25vciAqbm9yKQ0KPj4gIA0KPj4g
IAlyZXQgPSBzcGlfbm9yX3dyaXRlX3NyMihub3IsIHNyMik7DQo+PiAgCWlmIChyZXQpIHsNCj4+
IC0JCWRldl9lcnIobm9yLT5kZXYsICJlcnJvciB3aGlsZSB3cml0aW5nIHN0YXR1cyByZWdpc3Rl
ciAyXG4iKTsNCj4+ICsJCWRldl9kYmcobm9yLT5kZXYsICJlcnJvciB3aGlsZSB3cml0aW5nIHN0
YXR1cyByZWdpc3RlciAyXG4iKTsNCj4+ICAJCXJldHVybiByZXQ7DQo+PiAgCX0NCj4+ICANCj4+
IEBAIC0xOTQ5LDcgKzE5NDksNyBAQCBzdGF0aWMgaW50IHNyMl9iaXQ3X3F1YWRfZW5hYmxlKHN0
cnVjdCBzcGlfbm9yICpub3IpDQo+PiAgCQlyZXR1cm4gcmV0Ow0KPj4gIA0KPj4gIAlpZiAoISgq
c3IyICYgU1IyX1FVQURfRU5fQklUNykpIHsNCj4+IC0JCWRldl9lcnIobm9yLT5kZXYsICJTUjIg
UXVhZCBiaXQgbm90IHNldFxuIik7DQo+PiArCQlkZXZfZGJnKG5vci0+ZGV2LCAiU1IyIFF1YWQg
Yml0IG5vdCBzZXRcbiIpOw0KPj4gIAkJcmV0dXJuIC1FSU5WQUw7DQo+PiAgCX0NCj4+ICANCj4+
IEBAIC0xOTc4LDcgKzE5NzgsNyBAQCBzdGF0aWMgaW50IHNwaV9ub3JfY2xlYXJfc3JfYnAoc3Ry
dWN0IHNwaV9ub3IgKm5vcikNCj4+ICANCj4+ICAJcmV0ID0gc3BpX25vcl93cml0ZV9zcihub3Is
IG5vci0+Ym91bmNlYnVmWzBdICYgfm1hc2spOw0KPj4gIAlpZiAocmV0KSB7DQo+PiAtCQlkZXZf
ZXJyKG5vci0+ZGV2LCAid3JpdGUgdG8gc3RhdHVzIHJlZ2lzdGVyIGZhaWxlZFxuIik7DQo+PiAr
CQlkZXZfZGJnKG5vci0+ZGV2LCAid3JpdGUgdG8gc3RhdHVzIHJlZ2lzdGVyIGZhaWxlZFxuIik7
DQo+PiAgCQlyZXR1cm4gcmV0Ow0KPj4gIAl9DQo+PiAgDQo+PiBAQCAtMjUyNSw3ICsyNTI1LDcg
QEAgc3RhdGljIGNvbnN0IHN0cnVjdCBmbGFzaF9pbmZvICpzcGlfbm9yX3JlYWRfaWQoc3RydWN0
IHNwaV9ub3IgKm5vcikNCj4+ICAJCQkJCQkgICAgU1BJX05PUl9NQVhfSURfTEVOKTsNCj4+ICAJ
fQ0KPj4gIAlpZiAodG1wKSB7DQo+PiAtCQlkZXZfZXJyKG5vci0+ZGV2LCAiZXJyb3IgJWQgcmVh
ZGluZyBKRURFQyBJRFxuIiwgdG1wKTsNCj4+ICsJCWRldl9kYmcobm9yLT5kZXYsICJlcnJvciAl
ZCByZWFkaW5nIEpFREVDIElEXG4iLCB0bXApOw0KPj4gIAkJcmV0dXJuIEVSUl9QVFIodG1wKTsN
Cj4+ICAJfQ0KPj4gIA0KPj4gQEAgLTI3NDAsNyArMjc0MCw3IEBAIHN0YXRpYyBpbnQgczNhbl9u
b3Jfc2V0dXAoc3RydWN0IHNwaV9ub3IgKm5vciwNCj4+ICANCj4+ICAJcmV0ID0gc3BpX25vcl94
cmVhZF9zcihub3IsIG5vci0+Ym91bmNlYnVmKTsNCj4+ICAJaWYgKHJldCkgew0KPj4gLQkJZGV2
X2Vycihub3ItPmRldiwgImVycm9yICVkIHJlYWRpbmcgWFJEU1JcbiIsIHJldCk7DQo+PiArCQlk
ZXZfZGJnKG5vci0+ZGV2LCAiZXJyb3IgJWQgcmVhZGluZyBYUkRTUlxuIiwgcmV0KTsNCj4+ICAJ
CXJldHVybiByZXQ7DQo+PiAgCX0NCj4+ICANCj4+IEBAIC00MTAyLDcgKzQxMDIsNyBAQCBzdGF0
aWMgaW50IHNwaV9ub3JfcGFyc2Vfc2ZkcChzdHJ1Y3Qgc3BpX25vciAqbm9yLA0KPj4gIAkJZXJy
ID0gc3BpX25vcl9yZWFkX3NmZHAobm9yLCBzaXplb2YoaGVhZGVyKSwNCj4+ICAJCQkJCXBzaXpl
LCBwYXJhbV9oZWFkZXJzKTsNCj4+ICAJCWlmIChlcnIgPCAwKSB7DQo+PiAtCQkJZGV2X2Vycihk
ZXYsICJmYWlsZWQgdG8gcmVhZCBTRkRQIHBhcmFtZXRlciBoZWFkZXJzXG4iKTsNCj4+ICsJCQlk
ZXZfZGJnKGRldiwgImZhaWxlZCB0byByZWFkIFNGRFAgcGFyYW1ldGVyIGhlYWRlcnNcbiIpOw0K
Pj4gIAkJCWdvdG8gZXhpdDsNCj4+ICAJCX0NCj4+ICAJfQ0KPj4gQEAgLTQzNDksNyArNDM0OSw3
IEBAIHN0YXRpYyBpbnQgc3BpX25vcl9kZWZhdWx0X3NldHVwKHN0cnVjdCBzcGlfbm9yICpub3Is
DQo+PiAgCS8qIFNlbGVjdCB0aGUgKEZhc3QpIFJlYWQgY29tbWFuZC4gKi8NCj4+ICAJZXJyID0g
c3BpX25vcl9zZWxlY3RfcmVhZChub3IsIHNoYXJlZF9tYXNrKTsNCj4+ICAJaWYgKGVycikgew0K
Pj4gLQkJZGV2X2Vycihub3ItPmRldiwNCj4+ICsJCWRldl9kYmcobm9yLT5kZXYsDQo+PiAgCQkJ
ImNhbid0IHNlbGVjdCByZWFkIHNldHRpbmdzIHN1cHBvcnRlZCBieSBib3RoIHRoZSBTUEkgY29u
dHJvbGxlciBhbmQgbWVtb3J5LlxuIik7DQo+PiAgCQlyZXR1cm4gZXJyOw0KPj4gIAl9DQo+PiBA
QCAtNDM1Nyw3ICs0MzU3LDcgQEAgc3RhdGljIGludCBzcGlfbm9yX2RlZmF1bHRfc2V0dXAoc3Ry
dWN0IHNwaV9ub3IgKm5vciwNCj4+ICAJLyogU2VsZWN0IHRoZSBQYWdlIFByb2dyYW0gY29tbWFu
ZC4gKi8NCj4+ICAJZXJyID0gc3BpX25vcl9zZWxlY3RfcHAobm9yLCBzaGFyZWRfbWFzayk7DQo+
PiAgCWlmIChlcnIpIHsNCj4+IC0JCWRldl9lcnIobm9yLT5kZXYsDQo+PiArCQlkZXZfZGJnKG5v
ci0+ZGV2LA0KPj4gIAkJCSJjYW4ndCBzZWxlY3Qgd3JpdGUgc2V0dGluZ3Mgc3VwcG9ydGVkIGJ5
IGJvdGggdGhlIFNQSSBjb250cm9sbGVyIGFuZCBtZW1vcnkuXG4iKTsNCj4+ICAJCXJldHVybiBl
cnI7DQo+PiAgCX0NCj4+IEBAIC00MzY1LDcgKzQzNjUsNyBAQCBzdGF0aWMgaW50IHNwaV9ub3Jf
ZGVmYXVsdF9zZXR1cChzdHJ1Y3Qgc3BpX25vciAqbm9yLA0KPj4gIAkvKiBTZWxlY3QgdGhlIFNl
Y3RvciBFcmFzZSBjb21tYW5kLiAqLw0KPj4gIAllcnIgPSBzcGlfbm9yX3NlbGVjdF9lcmFzZShu
b3IpOw0KPj4gIAlpZiAoZXJyKSB7DQo+PiAtCQlkZXZfZXJyKG5vci0+ZGV2LA0KPj4gKwkJZGV2
X2RiZyhub3ItPmRldiwNCj4+ICAJCQkiY2FuJ3Qgc2VsZWN0IGVyYXNlIHNldHRpbmdzIHN1cHBv
cnRlZCBieSBib3RoIHRoZSBTUEkgY29udHJvbGxlciBhbmQgbWVtb3J5LlxuIik7DQo+PiAgCQly
ZXR1cm4gZXJyOw0KPj4gIAl9DQo+PiBAQCAtNDY4Niw3ICs0Njg2LDcgQEAgc3RhdGljIGludCBz
cGlfbm9yX2luaXQoc3RydWN0IHNwaV9ub3IgKm5vcikNCj4+ICANCj4+ICAJCWVyciA9IG5vci0+
Y2xlYXJfc3JfYnAobm9yKTsNCj4+ICAJCWlmIChlcnIpIHsNCj4+IC0JCQlkZXZfZXJyKG5vci0+
ZGV2LA0KPj4gKwkJCWRldl9kYmcobm9yLT5kZXYsDQo+PiAgCQkJCSJmYWlsIHRvIGNsZWFyIGJs
b2NrIHByb3RlY3Rpb24gYml0c1xuIik7DQo+PiAgCQkJcmV0dXJuIGVycjsNCj4+ICAJCX0NCj4+
IEBAIC00Njk0LDcgKzQ2OTQsNyBAQCBzdGF0aWMgaW50IHNwaV9ub3JfaW5pdChzdHJ1Y3Qgc3Bp
X25vciAqbm9yKQ0KPj4gIA0KPj4gIAllcnIgPSBzcGlfbm9yX3F1YWRfZW5hYmxlKG5vcik7DQo+
PiAgCWlmIChlcnIpIHsNCj4+IC0JCWRldl9lcnIobm9yLT5kZXYsICJxdWFkIG1vZGUgbm90IHN1
cHBvcnRlZFxuIik7DQo+PiArCQlkZXZfZGJnKG5vci0+ZGV2LCAicXVhZCBtb2RlIG5vdCBzdXBw
b3J0ZWRcbiIpOw0KPj4gIAkJcmV0dXJuIGVycjsNCj4+ICAJfQ0KPj4gIA0KPj4gQEAgLTQ3NjIs
NyArNDc2Miw3IEBAIHN0YXRpYyBpbnQgc3BpX25vcl9zZXRfYWRkcl93aWR0aChzdHJ1Y3Qgc3Bp
X25vciAqbm9yKQ0KPj4gIAl9DQo+PiAgDQo+PiAgCWlmIChub3ItPmFkZHJfd2lkdGggPiBTUElf
Tk9SX01BWF9BRERSX1dJRFRIKSB7DQo+PiAtCQlkZXZfZXJyKG5vci0+ZGV2LCAiYWRkcmVzcyB3
aWR0aCBpcyB0b28gbGFyZ2U6ICV1XG4iLA0KPj4gKwkJZGV2X2RiZyhub3ItPmRldiwgImFkZHJl
c3Mgd2lkdGggaXMgdG9vIGxhcmdlOiAldVxuIiwNCj4+ICAJCQlub3ItPmFkZHJfd2lkdGgpOw0K
Pj4gIAkJcmV0dXJuIC1FSU5WQUw7DQo+PiAgCX0NCj4+DQo+IA0K
