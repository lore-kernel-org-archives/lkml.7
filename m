Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 192F3C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 17:23:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE07E2077B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 17:23:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="b6I/X2gn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbfLJRXG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 12:23:06 -0500
Received: from mail-eopbgr150125.outbound.protection.outlook.com ([40.107.15.125]:34566
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727561AbfLJRXF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 12:23:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dj4RO5GdrGGL818zgMCLRYNKR4nwtuF4lN4p1ijsrmO7zWAASVmZaUEZrYDeVNxkYwVF4FimmjHH04gwlseqgXfn1edGQbYtplkGv+40qBOv8P/9PYAExBf1fuPFWoQOXauD/bu7Ir1QJYFd1H09D6C7Fpr9qR44fjRzmxYyDcZ6Pi1UwfuZ0owEd6VZJkh/bUc7VDl+Y20pLdu7VGX9ZlYrb4iJP6xVRtbOEDMjwxwhnl1vzRLBqQKVHQoLXGN5Wc5F+g4Rvij7e2+TMlaY3HJIfatkbobxZ5ES9fU2aIRB2bN8b+DQZFQQADNie3/mP5BitdzjEyivp6ZUGFt49Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HgN6TM3hsDnuQ8kp6yYGCwfMb96CSmuVN2j36F1JCVE=;
 b=JLIvjpgHUo3v289XG21j9pwKknIByGKr5/Bb20yql2gxvWApdKubb5oI+bQG1Lkwng6MRahaYr88BxL0CUfNifiEM5NYieG6SfHOrd8OnN68OIrEFYfM4cfsYfG8LovpvAbcX8Go/enihN86hJOEznYOP7zcvIJzOgWM+ypPYSi361iWfApvp1rBc6VMd9jY69Mns8d/Z7ks9XG19Is3BIPcnlyUFr93PWLubC2jZKewqPTIvEMxSdfcV1iZoucIqfhaRcZX2FAI1XlwG/lYFvFzugoPmichTpmfv+QkEWdob2IqrEaNJyDRR8jZ1zKLJ7YsOWO88OljSMZsGsc6MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HgN6TM3hsDnuQ8kp6yYGCwfMb96CSmuVN2j36F1JCVE=;
 b=b6I/X2gnCwn+i7tNsDKdKb7btOBfCLzsJ64TCBXFN7YTXg+EFl9fJikcry385U/UmriyrZqnBDUFHre5ziKsaZfU0kKyb3PQgtywvXO9HD113j9shm8ByZOzIEntBq8dNHQ0HScRbl0RQkOn7Bsh/G3FOVjKQ42fNP705//xJo8=
Received: from DB3PR0202MB3434.eurprd02.prod.outlook.com (52.134.66.158) by
 DB3PR0202MB3404.eurprd02.prod.outlook.com (52.134.68.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.17; Tue, 10 Dec 2019 17:22:59 +0000
Received: from DB3PR0202MB3434.eurprd02.prod.outlook.com
 ([fe80::446e:c4f8:7e59:1c6d]) by DB3PR0202MB3434.eurprd02.prod.outlook.com
 ([fe80::446e:c4f8:7e59:1c6d%7]) with mapi id 15.20.2516.018; Tue, 10 Dec 2019
 17:22:59 +0000
From:   Peter Rosin <peda@axentia.se>
To:     "Claudiu.Beznea@microchip.com" <Claudiu.Beznea@microchip.com>,
        "sam@ravnborg.org" <sam@ravnborg.org>,
        "bbrezillon@kernel.org" <bbrezillon@kernel.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "Nicolas.Ferre@microchip.com" <Nicolas.Ferre@microchip.com>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "Ludovic.Desroches@microchip.com" <Ludovic.Desroches@microchip.com>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>
CC:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/5] Revert "drm/atmel-hlcdc: allow selecting a higher
 pixel-clock than requested"
Thread-Topic: [PATCH 4/5] Revert "drm/atmel-hlcdc: allow selecting a higher
 pixel-clock than requested"
Thread-Index: AQHVr11DyxIz9S+dLEWyrkArJlSyg6ezeYGA///8moCAACgWAA==
Date:   Tue, 10 Dec 2019 17:22:59 +0000
Message-ID: <2272669c-38ee-1928-9563-46755574897c@axentia.se>
References: <1575984287-26787-1-git-send-email-claudiu.beznea@microchip.com>
 <1575984287-26787-5-git-send-email-claudiu.beznea@microchip.com>
 <4c3ffc48-7aa5-1e48-b0e9-a50c4eea7c38@axentia.se>
 <5fbad2cd-0dbe-0be5-833a-f7a612d48012@microchip.com>
In-Reply-To: <5fbad2cd-0dbe-0be5-833a-f7a612d48012@microchip.com>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
x-originating-ip: [213.112.138.100]
x-clientproxiedby: HE1PR05CA0158.eurprd05.prod.outlook.com
 (2603:10a6:7:28::45) To DB3PR0202MB3434.eurprd02.prod.outlook.com
 (2603:10a6:8:5::30)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f5b200d6-3e3d-4dd8-e48d-08d77d959a60
x-ms-traffictypediagnostic: DB3PR0202MB3404:
x-microsoft-antispam-prvs: <DB3PR0202MB3404FB03D7D4B79D2D8C093CBC5B0@DB3PR0202MB3404.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 02475B2A01
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(39840400004)(346002)(396003)(136003)(189003)(199004)(2616005)(36756003)(6486002)(66476007)(4001150100001)(31686004)(316002)(81166006)(66946007)(66446008)(508600001)(64756008)(66556008)(4326008)(86362001)(26005)(6512007)(53546011)(2906002)(54906003)(186003)(7416002)(52116002)(81156014)(31696002)(8936002)(8676002)(71200400001)(6506007)(5660300002)(110136005);DIR:OUT;SFP:1102;SCL:1;SRVR:DB3PR0202MB3404;H:DB3PR0202MB3434.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hbhh7sNwcJR+jAohzN4/z9SxPwL49VDMzyeQuwInotkK5KgOQrUFk7CNhedaAzgCUA9D04u0G1tPkOIxMY4Lh+X5/FtqTXj/Ck5SSWMwm2ZwZv8KbpX9KHqiKwmfQ09qmwC1SFaRT9r+3WlUPE0+DTYhmqIkash17NGTwOapCbREhzXA72CewIwvY95Ao5nqicgwIrvWKmoy+nHXFxcaJqUkhvncgnXKfWLIWh8aX4THbYNKP7teyKxu8GnC7OsfXDabK/xBcQ5crao2BdhE/eIV0I37RYUP7NdH7YvvvHBGpUCChvsflXgIsTPqkzQeJcgD6abNHm5K7gRm9VqK4+oYOSXiQQKIdTl3Xma/mwKs4oBYU250efqX61FVUCLX8pBJ4Pu1qUpKM62Aync8Y9jmStkmwQMO1OA4oXDJhfWo0YEsnZkYivPbjptNGOcz
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <A9E8A3325A99654699E1B825FC51ECCC@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: f5b200d6-3e3d-4dd8-e48d-08d77d959a60
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2019 17:22:59.1933
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kT2mTsS0ZoZwTo6Gr5jeIc8W62MJ0u/U+VfnLh2luKNqwCrZTiV550uhEzq7Jx1J
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0202MB3404
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAxOS0xMi0xMCAxNTo1OSwgQ2xhdWRpdS5CZXpuZWFAbWljcm9jaGlwLmNvbSB3cm90ZToN
Cj4gDQo+IA0KPiBPbiAxMC4xMi4yMDE5IDE2OjExLCBQZXRlciBSb3NpbiB3cm90ZToNCj4+IE9u
IDIwMTktMTItMTAgMTQ6MjQsIENsYXVkaXUgQmV6bmVhIHdyb3RlOg0KPj4+IFRoaXMgcmV2ZXJ0
cyBjb21taXQgZjZmN2FkMzIzNDYxM2Y2ZjdmMjdjMjUwMzZhYWYwNzhkZTA3ZTliMC4NCj4+PiAo
ImRybS9hdG1lbC1obGNkYzogYWxsb3cgc2VsZWN0aW5nIGEgaGlnaGVyIHBpeGVsLWNsb2NrIHRo
YW4gcmVxdWVzdGVkIikNCj4+PiBiZWNhdXNlIGFsbG93aW5nIHNlbGVjdGluZyBhIGhpZ2hlciBw
aXhlbCBjbG9jayBtYXkgb3ZlcmNsb2NrDQo+Pj4gTENEIGRldmljZXMsIG5vdCBhbGwgb2YgdGhl
bSBiZWluZyBjYXBhYmxlIG9mIHRoaXMuDQo+Pg0KPj4gV2l0aG91dCB0aGlzIHBhdGNoLCB0aGVy
ZSBhcmUgcGFuZWxzIHRoYXQgYXJlICpzZXZlcmx5KiB1bmRlcmNsb2NrZWQgKG9uIHRoZQ0KPj4g
bWFnbml0dWRlIG9mIDQwTUh6IGluc3RlYWQgb2YgNjVNSHogb3Igc29tZXRoaW5nIGxpa2UgdGhh
dCwgSSBkb24ndCByZW1lbWJlcg0KPj4gdGhlIGV4YWN0IGZpZ3VyZXMpLiANCj4gDQo+IFdpdGgg
cGF0Y2ggdGhhdCBzd2l0Y2hlcyBieSBkZWZhdWx0IHRvIDJ4c3lzdGVtIGNsb2NrIGZvciBwaXhl
bCBjbG9jaywgaWYNCj4gdXNpbmcgMTMzTUh6IHN5c3RlbSBjbG9jayAoYXMgeW91IHNwZWNpZmll
ZCBpbiB0aGUgcGF0Y2ggSSBwcm9wb3NlZCBmb3INCj4gcmV2ZXJ0IGhlcmUpIHRoYXQgd291bGQg
Z28sIHdpdGhvdXQgdGhpcyBwYXRjaCBhdCA1M01IeiBpZiA2NU1IeiBpcw0KPiByZXF1ZXN0ZWQu
IENvcnJlY3QgbWUgaWYgSSdtIHdyb25nLg0KDQpJdCBtaWdodCBoYXZlIGJlZW4gNTNNSHosIHdo
YXRldmVyIGl0IHdhcyBpdCB3YXMgdG9vIGxvdyBmb3IgdGhpbmdzIHRvIHdvcmsuDQoNCj4+IEFu
ZCB0aGV5IGFyZSBvZiBjb3Vyc2Ugbm90IGNhcGFibGUgb2YgdGhhdC4gQWxsIHBhbmVscw0KPj4g
aGF2ZSAqc29tZSogc2xhY2sgYXMgdG8gd2hhdCBmcmVxdWVuY2llcyBhcmUgc3VwcG9ydGVkLCBh
bmQgdGhlIHBhdGNoIHdhcw0KPj4gd3JpdHRlbiB1bmRlciB0aGUgYXNzdW1wdGlvbiB0aGF0IHRo
ZSBwcmVmZXJyZWQgZnJlcXVlbmN5IG9mIHRoZSBwYW5lbCB3YXMNCj4+IHJlcXVlc3RlZCwgd2hp
Y2ggc2hvdWxkIGxlYXZlIGF0IGxlYXN0IGEgKmxpdHRsZSogaGVhZHJvb20uDQo+IA0KPiBJIHNl
ZSwgYnV0IGZyb20gbXkgcG9pbnQgb2YgdmlldywgdGhlIHVwcGVyIGxheWVycyBzaG91bGQgZGVj
aWRlIHdoYXQNCj4gZnJlcXVlbmN5IHNldHRpbmdzIHNob3VsZCBiZSBkb25lIG9uIHRoZSBMQ0Qg
Y29udHJvbGxlciBhbmQgbm90IGxldCB0aGlzIGF0DQo+ICB0aGUgZHJpdmVyJ3MgbGF0aXR1ZGUu
DQoNClJpZ2h0LCBidXQgdGhlIHVwcGVyIGxheWVycyBkbyBub3Qgc3VwcG9ydCBuZWdvdGlhdGlu
ZyBhIGZyZXF1ZW5jeSBmcm9tDQpyYW5nZXMuIEF0IGxlYXN0IHRoZSBkaWRuJ3Qgd2hlbiB0aGUg
cGF0Y2ggd2FzIHdyaXR0ZW4sIGFuZCBpbXBsZW1lbnRpbmcNCip0aGF0KiBzZWVtZWQgbGlrZSBh
IGh1Z2UgdW5kZXJ0YWtpbmcuDQoNCj4+DQo+PiBTbywgSSdtIGN1cmlvdXMgYXMgdG8gd2hhdCBw
YW5lbCByZWdyZXNzZWQuIE9yIHJhdGhlciwgd2hhdCBwaXhlbC1jbG9jayBpdCBuZWVkcw0KPj4g
YW5kIHdoYXQgaXQgZ2V0cyB3aXRoL3dpdGhvdXQgdGhlIHBhdGNoPw0KPiANCj4gSSBoYXZlIDIg
dXNlIGNhc2VzOg0KPiAxLyBzeXN0ZW0gY2xvY2sgPSAyMDBNSHogYW5kIHJlcXVlc3RlZCBwaXhl
bCBjbG9jayAobW9kZV9yYXRlKSB+NzFNSHouIFdpdGgNCj4gdGhlIHJldmVydGVkIHBhdGNoIHRo
ZSByZXN1bHRlZCBjb21wdXRlZCBwaXhlbCBjbG9jayB3b3VsZCBiZSA4ME1Iei4NCj4gUHJldmlv
dXNseSBpdCB3YXMgYXQgNjZNSHoNCg0KSSBkb24ndCBzZWUgaG93IHRoYXQncyBwb3NzaWJsZS4N
Cg0KW2RvaW5nIHNvbWUgY2FsY3VsYXRpb24gYnkgaGFuZF0NCg0KQXJyZ2guICpibHVzaCoNCg0K
VGhlIGNvZGUgZG9lcyBub3QgZG8gd2hhdCBJIGludGVuZGVkIGZvciBpdCB0byBkby4NCkNhbiB5
b3UgcGxlYXNlIHRyeSB0aGlzIGluc3RlYWQgb2YgcmV2ZXJ0aW5nPw0KDQpDaGVlcnMsDQpQZXRl
cg0KDQpGcm9tIGIzZTg2ZDU1YjhkMTA3YTVjMDdlOThmODc5YzY3ZjY3MTIwYzg3YTYgTW9uIFNl
cCAxNyAwMDowMDowMCAyMDAxDQpGcm9tOiBQZXRlciBSb3NpbiA8cGVkYUBheGVudGlhLnNlPg0K
RGF0ZTogVHVlLCAxMCBEZWMgMjAxOSAxODoxMToyOCArMDEwMA0KU3ViamVjdDogW1BBVENIXSBk
cm0vYXRtZWwtaGxjZGM6IHByZWZlciBhIGxvd2VyIHBpeGVsLWNsb2NrIHRoYW4gcmVxdWVzdGVk
DQoNClRoZSBpbnRlbnRpb24gd2FzIHRvIG9ubHkgc2VsZWN0IGEgaGlnaGVyIHBpeGVsLWNsb2Nr
IHJhdGUgdGhhbiB0aGUNCnJlcXVlc3RlZCwgaWYgYSBzbGlnaHQgb3ZlcmNsb2NraW5nIHdvdWxk
IHJlc3VsdCBpbiBhIHJhdGUgc2lnbmlmaWNhbnRseQ0KY2xvc2VyIHRvIHRoZSByZXF1ZXN0ZWQg
cmF0ZSB0aGFuIGlmIHRoZSBjb25zZXJ2YXRpdmUgbG93ZXIgcGl4ZWwtY2xvY2sNCnJhdGUgaXMg
c2VsZWN0ZWQuIFRoZSBmaXhlZCBwYXRjaCBoYXMgdGhlIGxvZ2ljIHRoZSBvdGhlciB3YXkgYXJv
dW5kIGFuZA0KYWN0dWFsbHkgcHJlZmVycyB0aGUgaGlnaGVyIGZyZXF1ZW5jeS4gRml4IHRoYXQu
DQoNCkZpeGVzOiBmNmY3YWQzMjM0NjEgKCJkcm0vYXRtZWwtaGxjZGM6IGFsbG93IHNlbGVjdGlu
ZyBhIGhpZ2hlciBwaXhlbC1jbG9jayB0aGFuIHJlcXVlc3RlZCIpDQpSZXBvcnRlZC1ieTogQ2xh
dWRpdSBCZXpuZWEgPGNsYXVkaXUuYmV6bmVhQG1pY3JvY2hpcC5jb20+DQpTaWduZWQtb2ZmLWJ5
OiBQZXRlciBSb3NpbiA8cGVkYUBheGVudGlhLnNlPg0KLS0tDQogZHJpdmVycy9ncHUvZHJtL2F0
bWVsLWhsY2RjL2F0bWVsX2hsY2RjX2NydGMuYyB8IDQgKystLQ0KIDEgZmlsZSBjaGFuZ2VkLCAy
IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vYXRtZWwtaGxjZGMvYXRtZWxfaGxjZGNfY3J0Yy5jIGIvZHJpdmVycy9ncHUvZHJtL2F0
bWVsLWhsY2RjL2F0bWVsX2hsY2RjX2NydGMuYw0KaW5kZXggOWUzNGJjZTA4OWQwLi4wMzY5MTg0
NWQzN2EgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYXRtZWwtaGxjZGMvYXRtZWxfaGxj
ZGNfY3J0Yy5jDQorKysgYi9kcml2ZXJzL2dwdS9kcm0vYXRtZWwtaGxjZGMvYXRtZWxfaGxjZGNf
Y3J0Yy5jDQpAQCAtMTIwLDggKzEyMCw4IEBAIHN0YXRpYyB2b2lkIGF0bWVsX2hsY2RjX2NydGNf
bW9kZV9zZXRfbm9mYihzdHJ1Y3QgZHJtX2NydGMgKmMpDQogCQlpbnQgZGl2X2xvdyA9IHByYXRl
IC8gbW9kZV9yYXRlOw0KIA0KIAkJaWYgKGRpdl9sb3cgPj0gMiAmJg0KLQkJICAgICgocHJhdGUg
LyBkaXZfbG93IC0gbW9kZV9yYXRlKSA8DQotCQkgICAgIDEwICogKG1vZGVfcmF0ZSAtIHByYXRl
IC8gZGl2KSkpDQorCQkgICAgKDEwICogKHByYXRlIC8gZGl2X2xvdyAtIG1vZGVfcmF0ZSkgPA0K
KwkJICAgICAobW9kZV9yYXRlIC0gcHJhdGUgLyBkaXYpKSkNCiAJCQkvKg0KIAkJCSAqIEF0IGxl
YXN0IDEwIHRpbWVzIGJldHRlciB3aGVuIHVzaW5nIGEgaGlnaGVyDQogCQkJICogZnJlcXVlbmN5
IHRoYW4gcmVxdWVzdGVkLCBpbnN0ZWFkIG9mIGEgbG93ZXIuDQotLSANCjIuMjAuMQ0KDQo=
