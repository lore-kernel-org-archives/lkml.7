Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 894A6C2D0CF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 05:40:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 569B3215A4
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 05:40:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="dkjyBgHX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbfLPFkO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 00:40:14 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:4522 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726181AbfLPFkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 00:40:14 -0500
X-UUID: c3d5781ffd744501a25a5760812467eb-20191216
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=bU3pTXiHaPfq2d8vyXK1ujCYPstVOHhLasLwvoHqrcE=;
        b=dkjyBgHX9GK+nfB9qN6gnzbjraaH9bQQgURwOUqdKMuVPklV8DipuYxS/VK9WkWbtrYZRm8SC2ZtcuqQOiBLTC/C6+3W1c2Vl97H5yDaoKQPCu8w8rzofK9xBzTQrHnGoxd43wRBEO5HLNvIBw0MpKlReBlYPTTIJyDsiLAP6Rw=;
X-UUID: c3d5781ffd744501a25a5760812467eb-20191216
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <biao.huang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 770036410; Mon, 16 Dec 2019 13:40:07 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 16 Dec 2019 13:40:28 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 16 Dec 2019 13:39:20 +0800
From:   Biao Huang <biao.huang@mediatek.com>
To:     <davem@davemloft.net>, Rob Herring <robh+dt@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>
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
Subject: [v2, PATCH 0/2] net-next: stmmac: dwmac-mediatek: add more support for RMII
Date:   Mon, 16 Dec 2019 13:39:56 +0800
Message-ID: <20191216053958.26130-1-biao.huang@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Y2hhbmdlcyBpbiB2MjoNCiBQQVRDSCAxLzIgbmV0LW5leHQ6IHN0bW1hYzogbWVkaWF0ZWs6IGFk
ZCBtb3JlIHN1cHBvcnQgZm9yIFJNSUkNCiAgICAgICAgQXMgQW5kcmV3J3MgY29tbWVudHMsIGFk
ZCB0aGUgInJtaWlfaW50ZXJuYWwiIGNsb2NrIHRvIHRoZSBsaXN0IG9mIGNsb2Nrcy4NCg0KIFBB
VENIIDIvMiBuZXQtbmV4dDogZHQtYmluZGluZzogZHdtYWMtbWVkaWF0ZWs6IGFkZCBtb3JlIGRl
c2NyaXB0aW9uIGZvciBSTUlJDQogICAgICAgIGRvY3VtZW50IHRoZSAicm1paV9pbnRlcm5hbCIg
Y2xvY2sgaW4gZHQtYmluZGluZ3MNCiAgICAgICAgcmV3cml0ZSB0aGUgc2FtcGxlIGR0cyBpbiBk
dC1iaW5kaW5ncy4NCg0KdjE6DQpUaGlzIHNlcmllcyBpcyBmb3Igc3VwcG9ydCBSTUlJIHdoZW4g
TVQyNzEyIFNvQyBwcm92aWRlcyB0aGUgcmVmZXJlbmNlIGNsb2NrLg0KDQpCaWFvIEh1YW5nICgy
KToNCiAgbmV0LW5leHQ6IHN0bW1hYzogbWVkaWF0ZWs6IGFkZCBtb3JlIHN1cHBvcnQgZm9yIFJN
SUkNCiAgbmV0LW5leHQ6IGR0LWJpbmRpbmc6IGR3bWFjLW1lZGlhdGVrOiBhZGQgbW9yZSBkZXNj
cmlwdGlvbiBmb3IgUk1JSQ0KDQogLi4uL2JpbmRpbmdzL25ldC9tZWRpYXRlay1kd21hYy50eHQg
ICAgICAgICAgIHwgMzMgKysrKy0tLQ0KIC4uLi9ldGhlcm5ldC9zdG1pY3JvL3N0bW1hYy9kd21h
Yy1tZWRpYXRlay5jICB8IDg5ICsrKysrKysrKysrKystLS0tLS0NCiAyIGZpbGVzIGNoYW5nZWQs
IDgzIGluc2VydGlvbnMoKyksIDM5IGRlbGV0aW9ucygtKQ0KDQotLQ0KMi4yNC4wDQoNCg==

