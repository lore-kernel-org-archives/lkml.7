Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CE5EC74A51
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 10:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46720208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 10:17:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="Y7M04uv0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728313AbfGKKRE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 06:17:04 -0400
Received: from mail-eopbgr40125.outbound.protection.outlook.com ([40.107.4.125]:26685
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728072AbfGKKRD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 06:17:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=albjQZVYpuUKlfImVuJKpM5k6mZj4MeKEx0ty/Vt/bXuF+cHhOQjQC6YyNt8EDR7us0LgcguuJGWQPNlLFgCn/4eZvdUWyg1jFhTGdLxVmpwcGaxkUtr3+1Dx2PfY1wXp4Ln4kEledgAqEnxD82thYDzj5TK4+JRjg+WttIUHUFNq1RA8CJ1T5xlqnBcsTIfcewparpNgXeVU3v78VVuhneV0/foCe5lxMvhV8Ltnr9YI3SEixHFzHLNa0iZ2jkE2uCOPQwsupJLRyG8mq2tL2/l0vjHnXa0omFG9cBGitFm63eH3350LD1Mizk9DjkurvqEnRTfjevXuBOSY7fMUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7hNr3QoKwMeUnyCP5hB6vdZTSXriXXS1eoMuJIcQRfA=;
 b=ayA53LwPNhj0tLWmzAtemEbuQK3VAKnP1MJ9HiBuZJAEzf/b4xJNMCqhsu1P1at/Zj0yDHsZqkF+qR2AdYRKGlij2PpJdl8oMEYi85ntQg38PzNCiSFosdkejJ3+3wtaHOJw5cBQAPBREqqpbMjWm12eXUUjuIc/IrlXYxPXoAw3cjh9Qt35xD6tKa+GqkgsCxIAFne4379ggQDrwOmVWFxtZKKA8t00a7l8usiHQr8kEVjXlrDnmfdg5ZhdTw0W7yYqRHqwCaQJRbEIIHzPnCIo1wVirsH/bvUjjrXOA6SRz0b2XF4XI0CivUB9fHl53/9qX5SZqQ5jqYn+bHkltA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=toradex.com;dmarc=pass action=none
 header.from=toradex.com;dkim=pass header.d=toradex.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7hNr3QoKwMeUnyCP5hB6vdZTSXriXXS1eoMuJIcQRfA=;
 b=Y7M04uv0ZHLZT+i3S9wdflvPbwYSrtCNf/UgcZqwaudsSyb+wGtlLzC2L1TOBmG0kocyHajR+Dfmmx94WsXNgT7/MYs8B0nYv9tSrFIsP4ke8bmfxTvCeP2Drvj8DKUNd3WWmYX/XuLr+hE5fmJWgFf5du3kKVWb404qdw941Yk=
Received: from AM7PR05MB6741.eurprd05.prod.outlook.com (10.186.171.86) by
 AM7PR05MB6728.eurprd05.prod.outlook.com (10.186.169.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.11; Thu, 11 Jul 2019 10:17:00 +0000
Received: from AM7PR05MB6741.eurprd05.prod.outlook.com
 ([fe80::55f7:56d8:e219:79f5]) by AM7PR05MB6741.eurprd05.prod.outlook.com
 ([fe80::55f7:56d8:e219:79f5%3]) with mapi id 15.20.2073.008; Thu, 11 Jul 2019
 10:17:00 +0000
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
Subject: Re: [PATCH v2 1/6] ASoC: sgtl5000: Fix definition of VAG Ramp Control
Thread-Topic: [PATCH v2 1/6] ASoC: sgtl5000: Fix definition of VAG Ramp
 Control
Thread-Index: AQHVKyqQziN8PVlEs02TceIA9905xabFTSiA
Date:   Thu, 11 Jul 2019 10:16:59 +0000
Message-ID: <CAByghJazsgcSCi_ucgRBN2a4yfVT2_9Gk_DfOPEz-YtNw1u+yg@mail.gmail.com>
References: <20190625074937.2621-1-oleksandr.suvorov@toradex.com>
 <20190625074937.2621-2-oleksandr.suvorov@toradex.com>
In-Reply-To: <20190625074937.2621-2-oleksandr.suvorov@toradex.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0PR02CA0032.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::45) To AM7PR05MB6741.eurprd05.prod.outlook.com
 (2603:10a6:20b:13e::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=igor.opaniuk@toradex.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-gm-message-state: APjAAAWfK2YVZ3lsoVpYbtCnhDZ0wqNuMYHyILhxklTe9MALuHO7MzrA
        ghhfSsRYlDvfero8FBoV2qosZQT0jhPsTuHlpLk=
x-google-smtp-source: APXvYqwDCEcdaMpWQqgjTQsxiXnzWiNUesfVHId1yXV52kNeDzpItG4FwRvarJ9aiMn9t0mzMo37iUSSVPbiXcE0b+o=
x-received: by 2002:a50:ba09:: with SMTP id g9mr2641173edc.172.1562840218832;
 Thu, 11 Jul 2019 03:16:58 -0700 (PDT)
x-gmail-original-message-id: <CAByghJazsgcSCi_ucgRBN2a4yfVT2_9Gk_DfOPEz-YtNw1u+yg@mail.gmail.com>
x-originating-ip: [209.85.208.48]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a841c353-39e2-48d2-4013-08d705e8e8bf
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:AM7PR05MB6728;
x-ms-traffictypediagnostic: AM7PR05MB6728:
x-microsoft-antispam-prvs: <AM7PR05MB67289535D6B072CD441C55DF9EF30@AM7PR05MB6728.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1122;
x-forefront-prvs: 0095BCF226
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(376002)(366004)(346002)(396003)(39850400004)(189003)(199004)(186003)(26005)(66946007)(66476007)(66556008)(53936002)(64756008)(61266001)(66446008)(61726006)(229853002)(6512007)(68736007)(9686003)(6436002)(52116002)(71200400001)(71190400001)(14454004)(6486002)(14444005)(66574012)(256004)(76176011)(66066001)(6246003)(107886003)(53546011)(102836004)(386003)(6506007)(11346002)(4326008)(81166006)(7736002)(486006)(6116002)(44832011)(2906002)(99286004)(3846002)(8936002)(86362001)(55446002)(446003)(478600001)(476003)(6862004)(81156014)(5660300002)(498394004)(8676002)(305945005)(25786009)(6636002)(95326003)(54906003)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM7PR05MB6728;H:AM7PR05MB6741.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: UIqZYx/j8lhj2HYIpbh5PRX+Ei54ceDUM04p/HMSgPv1hZ/E+Gb9cXqLIE/ou/Zh0FrH7ohPFvQMcrjwe7FW1jWedLk0SCEwiwcZa2S9XIsVgmKBT+0W+Ck1lO4izLfEVkpN8jNrqcFnG++GbsH+9co2O2g9YUb5NulOixyDFFYPTh7f2xqSEPPZuh6SjO9L2//nQwb1X1essSsh+h8eL6IeH/2eyZ+nJ+vk5wK+1TX3nkbxVZ7suNyF2JYoO9EXK91daIGe7LO5b98FK+cz8AlJMuAWc/4OToNDC6oKtn1Z4VvVSrm4zsR3t3K+FKNsK6D3X/X+VBTSgi0lvM7GSJXfsEPhHH7BeOsd1xnP4+0a69mzIen7wlMMTya9DdO1TrbSN4hg6zSeCQ64JAHwbGE4c6pyKNUMIZwh7o03APQ=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D8E6F5BC411E4D40AE04DCAB5726E982@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a841c353-39e2-48d2-4013-08d705e8e8bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2019 10:16:59.2764
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: igor.opaniuk@toradex.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR05MB6728
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCBKdW4gMjUsIDIwMTkgYXQgMTA6NTUgQU0gT2xla3NhbmRyIFN1dm9yb3YNCjxvbGVr
c2FuZHIuc3V2b3JvdkB0b3JhZGV4LmNvbT4gd3JvdGU6DQo+DQo+IFNHVEw1MDAwX1NNQUxMX1BP
UCBpcyBhIGJpdCBtYXNrLCBub3QgYSB2YWx1ZS4gVXNhZ2Ugb2YNCj4gY29ycmVjdCBkZWZpbml0
aW9uIG1ha2VzIGRldmljZSBwcm9iaW5nIGNvZGUgbW9yZSBjbGVhci4NCj4NCj4gU2lnbmVkLW9m
Zi1ieTogT2xla3NhbmRyIFN1dm9yb3YgPG9sZWtzYW5kci5zdXZvcm92QHRvcmFkZXguY29tPg0K
PiAtLS0NCj4NCj4gIHNvdW5kL3NvYy9jb2RlY3Mvc2d0bDUwMDAuYyB8IDIgKy0NCj4gIHNvdW5k
L3NvYy9jb2RlY3Mvc2d0bDUwMDAuaCB8IDIgKy0NCj4gIDIgZmlsZXMgY2hhbmdlZCwgMiBpbnNl
cnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvc291bmQvc29jL2Nv
ZGVjcy9zZ3RsNTAwMC5jIGIvc291bmQvc29jL2NvZGVjcy9zZ3RsNTAwMC5jDQo+IGluZGV4IGE2
YTQ3NDhjOTdmOWQuLjVlNDk1MjNlZTBiNjcgMTAwNjQ0DQo+IC0tLSBhL3NvdW5kL3NvYy9jb2Rl
Y3Mvc2d0bDUwMDAuYw0KPiArKysgYi9zb3VuZC9zb2MvY29kZWNzL3NndGw1MDAwLmMNCj4gQEAg
LTEyOTYsNyArMTI5Niw3IEBAIHN0YXRpYyBpbnQgc2d0bDUwMDBfcHJvYmUoc3RydWN0IHNuZF9z
b2NfY29tcG9uZW50ICpjb21wb25lbnQpDQo+DQo+ICAgICAgICAgLyogZW5hYmxlIHNtYWxsIHBv
cCwgaW50cm9kdWNlIDQwMG1zIGRlbGF5IGluIHR1cm5pbmcgb2ZmICovDQo+ICAgICAgICAgc25k
X3NvY19jb21wb25lbnRfdXBkYXRlX2JpdHMoY29tcG9uZW50LCBTR1RMNTAwMF9DSElQX1JFRl9D
VFJMLA0KPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFNHVEw1MDAwX1NNQUxMX1BP
UCwgMSk7DQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgU0dUTDUwMDBfU01BTExf
UE9QLCBTR1RMNTAwMF9TTUFMTF9QT1ApOw0KPg0KPiAgICAgICAgIC8qIGRpc2FibGUgc2hvcnQg
Y3V0IGRldGVjdG9yICovDQo+ICAgICAgICAgc25kX3NvY19jb21wb25lbnRfd3JpdGUoY29tcG9u
ZW50LCBTR1RMNTAwMF9DSElQX1NIT1JUX0NUUkwsIDApOw0KPiBkaWZmIC0tZ2l0IGEvc291bmQv
c29jL2NvZGVjcy9zZ3RsNTAwMC5oIGIvc291bmQvc29jL2NvZGVjcy9zZ3RsNTAwMC5oDQo+IGlu
ZGV4IDE4Y2FlMDhiYmQzYTYuLmE0YmY0YmNhOTViZjcgMTAwNjQ0DQo+IC0tLSBhL3NvdW5kL3Nv
Yy9jb2RlY3Mvc2d0bDUwMDAuaA0KPiArKysgYi9zb3VuZC9zb2MvY29kZWNzL3NndGw1MDAwLmgN
Cj4gQEAgLTI3Myw3ICsyNzMsNyBAQA0KPiAgI2RlZmluZSBTR1RMNTAwMF9CSUFTX0NUUkxfTUFT
SyAgICAgICAgICAgICAgICAgICAgICAgIDB4MDAwZQ0KPiAgI2RlZmluZSBTR1RMNTAwMF9CSUFT
X0NUUkxfU0hJRlQgICAgICAgICAgICAgICAxDQo+ICAjZGVmaW5lIFNHVEw1MDAwX0JJQVNfQ1RS
TF9XSURUSCAgICAgICAgICAgICAgIDMNCj4gLSNkZWZpbmUgU0dUTDUwMDBfU01BTExfUE9QICAg
ICAgICAgICAgICAgICAgICAgMQ0KPiArI2RlZmluZSBTR1RMNTAwMF9TTUFMTF9QT1AgICAgICAg
ICAgICAgICAgICAgICAweDAwMDENCj4NCj4gIC8qDQo+ICAgKiBTR1RMNTAwMF9DSElQX01JQ19D
VFJMDQo+IC0tDQo+IDIuMjAuMQ0KPg0KDQpSZXZpZXdlZC1ieTogSWdvciBPcGFuaXVrIDxpZ29y
Lm9wYW5pdWtAdG9yYWRleC5jb20+DQoNCi0tIA0KQmVzdCByZWdhcmRzIC0gRnJldW5kbGljaGUg
R3LDvHNzZSAtIE1laWxsZXVyZXMgc2FsdXRhdGlvbnMNCg0KU2VuaW9yIERldmVsb3BtZW50IEVu
Z2luZWVyLA0KSWdvciBPcGFuaXVrDQoNClRvcmFkZXggQUcNCkFsdHNhZ2Vuc3RyYXNzZSA1IHwg
NjA0OCBIb3J3L0x1emVybiB8IFN3aXR6ZXJsYW5kIHwgVDogKzQxIDQxIDUwMCA0OA0KMDAgKG1h
aW4gbGluZSkNCg==
