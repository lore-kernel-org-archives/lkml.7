Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE9ECC10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 07:09:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DBF620874
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 07:09:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="mMoZkrW+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbfDOHJU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 03:09:20 -0400
Received: from mail-eopbgr140052.outbound.protection.outlook.com ([40.107.14.52]:37702
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725798AbfDOHJT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 03:09:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KZjpu1iU2KMpqj5Y0ytF0flhM2/TJfGKz9BZOsPGe3I=;
 b=mMoZkrW+aJuMMb1tKgmbUKQDxEAWrMGzOi+2yv7bVc7AoHh6LIVbYkskcKC7aaqj01SYtuKswb32Jar2NrHsfrjH4uwNHdIeezTKelTTTaRvg92/e0crSmcP1aqSPhtqmD8xdxvCiGlc0MioFsSA5iJ8cUmA6Wzc3pZsOz1kugQ=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB4765.eurprd08.prod.outlook.com (10.255.113.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.19; Mon, 15 Apr 2019 07:09:15 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::6ca6:1d85:8903:90d7]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::6ca6:1d85:8903:90d7%5]) with mapi id 15.20.1792.018; Mon, 15 Apr 2019
 07:09:15 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Liviu Dudau <Liviu.Dudau@arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "sean@poorly.run" <sean@poorly.run>
CC:     "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "thomas Sun (Arm Technology China)" <thomas.Sun@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "Tiannan Zhu (Arm Technology China)" <Tiannan.Zhu@arm.com>,
        "Yiqi Kang (Arm Technology China)" <Yiqi.Kang@arm.com>,
        nd <nd@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
Subject: [PATCH v1 3/6] drm/komeda: Implement D71 scaler support
Thread-Topic: [PATCH v1 3/6] drm/komeda: Implement D71 scaler support
Thread-Index: AQHU81oiecYNSIcS+UGtZppo/ig3Dw==
Date:   Mon, 15 Apr 2019 07:09:15 +0000
Message-ID: <20190415070828.24075-4-james.qian.wang@arm.com>
References: <20190415070828.24075-1-james.qian.wang@arm.com>
In-Reply-To: <20190415070828.24075-1-james.qian.wang@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK0P153CA0011.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:18::23) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e8f9405b-8c76-412d-4afd-08d6c17144be
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600140)(711020)(4605104)(4618075)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VE1PR08MB4765;
x-ms-traffictypediagnostic: VE1PR08MB4765:
nodisclaimer: True
x-microsoft-antispam-prvs: <VE1PR08MB47659BADD59EBA8EF4E6AF95B32B0@VE1PR08MB4765.eurprd08.prod.outlook.com>
x-forefront-prvs: 000800954F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(136003)(39860400002)(376002)(346002)(199004)(189003)(186003)(14454004)(446003)(81156014)(486006)(66066001)(8676002)(26005)(5660300002)(6436002)(1076003)(103116003)(6512007)(76176011)(36756003)(476003)(14444005)(2616005)(7736002)(4326008)(81166006)(11346002)(305945005)(2906002)(25786009)(71200400001)(71190400001)(68736007)(86362001)(2201001)(50226002)(102836004)(110136005)(97736004)(386003)(6506007)(55236004)(54906003)(256004)(8936002)(52116002)(106356001)(105586002)(2501003)(6486002)(53936002)(3846002)(478600001)(99286004)(316002)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB4765;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: hBAX6WpRf0i4xiSw9cDm14CLGdOzYqpP/ZhPUTLMzxboEtAKFWABCKleUKpEsgOwyzaiH+9es47TEE7ZWRHpSHpZJ+9aY9sI1UTfvVGva1jufVMpGsm8i4N9Kke+cjiVPTAxG+XfmkQeK1u/kq0MwGY62kFDq7ohLW4SZRy6GyoTSO9nA/WIsF2jWhxQsSGrx6dQNOL/6hYm/sO+UINpkVqRFBd4ldNvY/OdSEfippWrdeX515WELUrg27QeRvocbQKaq0lL5NKaL/e7hiirPAYSjbA/5kQfugPMEHHXTJ6os5dsgscWchuhEu80mTP2Q20u6b9WDShoPa8hpp2HadhXolGe/+MQYUgVoxJTpj2CFOe38R5cgbrs08H7xedF6hVl7MbJgIsLRRT9p81LVydVdQ1Cj0h1CfCqQA4v9fU=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8f9405b-8c76-412d-4afd-08d6c17144be
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2019 07:09:15.0892
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4765
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MS4gQWRkIHNjYWxlciBjb21wb25lbnQgYW5kIGluaXRpYWxpemUgaXQgYWNjb3JkaW5nIHRvIEQ3
MSBIVy4NCjIuIEltcGxlbWVudCBkNzFfc2NhbGVyX3VwZGF0ZS9kaXNhYmxlL2R1bXANCg0KU2ln
bmVkLW9mZi1ieTogSmFtZXMgUWlhbiBXYW5nIChBcm0gVGVjaG5vbG9neSBDaGluYSkgPGphbWVz
LnFpYW4ud2FuZ0Bhcm0uY29tPg0KLS0tDQogLi4uL2FybS9kaXNwbGF5L2tvbWVkYS9kNzEvZDcx
X2NvbXBvbmVudC5jICAgIHwgMTMxICsrKysrKysrKysrKysrKysrLQ0KIDEgZmlsZSBjaGFuZ2Vk
LCAxMzAgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2FybS9kaXNwbGF5L2tvbWVkYS9kNzEvZDcxX2NvbXBvbmVudC5jIGIvZHJpdmVy
cy9ncHUvZHJtL2FybS9kaXNwbGF5L2tvbWVkYS9kNzEvZDcxX2NvbXBvbmVudC5jDQppbmRleCAz
M2NhMTcxOGI1Y2QuLjVhNGM4ZmQxMjJkYSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3B1L2RybS9h
cm0vZGlzcGxheS9rb21lZGEvZDcxL2Q3MV9jb21wb25lbnQuYw0KKysrIGIvZHJpdmVycy9ncHUv
ZHJtL2FybS9kaXNwbGF5L2tvbWVkYS9kNzEvZDcxX2NvbXBvbmVudC5jDQpAQCAtNTUxLDYgKzU1
MSwxMzIgQEAgc3RhdGljIGludCBkNzFfY29tcGl6X2luaXQoc3RydWN0IGQ3MV9kZXYgKmQ3MSwN
CiAJcmV0dXJuIDA7DQogfQ0KIA0KK3N0YXRpYyB2b2lkIGQ3MV9zY2FsZXJfdXBkYXRlX2ZpbHRl
cl9sdXQodTMyIF9faW9tZW0gKnJlZywgdTMyIGhzaXplX2luLA0KKwkJCQkJIHUzMiB2c2l6ZV9p
biwgdTMyIGhzaXplX291dCwNCisJCQkJCSB1MzIgdnNpemVfb3V0KQ0KK3sNCisJdTMyIHZhbCA9
IDA7DQorDQorCWlmIChoc2l6ZV9pbiA8PSBoc2l6ZV9vdXQpDQorCQl2YWwgIHw9IDB4NjI7DQor
CWVsc2UgaWYgKGhzaXplX2luIDw9IChoc2l6ZV9vdXQgKyBoc2l6ZV9vdXQgLyAyKSkNCisJCXZh
bCB8PSAweDYzOw0KKwllbHNlIGlmIChoc2l6ZV9pbiA8PSBoc2l6ZV9vdXQgKiAyKQ0KKwkJdmFs
IHw9IDB4NjQ7DQorCWVsc2UgaWYgKGhzaXplX2luIDw9IGhzaXplX291dCAqIDIgKyAoaHNpemVf
b3V0ICogMykgLyA0KQ0KKwkJdmFsIHw9IDB4NjU7DQorCWVsc2UNCisJCXZhbCB8PSAweDY2Ow0K
Kw0KKwlpZiAodnNpemVfaW4gPD0gdnNpemVfb3V0KQ0KKwkJdmFsICB8PSBTQ19WVFNFTCgweDZB
KTsNCisJZWxzZSBpZiAodnNpemVfaW4gPD0gKHZzaXplX291dCArIHZzaXplX291dCAvIDIpKQ0K
KwkJdmFsIHw9IFNDX1ZUU0VMKDB4NkIpOw0KKwllbHNlIGlmICh2c2l6ZV9pbiA8PSB2c2l6ZV9v
dXQgKiAyKQ0KKwkJdmFsIHw9IFNDX1ZUU0VMKDB4NkMpOw0KKwllbHNlIGlmICh2c2l6ZV9pbiA8
PSB2c2l6ZV9vdXQgKiAyICsgdnNpemVfb3V0ICogMyAvIDQpDQorCQl2YWwgfD0gU0NfVlRTRUwo
MHg2RCk7DQorCWVsc2UNCisJCXZhbCB8PSBTQ19WVFNFTCgweDZFKTsNCisNCisJbWFsaWRwX3dy
aXRlMzIocmVnLCBTQ19DT0VGRlRBQiwgdmFsKTsNCit9DQorDQorc3RhdGljIHZvaWQgZDcxX3Nj
YWxlcl91cGRhdGUoc3RydWN0IGtvbWVkYV9jb21wb25lbnQgKmMsDQorCQkJICAgICAgc3RydWN0
IGtvbWVkYV9jb21wb25lbnRfc3RhdGUgKnN0YXRlKQ0KK3sNCisJc3RydWN0IGtvbWVkYV9zY2Fs
ZXJfc3RhdGUgKnN0ID0gdG9fc2NhbGVyX3N0KHN0YXRlKTsNCisJdTMyIF9faW9tZW0gKnJlZyA9
IGMtPnJlZzsNCisJdTMyIGluaXRfcGgsIGRlbHRhX3BoLCBjdHJsOw0KKw0KKwlkNzFfc2NhbGVy
X3VwZGF0ZV9maWx0ZXJfbHV0KHJlZywgc3QtPmhzaXplX2luLCBzdC0+dnNpemVfaW4sDQorCQkJ
CSAgICAgc3QtPmhzaXplX291dCwgc3QtPnZzaXplX291dCk7DQorDQorCW1hbGlkcF93cml0ZTMy
KHJlZywgQkxLX0lOX1NJWkUsIEhWX1NJWkUoc3QtPmhzaXplX2luLCBzdC0+dnNpemVfaW4pKTsN
CisJbWFsaWRwX3dyaXRlMzIocmVnLCBTQ19PVVRfU0laRSwgSFZfU0laRShzdC0+aHNpemVfb3V0
LCBzdC0+dnNpemVfb3V0KSk7DQorDQorCWluaXRfcGggPSAoc3QtPmhzaXplX2luIDw8IDE1KSAv
IHN0LT5oc2l6ZV9vdXQ7DQorCW1hbGlkcF93cml0ZTMyKHJlZywgU0NfSF9JTklUX1BILCBpbml0
X3BoKTsNCisNCisJZGVsdGFfcGggPSAoc3QtPmhzaXplX2luIDw8IDE2KSAvIHN0LT5oc2l6ZV9v
dXQ7DQorCW1hbGlkcF93cml0ZTMyKHJlZywgU0NfSF9ERUxUQV9QSCwgZGVsdGFfcGgpOw0KKw0K
Kwlpbml0X3BoID0gKHN0LT52c2l6ZV9pbiA8PCAxNSkgLyBzdC0+dnNpemVfb3V0Ow0KKwltYWxp
ZHBfd3JpdGUzMihyZWcsIFNDX1ZfSU5JVF9QSCwgaW5pdF9waCk7DQorDQorCWRlbHRhX3BoID0g
KHN0LT52c2l6ZV9pbiA8PCAxNikgLyBzdC0+dnNpemVfb3V0Ow0KKwltYWxpZHBfd3JpdGUzMihy
ZWcsIFNDX1ZfREVMVEFfUEgsIGRlbHRhX3BoKTsNCisNCisJY3RybCA9IDA7DQorCWN0cmwgfD0g
c3QtPmVuX3NjYWxpbmcgPyBTQ19DVFJMX1NDTCA6IDA7DQorCWN0cmwgfD0gc3QtPmVuX2FscGhh
ID8gU0NfQ1RSTF9BUCA6IDA7DQorDQorCW1hbGlkcF93cml0ZTMyKHJlZywgQkxLX0NPTlRST0ws
IGN0cmwpOw0KKwltYWxpZHBfd3JpdGUzMihyZWcsIEJMS19JTlBVVF9JRDAsIHRvX2Q3MV9pbnB1
dF9pZCgmc3RhdGUtPmlucHV0c1swXSkpOw0KK30NCisNCitzdGF0aWMgdm9pZCBkNzFfc2NhbGVy
X2R1bXAoc3RydWN0IGtvbWVkYV9jb21wb25lbnQgKmMsIHN0cnVjdCBzZXFfZmlsZSAqc2YpDQor
ew0KKwl1MzIgdls5XTsNCisNCisJZHVtcF9ibG9ja19oZWFkZXIoc2YsIGMtPnJlZyk7DQorDQor
CWdldF92YWx1ZXNfZnJvbV9yZWcoYy0+cmVnLCAweDgwLCAxLCB2KTsNCisJc2VxX3ByaW50Zihz
ZiwgIlNDX0lOUFVUX0lEMDpcdFx0MHglWFxuIiwgdlswXSk7DQorDQorCWdldF92YWx1ZXNfZnJv
bV9yZWcoYy0+cmVnLCAweEQwLCAxLCB2KTsNCisJc2VxX3ByaW50ZihzZiwgIlNDX0NPTlRST0w6
XHRcdDB4JVhcbiIsIHZbMF0pOw0KKw0KKwlnZXRfdmFsdWVzX2Zyb21fcmVnKGMtPnJlZywgMHhE
QywgOSwgdik7DQorCXNlcV9wcmludGYoc2YsICJTQ19DT0VGRlRBQjpcdFx0MHglWFxuIiwgdlsw
XSk7DQorCXNlcV9wcmludGYoc2YsICJTQ19JTl9TSVpFOlx0XHQweCVYXG4iLCB2WzFdKTsNCisJ
c2VxX3ByaW50ZihzZiwgIlNDX09VVF9TSVpFOlx0XHQweCVYXG4iLCB2WzJdKTsNCisJc2VxX3By
aW50ZihzZiwgIlNDX0hfQ1JPUDpcdFx0MHglWFxuIiwgdlszXSk7DQorCXNlcV9wcmludGYoc2Ys
ICJTQ19WX0NST1A6XHRcdDB4JVhcbiIsIHZbNF0pOw0KKwlzZXFfcHJpbnRmKHNmLCAiU0NfSF9J
TklUX1BIOlx0XHQweCVYXG4iLCB2WzVdKTsNCisJc2VxX3ByaW50ZihzZiwgIlNDX0hfREVMVEFf
UEg6XHRcdDB4JVhcbiIsIHZbNl0pOw0KKwlzZXFfcHJpbnRmKHNmLCAiU0NfVl9JTklUX1BIOlx0
XHQweCVYXG4iLCB2WzddKTsNCisJc2VxX3ByaW50ZihzZiwgIlNDX1ZfREVMVEFfUEg6XHRcdDB4
JVhcbiIsIHZbOF0pOw0KK30NCisNCitzdGF0aWMgc3RydWN0IGtvbWVkYV9jb21wb25lbnRfZnVu
Y3MgZDcxX3NjYWxlcl9mdW5jcyA9IHsNCisJLnVwZGF0ZQkJPSBkNzFfc2NhbGVyX3VwZGF0ZSwN
CisJLmRpc2FibGUJPSBkNzFfY29tcG9uZW50X2Rpc2FibGUsDQorCS5kdW1wX3JlZ2lzdGVyCT0g
ZDcxX3NjYWxlcl9kdW1wLA0KK307DQorDQorc3RhdGljIGludCBkNzFfc2NhbGVyX2luaXQoc3Ry
dWN0IGQ3MV9kZXYgKmQ3MSwNCisJCQkgICBzdHJ1Y3QgYmxvY2tfaGVhZGVyICpibGssIHUzMiBf
X2lvbWVtICpyZWcpDQorew0KKwlzdHJ1Y3Qga29tZWRhX2NvbXBvbmVudCAqYzsNCisJc3RydWN0
IGtvbWVkYV9zY2FsZXIgKnNjYWxlcjsNCisJdTMyIHBpcGVfaWQsIGNvbXBfaWQ7DQorDQorCWdl
dF9yZXNvdXJjZXNfaWQoYmxrLT5ibG9ja19pbmZvLCAmcGlwZV9pZCwgJmNvbXBfaWQpOw0KKw0K
KwljID0ga29tZWRhX2NvbXBvbmVudF9hZGQoJmQ3MS0+cGlwZXNbcGlwZV9pZF0tPmJhc2UsIHNp
emVvZigqc2NhbGVyKSwNCisJCQkJIGNvbXBfaWQsIEJMT0NLX0lORk9fSU5QVVRfSUQoYmxrLT5i
bG9ja19pbmZvKSwNCisJCQkJICZkNzFfc2NhbGVyX2Z1bmNzLA0KKwkJCQkgMSwgZ2V0X3ZhbGlk
X2lucHV0cyhibGspLCAxLCByZWcsDQorCQkJCSAiQ1UlZF9TQ0FMRVIlZCIsDQorCQkJCSBwaXBl
X2lkLCBCTE9DS19JTkZPX0JMS19JRChibGstPmJsb2NrX2luZm8pKTsNCisNCisJaWYgKCFjKSB7
DQorCQlEUk1fRVJST1IoIkZhaWxlZCB0byBpbml0aWFsaXplIHNjYWxlciIpOw0KKwkJcmV0dXJu
IC0xOw0KKwl9DQorDQorCXNjYWxlciA9IHRvX3NjYWxlcihjKTsNCisJc2V0X3JhbmdlKCZzY2Fs
ZXItPmhzaXplLCA0LCBkNzEtPm1heF9saW5lX3NpemUpOw0KKwlzZXRfcmFuZ2UoJnNjYWxlci0+
dnNpemUsIDQsIDQwOTYpOw0KKwlzY2FsZXItPm1heF9kb3duc2NhbGluZyA9IDY7DQorCXNjYWxl
ci0+bWF4X3Vwc2NhbGluZyA9IDY0Ow0KKw0KKwltYWxpZHBfd3JpdGUzMihjLT5yZWcsIEJMS19D
T05UUk9MLCAwKTsNCisNCisJcmV0dXJuIDA7DQorfQ0KKw0KIHN0YXRpYyB2b2lkIGQ3MV9pbXBy
b2NfdXBkYXRlKHN0cnVjdCBrb21lZGFfY29tcG9uZW50ICpjLA0KIAkJCSAgICAgIHN0cnVjdCBr
b21lZGFfY29tcG9uZW50X3N0YXRlICpzdGF0ZSkNCiB7DQpAQCAtNzcwLDggKzg5NiwxMSBAQCBp
bnQgZDcxX3Byb2JlX2Jsb2NrKHN0cnVjdCBkNzFfZGV2ICpkNzEsDQogCQllcnIgPSBkNzFfY29t
cGl6X2luaXQoZDcxLCBibGssIHJlZyk7DQogCQlicmVhazsNCiANCi0JY2FzZSBENzFfQkxLX1RZ
UEVfQ1VfU1BMSVRURVI6DQogCWNhc2UgRDcxX0JMS19UWVBFX0NVX1NDQUxFUjoNCisJCWVyciA9
IGQ3MV9zY2FsZXJfaW5pdChkNzEsIGJsaywgcmVnKTsNCisJCWJyZWFrOw0KKw0KKwljYXNlIEQ3
MV9CTEtfVFlQRV9DVV9TUExJVFRFUjoNCiAJY2FzZSBENzFfQkxLX1RZUEVfQ1VfTUVSR0VSOg0K
IAkJYnJlYWs7DQogDQotLSANCjIuMTcuMQ0KDQo=
