Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E24FC32770
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 03:13:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45BB52253D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 03:13:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Oaq4RqCD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727557AbgACDNB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 22:13:01 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:38834 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727468AbgACDMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 22:12:52 -0500
X-UUID: 8a3b57bca418494893e11e8af2680ad9-20200103
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=sZZHfWgfl0uySImCnCNvtUkrGZa7+VsmGsRBi9uuioU=;
        b=Oaq4RqCDR6UbwUvbuxDh7zZf8ekStutQ9leZEgNcMOxTyRPPivXIekhlMG/1LM0Ghk0ezkXof3eyY1+Le8P42v9xBcSi9jAkp90QxnlnclhsCwgiKQjU9k/RFFmsmeZ5LUVAfgz/b+H0vuwV7T7tBu0wmkq84Urwe5yE4N4TZ/A=;
X-UUID: 8a3b57bca418494893e11e8af2680ad9-20200103
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw02.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1765960839; Fri, 03 Jan 2020 11:12:47 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 3 Jan 2020 11:12:15 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 3 Jan 2020 11:13:13 +0800
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
Subject: [RESEND PATCH v6 11/17] drm/mediatek: add connection from RDMA1 to DSI0
Date:   Fri, 3 Jan 2020 11:12:22 +0800
Message-ID: <1578021148-32413-12-git-send-email-yongqiang.niu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1578021148-32413-1-git-send-email-yongqiang.niu@mediatek.com>
References: <1578021148-32413-1-git-send-email-yongqiang.niu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBwYXRjaCBhZGQgY29ubmVjdGlvbiBmcm9tIFJETUExIHRvIERTSTANCg0KU2lnbmVkLW9m
Zi1ieTogWW9uZ3FpYW5nIE5pdSA8eW9uZ3FpYW5nLm5pdUBtZWRpYXRlay5jb20+DQpSZXZpZXdl
ZC1ieTogQ0sgSHUgPGNrLmh1QG1lZGlhdGVrLmNvbT4NCi0tLQ0KIGRyaXZlcnMvZ3B1L2RybS9t
ZWRpYXRlay9tdGtfZHJtX2RkcC5jIHwgNCArKysrDQogMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0
aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1f
ZGRwLmMgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kZHAuYw0KaW5kZXggYjZi
ODY2MDAuLjdiN2UzNjUgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRr
X2RybV9kZHAuYw0KKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZGRwLmMN
CkBAIC0xNzYsNiArMTc2LDcgQEAgc3RydWN0IG10a19tbXN5c19yZWdfZGF0YSB7DQogCXUzMiBy
ZG1hMF9zb3V0X2NvbG9yMDsNCiAJdTMyIHJkbWExX3NvdXRfc2VsX2luOw0KIAl1MzIgcmRtYTFf
c291dF9kcGkwOw0KKwl1MzIgcmRtYTFfc291dF9kc2kwOw0KIAl1MzIgZHBpMF9zZWxfaW47DQog
CXUzMiBkcGkwX3NlbF9pbl9yZG1hMTsNCiAJdTMyIGRzaTBfc2VsX2luOw0KQEAgLTQzNyw2ICs0
MzgsOSBAQCBzdGF0aWMgdW5zaWduZWQgaW50IG10a19kZHBfc291dF9zZWwoY29uc3Qgc3RydWN0
IG10a19tbXN5c19yZWdfZGF0YSAqZGF0YSwNCiAJfSBlbHNlIGlmIChjdXIgPT0gRERQX0NPTVBP
TkVOVF9SRE1BMCAmJiBuZXh0ID09IEREUF9DT01QT05FTlRfQ09MT1IwKSB7DQogCQkqYWRkciA9
IGRhdGEtPnJkbWEwX3NvdXRfc2VsX2luOw0KIAkJdmFsdWUgPSBkYXRhLT5yZG1hMF9zb3V0X2Nv
bG9yMDsNCisJfSBlbHNlIGlmIChjdXIgPT0gRERQX0NPTVBPTkVOVF9SRE1BMSAmJiBuZXh0ID09
IEREUF9DT01QT05FTlRfRFNJMCkgew0KKwkJKmFkZHIgPSBkYXRhLT5yZG1hMV9zb3V0X3NlbF9p
bjsNCisJCXZhbHVlID0gZGF0YS0+cmRtYTFfc291dF9kc2kwOw0KIAl9IGVsc2Ugew0KIAkJdmFs
dWUgPSAwOw0KIAl9DQotLSANCjEuOC4xLjEuZGlydHkNCg==

