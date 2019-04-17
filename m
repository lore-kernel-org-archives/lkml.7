Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C86C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 10:05:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A28182177B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 10:05:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="x3OdOQU7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731732AbfDQKFT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 06:05:19 -0400
Received: from mail-eopbgr730065.outbound.protection.outlook.com ([40.107.73.65]:37344
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728237AbfDQKFS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 06:05:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2roTmt/UVCUG/E3QyPzabwPhhj+9FPZqhVgX2Et4iEw=;
 b=x3OdOQU76mxjh3rjqJoOJgtEqAk9KOv0o4HFT3vYrE7P9wuS97pIsezrFvY7APaP/iq1YBVjAivSO7pfO57QoShKzCL4KSI8dPPgaplz2GrW+EW0ncgnBaTekRE4+3k+2pfHGBBBIy3otnmUl0a/Jz21E9lREPeeam14Cd12ZzY=
Received: from MN2PR12MB2878.namprd12.prod.outlook.com (20.179.80.143) by
 MN2PR12MB3360.namprd12.prod.outlook.com (20.178.241.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.19; Wed, 17 Apr 2019 10:05:14 +0000
Received: from MN2PR12MB2878.namprd12.prod.outlook.com
 ([fe80::c5a0:395e:b9c6:4e5a]) by MN2PR12MB2878.namprd12.prod.outlook.com
 ([fe80::c5a0:395e:b9c6:4e5a%6]) with mapi id 15.20.1792.018; Wed, 17 Apr 2019
 10:05:14 +0000
From:   "Agrawal, Akshu" <Akshu.Agrawal@amd.com>
CC:     "Agrawal, Akshu" <Akshu.Agrawal@amd.com>,
        "djkurtz@chromium.org" <djkurtz@chromium.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Adam.Thomson.Opensource@diasemi.com" 
        <Adam.Thomson.Opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Andi Kleen <ak@linux.intel.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [v3] ASoC: AMD: Configure wclk and bclk of master codec
Thread-Topic: [v3] ASoC: AMD: Configure wclk and bclk of master codec
Thread-Index: AQHU9QUM4SzXG9ec60yG0w+RonnVUg==
Date:   Wed, 17 Apr 2019 10:05:13 +0000
Message-ID: <20190417100447.10321-1-akshu.agrawal@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MA1PR01CA0080.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00::20)
 To MN2PR12MB2878.namprd12.prod.outlook.com (2603:10b6:208:aa::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Akshu.Agrawal@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [165.204.156.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1d453517-0d3b-4413-97ba-08d6c31c2e39
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600140)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:MN2PR12MB3360;
x-ms-traffictypediagnostic: MN2PR12MB3360:
x-microsoft-antispam-prvs: <MN2PR12MB33607B66F1BE0AA65902DA46F8250@MN2PR12MB3360.namprd12.prod.outlook.com>
x-forefront-prvs: 0010D93EFE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(136003)(346002)(366004)(376002)(189003)(199004)(6506007)(6512007)(186003)(54906003)(102836004)(66066001)(386003)(59246006)(5660300002)(14454004)(26005)(476003)(72206003)(97736004)(81166006)(486006)(478600001)(99286004)(14444005)(50226002)(8936002)(71200400001)(256004)(2616005)(52116002)(6436002)(6486002)(6116002)(68736007)(71190400001)(1076003)(7416002)(81156014)(8676002)(4326008)(316002)(2906002)(7736002)(36756003)(1671002)(305945005)(25786009)(3846002)(105586002)(86362001)(106356001)(109986005)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB3360;H:MN2PR12MB2878.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 2UheofrJF1rozGxJlbP7RpMVRyZo2WATgKNkzdUN+a+G6c5r55gZdccV2iwaP5Twy0x0n//VOPydhbQ1bsSWqotI2kLAwGMgxRU90EGTG44z9aUxD18jVTUc7+YhPkpaz4sNAa81Nn7/N8n7a8cQA0LT2X0tsGVAjhNUR5MzOtp2eG54OMUUPSXEuSYEPvqr+gDGazuLAX750OSxdoGCzpkXQYAG9i6Yxg5hhmWKoh5mr1HxQWqJ3I7LgE1ej2YF8+1M9lm3m3qdqSHV5FoQL1GerZ855dpayGu7E6ESdZSpHOnGKRZR/u/sgO4yhKLWSR55tahc8fHiieL8O0yG0lPl/qVNqbxmOQxeOLVX7BLL9lgdylT7NxatDEj2V1OLvOGlhiJGUSUBSniSx6IEtf90P3nk9pM1M3JP440XFvw=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d453517-0d3b-4413-97ba-08d6c31c2e39
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2019 10:05:13.4319
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3360
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V2l0aCBDQ0Ygc3VwcG9ydCBpbiBkYTcyMTksIHdlIGNhbiBub3cgc2V0IHRoZSBjb3JyZWN0IHJh
dGUgb2YNCndjbGsgYW5kIGJjbGsuDQoNClNpZ25lZC1vZmYtYnk6IEFrc2h1IEFncmF3YWwgPGFr
c2h1LmFncmF3YWxAYW1kLmNvbT4NCi0tLQ0KdjI6IFJlbW92ZWQgY2xrIHNldCByYXRlIGFuZCBl
bmFibGUvZGlzYWJsZSBmcm9tIGRhNzIxOSBvcHMgYXMNCmRhNzIxOSBjb2RlYyB0YWtlcyBjYXJl
IG9mIHRoZW0gaW50ZXJuYWxseS4gQ2xvY2sgY29uZmlndXJhdGlvbg0Ka2VwdCBmb3IgdGhvc2Ug
Y29kZWNzIHdoZXJlIGRhNzIxOSBhY3RzIGFzIG1hc3RlciBvZiBjbG9jay4NCkFzIHN1Z2dlc3Rl
ZCBieSBBZGFtIFRob21zb24uDQoNCnYzOiBBcyBwZXIgc3BlYywgYWRhdTcwMDIgYmNsayB0byBi
ZSBtaW5pbXVtIG9mIDY0eCBvZiB3Y2xrLiBIZW5jZSwNCmxpbWl0aW5nIGJjbGsgZm9yIGFsbCBj
b2RlY3MuIEFsc28sIGJlY2F1c2Ugb2YgdGhpcyBjaGFuZ2VzIGRvbmUgaW4gdjINCm9mIHRoaXMg
cGF0Y2ggaGF2ZSB0byBiZSBicm91Z2h0IGJhY2suDQoNCiBzb3VuZC9zb2MvYW1kL2FjcC1kYTcy
MTktbWF4OTgzNTdhLmMgfCA2NiArKysrKysrKysrKysrKysrKystLS0tLS0tLS0tDQogMSBmaWxl
IGNoYW5nZWQsIDQyIGluc2VydGlvbnMoKyksIDI0IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0
IGEvc291bmQvc29jL2FtZC9hY3AtZGE3MjE5LW1heDk4MzU3YS5jIGIvc291bmQvc29jL2FtZC9h
Y3AtZGE3MjE5LW1heDk4MzU3YS5jDQppbmRleCA4YTYxOWE3NWIzYTkuLjE2YjBlYTNhM2Q3MiAx
MDA2NDQNCi0tLSBhL3NvdW5kL3NvYy9hbWQvYWNwLWRhNzIxOS1tYXg5ODM1N2EuYw0KKysrIGIv
c291bmQvc29jL2FtZC9hY3AtZGE3MjE5LW1heDk4MzU3YS5jDQpAQCAtNDYsNyArNDYsOCBAQA0K
ICNkZWZpbmUgRFVBTF9DSEFOTkVMCQkyDQogDQogc3RhdGljIHN0cnVjdCBzbmRfc29jX2phY2sg
Y3pfamFjazsNCi1zdGF0aWMgc3RydWN0IGNsayAqZGE3MjE5X2RhaV9jbGs7DQorc3RhdGljIHN0
cnVjdCBjbGsgKmRhNzIxOV9kYWlfd2NsazsNCitzdGF0aWMgc3RydWN0IGNsayAqZGE3MjE5X2Rh
aV9iY2xrOw0KIGV4dGVybiBib29sIGJ0X3VhcnRfZW5hYmxlOw0KIA0KIHN0YXRpYyBpbnQgY3pf
ZGE3MjE5X2luaXQoc3RydWN0IHNuZF9zb2NfcGNtX3J1bnRpbWUgKnJ0ZCkNCkBAIC03Miw3ICs3
Myw4IEBAIHN0YXRpYyBpbnQgY3pfZGE3MjE5X2luaXQoc3RydWN0IHNuZF9zb2NfcGNtX3J1bnRp
bWUgKnJ0ZCkNCiAJCXJldHVybiByZXQ7DQogCX0NCiANCi0JZGE3MjE5X2RhaV9jbGsgPSBjbGtf
Z2V0KGNvbXBvbmVudC0+ZGV2LCAiZGE3MjE5LWRhaS1iY2xrIik7DQorCWRhNzIxOV9kYWlfd2Ns
ayA9IGNsa19nZXQoY29tcG9uZW50LT5kZXYsICJkYTcyMTktZGFpLXdjbGsiKTsNCisJZGE3MjE5
X2RhaV9iY2xrID0gY2xrX2dldChjb21wb25lbnQtPmRldiwgImRhNzIxOS1kYWktYmNsayIpOw0K
IA0KIAlyZXQgPSBzbmRfc29jX2NhcmRfamFja19uZXcoY2FyZCwgIkhlYWRzZXQgSmFjayIsDQog
CQkJCVNORF9KQUNLX0hFQURTRVQgfCBTTkRfSkFDS19MSU5FT1VUIHwNCkBAIC05NCwxMiArOTYs
MTUgQEAgc3RhdGljIGludCBjel9kYTcyMTlfaW5pdChzdHJ1Y3Qgc25kX3NvY19wY21fcnVudGlt
ZSAqcnRkKQ0KIAlyZXR1cm4gMDsNCiB9DQogDQotc3RhdGljIGludCBkYTcyMTlfY2xrX2VuYWJs
ZShzdHJ1Y3Qgc25kX3BjbV9zdWJzdHJlYW0gKnN1YnN0cmVhbSkNCitzdGF0aWMgaW50IGRhNzIx
OV9jbGtfZW5hYmxlKHN0cnVjdCBzbmRfcGNtX3N1YnN0cmVhbSAqc3Vic3RyZWFtLA0KKwkJCSAg
ICAgaW50IHdjbGtfcmF0ZSwgaW50IGJjbGtfcmF0ZSkNCiB7DQogCWludCByZXQgPSAwOw0KIAlz
dHJ1Y3Qgc25kX3NvY19wY21fcnVudGltZSAqcnRkID0gc3Vic3RyZWFtLT5wcml2YXRlX2RhdGE7
DQogDQotCXJldCA9IGNsa19wcmVwYXJlX2VuYWJsZShkYTcyMTlfZGFpX2Nsayk7DQorCWNsa19z
ZXRfcmF0ZShkYTcyMTlfZGFpX3djbGssIHdjbGtfcmF0ZSk7DQorCWNsa19zZXRfcmF0ZShkYTcy
MTlfZGFpX2JjbGssIGJjbGtfcmF0ZSk7DQorCXJldCA9IGNsa19wcmVwYXJlX2VuYWJsZShkYTcy
MTlfZGFpX2JjbGspOw0KIAlpZiAocmV0IDwgMCkgew0KIAkJZGV2X2VycihydGQtPmRldiwgImNh
bid0IGVuYWJsZSBtYXN0ZXIgY2xvY2sgJWRcbiIsIHJldCk7DQogCQlyZXR1cm4gcmV0Ow0KQEAg
LTExMCw3ICsxMTUsNyBAQCBzdGF0aWMgaW50IGRhNzIxOV9jbGtfZW5hYmxlKHN0cnVjdCBzbmRf
cGNtX3N1YnN0cmVhbSAqc3Vic3RyZWFtKQ0KIA0KIHN0YXRpYyB2b2lkIGRhNzIxOV9jbGtfZGlz
YWJsZSh2b2lkKQ0KIHsNCi0JY2xrX2Rpc2FibGVfdW5wcmVwYXJlKGRhNzIxOV9kYWlfY2xrKTsN
CisJY2xrX2Rpc2FibGVfdW5wcmVwYXJlKGRhNzIxOV9kYWlfYmNsayk7DQogfQ0KIA0KIHN0YXRp
YyBjb25zdCB1bnNpZ25lZCBpbnQgY2hhbm5lbHNbXSA9IHsNCkBAIC0xNTEsNyArMTU2LDcgQEAg
c3RhdGljIGludCBjel9kYTcyMTlfcGxheV9zdGFydHVwKHN0cnVjdCBzbmRfcGNtX3N1YnN0cmVh
bSAqc3Vic3RyZWFtKQ0KIAkJCQkgICAmY29uc3RyYWludHNfcmF0ZXMpOw0KIA0KIAltYWNoaW5l
LT5wbGF5X2kyc19pbnN0YW5jZSA9IEkyU19TUF9JTlNUQU5DRTsNCi0JcmV0dXJuIGRhNzIxOV9j
bGtfZW5hYmxlKHN1YnN0cmVhbSk7DQorCXJldHVybiAwOw0KIH0NCiANCiBzdGF0aWMgaW50IGN6
X2RhNzIxOV9jYXBfc3RhcnR1cChzdHJ1Y3Qgc25kX3BjbV9zdWJzdHJlYW0gKnN1YnN0cmVhbSkN
CkBAIC0xNzMsMTIgKzE3OCw3IEBAIHN0YXRpYyBpbnQgY3pfZGE3MjE5X2NhcF9zdGFydHVwKHN0
cnVjdCBzbmRfcGNtX3N1YnN0cmVhbSAqc3Vic3RyZWFtKQ0KIA0KIAltYWNoaW5lLT5jYXBfaTJz
X2luc3RhbmNlID0gSTJTX1NQX0lOU1RBTkNFOw0KIAltYWNoaW5lLT5jYXB0dXJlX2NoYW5uZWwg
PSBDQVBfQ0hBTk5FTDE7DQotCXJldHVybiBkYTcyMTlfY2xrX2VuYWJsZShzdWJzdHJlYW0pOw0K
LX0NCi0NCi1zdGF0aWMgdm9pZCBjel9kYTcyMTlfc2h1dGRvd24oc3RydWN0IHNuZF9wY21fc3Vi
c3RyZWFtICpzdWJzdHJlYW0pDQotew0KLQlkYTcyMTlfY2xrX2Rpc2FibGUoKTsNCisJcmV0dXJu
IDA7DQogfQ0KIA0KIHN0YXRpYyBpbnQgY3pfbWF4X3N0YXJ0dXAoc3RydWN0IHNuZF9wY21fc3Vi
c3RyZWFtICpzdWJzdHJlYW0pDQpAQCAtMTk5LDEyICsxOTksNyBAQCBzdGF0aWMgaW50IGN6X21h
eF9zdGFydHVwKHN0cnVjdCBzbmRfcGNtX3N1YnN0cmVhbSAqc3Vic3RyZWFtKQ0KIAkJCQkgICAm
Y29uc3RyYWludHNfcmF0ZXMpOw0KIA0KIAltYWNoaW5lLT5wbGF5X2kyc19pbnN0YW5jZSA9IEky
U19CVF9JTlNUQU5DRTsNCi0JcmV0dXJuIGRhNzIxOV9jbGtfZW5hYmxlKHN1YnN0cmVhbSk7DQot
fQ0KLQ0KLXN0YXRpYyB2b2lkIGN6X21heF9zaHV0ZG93bihzdHJ1Y3Qgc25kX3BjbV9zdWJzdHJl
YW0gKnN1YnN0cmVhbSkNCi17DQotCWRhNzIxOV9jbGtfZGlzYWJsZSgpOw0KKwlyZXR1cm4gMDsN
CiB9DQogDQogc3RhdGljIGludCBjel9kbWljMF9zdGFydHVwKHN0cnVjdCBzbmRfcGNtX3N1YnN0
cmVhbSAqc3Vic3RyZWFtKQ0KQEAgLTIyNSw3ICsyMjAsNyBAQCBzdGF0aWMgaW50IGN6X2RtaWMw
X3N0YXJ0dXAoc3RydWN0IHNuZF9wY21fc3Vic3RyZWFtICpzdWJzdHJlYW0pDQogCQkJCSAgICZj
b25zdHJhaW50c19yYXRlcyk7DQogDQogCW1hY2hpbmUtPmNhcF9pMnNfaW5zdGFuY2UgPSBJMlNf
QlRfSU5TVEFOQ0U7DQotCXJldHVybiBkYTcyMTlfY2xrX2VuYWJsZShzdWJzdHJlYW0pOw0KKwly
ZXR1cm4gMDsNCiB9DQogDQogc3RhdGljIGludCBjel9kbWljMV9zdGFydHVwKHN0cnVjdCBzbmRf
cGNtX3N1YnN0cmVhbSAqc3Vic3RyZWFtKQ0KQEAgLTI0NywxMCArMjQyLDI4IEBAIHN0YXRpYyBp
bnQgY3pfZG1pYzFfc3RhcnR1cChzdHJ1Y3Qgc25kX3BjbV9zdWJzdHJlYW0gKnN1YnN0cmVhbSkN
CiANCiAJbWFjaGluZS0+Y2FwX2kyc19pbnN0YW5jZSA9IEkyU19TUF9JTlNUQU5DRTsNCiAJbWFj
aGluZS0+Y2FwdHVyZV9jaGFubmVsID0gQ0FQX0NIQU5ORUwwOw0KLQlyZXR1cm4gZGE3MjE5X2Ns
a19lbmFibGUoc3Vic3RyZWFtKTsNCisJcmV0dXJuIDA7DQogfQ0KIA0KLXN0YXRpYyB2b2lkIGN6
X2RtaWNfc2h1dGRvd24oc3RydWN0IHNuZF9wY21fc3Vic3RyZWFtICpzdWJzdHJlYW0pDQorc3Rh
dGljIGludCBjel9kYTcyMTlfcGFyYW1zKHN0cnVjdCBzbmRfcGNtX3N1YnN0cmVhbSAqc3Vic3Ry
ZWFtLA0KKwkJCQkgICAgICBzdHJ1Y3Qgc25kX3BjbV9od19wYXJhbXMgKnBhcmFtcykNCit7DQor
CWludCB3Y2xrLCBiY2xrOw0KKw0KKwl3Y2xrID0gcGFyYW1zX3JhdGUocGFyYW1zKTsNCisJYmNs
ayA9IHdjbGsgKiBwYXJhbXNfY2hhbm5lbHMocGFyYW1zKSAqDQorCQlzbmRfcGNtX2Zvcm1hdF93
aWR0aChwYXJhbXNfZm9ybWF0KHBhcmFtcykpOw0KKwkvKiBBREFVNzAwMiBzcGVjOiAiVGhlIEFE
QVU3MDAyIHJlcXVpcmVzIGEgQkNMSyByYXRlDQorCSAqIHRoYXQgaXMgbWluaW11bSBvZiA2NHgg
dGhlIExSQ0xLIHNhbXBsZSByYXRlLiINCisJICogREE3MjE5IGlzIHRoZSBvbmx5IGNsayBzb3Vy
Y2Ugc28gZm9yIGFsbCBjb2RlY3MNCisJICogd2UgaGF2ZSB0byBsaW1pdCBiY2xrIHRvIDY0WCBs
cmNsay4NCisJICovDQorCWlmIChiY2xrIDwgKHdjbGsgKiA2NCkpDQorCQliY2xrID0gd2NsayAq
IDY0Ow0KKwlyZXR1cm4gZGE3MjE5X2Nsa19lbmFibGUoc3Vic3RyZWFtLCB3Y2xrLCBiY2xrKTsN
Cit9DQorDQorc3RhdGljIHZvaWQgY3pfZGE3MjE5X3NodXRkb3duKHN0cnVjdCBzbmRfcGNtX3N1
YnN0cmVhbSAqc3Vic3RyZWFtKQ0KIHsNCiAJZGE3MjE5X2Nsa19kaXNhYmxlKCk7DQogfQ0KQEAg
LTI1OCwyNiArMjcxLDMxIEBAIHN0YXRpYyB2b2lkIGN6X2RtaWNfc2h1dGRvd24oc3RydWN0IHNu
ZF9wY21fc3Vic3RyZWFtICpzdWJzdHJlYW0pDQogc3RhdGljIGNvbnN0IHN0cnVjdCBzbmRfc29j
X29wcyBjel9kYTcyMTlfcGxheV9vcHMgPSB7DQogCS5zdGFydHVwID0gY3pfZGE3MjE5X3BsYXlf
c3RhcnR1cCwNCiAJLnNodXRkb3duID0gY3pfZGE3MjE5X3NodXRkb3duLA0KKwkuaHdfcGFyYW1z
ID0gY3pfZGE3MjE5X3BhcmFtcywNCiB9Ow0KIA0KIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgc25kX3Nv
Y19vcHMgY3pfZGE3MjE5X2NhcF9vcHMgPSB7DQogCS5zdGFydHVwID0gY3pfZGE3MjE5X2NhcF9z
dGFydHVwLA0KIAkuc2h1dGRvd24gPSBjel9kYTcyMTlfc2h1dGRvd24sDQorCS5od19wYXJhbXMg
PSBjel9kYTcyMTlfcGFyYW1zLA0KIH07DQogDQogc3RhdGljIGNvbnN0IHN0cnVjdCBzbmRfc29j
X29wcyBjel9tYXhfcGxheV9vcHMgPSB7DQogCS5zdGFydHVwID0gY3pfbWF4X3N0YXJ0dXAsDQot
CS5zaHV0ZG93biA9IGN6X21heF9zaHV0ZG93biwNCisJLnNodXRkb3duID0gY3pfZGE3MjE5X3No
dXRkb3duLA0KKwkuaHdfcGFyYW1zID0gY3pfZGE3MjE5X3BhcmFtcywNCiB9Ow0KIA0KIHN0YXRp
YyBjb25zdCBzdHJ1Y3Qgc25kX3NvY19vcHMgY3pfZG1pYzBfY2FwX29wcyA9IHsNCiAJLnN0YXJ0
dXAgPSBjel9kbWljMF9zdGFydHVwLA0KLQkuc2h1dGRvd24gPSBjel9kbWljX3NodXRkb3duLA0K
Kwkuc2h1dGRvd24gPSBjel9kYTcyMTlfc2h1dGRvd24sDQorCS5od19wYXJhbXMgPSBjel9kYTcy
MTlfcGFyYW1zLA0KIH07DQogDQogc3RhdGljIGNvbnN0IHN0cnVjdCBzbmRfc29jX29wcyBjel9k
bWljMV9jYXBfb3BzID0gew0KIAkuc3RhcnR1cCA9IGN6X2RtaWMxX3N0YXJ0dXAsDQotCS5zaHV0
ZG93biA9IGN6X2RtaWNfc2h1dGRvd24sDQorCS5zaHV0ZG93biA9IGN6X2RhNzIxOV9zaHV0ZG93
biwNCisJLmh3X3BhcmFtcyA9IGN6X2RhNzIxOV9wYXJhbXMsDQogfTsNCiANCiBzdGF0aWMgc3Ry
dWN0IHNuZF9zb2NfZGFpX2xpbmsgY3pfZGFpXzcyMTlfOTgzNTdbXSA9IHsNCi0tIA0KMi4xNy4x
DQoNCg==
