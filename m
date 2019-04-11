Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B67F0C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 20:18:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6828720850
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 20:18:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="mCTBrH2a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbfDKUSM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 16:18:12 -0400
Received: from mail-eopbgr820079.outbound.protection.outlook.com ([40.107.82.79]:50208
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726630AbfDKUSH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 16:18:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kMVZ2X2cu3x6QLdrQtYOfKTB0JniVuZaNcyzzoGkx/4=;
 b=mCTBrH2ayyZyg7SGdoNJfUvBvdw+FLMf5SmrSFOdyLMRxlNzYzf6IuTHUQltjBymS7ZemDwiefqtUJFUZZ5Yj764UvNwOW+Nqs57PG6XVRrXsvuDvZN033fgIFE/NwB1hCxq8q8GJ14UBscsRGyebU/zElMbar1Ov86y6dJ5ASE=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2688.namprd12.prod.outlook.com (52.135.103.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.16; Thu, 11 Apr 2019 20:18:03 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::9c51:41bf:f88e:f3e8]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::9c51:41bf:f88e:f3e8%2]) with mapi id 15.20.1771.016; Thu, 11 Apr 2019
 20:18:03 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
CC:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@suse.de" <bp@suse.de>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: [PATCH v2 3/6] x86/MCE/AMD: Don't cache block addresses on SMCA
 systems
Thread-Topic: [PATCH v2 3/6] x86/MCE/AMD: Don't cache block addresses on SMCA
 systems
Thread-Index: AQHU8KOqBPQXFXhaW0O3h6mXcbNkhw==
Date:   Thu, 11 Apr 2019 20:18:02 +0000
Message-ID: <20190411201743.43195-4-Yazen.Ghannam@amd.com>
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
x-ms-office365-filtering-correlation-id: 9099c73f-8f22-4a02-e519-08d6bebacc4d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:SN6PR12MB2688;
x-ms-traffictypediagnostic: SN6PR12MB2688:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <SN6PR12MB2688FBCF494344ABA9E04C27F82F0@SN6PR12MB2688.namprd12.prod.outlook.com>
x-forefront-prvs: 00046D390F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(346002)(136003)(376002)(396003)(199004)(189003)(2616005)(966005)(256004)(14444005)(4326008)(478600001)(66066001)(76176011)(26005)(5660300002)(53936002)(3846002)(6506007)(72206003)(186003)(6116002)(2906002)(386003)(54906003)(2501003)(102836004)(6916009)(2351001)(97736004)(105586002)(99286004)(6436002)(8936002)(52116002)(50226002)(36756003)(14454004)(106356001)(68736007)(81156014)(81166006)(476003)(6486002)(7736002)(11346002)(71200400001)(446003)(486006)(71190400001)(5640700003)(86362001)(6306002)(316002)(8676002)(1076003)(305945005)(6512007)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2688;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: c1tQNPZ4mqM09I33EeoC5RtP+XnLGFbG5Skb39HUxSQWfv58c1gzZRGzvEAHlNgmfgzvpcFybebNfCz7/CiRH2+1snoNziUKZFCV+GNZGXiwgxsZVUfIRR++24hDsT3xlgPHZSr274yi3dADkZV+lcPwvSrGFA2gU9Epe9BgzpTxvbi9yXXtDd7u7yirknI8KidjpsWcBsH6hJIDI+Doua8TixGUfOqWWB9wMerLkgPpRVnmRKetF/jm8mtPHwco9vAWcyv7O4eVfhrg2szQQc+OXkzJS/61a7hSoBcTyaN3bAteEEXhi9ML1u/53Dg23r3nWMSiRahwPJRsc3Ho+3CRKITEMJV2meRj9kSXunORrwy9zHkmu58QzbXOQ7wAAVDEoFYHkUqZ59pRDroyAvFj54M1DK18zppeYqW/iWA=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9099c73f-8f22-4a02-e519-08d6bebacc4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2019 20:18:02.3927
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2688
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogWWF6ZW4gR2hhbm5hbSA8eWF6ZW4uZ2hhbm5hbUBhbWQuY29tPg0KDQpPbiBsZWdhY3kg
c3lzdGVtcywgdGhlIGFkZHJlc3NlcyBvZiB0aGUgTUNBX01JU0MqIHJlZ2lzdGVycyBuZWVkIHRv
IGJlDQpyZWN1cnNpdmVseSBkaXNjb3ZlcmVkIGJhc2VkIG9uIGEgQmxvY2sgUG9pbnRlciBmaWVs
ZCBpbiB0aGUgcmVnaXN0ZXJzLg0KDQpPbiBTY2FsYWJsZSBNQ0Egc3lzdGVtcywgdGhlIHJlZ2lz
dGVyIHNwYWNlIGlzIGZpeGVkLCBhbmQgcGFydGljdWxhcg0KYWRkcmVzc2VzIGNhbiBiZSBkZXJp
dmVkIGJ5IHJlZ3VsYXIgb2Zmc2V0cyBmb3IgYmFuayBhbmQgcmVnaXN0ZXIgdHlwZS4NClRoaXMg
Zml4ZWQgYWRkcmVzcyBzcGFjZSBpbmNsdWRlcyB0aGUgTUNBX01JU0MqIHJlZ2lzdGVycy4NCg0K
TUNBX01JU0MwIGlzIGFsd2F5cyBhdmFpbGFibGUgZm9yIGVhY2ggTUNBIGJhbmsuIE1DQV9NSVND
MSB0aHJvdWdoDQpNQ0FfTUlTQzQgYXJlIGNvbnNpZGVyZWQgYXZhaWxhYmxlIGlmIE1DQV9NSVND
MFtCbGtQdHJdPTEuDQoNCkNhY2hlIHRoZSB2YWx1ZSBvZiBNQ0FfTUlTQzBbQmxrUHRyXSBmb3Ig
ZWFjaCBiYW5rIGFuZCBwZXIgQ1BVLiBUaGlzDQpuZWVkcyB0byBiZSBkb25lIG9ubHkgZHVyaW5n
IGluaXQuIFRoZSB2YWx1ZXMgc2hvdWxkIGJlIHNhdmVkIHBlciBDUFUNCnRvIGFjY29tbW9kYXRl
IGhldGVyb2dlbmVvdXMgU01DQSBzeXN0ZW1zLg0KDQpSZWRvIHNtY2FfZ2V0X2Jsb2NrX2FkZHJl
c3MoKSB0byBkaXJlY3RseSByZXR1cm4gdGhlIGJsb2NrIGFkZHJlc3Nlcy4NClVzZSB0aGUgY2Fj
aGVkIEJsb2NrIFBvaW50ZXIgdmFsdWUgdG8gZGVjaWRlIGlmIHRoZSBNQ0FfTUlTQzEtNA0KYWRk
cmVzc2VzIHNob3VsZCBiZSByZXR1cm5lZC4NCg0KU2lnbmVkLW9mZi1ieTogWWF6ZW4gR2hhbm5h
bSA8eWF6ZW4uZ2hhbm5hbUBhbWQuY29tPg0KLS0tDQpMaW5rOg0KaHR0cHM6Ly9sa21sLmtlcm5l
bC5vcmcvci8yMDE5MDQwODE0MTIwNS4xMjM3Ni00LVlhemVuLkdoYW5uYW1AYW1kLmNvbQ0KDQp2
MS0+djI6DQoqIE5vIGNoYW5nZS4NCg0KIGFyY2gveDg2L2tlcm5lbC9jcHUvbWNlL2FtZC5jIHwg
NzEgKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0NCiAxIGZpbGUgY2hhbmdlZCwg
MzUgaW5zZXJ0aW9ucygrKSwgMzYgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9hcmNoL3g4
Ni9rZXJuZWwvY3B1L21jZS9hbWQuYyBiL2FyY2gveDg2L2tlcm5lbC9jcHUvbWNlL2FtZC5jDQpp
bmRleCBlNjRkZTUxNDllNTAuLmYwNjQ0YjU5ODQ4ZCAxMDA2NDQNCi0tLSBhL2FyY2gveDg2L2tl
cm5lbC9jcHUvbWNlL2FtZC5jDQorKysgYi9hcmNoL3g4Ni9rZXJuZWwvY3B1L21jZS9hbWQuYw0K
QEAgLTEwMSwxMSArMTAxLDYgQEAgc3RhdGljIHN0cnVjdCBzbWNhX2JhbmtfbmFtZSBzbWNhX25h
bWVzW10gPSB7DQogCVtTTUNBX1BDSUVdCT0geyAicGNpZSIsCQkiUENJIEV4cHJlc3MgVW5pdCIg
fSwNCiB9Ow0KIA0KLXN0YXRpYyB1MzIgc21jYV9iYW5rX2FkZHJzW01BWF9OUl9CQU5LU11bTlJf
QkxPQ0tTXSBfX3JvX2FmdGVyX2luaXQgPQ0KLXsNCi0JWzAgLi4uIE1BWF9OUl9CQU5LUyAtIDFd
ID0geyBbMCAuLi4gTlJfQkxPQ0tTIC0gMV0gPSAtMSB9DQotfTsNCi0NCiBzdGF0aWMgY29uc3Qg
Y2hhciAqc21jYV9nZXRfbmFtZShlbnVtIHNtY2FfYmFua190eXBlcyB0KQ0KIHsNCiAJaWYgKHQg
Pj0gTl9TTUNBX0JBTktfVFlQRVMpDQpAQCAtMTk4LDYgKzE5Myw3IEBAIHN0YXRpYyBjaGFyIGJ1
Zl9tY2F0eXBlW01BWF9NQ0FUWVBFX05BTUVfTEVOXTsNCiANCiBzdGF0aWMgREVGSU5FX1BFUl9D
UFUoc3RydWN0IHRocmVzaG9sZF9iYW5rICoqLCB0aHJlc2hvbGRfYmFua3MpOw0KIHN0YXRpYyBE
RUZJTkVfUEVSX0NQVSh1bnNpZ25lZCBpbnQsIGJhbmtfbWFwKTsJLyogc2VlIHdoaWNoIGJhbmtz
IGFyZSBvbiAqLw0KK3N0YXRpYyBERUZJTkVfUEVSX0NQVSh1MzIsIHNtY2FfYmxrcHRyX21hcCk7
IC8qIHNlZSB3aGljaCBiYW5rcyB1c2UgQmxrUHRyICovDQogDQogc3RhdGljIHZvaWQgYW1kX3Ro
cmVzaG9sZF9pbnRlcnJ1cHQodm9pZCk7DQogc3RhdGljIHZvaWQgYW1kX2RlZmVycmVkX2Vycm9y
X2ludGVycnVwdCh2b2lkKTsNCkBAIC0yMDgsNiArMjA0LDI4IEBAIHN0YXRpYyB2b2lkIGRlZmF1
bHRfZGVmZXJyZWRfZXJyb3JfaW50ZXJydXB0KHZvaWQpDQogfQ0KIHZvaWQgKCpkZWZlcnJlZF9l
cnJvcl9pbnRfdmVjdG9yKSh2b2lkKSA9IGRlZmF1bHRfZGVmZXJyZWRfZXJyb3JfaW50ZXJydXB0
Ow0KIA0KK3N0YXRpYyB2b2lkIHNtY2Ffc2V0X2Jsa3B0cl9tYXAodW5zaWduZWQgaW50IGJhbmss
IHVuc2lnbmVkIGludCBjcHUpDQorew0KKwl1MzIgbG93LCBoaWdoOw0KKw0KKwkvKg0KKwkgKiBG
b3IgU01DQSBlbmFibGVkIHByb2Nlc3NvcnMsIEJMS1BUUiBmaWVsZCBvZiB0aGUgZmlyc3QgTUlT
QyByZWdpc3Rlcg0KKwkgKiAoTUN4X01JU0MwKSBpbmRpY2F0ZXMgcHJlc2VuY2Ugb2YgYWRkaXRp
b25hbCBNSVNDIHJlZ3Mgc2V0IChNSVNDMS00KS4NCisJICovDQorCWlmIChyZG1zcl9zYWZlKE1T
Ul9BTUQ2NF9TTUNBX01DeF9DT05GSUcoYmFuayksICZsb3csICZoaWdoKSkNCisJCXJldHVybjsN
CisNCisJaWYgKCEobG93ICYgTUNJX0NPTkZJR19NQ0FYKSkNCisJCXJldHVybjsNCisNCisJaWYg
KHJkbXNyX3NhZmUoTVNSX0FNRDY0X1NNQ0FfTUN4X01JU0MoYmFuayksICZsb3csICZoaWdoKSkN
CisJCXJldHVybjsNCisNCisJaWYgKGxvdyAmIE1BU0tfQkxLUFRSX0xPKQ0KKwkJcGVyX2NwdShz
bWNhX2Jsa3B0cl9tYXAsIGNwdSkgfD0gMSA8PCBiYW5rOw0KKw0KK30NCisNCiBzdGF0aWMgdm9p
ZCBzbWNhX2NvbmZpZ3VyZSh1bnNpZ25lZCBpbnQgYmFuaywgdW5zaWduZWQgaW50IGNwdSkNCiB7
DQogCXVuc2lnbmVkIGludCBpLCBod2lkX21jYXR5cGU7DQpAQCAtMjQ1LDYgKzI2Myw4IEBAIHN0
YXRpYyB2b2lkIHNtY2FfY29uZmlndXJlKHVuc2lnbmVkIGludCBiYW5rLCB1bnNpZ25lZCBpbnQg
Y3B1KQ0KIAkJd3Jtc3Ioc21jYV9jb25maWcsIGxvdywgaGlnaCk7DQogCX0NCiANCisJc21jYV9z
ZXRfYmxrcHRyX21hcChiYW5rLCBjcHUpOw0KKw0KIAkvKiBSZXR1cm4gZWFybHkgaWYgdGhpcyBi
YW5rIHdhcyBhbHJlYWR5IGluaXRpYWxpemVkLiAqLw0KIAlpZiAoc21jYV9iYW5rc1tiYW5rXS5o
d2lkKQ0KIAkJcmV0dXJuOw0KQEAgLTQ1NSw0MiArNDc1LDIxIEBAIHN0YXRpYyB2b2lkIGRlZmVy
cmVkX2Vycm9yX2ludGVycnVwdF9lbmFibGUoc3RydWN0IGNwdWluZm9feDg2ICpjKQ0KIAl3cm1z
cihNU1JfQ1VfREVGX0VSUiwgbG93LCBoaWdoKTsNCiB9DQogDQotc3RhdGljIHUzMiBzbWNhX2dl
dF9ibG9ja19hZGRyZXNzKHVuc2lnbmVkIGludCBiYW5rLCB1bnNpZ25lZCBpbnQgYmxvY2spDQor
c3RhdGljIHUzMiBzbWNhX2dldF9ibG9ja19hZGRyZXNzKHVuc2lnbmVkIGludCBiYW5rLCB1bnNp
Z25lZCBpbnQgYmxvY2ssDQorCQkJCSAgdW5zaWduZWQgaW50IGNwdSkNCiB7DQotCXUzMiBsb3cs
IGhpZ2g7DQotCXUzMiBhZGRyID0gMDsNCi0NCi0JaWYgKHNtY2FfZ2V0X2JhbmtfdHlwZShiYW5r
KSA9PSBTTUNBX1JFU0VSVkVEKQ0KLQkJcmV0dXJuIGFkZHI7DQotDQogCWlmICghYmxvY2spDQog
CQlyZXR1cm4gTVNSX0FNRDY0X1NNQ0FfTUN4X01JU0MoYmFuayk7DQogDQotCS8qIENoZWNrIG91
ciBjYWNoZSBmaXJzdDogKi8NCi0JaWYgKHNtY2FfYmFua19hZGRyc1tiYW5rXVtibG9ja10gIT0g
LTEpDQotCQlyZXR1cm4gc21jYV9iYW5rX2FkZHJzW2JhbmtdW2Jsb2NrXTsNCi0NCi0JLyoNCi0J
ICogRm9yIFNNQ0EgZW5hYmxlZCBwcm9jZXNzb3JzLCBCTEtQVFIgZmllbGQgb2YgdGhlIGZpcnN0
IE1JU0MgcmVnaXN0ZXINCi0JICogKE1DeF9NSVNDMCkgaW5kaWNhdGVzIHByZXNlbmNlIG9mIGFk
ZGl0aW9uYWwgTUlTQyByZWdzIHNldCAoTUlTQzEtNCkuDQotCSAqLw0KLQlpZiAocmRtc3Jfc2Fm
ZShNU1JfQU1ENjRfU01DQV9NQ3hfQ09ORklHKGJhbmspLCAmbG93LCAmaGlnaCkpDQotCQlnb3Rv
IG91dDsNCi0NCi0JaWYgKCEobG93ICYgTUNJX0NPTkZJR19NQ0FYKSkNCi0JCWdvdG8gb3V0Ow0K
LQ0KLQlpZiAoIXJkbXNyX3NhZmUoTVNSX0FNRDY0X1NNQ0FfTUN4X01JU0MoYmFuayksICZsb3cs
ICZoaWdoKSAmJg0KLQkgICAgKGxvdyAmIE1BU0tfQkxLUFRSX0xPKSkNCi0JCWFkZHIgPSBNU1Jf
QU1ENjRfU01DQV9NQ3hfTUlTQ3koYmFuaywgYmxvY2sgLSAxKTsNCisJaWYgKCEocGVyX2NwdShz
bWNhX2Jsa3B0cl9tYXAsIGNwdSkgJiAoMSA8PCBiYW5rKSkpDQorCQlyZXR1cm4gMDsNCiANCi1v
dXQ6DQotCXNtY2FfYmFua19hZGRyc1tiYW5rXVtibG9ja10gPSBhZGRyOw0KLQlyZXR1cm4gYWRk
cjsNCisJcmV0dXJuIE1TUl9BTUQ2NF9TTUNBX01DeF9NSVNDeShiYW5rLCBibG9jayAtIDEpOw0K
IH0NCiANCiBzdGF0aWMgdTMyIGdldF9ibG9ja19hZGRyZXNzKHUzMiBjdXJyZW50X2FkZHIsIHUz
MiBsb3csIHUzMiBoaWdoLA0KLQkJCSAgICAgdW5zaWduZWQgaW50IGJhbmssIHVuc2lnbmVkIGlu
dCBibG9jaykNCisJCQkgICAgIHVuc2lnbmVkIGludCBiYW5rLCB1bnNpZ25lZCBpbnQgYmxvY2ss
DQorCQkJICAgICB1bnNpZ25lZCBpbnQgY3B1KQ0KIHsNCiAJdTMyIGFkZHIgPSAwLCBvZmZzZXQg
PSAwOw0KIA0KQEAgLTQ5OCw3ICs0OTcsNyBAQCBzdGF0aWMgdTMyIGdldF9ibG9ja19hZGRyZXNz
KHUzMiBjdXJyZW50X2FkZHIsIHUzMiBsb3csIHUzMiBoaWdoLA0KIAkJcmV0dXJuIGFkZHI7DQog
DQogCWlmIChtY2VfZmxhZ3Muc21jYSkNCi0JCXJldHVybiBzbWNhX2dldF9ibG9ja19hZGRyZXNz
KGJhbmssIGJsb2NrKTsNCisJCXJldHVybiBzbWNhX2dldF9ibG9ja19hZGRyZXNzKGJhbmssIGJs
b2NrLCBjcHUpOw0KIA0KIAkvKiBGYWxsIGJhY2sgdG8gbWV0aG9kIHdlIHVzZWQgZm9yIG9sZGVy
IHByb2Nlc3NvcnM6ICovDQogCXN3aXRjaCAoYmxvY2spIHsNCkBAIC02MTEsNyArNjEwLDcgQEAg
dm9pZCBtY2VfYW1kX2ZlYXR1cmVfaW5pdChzdHJ1Y3QgY3B1aW5mb194ODYgKmMpDQogCQkJc21j
YV9jb25maWd1cmUoYmFuaywgY3B1KTsNCiANCiAJCWZvciAoYmxvY2sgPSAwOyBibG9jayA8IE5S
X0JMT0NLUzsgKytibG9jaykgew0KLQkJCWFkZHJlc3MgPSBnZXRfYmxvY2tfYWRkcmVzcyhhZGRy
ZXNzLCBsb3csIGhpZ2gsIGJhbmssIGJsb2NrKTsNCisJCQlhZGRyZXNzID0gZ2V0X2Jsb2NrX2Fk
ZHJlc3MoYWRkcmVzcywgbG93LCBoaWdoLCBiYW5rLCBibG9jaywgY3B1KTsNCiAJCQlpZiAoIWFk
ZHJlc3MpDQogCQkJCWJyZWFrOw0KIA0KQEAgLTEyMjgsNyArMTIyNyw3IEBAIHN0YXRpYyBpbnQg
YWxsb2NhdGVfdGhyZXNob2xkX2Jsb2Nrcyh1bnNpZ25lZCBpbnQgY3B1LCB1bnNpZ25lZCBpbnQg
YmFuaywNCiAJaWYgKGVycikNCiAJCWdvdG8gb3V0X2ZyZWU7DQogcmVjdXJzZToNCi0JYWRkcmVz
cyA9IGdldF9ibG9ja19hZGRyZXNzKGFkZHJlc3MsIGxvdywgaGlnaCwgYmFuaywgKytibG9jayk7
DQorCWFkZHJlc3MgPSBnZXRfYmxvY2tfYWRkcmVzcyhhZGRyZXNzLCBsb3csIGhpZ2gsIGJhbmss
ICsrYmxvY2ssIGNwdSk7DQogCWlmICghYWRkcmVzcykNCiAJCXJldHVybiAwOw0KIA0KLS0gDQoy
LjE3LjENCg0K
