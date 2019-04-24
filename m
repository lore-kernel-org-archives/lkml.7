Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C2A9C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 12:01:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EDE8218D2
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 12:01:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="IWH+bDS4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729733AbfDXMBL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 08:01:11 -0400
Received: from mail-eopbgr710074.outbound.protection.outlook.com ([40.107.71.74]:43387
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729281AbfDXMAf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 08:00:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Qm1ZQB1XZgElabykY/zxs8xcJHay1dvkcWJQ2J0Lc8=;
 b=IWH+bDS4yKXlw1NkOok5DW0SxY3ODLeignxGHjXjRyrxvnk+HMeUmA4RhRRGlejT8amuOaBF9UHU1lEM2s4m7NeKIP/SktzZtMAKXVSpZk4ExrK2RwKOtJulCK0eao0e5LA2T4ZrsqYN9S4BuFm4mtOVrBfWB7ji2NbKK6M54GQ=
Received: from MN2PR05MB6141.namprd05.prod.outlook.com (20.178.241.217) by
 MN2PR05MB6687.namprd05.prod.outlook.com (20.178.249.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.7; Wed, 24 Apr 2019 12:00:21 +0000
Received: from MN2PR05MB6141.namprd05.prod.outlook.com
 ([fe80::441b:ef64:e316:b294]) by MN2PR05MB6141.namprd05.prod.outlook.com
 ([fe80::441b:ef64:e316:b294%5]) with mapi id 15.20.1835.010; Wed, 24 Apr 2019
 12:00:21 +0000
From:   Thomas Hellstrom <thellstrom@vmware.com>
To:     Linux-graphics-maintainer <Linux-graphics-maintainer@vmware.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
CC:     Pv-drivers <Pv-drivers@vmware.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <christian.koenig@amd.com>
Subject: [PATCH 4/9] drm/ttm: Allow the driver to provide the ttm struct
 vm_operations_struct
Thread-Topic: [PATCH 4/9] drm/ttm: Allow the driver to provide the ttm struct
 vm_operations_struct
Thread-Index: AQHU+pVKHjTn6xj4L0+rY3D5lHMzKw==
Date:   Wed, 24 Apr 2019 12:00:21 +0000
Message-ID: <20190424115918.3380-5-thellstrom@vmware.com>
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
x-ms-office365-filtering-correlation-id: 9b921eab-e017-4f31-513a-08d6c8ac6d12
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:MN2PR05MB6687;
x-ms-traffictypediagnostic: MN2PR05MB6687:
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-microsoft-antispam-prvs: <MN2PR05MB66870BBDD2C0A335CB950DA0A13C0@MN2PR05MB6687.namprd05.prod.outlook.com>
x-forefront-prvs: 00179089FD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(136003)(346002)(396003)(366004)(189003)(199004)(8676002)(81156014)(64756008)(66946007)(66556008)(52116002)(6506007)(53936002)(66476007)(68736007)(102836004)(8936002)(6116002)(66446008)(6512007)(36756003)(186003)(81166006)(26005)(73956011)(7736002)(305945005)(316002)(66066001)(2501003)(66574012)(50226002)(97736004)(3846002)(86362001)(1076003)(110136005)(5660300002)(2616005)(14454004)(11346002)(25786009)(486006)(2906002)(76176011)(71200400001)(71190400001)(99286004)(476003)(386003)(256004)(4326008)(446003)(14444005)(6486002)(6436002)(54906003)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR05MB6687;H:MN2PR05MB6141.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: kczG9PNhuaZTmA07GYBh/M2A9lIMqklM1+CYR6iv2u8eXwiSPkozpK46iYj1mNxXgfWhote5n/f62u4BjjviCPW/KtO21jtyXr+/NVwW+G0a2X0LNqoyJwdbBK04OR1aXC5YZisnf6mS+EYY9cdBVa94zJYom2gEADRo18LMV0YMzSJ9lRmdM0UPJ0wPJaupRd7+MLLJbSpWh2NCKcUm6bVV5gtfeuu3sh54TKXc4ultM0iZljp88Ys09CYUYYDnhmbRvVjCz5ofVwCPgoRrwkbMU+iKwj4i/pm7kTDs5yG2F02y0GnFiwvq9xEkDCPrh3kDkFx/1vNyy5QFktEqR0Qs/3Ek8D8e9oI75qvWngNAvY3MZoFNRLUNeHTgvhXfxmLh5sZESljYaIYc/z8eoUWe+ybgllg+C5AZXE1XreU=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E213542893D9B94A8D16C724C95875FA@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b921eab-e017-4f31-513a-08d6c8ac6d12
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2019 12:00:21.4484
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR05MB6687
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIGEgcG9pbnRlciB0byB0aGUgc3RydWN0IHZtX29wZXJhdGlvbnNfc3RydWN0IGluIHRoZSBi
b19kZXZpY2UsIGFuZA0KYXNzaWduIHRoYXQgcG9pbnRlciB0byB0aGUgZGVmYXVsdCB2YWx1ZSBj
dXJyZW50bHkgdXNlZC4NCg0KVGhlIGRyaXZlciBjYW4gdGhlbiBvcHRpb25hbGx5IG1vZGlmeSB0
aGF0IHBvaW50ZXIgYW5kIHRoZSBuZXcgdmFsdWUNCmNhbiBiZSB1c2VkIGZvciBlYWNoIG5ldyB2
bWEgY3JlYXRlZC4NCg0KQ2M6ICJDaHJpc3RpYW4gS8O2bmlnIiA8Y2hyaXN0aWFuLmtvZW5pZ0Bh
bWQuY29tPg0KDQpTaWduZWQtb2ZmLWJ5OiBUaG9tYXMgSGVsbHN0cm9tIDx0aGVsbHN0cm9tQHZt
d2FyZS5jb20+DQpSZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5p
Z0BhbWQuY29tPg0KLS0tDQogZHJpdmVycy9ncHUvZHJtL3R0bS90dG1fYm8uYyAgICB8IDEgKw0K
IGRyaXZlcnMvZ3B1L2RybS90dG0vdHRtX2JvX3ZtLmMgfCA2ICsrKy0tLQ0KIGluY2x1ZGUvZHJt
L3R0bS90dG1fYm9fZHJpdmVyLmggfCA2ICsrKysrKw0KIDMgZmlsZXMgY2hhbmdlZCwgMTAgaW5z
ZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS90dG0vdHRtX2JvLmMgYi9kcml2ZXJzL2dwdS9kcm0vdHRtL3R0bV9iby5jDQppbmRleCAzZjU2
NjQ3Y2RiMzUuLjFjODViZWMwMDQ3MiAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3B1L2RybS90dG0v
dHRtX2JvLmMNCisrKyBiL2RyaXZlcnMvZ3B1L2RybS90dG0vdHRtX2JvLmMNCkBAIC0xNjU2LDYg
KzE2NTYsNyBAQCBpbnQgdHRtX2JvX2RldmljZV9pbml0KHN0cnVjdCB0dG1fYm9fZGV2aWNlICpi
ZGV2LA0KIAltdXRleF9sb2NrKCZ0dG1fZ2xvYmFsX211dGV4KTsNCiAJbGlzdF9hZGRfdGFpbCgm
YmRldi0+ZGV2aWNlX2xpc3QsICZnbG9iLT5kZXZpY2VfbGlzdCk7DQogCW11dGV4X3VubG9jaygm
dHRtX2dsb2JhbF9tdXRleCk7DQorCWJkZXYtPnZtX29wcyA9ICZ0dG1fYm9fdm1fb3BzOw0KIA0K
IAlyZXR1cm4gMDsNCiBvdXRfbm9fc3lzOg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS90
dG0vdHRtX2JvX3ZtLmMgYi9kcml2ZXJzL2dwdS9kcm0vdHRtL3R0bV9ib192bS5jDQppbmRleCBl
ODZhMjlhMWU1MWYuLmJmYjI1YjgxZmVkNyAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3B1L2RybS90
dG0vdHRtX2JvX3ZtLmMNCisrKyBiL2RyaXZlcnMvZ3B1L2RybS90dG0vdHRtX2JvX3ZtLmMNCkBA
IC0zOTUsNyArMzk1LDcgQEAgc3RhdGljIGludCB0dG1fYm9fdm1fYWNjZXNzKHN0cnVjdCB2bV9h
cmVhX3N0cnVjdCAqdm1hLCB1bnNpZ25lZCBsb25nIGFkZHIsDQogCXJldHVybiByZXQ7DQogfQ0K
IA0KLXN0YXRpYyBjb25zdCBzdHJ1Y3Qgdm1fb3BlcmF0aW9uc19zdHJ1Y3QgdHRtX2JvX3ZtX29w
cyA9IHsNCitjb25zdCBzdHJ1Y3Qgdm1fb3BlcmF0aW9uc19zdHJ1Y3QgdHRtX2JvX3ZtX29wcyA9
IHsNCiAJLmZhdWx0ID0gdHRtX2JvX3ZtX2ZhdWx0LA0KIAkub3BlbiA9IHR0bV9ib192bV9vcGVu
LA0KIAkuY2xvc2UgPSB0dG1fYm9fdm1fY2xvc2UsDQpAQCAtNDQ1LDcgKzQ0NSw3IEBAIGludCB0
dG1fYm9fbW1hcChzdHJ1Y3QgZmlsZSAqZmlscCwgc3RydWN0IHZtX2FyZWFfc3RydWN0ICp2bWEs
DQogCWlmICh1bmxpa2VseShyZXQgIT0gMCkpDQogCQlnb3RvIG91dF91bnJlZjsNCiANCi0Jdm1h
LT52bV9vcHMgPSAmdHRtX2JvX3ZtX29wczsNCisJdm1hLT52bV9vcHMgPSBiZGV2LT52bV9vcHM7
DQogDQogCS8qDQogCSAqIE5vdGU6IFdlJ3JlIHRyYW5zZmVycmluZyB0aGUgYm8gcmVmZXJlbmNl
IHRvDQpAQCAtNDc3LDcgKzQ3Nyw3IEBAIGludCB0dG1fZmJkZXZfbW1hcChzdHJ1Y3Qgdm1fYXJl
YV9zdHJ1Y3QgKnZtYSwgc3RydWN0IHR0bV9idWZmZXJfb2JqZWN0ICpibykNCiANCiAJdHRtX2Jv
X2dldChibyk7DQogDQotCXZtYS0+dm1fb3BzID0gJnR0bV9ib192bV9vcHM7DQorCXZtYS0+dm1f
b3BzID0gYm8tPmJkZXYtPnZtX29wczsNCiAJdm1hLT52bV9wcml2YXRlX2RhdGEgPSBibzsNCiAJ
dm1hLT52bV9mbGFncyB8PSBWTV9NSVhFRE1BUDsNCiAJdm1hLT52bV9mbGFncyB8PSBWTV9JTyB8
IFZNX0RPTlRFWFBBTkQ7DQpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9kcm0vdHRtL3R0bV9ib19kcml2
ZXIuaCBiL2luY2x1ZGUvZHJtL3R0bS90dG1fYm9fZHJpdmVyLmgNCmluZGV4IGNiZjMxODBjYjYx
Mi4uY2ZlYWZmNWQ5NzA2IDEwMDY0NA0KLS0tIGEvaW5jbHVkZS9kcm0vdHRtL3R0bV9ib19kcml2
ZXIuaA0KKysrIGIvaW5jbHVkZS9kcm0vdHRtL3R0bV9ib19kcml2ZXIuaA0KQEAgLTQ0Myw2ICs0
NDMsOSBAQCBleHRlcm4gc3RydWN0IHR0bV9ib19nbG9iYWwgew0KICAqIEBkcml2ZXI6IFBvaW50
ZXIgdG8gYSBzdHJ1Y3QgdHRtX2JvX2RyaXZlciBzdHJ1Y3Qgc2V0dXAgYnkgdGhlIGRyaXZlci4N
CiAgKiBAbWFuOiBBbiBhcnJheSBvZiBtZW1fdHlwZV9tYW5hZ2Vycy4NCiAgKiBAdm1hX21hbmFn
ZXI6IEFkZHJlc3Mgc3BhY2UgbWFuYWdlcg0KKyAqIEB2bV9vcHM6IFBvaW50ZXIgdG8gdGhlIHN0
cnVjdCB2bV9vcGVyYXRpb25zX3N0cnVjdCB1c2VkIGZvciB0aGlzDQorICogZGV2aWNlJ3MgVk0g
b3BlcmF0aW9ucy4gVGhlIGRyaXZlciBtYXkgb3ZlcnJpZGUgdGhpcyBiZWZvcmUgdGhlIGZpcnN0
DQorICogbW1hcCgpIGNhbGwuDQogICogbHJ1X2xvY2s6IFNwaW5sb2NrIHRoYXQgcHJvdGVjdHMg
dGhlIGJ1ZmZlcitkZXZpY2UgbHJ1IGxpc3RzIGFuZA0KICAqIGRkZXN0cm95IGxpc3RzLg0KICAq
IEBkZXZfbWFwcGluZzogQSBwb2ludGVyIHRvIHRoZSBzdHJ1Y3QgYWRkcmVzc19zcGFjZSByZXBy
ZXNlbnRpbmcgdGhlDQpAQCAtNDYxLDYgKzQ2NCw3IEBAIHN0cnVjdCB0dG1fYm9fZGV2aWNlIHsN
CiAJc3RydWN0IHR0bV9ib19nbG9iYWwgKmdsb2I7DQogCXN0cnVjdCB0dG1fYm9fZHJpdmVyICpk
cml2ZXI7DQogCXN0cnVjdCB0dG1fbWVtX3R5cGVfbWFuYWdlciBtYW5bVFRNX05VTV9NRU1fVFlQ
RVNdOw0KKwljb25zdCBzdHJ1Y3Qgdm1fb3BlcmF0aW9uc19zdHJ1Y3QgKnZtX29wczsNCiANCiAJ
LyoNCiAJICogUHJvdGVjdGVkIGJ5IGludGVybmFsIGxvY2tzLg0KQEAgLTQ4OSw2ICs0OTMsOCBA
QCBzdHJ1Y3QgdHRtX2JvX2RldmljZSB7DQogCWJvb2wgbm9fcmV0cnk7DQogfTsNCiANCitleHRl
cm4gY29uc3Qgc3RydWN0IHZtX29wZXJhdGlvbnNfc3RydWN0IHR0bV9ib192bV9vcHM7DQorDQog
LyoqDQogICogc3RydWN0IHR0bV9scnVfYnVsa19tb3ZlX3Bvcw0KICAqDQotLSANCjIuMjAuMQ0K
DQo=
