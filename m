Return-Path: <SRS0=Io4T=22=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DAA1C33C8C
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 10:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C342207FD
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 10:47:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="YGljSC8q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727264AbgAEKrl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jan 2020 05:47:41 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:23490 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726376AbgAEKrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 05:47:08 -0500
X-UUID: ed6921aaaf3e44569e2117d59d61f7c9-20200105
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=wzv+DS2QU8JGS/oClDBJUbQzay4lYYCHyz03iNL5uvs=;
        b=YGljSC8q8V0BRi4imizn3RnSB2cTy4/hf4KslC+BzSMYe9Bq3Dm7MT9BxXOJsIOMDSEgOTCRcASbPKJiJby67h+sBectUDNtxlxaRxWxJ3FrNS653qkxaWlt9BM1pcPclGg++ZQEDIyC/0Vwxu+NwiDqkVZAi9Ofnh9PK8bj5/c=;
X-UUID: ed6921aaaf3e44569e2117d59d61f7c9-20200105
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <chao.hao@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1008748616; Sun, 05 Jan 2020 18:47:02 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sun, 5 Jan 2020 18:46:35 +0800
Received: from localhost.localdomain (10.15.20.246) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sun, 5 Jan 2020 18:45:32 +0800
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
Subject: [PATCH v2 11/19] iommu/mediatek: Remove pgtable info in mtk_iommu_domain
Date:   Sun, 5 Jan 2020 18:45:15 +0800
Message-ID: <20200105104523.31006-12-chao.hao@mediatek.com>
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

VGhpcyBwYXRjaCB3aWxsIHVzZSBtdGtfaW9tbXVfcGd0YWJsZSB0byByZXBsYWNlIHRoZSBwYXJ0
DQpvZiBwZ3RhYmxlIGluIG10a19pb21tdV9kb21haW4sIHNvIHdlIGNhbiByZW1vdmUgdGhlIGlu
Zm9ybWF0aW9uDQpvZiBwZ3RhYmxlIGluIG10a19pb21tdV9kb21haW4uDQoNClNpZ25lZC1vZmYt
Ynk6IENoYW8gSGFvIDxjaGFvLmhhb0BtZWRpYXRlay5jb20+DQotLS0NCiBkcml2ZXJzL2lvbW11
L210a19pb21tdS5jIHwgMzcgKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLQ0K
IDEgZmlsZSBjaGFuZ2VkLCAxNyBpbnNlcnRpb25zKCspLCAyMCBkZWxldGlvbnMoLSkNCg0KZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMgYi9kcml2ZXJzL2lvbW11L210a19p
b21tdS5jDQppbmRleCBjZmVmZGQ2MzhmMWEuLmIzNGJkM2FiY2NmOCAxMDA2NDQNCi0tLSBhL2Ry
aXZlcnMvaW9tbXUvbXRrX2lvbW11LmMNCisrKyBiL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMN
CkBAIC0xMTEsOSArMTExLDYgQEANCiAjZGVmaW5lIE1US19NNFVfVE9fUE9SVChpZCkJCSgoaWQp
ICYgMHgxZikNCiANCiBzdHJ1Y3QgbXRrX2lvbW11X2RvbWFpbiB7DQotCXN0cnVjdCBpb19wZ3Rh
YmxlX2NmZwkJY2ZnOw0KLQlzdHJ1Y3QgaW9fcGd0YWJsZV9vcHMJCSppb3A7DQotDQogCXN0cnVj
dCBpb21tdV9kb21haW4JCWRvbWFpbjsNCiB9Ow0KIA0KQEAgLTM3Myw2ICszNzAsMTAgQEAgc3Rh
dGljIGludCBtdGtfaW9tbXVfYXR0YWNoX3BndGFibGUoc3RydWN0IG10a19pb21tdV9kYXRhICpk
YXRhLA0KIAkvKiBiaW5kaW5nIHRvIHBndGFibGUgKi8NCiAJZGF0YS0+cGd0YWJsZSA9IHBndGFi
bGU7DQogDQorCS8qIHVwZGF0ZSBIVyBzZXR0aW5ncyAqLw0KKwl3cml0ZWwocGd0YWJsZS0+Y2Zn
LmFybV92N3NfY2ZnLnR0YnJbMF0gJiBNTVVfUFRfQUREUl9NQVNLLA0KKwkgICAgICAgZGF0YS0+
YmFzZSArIFJFR19NTVVfUFRfQkFTRV9BRERSKTsNCisNCiAJZGV2X2luZm8oZGF0YS0+ZGV2LCAi
bTR1JWQgYXR0YWNoX3BndGFibGUgZG9uZSFcbiIsIGRhdGEtPm00dV9pZCk7DQogDQogCXJldHVy
biAwOw0KQEAgLTM5OCw4ICszOTksNiBAQCBzdGF0aWMgc3RydWN0IGlvbW11X2RvbWFpbiAqbXRr
X2lvbW11X2RvbWFpbl9hbGxvYyh1bnNpZ25lZCB0eXBlKQ0KIAlpZiAoaW9tbXVfZ2V0X2RtYV9j
b29raWUoJmRvbS0+ZG9tYWluKSkNCiAJCWdvdG8gIGZyZWVfZG9tOw0KIA0KLQlkb20tPmNmZyA9
IHBndGFibGUtPmNmZzsNCi0JZG9tLT5pb3AgPSBwZ3RhYmxlLT5pb3A7DQogCS8qIFVwZGF0ZSBv
dXIgc3VwcG9ydCBwYWdlIHNpemVzIGJpdG1hcCAqLw0KIAlkb20tPmRvbWFpbi5wZ3NpemVfYml0
bWFwID0gcGd0YWJsZS0+Y2ZnLnBnc2l6ZV9iaXRtYXA7DQogDQpAQCAtNDE2LDExICs0MTUsMTIg
QEAgc3RhdGljIHN0cnVjdCBpb21tdV9kb21haW4gKm10a19pb21tdV9kb21haW5fYWxsb2ModW5z
aWduZWQgdHlwZSkNCiANCiBzdGF0aWMgdm9pZCBtdGtfaW9tbXVfZG9tYWluX2ZyZWUoc3RydWN0
IGlvbW11X2RvbWFpbiAqZG9tYWluKQ0KIHsNCi0Jc3RydWN0IG10a19pb21tdV9kb21haW4gKmRv
bSA9IHRvX210a19kb21haW4oZG9tYWluKTsNCisJc3RydWN0IG10a19pb21tdV9wZ3RhYmxlICpw
Z3RhYmxlID0gbXRrX2lvbW11X2dldF9wZ3RhYmxlKCk7DQogDQotCWZyZWVfaW9fcGd0YWJsZV9v
cHMoZG9tLT5pb3ApOw0KIAlpb21tdV9wdXRfZG1hX2Nvb2tpZShkb21haW4pOw0KIAlrZnJlZSh0
b19tdGtfZG9tYWluKGRvbWFpbikpOw0KKwlmcmVlX2lvX3BndGFibGVfb3BzKHBndGFibGUtPmlv
cCk7DQorCWtmcmVlKHBndGFibGUpOw0KIH0NCiANCiBzdGF0aWMgaW50IG10a19pb21tdV9hdHRh
Y2hfZGV2aWNlKHN0cnVjdCBpb21tdV9kb21haW4gKmRvbWFpbiwNCkBAIC00MzMsMTEgKzQzMyw4
IEBAIHN0YXRpYyBpbnQgbXRrX2lvbW11X2F0dGFjaF9kZXZpY2Uoc3RydWN0IGlvbW11X2RvbWFp
biAqZG9tYWluLA0KIAkJcmV0dXJuIC1FTk9ERVY7DQogDQogCS8qIFVwZGF0ZSB0aGUgcGd0YWJs
ZSBiYXNlIGFkZHJlc3MgcmVnaXN0ZXIgb2YgdGhlIE00VSBIVyAqLw0KLQlpZiAoIWRhdGEtPm00
dV9kb20pIHsNCisJaWYgKCFkYXRhLT5tNHVfZG9tKQ0KIAkJZGF0YS0+bTR1X2RvbSA9IGRvbTsN
Ci0JCXdyaXRlbChkb20tPmNmZy5hcm1fdjdzX2NmZy50dGJyWzBdICYgTU1VX1BUX0FERFJfTUFT
SywNCi0JCSAgICAgICBkYXRhLT5iYXNlICsgUkVHX01NVV9QVF9CQVNFX0FERFIpOw0KLQl9DQog
DQogCW10a19pb21tdV9jb25maWcoZGF0YSwgZGV2LCB0cnVlKTsNCiAJcmV0dXJuIDA7DQpAQCAt
NDU3LDcgKzQ1NCw3IEBAIHN0YXRpYyB2b2lkIG10a19pb21tdV9kZXRhY2hfZGV2aWNlKHN0cnVj
dCBpb21tdV9kb21haW4gKmRvbWFpbiwNCiBzdGF0aWMgaW50IG10a19pb21tdV9tYXAoc3RydWN0
IGlvbW11X2RvbWFpbiAqZG9tYWluLCB1bnNpZ25lZCBsb25nIGlvdmEsDQogCQkJIHBoeXNfYWRk
cl90IHBhZGRyLCBzaXplX3Qgc2l6ZSwgaW50IHByb3QsIGdmcF90IGdmcCkNCiB7DQotCXN0cnVj
dCBtdGtfaW9tbXVfZG9tYWluICpkb20gPSB0b19tdGtfZG9tYWluKGRvbWFpbik7DQorCXN0cnVj
dCBtdGtfaW9tbXVfcGd0YWJsZSAqcGd0YWJsZSA9IG10a19pb21tdV9nZXRfcGd0YWJsZSgpOw0K
IAlzdHJ1Y3QgbXRrX2lvbW11X2RhdGEgKmRhdGEgPSBtdGtfaW9tbXVfZ2V0X200dV9kYXRhKCk7
DQogDQogCS8qIFRoZSAiNEdCIG1vZGUiIE00VSBwaHlzaWNhbGx5IGNhbiBub3QgdXNlIHRoZSBs
b3dlciByZW1hcCBvZiBEcmFtLiAqLw0KQEAgLTQ2NSwxNiArNDYyLDE2IEBAIHN0YXRpYyBpbnQg
bXRrX2lvbW11X21hcChzdHJ1Y3QgaW9tbXVfZG9tYWluICpkb21haW4sIHVuc2lnbmVkIGxvbmcg
aW92YSwNCiAJCXBhZGRyIHw9IEJJVF9VTEwoMzIpOw0KIA0KIAkvKiBTeW5jaHJvbml6ZSB3aXRo
IHRoZSB0bGJfbG9jayAqLw0KLQlyZXR1cm4gZG9tLT5pb3AtPm1hcChkb20tPmlvcCwgaW92YSwg
cGFkZHIsIHNpemUsIHByb3QpOw0KKwlyZXR1cm4gcGd0YWJsZS0+aW9wLT5tYXAocGd0YWJsZS0+
aW9wLCBpb3ZhLCBwYWRkciwgc2l6ZSwgcHJvdCk7DQogfQ0KIA0KIHN0YXRpYyBzaXplX3QgbXRr
X2lvbW11X3VubWFwKHN0cnVjdCBpb21tdV9kb21haW4gKmRvbWFpbiwNCiAJCQkgICAgICB1bnNp
Z25lZCBsb25nIGlvdmEsIHNpemVfdCBzaXplLA0KIAkJCSAgICAgIHN0cnVjdCBpb21tdV9pb3Rs
Yl9nYXRoZXIgKmdhdGhlcikNCiB7DQotCXN0cnVjdCBtdGtfaW9tbXVfZG9tYWluICpkb20gPSB0
b19tdGtfZG9tYWluKGRvbWFpbik7DQorCXN0cnVjdCBtdGtfaW9tbXVfcGd0YWJsZSAqcGd0YWJs
ZSA9IG10a19pb21tdV9nZXRfcGd0YWJsZSgpOw0KIA0KLQlyZXR1cm4gZG9tLT5pb3AtPnVubWFw
KGRvbS0+aW9wLCBpb3ZhLCBzaXplLCBnYXRoZXIpOw0KKwlyZXR1cm4gcGd0YWJsZS0+aW9wLT51
bm1hcChwZ3RhYmxlLT5pb3AsIGlvdmEsIHNpemUsIGdhdGhlcik7DQogfQ0KIA0KIHN0YXRpYyB2
b2lkIG10a19pb21tdV9mbHVzaF9pb3RsYl9hbGwoc3RydWN0IGlvbW11X2RvbWFpbiAqZG9tYWlu
KQ0KQEAgLTQ5OCwxMSArNDk1LDExIEBAIHN0YXRpYyB2b2lkIG10a19pb21tdV9pb3RsYl9zeW5j
KHN0cnVjdCBpb21tdV9kb21haW4gKmRvbWFpbiwNCiBzdGF0aWMgcGh5c19hZGRyX3QgbXRrX2lv
bW11X2lvdmFfdG9fcGh5cyhzdHJ1Y3QgaW9tbXVfZG9tYWluICpkb21haW4sDQogCQkJCQkgIGRt
YV9hZGRyX3QgaW92YSkNCiB7DQotCXN0cnVjdCBtdGtfaW9tbXVfZG9tYWluICpkb20gPSB0b19t
dGtfZG9tYWluKGRvbWFpbik7DQorCXN0cnVjdCBtdGtfaW9tbXVfcGd0YWJsZSAqcGd0YWJsZSA9
IG10a19pb21tdV9nZXRfcGd0YWJsZSgpOw0KIAlzdHJ1Y3QgbXRrX2lvbW11X2RhdGEgKmRhdGEg
PSBtdGtfaW9tbXVfZ2V0X200dV9kYXRhKCk7DQogCXBoeXNfYWRkcl90IHBhOw0KIA0KLQlwYSA9
IGRvbS0+aW9wLT5pb3ZhX3RvX3BoeXMoZG9tLT5pb3AsIGlvdmEpOw0KKwlwYSA9IHBndGFibGUt
PmlvcC0+aW92YV90b19waHlzKHBndGFibGUtPmlvcCwgaW92YSk7DQogCWlmIChkYXRhLT5lbmFi
bGVfNEdCICYmIHBhID49IE1US19JT01NVV80R0JfTU9ERV9SRU1BUF9CQVNFKQ0KIAkJcGEgJj0g
fkJJVF9VTEwoMzIpOw0KIA0KQEAgLTg0NSw4ICs4NDIsOCBAQCBzdGF0aWMgaW50IF9fbWF5YmVf
dW51c2VkIG10a19pb21tdV9zdXNwZW5kKHN0cnVjdCBkZXZpY2UgKmRldikNCiBzdGF0aWMgaW50
IF9fbWF5YmVfdW51c2VkIG10a19pb21tdV9yZXN1bWUoc3RydWN0IGRldmljZSAqZGV2KQ0KIHsN
CiAJc3RydWN0IG10a19pb21tdV9kYXRhICpkYXRhID0gZGV2X2dldF9kcnZkYXRhKGRldik7DQor
CXN0cnVjdCBtdGtfaW9tbXVfcGd0YWJsZSAqcGd0YWJsZSA9IGRhdGEtPnBndGFibGU7DQogCXN0
cnVjdCBtdGtfaW9tbXVfc3VzcGVuZF9yZWcgKnJlZyA9ICZkYXRhLT5yZWc7DQotCXN0cnVjdCBt
dGtfaW9tbXVfZG9tYWluICptNHVfZG9tID0gZGF0YS0+bTR1X2RvbTsNCiAJdm9pZCBfX2lvbWVt
ICpiYXNlID0gZGF0YS0+YmFzZTsNCiAJaW50IHJldDsNCiANCkBAIC04NjQsOCArODYxLDggQEAg
c3RhdGljIGludCBfX21heWJlX3VudXNlZCBtdGtfaW9tbXVfcmVzdW1lKHN0cnVjdCBkZXZpY2Ug
KmRldikNCiAJd3JpdGVsX3JlbGF4ZWQocmVnLT5pbnRfbWFpbl9jb250cm9sLCBiYXNlICsgUkVH
X01NVV9JTlRfTUFJTl9DT05UUk9MKTsNCiAJd3JpdGVsX3JlbGF4ZWQocmVnLT5pdnJwX3BhZGRy
LCBiYXNlICsgUkVHX01NVV9JVlJQX1BBRERSKTsNCiAJd3JpdGVsX3JlbGF4ZWQocmVnLT52bGRf
cGFfcm5nLCBiYXNlICsgUkVHX01NVV9WTERfUEFfUk5HKTsNCi0JaWYgKG00dV9kb20pDQotCQl3
cml0ZWwobTR1X2RvbS0+Y2ZnLmFybV92N3NfY2ZnLnR0YnJbMF0gJiBNTVVfUFRfQUREUl9NQVNL
LA0KKwlpZiAocGd0YWJsZSkNCisJCXdyaXRlbChwZ3RhYmxlLT5jZmcuYXJtX3Y3c19jZmcudHRi
clswXSAmIE1NVV9QVF9BRERSX01BU0ssDQogCQkgICAgICAgYmFzZSArIFJFR19NTVVfUFRfQkFT
RV9BRERSKTsNCiAJcmV0dXJuIDA7DQogfQ0KLS0gDQoyLjE4LjANCg==

