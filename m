Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8511CC2D0DD
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 04:02:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FACF20863
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 04:02:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="US+SrH5N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727754AbgABECq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jan 2020 23:02:46 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:23623 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727624AbgABEC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jan 2020 23:02:29 -0500
X-UUID: d2da767072b1400a9e78fb5547e04ac7-20200102
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=deIbXXx9icA1VtH9lvCqkXIJRv+7M70V70iJ9WqyKmk=;
        b=US+SrH5N55hszOfkTL9W38SVaG0vxnO0hPPIAVtT88oyoGdQx9e+OZ1MGIxFwk4jv3f5mAgdEH2/e0Lt9M587VQi6B6ikRvdFiFSC/WNB3SNvEwdPMDnhEv44EWQCMm/ypzFw1T3EC+wOWw4NGacWClMCowgrOC8ReWiR2fUc/8=;
X-UUID: d2da767072b1400a9e78fb5547e04ac7-20200102
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 682223982; Thu, 02 Jan 2020 12:02:26 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 2 Jan 2020 12:01:59 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 2 Jan 2020 12:01:44 +0800
From:   Yongqiang Niu <yongqiang.niu@mediatek.com>
To:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>
Subject: [PATCH v6, 13/14] drm/mediatek: add fifo_size into rdma private data
Date:   Thu, 2 Jan 2020 12:00:23 +0800
Message-ID: <1577937624-14313-14-git-send-email-yongqiang.niu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1577937624-14313-1-git-send-email-yongqiang.niu@mediatek.com>
References: <1577937624-14313-1-git-send-email-yongqiang.niu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dGhlIGZpZm8gc2l6ZSBvZiByZG1hIGluIG10ODE4MyBpcyBkaWZmZXJlbnQuDQpyZG1hMCBmaWZv
IHNpemUgaXMgNWsNCnJkbWExIGZpZm8gc2l6ZSBpcyAyaw0KDQpTaWduZWQtb2ZmLWJ5OiBZb25n
cWlhbmcgTml1IDx5b25ncWlhbmcubml1QG1lZGlhdGVrLmNvbT4NCi0tLQ0KIGRyaXZlcnMvZ3B1
L2RybS9tZWRpYXRlay9tdGtfZGlzcF9yZG1hLmMgfCAyMSArKysrKysrKysrKysrKysrKysrKy0N
CiAxIGZpbGUgY2hhbmdlZCwgMjAgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KDQpkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX3JkbWEuYyBiL2RyaXZl
cnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9yZG1hLmMNCmluZGV4IDQwNWFmZWYuLjY5MTQ4
MGIgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3BfcmRtYS5j
DQorKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3BfcmRtYS5jDQpAQCAtNjIs
NiArNjIsNyBAQCBzdHJ1Y3QgbXRrX2Rpc3BfcmRtYSB7DQogCXN0cnVjdCBtdGtfZGRwX2NvbXAJ
CWRkcF9jb21wOw0KIAlzdHJ1Y3QgZHJtX2NydGMJCQkqY3J0YzsNCiAJY29uc3Qgc3RydWN0IG10
a19kaXNwX3JkbWFfZGF0YQkqZGF0YTsNCisJdTMyCQkJCWZpZm9fc2l6ZTsNCiB9Ow0KIA0KIHN0
YXRpYyBpbmxpbmUgc3RydWN0IG10a19kaXNwX3JkbWEgKmNvbXBfdG9fcmRtYShzdHJ1Y3QgbXRr
X2RkcF9jb21wICpjb21wKQ0KQEAgLTEzMCwxMCArMTMxLDE2IEBAIHN0YXRpYyB2b2lkIG10a19y
ZG1hX2NvbmZpZyhzdHJ1Y3QgbXRrX2RkcF9jb21wICpjb21wLCB1bnNpZ25lZCBpbnQgd2lkdGgs
DQogCXVuc2lnbmVkIGludCB0aHJlc2hvbGQ7DQogCXVuc2lnbmVkIGludCByZWc7DQogCXN0cnVj
dCBtdGtfZGlzcF9yZG1hICpyZG1hID0gY29tcF90b19yZG1hKGNvbXApOw0KKwl1MzIgcmRtYV9m
aWZvX3NpemU7DQogDQogCXJkbWFfdXBkYXRlX2JpdHMoY29tcCwgRElTUF9SRUdfUkRNQV9TSVpF
X0NPTl8wLCAweGZmZiwgd2lkdGgpOw0KIAlyZG1hX3VwZGF0ZV9iaXRzKGNvbXAsIERJU1BfUkVH
X1JETUFfU0laRV9DT05fMSwgMHhmZmZmZiwgaGVpZ2h0KTsNCiANCisJaWYgKHJkbWEtPmZpZm9f
c2l6ZSkNCisJCXJkbWFfZmlmb19zaXplID0gcmRtYS0+Zmlmb19zaXplOw0KKwllbHNlDQorCQly
ZG1hX2ZpZm9fc2l6ZSA9IFJETUFfRklGT19TSVpFKHJkbWEpOw0KKw0KIAkvKg0KIAkgKiBFbmFi
bGUgRklGTyB1bmRlcmZsb3cgc2luY2UgRFNJIGFuZCBEUEkgY2FuJ3QgYmUgYmxvY2tlZC4NCiAJ
ICogS2VlcCB0aGUgRklGTyBwc2V1ZG8gc2l6ZSByZXNldCBkZWZhdWx0IG9mIDggS2lCLiBTZXQg
dGhlDQpAQCAtMTQyLDcgKzE0OSw3IEBAIHN0YXRpYyB2b2lkIG10a19yZG1hX2NvbmZpZyhzdHJ1
Y3QgbXRrX2RkcF9jb21wICpjb21wLCB1bnNpZ25lZCBpbnQgd2lkdGgsDQogCSAqLw0KIAl0aHJl
c2hvbGQgPSB3aWR0aCAqIGhlaWdodCAqIHZyZWZyZXNoICogNCAqIDcgLyAxMDAwMDAwOw0KIAly
ZWcgPSBSRE1BX0ZJRk9fVU5ERVJGTE9XX0VOIHwNCi0JICAgICAgUkRNQV9GSUZPX1BTRVVET19T
SVpFKFJETUFfRklGT19TSVpFKHJkbWEpKSB8DQorCSAgICAgIFJETUFfRklGT19QU0VVRE9fU0la
RShyZG1hX2ZpZm9fc2l6ZSkgfA0KIAkgICAgICBSRE1BX09VVFBVVF9WQUxJRF9GSUZPX1RIUkVT
SE9MRCh0aHJlc2hvbGQpOw0KIAl3cml0ZWwocmVnLCBjb21wLT5yZWdzICsgRElTUF9SRUdfUkRN
QV9GSUZPX0NPTik7DQogfQ0KQEAgLTI4NCw2ICsyOTEsMTggQEAgc3RhdGljIGludCBtdGtfZGlz
cF9yZG1hX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQogCQlyZXR1cm4gY29t
cF9pZDsNCiAJfQ0KIA0KKwlpZiAob2ZfZmluZF9wcm9wZXJ0eShkZXYtPm9mX25vZGUsICJtZWRp
YXRlayxyZG1hX2ZpZm9fc2l6ZSIsICZyZXQpKSB7DQorCQlyZXQgPSBvZl9wcm9wZXJ0eV9yZWFk
X3UzMihkZXYtPm9mX25vZGUsDQorCQkJCQkgICAibWVkaWF0ZWsscmRtYV9maWZvX3NpemUiLA0K
KwkJCQkJICAgJnByaXYtPmZpZm9fc2l6ZSk7DQorCQlpZiAocmV0KSB7DQorCQkJZGV2X2Vycihk
ZXYsICJGYWlsZWQgdG8gZ2V0IHJkbWEgZmlmbyBzaXplXG4iKTsNCisJCQlyZXR1cm4gcmV0Ow0K
KwkJfQ0KKw0KKwkJcHJpdi0+Zmlmb19zaXplICo9IFNaXzFLOw0KKwl9DQorDQogCXJldCA9IG10
a19kZHBfY29tcF9pbml0KGRldiwgZGV2LT5vZl9ub2RlLCAmcHJpdi0+ZGRwX2NvbXAsIGNvbXBf
aWQsDQogCQkJCSZtdGtfZGlzcF9yZG1hX2Z1bmNzKTsNCiAJaWYgKHJldCkgew0KLS0gDQoxLjgu
MS4xLmRpcnR5DQo=

