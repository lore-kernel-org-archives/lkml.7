Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 722F7C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 11:58:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F50D214D8
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 11:58:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="emk0ikDn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729102AbfLLL65 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 06:58:57 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:1194 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728919AbfLLL64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 06:58:56 -0500
X-UUID: c530bd8ff1574b4487cfd98afd752a07-20191212
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=dail/LG0z8iZJ8tcfeMMz3hG5C4dKVGEMXa8efdIfeQ=;
        b=emk0ikDnYR7OqJjnq1YxTC2ab8l1nyERP0vDM0f+6r1P2Qm//c7I37Oa653wunvnnKYSV3nZYveEnEyKzVf/88ivN75i9WNtdjbHzbpRM/4kH2Q3hxZxRU093UfuWm89KY4Y6L56MXdcNNx0COrQOuRlvhIQIHsNiYfOYhWoT1I=;
X-UUID: c530bd8ff1574b4487cfd98afd752a07-20191212
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <walter-zh.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1570599864; Thu, 12 Dec 2019 19:58:52 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 12 Dec 2019 19:58:51 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 12 Dec 2019 19:58:45 +0800
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
Subject: [PATCH v2] lib/stackdepot: Fix global out-of-bounds in stackdepot
Date:   Thu, 12 Dec 2019 19:58:48 +0800
Message-ID: <20191212115848.21687-1-walter-zh.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SWYgdGhlIGRlcG90X2luZGV4ID0gU1RBQ0tfQUxMT0NfTUFYX1NMQUJTIC0gMiBhbmQgbmV4dF9z
bGFiX2luaXRlZCA9IDAsDQp0aGVuIGl0IHdpbGwgY2F1c2UgYXJyYXkgb3V0LW9mLWJvdW5kcyBh
Y2Nlc3MsIHNvIHRoYXQgd2Ugc2hvdWxkIG1vZGlmeQ0KdGhlIGRldGVjdGlvbiB0byBhdm9pZCB0
aGlzIGFycmF5IG91dC1vZi1ib3VuZHMgYnVnLg0KDQpBc3N1bWUgZGVwb3RfaW5kZXggPSBTVEFD
S19BTExPQ19NQVhfU0xBQlMgLSAzDQpDb25zaWRlciBmb2xsb3dpbmcgY2FsbCBmbG93IHNlcXVl
bmNlOg0KDQpzdGFja19kZXBvdF9zYXZlKCkNCiAgIGRlcG90X2FsbG9jX3N0YWNrKCkNCiAgICAg
IGlmICh1bmxpa2VseShkZXBvdF9pbmRleCArIDEgPj0gU1RBQ0tfQUxMT0NfTUFYX1NMQUJTKSkg
Ly9wYXNzDQogICAgICBkZXBvdF9pbmRleCsrICAvL2RlcG90X2luZGV4ID0gU1RBQ0tfQUxMT0Nf
TUFYX1NMQUJTIC0gMg0KICAgICAgaWYgKGRlcG90X2luZGV4ICsgMSA8IFNUQUNLX0FMTE9DX01B
WF9TTEFCUykgLy9lbnRlcg0KICAgICAgICAgc21wX3N0b3JlX3JlbGVhc2UoJm5leHRfc2xhYl9p
bml0ZWQsIDApOyAvL25leHRfc2xhYl9pbml0ZWQgPSAwDQogICAgICBpbml0X3N0YWNrX3NsYWIo
KQ0KCSAgICAgaWYgKHN0YWNrX3NsYWJzW2RlcG90X2luZGV4XSA9PSBOVUxMKSAvL2VudGVyDQoN
CnN0YWNrX2RlcG90X3NhdmUoKQ0KICAgZGVwb3RfYWxsb2Nfc3RhY2soKQ0KICAgICAgaWYgKHVu
bGlrZWx5KGRlcG90X2luZGV4ICsgMSA+PSBTVEFDS19BTExPQ19NQVhfU0xBQlMpKSAvL3Bhc3MN
CiAgICAgIGRlcG90X2luZGV4KysgIC8vZGVwb3RfaW5kZXggPSBTVEFDS19BTExPQ19NQVhfU0xB
QlMgLSAxDQogICAgICBpbml0X3N0YWNrX3NsYWIoJnByZWFsbG9jKQ0KICAgICAgICAgc3RhY2tf
c2xhYnNbZGVwb3RfaW5kZXggKyAxXSAgLy9oZXJlIGdldCBnbG9iYWwgb3V0LW9mLWJvdW5kcw0K
DQpTaWduZWQtb2ZmLWJ5OiBXYWx0ZXIgV3UgPHdhbHRlci16aC53dUBtZWRpYXRlay5jb20+DQot
LS0NCmNoYW5nZXMgaW4gdjI6DQptb2RpZnkgY2FsbCBmbG93IHNlcXVlbmNlIGFuZCBwcmVjb25k
aXRvbg0KDQotLS0NCiBsaWIvc3RhY2tkZXBvdC5jIHwgMiArLQ0KIDEgZmlsZSBjaGFuZ2VkLCAx
IGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEvbGliL3N0YWNrZGVw
b3QuYyBiL2xpYi9zdGFja2RlcG90LmMNCmluZGV4IGVkNzE3ZGQwOGZmMy4uN2U4YTE1ZTQxNjAw
IDEwMDY0NA0KLS0tIGEvbGliL3N0YWNrZGVwb3QuYw0KKysrIGIvbGliL3N0YWNrZGVwb3QuYw0K
QEAgLTEwNiw3ICsxMDYsNyBAQCBzdGF0aWMgc3RydWN0IHN0YWNrX3JlY29yZCAqZGVwb3RfYWxs
b2Nfc3RhY2sodW5zaWduZWQgbG9uZyAqZW50cmllcywgaW50IHNpemUsDQogCXJlcXVpcmVkX3Np
emUgPSBBTElHTihyZXF1aXJlZF9zaXplLCAxIDw8IFNUQUNLX0FMTE9DX0FMSUdOKTsNCiANCiAJ
aWYgKHVubGlrZWx5KGRlcG90X29mZnNldCArIHJlcXVpcmVkX3NpemUgPiBTVEFDS19BTExPQ19T
SVpFKSkgew0KLQkJaWYgKHVubGlrZWx5KGRlcG90X2luZGV4ICsgMSA+PSBTVEFDS19BTExPQ19N
QVhfU0xBQlMpKSB7DQorCQlpZiAodW5saWtlbHkoZGVwb3RfaW5kZXggKyAyID49IFNUQUNLX0FM
TE9DX01BWF9TTEFCUykpIHsNCiAJCQlXQVJOX09OQ0UoMSwgIlN0YWNrIGRlcG90IHJlYWNoZWQg
bGltaXQgY2FwYWNpdHkiKTsNCiAJCQlyZXR1cm4gTlVMTDsNCiAJCX0NCi0tIA0KMi4xOC4wDQo=

