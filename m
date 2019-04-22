Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E163BC10F14
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 03:16:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A65920859
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 03:16:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="EmKO3F8K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbfDVDQa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Apr 2019 23:16:30 -0400
Received: from mail-eopbgr30053.outbound.protection.outlook.com ([40.107.3.53]:29550
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726108AbfDVDQ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Apr 2019 23:16:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ey22I86sPmrgn8KV0BgV5XuvXKpTPsecI/l18vprVBE=;
 b=EmKO3F8K6sLYYpgGyxs3p7gThLHNn7pKe4TXKRav9sMTiPQ91ibe6sDioq3fG+hMpMkeJzoA8EyVMjXAwr7UIby6mTa7a6l+4En7t49LRn3Mp4ceeUBKg46NLBdgvUtHB1PMj1ne8XBVxSNpCHuz1FX+es/Svnl4Mi33XHv9YKo=
Received: from DB7PR08MB3530.eurprd08.prod.outlook.com (20.177.120.80) by
 DB7PR08MB3081.eurprd08.prod.outlook.com (52.134.110.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.14; Mon, 22 Apr 2019 03:16:26 +0000
Received: from DB7PR08MB3530.eurprd08.prod.outlook.com
 ([fe80::899e:4160:166b:923a]) by DB7PR08MB3530.eurprd08.prod.outlook.com
 ([fe80::899e:4160:166b:923a%3]) with mapi id 15.20.1813.017; Mon, 22 Apr 2019
 03:16:26 +0000
From:   "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>
To:     Liviu Dudau <Liviu.Dudau@arm.com>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "seanpaul@chromium.org" <seanpaul@chromium.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>
CC:     "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nd <nd@arm.com>
Subject: [PATCH v1 1/2] drm/komeda: Add rotation support on Komeda driver
Thread-Topic: [PATCH v1 1/2] drm/komeda: Add rotation support on Komeda driver
Thread-Index: AQHU+LnF01A1o5O/qEOerVAXVeralQ==
Date:   Mon, 22 Apr 2019 03:16:26 +0000
Message-ID: <1555902945-2877-2-git-send-email-lowry.li@arm.com>
References: <1555902945-2877-1-git-send-email-lowry.li@arm.com>
In-Reply-To: <1555902945-2877-1-git-send-email-lowry.li@arm.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK2PR06CA0008.apcprd06.prod.outlook.com
 (2603:1096:202:2e::20) To DB7PR08MB3530.eurprd08.prod.outlook.com
 (2603:10a6:10:49::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Lowry.Li@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.9.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5d79f6fd-5b7a-47d0-51b2-08d6c6d0e74a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB7PR08MB3081;
x-ms-traffictypediagnostic: DB7PR08MB3081:
nodisclaimer: True
x-microsoft-antispam-prvs: <DB7PR08MB30813BF1881EA07491220DDE9F220@DB7PR08MB3081.eurprd08.prod.outlook.com>
x-forefront-prvs: 00159D1518
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(396003)(39850400004)(376002)(346002)(189003)(199004)(102836004)(386003)(86362001)(72206003)(6506007)(55236004)(316002)(66946007)(54906003)(305945005)(14454004)(26005)(25786009)(186003)(73956011)(81156014)(81166006)(66476007)(110136005)(6636002)(53936002)(76176011)(6512007)(478600001)(50226002)(7736002)(2201001)(66066001)(97736004)(68736007)(256004)(446003)(14444005)(99286004)(4326008)(11346002)(476003)(2616005)(486006)(2906002)(6116002)(8676002)(36756003)(5660300002)(52116002)(3846002)(71190400001)(64756008)(66556008)(8936002)(2501003)(71200400001)(6486002)(6436002)(66446008);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR08MB3081;H:DB7PR08MB3530.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: cgfNuSTFxcDz7b3eAUY7KEVccwUOSdNALzAjf70SRbrKlHjpEmDsBWq37BR0wBLCExa5oT7wYvA4Bat06wup0g6S8XnOuYLhS+CmF97i3wi0XfQTTgpx/VjB+UXLsNV0WOA75C+BGu51xgpPRFusQ9kT5JK/l7lgytcNCAo/xoOSjHpasJjpJFar1Hq8eLb5y3pQ8arD+kdV/VHGikDYhewr6YiBU91MNJL0M7vm4uDcUVhQgh/dm9JvQRI0e1CxVwQ/wtG0yNJW23ewNwpdx5mCrxnZcoRg25RlsCGMrdLrsBhr+xDhs/5HXmUxA/zxaz08y7pOyM9Fbmz5pQNYAICm+S/a3LpyZzS+hBH5BWv+nrxkHXKuplsD9Dc1DqYVO6QUnKfiOcnfZKEy7+fikY1ya+Cr3Y+MdHZnFyZIjvA=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d79f6fd-5b7a-47d0-51b2-08d6c6d0e74a
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2019 03:16:26.1582
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3081
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LSBBZGRzIHJvdGF0aW9uIHByb3BlcnR5IHRvIHBsYW5lLg0KLSBLb21lZGEgZGlzcGxheSByb3Rh
dGlvbiBzdXBwb3J0IGRpdmVyZ2VzIGZyb20gdGhlIHNwZWNpZmljIGZvcm1hdHMsDQpzbyBuZWVk
IHRvIGNoZWNrIHRoZSB1c2VyIHJlcXVpcmVkIHJvdGF0aW9uIHR5cGUgd2l0aCB0aGUgZm9ybWF0
IGNhcHMNCmFuZCByZWplY3QgdGhlIGNvbW1pdCBpZiBpdCBjYW4gbm90IGJlIHN1cHBvcnRlZC4N
Ci0gSW4gdGhlIGxheWVyIHZhbGlkYXRlIGZsb3csIHNldHMgdGhlIHJvdGF0aW9uIHZhbHVlIHRv
IHRoZSBsYXllcg0Kc3RhdGUuIElmIHI5MCBvciByMjcwLCBzd2FwIHRoZSB3aWR0aCBhbmQgaGVp
Z2h0IG9mIHRoZSBkYXRhIGZsb3cNCmZvciBuZXh0IHN0YWdlLg0KDQpTaWduZWQtb2ZmLWJ5OiBM
b3dyeSBMaSAoQXJtIFRlY2hub2xvZ3kgQ2hpbmEpIDxsb3dyeS5saUBhcm0uY29tPg0KLS0tDQog
ZHJpdmVycy9ncHUvZHJtL2FybS9kaXNwbGF5L2tvbWVkYS9rb21lZGFfZm9ybWF0X2NhcHMuaCAg
fCAxMSArKysrKysrKysrKw0KIC4uLi9ncHUvZHJtL2FybS9kaXNwbGF5L2tvbWVkYS9rb21lZGFf
cGlwZWxpbmVfc3RhdGUuYyAgIHwgIDcgKysrKysrKw0KIGRyaXZlcnMvZ3B1L2RybS9hcm0vZGlz
cGxheS9rb21lZGEva29tZWRhX3BsYW5lLmMgICAgICAgIHwgMTYgKysrKysrKysrKysrKysrKw0K
IDMgZmlsZXMgY2hhbmdlZCwgMzQgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2FybS9kaXNwbGF5L2tvbWVkYS9rb21lZGFfZm9ybWF0X2NhcHMuaCBiL2RyaXZl
cnMvZ3B1L2RybS9hcm0vZGlzcGxheS9rb21lZGEva29tZWRhX2Zvcm1hdF9jYXBzLmgNCmluZGV4
IGJjM2IyZGYzNi4uOTZkZTIyZSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hcm0vZGlz
cGxheS9rb21lZGEva29tZWRhX2Zvcm1hdF9jYXBzLmgNCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9h
cm0vZGlzcGxheS9rb21lZGEva29tZWRhX2Zvcm1hdF9jYXBzLmgNCkBAIC03OSw2ICs3OSwxNyBA
QCBzdHJ1Y3Qga29tZWRhX2Zvcm1hdF9jYXBzX3RhYmxlIHsNCiANCiBleHRlcm4gdTY0IGtvbWVk
YV9zdXBwb3J0ZWRfbW9kaWZpZXJzW107DQogDQorc3RhdGljIGlubGluZSBjb25zdCBjaGFyICpr
b21lZGFfZ2V0X2Zvcm1hdF9uYW1lKHUzMiBmb3VyY2MsIHU2NCBtb2RpZmllcikNCit7DQorCXN0
cnVjdCBkcm1fZm9ybWF0X25hbWVfYnVmIGJ1ZjsNCisJc3RhdGljIGNoYXIgbmFtZVs2NF07DQor
DQorCXNucHJpbnRmKG5hbWUsIHNpemVvZihuYW1lKSwgIiVzIHdpdGggbW9kaWZpZXI6IDB4JWxs
eC4iLA0KKwkJIGRybV9nZXRfZm9ybWF0X25hbWUoZm91cmNjLCAmYnVmKSwgbW9kaWZpZXIpOw0K
Kw0KKwlyZXR1cm4gbmFtZTsNCit9DQorDQogY29uc3Qgc3RydWN0IGtvbWVkYV9mb3JtYXRfY2Fw
cyAqDQoga29tZWRhX2dldF9mb3JtYXRfY2FwcyhzdHJ1Y3Qga29tZWRhX2Zvcm1hdF9jYXBzX3Rh
YmxlICp0YWJsZSwNCiAJCSAgICAgICB1MzIgZm91cmNjLCB1NjQgbW9kaWZpZXIpOw0KZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hcm0vZGlzcGxheS9rb21lZGEva29tZWRhX3BpcGVsaW5l
X3N0YXRlLmMgYi9kcml2ZXJzL2dwdS9kcm0vYXJtL2Rpc3BsYXkva29tZWRhL2tvbWVkYV9waXBl
bGluZV9zdGF0ZS5jDQppbmRleCA5YjI5ZTlhLi44YzEzM2U0IDEwMDY0NA0KLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL2FybS9kaXNwbGF5L2tvbWVkYS9rb21lZGFfcGlwZWxpbmVfc3RhdGUuYw0KKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FybS9kaXNwbGF5L2tvbWVkYS9rb21lZGFfcGlwZWxpbmVfc3Rh
dGUuYw0KQEAgLTMxNyw2ICszMTcsMTMgQEAgc3RydWN0IGtvbWVkYV9waXBlbGluZV9zdGF0ZSAq
DQogCS8qIHVwZGF0ZSB0aGUgZGF0YSBmbG93IGZvciB0aGUgbmV4dCBzdGFnZSAqLw0KIAlrb21l
ZGFfY29tcG9uZW50X3NldF9vdXRwdXQoJmRmbG93LT5pbnB1dCwgJmxheWVyLT5iYXNlLCAwKTsN
CiANCisJLyoNCisJICogVGhlIHJvdGF0aW9uIGhhcyBiZWVuIGhhbmRsZWQgYnkgbGF5ZXIsIHNv
IGFkanVzdGVkIHRoZSBkYXRhIGZsb3cgZm9yDQorCSAqIHRoZSBuZXh0IHN0YWdlLg0KKwkgKi8N
CisJaWYgKGRybV9yb3RhdGlvbl85MF9vcl8yNzAoc3QtPnJvdCkpDQorCQlzd2FwKGRmbG93LT5p
bl9oLCBkZmxvdy0+aW5fdyk7DQorDQogCXJldHVybiAwOw0KIH0NCiANCmRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vYXJtL2Rpc3BsYXkva29tZWRhL2tvbWVkYV9wbGFuZS5jIGIvZHJpdmVy
cy9ncHUvZHJtL2FybS9kaXNwbGF5L2tvbWVkYS9rb21lZGFfcGxhbmUuYw0KaW5kZXggMTRkNjg2
MS4uNWU1YmZkYiAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hcm0vZGlzcGxheS9rb21l
ZGEva29tZWRhX3BsYW5lLmMNCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hcm0vZGlzcGxheS9rb21l
ZGEva29tZWRhX3BsYW5lLmMNCkBAIC05LDEyICs5LDE0IEBADQogI2luY2x1ZGUgPGRybS9kcm1f
cGxhbmVfaGVscGVyLmg+DQogI2luY2x1ZGUgImtvbWVkYV9kZXYuaCINCiAjaW5jbHVkZSAia29t
ZWRhX2ttcy5oIg0KKyNpbmNsdWRlICJrb21lZGFfZnJhbWVidWZmZXIuaCINCiANCiBzdGF0aWMg
aW50DQoga29tZWRhX3BsYW5lX2luaXRfZGF0YV9mbG93KHN0cnVjdCBkcm1fcGxhbmVfc3RhdGUg
KnN0LA0KIAkJCSAgICBzdHJ1Y3Qga29tZWRhX2RhdGFfZmxvd19jZmcgKmRmbG93KQ0KIHsNCiAJ
c3RydWN0IGRybV9mcmFtZWJ1ZmZlciAqZmIgPSBzdC0+ZmI7DQorCWNvbnN0IHN0cnVjdCBrb21l
ZGFfZm9ybWF0X2NhcHMgKmNhcHMgPSB0b19rZmIoZmIpLT5mb3JtYXRfY2FwczsNCiANCiAJbWVt
c2V0KGRmbG93LCAwLCBzaXplb2YoKmRmbG93KSk7DQogDQpAQCAtMzUsNiArMzcsMTUgQEANCiAJ
ZGZsb3ctPmluX3cgPSBzdC0+c3JjX3cgPj4gMTY7DQogCWRmbG93LT5pbl9oID0gc3QtPnNyY19o
ID4+IDE2Ow0KIA0KKwlkZmxvdy0+cm90ID0gZHJtX3JvdGF0aW9uX3NpbXBsaWZ5KHN0LT5yb3Rh
dGlvbiwgY2Fwcy0+c3VwcG9ydGVkX3JvdHMpOw0KKwlpZiAoIWhhc19iaXRzKGRmbG93LT5yb3Qs
IGNhcHMtPnN1cHBvcnRlZF9yb3RzKSkgew0KKwkJRFJNX0RFQlVHX0FUT01JQygicm90YXRpb24o
MHgleCkgaXNuJ3Qgc3VwcG9ydGVkIGJ5ICVzLlxuIiwNCisJCQkJIGRmbG93LT5yb3QsDQorCQkJ
CSBrb21lZGFfZ2V0X2Zvcm1hdF9uYW1lKGNhcHMtPmZvdXJjYywNCisJCQkJCQkJZmItPm1vZGlm
aWVyKSk7DQorCQlyZXR1cm4gLUVJTlZBTDsNCisJfQ0KKw0KIAlyZXR1cm4gMDsNCiB9DQogDQpA
QCAtMjMzLDYgKzI0NCwxMSBAQCBzdGF0aWMgaW50IGtvbWVkYV9wbGFuZV9hZGQoc3RydWN0IGtv
bWVkYV9rbXNfZGV2ICprbXMsDQogDQogCWRybV9wbGFuZV9oZWxwZXJfYWRkKHBsYW5lLCAma29t
ZWRhX3BsYW5lX2hlbHBlcl9mdW5jcyk7DQogDQorCWVyciA9IGRybV9wbGFuZV9jcmVhdGVfcm90
YXRpb25fcHJvcGVydHkocGxhbmUsIERSTV9NT0RFX1JPVEFURV8wLA0KKwkJCQkJCSBsYXllci0+
c3VwcG9ydGVkX3JvdHMpOw0KKwlpZiAoZXJyKQ0KKwkJZ290byBjbGVhbnVwOw0KKw0KIAllcnIg
PSBkcm1fcGxhbmVfY3JlYXRlX2FscGhhX3Byb3BlcnR5KHBsYW5lKTsNCiAJaWYgKGVycikNCiAJ
CWdvdG8gY2xlYW51cDsNCi0tIA0KMS45LjENCg0K
