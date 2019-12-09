Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9331CC43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 05:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E489206D3
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 05:49:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="T0rnmY1g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbfLIFs7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 00:48:59 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:51527 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726343AbfLIFs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 00:48:59 -0500
X-UUID: 902b7fe004794afd88fd55965f676b0c-20191209
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=zK5djuSKYwqaaHgHxdED8AbROBXJzib5e6bG7MyafoQ=;
        b=T0rnmY1g38CZXStFCH3SSNkP+iHjXCP0tF0EoP6CwBeQoRi4n9o1pk9Ho96wxCubp9pWELGxyyXm0HKFcEPuSoXA/wPFmg8ZanRnFpTpvrgHuTigNbrghjq+bWzQ2KFTzoGJE5E4XRp9r8kKGYpTxsJrJfRmd+eCOr66WRNRnJ0=;
X-UUID: 902b7fe004794afd88fd55965f676b0c-20191209
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <walter-zh.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 462000421; Mon, 09 Dec 2019 13:48:52 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 9 Dec 2019 13:48:43 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 9 Dec 2019 13:48:36 +0800
From:   Walter Wu <walter-zh.wu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexander Potapenko <glider@google.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        Walter Wu <walter-zh.wu@mediatek.com>
Subject: [PATCH] lib/stackdepot: Fix global out-of-bounds in stackdepot
Date:   Mon, 9 Dec 2019 13:48:49 +0800
Message-ID: <20191209054849.26756-1-walter-zh.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SWYgdGhlIGRlcG90X2luZGV4ID0gU1RBQ0tfQUxMT0NfTUFYX1NMQUJTIC0gMiwgdGhlbiBpdCB3
aWxsIGNhdXNlDQphcnJheSBvdXQtb2YtYm91bmRzIGFjY2Vzcywgc28gdGhhdCB3ZSBzaG91bGQg
bW9kaWZ5IHRoZSBkZXRlY3Rpb24NCnRvIGF2b2lkIHRoaXMgYXJyYXkgb3V0LW9mLWJvdW5kcyBi
dWcuDQoNCkNvbnNpZGVyIGZvbGxvd2luZyBjYWxsIGZsb3cgc2VxdWVuY2U6DQoNCnN0YWNrX2Rl
cG90X3NhdmUoKQ0KICAgZGVwb3RfYWxsb2Nfc3RhY2soKQ0KICAgICAgaWYgKHVubGlrZWx5KGRl
cG90X2luZGV4ICsgMSA+PSBTVEFDS19BTExPQ19NQVhfU0xBQlMpKSAvL3Bhc3MNCiAgICAgIGRl
cG90X2luZGV4KysgIC8vZGVwb3RfaW5kZXggPSBTVEFDS19BTExPQ19NQVhfU0xBQlMgLSAxDQoN
CnN0YWNrX2RlcG90X3NhdmUoKQ0KICAgaW5pdF9zdGFja19zbGFiKCkNCiAgICAgIHN0YWNrX3Ns
YWJzW2RlcG90X2luZGV4ICsgMV0gIC8vaGVyZSBnZXQgZ2xvYmFsIG91dC1vZi1ib3VuZHMNCg0K
U2lnbmVkLW9mZi1ieTogV2FsdGVyIFd1IDx3YWx0ZXItemgud3VAbWVkaWF0ZWsuY29tPg0KLS0t
DQogbGliL3N0YWNrZGVwb3QuYyB8IDIgKy0NCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24o
KyksIDEgZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBhL2xpYi9zdGFja2RlcG90LmMgYi9saWIv
c3RhY2tkZXBvdC5jDQppbmRleCBlZDcxN2RkMDhmZjMuLjdlOGExNWU0MTYwMCAxMDA2NDQNCi0t
LSBhL2xpYi9zdGFja2RlcG90LmMNCisrKyBiL2xpYi9zdGFja2RlcG90LmMNCkBAIC0xMDYsNyAr
MTA2LDcgQEAgc3RhdGljIHN0cnVjdCBzdGFja19yZWNvcmQgKmRlcG90X2FsbG9jX3N0YWNrKHVu
c2lnbmVkIGxvbmcgKmVudHJpZXMsIGludCBzaXplLA0KIAlyZXF1aXJlZF9zaXplID0gQUxJR04o
cmVxdWlyZWRfc2l6ZSwgMSA8PCBTVEFDS19BTExPQ19BTElHTik7DQogDQogCWlmICh1bmxpa2Vs
eShkZXBvdF9vZmZzZXQgKyByZXF1aXJlZF9zaXplID4gU1RBQ0tfQUxMT0NfU0laRSkpIHsNCi0J
CWlmICh1bmxpa2VseShkZXBvdF9pbmRleCArIDEgPj0gU1RBQ0tfQUxMT0NfTUFYX1NMQUJTKSkg
ew0KKwkJaWYgKHVubGlrZWx5KGRlcG90X2luZGV4ICsgMiA+PSBTVEFDS19BTExPQ19NQVhfU0xB
QlMpKSB7DQogCQkJV0FSTl9PTkNFKDEsICJTdGFjayBkZXBvdCByZWFjaGVkIGxpbWl0IGNhcGFj
aXR5Iik7DQogCQkJcmV0dXJuIE5VTEw7DQogCQl9DQotLSANCjIuMTguMA0K

