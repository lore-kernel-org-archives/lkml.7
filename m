Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E67DC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 05:55:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0233A214D8
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 05:55:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="nXoI6YBA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbfLKFzD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 00:55:03 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:31713 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727784AbfLKFy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 00:54:59 -0500
X-UUID: 6c15ce00c0034573b9732ebd0212c3db-20191211
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=oZdq+ZB5lizA1Zsv3OtqtZc7ySPrJ90tee+pr+IgKBQ=;
        b=nXoI6YBA4W+m71iX1xdU2VRtkTWk+uEM1JeZBEVK9MXnJlME4sr6ibx9Jf4r48JmP3QKk2Ju0WonxogYse2n1TeK1M4xTcM4AjsIvwN3yWw87SCLWkoPrw3BTQaNyd4qpBum3YeKInYB+IDskla++CyP3cIJJQLy+DMgS0gTXI4=;
X-UUID: 6c15ce00c0034573b9732ebd0212c3db-20191211
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 76639154; Wed, 11 Dec 2019 13:54:53 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 11 Dec 2019 13:53:52 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 11 Dec 2019 13:54:44 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v5 06/11] phy: phy-mtk-tphy: add a property for disconnect threshold
Date:   Wed, 11 Dec 2019 13:54:18 +0800
Message-ID: <1576043663-14240-6-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1576043663-14240-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1576043663-14240-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 4088C541017843BA450E94A2BBBA50CB32742BB6D9559D008ECF50E07CA7047A2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBpcyB1c2VkIHRvIHR1bmUgdGhlIHRocmVzaG9sZCBvZiBkaXNjb25uZWN0LCB0aGUgaW5k
ZXggcmFuZ2UNCmlzIFswLCAxNV0sIHRoZSB0aHJlc2hvbGQgdm9sdGFnZSBpcyBhYm91dCA0MDBt
ViBmb3IgMCwgNzAwbVYgZm9yDQoxNSwgYW5kIHRoZSBzdGVwIGlzIDIwbVYuDQoNClNpZ25lZC1v
ZmYtYnk6IENodW5mZW5nIFl1biA8Y2h1bmZlbmcueXVuQG1lZGlhdGVrLmNvbT4NCi0tLQ0KdjU6
IG5vIGNoYW5nZXMNCg0KdjQ6IGNoYW5nZSBjb21taXQgbG9nDQoNCnYyfjM6IG5vIGNoYW5nZXMN
Ci0tLQ0KIGRyaXZlcnMvcGh5L21lZGlhdGVrL3BoeS1tdGstdHBoeS5jIHwgMTcgKysrKysrKysr
KysrKysrLS0NCiAxIGZpbGUgY2hhbmdlZCwgMTUgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMo
LSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGh5L21lZGlhdGVrL3BoeS1tdGstdHBoeS5jIGIv
ZHJpdmVycy9waHkvbWVkaWF0ZWsvcGh5LW10ay10cGh5LmMNCmluZGV4IGNiMmVkM2IyNTA2OC4u
NWFmZTMzNjIxZGJjIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9waHkvbWVkaWF0ZWsvcGh5LW10ay10
cGh5LmMNCisrKyBiL2RyaXZlcnMvcGh5L21lZGlhdGVrL3BoeS1tdGstdHBoeS5jDQpAQCAtNjAs
NiArNjAsOCBAQA0KICNkZWZpbmUgVTNQX1VTQlBIWUFDUjYJCTB4MDE4DQogI2RlZmluZSBQQTZf
UkdfVTJfQkMxMV9TV19FTgkJQklUKDIzKQ0KICNkZWZpbmUgUEE2X1JHX1UyX09UR19WQlVTQ01Q
X0VOCUJJVCgyMCkNCisjZGVmaW5lIFBBNl9SR19VMl9ESVNDVEgJCUdFTk1BU0soNywgNCkNCisj
ZGVmaW5lIFBBNl9SR19VMl9ESVNDVEhfVkFMKHgpCSgoMHhmICYgKHgpKSA8PCA0KQ0KICNkZWZp
bmUgUEE2X1JHX1UyX1NRVEgJCUdFTk1BU0soMywgMCkNCiAjZGVmaW5lIFBBNl9SR19VMl9TUVRI
X1ZBTCh4KQkoMHhmICYgKHgpKQ0KIA0KQEAgLTMwMCw2ICszMDIsNyBAQCBzdHJ1Y3QgbXRrX3Bo
eV9pbnN0YW5jZSB7DQogCWludCBleWVfc3JjOw0KIAlpbnQgZXllX3ZydDsNCiAJaW50IGV5ZV90
ZXJtOw0KKwlpbnQgZGlzY3RoOw0KIAlib29sIGJjMTJfZW47DQogfTsNCiANCkBAIC04NTAsOSAr
ODUzLDEyIEBAIHN0YXRpYyB2b2lkIHBoeV9wYXJzZV9wcm9wZXJ0eShzdHJ1Y3QgbXRrX3RwaHkg
KnRwaHksDQogCQkJCSAmaW5zdGFuY2UtPmV5ZV92cnQpOw0KIAlkZXZpY2VfcHJvcGVydHlfcmVh
ZF91MzIoZGV2LCAibWVkaWF0ZWssZXllLXRlcm0iLA0KIAkJCQkgJmluc3RhbmNlLT5leWVfdGVy
bSk7DQotCWRldl9kYmcoZGV2LCAiYmMxMjolZCwgc3JjOiVkLCB2cnQ6JWQsIHRlcm06JWRcbiIs
DQorCWRldmljZV9wcm9wZXJ0eV9yZWFkX3UzMihkZXYsICJtZWRpYXRlayxkaXNjdGgiLA0KKwkJ
CQkgJmluc3RhbmNlLT5kaXNjdGgpOw0KKwlkZXZfZGJnKGRldiwgImJjMTI6JWQsIHNyYzolZCwg
dnJ0OiVkLCB0ZXJtOiVkLCBkaXNjOiVkXG4iLA0KIAkJaW5zdGFuY2UtPmJjMTJfZW4sIGluc3Rh
bmNlLT5leWVfc3JjLA0KLQkJaW5zdGFuY2UtPmV5ZV92cnQsIGluc3RhbmNlLT5leWVfdGVybSk7
DQorCQlpbnN0YW5jZS0+ZXllX3ZydCwgaW5zdGFuY2UtPmV5ZV90ZXJtLA0KKwkJaW5zdGFuY2Ut
PmRpc2N0aCk7DQogfQ0KIA0KIHN0YXRpYyB2b2lkIHUyX3BoeV9wcm9wc19zZXQoc3RydWN0IG10
a190cGh5ICp0cGh5LA0KQEAgLTg4OCw2ICs4OTQsMTMgQEAgc3RhdGljIHZvaWQgdTJfcGh5X3By
b3BzX3NldChzdHJ1Y3QgbXRrX3RwaHkgKnRwaHksDQogCQl0bXAgfD0gUEExX1JHX1RFUk1fU0VM
X1ZBTChpbnN0YW5jZS0+ZXllX3Rlcm0pOw0KIAkJd3JpdGVsKHRtcCwgY29tICsgVTNQX1VTQlBI
WUFDUjEpOw0KIAl9DQorDQorCWlmIChpbnN0YW5jZS0+ZGlzY3RoKSB7DQorCQl0bXAgPSByZWFk
bChjb20gKyBVM1BfVVNCUEhZQUNSNik7DQorCQl0bXAgJj0gflBBNl9SR19VMl9ESVNDVEg7DQor
CQl0bXAgfD0gUEE2X1JHX1UyX0RJU0NUSF9WQUwoaW5zdGFuY2UtPmRpc2N0aCk7DQorCQl3cml0
ZWwodG1wLCBjb20gKyBVM1BfVVNCUEhZQUNSNik7DQorCX0NCiB9DQogDQogc3RhdGljIGludCBt
dGtfcGh5X2luaXQoc3RydWN0IHBoeSAqcGh5KQ0KLS0gDQoyLjI0LjANCg==

