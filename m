Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E5D6C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 02:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7346B207DD
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 02:00:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="kaVcJELQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727391AbfK0CAG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 21:00:06 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:45904 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727176AbfK0B7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 20:59:19 -0500
X-UUID: 52e7040e9e5c49cda93020605217b43c-20191127
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=f9tOpTNCngTFNlaWleKgUECGbxlKvCdla8iMy1g4J7I=;
        b=kaVcJELQ6gh4dGawYtcOefHC+6CRUc3wl1pSDg8b+BmHmwd0xn5e9Wik2tE0LfedFzrHU8zOQpKfop2rRd1Sgw3oUEvDQ1lKHk7E05g2CCdSKoYTiiWH3W1mEuz1eKCJuKkMlhGrBLbMElTie3efeyflWLch7oQX4sf3qyXkEtw=;
X-UUID: 52e7040e9e5c49cda93020605217b43c-20191127
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <dennis-yc.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1071452143; Wed, 27 Nov 2019 09:59:10 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 27 Nov 2019 09:58:57 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 27 Nov 2019 09:58:19 +0800
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
Subject: [PATCH v2 06/14] soc: mediatek: cmdq: return send msg error code
Date:   Wed, 27 Nov 2019 09:58:49 +0800
Message-ID: <1574819937-6246-8-git-send-email-dennis-yc.hsieh@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1574819937-6246-1-git-send-email-dennis-yc.hsieh@mediatek.com>
References: <1574819937-6246-1-git-send-email-dennis-yc.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UmV0dXJuIGVycm9yIGNvZGUgdG8gY2xpZW50IGlmIHNlbmQgbWVzc2FnZSBmYWlsLA0Kc28gdGhh
dCBjbGllbnQgaGFzIGNoYW5jZSB0byBlcnJvciBoYW5kbGluZy4NCg0KU2lnbmVkLW9mZi1ieTog
RGVubmlzIFlDIEhzaWVoIDxkZW5uaXMteWMuaHNpZWhAbWVkaWF0ZWsuY29tPg0KLS0tDQogZHJp
dmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMgfCA0ICsrLS0NCiAxIGZpbGUgY2hh
bmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJp
dmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMgYi9kcml2ZXJzL3NvYy9tZWRpYXRl
ay9tdGstY21kcS1oZWxwZXIuYw0KaW5kZXggMjc0ZjZmMzExZDA1Li44NDIxYjQwOTAzMDQgMTAw
NjQ0DQotLS0gYS9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYw0KKysrIGIv
ZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMNCkBAIC0zNTMsMTEgKzM1Mywx
MSBAQCBpbnQgY21kcV9wa3RfZmx1c2hfYXN5bmMoc3RydWN0IGNtZHFfcGt0ICpwa3QsIGNtZHFf
YXN5bmNfZmx1c2hfY2IgY2IsDQogCQlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZjbGllbnQtPmxv
Y2ssIGZsYWdzKTsNCiAJfQ0KIA0KLQltYm94X3NlbmRfbWVzc2FnZShjbGllbnQtPmNoYW4sIHBr
dCk7DQorCWVyciA9IG1ib3hfc2VuZF9tZXNzYWdlKGNsaWVudC0+Y2hhbiwgcGt0KTsNCiAJLyog
V2UgY2FuIHNlbmQgbmV4dCBwYWNrZXQgaW1tZWRpYXRlbHksIHNvIGp1c3QgY2FsbCB0eGRvbmUu
ICovDQogCW1ib3hfY2xpZW50X3R4ZG9uZShjbGllbnQtPmNoYW4sIDApOw0KIA0KLQlyZXR1cm4g
MDsNCisJcmV0dXJuIGVycjsNCiB9DQogRVhQT1JUX1NZTUJPTChjbWRxX3BrdF9mbHVzaF9hc3lu
Yyk7DQogDQotLSANCjIuMTguMA0K

