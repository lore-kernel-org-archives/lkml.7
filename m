Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE751C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 16:04:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E268218C3
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 16:04:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="lx4tgomN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbfDLQEe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 12:04:34 -0400
Received: from mail-eopbgr800078.outbound.protection.outlook.com ([40.107.80.78]:12000
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726992AbfDLQEd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 12:04:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0xd5TEgLr6viGC+GKg3VSqEBnsK5UtzAgMYhv4wLNTQ=;
 b=lx4tgomNtudYklyd3fLXSRHsV3vThiL9bI+apDu3zAZqhQY1tiPbH+1LaKMZeSI+7U034FxC9gt4a5fCSx2VTjJjTuIwxz+Iun/feKguHaCBaoylS0jt7hp8p/F/0vbesN2cpqDMEKFs4TOrYT6utIhezlFLd8AmvFSiCLPRly4=
Received: from MN2PR05MB6141.namprd05.prod.outlook.com (20.178.241.217) by
 MN2PR05MB6030.namprd05.prod.outlook.com (20.178.241.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.9; Fri, 12 Apr 2019 16:04:24 +0000
Received: from MN2PR05MB6141.namprd05.prod.outlook.com
 ([fe80::91e:292d:e304:78ad]) by MN2PR05MB6141.namprd05.prod.outlook.com
 ([fe80::91e:292d:e304:78ad%7]) with mapi id 15.20.1792.009; Fri, 12 Apr 2019
 16:04:24 +0000
From:   Thomas Hellstrom <thellstrom@vmware.com>
To:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Linux-graphics-maintainer <Linux-graphics-maintainer@vmware.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Thomas Hellstrom <thellstrom@vmware.com>,
        =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <christian.koenig@amd.com>
Subject: [PATCH 4/9] drm/ttm: Allow the driver to provide the ttm struct
 vm_operations_struct
Thread-Topic: [PATCH 4/9] drm/ttm: Allow the driver to provide the ttm struct
 vm_operations_struct
Thread-Index: AQHU8UllCfN1HiPxjkiuYBTS+xNlhA==
Date:   Fri, 12 Apr 2019 16:04:23 +0000
Message-ID: <20190412160338.64994-5-thellstrom@vmware.com>
References: <20190412160338.64994-1-thellstrom@vmware.com>
In-Reply-To: <20190412160338.64994-1-thellstrom@vmware.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VE1PR03CA0023.eurprd03.prod.outlook.com
 (2603:10a6:802:a0::35) To MN2PR05MB6141.namprd05.prod.outlook.com
 (2603:10b6:208:c7::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=thellstrom@vmware.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-originating-ip: [155.4.205.35]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8de3c4b1-bd52-4ad3-9f99-08d6bf6087a6
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);SRVR:MN2PR05MB6030;
x-ms-traffictypediagnostic: MN2PR05MB6030:
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-microsoft-antispam-prvs: <MN2PR05MB603065FE90EB29F26CC5234EA1280@MN2PR05MB6030.namprd05.prod.outlook.com>
x-forefront-prvs: 0005B05917
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(346002)(376002)(39860400002)(396003)(199004)(189003)(110136005)(25786009)(476003)(2616005)(71190400001)(6512007)(2906002)(186003)(486006)(316002)(54906003)(68736007)(1076003)(6486002)(6436002)(446003)(478600001)(3846002)(71200400001)(6116002)(11346002)(66574012)(99286004)(256004)(14444005)(14454004)(2501003)(8676002)(66066001)(7736002)(4326008)(6506007)(81166006)(36756003)(81156014)(386003)(97736004)(102836004)(50226002)(106356001)(52116002)(5660300002)(53936002)(8936002)(305945005)(76176011)(26005)(86362001)(105586002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR05MB6030;H:MN2PR05MB6141.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: XMQZKHmYgjZtdkWgh7vH6Cjrgs/sNGq+pC3q+vD+kodQvc8WUIODGADjOTQV0/gCa6WiNdwt+7uCuam6dBrmVzMxY66/4cBfbXg3G6klmwL82saIZO1mexZ3FZ/wGLlbhsMIEzrG12acX1xlMIJR+1Ylt+Zkmsi2utbJjSnT+HLHMZzB+nCr39bEcSzCreu90WJKYk22f+946VguKiRXPQeLvtHYvddHDJ52uZPAGBk0XKJb8zotJbTEVscCOhI9WXQDEUuUEuhO3cFi5mBn290gEOvY6YIZrxqe+Bhfe9gKpvjonnQhn530hNGCeHWDrxetC9Tw5E9Wz1OtWFFBaJxUfjJAgNYgY4tvjAZLgr7RJNBQiS9bSSFYH1lsBw08M2c2156mvMOBFkmm+j18Ow/x4fkV0xMmANNnKW+Fx9c=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B2B8EC862A1C474AB2F07B6673B5F04C@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8de3c4b1-bd52-4ad3-9f99-08d6bf6087a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2019 16:04:24.0428
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR05MB6030
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIGEgcG9pbnRlciB0byB0aGUgc3RydWN0IHZtX29wZXJhdGlvbnNfc3RydWN0IGluIHRoZSBi
b19kZXZpY2UsIGFuZA0KYXNzaWduIHRoYXQgcG9pbnRlciB0byB0aGUgZGVmYXVsdCB2YWx1ZSBj
dXJyZW50bHkgdXNlZC4NCg0KVGhlIGRyaXZlciBjYW4gdGhlbiBvcHRpb25hbGx5IG1vZGlmeSB0
aGF0IHBvaW50ZXIgYW5kIHRoZSBuZXcgdmFsdWUNCmNhbiBiZSB1c2VkIGZvciBlYWNoIG5ldyB2
bWEgY3JlYXRlZC4NCg0KQ2M6ICJDaHJpc3RpYW4gS8O2bmlnIiA8Y2hyaXN0aWFuLmtvZW5pZ0Bh
bWQuY29tPg0KU2lnbmVkLW9mZi1ieTogVGhvbWFzIEhlbGxzdHJvbSA8dGhlbGxzdHJvbUB2bXdh
cmUuY29tPg0KLS0tDQogZHJpdmVycy9ncHUvZHJtL3R0bS90dG1fYm8uYyAgICB8IDEgKw0KIGRy
aXZlcnMvZ3B1L2RybS90dG0vdHRtX2JvX3ZtLmMgfCA2ICsrKy0tLQ0KIGluY2x1ZGUvZHJtL3R0
bS90dG1fYm9fZHJpdmVyLmggfCA2ICsrKysrKw0KIDMgZmlsZXMgY2hhbmdlZCwgMTAgaW5zZXJ0
aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS90
dG0vdHRtX2JvLmMgYi9kcml2ZXJzL2dwdS9kcm0vdHRtL3R0bV9iby5jDQppbmRleCAzZjU2NjQ3
Y2RiMzUuLjFjODViZWMwMDQ3MiAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3B1L2RybS90dG0vdHRt
X2JvLmMNCisrKyBiL2RyaXZlcnMvZ3B1L2RybS90dG0vdHRtX2JvLmMNCkBAIC0xNjU2LDYgKzE2
NTYsNyBAQCBpbnQgdHRtX2JvX2RldmljZV9pbml0KHN0cnVjdCB0dG1fYm9fZGV2aWNlICpiZGV2
LA0KIAltdXRleF9sb2NrKCZ0dG1fZ2xvYmFsX211dGV4KTsNCiAJbGlzdF9hZGRfdGFpbCgmYmRl
di0+ZGV2aWNlX2xpc3QsICZnbG9iLT5kZXZpY2VfbGlzdCk7DQogCW11dGV4X3VubG9jaygmdHRt
X2dsb2JhbF9tdXRleCk7DQorCWJkZXYtPnZtX29wcyA9ICZ0dG1fYm9fdm1fb3BzOw0KIA0KIAly
ZXR1cm4gMDsNCiBvdXRfbm9fc3lzOg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS90dG0v
dHRtX2JvX3ZtLmMgYi9kcml2ZXJzL2dwdS9kcm0vdHRtL3R0bV9ib192bS5jDQppbmRleCBlODZh
MjlhMWU1MWYuLmJmYjI1YjgxZmVkNyAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3B1L2RybS90dG0v
dHRtX2JvX3ZtLmMNCisrKyBiL2RyaXZlcnMvZ3B1L2RybS90dG0vdHRtX2JvX3ZtLmMNCkBAIC0z
OTUsNyArMzk1LDcgQEAgc3RhdGljIGludCB0dG1fYm9fdm1fYWNjZXNzKHN0cnVjdCB2bV9hcmVh
X3N0cnVjdCAqdm1hLCB1bnNpZ25lZCBsb25nIGFkZHIsDQogCXJldHVybiByZXQ7DQogfQ0KIA0K
LXN0YXRpYyBjb25zdCBzdHJ1Y3Qgdm1fb3BlcmF0aW9uc19zdHJ1Y3QgdHRtX2JvX3ZtX29wcyA9
IHsNCitjb25zdCBzdHJ1Y3Qgdm1fb3BlcmF0aW9uc19zdHJ1Y3QgdHRtX2JvX3ZtX29wcyA9IHsN
CiAJLmZhdWx0ID0gdHRtX2JvX3ZtX2ZhdWx0LA0KIAkub3BlbiA9IHR0bV9ib192bV9vcGVuLA0K
IAkuY2xvc2UgPSB0dG1fYm9fdm1fY2xvc2UsDQpAQCAtNDQ1LDcgKzQ0NSw3IEBAIGludCB0dG1f
Ym9fbW1hcChzdHJ1Y3QgZmlsZSAqZmlscCwgc3RydWN0IHZtX2FyZWFfc3RydWN0ICp2bWEsDQog
CWlmICh1bmxpa2VseShyZXQgIT0gMCkpDQogCQlnb3RvIG91dF91bnJlZjsNCiANCi0Jdm1hLT52
bV9vcHMgPSAmdHRtX2JvX3ZtX29wczsNCisJdm1hLT52bV9vcHMgPSBiZGV2LT52bV9vcHM7DQog
DQogCS8qDQogCSAqIE5vdGU6IFdlJ3JlIHRyYW5zZmVycmluZyB0aGUgYm8gcmVmZXJlbmNlIHRv
DQpAQCAtNDc3LDcgKzQ3Nyw3IEBAIGludCB0dG1fZmJkZXZfbW1hcChzdHJ1Y3Qgdm1fYXJlYV9z
dHJ1Y3QgKnZtYSwgc3RydWN0IHR0bV9idWZmZXJfb2JqZWN0ICpibykNCiANCiAJdHRtX2JvX2dl
dChibyk7DQogDQotCXZtYS0+dm1fb3BzID0gJnR0bV9ib192bV9vcHM7DQorCXZtYS0+dm1fb3Bz
ID0gYm8tPmJkZXYtPnZtX29wczsNCiAJdm1hLT52bV9wcml2YXRlX2RhdGEgPSBibzsNCiAJdm1h
LT52bV9mbGFncyB8PSBWTV9NSVhFRE1BUDsNCiAJdm1hLT52bV9mbGFncyB8PSBWTV9JTyB8IFZN
X0RPTlRFWFBBTkQ7DQpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9kcm0vdHRtL3R0bV9ib19kcml2ZXIu
aCBiL2luY2x1ZGUvZHJtL3R0bS90dG1fYm9fZHJpdmVyLmgNCmluZGV4IGNiZjMxODBjYjYxMi4u
Y2ZlYWZmNWQ5NzA2IDEwMDY0NA0KLS0tIGEvaW5jbHVkZS9kcm0vdHRtL3R0bV9ib19kcml2ZXIu
aA0KKysrIGIvaW5jbHVkZS9kcm0vdHRtL3R0bV9ib19kcml2ZXIuaA0KQEAgLTQ0Myw2ICs0NDMs
OSBAQCBleHRlcm4gc3RydWN0IHR0bV9ib19nbG9iYWwgew0KICAqIEBkcml2ZXI6IFBvaW50ZXIg
dG8gYSBzdHJ1Y3QgdHRtX2JvX2RyaXZlciBzdHJ1Y3Qgc2V0dXAgYnkgdGhlIGRyaXZlci4NCiAg
KiBAbWFuOiBBbiBhcnJheSBvZiBtZW1fdHlwZV9tYW5hZ2Vycy4NCiAgKiBAdm1hX21hbmFnZXI6
IEFkZHJlc3Mgc3BhY2UgbWFuYWdlcg0KKyAqIEB2bV9vcHM6IFBvaW50ZXIgdG8gdGhlIHN0cnVj
dCB2bV9vcGVyYXRpb25zX3N0cnVjdCB1c2VkIGZvciB0aGlzDQorICogZGV2aWNlJ3MgVk0gb3Bl
cmF0aW9ucy4gVGhlIGRyaXZlciBtYXkgb3ZlcnJpZGUgdGhpcyBiZWZvcmUgdGhlIGZpcnN0DQor
ICogbW1hcCgpIGNhbGwuDQogICogbHJ1X2xvY2s6IFNwaW5sb2NrIHRoYXQgcHJvdGVjdHMgdGhl
IGJ1ZmZlcitkZXZpY2UgbHJ1IGxpc3RzIGFuZA0KICAqIGRkZXN0cm95IGxpc3RzLg0KICAqIEBk
ZXZfbWFwcGluZzogQSBwb2ludGVyIHRvIHRoZSBzdHJ1Y3QgYWRkcmVzc19zcGFjZSByZXByZXNl
bnRpbmcgdGhlDQpAQCAtNDYxLDYgKzQ2NCw3IEBAIHN0cnVjdCB0dG1fYm9fZGV2aWNlIHsNCiAJ
c3RydWN0IHR0bV9ib19nbG9iYWwgKmdsb2I7DQogCXN0cnVjdCB0dG1fYm9fZHJpdmVyICpkcml2
ZXI7DQogCXN0cnVjdCB0dG1fbWVtX3R5cGVfbWFuYWdlciBtYW5bVFRNX05VTV9NRU1fVFlQRVNd
Ow0KKwljb25zdCBzdHJ1Y3Qgdm1fb3BlcmF0aW9uc19zdHJ1Y3QgKnZtX29wczsNCiANCiAJLyoN
CiAJICogUHJvdGVjdGVkIGJ5IGludGVybmFsIGxvY2tzLg0KQEAgLTQ4OSw2ICs0OTMsOCBAQCBz
dHJ1Y3QgdHRtX2JvX2RldmljZSB7DQogCWJvb2wgbm9fcmV0cnk7DQogfTsNCiANCitleHRlcm4g
Y29uc3Qgc3RydWN0IHZtX29wZXJhdGlvbnNfc3RydWN0IHR0bV9ib192bV9vcHM7DQorDQogLyoq
DQogICogc3RydWN0IHR0bV9scnVfYnVsa19tb3ZlX3Bvcw0KICAqDQotLSANCjIuMjAuMQ0KDQo=
