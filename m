Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84562C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 12:01:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AC5B218D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 12:01:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="NcpECmww"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729765AbfDXMBN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 08:01:13 -0400
Received: from mail-eopbgr810079.outbound.protection.outlook.com ([40.107.81.79]:22328
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729248AbfDXMAc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 08:00:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SoHkp5gsl9DN4Hd13XTXMAdh4moT6hIRFvzZcADO0t8=;
 b=NcpECmwwletj95HiTJ9bpikBF3RMuaK9UNscgw/COHFUzfO92YZzZon+MKrJs4QekJQIkagEHzjiskH4GZPBH5BK+UUkAYuV+91/dceaHIUkG36dd/R2YdVNS+TvMbbTyXhbiQzOP5qQqf9xuW/zmJnPTifmdtIrRSw7DGB+CXI=
Received: from MN2PR05MB6141.namprd05.prod.outlook.com (20.178.241.217) by
 MN2PR05MB6272.namprd05.prod.outlook.com (20.178.240.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.6; Wed, 24 Apr 2019 12:00:12 +0000
Received: from MN2PR05MB6141.namprd05.prod.outlook.com
 ([fe80::441b:ef64:e316:b294]) by MN2PR05MB6141.namprd05.prod.outlook.com
 ([fe80::441b:ef64:e316:b294%5]) with mapi id 15.20.1835.010; Wed, 24 Apr 2019
 12:00:12 +0000
From:   Thomas Hellstrom <thellstrom@vmware.com>
To:     Linux-graphics-maintainer <Linux-graphics-maintainer@vmware.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
CC:     Pv-drivers <Pv-drivers@vmware.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Huang Ying <ying.huang@intel.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        =?utf-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Ralph Campbell <rcampbell@nvidia.com>
Subject: [PATCH 1/9] mm: Allow the [page|pfn]_mkwrite callbacks to drop the
 mmap_sem v2
Thread-Topic: [PATCH 1/9] mm: Allow the [page|pfn]_mkwrite callbacks to drop
 the mmap_sem v2
Thread-Index: AQHU+pVFpIoNyabDrUq+mablu5W5Jw==
Date:   Wed, 24 Apr 2019 12:00:12 +0000
Message-ID: <20190424115918.3380-2-thellstrom@vmware.com>
References: <20190424115918.3380-1-thellstrom@vmware.com>
In-Reply-To: <20190424115918.3380-1-thellstrom@vmware.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR07CA0208.eurprd07.prod.outlook.com
 (2603:10a6:802:3f::32) To MN2PR05MB6141.namprd05.prod.outlook.com
 (2603:10b6:208:c7::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=thellstrom@vmware.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-originating-ip: [155.4.205.35]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3e7e466c-4a1d-4825-7ce5-08d6c8ac67b4
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:MN2PR05MB6272;
x-ms-traffictypediagnostic: MN2PR05MB6272:
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-microsoft-antispam-prvs: <MN2PR05MB62729F513332F3557236F8ECA13C0@MN2PR05MB6272.namprd05.prod.outlook.com>
x-forefront-prvs: 00179089FD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(136003)(396003)(366004)(39860400002)(199004)(189003)(64756008)(66476007)(71200400001)(66446008)(86362001)(66556008)(305945005)(7416002)(14444005)(50226002)(478600001)(256004)(8936002)(81156014)(7736002)(81166006)(2906002)(66066001)(66946007)(71190400001)(8676002)(4326008)(25786009)(1076003)(66574012)(73956011)(186003)(26005)(6116002)(6512007)(486006)(6486002)(53936002)(110136005)(102836004)(6506007)(386003)(316002)(99286004)(54906003)(5660300002)(11346002)(2616005)(68736007)(14454004)(36756003)(6436002)(446003)(476003)(76176011)(3846002)(52116002)(97736004)(2501003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR05MB6272;H:MN2PR05MB6141.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: P55ZQkkMq+fvDR7dqCGUOJwKa5c9q48YjNeF4zlf41jt3c1ucZgc0uSnPKCnyioyaRLhKeOVoHNuQzqdxubXDb+9LMWDV3NZEw2fKIrd6Bg6uqxRTMIi/wLVhZ/S6STpBl716Qu9K0Vx47WB8on/UZewJUvOWPP0m+38Ua/sDzEsl3GKl478kd56gJwS5r0KAoluiFQ2fKeXsNBmw3QzSuMgjowzoZCuqyn747saO8jgLHBNo7uvWWpYKPJRkYZGUo3CpkMJe3t/MuRFf2t9W/OXlrhIzMBCVNrpcocUyK3zvPfiXCpnpziwt300Q8PgOQrRG7ZJWvXbrC0Bk8J7nsSHMBniIYi7SM2ToDwMlFTr1Q05FGQaBDlaM2zmkH6DDS8ADkpcbtYTQlLXHVL6mJ6kNf91dpuj1LpePYie2Jc=
Content-Type: text/plain; charset="utf-8"
Content-ID: <85C7C1DA7782054E8800582057FBFE3C@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e7e466c-4a1d-4825-7ce5-08d6c8ac67b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2019 12:00:12.7251
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR05MB6272
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RHJpdmVyIGZhdWx0IGNhbGxiYWNrcyBhcmUgYWxsb3dlZCB0byBkcm9wIHRoZSBtbWFwX3NlbSB3
aGVuIGV4cGVjdGluZw0KbG9uZyBoYXJkd2FyZSB3YWl0cyB0byBhdm9pZCBibG9ja2luZyBvdGhl
ciBtbSB1c2Vycy4gQWxsb3cgdGhlIG1rd3JpdGUNCmNhbGxiYWNrcyB0byBkbyB0aGUgc2FtZSBi
eSByZXR1cm5pbmcgZWFybHkgb24gVk1fRkFVTFRfUkVUUlkuDQoNCkluIHBhcnRpY3VsYXIgd2Ug
d2FudCB0byBiZSBhYmxlIHRvIGRyb3AgdGhlIG1tYXBfc2VtIHdoZW4gd2FpdGluZyBmb3INCmEg
cmVzZXJ2YXRpb24gb2JqZWN0IGxvY2sgb24gYSBHUFUgYnVmZmVyIG9iamVjdC4gVGhlc2UgbG9j
a3MgbWF5IGJlDQpoZWxkIHdoaWxlIHdhaXRpbmcgZm9yIHRoZSBHUFUuDQoNCkNjOiBBbmRyZXcg
TW9ydG9uIDxha3BtQGxpbnV4LWZvdW5kYXRpb24ub3JnPg0KQ2M6IE1hdHRoZXcgV2lsY294IDx3
aWxseUBpbmZyYWRlYWQub3JnPg0KQ2M6IFdpbGwgRGVhY29uIDx3aWxsLmRlYWNvbkBhcm0uY29t
Pg0KQ2M6IFBldGVyIFppamxzdHJhIDxwZXRlcnpAaW5mcmFkZWFkLm9yZz4NCkNjOiBSaWsgdmFu
IFJpZWwgPHJpZWxAc3VycmllbC5jb20+DQpDYzogTWluY2hhbiBLaW0gPG1pbmNoYW5Aa2VybmVs
Lm9yZz4NCkNjOiBNaWNoYWwgSG9ja28gPG1ob2Nrb0BzdXNlLmNvbT4NCkNjOiBIdWFuZyBZaW5n
IDx5aW5nLmh1YW5nQGludGVsLmNvbT4NCkNjOiBTb3VwdGljayBKb2FyZGVyIDxqcmRyLmxpbnV4
QGdtYWlsLmNvbT4NCkNjOiAiSsOpcsO0bWUgR2xpc3NlIiA8amdsaXNzZUByZWRoYXQuY29tPg0K
Q2M6IGxpbnV4LW1tQGt2YWNrLm9yZw0KQ2M6IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcN
Cg0KU2lnbmVkLW9mZi1ieTogVGhvbWFzIEhlbGxzdHJvbSA8dGhlbGxzdHJvbUB2bXdhcmUuY29t
Pg0KUmV2aWV3ZWQtYnk6IFJhbHBoIENhbXBiZWxsIDxyY2FtcGJlbGxAbnZpZGlhLmNvbT4NCi0t
LQ0KdjI6IE1ha2UgdGhlIG9yZGVyIGVycm9yIGNvZGVzIHdlIGNoZWNrIGZvciBjb25zaXN0ZW50
IHdpdGgNCiAgICB0aGUgb3JkZXIgdXNlZCBpbiB0aGUgcmVzdCBvZiB0aGUgZmlsZS4NCi0tLQ0K
IG1tL21lbW9yeS5jIHwgMTAgKysrKysrLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlv
bnMoKyksIDQgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9tbS9tZW1vcnkuYyBiL21tL21l
bW9yeS5jDQppbmRleCBlMTFjYTlkZDgyM2YuLjk1ODBkODk0Zjk2MyAxMDA2NDQNCi0tLSBhL21t
L21lbW9yeS5jDQorKysgYi9tbS9tZW1vcnkuYw0KQEAgLTIxNDQsNyArMjE0NCw3IEBAIHN0YXRp
YyB2bV9mYXVsdF90IGRvX3BhZ2VfbWt3cml0ZShzdHJ1Y3Qgdm1fZmF1bHQgKnZtZikNCiAJcmV0
ID0gdm1mLT52bWEtPnZtX29wcy0+cGFnZV9ta3dyaXRlKHZtZik7DQogCS8qIFJlc3RvcmUgb3Jp
Z2luYWwgZmxhZ3Mgc28gdGhhdCBjYWxsZXIgaXMgbm90IHN1cnByaXNlZCAqLw0KIAl2bWYtPmZs
YWdzID0gb2xkX2ZsYWdzOw0KLQlpZiAodW5saWtlbHkocmV0ICYgKFZNX0ZBVUxUX0VSUk9SIHwg
Vk1fRkFVTFRfTk9QQUdFKSkpDQorCWlmICh1bmxpa2VseShyZXQgJiAoVk1fRkFVTFRfRVJST1Ig
fCBWTV9GQVVMVF9OT1BBR0UgfCBWTV9GQVVMVF9SRVRSWSkpKQ0KIAkJcmV0dXJuIHJldDsNCiAJ
aWYgKHVubGlrZWx5KCEocmV0ICYgVk1fRkFVTFRfTE9DS0VEKSkpIHsNCiAJCWxvY2tfcGFnZShw
YWdlKTsNCkBAIC0yNDE5LDcgKzI0MTksNyBAQCBzdGF0aWMgdm1fZmF1bHRfdCB3cF9wZm5fc2hh
cmVkKHN0cnVjdCB2bV9mYXVsdCAqdm1mKQ0KIAkJcHRlX3VubWFwX3VubG9jayh2bWYtPnB0ZSwg
dm1mLT5wdGwpOw0KIAkJdm1mLT5mbGFncyB8PSBGQVVMVF9GTEFHX01LV1JJVEU7DQogCQlyZXQg
PSB2bWEtPnZtX29wcy0+cGZuX21rd3JpdGUodm1mKTsNCi0JCWlmIChyZXQgJiAoVk1fRkFVTFRf
RVJST1IgfCBWTV9GQVVMVF9OT1BBR0UpKQ0KKwkJaWYgKHJldCAmIChWTV9GQVVMVF9FUlJPUiB8
IFZNX0ZBVUxUX05PUEFHRSB8IFZNX0ZBVUxUX1JFVFJZKSkNCiAJCQlyZXR1cm4gcmV0Ow0KIAkJ
cmV0dXJuIGZpbmlzaF9ta3dyaXRlX2ZhdWx0KHZtZik7DQogCX0NCkBAIC0yNDQwLDcgKzI0NDAs
OCBAQCBzdGF0aWMgdm1fZmF1bHRfdCB3cF9wYWdlX3NoYXJlZChzdHJ1Y3Qgdm1fZmF1bHQgKnZt
ZikNCiAJCXB0ZV91bm1hcF91bmxvY2sodm1mLT5wdGUsIHZtZi0+cHRsKTsNCiAJCXRtcCA9IGRv
X3BhZ2VfbWt3cml0ZSh2bWYpOw0KIAkJaWYgKHVubGlrZWx5KCF0bXAgfHwgKHRtcCAmDQotCQkJ
CSAgICAgIChWTV9GQVVMVF9FUlJPUiB8IFZNX0ZBVUxUX05PUEFHRSkpKSkgew0KKwkJCQkgICAg
ICAoVk1fRkFVTFRfRVJST1IgfCBWTV9GQVVMVF9OT1BBR0UgfA0KKwkJCQkgICAgICAgVk1fRkFV
TFRfUkVUUlkpKSkpIHsNCiAJCQlwdXRfcGFnZSh2bWYtPnBhZ2UpOw0KIAkJCXJldHVybiB0bXA7
DQogCQl9DQpAQCAtMzQ5NCw3ICszNDk1LDggQEAgc3RhdGljIHZtX2ZhdWx0X3QgZG9fc2hhcmVk
X2ZhdWx0KHN0cnVjdCB2bV9mYXVsdCAqdm1mKQ0KIAkJdW5sb2NrX3BhZ2Uodm1mLT5wYWdlKTsN
CiAJCXRtcCA9IGRvX3BhZ2VfbWt3cml0ZSh2bWYpOw0KIAkJaWYgKHVubGlrZWx5KCF0bXAgfHwN
Ci0JCQkJKHRtcCAmIChWTV9GQVVMVF9FUlJPUiB8IFZNX0ZBVUxUX05PUEFHRSkpKSkgew0KKwkJ
CQkodG1wICYgKFZNX0ZBVUxUX0VSUk9SIHwgVk1fRkFVTFRfTk9QQUdFIHwNCisJCQkJCVZNX0ZB
VUxUX1JFVFJZKSkpKSB7DQogCQkJcHV0X3BhZ2Uodm1mLT5wYWdlKTsNCiAJCQlyZXR1cm4gdG1w
Ow0KIAkJfQ0KLS0gDQoyLjIwLjENCg0K
