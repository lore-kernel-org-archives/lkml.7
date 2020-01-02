Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C154C3276C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 04:02:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D446420863
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 04:02:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="YRXWgZRv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727684AbgABEC1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jan 2020 23:02:27 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:58755 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727509AbgABECY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jan 2020 23:02:24 -0500
X-UUID: 29a8d5606fe24bb4b82f01b36c416b86-20200102
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=IfNj7/vkSOAhM9QXMukLIxwSiptg5mKPbuqXVH09pWs=;
        b=YRXWgZRvsxv8B2hIXfPr6uN9AyvrJLLFR9bx7z7uPgcAbauDJZzodTM4qrPZ9G1/6gmJEa+Dpx8cKiM+7PZm9w0d6gdUVvFY/v1WC9c+9Hv8FyZc2kVtWzkLsvLTVFqcP5UXCgFO70DeScA2ne32wTk0GGtOX8/zG7hKO0G2R30=;
X-UUID: 29a8d5606fe24bb4b82f01b36c416b86-20200102
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw02.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 740244194; Thu, 02 Jan 2020 12:02:16 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 2 Jan 2020 12:01:45 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 2 Jan 2020 12:01:34 +0800
From:   Yongqiang Niu <yongqiang.niu@mediatek.com>
To:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>
Subject: [PATCH v6, 02/14] drm/mediatek: move dsi/dpi select input into mtk_ddp_sel_in
Date:   Thu, 2 Jan 2020 12:00:12 +0800
Message-ID: <1577937624-14313-3-git-send-email-yongqiang.niu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1577937624-14313-1-git-send-email-yongqiang.niu@mediatek.com>
References: <1577937624-14313-1-git-send-email-yongqiang.niu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bW92ZSBkc2kvZHBpIHNlbGVjdCBpbnB1dCBpbnRvIG10a19kZHBfc2VsX2luDQoNClNpZ25lZC1v
ZmYtYnk6IFlvbmdxaWFuZyBOaXUgPHlvbmdxaWFuZy5uaXVAbWVkaWF0ZWsuY29tPg0KLS0tDQog
ZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZGRwLmMgfCAxMCArKysrKystLS0tDQog
MSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCg0KZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2RkcC5jIGIvZHJpdmVycy9n
cHUvZHJtL21lZGlhdGVrL210a19kcm1fZGRwLmMNCmluZGV4IDM5NzAwYjkuLjkxYzliMTkgMTAw
NjQ0DQotLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kZHAuYw0KKysrIGIv
ZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZGRwLmMNCkBAIC0zNzYsNiArMzc2LDEy
IEBAIHN0YXRpYyB1bnNpZ25lZCBpbnQgbXRrX2RkcF9zZWxfaW4oZW51bSBtdGtfZGRwX2NvbXBf
aWQgY3VyLA0KIAl9IGVsc2UgaWYgKGN1ciA9PSBERFBfQ09NUE9ORU5UX0JMUyAmJiBuZXh0ID09
IEREUF9DT01QT05FTlRfRFNJMCkgew0KIAkJKmFkZHIgPSBESVNQX1JFR19DT05GSUdfRFNJX1NF
TDsNCiAJCXZhbHVlID0gRFNJX1NFTF9JTl9CTFM7DQorCX0gZWxzZSBpZiAoY3VyID09IEREUF9D
T01QT05FTlRfUkRNQTEgJiYgbmV4dCA9PSBERFBfQ09NUE9ORU5UX0RTSTApIHsNCisJCSphZGRy
ID0gRElTUF9SRUdfQ09ORklHX0RTSV9TRUw7DQorCQl2YWx1ZSA9IERTSV9TRUxfSU5fUkRNQTsN
CisJfSBlbHNlIGlmIChjdXIgPT0gRERQX0NPTVBPTkVOVF9CTFMgJiYgbmV4dCA9PSBERFBfQ09N
UE9ORU5UX0RQSTApIHsNCisJCSphZGRyID0gRElTUF9SRUdfQ09ORklHX0RQSV9TRUw7DQorCQl2
YWx1ZSA9IERQSV9TRUxfSU5fQkxTOw0KIAl9IGVsc2Ugew0KIAkJdmFsdWUgPSAwOw0KIAl9DQpA
QCAtMzkzLDEwICszOTksNiBAQCBzdGF0aWMgdm9pZCBtdGtfZGRwX3NvdXRfc2VsKHN0cnVjdCBy
ZWdtYXAgKmNvbmZpZ19yZWdzLA0KIAl9IGVsc2UgaWYgKGN1ciA9PSBERFBfQ09NUE9ORU5UX0JM
UyAmJiBuZXh0ID09IEREUF9DT01QT05FTlRfRFBJMCkgew0KIAkJcmVnbWFwX3dyaXRlKGNvbmZp
Z19yZWdzLCBESVNQX1JFR19DT05GSUdfT1VUX1NFTCwNCiAJCQkJQkxTX1RPX0RQSV9SRE1BMV9U
T19EU0kpOw0KLQkJcmVnbWFwX3dyaXRlKGNvbmZpZ19yZWdzLCBESVNQX1JFR19DT05GSUdfRFNJ
X1NFTCwNCi0JCQkJRFNJX1NFTF9JTl9SRE1BKTsNCi0JCXJlZ21hcF93cml0ZShjb25maWdfcmVn
cywgRElTUF9SRUdfQ09ORklHX0RQSV9TRUwsDQotCQkJCURQSV9TRUxfSU5fQkxTKTsNCiAJfQ0K
IH0NCiANCi0tIA0KMS44LjEuMS5kaXJ0eQ0K

