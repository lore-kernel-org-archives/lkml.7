Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBD3EC4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:57:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9182421939
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:57:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="c3XNRlqm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387697AbfCVL5g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:57:36 -0400
Received: from mail-eopbgr750088.outbound.protection.outlook.com ([40.107.75.88]:59370
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387680AbfCVL5e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:57:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AkItXx/ZFKpKh6NpIZIxqhEx1PGHZOGdqgUXxMS0YHg=;
 b=c3XNRlqmuhvM118EsfK8mAkGfiFVkqjPKpADtEJbibYI6yh2RnuKwzUx0uSN6Ilp7/daz8ii6Gv2qFDLCEUf3BoPbmZu6AI1E5QkeD4c8FYCtnQClwMNvLuFxQQ6lHQLcN4SiwWtfwCLhyMO2HzvPbRu4nYB7NPwNNWuvxacpCY=
Received: from DM6PR12MB2844.namprd12.prod.outlook.com (20.176.117.96) by
 DM6PR12MB2811.namprd12.prod.outlook.com (20.176.117.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.15; Fri, 22 Mar 2019 11:57:31 +0000
Received: from DM6PR12MB2844.namprd12.prod.outlook.com
 ([fe80::3589:a066:e1d:b1f0]) by DM6PR12MB2844.namprd12.prod.outlook.com
 ([fe80::3589:a066:e1d:b1f0%5]) with mapi id 15.20.1709.015; Fri, 22 Mar 2019
 11:57:31 +0000
From:   "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
CC:     "joro@8bytes.org" <joro@8bytes.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>
Subject: [PATCH 3/6] svm: Add support for APIC_ACCESS_PAGE_PRIVATE_MEMSLOT
 setup/destroy
Thread-Topic: [PATCH 3/6] svm: Add support for
 APIC_ACCESS_PAGE_PRIVATE_MEMSLOT setup/destroy
Thread-Index: AQHU4KZuc7R0vj5ZskiFGY4oB385Jg==
Date:   Fri, 22 Mar 2019 11:57:31 +0000
Message-ID: <20190322115702.10166-4-suravee.suthikulpanit@amd.com>
References: <20190322115702.10166-1-suravee.suthikulpanit@amd.com>
In-Reply-To: <20190322115702.10166-1-suravee.suthikulpanit@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [124.121.138.205]
x-clientproxiedby: SG2P274CA0022.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::34)
 To DM6PR12MB2844.namprd12.prod.outlook.com (2603:10b6:5:45::32)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Suravee.Suthikulpanit@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b087b000-b7c9-422b-9b3a-08d6aebd9060
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM6PR12MB2811;
x-ms-traffictypediagnostic: DM6PR12MB2811:
x-microsoft-antispam-prvs: <DM6PR12MB281149FF3948D0FBFC7B564BF3430@DM6PR12MB2811.namprd12.prod.outlook.com>
x-forefront-prvs: 09840A4839
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(39860400002)(366004)(136003)(346002)(396003)(376002)(199004)(189003)(52116002)(71190400001)(86362001)(105586002)(7736002)(5660300002)(186003)(106356001)(53936002)(25786009)(76176011)(316002)(4326008)(14454004)(71200400001)(99286004)(110136005)(97736004)(102836004)(26005)(54906003)(386003)(2906002)(11346002)(478600001)(2501003)(66066001)(6486002)(6512007)(6506007)(68736007)(14444005)(256004)(446003)(36756003)(476003)(72206003)(486006)(1076003)(6116002)(81156014)(3846002)(8936002)(2616005)(8676002)(81166006)(305945005)(50226002)(6436002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB2811;H:DM6PR12MB2844.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: AKygTUcmWnKTW9TFbikQYzv3G8m6h6h28OAJbYXnlTMi8z5EnGdpuU15LX7/uNKtS3l+opOUw/FeCEXob9VLaqO/b+/pnEgOm0TojjwbR/bldmZgwAlRXuMx0JiaYrywl8R7OUSkUdCguAf3dLUM9ST9X3LS/kxA+m7uhSqigdfntGHXpOr/cOXO9Cugz0Bmv5LS/XdNQQ+qZKxsfLdiAmXV0YUzxoZ0JeeixE/MmuWRjdo5YzLEiERGmWPRS7J5unn104vImJlq41Xtw/SiU1XKdremqPto4N7sMFzd8MkIz3qSAKxc8UMFRBR/5HzYHRqquzEBeiZ67KIBBF2h0JtJk1Te6tbATM5nvkL9Km56mvHxVU1cV+zC+c6iwV7DxVmMaV18A46mxq/HeHEHAnn3gv1xRrS+BRHmuCCx7m0=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FC2D28B3A1DBCE499E58F45CEC1F99AE@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b087b000-b7c9-422b-9b3a-08d6aebd9060
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2019 11:57:31.6868
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2811
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWN0aXZhdGUvZGVhY3RpdmF0ZSBBVklDIHJlcXVpcmVzIHNldHRpbmcvdW5zZXR0aW5nIHRoZSBt
ZW1vcnkgcmVnaW9uIHVzZWQNCmZvciBBUElDX0FDQ0VTU19QQUdFX1BSSVZBVEVfTUVNU0xPVC4g
U28sIHJlLWZhY3RvciBhdmljX2luaXRfYWNjZXNzX3BhZ2UoKQ0KdG8gYXZpY19zZXR1cF9hY2Nl
c3NfcGFnZSgpIGFuZCBhZGQgc3JjdV9yZWFkX2xvY2svdW5sb2NrLCB3aGljaCBhcmUgbmVlZGVk
DQp0byBhbGxvdyB0aGlzIGZ1bmN0aW9uIHRvIGJlIGNhbGxlZCBkdXJpbmcgcnVuLXRpbWUuDQoN
CkFsc28sIGludHJvZHVjZSBhdmljX2Rlc3Ryb3lfYWNjZXNzX3BhZ2UoKSB0byB1bnNldCB0aGUg
cGFnZSB3aGVuDQpkZWFjdGl2YXRlIEFWSUMuDQoNClNpZ25lZC1vZmYtYnk6IFN1cmF2ZWUgU3V0
aGlrdWxwYW5pdCA8c3VyYXZlZS5zdXRoaWt1bHBhbml0QGFtZC5jb20+DQotLS0NCiBhcmNoL3g4
Ni9rdm0vc3ZtLmMgfCAyOCArKysrKysrKysrKysrKysrKysrKysrKysrKy0tDQogMSBmaWxlIGNo
YW5nZWQsIDI2IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9h
cmNoL3g4Ni9rdm0vc3ZtLmMgYi9hcmNoL3g4Ni9rdm0vc3ZtLmMNCmluZGV4IDRjZjkzYTcyOWFk
OC4uZjQxZjM0ZjcwZGRlIDEwMDY0NA0KLS0tIGEvYXJjaC94ODYva3ZtL3N2bS5jDQorKysgYi9h
cmNoL3g4Ni9rdm0vc3ZtLmMNCkBAIC0xNjY2LDcgKzE2NjYsNyBAQCBzdGF0aWMgdTY0ICphdmlj
X2dldF9waHlzaWNhbF9pZF9lbnRyeShzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUsDQogICogZmllbGQg
b2YgdGhlIFZNQ0IuIFRoZXJlZm9yZSwgd2Ugc2V0IHVwIHRoZQ0KICAqIEFQSUNfQUNDRVNTX1BB
R0VfUFJJVkFURV9NRU1TTE9UICg0S0IpIGhlcmUuDQogICovDQotc3RhdGljIGludCBhdmljX2lu
aXRfYWNjZXNzX3BhZ2Uoc3RydWN0IGt2bV92Y3B1ICp2Y3B1KQ0KK3N0YXRpYyBpbnQgYXZpY19z
ZXR1cF9hY2Nlc3NfcGFnZShzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUsIGJvb2wgaW5pdCkNCiB7DQog
CXN0cnVjdCBrdm0gKmt2bSA9IHZjcHUtPmt2bTsNCiAJaW50IHJldCA9IDA7DQpAQCAtMTY3NSwx
MCArMTY3NSwxNCBAQCBzdGF0aWMgaW50IGF2aWNfaW5pdF9hY2Nlc3NfcGFnZShzdHJ1Y3Qga3Zt
X3ZjcHUgKnZjcHUpDQogCWlmIChrdm0tPmFyY2guYXBpY19hY2Nlc3NfcGFnZV9kb25lKQ0KIAkJ
Z290byBvdXQ7DQogDQorCWlmICghaW5pdCkNCisJCXNyY3VfcmVhZF91bmxvY2soJmt2bS0+c3Jj
dSwgdmNwdS0+c3JjdV9pZHgpOw0KIAlyZXQgPSBfX3g4Nl9zZXRfbWVtb3J5X3JlZ2lvbihrdm0s
DQogCQkJCSAgICAgIEFQSUNfQUNDRVNTX1BBR0VfUFJJVkFURV9NRU1TTE9ULA0KIAkJCQkgICAg
ICBBUElDX0RFRkFVTFRfUEhZU19CQVNFLA0KIAkJCQkgICAgICBQQUdFX1NJWkUpOw0KKwlpZiAo
IWluaXQpDQorCQl2Y3B1LT5zcmN1X2lkeCA9IHNyY3VfcmVhZF9sb2NrKCZrdm0tPnNyY3UpOw0K
IAlpZiAocmV0KQ0KIAkJZ290byBvdXQ7DQogDQpAQCAtMTY4OCw2ICsxNjkyLDI2IEBAIHN0YXRp
YyBpbnQgYXZpY19pbml0X2FjY2Vzc19wYWdlKHN0cnVjdCBrdm1fdmNwdSAqdmNwdSkNCiAJcmV0
dXJuIHJldDsNCiB9DQogDQorc3RhdGljIHZvaWQgYXZpY19kZXN0cm95X2FjY2Vzc19wYWdlKHN0
cnVjdCBrdm1fdmNwdSAqdmNwdSkNCit7DQorCXN0cnVjdCBrdm0gKmt2bSA9IHZjcHUtPmt2bTsN
CisNCisJbXV0ZXhfbG9jaygma3ZtLT5zbG90c19sb2NrKTsNCisNCisJaWYgKCFrdm0tPmFyY2gu
YXBpY19hY2Nlc3NfcGFnZV9kb25lKQ0KKwkJZ290byBvdXQ7DQorDQorCXNyY3VfcmVhZF91bmxv
Y2soJmt2bS0+c3JjdSwgdmNwdS0+c3JjdV9pZHgpOw0KKwlfX3g4Nl9zZXRfbWVtb3J5X3JlZ2lv
bihrdm0sDQorCQkJCUFQSUNfQUNDRVNTX1BBR0VfUFJJVkFURV9NRU1TTE9ULA0KKwkJCQlBUElD
X0RFRkFVTFRfUEhZU19CQVNFLA0KKwkJCQkwKTsNCisJdmNwdS0+c3JjdV9pZHggPSBzcmN1X3Jl
YWRfbG9jaygma3ZtLT5zcmN1KTsNCisJa3ZtLT5hcmNoLmFwaWNfYWNjZXNzX3BhZ2VfZG9uZSA9
IGZhbHNlOw0KK291dDoNCisJbXV0ZXhfdW5sb2NrKCZrdm0tPnNsb3RzX2xvY2spOw0KK30NCisN
CiBzdGF0aWMgaW50IGF2aWNfaW5pdF9iYWNraW5nX3BhZ2Uoc3RydWN0IGt2bV92Y3B1ICp2Y3B1
KQ0KIHsNCiAJaW50IHJldDsNCkBAIC0xNjk1LDcgKzE3MTksNyBAQCBzdGF0aWMgaW50IGF2aWNf
aW5pdF9iYWNraW5nX3BhZ2Uoc3RydWN0IGt2bV92Y3B1ICp2Y3B1KQ0KIAlpbnQgaWQgPSB2Y3B1
LT52Y3B1X2lkOw0KIAlzdHJ1Y3QgdmNwdV9zdm0gKnN2bSA9IHRvX3N2bSh2Y3B1KTsNCiANCi0J
cmV0ID0gYXZpY19pbml0X2FjY2Vzc19wYWdlKHZjcHUpOw0KKwlyZXQgPSBhdmljX3NldHVwX2Fj
Y2Vzc19wYWdlKHZjcHUsIHRydWUpOw0KIAlpZiAocmV0KQ0KIAkJcmV0dXJuIHJldDsNCiANCi0t
IA0KMi4xNy4xDQoNCg==
