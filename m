Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37FFDC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 12:33:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED7A521738
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 12:33:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="YYqWWbgX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727720AbfDWMdm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 08:33:42 -0400
Received: from mail-eopbgr800053.outbound.protection.outlook.com ([40.107.80.53]:61502
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726033AbfDWMdm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 08:33:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SFOWcRMqYDhw6jqoVK+LfZMp/kt/wYrgJGBI7ZffPGk=;
 b=YYqWWbgXt1dRe98rTUW4tLQxyZBgm1iSUizVmwAsvhLDeMSJiHen5C1hKtCUqEcfqQoc0J9wYTeQ1rcqR4ymerOIYYShTl0Zc3JOFFx0j2jK/H7KjkFR7+lB5T0ugMJAtBum7zuiu5ZIAuBZVhMEv+ViAAzM/Wj2gcxxNRH9xuE=
Received: from MN2PR05MB6141.namprd05.prod.outlook.com (20.178.241.217) by
 MN2PR05MB6704.namprd05.prod.outlook.com (20.178.249.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.9; Tue, 23 Apr 2019 12:32:59 +0000
Received: from MN2PR05MB6141.namprd05.prod.outlook.com
 ([fe80::441b:ef64:e316:b294]) by MN2PR05MB6141.namprd05.prod.outlook.com
 ([fe80::441b:ef64:e316:b294%5]) with mapi id 15.20.1835.010; Tue, 23 Apr 2019
 12:32:59 +0000
From:   Thomas Hellstrom <thellstrom@vmware.com>
To:     Deepak Singh Rawat <drawat@vmware.com>, "hch@lst.de" <hch@lst.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Thomas Hellstrom <thellstrom@vmware.com>
Subject: [PATCH] drm/vmwgfx: Fix dma API layer violation
Thread-Topic: [PATCH] drm/vmwgfx: Fix dma API layer violation
Thread-Index: AQHU+dCvO3ng+InGw0O++RF6DrHRnA==
Date:   Tue, 23 Apr 2019 12:32:59 +0000
Message-ID: <20190423123242.3028-1-thellstrom@vmware.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0347.eurprd05.prod.outlook.com
 (2603:10a6:7:92::42) To MN2PR05MB6141.namprd05.prod.outlook.com
 (2603:10b6:208:c7::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=thellstrom@vmware.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-originating-ip: [155.4.205.35]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 81484530-35b8-4dde-4c7b-08d6c7e7d195
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:MN2PR05MB6704;
x-ms-traffictypediagnostic: MN2PR05MB6704:
x-microsoft-antispam-prvs: <MN2PR05MB6704E53D8566D88A475138F5A1230@MN2PR05MB6704.namprd05.prod.outlook.com>
x-forefront-prvs: 0016DEFF96
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(39860400002)(376002)(136003)(366004)(199004)(189003)(6506007)(102836004)(2501003)(6436002)(5660300002)(3846002)(386003)(52116002)(6116002)(2906002)(6486002)(66446008)(53936002)(66556008)(66476007)(6512007)(86362001)(66946007)(73956011)(25786009)(66066001)(64756008)(4326008)(107886003)(8676002)(81166006)(50226002)(8936002)(81156014)(1076003)(14454004)(2616005)(486006)(97736004)(71190400001)(256004)(36756003)(26005)(476003)(186003)(71200400001)(305945005)(110136005)(54906003)(316002)(99286004)(7736002)(478600001)(68736007);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR05MB6704;H:MN2PR05MB6141.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: KQksZ4C6uzYxGixyVe5Srk7e1OVC+jaGvu78aIvOq7ltiP0Xv3c+HFV+89ep2jXgDYqCnfVZ3MxHljcovd8/C+KIEbp1q3R/5CvrbB8w2bJBA/gwFt5aYCFKtZmRfUnWciAmIiTIJwbC/hwe2XP5xKakD+PmW54WABEMzByhruTnaueUkIEBH09E779wZ0EFYHleRAu97krUMdSzPIUuMA2lbCXZogP3aukRUgYE/hFdAGTw5Rs+pUNoUZcvGi7di7a9x5s1dHzIh2Ul3H04M8VK5XH6fzveCmFWUklceE2CxWcQ7PKdLUSvav2FSKGfB2VXsCIKRCcdsIO/KOFsIna13N7J5sUWOX3cMXh290y5XlmJxeJj9MYvnWgnH+B94egYDpRcCi4Qml6iQtDE96XvF764tnDxVoiv5x0Cmag=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81484530-35b8-4dde-4c7b-08d6c7e7d195
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2019 12:32:59.0782
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR05MB6704
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UmVtb3ZlIHRoZSBjaGVjayBmb3IgSU9NTVUgcHJlc2VuY2Ugc2luY2UgaXQgd2FzIGNvbnNpZGVy
ZWQgYQ0KbGF5ZXIgdmlvbGF0aW9uLg0KVGhpcyBtZWFucyB3ZSBoYXZlIG5vIHJlbGlhYmxlIHdh
eSB0byBkZXN0aW5ndWlzaCBiZXR3ZWVuIGNvaGVyZW50DQpoYXJkd2FyZSBJT01NVSBETUEgYWRk
cmVzcyB0cmFuc2xhdGlvbnMgYW5kIGluY29oZXJlbnQgU1dJT1RMQiBETUENCmFkZHJlc3MgdHJh
bnNsYXRpb25zLCB3aGljaCB3ZSBjYW4ndCBoYW5kbGUuIFNvIGFsd2F5cyBwcmVzdW1lIHRoZQ0K
Zm9ybWVyLiBUaGlzIG1lYW5zIHRoYXQgaWYgYW55Ym9keSBmb3JjZXMgU1dJT1RMQiB3aXRob3V0
IGFsc28gc2V0dGluZw0KdGhlIHZtd19mb3JjZV9jb2hlcmVudD0xIHZtd2dmeCBvcHRpb24sIGRy
aXZlciBvcGVyYXRpb24gd2lsbCBmYWlsLA0KbGlrZSBpdCB3aWxsIG9uIG1vc3Qgb3RoZXIgZ3Jh
cGhpY3MgZHJpdmVycy4NCg0KU2lnbmVkLW9mZi1ieTogVGhvbWFzIEhlbGxzdHJvbSA8dGhlbGxz
dHJvbUB2bXdhcmUuY29tPg0KLS0tDQogZHJpdmVycy9ncHUvZHJtL3Ztd2dmeC92bXdnZnhfZHJ2
LmMgfCAzMyArKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCA1
IGluc2VydGlvbnMoKyksIDI4IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL3Ztd2dmeC92bXdnZnhfZHJ2LmMgYi9kcml2ZXJzL2dwdS9kcm0vdm13Z2Z4L3Ztd2dm
eF9kcnYuYw0KaW5kZXggNzRlOTQxMzg4NzdlLi4yNzcyNTMwZGU0Y2IgMTAwNjQ0DQotLS0gYS9k
cml2ZXJzL2dwdS9kcm0vdm13Z2Z4L3Ztd2dmeF9kcnYuYw0KKysrIGIvZHJpdmVycy9ncHUvZHJt
L3Ztd2dmeC92bXdnZnhfZHJ2LmMNCkBAIC01NDUsMzAgKzU0NSwxNCBAQCBzdGF0aWMgdm9pZCB2
bXdfZ2V0X2luaXRpYWxfc2l6ZShzdHJ1Y3Qgdm13X3ByaXZhdGUgKmRldl9wcml2KQ0KIAlkZXZf
cHJpdi0+aW5pdGlhbF9oZWlnaHQgPSBoZWlnaHQ7DQogfQ0KIA0KLS8qKg0KLSAqIHZtd19hc3N1
bWVfaW9tbXUgLSBGaWd1cmUgb3V0IHdoZXRoZXIgY29oZXJlbnQgZG1hLXJlbWFwcGluZyBtaWdo
dCBiZQ0KLSAqIHRha2luZyBwbGFjZS4NCi0gKiBAZGV2OiBQb2ludGVyIHRvIHRoZSBzdHJ1Y3Qg
ZHJtX2RldmljZS4NCi0gKg0KLSAqIFJldHVybjogdHJ1ZSBpZiBpb21tdSBwcmVzZW50LCBmYWxz
ZSBvdGhlcndpc2UuDQotICovDQotc3RhdGljIGJvb2wgdm13X2Fzc3VtZV9pb21tdShzdHJ1Y3Qg
ZHJtX2RldmljZSAqZGV2KQ0KLXsNCi0JY29uc3Qgc3RydWN0IGRtYV9tYXBfb3BzICpvcHMgPSBn
ZXRfZG1hX29wcyhkZXYtPmRldik7DQotDQotCXJldHVybiAhZG1hX2lzX2RpcmVjdChvcHMpICYm
IG9wcyAmJg0KLQkJb3BzLT5tYXBfcGFnZSAhPSBkbWFfZGlyZWN0X21hcF9wYWdlOw0KLX0NCi0N
CiAvKioNCiAgKiB2bXdfZG1hX3NlbGVjdF9tb2RlIC0gRGV0ZXJtaW5lIGhvdyBETUEgbWFwcGlu
Z3Mgc2hvdWxkIGJlIHNldCB1cCBmb3IgdGhpcw0KICAqIHN5c3RlbS4NCiAgKg0KICAqIEBkZXZf
cHJpdjogUG9pbnRlciB0byBhIHN0cnVjdCB2bXdfcHJpdmF0ZQ0KICAqDQotICogVGhpcyBmdW5j
dGlvbnMgdHJpZXMgdG8gZGV0ZXJtaW5lIHRoZSBJT01NVSBzZXR1cCBhbmQgd2hhdCBhY3Rpb25z
DQotICogbmVlZCB0byBiZSB0YWtlbiBieSB0aGUgZHJpdmVyIHRvIG1ha2Ugc3lzdGVtIHBhZ2Vz
IHZpc2libGUgdG8gdGhlDQotICogZGV2aWNlLg0KKyAqIFRoaXMgZnVuY3Rpb25zIHRyaWVzIHRv
IGRldGVybWluZSB3aGF0IGFjdGlvbnMgbmVlZCB0byBiZSB0YWtlbiBieSB0aGUNCisgKiBkcml2
ZXIgdG8gbWFrZSBzeXN0ZW0gcGFnZXMgdmlzaWJsZSB0byB0aGUgZGV2aWNlLg0KICAqIElmIHRo
aXMgZnVuY3Rpb24gZGVjaWRlcyB0aGF0IERNQSBpcyBub3QgcG9zc2libGUsIGl0IHJldHVybnMg
LUVJTlZBTC4NCiAgKiBUaGUgZHJpdmVyIG1heSB0aGVuIHRyeSB0byBkaXNhYmxlIGZlYXR1cmVz
IG9mIHRoZSBkZXZpY2UgdGhhdCByZXF1aXJlDQogICogRE1BLg0KQEAgLTU3OCwyMyArNTYyLDE2
IEBAIHN0YXRpYyBpbnQgdm13X2RtYV9zZWxlY3RfbW9kZShzdHJ1Y3Qgdm13X3ByaXZhdGUgKmRl
dl9wcml2KQ0KIAlzdGF0aWMgY29uc3QgY2hhciAqbmFtZXNbdm13X2RtYV9tYXBfbWF4XSA9IHsN
CiAJCVt2bXdfZG1hX3BoeXNdID0gIlVzaW5nIHBoeXNpY2FsIFRUTSBwYWdlIGFkZHJlc3Nlcy4i
LA0KIAkJW3Ztd19kbWFfYWxsb2NfY29oZXJlbnRdID0gIlVzaW5nIGNvaGVyZW50IFRUTSBwYWdl
cy4iLA0KLQkJW3Ztd19kbWFfbWFwX3BvcHVsYXRlXSA9ICJLZWVwaW5nIERNQSBtYXBwaW5ncy4i
LA0KKwkJW3Ztd19kbWFfbWFwX3BvcHVsYXRlXSA9ICJDYWNoaW5nIERNQSBtYXBwaW5ncy4iLA0K
IAkJW3Ztd19kbWFfbWFwX2JpbmRdID0gIkdpdmluZyB1cCBETUEgbWFwcGluZ3MgZWFybHkuIn07
DQogDQogCWlmICh2bXdfZm9yY2VfY29oZXJlbnQpDQogCQlkZXZfcHJpdi0+bWFwX21vZGUgPSB2
bXdfZG1hX2FsbG9jX2NvaGVyZW50Ow0KLQllbHNlIGlmICh2bXdfYXNzdW1lX2lvbW11KGRldl9w
cml2LT5kZXYpKQ0KLQkJZGV2X3ByaXYtPm1hcF9tb2RlID0gdm13X2RtYV9tYXBfcG9wdWxhdGU7
DQotCWVsc2UgaWYgKCF2bXdfZm9yY2VfaW9tbXUpDQotCQlkZXZfcHJpdi0+bWFwX21vZGUgPSB2
bXdfZG1hX3BoeXM7DQotCWVsc2UgaWYgKElTX0VOQUJMRUQoQ09ORklHX1NXSU9UTEIpICYmIHN3
aW90bGJfbnJfdGJsKCkpDQotCQlkZXZfcHJpdi0+bWFwX21vZGUgPSB2bXdfZG1hX2FsbG9jX2Nv
aGVyZW50Ow0KKwllbHNlIGlmICh2bXdfcmVzdHJpY3RfaW9tbXUpDQorCQlkZXZfcHJpdi0+bWFw
X21vZGUgPSB2bXdfZG1hX21hcF9iaW5kOw0KIAllbHNlDQogCQlkZXZfcHJpdi0+bWFwX21vZGUg
PSB2bXdfZG1hX21hcF9wb3B1bGF0ZTsNCiANCi0JaWYgKGRldl9wcml2LT5tYXBfbW9kZSA9PSB2
bXdfZG1hX21hcF9wb3B1bGF0ZSAmJiB2bXdfcmVzdHJpY3RfaW9tbXUpDQotCQlkZXZfcHJpdi0+
bWFwX21vZGUgPSB2bXdfZG1hX21hcF9iaW5kOw0KLQ0KIAkvKiBObyBUVE0gY29oZXJlbnQgcGFn
ZSBwb29sPyBGSVhNRTogQXNrIFRUTSBpbnN0ZWFkISAqLw0KICAgICAgICAgaWYgKCEoSVNfRU5B
QkxFRChDT05GSUdfU1dJT1RMQikgfHwgSVNfRU5BQkxFRChDT05GSUdfSU5URUxfSU9NTVUpKSAm
Jg0KIAkgICAgKGRldl9wcml2LT5tYXBfbW9kZSA9PSB2bXdfZG1hX2FsbG9jX2NvaGVyZW50KSkN
Ci0tIA0KMi4yMC4xDQoNCg==
