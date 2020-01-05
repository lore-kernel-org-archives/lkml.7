Return-Path: <SRS0=Io4T=22=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73E13C33C8C
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 10:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DF77218AC
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 10:47:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="YcQG7EOT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbgAEKrM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jan 2020 05:47:12 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:31535 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727025AbgAEKrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 05:47:10 -0500
X-UUID: f748233c7a874cdab3b660c009496d3f-20200105
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=WYOd08EzerHDPlgL6xUYgzCvGPNKGXb02WcxQ9aFfTw=;
        b=YcQG7EOTJI2Vnup12mMh54AkruGQ9RbkAHJbrRZNI7DDkU981SliFuD5frpjy73K0o+oe0DEgfqAstmPcfzFZUEXHQDr5ku0AehgZYE6UJTsxkq73XnKsAE2WbZZ2ct3GomK+VM3XYVLVyX3Zhc+HUy0sVtlskFIfdyXQhI8OUc=;
X-UUID: f748233c7a874cdab3b660c009496d3f-20200105
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <chao.hao@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 156884624; Sun, 05 Jan 2020 18:47:05 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sun, 5 Jan 2020 18:46:39 +0800
Received: from localhost.localdomain (10.15.20.246) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sun, 5 Jan 2020 18:45:35 +0800
From:   Chao Hao <chao.hao@mediatek.com>
To:     Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <iommu@lists.linux-foundation.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        Chao Hao <chao.hao@mediatek.com>,
        Jun Yan <jun.yan@mediatek.com>,
        Cui Zhang <zhang.cui@mediatek.com>,
        Yong Wu <yong.wu@mediatek.com>,
        Anan Sun <anan.sun@mediatek.com>
Subject: [PATCH v2 12/19] iommu/mediatek: Change get the way of m4u_group
Date:   Sun, 5 Jan 2020 18:45:16 +0800
Message-ID: <20200105104523.31006-13-chao.hao@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200105104523.31006-1-chao.hao@mediatek.com>
References: <20200105104523.31006-1-chao.hao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MS4gUmVkZWZpbmUgbXRrX2lvbW11X2RvbWFpbiBzdHJ1Y3R1cmUsIGl0IHdpbGwgaW5jbHVkZSBp
b21tdV9ncm91cA0KYW5kIGlvbW11X2RvbWFpbi4gRGlmZmVyZW50IG10a19pb21tdV9kb21haW5z
IGNhbiBiZSBkaXN0aW5ndWlzaGVkIGJ5DQpJRC4gV2hlbiB3ZSByZWFsaXplIG11bHRpcGxlIG10
a19pb21tdV9kb21haW5zLCBldmVyeSBtdGtfaW9tbXVfZG9tYWluDQpjYW4gZGVzY3JpYmUgb25l
IGlvdmEgcmVnaW9uLg0KMi4gSW4gdGhlb3J5LCBldmVyeSBkZXZpY2UgaGFzIG9uZSBpb21tdV9n
cm91cCwgc28gdGhpcyBwYXRjaCB3aWxsDQpnZXQgaW9tbXVfZ3JvdXAgYnkgY2hlY2tpbmcgZGV2
aWNlLiBBbGwgdGhlIGRldmljZXMgYmVsb25nIHRvIHRoZSBzYW1lDQptNHVfZ3JvdXAgY3VycmVu
dGx5LCBzbyB0aGV5IGFsc28gdXNlIHRoZSBzYW1lIG10a19pb21tdV9kb21haW4oaWQ9MCkuDQoN
ClNpZ25lZC1vZmYtYnk6IENoYW8gSGFvIDxjaGFvLmhhb0BtZWRpYXRlay5jb20+DQotLS0NCiBk
cml2ZXJzL2lvbW11L210a19pb21tdS5jIHwgNDYgKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrDQogMSBmaWxlIGNoYW5nZWQsIDQ2IGluc2VydGlvbnMoKykNCg0KZGlmZiAt
LWdpdCBhL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMgYi9kcml2ZXJzL2lvbW11L210a19pb21t
dS5jDQppbmRleCBiMzRiZDNhYmNjZjguLmJmNzgxZjRkNzM2NCAxMDA2NDQNCi0tLSBhL2RyaXZl
cnMvaW9tbXUvbXRrX2lvbW11LmMNCisrKyBiL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMNCkBA
IC0xMTEsMTIgKzExMSwxNiBAQA0KICNkZWZpbmUgTVRLX000VV9UT19QT1JUKGlkKQkJKChpZCkg
JiAweDFmKQ0KIA0KIHN0cnVjdCBtdGtfaW9tbXVfZG9tYWluIHsNCisJdTMyCQkJCWlkOw0KIAlz
dHJ1Y3QgaW9tbXVfZG9tYWluCQlkb21haW47DQorCXN0cnVjdCBpb21tdV9ncm91cAkJKmdyb3Vw
Ow0KKwlzdHJ1Y3QgbGlzdF9oZWFkCQlsaXN0Ow0KIH07DQogDQogc3RydWN0IG10a19pb21tdV9w
Z3RhYmxlIHsNCiAJc3RydWN0IGlvX3BndGFibGVfY2ZnCWNmZzsNCiAJc3RydWN0IGlvX3BndGFi
bGVfb3BzCSppb3A7DQorCXN0cnVjdCBsaXN0X2hlYWQJbTR1X2RvbV92MjsNCiB9Ow0KIA0KIHN0
YXRpYyBzdHJ1Y3QgbXRrX2lvbW11X3BndGFibGUgKnNoYXJlX3BndGFibGU7DQpAQCAtMTY3LDYg
KzE3MSw0MSBAQCBzdGF0aWMgc3RydWN0IG10a19pb21tdV9kYXRhICptdGtfaW9tbXVfZ2V0X200
dV9kYXRhKHZvaWQpDQogCXJldHVybiBOVUxMOw0KIH0NCiANCitzdGF0aWMgdTMyIGdldF9kb21h
aW5faWQodm9pZCkNCit7DQorCS8qIG9ubHkgc3VwcG9ydCBvbmUgbXRrX2lvbW11X2RvbWFpbiBj
dXJyZW50bHkgKi8NCisJcmV0dXJuIDA7DQorfQ0KKw0KK3N0YXRpYyB1MzIgbXRrX2lvbW11X2dl
dF9kb21haW5faWQodm9pZCkNCit7DQorCXJldHVybiBnZXRfZG9tYWluX2lkKCk7DQorfQ0KKw0K
K3N0YXRpYyBzdHJ1Y3QgbXRrX2lvbW11X2RvbWFpbiAqZ2V0X210a19kb21haW4oc3RydWN0IGRl
dmljZSAqZGV2KQ0KK3sNCisJc3RydWN0IG10a19pb21tdV9kYXRhICpkYXRhID0gZGV2LT5pb21t
dV9md3NwZWMtPmlvbW11X3ByaXY7DQorCXN0cnVjdCBtdGtfaW9tbXVfZG9tYWluICpkb207DQor
CXUzMiBkb21haW5faWQgPSBtdGtfaW9tbXVfZ2V0X2RvbWFpbl9pZCgpOw0KKw0KKwlsaXN0X2Zv
cl9lYWNoX2VudHJ5KGRvbSwgJmRhdGEtPnBndGFibGUtPm00dV9kb21fdjIsIGxpc3QpIHsNCisJ
CWlmIChkb20tPmlkID09IGRvbWFpbl9pZCkNCisJCQlyZXR1cm4gZG9tOw0KKwl9DQorCXJldHVy
biBOVUxMOw0KK30NCisNCitzdGF0aWMgc3RydWN0IGlvbW11X2dyb3VwICptdGtfaW9tbXVfZ2V0
X2dyb3VwKHN0cnVjdCBkZXZpY2UgKmRldikNCit7DQorCXN0cnVjdCBtdGtfaW9tbXVfZG9tYWlu
ICpkb207DQorDQorCWRvbSA9IGdldF9tdGtfZG9tYWluKGRldik7DQorCWlmIChkb20pDQorCQly
ZXR1cm4gZG9tLT5ncm91cDsNCisNCisJcmV0dXJuIE5VTEw7DQorfQ0KKw0KIHN0YXRpYyBzdHJ1
Y3QgbXRrX2lvbW11X3BndGFibGUgKm10a19pb21tdV9nZXRfcGd0YWJsZSh2b2lkKQ0KIHsNCiAJ
cmV0dXJuIHNoYXJlX3BndGFibGU7DQpAQCAtMzI4LDYgKzM2Nyw4IEBAIHN0YXRpYyBzdHJ1Y3Qg
bXRrX2lvbW11X3BndGFibGUgKmNyZWF0ZV9wZ3RhYmxlKHN0cnVjdCBtdGtfaW9tbXVfZGF0YSAq
ZGF0YSkNCiAJaWYgKCFwZ3RhYmxlKQ0KIAkJcmV0dXJuIEVSUl9QVFIoLUVOT01FTSk7DQogDQor
CUlOSVRfTElTVF9IRUFEKCZwZ3RhYmxlLT5tNHVfZG9tX3YyKTsNCisNCiAJcGd0YWJsZS0+Y2Zn
ID0gKHN0cnVjdCBpb19wZ3RhYmxlX2NmZykgew0KIAkJLnF1aXJrcyA9IElPX1BHVEFCTEVfUVVJ
UktfQVJNX05TIHwNCiAJCQlJT19QR1RBQkxFX1FVSVJLX05PX1BFUk1TIHwNCkBAIC0zODIsNiAr
NDIzLDcgQEAgc3RhdGljIGludCBtdGtfaW9tbXVfYXR0YWNoX3BndGFibGUoc3RydWN0IG10a19p
b21tdV9kYXRhICpkYXRhLA0KIHN0YXRpYyBzdHJ1Y3QgaW9tbXVfZG9tYWluICptdGtfaW9tbXVf
ZG9tYWluX2FsbG9jKHVuc2lnbmVkIHR5cGUpDQogew0KIAlzdHJ1Y3QgbXRrX2lvbW11X3BndGFi
bGUgKnBndGFibGUgPSBtdGtfaW9tbXVfZ2V0X3BndGFibGUoKTsNCisJc3RydWN0IG10a19pb21t
dV9kYXRhICpkYXRhID0gbXRrX2lvbW11X2dldF9tNHVfZGF0YSgpOw0KIAlzdHJ1Y3QgbXRrX2lv
bW11X2RvbWFpbiAqZG9tOw0KIA0KIAlpZiAodHlwZSAhPSBJT01NVV9ET01BSU5fRE1BKQ0KQEAg
LTM5OSwxMiArNDQxLDE1IEBAIHN0YXRpYyBzdHJ1Y3QgaW9tbXVfZG9tYWluICptdGtfaW9tbXVf
ZG9tYWluX2FsbG9jKHVuc2lnbmVkIHR5cGUpDQogCWlmIChpb21tdV9nZXRfZG1hX2Nvb2tpZSgm
ZG9tLT5kb21haW4pKQ0KIAkJZ290byAgZnJlZV9kb207DQogDQorCWRvbS0+Z3JvdXAgPSBkYXRh
LT5tNHVfZ3JvdXA7DQorCWRvbS0+aWQgPSBtdGtfaW9tbXVfZ2V0X2RvbWFpbl9pZCgpOw0KIAkv
KiBVcGRhdGUgb3VyIHN1cHBvcnQgcGFnZSBzaXplcyBiaXRtYXAgKi8NCiAJZG9tLT5kb21haW4u
cGdzaXplX2JpdG1hcCA9IHBndGFibGUtPmNmZy5wZ3NpemVfYml0bWFwOw0KIA0KIAlkb20tPmRv
bWFpbi5nZW9tZXRyeS5hcGVydHVyZV9zdGFydCA9IDA7DQogCWRvbS0+ZG9tYWluLmdlb21ldHJ5
LmFwZXJ0dXJlX2VuZCA9IERNQV9CSVRfTUFTSygzMik7DQogCWRvbS0+ZG9tYWluLmdlb21ldHJ5
LmZvcmNlX2FwZXJ0dXJlID0gdHJ1ZTsNCisJbGlzdF9hZGRfdGFpbCgmZG9tLT5saXN0LCAmcGd0
YWJsZS0+bTR1X2RvbV92Mik7DQogDQogCXJldHVybiAmZG9tLT5kb21haW47DQogDQpAQCAtNTYw
LDYgKzYwNSw3IEBAIHN0YXRpYyBzdHJ1Y3QgaW9tbXVfZ3JvdXAgKm10a19pb21tdV9kZXZpY2Vf
Z3JvdXAoc3RydWN0IGRldmljZSAqZGV2KQ0KIAl9DQogDQogCS8qIEFsbCB0aGUgY2xpZW50IGRl
dmljZXMgYXJlIGluIHRoZSBzYW1lIG00dSBpb21tdS1ncm91cCAqLw0KKwlkYXRhLT5tNHVfZ3Jv
dXAgPSBtdGtfaW9tbXVfZ2V0X2dyb3VwKGRldik7DQogCWlmICghZGF0YS0+bTR1X2dyb3VwKSB7
DQogCQlkYXRhLT5tNHVfZ3JvdXAgPSBpb21tdV9ncm91cF9hbGxvYygpOw0KIAkJaWYgKElTX0VS
UihkYXRhLT5tNHVfZ3JvdXApKQ0KLS0gDQoyLjE4LjANCg==

