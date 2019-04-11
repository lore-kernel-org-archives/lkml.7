Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59BA1C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 20:18:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18A952146F
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 20:18:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="PGHy23Te"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbfDKUSQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 16:18:16 -0400
Received: from mail-eopbgr820079.outbound.protection.outlook.com ([40.107.82.79]:50208
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726630AbfDKUSP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 16:18:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yrVERZ76ewvybc1AIFK+sHA73a/3E+B9d9huPp+oEaw=;
 b=PGHy23Tew1Si/91l5MHBvjOZJyznh0RrQT/VpTiap4vnbA3+2QvV/OGu4t9XeAiSXt1X88k05r3M56Awl5weeOi/RFwrDTzz5w2FY7FPXYLOfnvR98NOeBIgjAHPJvvkk/2F+T6SmxNixQcBM0+P9zLYlAzY/wN4NrecaRmdB3g=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2688.namprd12.prod.outlook.com (52.135.103.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.16; Thu, 11 Apr 2019 20:18:04 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::9c51:41bf:f88e:f3e8]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::9c51:41bf:f88e:f3e8%2]) with mapi id 15.20.1771.016; Thu, 11 Apr 2019
 20:18:04 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
CC:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@suse.de" <bp@suse.de>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: [PATCH v2 5/6] x86/MCE: Save MCA control bits that get set in
 hardware
Thread-Topic: [PATCH v2 5/6] x86/MCE: Save MCA control bits that get set in
 hardware
Thread-Index: AQHU8KOrfULDp9p3IECUcyj9sZD7aQ==
Date:   Thu, 11 Apr 2019 20:18:04 +0000
Message-ID: <20190411201743.43195-6-Yazen.Ghannam@amd.com>
References: <20190411201743.43195-1-Yazen.Ghannam@amd.com>
In-Reply-To: <20190411201743.43195-1-Yazen.Ghannam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR02CA0014.namprd02.prod.outlook.com
 (2603:10b6:805:a2::27) To SN6PR12MB2639.namprd12.prod.outlook.com
 (2603:10b6:805:6f::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8b9ac8b3-9792-4122-febb-08d6bebacd35
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:SN6PR12MB2688;
x-ms-traffictypediagnostic: SN6PR12MB2688:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <SN6PR12MB2688E3F1BB3A47B17D6FD091F82F0@SN6PR12MB2688.namprd12.prod.outlook.com>
x-forefront-prvs: 00046D390F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(346002)(136003)(376002)(396003)(199004)(189003)(2616005)(966005)(256004)(4326008)(478600001)(66066001)(76176011)(26005)(5660300002)(53936002)(3846002)(6506007)(72206003)(186003)(6116002)(2906002)(386003)(54906003)(2501003)(102836004)(6916009)(2351001)(97736004)(105586002)(99286004)(6436002)(8936002)(52116002)(50226002)(36756003)(14454004)(106356001)(68736007)(81156014)(81166006)(476003)(6486002)(7736002)(11346002)(71200400001)(446003)(486006)(71190400001)(5640700003)(86362001)(6306002)(316002)(8676002)(1076003)(305945005)(6512007)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2688;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: PfHIqbVOZO38nwQQ53TkJv14ofxS1D+dpCkpea2IBajJHqWb1fLPMIu8o8aNaP4Q0NX0gb6YFw6Bd8NkDejEi8/a4R+8Fk1dIUhMwIfSItDDlzkDTPzbmosDtHAJHmQESkv5mN3B89tOdrjfeo1FnGIRl8VkyDtLv20qOtXFxP0bRiP+uVSm92ZhNnYUnQfuem1CJEoozlXloPzhqB9/Zh2mlhwAI0KpI4r/71fzi3pU2TYkqVthlszYdI2yTr4kpPdxr2atYGkqOc7ULYSv2nTtwOdtW3MEBidNcGk6kN+cPJ1G5o1ULkNLpZlYEhq9+4lEfCS6bV2Idr2t6EhEASOVN11yqwlU9LSXH9wylR7oFtotCV4kfB+zqcjfY2RaaSLyDtIvX12eM/SdU3kP5QnJyyj8LnMk6xc3kAL4ca8=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b9ac8b3-9792-4122-febb-08d6bebacd35
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2019 20:18:04.1560
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2688
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogWWF6ZW4gR2hhbm5hbSA8eWF6ZW4uZ2hhbm5hbUBhbWQuY29tPg0KDQpUaGUgT1MgaXMg
ZXhwZWN0ZWQgdG8gd3JpdGUgYWxsIGJpdHMgaW4gTUNBX0NUTC4gSG93ZXZlciwgb25seQ0KaW1w
bGVtZW50ZWQgYml0cyBnZXQgc2V0IGluIHRoZSBoYXJkd2FyZS4NCg0KUmVhZCBiYWNrIE1DQV9D
VEwgc28gdGhhdCB0aGUgdmFsdWUgaW4gdGhlIGhhcmR3YXJlIGlzIHNhdmVkIGFuZA0KcmVwb3J0
ZWQgdGhyb3VnaCBzeXNmcy4NCg0KU2lnbmVkLW9mZi1ieTogWWF6ZW4gR2hhbm5hbSA8eWF6ZW4u
Z2hhbm5hbUBhbWQuY29tPg0KLS0tDQpMaW5rOg0KaHR0cHM6Ly9sa21sLmtlcm5lbC5vcmcvci8y
MDE5MDQwODE0MTIwNS4xMjM3Ni02LVlhemVuLkdoYW5uYW1AYW1kLmNvbQ0KDQp2MS0+djI6DQoq
IE5vIGNoYW5nZS4NCg0KIGFyY2gveDg2L2tlcm5lbC9jcHUvbWNlL2NvcmUuYyB8IDE1ICsrKysr
KysrKystLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9u
cygtKQ0KDQpkaWZmIC0tZ2l0IGEvYXJjaC94ODYva2VybmVsL2NwdS9tY2UvY29yZS5jIGIvYXJj
aC94ODYva2VybmVsL2NwdS9tY2UvY29yZS5jDQppbmRleCAwZmUyOTE0MGVjYWIuLjcxNjYyMTMz
YzcwYyAxMDA2NDQNCi0tLSBhL2FyY2gveDg2L2tlcm5lbC9jcHUvbWNlL2NvcmUuYw0KKysrIGIv
YXJjaC94ODYva2VybmVsL2NwdS9tY2UvY29yZS5jDQpAQCAtMTU2NSwxMCArMTU2NSwxMyBAQCBz
dGF0aWMgdm9pZCBfX21jaGVja19jcHVfaW5pdF9jbGVhcl9iYW5rcyh2b2lkKQ0KIAlmb3IgKGkg
PSAwOyBpIDwgdGhpc19jcHVfcmVhZChtY2VfbnVtX2JhbmtzKTsgaSsrKSB7DQogCQlzdHJ1Y3Qg
bWNlX2JhbmsgKmIgPSAmdGhpc19jcHVfcmVhZChtY2VfYmFua3MpW2ldOw0KIA0KLQkJaWYgKCFi
LT5pbml0KQ0KLQkJCWNvbnRpbnVlOw0KLQkJd3Jtc3JsKG1zcl9vcHMuY3RsKGkpLCBiLT5jdGwp
Ow0KLQkJd3Jtc3JsKG1zcl9vcHMuc3RhdHVzKGkpLCAwKTsNCisJCWlmIChiLT5pbml0KSB7DQor
CQkJd3Jtc3JsKG1zcl9vcHMuY3RsKGkpLCBiLT5jdGwpOw0KKwkJCXdybXNybChtc3Jfb3BzLnN0
YXR1cyhpKSwgMCk7DQorCQl9DQorDQorCQkvKiBTYXZlIGJpdHMgc2V0IGluIGhhcmR3YXJlLiAq
Lw0KKwkJcmRtc3JsKG1zcl9vcHMuY3RsKGkpLCBiLT5jdGwpOw0KIAl9DQogfQ0KIA0KQEAgLTIz
MTIsOCArMjMxNSwxMCBAQCBzdGF0aWMgdm9pZCBtY2VfcmVlbmFibGVfY3B1KHZvaWQpDQogCWZv
ciAoaSA9IDA7IGkgPCB0aGlzX2NwdV9yZWFkKG1jZV9udW1fYmFua3MpOyBpKyspIHsNCiAJCXN0
cnVjdCBtY2VfYmFuayAqYiA9ICZ0aGlzX2NwdV9yZWFkKG1jZV9iYW5rcylbaV07DQogDQotCQlp
ZiAoYi0+aW5pdCkNCisJCWlmIChiLT5pbml0KSB7DQogCQkJd3Jtc3JsKG1zcl9vcHMuY3RsKGkp
LCBiLT5jdGwpOw0KKwkJCXJkbXNybChtc3Jfb3BzLmN0bChpKSwgYi0+Y3RsKTsNCisJCX0NCiAJ
fQ0KIH0NCiANCi0tIA0KMi4xNy4xDQoNCg==
