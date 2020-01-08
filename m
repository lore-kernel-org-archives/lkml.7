Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32DC3C33C99
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 01:52:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08FF620848
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 01:52:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="AstZOzVd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbgAHBw6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 20:52:58 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:46630 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726931AbgAHBwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 20:52:37 -0500
X-UUID: 982e3704e816499d8d5668219d1e4c10-20200108
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=oZdq+ZB5lizA1Zsv3OtqtZc7ySPrJ90tee+pr+IgKBQ=;
        b=AstZOzVdlKNQpGDw2kWutbSCtHKfXowENkD4LJkKW0wfe5lR4dqbKTFcYblOiYg19NnOXn5hLg6CiwcB71BPi2FlOVC3D1ZMD1id8+q+vlNtFuFbF5e9WhOl+LpkkRE/SLG3vl4wMH8nz7p4r+erhMp7Mz8vRPLdxuH22fMg6AU=;
X-UUID: 982e3704e816499d8d5668219d1e4c10-20200108
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1620129963; Wed, 08 Jan 2020 09:52:31 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 8 Jan 2020 09:51:17 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 8 Jan 2020 09:53:02 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [RESEND PATCH v5 06/11] phy: phy-mtk-tphy: add a property for disconnect threshold
Date:   Wed, 8 Jan 2020 09:52:01 +0800
Message-ID: <1578448326-27455-6-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1578448326-27455-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1578448326-27455-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: BFA84CA48E7339B3DB0587B4124D89784EB6BDEA2575B14996EC5CD22A51D9592000:8
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

