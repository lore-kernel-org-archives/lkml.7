Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFB62C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 06:29:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 927AE2071A
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 06:29:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="mmAOqSWh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbfKZG3k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 01:29:40 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:57957 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725802AbfKZG3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 01:29:40 -0500
X-UUID: 08e24a3592044f59971ea114d3534e6b-20191126
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=ff27DYoCkJgamZyY4a90dDsJBb/RppXLWXoUrTKLkjM=;
        b=mmAOqSWh1XXtrPbCzvcj5efveNNIqFP7B4bJaBo9BmkEwK5kQ1oCs4/u8diUXzQ6nqMER+oFCqChzXcWzY90eb17GTRrf/pKdLhBydom3mL1W/CMpjUQqyaa+jEbh8ADHAlwT+8/jitAaNA9nTLit+gv2LspLnsxKgBzyC3vzkk=;
X-UUID: 08e24a3592044f59971ea114d3534e6b-20191126
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <bibby.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 467868600; Tue, 26 Nov 2019 14:29:35 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 26 Nov 2019 14:29:26 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 26 Nov 2019 14:29:15 +0800
From:   Bibby Hsieh <bibby.hsieh@mediatek.com>
To:     David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        YT Shen <yt.shen@mediatek.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        CK Hu <ck.hu@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>, <tfiga@chromium.org>,
        <drinkcat@chromium.org>, <linux-kernel@vger.kernel.org>,
        <srv_heupstream@mediatek.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>
Subject: [PATCH 2/7] drm/mediatek: put "event" in critical section
Date:   Tue, 26 Nov 2019 14:29:27 +0800
Message-ID: <20191126062932.19773-3-bibby.hsieh@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20191126062932.19773-1-bibby.hsieh@mediatek.com>
References: <20191126062932.19773-1-bibby.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlIHN0YXRlLT5iYXNlLmV2ZW50IHZhcmlhYmxlIHdvdWxkIGJlIGFjY2VzcyBieSB0aHJlYWQg
Y29udGV4dA0KaW4gbXRrX2RybV9jcnRjX2F0b21pY19iZWdpbigpIG9yIGJ5IGludGVycnVwdCBj
b250ZXh0IGluDQptdGtfZHJtX2NydGNfZmluaXNoX3BhZ2VfZmxpcCgpLCBzbyBlYWNoIHBhcnQg
c2hvdWxkIGJlIGEgY3JpdGljYWwNCnNlY3Rpb24uIEZpeCBpdC4NCg0KRml4ZXM6IDExOWY1MTcz
NjI4YSAoImRybS9tZWRpYXRlazogQWRkIERSTSBEcml2ZXIgZm9yIE1lZGlhdGVrIFNvQyBNVDgx
NzMuIikNCg0KU2lnbmVkLW9mZi1ieTogQmliYnkgSHNpZWggPGJpYmJ5LmhzaWVoQG1lZGlhdGVr
LmNvbT4NCi0tLQ0KIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2NydGMuYyB8IDMg
KysrDQogMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fY3J0Yy5jIGIvZHJpdmVycy9ncHUvZHJtL21l
ZGlhdGVrL210a19kcm1fY3J0Yy5jDQppbmRleCA2OGI5MmFkYzk2YmIuLmUzODUwNmQ3YTRlOCAx
MDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2NydGMuYw0KKysr
IGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fY3J0Yy5jDQpAQCAtNDg2LDEyICs0
ODYsMTUgQEAgc3RhdGljIHZvaWQgbXRrX2RybV9jcnRjX2F0b21pY19iZWdpbihzdHJ1Y3QgZHJt
X2NydGMgKmNydGMsDQogCWlmIChtdGtfY3J0Yy0+ZXZlbnQgJiYgc3RhdGUtPmJhc2UuZXZlbnQp
DQogCQlEUk1fRVJST1IoIm5ldyBldmVudCB3aGlsZSB0aGVyZSBpcyBzdGlsbCBhIHBlbmRpbmcg
ZXZlbnRcbiIpOw0KIA0KKwlzcGluX2xvY2tfaXJxKCZjcnRjLT5kZXYtPmV2ZW50X2xvY2spOw0K
IAlpZiAoc3RhdGUtPmJhc2UuZXZlbnQpIHsNCiAJCXN0YXRlLT5iYXNlLmV2ZW50LT5waXBlID0g
ZHJtX2NydGNfaW5kZXgoY3J0Yyk7DQogCQlXQVJOX09OKGRybV9jcnRjX3ZibGFua19nZXQoY3J0
YykgIT0gMCk7DQorCQlXQVJOX09OKG10a19jcnRjLT5ldmVudCk7DQogCQltdGtfY3J0Yy0+ZXZl
bnQgPSBzdGF0ZS0+YmFzZS5ldmVudDsNCiAJCXN0YXRlLT5iYXNlLmV2ZW50ID0gTlVMTDsNCiAJ
fQ0KKwlzcGluX3VubG9ja19pcnEoJmNydGMtPmRldi0+ZXZlbnRfbG9jayk7DQogfQ0KIA0KIHN0
YXRpYyB2b2lkIG10a19kcm1fY3J0Y19hdG9taWNfZmx1c2goc3RydWN0IGRybV9jcnRjICpjcnRj
LA0KLS0gDQoyLjE4LjANCg==

