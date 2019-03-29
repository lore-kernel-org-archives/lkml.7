Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B9AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 14:26:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBC192183F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 14:26:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="EIra9zqR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729082AbfC2O0m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 10:26:42 -0400
Received: from mail-eopbgr800082.outbound.protection.outlook.com ([40.107.80.82]:22577
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728743AbfC2O0m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 10:26:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ffIcDvT04okzWwcXsupfD0KF8O/6QWwOKPVqZrrMnJo=;
 b=EIra9zqRAMgknuTLvzcNlUbw8HEU/coEh/9rzcdCq/VghGg6+9Z1g4VJs+RMNk6QrgD2GZuVHd/+EuONT+xISdZjTJlFfGuDaPjYWq1v+n8Dwi5g/80TD6T4LZE/4cikVwJlxV3EtPIE7CnLhVtko6UY5wyUI9qtsr96eYrTbXA=
Received: from DM5PR12MB1546.namprd12.prod.outlook.com (10.172.36.23) by
 DM5SPR01MB82.namprd12.prod.outlook.com (10.164.253.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.15; Fri, 29 Mar 2019 14:26:38 +0000
Received: from DM5PR12MB1546.namprd12.prod.outlook.com
 ([fe80::9559:5e05:6b91:5ab4]) by DM5PR12MB1546.namprd12.prod.outlook.com
 ([fe80::9559:5e05:6b91:5ab4%6]) with mapi id 15.20.1730.019; Fri, 29 Mar 2019
 14:26:38 +0000
From:   "Koenig, Christian" <Christian.Koenig@amd.com>
To:     Jann Horn <jannh@google.com>, "Huang, Ray" <Ray.Huang@amd.com>,
        "Zhang, Jerry" <Jerry.Zhang@amd.com>
CC:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/ttm: fix out-of-bounds read in ttm_put_pages()
Thread-Topic: [PATCH] drm/ttm: fix out-of-bounds read in ttm_put_pages()
Thread-Index: AQHU5Lq1ijtDRegUDUqcAg7xNbvN2qYirVmA
Date:   Fri, 29 Mar 2019 14:26:38 +0000
Message-ID: <f5185354-478a-55bd-7107-c98b026241a9@amd.com>
References: <20190327163238.237413-1-jannh@google.com>
In-Reply-To: <20190327163238.237413-1-jannh@google.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
x-originating-ip: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
x-clientproxiedby: AM6PR08CA0009.eurprd08.prod.outlook.com
 (2603:10a6:20b:b2::21) To DM5PR12MB1546.namprd12.prod.outlook.com
 (2603:10b6:4:8::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e7d9b022-dc21-479c-8ff0-08d6b4528dd7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM5SPR01MB82;
x-ms-traffictypediagnostic: DM5SPR01MB82:
x-microsoft-antispam-prvs: <DM5SPR01MB820F9107ACDAD9EDBB2D6D835A0@DM5SPR01MB82.namprd12.prod.outlook.com>
x-forefront-prvs: 0991CAB7B3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(396003)(376002)(136003)(346002)(199004)(189003)(446003)(6506007)(6246003)(186003)(2906002)(36756003)(65956001)(72206003)(2616005)(110136005)(54906003)(6116002)(316002)(99286004)(478600001)(65806001)(65826007)(305945005)(7736002)(6436002)(256004)(14444005)(6636002)(46003)(6486002)(6512007)(486006)(58126008)(106356001)(71190400001)(76176011)(81166006)(81156014)(14454004)(386003)(31686004)(8676002)(229853002)(68736007)(102836004)(64126003)(31696002)(105586002)(53936002)(476003)(52116002)(8936002)(71200400001)(86362001)(11346002)(5660300002)(25786009)(97736004)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5SPR01MB82;H:DM5PR12MB1546.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: vjadAmOEwKdegsPobohKcfYSbE7vrlvboLatugUZJ1oCtsBzYRmH0sMfiBQSidJPat73xzjKdBqadsRul2M65bNV79Ig2KHfZgE8q+3f5Bj54QbgkrOpd2tlhSYId2JoLeOHBdhC2eUcWBXg4OsRuL6SKVhYoJuXqYVuLREceQIAyvR40FcSfz5cI6hHiScWqIGyMmv2jgZL4nZnUuBVlKySAEl2Aj90cMfTOGcMpgdOAYBnGhraKaKlfKvG9NR219HbBFCrKNUDi6ElIzOHrbAxip7y3amuyhu3ExPFocoOK6GDg3FpTDp3RIootnjrWsiG8ncnaYO21kAJACp/b0lgBHkF6ucoo4zHrCT3A82tOE3Or5GuIiDsjyJveDGoYyU59DZi+rLm/LYT9mwIZXVjMopYW8Os9eykq+OCfhA=
Content-Type: text/plain; charset="utf-8"
Content-ID: <327E8BD063F25145B14C3C6275272F60@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7d9b022-dc21-479c-8ff0-08d6b4528dd7
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2019 14:26:38.3139
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5SPR01MB82
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QW0gMjcuMDMuMTkgdW0gMTc6MzIgc2NocmllYiBKYW5uIEhvcm46DQo+IFdoZW4gdHRtX3B1dF9w
YWdlcygpIHRyaWVzIHRvIGZpZ3VyZSBvdXQgd2hldGhlciBpdCdzIGRlYWxpbmcgd2l0aA0KPiB0
cmFuc3BhcmVudCBodWdlcGFnZXMsIGl0IGp1c3QgcmVhZHMgcGFzdCB0aGUgYm91bmRzIG9mIHRo
ZSBwYWdlcyBhcnJheQ0KPiB3aXRob3V0IGEgY2hlY2s7IGluc3RlYWQsIHdoZW4gdGhlIGVuZCBv
ZiB0aGUgYXJyYXkgaXMgcmVhY2hlZCwgdHJlYXQgdGhhdA0KPiBhcyAid2UgZG9uJ3QgaGF2ZSBl
bm91Z2ggcGFnZXMgbGVmdCBmb3IgYSBodWdlcGFnZSwgc28gdGhpcyBpc24ndCBhDQo+IGh1Z2Vw
YWdlIi4NCj4NCj4NCj4gVGhpcyB3YXMgZGlzY292ZXJlZCBieSBib290aW5nIGEgbGlidmlydCBW
TSB3aXRoIFFYTCBncmFwaGljcywgd2hpY2ggY2F1c2VzDQo+IGEgS0FTQU4gc3BsYXQuIFdoZW4g
SSBhZGQgdGhlIGZvbGxvd2luZyBsaW5lIGF0IHRoZSBzdGFydCBvZg0KPiB0dG1fcGFnZV9wb29s
X2dldF9wYWdlcygpOg0KPg0KPiAgICAgIHByX3dhcm4oInR0bV9wdXRfcGFnZXMoMHglbHgsIDB4
JXgpXG4iLCAodW5zaWduZWQgbG9uZylwYWdlcywgbnBhZ2VzKTsNCj4NCj4gSSBnZXQgdGhpcyBk
bWVzZyBvdXRwdXQ6DQo+DQo+IFtUVE1dIHR0bV9wdXRfcGFnZXMoMHhmZmZmODg4MWU2OGM3YWMw
LCAweDEpDQo+IFsuLi5dDQo+ID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KPiBbLi4uXQ0KPiBCVUc6IEtBU0FOOiBzbGFi
LW91dC1vZi1ib3VuZHMgaW4gdHRtX3B1dF9wYWdlcysweDVhMC8weDY4MA0KPiBSZWFkIG9mIHNp
emUgOCBhdCBhZGRyIGZmZmY4ODgxZTY4YzdhYzggYnkgdGFzayBrd29ya2VyLzM6Mi8xODkNCj4g
Wy4uLl0NCj4gQ1BVOiAzIFBJRDogMTg5IENvbW06IGt3b3JrZXIvMzoyIE5vdCB0YWludGVkIDUu
MS4wLXJjMisgIzMzNw0KPiBIYXJkd2FyZSBuYW1lOiBRRU1VIFN0YW5kYXJkIFBDIChpNDQwRlgg
KyBQSUlYLCAxOTk2KSwgQklPUyAxLjEwLjItMSAwNC8wMS8yMDE0DQo+IFsuLi5dDQo+IENhbGwg
VHJhY2U6DQo+IFsuLi5dDQo+ICAga2FzYW5fcmVwb3J0KzB4MTRlLzB4MTkyDQo+IFsuLi5dDQo+
ICAgdHRtX3B1dF9wYWdlcysweDVhMC8weDY4MA0KPiBbLi4uXQ0KPiAgIHR0bV9wb29sX3VucG9w
dWxhdGVfaGVscGVyKzB4Y2IvMHhmMA0KPiAgIHR0bV90dF9kZXN0cm95LnBhcnQuMTErMHg4MC8w
eDkwDQo+ICAgdHRtX2JvX2NsZWFudXBfbWVtdHlwZV91c2UrMHg1Zi8weGUwDQo+ICAgdHRtX2Jv
X2NsZWFudXBfcmVmcysweDI2Mi8weDJhMA0KPiAgIHR0bV9ib19kZWxheWVkX2RlbGV0ZSsweDJj
Yi8weDJmMA0KPiBbLi4uXQ0KPiAgIHR0bV9ib19kZWxheWVkX3dvcmtxdWV1ZSsweDE3LzB4NTAN
Cj4gICBwcm9jZXNzX29uZV93b3JrKzB4NDUyLzB4N2QwDQo+ICAgd29ya2VyX3RocmVhZCsweDY5
LzB4NjkwDQo+ICAgPyBwcm9jZXNzX29uZV93b3JrKzB4N2QwLzB4N2QwDQo+ICAga3RocmVhZCsw
eDFhYy8weDFkMA0KPiAgID8ga3RocmVhZF9wYXJrKzB4YjAvMHhiMA0KPiAgIHJldF9mcm9tX2Zv
cmsrMHgxZi8weDMwDQo+DQo+IEFsbG9jYXRlZCBieSB0YXNrIDE4OToNCj4gICBfX2thc2FuX2tt
YWxsb2MuY29uc3Rwcm9wLjkrMHhhMC8weGQwDQo+ICAgX19rbWFsbG9jX25vZGUrMHgxMzIvMHgz
MjANCj4gICB0dG1fdHRfaW5pdCsweGMyLzB4MTIwDQo+ICAgcXhsX3R0bV90dF9jcmVhdGUrMHg3
Ny8weGEwDQo+ICAgdHRtX3R0X2NyZWF0ZSsweDkwLzB4ZjANCj4gICB0dG1fYm9faGFuZGxlX21v
dmVfbWVtKzB4YzE0LzB4Y2EwDQo+ICAgdHRtX2JvX2V2aWN0KzB4MjQwLzB4NTQwDQo+ICAgdHRt
X21lbV9ldmljdF9maXJzdCsweDI0MC8weDJmMA0KPiAgIHR0bV9ib19tZW1fc3BhY2UrMHg0OTIv
MHg2NjANCj4gICB0dG1fYm9fdmFsaWRhdGUrMHgxOGIvMHgyMjANCj4gICB0dG1fYm9faW5pdF9y
ZXNlcnZlZCsweDYwMy8weDZhMA0KPiAgIHR0bV9ib19pbml0KzB4YzcvMHgxYjANCj4gICBxeGxf
Ym9fY3JlYXRlKzB4MTg1LzB4MjAwDQo+ICAgcXhsX2FsbG9jX2JvX3Jlc2VydmVkKzB4N2UvMHgx
MDANCj4gICBxeGxfaW1hZ2VfYWxsb2Nfb2JqZWN0cysweGRmLzB4MWEwDQo+ICAgcXhsX2RyYXdf
ZGlydHlfZmIrMHgyZWMvMHg5YmMNCj4gICBxeGxfZnJhbWVidWZmZXJfc3VyZmFjZV9kaXJ0eSsw
eDE1Yy8weDFmMA0KPiAgIGRybV9mYl9oZWxwZXJfZGlydHlfd29yaysweDI1ZS8weDJhMA0KPiAg
IHByb2Nlc3Nfb25lX3dvcmsrMHg0NTIvMHg3ZDANCj4gICB3b3JrZXJfdGhyZWFkKzB4NjkvMHg2
OTANCj4gICBrdGhyZWFkKzB4MWFjLzB4MWQwDQo+ICAgcmV0X2Zyb21fZm9yaysweDFmLzB4MzAN
Cj4gWy4uLl0NCj4gVGhlIGJ1Z2d5IGFkZHJlc3MgYmVsb25ncyB0byB0aGUgb2JqZWN0IGF0IGZm
ZmY4ODgxZTY4YzdhYzANCj4gICAgICAgICAgICAgICAgICB3aGljaCBiZWxvbmdzIHRvIHRoZSBj
YWNoZSBrbWFsbG9jLTggb2Ygc2l6ZSA4DQo+IFRoZSBidWdneSBhZGRyZXNzIGlzIGxvY2F0ZWQg
MCBieXRlcyB0byB0aGUgcmlnaHQgb2YNCj4gICAgICAgICAgICAgICAgICA4LWJ5dGUgcmVnaW9u
IFtmZmZmODg4MWU2OGM3YWMwLCBmZmZmODg4MWU2OGM3YWM4KQ0KPiBbLi4uXQ0KPg0KPiBGaXhl
czogNWM0MmM2NGY3ZDU0ICgiZHJtL3R0bTogZml4IHRoZSBmaXggZm9yIGh1Z2UgY29tcG91bmQg
cGFnZXMiKQ0KPiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPiBTaWduZWQtb2ZmLWJ5OiBK
YW5uIEhvcm4gPGphbm5oQGdvb2dsZS5jb20+DQo+IC0tLQ0KPiBJJ3ZlIHRlc3RlZCB0aGF0IHRo
aXMgbWFrZXMgdGhlIEtBU0FOIHNwbGF0IGdvIGF3YXkgZm9yIG1lLg0KPiBJJ20gbm90IHZlcnkg
ZmFtaWxpYXIgd2l0aCB0aGUgZ3JhcGhpY3Mgc3Vic3lzdGVtIHRob3VnaCwNCj4gc28gaXQgbWln
aHQgd2VsbCBiZSB0aGF0IEkndmUgY29tcGxldGVseSBtaXNkaWFnbm9zZWQgd2hhdA0KPiB0aGUg
cm9vdCBjYXVzZSBpcy4NCj4NCj4gICBkcml2ZXJzL2dwdS9kcm0vdHRtL3R0bV9wYWdlX2FsbG9j
LmMgfCAxMiArKysrKysrKystLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCsp
LCAzIGRlbGV0aW9ucygtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3R0bS90
dG1fcGFnZV9hbGxvYy5jIGIvZHJpdmVycy9ncHUvZHJtL3R0bS90dG1fcGFnZV9hbGxvYy5jDQo+
IGluZGV4IGY4NDFhY2NjMmMwMC4uNjg5MTI2NjRhNmRmIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJz
L2dwdS9kcm0vdHRtL3R0bV9wYWdlX2FsbG9jLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL3R0
bS90dG1fcGFnZV9hbGxvYy5jDQo+IEBAIC03MzEsOSArNzMxLDEyIEBAIHN0YXRpYyB2b2lkIHR0
bV9wdXRfcGFnZXMoc3RydWN0IHBhZ2UgKipwYWdlcywgdW5zaWduZWQgbnBhZ2VzLCBpbnQgZmxh
Z3MsDQo+ICAgDQo+ICAgI2lmZGVmIENPTkZJR19UUkFOU1BBUkVOVF9IVUdFUEFHRQ0KPiAgIAkJ
CWlmICghKGZsYWdzICYgVFRNX1BBR0VfRkxBR19ETUEzMikpIHsNCj4gLQkJCQlmb3IgKGogPSAw
OyBqIDwgSFBBR0VfUE1EX05SOyArK2opDQo+ICsJCQkJZm9yIChqID0gMDsgaiA8IEhQQUdFX1BN
RF9OUjsgKytqKSB7DQo+ICsJCQkJCWlmIChpICsgaiA+PSBucGFnZXMpDQo+ICsJCQkJCQlicmVh
azsNCj4gICAJCQkJCWlmIChwKysgIT0gcGFnZXNbaSArIGpdKQ0KPiAtCQkJCQkgICAgYnJlYWs7
DQo+ICsJCQkJCQlicmVhazsNCj4gKwkJCQl9DQoNClRoZSBjb2RlIHNob3VsZCBwcm9iYWJseSBi
ZSByZWZhY3RvcmVkIHRvIG5vdCBkbyB0aGUgbG9vcCBpbiB0aGUgZmlyc3QgDQpwbGFjZS4NCg0K
QnV0IHRoYW5rcyBmb3IgcG9pbnRpbmcgb3V0IHRoZSBwcm9ibGVtLCBJJ20gZ29pbmcgdG8gdGFr
ZSBhIGxvb2sgd2hlbiBJIA0KaGF2ZSB0aW1lLg0KDQpDaHJpc3RpYW4uDQoNCj4gICANCj4gICAJ
CQkJaWYgKGogPT0gSFBBR0VfUE1EX05SKQ0KPiAgIAkJCQkJb3JkZXIgPSBIUEFHRV9QTURfT1JE
RVI7DQo+IEBAIC03NjYsOSArNzY5LDEyIEBAIHN0YXRpYyB2b2lkIHR0bV9wdXRfcGFnZXMoc3Ry
dWN0IHBhZ2UgKipwYWdlcywgdW5zaWduZWQgbnBhZ2VzLCBpbnQgZmxhZ3MsDQo+ICAgCQkJaWYg
KCFwKQ0KPiAgIAkJCQlicmVhazsNCj4gICANCj4gLQkJCWZvciAoaiA9IDA7IGogPCBIUEFHRV9Q
TURfTlI7ICsraikNCj4gKwkJCWZvciAoaiA9IDA7IGogPCBIUEFHRV9QTURfTlI7ICsraikgew0K
PiArCQkJCWlmIChpICsgaiA+PSBucGFnZXMpDQo+ICsJCQkJCWJyZWFrOw0KPiAgIAkJCQlpZiAo
cCsrICE9IHBhZ2VzW2kgKyBqXSkNCj4gICAJCQkJICAgIGJyZWFrOw0KPiArCQkJfQ0KPiAgIA0K
PiAgIAkJCWlmIChqICE9IEhQQUdFX1BNRF9OUikNCj4gICAJCQkJYnJlYWs7DQoNCg==
