Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61BDAC17443
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 06:51:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28F2A21783
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 06:51:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="J9nHo+XK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbfKKGvm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 01:51:42 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:48916 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726785AbfKKGvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 01:51:41 -0500
X-UUID: 80a7be139c414cc08cfec1efc5c1d8c2-20191111
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=1NPMi5s0B7PLycleggl/Ct6ul55hyyE2HzaKv33AkXA=;
        b=J9nHo+XK+ak6jlO69eM+HHcJwe15+MNuWYckGI0u1iPzmQS1DQjhRu3jSU7RlprLxnn1oU6TiKAQCZTkdnmafk3CaQIFDeFRYEAn9vCaPX7e0dp4QdRI2MfjrTT4lGomFEPbNaz3vnpLWzWD0NGMLLyICmymfYKDDEyOMirb5gc=;
X-UUID: 80a7be139c414cc08cfec1efc5c1d8c2-20191111
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <mark-mc.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 44719251; Mon, 11 Nov 2019 14:51:31 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 11 Nov 2019 14:51:28 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 11 Nov 2019 14:51:28 +0800
From:   MarkLee <Mark-MC.Lee@mediatek.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Sean Wang <sean.wang@mediatek.com>,
        John Crispin <john@phrozen.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rene van Dorst <opensource@vdorst.com>,
        <devicetree@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        MarkLee <Mark-MC.Lee@mediatek.com>
Subject: [PATCH net,v2 0/3]  Rework mt762x GDM setup flow
Date:   Mon, 11 Nov 2019 14:51:26 +0800
Message-ID: <20191111065129.30078-1-Mark-MC.Lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlIG10NzYyeCBHRE0gYmxvY2sgaXMgbWFpbmx5IHVzZWQgdG8gc2V0dXAgdGhlIEhXIGludGVy
bmFsDQpyeCBwYXRoIGZyb20gR01BQyB0byBSWCBETUEgZW5naW5lKFBETUEpIGFuZCB0aGUgcGFj
a2V0DQpzd2l0Y2hpbmcgZW5naW5lKFBTRSkgaXMgcmVzcG9uc2VkIHRvIGRvIHRoZSBkYXRhIGZv
cndhcmQNCmZvbGxvd2luZyB0aGUgR0RNIGNvbmZpZ3VyYXRpb24uDQoNClRoaXMgcGF0Y2ggc2V0
IGhhdmUgdGhyZWUgZ29hbHMgOg0KDQoxLiBJbnRlZ3JhdGUgR0RNL1BTRSBzZXR1cCBvcGVyYXRp
b25zIGludG8gc2luZ2xlIGZ1bmN0aW9uICJtdGtfZ2RtX2NvbmZpZyINCg0KMi4gUmVmaW5lIHRo
ZSB0aW1pbmcgb2YgR0RNL1BTRSBzZXR1cCwgbW92ZSBpdCBmcm9tIG10a19od19pbml0IA0KICAg
dG8gbXRrX29wZW4NCg0KMy4gRW5hYmxlIEdETSBHRE1BX0RST1BfQUxMIG1vZGUgdG8gZHJvcCBh
bGwgcGFja2V0IGR1cmluZyB0aGUgDQogICBzdG9wIG9wZXJhdGlvbg0KDQpNYXJrTGVlICgzKToN
CiAgbmV0OiBldGhlcm5ldDogbWVkaWF0ZWs6IEludGVncmF0ZSBHRE0vUFNFIHNldHVwIG9wZXJh
dGlvbnMNCiAgbmV0OiBldGhlcm5ldDogbWVkaWF0ZWs6IFJlZmluZSB0aGUgdGltaW5nIG9mIEdE
TS9QU0Ugc2V0dXANCiAgbmV0OiBldGhlcm5ldDogbWVkaWF0ZWs6IEVuYWJsZSBHRE0gR0RNQV9E
Uk9QX0FMTCBtb2RlDQoNCiBkcml2ZXJzL25ldC9ldGhlcm5ldC9tZWRpYXRlay9tdGtfZXRoX3Nv
Yy5jIHwgNDQgKysrKysrKysrKysrKystLS0tLS0tDQogZHJpdmVycy9uZXQvZXRoZXJuZXQvbWVk
aWF0ZWsvbXRrX2V0aF9zb2MuaCB8ICAyICsNCiAyIGZpbGVzIGNoYW5nZWQsIDMxIGluc2VydGlv
bnMoKyksIDE1IGRlbGV0aW9ucygtKQ0KDQotLSANCjIuMTcuMQ0K

