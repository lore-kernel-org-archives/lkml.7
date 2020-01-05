Return-Path: <SRS0=Io4T=22=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05E23C33C8C
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 10:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1484222C4
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 10:47:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="bFs2cIlw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbgAEKrT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jan 2020 05:47:19 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:51931 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727146AbgAEKrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 05:47:17 -0500
X-UUID: a6ec5ce760754a7484ce00383978b84f-20200105
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=gy4tHLXRv2FvAOvp3/caFYhMAq0QdVmLmvhz6NoN0hg=;
        b=bFs2cIlwC35DlAIaD5o5geMasFYxn+VOky0UUpJrpUOVpFdeSiU10Ew7KkQt2bT/H1kYbOV6qFo+4IWcTM6OQj9XQAe9LeV18DXJa/SHduypc3wWhVLaJ2Bg3+G1gw1ZhWnG/SLFjkhzcU1ZdjAb1QrdKF/SbjKnxKrxOJkSY9w=;
X-UUID: a6ec5ce760754a7484ce00383978b84f-20200105
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw02.mediatek.com
        (envelope-from <chao.hao@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 352062431; Sun, 05 Jan 2020 18:47:12 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sun, 5 Jan 2020 18:46:45 +0800
Received: from localhost.localdomain (10.15.20.246) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sun, 5 Jan 2020 18:45:42 +0800
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
Subject: [PATCH v2 15/19] iommu/mediatek: Remove the usage of m4u_dom variable
Date:   Sun, 5 Jan 2020 18:45:19 +0800
Message-ID: <20200105104523.31006-16-chao.hao@mediatek.com>
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

VGhpcyBwYXRjaCB3aWxsIHJlbW92ZSB0aGUgdXNhZ2Ugb2YgdGhlIG00dV9kb20gdmFyaWFibGUu
DQoNCldlIGhhdmUgYWxyZWFkeSByZWRlZmluZWQgbXRrX2lvbW11X2RvbWFpbiBzdHJ1Y3R1cmUg
YW5kIGl0DQppbmNsdWRlcyBpb21tdV9kb21haW4sIHNvIG00dV9kb20gdmFyaWFibGUgd2lsbCBu
b3QgYmUgdXNlZC4NCg0KU2lnbmVkLW9mZi1ieTogQ2hhbyBIYW8gPGNoYW8uaGFvQG1lZGlhdGVr
LmNvbT4NCi0tLQ0KIGRyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMgfCAyNyArKysrKysrKysrKysr
KysrKysrKy0tLS0tLS0NCiAxIGZpbGUgY2hhbmdlZCwgMjAgaW5zZXJ0aW9ucygrKSwgNyBkZWxl
dGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMgYi9kcml2
ZXJzL2lvbW11L210a19pb21tdS5jDQppbmRleCBiMWNlMGEyZGY1ODMuLmJmYjE4MzFhZmFlOSAx
MDA2NDQNCi0tLSBhL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMNCisrKyBiL2RyaXZlcnMvaW9t
bXUvbXRrX2lvbW11LmMNCkBAIC0xMDcsNiArMTA3LDcgQEANCiAgKiBHZXQgdGhlIGxvY2FsIGFy
Yml0ZXIgSUQgYW5kIHRoZSBwb3J0aWQgd2l0aGluIHRoZSBsYXJiIGFyYml0ZXINCiAgKiBmcm9t
IG10a19tNHVfaWQgd2hpY2ggaXMgZGVmaW5lZCBieSBNVEtfTTRVX0lELg0KICAqLw0KKyNkZWZp
bmUgTVRLX000VV9JRChsYXJiLCBwb3J0KQkJKCgobGFyYikgPDwgNSkgfCAocG9ydCkpDQogI2Rl
ZmluZSBNVEtfTTRVX1RPX0xBUkIoaWQpCQkoKChpZCkgPj4gNSkgJiAweGYpDQogI2RlZmluZSBN
VEtfTTRVX1RPX1BPUlQoaWQpCQkoKGlkKSAmIDB4MWYpDQogDQpAQCAtMTk5LDYgKzIwMCwyMiBA
QCBzdGF0aWMgdTMyIG10a19pb21tdV9nZXRfZG9tYWluX2lkKHN0cnVjdCBkZXZpY2UgKmRldikN
CiAJcmV0dXJuIGdldF9kb21haW5faWQoZGF0YSwgcG9ydGlkKTsNCiB9DQogDQorc3RhdGljIHN0
cnVjdCBpb21tdV9kb21haW4gKl9nZXRfbXRrX2RvbWFpbihzdHJ1Y3QgbXRrX2lvbW11X2RhdGEg
KmRhdGEsDQorCQkJCQkgICAgdTMyIGxhcmJpZCwgdTMyIHBvcnRpZCkNCit7DQorCXUzMiBkb21h
aW5faWQ7DQorCXUzMiBwb3J0X21hc2sgPSBNVEtfTTRVX0lEKGxhcmJpZCwgcG9ydGlkKTsNCisJ
c3RydWN0IG10a19pb21tdV9kb21haW4gKmRvbTsNCisNCisJZG9tYWluX2lkID0gZ2V0X2RvbWFp
bl9pZChkYXRhLCBwb3J0X21hc2spOw0KKw0KKwlsaXN0X2Zvcl9lYWNoX2VudHJ5KGRvbSwgJmRh
dGEtPnBndGFibGUtPm00dV9kb21fdjIsIGxpc3QpIHsNCisJCWlmIChkb20tPmlkID09IGRvbWFp
bl9pZCkNCisJCQlyZXR1cm4gJmRvbS0+ZG9tYWluOw0KKwl9DQorCXJldHVybiBOVUxMOw0KK30N
CisNCiBzdGF0aWMgc3RydWN0IG10a19pb21tdV9kb21haW4gKmdldF9tdGtfZG9tYWluKHN0cnVj
dCBkZXZpY2UgKmRldikNCiB7DQogCXN0cnVjdCBtdGtfaW9tbXVfZGF0YSAqZGF0YSA9IGRldi0+
aW9tbXVfZndzcGVjLT5pb21tdV9wcml2Ow0KQEAgLTMwMSw3ICszMTgsNyBAQCBzdGF0aWMgY29u
c3Qgc3RydWN0IGlvbW11X2ZsdXNoX29wcyBtdGtfaW9tbXVfZmx1c2hfb3BzID0gew0KIHN0YXRp
YyBpcnFyZXR1cm5fdCBtdGtfaW9tbXVfaXNyKGludCBpcnEsIHZvaWQgKmRldl9pZCkNCiB7DQog
CXN0cnVjdCBtdGtfaW9tbXVfZGF0YSAqZGF0YSA9IGRldl9pZDsNCi0Jc3RydWN0IG10a19pb21t
dV9kb21haW4gKmRvbSA9IGRhdGEtPm00dV9kb207DQorCXN0cnVjdCBpb21tdV9kb21haW4gKmRv
bWFpbjsNCiAJdTMyIGludF9zdGF0ZSwgcmVndmFsLCBmYXVsdF9pb3ZhLCBmYXVsdF9wYTsNCiAJ
dW5zaWduZWQgaW50IGZhdWx0X2xhcmIsIGZhdWx0X3BvcnQsIHN1Yl9jb21tID0gMDsNCiAJYm9v
bCBsYXllciwgd3JpdGU7DQpAQCAtMzM2LDcgKzM1Myw4IEBAIHN0YXRpYyBpcnFyZXR1cm5fdCBt
dGtfaW9tbXVfaXNyKGludCBpcnEsIHZvaWQgKmRldl9pZCkNCiANCiAJZmF1bHRfbGFyYiA9IGRh
dGEtPnBsYXRfZGF0YS0+bGFyYmlkX3JlbWFwW2RhdGEtPm00dV9pZF1bZmF1bHRfbGFyYl07DQog
DQotCWlmIChyZXBvcnRfaW9tbXVfZmF1bHQoJmRvbS0+ZG9tYWluLCBkYXRhLT5kZXYsIGZhdWx0
X2lvdmEsDQorCWRvbWFpbiA9IF9nZXRfbXRrX2RvbWFpbihkYXRhLCBmYXVsdF9sYXJiLCBmYXVs
dF9wb3J0KTsNCisJaWYgKHJlcG9ydF9pb21tdV9mYXVsdChkb21haW4sIGRhdGEtPmRldiwgZmF1
bHRfaW92YSwNCiAJCQkgICAgICAgd3JpdGUgPyBJT01NVV9GQVVMVF9XUklURSA6IElPTU1VX0ZB
VUxUX1JFQUQpKSB7DQogCQlkZXZfZXJyX3JhdGVsaW1pdGVkKA0KIAkJCWRhdGEtPmRldiwNCkBA
IC01MDYsMTYgKzUyNCwxMSBAQCBzdGF0aWMgdm9pZCBtdGtfaW9tbXVfZG9tYWluX2ZyZWUoc3Ry
dWN0IGlvbW11X2RvbWFpbiAqZG9tYWluKQ0KIHN0YXRpYyBpbnQgbXRrX2lvbW11X2F0dGFjaF9k
ZXZpY2Uoc3RydWN0IGlvbW11X2RvbWFpbiAqZG9tYWluLA0KIAkJCQkgICBzdHJ1Y3QgZGV2aWNl
ICpkZXYpDQogew0KLQlzdHJ1Y3QgbXRrX2lvbW11X2RvbWFpbiAqZG9tID0gdG9fbXRrX2RvbWFp
bihkb21haW4pOw0KIAlzdHJ1Y3QgbXRrX2lvbW11X2RhdGEgKmRhdGEgPSBkZXZfaW9tbXVfZndz
cGVjX2dldChkZXYpLT5pb21tdV9wcml2Ow0KIA0KIAlpZiAoIWRhdGEpDQogCQlyZXR1cm4gLUVO
T0RFVjsNCiANCi0JLyogVXBkYXRlIHRoZSBwZ3RhYmxlIGJhc2UgYWRkcmVzcyByZWdpc3RlciBv
ZiB0aGUgTTRVIEhXICovDQotCWlmICghZGF0YS0+bTR1X2RvbSkNCi0JCWRhdGEtPm00dV9kb20g
PSBkb207DQotDQogCW10a19pb21tdV9jb25maWcoZGF0YSwgZGV2LCB0cnVlKTsNCiAJcmV0dXJu
IDA7DQogfQ0KLS0gDQoyLjE4LjANCg==

