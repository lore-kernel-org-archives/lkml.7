Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EC06C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 07:09:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6627206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 07:09:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="RWuxKXRU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbfDOHJ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 03:09:26 -0400
Received: from mail-eopbgr30050.outbound.protection.outlook.com ([40.107.3.50]:62646
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725798AbfDOHJZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 03:09:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1RqbQwMGq3A5MRPgNd73J5r8QrV6/3IZCbO9mUUSRkw=;
 b=RWuxKXRUtSFr+VYMtPyxjuCVjDbjsBnwmxC9EXohexeOL09kXx8HIiAm/ajQQ3L8DVz0r94BL3gOhVr0JyhyYlY04857HiGpNeulkY/+V9JLwMd3QhgNgXMA4mejYFuyqFKE7zMp9zeGmrUJ+oMfIKaxy4HsVRWFhxLhCWO+usE=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB5151.eurprd08.prod.outlook.com (20.179.30.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.14; Mon, 15 Apr 2019 07:09:20 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::6ca6:1d85:8903:90d7]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::6ca6:1d85:8903:90d7%5]) with mapi id 15.20.1792.018; Mon, 15 Apr 2019
 07:09:20 +0000
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
Subject: [PATCH v1 4/6] drm/komeda: Add writeback scaling support
Thread-Topic: [PATCH v1 4/6] drm/komeda: Add writeback scaling support
Thread-Index: AQHU81olJofAIrFwekmd0yTMDMc2wg==
Date:   Mon, 15 Apr 2019 07:09:20 +0000
Message-ID: <20190415070828.24075-5-james.qian.wang@arm.com>
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
x-ms-office365-filtering-correlation-id: 3e57e2ce-723f-45f2-6c1e-08d6c17147de
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600140)(711020)(4605104)(4618075)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VE1PR08MB5151;
x-ms-traffictypediagnostic: VE1PR08MB5151:
nodisclaimer: True
x-microsoft-antispam-prvs: <VE1PR08MB51517CBAA8C8EC961A3AD39CB32B0@VE1PR08MB5151.eurprd08.prod.outlook.com>
x-forefront-prvs: 000800954F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39850400004)(376002)(136003)(346002)(366004)(199004)(189003)(446003)(11346002)(486006)(2616005)(14454004)(476003)(6486002)(52116002)(86362001)(4326008)(97736004)(102836004)(8936002)(5660300002)(6506007)(6512007)(386003)(53936002)(76176011)(103116003)(2201001)(1076003)(6436002)(55236004)(26005)(186003)(478600001)(7736002)(110136005)(2906002)(14444005)(256004)(81156014)(105586002)(54906003)(81166006)(99286004)(316002)(3846002)(6116002)(106356001)(305945005)(8676002)(2501003)(66066001)(25786009)(71190400001)(71200400001)(50226002)(68736007)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB5151;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: PXMBNyQd0KSgbSYP5pAJ+KOPujHfAE2/f2Iu4rV27gTjyIvWSYvb7RqdFHQUd7BRyIR6T54pr1O46Q0nYsOz/wnYtX4TJlVecd1RDsf67Y1Wy2oHrTVlQ2WGdbHCNW6k/YRShauIpB+arN/nDFFpOBOZ4SZT6c1Gf+sNjD3vHi0eDG2tOAdg0ecGMv9DgYtZmAmEGaM98ohCatJYlgd5SqFY3ivlFuCTvJpfxl+Y/BKBmYAMcVObi1FxqLMkTKmQOccCTV/RU6ew5GAZm6CDaOwpmq0fh7G1PHsrOPy0K70patyixOJfYmn9dU+fFcC8Z0afvH4/CATkKQHvYe3swZwUv7pYkM62menm4R1ajqfuenqQYuD0O9zJsLt89+vU+5RIUIyS5c7WwgUqmU846IufgGGFbub8o2ZnnXNnjKU=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e57e2ce-723f-45f2-6c1e-08d6c17147de
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2019 07:09:20.3399
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5151
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MS4gQWRkIHNjYWxlciB0byB3cml0ZWJhY2sgcGlwZWxpbmUgdG8gZW5hYmxlIHRoZSB3cml0ZWJh
Y2sgc2NhbGluZyBzdXBwb3J0DQoyLiBEaXNwbGF5IEhXIGNhbiBub3QgZG8gdXBzY2FsaW5nIGZv
ciB3cml0ZWJhY2ssIGNoZWNrIGl0IHdoZW4gdmFsaWRhdGUuDQoNClNpZ25lZC1vZmYtYnk6IEph
bWVzIFFpYW4gV2FuZyAoQXJtIFRlY2hub2xvZ3kgQ2hpbmEpIDxqYW1lcy5xaWFuLndhbmdAYXJt
LmNvbT4NCi0tLQ0KIC4uLi9kcm0vYXJtL2Rpc3BsYXkva29tZWRhL2tvbWVkYV9waXBlbGluZS5o
ICB8ICAyICsrDQogLi4uL2Rpc3BsYXkva29tZWRhL2tvbWVkYV9waXBlbGluZV9zdGF0ZS5jICAg
IHwgMzYgKysrKysrKysrKysrKysrLS0tLQ0KIC4uLi9ncHUvZHJtL2FybS9kaXNwbGF5L2tvbWVk
YS9rb21lZGFfcGxhbmUuYyB8ICA4ICstLS0tDQogLi4uL2FybS9kaXNwbGF5L2tvbWVkYS9rb21l
ZGFfd2JfY29ubmVjdG9yLmMgIHwgIDIgKysNCiA0IGZpbGVzIGNoYW5nZWQsIDM0IGluc2VydGlv
bnMoKyksIDE0IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2Fy
bS9kaXNwbGF5L2tvbWVkYS9rb21lZGFfcGlwZWxpbmUuaCBiL2RyaXZlcnMvZ3B1L2RybS9hcm0v
ZGlzcGxheS9rb21lZGEva29tZWRhX3BpcGVsaW5lLmgNCmluZGV4IDg1ZDdlYzM0MWFjYy4uYmZh
ZDdkMDNmODAxIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FybS9kaXNwbGF5L2tvbWVk
YS9rb21lZGFfcGlwZWxpbmUuaA0KKysrIGIvZHJpdmVycy9ncHUvZHJtL2FybS9kaXNwbGF5L2tv
bWVkYS9rb21lZGFfcGlwZWxpbmUuaA0KQEAgLTQ3MCw0ICs0NzAsNiBAQCB2b2lkIGtvbWVkYV9w
aXBlbGluZV9kaXNhYmxlKHN0cnVjdCBrb21lZGFfcGlwZWxpbmUgKnBpcGUsDQogdm9pZCBrb21l
ZGFfcGlwZWxpbmVfdXBkYXRlKHN0cnVjdCBrb21lZGFfcGlwZWxpbmUgKnBpcGUsDQogCQkJICAg
IHN0cnVjdCBkcm1fYXRvbWljX3N0YXRlICpvbGRfc3RhdGUpOw0KIA0KK3ZvaWQga29tZWRhX2Nv
bXBsZXRlX2RhdGFfZmxvd19jZmcoc3RydWN0IGtvbWVkYV9kYXRhX2Zsb3dfY2ZnICpkZmxvdyk7
DQorDQogI2VuZGlmIC8qIF9LT01FREFfUElQRUxJTkVfSF8qLw0KZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9hcm0vZGlzcGxheS9rb21lZGEva29tZWRhX3BpcGVsaW5lX3N0YXRlLmMgYi9k
cml2ZXJzL2dwdS9kcm0vYXJtL2Rpc3BsYXkva29tZWRhL2tvbWVkYV9waXBlbGluZV9zdGF0ZS5j
DQppbmRleCAxZGVjMzIxYzcyN2IuLmM2ZjE5OTY5ZmMxMCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMv
Z3B1L2RybS9hcm0vZGlzcGxheS9rb21lZGEva29tZWRhX3BpcGVsaW5lX3N0YXRlLmMNCisrKyBi
L2RyaXZlcnMvZ3B1L2RybS9hcm0vZGlzcGxheS9rb21lZGEva29tZWRhX3BpcGVsaW5lX3N0YXRl
LmMNCkBAIC0zODgsNiArMzg4LDcgQEAga29tZWRhX3NjYWxlcl9jaGVja19jZmcoc3RydWN0IGtv
bWVkYV9zY2FsZXIgKnNjYWxlciwNCiAJCQlzdHJ1Y3Qga29tZWRhX2RhdGFfZmxvd19jZmcgKmRm
bG93KQ0KIHsNCiAJdTMyIGhzaXplX2luLCB2c2l6ZV9pbiwgaHNpemVfb3V0LCB2c2l6ZV9vdXQ7
DQorCXUzMiBtYXhfdXBzY2FsaW5nOw0KIA0KIAloc2l6ZV9pbiA9IGRmbG93LT5pbl93Ow0KIAl2
c2l6ZV9pbiA9IGRmbG93LT5pbl9oOw0KQEAgLTQwNiwxMyArNDA3LDIxIEBAIGtvbWVkYV9zY2Fs
ZXJfY2hlY2tfY2ZnKHN0cnVjdCBrb21lZGFfc2NhbGVyICpzY2FsZXIsDQogCQlyZXR1cm4gLUVJ
TlZBTDsNCiAJfQ0KIA0KLQlpZiAoIXNjYWxpbmdfcmF0aW9fdmFsaWQoaHNpemVfaW4sIGhzaXpl
X291dCwgc2NhbGVyLT5tYXhfdXBzY2FsaW5nLA0KKwkvKiBJZiBpbnB1dCBjb21lcyBmcm9tIGNv
bXBpeiB0aGF0IG1lYW5zIHRoZSBzY2FsaW5nIGlzIGZvciB3cml0ZWJhY2sNCisJICogYW5kIHNj
YWxlciBjYW4gbm90IGRvIHVwc2NhbGluZyBmb3Igd3JpdGViYWNrDQorCSAqLw0KKwlpZiAoaGFz
X2JpdChkZmxvdy0+aW5wdXQuY29tcG9uZW50LT5pZCwgS09NRURBX1BJUEVMSU5FX0NPTVBJWlMp
KQ0KKwkJbWF4X3Vwc2NhbGluZyA9IDE7DQorCWVsc2UNCisJCW1heF91cHNjYWxpbmcgPSBzY2Fs
ZXItPm1heF91cHNjYWxpbmc7DQorDQorCWlmICghc2NhbGluZ19yYXRpb192YWxpZChoc2l6ZV9p
biwgaHNpemVfb3V0LCBtYXhfdXBzY2FsaW5nLA0KIAkJCQkgc2NhbGVyLT5tYXhfZG93bnNjYWxp
bmcpKSB7DQogCQlEUk1fREVCVUdfQVRPTUlDKCJJbnZhbGlkIGhvcml6b250YWwgc2NhbGluZyBy
YXRpbyIpOw0KIAkJcmV0dXJuIC1FSU5WQUw7DQogCX0NCiANCi0JaWYgKCFzY2FsaW5nX3JhdGlv
X3ZhbGlkKHZzaXplX2luLCB2c2l6ZV9vdXQsIHNjYWxlci0+bWF4X3Vwc2NhbGluZywNCisJaWYg
KCFzY2FsaW5nX3JhdGlvX3ZhbGlkKHZzaXplX2luLCB2c2l6ZV9vdXQsIG1heF91cHNjYWxpbmcs
DQogCQkJCSBzY2FsZXItPm1heF9kb3duc2NhbGluZykpIHsNCiAJCURSTV9ERUJVR19BVE9NSUMo
IkludmFsaWQgdmVydGljYWwgc2NhbGluZyByYXRpbyIpOw0KIAkJcmV0dXJuIC1FSU5WQUw7DQpA
QCAtNjEyLDYgKzYyMSwxNyBAQCBrb21lZGFfdGltaW5nX2N0cmxyX3ZhbGlkYXRlKHN0cnVjdCBr
b21lZGFfdGltaW5nX2N0cmxyICpjdHJsciwNCiAJcmV0dXJuIDA7DQogfQ0KIA0KK3ZvaWQga29t
ZWRhX2NvbXBsZXRlX2RhdGFfZmxvd19jZmcoc3RydWN0IGtvbWVkYV9kYXRhX2Zsb3dfY2ZnICpk
ZmxvdykNCit7DQorCXUzMiB3ID0gZGZsb3ctPmluX3c7DQorCXUzMiBoID0gZGZsb3ctPmluX2g7
DQorDQorCWlmIChkcm1fcm90YXRpb25fOTBfb3JfMjcwKGRmbG93LT5yb3QpKQ0KKwkJc3dhcCh3
LCBoKTsNCisNCisJZGZsb3ctPm5lZWRzX3NjYWxpbmcgPSAodyAhPSBkZmxvdy0+b3V0X3cpIHx8
IChoICE9IGRmbG93LT5vdXRfaCk7DQorfQ0KKw0KIGludCBrb21lZGFfYnVpbGRfbGF5ZXJfZGF0
YV9mbG93KHN0cnVjdCBrb21lZGFfbGF5ZXIgKmxheWVyLA0KIAkJCQkgc3RydWN0IGtvbWVkYV9w
bGFuZV9zdGF0ZSAqa3BsYW5lX3N0LA0KIAkJCQkgc3RydWN0IGtvbWVkYV9jcnRjX3N0YXRlICpr
Y3J0Y19zdCwNCkBAIC02MzksMTYgKzY1OSwxOCBAQCBpbnQga29tZWRhX2J1aWxkX2xheWVyX2Rh
dGFfZmxvdyhzdHJ1Y3Qga29tZWRhX2xheWVyICpsYXllciwNCiAJcmV0dXJuIGVycjsNCiB9DQog
DQorLyogd3JpdGViYWNrIGRhdGEgcGF0aDogY29tcGl6IC0+IHNjYWxlciAtPiB3Yl9sYXllciAt
PiBtZW1vcnkgKi8NCiBpbnQga29tZWRhX2J1aWxkX3diX2RhdGFfZmxvdyhzdHJ1Y3Qga29tZWRh
X2xheWVyICp3Yl9sYXllciwNCiAJCQkgICAgICBzdHJ1Y3QgZHJtX2Nvbm5lY3Rvcl9zdGF0ZSAq
Y29ubl9zdCwNCiAJCQkgICAgICBzdHJ1Y3Qga29tZWRhX2NydGNfc3RhdGUgKmtjcnRjX3N0LA0K
IAkJCSAgICAgIHN0cnVjdCBrb21lZGFfZGF0YV9mbG93X2NmZyAqZGZsb3cpDQogew0KLQlpZiAo
KGRmbG93LT5pbl93ICE9IGRmbG93LT5vdXRfdykgfHwNCi0JICAgIChkZmxvdy0+aW5faCAhPSBk
Zmxvdy0+b3V0X2gpKSB7DQotCQlEUk1fREVCVUdfQVRPTUlDKCJjdXJyZW50IGRvIG5vdCBzdXBw
b3J0IHNjYWxpbmcgd3JpdGViYWNrLlxuIik7DQotCQlyZXR1cm4gLUVJTlZBTDsNCi0JfQ0KKwlz
dHJ1Y3QgZHJtX2Nvbm5lY3RvciAqY29ubiA9IGNvbm5fc3QtPmNvbm5lY3RvcjsNCisJaW50IGVy
cjsNCisNCisJZXJyID0ga29tZWRhX3NjYWxlcl92YWxpZGF0ZShjb25uLCBrY3J0Y19zdCwgZGZs
b3cpOw0KKwlpZiAoZXJyKQ0KKwkJcmV0dXJuIGVycjsNCiANCiAJcmV0dXJuIGtvbWVkYV93Yl9s
YXllcl92YWxpZGF0ZSh3Yl9sYXllciwgY29ubl9zdCwgZGZsb3cpOw0KIH0NCmRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vYXJtL2Rpc3BsYXkva29tZWRhL2tvbWVkYV9wbGFuZS5jIGIvZHJp
dmVycy9ncHUvZHJtL2FybS9kaXNwbGF5L2tvbWVkYS9rb21lZGFfcGxhbmUuYw0KaW5kZXggMzhj
OTRlOGYwY2UyLi41ZGU0NjIxNzIxNTEgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYXJt
L2Rpc3BsYXkva29tZWRhL2tvbWVkYV9wbGFuZS5jDQorKysgYi9kcml2ZXJzL2dwdS9kcm0vYXJt
L2Rpc3BsYXkva29tZWRhL2tvbWVkYV9wbGFuZS5jDQpAQCAtMTUsNyArMTUsNiBAQCBrb21lZGFf
cGxhbmVfaW5pdF9kYXRhX2Zsb3coc3RydWN0IGRybV9wbGFuZV9zdGF0ZSAqc3QsDQogCQkJICAg
IHN0cnVjdCBrb21lZGFfZGF0YV9mbG93X2NmZyAqZGZsb3cpDQogew0KIAlzdHJ1Y3QgZHJtX2Zy
YW1lYnVmZmVyICpmYiA9IHN0LT5mYjsNCi0JdTMyIHcsIGg7DQogDQogCW1lbXNldChkZmxvdywg
MCwgc2l6ZW9mKCpkZmxvdykpOw0KIA0KQEAgLTM2LDEyICszNSw3IEBAIGtvbWVkYV9wbGFuZV9p
bml0X2RhdGFfZmxvdyhzdHJ1Y3QgZHJtX3BsYW5lX3N0YXRlICpzdCwNCiAJZGZsb3ctPmluX3cg
PSBzdC0+c3JjX3cgPj4gMTY7DQogCWRmbG93LT5pbl9oID0gc3QtPnNyY19oID4+IDE2Ow0KIA0K
LQl3ID0gZGZsb3ctPmluX3c7DQotCWggPSBkZmxvdy0+aW5faDsNCi0JaWYgKGRybV9yb3RhdGlv
bl85MF9vcl8yNzAoZGZsb3ctPnJvdCkpDQotCQlzd2FwKHcsIGgpOw0KLQ0KLQlkZmxvdy0+bmVl
ZHNfc2NhbGluZyA9ICh3ICE9IGRmbG93LT5vdXRfdykgfHwgKGggIT0gZGZsb3ctPm91dF9oKTsN
CisJa29tZWRhX2NvbXBsZXRlX2RhdGFfZmxvd19jZmcoZGZsb3cpOw0KIA0KIAlyZXR1cm4gMDsN
CiB9DQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FybS9kaXNwbGF5L2tvbWVkYS9rb21l
ZGFfd2JfY29ubmVjdG9yLmMgYi9kcml2ZXJzL2dwdS9kcm0vYXJtL2Rpc3BsYXkva29tZWRhL2tv
bWVkYV93Yl9jb25uZWN0b3IuYw0KaW5kZXggMGMxYTQyMjBjMjgwLi5lZWQ1MjEyMThlZjMgMTAw
NjQ0DQotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYXJtL2Rpc3BsYXkva29tZWRhL2tvbWVkYV93Yl9j
b25uZWN0b3IuYw0KKysrIGIvZHJpdmVycy9ncHUvZHJtL2FybS9kaXNwbGF5L2tvbWVkYS9rb21l
ZGFfd2JfY29ubmVjdG9yLmMNCkBAIC0zMSw2ICszMSw4IEBAIGtvbWVkYV93Yl9pbml0X2RhdGFf
ZmxvdyhzdHJ1Y3Qga29tZWRhX2xheWVyICp3Yl9sYXllciwNCiAJZGZsb3ctPnBpeGVsX2JsZW5k
X21vZGUgPSBEUk1fTU9ERV9CTEVORF9QSVhFTF9OT05FOw0KIAlkZmxvdy0+cm90ID0gRFJNX01P
REVfUk9UQVRFXzA7DQogDQorCWtvbWVkYV9jb21wbGV0ZV9kYXRhX2Zsb3dfY2ZnKGRmbG93KTsN
CisNCiAJcmV0dXJuIDA7DQogfQ0KIA0KLS0gDQoyLjE3LjENCg0K
