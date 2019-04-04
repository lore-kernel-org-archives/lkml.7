Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 402D3C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 21:26:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED8C52171F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 21:26:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="XptcP6eb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730770AbfDDVZ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 17:25:58 -0400
Received: from mail-eopbgr740047.outbound.protection.outlook.com ([40.107.74.47]:6544
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730674AbfDDVZ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 17:25:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ElAlkD+uZhbpdj0DyT5bL5qT98VOJp68BileWw2osEI=;
 b=XptcP6ebLNgEPvo54ipo3JMJlVsSjz9lyzvarKxoCegUenUNvT9HbLawT1FlGLXzAHaTh7L4htI07o7+ZaWWyOcZVYH2LCURpCFodC4ZXSK8P3pmWKkmt0burUpjNsn61jwUxySrW4QDxGynbY48/DYIYfD3paMlYzfwAvyl43I=
Received: from SN6PR12MB2736.namprd12.prod.outlook.com (52.135.107.27) by
 SN6PR12MB2845.namprd12.prod.outlook.com (52.135.102.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.17; Thu, 4 Apr 2019 21:25:49 +0000
Received: from SN6PR12MB2736.namprd12.prod.outlook.com
 ([fe80::65cb:af55:6bd4:55a]) by SN6PR12MB2736.namprd12.prod.outlook.com
 ([fe80::65cb:af55:6bd4:55a%4]) with mapi id 15.20.1750.017; Thu, 4 Apr 2019
 21:25:49 +0000
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
Subject: [PATCH v2 2/7] acpi/cppc: Ensure only supported CPPC sysfs entries
 are created
Thread-Topic: [PATCH v2 2/7] acpi/cppc: Ensure only supported CPPC sysfs
 entries are created
Thread-Index: AQHU6yz5Jgs7bPb6v0m5gJ5fN3WRzg==
Date:   Thu, 4 Apr 2019 21:25:49 +0000
Message-ID: <71114f283852625e3d88cd76ca4f8ac1fd8c25fa.1554410643.git.Janakarajan.Natarajan@amd.com>
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
x-ms-office365-filtering-correlation-id: 55d53135-e4a5-41e0-d400-08d6b9441b6c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:SN6PR12MB2845;
x-ms-traffictypediagnostic: SN6PR12MB2845:
x-microsoft-antispam-prvs: <SN6PR12MB2845A49D80A90591728A9941E7500@SN6PR12MB2845.namprd12.prod.outlook.com>
x-forefront-prvs: 0997523C40
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(376002)(396003)(366004)(346002)(199004)(189003)(305945005)(5660300002)(26005)(102836004)(105586002)(66066001)(118296001)(8676002)(106356001)(6116002)(3846002)(81156014)(97736004)(68736007)(53936002)(81166006)(316002)(7736002)(2201001)(50226002)(71190400001)(71200400001)(86362001)(6512007)(2501003)(8936002)(99286004)(25786009)(36756003)(256004)(4326008)(6486002)(478600001)(186003)(110136005)(486006)(14454004)(54906003)(446003)(72206003)(11346002)(2906002)(52116002)(2616005)(476003)(6506007)(386003)(76176011)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2845;H:SN6PR12MB2736.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 2q074iE+Oam0Q2U1Ev9TmvW6UH/08+qiVUVZu5FBC6RuwXDshbsqvD/SI8+kH4gHsqRdQjUXDXAfAmne3WkPAFkg4aWqi1rf7U6AcP8X5i7RfMXNmFm56V9EXHNQXP9UOXujOqzCiFmkEokq/u0M07UaLHckSOI4f5Du9UavEPgML77JekunusTIaIPfereab7HqfdO4IE9OiAS906mWvbMCWnBXmDn/bm0GDKYBFSK+sD/f2iyPD4PiRFvxSzl+bwG5N1Ge0PcWaHQkJDWAFfXuNZgUP00j2jnoNVwNgu+5FvIAN+MlODs87P1LprXyy4ykEC0XZy3Bip8kpesojBW8hv9rdMK9poiLLlva3vsnd7HfSmKlaXE9ExpJ6IVXbkkHRincvhGHsXQs0Pel1FFq2oMr1VOI9mKzxfgN1hM=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55d53135-e4a5-41e0-d400-08d6b9441b6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2019 21:25:49.2588
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2845
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIGF0dHJpYnV0ZXMgZm9yIHJlZ2lzdGVycyB0aGF0IGFyZSBzdXBwb3J0ZWQgYnkgdGhlIHBs
YXRmb3JtLiBUaGlzIHByZXZlbnRzDQp1bnN1cHBvcnRlZCBvcHRpb25hbCByZWdpc3RlcnMgZnJv
bSBoYXZpbmcgc3lzZnMgZW50cmllcyBjcmVhdGVkLg0KDQpBbHNvLCBhZGQgYSBtYWNybyBSRUdf
U1VQUE9SVEVEIHdoaWNoIHdpbGwgZGVjaWRlIG9uIHRoZSBjaGVjayB0byBwZXJmb3JtDQpiYXNl
ZCBvbiB0aGUgdHlwZSBvZiByZWdpc3Rlci4NCg0KU2lnbmVkLW9mZi1ieTogSmFuYWthcmFqYW4g
TmF0YXJhamFuIDxKYW5ha2FyYWphbi5OYXRhcmFqYW5AYW1kLmNvbT4NCi0tLQ0KIGRyaXZlcnMv
YWNwaS9jcHBjX2FjcGkuYyB8IDEwMCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKyst
LS0tLS0NCiAxIGZpbGUgY2hhbmdlZCwgODYgaW5zZXJ0aW9ucygrKSwgMTQgZGVsZXRpb25zKC0p
DQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2FjcGkvY3BwY19hY3BpLmMgYi9kcml2ZXJzL2FjcGkv
Y3BwY19hY3BpLmMNCmluZGV4IDU2YTA5ZTA1N2M0Zi4uMzcxNTdkMTlkMmRmIDEwMDY0NA0KLS0t
IGEvZHJpdmVycy9hY3BpL2NwcGNfYWNwaS5jDQorKysgYi9kcml2ZXJzL2FjcGkvY3BwY19hY3Bp
LmMNCkBAIC0xODcsMjIgKzE4Nyw4IEBAIHN0YXRpYyBzc2l6ZV90IHNob3dfZmVlZGJhY2tfY3Ry
cyhzdHJ1Y3Qga29iamVjdCAqa29iaiwNCiB9DQogZGVmaW5lX29uZV9jcHBjX3JvKGZlZWRiYWNr
X2N0cnMpOw0KIA0KLXN0YXRpYyBzdHJ1Y3QgYXR0cmlidXRlICpjcHBjX2F0dHJzW10gPSB7DQot
CSZmZWVkYmFja19jdHJzLmF0dHIsDQotCSZyZWZlcmVuY2VfcGVyZi5hdHRyLA0KLQkmd3JhcGFy
b3VuZF90aW1lLmF0dHIsDQotCSZoaWdoZXN0X3BlcmYuYXR0ciwNCi0JJmxvd2VzdF9wZXJmLmF0
dHIsDQotCSZsb3dlc3Rfbm9ubGluZWFyX3BlcmYuYXR0ciwNCi0JJm5vbWluYWxfcGVyZi5hdHRy
LA0KLQkmbm9taW5hbF9mcmVxLmF0dHIsDQotCSZsb3dlc3RfZnJlcS5hdHRyLA0KLQlOVUxMDQot
fTsNCi0NCiBzdGF0aWMgc3RydWN0IGtvYmpfdHlwZSBjcHBjX2t0eXBlID0gew0KIAkuc3lzZnNf
b3BzID0gJmtvYmpfc3lzZnNfb3BzLA0KLQkuZGVmYXVsdF9hdHRycyA9IGNwcGNfYXR0cnMsDQog
fTsNCiANCiBzdGF0aWMgaW50IGNoZWNrX3BjY19jaGFuKGludCBwY2Nfc3NfaWQsIGJvb2wgY2hr
X2Vycl9iaXQpDQpAQCAtNzE3LDYgKzcwMyw4NyBAQCBzdGF0aWMgYm9vbCBpc19jcHBjX3N1cHBv
cnRlZChpbnQgcmV2aXNpb24sIGludCBudW1fZW50KQ0KICAqCX0NCiAgKi8NCiANCitzdGF0aWMg
Ym9vbCBpc19idWZfb25seShpbnQgcmVnX2lkeCkNCit7DQorCXN3aXRjaCAocmVnX2lkeCkgew0K
KwljYXNlIEhJR0hFU1RfUEVSRjoNCisJY2FzZSBOT01JTkFMX1BFUkY6DQorCWNhc2UgTE9XX05P
Tl9MSU5FQVJfUEVSRjoNCisJY2FzZSBMT1dFU1RfUEVSRjoNCisJY2FzZSBDVFJfV1JBUF9USU1F
Og0KKwljYXNlIEFVVE9fU0VMX0VOQUJMRToNCisJY2FzZSBSRUZFUkVOQ0VfUEVSRjoNCisJCXJl
dHVybiBmYWxzZTsNCisJZGVmYXVsdDoNCisJCXJldHVybiB0cnVlOw0KKwl9DQorfQ0KKw0KKyNk
ZWZpbmUgUkVHX1NVUFBPUlRFRChjcGMsIGlkeCkgKGlzX2J1Zl9vbmx5KGlkeCkgPwkJCSAgICBc
DQorCQkJCSBDUENfU1VQX0JVRkZFUl9PTkxZKCZjcGMtPmNwY19yZWdzW2lkeF0pIDogXA0KKwkJ
CQkgQ1BDX1NVUFBPUlRFRCgmY3BjLT5jcGNfcmVnc1tpZHhdKSkNCisNCitzdGF0aWMgaW50IGlz
X21hbmRhdG9yeV9yZWcoaW50IHJlZ19pZHgpDQorew0KKwlzd2l0Y2ggKHJlZ19pZHgpIHsNCisJ
Y2FzZSBISUdIRVNUX1BFUkY6DQorCWNhc2UgTk9NSU5BTF9QRVJGOg0KKwljYXNlIExPV19OT05f
TElORUFSX1BFUkY6DQorCWNhc2UgTE9XRVNUX1BFUkY6DQorCWNhc2UgUkVGRVJFTkNFX0NUUjoN
CisJY2FzZSBERUxJVkVSRURfQ1RSOg0KKwkJcmV0dXJuIDE7DQorCX0NCisNCisJcmV0dXJuIDA7
DQorfQ0KKw0KKyNkZWZpbmUgTUFOREFUT1JZX1JFR19DTlQJNg0KKw0KK3N0YXRpYyBpbnQgc2V0
X2NwcGNfYXR0cnMoc3RydWN0IGNwY19kZXNjICpjcGMsIGludCBlbnRyaWVzKQ0KK3sNCisJaW50
IGksIGF0dHJfaSA9IDAsIG9wdF9yZWdfY250ID0gZW50cmllcyAtIE1BTkRBVE9SWV9SRUdfQ05U
Ow0KKwlzdGF0aWMgc3RydWN0IGF0dHJpYnV0ZSAqKmNwcGNfYXR0cnM7DQorDQorCWNwcGNfYXR0
cnMgPSBrY2FsbG9jKGVudHJpZXMsIHNpemVvZigqY3BwY19hdHRycyksIEdGUF9LRVJORUwpOw0K
KwlpZiAoIWNwcGNfYXR0cnMpDQorCQlyZXR1cm4gLUVOT01FTTsNCisNCisJZm9yIChpID0gMDsg
aSA8IE1BWF9DUENfUkVHX0VOVCAmJiBhdHRyX2kgPCBvcHRfcmVnX2NudDsgaSsrKSB7DQorCQlp
ZiAoaXNfbWFuZGF0b3J5X3JlZyhpKSB8fCAhUkVHX1NVUFBPUlRFRChjcGMsIGkpKQ0KKwkJCWNv
bnRpbnVlOw0KKw0KKwkJc3dpdGNoIChpKSB7DQorCQljYXNlIE5PTUlOQUxfRlJFUToNCisJCQlj
cHBjX2F0dHJzW2F0dHJfaSsrXSA9ICZub21pbmFsX2ZyZXEuYXR0cjsNCisJCQlicmVhazsNCisJ
CWNhc2UgTE9XRVNUX0ZSRVE6DQorCQkJY3BwY19hdHRyc1thdHRyX2krK10gPSAmbG93ZXN0X2Zy
ZXEuYXR0cjsNCisJCQlicmVhazsNCisJCWNhc2UgUkVGRVJFTkNFX1BFUkY6DQorCQkJY3BwY19h
dHRyc1thdHRyX2krK10gPSAmcmVmZXJlbmNlX3BlcmYuYXR0cjsNCisJCQlicmVhazsNCisJCWNh
c2UgQ1RSX1dSQVBfVElNRToNCisJCQljcHBjX2F0dHJzW2F0dHJfaSsrXSA9ICZ3cmFwYXJvdW5k
X3RpbWUuYXR0cjsNCisJCQlicmVhazsNCisJCX0NCisJfQ0KKw0KKwkvKiBTZXQgbWFuZGF0b3J5
IHJlZ3MgKi8NCisJY3BwY19hdHRyc1thdHRyX2krK10gPSAmaGlnaGVzdF9wZXJmLmF0dHI7DQor
CWNwcGNfYXR0cnNbYXR0cl9pKytdID0gJm5vbWluYWxfcGVyZi5hdHRyOw0KKwljcHBjX2F0dHJz
W2F0dHJfaSsrXSA9ICZsb3dlc3Rfbm9ubGluZWFyX3BlcmYuYXR0cjsNCisJY3BwY19hdHRyc1th
dHRyX2krK10gPSAmbG93ZXN0X3BlcmYuYXR0cjsNCisNCisJLyogU2V0IGZlZWRiYWNrX2N0ciBz
eXNmcyBlbnRyeSAqLw0KKwljcHBjX2F0dHJzW2F0dHJfaV0gPSAmZmVlZGJhY2tfY3Rycy5hdHRy
Ow0KKw0KKwkvKiBTZXQga29ial90eXBlIG1lbWJlciAqLw0KKwljcHBjX2t0eXBlLmRlZmF1bHRf
YXR0cnMgPSBjcHBjX2F0dHJzOw0KKw0KKwlyZXR1cm4gMDsNCit9DQorDQogLyoqDQogICogYWNw
aV9jcHBjX3Byb2Nlc3Nvcl9wcm9iZSAtIFNlYXJjaCBmb3IgcGVyIENQVSBfQ1BDIG9iamVjdHMu
DQogICogQHByOiBQdHIgdG8gYWNwaV9wcm9jZXNzb3IgY29udGFpbmluZyB0aGlzIENQVXMgbG9n
aWNhbCBJZC4NCkBAIC04NzEsNiArOTM4LDEwIEBAIGludCBhY3BpX2NwcGNfcHJvY2Vzc29yX3By
b2JlKHN0cnVjdCBhY3BpX3Byb2Nlc3NvciAqcHIpDQogCS8qIFBsdWcgUFNEIGRhdGEgaW50byB0
aGlzIENQVXMgQ1BDIGRlc2NyaXB0b3IuICovDQogCXBlcl9jcHUoY3BjX2Rlc2NfcHRyLCBwci0+
aWQpID0gY3BjX3B0cjsNCiANCisJcmV0ID0gc2V0X2NwcGNfYXR0cnMoY3BjX3B0ciwgbnVtX2Vu
dCAtIDIpOw0KKwlpZiAocmV0KQ0KKwkJZ290byBvdXRfZnJlZTsNCisNCiAJcmV0ID0ga29iamVj
dF9pbml0X2FuZF9hZGQoJmNwY19wdHItPmtvYmosICZjcHBjX2t0eXBlLCAmY3B1X2Rldi0+a29i
aiwNCiAJCQkiYWNwaV9jcHBjIik7DQogCWlmIChyZXQpIHsNCkBAIC05MzIsNiArMTAwMyw3IEBA
IHZvaWQgYWNwaV9jcHBjX3Byb2Nlc3Nvcl9leGl0KHN0cnVjdCBhY3BpX3Byb2Nlc3NvciAqcHIp
DQogCQkJaW91bm1hcChhZGRyKTsNCiAJfQ0KIA0KKwlrZnJlZShjcHBjX2t0eXBlLmRlZmF1bHRf
YXR0cnMpOw0KIAlrb2JqZWN0X3B1dCgmY3BjX3B0ci0+a29iaik7DQogCWtmcmVlKGNwY19wdHIp
Ow0KIH0NCi0tIA0KMi4xNy4xDQoNCg==
