Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1978C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 02:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4165216F4
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 02:43:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="QJYsYnsS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728477AbfK1Cmw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 21:42:52 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:57503 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727344AbfK1Cmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 21:42:50 -0500
X-UUID: 508857a49148437da632a89fe0540804-20191128
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=c6kYd59V8wIXF0yDxCVqtSEJfWBhEuWuPSZyY1b5Pu8=;
        b=QJYsYnsSjV8NfcIEhQOO1NFdVrnARe0cDj2sjZWmxsqpoFviLfYhAyhhqfFCnKreAJAdsbP/Xosu0Yi5r/N967CL/Suk+evrzKl1KhK4WPoDS13sbuB5xrUXPOD+zbCH2dn/dlICBN/IkkMGhUUJwulmXuXiX8ufNdsjnJXfu+0=;
X-UUID: 508857a49148437da632a89fe0540804-20191128
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw02.mediatek.com
        (envelope-from <bibby.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 2081746705; Thu, 28 Nov 2019 10:42:42 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 28 Nov 2019 10:41:58 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 28 Nov 2019 10:42:46 +0800
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
Subject: [PATCH v1 3/6] drm/mediatek: handle events when enabling/disabling crtc
Date:   Thu, 28 Nov 2019 10:42:35 +0800
Message-ID: <20191128024238.9399-4-bibby.hsieh@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20191128024238.9399-1-bibby.hsieh@mediatek.com>
References: <20191128024238.9399-1-bibby.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
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
QG1lZGlhdGVrLmNvbT4NCi0tLQ0KIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2Ny
dGMuYyB8IDggKysrKysrKysNCiAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspDQoNCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9jcnRjLmMgYi9kcml2
ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9jcnRjLmMNCmluZGV4IDcxZjQwODlhODExNy4u
Y2I4N2E1MzhiOGZmIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19k
cm1fY3J0Yy5jDQorKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9jcnRjLmMN
CkBAIC0zMzQsNiArMzM0LDcgQEAgc3RhdGljIGludCBtdGtfY3J0Y19kZHBfaHdfaW5pdChzdHJ1
Y3QgbXRrX2RybV9jcnRjICptdGtfY3J0YykNCiBzdGF0aWMgdm9pZCBtdGtfY3J0Y19kZHBfaHdf
ZmluaShzdHJ1Y3QgbXRrX2RybV9jcnRjICptdGtfY3J0YykNCiB7DQogCXN0cnVjdCBkcm1fZGV2
aWNlICpkcm0gPSBtdGtfY3J0Yy0+YmFzZS5kZXY7DQorCXN0cnVjdCBkcm1fY3J0YyAqY3J0YyA9
ICZtdGtfY3J0Yy0+YmFzZTsNCiAJaW50IGk7DQogDQogCURSTV9ERUJVR19EUklWRVIoIiVzXG4i
LCBfX2Z1bmNfXyk7DQpAQCAtMzU3LDYgKzM1OCwxMyBAQCBzdGF0aWMgdm9pZCBtdGtfY3J0Y19k
ZHBfaHdfZmluaShzdHJ1Y3QgbXRrX2RybV9jcnRjICptdGtfY3J0YykNCiAJbXRrX2Rpc3BfbXV0
ZXhfdW5wcmVwYXJlKG10a19jcnRjLT5tdXRleCk7DQogDQogCXBtX3J1bnRpbWVfcHV0KGRybS0+
ZGV2KTsNCisNCisJaWYgKGNydGMtPnN0YXRlLT5ldmVudCAmJiAhY3J0Yy0+c3RhdGUtPmFjdGl2
ZSkgew0KKwkJc3Bpbl9sb2NrX2lycSgmY3J0Yy0+ZGV2LT5ldmVudF9sb2NrKTsNCisJCWRybV9j
cnRjX3NlbmRfdmJsYW5rX2V2ZW50KGNydGMsIGNydGMtPnN0YXRlLT5ldmVudCk7DQorCQljcnRj
LT5zdGF0ZS0+ZXZlbnQgPSBOVUxMOw0KKwkJc3Bpbl91bmxvY2tfaXJxKCZjcnRjLT5kZXYtPmV2
ZW50X2xvY2spOw0KKwl9DQogfQ0KIA0KIHN0YXRpYyB2b2lkIG10a19jcnRjX2RkcF9jb25maWco
c3RydWN0IGRybV9jcnRjICpjcnRjKQ0KLS0gDQoyLjE4LjANCg==

