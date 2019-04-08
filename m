Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0061DC10F14
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 14:12:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFE5C21874
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 14:12:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="GukP1ktL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbfDHOM1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 10:12:27 -0400
Received: from mail-eopbgr800047.outbound.protection.outlook.com ([40.107.80.47]:7348
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726756AbfDHOM0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 10:12:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ZQCCeEyNFhALcxdlg73b0Wyr3YcQDRnF69KCX8ehyM=;
 b=GukP1ktLltWwvOsvwAgJQRREihSo7NFbFP6r953m942ROKKZgOt3pGDxq2XNtroSnxxCXDYGThvmFFUzjOp9l3/fQNIFAfoC+Z9HE8PqXeO0CfYna6WgoIUb+8KK2tEQyaggEJ9+tWcIupgHKl7EVedXK5LhhE8/8M9No1Qk8zM=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2685.namprd12.prod.outlook.com (52.135.103.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.21; Mon, 8 Apr 2019 14:12:19 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::9c51:41bf:f88e:f3e8]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::9c51:41bf:f88e:f3e8%2]) with mapi id 15.20.1771.016; Mon, 8 Apr 2019
 14:12:19 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
CC:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@suse.de" <bp@suse.de>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: [PATCH RESEND 5/5] x86/MCE: Save MCA control bits that get set in
 hardware
Thread-Topic: [PATCH RESEND 5/5] x86/MCE: Save MCA control bits that get set
 in hardware
Thread-Index: AQHU7hUTUjCHzFTL7kGlEkQbALcxYg==
Date:   Mon, 8 Apr 2019 14:12:18 +0000
Message-ID: <20190408141205.12376-6-Yazen.Ghannam@amd.com>
References: <20190408141205.12376-1-Yazen.Ghannam@amd.com>
In-Reply-To: <20190408141205.12376-1-Yazen.Ghannam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN2PR01CA0025.prod.exchangelabs.com (2603:10b6:804:2::35)
 To SN6PR12MB2639.namprd12.prod.outlook.com (2603:10b6:805:6f::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d591b479-aaf4-44e6-a77e-08d6bc2c3592
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:SN6PR12MB2685;
x-ms-traffictypediagnostic: SN6PR12MB2685:
x-microsoft-antispam-prvs: <SN6PR12MB268598F01ADD3830B9D397FCF82C0@SN6PR12MB2685.namprd12.prod.outlook.com>
x-forefront-prvs: 0001227049
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(39860400002)(366004)(396003)(376002)(189003)(199004)(186003)(2906002)(6116002)(11346002)(26005)(3846002)(6916009)(66066001)(446003)(99286004)(2616005)(476003)(6506007)(2501003)(105586002)(102836004)(54906003)(52116002)(386003)(2351001)(25786009)(97736004)(106356001)(316002)(76176011)(36756003)(486006)(7736002)(4326008)(8936002)(8676002)(50226002)(81166006)(81156014)(14454004)(305945005)(68736007)(256004)(1076003)(5660300002)(6512007)(86362001)(6486002)(5640700003)(6436002)(72206003)(53936002)(478600001)(71200400001)(71190400001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2685;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: nAmfiUjiRUoH5eu8Ad4fa6kFx0HWcJxESPw2MThLDTAgm0nJfTOgB3tlzYbpY+f7sH591dQm7TiqXFL4aKQ8YRPvyiKKaB7Khbpa9hzdu3dhChIekvsfpuu3yzPt4pFu6dir3hEIwa8oDtWmOVBZ9W8rgN3n7UHZvBkVQJFpysb1XizJq85YdaTe/yH0/31UtUzQusAsNvNvWvumM91Oj7+pceZvoxRM6MXW0g0587j1ESjvYxIWNP68vupPgydGFdwWrCm9/vkw74d8NUn2Skk3/cg9YHv7aPi3RpJ3FqZmNSKC38Ljio6+dL5lrrKFhLNj8hDMBluHB+mhg83h+q9B9sFbiCrkZvxtdSviHnE5Bp14txsog0HctJien+013aowrRr6ZqOyv11QURRXGYSOWokIRMONF6Dy/FvU83E=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d591b479-aaf4-44e6-a77e-08d6bc2c3592
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2019 14:12:18.8774
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2685
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogWWF6ZW4gR2hhbm5hbSA8eWF6ZW4uZ2hhbm5hbUBhbWQuY29tPg0KDQpUaGUgT1MgaXMg
ZXhwZWN0ZWQgdG8gd3JpdGUgYWxsIGJpdHMgaW4gTUNBX0NUTC4gSG93ZXZlciwgb25seQ0KaW1w
bGVtZW50ZWQgYml0cyBnZXQgc2V0IGluIHRoZSBoYXJkd2FyZS4NCg0KUmVhZCBiYWNrIE1DQV9D
VEwgc28gdGhhdCB0aGUgdmFsdWUgaW4gdGhlIGhhcmR3YXJlIGlzIHNhdmVkIGFuZA0KcmVwb3J0
ZWQgdGhyb3VnaCBzeXNmcy4NCg0KU2lnbmVkLW9mZi1ieTogWWF6ZW4gR2hhbm5hbSA8eWF6ZW4u
Z2hhbm5hbUBhbWQuY29tPg0KLS0tDQogYXJjaC94ODYva2VybmVsL2NwdS9tY2UvY29yZS5jIHwg
MTUgKysrKysrKysrKy0tLS0tDQogMSBmaWxlIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKyksIDUg
ZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rZXJuZWwvY3B1L21jZS9jb3Jl
LmMgYi9hcmNoL3g4Ni9rZXJuZWwvY3B1L21jZS9jb3JlLmMNCmluZGV4IDRhMDY2YzFlOGFiMi4u
ZWQ1Mzc0YWIzYWMzIDEwMDY0NA0KLS0tIGEvYXJjaC94ODYva2VybmVsL2NwdS9tY2UvY29yZS5j
DQorKysgYi9hcmNoL3g4Ni9rZXJuZWwvY3B1L21jZS9jb3JlLmMNCkBAIC0xNTY2LDEwICsxNTY2
LDEzIEBAIHN0YXRpYyB2b2lkIF9fbWNoZWNrX2NwdV9pbml0X2NsZWFyX2JhbmtzKHZvaWQpDQog
CWZvciAoaSA9IDA7IGkgPCB0aGlzX2NwdV9yZWFkKG51bV9iYW5rcyk7IGkrKykgew0KIAkJc3Ry
dWN0IG1jZV9iYW5rICpiID0gJnRoaXNfY3B1X3JlYWQobWNlX2JhbmtzKVtpXTsNCiANCi0JCWlm
ICghYi0+aW5pdCkNCi0JCQljb250aW51ZTsNCi0JCXdybXNybChtc3Jfb3BzLmN0bChpKSwgYi0+
Y3RsKTsNCi0JCXdybXNybChtc3Jfb3BzLnN0YXR1cyhpKSwgMCk7DQorCQlpZiAoYi0+aW5pdCkg
ew0KKwkJCXdybXNybChtc3Jfb3BzLmN0bChpKSwgYi0+Y3RsKTsNCisJCQl3cm1zcmwobXNyX29w
cy5zdGF0dXMoaSksIDApOw0KKwkJfQ0KKw0KKwkJLyogU2F2ZSBiaXRzIHNldCBpbiBoYXJkd2Fy
ZS4gKi8NCisJCXJkbXNybChtc3Jfb3BzLmN0bChpKSwgYi0+Y3RsKTsNCiAJfQ0KIH0NCiANCkBA
IC0yMzEzLDggKzIzMTYsMTAgQEAgc3RhdGljIHZvaWQgbWNlX3JlZW5hYmxlX2NwdSh2b2lkKQ0K
IAlmb3IgKGkgPSAwOyBpIDwgdGhpc19jcHVfcmVhZChudW1fYmFua3MpOyBpKyspIHsNCiAJCXN0
cnVjdCBtY2VfYmFuayAqYiA9ICZ0aGlzX2NwdV9yZWFkKG1jZV9iYW5rcylbaV07DQogDQotCQlp
ZiAoYi0+aW5pdCkNCisJCWlmIChiLT5pbml0KSB7DQogCQkJd3Jtc3JsKG1zcl9vcHMuY3RsKGkp
LCBiLT5jdGwpOw0KKwkJCXJkbXNybChtc3Jfb3BzLmN0bChpKSwgYi0+Y3RsKTsNCisJCX0NCiAJ
fQ0KIH0NCiANCi0tIA0KMi4xNy4xDQoNCg==
