Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97D14C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 06:09:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D94621924
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 06:09:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="gSm5Lyn3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393238AbfIJGJF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 02:09:05 -0400
Received: from mail-eopbgr00091.outbound.protection.outlook.com ([40.107.0.91]:54656
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730334AbfIJGJE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 02:09:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SgtUVns71ruGg3pnhwIDr1DT+dHmFNvMZFFAQWupzGxr3VfVJQWdQMwdVRe65uGsxs57Adyd9SrCu+wcti0KWbMejZ7ICN9rGfmhOgVUrcmAOJpyNTMc4Ba/Mi11t/gvW9uJwxojuSkI4CTBlbjIEJRcJmvEgsIayTH4DXl3L0bjdFF7keHHqFNZJTVjna/bEL4EFGp6dOV2EsupQorknlSBq6JYu27z5VhnHA8AE08WDx8mfqYH/xoffsRKCgi6Jm7YVtq7goAeDDLjePneB2XSajFS4I3VYvMkF96Nob9uAj82+3JjUyZeLaxxjQi1s5IHNxZtm8wZZ3gtYDYZKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O0S/90Z2aEB4W9XDgqflzVi/C+Wep22AdOMKAy+ujxA=;
 b=EabaEv/HJXO7TharGh/lBdPm14XBcud7uV6rEolb4LC0hyb1EPQHE1R7267pEjwWwfUpVSPkdMKP6RONOmt6PbnAlK4vNtRf5v924T6Jz2v7cQQRD1NdALlY+YHc4oMUfuvBzCNTJkQ1dnkqSdd51LXlmX+0HU2V2edtWPd+sWUM3np2rx1ET6Jv0hkpHwzEGmyetoI6Vv1PR7lQlIIcRiQ4zMirnC8ohWv3qAy3hrE91XyisNgfN9GWDrTFkmkXy1MkkwTuOi612AwgwZyA1UjctS5jz1Iw69Iz67H2uNeIy1wUMnso8mVmibFUwcZ9mAJ3bobm1V2KL8++aGlTvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O0S/90Z2aEB4W9XDgqflzVi/C+Wep22AdOMKAy+ujxA=;
 b=gSm5Lyn3TQ1k7Uk72wO8qmEeS4cvfGiUmPIBa/1Jdtqw/ZchtHGFluUuH8s8+Xv9Fyp8XjhGkQ0/5qE6rn1e8cdaD7cNyYbwpNwe62Wn1rgZy0UzIhvjg6UVPoaUl7K5G4lzIJnnzyHSXjYAxdFD8APQN0otDJNgkzWKTprmVZ8=
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com (52.134.17.157) by
 VI1PR0502MB3023.eurprd05.prod.outlook.com (10.175.22.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.15; Tue, 10 Sep 2019 06:09:00 +0000
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::f59f:a307:9c53:63b9]) by VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::f59f:a307:9c53:63b9%6]) with mapi id 15.20.2241.018; Tue, 10 Sep 2019
 06:09:00 +0000
From:   Philippe Schenker <philippe.schenker@toradex.com>
To:     "broonie@kernel.org" <broonie@kernel.org>
CC:     Max Krummenacher <max.krummenacher@toradex.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Luka Pivk <luka.pivk@toradex.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stefan Agner <stefan.agner@toradex.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: Re: [PATCH 1/3] regulator: fixed: add possibility to enable by clock
Thread-Topic: [PATCH 1/3] regulator: fixed: add possibility to enable by clock
Thread-Index: AQHVYi4cgyK53mdiuEKJwWlDc8lst6cdZNqAgAcTQoA=
Date:   Tue, 10 Sep 2019 06:08:59 +0000
Message-ID: <c44f33e7396c87afecec234975652c1445d7be9d.camel@toradex.com>
References: <20190903080336.32288-1-philippe.schenker@toradex.com>
         <20190903080336.32288-2-philippe.schenker@toradex.com>
         <20190905180615.GG4053@sirena.co.uk>
In-Reply-To: <20190905180615.GG4053@sirena.co.uk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=philippe.schenker@toradex.com; 
x-originating-ip: [46.140.72.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c57e12d3-a68a-4742-3e04-08d735b55f57
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR0502MB3023;
x-ms-traffictypediagnostic: VI1PR0502MB3023:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0502MB302383ADA076B0F911E0645FF4B60@VI1PR0502MB3023.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 01565FED4C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(136003)(376002)(346002)(396003)(39850400004)(199004)(189003)(478600001)(5660300002)(86362001)(6506007)(76176011)(11346002)(102836004)(316002)(26005)(2906002)(2351001)(118296001)(66946007)(6512007)(66446008)(64756008)(66556008)(66476007)(53936002)(25786009)(99286004)(5640700003)(81156014)(1730700003)(8676002)(4326008)(8936002)(81166006)(3846002)(6116002)(54906003)(2501003)(6436002)(7736002)(6246003)(6486002)(256004)(476003)(71190400001)(91956017)(66066001)(186003)(44832011)(446003)(486006)(71200400001)(229853002)(2616005)(36756003)(6916009)(14454004)(305945005)(76116006);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0502MB3023;H:VI1PR0502MB3965.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 6p61duBWLNCkFq14Opw4Jt6U6uiF/J/jraM8TCpHoY/8kKx/7QKXw13oHwl29ZvaaJ9Kwzd+R5r5Br/Z3qCKlkYmohY7yTKp0dVJRFdH459r1f3P6D79xDlHVgkNcgDcBwM1G0PUW1Xm6HBtoySIpsPJmeYuNyS2Pq0N4c6n/ikBr+VrQCR3vJM1VPOTHmfqy25sTQeTHzCx4gMOTDWfUq5EQj6ALJRhJ4n1MjyKVmAy/upq8iZQhxtxQHaOMpfMQmlyPWXSt20MMIhsYzMRMX7hxKkVaU8E1p9uK6yV+fkAgEYdnlmMbmfYjSAIlA5V43vK4YooBCif9dWJZ304VPhgocHNdSWZ1qBfvYGR7MBzeAP1BbJw/Jr3/rRu9WiQEgVnQZwBmiNc+cJhEir2BGPGXZx0jxQfLSPMK9VVhVk=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FF84837E07CC9D45A94E64932B20C960@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c57e12d3-a68a-4742-3e04-08d735b55f57
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2019 06:08:59.8141
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZKssVDLF4WZegmjQe2J2jjjTmAsKg0n7l5jpzlunkNHb18QBPqL83FPnV7vCjUfVSn29xqhpuIggvYlD4WBsHv7aNkOncBkVh+QIredTN1Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB3023
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDE5LTA5LTA1IGF0IDE5OjA2ICswMTAwLCBNYXJrIEJyb3duIHdyb3RlOg0KPiBP
biBUdWUsIFNlcCAwMywgMjAxOSBhdCAwODowMzo0NkFNICswMDAwLCBQaGlsaXBwZSBTY2hlbmtl
ciB3cm90ZToNCj4gPiBUaGlzIGNvbW1pdCBhZGRzIHRoZSBwb3NzaWJpbGl0eSB0byBjaG9vc2Ug
dGhlIGNvbXBhdGlibGUNCj4gPiAicmVndWxhdG9yLWZpeGVkLWNsb2NrIiBpbiBkZXZpY2V0cmVl
Lg0KPiA+IA0KPiA+IFRoaXMgaXMgYSBzcGVjaWFsIHJlZ3VsYXRvci1maXhlZCB0aGF0IGhhcyB0
byBoYXZlIGEgY2xvY2ssIGZyb20NCj4gPiB3aGljaA0KPiA+IHRoZSByZWd1bGF0b3IgZ2V0cyBz
d2l0Y2hlZCBvbiBhbmQgb2ZmLg0KPiANCj4gVGhpcyBzZWVtcyBjb25jZXB0dWFsbHkgZmluZS4g
IE1pbm9yIGlzc3VlcyB0aG91Z2g6DQoNClRoYW5rcyBmb3IgeW91ciBjb21tZW50cyBhbmQgSSdt
IGdsYWQgeW91IGxpa2UgaXQhIEkgd2lsbCBzZW5kIGEgdjINCnNob3J0bHksIGFsc28gd2l0aCBS
b2IncyBmaXhlcyBpbi4gQ2FuIEkgZXhwZWN0IGl0IHRvIGJlIHB1bGxlZCBmb3IgNS40Pw0KDQpC
ZXN0IHJlZ2FyZHMsDQpQaGlsaXBwZQ0KDQo+IA0KPiA+ICtzdGF0aWMgaW50IHJlZ19jbG9ja19p
c19lbmFibGVkKHN0cnVjdCByZWd1bGF0b3JfZGV2ICpyZGV2KQ0KPiA+ICt7DQo+ID4gKwlzdHJ1
Y3QgZml4ZWRfdm9sdGFnZV9kYXRhICpwcml2ID0gcmRldl9nZXRfZHJ2ZGF0YShyZGV2KTsNCj4g
PiArDQo+ID4gKwlpZiAocHJpdi0+Y2xrX2VuYWJsZV9jb3VudGVyID4gMCkNCj4gPiArCQlyZXR1
cm4gMTsNCj4gPiArDQo+ID4gKwlyZXR1cm4gMDsNCj4gPiArfQ0KPiANCj4gVGhpcyBjb3VsZCBq
dXN0IGJlIHJldHVybiBwcml2LT5jbGtfZW5hYmxlX2NvdW50ZXIgPiAwIC0gaWRlYWxseSB0aGUN
Cj4gY2xvY2sgQVBJIHdvdWxkIGxldCB1cyBxdWVyeSBpZiB0aGUgY2xvY2sgaXMgZW5hYmxlZCBi
dXQgdGhhdCBtaWdodCBiZQ0KPiBhDQo+IGJpdCBjb25mdXNlZCBhbnl3YXkgZ2l2ZW4gdGhhdCBp
dCdzIHBvc3NpYmx5IHNoYXJlZC4NCg==
