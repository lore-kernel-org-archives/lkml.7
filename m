Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E809C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 11:07:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26044218E2
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 11:07:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="lM23HOeX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbfDILHd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 07:07:33 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:55266 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbfDILHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 07:07:30 -0400
X-IronPort-AV: E=Sophos;i="5.60,329,1549954800"; 
   d="scan'208";a="29738791"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 09 Apr 2019 04:07:29 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.38) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Tue, 9 Apr 2019 04:07:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fy40osxoOl1PC4sq+lAQ9JLO5R7YNNWYg1FqHbxUQiE=;
 b=lM23HOeXsTgfedk0rYEgkNuVFAhCRjB6FJXDr67beCSyMYbSgi+FOnp3PEA3gaAwpMto8r1ioYgXruUje1dvMnuG7mL16Wr+E+ZP/0j7BbYPtBqrAA27XrqSoJE6/DKFbeiFYttAxDNtSHyLan2ubH4D9uNawtMq3VM6fLcMDc8=
Received: from DM5PR11MB1242.namprd11.prod.outlook.com (10.168.108.8) by
 DM5PR11MB0011.namprd11.prod.outlook.com (10.164.155.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.19; Tue, 9 Apr 2019 11:07:27 +0000
Received: from DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::e0e3:1d51:9e3e:6dc]) by DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::e0e3:1d51:9e3e:6dc%3]) with mapi id 15.20.1771.021; Tue, 9 Apr 2019
 11:07:27 +0000
From:   <Eugen.Hristev@microchip.com>
To:     <linux-media@vger.kernel.org>, <hverkuil@xs4all.nl>,
        <Nicolas.Ferre@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mchehab@kernel.org>
CC:     <ksloat@aampglobal.com>, <Eugen.Hristev@microchip.com>
Subject: [PATCH 1/7] media: atmel: atmel-isc: add safe checks and fixed wrong
 ISC state in error case
Thread-Topic: [PATCH 1/7] media: atmel: atmel-isc: add safe checks and fixed
 wrong ISC state in error case
Thread-Index: AQHU7sRnq25L58WM2EaOgqX2GZumDQ==
Date:   Tue, 9 Apr 2019 11:07:21 +0000
Message-ID: <1554807715-2353-2-git-send-email-eugen.hristev@microchip.com>
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
x-ms-office365-filtering-correlation-id: 54d39806-c97e-4f58-cea7-08d6bcdb89b4
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);SRVR:DM5PR11MB0011;
x-ms-traffictypediagnostic: DM5PR11MB0011:
x-microsoft-antispam-prvs: <DM5PR11MB001173F075618A40E2114CC1E82D0@DM5PR11MB0011.namprd11.prod.outlook.com>
x-forefront-prvs: 000227DA0C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(376002)(366004)(396003)(39850400004)(199004)(189003)(256004)(81166006)(66066001)(486006)(8676002)(36756003)(6666004)(446003)(476003)(5660300002)(81156014)(50226002)(8936002)(71200400001)(71190400001)(14444005)(2616005)(11346002)(6512007)(106356001)(105586002)(7736002)(305945005)(478600001)(4326008)(2201001)(186003)(99286004)(76176011)(6486002)(107886003)(68736007)(97736004)(72206003)(110136005)(14454004)(316002)(53936002)(52116002)(26005)(54906003)(6436002)(6506007)(6116002)(2501003)(2906002)(3846002)(386003)(25786009)(102836004)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR11MB0011;H:DM5PR11MB1242.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: kKZoQoVvQL0rG8wgj2qE+/ZEDHRsqEaW/e1Jea67AjQJquMn3xjcT/A6i/FvMdOswyWh/zwXa0K6rDSjYLdfyqXfWcLO8Wl275pn/0UR9wlV5woWzNQ/HUpWsH2D1u6jLhzaCiNsaxOlhAXCSoZIPFFWXZyx10UTQVFgpom32D4msUbQRip++z7bkb+MCXDAzB+IlvnV/HLeHTtshJEJqMbScD9Q2kG6XcF/Rzr3kik95H8qpXf1dFrWiWkk9NM1U11PIR8QdviDYNJbKap1ST0aQDaD8IrQJhLa3LagtIlNSIb+TxdY77z4OiAq0P9rloTbSCdOfDCwPCxKByTG5QMn8pAdWEHeYFiI47HqbEys1Yg+17tFg2LdHFkjBsEItoOLXa2zTvkAICxeJhUKy5zLLyCtziZjp0WzsRCcBFA=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 54d39806-c97e-4f58-cea7-08d6bcdb89b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2019 11:07:21.8005
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
IGFkZHMgc2FmZXR5IGNoZWNrcyBvbiBzb21lIHNjZW5hcmlvczoNCi0gc3RhcnQgc3RyZWFtaW5n
IGJ1dCBzdHJlYW1pbmcgaXMgYWxyZWFkeSBzdGFydGVkDQotIHN0YXJ0IHN0cmVhbWluZyBidXQg
bm8gYnVmZmVyIGluIHRoZSBkbWEgcXVldWUNCi0gc3BpbiBsb2NrIGlzIG5vdCByZWxlYXNlZCBp
biBlcnJvciBzY2VuYXJpbw0KLSBubyBmcmFtZSBpcyBjb25maWd1cmVkIGJ1dCBkbWEgaXMgcmVx
dWVzdGVkIHRvIHN0YXJ0DQotIGNvbmZpZ3VyZSBJU0MgbWF5IGhhdmUgYmVlbiBjYWxsZWQgd2l0
aG91dCBuZWVkLCBiZWZvcmUgY2hlY2tpbmcgaWYgYnVmZmVyIGlzDQpvay4NCg0KU2lnbmVkLW9m
Zi1ieTogRXVnZW4gSHJpc3RldiA8ZXVnZW4uaHJpc3RldkBtaWNyb2NoaXAuY29tPg0KLS0tDQog
ZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9hdG1lbC9hdG1lbC1pc2MuYyB8IDMyICsrKysrKysrKysr
KysrKysrKysrKysrKysrKy0tLS0tDQogMSBmaWxlIGNoYW5nZWQsIDI3IGluc2VydGlvbnMoKyks
IDUgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL2F0
bWVsL2F0bWVsLWlzYy5jIGIvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9hdG1lbC9hdG1lbC1pc2Mu
Yw0KaW5kZXggYTEwZGIxNi4uM2MxOTc2MSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvbWVkaWEvcGxh
dGZvcm0vYXRtZWwvYXRtZWwtaXNjLmMNCisrKyBiL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vYXRt
ZWwvYXRtZWwtaXNjLmMNCkBAIC03MjIsNiArNzIyLDExIEBAIHN0YXRpYyB2b2lkIGlzY19zdGFy
dF9kbWEoc3RydWN0IGlzY19kZXZpY2UgKmlzYykNCiAJdTMyIGRjdHJsX2R2aWV3Ow0KIAlkbWFf
YWRkcl90IGFkZHIwOw0KIA0KKwlpZiAoIWlzYy0+Y3VyX2ZybSkgew0KKwkJdjRsMl9lcnIoJmlz
Yy0+djRsMl9kZXYsICJWaWRlbyBidWZmZXIgbm90IGF2YWlsYWJsZVxuIik7DQorCQlyZXR1cm47
DQorCX0NCisNCiAJYWRkcjAgPSB2YjJfZG1hX2NvbnRpZ19wbGFuZV9kbWFfYWRkcigmaXNjLT5j
dXJfZnJtLT52Yi52YjJfYnVmLCAwKTsNCiAJcmVnbWFwX3dyaXRlKHJlZ21hcCwgSVNDX0RBRDAs
IGFkZHIwKTsNCiANCkBAIC04ODYsNiArODkxLDkgQEAgc3RhdGljIGludCBpc2Nfc3RhcnRfc3Ry
ZWFtaW5nKHN0cnVjdCB2YjJfcXVldWUgKnZxLCB1bnNpZ25lZCBpbnQgY291bnQpDQogCXVuc2ln
bmVkIGxvbmcgZmxhZ3M7DQogCWludCByZXQ7DQogDQorCWlmICh2YjJfaXNfc3RyZWFtaW5nKCZp
c2MtPnZiMl92aWRxKSkNCisJCXJldHVybiAtRUJVU1k7DQorDQogCS8qIEVuYWJsZSBzdHJlYW0g
b24gdGhlIHN1YiBkZXZpY2UgKi8NCiAJcmV0ID0gdjRsMl9zdWJkZXZfY2FsbChpc2MtPmN1cnJl
bnRfc3ViZGV2LT5zZCwgdmlkZW8sIHNfc3RyZWFtLCAxKTsNCiAJaWYgKHJldCAmJiByZXQgIT0g
LUVOT0lPQ1RMQ01EKSB7DQpAQCAtODk2LDYgKzkwNCwyMCBAQCBzdGF0aWMgaW50IGlzY19zdGFy
dF9zdHJlYW1pbmcoc3RydWN0IHZiMl9xdWV1ZSAqdnEsIHVuc2lnbmVkIGludCBjb3VudCkNCiAN
CiAJcG1fcnVudGltZV9nZXRfc3luYyhpc2MtPmRldik7DQogDQorCXNwaW5fbG9ja19pcnFzYXZl
KCZpc2MtPmRtYV9xdWV1ZV9sb2NrLCBmbGFncyk7DQorDQorCWlzYy0+c2VxdWVuY2UgPSAwOw0K
Kwlpc2MtPnN0b3AgPSBmYWxzZTsNCisJcmVpbml0X2NvbXBsZXRpb24oJmlzYy0+Y29tcCk7DQor
DQorCWlmIChsaXN0X2VtcHR5KCZpc2MtPmRtYV9xdWV1ZSkpIHsNCisJCXY0bDJfZXJyKCZpc2Mt
PnY0bDJfZGV2LCAiZG1hIHF1ZXVlIGVtcHR5XG4iKTsNCisJCXJldCA9IC1FSU5WQUw7DQorCQln
b3RvIGVycl9jb25maWd1cmVfdW5sb2NrOw0KKwl9DQorDQorCXNwaW5fdW5sb2NrX2lycXJlc3Rv
cmUoJmlzYy0+ZG1hX3F1ZXVlX2xvY2ssIGZsYWdzKTsNCisNCiAJcmV0ID0gaXNjX2NvbmZpZ3Vy
ZShpc2MpOw0KIAlpZiAodW5saWtlbHkocmV0KSkNCiAJCWdvdG8gZXJyX2NvbmZpZ3VyZTsNCkBA
IC05MDUsMTAgKzkyNyw2IEBAIHN0YXRpYyBpbnQgaXNjX3N0YXJ0X3N0cmVhbWluZyhzdHJ1Y3Qg
dmIyX3F1ZXVlICp2cSwgdW5zaWduZWQgaW50IGNvdW50KQ0KIA0KIAlzcGluX2xvY2tfaXJxc2F2
ZSgmaXNjLT5kbWFfcXVldWVfbG9jaywgZmxhZ3MpOw0KIA0KLQlpc2MtPnNlcXVlbmNlID0gMDsN
Ci0JaXNjLT5zdG9wID0gZmFsc2U7DQotCXJlaW5pdF9jb21wbGV0aW9uKCZpc2MtPmNvbXApOw0K
LQ0KIAlpc2MtPmN1cl9mcm0gPSBsaXN0X2ZpcnN0X2VudHJ5KCZpc2MtPmRtYV9xdWV1ZSwNCiAJ
CQkJCXN0cnVjdCBpc2NfYnVmZmVyLCBsaXN0KTsNCiAJbGlzdF9kZWwoJmlzYy0+Y3VyX2ZybS0+
bGlzdCk7DQpAQCAtOTE5LDggKzkzNywxMSBAQCBzdGF0aWMgaW50IGlzY19zdGFydF9zdHJlYW1p
bmcoc3RydWN0IHZiMl9xdWV1ZSAqdnEsIHVuc2lnbmVkIGludCBjb3VudCkNCiANCiAJcmV0dXJu
IDA7DQogDQorZXJyX2NvbmZpZ3VyZV91bmxvY2s6DQorCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUo
JmlzYy0+ZG1hX3F1ZXVlX2xvY2ssIGZsYWdzKTsNCisNCiBlcnJfY29uZmlndXJlOg0KLQlwbV9y
dW50aW1lX3B1dF9zeW5jKGlzYy0+ZGV2KTsNCisJaXNjLT5zdG9wID0gdHJ1ZTsNCiANCiAJdjRs
Ml9zdWJkZXZfY2FsbChpc2MtPmN1cnJlbnRfc3ViZGV2LT5zZCwgdmlkZW8sIHNfc3RyZWFtLCAw
KTsNCiANCkBAIC05MzEsNiArOTUyLDcgQEAgc3RhdGljIGludCBpc2Nfc3RhcnRfc3RyZWFtaW5n
KHN0cnVjdCB2YjJfcXVldWUgKnZxLCB1bnNpZ25lZCBpbnQgY291bnQpDQogCUlOSVRfTElTVF9I
RUFEKCZpc2MtPmRtYV9xdWV1ZSk7DQogCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJmlzYy0+ZG1h
X3F1ZXVlX2xvY2ssIGZsYWdzKTsNCiANCisJcG1fcnVudGltZV9wdXRfc3luYyhpc2MtPmRldik7
DQogCXJldHVybiByZXQ7DQogfQ0KIA0KLS0gDQoyLjcuNA0KDQo=
