Return-Path: <SRS0=Io4T=22=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B27F6C33C8C
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 10:46:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89C3D20866
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 10:46:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Ww6JLIeo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgAEKqk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jan 2020 05:46:40 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:2590 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726360AbgAEKqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 05:46:38 -0500
X-UUID: 5338576dd763456d810138b6743bd429-20200105
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=WZ/umlXOyPHUYCRi2U9EvlX0wVfU8S8+Ftnq58VNe5M=;
        b=Ww6JLIeodifH780mh1kn6g0ShhkKaZ9N7wOg/1n6rCumMsiSmbUd3ApICeVbbTevMGEg28fnWlszyfZ26PZmDx/2p4VFJHoUk5xpKsicHNgXB9Pm9CZiTtHHqeotjqAdqQIgXvF7Qr2jWjChlCJoZeIgUJs860ClYWI448JGoWs=;
X-UUID: 5338576dd763456d810138b6743bd429-20200105
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <chao.hao@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 866995537; Sun, 05 Jan 2020 18:46:31 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sun, 5 Jan 2020 18:46:05 +0800
Received: from localhost.localdomain (10.15.20.246) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sun, 5 Jan 2020 18:45:01 +0800
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
Subject: [PATCH v2 02/19] iommu/mediatek: Add m4u1_mask to distinguish m4u_id
Date:   Sun, 5 Jan 2020 18:45:06 +0800
Message-ID: <20200105104523.31006-3-chao.hao@mediatek.com>
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

Rm9yIHNvbWUgcGxhdGZvcm1zKGV4OiBsYXRlciBtdDY3NzkpLCBpdCBtYXliZSBoYXZlIHR3byBJ
T01NVXMsDQpzbyB3ZSBjYW4gYWRkIG00dV9tYXNrIHZhcmlhYmxlIHRvIGRpc3Rpbmd1aXNoIGl0
IGJ5IGRpZmZlcmVudA0Kc21pX2xhcmIgaWQNCg0KU2lnbmVkLW9mZi1ieTogQ2hhbyBIYW8gPGNo
YW8uaGFvQG1lZGlhdGVrLmNvbT4NCi0tLQ0KIGRyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMgfCAz
ICsrKw0KIGRyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmggfCAyICsrDQogMiBmaWxlcyBjaGFuZ2Vk
LCA1IGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11
LmMgYi9kcml2ZXJzL2lvbW11L210a19pb21tdS5jDQppbmRleCA2ZmMxZjVlY2Y5MWUuLjA5MTky
ZWRlZjFmNyAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMNCisrKyBiL2Ry
aXZlcnMvaW9tbXUvbXRrX2lvbW11LmMNCkBAIC02NzgsNiArNjc4LDkgQEAgc3RhdGljIGludCBt
dGtfaW9tbXVfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCiAJCX0NCiAJCWRh
dGEtPmxhcmJfaW11W2lkXS5kZXYgPSAmcGxhcmJkZXYtPmRldjsNCiANCisJCWlmIChkYXRhLT5w
bGF0X2RhdGEtPm00dTFfbWFzayA9PSAoMSA8PCBpZCkpDQorCQkJZGF0YS0+bTR1X2lkID0gMTsN
CisNCiAJCWNvbXBvbmVudF9tYXRjaF9hZGRfcmVsZWFzZShkZXYsICZtYXRjaCwgcmVsZWFzZV9v
ZiwNCiAJCQkJCSAgICBjb21wYXJlX29mLCBsYXJibm9kZSk7DQogCX0NCmRpZmYgLS1naXQgYS9k
cml2ZXJzL2lvbW11L210a19pb21tdS5oIGIvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuaA0KaW5k
ZXggZWE5NDlhMzI0ZTMzLi5iNGJkNzY1NDg2MTUgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2lvbW11
L210a19pb21tdS5oDQorKysgYi9kcml2ZXJzL2lvbW11L210a19pb21tdS5oDQpAQCAtNDIsNiAr
NDIsNyBAQCBzdHJ1Y3QgbXRrX2lvbW11X3BsYXRfZGF0YSB7DQogCWJvb2wgICAgICAgICAgICAg
ICAgaGFzX2JjbGs7DQogCWJvb2wgICAgICAgICAgICAgICAgaGFzX3ZsZF9wYV9ybmc7DQogCWJv
b2wgICAgICAgICAgICAgICAgcmVzZXRfYXhpOw0KKwl1MzIgICAgICAgICAgICAgICAgIG00dTFf
bWFzazsNCiAJdW5zaWduZWQgY2hhciAgICAgICBsYXJiaWRfcmVtYXBbTVRLX0xBUkJfTlJfTUFY
XTsNCiB9Ow0KIA0KQEAgLTU5LDYgKzYwLDcgQEAgc3RydWN0IG10a19pb21tdV9kYXRhIHsNCiAJ
Ym9vbCAgICAgICAgICAgICAgICAgICAgICAgICAgICBlbmFibGVfNEdCOw0KIAlzcGlubG9ja190
CQkJdGxiX2xvY2s7IC8qIGxvY2sgZm9yIHRsYiByYW5nZSBmbHVzaCAqLw0KIA0KKwl1MzIJCQkJ
bTR1X2lkOw0KIAlzdHJ1Y3QgaW9tbXVfZGV2aWNlCQlpb21tdTsNCiAJY29uc3Qgc3RydWN0IG10
a19pb21tdV9wbGF0X2RhdGEgKnBsYXRfZGF0YTsNCiANCi0tIA0KMi4xOC4wDQo=

