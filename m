Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54DA3C17441
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 06:52:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 296882084F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 06:52:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="SkP0IbH/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbfKLGwf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 01:52:35 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:7405 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725847AbfKLGwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 01:52:34 -0500
X-UUID: 76bf00009fdb47c4a0739cb4a74a6ebf-20191112
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=wdSA5MhsOB9Ng3BYMmOZcpPo2w0m19TKE7PUEysk4/I=;
        b=SkP0IbH/QLcjU2jsExzjgYU1k9VtsALKCJE6i0+bOJ8il7W+JBAO8INgUqhoW5yd2xMYC9HyydvrOQ/MwMsEC7auD6Kw6wxkn7bcxQnEBO7aOPvbrFEqjQsqEl2xZYVHAhBCOgPGhwJxn49M3rbWF5sSUqJbNc10PDUuIHpE8eM=;
X-UUID: 76bf00009fdb47c4a0739cb4a74a6ebf-20191112
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <walter-zh.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 139208525; Tue, 12 Nov 2019 14:52:28 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 12 Nov 2019 14:52:25 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 12 Nov 2019 14:52:26 +0800
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
Subject: [PATCH v4 0/2] fix the missing underflow in memory operation function
Date:   Tue, 12 Nov 2019 14:52:25 +0800
Message-ID: <20191112065225.6971-1-walter-zh.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlIHBhdGNoc2V0cyBoZWxwIHRvIHByb2R1Y2UgS0FTQU4gcmVwb3J0IHdoZW4gc2l6ZSBpcyBu
ZWdhdGl2ZSBudW1iZXJzDQppbiBtZW1vcnkgb3BlcmF0aW9uIGZ1bmN0aW9uLiBJdCBpcyBoZWxw
ZnVsIGZvciBwcm9ncmFtbWVyIHRvIHNvbHZlIHRoZSANCnVuZGVmaW5lZCBiZWhhdmlvciBpc3N1
ZS4gUGF0Y2ggMSBiYXNlZCBvbiBEbWl0cnkncyByZXZpZXcgYW5kDQpzdWdnZXN0aW9uLCBwYXRj
aCAyIGlzIGEgdGVzdCBpbiBvcmRlciB0byB2ZXJpZnkgdGhlIHBhdGNoIDEuIA0KDQpbMV1odHRw
czovL2J1Z3ppbGxhLmtlcm5lbC5vcmcvc2hvd19idWcuY2dpP2lkPTE5OTM0MSANClsyXWh0dHBz
Oi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWFybS1rZXJuZWwvMjAxOTA5MjcwMzQzMzguMTU4MTMt
MS13YWx0ZXItemgud3VAbWVkaWF0ZWsuY29tLyANCg0KV2FsdGVyIFd1ICgyKTogDQprYXNhbjog
ZGV0ZWN0IG5lZ2F0aXZlIHNpemUgaW4gbWVtb3J5IG9wZXJhdGlvbiBmdW5jdGlvbiANCmthc2Fu
OiBhZGQgdGVzdCBmb3IgaW52YWxpZCBzaXplIGluIG1lbW1vdmUNCi0tLQ0KQ2hhbmdlcyBpbiB2
MjoNCmZpeCB0aGUgaW5kZW50YXRpb24sIHRoYW5rcyBmb3IgdGhlIHJlbWluZGVyIE1hdHRoZXcu
DQoNCkNoYW5nZXMgaW4gdjM6DQpBZGQgYSBjb25maXRpb24gZm9yIG1lbW9yeSBvcGVyYXRpb24g
ZnVuY3Rpb24sIG5lZWQgdG8NCmF2b2lkIHRoZSBmYWxzZSBhbGFybSB3aGVuIEtBU0FOIHVuLWlu
aXRpYWxpemVkLg0KDQpDaGFuZ2VzIGluIHY0Og0KbW9kaWZ5IG5lZ2F0aXZlIHNpemUgY29uZGl0
aW9uDQptb2RpZnkgY29tbWVudHMNCm1vZGlmeSB0aGUgZml4ZWQgY29kZSBhYm91dCBlYXJseSBz
dGFnZXMgb2YgYm9vdA0KLS0tDQogaW5jbHVkZS9saW51eC9rYXNhbi5oICAgICB8ICAyICstDQog
bGliL3Rlc3Rfa2FzYW4uYyAgICAgICAgICB8IDE4IC0tLS0tLS0tLS0tLS0tLS0tLQ0KIG1tL2th
c2FuL2NvbW1vbi5jICAgICAgICAgfCAyNSArKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tDQogbW0v
a2FzYW4vZ2VuZXJpYy5jICAgICAgICB8ICA5ICsrKystLS0tLQ0KIG1tL2thc2FuL2dlbmVyaWNf
cmVwb3J0LmMgfCAxMSAtLS0tLS0tLS0tLQ0KIG1tL2thc2FuL2thc2FuLmggICAgICAgICAgfCAg
MiArLQ0KIG1tL2thc2FuL3JlcG9ydC5jICAgICAgICAgfCAgNSArKysrLQ0KIG1tL2thc2FuL3Rh
Z3MuYyAgICAgICAgICAgfCAgOSArKysrLS0tLS0NCiBtbS9rYXNhbi90YWdzX3JlcG9ydC5jICAg
IHwgMTEgLS0tLS0tLS0tLS0NCiA5IGZpbGVzIGNoYW5nZWQsIDIxIGluc2VydGlvbnMoKyksIDcx
IGRlbGV0aW9ucygtKQ0KDQotLSANCjIuMTguMA0K

