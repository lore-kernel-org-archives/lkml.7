Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 718B5C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 06:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F6D82084F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 06:53:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="K8jnYRkn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727504AbfKLGxX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 01:53:23 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:47194 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727031AbfKLGxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 01:53:21 -0500
X-UUID: 9fe46707aa4d41c0bda62169a4f3ff8d-20191112
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=Ehsd/rqNjquxYwB2rWRhuOLzczdbDyhLWsWEeWLWGxc=;
        b=K8jnYRkn+kZXk7AkDZvokwowUaom6Ffop8I4DcSwe3I3PW5aOvV0HVkSrcrYrg2Rcdd+Hvtx3PWF/H1DyeXVNVd1lv1EiKQTWcJjpripGcleWCcA9VS2xd0CupGpO+CVytVoxcMcZllgxp6+HQ5Uc9N2zERf0zHJimQGdZlxoYg=;
X-UUID: 9fe46707aa4d41c0bda62169a4f3ff8d-20191112
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw02.mediatek.com
        (envelope-from <walter-zh.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 2061064915; Tue, 12 Nov 2019 14:53:16 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 12 Nov 2019 14:53:14 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 12 Nov 2019 14:53:14 +0800
From:   Walter Wu <walter-zh.wu@mediatek.com>
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <kasan-dev@googlegroups.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        Walter Wu <walter-zh.wu@mediatek.com>
Subject: [PATCH v4 2/2] kasan: add test for invalid size in memmove
Date:   Tue, 12 Nov 2019 14:53:13 +0800
Message-ID: <20191112065313.7060-1-walter-zh.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGVzdCBuZWdhdGl2ZSBzaXplIGluIG1lbW1vdmUgaW4gb3JkZXIgdG8gdmVyaWZ5IHdoZXRoZXIg
aXQgY29ycmVjdGx5DQpnZXQgS0FTQU4gcmVwb3J0Lg0KDQpDYXN0aW5nIG5lZ2F0aXZlIG51bWJl
cnMgdG8gc2l6ZV90IHdvdWxkIGluZGVlZCB0dXJuIHVwIGFzIGEgbGFyZ2UNCnNpemVfdCwgc28g
aXQgd2lsbCBoYXZlIG91dC1vZi1ib3VuZHMgYnVnIGFuZCBiZSBkZXRlY3RlZCBieSBLQVNBTi4N
Cg0KU2lnbmVkLW9mZi1ieTogV2FsdGVyIFd1IDx3YWx0ZXItemgud3VAbWVkaWF0ZWsuY29tPg0K
UmV2aWV3ZWQtYnk6IERtaXRyeSBWeXVrb3YgPGR2eXVrb3ZAZ29vZ2xlLmNvbT4NCi0tLQ0KIGxp
Yi90ZXN0X2thc2FuLmMgfCAxOCArKysrKysrKysrKysrKysrKysNCiAxIGZpbGUgY2hhbmdlZCwg
MTggaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvbGliL3Rlc3Rfa2FzYW4uYyBiL2xpYi90
ZXN0X2thc2FuLmMNCmluZGV4IDQ5Y2M0ZDU3MGE0MC4uMDY5NDJjZjU4NWNjIDEwMDY0NA0KLS0t
IGEvbGliL3Rlc3Rfa2FzYW4uYw0KKysrIGIvbGliL3Rlc3Rfa2FzYW4uYw0KQEAgLTI4Myw2ICsy
ODMsMjMgQEAgc3RhdGljIG5vaW5saW5lIHZvaWQgX19pbml0IGttYWxsb2Nfb29iX2luX21lbXNl
dCh2b2lkKQ0KIAlrZnJlZShwdHIpOw0KIH0NCiANCitzdGF0aWMgbm9pbmxpbmUgdm9pZCBfX2lu
aXQga21hbGxvY19tZW1tb3ZlX2ludmFsaWRfc2l6ZSh2b2lkKQ0KK3sNCisJY2hhciAqcHRyOw0K
KwlzaXplX3Qgc2l6ZSA9IDY0Ow0KKw0KKwlwcl9pbmZvKCJpbnZhbGlkIHNpemUgaW4gbWVtbW92
ZVxuIik7DQorCXB0ciA9IGttYWxsb2Moc2l6ZSwgR0ZQX0tFUk5FTCk7DQorCWlmICghcHRyKSB7
DQorCQlwcl9lcnIoIkFsbG9jYXRpb24gZmFpbGVkXG4iKTsNCisJCXJldHVybjsNCisJfQ0KKw0K
KwltZW1zZXQoKGNoYXIgKilwdHIsIDAsIDY0KTsNCisJbWVtbW92ZSgoY2hhciAqKXB0ciwgKGNo
YXIgKilwdHIgKyA0LCAtMik7DQorCWtmcmVlKHB0cik7DQorfQ0KKw0KIHN0YXRpYyBub2lubGlu
ZSB2b2lkIF9faW5pdCBrbWFsbG9jX3VhZih2b2lkKQ0KIHsNCiAJY2hhciAqcHRyOw0KQEAgLTc3
Myw2ICs3OTAsNyBAQCBzdGF0aWMgaW50IF9faW5pdCBrbWFsbG9jX3Rlc3RzX2luaXQodm9pZCkN
CiAJa21hbGxvY19vb2JfbWVtc2V0XzQoKTsNCiAJa21hbGxvY19vb2JfbWVtc2V0XzgoKTsNCiAJ
a21hbGxvY19vb2JfbWVtc2V0XzE2KCk7DQorCWttYWxsb2NfbWVtbW92ZV9pbnZhbGlkX3NpemUo
KTsNCiAJa21hbGxvY191YWYoKTsNCiAJa21hbGxvY191YWZfbWVtc2V0KCk7DQogCWttYWxsb2Nf
dWFmMigpOw0KLS0gDQoyLjE4LjANCg==

