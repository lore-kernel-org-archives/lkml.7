Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D3FC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 07:29:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD52A2089D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 07:29:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="dF7WIzR/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbfKUH3T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 02:29:19 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:8629 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725842AbfKUH3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 02:29:18 -0500
X-UUID: 50003c530eab45729dc643b5b631aaf2-20191121
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=DdOBazdkEY8z3b9oLQBOBsUR+PwkBxvsgtd16bL2wP8=;
        b=dF7WIzR/p2XrAtxWVR+Uau04hx1SguyHDCvtAL0bumQpo8ZGhIzB07H26eHEYfdMkn2/o/0CgR9ItlVNh8Tz6g35yZIUMZs4km/tPhXQSPOFehPH3nUmb72k9cxTI3ZY5Io2WtdLG+tBJ8+lHghSvJ+oEnk/4FWL1CZdQVzL55o=;
X-UUID: 50003c530eab45729dc643b5b631aaf2-20191121
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <bibby.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 2015701134; Thu, 21 Nov 2019 15:29:12 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 21 Nov 2019 15:29:05 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 21 Nov 2019 15:29:07 +0800
From:   Bibby Hsieh <bibby.hsieh@mediatek.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, CK HU <ck.hu@mediatek.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Dennis-YC Hsieh <dennis-yc.hsieh@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>
Subject: [PATCH] soc: mediatek: cmdq: avoid racing condition with mutex
Date:   Thu, 21 Nov 2019 15:29:10 +0800
Message-ID: <20191121072910.31665-1-bibby.hsieh@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SWYgY21kcSBjbGllbnQgaXMgbXVsdGkgdGhyZWFkIHVzZXIsIHJhY2luZyB3aWxsIG9jY3VyIHdp
dGhvdXQgbXV0ZXgNCnByb3RlY3Rpb24uIEl0IHdpbGwgbWFrZSB0aGUgQyBtZXNzYWdlIHF1ZXVl
ZCBpbiBtYWlsYm94J3MgcXVldWUNCmFsd2F5cyBuZWVkIEQgbWVzc2FnZSdzIHRyaWdnZXJpbmcu
DQoNClRocmVhZCBBCQlUaHJlYWQgQgkJICBUaHJlYWQgQwkJVGhyZWFkIEQuLi4NCi0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tDQptYm94X3NlbmRfbWVzc2FnZSgpDQoJc2VuZF9kYXRhKCkNCgkJ
CW1ib3hfc2VuZF9tZXNzYWdlKCkNCgkJCQkqZXhpdA0KCQkJCQkJbWJveF9zZW5kX21lc3NhZ2Uo
KQ0KCQkJCQkJCSpleGl0DQptYm94X2NsaWVudF90eGRvbmUoKQ0KCXR4X3RpY2soKQ0KCQkJbWJv
eF9jbGllbnRfdHhkb25lKCkNCgkJCQl0eF90aWNrKCkNCgkJCQkJCW1ib3hfY2xpZW50X3R4ZG9u
ZSgpDQoJCQkJCQkJdHhfdGljaygpDQptc2dfc3VibWl0KCkNCglzZW5kX2RhdGEoKQ0KCQkJbXNn
X3N1Ym1pdCgpDQoJCQkJKmV4aXQNCgkJCQkJCW1zZ19zdWJtaXQoKQ0KCQkJCQkJCSpleGl0DQot
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KDQpTaWduZWQtb2ZmLWJ5OiBCaWJieSBIc2llaCA8
YmliYnkuaHNpZWhAbWVkaWF0ZWsuY29tPg0KLS0tDQogZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRr
LWNtZHEtaGVscGVyLmMgfCAzICsrKw0KIGluY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1j
bWRxLmggIHwgMSArDQogMiBmaWxlcyBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKykNCg0KZGlmZiAt
LWdpdCBhL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jIGIvZHJpdmVycy9z
b2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMNCmluZGV4IDlhZGQwZmQ1ZmE2Yy4uOWUzNWUw
YmVmZmFhIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVy
LmMNCisrKyBiL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jDQpAQCAtODEs
NiArODEsNyBAQCBzdHJ1Y3QgY21kcV9jbGllbnQgKmNtZHFfbWJveF9jcmVhdGUoc3RydWN0IGRl
dmljZSAqZGV2LCBpbnQgaW5kZXgsIHUzMiB0aW1lb3V0KQ0KIAljbGllbnQtPmNsaWVudC5kZXYg
PSBkZXY7DQogCWNsaWVudC0+Y2xpZW50LnR4X2Jsb2NrID0gZmFsc2U7DQogCWNsaWVudC0+Y2hh
biA9IG1ib3hfcmVxdWVzdF9jaGFubmVsKCZjbGllbnQtPmNsaWVudCwgaW5kZXgpOw0KKwltdXRl
eF9pbml0KCZjbGllbnQtPm11dGV4KTsNCiANCiAJaWYgKElTX0VSUihjbGllbnQtPmNoYW4pKSB7
DQogCQlsb25nIGVycjsNCkBAIC0zNTIsOSArMzUzLDExIEBAIGludCBjbWRxX3BrdF9mbHVzaF9h
c3luYyhzdHJ1Y3QgY21kcV9wa3QgKnBrdCwgY21kcV9hc3luY19mbHVzaF9jYiBjYiwNCiAJCXNw
aW5fdW5sb2NrX2lycXJlc3RvcmUoJmNsaWVudC0+bG9jaywgZmxhZ3MpOw0KIAl9DQogDQorCW11
dGV4X2xvY2soJmNsaWVudC0+bXV0ZXgpOw0KIAltYm94X3NlbmRfbWVzc2FnZShjbGllbnQtPmNo
YW4sIHBrdCk7DQogCS8qIFdlIGNhbiBzZW5kIG5leHQgcGFja2V0IGltbWVkaWF0ZWx5LCBzbyBq
dXN0IGNhbGwgdHhkb25lLiAqLw0KIAltYm94X2NsaWVudF90eGRvbmUoY2xpZW50LT5jaGFuLCAw
KTsNCisJbXV0ZXhfdW5sb2NrKCZjbGllbnQtPm11dGV4KTsNCiANCiAJcmV0dXJuIDA7DQogfQ0K
ZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmggYi9pbmNs
dWRlL2xpbnV4L3NvYy9tZWRpYXRlay9tdGstY21kcS5oDQppbmRleCBhNzRjMWQ1YWNkZjMuLjBm
OTA3MWNkMWJjNyAxMDA2NDQNCi0tLSBhL2luY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1j
bWRxLmgNCisrKyBiL2luY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmgNCkBAIC0y
OCw2ICsyOCw3IEBAIHN0cnVjdCBjbWRxX2NsaWVudCB7DQogCXN0cnVjdCBtYm94X2NoYW4gKmNo
YW47DQogCXN0cnVjdCB0aW1lcl9saXN0IHRpbWVyOw0KIAl1MzIgdGltZW91dF9tczsgLyogaW4g
dW5pdCBvZiBtaWNyb3NlY29uZCAqLw0KKwlzdHJ1Y3QgbXV0ZXggbXV0ZXg7DQogfTsNCiANCiAv
KioNCi0tIA0KMi4xOC4wDQo=

