Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8FE8C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 08:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5C0620898
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 08:30:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="i1ke+CB4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbfKUIaR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 03:30:17 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:47827 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726132AbfKUIaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 03:30:17 -0500
X-UUID: 5b0f312b28e8411f8ed7e8ca90f4bd26-20191121
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=0Ckld6EwBzz2+Vv2aLPvbwitkSnSY2s1D7AUbqn0zrg=;
        b=i1ke+CB4hO9trYn+KlvsKyGptMnYEreF+L2kHRi5BQEeT1Jup1ewWq5B7VLn4GDFN4M3mtDPEFCIhSSkUU52hnR3i/ryJZFxUbV1ek9WYv8Io771D6k9E0iBNZj5GQaSesQuNxn6cuN2/M9pFLbvE1z12ISXPdizbcqbbxjDjzg=;
X-UUID: 5b0f312b28e8411f8ed7e8ca90f4bd26-20191121
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <yt.chang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1952610544; Thu, 21 Nov 2019 16:30:11 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 21 Nov 2019 16:30:04 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 21 Nov 2019 16:30:14 +0800
From:   YT Chang <yt.chang@mediatek.com>
To:     YT Chang <yt.chang@mediatek.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <wsd_upstream@mediatek.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH 1/1] sched: cfs_rq h_load might not update due to irq disable
Date:   Thu, 21 Nov 2019 16:30:09 +0800
Message-ID: <1574325009-10846-1-git-send-email-yt.chang@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U3luZHJvbWU6DQoNClR3byBDUFVzIG1pZ2h0IGRvIGlkbGUgYmFsYW5jZSBpbiB0aGUgc2FtZSB0
aW1lLg0KT25lIENQVSBkb2VzIGlkbGUgYmFsYW5jZSBhbmQgcHVsbHMgc29tZSB0YXNrcy4NCkhv
d2V2ZXIgYmVmb3JlIHBpY2sgbmV4dCB0YXNrLCBBTEwgdGFzayBhcmUgcHVsbGVkIGJhY2sgdG8g
b3RoZXIgQ1BVLg0KVGhhdCByZXN1bHRzIGluIGluZmluaXRlIGxvb3AgaW4gYm90aCBDUFVzLg0K
DQo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KY29kZSBmbG93Og0K
DQppbiBwaWNrX25leHRfdGFza19mYWlyKCkNCg0KYWdhaW46DQoNCmlmIG5yX3J1bm5pbmcgPT0g
MA0KCWdvdG8gaWRsZQ0KcGljayBuZXh0IHRhc2sNCglyZXR1cm4NCg0KaWRsZToNCglpZGxlX2Jh
bGFuY2UNCiAgICAgICAvKiBwdWxsIHNvbWUgdGFza3MgZnJvbSBvdGhlciBDUFUsDQogICAgICAg
ICogSG93ZXZlciBvdGhlciBDUFUgYXJlIGFsc28gZG8gaWRsZSBiYWxhbmNlLA0KCSogYW5kIHB1
bGwgYmFjayB0aGVzZSB0YXNrICovDQoNCglnbyB0byBhZ2Fpbg0KDQo9PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PQ0KVGhlIHJlc3VsdCB0byBwdWxsIEFMTCB0YXNrcyBi
YWNrIHdoZW4gdGhlIHRhc2tfaF9sb2FkDQppcyBpbmNvcnJlY3QgYW5kIHRvbyBsb3cuDQoNCnN0
YXRpYyB1bnNpZ25lZCBsb25nIHRhc2tfaF9sb2FkKHN0cnVjdCB0YXNrX3N0cnVjdCAqcCkNCnsN
CiAgICAgICAgc3RydWN0IGNmc19ycSAqY2ZzX3JxID0gdGFza19jZnNfcnEocCk7DQoNCgl1cGRh
dGVfY2ZzX3JxX2hfbG9hZChjZnNfcnEpOw0KCXJldHVybiBkaXY2NF91bChwLT5zZS5hdmcubG9h
ZF9hdmdfY29udHJpYiAqIGNmc19ycS0+aF9sb2FkLA0KCQkJY2ZzX3JxLT5ydW5uYWJsZV9sb2Fk
X2F2ZyArIDEpOw0KfQ0KDQpUaGUgY2ZzX3JxLT5oX2xvYWQgaXMgaW5jb3JyZWN0IGFuZCBtaWdo
dCB0b28gc21hbGwuDQpUaGUgb3JpZ2luYWwgaWRlYSBvZiBjZnNfcnE6Omxhc3RfaF9sb2FkX3Vw
ZGF0ZSB3aWxsIG5vdA0KdXBkYXRlIGNmc19ycTo6aF9sb2FkIG1vcmUgdGhhbiBvbmNlIGEgamlm
Zmllcy4NCldoZW4gdGhlIFR3byBDUFVzIHB1bGwgZWFjaCBvdGhlciBpbiB0aGUgcGlja19uZXh0
X3Rhc2tfZmFpciwNCnRoZSBpcnEgZGlzYWJsZWQgYW5kIHJlc3VsdCBpbiBqaWZmaWUgbm90IHVw
ZGF0ZS4NCihPdGhlciBDUFVzIHdhaXQgZm9yIHJ1bnF1ZXVlIGxvY2sgbG9ja2VkIGJ5IHRoZSB0
d28gQ1BVcy4NClNvLCBBTEwgQ1BVcyBhcmUgaXJxIGRpc2FibGVkLikNCg0KU29sdXRpb246DQpj
ZnNfcnEgaF9sb2FkIG1pZ2h0IG5vdCB1cGRhdGUgZHVlIHRvIGlycSBkaXNhYmxlDQp1c2Ugc2No
ZWRfY2xvY2sgaW5zdGVhZCBqaWZmaWVzDQoNClNpZ25lZC1vZmYtYnk6IFlUIENoYW5nIDx5dC5j
aGFuZ0BtZWRpYXRlay5jb20+DQotLS0NCiBrZXJuZWwvc2NoZWQvZmFpci5jIHwgNCArKystDQog
MSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KDQpkaWZmIC0t
Z2l0IGEva2VybmVsL3NjaGVkL2ZhaXIuYyBiL2tlcm5lbC9zY2hlZC9mYWlyLmMNCmluZGV4IDgz
YWIzNWUuLjIzMWM1M2YgMTAwNjQ0DQotLS0gYS9rZXJuZWwvc2NoZWQvZmFpci5jDQorKysgYi9r
ZXJuZWwvc2NoZWQvZmFpci5jDQpAQCAtNzU3OCw5ICs3NTc4LDExIEBAIHN0YXRpYyB2b2lkIHVw
ZGF0ZV9jZnNfcnFfaF9sb2FkKHN0cnVjdCBjZnNfcnEgKmNmc19ycSkNCiB7DQogCXN0cnVjdCBy
cSAqcnEgPSBycV9vZihjZnNfcnEpOw0KIAlzdHJ1Y3Qgc2NoZWRfZW50aXR5ICpzZSA9IGNmc19y
cS0+dGctPnNlW2NwdV9vZihycSldOw0KLQl1bnNpZ25lZCBsb25nIG5vdyA9IGppZmZpZXM7DQor
CXU2NCBub3cgPSBzY2hlZF9jbG9ja19jcHUoY3B1X29mKHJxKSk7DQogCXVuc2lnbmVkIGxvbmcg
bG9hZDsNCiANCisJbm93ID0gbm93ICogSFogPj4gMzA7DQorDQogCWlmIChjZnNfcnEtPmxhc3Rf
aF9sb2FkX3VwZGF0ZSA9PSBub3cpDQogCQlyZXR1cm47DQogDQotLSANCjEuOS4xDQo=

