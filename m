Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F6FC32771
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 09:25:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8E962072C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 09:25:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="HitOQ6uZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbgAFJY7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 04:24:59 -0500
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:6829 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbgAFJY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 04:24:59 -0500
Received-SPF: Pass (esa3.microchip.iphmx.com: domain of
  Claudiu.Beznea@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="Claudiu.Beznea@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com -exists:%{i}.spf.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa3.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa3.microchip.iphmx.com; spf=Pass smtp.mailfrom=Claudiu.Beznea@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: 2BZd56lg6Xwwa8rZYLVuK5VrQdQF5bOYDHhmpbOKV/XoeMce4UR78EEcktrv4UlQrXK5VterbO
 CqW2b8m1DpuCSzespbVRpzWwOxilI4EXO1wyRLU6xPggEHaGSZIaVXinxgtjPsfP23tZTnyVdN
 cm2Z/x4Q02wocirRRI7KQz0bRaj1Ro3FsfomVskoa4ErEFoAkAFhhOWjIaHhtlW68+MWnVPWWO
 lMfEoTekPm7AadUr0HBa2j3wnIwAghFL75Q/jZ3kQWkyr01nNcYS39b19uumvDtAvzfVX7WHsh
 444=
X-IronPort-AV: E=Sophos;i="5.69,402,1571727600"; 
   d="scan'208";a="62299538"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Jan 2020 02:24:57 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 6 Jan 2020 02:24:54 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 6 Jan 2020 02:24:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XlA7tPQ/IOe7ED1I5e0GA9p7SMbz1dwl7ReYpLxhKvmWVYStTQNOYG5TpekOZtsHcVspaj858Pub1s84Ob0pEgpdm5c2q1i0ESVd1l2Vc+FhR2UXwIYvSpIyU6hc3kSdN8fAj3ym9ATYXYgXy3jKFjGKDbfLsmCSZFRjbC2tvcWgDCWTwEW1J4juKAg0ovhoZhcL7qKpzVeCx4I3LIjbhXJ/MKvt6uMgoud0AaSsS7jloD+PrgC5ggwrrMskjHMZLYktR9WSxETOLuQLfDuTvnkzYodrjprFhoBt4IvyWhwW3Rf63g0tTWYQgjcvkcs0DrKrAV7q3grBp5lXD5dyJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/rh9aNqo5n5LkVfP2WVL1yJvZPQJn0nB6mkWJ0BhoAU=;
 b=IJHsLxddh3IPOyQlT9M+EMz8QODsK3OXiD88CYfirEwdKUBdn4Py/8YQlUqEyszJUmz72mDIKoiWB+q3KjzFjhCEmljd/5/vw+jBQkM34yzrh1WquX+YvbmShfALQJVk388P6P4q5Kn3PWWQOaiiH3+9a4zM7DzZ8+KB1IoCaCDb/Jcx001+NhhFeCT1d3WYo/Mfc1Ku9e8a08KnbFv1ctw7lYfTsx3Uj2dJTKoo/0zdEhQfyQYvJvK1fhCWE+cx5yXGiUZ9Src0ycXfdbWauq3Ttya5thz+JUavnNSolnzMh3OHQ8Am8UMrmwApyUDmhzwAI+MZ6i7718DfAYVpCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/rh9aNqo5n5LkVfP2WVL1yJvZPQJn0nB6mkWJ0BhoAU=;
 b=HitOQ6uZpPOwU3nasNvJsiCqHIMfxX/nAThfp8XZqv0phwqFenZ0cOgk9fM81u0zpjPr9vGbzvsQV9gFrUGucA8Y/2YaAPswrwJnZXb6xj3z7cOFSsIv7wyz8svP2RiRguzVjE6zzvMfa2JaJcq9k0Wsgx0AmDL1MoGw5NK/ROI=
Received: from DM6PR11MB3225.namprd11.prod.outlook.com (20.176.120.224) by
 DM6PR11MB4267.namprd11.prod.outlook.com (52.132.248.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.13; Mon, 6 Jan 2020 09:24:52 +0000
Received: from DM6PR11MB3225.namprd11.prod.outlook.com
 ([fe80::106f:424f:ac54:1dbb]) by DM6PR11MB3225.namprd11.prod.outlook.com
 ([fe80::106f:424f:ac54:1dbb%7]) with mapi id 15.20.2602.015; Mon, 6 Jan 2020
 09:24:52 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <sam@ravnborg.org>
CC:     <boris.brezillon@bootlin.com>, <airlied@linux.ie>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <lee.jones@linaro.org>, <peda@axentia.se>,
        <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 5/6] drm: atmel-hlcdc: prefer a lower pixel-clock than
 requested
Thread-Topic: [PATCH v3 5/6] drm: atmel-hlcdc: prefer a lower pixel-clock than
 requested
Thread-Index: AQHVxHMmEp4Pw+8WakiQvTSsv/2xSA==
Date:   Mon, 6 Jan 2020 09:24:52 +0000
Message-ID: <64902ae8-ef5a-a94a-8edf-05159699b72c@microchip.com>
References: <1576672109-22707-1-git-send-email-claudiu.beznea@microchip.com>
 <1576672109-22707-6-git-send-email-claudiu.beznea@microchip.com>
 <20200102090848.GC29446@ravnborg.org>
In-Reply-To: <20200102090848.GC29446@ravnborg.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: da646c3e-f9b8-422e-b5aa-08d7928a48f5
x-ms-traffictypediagnostic: DM6PR11MB4267:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB42673924A3DA4C916580902A873C0@DM6PR11MB4267.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0274272F87
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(366004)(396003)(39860400002)(136003)(199004)(189003)(6486002)(478600001)(31686004)(86362001)(6512007)(71200400001)(5660300002)(53546011)(6506007)(26005)(6916009)(2616005)(4326008)(76116006)(91956017)(36756003)(8936002)(316002)(66946007)(31696002)(66556008)(186003)(64756008)(2906002)(66476007)(81166006)(81156014)(8676002)(54906003)(66446008)(341764005);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR11MB4267;H:DM6PR11MB3225.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AtxUO7lJyPE/HmtazA5qu11dheXa94oParEFVZxe432vWXENVot+IvGzvjdDAMA0n5P0xE0PeYFeVQ9bDbjKI01bQ0jmRij3rJAPfNr5t8O9+Ti8pygHtKcg6a8wYPT27xT9X06UvxczIJFQzyEjY4cVU+fzqDtEbqUWlC4UT6rtUF8n7hMC5aZiGWoulzeye4bdlBAFVCu4saLcqQFr55FJRi9ypvnPruPDWTyi62gMAZVQa6LzovqcvEA3MP7wkGxfeem249vyamwS7NlA8Vz1YEqy0PCWjEpSqHajd+Xeu0qe7Xgdq4aTWmOpPC6pHg7uxxN6GW5rCq6DmHkEhNfbOdtqZCoC20pMR3OhJKPpVtef+vcsN1aNn0AxNXr2E0QNi/uM9DreebI78N7s1mSvcy7J/Q0r4ZaVv/ukVittLZA07vUukCSmRBH/1dtR6YiITKS4M8gEjooepYNmN0njWlJZnOvI5+AqalGao1icPF5nQHGavx96uf1jCF1O
Content-Type: text/plain; charset="utf-8"
Content-ID: <15361D37B1196A4E85FED38C025D31C9@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: da646c3e-f9b8-422e-b5aa-08d7928a48f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2020 09:24:52.3069
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bI+26/ilveq9TheOYFDbsu9FurIgSfcd943Sgj59RIotSRaHReiIEo405F9JuJIJAU2F9c3OGPH9X9nAJOCbeHAYgkqcTrMb/DKuwUx0BmA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4267
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDAyLjAxLjIwMjAgMTE6MDgsIFNhbSBSYXZuYm9yZyB3cm90ZToNCj4gT24gV2VkLCBE
ZWMgMTgsIDIwMTkgYXQgMDI6Mjg6MjhQTSArMDIwMCwgQ2xhdWRpdSBCZXpuZWEgd3JvdGU6DQo+
PiBGcm9tOiBQZXRlciBSb3NpbiA8cGVkYUBheGVudGlhLnNlPg0KPj4NCj4+IFRoZSBpbnRlbnRp
b24gd2FzIHRvIG9ubHkgc2VsZWN0IGEgaGlnaGVyIHBpeGVsLWNsb2NrIHJhdGUgdGhhbiB0aGUN
Cj4+IHJlcXVlc3RlZCwgaWYgYSBzbGlnaHQgb3ZlcmNsb2NraW5nIHdvdWxkIHJlc3VsdCBpbiBh
IHJhdGUgc2lnbmlmaWNhbnRseQ0KPj4gY2xvc2VyIHRvIHRoZSByZXF1ZXN0ZWQgcmF0ZSB0aGFu
IGlmIHRoZSBjb25zZXJ2YXRpdmUgbG93ZXIgcGl4ZWwtY2xvY2sNCj4+IHJhdGUgaXMgc2VsZWN0
ZWQuIFRoZSBmaXhlZCBwYXRjaCBoYXMgdGhlIGxvZ2ljIHRoZSBvdGhlciB3YXkgYXJvdW5kIGFu
ZA0KPj4gYWN0dWFsbHkgcHJlZmVycyB0aGUgaGlnaGVyIGZyZXF1ZW5jeS4gRml4IHRoYXQuDQo+
Pg0KPj4gRml4ZXM6IGY2ZjdhZDMyMzQ2MSAoImRybS9hdG1lbC1obGNkYzogYWxsb3cgc2VsZWN0
aW5nIGEgaGlnaGVyIHBpeGVsLWNsb2NrIHRoYW4gcmVxdWVzdGVkIikNCj4gVGhlIGlkIGlzIHdy
b25nIGhlcmUgLSB0aGUgcmlnaHQgb25lIGlzOiA5OTQ2YTNhOWRiZWRhYWFjZWY4YjdlOTRmNmFj
MTQ0ZjFkYWFmMWRlDQoNClJpZ2h0ISBTb3JyeSBmb3IgdGhpcyBvbmUhIFRoYW5rIHlvdSBmb3Ig
Zml4aW5nIGl0IHVwLg0KDQpDbGF1ZGl1IEJlem5lYQ0KDQo+IFRoZSB3cm9uZyBpZCBhYm92ZSB3
YXMgdXNlZCBiZWZvcmUgLSBzbyBJIHRoaW5rIGl0IGlzIGEgY29weSduJ3Bhc3RlDQo+IHRoaW5n
Lg0KPiANCj4gSGludDogdHJ5ICJkaW0gZml4ZXMgOTk0NmEzYTlkYmVkYWFhY2VmOGI3ZTk0ZjZh
YzE0NGYxZGFhZjFkZSINCj4gDQo+IElmIEkgZ2V0IGEgcXVpY2sgcmVzcG9uc2UgZnJvbSBMZWUg
SSBjYW4gZml4IGl0IHVwIHdoaWxlIGFwcGx5aW5nLg0KPiANCj4gICAgICAgICBTYW0NCj4gDQo+
PiBSZXBvcnRlZC1ieTogQ2xhdWRpdSBCZXpuZWEgPGNsYXVkaXUuYmV6bmVhQG1pY3JvY2hpcC5j
b20+DQo+PiBUZXN0ZWQtYnk6IENsYXVkaXUgQmV6bmVhIDxjbGF1ZGl1LmJlem5lYUBtaWNyb2No
aXAuY29tPg0KPj4gU2lnbmVkLW9mZi1ieTogUGV0ZXIgUm9zaW4gPHBlZGFAYXhlbnRpYS5zZT4N
Cj4+IC0tLQ0KPj4gIGRyaXZlcnMvZ3B1L2RybS9hdG1lbC1obGNkYy9hdG1lbF9obGNkY19jcnRj
LmMgfCA0ICsrLS0NCj4+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0
aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYXRtZWwtaGxjZGMv
YXRtZWxfaGxjZGNfY3J0Yy5jIGIvZHJpdmVycy9ncHUvZHJtL2F0bWVsLWhsY2RjL2F0bWVsX2hs
Y2RjX2NydGMuYw0KPj4gaW5kZXggNzIxZmE4OGJmNzFkLi4xMDk4NTEzNGNlMGIgMTAwNjQ0DQo+
PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYXRtZWwtaGxjZGMvYXRtZWxfaGxjZGNfY3J0Yy5jDQo+
PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYXRtZWwtaGxjZGMvYXRtZWxfaGxjZGNfY3J0Yy5jDQo+
PiBAQCAtMTIxLDggKzEyMSw4IEBAIHN0YXRpYyB2b2lkIGF0bWVsX2hsY2RjX2NydGNfbW9kZV9z
ZXRfbm9mYihzdHJ1Y3QgZHJtX2NydGMgKmMpDQo+PiAgICAgICAgICAgICAgIGludCBkaXZfbG93
ID0gcHJhdGUgLyBtb2RlX3JhdGU7DQo+Pg0KPj4gICAgICAgICAgICAgICBpZiAoZGl2X2xvdyA+
PSAyICYmDQo+PiAtICAgICAgICAgICAgICAgICAoKHByYXRlIC8gZGl2X2xvdyAtIG1vZGVfcmF0
ZSkgPA0KPj4gLSAgICAgICAgICAgICAgICAgIDEwICogKG1vZGVfcmF0ZSAtIHByYXRlIC8gZGl2
KSkpDQo+PiArICAgICAgICAgICAgICAgICAoMTAgKiAocHJhdGUgLyBkaXZfbG93IC0gbW9kZV9y
YXRlKSA8DQo+PiArICAgICAgICAgICAgICAgICAgKG1vZGVfcmF0ZSAtIHByYXRlIC8gZGl2KSkp
DQo+PiAgICAgICAgICAgICAgICAgICAgICAgLyoNCj4+ICAgICAgICAgICAgICAgICAgICAgICAg
KiBBdCBsZWFzdCAxMCB0aW1lcyBiZXR0ZXIgd2hlbiB1c2luZyBhIGhpZ2hlcg0KPj4gICAgICAg
ICAgICAgICAgICAgICAgICAqIGZyZXF1ZW5jeSB0aGFuIHJlcXVlc3RlZCwgaW5zdGVhZCBvZiBh
IGxvd2VyLg0KPj4gLS0NCj4+IDIuNy40DQo+IA==
