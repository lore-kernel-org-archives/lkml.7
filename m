Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DBC4C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 20:18:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E3F3218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 20:18:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="gaxwts8K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbfDKUSF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 16:18:05 -0400
Received: from mail-eopbgr820079.outbound.protection.outlook.com ([40.107.82.79]:50208
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726630AbfDKUSE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 16:18:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WfC28tiWWzwnwhbUctvZqZw6453XSePz7TJXNr/eh8Q=;
 b=gaxwts8KzcgTsca36b/cROL2GYxSHe9iSU3HfJx9P/jdaqsraj+gDkZEtgkKEEtj5p/Fm51yUDn/Rtl/0IcBT7BcCbN7zeF6GGAhyLcLH8gpZ309N80dlpi8OnW2rOtwPLgnRJu7VsvgAYBKBw1LZIeYEEkB9N3XZZ08F0bM2pE=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2688.namprd12.prod.outlook.com (52.135.103.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.16; Thu, 11 Apr 2019 20:18:01 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::9c51:41bf:f88e:f3e8]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::9c51:41bf:f88e:f3e8%2]) with mapi id 15.20.1771.016; Thu, 11 Apr 2019
 20:18:01 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
CC:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@suse.de" <bp@suse.de>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: [PATCH v2 1/6] x86/MCE: Make struct mce_banks[] static
Thread-Topic: [PATCH v2 1/6] x86/MCE: Make struct mce_banks[] static
Thread-Index: AQHU8KOpsmdxLufMnk6vTZKtUP2rOg==
Date:   Thu, 11 Apr 2019 20:18:00 +0000
Message-ID: <20190411201743.43195-2-Yazen.Ghannam@amd.com>
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
x-ms-office365-filtering-correlation-id: d6b6b489-20c6-4b32-db98-08d6bebacb71
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:SN6PR12MB2688;
x-ms-traffictypediagnostic: SN6PR12MB2688:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <SN6PR12MB2688D65E0558228C2515E25FF82F0@SN6PR12MB2688.namprd12.prod.outlook.com>
x-forefront-prvs: 00046D390F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(346002)(136003)(376002)(396003)(199004)(189003)(2616005)(966005)(256004)(14444005)(4326008)(478600001)(66066001)(76176011)(26005)(5660300002)(53936002)(3846002)(6506007)(72206003)(186003)(6116002)(2906002)(386003)(54906003)(2501003)(102836004)(6916009)(2351001)(97736004)(105586002)(99286004)(6436002)(8936002)(52116002)(50226002)(36756003)(14454004)(106356001)(68736007)(81156014)(81166006)(476003)(6486002)(7736002)(11346002)(71200400001)(446003)(486006)(71190400001)(5640700003)(86362001)(6306002)(316002)(8676002)(1076003)(305945005)(6512007)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2688;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: S94Z+lYbvThsYdef5YaDUHXWDmfx2hJyINJXkvRS1pqS5x8zg9v5pqpNKNGP6NiG4g7tVxHfrdN8YrCbe8XJf7ONgVxVpRVRmuc/7WIMkcLBRRQd9tItmip+ULmdbnEawoV9auDhfW1+0PZ8INcnD30mo+O2xWt7EHiuzNA/+tWl5nH0YJXhVosl81Zt42OeO6J9e+oq3a8Vg4B7LL8GZjIDvUaxu/z4Em6MpwVEA1Q3qUxScrQj3Zn5cTxjrgYYsxLDS2zp4VCT40pNPjidlHfnYT9hvJvJFGFoymeySUWecgouTP0DLCTqfmxYVRnDpy4b95kgF/mT2dHE40AkCiPo9/uQSqangtO44IFgu7Y8IyYSASZVi5X79QUI/kn/c16OHpgF2gL6p2zn+kvnk197QgzeB7JeiLd1NqpW9Dg=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6b6b489-20c6-4b32-db98-08d6bebacb71
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2019 20:18:01.0828
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2688
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogWWF6ZW4gR2hhbm5hbSA8eWF6ZW4uZ2hhbm5hbUBhbWQuY29tPg0KDQpUaGUgc3RydWN0
IG1jZV9iYW5rc1tdIGFycmF5IGlzIG9ubHkgdXNlZCBpbiBtY2UvY29yZS5jIHNvIG1vdmUgdGhl
DQpkZWZpbml0aW9uIG9mIHN0cnVjdCBtY2VfYmFuayB0byBtY2UvY29yZS5jIGFuZCBtYWtlIHRo
ZSBhcnJheSBzdGF0aWMuDQoNCkFsc28sIGNoYW5nZSB0aGUgImluaXQiIGZpZWxkIHRvIGJvb2wg
dHlwZS4NCg0KU2lnbmVkLW9mZi1ieTogWWF6ZW4gR2hhbm5hbSA8eWF6ZW4uZ2hhbm5hbUBhbWQu
Y29tPg0KLS0tDQpMaW5rOg0KaHR0cHM6Ly9sa21sLmtlcm5lbC5vcmcvci8yMDE5MDQwODE0MTIw
NS4xMjM3Ni0yLVlhemVuLkdoYW5uYW1AYW1kLmNvbQ0KDQp2MS0+djI6DQoqIE5vIGNoYW5nZXMN
Cg0KIGFyY2gveDg2L2tlcm5lbC9jcHUvbWNlL2NvcmUuYyAgICAgfCAxMSArKysrKysrKysrLQ0K
IGFyY2gveDg2L2tlcm5lbC9jcHUvbWNlL2ludGVybmFsLmggfCAxMCAtLS0tLS0tLS0tDQogMiBm
aWxlcyBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspLCAxMSBkZWxldGlvbnMoLSkNCg0KZGlmZiAt
LWdpdCBhL2FyY2gveDg2L2tlcm5lbC9jcHUvbWNlL2NvcmUuYyBiL2FyY2gveDg2L2tlcm5lbC9j
cHUvbWNlL2NvcmUuYw0KaW5kZXggNTg5MjVlN2NjYjI3Li44ZDBkMWU4NDI1ZGIgMTAwNjQ0DQot
LS0gYS9hcmNoL3g4Ni9rZXJuZWwvY3B1L21jZS9jb3JlLmMNCisrKyBiL2FyY2gveDg2L2tlcm5l
bC9jcHUvbWNlL2NvcmUuYw0KQEAgLTY0LDcgKzY0LDE2IEBAIHN0YXRpYyBERUZJTkVfTVVURVgo
bWNlX3N5c2ZzX211dGV4KTsNCiANCiBERUZJTkVfUEVSX0NQVSh1bnNpZ25lZCwgbWNlX2V4Y2Vw
dGlvbl9jb3VudCk7DQogDQotc3RydWN0IG1jZV9iYW5rICptY2VfYmFua3MgX19yZWFkX21vc3Rs
eTsNCisjZGVmaW5lIEFUVFJfTEVOICAgICAgICAgICAgICAgMTYNCisvKiBPbmUgb2JqZWN0IGZv
ciBlYWNoIE1DRSBiYW5rLCBzaGFyZWQgYnkgYWxsIENQVXMgKi8NCitzdHJ1Y3QgbWNlX2Jhbmsg
ew0KKwl1NjQJCQljdGw7CQkJLyogc3ViZXZlbnRzIHRvIGVuYWJsZSAqLw0KKwlib29sCQkJaW5p
dDsJCQkvKiBpbml0aWFsaXNlIGJhbms/ICovDQorCXN0cnVjdCBkZXZpY2VfYXR0cmlidXRlCWF0
dHI7CQkJLyogZGV2aWNlIGF0dHJpYnV0ZSAqLw0KKwljaGFyCQkJYXR0cm5hbWVbQVRUUl9MRU5d
OwkvKiBhdHRyaWJ1dGUgbmFtZSAqLw0KK307DQorDQorc3RhdGljIHN0cnVjdCBtY2VfYmFuayAq
bWNlX2JhbmtzIF9fcmVhZF9tb3N0bHk7DQogc3RydWN0IG1jZV92ZW5kb3JfZmxhZ3MgbWNlX2Zs
YWdzIF9fcmVhZF9tb3N0bHk7DQogDQogc3RydWN0IG1jYV9jb25maWcgbWNhX2NmZyBfX3JlYWRf
bW9zdGx5ID0gew0KZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC9jcHUvbWNlL2ludGVybmFs
LmggYi9hcmNoL3g4Ni9rZXJuZWwvY3B1L21jZS9pbnRlcm5hbC5oDQppbmRleCBhZjVlYWIxZTY1
ZTIuLjAzMmQ1MmM2NjYxNiAxMDA2NDQNCi0tLSBhL2FyY2gveDg2L2tlcm5lbC9jcHUvbWNlL2lu
dGVybmFsLmgNCisrKyBiL2FyY2gveDg2L2tlcm5lbC9jcHUvbWNlL2ludGVybmFsLmgNCkBAIC0y
MiwxNyArMjIsOCBAQCBlbnVtIHNldmVyaXR5X2xldmVsIHsNCiANCiBleHRlcm4gc3RydWN0IGJs
b2NraW5nX25vdGlmaWVyX2hlYWQgeDg2X21jZV9kZWNvZGVyX2NoYWluOw0KIA0KLSNkZWZpbmUg
QVRUUl9MRU4JCTE2DQogI2RlZmluZSBJTklUSUFMX0NIRUNLX0lOVEVSVkFMCTUgKiA2MCAvKiA1
IG1pbnV0ZXMgKi8NCiANCi0vKiBPbmUgb2JqZWN0IGZvciBlYWNoIE1DRSBiYW5rLCBzaGFyZWQg
YnkgYWxsIENQVXMgKi8NCi1zdHJ1Y3QgbWNlX2Jhbmsgew0KLQl1NjQJCQljdGw7CQkJLyogc3Vi
ZXZlbnRzIHRvIGVuYWJsZSAqLw0KLQl1bnNpZ25lZCBjaGFyIGluaXQ7CQkJCS8qIGluaXRpYWxp
c2UgYmFuaz8gKi8NCi0Jc3RydWN0IGRldmljZV9hdHRyaWJ1dGUgYXR0cjsJCQkvKiBkZXZpY2Ug
YXR0cmlidXRlICovDQotCWNoYXIJCQlhdHRybmFtZVtBVFRSX0xFTl07CS8qIGF0dHJpYnV0ZSBu
YW1lICovDQotfTsNCi0NCiBzdHJ1Y3QgbWNlX2V2dF9sbGlzdCB7DQogCXN0cnVjdCBsbGlzdF9u
b2RlIGxsbm9kZTsNCiAJc3RydWN0IG1jZSBtY2U7DQpAQCAtNDcsNyArMzgsNiBAQCBzdHJ1Y3Qg
bGxpc3Rfbm9kZSAqbWNlX2dlbl9wb29sX3ByZXBhcmVfcmVjb3Jkcyh2b2lkKTsNCiBleHRlcm4g
aW50ICgqbWNlX3NldmVyaXR5KShzdHJ1Y3QgbWNlICphLCBpbnQgdG9sZXJhbnQsIGNoYXIgKipt
c2csIGJvb2wgaXNfZXhjcCk7DQogc3RydWN0IGRlbnRyeSAqbWNlX2dldF9kZWJ1Z2ZzX2Rpcih2
b2lkKTsNCiANCi1leHRlcm4gc3RydWN0IG1jZV9iYW5rICptY2VfYmFua3M7DQogZXh0ZXJuIG1j
ZV9iYW5rc190IG1jZV9iYW5rc19jZV9kaXNhYmxlZDsNCiANCiAjaWZkZWYgQ09ORklHX1g4Nl9N
Q0VfSU5URUwNCi0tIA0KMi4xNy4xDQoNCg==
