Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB03EC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 13:31:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 878D42084F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 13:31:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="l/h8OgTb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727220AbfKLNbM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 08:31:12 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:60967 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726979AbfKLNbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 08:31:12 -0500
X-UUID: fa344ab78da246fd9d8c411a4751c8c0-20191112
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=hT9QBdG+LtUKaBpt4OHfKg/vmDyoLlBwacPEIY+C38w=;
        b=l/h8OgTbd9GX8WRcOrFoOu5PNXuzU9akznAB+2X9v2vhclOHI9JXoWV22TJ2xaskjLvfXHqDOvFOha6ZswtjU59oB6GJh6f7GDMPSp1nD/0RQZCMZ13ZIdpChBvf1tyNva4W7ugamIWh8uZOj1w8SV4/VNqGUjqWuIflcZddpZQ=;
X-UUID: fa344ab78da246fd9d8c411a4751c8c0-20191112
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <mark-pk.tsai@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1889015713; Tue, 12 Nov 2019 21:31:02 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 12 Nov 2019 21:31:00 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 12 Nov 2019 21:31:00 +0800
From:   Mark-PK Tsai <mark-pk.tsai@mediatek.com>
To:     <linux@armlinux.org.uk>
CC:     <matthias.bgg@gmail.com>, <kstewart@linuxfoundation.org>,
        <allison@lohutok.net>, <lvqiang.huang@unisoc.com>,
        <gregkh@linuxfoundation.org>, <info@metux.net>,
        <tglx@linutronix.de>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <yj.chiang@mediatek.com>,
        <mark-pk.tsai@mediatek.com>, <alix.wu@mediatek.com>,
        <mike-sl.lin@mediatek.com>, <eddy.lin@mediatek.com>,
        <phil.chang@mediatek.com>
Subject: [PATCH] ARM: fix race in for_each_frame
Date:   Tue, 12 Nov 2019 21:29:38 +0800
Message-ID: <20191112132937.19335-1-mark-pk.tsai@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 323926A5FB2DE832EA31753876BD697D6E80BA9E1623AE50FC1C3E17F6D5373C2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlIHN2X3BjLCB3aGljaCBpcyBzYXZlZCBpbiB0aGUgc3RhY2ssIG1heSBiZSBhbiBpbnZhbGlk
IGFkZHJlc3MNCmlmIHRoZSB0YXJnZXQgdGhyZWFkIGlzIHJ1bm5pbmcgb24gYW5vdGhlciBwcm9j
ZXNzb3IgaW4gdGhlIG1lYW50aW1lLg0KSXQgd2lsbCBjYXVzZSBrZXJuZWwgY3Jhc2ggYXQgYGxk
ciByMiwgW3N2X3BjLCAjLTRdYC4NCg0KQ2hlY2sgaWYgc3ZfcGMgaXMgdmFsaWQgYmVmb3JlIHVz
ZSBpdCBsaWtlIHVud2luZF9mcmFtZSBpbg0KYXJjaC9hcm0va2VybmVsL3Vud2luZC5jLg0KDQpT
aWduZWQtb2ZmLWJ5OiBNaWtlLVNMIExpbiA8bWlrZS1zbC5saW5AbWVkaWF0ZWsuY29tPg0KU2ln
bmVkLW9mZi1ieTogTWFyay1QSyBUc2FpIDxtYXJrLXBrLnRzYWlAbWVkaWF0ZWsuY29tPg0KLS0t
DQogYXJjaC9hcm0vbGliL2JhY2t0cmFjZS5TIHwgNSArKysrKw0KIDEgZmlsZSBjaGFuZ2VkLCA1
IGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2xpYi9iYWNrdHJhY2UuUyBi
L2FyY2gvYXJtL2xpYi9iYWNrdHJhY2UuUw0KaW5kZXggNTgyOTI1MjM4ZDY1Li44NGYwNjM4MWJi
ZmIgMTAwNjQ0DQotLS0gYS9hcmNoL2FybS9saWIvYmFja3RyYWNlLlMNCisrKyBiL2FyY2gvYXJt
L2xpYi9iYWNrdHJhY2UuUw0KQEAgLTY0LDYgKzY0LDExIEBAIGZvcl9lYWNoX2ZyYW1lOgl0c3QJ
ZnJhbWUsIG1hc2sJCUAgQ2hlY2sgZm9yIGFkZHJlc3MgZXhjZXB0aW9ucw0KIAkJc3ViCXN2X3Bj
LCBzdl9wYywgb2Zmc2V0CUAgQ29ycmVjdCBQQyBmb3IgcHJlZmV0Y2hpbmcNCiAJCWJpYwlzdl9w
Yywgc3ZfcGMsIG1hc2sJQCBtYXNrIFBDL0xSIGZvciB0aGUgbW9kZQ0KIA0KKwkJbW92CXIwLCBz
dl9wYw0KKwkJYmwJa2VybmVsX3RleHRfYWRkcmVzcwlAIGNoZWNrIGlmIHN2X3BjIGlzIHZhbGlk
DQorCQljbXAJcjAsICMwCQkJQCBpZiBzdl9wYyBpcyBub3Qga2VybmVsIHRleHQNCisJCWJlcQkx
MDA2ZgkJCUAgYWRkcmVzcywgYWJvcnQgYmFja3RyYWNlDQorDQogMTAwMzoJCWxkcglyMiwgW3N2
X3BjLCAjLTRdCUAgaWYgc3RtZmQgc3AhLCB7YXJnc30gZXhpc3RzLA0KIAkJbGRyCXIzLCAuTGRz
aSs0CQlAIGFkanVzdCBzYXZlZCAncGMnIGJhY2sgb25lDQogCQl0ZXEJcjMsIHIyLCBsc3IgIzEx
CQlAIGluc3RydWN0aW9uDQotLSANCjIuMTguMA0K

