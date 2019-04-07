Return-Path: <SRS0=A1VX=SJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8C6DC10F0E
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 23:14:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FE2A206C0
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 23:14:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="GmlG5u8J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbfDGXOH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 19:14:07 -0400
Received: from mail-eopbgr720052.outbound.protection.outlook.com ([40.107.72.52]:46091
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726562AbfDGXOC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 19:14:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ZQCCeEyNFhALcxdlg73b0Wyr3YcQDRnF69KCX8ehyM=;
 b=GmlG5u8JZniRx/3OZ+V3GeOX4X7KUNsrdJ+h9xXmsyRqKscqeuJzV0f5Veo7FEPDXe9jNzjNzUllwZHTEO2G1S387sJU9hKLd03p6KEH+xV1AuwEkUg2ZNrp/JBO8VWccAm6XEEAeujacgAOQkvk7OWtrzTppISAKL6LzmUlU50=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2768.namprd12.prod.outlook.com (52.135.107.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.16; Sun, 7 Apr 2019 23:13:52 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::9c51:41bf:f88e:f3e8]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::9c51:41bf:f88e:f3e8%2]) with mapi id 15.20.1771.016; Sun, 7 Apr 2019
 23:13:52 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
CC:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@suse.de" <bp@suse.de>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: [PATCH 5/5] x86/MCE: Save MCA control bits that get set in hardware
Thread-Topic: [PATCH 5/5] x86/MCE: Save MCA control bits that get set in
 hardware
Thread-Index: AQHU7ZePtqaVptK3KUu4cMxW99nyZw==
Date:   Sun, 7 Apr 2019 23:13:50 +0000
Message-ID: <20190407231331.52362-6-Yazen.Ghannam@amd.com>
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
x-ms-office365-filtering-correlation-id: 606a3b33-27a7-4202-f326-08d6bbaeb1c4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:SN6PR12MB2768;
x-ms-traffictypediagnostic: SN6PR12MB2768:
x-microsoft-antispam-prvs: <SN6PR12MB2768C0AA650EBB6E878137F1F8530@SN6PR12MB2768.namprd12.prod.outlook.com>
x-forefront-prvs: 00003DBFE7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(136003)(39860400002)(346002)(396003)(199004)(189003)(105586002)(99286004)(14454004)(186003)(72206003)(478600001)(106356001)(53936002)(2351001)(3846002)(1076003)(6116002)(54906003)(316002)(102836004)(5660300002)(2906002)(68736007)(6512007)(50226002)(4326008)(36756003)(6506007)(386003)(66066001)(81166006)(97736004)(52116002)(6486002)(7736002)(76176011)(476003)(11346002)(26005)(486006)(2616005)(81156014)(5640700003)(6436002)(8676002)(6916009)(446003)(25786009)(86362001)(256004)(71200400001)(2501003)(8936002)(71190400001)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2768;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 7W58UepPRuK8kayB7mOgtPHyQIWQRNyEVi77C18QKw2I2ROUwGX6FJAIiDRewk654CnlaO9EExwWK1GIHnaJduCGlOXW4EiFVuMMlWM7t/fzmg4PrmxOWxGAbM3ttsiPoiX08wJiXgxBoFTfoeTkTDAE0DkMWIqvJTWF7kOmEHAFI13EORqg+wtqwkPTFtt9rwNKgwhL0orRZ8RZmD4QIxBVL9vBG0T4Dh7UALrpv/JvNlYqoX+aeTQE/kccD7Ev+DDZLWBOfci0Zc4SCnDI/IDYiKRGKaIn38GEnn+oXvDAMEii3ZhUxuLNRnI8yNQi4MEUsqqknQfbJx35LuN7zqOqR9Cw0fU4nfk8umy65ipdW0V1jvtE10otPwkmm0qEhoPjkJzpQ5dRJjQVOdtb9SWWje2XC9CkbHXvSih52Ow=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 606a3b33-27a7-4202-f326-08d6bbaeb1c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2019 23:13:50.4564
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2768
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
