Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA014C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:53:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7393B2064A
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:53:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="nq0kSMqR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390033AbfFMPxD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:53:03 -0400
Received: from mail-eopbgr50129.outbound.protection.outlook.com ([40.107.5.129]:36526
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731624AbfFMJFO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 05:05:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9vemiUvP6gECFgPEBfsenCN7aavZmFeTwt01FNNpaRo=;
 b=nq0kSMqRdGUOmYOqs53uREpcz3CKQ1ncmKUPtB0puiPfSbLuth9pEUgp9rYwfCWV0L+O99UMPAUaxz1ZfQV/VuwnSREyNYyqjuSuos6Ue7EWvUaMVJODbWJ3pD6fe/tBwQGU9/vqUf/yFhuM5vWVAupelgAHJ8U5O5MN40oaVbc=
Received: from VI1PR05MB6477.eurprd05.prod.outlook.com (20.179.26.150) by
 VI1PR05MB5599.eurprd05.prod.outlook.com (20.177.203.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.10; Thu, 13 Jun 2019 09:05:09 +0000
Received: from VI1PR05MB6477.eurprd05.prod.outlook.com
 ([fe80::8437:8389:cec3:452c]) by VI1PR05MB6477.eurprd05.prod.outlook.com
 ([fe80::8437:8389:cec3:452c%6]) with mapi id 15.20.1965.017; Thu, 13 Jun 2019
 09:05:09 +0000
From:   Marcel Ziswiler <marcel.ziswiler@toradex.com>
To:     "festevam@gmail.com" <festevam@gmail.com>,
        Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
CC:     Igor Opaniuk <igor.opaniuk@toradex.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Subject: Re: [PATCH v1 1/6] ASoC: sgtl5000: Fix definition of VAG Ramp Control
Thread-Topic: [PATCH v1 1/6] ASoC: sgtl5000: Fix definition of VAG Ramp
 Control
Thread-Index: AQHVD9h2Jvq9SRrSGEWyDMAz3sEU8KaZboEA
Date:   Thu, 13 Jun 2019 09:05:09 +0000
Message-ID: <79fa1a0855bfcc1abad348aa047e7a69fffb8225.camel@toradex.com>
References: <20190521103619.4707-1-oleksandr.suvorov@toradex.com>
         <20190521103619.4707-2-oleksandr.suvorov@toradex.com>
In-Reply-To: <20190521103619.4707-2-oleksandr.suvorov@toradex.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=marcel.ziswiler@toradex.com; 
x-originating-ip: [46.140.72.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bdf313a1-3feb-415b-1c04-08d6efde3c45
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR05MB5599;
x-ms-traffictypediagnostic: VI1PR05MB5599:
x-microsoft-antispam-prvs: <VI1PR05MB559960DEB780C535A821C257FBEF0@VI1PR05MB5599.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 0067A8BA2A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(39850400004)(366004)(346002)(136003)(189003)(199004)(305945005)(186003)(118296001)(6636002)(11346002)(229853002)(26005)(6486002)(316002)(71190400001)(7736002)(71200400001)(54906003)(86362001)(478600001)(110136005)(14454004)(3846002)(6246003)(81156014)(99286004)(36756003)(76176011)(8676002)(6506007)(53936002)(476003)(6512007)(256004)(5660300002)(25786009)(81166006)(14444005)(6436002)(8936002)(66446008)(66066001)(4326008)(2501003)(66556008)(66476007)(64756008)(68736007)(66946007)(76116006)(44832011)(2616005)(2906002)(6116002)(486006)(446003)(102836004)(73956011);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR05MB5599;H:VI1PR05MB6477.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 57WpHKHDl1EOrtYbZTcQAjJ/2PcSH6zdaYw3RLy34RCJg41K9foeAK0geGQ6xzTp3uBFMXRGzCZIk7VA3zaX3Yn6ym758rhwIeIHIPI6GuCjDZ5hleMoGxyAO+orT5i/AFEhjvn3GqdCkK7sBZIsuxC4Tf1cnKiJwCC3duwjc+HTxgZGjF3cmCjyVRkiNg25o2kLQsRAieqf99VJmjA55C5qW1XHHnl0YjyxRcGCL39Imy5IKkH+RdSg8fe4Y8+MRnNLJAhy3V/QZNY4K16RzWDzszh5OWFFKKzX37Etkl2shdMs4y3FQeB7ArHfWZKag8YL1EPNTySY2ei+2IfNyRe51aFXKa7RjMOCH8cDXzgab26lXlwNRJy2e97QuRkg2LnVQrla+a1OZU5VMFzqszULM9wQwvjXgqyU8ybPxaQ=
Content-Type: text/plain; charset="utf-8"
Content-ID: <076A28A3E55D844EA3B5769359C1B9E2@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdf313a1-3feb-415b-1c04-08d6efde3c45
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2019 09:05:09.1514
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: marcel.ziswiler@toradex.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5599
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE5LTA1LTIxIGF0IDEzOjM2ICswMzAwLCBPbGVrc2FuZHIgU3V2b3JvdiB3cm90
ZToNCj4gU0dUTDUwMDBfU01BTExfUE9QIGlzIGEgYml0IG1hc2ssIG5vdCBhIHZhbHVlLiBVc2Fn
ZSBvZg0KPiBjb3JyZWN0IGRlZmluaXRpb24gbWFrZXMgZGV2aWNlIHByb2JpbmcgY29kZSBtb3Jl
IGNsZWFyLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogT2xla3NhbmRyIFN1dm9yb3YgPG9sZWtzYW5k
ci5zdXZvcm92QHRvcmFkZXguY29tPg0KDQpSZXZpZXdlZC1ieTogTWFyY2VsIFppc3dpbGVyIDxt
YXJjZWwuemlzd2lsZXJAdG9yYWRleC5jb20+DQoNCj4gLS0tDQo+IA0KPiAgc291bmQvc29jL2Nv
ZGVjcy9zZ3RsNTAwMC5jIHwgMiArLQ0KPiAgc291bmQvc29jL2NvZGVjcy9zZ3RsNTAwMC5oIHwg
MiArLQ0KPiAgMiBmaWxlcyBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0p
DQo+IA0KPiBkaWZmIC0tZ2l0IHNvdW5kL3NvYy9jb2RlY3Mvc2d0bDUwMDAuYyBzb3VuZC9zb2Mv
Y29kZWNzL3NndGw1MDAwLmMNCg0KSSdtIG5vdCBzdXJlIGhvdyBleGFjdGx5IHlvdSBnZW5lcmF0
ZWQgdGhpcyBwYXRjaCBzZXQgYnV0IHVzdWFsbHkgZ2l0DQpmb3JtYXQtcGF0Y2ggaW5zZXJ0cyBh
biBhZGRpdGlvbmFsIGZvbGRlciBsZXZlbCBjYWxsZWQgYS9iIHdoaWNoIGlzDQp3aGF0IGdpdCBh
bSBhY2NlcHRzIGJ5IGRlZmF1bHQgZS5nLg0KDQpkaWZmIC0tZ2l0IGEvc291bmQvc29jL2NvZGVj
cy9zZ3RsNTAwMC5jIGIvc291bmQvc29jL2NvZGVjcy9zZ3RsNTAwMC5jDQoNCj4gaW5kZXggYTZh
NDc0OGM5N2Y5Li41ZTQ5NTIzZWUwYjYgMTAwNjQ0DQo+IC0tLSBzb3VuZC9zb2MvY29kZWNzL3Nn
dGw1MDAwLmMNCj4gKysrIHNvdW5kL3NvYy9jb2RlY3Mvc2d0bDUwMDAuYw0KDQpPZiBjb3Vyc2Us
IHRoZSBzYW1lIGEvYiBzdHVmZiBhcHBsaWVzIGhlcmU6DQoNCi0tLSBhL3NvdW5kL3NvYy9jb2Rl
Y3Mvc2d0bDUwMDAuYw0KKysrIGIvc291bmQvc29jL2NvZGVjcy9zZ3RsNTAwMC5jDQoNCj4gQEAg
LTEyOTYsNyArMTI5Niw3IEBAIHN0YXRpYyBpbnQgc2d0bDUwMDBfcHJvYmUoc3RydWN0DQo+IHNu
ZF9zb2NfY29tcG9uZW50ICpjb21wb25lbnQpDQo+ICANCj4gIAkvKiBlbmFibGUgc21hbGwgcG9w
LCBpbnRyb2R1Y2UgNDAwbXMgZGVsYXkgaW4gdHVybmluZyBvZmYgKi8NCj4gIAlzbmRfc29jX2Nv
bXBvbmVudF91cGRhdGVfYml0cyhjb21wb25lbnQsDQo+IFNHVEw1MDAwX0NISVBfUkVGX0NUUkws
DQo+IC0JCQkJU0dUTDUwMDBfU01BTExfUE9QLCAxKTsNCj4gKwkJCQlTR1RMNTAwMF9TTUFMTF9Q
T1AsDQo+IFNHVEw1MDAwX1NNQUxMX1BPUCk7DQo+ICANCj4gIAkvKiBkaXNhYmxlIHNob3J0IGN1
dCBkZXRlY3RvciAqLw0KPiAgCXNuZF9zb2NfY29tcG9uZW50X3dyaXRlKGNvbXBvbmVudCwgU0dU
TDUwMDBfQ0hJUF9TSE9SVF9DVFJMLA0KPiAwKTsNCj4gZGlmZiAtLWdpdCBzb3VuZC9zb2MvY29k
ZWNzL3NndGw1MDAwLmggc291bmQvc29jL2NvZGVjcy9zZ3RsNTAwMC5oDQo+IGluZGV4IDE4Y2Fl
MDhiYmQzYS4uYTRiZjRiY2E5NWJmIDEwMDY0NA0KPiAtLS0gc291bmQvc29jL2NvZGVjcy9zZ3Rs
NTAwMC5oDQo+ICsrKyBzb3VuZC9zb2MvY29kZWNzL3NndGw1MDAwLmgNCj4gQEAgLTI3Myw3ICsy
NzMsNyBAQA0KPiAgI2RlZmluZSBTR1RMNTAwMF9CSUFTX0NUUkxfTUFTSwkJCTB4MDAwZQ0KPiAg
I2RlZmluZSBTR1RMNTAwMF9CSUFTX0NUUkxfU0hJRlQJCTENCj4gICNkZWZpbmUgU0dUTDUwMDBf
QklBU19DVFJMX1dJRFRICQkzDQo+IC0jZGVmaW5lIFNHVEw1MDAwX1NNQUxMX1BPUAkJCTENCj4g
KyNkZWZpbmUgU0dUTDUwMDBfU01BTExfUE9QCQkJMHgwMDAxDQo+ICANCj4gIC8qDQo+ICAgKiBT
R1RMNTAwMF9DSElQX01JQ19DVFJMDQo+IC0tIA0KPiAyLjIwLjENCg==
