Return-Path: <SRS0=Io4T=22=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 333D7C33C8C
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 10:46:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 075BB20866
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 10:46:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="a333gjfQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbgAEKqr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jan 2020 05:46:47 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:63687 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725930AbgAEKqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 05:46:46 -0500
X-UUID: 21bf380631114563ac5aed5aea0b57ef-20200105
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=ZPCRSBMjNTbmtCtbn8whmT0YKKLCCciViyvFYOwLrTg=;
        b=a333gjfQQ0nklAp2U7LVLl1bAWTaGJ+WYDma4471zh5LzpbqpYjiYwozu6kQy4CnAwbkl/g6AwVM8DzoDzicOJL3AFZ5ehQzW43B9HH/zH16z2tK+lyi1nsHEk2NNYbK/BScMiADuYT5E5Y1/jHPHxDy4uPASdgcQFO5S5H9VRA=;
X-UUID: 21bf380631114563ac5aed5aea0b57ef-20200105
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <chao.hao@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1631028064; Sun, 05 Jan 2020 18:46:43 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sun, 5 Jan 2020 18:46:15 +0800
Received: from localhost.localdomain (10.15.20.246) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sun, 5 Jan 2020 18:45:07 +0800
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
Subject: [PATCH v2 05/19] iommu/mediatek: Put inv_sel_reg in the plat_data for preparing add 0x2c support in mt6779
Date:   Sun, 5 Jan 2020 18:45:09 +0800
Message-ID: <20200105104523.31006-6-chao.hao@mediatek.com>
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

Rm9yIG10Njc3OSwgTU1VX0lOVkxEVF9TRUwgcmVnaXN0ZXIncyBvZmZzZXQgaXMgY2hhbmdlZCBm
cm9tIDB4MzggdG8gMHgyYywNCnNvIHdlIGNhbiBwdXQgaW52X3NlbF9yZWcgaW4gdGhlIHBsYXRf
ZGF0YSB0byB1c2UgaXQuDQoNClNpZ25lZC1vZmYtYnk6IENoYW8gSGFvIDxjaGFvLmhhb0BtZWRp
YXRlay5jb20+DQotLS0NCiBkcml2ZXJzL2lvbW11L210a19pb21tdS5jIHwgOCArKysrKystLQ0K
IGRyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmggfCAxICsNCiAyIGZpbGVzIGNoYW5nZWQsIDcgaW5z
ZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUv
bXRrX2lvbW11LmMgYi9kcml2ZXJzL2lvbW11L210a19pb21tdS5jDQppbmRleCBiZmZkNDE3ZjQ0
NDIuLmI2MTc4NWE4Nzc2NCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMN
CisrKyBiL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMNCkBAIC0zNyw2ICszNyw3IEBADQogI2Rl
ZmluZSBSRUdfTU1VX0lOVkxEX1NUQVJUX0EJCQkweDAyNA0KICNkZWZpbmUgUkVHX01NVV9JTlZM
RF9FTkRfQQkJCTB4MDI4DQogDQorI2RlZmluZSBSRUdfTU1VX0lOVl9TRUxfTVQ2Nzc5CQkJMHgw
MmMNCiAjZGVmaW5lIFJFR19NTVVfSU5WX1NFTAkJCQkweDAzOA0KICNkZWZpbmUgRl9JTlZMRF9F
TjAJCQkJQklUKDApDQogI2RlZmluZSBGX0lOVkxEX0VOMQkJCQlCSVQoMSkNCkBAIC0xNjUsNyAr
MTY2LDcgQEAgc3RhdGljIHZvaWQgbXRrX2lvbW11X3RsYl9mbHVzaF9hbGwodm9pZCAqY29va2ll
KQ0KIA0KIAlmb3JfZWFjaF9tNHUoZGF0YSkgew0KIAkJd3JpdGVsX3JlbGF4ZWQoRl9JTlZMRF9F
TjEgfCBGX0lOVkxEX0VOMCwNCi0JCQkgICAgICAgZGF0YS0+YmFzZSArIFJFR19NTVVfSU5WX1NF
TCk7DQorCQkJICAgICAgIGRhdGEtPmJhc2UgKyBkYXRhLT5wbGF0X2RhdGEtPmludl9zZWxfcmVn
KTsNCiAJCXdyaXRlbF9yZWxheGVkKEZfQUxMX0lOVkxELCBkYXRhLT5iYXNlICsgUkVHX01NVV9J
TlZBTElEQVRFKTsNCiAJCXdtYigpOyAvKiBNYWtlIHN1cmUgdGhlIHRsYiBmbHVzaCBhbGwgZG9u
ZSAqLw0KIAl9DQpAQCAtMTgyLDcgKzE4Myw3IEBAIHN0YXRpYyB2b2lkIG10a19pb21tdV90bGJf
Zmx1c2hfcmFuZ2Vfc3luYyh1bnNpZ25lZCBsb25nIGlvdmEsIHNpemVfdCBzaXplLA0KIAlmb3Jf
ZWFjaF9tNHUoZGF0YSkgew0KIAkJc3Bpbl9sb2NrX2lycXNhdmUoJmRhdGEtPnRsYl9sb2NrLCBm
bGFncyk7DQogCQl3cml0ZWxfcmVsYXhlZChGX0lOVkxEX0VOMSB8IEZfSU5WTERfRU4wLA0KLQkJ
CSAgICAgICBkYXRhLT5iYXNlICsgUkVHX01NVV9JTlZfU0VMKTsNCisJCQkgICAgICAgZGF0YS0+
YmFzZSArIGRhdGEtPnBsYXRfZGF0YS0+aW52X3NlbF9yZWcpOw0KIA0KIAkJd3JpdGVsX3JlbGF4
ZWQoaW92YSwgZGF0YS0+YmFzZSArIFJFR19NTVVfSU5WTERfU1RBUlRfQSk7DQogCQl3cml0ZWxf
cmVsYXhlZChpb3ZhICsgc2l6ZSAtIDEsDQpAQCAtNzgzLDYgKzc4NCw3IEBAIHN0YXRpYyBjb25z
dCBzdHJ1Y3QgbXRrX2lvbW11X3BsYXRfZGF0YSBtdDI3MTJfZGF0YSA9IHsNCiAJLmhhc19iY2xr
ICAgICA9IHRydWUsDQogCS5oYXNfdmxkX3BhX3JuZyAgID0gdHJ1ZSwNCiAJLmxhcmJpZF9yZW1h
cFswXSA9IHswLCAxLCAyLCAzLCA0LCA1LCA2LCA3LCA4LCA5fSwNCisJLmludl9zZWxfcmVnID0g
UkVHX01NVV9JTlZfU0VMLA0KIH07DQogDQogc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfaW9tbXVf
cGxhdF9kYXRhIG10ODE3M19kYXRhID0gew0KQEAgLTc5MSwxMiArNzkzLDE0IEBAIHN0YXRpYyBj
b25zdCBzdHJ1Y3QgbXRrX2lvbW11X3BsYXRfZGF0YSBtdDgxNzNfZGF0YSA9IHsNCiAJLmhhc19i
Y2xrICAgICA9IHRydWUsDQogCS5yZXNldF9heGkgICAgPSB0cnVlLA0KIAkubGFyYmlkX3JlbWFw
WzBdID0gezAsIDEsIDIsIDMsIDQsIDV9LCAvKiBMaW5lYXIgbWFwcGluZy4gKi8NCisJLmludl9z
ZWxfcmVnID0gUkVHX01NVV9JTlZfU0VMLA0KIH07DQogDQogc3RhdGljIGNvbnN0IHN0cnVjdCBt
dGtfaW9tbXVfcGxhdF9kYXRhIG10ODE4M19kYXRhID0gew0KIAkubTR1X3BsYXQgICAgID0gTTRV
X01UODE4MywNCiAJLnJlc2V0X2F4aSAgICA9IHRydWUsDQogCS5sYXJiaWRfcmVtYXBbMF0gPSB7
MCwgNCwgNSwgNiwgNywgMiwgMywgMX0sDQorCS5pbnZfc2VsX3JlZyA9IFJFR19NTVVfSU5WX1NF
TCwNCiB9Ow0KIA0KIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIG10a19pb21tdV9v
Zl9pZHNbXSA9IHsNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L210a19pb21tdS5oIGIvZHJp
dmVycy9pb21tdS9tdGtfaW9tbXUuaA0KaW5kZXggYzU4NTgxMWE5NTdjLi5lYzMwMTFhNTA3Mjgg
MTAwNjQ0DQotLS0gYS9kcml2ZXJzL2lvbW11L210a19pb21tdS5oDQorKysgYi9kcml2ZXJzL2lv
bW11L210a19pb21tdS5oDQpAQCAtNDMsNiArNDMsNyBAQCBzdHJ1Y3QgbXRrX2lvbW11X3BsYXRf
ZGF0YSB7DQogCWJvb2wgICAgICAgICAgICAgICAgaGFzX3ZsZF9wYV9ybmc7DQogCWJvb2wgICAg
ICAgICAgICAgICAgcmVzZXRfYXhpOw0KIAl1MzIgICAgICAgICAgICAgICAgIG00dTFfbWFzazsN
CisJdTMyICAgICAgICAgICAgICAgICBpbnZfc2VsX3JlZzsNCiAJdW5zaWduZWQgY2hhciAgICAg
ICBsYXJiaWRfcmVtYXBbMl1bTVRLX0xBUkJfTlJfTUFYXTsNCiB9Ow0KIA0KLS0gDQoyLjE4LjAN
Cg==

