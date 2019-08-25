Return-Path: <SRS0=9baz=WV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C486EC3A5A1
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 13:20:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BEA12070B
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 13:20:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="fBosKNth"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728373AbfHYNUI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Aug 2019 09:20:08 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:22494 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727426AbfHYNUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 09:20:07 -0400
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
IronPort-SDR: N/7/Mfnltcx4jlWrkbk6+6wTiXOz1IlHprqAwRb7+ckdS4MshxOF5kpykiwd9nYMH6VdBKmmBJ
 ZRfA75Y4hMQlWogG/v3xzGgjUO3UUbCqk+EpJjIVmUnGTyP5IxpzIUz5RNA4x2U+dlDe+RQWeO
 YPCCF1Tga4NAOKLVWC55FAU6BzRZ7CVy1BWsdhjPh5LGRMn3bLK6dkGPj7YvWXTrm2zzohY3j5
 Cz+by8gbt8YZJxtgsja020PhAZSYMfR+RkqKgvzXM8E1eD4RVhFvbXvubHEel7DNebR5XdJL3L
 p4s=
X-IronPort-AV: E=Sophos;i="5.64,429,1559545200"; 
   d="scan'208";a="43601492"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Aug 2019 06:20:01 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sun, 25 Aug 2019 06:20:00 -0700
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Sun, 25 Aug 2019 06:20:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LWjyfNm2nMFse711pWHuBZDUGg2ZPoy5DkkaFC7o1iysepjKe35LKa7auPedKBTIq0EnuxJKEfDvSQtm59v27SV40GoAazxcCrD/wOPtdMPVOufTgHkzF58koMo35+L2fcNH8aqRpPR9pCk5bGPyILn5M2l8hAH2E3itBQZfqoPRGQlAG8hhUgCKpY0VeZ5H+nKBZFtksEpz2QafgPGpCxvLAYjnvCzorBJGgfnuxrG1jx+J+LzDr5hEpfjpT64C3OhmTRudG2QGcCjFS3WHusoBbBOX+yirW3tsxlEPaA2YYs7oE7nFi2aN/ojs45RLF9yHI7+dktVXsMDnn3vNeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mcz3oJCTP2tCU5VeMacZ4nyRll6b50SnnEOeNfhoi+M=;
 b=NYhDG5PV2aYtnr0PPjrmwV0pbHC0NiltVBlatV+1FItLoq02i9JTZJXUh0x4BQQueqQ1lF08mDyGwCBIzZ411Q8EM7FP6X0YHOl8ri5p5M8IFmYfP8TkWlbtGlUqCqzhohlqYAJb4pD4h5+vlVriD68b9lY+7L8ClZ3kbfeDgp4FEH61LS8GryaKjzltLVey15ycy8Pf9DXSL7GHBIe0kZjnSuk4y2r1nmN74zMDfSuT7EwtcVA8xy9Eey0i6uT3hNLUYx0NjUnM6U7ugm4HQbBxUhB8kI9dHhsmkVwGILVf99wS1b2Wa1mHTa/fEZYZURiRgQ7RGir/aStJBnDDxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mcz3oJCTP2tCU5VeMacZ4nyRll6b50SnnEOeNfhoi+M=;
 b=fBosKNth0Uv4nhIbPrC4uMlZxcYGk+LXCuyiTL4HYbLmSOZc4sya1nexgNOhDd2HIq4AV3XUcXUKmgNcyM86TaVvMCQ0oNQ9zkRUPM3pMsJ7U6Ro+Qt4+bwQ8KGZop3QB8hvHl1EXiTPI6yAI+8G5IhMzz0BRWJUKdsV/P2ZM4Q=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB4384.namprd11.prod.outlook.com (52.135.37.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.20; Sun, 25 Aug 2019 13:19:57 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::70c3:e929:4da2:60a5]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::70c3:e929:4da2:60a5%7]) with mapi id 15.20.2199.021; Sun, 25 Aug 2019
 13:19:57 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <boris.brezillon@collabora.com>
CC:     <marek.vasut@gmail.com>, <vigneshr@ti.com>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/5] mtd: spi-nor: Move clear_sr_bp() to 'struct
 spi_nor_flash_parameter'
Thread-Topic: [PATCH 4/5] mtd: spi-nor: Move clear_sr_bp() to 'struct
 spi_nor_flash_parameter'
Thread-Index: AQHVWcrvkrm6wR4a/Ey8Wo3jUNa/D6cL2Q+AgAAC5YA=
Date:   Sun, 25 Aug 2019 13:19:57 +0000
Message-ID: <6485db42-4449-cc9b-8e09-0ad89b259a8b@microchip.com>
References: <20190823155325.13459-1-tudor.ambarus@microchip.com>
 <20190823155325.13459-5-tudor.ambarus@microchip.com>
 <20190825150927.5374b1ea@collabora.com>
In-Reply-To: <20190825150927.5374b1ea@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0601CA0035.eurprd06.prod.outlook.com
 (2603:10a6:800:1e::45) To MN2PR11MB4448.namprd11.prod.outlook.com
 (2603:10b6:208:193::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [86.127.53.184]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 57a64cc5-7738-40cd-ace7-08d7295eecce
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR11MB4384;
x-ms-traffictypediagnostic: MN2PR11MB4384:
x-microsoft-antispam-prvs: <MN2PR11MB438425EB5244151B8BE7C10FF0A60@MN2PR11MB4384.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 01401330D1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(39850400004)(136003)(366004)(376002)(199004)(189003)(66476007)(66556008)(64756008)(66446008)(305945005)(31686004)(25786009)(4326008)(54906003)(6512007)(6486002)(53546011)(386003)(14444005)(256004)(31696002)(86362001)(99286004)(52116002)(53936002)(6246003)(71190400001)(8936002)(5660300002)(76176011)(6436002)(26005)(186003)(2906002)(66066001)(102836004)(81156014)(81166006)(8676002)(2616005)(14454004)(66946007)(486006)(7736002)(71200400001)(6116002)(3846002)(6506007)(476003)(11346002)(316002)(446003)(229853002)(6916009)(36756003)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB4384;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: NhEJQIL23HALIKTu+OqZu25WPdzuS5yBgE4G96TBQ0FWCeZjfVY4PvmYPp1u7c2x0zzpVaHAxNsdk4a4OLaBC6Vq0x5gxQPfgA8ax9LDsZGDjVpSNrLAR0But74EHWWk+JeHku8lmbQ7EPODWpyx94v3XFroM5vYRdbJ4KWsXf7c6Is5Q3LldzTCZz54PjK8CKumSqKeiBKgERfjFeON5IlD6eup6mSs6pcQcNMtBRUQ0yKZFyMvUmzJb14T02+1+qNimhNvq4kcMiBf0iqhGp0wl1EhVzNW00NzCG6aKIAXXhmTYnsADpnpcevkoTipMlbVePn4W4RJHQmgx9So0yCGP3HTFZgkcSQNqVgrwK5xvtVA+DNiPy00p/LcrkGYdkr+Q5IFKsaaJVhi/FvQ2O3bSDCaeG3Ep44DjZgkLG0=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <4435CA0145BC0146A51495677E043301@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 57a64cc5-7738-40cd-ace7-08d7295eecce
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2019 13:19:57.4485
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vyxaUyWfT8dE2eCOAKytSYImWFTSyXVDYQ+YLPUKjooI6PKx7/wEjnDNzS8jNnXdx2QIYx3fJA17xfQTEb2wkFFMsynDMOUrv1LdHsHJBiA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4384
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDA4LzI1LzIwMTkgMDQ6MDkgUE0sIEJvcmlzIEJyZXppbGxvbiB3cm90ZToNCj4gT24g
RnJpLCAyMyBBdWcgMjAxOSAxNTo1Mzo0MSArMDAwMA0KPiA8VHVkb3IuQW1iYXJ1c0BtaWNyb2No
aXAuY29tPiB3cm90ZToNCj4gDQo+PiBGcm9tOiBUdWRvciBBbWJhcnVzIDx0dWRvci5hbWJhcnVz
QG1pY3JvY2hpcC5jb20+DQo+Pg0KPj4gQWxsIGZsYXNoIHBhcmFtZXRlcnMgYW5kIHNldHRpbmdz
IHNob3VsZCByZXNpZGUgaW5zaWRlDQo+PiAnc3RydWN0IHNwaV9ub3JfZmxhc2hfcGFyYW1ldGVy
Jy4gTW92ZSBjbGVhcl9zcl9icCgpIGZyb20NCj4+ICdzdHJ1Y3Qgc3BpX25vcicgdG8gJ3N0cnVj
dCBzcGlfbm9yX2ZsYXNoX3BhcmFtZXRlcicuDQo+Pg0KPj4gUmVuYW1lIGNsZWFyX3NyX2JwKCkv
ZGlzYWJsZV9ibG9ja19wcm90ZWN0aW9uKCkgdG8gYmV0dGVyIGluZGljYXRlDQo+PiB3aGF0IHRo
ZSBmdW5jdGlvbiBkb2VzLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IFR1ZG9yIEFtYmFydXMgPHR1
ZG9yLmFtYmFydXNAbWljcm9jaGlwLmNvbT4NCj4+IC0tLQ0KPj4gIGRyaXZlcnMvbXRkL3NwaS1u
b3Ivc3BpLW5vci5jIHwgNDcgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0t
LS0tLQ0KPj4gIGluY2x1ZGUvbGludXgvbXRkL3NwaS1ub3IuaCAgIHwgIDUgKystLS0NCj4+ICAy
IGZpbGVzIGNoYW5nZWQsIDM4IGluc2VydGlvbnMoKyksIDE0IGRlbGV0aW9ucygtKQ0KPj4NCj4+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL210ZC9zcGktbm9yL3NwaS1ub3IuYyBiL2RyaXZlcnMvbXRk
L3NwaS1ub3Ivc3BpLW5vci5jDQo+PiBpbmRleCA2YmQxMDRjMjljZDkuLjE1YjBiMTE0OGJmMyAx
MDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvbXRkL3NwaS1ub3Ivc3BpLW5vci5jDQo+PiArKysgYi9k
cml2ZXJzL210ZC9zcGktbm9yL3NwaS1ub3IuYw0KPj4gQEAgLTQ0NzcsMjAgKzQ0NzcsNDUgQEAg
c3RhdGljIGludCBzcGlfbm9yX3F1YWRfZW5hYmxlKHN0cnVjdCBzcGlfbm9yICpub3IpDQo+PiAg
CXJldHVybiBub3ItPnBhcmFtcy5xdWFkX2VuYWJsZShub3IpOw0KPj4gIH0NCj4+ICANCj4+ICsv
KioNCj4+ICsgKiBzcGlfbm9yX2Rpc2FibGVfYmxvY2tfcHJvdGVjdGlvbigpIC0gRGlzYWJsZSB0
aGUgd3JpdGUgYmxvY2sgcHJvdGVjdGlvbg0KPj4gKyAqIGR1cmluZyBwb3dlci11cC4NCj4+ICsg
KiBAbm9yOiAgICAgICAgICAgICAgICBwb2ludGVyIHRvIGEgJ3N0cnVjdCBzcGlfbm9yJw0KPj4g
KyAqDQo+PiArICogU29tZSBzcGktbm9yIGZsYXNoZXMgYXJlIHdyaXRlIHByb3RlY3RlZCBieSBk
ZWZhdWx0IGFmdGVyIGEgcG93ZXItb24gcmVzZXQNCj4+ICsgKiBjeWNsZSwgaW4gb3JkZXIgdG8g
YXZvaWQgaW5hZHZlcnRlbmQgd3JpdGVzIGR1cmluZyBwb3dlci11cC4gQmFja3dhcmQNCj4+ICsg
KiBjb21wYXRpYmlsaXR5IGltcG9zZXMgdG8gZGlzYWJsZSB0aGUgd3JpdGUgYmxvY2sgcHJvdGVj
dGlvbiBhdCBwb3dlci11cA0KPj4gKyAqIGJ5IGRlZmF1bHQuDQo+PiArICoNCj4+ICsgKiBSZXR1
cm46IDAgb24gc3VjY2VzcywgLWVycm5vIG90aGVyd2lzZS4NCj4+ICsgKi8NCj4+ICtzdGF0aWMg
aW50IHNwaV9ub3JfZGlzYWJsZV9ibG9ja19wcm90ZWN0aW9uKHN0cnVjdCBzcGlfbm9yICpub3Ip
DQo+PiArew0KPj4gKwlpZiAoIW5vci0+cGFyYW1zLmRpc2FibGVfYmxvY2tfcHJvdGVjdGlvbikN
Cj4+ICsJCXJldHVybiAwOw0KPj4gKw0KPj4gKwkvKg0KPj4gKwkgKiBJbiBjYXNlIG9mIHRoZSBs
ZWdhY3kgcXVhZCBlbmFibGUgcmVxdWlyZW1lbnRzIGFyZSBzZXQsIGlmIHRoZQ0KPj4gKwkgKiBj
b25maWd1cmF0aW9uIHJlZ2lzdGVyIFF1YWQgRW5hYmxlIGJpdCBpcyBvbmUsIG9ubHkgdGhlIHRo
ZQ0KPj4gKwkgKiBXcml0ZSBTdGF0dXMgKDAxaCkgY29tbWFuZCB3aXRoIHR3byBkYXRhIGJ5dGVz
IG1heSBiZSB1c2VkIHRvIGNsZWFyDQo+PiArCSAqIHRoZSBibG9jayBwcm90ZWN0aW9uIGJpdHMu
DQo+PiArCSAqLw0KPj4gKwlpZiAobm9yLT5wYXJhbXMucXVhZF9lbmFibGUgPT0gc3BhbnNpb25f
cXVhZF9lbmFibGUpDQo+PiArCQlub3ItPnBhcmFtcy5kaXNhYmxlX2Jsb2NrX3Byb3RlY3Rpb24g
PQ0KPj4gKwkJCXNwaV9ub3Jfc3BhbnNpb25fY2xlYXJfc3JfYnA7DQo+IA0KPiBIbSwgZG9lc24n
dCBsb29rIHJpZ2h0IHRvIGFkanVzdCB0aGUgZnVuY3Rpb24gcG9pbnRlciBqdXN0IGJlZm9yZQ0K
PiBjYWxsaW5nIGl0LiBDYW4ndCB3ZSBtb3ZlIHRoYXQgbG9naWMgZWFybGllciAod2hlbiBkb2lu
ZyB0aGUNCj4gZGVmYXVsdC9tYW51ZmFjdHVyZXIgc3BlY2lmaWMgaW5pdCk/IEFsc28sIGFzIEkg
c2FpZCBpbiBvbmUgb2YgbXkNCg0KTm8sIHdlIGNhbid0IG1vdmUgaXQgZWFybGllciB0byAtPmRl
ZmF1bHRfaW5pdCgpIGJlY2F1c2UgdGhlIHBvaW50ZXIgdG8NCnF1YWRfZW5hYmxlKCkgZnVuY3Rp
b24gY2FuIGJlIG1vZGlmaWVkIGxhdGVyIG9uLCB3aGVuIHBhcnNpbmcgU0ZEUC4gVGhpcyBzaG91
bGQNCnN0YXkgaGVyZSwgYWZ0ZXIgdGhlIHF1YWRfZW5hYmxlKCkgbWV0aG9kIGlzIGtub3duLCBz
byBhZnRlciB0aGUNCnNwaV9ub3JfaW5pdF9wYXJhbXMoKSBjYWxsLg0KDQoNCj4gcHJldmlvdXMg
ZW1haWxzLCBJJ2QgcHJlZmVyIHRvIGhhdmUgdGhpcyBob29rIG1vdmVkIHRvDQo+IHNwaV9ub3Jf
bG9ja2luZ19vcHMgYW5kIGp1c3QgaGF2ZSBhIGZsYWcgdG8gcmVmbGVjdCB3aGVuIGJsb2NrDQo+
IHByb3RlY3Rpb24gY2FuIGJlIGRpc2FibGVkLg0KDQp5ZXMsIEkgYWdyZWUsIHdpbGwgbW92ZS4N
Cg0KPiANCj4+ICsNCj4+ICsJcmV0dXJuIG5vci0+cGFyYW1zLmRpc2FibGVfYmxvY2tfcHJvdGVj
dGlvbihub3IpOw0KPj4gK30NCj4+ICsNCj4+ICBzdGF0aWMgaW50IHNwaV9ub3JfaW5pdChzdHJ1
Y3Qgc3BpX25vciAqbm9yKQ0KPj4gIHsNCj4+ICAJaW50IGVycjsNCj4+ICANCj4+IC0JaWYgKG5v
ci0+Y2xlYXJfc3JfYnApIHsNCj4+IC0JCWlmIChub3ItPnF1YWRfZW5hYmxlID09IHNwYW5zaW9u
X3F1YWRfZW5hYmxlKQ0KPj4gLQkJCW5vci0+Y2xlYXJfc3JfYnAgPSBzcGlfbm9yX3NwYW5zaW9u
X2NsZWFyX3NyX2JwOw0KPj4gLQ0KPj4gLQkJZXJyID0gbm9yLT5jbGVhcl9zcl9icChub3IpOw0K
Pj4gLQkJaWYgKGVycikgew0KPj4gLQkJCWRldl9lcnIobm9yLT5kZXYsDQo+PiAtCQkJCSJmYWls
IHRvIGNsZWFyIGJsb2NrIHByb3RlY3Rpb24gYml0c1xuIik7DQo+PiAtCQkJcmV0dXJuIGVycjsN
Cj4+IC0JCX0NCj4+ICsJZXJyID0gc3BpX25vcl9kaXNhYmxlX2Jsb2NrX3Byb3RlY3Rpb24obm9y
KTsNCj4+ICsJaWYgKGVycikgew0KPj4gKwkJZGV2X2Vycihub3ItPmRldiwNCj4+ICsJCQkiZmFp
bCB0byB1bmxvY2sgdGhlIGZsYXNoIGF0IGluaXQgKGVyciA9ICVkKVxuIiwgZXJyKTsNCj4+ICsJ
CXJldHVybiBlcnI7DQo+PiAgCX0NCj4+ICANCj4+ICAJZXJyID0gc3BpX25vcl9xdWFkX2VuYWJs
ZShub3IpOw0KPj4gQEAgLTQ2MzUsNyArNDY2MCw3IEBAIGludCBzcGlfbm9yX3NjYW4oc3RydWN0
IHNwaV9ub3IgKm5vciwgY29uc3QgY2hhciAqbmFtZSwNCj4+ICAJICAgIEpFREVDX01GUihub3It
PmluZm8pID09IFNOT1JfTUZSX0lOVEVMIHx8DQo+PiAgCSAgICBKRURFQ19NRlIobm9yLT5pbmZv
KSA9PSBTTk9SX01GUl9TU1QgfHwNCj4+ICAJICAgIG5vci0+aW5mby0+ZmxhZ3MgJiBTUElfTk9S
X0hBU19MT0NLKQ0KPj4gLQkJbm9yLT5jbGVhcl9zcl9icCA9IHNwaV9ub3JfY2xlYXJfc3JfYnA7
DQo+PiArCQlub3ItPnBhcmFtcy5kaXNhYmxlX2Jsb2NrX3Byb3RlY3Rpb24gPSBzcGlfbm9yX2Ns
ZWFyX3NyX2JwOw0KPj4gIA0KPj4gIAkvKiBQYXJzZSB0aGUgU2VyaWFsIEZsYXNoIERpc2NvdmVy
YWJsZSBQYXJhbWV0ZXJzIHRhYmxlLiAqLw0KPj4gIAlyZXQgPSBzcGlfbm9yX2luaXRfcGFyYW1z
KG5vcik7DQo+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9tdGQvc3BpLW5vci5oIGIvaW5j
bHVkZS9saW51eC9tdGQvc3BpLW5vci5oDQo+PiBpbmRleCAxNzc4NzIzOGYwZTkuLjM5OWFjMzRh
NTI5ZCAxMDA2NDQNCj4+IC0tLSBhL2luY2x1ZGUvbGludXgvbXRkL3NwaS1ub3IuaA0KPj4gKysr
IGIvaW5jbHVkZS9saW51eC9tdGQvc3BpLW5vci5oDQo+PiBAQCAtNDgwLDYgKzQ4MCw3IEBAIHN0
cnVjdCBzcGlfbm9yOw0KPj4gICAqIEBwYWdlX3Byb2dyYW1zOglwYWdlIHByb2dyYW0gY2FwYWJp
bGl0aWVzIG9yZGVyZWQgYnkgcHJpb3JpdHk6IHRoZQ0KPj4gICAqICAgICAgICAgICAgICAgICAg
ICAgIGhpZ2hlciBpbmRleCBpbiB0aGUgYXJyYXksIHRoZSBoaWdoZXIgcHJpb3JpdHkuDQo+PiAg
ICogQHF1YWRfZW5hYmxlOgllbmFibGVzIFNQSSBOT1IgcXVhZCBtb2RlLg0KPj4gKyAqIEBkaXNh
YmxlX2Jsb2NrX3Byb3RlY3Rpb246IGRpc2FibGVzIGJsb2NrIHByb3RlY3Rpb24gZHVyaW5nIHBv
d2VyLXVwLg0KPj4gICAqLw0KPj4gIHN0cnVjdCBzcGlfbm9yX2ZsYXNoX3BhcmFtZXRlciB7DQo+
PiAgCXU2NAkJCQlzaXplOw0KPj4gQEAgLTQ5MCw2ICs0OTEsNyBAQCBzdHJ1Y3Qgc3BpX25vcl9m
bGFzaF9wYXJhbWV0ZXIgew0KPj4gIAlzdHJ1Y3Qgc3BpX25vcl9wcF9jb21tYW5kCXBhZ2VfcHJv
Z3JhbXNbU05PUl9DTURfUFBfTUFYXTsNCj4+ICANCj4+ICAJaW50ICgqcXVhZF9lbmFibGUpKHN0
cnVjdCBzcGlfbm9yICpub3IpOw0KPj4gKwlpbnQgKCpkaXNhYmxlX2Jsb2NrX3Byb3RlY3Rpb24p
KHN0cnVjdCBzcGlfbm9yICpub3IpOw0KPj4gIH07DQo+PiAgDQo+PiAgLyoqDQo+PiBAQCAtNTM1
LDggKzUzNyw2IEBAIHN0cnVjdCBmbGFzaF9pbmZvOw0KPj4gICAqIEBmbGFzaF91bmxvY2s6CVtG
TEFTSC1TUEVDSUZJQ10gdW5sb2NrIGEgcmVnaW9uIG9mIHRoZSBTUEkgTk9SDQo+PiAgICogQGZs
YXNoX2lzX2xvY2tlZDoJW0ZMQVNILVNQRUNJRklDXSBjaGVjayBpZiBhIHJlZ2lvbiBvZiB0aGUg
U1BJIE5PUiBpcw0KPj4gICAqCQkJY29tcGxldGVseSBsb2NrZWQNCj4+IC0gKiBAY2xlYXJfc3Jf
YnA6CVtGTEFTSC1TUEVDSUZJQ10gY2xlYXJzIHRoZSBCbG9jayBQcm90ZWN0aW9uIEJpdHMgZnJv
bQ0KPj4gLSAqCQkJdGhlIFNQSSBOT1IgU3RhdHVzIFJlZ2lzdGVyLg0KPj4gICAqIEBwYXJhbXM6
CQlbRkxBU0gtU1BFQ0lGSUNdIFNQSS1OT1IgZmxhc2ggcGFyYW1ldGVycyBhbmQgc2V0dGluZ3Mu
DQo+PiAgICogICAgICAgICAgICAgICAgICAgICAgVGhlIHN0cnVjdHVyZSBpbmNsdWRlcyBsZWdh
Y3kgZmxhc2ggcGFyYW1ldGVycyBhbmQNCj4+ICAgKiAgICAgICAgICAgICAgICAgICAgICBzZXR0
aW5ncyB0aGF0IGNhbiBiZSBvdmVyd3JpdHRlbiBieSB0aGUgc3BpX25vcl9maXh1cHMNCj4+IEBA
IC01NzgsNyArNTc4LDYgQEAgc3RydWN0IHNwaV9ub3Igew0KPj4gIAlpbnQgKCpmbGFzaF9sb2Nr
KShzdHJ1Y3Qgc3BpX25vciAqbm9yLCBsb2ZmX3Qgb2ZzLCB1aW50NjRfdCBsZW4pOw0KPj4gIAlp
bnQgKCpmbGFzaF91bmxvY2spKHN0cnVjdCBzcGlfbm9yICpub3IsIGxvZmZfdCBvZnMsIHVpbnQ2
NF90IGxlbik7DQo+PiAgCWludCAoKmZsYXNoX2lzX2xvY2tlZCkoc3RydWN0IHNwaV9ub3IgKm5v
ciwgbG9mZl90IG9mcywgdWludDY0X3QgbGVuKTsNCj4+IC0JaW50ICgqY2xlYXJfc3JfYnApKHN0
cnVjdCBzcGlfbm9yICpub3IpOw0KPj4gIAlzdHJ1Y3Qgc3BpX25vcl9mbGFzaF9wYXJhbWV0ZXIg
cGFyYW1zOw0KPj4gIA0KPj4gIAl2b2lkICpwcml2Ow0KPiANCj4gDQo=
