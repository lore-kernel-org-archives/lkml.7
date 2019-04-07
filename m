Return-Path: <SRS0=A1VX=SJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 959B3C10F0E
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 23:14:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B27320663
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 23:14:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="pFMKSSwm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbfDGXOA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 19:14:00 -0400
Received: from mail-eopbgr720042.outbound.protection.outlook.com ([40.107.72.42]:47936
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726493AbfDGXN4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 19:13:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E73TR6y68gaqltlH3rFek819IcbUAFvTktmvAA4M8sk=;
 b=pFMKSSwm/R7eyx2GE4Ck51FaGhGDZENR5nAVeLAJz0Zo6BqvkdhxLIkRhtjH4qTpaubtzVERIjLfNyjNAwXD2RQ8DDQsY99lvBWJyL4OInfjq2eayB4eguPl19/qR5WL6gzqVtJJDrZz+Bw/ESR1MZ/D3EmOWWtBe+JkOFBjcZE=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2768.namprd12.prod.outlook.com (52.135.107.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.16; Sun, 7 Apr 2019 23:13:51 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::9c51:41bf:f88e:f3e8]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::9c51:41bf:f88e:f3e8%2]) with mapi id 15.20.1771.016; Sun, 7 Apr 2019
 23:13:51 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
CC:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@suse.de" <bp@suse.de>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: [PATCH 3/5] x86/MCE/AMD: Don't cache block addresses on SMCA systems
Thread-Topic: [PATCH 3/5] x86/MCE/AMD: Don't cache block addresses on SMCA
 systems
Thread-Index: AQHU7ZeO3wMx2ezEcEGPN5Cf4PrdmA==
Date:   Sun, 7 Apr 2019 23:13:49 +0000
Message-ID: <20190407231331.52362-4-Yazen.Ghannam@amd.com>
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
x-ms-office365-filtering-correlation-id: 28826fc4-b5ec-449d-a033-08d6bbaeb12d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:SN6PR12MB2768;
x-ms-traffictypediagnostic: SN6PR12MB2768:
x-microsoft-antispam-prvs: <SN6PR12MB2768DE9DBE30F3067F839C44F8530@SN6PR12MB2768.namprd12.prod.outlook.com>
x-forefront-prvs: 00003DBFE7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(136003)(39860400002)(346002)(396003)(199004)(189003)(105586002)(99286004)(14454004)(186003)(72206003)(478600001)(106356001)(53936002)(2351001)(3846002)(1076003)(6116002)(54906003)(316002)(102836004)(5660300002)(2906002)(68736007)(6512007)(50226002)(4326008)(36756003)(6506007)(386003)(66066001)(81166006)(97736004)(52116002)(6486002)(7736002)(76176011)(476003)(11346002)(26005)(486006)(2616005)(81156014)(5640700003)(6436002)(8676002)(6916009)(446003)(25786009)(86362001)(14444005)(256004)(71200400001)(2501003)(8936002)(71190400001)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2768;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: N6YWeeakdOTlEIBGAniDgmFPG0Xm69iHolndfEhet0pdSGG+R+d1jfgxh5rvRPjx4mxryHU9cMIuJSIq+jKtoMyvuRV+nq1o1QxgoYeSFGZm42y4wosj8N852BZA1+2+OxzchkcXp7W6NB//Pw203uixZH/6v5DXi/72D/ZCzZEEBky2JsSpk1oPEG9IBo8wx0nnwHwxpRB5tWX8peRxFnayIPb1n8sovzU+K0CAeXqtrWFGoi6a3Zp02oqpTYSQzWgOJSz4gps6Ll6+NGE4AY4wWEnF7DCTvPQv/BEmNxT6xnlPIe8Lc2Sr+7nhXSj7WiRPcU/MFyq91iT+HjMaIb3APlIiGQb+Zeq/CB7vFZxyefaumhMXi7ZXTHZF2boyvhk9ZNmPFRbjKOkpRwivAMA20CbBjU8wP0TO8yUJiY8=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28826fc4-b5ec-449d-a033-08d6bbaeb12d
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2019 23:13:49.3336
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2768
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
bSA8eWF6ZW4uZ2hhbm5hbUBhbWQuY29tPg0KLS0tDQogYXJjaC94ODYva2VybmVsL2NwdS9tY2Uv
YW1kLmMgfCA3MSArKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLQ0KIDEgZmlsZSBj
aGFuZ2VkLCAzNSBpbnNlcnRpb25zKCspLCAzNiBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBh
L2FyY2gveDg2L2tlcm5lbC9jcHUvbWNlL2FtZC5jIGIvYXJjaC94ODYva2VybmVsL2NwdS9tY2Uv
YW1kLmMNCmluZGV4IGU2NGRlNTE0OWU1MC4uZjA2NDRiNTk4NDhkIDEwMDY0NA0KLS0tIGEvYXJj
aC94ODYva2VybmVsL2NwdS9tY2UvYW1kLmMNCisrKyBiL2FyY2gveDg2L2tlcm5lbC9jcHUvbWNl
L2FtZC5jDQpAQCAtMTAxLDExICsxMDEsNiBAQCBzdGF0aWMgc3RydWN0IHNtY2FfYmFua19uYW1l
IHNtY2FfbmFtZXNbXSA9IHsNCiAJW1NNQ0FfUENJRV0JPSB7ICJwY2llIiwJCSJQQ0kgRXhwcmVz
cyBVbml0IiB9LA0KIH07DQogDQotc3RhdGljIHUzMiBzbWNhX2JhbmtfYWRkcnNbTUFYX05SX0JB
TktTXVtOUl9CTE9DS1NdIF9fcm9fYWZ0ZXJfaW5pdCA9DQotew0KLQlbMCAuLi4gTUFYX05SX0JB
TktTIC0gMV0gPSB7IFswIC4uLiBOUl9CTE9DS1MgLSAxXSA9IC0xIH0NCi19Ow0KLQ0KIHN0YXRp
YyBjb25zdCBjaGFyICpzbWNhX2dldF9uYW1lKGVudW0gc21jYV9iYW5rX3R5cGVzIHQpDQogew0K
IAlpZiAodCA+PSBOX1NNQ0FfQkFOS19UWVBFUykNCkBAIC0xOTgsNiArMTkzLDcgQEAgc3RhdGlj
IGNoYXIgYnVmX21jYXR5cGVbTUFYX01DQVRZUEVfTkFNRV9MRU5dOw0KIA0KIHN0YXRpYyBERUZJ
TkVfUEVSX0NQVShzdHJ1Y3QgdGhyZXNob2xkX2JhbmsgKiosIHRocmVzaG9sZF9iYW5rcyk7DQog
c3RhdGljIERFRklORV9QRVJfQ1BVKHVuc2lnbmVkIGludCwgYmFua19tYXApOwkvKiBzZWUgd2hp
Y2ggYmFua3MgYXJlIG9uICovDQorc3RhdGljIERFRklORV9QRVJfQ1BVKHUzMiwgc21jYV9ibGtw
dHJfbWFwKTsgLyogc2VlIHdoaWNoIGJhbmtzIHVzZSBCbGtQdHIgKi8NCiANCiBzdGF0aWMgdm9p
ZCBhbWRfdGhyZXNob2xkX2ludGVycnVwdCh2b2lkKTsNCiBzdGF0aWMgdm9pZCBhbWRfZGVmZXJy
ZWRfZXJyb3JfaW50ZXJydXB0KHZvaWQpOw0KQEAgLTIwOCw2ICsyMDQsMjggQEAgc3RhdGljIHZv
aWQgZGVmYXVsdF9kZWZlcnJlZF9lcnJvcl9pbnRlcnJ1cHQodm9pZCkNCiB9DQogdm9pZCAoKmRl
ZmVycmVkX2Vycm9yX2ludF92ZWN0b3IpKHZvaWQpID0gZGVmYXVsdF9kZWZlcnJlZF9lcnJvcl9p
bnRlcnJ1cHQ7DQogDQorc3RhdGljIHZvaWQgc21jYV9zZXRfYmxrcHRyX21hcCh1bnNpZ25lZCBp
bnQgYmFuaywgdW5zaWduZWQgaW50IGNwdSkNCit7DQorCXUzMiBsb3csIGhpZ2g7DQorDQorCS8q
DQorCSAqIEZvciBTTUNBIGVuYWJsZWQgcHJvY2Vzc29ycywgQkxLUFRSIGZpZWxkIG9mIHRoZSBm
aXJzdCBNSVNDIHJlZ2lzdGVyDQorCSAqIChNQ3hfTUlTQzApIGluZGljYXRlcyBwcmVzZW5jZSBv
ZiBhZGRpdGlvbmFsIE1JU0MgcmVncyBzZXQgKE1JU0MxLTQpLg0KKwkgKi8NCisJaWYgKHJkbXNy
X3NhZmUoTVNSX0FNRDY0X1NNQ0FfTUN4X0NPTkZJRyhiYW5rKSwgJmxvdywgJmhpZ2gpKQ0KKwkJ
cmV0dXJuOw0KKw0KKwlpZiAoIShsb3cgJiBNQ0lfQ09ORklHX01DQVgpKQ0KKwkJcmV0dXJuOw0K
Kw0KKwlpZiAocmRtc3Jfc2FmZShNU1JfQU1ENjRfU01DQV9NQ3hfTUlTQyhiYW5rKSwgJmxvdywg
JmhpZ2gpKQ0KKwkJcmV0dXJuOw0KKw0KKwlpZiAobG93ICYgTUFTS19CTEtQVFJfTE8pDQorCQlw
ZXJfY3B1KHNtY2FfYmxrcHRyX21hcCwgY3B1KSB8PSAxIDw8IGJhbms7DQorDQorfQ0KKw0KIHN0
YXRpYyB2b2lkIHNtY2FfY29uZmlndXJlKHVuc2lnbmVkIGludCBiYW5rLCB1bnNpZ25lZCBpbnQg
Y3B1KQ0KIHsNCiAJdW5zaWduZWQgaW50IGksIGh3aWRfbWNhdHlwZTsNCkBAIC0yNDUsNiArMjYz
LDggQEAgc3RhdGljIHZvaWQgc21jYV9jb25maWd1cmUodW5zaWduZWQgaW50IGJhbmssIHVuc2ln
bmVkIGludCBjcHUpDQogCQl3cm1zcihzbWNhX2NvbmZpZywgbG93LCBoaWdoKTsNCiAJfQ0KIA0K
KwlzbWNhX3NldF9ibGtwdHJfbWFwKGJhbmssIGNwdSk7DQorDQogCS8qIFJldHVybiBlYXJseSBp
ZiB0aGlzIGJhbmsgd2FzIGFscmVhZHkgaW5pdGlhbGl6ZWQuICovDQogCWlmIChzbWNhX2Jhbmtz
W2JhbmtdLmh3aWQpDQogCQlyZXR1cm47DQpAQCAtNDU1LDQyICs0NzUsMjEgQEAgc3RhdGljIHZv
aWQgZGVmZXJyZWRfZXJyb3JfaW50ZXJydXB0X2VuYWJsZShzdHJ1Y3QgY3B1aW5mb194ODYgKmMp
DQogCXdybXNyKE1TUl9DVV9ERUZfRVJSLCBsb3csIGhpZ2gpOw0KIH0NCiANCi1zdGF0aWMgdTMy
IHNtY2FfZ2V0X2Jsb2NrX2FkZHJlc3ModW5zaWduZWQgaW50IGJhbmssIHVuc2lnbmVkIGludCBi
bG9jaykNCitzdGF0aWMgdTMyIHNtY2FfZ2V0X2Jsb2NrX2FkZHJlc3ModW5zaWduZWQgaW50IGJh
bmssIHVuc2lnbmVkIGludCBibG9jaywNCisJCQkJICB1bnNpZ25lZCBpbnQgY3B1KQ0KIHsNCi0J
dTMyIGxvdywgaGlnaDsNCi0JdTMyIGFkZHIgPSAwOw0KLQ0KLQlpZiAoc21jYV9nZXRfYmFua190
eXBlKGJhbmspID09IFNNQ0FfUkVTRVJWRUQpDQotCQlyZXR1cm4gYWRkcjsNCi0NCiAJaWYgKCFi
bG9jaykNCiAJCXJldHVybiBNU1JfQU1ENjRfU01DQV9NQ3hfTUlTQyhiYW5rKTsNCiANCi0JLyog
Q2hlY2sgb3VyIGNhY2hlIGZpcnN0OiAqLw0KLQlpZiAoc21jYV9iYW5rX2FkZHJzW2JhbmtdW2Js
b2NrXSAhPSAtMSkNCi0JCXJldHVybiBzbWNhX2JhbmtfYWRkcnNbYmFua11bYmxvY2tdOw0KLQ0K
LQkvKg0KLQkgKiBGb3IgU01DQSBlbmFibGVkIHByb2Nlc3NvcnMsIEJMS1BUUiBmaWVsZCBvZiB0
aGUgZmlyc3QgTUlTQyByZWdpc3Rlcg0KLQkgKiAoTUN4X01JU0MwKSBpbmRpY2F0ZXMgcHJlc2Vu
Y2Ugb2YgYWRkaXRpb25hbCBNSVNDIHJlZ3Mgc2V0IChNSVNDMS00KS4NCi0JICovDQotCWlmIChy
ZG1zcl9zYWZlKE1TUl9BTUQ2NF9TTUNBX01DeF9DT05GSUcoYmFuayksICZsb3csICZoaWdoKSkN
Ci0JCWdvdG8gb3V0Ow0KLQ0KLQlpZiAoIShsb3cgJiBNQ0lfQ09ORklHX01DQVgpKQ0KLQkJZ290
byBvdXQ7DQotDQotCWlmICghcmRtc3Jfc2FmZShNU1JfQU1ENjRfU01DQV9NQ3hfTUlTQyhiYW5r
KSwgJmxvdywgJmhpZ2gpICYmDQotCSAgICAobG93ICYgTUFTS19CTEtQVFJfTE8pKQ0KLQkJYWRk
ciA9IE1TUl9BTUQ2NF9TTUNBX01DeF9NSVNDeShiYW5rLCBibG9jayAtIDEpOw0KKwlpZiAoIShw
ZXJfY3B1KHNtY2FfYmxrcHRyX21hcCwgY3B1KSAmICgxIDw8IGJhbmspKSkNCisJCXJldHVybiAw
Ow0KIA0KLW91dDoNCi0Jc21jYV9iYW5rX2FkZHJzW2JhbmtdW2Jsb2NrXSA9IGFkZHI7DQotCXJl
dHVybiBhZGRyOw0KKwlyZXR1cm4gTVNSX0FNRDY0X1NNQ0FfTUN4X01JU0N5KGJhbmssIGJsb2Nr
IC0gMSk7DQogfQ0KIA0KIHN0YXRpYyB1MzIgZ2V0X2Jsb2NrX2FkZHJlc3ModTMyIGN1cnJlbnRf
YWRkciwgdTMyIGxvdywgdTMyIGhpZ2gsDQotCQkJICAgICB1bnNpZ25lZCBpbnQgYmFuaywgdW5z
aWduZWQgaW50IGJsb2NrKQ0KKwkJCSAgICAgdW5zaWduZWQgaW50IGJhbmssIHVuc2lnbmVkIGlu
dCBibG9jaywNCisJCQkgICAgIHVuc2lnbmVkIGludCBjcHUpDQogew0KIAl1MzIgYWRkciA9IDAs
IG9mZnNldCA9IDA7DQogDQpAQCAtNDk4LDcgKzQ5Nyw3IEBAIHN0YXRpYyB1MzIgZ2V0X2Jsb2Nr
X2FkZHJlc3ModTMyIGN1cnJlbnRfYWRkciwgdTMyIGxvdywgdTMyIGhpZ2gsDQogCQlyZXR1cm4g
YWRkcjsNCiANCiAJaWYgKG1jZV9mbGFncy5zbWNhKQ0KLQkJcmV0dXJuIHNtY2FfZ2V0X2Jsb2Nr
X2FkZHJlc3MoYmFuaywgYmxvY2spOw0KKwkJcmV0dXJuIHNtY2FfZ2V0X2Jsb2NrX2FkZHJlc3Mo
YmFuaywgYmxvY2ssIGNwdSk7DQogDQogCS8qIEZhbGwgYmFjayB0byBtZXRob2Qgd2UgdXNlZCBm
b3Igb2xkZXIgcHJvY2Vzc29yczogKi8NCiAJc3dpdGNoIChibG9jaykgew0KQEAgLTYxMSw3ICs2
MTAsNyBAQCB2b2lkIG1jZV9hbWRfZmVhdHVyZV9pbml0KHN0cnVjdCBjcHVpbmZvX3g4NiAqYykN
CiAJCQlzbWNhX2NvbmZpZ3VyZShiYW5rLCBjcHUpOw0KIA0KIAkJZm9yIChibG9jayA9IDA7IGJs
b2NrIDwgTlJfQkxPQ0tTOyArK2Jsb2NrKSB7DQotCQkJYWRkcmVzcyA9IGdldF9ibG9ja19hZGRy
ZXNzKGFkZHJlc3MsIGxvdywgaGlnaCwgYmFuaywgYmxvY2spOw0KKwkJCWFkZHJlc3MgPSBnZXRf
YmxvY2tfYWRkcmVzcyhhZGRyZXNzLCBsb3csIGhpZ2gsIGJhbmssIGJsb2NrLCBjcHUpOw0KIAkJ
CWlmICghYWRkcmVzcykNCiAJCQkJYnJlYWs7DQogDQpAQCAtMTIyOCw3ICsxMjI3LDcgQEAgc3Rh
dGljIGludCBhbGxvY2F0ZV90aHJlc2hvbGRfYmxvY2tzKHVuc2lnbmVkIGludCBjcHUsIHVuc2ln
bmVkIGludCBiYW5rLA0KIAlpZiAoZXJyKQ0KIAkJZ290byBvdXRfZnJlZTsNCiByZWN1cnNlOg0K
LQlhZGRyZXNzID0gZ2V0X2Jsb2NrX2FkZHJlc3MoYWRkcmVzcywgbG93LCBoaWdoLCBiYW5rLCAr
K2Jsb2NrKTsNCisJYWRkcmVzcyA9IGdldF9ibG9ja19hZGRyZXNzKGFkZHJlc3MsIGxvdywgaGln
aCwgYmFuaywgKytibG9jaywgY3B1KTsNCiAJaWYgKCFhZGRyZXNzKQ0KIAkJcmV0dXJuIDA7DQog
DQotLSANCjIuMTcuMQ0KDQo=
