Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 958CBC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 08:12:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49A322184D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 08:12:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="IpDX++6E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbfCTIMc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 04:12:32 -0400
Received: from mail-eopbgr800077.outbound.protection.outlook.com ([40.107.80.77]:44539
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727573AbfCTIMb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 04:12:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3HUTWye9XtHN1VfOcRKQb1k6/axmCtfvpgq3KLwCgdY=;
 b=IpDX++6ECqIts/xeRwAEv58xTnRXLtSS2iynbzigNW4NNTVj01gdtlYtgwgyW6fYp+SpZtoRDoXwu7eEteQNp+7Hdxt2lJCrPpsh7NfT2OHSdPxe1KWLYAWK5i+lWpANtu0Zqssr87ubhOtlR07yC4p5a1MupfpOF6lrgTJX7Hw=
Received: from DM6PR12MB2844.namprd12.prod.outlook.com (20.176.117.96) by
 DM6PR12MB3611.namprd12.prod.outlook.com (20.178.199.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.14; Wed, 20 Mar 2019 08:12:28 +0000
Received: from DM6PR12MB2844.namprd12.prod.outlook.com
 ([fe80::3589:a066:e1d:b1f0]) by DM6PR12MB2844.namprd12.prod.outlook.com
 ([fe80::3589:a066:e1d:b1f0%5]) with mapi id 15.20.1709.015; Wed, 20 Mar 2019
 08:12:28 +0000
From:   "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
CC:     "joro@8bytes.org" <joro@8bytes.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>
Subject: [PATCH] Revert "svm: Fix AVIC incomplete IPI emulation"
Thread-Topic: [PATCH] Revert "svm: Fix AVIC incomplete IPI emulation"
Thread-Index: AQHU3vSoF/6SczcFzECLQBUaeLu7Kg==
Date:   Wed, 20 Mar 2019 08:12:28 +0000
Message-ID: <20190320081158.2442-1-suravee.suthikulpanit@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [171.96.73.208]
x-clientproxiedby: SG2PR0601CA0006.apcprd06.prod.outlook.com (2603:1096:3::16)
 To DM6PR12MB2844.namprd12.prod.outlook.com (2603:10b6:5:45::32)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Suravee.Suthikulpanit@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6e3ce367-02a9-41e5-63f7-08d6ad0bcac9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM6PR12MB3611;
x-ms-traffictypediagnostic: DM6PR12MB3611:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DM6PR12MB36113D99FAA0279F0B80BAEDF3410@DM6PR12MB3611.namprd12.prod.outlook.com>
x-forefront-prvs: 098291215C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(39860400002)(376002)(136003)(346002)(199004)(189003)(305945005)(6506007)(25786009)(2906002)(72206003)(7736002)(386003)(50226002)(5660300002)(8936002)(14444005)(66574012)(256004)(68736007)(102836004)(26005)(53936002)(71190400001)(186003)(71200400001)(86362001)(6116002)(2616005)(476003)(14454004)(1076003)(66066001)(3846002)(486006)(97736004)(966005)(36756003)(4326008)(81156014)(6436002)(110136005)(6486002)(54906003)(52116002)(99286004)(478600001)(105586002)(8676002)(316002)(81166006)(106356001)(6512007)(2501003)(6306002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB3611;H:DM6PR12MB2844.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: QRKYK1igkDQlk5smwD/3cuuB0lJ8Mm+EnAXecWKOrzSKA8dTYXW+3v7Xg7pIYC8Vv8qQNokyjbgDtio1Uwegv5RlFsAsuPI4r+VCdGevLSF1ZwHTaB4vKz2xsRPCZcyMwHqWViQUaw5Zyxnkt5KT1sEvs6xtIjo3pYt2WptxMEKTo6GzmZkSfIMewl2t+45031iecNiMdbLq2D9pNyRnHNxoUoE+ysmys+jArMGzGoiM4fPatpRbqolQgrm+sUUqtwRSf2p9RgHbLn7MPnl7R+0Z4hfGFSzcAE5m2xxOH4uvQE0kGPhH9Thde85lnGTkISMAV+ClM0t71/cof/TPP6PdlOISt3XA0nLqmcr33hvgApDOgYadU8V/MC4OtfIMDwI+VJnWqzZV8CPjsJRXDM3m5x2rZtWYapbeVHGuAz4=
Content-Type: text/plain; charset="utf-8"
Content-ID: <76B7D08EC551CE4E892E99DF94A181AF@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e3ce367-02a9-41e5-63f7-08d6ad0bcac9
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2019 08:12:28.3759
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3611
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyByZXZlcnRzIGNvbW1pdCBiYjIxOGZiY2ZhYWEzYjExNWQ0Y2Q3YTQzYzBjYTE2NGYzYTk2
ZTU3Lg0KDQpBcyBPcmVuIFR3YWlnIHBvaW50ZWQgb3V0IHRoZSBvbGQgZGlzY3Vzc2lvbjoNCg0K
ICBodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3BhdGNoLzgyOTIyMzEvDQoNCnRoYXQgdGhl
IGNoYW5nZSBjb3VkIHBvdGVudGlhbGx5IGNhdXNlIGFuIGV4dHJhIElQSSB0byBiZSBzZW50IHRv
DQp0aGUgZGVzdGluYXRpb24gdmNwdSBiZWNhdXNlIHRoZSBBVklDIGhhcmR3YXJlIGFscmVhZHkg
c2V0IHRoZSBJUlIgYml0DQpiZWZvcmUgdGhlIGluY29tcGxldGUgSVBJICNWTUVYSVQgd2l0aCBp
ZD0xICh0YXJnZXQgdmNwdSBpcyBub3QgcnVubmluZykuDQpTaW5jZSB3cml0dGluZyB0byBJQ1Ig
YW5kIElDUjIgd2lsbCBhbHNvIHNldCB0aGUgSVJSLiBJZiBzb21ldGhpbmcgdHJpZ2dlcnMNCnRo
ZSBkZXN0aW5hdGlvbiB2Y3B1IHRvIGdldCBzY2hlZHVsZWQgYmVmb3JlIHRoZSBlbXVsYXRpb24g
ZmluaXNoZXMsIHRoZW4NCnRoaXMgY291bGQgcmVzdWx0IGluIGFuIGFkZGl0aW9uYWwgSVBJLg0K
DQpBbHNvLCB0aGUgaXNzdWUgbWVudGlvbmVkIGluIHRoZSBjb21taXQgYmIyMThmYmNmYWFhIHdh
cyBtaXNkaWFnbm9zZWQuDQoNCkNjOiBSYWRpbSBLcsSNbcOhxZkgPHJrcmNtYXJAcmVkaGF0LmNv
bT4NCkNjOiBQYW9sbyBCb256aW5pIDxwYm9uemluaUByZWRoYXQuY29tPg0KUmVwb3J0ZWQtYnk6
IE9yZW4gVHdhaWcgPG9yZW5Ac2NhbGVtcC5jb20+DQpTaWduZWQtb2ZmLWJ5OiBTdXJhdmVlIFN1
dGhpa3VscGFuaXQgPHN1cmF2ZWUuc3V0aGlrdWxwYW5pdEBhbWQuY29tPg0KLS0tDQogYXJjaC94
ODYva3ZtL3N2bS5jIHwgMTkgKysrKysrKysrKysrKysrLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCAx
NSBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvYXJjaC94ODYv
a3ZtL3N2bS5jIGIvYXJjaC94ODYva3ZtL3N2bS5jDQppbmRleCBmMTNhM2EyNGQzNjAuLjQ3YzQ5
OTM0NDhjNyAxMDA2NDQNCi0tLSBhL2FyY2gveDg2L2t2bS9zdm0uYw0KKysrIGIvYXJjaC94ODYv
a3ZtL3N2bS5jDQpAQCAtNDUxMiwxNCArNDUxMiwyNSBAQCBzdGF0aWMgaW50IGF2aWNfaW5jb21w
bGV0ZV9pcGlfaW50ZXJjZXB0aW9uKHN0cnVjdCB2Y3B1X3N2bSAqc3ZtKQ0KIAkJa3ZtX2xhcGlj
X3JlZ193cml0ZShhcGljLCBBUElDX0lDUiwgaWNybCk7DQogCQlicmVhazsNCiAJY2FzZSBBVklD
X0lQSV9GQUlMVVJFX1RBUkdFVF9OT1RfUlVOTklORzogew0KKwkJaW50IGk7DQorCQlzdHJ1Y3Qg
a3ZtX3ZjcHUgKnZjcHU7DQorCQlzdHJ1Y3Qga3ZtICprdm0gPSBzdm0tPnZjcHUua3ZtOw0KIAkJ
c3RydWN0IGt2bV9sYXBpYyAqYXBpYyA9IHN2bS0+dmNwdS5hcmNoLmFwaWM7DQogDQogCQkvKg0K
LQkJICogVXBkYXRlIElDUiBoaWdoIGFuZCBsb3csIHRoZW4gZW11bGF0ZSBzZW5kaW5nIElQSSwN
Ci0JCSAqIHdoaWNoIGlzIGhhbmRsZWQgd2hlbiB3cml0aW5nIEFQSUNfSUNSLg0KKwkJICogQXQg
dGhpcyBwb2ludCwgd2UgZXhwZWN0IHRoYXQgdGhlIEFWSUMgSFcgaGFzIGFscmVhZHkNCisJCSAq
IHNldCB0aGUgYXBwcm9wcmlhdGUgSVJSIGJpdHMgb24gdGhlIHZhbGlkIHRhcmdldA0KKwkJICog
dmNwdXMuIFNvLCB3ZSBqdXN0IG5lZWQgdG8ga2ljayB0aGUgYXBwcm9wcmlhdGUgdmNwdS4NCiAJ
CSAqLw0KLQkJa3ZtX2xhcGljX3JlZ193cml0ZShhcGljLCBBUElDX0lDUjIsIGljcmgpOw0KLQkJ
a3ZtX2xhcGljX3JlZ193cml0ZShhcGljLCBBUElDX0lDUiwgaWNybCk7DQorCQlrdm1fZm9yX2Vh
Y2hfdmNwdShpLCB2Y3B1LCBrdm0pIHsNCisJCQlib29sIG0gPSBrdm1fYXBpY19tYXRjaF9kZXN0
KHZjcHUsIGFwaWMsDQorCQkJCQkJICAgICBpY3JsICYgS1ZNX0FQSUNfU0hPUlRfTUFTSywNCisJ
CQkJCQkgICAgIEdFVF9BUElDX0RFU1RfRklFTEQoaWNyaCksDQorCQkJCQkJICAgICBpY3JsICYg
S1ZNX0FQSUNfREVTVF9NQVNLKTsNCisNCisJCQlpZiAobSAmJiAhYXZpY192Y3B1X2lzX3J1bm5p
bmcodmNwdSkpDQorCQkJCWt2bV92Y3B1X3dha2VfdXAodmNwdSk7DQorCQl9DQogCQlicmVhazsN
CiAJfQ0KIAljYXNlIEFWSUNfSVBJX0ZBSUxVUkVfSU5WQUxJRF9UQVJHRVQ6DQotLSANCjIuMTcu
MQ0KDQo=
