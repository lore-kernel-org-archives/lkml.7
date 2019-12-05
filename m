Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB441C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 09:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B105A2464F
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 09:28:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="YApkMZxn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729190AbfLEJ2C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 04:28:02 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:30070 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729107AbfLEJ16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 04:27:58 -0500
X-UUID: dbff0ba6066c401d94920387711a746e-20191205
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=wfbgAypWcJD8BoKp0RqiMZYqAeZg3ySAwC4T95RExtU=;
        b=YApkMZxnZpqyMUZXkh/eeAmQLZp6zdr4CBOP9gEcPSZIeVE29jVyvbwOOXsMHM1R6sUK08QyKzMQrbyNz77JsE7HLQLPwcHx57D4Ys4ScL2hYbs5bKbJIlJ7A2oyRnYf+5z8KMMoNRmq75xfuL0eELUP3UhPw9LnDd/gRg8QmYU=;
X-UUID: dbff0ba6066c401d94920387711a746e-20191205
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw01.mediatek.com
        (envelope-from <bibby.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 348923328; Thu, 05 Dec 2019 17:27:52 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 5 Dec 2019 17:27:06 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 5 Dec 2019 17:26:52 +0800
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
Subject: [PATCH v4 2/7] drm/mediatek: handle events when enabling/disabling crtc
Date:   Thu, 5 Dec 2019 17:27:44 +0800
Message-ID: <20191205092749.4021-3-bibby.hsieh@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20191205092749.4021-1-bibby.hsieh@mediatek.com>
References: <20191205092749.4021-1-bibby.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 1C5FD9482EEAF9DFC62FDC1CAAF73359835CE475FCD88CB7CC262BA0BAA60DE42000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlIGRyaXZlciBjdXJyZW50bHkgaGFuZGxlcyB2YmxhbmsgZXZlbnRzIG9ubHkgd2hlbiB1cGRh
dGluZyBwbGFuZXMgb24NCmFuIGFscmVhZHkgZW5hYmxlZCBDUlRDLiBUaGUgYXRvbWljIHVwZGF0
ZSBBUEkgaG93ZXZlciBhbGxvd3MgcmVxdWVzdGluZw0KYW4gZXZlbnQgd2hlbiBlbmFibGluZyBv
ciBkaXNhYmxpbmcgYSBDUlRDLiBUaGlzIGN1cnJlbnRseSBsZWFkcyB0bw0KZXZlbnQgb2JqZWN0
cyBiZWluZyBsZWFrZWQgaW4gdGhlIGtlcm5lbCBhbmQgdG8gZXZlbnRzIG5vdCBiZWluZyBzZW50
DQpvdXQuIEZpeCBpdC4NCg0KU2lnbmVkLW9mZi1ieTogQmliYnkgSHNpZWggPGJpYmJ5LmhzaWVo
QG1lZGlhdGVrLmNvbT4NClJldmlld2VkLWJ5OiBDSyBIdSA8Y2suaHVAbWVkaWF0ZWsuY29tPg0K
LS0tDQogZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fY3J0Yy5jIHwgOCArKysrKysr
Kw0KIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2NydGMuYyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRp
YXRlay9tdGtfZHJtX2NydGMuYw0KaW5kZXggZjVlZWIwZWViZjc2Li40YmM1MjM0NjA5M2QgMTAw
NjQ0DQotLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9jcnRjLmMNCisrKyBi
L2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2NydGMuYw0KQEAgLTMzOCw2ICszMzgs
NyBAQCBzdGF0aWMgaW50IG10a19jcnRjX2RkcF9od19pbml0KHN0cnVjdCBtdGtfZHJtX2NydGMg
Km10a19jcnRjKQ0KIHN0YXRpYyB2b2lkIG10a19jcnRjX2RkcF9od19maW5pKHN0cnVjdCBtdGtf
ZHJtX2NydGMgKm10a19jcnRjKQ0KIHsNCiAJc3RydWN0IGRybV9kZXZpY2UgKmRybSA9IG10a19j
cnRjLT5iYXNlLmRldjsNCisJc3RydWN0IGRybV9jcnRjICpjcnRjID0gJm10a19jcnRjLT5iYXNl
Ow0KIAlpbnQgaTsNCiANCiAJRFJNX0RFQlVHX0RSSVZFUigiJXNcbiIsIF9fZnVuY19fKTsNCkBA
IC0zNjQsNiArMzY1LDEzIEBAIHN0YXRpYyB2b2lkIG10a19jcnRjX2RkcF9od19maW5pKHN0cnVj
dCBtdGtfZHJtX2NydGMgKm10a19jcnRjKQ0KIAkJbXRrX2RkcF9jb21wX3VucHJlcGFyZShtdGtf
Y3J0Yy0+ZGRwX2NvbXBbaV0pOw0KIA0KIAlwbV9ydW50aW1lX3B1dChkcm0tPmRldik7DQorDQor
CWlmIChjcnRjLT5zdGF0ZS0+ZXZlbnQgJiYgIWNydGMtPnN0YXRlLT5hY3RpdmUpIHsNCisJCXNw
aW5fbG9ja19pcnEoJmNydGMtPmRldi0+ZXZlbnRfbG9jayk7DQorCQlkcm1fY3J0Y19zZW5kX3Zi
bGFua19ldmVudChjcnRjLCBjcnRjLT5zdGF0ZS0+ZXZlbnQpOw0KKwkJY3J0Yy0+c3RhdGUtPmV2
ZW50ID0gTlVMTDsNCisJCXNwaW5fdW5sb2NrX2lycSgmY3J0Yy0+ZGV2LT5ldmVudF9sb2NrKTsN
CisJfQ0KIH0NCiANCiBzdGF0aWMgdm9pZCBtdGtfY3J0Y19kZHBfY29uZmlnKHN0cnVjdCBkcm1f
Y3J0YyAqY3J0YykNCi0tIA0KMi4xOC4wDQo=

