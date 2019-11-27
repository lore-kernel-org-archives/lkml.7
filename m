Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7132C43215
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 02:00:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD91B207DD
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 02:00:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="kYnvSS84"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727356AbfK0CAB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 21:00:01 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:27971 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727205AbfK0B7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 20:59:20 -0500
X-UUID: 587fa98754904267810c92888469dde6-20191127
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=2EUYRdJJB+6C4Vcp34YJqDRjMB/hWvRZnXFUMAZXaXk=;
        b=kYnvSS84dyY9HInuNHI/VyG4C8PkxCK0KBzc8qaaOYsQHPXp07SOdEuaEwqy7hlvSM6DhmvfvqhDCjoKiHTPWDbLMypf4bRuBVNxFsYd3RlasD624g9ryiPgyDYeovBb4VldIpsNvVN5ohCiyjjxkuu94WpaLxwpmfh0ExxV8Rw=;
X-UUID: 587fa98754904267810c92888469dde6-20191127
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <dennis-yc.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 304460913; Wed, 27 Nov 2019 09:59:10 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 27 Nov 2019 09:58:43 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 27 Nov 2019 09:58:18 +0800
From:   Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        CK Hu <ck.hu@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>
Subject: [PATCH v2 00/14] support gce on mt6779 platform
Date:   Wed, 27 Nov 2019 09:58:43 +0800
Message-ID: <1574819937-6246-2-git-send-email-dennis-yc.hsieh@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1574819937-6246-1-git-send-email-dennis-yc.hsieh@mediatek.com>
References: <1574819937-6246-1-git-send-email-dennis-yc.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 7B38D6324E116F0119907231B5DDCEFEC8E43DE7EA718D521028080F857EBEFB2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KioqIEJMVVJCIEhFUkUgKioqDQoNCkRlbm5pcyBZQyBIc2llaCAoMTQpOg0KICBkdC1iaW5kaW5n
OiBnY2U6IGFkZCBnY2UgaGVhZGVyIGZpbGUgZm9yIG10Njc3OQ0KICBtYWlsYm94OiBjbWRxOiB2
YXJpYWJsaXplIGFkZHJlc3Mgc2hpZnQgaW4gcGxhdGZvcm0NCiAgbWFpbGJveDogY21kcTogc3Vw
cG9ydCBtdDY3NzkgZ2NlIHBsYXRmb3JtIGRlZmluaXRpb24NCiAgbWFpbGJveDogbWVkaWF0ZWs6
IGNtZHE6IGNsZWFyIHRhc2sgaW4gY2hhbm5lbCBiZWZvcmUgc2h1dGRvd24NCiAgYXJtNjQ6IGR0
czogYWRkIGdjZSBub2RlIGZvciBtdDY3NzkNCiAgc29jOiBtZWRpYXRlazogY21kcTogcmV0dXJu
IHNlbmQgbXNnIGVycm9yIGNvZGUNCiAgc29jOiBtZWRpYXRlazogY21kcTogYWRkIGFzc2lnbiBm
dW5jdGlvbg0KICBzb2M6IG1lZGlhdGVrOiBjbWRxOiBhZGQgd3JpdGVfcyBmdW5jdGlvbg0KICBz
b2M6IG1lZGlhdGVrOiBjbWRxOiBhZGQgcmVhZF9zIGZ1bmN0aW9uDQogIHNvYzogbWVkaWF0ZWs6
IGNtZHE6IGFkZCB3cml0ZV9zIHZhbHVlIGZ1bmN0aW9uDQogIHNvYzogbWVkaWF0ZWs6IGNtZHE6
IGV4cG9ydCBmaW5hbGl6ZSBmdW5jdGlvbg0KICBzb2M6IG1lZGlhdGVrOiBjbWRxOiBhZGQgbG9v
cCBmdW5jdGlvbg0KICBzb2M6IG1lZGlhdGVrOiBjbWRxOiBhZGQgd2FpdCBubyBjbGVhciBldmVu
dCBmdW5jdGlvbg0KICBzb2M6IG1lZGlhdGVrOiBjbWRxOiBhZGQgc2V0IGV2ZW50IGZ1bmN0aW9u
DQoNCiAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9tYWlsYm94L210ay1nY2UudHh0ICAgfCAgIDgg
Ky0NCiBhcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210Njc3OS5kdHNpICAgICAgfCAgMTAg
Kw0KIGRyaXZlcnMvbWFpbGJveC9tdGstY21kcS1tYWlsYm94LmMgICAgICAgICAgICB8ICA4NSAr
KysrKystDQogZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMgICAgICAgIHwg
MTgxICsrKysrKysrKysrKystDQogaW5jbHVkZS9kdC1iaW5kaW5ncy9nY2UvbXQ2Nzc5LWdjZS5o
ICAgICAgICAgIHwgMjIyICsrKysrKysrKysrKysrKysrKw0KIGluY2x1ZGUvbGludXgvbWFpbGJv
eC9tdGstY21kcS1tYWlsYm94LmggICAgICB8ICAgNyArDQogaW5jbHVkZS9saW51eC9zb2MvbWVk
aWF0ZWsvbXRrLWNtZHEuaCAgICAgICAgIHwgIDg3ICsrKysrKysNCiA3IGZpbGVzIGNoYW5nZWQs
IDU3NSBpbnNlcnRpb25zKCspLCAyNSBkZWxldGlvbnMoLSkNCiBjcmVhdGUgbW9kZSAxMDA2NDQg
aW5jbHVkZS9kdC1iaW5kaW5ncy9nY2UvbXQ2Nzc5LWdjZS5oDQoNCi0tIA0KMi4xOC4wDQo=

