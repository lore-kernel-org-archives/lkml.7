Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0159C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 09:14:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C865B2089D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 09:14:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Kz4ZqHVD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbfKUJOX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 04:14:23 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:12471 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726568AbfKUJNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 04:13:33 -0500
X-UUID: 3cb19b2a19e747d4ab0722a249cfb574-20191121
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=bFJxZH0AXm81N1vk9AvWXrEq/g3qKxp104WObxKx0SM=;
        b=Kz4ZqHVDnNxE0d6MXDwos+tlqrmmRLxqau6UmGS9DLXxbckvROlu1Rkq9jpbcHrKSxdvsGN83yU+wFp6IIMKg+YdbaZbIRMoA0VLcc/RtrP6TNOJCVKQ2qH/JpJUOb0fiqwkoMPzmipJi8jgSytHu10XTT0XElJHcLosbeYZU10=;
X-UUID: 3cb19b2a19e747d4ab0722a249cfb574-20191121
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <dennis-yc.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 498235357; Thu, 21 Nov 2019 17:13:25 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 21 Nov 2019 17:13:21 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 21 Nov 2019 17:13:28 +0800
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
Subject: support gce on mt6779 platform
Date:   Thu, 21 Nov 2019 17:12:20 +0800
Message-ID: <1574327552-11806-1-git-send-email-dennis-yc.hsieh@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U3VwcG9ydCBnY2UgZnVuY3Rpb24gb24gbXQ2Nzc5IHBsYXRmb3JtLg0KCWR0LWJpbmRpbmc6IGdj
ZTogYWRkIGdjZSBoZWFkZXIgZmlsZSBmb3IgbXQ2Nzc5DQoJbWFpbGJveDogY21kcTogdmFyaWFi
bGl6ZSBhZGRyZXNzIHNoaWZ0IGluIHBsYXRmb3JtDQoJbWFpbGJveDogY21kcTogc3VwcG9ydCBt
dDY3NzkgZ2NlIHBsYXRmb3JtDQoJYXJtNjQ6IGR0czogYWRkIGdjZSBub2RlIGZvciBtdDY3NzkN
Cg0KUmVmaW5lIGRyaXZlciB0byBzdXBwb3J0IHN0b3AgaGFyZHdhcmUgd2l0aCBzYWZlIGNhbGxi
YWNrLg0KCW1haWxib3g6IG1lZGlhdGVrOiBjbWRxOiBjbGVhciB0YXNrIGluIGNoYW5uZWwNCg0K
SW5vcmRlciB0byBzdXBwb3J0IG10Njc3OSBjbGllbnQgcmVxdWlyZW1lbnQsIGFkZCBuZXcgaGVs
cGVyIGZ1bmN0aW9ucyB0bw0KZW5hYmxlIG1vcmUgaGFyZHdhcmUgY2FwYWJpbGl0eS4NCglzb2M6
IG1lZGlhdGVrOiBjbWRxOiBhZGQgYXNzaWduIGZ1bmN0aW9uDQoJc29jOiBtZWRpYXRlazogY21k
cTogYWRkIHdyaXRlX3MgZnVuY3Rpb24NCglzb2M6IG1lZGlhdGVrOiBjbWRxOiBhZGQgcmVhZF9z
IGZ1bmN0aW9uDQoJc29jOiBtZWRpYXRlazogY21kcTogYWRkIG1lbSBtb3ZlIGZ1bmN0aW9uDQoJ
c29jOiBtZWRpYXRlazogY21kcTogYWRkIGxvb3AgZnVuY3Rpb24NCglzb2M6IG1lZGlhdGVrOiBj
bWRxOiBhZGQgd2FpdCBubyBjbGVhciBldmVudA0KCXNvYzogbWVkaWF0ZWs6IGNtZHE6IGFkZCBz
ZXQgZXZlbnQgZnVuY3Rpb24NCg0KDQoNCkRlbm5pcyBZQyBIc2llaCAoMTIpOg0KICBkdC1iaW5k
aW5nOiBnY2U6IGFkZCBnY2UgaGVhZGVyIGZpbGUgZm9yIG10Njc3OQ0KICBtYWlsYm94OiBjbWRx
OiB2YXJpYWJsaXplIGFkZHJlc3Mgc2hpZnQgaW4gcGxhdGZvcm0NCiAgbWFpbGJveDogY21kcTog
c3VwcG9ydCBtdDY3NzkgZ2NlIHBsYXRmb3JtIGRlZmluaXRpb24NCiAgbWFpbGJveDogbWVkaWF0
ZWs6IGNtZHE6IGNsZWFyIHRhc2sgaW4gY2hhbm5lbCBiZWZvcmUgc2h1dGRvd24NCiAgYXJtNjQ6
IGR0czogYWRkIGdjZSBub2RlIGZvciBtdDY3NzkNCiAgc29jOiBtZWRpYXRlazogY21kcTogYWRk
IGFzc2lnbiBmdW5jdGlvbg0KICBzb2M6IG1lZGlhdGVrOiBjbWRxOiBhZGQgd3JpdGVfcyBmdW5j
dGlvbg0KICBzb2M6IG1lZGlhdGVrOiBjbWRxOiBhZGQgcmVhZF9zIGZ1bmN0aW9uDQogIHNvYzog
bWVkaWF0ZWs6IGNtZHE6IGFkZCBtZW0gbW92ZSBmdW5jdGlvbg0KICBzb2M6IG1lZGlhdGVrOiBj
bWRxOiBhZGQgbG9vcCBmdW5jdGlvbg0KICBzb2M6IG1lZGlhdGVrOiBjbWRxOiBhZGQgd2FpdCBu
byBjbGVhciBldmVudCBmdW5jdGlvbg0KICBzb2M6IG1lZGlhdGVrOiBjbWRxOiBhZGQgc2V0IGV2
ZW50IGZ1bmN0aW9uDQoNCiAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9tYWlsYm94L210ay1nY2Uu
dHh0ICAgfCAgIDggKy0NCiBhcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210Njc3OS5kdHNp
ICAgICAgfCAgMTAgKw0KIGRyaXZlcnMvbWFpbGJveC9tdGstY21kcS1tYWlsYm94LmMgICAgICAg
ICAgICB8ICA4NSArKysrKystDQogZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVy
LmMgICAgICAgIHwgMTgyICsrKysrKysrKysrKystDQogaW5jbHVkZS9kdC1iaW5kaW5ncy9nY2Uv
bXQ2Nzc5LWdjZS5oICAgICAgICAgIHwgMjIyICsrKysrKysrKysrKysrKysrKw0KIGluY2x1ZGUv
bGludXgvbWFpbGJveC9tdGstY21kcS1tYWlsYm94LmggICAgICB8ICAgNyArDQogaW5jbHVkZS9s
aW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaCAgICAgICAgIHwgIDc3ICsrKysrKw0KIDcgZmls
ZXMgY2hhbmdlZCwgNTczIGluc2VydGlvbnMoKyksIDE4IGRlbGV0aW9ucygtKQ0KIGNyZWF0ZSBt
b2RlIDEwMDY0NCBpbmNsdWRlL2R0LWJpbmRpbmdzL2djZS9tdDY3NzktZ2NlLmgNCg==

