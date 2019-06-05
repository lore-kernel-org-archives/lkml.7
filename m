Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 056BAC28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 14:41:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C551E20693
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 14:41:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="QpkP70V0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728477AbfFEOlx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 10:41:53 -0400
Received: from mail-eopbgr30117.outbound.protection.outlook.com ([40.107.3.117]:58497
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726442AbfFEOlr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 10:41:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rh9AJa/373eD+GS1BgxhOB8N4yh0gHDtlCXIBfkv7wU=;
 b=QpkP70V0jxQq95/ujwVb908ioPHTHuhTdHOiETswIAAWQeC4zZ+WohdK9WTZtTS5UZeYPetAbPD36AxF5jUUQ+9o1FKtDzvi86HJF/6NhlrPiekMCV827vawBqqKmsIxab1kL0qig3PUUivKAGwNrQAt6pNjLDMIvq0UxeT49mQ=
Received: from VI1PR07MB3165.eurprd07.prod.outlook.com (10.175.243.15) by
 VI1PR07MB6032.eurprd07.prod.outlook.com (20.178.124.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.10; Wed, 5 Jun 2019 14:41:44 +0000
Received: from VI1PR07MB3165.eurprd07.prod.outlook.com
 ([fe80::1403:5377:c11d:a41a]) by VI1PR07MB3165.eurprd07.prod.outlook.com
 ([fe80::1403:5377:c11d:a41a%7]) with mapi id 15.20.1965.011; Wed, 5 Jun 2019
 14:41:44 +0000
From:   "Sverdlin, Alexander (Nokia - DE/Ulm)" <alexander.sverdlin@nokia.com>
To:     "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Sverdlin, Alexander (Nokia - DE/Ulm)" <alexander.sverdlin@nokia.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Vas Dias <jason.vas.dias@gmail.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v3 1/2] x86/vdso: Move mult and shift into struct vgtod_ts
Thread-Topic: [PATCH v3 1/2] x86/vdso: Move mult and shift into struct
 vgtod_ts
Thread-Index: AQHVG6zLWVr+SmJGqUG78zQ8oYIU5w==
Date:   Wed, 5 Jun 2019 14:41:44 +0000
Message-ID: <20190605144116.28553-2-alexander.sverdlin@nokia.com>
References: <20190605144116.28553-1-alexander.sverdlin@nokia.com>
In-Reply-To: <20190605144116.28553-1-alexander.sverdlin@nokia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [131.228.32.181]
x-mailer: git-send-email 2.21.0
x-clientproxiedby: HE1PR06CA0156.eurprd06.prod.outlook.com
 (2603:10a6:7:16::43) To VI1PR07MB3165.eurprd07.prod.outlook.com
 (2603:10a6:802:21::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=alexander.sverdlin@nokia.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 42fa2f2f-299f-4041-5e7c-08d6e9c3edfb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR07MB6032;
x-ms-traffictypediagnostic: VI1PR07MB6032:
x-microsoft-antispam-prvs: <VI1PR07MB6032474A9A1BB54E6410166E88160@VI1PR07MB6032.eurprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 00594E8DBA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(39860400002)(366004)(346002)(136003)(199004)(189003)(486006)(256004)(11346002)(476003)(2616005)(14444005)(53936002)(66556008)(64756008)(25786009)(54906003)(36756003)(50226002)(71200400001)(26005)(446003)(6512007)(4326008)(186003)(8936002)(6486002)(66066001)(508600001)(6436002)(8676002)(1076003)(81156014)(316002)(86362001)(2906002)(2501003)(5660300002)(71190400001)(110136005)(66476007)(66446008)(52116002)(76176011)(3846002)(6506007)(102836004)(68736007)(7736002)(305945005)(66946007)(14454004)(99286004)(73956011)(81166006)(6116002)(386003);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR07MB6032;H:VI1PR07MB3165.eurprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nokia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: FdvoO7eRDgH11tVz/9hT0MuneEh73/ofPRc+NUwpX6XIyh0IboxRs98a6l3S1jriH6ZylzlZ6fFXy7h7cTbywjn7/BeEsC8lU3SsKHDaDpLU2VSwuvwznNEYZn4x/nha/6i9Sy4h43fZpQqPB+m1Oi1Cs5QptDD3E98Hlmo+j8luh8X0Ck7v/qcg8Nk04+AdVTLEkDM9i3EusA9WGhaLs8b/dJ3tjGaLeVsdZVpThnAy0DtXQ7qtVoksS4ppLjO4A48q8N7kSX1cmhChWfJQXUQ/VE66N6pVBypggr4rwT+Omkof0EAtdks1fnODOJWjNCClFOrEh5FwMkS0YACh9vwR+1BEs9UkoHHaH9Zj05+CCKeH8MPn0jNq58kGrvUN3Jm8vsANnekJylw63tfv6yNKSUUvs2KXfM1YMB+GlM0=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42fa2f2f-299f-4041-5e7c-08d6e9c3edfb
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2019 14:41:44.1841
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: alexander.sverdlin@nokia.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB6032
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogQWxleGFuZGVyIFN2ZXJkbGluIDxhbGV4YW5kZXIuc3ZlcmRsaW5Abm9raWEuY29tPg0K
DQpUaGlzIGlzIGEgcHJlcGFyYXRpb24gZm9yIENMT0NLX01PTk9UT05JQ19SQVcgdkRTTyBpbXBs
ZW1lbnRhdGlvbi4NCkNvaW5jaWRlbnRhbGx5IGl0IGhhZCBhIHNsaWdodCBwZXJmb3JtYW5jZSBp
bXByb3ZlbWVudCBhcyB3ZWxsOg0KDQotLS0tIFRlc3QgY29kZSAtLS0tDQogI2luY2x1ZGUgPGVy
cm5vLmg+DQogI2luY2x1ZGUgPHN0ZGlvLmg+DQogI2luY2x1ZGUgPHN0ZGxpYi5oPg0KICNpbmNs
dWRlIDx0aW1lLmg+DQogI2luY2x1ZGUgPHVuaXN0ZC5oPg0KDQogI2RlZmluZSBDTE9DS19UWVBF
IENMT0NLX01PTk9UT05JQ19SQVcNCiAjZGVmaW5lIERVUkFUSU9OX1NFQyAxMA0KDQppbnQgbWFp
bihpbnQgYXJnYywgY2hhciAqKmFyZ3YpDQp7DQoJc3RydWN0IHRpbWVzcGVjIHQsIGVuZDsNCgl1
bnNpZ25lZCBsb25nIGxvbmcgY250ID0gMDsNCg0KCWNsb2NrX2dldHRpbWUoQ0xPQ0tfVFlQRSwg
JmVuZCk7DQoJZW5kLnR2X3NlYyArPSBEVVJBVElPTl9TRUM7DQoNCglkbyB7DQoJCWNsb2NrX2dl
dHRpbWUoQ0xPQ0tfVFlQRSwgJnQpOw0KCQkrK2NudDsNCgl9IHdoaWxlICh0LnR2X3NlYyA8IGVu
ZC50dl9zZWMgfHwgdC50dl9uc2VjIDwgZW5kLnR2X25zZWMpOw0KDQoJZHByaW50ZihTVERPVVRf
RklMRU5PLCAiJWxsdSIsIGNudCk7DQoNCglyZXR1cm4gRVhJVF9TVUNDRVNTOw0KfQ0KLS0tLS0t
LS0tLS0tLS0tLS0tLQ0KDQpUaGUgcmVzdWx0cyBmcm9tIHRoZSBhYm92ZSB0ZXN0IHByb2dyYW06
DQoNCkNsb2NrICAgICAgICAgICAgICAgICAgIEJlZm9yZSAgQWZ0ZXIgICBEaWZmDQotLS0tLSAg
ICAgICAgICAgICAgICAgICAtLS0tLS0gIC0tLS0tICAgLS0tLQ0KQ0xPQ0tfTU9OT1RPTklDICAg
ICAgICAgMzU1LjVNICAzNTkuNk0gICsxJQ0KQ0xPQ0tfUkVBTFRJTUUgICAgICAgICAgMzU1LjVN
ICAzNTkuNk0gICsxJQ0KDQpDYzogVGhvbWFzIEdsZWl4bmVyIDx0Z2x4QGxpbnV0cm9uaXguZGU+
DQpDYzogSmFzb24gVmFzIERpYXMgPGphc29uLnZhcy5kaWFzQGdtYWlsLmNvbT4NClN1Z2dlc3Rl
ZC1ieTogQW5keSBMdXRvbWlyc2tpIDxsdXRvQGtlcm5lbC5vcmc+DQpTaWduZWQtb2ZmLWJ5OiBB
bGV4YW5kZXIgU3ZlcmRsaW4gPGFsZXhhbmRlci5zdmVyZGxpbkBub2tpYS5jb20+DQotLS0NCiBh
cmNoL3g4Ni9lbnRyeS92ZHNvL3ZjbG9ja19nZXR0aW1lLmMgICAgfCA0ICsrLS0NCiBhcmNoL3g4
Ni9lbnRyeS92c3lzY2FsbC92c3lzY2FsbF9ndG9kLmMgfCA4ICsrKysrKy0tDQogYXJjaC94ODYv
aW5jbHVkZS9hc20vdmd0b2QuaCAgICAgICAgICAgIHwgNCArKy0tDQogMyBmaWxlcyBjaGFuZ2Vk
LCAxMCBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvYXJjaC94
ODYvZW50cnkvdmRzby92Y2xvY2tfZ2V0dGltZS5jIGIvYXJjaC94ODYvZW50cnkvdmRzby92Y2xv
Y2tfZ2V0dGltZS5jDQppbmRleCAwZjgyYTcwLi5hOTllYWY1IDEwMDY0NA0KLS0tIGEvYXJjaC94
ODYvZW50cnkvdmRzby92Y2xvY2tfZ2V0dGltZS5jDQorKysgYi9hcmNoL3g4Ni9lbnRyeS92ZHNv
L3ZjbG9ja19nZXR0aW1lLmMNCkBAIC0xNTMsOCArMTUzLDggQEAgbm90cmFjZSBzdGF0aWMgaW50
IGRvX2hyZXMoY2xvY2tpZF90IGNsaywgc3RydWN0IHRpbWVzcGVjICp0cykNCiAJCWlmICh1bmxp
a2VseSgoczY0KWN5Y2xlcyA8IDApKQ0KIAkJCXJldHVybiB2ZHNvX2ZhbGxiYWNrX2dldHRpbWUo
Y2xrLCB0cyk7DQogCQlpZiAoY3ljbGVzID4gbGFzdCkNCi0JCQlucyArPSAoY3ljbGVzIC0gbGFz
dCkgKiBndG9kLT5tdWx0Ow0KLQkJbnMgPj49IGd0b2QtPnNoaWZ0Ow0KKwkJCW5zICs9IChjeWNs
ZXMgLSBsYXN0KSAqIGJhc2UtPm11bHQ7DQorCQlucyA+Pj0gYmFzZS0+c2hpZnQ7DQogCQlzZWMg
PSBiYXNlLT5zZWM7DQogCX0gd2hpbGUgKHVubGlrZWx5KGd0b2RfcmVhZF9yZXRyeShndG9kLCBz
ZXEpKSk7DQogDQpkaWZmIC0tZ2l0IGEvYXJjaC94ODYvZW50cnkvdnN5c2NhbGwvdnN5c2NhbGxf
Z3RvZC5jIGIvYXJjaC94ODYvZW50cnkvdnN5c2NhbGwvdnN5c2NhbGxfZ3RvZC5jDQppbmRleCBj
ZmNkYmEwLi42NGIxZTdjIDEwMDY0NA0KLS0tIGEvYXJjaC94ODYvZW50cnkvdnN5c2NhbGwvdnN5
c2NhbGxfZ3RvZC5jDQorKysgYi9hcmNoL3g4Ni9lbnRyeS92c3lzY2FsbC92c3lzY2FsbF9ndG9k
LmMNCkBAIC00NCwxNiArNDQsMTggQEAgdm9pZCB1cGRhdGVfdnN5c2NhbGwoc3RydWN0IHRpbWVr
ZWVwZXIgKnRrKQ0KIAl2ZGF0YS0+dmNsb2NrX21vZGUJPSB2Y2xvY2tfbW9kZTsNCiAJdmRhdGEt
PmN5Y2xlX2xhc3QJPSB0ay0+dGtyX21vbm8uY3ljbGVfbGFzdDsNCiAJdmRhdGEtPm1hc2sJCT0g
dGstPnRrcl9tb25vLm1hc2s7DQotCXZkYXRhLT5tdWx0CQk9IHRrLT50a3JfbW9uby5tdWx0Ow0K
LQl2ZGF0YS0+c2hpZnQJCT0gdGstPnRrcl9tb25vLnNoaWZ0Ow0KIA0KIAliYXNlID0gJnZkYXRh
LT5iYXNldGltZVtDTE9DS19SRUFMVElNRV07DQogCWJhc2UtPnNlYyA9IHRrLT54dGltZV9zZWM7
DQogCWJhc2UtPm5zZWMgPSB0ay0+dGtyX21vbm8ueHRpbWVfbnNlYzsNCisJYmFzZS0+bXVsdCA9
IHRrLT50a3JfbW9uby5tdWx0Ow0KKwliYXNlLT5zaGlmdCA9IHRrLT50a3JfbW9uby5zaGlmdDsN
CiANCiAJYmFzZSA9ICZ2ZGF0YS0+YmFzZXRpbWVbQ0xPQ0tfVEFJXTsNCiAJYmFzZS0+c2VjID0g
dGstPnh0aW1lX3NlYyArIChzNjQpdGstPnRhaV9vZmZzZXQ7DQogCWJhc2UtPm5zZWMgPSB0ay0+
dGtyX21vbm8ueHRpbWVfbnNlYzsNCisJYmFzZS0+bXVsdCA9IHRrLT50a3JfbW9uby5tdWx0Ow0K
KwliYXNlLT5zaGlmdCA9IHRrLT50a3JfbW9uby5zaGlmdDsNCiANCiAJYmFzZSA9ICZ2ZGF0YS0+
YmFzZXRpbWVbQ0xPQ0tfTU9OT1RPTklDXTsNCiAJYmFzZS0+c2VjID0gdGstPnh0aW1lX3NlYyAr
IHRrLT53YWxsX3RvX21vbm90b25pYy50dl9zZWM7DQpAQCAtNjQsNiArNjYsOCBAQCB2b2lkIHVw
ZGF0ZV92c3lzY2FsbChzdHJ1Y3QgdGltZWtlZXBlciAqdGspDQogCQliYXNlLT5zZWMrKzsNCiAJ
fQ0KIAliYXNlLT5uc2VjID0gbnNlYzsNCisJYmFzZS0+bXVsdCA9IHRrLT50a3JfbW9uby5tdWx0
Ow0KKwliYXNlLT5zaGlmdCA9IHRrLT50a3JfbW9uby5zaGlmdDsNCiANCiAJYmFzZSA9ICZ2ZGF0
YS0+YmFzZXRpbWVbQ0xPQ0tfUkVBTFRJTUVfQ09BUlNFXTsNCiAJYmFzZS0+c2VjID0gdGstPnh0
aW1lX3NlYzsNCmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS92Z3RvZC5oIGIvYXJj
aC94ODYvaW5jbHVkZS9hc20vdmd0b2QuaA0KaW5kZXggOTEzYTEzMy4uYjFmNmRmMyAxMDA2NDQN
Ci0tLSBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL3ZndG9kLmgNCisrKyBiL2FyY2gveDg2L2luY2x1
ZGUvYXNtL3ZndG9kLmgNCkBAIC0yNSw2ICsyNSw4IEBAIHR5cGVkZWYgdW5zaWduZWQgbG9uZyBn
dG9kX2xvbmdfdDsNCiBzdHJ1Y3Qgdmd0b2RfdHMgew0KIAl1NjQJCXNlYzsNCiAJdTY0CQluc2Vj
Ow0KKwl1MzIJCW11bHQ7DQorCXUzMgkJc2hpZnQ7DQogfTsNCiANCiAjZGVmaW5lIFZHVE9EX0JB
U0VTCShDTE9DS19UQUkgKyAxKQ0KQEAgLTQxLDggKzQzLDYgQEAgc3RydWN0IHZzeXNjYWxsX2d0
b2RfZGF0YSB7DQogCWludAkJdmNsb2NrX21vZGU7DQogCXU2NAkJY3ljbGVfbGFzdDsNCiAJdTY0
CQltYXNrOw0KLQl1MzIJCW11bHQ7DQotCXUzMgkJc2hpZnQ7DQogDQogCXN0cnVjdCB2Z3RvZF90
cwliYXNldGltZVtWR1RPRF9CQVNFU107DQogDQotLSANCjIuNC42DQoNCg==
