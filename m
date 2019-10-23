Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AD39CA9EB7
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 02:56:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B95D214B2
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 02:56:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389455AbfJWC4N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 22:56:13 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:2061 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732748AbfJWC4N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 22:56:13 -0400
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.56])
        by Forcepoint Email with ESMTP id 960EAB3C485D39489CD2;
        Wed, 23 Oct 2019 10:56:05 +0800 (CST)
Received: from dggeme711-chm.china.huawei.com (10.1.199.107) by
 DGGEMM404-HUB.china.huawei.com (10.3.20.212) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 23 Oct 2019 10:56:05 +0800
Received: from dggeme762-chm.china.huawei.com (10.3.19.108) by
 dggeme711-chm.china.huawei.com (10.1.199.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Wed, 23 Oct 2019 10:56:05 +0800
Received: from dggeme762-chm.china.huawei.com ([10.8.68.53]) by
 dggeme762-chm.china.huawei.com ([10.8.68.53]) with mapi id 15.01.1713.004;
 Wed, 23 Oct 2019 10:56:05 +0800
From:   linfeilong <linfeilong@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?gb2312?B?tPC4tDogW1BBVENIXSBzY3JpcHRzOiBmaXggbWVtbGVhayBlcnJvciBpbiBy?=
 =?gb2312?Q?ead=5Ffile?=
Thread-Topic: [PATCH] scripts: fix memleak error in read_file
Thread-Index: AdWIy2TaZdJlKP2sR+evaSWkQsNSfgAF216AABo27cA=
Date:   Wed, 23 Oct 2019 02:56:04 +0000
Message-ID: <9e0807659574488490391feff79870e6@huawei.com>
References: <bf5c73b4b8534189be0f0df81fe863f0@huawei.com>
 <20191022151305.c4af5c45ee7c605b4b12ae32@linux-foundation.org>
In-Reply-To: <20191022151305.c4af5c45ee7c605b4b12ae32@linux-foundation.org>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.173.220.147]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMiBPY3QgMjAxOSAxMTo0Nzo1OSArMDAwMCBsaW5mZWlsb25nIDxsaW5mZWlsb25n
QGh1YXdlaS5jb20+IHdyb3RlOg0KPg0KPj4gQW4gZXJyb3IgaXMgZm91bmQgYnkgdGhlIHN0YXRp
YyBjb2RlIGFuYWx5c2lzIHRvb2w6ICJtZW1sZWFrIg0KPj4gRml4IHRoaXMgYnkgYWRkIGZyZWUg
YmVmb3JlIHJldHVybi4NCj4+IA0KPj4gU2lnbmVkLW9mZi1ieTogRmVpbG9uZyBMaW4gPGxpbmZl
aWxvbmdAaHVhd2VpLmNvbT4NCj4+IC0tLQ0KPj4gIHNjcmlwdHMvaW5zZXJ0LXN5cy1jZXJ0LmMg
fCAxICsNCj4+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCj4+IA0KPj4gZGlmZiAt
LWdpdCBhL3NjcmlwdHMvaW5zZXJ0LXN5cy1jZXJ0LmMgYi9zY3JpcHRzL2luc2VydC1zeXMtY2Vy
dC5jIA0KPj4gaW5kZXggODkwMjgzNi4uMjJkOTlhOCAxMDA2NDQNCj4+IC0tLSBhL3NjcmlwdHMv
aW5zZXJ0LXN5cy1jZXJ0LmMNCj4+ICsrKyBiL3NjcmlwdHMvaW5zZXJ0LXN5cy1jZXJ0LmMNCj4+
IEBAIC0yNTAsNiArMjUwLDcgQEAgc3RhdGljIGNoYXIgKnJlYWRfZmlsZShjaGFyICpmaWxlX25h
bWUsIGludCAqc2l6ZSkNCj4+ICAJfQ0KPj4gIAlpZiAocmVhZChmZCwgYnVmLCAqc2l6ZSkgIT0g
KnNpemUpIHsNCj4+ICAJCXBlcnJvcigiRmlsZSByZWFkIGZhaWxlZCIpOw0KPj4gKwkJCWZyZWUo
YnVmKTsNCj4+ICAJCWNsb3NlKGZkKTsNCj4+ICAJCXJldHVybiBOVUxMOw0KPj4gIAl9DQo+DQo+
QSBmZXcgbGluZXMgbGF0ZXIgd2UgZG8NCj4NCj4JcmV0dXJuIGJ1ZjsNCj4NCj5zbyB0aGUgcGF0
Y2ggYWRkcyBhIHVzZS1hZnRlci1mcmVlIGVycm9yLiANCj4NCj5XZSBjb3VsZCBkbyBhIGZyZWUo
Y2VydCkgZG93biBpbiBtYWluKCkgb3Igd2UgY291bGQganVzdCBkbyBub3RoaW5nIC0NCj5yZWFk
X2ZpbGUoKSBpcyBvbmx5IGNhbGxlZCBhIHNpbmdsZSB0aW1lLg0KDQpUaGFua3MsIGJ1dCB0aGVy
ZSBpcyBubyB1c2UtYWZ0ZXItZnJlZSBhcyB3ZSBkbyBmcmVlIGp1c3QgYmVmb3JlIHJldHVybiBO
VUxMLg0KQW5kIEkgdGhpbmsgZG8gZnJlZSBpbiBlcnJvciBzY2VuZXMgbWFrZXMgdGhlIGNvZGUg
bG9vayBiZXR0ZXIuDQo=
