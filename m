Return-Path: <SRS0=/nvU=VK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E624EC742D7
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 12:50:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B076A2084C
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 12:50:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="Ztw7DwPZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbfGMMuj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jul 2019 08:50:39 -0400
Received: from mail-eopbgr70138.outbound.protection.outlook.com ([40.107.7.138]:53877
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727725AbfGMMui (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jul 2019 08:50:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g/J1NHerq+CTQ/BTPKsDfJQfaqnmq8tOCdPl5uJsGe25iOd/ywYvIqeADYSbKCJvrQcMgSO2ucLKAB1jai7f/e5O8Tn7i8sie8POxbGNq5rzbWWIr2C6BDtZv20LPq7/4VHL17ugbepM2pFcZlUgriLNq8bIRzhrF4uvmoRJ5P9gpbOVgQDUBbsV3NCdqgVBpO7473FZPGu5K+KSEEwtDha+l68PzmaZ7XLRZ/vBAwr+U5CsNgb08Vf9sEX1vCJNBme9GXM2uHA36fn6mJjbiPcbDyNLDkHN0BW6nt5LE0NbzL26531ouiO+wOhlEKlH9FCTf5X0zyAFiAEeMnkY+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QDVehqKB2ZeByEDqJifLLuCgz6CWavLqLW1mayy8FLQ=;
 b=og2bkvjh750gcM8vGqPB/L9vpUIppBVB9agB7ZrNIrfc36SyFjAst2pZxzsnIYmMnxJKPEnxezFVk3fQWsyyk+4FEB1mC9JOWz+o1/MzBAwGrPolEn7qGq+qdfSzOW4c7imXVqLDSeXBI2RIncwdU/H1+CtCKa7rCYFzKxNBFrCCjwBSTgGZstR8gZX93PSnSmn6NNPT4RUPMRQl+//VamEEvZ787Oa+dphM5kTyWYTzQY0Vngv9hqY94ZWvx1FDPeR/Z6bB3/PN2kDq4NNLuCBUlnH7pbddh5yl1seNSSBfE2MxB6+pdJce0f+bl6lC20EMW5lKvNAkRewdU5nikw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=toradex.com;dmarc=pass action=none
 header.from=toradex.com;dkim=pass header.d=toradex.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QDVehqKB2ZeByEDqJifLLuCgz6CWavLqLW1mayy8FLQ=;
 b=Ztw7DwPZviH15DoqHXENdnaBhLNAsU1mAFt6xpwGThx+4U4uwM1Bq3tasnhx0V0JKgdfPI4tTRy2pmt/xMFRXHvF6ym92jTrTYGfw3b/yuKVkoXRO6xSxVe1sAilLNw43CkSZ2ACwaHOO1yu6dqvwjMHv01s4T4R4/O+fMqVnCE=
Received: from AM6PR05MB6535.eurprd05.prod.outlook.com (20.179.18.16) by
 AM6PR05MB6472.eurprd05.prod.outlook.com (20.179.7.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.14; Sat, 13 Jul 2019 12:49:53 +0000
Received: from AM6PR05MB6535.eurprd05.prod.outlook.com
 ([fe80::c860:b386:22a:8ec9]) by AM6PR05MB6535.eurprd05.prod.outlook.com
 ([fe80::c860:b386:22a:8ec9%6]) with mapi id 15.20.2073.012; Sat, 13 Jul 2019
 12:49:53 +0000
From:   Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
To:     Arnd Bergmann <arnd@arndb.de>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Wen Yang <wen.yang99@zte.com.cn>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: audio-graph-card: fix type mismatch warning
Thread-Topic: [PATCH] ASoC: audio-graph-card: fix type mismatch warning
Thread-Index: AQHVOXl2ZQlhuKvEVEakPTICr0j5XQ==
Date:   Sat, 13 Jul 2019 12:49:51 +0000
Message-ID: <CAGgjyvHBfyviNofKay47TGG7EGBHQDSiq78y+=FGtZc3eZKpOw@mail.gmail.com>
References: <20190712085605.4062896-1-arnd@arndb.de>
In-Reply-To: <20190712085605.4062896-1-arnd@arndb.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM3PR07CA0121.eurprd07.prod.outlook.com
 (2603:10a6:207:7::31) To AM6PR05MB6535.eurprd05.prod.outlook.com
 (2603:10a6:20b:71::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=oleksandr.suvorov@toradex.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-gm-message-state: APjAAAXU12blU+ke11Bj43Y0RITyHabeajs/Hi8tEnUJku+QTzTX3Say
        btYsSgh9zK2302/sIjivlvuv9D2bvGwV/wrpQkU=
x-google-smtp-source: APXvYqyHz3vONT9peljHK2/8BqeWnne53tQZ8KrmYJI1MCCGu8ZBTA5UIWzcoweVpj/wtZYxfsc451saVMcvxldSHPg=
x-received: by 2002:a17:906:25c5:: with SMTP id
 n5mr12260286ejb.195.1563022191006; Sat, 13 Jul 2019 05:49:51 -0700 (PDT)
x-gmail-original-message-id: <CAGgjyvHBfyviNofKay47TGG7EGBHQDSiq78y+=FGtZc3eZKpOw@mail.gmail.com>
x-originating-ip: [209.85.208.53]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6d3557f1-3ec3-4765-c7e1-08d7079098dd
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:AM6PR05MB6472;
x-ms-traffictypediagnostic: AM6PR05MB6472:
x-microsoft-antispam-prvs: <AM6PR05MB6472B8E1766A1E5C0CE8D171F9CD0@AM6PR05MB6472.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2331;
x-forefront-prvs: 00979FCB3A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(376002)(39840400004)(366004)(346002)(396003)(189003)(199004)(11346002)(478600001)(6246003)(95326003)(25786009)(66446008)(5660300002)(446003)(76176011)(305945005)(53936002)(52116002)(86362001)(68736007)(99286004)(81156014)(8676002)(476003)(55446002)(7736002)(71200400001)(81166006)(71190400001)(9686003)(66476007)(64756008)(6862004)(14444005)(54906003)(66556008)(8936002)(66946007)(316002)(66066001)(6436002)(386003)(102836004)(2906002)(61726006)(6486002)(229853002)(3846002)(44832011)(4326008)(256004)(6506007)(14454004)(486006)(26005)(186003)(6116002)(498394004)(61266001)(6512007);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR05MB6472;H:AM6PR05MB6535.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: NjGB3Fs2npt+mkJSupA0mHYnf0rWB27uwbW3hqGSD3rB9KbBcQZC6M4lv1fnxtA+tZp3YxUs8bqXCypF1Weq8OjTEcPH7JGYBEJmuIk7rmJ1U36rTcyTvOrLAnFW3T7T4NJcnafzFPgITjvFi4NdLd7tenHJB1Bj/0mlIPA/aroruMmj6/h9GIj/gNLflxJ+YwCMs69eBT5PPjptO16xVx6yfyHV13FE3nFxrWajiFYmf35Oy6ILmzMBJ5f2HQl/lV8Kt8qcWcX7eIMYjZEIJes/cKebY1M4HbmvnMQrrlG9loeOgE2IEPI6g4uEo1376pZVqvtCDlVMe+DpmUR57SvYSZlZyAPvfA4S7jWDBZcw7NhIKHT3qQf3xDUnuFFfLrOUW55Iq3g4LaxJxX9Z5M/obG67NnUZC6hAlh/0Hyk=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4865FEF536F5FE408CD1F45B19749744@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d3557f1-3ec3-4765-c7e1-08d7079098dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2019 12:49:51.9699
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oleksandr.suvorov@toradex.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB6472
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAxMiBKdWwgMjAxOSBhdCAxMTo1NywgQXJuZCBCZXJnbWFubiA8YXJuZEBhcm5kYi5k
ZT4gd3JvdGU6DQo+DQo+IFRoZSBuZXcgdGVtcG9yYXJ5IHZhcmlhYmxlIGlzIGxhY2tzIGEgJ2Nv
bnN0JyBhbm5vdGF0aW9uOg0KPg0KPiBzb3VuZC9zb2MvZ2VuZXJpYy9hdWRpby1ncmFwaC1jYXJk
LmM6ODc6NzogZXJyb3I6IGFzc2lnbmluZyB0byAndTMyIConIChha2EgJ3Vuc2lnbmVkIGludCAq
JykgZnJvbSAnY29uc3Qgdm9pZCAqJyBkaXNjYXJkcyBxdWFsaWZpZXJzIFstV2Vycm9yLC1XaW5j
b21wYXRpYmxlLXBvaW50ZXItdHlwZXMtZGlzY2FyZHMtcXVhbGlmaWVyc10NCj4NCj4gRml4ZXM6
IGMxNTJmODQ5MWE4ZCAoIkFTb0M6IGF1ZGlvLWdyYXBoLWNhcmQ6IGZpeCBhbiB1c2UtYWZ0ZXIt
ZnJlZSBpbiBncmFwaF9nZXRfZGFpX2lkKCkiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBBcm5kIEJlcmdt
YW5uIDxhcm5kQGFybmRiLmRlPg0KDQpSZXZpZXdlZC1ieTogT2xla3NhbmRyIFN1dm9yb3YgPG9s
ZWtzYW5kci5zdXZvcm92QHRvcmFkZXguY29tPg0KDQo+IC0tLQ0KPiAgc291bmQvc29jL2dlbmVy
aWMvYXVkaW8tZ3JhcGgtY2FyZC5jIHwgMiArLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0
aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9zb3VuZC9zb2MvZ2VuZXJp
Yy9hdWRpby1ncmFwaC1jYXJkLmMgYi9zb3VuZC9zb2MvZ2VuZXJpYy9hdWRpby1ncmFwaC1jYXJk
LmMNCj4gaW5kZXggYzhhYmI4NmFmZWZhLi4yODhkZjI0NWIyZjAgMTAwNjQ0DQo+IC0tLSBhL3Nv
dW5kL3NvYy9nZW5lcmljL2F1ZGlvLWdyYXBoLWNhcmQuYw0KPiArKysgYi9zb3VuZC9zb2MvZ2Vu
ZXJpYy9hdWRpby1ncmFwaC1jYXJkLmMNCj4gQEAgLTYzLDcgKzYzLDcgQEAgc3RhdGljIGludCBn
cmFwaF9nZXRfZGFpX2lkKHN0cnVjdCBkZXZpY2Vfbm9kZSAqZXApDQo+ICAgICAgICAgc3RydWN0
IGRldmljZV9ub2RlICplbmRwb2ludDsNCj4gICAgICAgICBzdHJ1Y3Qgb2ZfZW5kcG9pbnQgaW5m
bzsNCj4gICAgICAgICBpbnQgaSwgaWQ7DQo+IC0gICAgICAgdTMyICpyZWc7DQo+ICsgICAgICAg
Y29uc3QgdTMyICpyZWc7DQo+ICAgICAgICAgaW50IHJldDsNCj4NCj4gICAgICAgICAvKiB1c2Ug
ZHJpdmVyIHNwZWNpZmllZCBEQUkgSUQgaWYgZXhpc3QgKi8NCj4gLS0NCj4gMi4yMC4wDQo+DQoN
Cg0KLS0gDQpCZXN0IHJlZ2FyZHMNCk9sZWtzYW5kciBTdXZvcm92DQoNClRvcmFkZXggQUcNCkFs
dHNhZ2Vuc3RyYXNzZSA1IHwgNjA0OCBIb3J3L0x1emVybiB8IFN3aXR6ZXJsYW5kIHwgVDogKzQx
IDQxIDUwMA0KNDgwMCAobWFpbiBsaW5lKQ0K
