Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 319DDC2D0C6
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 02:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07AE72077B
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 02:42:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="KPsseFeJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbfLLCmJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 21:42:09 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:37207 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727756AbfLLCmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 21:42:08 -0500
X-UUID: 518e8e4ceec045a9853907919b5d8b2f-20191212
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=cG1YyDPw+qG1448MfGYrVaHuFejY1iS6sWsg1RBugiM=;
        b=KPsseFeJnx+VlY9vPDfCtreUBoEbgbYGNryNOu7MYUq1lU/rGPv3fOOLB5gPt3ZJk6hsEexkeWgSZ9bSJm5HTMvlVx+kmkRRaV4Cj2vmeeVHNXWX8zlylxpBVZ5eObaZRzNBa3+u9hUxDJnI3HOHiwUIInnElXvGtQ6BSYLRw+w=;
X-UUID: 518e8e4ceec045a9853907919b5d8b2f-20191212
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <biao.huang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 963971734; Thu, 12 Dec 2019 10:42:03 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 12 Dec 2019 10:42:33 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 12 Dec 2019 10:41:52 +0800
From:   Biao Huang <biao.huang@mediatek.com>
To:     <davem@davemloft.net>, Rob Herring <robh+dt@kernel.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Biao Huang <biao.huang@mediatek.com>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <yt.shen@mediatek.com>
Subject: [PATCH 0/2] net-next: stmmac: dwmac-mediatek: add more support for RMII
Date:   Thu, 12 Dec 2019 10:41:43 +0800
Message-ID: <20191212024145.21752-1-biao.huang@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBzZXJpZXMgaXMgZm9yIHN1cHBvcnQgUk1JSSB3aGVuIE1UMjcxMiBTb0MgcHJvdmlkZXMg
dGhlIHJlZmVyZW5jZSBjbG9jay4NCg0KQmlhbyBIdWFuZyAoMik6DQogIG5ldC1uZXh0OiBzdG1t
YWM6IG1lZGlhdGVrOiBhZGQgbW9yZSBzdXVwb3J0IGZvciBSTUlJDQogIG5ldC1uZXh0OiBkdC1i
aW5kaW5nOiBkd21hYy1tZWRpYXRlazogYWRkIG1vcmUgZGVzY3JpcHRpb24gZm9yIFJNSUkNCg0K
IC4uLi9iaW5kaW5ncy9uZXQvbWVkaWF0ZWstZHdtYWMudHh0ICAgICAgICAgICB8IDE3ICsrKy0N
CiAuLi4vZXRoZXJuZXQvc3RtaWNyby9zdG1tYWMvZHdtYWMtbWVkaWF0ZWsuYyAgfCA4NSArKysr
KysrKysrKysrLS0tLS0tDQogMiBmaWxlcyBjaGFuZ2VkLCA3NCBpbnNlcnRpb25zKCspLCAyOCBk
ZWxldGlvbnMoLSkNCg0KLS0NCjIuMjQuMA0KDQo=

