Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 560ABC17448
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 08:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EFD321783
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 08:37:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="hkwHUQZU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbfKLIhJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 03:37:09 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:9135 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727143AbfKLIhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 03:37:06 -0500
X-UUID: ced489d8bf39445093e0e30e306e2c7c-20191112
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=yMzHcP4/uyY2Cx5LN7YBeIgq9eqF5jOyU8/aGjqQQf8=;
        b=hkwHUQZUuQbxP5EXnM55C7fTW+VqLDqjWbb5faMuP9z2wt5VpYZ0d7ji/JdAalvGTGN8ujwJL6W05VkiOCASX04AXroGBV9IU/QULNdMBEK83VnXp6ZDkyoI7+op/7pfdRof8lSHh8FaLtErPwaIT+5Jdf2oJg2Ilr1Nl9gYziA=;
X-UUID: ced489d8bf39445093e0e30e306e2c7c-20191112
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 625615438; Tue, 12 Nov 2019 16:37:00 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 12 Nov 2019 16:36:58 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 12 Nov 2019 16:36:57 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v4 06/11] phy: phy-mtk-tphy: add a property for disconnect threshold
Date:   Tue, 12 Nov 2019 16:36:31 +0800
Message-ID: <1573547796-29566-6-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1573547796-29566-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1573547796-29566-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 5A7971E6D4202723A12F9211218CE4AF0C55924D46C907829EE0A7B04322B9122000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBpcyB1c2VkIHRvIHR1bmUgdGhlIHRocmVzaG9sZCBvZiBkaXNjb25uZWN0LCB0aGUgaW5k
ZXggcmFuZ2UNCmlzIFswLCAxNV0sIHRoZSB0aHJlc2hvbGQgdm9sdGFnZSBpcyBhYm91dCA0MDBt
ViBmb3IgMCwgNzAwbVYgZm9yDQoxNSwgYW5kIHRoZSBzdGVwIGlzIDIwbVYuDQoNClNpZ25lZC1v
ZmYtYnk6IENodW5mZW5nIFl1biA8Y2h1bmZlbmcueXVuQG1lZGlhdGVrLmNvbT4NCi0tLQ0KdjQ6
IGNoYW5nZSBjb21taXQgbG9nDQoNCnYyfjM6IG5vIGNoYW5nZXMNCi0tLQ0KIGRyaXZlcnMvcGh5
L21lZGlhdGVrL3BoeS1tdGstdHBoeS5jIHwgMTcgKysrKysrKysrKysrKysrLS0NCiAxIGZpbGUg
Y2hhbmdlZCwgMTUgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBh
L2RyaXZlcnMvcGh5L21lZGlhdGVrL3BoeS1tdGstdHBoeS5jIGIvZHJpdmVycy9waHkvbWVkaWF0
ZWsvcGh5LW10ay10cGh5LmMNCmluZGV4IGNiMmVkM2IyNTA2OC4uNWFmZTMzNjIxZGJjIDEwMDY0
NA0KLS0tIGEvZHJpdmVycy9waHkvbWVkaWF0ZWsvcGh5LW10ay10cGh5LmMNCisrKyBiL2RyaXZl
cnMvcGh5L21lZGlhdGVrL3BoeS1tdGstdHBoeS5jDQpAQCAtNjAsNiArNjAsOCBAQA0KICNkZWZp
bmUgVTNQX1VTQlBIWUFDUjYJCTB4MDE4DQogI2RlZmluZSBQQTZfUkdfVTJfQkMxMV9TV19FTgkJ
QklUKDIzKQ0KICNkZWZpbmUgUEE2X1JHX1UyX09UR19WQlVTQ01QX0VOCUJJVCgyMCkNCisjZGVm
aW5lIFBBNl9SR19VMl9ESVNDVEgJCUdFTk1BU0soNywgNCkNCisjZGVmaW5lIFBBNl9SR19VMl9E
SVNDVEhfVkFMKHgpCSgoMHhmICYgKHgpKSA8PCA0KQ0KICNkZWZpbmUgUEE2X1JHX1UyX1NRVEgJ
CUdFTk1BU0soMywgMCkNCiAjZGVmaW5lIFBBNl9SR19VMl9TUVRIX1ZBTCh4KQkoMHhmICYgKHgp
KQ0KIA0KQEAgLTMwMCw2ICszMDIsNyBAQCBzdHJ1Y3QgbXRrX3BoeV9pbnN0YW5jZSB7DQogCWlu
dCBleWVfc3JjOw0KIAlpbnQgZXllX3ZydDsNCiAJaW50IGV5ZV90ZXJtOw0KKwlpbnQgZGlzY3Ro
Ow0KIAlib29sIGJjMTJfZW47DQogfTsNCiANCkBAIC04NTAsOSArODUzLDEyIEBAIHN0YXRpYyB2
b2lkIHBoeV9wYXJzZV9wcm9wZXJ0eShzdHJ1Y3QgbXRrX3RwaHkgKnRwaHksDQogCQkJCSAmaW5z
dGFuY2UtPmV5ZV92cnQpOw0KIAlkZXZpY2VfcHJvcGVydHlfcmVhZF91MzIoZGV2LCAibWVkaWF0
ZWssZXllLXRlcm0iLA0KIAkJCQkgJmluc3RhbmNlLT5leWVfdGVybSk7DQotCWRldl9kYmcoZGV2
LCAiYmMxMjolZCwgc3JjOiVkLCB2cnQ6JWQsIHRlcm06JWRcbiIsDQorCWRldmljZV9wcm9wZXJ0
eV9yZWFkX3UzMihkZXYsICJtZWRpYXRlayxkaXNjdGgiLA0KKwkJCQkgJmluc3RhbmNlLT5kaXNj
dGgpOw0KKwlkZXZfZGJnKGRldiwgImJjMTI6JWQsIHNyYzolZCwgdnJ0OiVkLCB0ZXJtOiVkLCBk
aXNjOiVkXG4iLA0KIAkJaW5zdGFuY2UtPmJjMTJfZW4sIGluc3RhbmNlLT5leWVfc3JjLA0KLQkJ
aW5zdGFuY2UtPmV5ZV92cnQsIGluc3RhbmNlLT5leWVfdGVybSk7DQorCQlpbnN0YW5jZS0+ZXll
X3ZydCwgaW5zdGFuY2UtPmV5ZV90ZXJtLA0KKwkJaW5zdGFuY2UtPmRpc2N0aCk7DQogfQ0KIA0K
IHN0YXRpYyB2b2lkIHUyX3BoeV9wcm9wc19zZXQoc3RydWN0IG10a190cGh5ICp0cGh5LA0KQEAg
LTg4OCw2ICs4OTQsMTMgQEAgc3RhdGljIHZvaWQgdTJfcGh5X3Byb3BzX3NldChzdHJ1Y3QgbXRr
X3RwaHkgKnRwaHksDQogCQl0bXAgfD0gUEExX1JHX1RFUk1fU0VMX1ZBTChpbnN0YW5jZS0+ZXll
X3Rlcm0pOw0KIAkJd3JpdGVsKHRtcCwgY29tICsgVTNQX1VTQlBIWUFDUjEpOw0KIAl9DQorDQor
CWlmIChpbnN0YW5jZS0+ZGlzY3RoKSB7DQorCQl0bXAgPSByZWFkbChjb20gKyBVM1BfVVNCUEhZ
QUNSNik7DQorCQl0bXAgJj0gflBBNl9SR19VMl9ESVNDVEg7DQorCQl0bXAgfD0gUEE2X1JHX1Uy
X0RJU0NUSF9WQUwoaW5zdGFuY2UtPmRpc2N0aCk7DQorCQl3cml0ZWwodG1wLCBjb20gKyBVM1Bf
VVNCUEhZQUNSNik7DQorCX0NCiB9DQogDQogc3RhdGljIGludCBtdGtfcGh5X2luaXQoc3RydWN0
IHBoeSAqcGh5KQ0KLS0gDQoyLjIzLjANCg==

