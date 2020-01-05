Return-Path: <SRS0=Io4T=22=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76EBAC33C8C
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 10:47:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 448B021775
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 10:47:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Hmv/NN7D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbgAEKrK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jan 2020 05:47:10 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:32062 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726702AbgAEKrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 05:47:06 -0500
X-UUID: 07f00fd078c34ac68ce2c55ac1e2529d-20200105
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=TnjVeJwcbvQSB0jZ1PBholvwkjk3w09NdGN4BC3AJAw=;
        b=Hmv/NN7D8PjriN6jrcKvYf4YXOEUgjQVL0MWl4qoKl6IbktWbKdTKkGtm+DI2TVBy6oCfTHnqCYJVzKEiM38srAddUQjSCWcRJvpUYea7RN/GDC4xvQeM4Gbf9LBmkZ5IHhbKor92s0ExxtCoKKaA11diISLH4djY4rKl3tvfl8=;
X-UUID: 07f00fd078c34ac68ce2c55ac1e2529d-20200105
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <chao.hao@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1400420485; Sun, 05 Jan 2020 18:47:00 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sun, 5 Jan 2020 18:46:35 +0800
Received: from localhost.localdomain (10.15.20.246) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sun, 5 Jan 2020 18:45:30 +0800
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
Subject: [PATCH v2 10/19] iommu/mediatek: Remove mtk_iommu_domain_finalise
Date:   Sun, 5 Jan 2020 18:45:14 +0800
Message-ID: <20200105104523.31006-11-chao.hao@mediatek.com>
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

V2UgYWxyZWFkeSBoYXZlIGdsb2JhbCBtdGtfaW9tbXVfcGd0YWJsZSBzdHJ1Y3R1cmUgdG8gZGVz
Y3JpYmUNCnBhZ2UgdGFibGUgYW5kIGNyZWF0ZSBpdCBpbiBncm91cF9kZXZpY2UsICJtdGtfaW9t
bXVfZG9tYWluX2ZpbmFsaXNlIg0KaXMgYXMgdGhlIHNhbWUgYXMgdGhhdCwgc28gc28gd2Ugd2ls
bCByZW1vdmUgbXRrX2lvbW11X2RvbWFpbl9maW5hbGlzZS4NCg0KU2lnbmVkLW9mZi1ieTogQ2hh
byBIYW8gPGNoYW8uaGFvQG1lZGlhdGVrLmNvbT4NCi0tLQ0KIGRyaXZlcnMvaW9tbXUvbXRrX2lv
bW11LmMgfCA0OCArKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCiAxIGZp
bGUgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgMzggZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1n
aXQgYS9kcml2ZXJzL2lvbW11L210a19pb21tdS5jIGIvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUu
Yw0KaW5kZXggNTBjNmEwMWViNTE3Li5jZmVmZGQ2MzhmMWEgMTAwNjQ0DQotLS0gYS9kcml2ZXJz
L2lvbW11L210a19pb21tdS5jDQorKysgYi9kcml2ZXJzL2lvbW11L210a19pb21tdS5jDQpAQCAt
MzIzLDQwICszMjMsNiBAQCBzdGF0aWMgdm9pZCBtdGtfaW9tbXVfY29uZmlnKHN0cnVjdCBtdGtf
aW9tbXVfZGF0YSAqZGF0YSwNCiAJfQ0KIH0NCiANCi1zdGF0aWMgaW50IG10a19pb21tdV9kb21h
aW5fZmluYWxpc2Uoc3RydWN0IG10a19pb21tdV9kb21haW4gKmRvbSkNCi17DQotCXN0cnVjdCBt
dGtfaW9tbXVfZGF0YSAqZGF0YSA9IG10a19pb21tdV9nZXRfbTR1X2RhdGEoKTsNCi0NCi0JaWYg
KGRhdGEtPnBndGFibGUpIHsNCi0JCWRvbS0+Y2ZnID0gZGF0YS0+cGd0YWJsZS0+Y2ZnOw0KLQkJ
ZG9tLT5pb3AgPSBkYXRhLT5wZ3RhYmxlLT5pb3A7DQotCQlkb20tPmRvbWFpbi5wZ3NpemVfYml0
bWFwID0gZGF0YS0+cGd0YWJsZS0+Y2ZnLnBnc2l6ZV9iaXRtYXA7DQotCQlyZXR1cm4gMDsNCi0J
fQ0KLQ0KLQlkb20tPmNmZyA9IChzdHJ1Y3QgaW9fcGd0YWJsZV9jZmcpIHsNCi0JCS5xdWlya3Mg
PSBJT19QR1RBQkxFX1FVSVJLX0FSTV9OUyB8DQotCQkJSU9fUEdUQUJMRV9RVUlSS19OT19QRVJN
UyB8DQotCQkJSU9fUEdUQUJMRV9RVUlSS19UTEJJX09OX01BUCB8DQotCQkJSU9fUEdUQUJMRV9R
VUlSS19BUk1fTVRLX0VYVCwNCi0JCS5wZ3NpemVfYml0bWFwID0gbXRrX2lvbW11X29wcy5wZ3Np
emVfYml0bWFwLA0KLQkJLmlhcyA9IDMyLA0KLQkJLm9hcyA9IDM0LA0KLQkJLnRsYiA9ICZtdGtf
aW9tbXVfZmx1c2hfb3BzLA0KLQkJLmlvbW11X2RldiA9IGRhdGEtPmRldiwNCi0JfTsNCi0NCi0J
ZG9tLT5pb3AgPSBhbGxvY19pb19wZ3RhYmxlX29wcyhBUk1fVjdTLCAmZG9tLT5jZmcsIGRhdGEp
Ow0KLQlpZiAoIWRvbS0+aW9wKSB7DQotCQlkZXZfZXJyKGRhdGEtPmRldiwgIkZhaWxlZCB0byBh
bGxvYyBpbyBwZ3RhYmxlXG4iKTsNCi0JCXJldHVybiAtRUlOVkFMOw0KLQl9DQotDQotCS8qIFVw
ZGF0ZSBvdXIgc3VwcG9ydCBwYWdlIHNpemVzIGJpdG1hcCAqLw0KLQlkb20tPmRvbWFpbi5wZ3Np
emVfYml0bWFwID0gZG9tLT5jZmcucGdzaXplX2JpdG1hcDsNCi0JcmV0dXJuIDA7DQotfQ0KLQ0K
IHN0YXRpYyBzdHJ1Y3QgbXRrX2lvbW11X3BndGFibGUgKmNyZWF0ZV9wZ3RhYmxlKHN0cnVjdCBt
dGtfaW9tbXVfZGF0YSAqZGF0YSkNCiB7DQogCXN0cnVjdCBtdGtfaW9tbXVfcGd0YWJsZSAqcGd0
YWJsZTsNCkBAIC00MTQsMTEgKzM4MCwxNyBAQCBzdGF0aWMgaW50IG10a19pb21tdV9hdHRhY2hf
cGd0YWJsZShzdHJ1Y3QgbXRrX2lvbW11X2RhdGEgKmRhdGEsDQogDQogc3RhdGljIHN0cnVjdCBp
b21tdV9kb21haW4gKm10a19pb21tdV9kb21haW5fYWxsb2ModW5zaWduZWQgdHlwZSkNCiB7DQor
CXN0cnVjdCBtdGtfaW9tbXVfcGd0YWJsZSAqcGd0YWJsZSA9IG10a19pb21tdV9nZXRfcGd0YWJs
ZSgpOw0KIAlzdHJ1Y3QgbXRrX2lvbW11X2RvbWFpbiAqZG9tOw0KIA0KIAlpZiAodHlwZSAhPSBJ
T01NVV9ET01BSU5fRE1BKQ0KIAkJcmV0dXJuIE5VTEw7DQogDQorCWlmICghcGd0YWJsZSkgew0K
KwkJcHJfZXJyKCIlcywgcGd0YWJsZSBpcyBub3QgcmVhZHlcbiIsIF9fZnVuY19fKTsNCisJCXJl
dHVybiBOVUxMOw0KKwl9DQorDQogCWRvbSA9IGt6YWxsb2Moc2l6ZW9mKCpkb20pLCBHRlBfS0VS
TkVMKTsNCiAJaWYgKCFkb20pDQogCQlyZXR1cm4gTlVMTDsNCkBAIC00MjYsOCArMzk4LDEwIEBA
IHN0YXRpYyBzdHJ1Y3QgaW9tbXVfZG9tYWluICptdGtfaW9tbXVfZG9tYWluX2FsbG9jKHVuc2ln
bmVkIHR5cGUpDQogCWlmIChpb21tdV9nZXRfZG1hX2Nvb2tpZSgmZG9tLT5kb21haW4pKQ0KIAkJ
Z290byAgZnJlZV9kb207DQogDQotCWlmIChtdGtfaW9tbXVfZG9tYWluX2ZpbmFsaXNlKGRvbSkp
DQotCQlnb3RvICBwdXRfZG1hX2Nvb2tpZTsNCisJZG9tLT5jZmcgPSBwZ3RhYmxlLT5jZmc7DQor
CWRvbS0+aW9wID0gcGd0YWJsZS0+aW9wOw0KKwkvKiBVcGRhdGUgb3VyIHN1cHBvcnQgcGFnZSBz
aXplcyBiaXRtYXAgKi8NCisJZG9tLT5kb21haW4ucGdzaXplX2JpdG1hcCA9IHBndGFibGUtPmNm
Zy5wZ3NpemVfYml0bWFwOw0KIA0KIAlkb20tPmRvbWFpbi5nZW9tZXRyeS5hcGVydHVyZV9zdGFy
dCA9IDA7DQogCWRvbS0+ZG9tYWluLmdlb21ldHJ5LmFwZXJ0dXJlX2VuZCA9IERNQV9CSVRfTUFT
SygzMik7DQpAQCAtNDM1LDggKzQwOSw2IEBAIHN0YXRpYyBzdHJ1Y3QgaW9tbXVfZG9tYWluICpt
dGtfaW9tbXVfZG9tYWluX2FsbG9jKHVuc2lnbmVkIHR5cGUpDQogDQogCXJldHVybiAmZG9tLT5k
b21haW47DQogDQotcHV0X2RtYV9jb29raWU6DQotCWlvbW11X3B1dF9kbWFfY29va2llKCZkb20t
PmRvbWFpbik7DQogZnJlZV9kb206DQogCWtmcmVlKGRvbSk7DQogCXJldHVybiBOVUxMOw0KLS0g
DQoyLjE4LjANCg==

