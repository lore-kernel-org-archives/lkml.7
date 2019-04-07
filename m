Return-Path: <SRS0=A1VX=SJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3B18C282DE
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 23:13:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A797D20896
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 23:13:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="M3w4i41J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbfDGXNw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 19:13:52 -0400
Received: from mail-eopbgr720042.outbound.protection.outlook.com ([40.107.72.42]:47936
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726223AbfDGXNw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 19:13:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rFSiJO0hR8ae1DIoGnj2xkz4xpeSgrA7AVoxTpdA+dE=;
 b=M3w4i41JjJFNgrvts4FVWBEECTJpufa8GpFdBYP1vLeJHfU0XFY+cuVelVNZOYJEX1Hv7UEmxjAA5AzBV5+8IMuqe3O28vFyUhewTx5QQOwX8ac/e4q8Qjg2HQkTIHnBJC0COZXqsgx69BMQzr2lgRGkn2kuh6WhJmVGtdeS4vI=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2768.namprd12.prod.outlook.com (52.135.107.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.16; Sun, 7 Apr 2019 23:13:48 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::9c51:41bf:f88e:f3e8]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::9c51:41bf:f88e:f3e8%2]) with mapi id 15.20.1771.016; Sun, 7 Apr 2019
 23:13:48 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
CC:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@suse.de" <bp@suse.de>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: [PATCH 1/5] x86/MCE: Make struct mce_banks[] static
Thread-Topic: [PATCH 1/5] x86/MCE: Make struct mce_banks[] static
Thread-Index: AQHU7ZeOZX8KCwsbTEyH9lxtVkcXMQ==
Date:   Sun, 7 Apr 2019 23:13:48 +0000
Message-ID: <20190407231331.52362-2-Yazen.Ghannam@amd.com>
References: <20190407231331.52362-1-Yazen.Ghannam@amd.com>
In-Reply-To: <20190407231331.52362-1-Yazen.Ghannam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0501CA0039.namprd05.prod.outlook.com
 (2603:10b6:803:41::16) To SN6PR12MB2639.namprd12.prod.outlook.com
 (2603:10b6:805:6f::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: df440a53-21eb-47ee-838f-08d6bbaeb08e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:SN6PR12MB2768;
x-ms-traffictypediagnostic: SN6PR12MB2768:
x-microsoft-antispam-prvs: <SN6PR12MB2768A26FC7F9A31F4D63C895F8530@SN6PR12MB2768.namprd12.prod.outlook.com>
x-forefront-prvs: 00003DBFE7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(136003)(39860400002)(346002)(396003)(199004)(189003)(105586002)(99286004)(14454004)(186003)(72206003)(478600001)(106356001)(53936002)(2351001)(3846002)(1076003)(6116002)(54906003)(316002)(102836004)(5660300002)(2906002)(68736007)(6512007)(50226002)(4326008)(36756003)(6506007)(386003)(66066001)(81166006)(97736004)(52116002)(6486002)(7736002)(76176011)(476003)(11346002)(26005)(486006)(2616005)(81156014)(5640700003)(6436002)(8676002)(6916009)(446003)(25786009)(86362001)(14444005)(256004)(71200400001)(2501003)(8936002)(71190400001)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2768;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: tgnrLzEd5jofpQUt5hi2XMs6A8I9zSfoVGAXPFibUwnENfndAi1yZVvxiCJJhZAgsitDOkqp2s2FucSjgQXzNdP75AQhifKXRTVxisZ3vjOPgKEvJjyuKOgiByvoy0fiEZciwJb/tJdoG3XPKJRrXC0myeCkacfTQL1Zo3VLRixYEU1/FIRP30TaJ1Z3xSeo5UtolVxI3bapC8/pPn0n1HTNHaLL2sNCgtRpJuTj/eL0+xeCrJFHs/B8jU79g9uD3kAYRDEYP0N6WkDF9b5YMhG0wLIJmLeV2MA3xKh4aARLa0ijd303UzbWT0ujQ7H20boXVxf7XVrv7AIb3t54rNQd2YwP47HK+LQhYdkImgoq4VdPF/ILEFFbUXH072kPLxaZIBq0RGN58d0rZ2rWI/VIAZTJwkEACzxfRLwALLM=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df440a53-21eb-47ee-838f-08d6bbaeb08e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2019 23:13:48.2759
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2768
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogWWF6ZW4gR2hhbm5hbSA8eWF6ZW4uZ2hhbm5hbUBhbWQuY29tPg0KDQpUaGUgc3RydWN0
IG1jZV9iYW5rc1tdIGFycmF5IGlzIG9ubHkgdXNlZCBpbiBtY2UvY29yZS5jIHNvIG1vdmUgdGhl
DQpkZWZpbml0aW9uIG9mIHN0cnVjdCBtY2VfYmFuayB0byBtY2UvY29yZS5jIGFuZCBtYWtlIHRo
ZSBhcnJheSBzdGF0aWMuDQoNCkFsc28sIGNoYW5nZSB0aGUgImluaXQiIGZpZWxkIHRvIGJvb2wg
dHlwZS4NCg0KU2lnbmVkLW9mZi1ieTogWWF6ZW4gR2hhbm5hbSA8eWF6ZW4uZ2hhbm5hbUBhbWQu
Y29tPg0KLS0tDQogYXJjaC94ODYva2VybmVsL2NwdS9tY2UvY29yZS5jICAgICB8IDExICsrKysr
KysrKystDQogYXJjaC94ODYva2VybmVsL2NwdS9tY2UvaW50ZXJuYWwuaCB8IDEwIC0tLS0tLS0t
LS0NCiAyIGZpbGVzIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKyksIDExIGRlbGV0aW9ucygtKQ0K
DQpkaWZmIC0tZ2l0IGEvYXJjaC94ODYva2VybmVsL2NwdS9tY2UvY29yZS5jIGIvYXJjaC94ODYv
a2VybmVsL2NwdS9tY2UvY29yZS5jDQppbmRleCA1ODkyNWU3Y2NiMjcuLjhkMGQxZTg0MjVkYiAx
MDA2NDQNCi0tLSBhL2FyY2gveDg2L2tlcm5lbC9jcHUvbWNlL2NvcmUuYw0KKysrIGIvYXJjaC94
ODYva2VybmVsL2NwdS9tY2UvY29yZS5jDQpAQCAtNjQsNyArNjQsMTYgQEAgc3RhdGljIERFRklO
RV9NVVRFWChtY2Vfc3lzZnNfbXV0ZXgpOw0KIA0KIERFRklORV9QRVJfQ1BVKHVuc2lnbmVkLCBt
Y2VfZXhjZXB0aW9uX2NvdW50KTsNCiANCi1zdHJ1Y3QgbWNlX2JhbmsgKm1jZV9iYW5rcyBfX3Jl
YWRfbW9zdGx5Ow0KKyNkZWZpbmUgQVRUUl9MRU4gICAgICAgICAgICAgICAxNg0KKy8qIE9uZSBv
YmplY3QgZm9yIGVhY2ggTUNFIGJhbmssIHNoYXJlZCBieSBhbGwgQ1BVcyAqLw0KK3N0cnVjdCBt
Y2VfYmFuayB7DQorCXU2NAkJCWN0bDsJCQkvKiBzdWJldmVudHMgdG8gZW5hYmxlICovDQorCWJv
b2wJCQlpbml0OwkJCS8qIGluaXRpYWxpc2UgYmFuaz8gKi8NCisJc3RydWN0IGRldmljZV9hdHRy
aWJ1dGUJYXR0cjsJCQkvKiBkZXZpY2UgYXR0cmlidXRlICovDQorCWNoYXIJCQlhdHRybmFtZVtB
VFRSX0xFTl07CS8qIGF0dHJpYnV0ZSBuYW1lICovDQorfTsNCisNCitzdGF0aWMgc3RydWN0IG1j
ZV9iYW5rICptY2VfYmFua3MgX19yZWFkX21vc3RseTsNCiBzdHJ1Y3QgbWNlX3ZlbmRvcl9mbGFn
cyBtY2VfZmxhZ3MgX19yZWFkX21vc3RseTsNCiANCiBzdHJ1Y3QgbWNhX2NvbmZpZyBtY2FfY2Zn
IF9fcmVhZF9tb3N0bHkgPSB7DQpkaWZmIC0tZ2l0IGEvYXJjaC94ODYva2VybmVsL2NwdS9tY2Uv
aW50ZXJuYWwuaCBiL2FyY2gveDg2L2tlcm5lbC9jcHUvbWNlL2ludGVybmFsLmgNCmluZGV4IGFm
NWVhYjFlNjVlMi4uMDMyZDUyYzY2NjE2IDEwMDY0NA0KLS0tIGEvYXJjaC94ODYva2VybmVsL2Nw
dS9tY2UvaW50ZXJuYWwuaA0KKysrIGIvYXJjaC94ODYva2VybmVsL2NwdS9tY2UvaW50ZXJuYWwu
aA0KQEAgLTIyLDE3ICsyMiw4IEBAIGVudW0gc2V2ZXJpdHlfbGV2ZWwgew0KIA0KIGV4dGVybiBz
dHJ1Y3QgYmxvY2tpbmdfbm90aWZpZXJfaGVhZCB4ODZfbWNlX2RlY29kZXJfY2hhaW47DQogDQot
I2RlZmluZSBBVFRSX0xFTgkJMTYNCiAjZGVmaW5lIElOSVRJQUxfQ0hFQ0tfSU5URVJWQUwJNSAq
IDYwIC8qIDUgbWludXRlcyAqLw0KIA0KLS8qIE9uZSBvYmplY3QgZm9yIGVhY2ggTUNFIGJhbmss
IHNoYXJlZCBieSBhbGwgQ1BVcyAqLw0KLXN0cnVjdCBtY2VfYmFuayB7DQotCXU2NAkJCWN0bDsJ
CQkvKiBzdWJldmVudHMgdG8gZW5hYmxlICovDQotCXVuc2lnbmVkIGNoYXIgaW5pdDsJCQkJLyog
aW5pdGlhbGlzZSBiYW5rPyAqLw0KLQlzdHJ1Y3QgZGV2aWNlX2F0dHJpYnV0ZSBhdHRyOwkJCS8q
IGRldmljZSBhdHRyaWJ1dGUgKi8NCi0JY2hhcgkJCWF0dHJuYW1lW0FUVFJfTEVOXTsJLyogYXR0
cmlidXRlIG5hbWUgKi8NCi19Ow0KLQ0KIHN0cnVjdCBtY2VfZXZ0X2xsaXN0IHsNCiAJc3RydWN0
IGxsaXN0X25vZGUgbGxub2RlOw0KIAlzdHJ1Y3QgbWNlIG1jZTsNCkBAIC00Nyw3ICszOCw2IEBA
IHN0cnVjdCBsbGlzdF9ub2RlICptY2VfZ2VuX3Bvb2xfcHJlcGFyZV9yZWNvcmRzKHZvaWQpOw0K
IGV4dGVybiBpbnQgKCptY2Vfc2V2ZXJpdHkpKHN0cnVjdCBtY2UgKmEsIGludCB0b2xlcmFudCwg
Y2hhciAqKm1zZywgYm9vbCBpc19leGNwKTsNCiBzdHJ1Y3QgZGVudHJ5ICptY2VfZ2V0X2RlYnVn
ZnNfZGlyKHZvaWQpOw0KIA0KLWV4dGVybiBzdHJ1Y3QgbWNlX2JhbmsgKm1jZV9iYW5rczsNCiBl
eHRlcm4gbWNlX2JhbmtzX3QgbWNlX2JhbmtzX2NlX2Rpc2FibGVkOw0KIA0KICNpZmRlZiBDT05G
SUdfWDg2X01DRV9JTlRFTA0KLS0gDQoyLjE3LjENCg0K
