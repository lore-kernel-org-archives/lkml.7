Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2026CC282CE
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 20:18:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D723720850
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 20:18:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="J7xJAQTW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbfDKUSR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 16:18:17 -0400
Received: from mail-eopbgr820079.outbound.protection.outlook.com ([40.107.82.79]:50208
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727021AbfDKUSR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 16:18:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DrcHeSEUzK2MmTkpD7La6vLFvH/C0Bww2ZwlOnNqVXM=;
 b=J7xJAQTWWn66mskL0Bpq7HmIllbO4nzmZGDHYOVRm3MJlO0bS+nfZ6DdCrenYLU06JoVKiW5ZVqw6oTMedF0gtxl1d3Vq0NeO+UzXRzYXwuYX2FKgiM9V4eMQAMtfh0bBf1ENXD6XYWz8VoJ29xKgpS23nxd87pcPmdHp8oTTTU=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2688.namprd12.prod.outlook.com (52.135.103.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.16; Thu, 11 Apr 2019 20:18:05 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::9c51:41bf:f88e:f3e8]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::9c51:41bf:f88e:f3e8%2]) with mapi id 15.20.1771.016; Thu, 11 Apr 2019
 20:18:05 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
CC:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@suse.de" <bp@suse.de>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: [PATCH v2 6/6] x86/MCE: Treat MCE bank as initialized if control bits
 set in hardware
Thread-Topic: [PATCH v2 6/6] x86/MCE: Treat MCE bank as initialized if control
 bits set in hardware
Thread-Index: AQHU8KOru2Mxyo5fHUqwUnD+bhilyQ==
Date:   Thu, 11 Apr 2019 20:18:04 +0000
Message-ID: <20190411201743.43195-7-Yazen.Ghannam@amd.com>
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
x-ms-office365-filtering-correlation-id: c8c31be7-c06a-481a-f6f2-08d6bebacdbe
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:SN6PR12MB2688;
x-ms-traffictypediagnostic: SN6PR12MB2688:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <SN6PR12MB268875FD3DF31D075F862897F82F0@SN6PR12MB2688.namprd12.prod.outlook.com>
x-forefront-prvs: 00046D390F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(346002)(136003)(376002)(396003)(199004)(189003)(2616005)(966005)(256004)(4326008)(478600001)(66066001)(76176011)(26005)(5660300002)(53936002)(3846002)(6506007)(72206003)(186003)(6116002)(2906002)(386003)(54906003)(2501003)(102836004)(6916009)(2351001)(97736004)(105586002)(99286004)(6436002)(8936002)(15650500001)(52116002)(50226002)(36756003)(14454004)(106356001)(68736007)(81156014)(81166006)(476003)(6486002)(7736002)(11346002)(71200400001)(446003)(486006)(71190400001)(5640700003)(86362001)(6306002)(316002)(8676002)(1076003)(305945005)(6512007)(25786009)(309714004);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2688;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: xNqWVl3PW3p732Xbyu8FpdN7jwIYp6PGcQk47S2U4Z+OzYj74dvk/mla74AdDx+G1BJIHRTZz0APFwwvDQ8CUy18+KcFk07MgJ5UcccHcnKLBbjCXRxcZjokN7fODaMsNu0BKrMfvdJPOzhjsLS9EPy5Rf9/43iBpbzWFm82KQkxlXWSNogiZNIitStDMaVUr3KOXRKCDMH7z1xvnOO4HuJcrA8oJELuIqTIQXNJZo69kjkssfl5PT0V1bPRklNiE9FRhvDY2xEdM5Pzp94D5SVKuFuyTxd/1dcfrIkxYk/AqTv4uBSGpi0yjvrTIWtURuQNJquU5w6k3rulKvci+24tLCWenR0hFD4w87b5YoYH9NSAeG+ndEgb1Jtm1ri1sM9iG+XS1O0owI9JK9ZbwIOcNnpZxrEmyTG2ziinaP0=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8c31be7-c06a-481a-f6f2-08d6bebacdbe
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2019 20:18:04.7995
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
ZXhwZWN0ZWQgdG8gd3JpdGUgYWxsIGJpdHMgdG8gTUNBX0NUTCBmb3IgZWFjaCBiYW5rLiBIb3dl
dmVyLA0Kc29tZSBiYW5rcyBtYXkgYmUgdW51c2VkIGluIHdoaWNoIGNhc2UgdGhlIHJlZ2lzdGVy
cyBmb3Igc3VjaCBiYW5rcyBhcmUNClJlYWQtYXMtWmVyby9Xcml0ZXMtSWdub3JlZC4gQWxzbywg
dGhlIE9TIG1heSBub3Qgd3JpdGUgYW55IGNvbnRyb2wgYml0cw0KYmVjYXVzZSBvZiBxdWlya3Ms
IGV0Yy4NCg0KQSBiYW5rIGNhbiBiZSBjb25zaWRlcmVkIHVuaW5pdGlhbGl6ZWQgaWYgdGhlIE1D
QV9DVEwgcmVnaXN0ZXIgcmV0dXJucw0KemVyby4gVGhpcyBpcyBiZWNhdXNlIGVpdGhlciB0aGUg
T1MgZGlkIG5vdCB3cml0ZSBhbnl0aGluZyBvciBiZWNhdXNlDQp0aGUgaGFyZHdhcmUgaXMgZW5m
b3JjaW5nIFJBWi9XSSBmb3IgdGhlIGJhbmsuDQoNClNldCBhIGJhbmsncyBpbml0IHZhbHVlIGJh
c2VkIG9uIGlmIHRoZSBjb250cm9sIGJpdHMgYXJlIHNldCBvciBub3QgaW4NCmhhcmR3YXJlLg0K
DQpSZXR1cm4gYW4gZXJyb3IgY29kZSBpbiB0aGUgc3lzZnMgaW50ZXJmYWNlIGZvciB1bmluaXRp
YWxpemVkIGJhbmtzLg0KDQpTaWduZWQtb2ZmLWJ5OiBZYXplbiBHaGFubmFtIDx5YXplbi5naGFu
bmFtQGFtZC5jb20+DQotLS0NCkxpbms6DQpodHRwczovL2xrbWwua2VybmVsLm9yZy9yLzIwMTkw
NDA4MTQxMjA1LjEyMzc2LTMtWWF6ZW4uR2hhbm5hbUBhbWQuY29tDQoNCnYxLT52MjoNCiogTmV3
IGluIHYyLg0KKiBCYXNlZCBvbiBkaXNjdXNzaW9uIGZyb20gdjEgcGF0Y2ggMi4NCg0KIGFyY2gv
eDg2L2tlcm5lbC9jcHUvbWNlL2NvcmUuYyB8IDkgKysrKysrKysrDQogMSBmaWxlIGNoYW5nZWQs
IDkgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvYXJjaC94ODYva2VybmVsL2NwdS9tY2Uv
Y29yZS5jIGIvYXJjaC94ODYva2VybmVsL2NwdS9tY2UvY29yZS5jDQppbmRleCA3MTY2MjEzM2M3
MGMuLmRjZjVjNmQ3MjgxMSAxMDA2NDQNCi0tLSBhL2FyY2gveDg2L2tlcm5lbC9jcHUvbWNlL2Nv
cmUuYw0KKysrIGIvYXJjaC94ODYva2VybmVsL2NwdS9tY2UvY29yZS5jDQpAQCAtMTU3Miw2ICsx
NTcyLDkgQEAgc3RhdGljIHZvaWQgX19tY2hlY2tfY3B1X2luaXRfY2xlYXJfYmFua3Modm9pZCkN
CiANCiAJCS8qIFNhdmUgYml0cyBzZXQgaW4gaGFyZHdhcmUuICovDQogCQlyZG1zcmwobXNyX29w
cy5jdGwoaSksIGItPmN0bCk7DQorDQorCQkvKiBCYW5rIGlzIGluaXRpYWxpemVkIGlmIGJpdHMg
YXJlIHNldCBpbiBoYXJkd2FyZS4gKi8NCisJCWItPmluaXQgPSAhIWItPmN0bDsNCiAJfQ0KIH0N
CiANCkBAIC0yMDg2LDYgKzIwODksOSBAQCBzdGF0aWMgc3NpemVfdCBzaG93X2Jhbmsoc3RydWN0
IGRldmljZSAqcywgc3RydWN0IGRldmljZV9hdHRyaWJ1dGUgKmF0dHIsDQogDQogCWIgPSAmcGVy
X2NwdShtY2VfYmFua3MsIHMtPmlkKVtiYW5rXTsNCiANCisJaWYgKCFiLT5pbml0KQ0KKwkJcmV0
dXJuIC1FTk9ERVY7DQorDQogCXJldHVybiBzcHJpbnRmKGJ1ZiwgIiVsbHhcbiIsIGItPmN0bCk7
DQogfQ0KIA0KQEAgLTIxMDQsNiArMjExMCw5IEBAIHN0YXRpYyBzc2l6ZV90IHNldF9iYW5rKHN0
cnVjdCBkZXZpY2UgKnMsIHN0cnVjdCBkZXZpY2VfYXR0cmlidXRlICphdHRyLA0KIA0KIAliID0g
JnBlcl9jcHUobWNlX2JhbmtzLCBzLT5pZClbYmFua107DQogDQorCWlmICghYi0+aW5pdCkNCisJ
CXJldHVybiAtRU5PREVWOw0KKw0KIAliLT5jdGwgPSBuZXc7DQogCW1jZV9yZXN0YXJ0KCk7DQog
DQotLSANCjIuMTcuMQ0KDQo=
