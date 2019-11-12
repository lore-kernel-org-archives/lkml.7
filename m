Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81A50C17441
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 15:21:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3242321E6F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 15:21:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="aNg9ioEj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbfKLPVB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 10:21:01 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:6282 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726952AbfKLPVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 10:21:00 -0500
X-UUID: 52aaeee72103438fbe753863ec8e7517-20191112
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=00tgKT8PrLUAKPdNow52sT3g7JzrzlOSLvjva9U8+i4=;
        b=aNg9ioEjCTD/UuYmx8I4EXhlGq50s4f+4LuI+vC5bWHhtG48cfYoCBtno9Ajr0h99ttHRs+Quo6opAPXAJzhd5W/64euQwWYXsntYJvEa7I32kjrnZKFUoS8NXK1PzF3Bb2k9UdKHI1T+o/YMZpffUdob4Zihe7ll5WTNcQwzjU=;
X-UUID: 52aaeee72103438fbe753863ec8e7517-20191112
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <mark-pk.tsai@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 363594618; Tue, 12 Nov 2019 23:20:54 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 12 Nov 2019 23:20:52 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 12 Nov 2019 23:20:51 +0800
From:   Mark-PK Tsai <mark-pk.tsai@mediatek.com>
To:     <lvqiang.huang@unisoc.com>
CC:     <alix.wu@mediatek.com>, <allison@lohutok.net>,
        <eddy.lin@mediatek.com>, <enlai.chu@unisoc.com>,
        <gregkh@linuxfoundation.org>, <info@metux.net>,
        <kstewart@linuxfoundation.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux@armlinux.org.uk>,
        <mark-pk.tsai@mediatek.com>, <matthias.bgg@gmail.com>,
        <mike-sl.lin@mediatek.com>, <phil.chang@mediatek.com>,
        <tglx@linutronix.de>, <yj.chiang@mediatek.com>
Subject: Re: [PATCH] ARM: fix race in for_each_frame
Date:   Tue, 12 Nov 2019 23:20:51 +0800
Message-ID: <C1108AB0-9156-426F-A933-486B4F5C91CF@unisoc.com> (raw)
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20191112132937.19335-1-mark-pk.tsai@mediatek.com>
References: <C1108AB0-9156-426F-A933-486B4F5C91CF@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 9C74EC90DFF44018F894B585C421D81AFE7E4C3710BA51A8D0AC3CF6940C760F2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Message-ID: <20191112152051.gur8ZhacjNizFPYKxAfraODC1A4Nqi2IvZqY9UaTx7c@z>

DQo+IC4gMjAxOS4xMS4xMi4uMjE6MzEuTWFyay1QSyBUc2FpIDxtYXJrLXBrLnRzYWlAbWVkaWF0
ZWsuY29tPiAuLi4NCj4gDQo+IFRoZSBzdl9wYywgd2hpY2ggaXMgc2F2ZWQgaW4gdGhlIHN0YWNr
LCBtYXkgYmUgYW4gaW52YWxpZCBhZGRyZXNzDQo+IGlmIHRoZSB0YXJnZXQgdGhyZWFkIGlzIHJ1
bm5pbmcgb24gYW5vdGhlciBwcm9jZXNzb3IgaW4gdGhlIG1lYW50aW1lLg0KPiBJdCB3aWxsIGNh
dXNlIGtlcm5lbCBjcmFzaCBhdCBgbGRyIHIyLCBbc3ZfcGMsICMtNF1gLg0KPiANCj4gQ2hlY2sg
aWYgc3ZfcGMgaXMgdmFsaWQgYmVmb3JlIHVzZSBpdCBsaWtlIHVud2luZF9mcmFtZSBpbg0KPiBh
cmNoL2FybS9rZXJuZWwvdW53aW5kLmMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBNaWtlLVNMIExp
biA8bWlrZS1zbC5saW5AbWVkaWF0ZWsuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBNYXJrLVBLIFRz
YWkgPG1hcmstcGsudHNhaUBtZWRpYXRlay5jb20+DQo+IC0tLQ0KPiBhcmNoL2FybS9saWIvYmFj
a3RyYWNlLlMgfCA1ICsrKysrDQo+IDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKykNCj4g
DQo+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9saWIvYmFja3RyYWNlLlMgYi9hcmNoL2FybS9saWIv
YmFja3RyYWNlLlMNCj4gaW5kZXggNTgyOTI1MjM4ZDY1Li44NGYwNjM4MWJiZmIgMTAwNjQ0DQo+
IC0tLSBhL2FyY2gvYXJtL2xpYi9iYWNrdHJhY2UuUw0KPiArKysgYi9hcmNoL2FybS9saWIvYmFj
a3RyYWNlLlMNCj4gQEAgLTY0LDYgKzY0LDExIEBAIGZvcl9lYWNoX2ZyYW1lOiAgICB0c3QgICAg
ZnJhbWUsIG1hc2sgICAgICAgIEAgQ2hlY2sgZm9yIGFkZHJlc3MgZXhjZXB0aW9ucw0KPiAgICAg
ICAgc3ViICAgIHN2X3BjLCBzdl9wYywgb2Zmc2V0ICAgIEAgQ29ycmVjdCBQQyBmb3IgcHJlZmV0
Y2hpbmcNCj4gICAgICAgIGJpYyAgICBzdl9wYywgc3ZfcGMsIG1hc2sgICAgQCBtYXNrIFBDL0xS
IGZvciB0aGUgbW9kZQ0KPiANCj4gKyAgICAgICAgbW92ICAgIHIwLCBzdl9wYw0KPiArICAgICAg
ICBibCAgICBrZXJuZWxfdGV4dF9hZGRyZXNzICAgIEAgY2hlY2sgaWYgc3ZfcGMgaXMgdmFsaWQN
Cj4gKyAgICAgICAgY21wICAgIHIwLCAjMCAgICAgICAgICAgIEAgaWYgc3ZfcGMgaXMgbm90IGtl
cm5lbCB0ZXh0DQo+ICsgICAgICAgIGJlcSAgICAxMDA2ZiAgICAgICAgICAgIEAgYWRkcmVzcywg
YWJvcnQgYmFja3RyYWNlDQo+ICsNCg0KVGhlIHN2X3BjIGNhbiBiZSBhIGtlcm5lbCBtb2R1bGUg
dGV4dC4gDQoNClRoZSBtb2R1bGUgdGV4dCBhcmVhIGlzIG9rIGZvciBrZXJuZWxfdGV4dF9hZGRy
ZXNzKCkuDQoNCj4gMTAwMzogICAgICAgIGxkciAgICByMiwgW3N2X3BjLCAjLTRdICAgIEAgaWYg
c3RtZmQgc3AhLCB7YXJnc30gZXhpc3RzLA0KPiAgICAgICAgbGRyICAgIHIzLCAuTGRzaSs0ICAg
ICAgICBAIGFkanVzdCBzYXZlZCAncGMnIGJhY2sgb25lDQo+ICAgICAgICB0ZXEgICAgcjMsIHIy
LCBsc3IgIzExICAgICAgICBAIGluc3RydWN0aW9uDQo+IC0tIA0KPiAyLjE4LjA=

