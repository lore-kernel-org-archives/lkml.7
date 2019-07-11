Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CE3EC74A4B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 10:25:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0725720872
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 10:25:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="q1mTb7Xv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728380AbfGKKZ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 06:25:27 -0400
Received: from mail-eopbgr80125.outbound.protection.outlook.com ([40.107.8.125]:23264
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727680AbfGKKZ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 06:25:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZETWu3pUq3KnnpTWiuPgWsTfQGSFbtSXLebgHum6NWjlBtI5LDzeevJ+W/U5us9FPj0yRpMipQYIt1xrGYpdjQvayLMMvk8q5gbduNUiptGc++sWUzsbQWVh8bitKnJ/p1VoG60xmxGuCXRl/y9ucdEiCF17ex6Ywt+OaKQFaFWsfSzEhc7GF/fPZrCIoqbOdZo9YjbuWKuCb8xdDfkp6RP7ygxj3+xddFfRd8ksCxI8eNNXfkvqpYzFT5EcRT00fNzxSwojbzOifAiNfOIwLL1odpbuOEY9qJDa1R159HWtZHCdbNp0NYasih5FBvwWMeVA87BtfDMu5DovlevgiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vqegzccg5mgbuJhviu+qMN4asH3YvvBxrmBNQoevxYc=;
 b=Bfzyzi62GdGqtTIcwmnhiErSdyKekBCCBZW+pmHfTrG6r7rF9JFfTYrKcbUpaWjQ+d8ikMvQgqXRPPH15NeFn6mzkOJgBFkwJ17vU+fDJbgyAOREfCyEm5kdC7AXaZObCZTNkzTVzdGx0aCpTcCKjUfbNuJ0q+dhAuAoG2SYW2hAPoxpuK9mIFh470xQ70jKHEgi+BgTaS9QGapy18buQ1CcdQsx4azj1AiECaGmlpumZBCU3F2NlhzY9AuyOVQbpDpB7ufg22zgkcgJJe+AA/V2cRHnkFJOHW7hA3AAqul+cWdy9UIkrKuCEp/MJ2IEorE/V6m1/OLWY1KJwBTKwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=toradex.com;dmarc=pass action=none
 header.from=toradex.com;dkim=pass header.d=toradex.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vqegzccg5mgbuJhviu+qMN4asH3YvvBxrmBNQoevxYc=;
 b=q1mTb7XvFOZM/luP/GFvZyFP7s+mgdFCxxdgxvJi1drl47dga+B89mRvvJ2Wq0xqo+iMVQ0RQL3IFcUWd9Bcm1aXU/8BQHQ+QRMdSbVugCVw6QkQmq0lq6nMPW76m9LxLI7g1c5kC28KK7cvH3jl+zP3Tg6szQETVqD0B/Nho/U=
Received: from AM7PR05MB6741.eurprd05.prod.outlook.com (10.186.171.86) by
 AM7PR05MB6741.eurprd05.prod.outlook.com (10.186.171.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.11; Thu, 11 Jul 2019 10:25:23 +0000
Received: from AM7PR05MB6741.eurprd05.prod.outlook.com
 ([fe80::55f7:56d8:e219:79f5]) by AM7PR05MB6741.eurprd05.prod.outlook.com
 ([fe80::55f7:56d8:e219:79f5%3]) with mapi id 15.20.2073.008; Thu, 11 Jul 2019
 10:25:23 +0000
From:   Igor Opaniuk <igor.opaniuk@toradex.com>
To:     Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
CC:     Fabio Estevam <festevam@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Igor Opaniuk <igor.opaniuk@toradex.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH v2 3/6] ASoC: sgtl5000: Fix of unmute outputs on probe
Thread-Topic: [PATCH v2 3/6] ASoC: sgtl5000: Fix of unmute outputs on probe
Thread-Index: AQHVKyqTM6H+ZqUkgEmGrNSyaGiEVabFTeEA
Date:   Thu, 11 Jul 2019 10:25:23 +0000
Message-ID: <CAByghJYYVNCWB8kdmWvdeL_s2P8nnn7zegh6HwNW0pRC3gAXiw@mail.gmail.com>
References: <20190625074937.2621-1-oleksandr.suvorov@toradex.com>
 <20190625074937.2621-4-oleksandr.suvorov@toradex.com>
In-Reply-To: <20190625074937.2621-4-oleksandr.suvorov@toradex.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM4PR0701CA0022.eurprd07.prod.outlook.com
 (2603:10a6:200:42::32) To AM7PR05MB6741.eurprd05.prod.outlook.com
 (2603:10a6:20b:13e::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=igor.opaniuk@toradex.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-gm-message-state: APjAAAW0d2NTFWbUMRkH+DsUMVT6i+T9nk/Z2184QsWLYhGHCiKCHVNn
        /Yew4WEEHDjN6cGHtKJqQfJn3qDxUsfaoG0QSWA=
x-google-smtp-source: APXvYqwh/1judZAE/L+wM0ZSzXPgB0nK6J9Ws7VbIEsYIvwpfSHvJbPfA+zVw9u0hdPt5B3+G90YuHD5dFH9n7sgi7A=
x-received: by 2002:a17:906:31c9:: with SMTP id
 f9mr2485556ejf.168.1562840373867; Thu, 11 Jul 2019 03:19:33 -0700 (PDT)
x-gmail-original-message-id: <CAByghJYYVNCWB8kdmWvdeL_s2P8nnn7zegh6HwNW0pRC3gAXiw@mail.gmail.com>
x-originating-ip: [209.85.208.50]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4b8d71f4-0496-4e30-5ce8-08d705ea1568
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:AM7PR05MB6741;
x-ms-traffictypediagnostic: AM7PR05MB6741:
x-microsoft-antispam-prvs: <AM7PR05MB6741BD75EEFD7AFC120688309EF30@AM7PR05MB6741.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1360;
x-forefront-prvs: 0095BCF226
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(39850400004)(376002)(366004)(136003)(396003)(189003)(199004)(305945005)(81166006)(107886003)(71190400001)(3846002)(99286004)(81156014)(7736002)(8676002)(6436002)(71200400001)(76176011)(66446008)(6506007)(386003)(6486002)(95326003)(53546011)(64756008)(66476007)(66556008)(6116002)(5660300002)(25786009)(102836004)(2906002)(486006)(66946007)(8936002)(26005)(6862004)(14444005)(256004)(229853002)(44832011)(66574012)(316002)(68736007)(478600001)(61266001)(66066001)(53936002)(6636002)(6246003)(14454004)(498394004)(476003)(52116002)(446003)(4326008)(11346002)(61726006)(55446002)(186003)(9686003)(86362001)(54906003)(6512007);DIR:OUT;SFP:1102;SCL:1;SRVR:AM7PR05MB6741;H:AM7PR05MB6741.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: NX9aIKcNKvtMkRFExXW6ohqFV0a/zq+DKDIkoUUXgPtB/Q+fRBUxpesa20vV2IDVApNoF8mxEE+nf1TYAUhJN9dxIR4U6RdJgt5ZMyzHV3QEpO7GcdonrCrscxTSpeSQu14mdwObRJqvOfCrig6b3zeDH1lGBiGDUvNh4CBFbRhoqtc+Hr37F610xkD9lZw7uEDeTbEwHRsK9yOoCCZ3GaLrULvOJlyu0osnyQlke2aThDtCl12+JNiGCDWtjRzalFhoWVX4E4C1rts+dIU1BefjZ68DpW+93tYTTUYU4QiSS2ajxOHliSLI9baDxg17CM8U9gMvvtKqD0srRPuFt5vNJbOMUDtjiVQwCzQ9efYbU9zJqocsfGlUqx+qUSDRPTqvK0KUVBlTNXEw9PLMSeG+Hrv6mJaSuEX4yEhI6Go=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4BA652CA2230714284FFA5789C48A60D@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b8d71f4-0496-4e30-5ce8-08d705ea1568
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2019 10:25:23.6672
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: igor.opaniuk@toradex.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR05MB6741
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCBKdW4gMjUsIDIwMTkgYXQgMTA6NTQgQU0gT2xla3NhbmRyIFN1dm9yb3YNCjxvbGVr
c2FuZHIuc3V2b3JvdkB0b3JhZGV4LmNvbT4gd3JvdGU6DQo+DQo+IFRvIGVuYWJsZSAiemVybyBj
cm9zcyBkZXRlY3QiIGZvciBBREMvSFAsIGNoYW5nZQ0KPiBIUF9aQ0RfRU4vQURDX1pDRF9FTiBi
aXRzIG9ubHkgaW5zdGVhZCBvZiB3cml0aW5nIHRoZSB3aG9sZQ0KPiBDSElQX0FOQV9DVFJMIHJl
Z2lzdGVyLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBPbGVrc2FuZHIgU3V2b3JvdiA8b2xla3NhbmRy
LnN1dm9yb3ZAdG9yYWRleC5jb20+DQo+IC0tLQ0KPg0KPiAgc291bmQvc29jL2NvZGVjcy9zZ3Rs
NTAwMC5jIHwgNiArKystLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDMg
ZGVsZXRpb25zKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9zb3VuZC9zb2MvY29kZWNzL3NndGw1MDAw
LmMgYi9zb3VuZC9zb2MvY29kZWNzL3NndGw1MDAwLmMNCj4gaW5kZXggYmI1OGM5OTdjNjkxNC4u
ZTgxM2EzNzkxMGFmNCAxMDA2NDQNCj4gLS0tIGEvc291bmQvc29jL2NvZGVjcy9zZ3RsNTAwMC5j
DQo+ICsrKyBiL3NvdW5kL3NvYy9jb2RlY3Mvc2d0bDUwMDAuYw0KPiBAQCAtMTI4OSw2ICsxMjg5
LDcgQEAgc3RhdGljIGludCBzZ3RsNTAwMF9wcm9iZShzdHJ1Y3Qgc25kX3NvY19jb21wb25lbnQg
KmNvbXBvbmVudCkNCj4gICAgICAgICBpbnQgcmV0Ow0KPiAgICAgICAgIHUxNiByZWc7DQo+ICAg
ICAgICAgc3RydWN0IHNndGw1MDAwX3ByaXYgKnNndGw1MDAwID0gc25kX3NvY19jb21wb25lbnRf
Z2V0X2RydmRhdGEoY29tcG9uZW50KTsNCj4gKyAgICAgICB1bnNpZ25lZCBpbnQgemNkX21hc2sg
PSBTR1RMNTAwMF9IUF9aQ0RfRU4gfCBTR1RMNTAwMF9BRENfWkNEX0VOOw0KPg0KPiAgICAgICAg
IC8qIHBvd2VyIHVwIHNndGw1MDAwICovDQo+ICAgICAgICAgcmV0ID0gc2d0bDUwMDBfc2V0X3Bv
d2VyX3JlZ3MoY29tcG9uZW50KTsNCj4gQEAgLTEzMTYsOSArMTMxNyw4IEBAIHN0YXRpYyBpbnQg
c2d0bDUwMDBfcHJvYmUoc3RydWN0IHNuZF9zb2NfY29tcG9uZW50ICpjb21wb25lbnQpDQo+ICAg
ICAgICAgICAgICAgIDB4MWYpOw0KPiAgICAgICAgIHNuZF9zb2NfY29tcG9uZW50X3dyaXRlKGNv
bXBvbmVudCwgU0dUTDUwMDBfQ0hJUF9QQURfU1RSRU5HVEgsIHJlZyk7DQo+DQo+IC0gICAgICAg
c25kX3NvY19jb21wb25lbnRfd3JpdGUoY29tcG9uZW50LCBTR1RMNTAwMF9DSElQX0FOQV9DVFJM
LA0KPiAtICAgICAgICAgICAgICAgICAgICAgICBTR1RMNTAwMF9IUF9aQ0RfRU4gfA0KPiAtICAg
ICAgICAgICAgICAgICAgICAgICBTR1RMNTAwMF9BRENfWkNEX0VOKTsNCj4gKyAgICAgICBzbmRf
c29jX2NvbXBvbmVudF91cGRhdGVfYml0cyhjb21wb25lbnQsIFNHVEw1MDAwX0NISVBfQU5BX0NU
UkwsDQo+ICsgICAgICAgICAgICAgICB6Y2RfbWFzaywgemNkX21hc2spOw0KPg0KPiAgICAgICAg
IHNuZF9zb2NfY29tcG9uZW50X3VwZGF0ZV9iaXRzKGNvbXBvbmVudCwgU0dUTDUwMDBfQ0hJUF9N
SUNfQ1RSTCwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgU0dUTDUwMDBfQklBU19SX01BU0ss
DQo+IC0tDQo+IDIuMjAuMQ0KPg0KDQpSZXZpZXdlZC1ieTogSWdvciBPcGFuaXVrIDxpZ29yLm9w
YW5pdWtAdG9yYWRleC5jb20+DQoNCi0tIA0KQmVzdCByZWdhcmRzIC0gRnJldW5kbGljaGUgR3LD
vHNzZSAtIE1laWxsZXVyZXMgc2FsdXRhdGlvbnMNCg0KU2VuaW9yIERldmVsb3BtZW50IEVuZ2lu
ZWVyLA0KSWdvciBPcGFuaXVrDQoNClRvcmFkZXggQUcNCkFsdHNhZ2Vuc3RyYXNzZSA1IHwgNjA0
OCBIb3J3L0x1emVybiB8IFN3aXR6ZXJsYW5kIHwgVDogKzQxIDQxIDUwMCA0OA0KMDAgKG1haW4g
bGluZSkNCg==
