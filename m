Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B22E2C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 21:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61E562171F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 21:26:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ECvLsKIT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730866AbfDDV0F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 17:26:05 -0400
Received: from mail-eopbgr760073.outbound.protection.outlook.com ([40.107.76.73]:65094
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730801AbfDDV0C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 17:26:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mD/HGsYGXhlMOCK6yRaNFNE9SWVp6H/5uNi6cPoo5W4=;
 b=ECvLsKITEIDKwrqnl72Km+HWWUvue27R+TkCfjdqZZr4XeZfWOEqnAIvryYhfOzKcjxpTBS4Gn6J4MMwtLJsEdJvyWA3vlnn0BtzgLIlsfgL5PmfGG3Et1ODdNu0GSv5VKq2cY7eR/BkAV7GXaw+L6eNJ96NaY2EY3PGHbDzZvc=
Received: from SN6PR12MB2736.namprd12.prod.outlook.com (52.135.107.27) by
 SN6PR12MB2784.namprd12.prod.outlook.com (52.135.107.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.22; Thu, 4 Apr 2019 21:25:54 +0000
Received: from SN6PR12MB2736.namprd12.prod.outlook.com
 ([fe80::65cb:af55:6bd4:55a]) by SN6PR12MB2736.namprd12.prod.outlook.com
 ([fe80::65cb:af55:6bd4:55a%4]) with mapi id 15.20.1750.017; Thu, 4 Apr 2019
 21:25:54 +0000
From:   "Natarajan, Janakarajan" <Janakarajan.Natarajan@amd.com>
To:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>
CC:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Schmauss <erik.schmauss@intel.com>,
        "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        "Natarajan, Janakarajan" <Janakarajan.Natarajan@amd.com>
Subject: [PATCH v2 5/7] acpi/cppc: Add macros to define a R/W sysfs entry for
 CPPC registers
Thread-Topic: [PATCH v2 5/7] acpi/cppc: Add macros to define a R/W sysfs entry
 for CPPC registers
Thread-Index: AQHU6yz79kHizkaTb0yix5NLjnzz5A==
Date:   Thu, 4 Apr 2019 21:25:53 +0000
Message-ID: <ca37ee20457cbd96b4f028ec7155135c61b06e61.1554410643.git.Janakarajan.Natarajan@amd.com>
References: <cover.1554410643.git.Janakarajan.Natarajan@amd.com>
In-Reply-To: <cover.1554410643.git.Janakarajan.Natarajan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0201CA0052.namprd02.prod.outlook.com
 (2603:10b6:803:20::14) To SN6PR12MB2736.namprd12.prod.outlook.com
 (2603:10b6:805:77::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Janakarajan.Natarajan@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [165.204.78.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1d7e4330-6b65-48cf-fbdc-08d6b9441e41
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:SN6PR12MB2784;
x-ms-traffictypediagnostic: SN6PR12MB2784:
x-microsoft-antispam-prvs: <SN6PR12MB27844E226091FC68121D986BE7500@SN6PR12MB2784.namprd12.prod.outlook.com>
x-forefront-prvs: 0997523C40
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(366004)(396003)(136003)(376002)(199004)(189003)(97736004)(6436002)(478600001)(71200400001)(118296001)(7736002)(71190400001)(36756003)(14444005)(256004)(72206003)(4326008)(2201001)(86362001)(486006)(68736007)(14454004)(6486002)(66066001)(316002)(8676002)(2501003)(102836004)(52116002)(2906002)(110136005)(26005)(99286004)(6506007)(54906003)(76176011)(2616005)(186003)(81156014)(5660300002)(81166006)(305945005)(50226002)(8936002)(6512007)(25786009)(53936002)(6116002)(446003)(106356001)(105586002)(3846002)(476003)(11346002)(386003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2784;H:SN6PR12MB2736.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: r8TZYo7KSHG6zwxbiJ+W9vzfYshfYJ++0nvo1xMWjZy4CZ/9hZqK4bRiMOTvZKCJmyOE2lKh/KT7NFp8eB05iHJMI6QyY5JBtkoH4WTkHncMk1BLblR+Vcq0Xr3OgJN1QQmslh3KS5fs6CHnirJwAhUhcTgKPQi9X5aH9OsQFsoRMdsoQ4rhIu3lr3CPkSPtLSd2B4+QgQxhAUEEbAy12K6X3LlzB4VzWLvV8Hsbqj+k4DMLhDK62kl7EAmKqh1A009I/633s4P9jkmN3mY8TyVuY5TCDVev8mMuauq6tVgBYUc2kJOZD0QD4Z9ew14q1WcbTVw3Rtcu7BVW/5X+HcmVPE4c/fJs8pD2s9je4Z9ZUvYge4LqNQ3V4QGU0EhkeR3hsnEJT+RamNXvz19cffxsmCJ69CeLF7FpA7XoKRY=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d7e4330-6b65-48cf-fbdc-08d6b9441e41
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2019 21:25:53.8330
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2784
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogWWF6ZW4gR2hhbm5hbSA8WWF6ZW4uR2hhbm5hbUBhbWQuY29tPg0KDQpTb21lIENQUEMg
cmVnaXN0ZXJzIGNhbiBiZSB1c2VkIHRvIGNvbmZpZ3VyZSB0aGUgcGxhdGZvcm0uIFRvIGVuYWJs
ZSB0aGlzLA0KY3JlYXRlIG1hY3JvcyB0byBkZWZpbmUgdGhlIHNob3csIHN0b3JlIHJvdXRpbmVz
IGFuZCBjcmVhdGUgc3lzZnMgZW50cmllcw0Kd2l0aCBSL1cgcGVybWlzc2lvbi4NCg0KU2lnbmVk
LW9mZi1ieTogWWF6ZW4gR2hhbm5hbSA8WWF6ZW4uR2hhbm5hbUBhbWQuY29tPg0KWyBjYXJ2ZWQg
aW50byBhIHBhdGNoLCBjbGVhbmVkIHVwLCBwcm9kdWN0aXplZCBdDQpTaWduZWQtb2ZmLWJ5OiBK
YW5ha2FyYWphbiBOYXRhcmFqYW4gPEphbmFrYXJhamFuLk5hdGFyYWphbkBhbWQuY29tPg0KLS0t
DQogZHJpdmVycy9hY3BpL2NwcGNfYWNwaS5jIHwgMzEgKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKw0KIDEgZmlsZSBjaGFuZ2VkLCAzMSBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQg
YS9kcml2ZXJzL2FjcGkvY3BwY19hY3BpLmMgYi9kcml2ZXJzL2FjcGkvY3BwY19hY3BpLmMNCmlu
ZGV4IDFjY2UyMzFiODUwMS4uMWU4NjI0MTVmYWYwIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9hY3Bp
L2NwcGNfYWNwaS5jDQorKysgYi9kcml2ZXJzL2FjcGkvY3BwY19hY3BpLmMNCkBAIC0xNDIsNiAr
MTQyLDEwIEBAIHN0cnVjdCBjcHBjX2F0dHIgew0KIHN0YXRpYyBzdHJ1Y3QgY3BwY19hdHRyIF9u
YW1lID0JCQlcDQogX19BVFRSKF9uYW1lLCAwNDQ0LCBzaG93XyMjX25hbWUsIE5VTEwpDQogDQor
I2RlZmluZSBkZWZpbmVfb25lX2NwcGNfcncoX25hbWUpCQlcDQorc3RhdGljIHN0cnVjdCBjcHBj
X2F0dHIgX25hbWUgPQkJCVwNCitfX0FUVFIoX25hbWUsIDA2NDQsIHNob3dfIyNfbmFtZSwgc3Rv
cmVfIyNfbmFtZSkNCisNCiAjZGVmaW5lIHRvX2NwY19kZXNjKGEpIGNvbnRhaW5lcl9vZihhLCBz
dHJ1Y3QgY3BjX2Rlc2MsIGtvYmopDQogDQogI2RlZmluZSBzaG93X2NwcGNfZGF0YShhY2Nlc3Nf
Zm4sIHN0cnVjdF9uYW1lLCBtZW1iZXJfbmFtZSkJCVwNCkBAIC0xNjQsNiArMTY4LDMzIEBAIF9f
QVRUUihfbmFtZSwgMDQ0NCwgc2hvd18jI19uYW1lLCBOVUxMKQ0KIAlzaG93X2NwcGNfZGF0YShh
Y2Nlc3NfZm4sIHN0cnVjdF9uYW1lLCBtZW1iZXJfbmFtZSkJCVwNCiAJZGVmaW5lX29uZV9jcHBj
X3JvKG1lbWJlcl9uYW1lKQ0KIA0KKyNkZWZpbmUgc3RvcmVfY3BwY19kYXRhKHN0cnVjdF9uYW1l
LCBtZW1iZXJfbmFtZSwgcmVnX2lkeCkJCVwNCisJc3RhdGljIHNzaXplX3Qgc3RvcmVfIyNtZW1i
ZXJfbmFtZShzdHJ1Y3Qga29iamVjdCAqa29iaiwJXA0KKwkJCQkJICAgc3RydWN0IGF0dHJpYnV0
ZSAqYXR0ciwJXA0KKwkJCQkJICAgY29uc3QgY2hhciAqYywgc3NpemVfdCBjb3VudClcDQorCXsJ
CQkJCQkJCVwNCisJCXN0cnVjdCBjcGNfZGVzYyAqY3BjX3B0ciA9IHRvX2NwY19kZXNjKGtvYmop
OwkJXA0KKwkJc3RydWN0IHN0cnVjdF9uYW1lIHN0X25hbWUgPSB7MH07CQkJXA0KKwkJdTMyIHZh
bDsJCQkJCQlcDQorCQlpbnQgcmV0OwkJCQkJCVwNCisJCQkJCQkJCQlcDQorCQlyZXQgPSBrc3Ry
dG91MzIoYywgMCwgJnZhbCk7CQkJCVwNCisJCWlmIChyZXQpCQkJCQkJXA0KKwkJCXJldHVybiBy
ZXQ7CQkJCQlcDQorCQkJCQkJCQkJXA0KKwkJc3RfbmFtZS5tZW1iZXJfbmFtZSA9IHZhbDsJCQkJ
XA0KKwkJCQkJCQkJCVwNCisJCXJldCA9IGNwcGNfc2V0X3JlZyhjcGNfcHRyLT5jcHVfaWQsICZz
dF9uYW1lLCByZWdfaWR4KTsJXA0KKwkJaWYgKHJldCkJCQkJCQlcDQorCQkJcmV0dXJuIHJldDsJ
CQkJCVwNCisJCQkJCQkJCQlcDQorCQlyZXR1cm4gY291bnQ7CQkJCQkJXA0KKwl9CQkJCQkJCQlc
DQorDQorI2RlZmluZSBzdG9yZV9jcHBjX2RhdGFfcncoc3RydWN0X25hbWUsIG1lbWJlcl9uYW1l
LCByZWdfaWR4KQkJXA0KKwlzdG9yZV9jcHBjX2RhdGEoc3RydWN0X25hbWUsIG1lbWJlcl9uYW1l
LCByZWdfaWR4KQkJXA0KKwlkZWZpbmVfb25lX2NwcGNfcncobWVtYmVyX25hbWUpDQorDQogc2hv
d19jcHBjX2RhdGFfcm8oY3BwY19nZXRfcGVyZl9jYXBzLCBjcHBjX3BlcmZfY2FwcywgaGlnaGVz
dF9wZXJmKTsNCiBzaG93X2NwcGNfZGF0YV9ybyhjcHBjX2dldF9wZXJmX2NhcHMsIGNwcGNfcGVy
Zl9jYXBzLCBsb3dlc3RfcGVyZik7DQogc2hvd19jcHBjX2RhdGFfcm8oY3BwY19nZXRfcGVyZl9j
YXBzLCBjcHBjX3BlcmZfY2Fwcywgbm9taW5hbF9wZXJmKTsNCi0tIA0KMi4xNy4xDQoNCg==
