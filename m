Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B192C433FF
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 07:43:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1883C2084D
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 07:43:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="iQWy9WqW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730549AbfHOHnY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 03:43:24 -0400
Received: from mail-eopbgr80111.outbound.protection.outlook.com ([40.107.8.111]:61166
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730496AbfHOHnX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 03:43:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oQHxdVbp9XqM4UPUKgw6ts9HZEv9R9i4/Q+LUWncdcRZvHa3U4YT8kKOSRobJiKFiCqX39BarncMtTuWBH1co7CShKh3TJrLZkdXqFLZUMXBhWzFEhWvqD/i0mJuBfv5B4qwuvhXyHoCFuJHDkpNf6El4mNiGYDIzzCYQMWio3iNdH/roVpfJg+0t7S7JtpYLrGdL/mWCBHFDD6e03EDGkz71THeKaZva92uGDXeIJT2APVvNvlcltXrVN36A07b5RF7WoCbzMv9L9tNADU+YhfFaj0kiEuv9my0fU60DgMQpaP/16e6aTD8j0AkKBlAvcvYcQ+INghYrHrbjhhW6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YyPAAwQXi7UbHk9cv7pNm4qTho3KuMWswcakzFgYrD0=;
 b=CcWcuJli0xVM67kiCtLGiN8cF2rKZk9G7bBXi/ucZvCy25pttAsl0sxr9pA/C+8uWzvclz+iPz8/D6xhIiuxlaLGgtGrI5MvHkqIalQt6YHgB7vk+DYVRajwd8j57+tPWpy6LiDa/HuYql7SiWEj3ck4f4b7UtL+SPxP+NvWZX/liKDwgk45tmZw9DlL9K/Eit6ralz5Yqfsqn1yuBUzEcegETb0G1dZF39ytOS1qrsLv9kQ98/EhrGyN+0+nABGecMawZaBhuMaVro8tQqxpsT87yjiEmWp7zsiYDuKbcV0fI174buAU7Hv9hLc2tw+1/c5oetx1Enzv3eifJYrMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YyPAAwQXi7UbHk9cv7pNm4qTho3KuMWswcakzFgYrD0=;
 b=iQWy9WqWHBKBZY23ESgieIamL2Ju1aoud/64S54dh6vrkVK2FduGj9aaPDKSm6gbUQlO3NTU9iCirCw2AQq0GBNtZA+k8kVFemjbAp48HrRC3jgWgqCAARiiFb8J0QfcqSILScn14B3D6ct1yXdke2dYSIf2wmveRAJRInpNsTY=
Received: from VI1PR05MB6544.eurprd05.prod.outlook.com (20.179.27.210) by
 VI1PR05MB6144.eurprd05.prod.outlook.com (20.178.205.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Thu, 15 Aug 2019 07:42:39 +0000
Received: from VI1PR05MB6544.eurprd05.prod.outlook.com
 ([fe80::4810:d157:267a:83b9]) by VI1PR05MB6544.eurprd05.prod.outlook.com
 ([fe80::4810:d157:267a:83b9%4]) with mapi id 15.20.2157.022; Thu, 15 Aug 2019
 07:42:39 +0000
From:   Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
To:     Philippe Schenker <philippe.schenker@toradex.com>
CC:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        "stefan@agner.ch" <stefan@agner.ch>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?utf-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>,
        Fabio Estevam <festevam@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH v4 17/21] ARM: dts: imx6ull: improve can templates
Thread-Topic: [PATCH v4 17/21] ARM: dts: imx6ull: improve can templates
Thread-Index: AQHVUzz64LFMvw0vFEC8FM2ndGfujQ==
Date:   Thu, 15 Aug 2019 07:42:37 +0000
Message-ID: <CAGgjyvHi=DhUFE_6e_iPn91RNqJgDbGAEvZodji6OME9x5crrw@mail.gmail.com>
References: <20190812142105.1995-1-philippe.schenker@toradex.com>
 <20190812142105.1995-18-philippe.schenker@toradex.com>
In-Reply-To: <20190812142105.1995-18-philippe.schenker@toradex.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0PR07CA0013.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::26) To VI1PR05MB6544.eurprd05.prod.outlook.com
 (2603:10a6:803:ff::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=oleksandr.suvorov@toradex.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-gm-message-state: APjAAAUzOpUHcHRvFdbXXYL96WsuuWwg2F4wIsFmwVb9reTFkV4zYpus
        9hg4JbN2a4mVOCWwmsspZ++lw0EXGGT8vCNWKAs=
x-google-smtp-source: APXvYqx4tjUxCzIeh16S5Mr6goxour78zIRul8lCMmCgPaFA1PcD2y5gnUcQDq4KmrnOqeZ7bNtofEAGqXD8W8nUJIk=
x-received: by 2002:a05:6402:125a:: with SMTP id
 l26mr4007976edw.192.1565854956140; Thu, 15 Aug 2019 00:42:36 -0700 (PDT)
x-gmail-original-message-id: <CAGgjyvHi=DhUFE_6e_iPn91RNqJgDbGAEvZodji6OME9x5crrw@mail.gmail.com>
x-originating-ip: [209.85.208.48]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2f87f67a-6f1f-4d64-c923-08d721542477
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR05MB6144;
x-ms-traffictypediagnostic: VI1PR05MB6144:
x-microsoft-antispam-prvs: <VI1PR05MB61447DD0D403D39AD7A3C83EF9AC0@VI1PR05MB6144.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2150;
x-forefront-prvs: 01304918F3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(346002)(136003)(39840400004)(396003)(376002)(199004)(189003)(14444005)(66556008)(66446008)(64756008)(66476007)(8676002)(6486002)(66946007)(6636002)(81156014)(81166006)(6436002)(498394004)(8936002)(66066001)(71200400001)(71190400001)(486006)(61726006)(54906003)(14454004)(2906002)(86362001)(256004)(229853002)(61266001)(5660300002)(6512007)(9686003)(4326008)(102836004)(26005)(99286004)(478600001)(386003)(186003)(6506007)(6246003)(305945005)(55446002)(7736002)(53936002)(107886003)(450100002)(446003)(44832011)(3846002)(6116002)(11346002)(6862004)(25786009)(52116002)(476003)(95326003)(76176011)(53546011)(316002)(32563001);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR05MB6144;H:VI1PR05MB6544.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 62c1BFE/3GYHtL8zpV38iFgzMoG3aVLRpweE7gFHYhiP/nlKxP/4O65HDA/9Qro6PZeO6TXwnaWEP30QjBBuEZ4E7hXkmXvSjPg6kAknPuZOmRzilmdA0eaObzbAQEufGfcj47aPJ51gdnyvbm6dSzteNOsEXx4PCvflWP9Ys2QuGdvJWiCj3WlD4kTvcqbaYJN7wYjTzKJqTgsWNva61rigqLXVe9nrhyeLfQUOVYuje16bSmqYWlh4wWoz16dZ+D3NfJP5QO0FusjNHqXoYF1rqvW1Z4xDVMzNroeIZuDj5s0JgIS2NBX5VXFOoeEes7ToqSuwKHdT6bdsQzhzzg70GeB9Ik/l9dtQTGltFEFoDENOTpV9yB+l/+zOib0LUijCp/FQpMLAO0iIxirrWVABCpkrqL7L2YIwTRa2USw=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <20227A4824A37D4F8B391A70AE272375@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f87f67a-6f1f-4d64-c923-08d721542477
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2019 07:42:37.0753
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5DLdLpsaE23VP7w17mN0UFfn/QPOCkY7AbnZIKBxzkhQ1e/pA2NM0vYsofnbfFgyb43FsNdah6zRR//9xwxJRZH1ygmIHucEqhZTqX6Mxwo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6144
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCBBdWcgMTIsIDIwMTkgYXQgNToyNCBQTSBQaGlsaXBwZSBTY2hlbmtlcg0KPHBoaWxp
cHBlLnNjaGVua2VyQHRvcmFkZXguY29tPiB3cm90ZToNCj4NCj4gRnJvbTogTWF4IEtydW1tZW5h
Y2hlciA8bWF4LmtydW1tZW5hY2hlckB0b3JhZGV4LmNvbT4NCj4NCj4gQWRkIHRoZSBwaW5tdXhp
bmcgYW5kIGEgaW5hY3RpdmUgbm9kZSBmb3IgZmxleGNhbjEgb24gU09ESU1NIDU1LzYzDQo+IGFu
ZCBtb3ZlIHRoZSBpbmFjdGl2ZSBmbGV4Y2FuIG5vZGVzIHRvIGlteDZ1bGwtY29saWJyaS1ldmFs
LXYzLmR0c2kNCj4gd2hlcmUgdGhleSBiZWxvbmcuDQo+DQo+IE5vdGUgdGhhdCB0aGlzIGNvbW1p
dCBkb2VzIG5vdCBlbmFibGUgZmxleGNhbiBmdW5jdGlvbmFsaXR5LCBidXQgcmF0aGVyDQo+IGVh
c2VzIHRoZSBlZmZvcnQgbmVlZGVkIHRvIGRvIHNvLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBNYXgg
S3J1bW1lbmFjaGVyIDxtYXgua3J1bW1lbmFjaGVyQHRvcmFkZXguY29tPg0KPiBTaWduZWQtb2Zm
LWJ5OiBQaGlsaXBwZSBTY2hlbmtlciA8cGhpbGlwcGUuc2NoZW5rZXJAdG9yYWRleC5jb20+DQoN
ClJldmlld2VkLWJ5OiBPbGVrc2FuZHIgU3V2b3JvdiA8b2xla3NhbmRyLnN1dm9yb3ZAdG9yYWRl
eC5jb20+DQoNCj4NCj4gLS0tDQo+DQo+IENoYW5nZXMgaW4gdjQ6DQo+IC0gTW92ZSBjYW4gbm9k
ZXMgdG8gbW9kdWxlIGRldmljZXRlcmVlIGluY2x1ZGUgaW14NnVsbC1jb2xpYnJpLmR0c2kNCj4N
Cj4gQ2hhbmdlcyBpbiB2MzogTm9uZQ0KPiBDaGFuZ2VzIGluIHYyOiBOb25lDQo+DQo+ICAuLi4v
YXJtL2Jvb3QvZHRzL2lteDZ1bGwtY29saWJyaS1ub253aWZpLmR0c2kgfCAgMiArLQ0KPiAgYXJj
aC9hcm0vYm9vdC9kdHMvaW14NnVsbC1jb2xpYnJpLXdpZmkuZHRzaSAgIHwgIDIgKy0NCj4gIGFy
Y2gvYXJtL2Jvb3QvZHRzL2lteDZ1bGwtY29saWJyaS5kdHNpICAgICAgICB8IDI4ICsrKysrKysr
KysrKysrKysrLS0NCj4gIDMgZmlsZXMgY2hhbmdlZCwgMjggaW5zZXJ0aW9ucygrKSwgNCBkZWxl
dGlvbnMoLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDZ1bGwtY29s
aWJyaS1ub253aWZpLmR0c2kgYi9hcmNoL2FybS9ib290L2R0cy9pbXg2dWxsLWNvbGlicmktbm9u
d2lmaS5kdHNpDQo+IGluZGV4IGZiMjEzYmVjNDY1NC4uOTVhMTFiOGJjYmRiIDEwMDY0NA0KPiAt
LS0gYS9hcmNoL2FybS9ib290L2R0cy9pbXg2dWxsLWNvbGlicmktbm9ud2lmaS5kdHNpDQo+ICsr
KyBiL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDZ1bGwtY29saWJyaS1ub253aWZpLmR0c2kNCj4gQEAg
LTE1LDcgKzE1LDcgQEANCj4gICZpb211eGMgew0KPiAgICAgICAgIHBpbmN0cmwtbmFtZXMgPSAi
ZGVmYXVsdCI7DQo+ICAgICAgICAgcGluY3RybC0wID0gPCZwaW5jdHJsX2dwaW8xICZwaW5jdHJs
X2dwaW8yICZwaW5jdHJsX2dwaW8zDQo+IC0gICAgICAgICAgICAgICAmcGluY3RybF9ncGlvNCAm
cGluY3RybF9ncGlvNSAmcGluY3RybF9ncGlvNj47DQo+ICsgICAgICAgICAgICAgICAmcGluY3Ry
bF9ncGlvNCAmcGluY3RybF9ncGlvNSAmcGluY3RybF9ncGlvNiAmcGluY3RybF9ncGlvNz47DQo+
ICB9Ow0KPg0KPiAgJmlvbXV4Y19zbnZzIHsNCj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2Jvb3Qv
ZHRzL2lteDZ1bGwtY29saWJyaS13aWZpLmR0c2kgYi9hcmNoL2FybS9ib290L2R0cy9pbXg2dWxs
LWNvbGlicmktd2lmaS5kdHNpDQo+IGluZGV4IDAzOGQ4YzkwZjZkZi4uYTA1NDU0MzFiM2RjIDEw
MDY0NA0KPiAtLS0gYS9hcmNoL2FybS9ib290L2R0cy9pbXg2dWxsLWNvbGlicmktd2lmaS5kdHNp
DQo+ICsrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDZ1bGwtY29saWJyaS13aWZpLmR0c2kNCj4g
QEAgLTI2LDcgKzI2LDcgQEANCj4gICZpb211eGMgew0KPiAgICAgICAgIHBpbmN0cmwtbmFtZXMg
PSAiZGVmYXVsdCI7DQo+ICAgICAgICAgcGluY3RybC0wID0gPCZwaW5jdHJsX2dwaW8xICZwaW5j
dHJsX2dwaW8yICZwaW5jdHJsX2dwaW8zDQo+IC0gICAgICAgICAgICAgICAmcGluY3RybF9ncGlv
NCAmcGluY3RybF9ncGlvNT47DQo+ICsgICAgICAgICAgICAgICAmcGluY3RybF9ncGlvNCAmcGlu
Y3RybF9ncGlvNSAmcGluY3RybF9ncGlvNz47DQo+DQo+ICB9Ow0KPg0KPiBkaWZmIC0tZ2l0IGEv
YXJjaC9hcm0vYm9vdC9kdHMvaW14NnVsbC1jb2xpYnJpLmR0c2kgYi9hcmNoL2FybS9ib290L2R0
cy9pbXg2dWxsLWNvbGlicmkuZHRzaQ0KPiBpbmRleCBlMzIyMDI5OGRkNmYuLjZkODUwZDk5N2Ux
ZSAxMDA2NDQNCj4gLS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMvaW14NnVsbC1jb2xpYnJpLmR0c2kN
Cj4gKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvaW14NnVsbC1jb2xpYnJpLmR0c2kNCj4gQEAgLTU0
LDYgKzU0LDE4IEBADQo+ICAgICAgICAgdnJlZi1zdXBwbHkgPSA8JnJlZ19tb2R1bGVfM3YzX2F2
ZGQ+Ow0KPiAgfTsNCj4NCj4gKyZjYW4xIHsNCj4gKyAgICAgICBwaW5jdHJsLW5hbWVzID0gImRl
ZmF1bHQiOw0KPiArICAgICAgIHBpbmN0cmwtMCA9IDwmcGluY3RybF9mbGV4Y2FuMT47DQo+ICsg
ICAgICAgc3RhdHVzID0gImRpc2FibGVkIjsNCj4gK307DQo+ICsNCj4gKyZjYW4yIHsNCj4gKyAg
ICAgICBwaW5jdHJsLW5hbWVzID0gImRlZmF1bHQiOw0KPiArICAgICAgIHBpbmN0cmwtMCA9IDwm
cGluY3RybF9mbGV4Y2FuMj47DQo+ICsgICAgICAgc3RhdHVzID0gImRpc2FibGVkIjsNCj4gK307
DQo+ICsNCj4gIC8qIENvbGlicmkgU1BJICovDQo+ICAmZWNzcGkxIHsNCj4gICAgICAgICBjcy1n
cGlvcyA9IDwmZ3BpbzMgMjYgR1BJT19BQ1RJVkVfSElHSD47DQo+IEBAIC0yNTYsNiArMjY4LDEz
IEBADQo+ICAgICAgICAgICAgICAgICA+Ow0KPiAgICAgICAgIH07DQo+DQo+ICsgICAgICAgcGlu
Y3RybF9mbGV4Y2FuMTogZmxleGNhbjEtZ3JwIHsNCj4gKyAgICAgICAgICAgICAgIGZzbCxwaW5z
ID0gPA0KPiArICAgICAgICAgICAgICAgICAgICAgICBNWDZVTF9QQURfRU5FVDFfUlhfREFUQTBf
X0ZMRVhDQU4xX1RYICAgMHgxYjAyMA0KPiArICAgICAgICAgICAgICAgICAgICAgICBNWDZVTF9Q
QURfRU5FVDFfUlhfREFUQTFfX0ZMRVhDQU4xX1JYICAgMHgxYjAyMA0KPiArICAgICAgICAgICAg
ICAgPjsNCj4gKyAgICAgICB9Ow0KPiArDQo+ICAgICAgICAgcGluY3RybF9mbGV4Y2FuMjogZmxl
eGNhbjItZ3JwIHsNCj4gICAgICAgICAgICAgICAgIGZzbCxwaW5zID0gPA0KPiAgICAgICAgICAg
ICAgICAgICAgICAgICBNWDZVTF9QQURfRU5FVDFfVFhfREFUQTBfX0ZMRVhDQU4yX1JYICAgMHgx
YjAyMA0KPiBAQCAtMjcxLDggKzI5MCw2IEBADQo+DQo+ICAgICAgICAgcGluY3RybF9ncGlvMTog
Z3BpbzEtZ3JwIHsNCj4gICAgICAgICAgICAgICAgIGZzbCxwaW5zID0gPA0KPiAtICAgICAgICAg
ICAgICAgICAgICAgICBNWDZVTF9QQURfRU5FVDFfUlhfREFUQTBfX0dQSU8yX0lPMDAgICAgMHg3
NCAvKiBTT0RJTU0gNTUgKi8NCj4gLSAgICAgICAgICAgICAgICAgICAgICAgTVg2VUxfUEFEX0VO
RVQxX1JYX0RBVEExX19HUElPMl9JTzAxICAgIDB4NzQgLyogU09ESU1NIDYzICovDQo+ICAgICAg
ICAgICAgICAgICAgICAgICAgIE1YNlVMX1BBRF9VQVJUM19SWF9EQVRBX19HUElPMV9JTzI1ICAg
ICAwWDE0IC8qIFNPRElNTSA3NyAqLw0KPiAgICAgICAgICAgICAgICAgICAgICAgICBNWDZVTF9Q
QURfSlRBR19UQ0tfX0dQSU8xX0lPMTQgICAgICAgICAgMHgxNCAvKiBTT0RJTU0gOTkgKi8NCj4g
ICAgICAgICAgICAgICAgICAgICAgICAgTVg2VUxfUEFEX05BTkRfQ0UxX0JfX0dQSU80X0lPMTQg
ICAgICAgIDB4MTQgLyogU09ESU1NIDEzMyAqLw0KPiBAQCAtMzI1LDYgKzM0MiwxMyBAQA0KPiAg
ICAgICAgICAgICAgICAgPjsNCj4gICAgICAgICB9Ow0KPg0KPiArICAgICAgIHBpbmN0cmxfZ3Bp
bzc6IGdwaW83LWdycCB7IC8qIENBTjEgKi8NCj4gKyAgICAgICAgICAgICAgIGZzbCxwaW5zID0g
PA0KPiArICAgICAgICAgICAgICAgICAgICAgICBNWDZVTF9QQURfRU5FVDFfUlhfREFUQTBfX0dQ
SU8yX0lPMDAgICAgMHg3NCAvKiBTT0RJTU0gNTUgKi8NCj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgTVg2VUxfUEFEX0VORVQxX1JYX0RBVEExX19HUElPMl9JTzAxICAgIDB4NzQgLyogU09ESU1N
IDYzICovDQo+ICsgICAgICAgICAgICAgICA+Ow0KPiArICAgICAgIH07DQo+ICsNCj4gICAgICAg
ICBwaW5jdHJsX2dwbWlfbmFuZDogZ3BtaS1uYW5kLWdycCB7DQo+ICAgICAgICAgICAgICAgICBm
c2wscGlucyA9IDwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgTVg2VUxfUEFEX05BTkRfREFU
QTAwX19SQVdOQU5EX0RBVEEwMCAgIDB4MTAwYTkNCj4gLS0NCj4gMi4yMi4wDQo+DQoNCg0KLS0g
DQpCZXN0IHJlZ2FyZHMNCk9sZWtzYW5kciBTdXZvcm92DQoNClRvcmFkZXggQUcNCkFsdHNhZ2Vu
c3RyYXNzZSA1IHwgNjA0OCBIb3J3L0x1emVybiB8IFN3aXR6ZXJsYW5kIHwgVDogKzQxIDQxIDUw
MA0KNDgwMCAobWFpbiBsaW5lKQ0K
