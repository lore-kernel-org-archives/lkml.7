Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94233C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 21:26:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C18921738
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 21:26:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="iW2OaNWi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730997AbfDDV0Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 17:26:24 -0400
Received: from mail-eopbgr760073.outbound.protection.outlook.com ([40.107.76.73]:65094
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730206AbfDDV0W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 17:26:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ky/BSv/j6ICMo+UtYOQOIwZ91Y+pcvJ9i0cuA9noUsw=;
 b=iW2OaNWiMRqVLKQWwGYd8B0aCx1jw4lKYF42pNTy+dNbXmp9jVKxSQdl7oIk99CVQj/L5PyN/aqwrCxiuXRNSG2tp1Fe4ducG7xH2nrctLkUTqlbJQyR9/qh487TslQMdlAwau9KDSqaXJT8DgqpfLWkfex7TeaPVnlIHHhwdAk=
Received: from SN6PR12MB2736.namprd12.prod.outlook.com (52.135.107.27) by
 SN6PR12MB2784.namprd12.prod.outlook.com (52.135.107.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.22; Thu, 4 Apr 2019 21:25:57 +0000
Received: from SN6PR12MB2736.namprd12.prod.outlook.com
 ([fe80::65cb:af55:6bd4:55a]) by SN6PR12MB2736.namprd12.prod.outlook.com
 ([fe80::65cb:af55:6bd4:55a%4]) with mapi id 15.20.1750.017; Thu, 4 Apr 2019
 21:25:57 +0000
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
Subject: [PATCH v2 7/7] acpi/cppc: Add support for CPPC Enable register
Thread-Topic: [PATCH v2 7/7] acpi/cppc: Add support for CPPC Enable register
Thread-Index: AQHU6yz+DxZ5qtCYS0KW8MgU0wIz4g==
Date:   Thu, 4 Apr 2019 21:25:57 +0000
Message-ID: <22e1dec2fc26026647dc0f367b2e79599e062399.1554410643.git.Janakarajan.Natarajan@amd.com>
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
x-ms-office365-filtering-correlation-id: 1e6e04ae-13db-469b-6782-08d6b9442046
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:SN6PR12MB2784;
x-ms-traffictypediagnostic: SN6PR12MB2784:
x-microsoft-antispam-prvs: <SN6PR12MB2784B4F93638529DA3843C3EE7500@SN6PR12MB2784.namprd12.prod.outlook.com>
x-forefront-prvs: 0997523C40
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(366004)(396003)(136003)(376002)(199004)(189003)(97736004)(6436002)(478600001)(71200400001)(118296001)(7736002)(71190400001)(36756003)(14444005)(256004)(72206003)(4326008)(2201001)(86362001)(486006)(68736007)(14454004)(6486002)(66066001)(316002)(8676002)(2501003)(102836004)(52116002)(2906002)(110136005)(26005)(99286004)(6506007)(54906003)(76176011)(2616005)(186003)(81156014)(5660300002)(81166006)(305945005)(50226002)(8936002)(6512007)(25786009)(53936002)(6116002)(446003)(106356001)(105586002)(3846002)(476003)(11346002)(386003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2784;H:SN6PR12MB2736.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: MFgc768k2mNtPBzZBFer4IvDzTO7lb7yOwjTeoqAF9Q2D+julURrtTCJ2/bsdhwdz5FunUgyM6U2kMV7WBUYzGI4Zg2+4KW5IL02wS1oXQiecUi8YhU3uJnSvIYWFIV3HQRgIoQFYj/5vZ8BUf9zZD63Yhsw69zgoETfhDh/n5FaOdUOTO8or/OH2+l/j9Fqq95uOvOyGO7VMOGz7HxvzG8Kgy9FATch7bMwQ5si47jmZ6EVF8FzLBqvZ5Tcj9/FzJ9+dVLM7BHWrIpCiSsnhMtf5dBTIl9S1ZMP83bMnvDm7jPriY/s6tNaRspw1lK3XCjd+InxE+AYeLEBZMLE5rhbf+jRPFKX/HDN9cTfTE/G4Cl77Nn6xDl9XrLumJGlITfL16Z0vUq2sIDnpsidKmdetxHR1vr3CWV2MRYkPHc=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e6e04ae-13db-469b-6782-08d6b9442046
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2019 21:25:57.6618
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2784
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogWWF6ZW4gR2hhbm5hbSA8WWF6ZW4uR2hhbm5hbUBhbWQuY29tPg0KDQpUbyBlbmFibGUg
Q1BQQyBvbiBhIHByb2Nlc3NvciwgdGhlIE9TIHNob3VsZCB3cml0ZSBhIHZhbHVlICIxIiB0byB0
aGUNCkNQUEMgRW5hYmxlIHJlZ2lzdGVyLiBBZGQgc3VwcG9ydCBmb3IgdGhpcyByZWdpc3Rlci4N
Cg0KU2lnbmVkLW9mZi1ieTogWWF6ZW4gR2hhbm5hbSA8WWF6ZW4uR2hhbm5hbUBhbWQuY29tPg0K
WyBjYXJ2ZWQgb3V0IGludG8gYSBwYXRjaCwgY2xlYW5lZCB1cCwgcHJvZHVjdGl6ZWQgXQ0KU2ln
bmVkLW9mZi1ieTogSmFuYWthcmFqYW4gTmF0YXJhamFuIDxKYW5ha2FyYWphbi5OYXRhcmFqYW5A
YW1kLmNvbT4NCi0tLQ0KIGRyaXZlcnMvYWNwaS9jcHBjX2FjcGkuYyB8IDk2ICsrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCiBpbmNsdWRlL2FjcGkvY3BwY19hY3BpLmgg
fCAgMSArDQogMiBmaWxlcyBjaGFuZ2VkLCA5NyBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQg
YS9kcml2ZXJzL2FjcGkvY3BwY19hY3BpLmMgYi9kcml2ZXJzL2FjcGkvY3BwY19hY3BpLmMNCmlu
ZGV4IGJiNTdkNTI2ZTU0ZS4uYjc0YzQ4OWEzZThkIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9hY3Bp
L2NwcGNfYWNwaS5jDQorKysgYi9kcml2ZXJzL2FjcGkvY3BwY19hY3BpLmMNCkBAIC0yMzIsNiAr
MjMyLDQzIEBAIHN0YXRpYyBzc2l6ZV90IHNob3dfZmVlZGJhY2tfY3RycyhzdHJ1Y3Qga29iamVj
dCAqa29iaiwNCiB9DQogZGVmaW5lX29uZV9jcHBjX3JvKGZlZWRiYWNrX2N0cnMpOw0KIA0KKy8q
IFVzZWQgdG8gbW92ZSBFTkFCTEUgcmVnaXN0ZXIgdmFsdWUgYmV0d2VlbiB1c2Vyc3BhY2UgYW5k
IHBsYXRmb3JtICovDQorc3RhdGljIGJvb2wgY3BwY19jcHVfZW5hYmxlOw0KKw0KK3N0YXRpYyBz
c2l6ZV90IHNob3dfZW5hYmxlKHN0cnVjdCBrb2JqZWN0ICprb2JqLA0KKwkJCSAgIHN0cnVjdCBh
dHRyaWJ1dGUgKmF0dHIsDQorCQkJICAgY2hhciAqYnVmKQ0KK3sNCisJc3RydWN0IGNwY19kZXNj
ICpjcGNfcHRyID0gdG9fY3BjX2Rlc2Moa29iaik7DQorCWludCByZXQ7DQorDQorCXJldCA9IGNw
cGNfZ2V0X2VuYWJsZShjcGNfcHRyLT5jcHVfaWQpOw0KKwlpZiAocmV0KQ0KKwkJcmV0dXJuIHJl
dDsNCisNCisJcmV0dXJuIHNjbnByaW50ZihidWYsIFBBR0VfU0laRSwgIiVkXG4iLCBjcHBjX2Nw
dV9lbmFibGUpOw0KK30NCisNCitzdGF0aWMgc3NpemVfdCBzdG9yZV9lbmFibGUoc3RydWN0IGtv
YmplY3QgKmtvYmosDQorCQkJICAgIHN0cnVjdCBhdHRyaWJ1dGUgKmF0dHIsDQorCQkJICAgIGNv
bnN0IGNoYXIgKmMsIHNzaXplX3QgY291bnQpDQorew0KKwlzdHJ1Y3QgY3BjX2Rlc2MgKmNwY19w
dHIgPSB0b19jcGNfZGVzYyhrb2JqKTsNCisJaW50IHJldDsNCisNCisJcmV0ID0ga3N0cnRvYm9v
bChjLCAmY3BwY19jcHVfZW5hYmxlKTsNCisJaWYgKHJldCkNCisJCXJldHVybiByZXQ7DQorDQor
CXJldCA9IGNwcGNfc2V0X3JlZyhjcGNfcHRyLT5jcHVfaWQsIE5VTEwsIEVOQUJMRSk7DQorCWlm
IChyZXQpDQorCQlyZXR1cm4gcmV0Ow0KKw0KKwlyZXR1cm4gY291bnQ7DQorfQ0KKw0KK2RlZmlu
ZV9vbmVfY3BwY19ydyhlbmFibGUpOw0KKw0KIHN0YXRpYyBzdHJ1Y3Qga29ial90eXBlIGNwcGNf
a3R5cGUgPSB7DQogCS5zeXNmc19vcHMgPSAma29ial9zeXNmc19vcHMsDQogfTsNCkBAIC04MjYs
NiArODYzLDkgQEAgc3RhdGljIGludCBzZXRfY3BwY19hdHRycyhzdHJ1Y3QgY3BjX2Rlc2MgKmNw
YywgaW50IGVudHJpZXMpDQogCQljYXNlIERFU0lSRURfUEVSRjoNCiAJCQljcHBjX2F0dHJzW2F0
dHJfaSsrXSA9ICZkZXNpcmVkX3BlcmYuYXR0cjsNCiAJCQlicmVhazsNCisJCWNhc2UgRU5BQkxF
Og0KKwkJCWNwcGNfYXR0cnNbYXR0cl9pKytdID0gJmVuYWJsZS5hdHRyOw0KKwkJCWJyZWFrOw0K
IAkJfQ0KIAl9DQogDQpAQCAtMTQyNiw2ICsxNDY2LDkgQEAgaW50IGNwcGNfc2V0X3JlZyhpbnQg
Y3B1LCBzdHJ1Y3QgY3BwY19wZXJmX2N0cmxzICpwZXJmX2N0cmxzLA0KIAl9DQogDQogCXN3aXRj
aCAocmVnX2lkeCkgew0KKwljYXNlIEVOQUJMRToNCisJCXZhbHVlID0gY3BwY19jcHVfZW5hYmxl
Ow0KKwkJYnJlYWs7DQogCWNhc2UgREVTSVJFRF9QRVJGOg0KIAkJdmFsdWUgPSBwZXJmX2N0cmxz
LT5kZXNpcmVkX3BlcmY7DQogCQlicmVhazsNCkBAIC0xNjE2LDYgKzE2NTksNTkgQEAgaW50IGNw
cGNfZ2V0X3BlcmYoaW50IGNwdSwgc3RydWN0IGNwcGNfcGVyZl9jdHJscyAqcGVyZl9jdHJscykN
CiB9DQogRVhQT1JUX1NZTUJPTF9HUEwoY3BwY19nZXRfcGVyZik7DQogDQorLyoqDQorICogY3Bw
Y19nZXRfZW5hYmxlIC0gUmVhZCBhIENQVXMgZW5hYmxlIHJlZ2lzdGVyLg0KKyAqIEBjcHU6IENQ
VSBmcm9tIHdoaWNoIHRvIHJlYWQgY29udHJvbCB2YWx1ZXMuDQorICoNCisgKiBSZXR1cm46IDAg
Zm9yIHN1Y2Nlc3MuDQorICovDQoraW50IGNwcGNfZ2V0X2VuYWJsZShpbnQgY3B1KQ0KK3sNCisJ
c3RydWN0IGNwY19kZXNjICpjcGNfZGVzYyA9IHBlcl9jcHUoY3BjX2Rlc2NfcHRyLCBjcHUpOw0K
KwlpbnQgcGNjX3NzX2lkID0gcGVyX2NwdShjcHVfcGNjX3N1YnNwYWNlX2lkeCwgY3B1KTsNCisJ
c3RydWN0IGNwY19yZWdpc3Rlcl9yZXNvdXJjZSAqZW5hYmxlX3JlZzsNCisJc3RydWN0IGNwcGNf
cGNjX2RhdGEgKnBjY19zc19kYXRhID0gTlVMTDsNCisJaW50IHJldCA9IDAsIHJlZ3NfaW5fcGNj
ID0gMDsNCisJdTY0IGVuYWJsZTsNCisNCisJaWYgKCFjcGNfZGVzYykgew0KKwkJcHJfZGVidWco
Ik5vIENQQyBkZXNjcmlwdG9yIGZvciBDUFU6ICVkXG4iLCBjcHUpOw0KKwkJcmV0dXJuIC1FTk9E
RVY7DQorCX0NCisNCisJZW5hYmxlX3JlZyA9ICZjcGNfZGVzYy0+Y3BjX3JlZ3NbRU5BQkxFXTsN
CisNCisJaWYgKCFDUENfU1VQX0JVRkZFUl9PTkxZKGVuYWJsZV9yZWcpKSB7DQorCQlwcl93YXJu
KCJDUEMgRU5BQkxFIHJlZ2lzdGVyIG5vdCBzdXBwb3J0ZWQuXG4iKTsNCisJCXJldHVybiAtRU5P
VFNVUFA7DQorCX0NCisNCisJaWYgKENQQ19JTl9QQ0MoZW5hYmxlX3JlZykpIHsNCisJCXBjY19z
c19kYXRhID0gcGNjX2RhdGFbcGNjX3NzX2lkXTsNCisJCWRvd25fd3JpdGUoJnBjY19zc19kYXRh
LT5wY2NfbG9jayk7DQorCQlyZWdzX2luX3BjYyA9IDE7DQorCQkvKiBSaW5nIGRvb3JiZWxsIG9u
Y2UgdG8gdXBkYXRlIFBDQyBzdWJzcGFjZSAqLw0KKwkJaWYgKHNlbmRfcGNjX2NtZChwY2Nfc3Nf
aWQsIENNRF9SRUFEKSA8IDApIHsNCisJCQlyZXQgPSAtRUlPOw0KKwkJCWdvdG8gb3V0X2VycjsN
CisJCX0NCisJfQ0KKw0KKwlpZiAoY3BjX3JlYWQoY3B1LCBlbmFibGVfcmVnLCAmZW5hYmxlKSkg
ew0KKwkJcmV0ID0gLUVGQVVMVDsNCisJCWdvdG8gb3V0X2VycjsNCisJfQ0KKw0KKwljcHBjX2Nw
dV9lbmFibGUgPSBlbmFibGU7DQorDQorb3V0X2VycjoNCisJaWYgKHJlZ3NfaW5fcGNjKQ0KKwkJ
dXBfd3JpdGUoJnBjY19zc19kYXRhLT5wY2NfbG9jayk7DQorDQorCXJldHVybiByZXQ7DQorfQ0K
K0VYUE9SVF9TWU1CT0xfR1BMKGNwcGNfZ2V0X2VuYWJsZSk7DQorDQogLyoqDQogICogY3BwY19n
ZXRfdHJhbnNpdGlvbl9sYXRlbmN5IC0gcmV0dXJucyBmcmVxdWVuY3kgdHJhbnNpdGlvbiBsYXRl
bmN5IGluIG5zDQogICoNCmRpZmYgLS1naXQgYS9pbmNsdWRlL2FjcGkvY3BwY19hY3BpLmggYi9p
bmNsdWRlL2FjcGkvY3BwY19hY3BpLmgNCmluZGV4IDZmNjUxMjM1OTMzYy4uZmNkZWRmZjhlNmJk
IDEwMDY0NA0KLS0tIGEvaW5jbHVkZS9hY3BpL2NwcGNfYWNwaS5oDQorKysgYi9pbmNsdWRlL2Fj
cGkvY3BwY19hY3BpLmgNCkBAIC0xMzksNiArMTM5LDcgQEAgc3RydWN0IGNwcGNfY3B1ZGF0YSB7
DQogCWNwdW1hc2tfdmFyX3Qgc2hhcmVkX2NwdV9tYXA7DQogfTsNCiANCitleHRlcm4gaW50IGNw
cGNfZ2V0X2VuYWJsZShpbnQgY3B1KTsNCiBleHRlcm4gaW50IGNwcGNfZ2V0X2Rlc2lyZWRfcGVy
ZihpbnQgY3B1bnVtLCB1NjQgKmRlc2lyZWRfcGVyZik7DQogZXh0ZXJuIGludCBjcHBjX2dldF9w
ZXJmX2N0cnMoaW50IGNwdSwgc3RydWN0IGNwcGNfcGVyZl9mYl9jdHJzICpwZXJmX2ZiX2N0cnMp
Ow0KIGV4dGVybiBpbnQgY3BwY19zZXRfcmVnKGludCBjcHUsIHN0cnVjdCBjcHBjX3BlcmZfY3Ry
bHMgKnBlcmZfY3RybHMsIGVudW0gY3BwY19yZWdzIHJlZ19pZHgpOw0KLS0gDQoyLjE3LjENCg0K
