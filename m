Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 046C4C43218
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 09:49:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B51D5212F5
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 09:49:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="6YpWm788"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404496AbfFKJtz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 05:49:55 -0400
Received: from mail-eopbgr90084.outbound.protection.outlook.com ([40.107.9.84]:14304
        "EHLO FRA01-MR2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727641AbfFKJty (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 05:49:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m2G3YmPIn0VqPVjMdNsiScPAuW3tw1HqVHwl2rQoccs=;
 b=6YpWm788R65KGxmoy5CpkUgmmk11sgdTIhKbxf6Lt3PJbnscGnBNBH7rXC4v34ef1b1WU/D79d3oOVpdHTtIJp4XcORslEZaRKznXj/ef5g75uiGH4SOCkfyMjXpf4DcZvI+D+BsbmPmta/LFJzZtIH3OFinhRmA/ehVkqeBRxA=
Received: from PR2PR08MB4796.eurprd08.prod.outlook.com (52.133.109.138) by
 PR2PR08MB4730.eurprd08.prod.outlook.com (52.133.107.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.14; Tue, 11 Jun 2019 09:49:46 +0000
Received: from PR2PR08MB4796.eurprd08.prod.outlook.com
 ([fe80::ad5e:4a37:5c25:37e8]) by PR2PR08MB4796.eurprd08.prod.outlook.com
 ([fe80::ad5e:4a37:5c25:37e8%7]) with mapi id 15.20.1987.010; Tue, 11 Jun 2019
 09:49:46 +0000
From:   Vladimir Murzin <Vladimir.Murzin@arm.com>
To:     Christoph Hellwig <hch@lst.de>, Greg Ungerer <gerg@linux-m68k.org>
CC:     "uclinux-h8-devel@lists.sourceforge.jp" 
        <uclinux-h8-devel@lists.sourceforge.jp>,
        "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>,
        Michal Simek <monstr@monstr.eu>,
        "linux-c6x-dev@linux-c6x.org" <linux-c6x-dev@linux-c6x.org>,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 05/15] binfmt_flat: replace flat_argvp_envp_on_stack with
 a Kconfig variable
Thread-Topic: [PATCH 05/15] binfmt_flat: replace flat_argvp_envp_on_stack with
 a Kconfig variable
Thread-Index: AQHVH9KZQF6vzdl9i0ut6BV9ck+LDaaWNlqA
Date:   Tue, 11 Jun 2019 09:49:46 +0000
Message-ID: <09e6ae8e-0495-4af0-acec-91a0b87a8493@arm.com>
References: <20190610212015.9157-1-hch@lst.de>
 <20190610212015.9157-6-hch@lst.de>
In-Reply-To: <20190610212015.9157-6-hch@lst.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
x-originating-ip: [217.140.106.50]
x-clientproxiedby: LO2P265CA0377.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a3::29) To PR2PR08MB4796.eurprd08.prod.outlook.com
 (2603:10a6:101:21::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Vladimir.Murzin@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3b057ad8-7d47-40de-b21e-08d6ee5222e4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:PR2PR08MB4730;
x-ms-traffictypediagnostic: PR2PR08MB4730:
x-microsoft-antispam-prvs: <PR2PR08MB4730A0D9C2F460B07228B7DEF2ED0@PR2PR08MB4730.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 006546F32A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(39850400004)(376002)(346002)(136003)(189003)(199004)(40434004)(66476007)(66556008)(5660300002)(73956011)(8676002)(64756008)(66946007)(6246003)(86362001)(72206003)(53936002)(26005)(99286004)(25786009)(64126003)(14444005)(5024004)(71200400001)(31696002)(66446008)(4326008)(478600001)(316002)(7736002)(305945005)(14454004)(71190400001)(8936002)(256004)(81156014)(81166006)(52116002)(58126008)(110136005)(53546011)(7416002)(6116002)(6486002)(2906002)(76176011)(3846002)(102836004)(54906003)(68736007)(65826007)(229853002)(6512007)(6436002)(6506007)(386003)(65956001)(66066001)(65806001)(11346002)(31686004)(36756003)(2616005)(186003)(446003)(44832011)(486006)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:PR2PR08MB4730;H:PR2PR08MB4796.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: U+BcZ7QRuCjzgZsyxZBwErSy3iNFPkb+xMJNNCOkF2VGyK4UzCCRh+R9gcaBjOOG+UhKoEhoHNX6U5SXlgvE48dgqaG4bOVIZkG+q1fVuSBx/59v6DGJdnfdVvYf5AopgIs2O7o0vU54SzXPfgWw94eXBOMPd48IrclVWMiwuBprg4WTEo7W5Cm3W+6ARh1nJf6jH4PMndyAMOHZKTuTqmy21WMhWkpG5dEa6968aS46OGmQXrDhkYKJdqJbReigYNN4spxsOuYlj8NOf6JhFp97z7WNJ8KRrmA2tz1AAJKNu9gyOYQi86haTF9W8NtPCqDiBLucvGUH7aWxoBhOKoMcHJyURUC+neXpBu0U16yoXsQr3QlJv4rc2KXY7j89P9eTD+qliCubF9yX/6Oflm3824eoyx0ADY/OrVNs4e4=
Content-Type: text/plain; charset="utf-8"
Content-ID: <373E563EC1A9A34A97E05AA08D0C3D6E@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b057ad8-7d47-40de-b21e-08d6ee5222e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2019 09:49:46.5302
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vladimir.Murzin@arm.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR2PR08MB4730
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNi8xMC8xOSAxMDoyMCBQTSwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IFRoaXMgd2ls
bCBldmVudHVhbGx5IGFsbG93IHVzIHRvIGtpbGwgdGhlIG5lZWQgZm9yIGFuIDxhc20vZmxhdC5o
PiBmb3INCj4gbWFueSBjYXNlcy4NCj4NCj4gU2lnbmVkLW9mZi1ieTogQ2hyaXN0b3BoIEhlbGx3
aWcgPGhjaEBsc3QuZGU+DQo+IC0tLQ0KPiAgYXJjaC9hcm0vS2NvbmZpZyAgICAgICAgICAgICAg
ICAgICB8IDEgKw0KPiAgYXJjaC9hcm0vaW5jbHVkZS9hc20vZmxhdC5oICAgICAgICB8IDIgLS0N
Cj4gIGFyY2gvYzZ4L2luY2x1ZGUvYXNtL2ZsYXQuaCAgICAgICAgfCAxIC0NCj4gIGFyY2gvaDgz
MDAvS2NvbmZpZyAgICAgICAgICAgICAgICAgfCAxICsNCj4gIGFyY2gvaDgzMDAvaW5jbHVkZS9h
c20vZmxhdC5oICAgICAgfCAyIC0tDQo+ICBhcmNoL202OGsvS2NvbmZpZyAgICAgICAgICAgICAg
ICAgIHwgMSArDQo+ICBhcmNoL202OGsvaW5jbHVkZS9hc20vZmxhdC5oICAgICAgIHwgMSAtDQo+
ICBhcmNoL21pY3JvYmxhemUvaW5jbHVkZS9hc20vZmxhdC5oIHwgMiAtLQ0KPiAgYXJjaC9zaC9p
bmNsdWRlL2FzbS9mbGF0LmggICAgICAgICB8IDEgLQ0KPiAgYXJjaC94dGVuc2EvaW5jbHVkZS9h
c20vZmxhdC5oICAgICB8IDEgLQ0KPiAgZnMvS2NvbmZpZy5iaW5mbXQgICAgICAgICAgICAgICAg
ICB8IDMgKysrDQo+ICBmcy9iaW5mbXRfZmxhdC5jICAgICAgICAgICAgICAgICAgIHwgNSArKyst
LQ0KPiAgMTIgZmlsZXMgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspLCAxMiBkZWxldGlvbnMoLSkN
Cj4NCg0KRm9yIEFSTSBiaXRzOg0KDQpUZXN0ZWQtYnk6IFZsYWRpbWlyIE11cnppbiA8dmxhZGlt
aXIubXVyemluQGFybS5jb20+DQpSZXZpZXdlZC1ieTogVmxhZGltaXIgTXVyemluIDx2bGFkaW1p
ci5tdXJ6aW5AYXJtLmNvbT4NCg0KDQo+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9LY29uZmlnIGIv
YXJjaC9hcm0vS2NvbmZpZw0KPiBpbmRleCA4ODY5NzQyYTg1ZGYuLmIxYjQ4YzBiZGU3NiAxMDA2
NDQNCj4gLS0tIGEvYXJjaC9hcm0vS2NvbmZpZw0KPiArKysgYi9hcmNoL2FybS9LY29uZmlnDQo+
IEBAIC0zMCw2ICszMCw3IEBAIGNvbmZpZyBBUk0NCj4gIHNlbGVjdCBBUkNIX1VTRV9CVUlMVElO
X0JTV0FQDQo+ICBzZWxlY3QgQVJDSF9VU0VfQ01QWENIR19MT0NLUkVGDQo+ICBzZWxlY3QgQVJD
SF9XQU5UX0lQQ19QQVJTRV9WRVJTSU9ODQo+ICtzZWxlY3QgQklORk1UX0ZMQVRfQVJHVlBfRU5W
UF9PTl9TVEFDSw0KPiAgc2VsZWN0IEJVSUxEVElNRV9FWFRBQkxFX1NPUlQgaWYgTU1VDQo+ICBz
ZWxlY3QgQ0xPTkVfQkFDS1dBUkRTDQo+ICBzZWxlY3QgQ1BVX1BNIGlmIFNVU1BFTkQgfHwgQ1BV
X0lETEUNCj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2luY2x1ZGUvYXNtL2ZsYXQuaCBiL2FyY2gv
YXJtL2luY2x1ZGUvYXNtL2ZsYXQuaA0KPiBpbmRleCBhY2YxNjIxMTFlZTIuLmJiYzI3OTAxNDQ2
ZiAxMDA2NDQNCj4gLS0tIGEvYXJjaC9hcm0vaW5jbHVkZS9hc20vZmxhdC5oDQo+ICsrKyBiL2Fy
Y2gvYXJtL2luY2x1ZGUvYXNtL2ZsYXQuaA0KPiBAQCAtOCw4ICs4LDYgQEANCj4NCj4gICNpbmNs
dWRlIDxsaW51eC91YWNjZXNzLmg+DQo+DQo+IC0jZGVmaW5lZmxhdF9hcmd2cF9lbnZwX29uX3N0
YWNrKCkxDQo+IC0NCj4gIHN0YXRpYyBpbmxpbmUgaW50IGZsYXRfZ2V0X2FkZHJfZnJvbV9ycCh1
MzIgX191c2VyICpycCwgdTMyIHJlbHZhbCwgdTMyIGZsYWdzLA0KPiAgdTMyICphZGRyLCB1MzIg
KnBlcnNpc3RlbnQpDQo+ICB7DQo+IGRpZmYgLS1naXQgYS9hcmNoL2M2eC9pbmNsdWRlL2FzbS9m
bGF0LmggYi9hcmNoL2M2eC9pbmNsdWRlL2FzbS9mbGF0LmgNCj4gaW5kZXggMzUzZTRkMDZlOGMw
Li4yZDU3YTkyMDRkMjEgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvYzZ4L2luY2x1ZGUvYXNtL2ZsYXQu
aA0KPiArKysgYi9hcmNoL2M2eC9pbmNsdWRlL2FzbS9mbGF0LmgNCj4gQEAgLTQsNyArNCw2IEBA
DQo+DQo+ICAjaW5jbHVkZSA8YXNtL3VuYWxpZ25lZC5oPg0KPg0KPiAtI2RlZmluZSBmbGF0X2Fy
Z3ZwX2VudnBfb25fc3RhY2soKTANCj4gIHN0YXRpYyBpbmxpbmUgaW50IGZsYXRfZ2V0X2FkZHJf
ZnJvbV9ycCh1MzIgX191c2VyICpycCwgdTMyIHJlbHZhbCwgdTMyIGZsYWdzLA0KPiAgdTMyICph
ZGRyLCB1MzIgKnBlcnNpc3RlbnQpDQo+ICB7DQo+IGRpZmYgLS1naXQgYS9hcmNoL2g4MzAwL0tj
b25maWcgYi9hcmNoL2g4MzAwL0tjb25maWcNCj4gaW5kZXggZDMwZTg3MjdiMDJkLi43NDU3ZjE5
MGNhYWEgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvaDgzMDAvS2NvbmZpZw0KPiArKysgYi9hcmNoL2g4
MzAwL0tjb25maWcNCj4gQEAgLTIsNiArMiw3IEBADQo+ICBjb25maWcgSDgzMDANCj4gICAgICAg
ICAgZGVmX2Jvb2wgeQ0KPiAgc2VsZWN0IEFSQ0hfMzJCSVRfT0ZGX1QNCj4gK3NlbGVjdCBCSU5G
TVRfRkxBVF9BUkdWUF9FTlZQX09OX1NUQUNLDQo+ICBzZWxlY3QgQklORk1UX0ZMQVRfT0xEX0FM
V0FZU19SQU0NCj4gIHNlbGVjdCBHRU5FUklDX0FUT01JQzY0DQo+ICBzZWxlY3QgSEFWRV9VSUQx
Ng0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9oODMwMC9pbmNsdWRlL2FzbS9mbGF0LmggYi9hcmNoL2g4
MzAwL2luY2x1ZGUvYXNtL2ZsYXQuaA0KPiBpbmRleCAxNGNjOTI4ZDU0NzguLjQ2ODMxNDZmMGU5
ZSAxMDA2NDQNCj4gLS0tIGEvYXJjaC9oODMwMC9pbmNsdWRlL2FzbS9mbGF0LmgNCj4gKysrIGIv
YXJjaC9oODMwMC9pbmNsdWRlL2FzbS9mbGF0LmgNCj4gQEAgLTgsOCArOCw2IEBADQo+DQo+ICAj
aW5jbHVkZSA8YXNtL3VuYWxpZ25lZC5oPg0KPg0KPiAtI2RlZmluZWZsYXRfYXJndnBfZW52cF9v
bl9zdGFjaygpMQ0KPiAtDQo+ICAvKg0KPiAgICogb24gdGhlIEg4IGEgY291cGxlIG9mIHRoZSBy
ZWxvY2F0aW9ucyBoYXZlIGFuIGluc3RydWN0aW9uIGluIHRoZQ0KPiAgICogdG9wIGJ5dGUuICBB
cyB0aGVyZSBjYW4gb25seSBiZSAyNGJpdHMgb2YgYWRkcmVzcyBzcGFjZSwgIHdlIGp1c3QNCj4g
ZGlmZiAtLWdpdCBhL2FyY2gvbTY4ay9LY29uZmlnIGIvYXJjaC9tNjhrL0tjb25maWcNCj4gaW5k
ZXggMjE4ZTAzN2VmOTAxLi5mZDY5ZWU1YWQ2YWIgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvbTY4ay9L
Y29uZmlnDQo+ICsrKyBiL2FyY2gvbTY4ay9LY29uZmlnDQo+IEBAIC03LDYgKzcsNyBAQCBjb25m
aWcgTTY4Sw0KPiAgc2VsZWN0IEFSQ0hfTUlHSFRfSEFWRV9QQ19QQVJQT1JUIGlmIElTQQ0KPiAg
c2VsZWN0IEFSQ0hfTk9fQ09IRVJFTlRfRE1BX01NQVAgaWYgIU1NVQ0KPiAgc2VsZWN0IEFSQ0hf
Tk9fUFJFRU1QVCBpZiAhQ09MREZJUkUNCj4gK3NlbGVjdCBCSU5GTVRfRkxBVF9BUkdWUF9FTlZQ
X09OX1NUQUNLDQo+ICBzZWxlY3QgSEFWRV9JREUNCj4gIHNlbGVjdCBIQVZFX0FPVVQgaWYgTU1V
DQo+ICBzZWxlY3QgSEFWRV9ERUJVR19CVUdWRVJCT1NFDQo+IGRpZmYgLS1naXQgYS9hcmNoL202
OGsvaW5jbHVkZS9hc20vZmxhdC5oIGIvYXJjaC9tNjhrL2luY2x1ZGUvYXNtL2ZsYXQuaA0KPiBp
bmRleCA3YjFmYjVjMjgwOWUuLmQ3MTAyZmNkNDNlYiAxMDA2NDQNCj4gLS0tIGEvYXJjaC9tNjhr
L2luY2x1ZGUvYXNtL2ZsYXQuaA0KPiArKysgYi9hcmNoL202OGsvaW5jbHVkZS9hc20vZmxhdC5o
DQo+IEBAIC04LDcgKzgsNiBAQA0KPg0KPiAgI2luY2x1ZGUgPGxpbnV4L3VhY2Nlc3MuaD4NCj4N
Cj4gLSNkZWZpbmVmbGF0X2FyZ3ZwX2VudnBfb25fc3RhY2soKTENCj4gIHN0YXRpYyBpbmxpbmUg
aW50IGZsYXRfZ2V0X2FkZHJfZnJvbV9ycCh1MzIgX191c2VyICpycCwgdTMyIHJlbHZhbCwgdTMy
IGZsYWdzLA0KPiAgdTMyICphZGRyLCB1MzIgKnBlcnNpc3RlbnQpDQo+ICB7DQo+IGRpZmYgLS1n
aXQgYS9hcmNoL21pY3JvYmxhemUvaW5jbHVkZS9hc20vZmxhdC5oIGIvYXJjaC9taWNyb2JsYXpl
L2luY2x1ZGUvYXNtL2ZsYXQuaA0KPiBpbmRleCAxY2Q4ZDdmNGNmMTIuLjllM2Q4ZTAxZDI5NCAx
MDA2NDQNCj4gLS0tIGEvYXJjaC9taWNyb2JsYXplL2luY2x1ZGUvYXNtL2ZsYXQuaA0KPiArKysg
Yi9hcmNoL21pY3JvYmxhemUvaW5jbHVkZS9hc20vZmxhdC5oDQo+IEBAIC0xMyw4ICsxMyw2IEBA
DQo+DQo+ICAjaW5jbHVkZSA8YXNtL3VuYWxpZ25lZC5oPg0KPg0KPiAtI2RlZmluZWZsYXRfYXJn
dnBfZW52cF9vbl9zdGFjaygpMA0KPiAtDQo+ICAvKg0KPiAgICogTWljcm9ibGF6ZSB3b3JrcyBh
IGxpdHRsZSBkaWZmZXJlbnRseSBmcm9tIG90aGVyIGFyY2hlcywgYmVjYXVzZQ0KPiAgICogb2Yg
dGhlIE1JQ1JPQkxBWkVfNjQgcmVsb2MgdHlwZS4gSGVyZSwgYSAzMiBiaXQgYWRkcmVzcyBpcyBz
cGxpdA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9zaC9pbmNsdWRlL2FzbS9mbGF0LmggYi9hcmNoL3No
L2luY2x1ZGUvYXNtL2ZsYXQuaA0KPiBpbmRleCAwMTU2NzhkN2I3NzEuLjEwMDIzNDNkZDg0YSAx
MDA2NDQNCj4gLS0tIGEvYXJjaC9zaC9pbmNsdWRlL2FzbS9mbGF0LmgNCj4gKysrIGIvYXJjaC9z
aC9pbmNsdWRlL2FzbS9mbGF0LmgNCj4gQEAgLTExLDcgKzExLDYgQEANCj4NCj4gICNpbmNsdWRl
IDxhc20vdW5hbGlnbmVkLmg+DQo+DQo+IC0jZGVmaW5lZmxhdF9hcmd2cF9lbnZwX29uX3N0YWNr
KCkwDQo+ICBzdGF0aWMgaW5saW5lIGludCBmbGF0X2dldF9hZGRyX2Zyb21fcnAodTMyIF9fdXNl
ciAqcnAsIHUzMiByZWx2YWwsIHUzMiBmbGFncywNCj4gIHUzMiAqYWRkciwgdTMyICpwZXJzaXN0
ZW50KQ0KPiAgew0KPiBkaWZmIC0tZ2l0IGEvYXJjaC94dGVuc2EvaW5jbHVkZS9hc20vZmxhdC5o
IGIvYXJjaC94dGVuc2EvaW5jbHVkZS9hc20vZmxhdC5oDQo+IGluZGV4IGIyMTVjMWU2Njk1OC4u
M2QzNTczNzFiMjhiIDEwMDY0NA0KPiAtLS0gYS9hcmNoL3h0ZW5zYS9pbmNsdWRlL2FzbS9mbGF0
LmgNCj4gKysrIGIvYXJjaC94dGVuc2EvaW5jbHVkZS9hc20vZmxhdC5oDQo+IEBAIC00LDcgKzQs
NiBAQA0KPg0KPiAgI2luY2x1ZGUgPGFzbS91bmFsaWduZWQuaD4NCj4NCj4gLSNkZWZpbmUgZmxh
dF9hcmd2cF9lbnZwX29uX3N0YWNrKCkwDQo+ICBzdGF0aWMgaW5saW5lIGludCBmbGF0X2dldF9h
ZGRyX2Zyb21fcnAodTMyIF9fdXNlciAqcnAsIHUzMiByZWx2YWwsIHUzMiBmbGFncywNCj4gIHUz
MiAqYWRkciwgdTMyICpwZXJzaXN0ZW50KQ0KPiAgew0KPiBkaWZmIC0tZ2l0IGEvZnMvS2NvbmZp
Zy5iaW5mbXQgYi9mcy9LY29uZmlnLmJpbmZtdA0KPiBpbmRleCA1NjU4ZTEyYWQ5NDQuLjgyZjdk
N2YyMzRmMyAxMDA2NDQNCj4gLS0tIGEvZnMvS2NvbmZpZy5iaW5mbXQNCj4gKysrIGIvZnMvS2Nv
bmZpZy5iaW5mbXQNCj4gQEAgLTk3LDYgKzk3LDkgQEAgY29uZmlnIEJJTkZNVF9GTEFUDQo+ICBo
ZWxwDQo+ICAgIFN1cHBvcnQgdUNsaW51eCBGTEFUIGZvcm1hdCBiaW5hcmllcy4NCj4NCj4gK2Nv
bmZpZyBCSU5GTVRfRkxBVF9BUkdWUF9FTlZQX09OX1NUQUNLDQo+ICtib29sDQo+ICsNCj4gIGNv
bmZpZyBCSU5GTVRfRkxBVF9PTERfQUxXQVlTX1JBTQ0KPiAgYm9vbA0KPg0KPiBkaWZmIC0tZ2l0
IGEvZnMvYmluZm10X2ZsYXQuYyBiL2ZzL2JpbmZtdF9mbGF0LmMNCj4gaW5kZXggMThkODJmZDVm
NTdjLi5jMDk2NTEwODdlZGEgMTAwNjQ0DQo+IC0tLSBhL2ZzL2JpbmZtdF9mbGF0LmMNCj4gKysr
IGIvZnMvYmluZm10X2ZsYXQuYw0KPiBAQCAtMTI0LDE0ICsxMjQsMTUgQEAgc3RhdGljIGludCBj
cmVhdGVfZmxhdF90YWJsZXMoc3RydWN0IGxpbnV4X2JpbnBybSAqYnBybSwgdW5zaWduZWQgbG9u
ZyBhcmdfc3RhcnQNCj4NCj4gIHNwIC09IGJwcm0tPmVudmMgKyAxOw0KPiAgc3AgLT0gYnBybS0+
YXJnYyArIDE7DQo+IC1zcCAtPSBmbGF0X2FyZ3ZwX2VudnBfb25fc3RhY2soKSA/IDIgOiAwOw0K
PiAraWYgKElTX0VOQUJMRUQoQ09ORklHX0JJTkZNVF9GTEFUX0FSR1ZQX0VOVlBfT05fU1RBQ0sp
KQ0KPiArc3AgLT0gMjsgLyogYXJndnAgKyBlbnZwICovDQo+ICBzcCAtPSAxOyAgLyogJmFyZ2Mg
Ki8NCj4NCj4gIGN1cnJlbnQtPm1tLT5zdGFydF9zdGFjayA9ICh1bnNpZ25lZCBsb25nKXNwICYg
LUZMQVRfU1RBQ0tfQUxJR047DQo+ICBzcCA9ICh1bnNpZ25lZCBsb25nIF9fdXNlciAqKWN1cnJl
bnQtPm1tLT5zdGFydF9zdGFjazsNCj4NCj4gIF9fcHV0X3VzZXIoYnBybS0+YXJnYywgc3ArKyk7
DQo+IC1pZiAoZmxhdF9hcmd2cF9lbnZwX29uX3N0YWNrKCkpIHsNCj4gK2lmIChJU19FTkFCTEVE
KENPTkZJR19CSU5GTVRfRkxBVF9BUkdWUF9FTlZQX09OX1NUQUNLKSkgew0KPiAgdW5zaWduZWQg
bG9uZyBhcmd2LCBlbnZwOw0KPiAgYXJndiA9ICh1bnNpZ25lZCBsb25nKShzcCArIDIpOw0KPiAg
ZW52cCA9ICh1bnNpZ25lZCBsb25nKShzcCArIDIgKyBicHJtLT5hcmdjICsgMSk7DQo+DQoNCklN
UE9SVEFOVCBOT1RJQ0U6IFRoZSBjb250ZW50cyBvZiB0aGlzIGVtYWlsIGFuZCBhbnkgYXR0YWNo
bWVudHMgYXJlIGNvbmZpZGVudGlhbCBhbmQgbWF5IGFsc28gYmUgcHJpdmlsZWdlZC4gSWYgeW91
IGFyZSBub3QgdGhlIGludGVuZGVkIHJlY2lwaWVudCwgcGxlYXNlIG5vdGlmeSB0aGUgc2VuZGVy
IGltbWVkaWF0ZWx5IGFuZCBkbyBub3QgZGlzY2xvc2UgdGhlIGNvbnRlbnRzIHRvIGFueSBvdGhl
ciBwZXJzb24sIHVzZSBpdCBmb3IgYW55IHB1cnBvc2UsIG9yIHN0b3JlIG9yIGNvcHkgdGhlIGlu
Zm9ybWF0aW9uIGluIGFueSBtZWRpdW0uIFRoYW5rIHlvdS4NCg==
