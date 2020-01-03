Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6F8BC3276F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 03:13:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBCBF21D7D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 03:13:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="j4oxqgxv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727617AbgACDNW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 22:13:22 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:8062 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727521AbgACDM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 22:12:57 -0500
X-UUID: f44a66eac7e249c1ae5b04652d144ac0-20200103
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=RT3d9kWeiIuE9GL2srPbr1r8xa3wmXvPk20GUq9hFEg=;
        b=j4oxqgxvsuaW0MJD0JOher3/tAJ6Bt4/j+QlLyanP+BGpBRj4NJb3Q5psUmxZ1BDfBXhgQynIVnJbTzQOFAHQyxWvJtnVaqzWBQiP8kSmNE6kcd9NxXzi0GLe/z3WM4PMObjQ133Ru/LPpkcNc6CloKWpZGvfl2ZXhuOZD0wwQI=;
X-UUID: f44a66eac7e249c1ae5b04652d144ac0-20200103
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1727894227; Fri, 03 Jan 2020 11:12:52 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 3 Jan 2020 11:12:24 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 3 Jan 2020 11:13:18 +0800
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
Subject: [RESEND PATCH v6 16/17] drm/mediatek: add fifo_size into rdma private data
Date:   Fri, 3 Jan 2020 11:12:27 +0800
Message-ID: <1578021148-32413-17-git-send-email-yongqiang.niu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1578021148-32413-1-git-send-email-yongqiang.niu@mediatek.com>
References: <1578021148-32413-1-git-send-email-yongqiang.niu@mediatek.com>
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
L2RybS9tZWRpYXRlay9tdGtfZGlzcF9yZG1hLmMgfCAxOSArKysrKysrKysrKysrKysrKystDQog
MSBmaWxlIGNoYW5nZWQsIDE4IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCg0KZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9yZG1hLmMgYi9kcml2ZXJz
L2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3BfcmRtYS5jDQppbmRleCA0MDVhZmVmLi4wZTBhZjA0
YSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9yZG1hLmMN
CisrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9yZG1hLmMNCkBAIC02Miw2
ICs2Miw3IEBAIHN0cnVjdCBtdGtfZGlzcF9yZG1hIHsNCiAJc3RydWN0IG10a19kZHBfY29tcAkJ
ZGRwX2NvbXA7DQogCXN0cnVjdCBkcm1fY3J0YwkJCSpjcnRjOw0KIAljb25zdCBzdHJ1Y3QgbXRr
X2Rpc3BfcmRtYV9kYXRhCSpkYXRhOw0KKwl1MzIJCQkJZmlmb19zaXplOw0KIH07DQogDQogc3Rh
dGljIGlubGluZSBzdHJ1Y3QgbXRrX2Rpc3BfcmRtYSAqY29tcF90b19yZG1hKHN0cnVjdCBtdGtf
ZGRwX2NvbXAgKmNvbXApDQpAQCAtMTMwLDEwICsxMzEsMTYgQEAgc3RhdGljIHZvaWQgbXRrX3Jk
bWFfY29uZmlnKHN0cnVjdCBtdGtfZGRwX2NvbXAgKmNvbXAsIHVuc2lnbmVkIGludCB3aWR0aCwN
CiAJdW5zaWduZWQgaW50IHRocmVzaG9sZDsNCiAJdW5zaWduZWQgaW50IHJlZzsNCiAJc3RydWN0
IG10a19kaXNwX3JkbWEgKnJkbWEgPSBjb21wX3RvX3JkbWEoY29tcCk7DQorCXUzMiByZG1hX2Zp
Zm9fc2l6ZTsNCiANCiAJcmRtYV91cGRhdGVfYml0cyhjb21wLCBESVNQX1JFR19SRE1BX1NJWkVf
Q09OXzAsIDB4ZmZmLCB3aWR0aCk7DQogCXJkbWFfdXBkYXRlX2JpdHMoY29tcCwgRElTUF9SRUdf
UkRNQV9TSVpFX0NPTl8xLCAweGZmZmZmLCBoZWlnaHQpOw0KIA0KKwlpZiAocmRtYS0+Zmlmb19z
aXplKQ0KKwkJcmRtYV9maWZvX3NpemUgPSByZG1hLT5maWZvX3NpemU7DQorCWVsc2UNCisJCXJk
bWFfZmlmb19zaXplID0gUkRNQV9GSUZPX1NJWkUocmRtYSk7DQorDQogCS8qDQogCSAqIEVuYWJs
ZSBGSUZPIHVuZGVyZmxvdyBzaW5jZSBEU0kgYW5kIERQSSBjYW4ndCBiZSBibG9ja2VkLg0KIAkg
KiBLZWVwIHRoZSBGSUZPIHBzZXVkbyBzaXplIHJlc2V0IGRlZmF1bHQgb2YgOCBLaUIuIFNldCB0
aGUNCkBAIC0xNDIsNyArMTQ5LDcgQEAgc3RhdGljIHZvaWQgbXRrX3JkbWFfY29uZmlnKHN0cnVj
dCBtdGtfZGRwX2NvbXAgKmNvbXAsIHVuc2lnbmVkIGludCB3aWR0aCwNCiAJICovDQogCXRocmVz
aG9sZCA9IHdpZHRoICogaGVpZ2h0ICogdnJlZnJlc2ggKiA0ICogNyAvIDEwMDAwMDA7DQogCXJl
ZyA9IFJETUFfRklGT19VTkRFUkZMT1dfRU4gfA0KLQkgICAgICBSRE1BX0ZJRk9fUFNFVURPX1NJ
WkUoUkRNQV9GSUZPX1NJWkUocmRtYSkpIHwNCisJICAgICAgUkRNQV9GSUZPX1BTRVVET19TSVpF
KHJkbWFfZmlmb19zaXplKSB8DQogCSAgICAgIFJETUFfT1VUUFVUX1ZBTElEX0ZJRk9fVEhSRVNI
T0xEKHRocmVzaG9sZCk7DQogCXdyaXRlbChyZWcsIGNvbXAtPnJlZ3MgKyBESVNQX1JFR19SRE1B
X0ZJRk9fQ09OKTsNCiB9DQpAQCAtMjg0LDYgKzI5MSwxNiBAQCBzdGF0aWMgaW50IG10a19kaXNw
X3JkbWFfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCiAJCXJldHVybiBjb21w
X2lkOw0KIAl9DQogDQorCWlmIChvZl9maW5kX3Byb3BlcnR5KGRldi0+b2Zfbm9kZSwgIm1lZGlh
dGVrLHJkbWFfZmlmb19zaXplIiwgJnJldCkpIHsNCisJCXJldCA9IG9mX3Byb3BlcnR5X3JlYWRf
dTMyKGRldi0+b2Zfbm9kZSwNCisJCQkJCSAgICJtZWRpYXRlayxyZG1hX2ZpZm9fc2l6ZSIsDQor
CQkJCQkgICAmcHJpdi0+Zmlmb19zaXplKTsNCisJCWlmIChyZXQpIHsNCisJCQlkZXZfZXJyKGRl
diwgIkZhaWxlZCB0byBnZXQgcmRtYSBmaWZvIHNpemVcbiIpOw0KKwkJCXJldHVybiByZXQ7DQor
CQl9DQorCX0NCisNCiAJcmV0ID0gbXRrX2RkcF9jb21wX2luaXQoZGV2LCBkZXYtPm9mX25vZGUs
ICZwcml2LT5kZHBfY29tcCwgY29tcF9pZCwNCiAJCQkJJm10a19kaXNwX3JkbWFfZnVuY3MpOw0K
IAlpZiAocmV0KSB7DQotLSANCjEuOC4xLjEuZGlydHkNCg==

