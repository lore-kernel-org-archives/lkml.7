Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAE78C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 01:54:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFC612075A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 01:54:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="ctaH3Z5V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbfKUByb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 20:54:31 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:23328 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726333AbfKUByX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 20:54:23 -0500
X-UUID: 93c338ae4cec4cc39812cddf99fe3f32-20191121
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=eNc1q+Jm+ke51V5X9loIt4L2ckyzxIUn7oSSInk3fLI=;
        b=ctaH3Z5Vs7F7wKL3GCd+LW7C4GRIcJOuOdUxlKnd6hxHs6vav44yD6tWIFKjS1yPwZiB0RqzFlGwRvucTAccVkexi9ANuGX94jv9FFlMJeDH3qIL0thcyj38f/pOmOJXQu22gOUJO2tqh2GCXE2vYa47PyiyWWE6/Z+8inZT/bo=;
X-UUID: 93c338ae4cec4cc39812cddf99fe3f32-20191121
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <bibby.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 285830125; Thu, 21 Nov 2019 09:54:13 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 21 Nov 2019 09:54:07 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 21 Nov 2019 09:54:16 +0800
From:   Bibby Hsieh <bibby.hsieh@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, CK HU <ck.hu@mediatek.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Dennis-YC Hsieh <dennis-yc.hsieh@mediatek.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>
Subject: [PATCH v17 0/6] support gce on mt8183 platform
Date:   Thu, 21 Nov 2019 09:54:04 +0800
Message-ID: <20191121015410.18852-1-bibby.hsieh@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Q2hhbmdlcyBzaW5jZSB2MTY6DQogLSBuYW1pbmcgdGhlIHBvbGwgbWFzayBlbmFibGUgYml0DQog
LSBhZGQgYSBwYXRjaCB0byBmaXVwIHRoZSBpbnB1dCBvcmRlciBvZiB3cml0ZSBhcGkNCg0KQ2hh
bmdlcyBzaW5jZSB2MTU6DQogLSByZWJhc2Ugb250byA1LjQtcmMxDQogLSByb2xsYmFjayB0aGUg
djE0IGNoYW5nZQ0KIC0gYWRkIGEgcGF0Y2ggdG8gZml4dXAgdGhlIGNvbWJpbmF0aW9uIG9mIHJl
dHVybiB2YWx1ZQ0KDQpDaGFuZ2VzIHNpbmNlIHYxNDoNCiAtIGNoYW5nZSBpbnB1dCBhcmd1bWVu
dCBhcyBwb2ludGVyIGluIGFwcGVuZF9jb21tZW5kKCkNCg0KQ2hhbmdlcyBzaW5jZSB2MTM6DQog
LSBzZXBhcmF0ZSBwb2xsIGZ1bmN0aW9uIGFzIHBvbGwgdy8gJiB3L28gbWFzayBmdW5jdGlvbg0K
IC0gZGlyZWN0bHkgcGFzcyBpbnN0IGludG8gYXBwZW5kX2NvbW1hbmQgZnVuY3Rpb24gaW5zdGVh
ZA0KICAgb2YgcmV0dXJucyBhIHBvaW50ZXINCiAtIGZpeHVwIGNvZGluZyBzdHlsZQ0KIC0gcmVi
YXNlIG9udG8gNS4zLXJjMQ0KDQpbLi4uIHNuaXAgLi4uXQ0KDQpCaWJieSBIc2llaCAoNik6DQog
IHNvYzogbWVkaWF0ZWs6IGNtZHE6IGZpeHVwIHdyb25nIGlucHV0IG9yZGVyIG9mIHdyaXRlIGFw
aQ0KICBzb2M6IG1lZGlhdGVrOiBjbWRxOiByZW1vdmUgT1Igb3BlcnRhaW9uIGZyb20gZXJyIHJl
dHVybg0KICBzb2M6IG1lZGlhdGVrOiBjbWRxOiBkZWZpbmUgdGhlIGluc3RydWN0aW9uIHN0cnVj
dA0KICBzb2M6IG1lZGlhdGVrOiBjbWRxOiBhZGQgcG9sbGluZyBmdW5jdGlvbg0KICBzb2M6IG1l
ZGlhdGVrOiBjbWRxOiBhZGQgY21kcV9kZXZfZ2V0X2NsaWVudF9yZWcgZnVuY3Rpb24NCiAgYXJt
NjQ6IGR0czogYWRkIGdjZSBub2RlIGZvciBtdDgxODMNCg0KIGFyY2gvYXJtNjQvYm9vdC9kdHMv
bWVkaWF0ZWsvbXQ4MTgzLmR0c2kgfCAgMTAgKysNCiBkcml2ZXJzL3NvYy9tZWRpYXRlay9tdGst
Y21kcS1oZWxwZXIuYyAgIHwgMTQ3ICsrKysrKysrKysrKysrKysrKystLS0tDQogaW5jbHVkZS9s
aW51eC9tYWlsYm94L210ay1jbWRxLW1haWxib3guaCB8ICAxMSArKw0KIGluY2x1ZGUvbGludXgv
c29jL21lZGlhdGVrL210ay1jbWRxLmggICAgfCAgNTMgKysrKysrKysNCiA0IGZpbGVzIGNoYW5n
ZWQsIDE5NSBpbnNlcnRpb25zKCspLCAyNiBkZWxldGlvbnMoLSkNCg0KLS0gDQoyLjE4LjANCg==

