Return-Path: <SRS0=Io4T=22=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E981C33C8C
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 10:47:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4465721775
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 10:47:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="MqMWF4yq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbgAEKrQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jan 2020 05:47:16 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:12685 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727025AbgAEKrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 05:47:14 -0500
X-UUID: 5bf3b63f330444bfa9e261eede22e1b7-20200105
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=BU3FHHq8lyI4GErrRVuqeiEhzwtLbu5dCFfMXEQDW1k=;
        b=MqMWF4yqiWhgMsbK53C3+P3W1eBxvElV/CXXkEw03l+esiqkv78SUOxUtGSxx1c0RViWO/gGPSAYam1uJPrfxgplbmxWpcPe07/O5JBfuGlaqZFrk3LU5PD/ViMpYAMQkeIdFIQZeCFyBOy6769EvpwkIQSfG3AJTfsKGdtDlcU=;
X-UUID: 5bf3b63f330444bfa9e261eede22e1b7-20200105
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw02.mediatek.com
        (envelope-from <chao.hao@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1428780349; Sun, 05 Jan 2020 18:47:10 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sun, 5 Jan 2020 18:46:44 +0800
Received: from localhost.localdomain (10.15.20.246) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sun, 5 Jan 2020 18:45:40 +0800
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
Subject: [PATCH v2 14/19] iommu/mediatek: Add mtk_domain_data structure
Date:   Sun, 5 Jan 2020 18:45:18 +0800
Message-ID: <20200105104523.31006-15-chao.hao@mediatek.com>
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

QWRkIG10a19kb21haW5fZGF0YSBzdHJ1Y3R1cmUgdG8gZGVzY3JpYmUgaG93IG1hbnkgaW92YSBy
ZWdpb25zDQp0aGVyZSBhcmUgYW5kIHRoZSByZWxldmFudCB0aGUgc3RhcnQgYW5kIGVuZCBhZGRy
ZXNzIG9mIGVhY2gNCmlvdmEgcmVnaW9uLiBUaGUgbnVtYmVyIG9mIGlvdmEgcmVnaW9uIGlzIGVx
dWFsIHRvIHRoZSBudW1iZXINCm9mIG10a19pb21tdV9kb21haW4uIFNvIHdlIHdpbGwgdXNlIG10
a19kb21haW5fZGF0YSB0byBpbml0aWFsaXplDQp0aGUgc3RhcnQgYW5kIGVuZCBpb3ZhIG9mIG10
a19pb21tdV9kb21haW4uDQoNClNpZ25lZC1vZmYtYnk6IENoYW8gSGFvIDxjaGFvLmhhb0BtZWRp
YXRlay5jb20+DQotLS0NCiBkcml2ZXJzL2lvbW11L210a19pb21tdS5jIHwgMTcgKysrKysrKysr
KysrKysrLS0NCiBkcml2ZXJzL2lvbW11L210a19pb21tdS5oIHwgMTcgKysrKysrKysrKysrKysr
KysNCiAyIGZpbGVzIGNoYW5nZWQsIDMyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQoN
CmRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L210a19pb21tdS5jIGIvZHJpdmVycy9pb21tdS9t
dGtfaW9tbXUuYw0KaW5kZXggZjIxMzcwMzNlYzU5Li5iMWNlMGEyZGY1ODMgMTAwNjQ0DQotLS0g
YS9kcml2ZXJzL2lvbW11L210a19pb21tdS5jDQorKysgYi9kcml2ZXJzL2lvbW11L210a19pb21t
dS5jDQpAQCAtMTIyLDYgKzEyMiwxMiBAQCBzdHJ1Y3QgbXRrX2lvbW11X3BndGFibGUgew0KIAlz
dHJ1Y3QgaW9fcGd0YWJsZV9vcHMJKmlvcDsNCiAJc3RydWN0IGRldmljZQkJKmluaXRfZGV2Ow0K
IAlzdHJ1Y3QgbGlzdF9oZWFkCW00dV9kb21fdjI7DQorCWNvbnN0IHN0cnVjdCBtdGtfZG9tYWlu
X2RhdGEJKmRvbV9yZWdpb247DQorfTsNCisNCitjb25zdCBzdHJ1Y3QgbXRrX2RvbWFpbl9kYXRh
IHNpbmdsZV9kb20gPSB7DQorCS5taW5faW92YSA9IDB4MCwNCisJLm1heF9pb3ZhID0gRE1BX0JJ
VF9NQVNLKDMyKQ0KIH07DQogDQogc3RhdGljIHN0cnVjdCBtdGtfaW9tbXVfcGd0YWJsZSAqc2hh
cmVfcGd0YWJsZTsNCkBAIC00MDAsNiArNDA2LDcgQEAgc3RhdGljIHN0cnVjdCBtdGtfaW9tbXVf
cGd0YWJsZSAqY3JlYXRlX3BndGFibGUoc3RydWN0IG10a19pb21tdV9kYXRhICpkYXRhKQ0KIAkJ
ZGV2X2VycihkYXRhLT5kZXYsICJGYWlsZWQgdG8gYWxsb2MgaW8gcGd0YWJsZVxuIik7DQogCQly
ZXR1cm4gRVJSX1BUUigtRUlOVkFMKTsNCiAJfQ0KKwlwZ3RhYmxlLT5kb21fcmVnaW9uID0gZGF0
YS0+cGxhdF9kYXRhLT5kb21fZGF0YTsNCiANCiAJZGV2X2luZm8oZGF0YS0+ZGV2LCAiJXMgY3Jl
YXRlIHBndGFibGUgZG9uZVxuIiwgX19mdW5jX18pOw0KIA0KQEAgLTQ3MCw4ICs0NzcsMTAgQEAg
c3RhdGljIHN0cnVjdCBpb21tdV9kb21haW4gKm10a19pb21tdV9kb21haW5fYWxsb2ModW5zaWdu
ZWQgdHlwZSkNCiAJLyogVXBkYXRlIG91ciBzdXBwb3J0IHBhZ2Ugc2l6ZXMgYml0bWFwICovDQog
CWRvbS0+ZG9tYWluLnBnc2l6ZV9iaXRtYXAgPSBwZ3RhYmxlLT5jZmcucGdzaXplX2JpdG1hcDsN
CiANCi0JZG9tLT5kb21haW4uZ2VvbWV0cnkuYXBlcnR1cmVfc3RhcnQgPSAwOw0KLQlkb20tPmRv
bWFpbi5nZW9tZXRyeS5hcGVydHVyZV9lbmQgPSBETUFfQklUX01BU0soMzIpOw0KKwlkb20tPmRv
bWFpbi5nZW9tZXRyeS5hcGVydHVyZV9zdGFydCA9DQorCQkJCXBndGFibGUtPmRvbV9yZWdpb24t
Pm1pbl9pb3ZhOw0KKwlkb20tPmRvbWFpbi5nZW9tZXRyeS5hcGVydHVyZV9lbmQgPQ0KKwkJCQlw
Z3RhYmxlLT5kb21fcmVnaW9uLT5tYXhfaW92YTsNCiAJZG9tLT5kb21haW4uZ2VvbWV0cnkuZm9y
Y2VfYXBlcnR1cmUgPSB0cnVlOw0KIAlsaXN0X2FkZF90YWlsKCZkb20tPmxpc3QsICZwZ3RhYmxl
LT5tNHVfZG9tX3YyKTsNCiANCkBAIC05NTMsNiArOTYyLDcgQEAgc3RhdGljIGNvbnN0IHN0cnVj
dCBtdGtfaW9tbXVfcGxhdF9kYXRhIG10MjcxMl9kYXRhID0gew0KIAkuaGFzX2JjbGsgICAgID0g
dHJ1ZSwNCiAJLmhhc192bGRfcGFfcm5nICAgPSB0cnVlLA0KIAkuZG9tX2NudCA9IDEsDQorCS5k
b21fZGF0YSA9ICZzaW5nbGVfZG9tLA0KIAkubGFyYmlkX3JlbWFwWzBdID0gezAsIDEsIDIsIDMs
IDQsIDUsIDYsIDcsIDgsIDl9LA0KIAkuaW52X3NlbF9yZWcgPSBSRUdfTU1VX0lOVl9TRUwsDQog
fTsNCkBAIC05NjAsNiArOTcwLDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfaW9tbXVfcGxh
dF9kYXRhIG10MjcxMl9kYXRhID0gew0KIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2lvbW11X3Bs
YXRfZGF0YSBtdDY3NzlfZGF0YSA9IHsNCiAJLm00dV9wbGF0ID0gTTRVX01UNjc3OSwNCiAJLmRv
bV9jbnQgPSAxLA0KKwkuZG9tX2RhdGEgPSAmc2luZ2xlX2RvbSwNCiAJLmxhcmJpZF9yZW1hcFsw
XSA9IHswLCAxLCAyLCAzLCA1LCA3LCAxMCwgOX0sDQogCS8qIHZwNmEsIHZwNmIsIG1kbGEvY29y
ZTIsIG1kbGEvZWRtYyovDQogCS5sYXJiaWRfcmVtYXBbMV0gPSB7MiwgMCwgMywgMX0sDQpAQCAt
OTc2LDYgKzk4Nyw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2lvbW11X3BsYXRfZGF0YSBt
dDgxNzNfZGF0YSA9IHsNCiAJLmhhc19iY2xrICAgICA9IHRydWUsDQogCS5yZXNldF9heGkgICAg
PSB0cnVlLA0KIAkuZG9tX2NudCA9IDEsDQorCS5kb21fZGF0YSA9ICZzaW5nbGVfZG9tLA0KIAku
bGFyYmlkX3JlbWFwWzBdID0gezAsIDEsIDIsIDMsIDQsIDV9LCAvKiBMaW5lYXIgbWFwcGluZy4g
Ki8NCiAJLmludl9zZWxfcmVnID0gUkVHX01NVV9JTlZfU0VMLA0KIH07DQpAQCAtOTg0LDYgKzk5
Niw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2lvbW11X3BsYXRfZGF0YSBtdDgxODNfZGF0
YSA9IHsNCiAJLm00dV9wbGF0ICAgICA9IE00VV9NVDgxODMsDQogCS5yZXNldF9heGkgICAgPSB0
cnVlLA0KIAkuZG9tX2NudCA9IDEsDQorCS5kb21fZGF0YSA9ICZzaW5nbGVfZG9tLA0KIAkubGFy
YmlkX3JlbWFwWzBdID0gezAsIDQsIDUsIDYsIDcsIDIsIDMsIDF9LA0KIAkuaW52X3NlbF9yZWcg
PSBSRUdfTU1VX0lOVl9TRUwsDQogfTsNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L210a19p
b21tdS5oIGIvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuaA0KaW5kZXggM2ExYzc5MjIyZDA5Li5h
MzhiMjYwMThhYmUgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2lvbW11L210a19pb21tdS5oDQorKysg
Yi9kcml2ZXJzL2lvbW11L210a19pb21tdS5oDQpAQCAtMzYsNiArMzYsMjIgQEAgZW51bSBtdGtf
aW9tbXVfcGxhdCB7DQogCU00VV9NVDgxODMsDQogfTsNCiANCisvKg0KKyAqIHJlc2VydmVkIElP
VkEgRG9tYWluIGZvciBJT01NVSB1c2VycyBvZiBIVyBsaW1pdGF0aW9uLg0KKyAqLw0KKw0KKy8q
DQorICogc3RydWN0IG10a19kb21haW5fZGF0YToJZG9tYWluIGNvbmZpZ3VyYXRpb24NCisgKiBA
bWluX2lvdmE6CVN0YXJ0IGFkZHJlc3Mgb2YgaW92YQ0KKyAqIEBtYXhfaW92YToJRW5kIGFkZHJl
c3Mgb2YgaW92YQ0KKyAqIE5vdGU6IG9uZSB1c2VyIGNhbiBvbmx5IGJlbG9uZyB0byBvbmUgZG9t
YWluDQorICovDQorDQorc3RydWN0IG10a19kb21haW5fZGF0YSB7DQorCWRtYV9hZGRyX3QJbWlu
X2lvdmE7DQorCWRtYV9hZGRyX3QJbWF4X2lvdmE7DQorfTsNCisNCiBzdHJ1Y3QgbXRrX2lvbW11
X3BsYXRfZGF0YSB7DQogCWVudW0gbXRrX2lvbW11X3BsYXQgbTR1X3BsYXQ7DQogCWJvb2wgICAg
ICAgICAgICAgICAgaGFzXzRnYl9tb2RlOw0KQEAgLTUxLDYgKzY3LDcgQEAgc3RydWN0IG10a19p
b21tdV9wbGF0X2RhdGEgew0KIAl1MzIgICAgICAgICAgICAgICAgIG00dTFfbWFzazsNCiAJdTMy
ICAgICAgICAgICAgICAgICBpbnZfc2VsX3JlZzsNCiAJdW5zaWduZWQgY2hhciAgICAgICBsYXJi
aWRfcmVtYXBbMl1bTVRLX0xBUkJfTlJfTUFYXTsNCisJY29uc3Qgc3RydWN0IG10a19kb21haW5f
ZGF0YQkqZG9tX2RhdGE7DQogfTsNCiANCiBzdHJ1Y3QgbXRrX2lvbW11X2RvbWFpbjsNCi0tIA0K
Mi4xOC4wDQo=

