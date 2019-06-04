Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A15A6C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 16:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A11223CE7
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 16:42:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="hgR9eR80"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbfFDQmZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 12:42:25 -0400
Received: from mail-eopbgr150130.outbound.protection.outlook.com ([40.107.15.130]:4014
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727482AbfFDQmZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 12:42:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TgfJacl8xSAowGMqepIoTDjEhZqrOcuzr07TAyLK5LY=;
 b=hgR9eR80oeMl7LRtrOZRAJP4sicIqzSO5kfvyddFqxQ4Gjq8AGN0Q0ZL7h6DrbPPo7VjzlqmzESFOvcIolUjegrZmYhSndYzymDsld7qAEAsbp8IZFGPLs59dcO+yqnB2IKrS/6kVNGHbLkpDXUo0ux+RPe7MgBdY3yvDPsuKig=
Received: from VI1PR07MB3165.eurprd07.prod.outlook.com (10.175.243.15) by
 VI1PR07MB4560.eurprd07.prod.outlook.com (20.177.56.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.4; Tue, 4 Jun 2019 16:42:21 +0000
Received: from VI1PR07MB3165.eurprd07.prod.outlook.com
 ([fe80::1403:5377:c11d:a41a]) by VI1PR07MB3165.eurprd07.prod.outlook.com
 ([fe80::1403:5377:c11d:a41a%7]) with mapi id 15.20.1965.011; Tue, 4 Jun 2019
 16:42:21 +0000
From:   "Sverdlin, Alexander (Nokia - DE/Ulm)" <alexander.sverdlin@nokia.com>
To:     "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Sverdlin, Alexander (Nokia - DE/Ulm)" <alexander.sverdlin@nokia.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Vas Dias <jason.vas.dias@gmail.com>
Subject: [PATCH v2] x86/vdso: implement clock_gettime(CLOCK_MONOTONIC_RAW,
 ...)
Thread-Topic: [PATCH v2] x86/vdso: implement
 clock_gettime(CLOCK_MONOTONIC_RAW, ...)
Thread-Index: AQHVGvR6xh0mXQ5auk6Hqpq4T1roAg==
Date:   Tue, 4 Jun 2019 16:42:20 +0000
Message-ID: <20190604164117.22154-1-alexander.sverdlin@nokia.com>
In-Reply-To: <alpine.DEB.2.21.1905281055240.1859@nanos.tec.linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [131.228.32.181]
x-mailer: git-send-email 2.21.0
x-clientproxiedby: HE1PR0402CA0007.eurprd04.prod.outlook.com
 (2603:10a6:3:d0::17) To VI1PR07MB3165.eurprd07.prod.outlook.com
 (2603:10a6:802:21::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=alexander.sverdlin@nokia.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 51a009a2-581e-4cc1-8185-08d6e90b9cef
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR07MB4560;
x-ms-traffictypediagnostic: VI1PR07MB4560:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <VI1PR07MB4560B778F41680D3CD40255B88150@VI1PR07MB4560.eurprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0058ABBBC7
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(39860400002)(346002)(396003)(366004)(54534003)(189003)(199004)(11346002)(2906002)(305945005)(14444005)(66946007)(66556008)(66446008)(6486002)(86362001)(66476007)(256004)(8676002)(966005)(5660300002)(2501003)(36756003)(6506007)(486006)(99286004)(64756008)(186003)(6436002)(53936002)(386003)(14454004)(26005)(68736007)(52116002)(3846002)(6116002)(71190400001)(25786009)(6512007)(508600001)(6306002)(4326008)(8936002)(316002)(66066001)(102836004)(1076003)(50226002)(73956011)(81166006)(110136005)(54906003)(71200400001)(2616005)(7736002)(476003)(81156014);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR07MB4560;H:VI1PR07MB3165.eurprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nokia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: EsGdnHPqTELWBCZY6tM4+kcADczWXaWhNM3kUohak7z3qDZWZZpzOV+XbBR+XOqmxrFbvPuWYJ1wOHAgIbN2h9ywewll2IXGlaIpR3TqZa0FYQ0XIhm5qFwzOPW8jmJXb7l1h3G6khOL+XcISrS0vj943bH0NzTe1W1tl2rMs270KMGKivsiBrEEitvEGn/JhHsKt6M0OZr7oMkJaRJc0l0NHqg+iThl+9t+zU3ePUQrfV5nFnAstylHnS5rX49wXOxWCNsngFfBSMumPXTpAP+SS3ATJ56j0gWoZjDF+pq7OSA+/6sibbnZKdOwS4CrsGBM1CcsqCLwOcQjv9v3sbkbxRz+lJCIMhSyEkCf/MVzIWW6sCJGTzJLJnpGC9l3x+xKAin+Duo5TIPzbHgGPPIoJ0pJUeEhaiaAEw2VfEA=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51a009a2-581e-4cc1-8185-08d6e90b9cef
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2019 16:42:20.8916
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: alexander.sverdlin@nokia.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB4560
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogQWxleGFuZGVyIFN2ZXJkbGluIDxhbGV4YW5kZXIuc3ZlcmRsaW5Abm9raWEuY29tPg0K
DQpBZGQgQ0xPQ0tfTU9OT1RPTklDX1JBVyB0byB0aGUgZXhpc3RpbmcgY2xvY2tfZ2V0dGltZSgp
IHZEU08NCmltcGxlbWVudGF0aW9uLiBUaGlzIGlzIGJhc2VkIG9uIHRoZSBpZGVhcyBvZiBKYXNv
biBWYXMgRGlhcyBhbmQgY29tbWVudHMNCm9mIFRob21hcyBHbGVpeG5lci4NCg0KLS0tLSBUZXN0
IGNvZGUgLS0tLQ0KICNpbmNsdWRlIDxlcnJuby5oPg0KICNpbmNsdWRlIDxzdGRpby5oPg0KICNp
bmNsdWRlIDxzdGRsaWIuaD4NCiAjaW5jbHVkZSA8dGltZS5oPg0KICNpbmNsdWRlIDx1bmlzdGQu
aD4NCg0KICNkZWZpbmUgQ0xPQ0tfVFlQRSBDTE9DS19NT05PVE9OSUNfUkFXDQogI2RlZmluZSBE
VVJBVElPTl9TRUMgMTANCg0KaW50IG1haW4oaW50IGFyZ2MsIGNoYXIgKiphcmd2KQ0Kew0KCXN0
cnVjdCB0aW1lc3BlYyB0LCBlbmQ7DQoJdW5zaWduZWQgbG9uZyBsb25nIGNudCA9IDA7DQoNCglj
bG9ja19nZXR0aW1lKENMT0NLX1RZUEUsICZlbmQpOw0KCWVuZC50dl9zZWMgKz0gRFVSQVRJT05f
U0VDOw0KDQoJZG8gew0KCQljbG9ja19nZXR0aW1lKENMT0NLX1RZUEUsICZ0KTsNCgkJKytjbnQ7
DQoJfSB3aGlsZSAodC50dl9zZWMgPCBlbmQudHZfc2VjIHx8IHQudHZfbnNlYyA8IGVuZC50dl9u
c2VjKTsNCg0KCWRwcmludGYoU1RET1VUX0ZJTEVOTywgIiVsbHUiLCBjbnQpOw0KDQoJcmV0dXJu
IEVYSVRfU1VDQ0VTUzsNCn0NCi0tLS0tLS0tLS0tLS0tLS0tLS0NCg0KVGhlIHJlc3VsdHMgZnJv
bSB0aGUgYWJvdmUgdGVzdCBwcm9ncmFtOg0KDQpDbG9jayAgICAgICAgICAgICAgICAgICBCZWZv
cmUgIEFmdGVyICAgRGlmZg0KLS0tLS0gICAgICAgICAgICAgICAgICAgLS0tLS0tICAtLS0tLSAg
IC0tLS0NCkNMT0NLX01PTk9UT05JQyAgICAgICAgIDM1NS41TSAgMzU1LjVNDQpDTE9DS19NT05P
VE9OSUNfUkFXICAgICAgNDQuOU0gIDM3MS4yTSAgKzcyNiUNCkNMT0NLX1JFQUxUSU1FICAgICAg
ICAgIDM1NS41TSAgMzU1LjVNDQoNCkxpbms6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3BhdGNo
d29yay9wYXRjaC85MzM1ODMvDQpMaW5rOiBodHRwczovL2J1Z3ppbGxhLmtlcm5lbC5vcmcvc2hv
d19idWcuY2dpP2lkPTE5ODk2MQ0KQ2M6IFRob21hcyBHbGVpeG5lciA8dGdseEBsaW51dHJvbml4
LmRlPg0KQ2M6IEphc29uIFZhcyBEaWFzIDxqYXNvbi52YXMuZGlhc0BnbWFpbC5jb20+DQpTaWdu
ZWQtb2ZmLWJ5OiBBbGV4YW5kZXIgU3ZlcmRsaW4gPGFsZXhhbmRlci5zdmVyZGxpbkBub2tpYS5j
b20+DQotLS0NCkNoYW5nZWxvZzoNCnYyOiBjb3B5IGRvX2hyZXMoKSBpbnRvIGRvX21vbm90b25p
Y19yYXcoKQ0KDQogYXJjaC94ODYvZW50cnkvdmRzby92Y2xvY2tfZ2V0dGltZS5jICAgIHwgMzUg
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQogYXJjaC94ODYvZW50cnkvdnN5c2Nh
bGwvdnN5c2NhbGxfZ3RvZC5jIHwgIDYgKysrKysrDQogYXJjaC94ODYvaW5jbHVkZS9hc20vdmd0
b2QuaCAgICAgICAgICAgIHwgIDIgKysNCiAzIGZpbGVzIGNoYW5nZWQsIDQzIGluc2VydGlvbnMo
KykNCg0KZGlmZiAtLWdpdCBhL2FyY2gveDg2L2VudHJ5L3Zkc28vdmNsb2NrX2dldHRpbWUuYyBi
L2FyY2gveDg2L2VudHJ5L3Zkc28vdmNsb2NrX2dldHRpbWUuYw0KaW5kZXggMGY4MmE3MC4uNjQ3
MzZhNCAxMDA2NDQNCi0tLSBhL2FyY2gveDg2L2VudHJ5L3Zkc28vdmNsb2NrX2dldHRpbWUuYw0K
KysrIGIvYXJjaC94ODYvZW50cnkvdmRzby92Y2xvY2tfZ2V0dGltZS5jDQpAQCAtMTY4LDYgKzE2
OCwzOSBAQCBub3RyYWNlIHN0YXRpYyBpbnQgZG9faHJlcyhjbG9ja2lkX3QgY2xrLCBzdHJ1Y3Qg
dGltZXNwZWMgKnRzKQ0KIAlyZXR1cm4gMDsNCiB9DQogDQorLyoNCisgKiBBdHRlbXB0cyB0byBt
ZXJnZSB0aGUgYmVsb3cgY29weSB3aXRoIHRoZSBhYm92ZSByb3V0aW5lIGxlZCB0byA1JSBwZXJm
b3JtYW5jZQ0KKyAqIGRyb3AgKENMT0NLX01PTk9UT05JQywgQ0xPQ0tfUkVBTFRJTUUpIHVwIHRv
IG5vdy4gVGVzdCBiZWZvcmUgbWFraW5nIGNoYW5nZXMuDQorICovDQorbm90cmFjZSBzdGF0aWMg
aW50IGRvX21vbm90b25pY19yYXcoc3RydWN0IHRpbWVzcGVjICp0cykNCit7DQorCXN0cnVjdCB2
Z3RvZF90cyAqYmFzZSA9ICZndG9kLT5iYXNldGltZVtDTE9DS19NT05PVE9OSUNfUkFXXTsNCisJ
dTY0IGN5Y2xlcywgbGFzdCwgc2VjLCBuczsNCisJdW5zaWduZWQgaW50IHNlcTsNCisNCisJZG8g
ew0KKwkJc2VxID0gZ3RvZF9yZWFkX2JlZ2luKGd0b2QpOw0KKwkJY3ljbGVzID0gdmdldGN5Yyhn
dG9kLT52Y2xvY2tfbW9kZSk7DQorCQlucyA9IGJhc2UtPm5zZWM7DQorCQlsYXN0ID0gZ3RvZC0+
Y3ljbGVfbGFzdDsNCisJCWlmICh1bmxpa2VseSgoczY0KWN5Y2xlcyA8IDApKQ0KKwkJCXJldHVy
biB2ZHNvX2ZhbGxiYWNrX2dldHRpbWUoQ0xPQ0tfTU9OT1RPTklDX1JBVywgdHMpOw0KKwkJaWYg
KGN5Y2xlcyA+IGxhc3QpDQorCQkJbnMgKz0gKGN5Y2xlcyAtIGxhc3QpICogZ3RvZC0+cmF3X211
bHQ7DQorCQlucyA+Pj0gZ3RvZC0+cmF3X3NoaWZ0Ow0KKwkJc2VjID0gYmFzZS0+c2VjOw0KKwl9
IHdoaWxlICh1bmxpa2VseShndG9kX3JlYWRfcmV0cnkoZ3RvZCwgc2VxKSkpOw0KKw0KKwkvKg0K
KwkgKiBEbyB0aGlzIG91dHNpZGUgdGhlIGxvb3A6IGEgcmFjZSBpbnNpZGUgdGhlIGxvb3AgY291
bGQgcmVzdWx0DQorCSAqIGluIF9faXRlcl9kaXZfdTY0X3JlbSgpIGJlaW5nIGV4dHJlbWVseSBz
bG93Lg0KKwkgKi8NCisJdHMtPnR2X3NlYyA9IHNlYyArIF9faXRlcl9kaXZfdTY0X3JlbShucywg
TlNFQ19QRVJfU0VDLCAmbnMpOw0KKwl0cy0+dHZfbnNlYyA9IG5zOw0KKw0KKwlyZXR1cm4gMDsN
Cit9DQorDQogbm90cmFjZSBzdGF0aWMgdm9pZCBkb19jb2Fyc2UoY2xvY2tpZF90IGNsaywgc3Ry
dWN0IHRpbWVzcGVjICp0cykNCiB7DQogCXN0cnVjdCB2Z3RvZF90cyAqYmFzZSA9ICZndG9kLT5i
YXNldGltZVtjbGtdOw0KQEAgLTE5OSw2ICsyMzIsOCBAQCBub3RyYWNlIGludCBfX3Zkc29fY2xv
Y2tfZ2V0dGltZShjbG9ja2lkX3QgY2xvY2ssIHN0cnVjdCB0aW1lc3BlYyAqdHMpDQogCQlkb19j
b2Fyc2UoY2xvY2ssIHRzKTsNCiAJCXJldHVybiAwOw0KIAl9DQorCWlmIChjbG9jayA9PSBDTE9D
S19NT05PVE9OSUNfUkFXKQ0KKwkJcmV0dXJuIGRvX21vbm90b25pY19yYXcodHMpOw0KIAlyZXR1
cm4gdmRzb19mYWxsYmFja19nZXR0aW1lKGNsb2NrLCB0cyk7DQogfQ0KIA0KZGlmZiAtLWdpdCBh
L2FyY2gveDg2L2VudHJ5L3ZzeXNjYWxsL3ZzeXNjYWxsX2d0b2QuYyBiL2FyY2gveDg2L2VudHJ5
L3ZzeXNjYWxsL3ZzeXNjYWxsX2d0b2QuYw0KaW5kZXggY2ZjZGJhMC4uOWY3NzQ0ZjMgMTAwNjQ0
DQotLS0gYS9hcmNoL3g4Ni9lbnRyeS92c3lzY2FsbC92c3lzY2FsbF9ndG9kLmMNCisrKyBiL2Fy
Y2gveDg2L2VudHJ5L3ZzeXNjYWxsL3ZzeXNjYWxsX2d0b2QuYw0KQEAgLTQ2LDYgKzQ2LDggQEAg
dm9pZCB1cGRhdGVfdnN5c2NhbGwoc3RydWN0IHRpbWVrZWVwZXIgKnRrKQ0KIAl2ZGF0YS0+bWFz
awkJPSB0ay0+dGtyX21vbm8ubWFzazsNCiAJdmRhdGEtPm11bHQJCT0gdGstPnRrcl9tb25vLm11
bHQ7DQogCXZkYXRhLT5zaGlmdAkJPSB0ay0+dGtyX21vbm8uc2hpZnQ7DQorCXZkYXRhLT5yYXdf
bXVsdAkJPSB0ay0+dGtyX3Jhdy5tdWx0Ow0KKwl2ZGF0YS0+cmF3X3NoaWZ0CT0gdGstPnRrcl9y
YXcuc2hpZnQ7DQogDQogCWJhc2UgPSAmdmRhdGEtPmJhc2V0aW1lW0NMT0NLX1JFQUxUSU1FXTsN
CiAJYmFzZS0+c2VjID0gdGstPnh0aW1lX3NlYzsNCkBAIC02NSw2ICs2NywxMCBAQCB2b2lkIHVw
ZGF0ZV92c3lzY2FsbChzdHJ1Y3QgdGltZWtlZXBlciAqdGspDQogCX0NCiAJYmFzZS0+bnNlYyA9
IG5zZWM7DQogDQorCWJhc2UgPSAmdmRhdGEtPmJhc2V0aW1lW0NMT0NLX01PTk9UT05JQ19SQVdd
Ow0KKwliYXNlLT5zZWMgPSB0ay0+cmF3X3NlYzsNCisJYmFzZS0+bnNlYyA9IHRrLT50a3JfcmF3
Lnh0aW1lX25zZWM7DQorDQogCWJhc2UgPSAmdmRhdGEtPmJhc2V0aW1lW0NMT0NLX1JFQUxUSU1F
X0NPQVJTRV07DQogCWJhc2UtPnNlYyA9IHRrLT54dGltZV9zZWM7DQogCWJhc2UtPm5zZWMgPSB0
ay0+dGtyX21vbm8ueHRpbWVfbnNlYyA+PiB0ay0+dGtyX21vbm8uc2hpZnQ7DQpkaWZmIC0tZ2l0
IGEvYXJjaC94ODYvaW5jbHVkZS9hc20vdmd0b2QuaCBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL3Zn
dG9kLmgNCmluZGV4IDkxM2ExMzMuLjY1YWMzMjAgMTAwNjQ0DQotLS0gYS9hcmNoL3g4Ni9pbmNs
dWRlL2FzbS92Z3RvZC5oDQorKysgYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS92Z3RvZC5oDQpAQCAt
NDMsNiArNDMsOCBAQCBzdHJ1Y3QgdnN5c2NhbGxfZ3RvZF9kYXRhIHsNCiAJdTY0CQltYXNrOw0K
IAl1MzIJCW11bHQ7DQogCXUzMgkJc2hpZnQ7DQorCXUzMgkJcmF3X211bHQ7DQorCXUzMgkJcmF3
X3NoaWZ0Ow0KIA0KIAlzdHJ1Y3Qgdmd0b2RfdHMJYmFzZXRpbWVbVkdUT0RfQkFTRVNdOw0KIA0K
LS0gDQoyLjQuNg0KDQo=
