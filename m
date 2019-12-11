Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62D76C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 11:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22B912073D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 11:45:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="mzXudpHo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729083AbfLKLpJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 06:45:09 -0500
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:11884 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727365AbfLKLpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 06:45:08 -0500
Received-SPF: Pass (esa1.microchip.iphmx.com: domain of
  Claudiu.Beznea@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa1.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="Claudiu.Beznea@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com -exists:%{i}.spf.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa1.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa1.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa1.microchip.iphmx.com; spf=Pass smtp.mailfrom=Claudiu.Beznea@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: DfIdp8VjNltaXMRNXaJvTbFNoYSAYsak/0q7gywIDKwfvwNMXFlLYJB+0ebbv+fuJui3kCv97x
 4dZtOKVKOf3KYCQZvtN0WHxtqZmVAnO0tBtKkcsoFgTc6qol9UAwrLUMvItsomH5ml647urKUf
 X8meClyxFD4rntHwwbnVv+29Ct8WH85f3k6D5PUd1z7fYVEPCqIfErepcnIwwwQIYir3Y8azol
 zfi/P0BmipMENlC3Lha4rTdiriDtZxPIuYZt0zqplVXdw6Dp7jdevG4GPP1Mep4q6PMdTSRHdI
 hy0=
X-IronPort-AV: E=Sophos;i="5.69,301,1571727600"; 
   d="scan'208";a="61351831"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Dec 2019 04:45:07 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 11 Dec 2019 04:45:15 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 11 Dec 2019 04:45:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LhfiQ88WkCgs6bPefm720P/efqK+HzlF/OuAZKx7wcRVXbvpwRQlVRLQh7FID78t2I7u9uG3LN1nK1+oNOs7aEvn4U2ilysbmBJHYr1ArtSXARhEO0XhKbeB8muvmvDZ0p087MTQJp8BF+OBiMZgsNBh6OMg4ZIQnNi603cBDegwDcKDuwnCsWzwwXJ6DjwRWP8ZOWw+KxxAGKCI56DYiwl+mzJYO5PHRWUunvw+ldv6Vm+J2Y/MwRN5ZY/OiQ+fvp/WHiJx9xPjXA7H/BEcjJgRdY9YkJXxHjF79eKAngx2xzZpWRTiXvf5x4b3aq3vkQMp0A29IxXAkppWNglzxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UGPxMDefpO3kz7dNeiCxXgFkQB0e2YiUbEwYP5llBFQ=;
 b=M6zct/8ZvaG09sTSWFgkJkkci/tWGK7Hc/kC0zaubSYRPaJRuXCcgRlljCYHeYT9ZM0w9nio3Z4JXdYNeCl3/bJbhYepsK1yeZYe+UdcpjopHBcvPFoN0uKKvRqmgwKtuHTHR5em+f99KrDAzytJ0LJEDU/2x3F1XMyzGWtoJFj7pubq30b/j9RObYO+1to/kOI/9NSyv6zWiaeJyY876ab2X7E5Tiya9NgRZo8WvsJOBsw28QN2GJf+28diW+6UxoRXo2FS6ZrLeYbqXSWWlXvyy3aX8iP3VrH3CmMIrjNdKkWkAoHJiTPCkTTs67ioA8/9sMSUd+pLgBAsEAEqtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UGPxMDefpO3kz7dNeiCxXgFkQB0e2YiUbEwYP5llBFQ=;
 b=mzXudpHod5i76Pk0dkEOadN0aKigNOX77V5NzBRfk9ud/HRgG0yhewhahAP44Uw8g92soA3ggia9uHoLboqvaHJYBES4IZOYYa88e3CVjZoykIcMGDMReTU/BfM6FZPkZJYFiir3vlfOAQt5Q9ZzJhSuRyxlPaeZpej6viwp/qc=
Received: from DM6PR11MB3225.namprd11.prod.outlook.com (20.176.120.224) by
 DM6PR11MB2860.namprd11.prod.outlook.com (20.176.96.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.12; Wed, 11 Dec 2019 11:45:05 +0000
Received: from DM6PR11MB3225.namprd11.prod.outlook.com
 ([fe80::ed7d:d06f:7d55:cbe2]) by DM6PR11MB3225.namprd11.prod.outlook.com
 ([fe80::ed7d:d06f:7d55:cbe2%6]) with mapi id 15.20.2538.012; Wed, 11 Dec 2019
 11:45:05 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <peda@axentia.se>, <sam@ravnborg.org>, <bbrezillon@kernel.org>,
        <airlied@linux.ie>, <daniel@ffwll.ch>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <lee.jones@linaro.org>
CC:     <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/5] Revert "drm/atmel-hlcdc: allow selecting a higher
 pixel-clock than requested"
Thread-Topic: [PATCH 4/5] Revert "drm/atmel-hlcdc: allow selecting a higher
 pixel-clock than requested"
Thread-Index: AQHVr11ICLJHO/IKjE+yoyNQ0RZUOA==
Date:   Wed, 11 Dec 2019 11:45:05 +0000
Message-ID: <167cb87e-b189-71fd-0a79-adf89336d1f3@microchip.com>
References: <1575984287-26787-1-git-send-email-claudiu.beznea@microchip.com>
 <1575984287-26787-5-git-send-email-claudiu.beznea@microchip.com>
 <4c3ffc48-7aa5-1e48-b0e9-a50c4eea7c38@axentia.se>
 <5fbad2cd-0dbe-0be5-833a-f7a612d48012@microchip.com>
 <2272669c-38ee-1928-9563-46755574897c@axentia.se>
In-Reply-To: <2272669c-38ee-1928-9563-46755574897c@axentia.se>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM3PR04CA0146.eurprd04.prod.outlook.com (2603:10a6:207::30)
 To DM6PR11MB3225.namprd11.prod.outlook.com (2603:10b6:5:5b::32)
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191211134458152
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 149f0763-8673-458a-b75b-08d77e2f90bc
x-ms-traffictypediagnostic: DM6PR11MB2860:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB28601B518B922837437AECFD875A0@DM6PR11MB2860.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 024847EE92
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(346002)(396003)(39860400002)(376002)(189003)(199004)(7416002)(36756003)(86362001)(81166006)(66556008)(110136005)(6512007)(31686004)(2616005)(6486002)(31696002)(66946007)(66476007)(316002)(8676002)(2906002)(71200400001)(5660300002)(478600001)(66446008)(4001150100001)(64756008)(6506007)(8936002)(4326008)(52116002)(186003)(26005)(81156014)(54906003)(53546011);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR11MB2860;H:DM6PR11MB3225.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wQkHWgJnnt+YTqNaa30cXX0QFg3UqsNjy7/Uirpu/KMSYz1aBkALWqAlTvSUcHGl+WKHiaFQIkche8ZcgJkgpV59x6QvZoy59E1I72p3p1xmEoN6DHVj1ygVre9zQoiDxhimC8LsMcU8s3JPfiUVZchQQkuYE8YJ6jRXGrsozfSORJXUhGaZFamJKJlDe7lLHGNzocFku7GAhrtkIfTubryrTZ1mwd5XBUdrQdEnWK/TnItAGraatUMHw6pWAwZEasi5pyzc/qyMWCOFPTwloICUKdirJCOiscOd7PnuylZt1HkKKoSDw5NWMrY59dCIJhIQIFxtfSkCr/fPhqKfm/7CHnN2HRH8lI1b0auVX1YxfoSQ8FGrR3cksZ0HDdxV2kwp2g2w+eSgWJ12zhUnrMNR9q3G5vtpYwDrv+VdxEjA/zpTcyZA+Vu8vr3Bfvob
Content-Type: text/plain; charset="utf-8"
Content-ID: <DB250B37A69CC644BC5A8E6C8C0A9EBD@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 149f0763-8673-458a-b75b-08d77e2f90bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2019 11:45:05.3973
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z3o+U/JYA8x8EZnCGpZXuYefdU8kmI8IqLZ7tqPxJyPuYOkcPE+MJB7rE0cx1EfJZCRUqWfl0z30yyKXiYVnl2qO/jeKsJMfkKknntX1HtQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2860
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDEwLjEyLjIwMTkgMTk6MjIsIFBldGVyIFJvc2luIHdyb3RlOg0KPiBFWFRFUk5BTCBF
TUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBr
bm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IE9uIDIwMTktMTItMTAgMTU6NTksIENsYXVk
aXUuQmV6bmVhQG1pY3JvY2hpcC5jb20gd3JvdGU6DQo+Pg0KPj4NCj4+IE9uIDEwLjEyLjIwMTkg
MTY6MTEsIFBldGVyIFJvc2luIHdyb3RlOg0KPj4+IE9uIDIwMTktMTItMTAgMTQ6MjQsIENsYXVk
aXUgQmV6bmVhIHdyb3RlOg0KPj4+PiBUaGlzIHJldmVydHMgY29tbWl0IGY2ZjdhZDMyMzQ2MTNm
NmY3ZjI3YzI1MDM2YWFmMDc4ZGUwN2U5YjAuDQo+Pj4+ICgiZHJtL2F0bWVsLWhsY2RjOiBhbGxv
dyBzZWxlY3RpbmcgYSBoaWdoZXIgcGl4ZWwtY2xvY2sgdGhhbiByZXF1ZXN0ZWQiKQ0KPj4+PiBi
ZWNhdXNlIGFsbG93aW5nIHNlbGVjdGluZyBhIGhpZ2hlciBwaXhlbCBjbG9jayBtYXkgb3ZlcmNs
b2NrDQo+Pj4+IExDRCBkZXZpY2VzLCBub3QgYWxsIG9mIHRoZW0gYmVpbmcgY2FwYWJsZSBvZiB0
aGlzLg0KPj4+DQo+Pj4gV2l0aG91dCB0aGlzIHBhdGNoLCB0aGVyZSBhcmUgcGFuZWxzIHRoYXQg
YXJlICpzZXZlcmx5KiB1bmRlcmNsb2NrZWQgKG9uIHRoZQ0KPj4+IG1hZ25pdHVkZSBvZiA0ME1I
eiBpbnN0ZWFkIG9mIDY1TUh6IG9yIHNvbWV0aGluZyBsaWtlIHRoYXQsIEkgZG9uJ3QgcmVtZW1i
ZXINCj4+PiB0aGUgZXhhY3QgZmlndXJlcykuDQo+Pg0KPj4gV2l0aCBwYXRjaCB0aGF0IHN3aXRj
aGVzIGJ5IGRlZmF1bHQgdG8gMnhzeXN0ZW0gY2xvY2sgZm9yIHBpeGVsIGNsb2NrLCBpZg0KPj4g
dXNpbmcgMTMzTUh6IHN5c3RlbSBjbG9jayAoYXMgeW91IHNwZWNpZmllZCBpbiB0aGUgcGF0Y2gg
SSBwcm9wb3NlZCBmb3INCj4+IHJldmVydCBoZXJlKSB0aGF0IHdvdWxkIGdvLCB3aXRob3V0IHRo
aXMgcGF0Y2ggYXQgNTNNSHogaWYgNjVNSHogaXMNCj4+IHJlcXVlc3RlZC4gQ29ycmVjdCBtZSBp
ZiBJJ20gd3JvbmcuDQo+IA0KPiBJdCBtaWdodCBoYXZlIGJlZW4gNTNNSHosIHdoYXRldmVyIGl0
IHdhcyBpdCB3YXMgdG9vIGxvdyBmb3IgdGhpbmdzIHRvIHdvcmsuDQo+IA0KPj4+IEFuZCB0aGV5
IGFyZSBvZiBjb3Vyc2Ugbm90IGNhcGFibGUgb2YgdGhhdC4gQWxsIHBhbmVscw0KPj4+IGhhdmUg
KnNvbWUqIHNsYWNrIGFzIHRvIHdoYXQgZnJlcXVlbmNpZXMgYXJlIHN1cHBvcnRlZCwgYW5kIHRo
ZSBwYXRjaCB3YXMNCj4+PiB3cml0dGVuIHVuZGVyIHRoZSBhc3N1bXB0aW9uIHRoYXQgdGhlIHBy
ZWZlcnJlZCBmcmVxdWVuY3kgb2YgdGhlIHBhbmVsIHdhcw0KPj4+IHJlcXVlc3RlZCwgd2hpY2gg
c2hvdWxkIGxlYXZlIGF0IGxlYXN0IGEgKmxpdHRsZSogaGVhZHJvb20uDQo+Pg0KPj4gSSBzZWUs
IGJ1dCBmcm9tIG15IHBvaW50IG9mIHZpZXcsIHRoZSB1cHBlciBsYXllcnMgc2hvdWxkIGRlY2lk
ZSB3aGF0DQo+PiBmcmVxdWVuY3kgc2V0dGluZ3Mgc2hvdWxkIGJlIGRvbmUgb24gdGhlIExDRCBj
b250cm9sbGVyIGFuZCBub3QgbGV0IHRoaXMgYXQNCj4+ICB0aGUgZHJpdmVyJ3MgbGF0aXR1ZGUu
DQo+IA0KPiBSaWdodCwgYnV0IHRoZSB1cHBlciBsYXllcnMgZG8gbm90IHN1cHBvcnQgbmVnb3Rp
YXRpbmcgYSBmcmVxdWVuY3kgZnJvbQ0KPiByYW5nZXMuIEF0IGxlYXN0IHRoZSBkaWRuJ3Qgd2hl
biB0aGUgcGF0Y2ggd2FzIHdyaXR0ZW4sIGFuZCBpbXBsZW1lbnRpbmcNCj4gKnRoYXQqIHNlZW1l
ZCBsaWtlIGEgaHVnZSB1bmRlcnRha2luZy4NCj4gDQo+Pj4NCj4+PiBTbywgSSdtIGN1cmlvdXMg
YXMgdG8gd2hhdCBwYW5lbCByZWdyZXNzZWQuIE9yIHJhdGhlciwgd2hhdCBwaXhlbC1jbG9jayBp
dCBuZWVkcw0KPj4+IGFuZCB3aGF0IGl0IGdldHMgd2l0aC93aXRob3V0IHRoZSBwYXRjaD8NCj4+
DQo+PiBJIGhhdmUgMiB1c2UgY2FzZXM6DQo+PiAxLyBzeXN0ZW0gY2xvY2sgPSAyMDBNSHogYW5k
IHJlcXVlc3RlZCBwaXhlbCBjbG9jayAobW9kZV9yYXRlKSB+NzFNSHouIFdpdGgNCj4+IHRoZSBy
ZXZlcnRlZCBwYXRjaCB0aGUgcmVzdWx0ZWQgY29tcHV0ZWQgcGl4ZWwgY2xvY2sgd291bGQgYmUg
ODBNSHouDQo+PiBQcmV2aW91c2x5IGl0IHdhcyBhdCA2Nk1Ieg0KPiANCj4gSSBkb24ndCBzZWUg
aG93IHRoYXQncyBwb3NzaWJsZS4NCj4gDQo+IFtkb2luZyBzb21lIGNhbGN1bGF0aW9uIGJ5IGhh
bmRdDQo+IA0KPiBBcnJnaC4gKmJsdXNoKg0KPiANCj4gVGhlIGNvZGUgZG9lcyBub3QgZG8gd2hh
dCBJIGludGVuZGVkIGZvciBpdCB0byBkby4NCj4gQ2FuIHlvdSBwbGVhc2UgdHJ5IHRoaXMgaW5z
dGVhZCBvZiByZXZlcnRpbmc/DQo+IA0KPiBDaGVlcnMsDQo+IFBldGVyDQo+IA0KPiBGcm9tIGIz
ZTg2ZDU1YjhkMTA3YTVjMDdlOThmODc5YzY3ZjY3MTIwYzg3YTYgTW9uIFNlcCAxNyAwMDowMDow
MCAyMDAxDQo+IEZyb206IFBldGVyIFJvc2luIDxwZWRhQGF4ZW50aWEuc2U+DQo+IERhdGU6IFR1
ZSwgMTAgRGVjIDIwMTkgMTg6MTE6MjggKzAxMDANCj4gU3ViamVjdDogW1BBVENIXSBkcm0vYXRt
ZWwtaGxjZGM6IHByZWZlciBhIGxvd2VyIHBpeGVsLWNsb2NrIHRoYW4gcmVxdWVzdGVkDQo+IA0K
PiBUaGUgaW50ZW50aW9uIHdhcyB0byBvbmx5IHNlbGVjdCBhIGhpZ2hlciBwaXhlbC1jbG9jayBy
YXRlIHRoYW4gdGhlDQo+IHJlcXVlc3RlZCwgaWYgYSBzbGlnaHQgb3ZlcmNsb2NraW5nIHdvdWxk
IHJlc3VsdCBpbiBhIHJhdGUgc2lnbmlmaWNhbnRseQ0KPiBjbG9zZXIgdG8gdGhlIHJlcXVlc3Rl
ZCByYXRlIHRoYW4gaWYgdGhlIGNvbnNlcnZhdGl2ZSBsb3dlciBwaXhlbC1jbG9jaw0KPiByYXRl
IGlzIHNlbGVjdGVkLiBUaGUgZml4ZWQgcGF0Y2ggaGFzIHRoZSBsb2dpYyB0aGUgb3RoZXIgd2F5
IGFyb3VuZCBhbmQNCj4gYWN0dWFsbHkgcHJlZmVycyB0aGUgaGlnaGVyIGZyZXF1ZW5jeS4gRml4
IHRoYXQuDQo+IA0KPiBGaXhlczogZjZmN2FkMzIzNDYxICgiZHJtL2F0bWVsLWhsY2RjOiBhbGxv
dyBzZWxlY3RpbmcgYSBoaWdoZXIgcGl4ZWwtY2xvY2sgdGhhbiByZXF1ZXN0ZWQiKQ0KPiBSZXBv
cnRlZC1ieTogQ2xhdWRpdSBCZXpuZWEgPGNsYXVkaXUuYmV6bmVhQG1pY3JvY2hpcC5jb20+DQo+
IFNpZ25lZC1vZmYtYnk6IFBldGVyIFJvc2luIDxwZWRhQGF4ZW50aWEuc2U+DQo+IC0tLQ0KPiAg
ZHJpdmVycy9ncHUvZHJtL2F0bWVsLWhsY2RjL2F0bWVsX2hsY2RjX2NydGMuYyB8IDQgKystLQ0K
PiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYXRtZWwtaGxjZGMvYXRtZWxfaGxjZGNfY3J0
Yy5jIGIvZHJpdmVycy9ncHUvZHJtL2F0bWVsLWhsY2RjL2F0bWVsX2hsY2RjX2NydGMuYw0KPiBp
bmRleCA5ZTM0YmNlMDg5ZDAuLjAzNjkxODQ1ZDM3YSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9n
cHUvZHJtL2F0bWVsLWhsY2RjL2F0bWVsX2hsY2RjX2NydGMuYw0KPiArKysgYi9kcml2ZXJzL2dw
dS9kcm0vYXRtZWwtaGxjZGMvYXRtZWxfaGxjZGNfY3J0Yy5jDQo+IEBAIC0xMjAsOCArMTIwLDgg
QEAgc3RhdGljIHZvaWQgYXRtZWxfaGxjZGNfY3J0Y19tb2RlX3NldF9ub2ZiKHN0cnVjdCBkcm1f
Y3J0YyAqYykNCj4gICAgICAgICAgICAgICAgIGludCBkaXZfbG93ID0gcHJhdGUgLyBtb2RlX3Jh
dGU7DQo+IA0KPiAgICAgICAgICAgICAgICAgaWYgKGRpdl9sb3cgPj0gMiAmJg0KPiAtICAgICAg
ICAgICAgICAgICAgICgocHJhdGUgLyBkaXZfbG93IC0gbW9kZV9yYXRlKSA8DQo+IC0gICAgICAg
ICAgICAgICAgICAgIDEwICogKG1vZGVfcmF0ZSAtIHByYXRlIC8gZGl2KSkpDQo+ICsgICAgICAg
ICAgICAgICAgICAgKDEwICogKHByYXRlIC8gZGl2X2xvdyAtIG1vZGVfcmF0ZSkgPA0KPiArICAg
ICAgICAgICAgICAgICAgICAobW9kZV9yYXRlIC0gcHJhdGUgLyBkaXYpKSkNCg0KSSB0ZXN0ZWQg
aXQgb24gbXkgc2V0dXAgKEkgaGF2ZSBvbmx5IG9uZSBvZiB0aG9zZSBzcGVjaWZpZWQgYWJvdmUp
IGFuZCBpdA0KaXMgT0suIERvaW5nIHNvbWUgbWF0aCBmb3IgdGhlIG90aGVyIHNldHVwIGl0IHNo
b3VsZCBhbHNvIGJlIE9LLg0KDQpBcyBhIHdob2xlLCBJJ20gT0sgd2l0aCB0aGlzIGF0IHRoZSBt
b21lbnQgKGxldCdzIGhvcGUgaXQgd2lsbCB3b3JrIGZvciBhbGwNCnVzZS1jYXNlcykgYnV0IHN0
aWxsIEkgYW0gbm90IE9LIHdpdGggc2VsZWN0aW5nIGhlcmUsIGluIHRoZSBkcml2ZXIsDQpzb21l
dGhpbmcgdGhhdCBtaWdodCB3b3JrLiBBbHRob3VnaCBJIGFtIG5vdCBmYW1pbGlhciB3aXRoIGhv
dyBvdGhlciBEUk0NCmRyaXZlcnMgYXJlIGhhbmRsaW5nIHRoaXMga2luZCBvZiBzY2VuYXJpb3Mu
IE1heWJlIHlvdSBhbmQvb3Igb3RoZXIgRFJNDQpndXlzIGtub3dzIG1vcmUgYWJvdXQgaXQuDQoN
Ckp1c3QgYXMgYSBub3RpY2UsIGl0IG1heSB3b3J0aCBhZGRpbmcgYSBwcmludCBtZXNzYWdlIHNh
eWluZyB3aGF0IHdhcw0KZnJlcXVlbmN5IHdhcyByZXF1ZXN0ZWQgYW5kIHdoYXQgZnJlcXVlbmN5
IGhhcyBiZWVuIHNldHVwIGJ5IGRyaXZlci4NCg0KPiAgICAgICAgICAgICAgICAgICAgICAgICAv
Kg0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgKiBBdCBsZWFzdCAxMCB0aW1lcyBiZXR0ZXIg
d2hlbiB1c2luZyBhIGhpZ2hlcg0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgKiBmcmVxdWVu
Y3kgdGhhbiByZXF1ZXN0ZWQsIGluc3RlYWQgb2YgYSBsb3dlci4NCj4gLS0NCj4gMi4yMC4xDQo+
IA0K
