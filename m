Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25DBCC04E84
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 15:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEDC920657
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 15:18:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=camlinlimited.onmicrosoft.com header.i=@camlinlimited.onmicrosoft.com header.b="FrUcXCu/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727491AbfEPPS1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 11:18:27 -0400
Received: from mail-eopbgr100050.outbound.protection.outlook.com ([40.107.10.50]:55412
        "EHLO GBR01-LO2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726740AbfEPPS1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 11:18:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=camlinlimited.onmicrosoft.com; s=selector1-camlinlimited-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WaCHPVPqnFpyRaZj9TTksoERgO2SLJPtwbe+s/sjQMc=;
 b=FrUcXCu/zzpOyJ2fmMQ5yoZ7fGy1foz48EcfU2723pXOlPE8dE9gg5NXBU7YVEd72ONnkcUBnve2uu1Gqos/r3bwdWtTTxMVZ35OAegzegKjoVsIwHFg3siOCLih0nZqwTIDB1jdYYYomdkR1KDnmG6W0YSkoi6VQUikQI7WXqA=
Received: from CWXP123MB1767.GBRP123.PROD.OUTLOOK.COM (20.176.63.151) by
 CWXP123MB1848.GBRP123.PROD.OUTLOOK.COM (20.179.108.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.16; Thu, 16 May 2019 15:18:24 +0000
Received: from CWXP123MB1767.GBRP123.PROD.OUTLOOK.COM
 ([fe80::a94b:e878:949e:25e0]) by CWXP123MB1767.GBRP123.PROD.OUTLOOK.COM
 ([fe80::a94b:e878:949e:25e0%6]) with mapi id 15.20.1878.024; Thu, 16 May 2019
 15:18:24 +0000
From:   Lech Perczak <l.perczak@camlintechnologies.com>
To:     Matthew Wilcox <willy@infradead.org>,
        Eric Dumazet <edumazet@google.com>
CC:     Al Viro <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Piotr Figiel <p.figiel@camlintechnologies.com>,
        =?utf-8?B?S3J6eXN6dG9mIERyb2JpxYRza2k=?= 
        <k.drobinski@camlintechnologies.com>,
        Pawel Lenkow <p.lenkow@camlintechnologies.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Recurring warning in page_copy_sane (inside copy_page_to_iter)
 when running stress tests involving drop_caches
Thread-Topic: Recurring warning in page_copy_sane (inside copy_page_to_iter)
 when running stress tests involving drop_caches
Thread-Index: AQHU+0je8+eBBHiobkyiBc3+zJz+BKZOQv6AgB4pdgD///Y0AIAABSWAgAAEdQCAAZJcAA==
Date:   Thu, 16 May 2019 15:18:23 +0000
Message-ID: <79c406af-3cc4-1e63-80d5-267900520ef8@camlintechnologies.com>
References: <d68c83ba-bf5a-f6e8-44dd-be98f45fc97a@camlintechnologies.com>
 <14c9e6f4-3fb8-ca22-91cc-6970f1d52265@camlintechnologies.com>
 <011a16e4-6aff-104c-a19b-d2bd11caba99@camlintechnologies.com>
 <20190515144352.GC31704@bombadil.infradead.org>
 <CANn89iJ0r116a8q_+jUgP_8wPX4iS6WVppQ6HvgZFt9v9CviKA@mail.gmail.com>
 <20190515151814.GD31704@bombadil.infradead.org>
In-Reply-To: <20190515151814.GD31704@bombadil.infradead.org>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0701CA0083.eurprd07.prod.outlook.com
 (2603:10a6:3:64::27) To CWXP123MB1767.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:401:75::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=l.perczak@camlintechnologies.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [95.143.242.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 91d43b09-b5a6-4658-2239-08d6da11bce0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:CWXP123MB1848;
x-ms-traffictypediagnostic: CWXP123MB1848:
x-microsoft-antispam-prvs: <CWXP123MB1848D56FB17A4E53070F89A9870A0@CWXP123MB1848.GBRP123.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-forefront-prvs: 0039C6E5C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(376002)(136003)(39850400004)(346002)(189003)(199004)(55674003)(14444005)(316002)(71190400001)(71200400001)(26005)(6246003)(256004)(81166006)(99286004)(81156014)(14454004)(6116002)(3846002)(86362001)(25786009)(68736007)(31696002)(36756003)(4326008)(8676002)(2906002)(8936002)(53936002)(66446008)(76176011)(31686004)(66946007)(6512007)(53546011)(73956011)(386003)(6506007)(11346002)(446003)(102836004)(478600001)(2616005)(66556008)(66476007)(64756008)(186003)(54906003)(110136005)(229853002)(66066001)(5660300002)(305945005)(476003)(52116002)(486006)(6436002)(6486002)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:CWXP123MB1848;H:CWXP123MB1767.GBRP123.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: camlintechnologies.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: rv0ghT8rdQT7+nayjC9C2IzRbrKx0X9QV53RIOhP4S93SSNYevCoTXJAgKZxyQE3kQU7Fnna6uozBAVtl6fhZ196q2tqUbSrA/uNXZMz+FrYtK+bI3N81U2uZqEGt4v7XBaDSISGAfKKG3K57fVfO8bgMGK/xFg8PN/xvm6+Lls/qcsjZ9l9gF/Y7E5ieU5VqGabAi+1VnDw5rvPPgSNqewxQ4+YHDRV2bJj+6Bay0yxT01JohRDNI7ISXD2FTRysKTCaXCfBorSsA8nB0VHfv0RUfrQcW6xORNAWyMLsH8KB/6jalgZBbQM9OOjx8jiOhgySbhl4hmWIBArNlFH7qDfkWwpQlv0loElheAeEgjiUEagyVnKBk0f1VxV97PMMKxXDCKs28DGEyCHPbIr5xemxL9OOz49YELUJYPbvjs=
Content-Type: text/plain; charset="utf-8"
Content-ID: <56B38E369B89C84693A52CD5C99E478F@GBRP123.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: camlintechnologies.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91d43b09-b5a6-4658-2239-08d6da11bce0
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2019 15:18:23.9877
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fd4b1729-b18d-46d2-9ba0-2717b852b252
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP123MB1848
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpXIGRuaXUgMTUuMDUuMjAxOSBvwqAxNzoxOCwgTWF0dGhldyBXaWxjb3ggcGlzemU6DQo+IE9u
IFdlZCwgTWF5IDE1LCAyMDE5IGF0IDA4OjAyOjE3QU0gLTA3MDAsIEVyaWMgRHVtYXpldCB3cm90
ZToNCj4+IE9uIFdlZCwgTWF5IDE1LCAyMDE5IGF0IDc6NDMgQU0gTWF0dGhldyBXaWxjb3ggPHdp
bGx5QGluZnJhZGVhZC5vcmc+IHdyb3RlOg0KPj4+IFlvdSdyZSBzZWVpbmcgYSByYWNlIGJldHdl
ZW4gcGFnZV9hZGRyZXNzKHBhZ2UpIGJlaW5nIGNhbGxlZCB0d2ljZS4NCj4+PiBCZXR3ZWVuIHRo
b3NlIHR3byBjYWxscywgc29tZXRoaW5nIGhhcyBjYXVzZWQgdGhlIHBhZ2UgdG8gYmUgcmVtb3Zl
ZCBmcm9tDQo+Pj4gdGhlIHBhZ2VfYWRkcmVzc19tYXAoKSBsaXN0LiAgRXJpYydzIHBhdGNoIGF2
b2lkcyBjYWxsaW5nIHBhZ2VfYWRkcmVzcygpLA0KPj4+IHNvIGFwcGx5IGl0IGFuZCBiZSBoYXBw
eS4NCj4+IEhtbS4uLiB3b250IHRoZSBrbWFwX2F0b21pYygpIGRvbmUgbGF0ZXIsIGFmdGVyIHBh
Z2VfY29weV9zYW5lKCkgd291bGQNCj4+IHN1ZmZlciBmcm9tIHRoZSByYWNlID8NCj4+DQo+PiBJ
dCBzZWVtcyB0aGVyZSBpcyBhIHJlYWwgYnVnIHNvbWV3aGVyZSB0byBmaXguDQo+IE5vLiAgcGFn
ZV9hZGRyZXNzKCkgY2FsbGVkIGJlZm9yZSB0aGUga21hcF9hdG9taWMoKSB3aWxsIGxvb2sgdGhy
b3VnaA0KPiB0aGUgbGlzdCBvZiBtYXBwaW5ncyBhbmQgc2VlIGlmIHRoYXQgcGFnZSBpcyBtYXBw
ZWQgc29tZXdoZXJlLiAgV2UgdW5tYXANCj4gbGF6aWx5LCBzbyBhbGwgaXQgdGFrZXMgdG8gdHJp
Z2dlciB0aGlzIHJhY2UgaXMgdGhhdCB0aGUgcGFnZSBfaGFzXw0KPiBiZWVuIG1hcHBlZCBiZWZv
cmUsIGFuZCBpdHMgbWFwcGluZyBnZXRzIHRvcm4gZG93biBkdXJpbmcgdGhpcyBjYWxsLg0KPg0K
PiBXaGlsZSB0aGUgcGFnZSBpcyBrbWFwcGVkLCBpdHMgbWFwcGluZyBjYW5ub3QgYmUgdG9ybiBk
b3duLg0KDQpBbmQgdGhhdCdzIHRoZSBhbnN3ZXIgSSdtIHJlYWxseSBnbGFkIHRvIGhlYXIuIA0K
SW4gdGhlIG1lYW50aW1lIEkndmUgc2V0IHVwIGEgdGVzdCBydW4gd2l0aCBDT05GSUdfSElHSE1F
TSBkaXNhYmxlZA0KdG8gYmUgZXh0cmEgc3VyZSwgaG93ZXZlciBxdWl0ZSBleHBlY3RlZGx5IGl0
IHJvYnMgdGhlIHN5c3RlbSBvZiAyNTZNaUINCm9mIGFjY2Vzc2libGUgbWVtb3J5Lg0KDQpVbmZv
cnR1bmF0bHksIGxvb2tpbmcgdGhyb3VnaCBkZWZjb25maWdzIGZvciAzMi1iaXQgQVJNLCBDT05G
SUdfSElHSE1FTQ0KaXMgZW5hYmxlZCBpbiBxdWl0ZSBhIGZldyBvZiB0aGVtLCBpLk1YIGluY2x1
ZGVkLg0KDQpJJ2xsIHBpY2sgdXAgdGhlIHBhdGNoIHRoZW4gYW5kIGRyb3AgaXQgd2hlbiBpdCBn
ZXRzIGluY2x1ZGVkIGluIDQuMTkueS4NClRoYW5rcyENCg0KLS0NCldpdGgga2luZCByZWdhcmRz
LA0KTGVjaA0KDQo=
