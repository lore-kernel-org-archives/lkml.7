Return-Path: <SRS0=Io4T=22=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A791DC33C8C
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 10:46:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C61A20866
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 10:46:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="pFdgz2uZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbgAEKqz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jan 2020 05:46:55 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:24609 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726702AbgAEKqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 05:46:51 -0500
X-UUID: e2bc8ee6dc254265b5b1e3f3b70a7945-20200105
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=DGmQNidlzNQc5LwY8YiBP+cNsBp8IGVfEGVlTvoknPc=;
        b=pFdgz2uZ7V1zo4Yv/x7kvKtd2o4M60g9bGE8U5fdzYIpObJ/yx9XExN8aKYXv8aL5WOiGI/eKPVswIAOKYqTKaiDaWgKYUsIG6HGZ/j9eYSTzngXFzg+aOU7pq6FdEX038OEPLwM15tbgreK731chEcqvWTtwqe4HVTUiP3lWbg=;
X-UUID: e2bc8ee6dc254265b5b1e3f3b70a7945-20200105
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw02.mediatek.com
        (envelope-from <chao.hao@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 103566578; Sun, 05 Jan 2020 18:46:47 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sun, 5 Jan 2020 18:46:22 +0800
Received: from localhost.localdomain (10.15.20.246) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sun, 5 Jan 2020 18:45:17 +0800
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
Subject: [PATCH v2 07/19] iommu/mediatek: Add REG_MMU_WR_LEN reg define prepare for mt6779
Date:   Sun, 5 Jan 2020 18:45:11 +0800
Message-ID: <20200105104523.31006-8-chao.hao@mediatek.com>
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

V2hlbiBzb21lIHBsYXRmb3JtcyhleDpsYXRlciBtdDY3NzkpIGRlZmluZSBoYXNfd3JfbGVuIHZh
cmlhYmxlLA0Kd2UgbmVlZCB0byBzZXQgUkVHX01NVV9XUl9MRU4gdG8gaW1wcm92ZSBwZXJmb3Jt
YW5jZS4gU28gd2UgYWRkDQpSRUdfTU1VX1dSX0xFTiByZWdpc3RlciBkZWZpbmUgaW4gdGhpcyBw
YXRjaC4NCg0KU2lnbmVkLW9mZi1ieTogQ2hhbyBIYW8gPGNoYW8uaGFvQG1lZGlhdGVrLmNvbT4N
Ci0tLQ0KIGRyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMgfCAxMSArKysrKysrKysrKw0KIGRyaXZl
cnMvaW9tbXUvbXRrX2lvbW11LmggfCAgMiArKw0KIDIgZmlsZXMgY2hhbmdlZCwgMTMgaW5zZXJ0
aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYyBiL2RyaXZl
cnMvaW9tbXUvbXRrX2lvbW11LmMNCmluZGV4IDVkZTEzYWIxMDk0ZS4uYWQ1NjkwMzUwZDZhIDEw
MDY0NA0KLS0tIGEvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYw0KKysrIGIvZHJpdmVycy9pb21t
dS9tdGtfaW9tbXUuYw0KQEAgLTQ0LDYgKzQ0LDggQEANCiANCiAjZGVmaW5lIFJFR19NTVVfTUlT
Q19DVFJMCQkJMHgwNDgNCiAjZGVmaW5lIFJFR19NTVVfRENNX0RJUwkJCQkweDA1MA0KKyNkZWZp
bmUgUkVHX01NVV9XUl9MRU4JCQkJMHgwNTQNCisjZGVmaW5lIEZfTU1VX1dSX1RIUk9UX0RJUwkJ
CShCSVQoNSkgfCAgQklUKDIxKSkNCiANCiAjZGVmaW5lIFJFR19NTVVfQ1RSTF9SRUcJCQkweDEx
MA0KICNkZWZpbmUgRl9NTVVfVEZfUFJPVF9UT19QUk9HUkFNX0FERFIJCSgyIDw8IDQpDQpAQCAt
NTk1LDYgKzU5NywxMyBAQCBzdGF0aWMgaW50IG10a19pb21tdV9od19pbml0KGNvbnN0IHN0cnVj
dCBtdGtfaW9tbXVfZGF0YSAqZGF0YSkNCiAJfQ0KIAl3cml0ZWxfcmVsYXhlZCgwLCBkYXRhLT5i
YXNlICsgUkVHX01NVV9EQ01fRElTKTsNCiANCisJaWYgKGRhdGEtPnBsYXRfZGF0YS0+aGFzX3dy
X2xlbikgew0KKwkJLyogd3JpdGUgY29tbWFuZCB0aHJvdHRsaW5nIG1vZGUgKi8NCisJCXJlZ3Zh
bCA9IHJlYWRsX3JlbGF4ZWQoZGF0YS0+YmFzZSArIFJFR19NTVVfV1JfTEVOKTsNCisJCXJlZ3Zh
bCAmPSB+Rl9NTVVfV1JfVEhST1RfRElTOw0KKwkJd3JpdGVsX3JlbGF4ZWQocmVndmFsLCBkYXRh
LT5iYXNlICsgUkVHX01NVV9XUl9MRU4pOw0KKwl9DQorDQogCWlmIChkYXRhLT5wbGF0X2RhdGEt
PnJlc2V0X2F4aSkNCiAJCXdyaXRlbF9yZWxheGVkKDAsIGRhdGEtPmJhc2UgKyBSRUdfTU1VX01J
U0NfQ1RSTCk7DQogDQpAQCAtNzQzLDYgKzc1Miw3IEBAIHN0YXRpYyBpbnQgX19tYXliZV91bnVz
ZWQgbXRrX2lvbW11X3N1c3BlbmQoc3RydWN0IGRldmljZSAqZGV2KQ0KIAlzdHJ1Y3QgbXRrX2lv
bW11X3N1c3BlbmRfcmVnICpyZWcgPSAmZGF0YS0+cmVnOw0KIAl2b2lkIF9faW9tZW0gKmJhc2Ug
PSBkYXRhLT5iYXNlOw0KIA0KKwlyZWctPndyX2xlbiA9IHJlYWRsX3JlbGF4ZWQoYmFzZSArIFJF
R19NTVVfV1JfTEVOKTsNCiAJcmVnLT5zdGFuZGFyZF9heGlfbW9kZSA9IHJlYWRsX3JlbGF4ZWQo
YmFzZSArDQogCQkJCQkgICAgICAgUkVHX01NVV9NSVNDX0NUUkwpOw0KIAlyZWctPmRjbV9kaXMg
PSByZWFkbF9yZWxheGVkKGJhc2UgKyBSRUdfTU1VX0RDTV9ESVMpOw0KQEAgLTc2OCw2ICs3Nzgs
NyBAQCBzdGF0aWMgaW50IF9fbWF5YmVfdW51c2VkIG10a19pb21tdV9yZXN1bWUoc3RydWN0IGRl
dmljZSAqZGV2KQ0KIAkJZGV2X2VycihkYXRhLT5kZXYsICJGYWlsZWQgdG8gZW5hYmxlIGNsaygl
ZCkgaW4gcmVzdW1lXG4iLCByZXQpOw0KIAkJcmV0dXJuIHJldDsNCiAJfQ0KKwl3cml0ZWxfcmVs
YXhlZChyZWctPndyX2xlbiwgYmFzZSArIFJFR19NTVVfV1JfTEVOKTsNCiAJd3JpdGVsX3JlbGF4
ZWQocmVnLT5zdGFuZGFyZF9heGlfbW9kZSwNCiAJCSAgICAgICBiYXNlICsgUkVHX01NVV9NSVND
X0NUUkwpOw0KIAl3cml0ZWxfcmVsYXhlZChyZWctPmRjbV9kaXMsIGJhc2UgKyBSRUdfTU1VX0RD
TV9ESVMpOw0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmggYi9kcml2ZXJz
L2lvbW11L210a19pb21tdS5oDQppbmRleCBkNDQ5NTIzMGM2ZTcuLjA2MjNmMTk5ZTk2ZiAxMDA2
NDQNCi0tLSBhL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmgNCisrKyBiL2RyaXZlcnMvaW9tbXUv
bXRrX2lvbW11LmgNCkBAIC0yNSw2ICsyNSw3IEBAIHN0cnVjdCBtdGtfaW9tbXVfc3VzcGVuZF9y
ZWcgew0KIAl1MzIJCQkJaW50X21haW5fY29udHJvbDsNCiAJdTMyCQkJCWl2cnBfcGFkZHI7DQog
CXUzMgkJCQl2bGRfcGFfcm5nOw0KKwl1MzIJCQkJd3JfbGVuOw0KIH07DQogDQogZW51bSBtdGtf
aW9tbXVfcGxhdCB7DQpAQCAtNDMsNiArNDQsNyBAQCBzdHJ1Y3QgbXRrX2lvbW11X3BsYXRfZGF0
YSB7DQogCWJvb2wgICAgICAgICAgICAgICAgaGFzX3N1Yl9jb21tWzJdOw0KIAlib29sICAgICAg
ICAgICAgICAgIGhhc192bGRfcGFfcm5nOw0KIAlib29sICAgICAgICAgICAgICAgIHJlc2V0X2F4
aTsNCisJYm9vbCAgICAgICAgICAgICAgICBoYXNfd3JfbGVuOw0KIAl1MzIgICAgICAgICAgICAg
ICAgIG00dTFfbWFzazsNCiAJdTMyICAgICAgICAgICAgICAgICBpbnZfc2VsX3JlZzsNCiAJdW5z
aWduZWQgY2hhciAgICAgICBsYXJiaWRfcmVtYXBbMl1bTVRLX0xBUkJfTlJfTUFYXTsNCi0tIA0K
Mi4xOC4wDQo=

