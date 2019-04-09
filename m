Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CE3AC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 11:07:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F191C2084F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 11:07:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="fOxnvFOP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbfDILHx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 07:07:53 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:55266 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbfDILHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 07:07:34 -0400
X-IronPort-AV: E=Sophos;i="5.60,329,1549954800"; 
   d="scan'208";a="29738805"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 09 Apr 2019 04:07:33 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.106) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Tue, 9 Apr 2019 04:07:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8E/p0FPFMNXWGuNw0abjyVkKdI/h196NH068J1g2B00=;
 b=fOxnvFOPWnzOnTt4/uuUBKAxlfDNHEOqh986R7gJ+Dr431PuA1f9Jf/90mHnhOveW8Oj53aXASxW8LgJS26I2EbU1b+8ss/JTPctwy3zxNoxweROrOZ4dFIDcu3r9sK3buTB1lO22dZhtYuUkmknEGdBdJYUPfVdk5gQ7i4Jjb0=
Received: from DM5PR11MB1242.namprd11.prod.outlook.com (10.168.108.8) by
 DM5PR11MB0011.namprd11.prod.outlook.com (10.164.155.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.19; Tue, 9 Apr 2019 11:07:31 +0000
Received: from DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::e0e3:1d51:9e3e:6dc]) by DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::e0e3:1d51:9e3e:6dc%3]) with mapi id 15.20.1771.021; Tue, 9 Apr 2019
 11:07:31 +0000
From:   <Eugen.Hristev@microchip.com>
To:     <linux-media@vger.kernel.org>, <hverkuil@xs4all.nl>,
        <Nicolas.Ferre@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mchehab@kernel.org>
CC:     <ksloat@aampglobal.com>, <Eugen.Hristev@microchip.com>
Subject: [PATCH 5/7] media: atmel: atmel-isc: limit incoming pixels per frame
Thread-Topic: [PATCH 5/7] media: atmel: atmel-isc: limit incoming pixels per
 frame
Thread-Index: AQHU7sRtpDUqf390MEyRUtIRVD50SA==
Date:   Tue, 9 Apr 2019 11:07:31 +0000
Message-ID: <1554807715-2353-6-git-send-email-eugen.hristev@microchip.com>
References: <1554807715-2353-1-git-send-email-eugen.hristev@microchip.com>
In-Reply-To: <1554807715-2353-1-git-send-email-eugen.hristev@microchip.com>
Accept-Language: ro-RO, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR09CA0054.eurprd09.prod.outlook.com
 (2603:10a6:802:28::22) To DM5PR11MB1242.namprd11.prod.outlook.com
 (2603:10b6:3:14::8)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Eugen.Hristev@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f8a10e4e-347c-4a0b-1f6e-08d6bcdb8f56
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);SRVR:DM5PR11MB0011;
x-ms-traffictypediagnostic: DM5PR11MB0011:
x-microsoft-antispam-prvs: <DM5PR11MB00118C805FCEC9D2158713F3E82D0@DM5PR11MB0011.namprd11.prod.outlook.com>
x-forefront-prvs: 000227DA0C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(346002)(136003)(376002)(366004)(396003)(39850400004)(199004)(189003)(256004)(81166006)(66066001)(486006)(8676002)(36756003)(446003)(476003)(5660300002)(81156014)(50226002)(8936002)(71200400001)(71190400001)(14444005)(2616005)(11346002)(6512007)(106356001)(105586002)(7736002)(305945005)(478600001)(4326008)(2201001)(186003)(99286004)(76176011)(6486002)(107886003)(68736007)(97736004)(72206003)(110136005)(14454004)(316002)(53936002)(52116002)(26005)(54906003)(6436002)(6506007)(6116002)(2501003)(2906002)(3846002)(386003)(25786009)(102836004)(86362001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR11MB0011;H:DM5PR11MB1242.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: m7RRew/mtEZJGPLMnV+Oh5ExhTp3Vg9G2XAE5nJSLigZTKbfOOkqkpBSQvl6bWZ9Tcppz5SDmmY8vFXezV5IyVJSGcnULbyuJIbR5/5SbMH+b/n29KPJLbIhXoR7Yy0Zyg7T5DZlTcdJPX2ALnz5fQn7DfT5ZnJlRwdCHSd4h/IYJ8x4s46LL3TEavuAftMNsjBiwEkv3S3utYNTupG8EBnpRpo1XXfeGcutIgXAyKcxdLgD9NvbwmMIVL1TnEfCEPhUaHHxMauQfrAFiuMV7/cWCthgsrFlphusBP04RNLl9dk9glW1LxI62R1YNFW1tkoUG7qjeJLD6XlIh78TBluK8ngsx9n5zfZf8cdD24kQT23AoIAMidIwGvKAOrd5anvKUXN0wCAPJK3VOAAYhtYB1bZDzmvcVbZKEmBFzZM=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f8a10e4e-347c-4a0b-1f6e-08d6bcdb8f56
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2019 11:07:31.5906
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB0011
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogRXVnZW4gSHJpc3RldiA8ZXVnZW4uaHJpc3RldkBtaWNyb2NoaXAuY29tPg0KDQpUaGlz
IHdpbGwgbGltaXQgdGhlIGluY29taW5nIHBpeGVscyBwZXIgZnJhbWUgZnJvbSB0aGUgc2Vuc29y
Lg0KQ3VycmVudGx5LCB0aGUgSVNDIHdpbGwgc3RvcCBzYW1wbGluZyB0aGUgZnJhbWUgb25seSB3
aGVuIHRoZSB2c3luYy9oc3luYw0KYXJlIGRldGVjdGVkLg0KSWYgd2UgbWlzY29uZmlndXJlIHRo
ZSByZXNvbHV0aW9uIGluIHRoZSBzZW5zb3Igdy5yLnQuIHJlc29sdXRpb24gaW4gdGhlIElTQywN
CnRoZSBidWZmZXIgdXNlZCBmb3IgRE1BIGluIHRoZSBJU0Mgd2lsbCBiZSBzbWFsbGVyIHRoYW4g
dGhlIG51bWJlciBvZiBwaXhlbHMNCnRoYXQgdGhlIElTQyBETUEgZW5naW5lIHdpbGwgY29weS4N
CkluIHRoaXMgY2FzZSBpdCBoYXBwZW5zIHRoYXQgdGhlIERNQSB3aWxsIG92ZXJ3cml0ZSBwYXJ0
cyBvZiB0aGUgbWVtb3J5IHdoaWNoDQpzaG91bGQgbm90IGJlIHdyaXR0ZW4sIGxlYWRpbmcgdG8g
bWVtb3J5IGNvcnJ1cHRpb24uDQpUbyBhdm9pZCB0aGlzIHNpdHVhdGlvbiwgdXNlIHRoZSBQRkUg
Q0ZHMSBhbmQgUEZFIENGRzIgcmVnaXN0ZXJzLCB3aGljaCBjcm9wDQp0aGUgaW5jb21pbmcgZnJh
bWUgdG8gdGhlIHJlc29sdXRpb24gdGhhdCB3ZSBjb25maWd1cmUuDQpUaGlzIHdheSB0aGUgRE1B
IGVuZ2luZSB3aWxsIG5ldmVyIHdyaXRlIG1vcmUgZGF0YSB0aGFuIHdlIGV4cGVjdCBpdCB0by4N
Cg0KU2lnbmVkLW9mZi1ieTogRXVnZW4gSHJpc3RldiA8ZXVnZW4uaHJpc3RldkBtaWNyb2NoaXAu
Y29tPg0KLS0tDQogZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9hdG1lbC9hdG1lbC1pc2MtcmVncy5o
IHwgMTkgKysrKysrKysrKysrKysrDQogZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9hdG1lbC9hdG1l
bC1pc2MuYyAgICAgIHwgMzQgKysrKysrKysrKysrKysrKysrKysrKysrKysrDQogMiBmaWxlcyBj
aGFuZ2VkLCA1MyBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL21lZGlhL3Bs
YXRmb3JtL2F0bWVsL2F0bWVsLWlzYy1yZWdzLmggYi9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL2F0
bWVsL2F0bWVsLWlzYy1yZWdzLmgNCmluZGV4IGM3MjBiMWIuLjliM2E2MGIgMTAwNjQ0DQotLS0g
YS9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL2F0bWVsL2F0bWVsLWlzYy1yZWdzLmgNCisrKyBiL2Ry
aXZlcnMvbWVkaWEvcGxhdGZvcm0vYXRtZWwvYXRtZWwtaXNjLXJlZ3MuaA0KQEAgLTM1LDYgKzM1
LDI1IEBADQogI2RlZmluZSBJU0NfUEZHX0NGRzBfQlBTX1RXRUxWRSAoMHgwIDw8IDI4KQ0KICNk
ZWZpbmUgSVNDX1BGRV9DRkcwX0JQU19NQVNLICAgR0VOTUFTSygzMCwgMjgpDQogDQorI2RlZmlu
ZSBJU0NfUEZFX0NGRzBfQ09MRU4JQklUKDEyKQ0KKyNkZWZpbmUgSVNDX1BGRV9DRkcwX1JPV0VO
CUJJVCgxMykNCisNCisvKiBJU0MgUGFyYWxsZWwgRnJvbnQgRW5kIENvbmZpZ3VyYXRpb24gMSBS
ZWdpc3RlciAqLw0KKyNkZWZpbmUgSVNDX1BGRV9DRkcxICAgIDB4MDAwMDAwMTANCisNCisjZGVm
aW5lIElTQ19QRkVfQ0ZHMV9DT0xNSU4odikJCSgodikpDQorI2RlZmluZSBJU0NfUEZFX0NGRzFf
Q09MTUlOX01BU0sJR0VOTUFTSygxNSwgMCkNCisjZGVmaW5lIElTQ19QRkVfQ0ZHMV9DT0xNQVgo
dikJCSgodikgPDwgMTYpDQorI2RlZmluZSBJU0NfUEZFX0NGRzFfQ09MTUFYX01BU0sJR0VOTUFT
SygzMSwgMTYpDQorDQorLyogSVNDIFBhcmFsbGVsIEZyb250IEVuZCBDb25maWd1cmF0aW9uIDIg
UmVnaXN0ZXIgKi8NCisjZGVmaW5lIElTQ19QRkVfQ0ZHMiAgICAweDAwMDAwMDE0DQorDQorI2Rl
ZmluZSBJU0NfUEZFX0NGRzJfUk9XTUlOKHYpCQkoKHYpKQ0KKyNkZWZpbmUgSVNDX1BGRV9DRkcy
X1JPV01JTl9NQVNLCUdFTk1BU0soMTUsIDApDQorI2RlZmluZSBJU0NfUEZFX0NGRzJfUk9XTUFY
KHYpCQkoKHYpIDw8IDE2KQ0KKyNkZWZpbmUgSVNDX1BGRV9DRkcyX1JPV01BWF9NQVNLCUdFTk1B
U0soMzEsIDE2KQ0KKw0KIC8qIElTQyBDbG9jayBFbmFibGUgUmVnaXN0ZXIgKi8NCiAjZGVmaW5l
IElTQ19DTEtFTiAgICAgICAgICAgICAgIDB4MDAwMDAwMTgNCiANCmRpZmYgLS1naXQgYS9kcml2
ZXJzL21lZGlhL3BsYXRmb3JtL2F0bWVsL2F0bWVsLWlzYy5jIGIvZHJpdmVycy9tZWRpYS9wbGF0
Zm9ybS9hdG1lbC9hdG1lbC1pc2MuYw0KaW5kZXggZTUxNjgwNS4uOTAyYmQ3ZSAxMDA2NDQNCi0t
LSBhL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vYXRtZWwvYXRtZWwtaXNjLmMNCisrKyBiL2RyaXZl
cnMvbWVkaWEvcGxhdGZvcm0vYXRtZWwvYXRtZWwtaXNjLmMNCkBAIC03NjQsMTIgKzc2NCw0NiBA
QCBzdGF0aWMgdm9pZCBpc2Nfc3RhcnRfZG1hKHN0cnVjdCBpc2NfZGV2aWNlICppc2MpDQogCXUz
MiBzaXplaW1hZ2UgPSBpc2MtPmZtdC5mbXQucGl4LnNpemVpbWFnZTsNCiAJdTMyIGRjdHJsX2R2
aWV3Ow0KIAlkbWFfYWRkcl90IGFkZHIwOw0KKwl1MzIgaCwgdzsNCiANCiAJaWYgKCFpc2MtPmN1
cl9mcm0pIHsNCiAJCXY0bDJfZXJyKCZpc2MtPnY0bDJfZGV2LCAiVmlkZW8gYnVmZmVyIG5vdCBh
dmFpbGFibGVcbiIpOw0KIAkJcmV0dXJuOw0KIAl9DQogDQorCWggPSBpc2MtPmZtdC5mbXQucGl4
LmhlaWdodDsNCisJdyA9IGlzYy0+Zm10LmZtdC5waXgud2lkdGg7DQorDQorCS8qDQorCSAqIElu
IGNhc2UgdGhlIHNlbnNvciBpcyBub3QgUkFXLCBpdCB3aWxsIG91dHB1dCBhIHBpeGVsICgxMi0x
NiBiaXRzKQ0KKwkgKiB3aXRoIHR3byBzYW1wbGVzIG9uIHRoZSBJU0MgRGF0YSBidXMgKHdoaWNo
IGlzIDgtMTIpDQorCSAqIElTQyB3aWxsIGNvdW50IGVhY2ggc2FtcGxlLCBzbywgd2UgbmVlZCB0
byBtdWx0aXBseSB0aGVzZSB2YWx1ZXMNCisJICogYnkgdHdvLCB0byBnZXQgdGhlIHJlYWwgbnVt
YmVyIG9mIHNhbXBsZXMgZm9yIHRoZSByZXF1aXJlZCBwaXhlbHMuDQorCSAqLw0KKwlpZiAoIUlT
Q19JU19GT1JNQVRfUkFXKGlzYy0+Y29uZmlnLnNkX2Zvcm1hdC0+bWJ1c19jb2RlKSkgew0KKwkJ
aCA8PD0gMTsNCisJCXcgPDw9IDE7DQorCX0NCisNCisJLyoNCisJICogV2UgbGltaXQgdGhlIGNv
bHVtbi9yb3cgY291bnQgdGhhdCB0aGUgSVNDIHdpbGwgb3V0cHV0IGFjY29yZGluZw0KKwkgKiB0
byB0aGUgY29uZmlndXJlZCByZXNvbHV0aW9uIHRoYXQgd2Ugd2FudC4NCisJICogVGhpcyB3aWxs
IGF2b2lkIHRoZSBzaXR1YXRpb24gd2hlcmUgdGhlIHNlbnNvciBpcyBtaXNjb25maWd1cmVkLA0K
KwkgKiBzZW5kaW5nIG1vcmUgZGF0YSwgYW5kIHRoZSBJU0Mgd2lsbCBqdXN0IHRha2UgaXQgYW5k
IERNQSB0byBtZW1vcnksDQorCSAqIGNhdXNpbmcgY29ycnVwdGlvbi4NCisJICovDQorCXJlZ21h
cF93cml0ZShyZWdtYXAsIElTQ19QRkVfQ0ZHMSwNCisJCSAgICAgKElTQ19QRkVfQ0ZHMV9DT0xN
SU4oMCkgJiBJU0NfUEZFX0NGRzFfQ09MTUlOX01BU0spIHwNCisJCSAgICAgKElTQ19QRkVfQ0ZH
MV9DT0xNQVgodyAtIDEpICYgSVNDX1BGRV9DRkcxX0NPTE1BWF9NQVNLKSk7DQorDQorCXJlZ21h
cF93cml0ZShyZWdtYXAsIElTQ19QRkVfQ0ZHMiwNCisJCSAgICAgKElTQ19QRkVfQ0ZHMl9ST1dN
SU4oMCkgJiBJU0NfUEZFX0NGRzJfUk9XTUlOX01BU0spIHwNCisJCSAgICAgKElTQ19QRkVfQ0ZH
Ml9ST1dNQVgoaCAtIDEpICYgSVNDX1BGRV9DRkcyX1JPV01BWF9NQVNLKSk7DQorDQorCXJlZ21h
cF91cGRhdGVfYml0cyhyZWdtYXAsIElTQ19QRkVfQ0ZHMCwNCisJCQkgICBJU0NfUEZFX0NGRzBf
Q09MRU4gfCBJU0NfUEZFX0NGRzBfUk9XRU4sDQorCQkJICAgSVNDX1BGRV9DRkcwX0NPTEVOIHwg
SVNDX1BGRV9DRkcwX1JPV0VOKTsNCisNCiAJYWRkcjAgPSB2YjJfZG1hX2NvbnRpZ19wbGFuZV9k
bWFfYWRkcigmaXNjLT5jdXJfZnJtLT52Yi52YjJfYnVmLCAwKTsNCiAJcmVnbWFwX3dyaXRlKHJl
Z21hcCwgSVNDX0RBRDAsIGFkZHIwKTsNCiANCi0tIA0KMi43LjQNCg0K
