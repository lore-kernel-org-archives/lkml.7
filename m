Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBA53C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 01:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3AD1207DD
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 01:59:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="auqqwUkk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727339AbfK0B75 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 20:59:57 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:8751 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726558AbfK0B7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 20:59:20 -0500
X-UUID: 4b791b59fcb541a79544c9e176ba0366-20191127
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=xgQWPOCZyQy+pjAO4YlSup72JlwqCII8CwTVMie3F70=;
        b=auqqwUkkrfz+PnUt8tvmNp3rZFyQbaC7TP8wQ45tYB9oaezQJRe8Zo2Ko4NKzDy2tOSbGCu00CgAOC6rvaPpwDNM73amBYQE6UvHFLQOO4I6mgnXUXXLAFtNZIKFbX+Srmev0jtE2GFbdOtI9vAqEys5gEP03WE45Q9DPix5Qm0=;
X-UUID: 4b791b59fcb541a79544c9e176ba0366-20191127
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <dennis-yc.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 665917906; Wed, 27 Nov 2019 09:59:10 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 27 Nov 2019 09:58:29 +0800
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
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v2] support gce on mt6779 platform
Date:   Wed, 27 Nov 2019 09:58:42 +0800
Message-ID: <1574819937-6246-1-git-send-email-dennis-yc.hsieh@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U3VwcG9ydCBnY2Ugb24gbXQ2Nzc5IHBsYXRmb3JtLg0KDQpUaGVzZSBwYXRjaGVzIGRlcGVuZCBv
biBwYXRjaDoNCnN1cHBvcnQgZ2NlIG9uIG10ODE4MyBwbGF0Zm9ybQ0KKGh0dHBzOi8vcGF0Y2h3
b3JrLmtlcm5lbC5vcmcvY292ZXIvMTEyNTUxNDcvKQ0KDQpTdXBwb3J0IGdjZSBmdW5jdGlvbiBv
biBtdDY3NzkgcGxhdGZvcm0uDQoJZHQtYmluZGluZzogZ2NlOiBhZGQgZ2NlIGhlYWRlciBmaWxl
IGZvciBtdDY3NzkNCgltYWlsYm94OiBjbWRxOiB2YXJpYWJsaXplIGFkZHJlc3Mgc2hpZnQgaW4g
cGxhdGZvcm0NCgltYWlsYm94OiBjbWRxOiBzdXBwb3J0IG10Njc3OSBnY2UgcGxhdGZvcm0gZGVm
aW5pdGlvbg0KCWFybTY0OiBkdHM6IGFkZCBnY2Ugbm9kZSBmb3IgbXQ2Nzc5DQoNClJlZmluZSBk
cml2ZXIgdG8gc3VwcG9ydCBzdG9wIGhhcmR3YXJlIHdpdGggc2FmZSBjYWxsYmFjay4NCgltYWls
Ym94OiBtZWRpYXRlazogY21kcTogY2xlYXIgdGFzayBpbiBjaGFubmVsIGJlZm9yZSBzaHV0ZG93
bg0KDQoNCkRlbm5pcyBZQyBIc2llaCAoMTQpOg0KICBkdC1iaW5kaW5nOiBnY2U6IGFkZCBnY2Ug
aGVhZGVyIGZpbGUgZm9yIG10Njc3OQ0KICBtYWlsYm94OiBjbWRxOiB2YXJpYWJsaXplIGFkZHJl
c3Mgc2hpZnQgaW4gcGxhdGZvcm0NCiAgbWFpbGJveDogY21kcTogc3VwcG9ydCBtdDY3NzkgZ2Nl
IHBsYXRmb3JtIGRlZmluaXRpb24NCiAgbWFpbGJveDogbWVkaWF0ZWs6IGNtZHE6IGNsZWFyIHRh
c2sgaW4gY2hhbm5lbCBiZWZvcmUgc2h1dGRvd24NCiAgYXJtNjQ6IGR0czogYWRkIGdjZSBub2Rl
IGZvciBtdDY3NzkNCiAgc29jOiBtZWRpYXRlazogY21kcTogcmV0dXJuIHNlbmQgbXNnIGVycm9y
IGNvZGUNCiAgc29jOiBtZWRpYXRlazogY21kcTogYWRkIGFzc2lnbiBmdW5jdGlvbg0KICBzb2M6
IG1lZGlhdGVrOiBjbWRxOiBhZGQgd3JpdGVfcyBmdW5jdGlvbg0KICBzb2M6IG1lZGlhdGVrOiBj
bWRxOiBhZGQgcmVhZF9zIGZ1bmN0aW9uDQogIHNvYzogbWVkaWF0ZWs6IGNtZHE6IGFkZCB3cml0
ZV9zIHZhbHVlIGZ1bmN0aW9uDQogIHNvYzogbWVkaWF0ZWs6IGNtZHE6IGV4cG9ydCBmaW5hbGl6
ZSBmdW5jdGlvbg0KICBzb2M6IG1lZGlhdGVrOiBjbWRxOiBhZGQgbG9vcCBmdW5jdGlvbg0KICBz
b2M6IG1lZGlhdGVrOiBjbWRxOiBhZGQgd2FpdCBubyBjbGVhciBldmVudCBmdW5jdGlvbg0KICBz
b2M6IG1lZGlhdGVrOiBjbWRxOiBhZGQgc2V0IGV2ZW50IGZ1bmN0aW9uDQoNCiAuLi4vZGV2aWNl
dHJlZS9iaW5kaW5ncy9tYWlsYm94L210ay1nY2UudHh0ICAgfCAgIDggKy0NCiBhcmNoL2FybTY0
L2Jvb3QvZHRzL21lZGlhdGVrL210Njc3OS5kdHNpICAgICAgfCAgMTAgKw0KIGRyaXZlcnMvbWFp
bGJveC9tdGstY21kcS1tYWlsYm94LmMgICAgICAgICAgICB8ICA4NSArKysrKystDQogZHJpdmVy
cy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMgICAgICAgIHwgMTgxICsrKysrKysrKysr
KystDQogaW5jbHVkZS9kdC1iaW5kaW5ncy9nY2UvbXQ2Nzc5LWdjZS5oICAgICAgICAgIHwgMjIy
ICsrKysrKysrKysrKysrKysrKw0KIGluY2x1ZGUvbGludXgvbWFpbGJveC9tdGstY21kcS1tYWls
Ym94LmggICAgICB8ICAgNyArDQogaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEu
aCAgICAgICAgIHwgIDg3ICsrKysrKysNCiA3IGZpbGVzIGNoYW5nZWQsIDU3NSBpbnNlcnRpb25z
KCspLCAyNSBkZWxldGlvbnMoLSkNCiBjcmVhdGUgbW9kZSAxMDA2NDQgaW5jbHVkZS9kdC1iaW5k
aW5ncy9nY2UvbXQ2Nzc5LWdjZS5oDQo=

