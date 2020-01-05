Return-Path: <SRS0=Io4T=22=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF307C33C9A
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 10:46:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6081207FD
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 10:46:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="VgznuY2l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbgAEKqg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jan 2020 05:46:36 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:42482 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725897AbgAEKqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 05:46:36 -0500
X-UUID: 203e6e9241554a088f4db1757d32f1b7-20200105
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=5wwx9zI1tNRihK2T3I1D2qJUFCK1MtGL2mDXTtoZpp8=;
        b=VgznuY2lEDk/TQh0Moc4gZ6TFqXdF9AB69olMhdi0x8V5gILcVQIxenSJOSV/W/Jw1GoivQ25cIO57D/fiGTynCFP4SK0HidvqtAncp9auIfGpeZSefLTl6bSZQpTRQSail3nNVhNFodftubJR+GpsQawUXYBIknsxopjSzfpZA=;
X-UUID: 203e6e9241554a088f4db1757d32f1b7-20200105
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <chao.hao@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 387808072; Sun, 05 Jan 2020 18:46:33 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sun, 5 Jan 2020 18:46:06 +0800
Received: from localhost.localdomain (10.15.20.246) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sun, 5 Jan 2020 18:45:03 +0800
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
Subject: [PATCH v2 03/19] iommu/mediatek: Extend larb_remap to larb_remap[2]
Date:   Sun, 5 Jan 2020 18:45:07 +0800
Message-ID: <20200105104523.31006-4-chao.hao@mediatek.com>
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

Rm9yIG1vcmUgdGhhbiBvbmUgSU9NTVVzLCB0aGV5IGFyZSBjb3JyZXNwb25kaW5nIHRvIGRpZmZl
cmVudA0Kc21pX2xhcmIgaWQsIHNvIHdlIG5lZWQgdG8gZXh0ZW5kIGxhcmJfcmVtYXAgdG8gbGFy
Yl9yZW1hcFsyXQ0KdG8gZGlzdGluZ3Vpc2ggaXQgYnkgaW5kZXguDQoNClNpZ25lZC1vZmYtYnk6
IENoYW8gSGFvIDxjaGFvLmhhb0BtZWRpYXRlay5jb20+DQotLS0NCiBkcml2ZXJzL2lvbW11L210
a19pb21tdS5jIHwgOCArKysrLS0tLQ0KIGRyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmggfCAyICst
DQogMiBmaWxlcyBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQoNCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L210a19pb21tdS5jIGIvZHJpdmVycy9pb21tdS9tdGtf
aW9tbXUuYw0KaW5kZXggMDkxOTJlZGVmMWY3Li5mMmQ5NTNmYzA5ZGYgMTAwNjQ0DQotLS0gYS9k
cml2ZXJzL2lvbW11L210a19pb21tdS5jDQorKysgYi9kcml2ZXJzL2lvbW11L210a19pb21tdS5j
DQpAQCAtMjQ1LDcgKzI0NSw3IEBAIHN0YXRpYyBpcnFyZXR1cm5fdCBtdGtfaW9tbXVfaXNyKGlu
dCBpcnEsIHZvaWQgKmRldl9pZCkNCiAJZmF1bHRfbGFyYiA9IEZfTU1VX0lOVF9JRF9MQVJCX0lE
KHJlZ3ZhbCk7DQogCWZhdWx0X3BvcnQgPSBGX01NVV9JTlRfSURfUE9SVF9JRChyZWd2YWwpOw0K
IA0KLQlmYXVsdF9sYXJiID0gZGF0YS0+cGxhdF9kYXRhLT5sYXJiaWRfcmVtYXBbZmF1bHRfbGFy
Yl07DQorCWZhdWx0X2xhcmIgPSBkYXRhLT5wbGF0X2RhdGEtPmxhcmJpZF9yZW1hcFtkYXRhLT5t
NHVfaWRdW2ZhdWx0X2xhcmJdOw0KIA0KIAlpZiAocmVwb3J0X2lvbW11X2ZhdWx0KCZkb20tPmRv
bWFpbiwgZGF0YS0+ZGV2LCBmYXVsdF9pb3ZhLA0KIAkJCSAgICAgICB3cml0ZSA/IElPTU1VX0ZB
VUxUX1dSSVRFIDogSU9NTVVfRkFVTFRfUkVBRCkpIHsNCkBAIC03ODIsNyArNzgyLDcgQEAgc3Rh
dGljIGNvbnN0IHN0cnVjdCBtdGtfaW9tbXVfcGxhdF9kYXRhIG10MjcxMl9kYXRhID0gew0KIAku
aGFzXzRnYl9tb2RlID0gdHJ1ZSwNCiAJLmhhc19iY2xrICAgICA9IHRydWUsDQogCS5oYXNfdmxk
X3BhX3JuZyAgID0gdHJ1ZSwNCi0JLmxhcmJpZF9yZW1hcCA9IHswLCAxLCAyLCAzLCA0LCA1LCA2
LCA3LCA4LCA5fSwNCisJLmxhcmJpZF9yZW1hcFswXSA9IHswLCAxLCAyLCAzLCA0LCA1LCA2LCA3
LCA4LCA5fSwNCiB9Ow0KIA0KIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2lvbW11X3BsYXRfZGF0
YSBtdDgxNzNfZGF0YSA9IHsNCkBAIC03OTAsMTMgKzc5MCwxMyBAQCBzdGF0aWMgY29uc3Qgc3Ry
dWN0IG10a19pb21tdV9wbGF0X2RhdGEgbXQ4MTczX2RhdGEgPSB7DQogCS5oYXNfNGdiX21vZGUg
PSB0cnVlLA0KIAkuaGFzX2JjbGsgICAgID0gdHJ1ZSwNCiAJLnJlc2V0X2F4aSAgICA9IHRydWUs
DQotCS5sYXJiaWRfcmVtYXAgPSB7MCwgMSwgMiwgMywgNCwgNX0sIC8qIExpbmVhciBtYXBwaW5n
LiAqLw0KKwkubGFyYmlkX3JlbWFwWzBdID0gezAsIDEsIDIsIDMsIDQsIDV9LCAvKiBMaW5lYXIg
bWFwcGluZy4gKi8NCiB9Ow0KIA0KIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2lvbW11X3BsYXRf
ZGF0YSBtdDgxODNfZGF0YSA9IHsNCiAJLm00dV9wbGF0ICAgICA9IE00VV9NVDgxODMsDQogCS5y
ZXNldF9heGkgICAgPSB0cnVlLA0KLQkubGFyYmlkX3JlbWFwID0gezAsIDQsIDUsIDYsIDcsIDIs
IDMsIDF9LA0KKwkubGFyYmlkX3JlbWFwWzBdID0gezAsIDQsIDUsIDYsIDcsIDIsIDMsIDF9LA0K
IH07DQogDQogc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgbXRrX2lvbW11X29mX2lk
c1tdID0gew0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmggYi9kcml2ZXJz
L2lvbW11L210a19pb21tdS5oDQppbmRleCBiNGJkNzY1NDg2MTUuLmM1ODU4MTFhOTU3YyAxMDA2
NDQNCi0tLSBhL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmgNCisrKyBiL2RyaXZlcnMvaW9tbXUv
bXRrX2lvbW11LmgNCkBAIC00Myw3ICs0Myw3IEBAIHN0cnVjdCBtdGtfaW9tbXVfcGxhdF9kYXRh
IHsNCiAJYm9vbCAgICAgICAgICAgICAgICBoYXNfdmxkX3BhX3JuZzsNCiAJYm9vbCAgICAgICAg
ICAgICAgICByZXNldF9heGk7DQogCXUzMiAgICAgICAgICAgICAgICAgbTR1MV9tYXNrOw0KLQl1
bnNpZ25lZCBjaGFyICAgICAgIGxhcmJpZF9yZW1hcFtNVEtfTEFSQl9OUl9NQVhdOw0KKwl1bnNp
Z25lZCBjaGFyICAgICAgIGxhcmJpZF9yZW1hcFsyXVtNVEtfTEFSQl9OUl9NQVhdOw0KIH07DQog
DQogc3RydWN0IG10a19pb21tdV9kb21haW47DQotLSANCjIuMTguMA0K

