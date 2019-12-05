Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA559C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 09:28:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A79824654
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 09:28:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="pwV7PxrH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729224AbfLEJ2T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 04:28:19 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:33876 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729102AbfLEJ16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 04:27:58 -0500
X-UUID: b1466d2943124a3084fad19447f88ba3-20191205
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=3o3Wfx+85Ct3d0biiPy/482nOLIBAS/s4EBtF+buL3o=;
        b=pwV7PxrHWQNubFymaeRFO42LW0Qb718AbtIcEpYF3i2SRUmf6TMZ3FpX/NG9pzGnaFWjE+EzeBy2uwl86woj6ehq4IAfS8RIwONE34VCRnEJ85ITOx7uaHaTLA2LkhCGApQrgxzId2t89x14rhySYoY+LF3D/zFuHVLI5xTcwO8=;
X-UUID: b1466d2943124a3084fad19447f88ba3-20191205
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <bibby.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1179283622; Thu, 05 Dec 2019 17:27:51 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 5 Dec 2019 17:27:44 +0800
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
Subject: [PATCH v4 4/7] drm/mediatek: disable all the planes in atomic_disable
Date:   Thu, 5 Dec 2019 17:27:46 +0800
Message-ID: <20191205092749.4021-5-bibby.hsieh@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20191205092749.4021-1-bibby.hsieh@mediatek.com>
References: <20191205092749.4021-1-bibby.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VW5kZXIgc2hhZG93IHJlZ2lzdGVyIGNhc2UsIHdlIGRvIG5vdCBkaXNhYmxlIGFsbCB0aGUgcGxh
bmUgYmVmb3JlDQpkaXNhYmxlIGFsbCB0aGUgaGFyZHdhcmVzLiBGaXggaXQuDQoNClNpZ25lZC1v
ZmYtYnk6IEJpYmJ5IEhzaWVoIDxiaWJieS5oc2llaEBtZWRpYXRlay5jb20+DQotLS0NCiBkcml2
ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9jcnRjLmMgfCAxICsNCiAxIGZpbGUgY2hhbmdl
ZCwgMSBpbnNlcnRpb24oKykNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRl
ay9tdGtfZHJtX2NydGMuYyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2NydGMu
Yw0KaW5kZXggZTg4N2E2ODc3YmNkLi5lNDBjOGNmN2Q3NGYgMTAwNjQ0DQotLS0gYS9kcml2ZXJz
L2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9jcnRjLmMNCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9t
ZWRpYXRlay9tdGtfZHJtX2NydGMuYw0KQEAgLTU1MCw2ICs1NTAsNyBAQCBzdGF0aWMgdm9pZCBt
dGtfZHJtX2NydGNfYXRvbWljX2Rpc2FibGUoc3RydWN0IGRybV9jcnRjICpjcnRjLA0KIAl9DQog
CW10a19jcnRjLT5wZW5kaW5nX3BsYW5lcyA9IHRydWU7DQogDQorCW10a19kcm1fY3J0Y19od19j
b25maWcobXRrX2NydGMpOw0KIAkvKiBXYWl0IGZvciBwbGFuZXMgdG8gYmUgZGlzYWJsZWQgKi8N
CiAJZHJtX2NydGNfd2FpdF9vbmVfdmJsYW5rKGNydGMpOw0KIA0KLS0gDQoyLjE4LjANCg==

