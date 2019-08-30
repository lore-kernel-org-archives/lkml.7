Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4296FC3A5A3
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 07:38:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19EB9215EA
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 07:38:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728201AbfH3Hia (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 03:38:30 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:10953 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726716AbfH3Hi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 03:38:29 -0400
X-UUID: 3cf16ed45a174c4c93b9cb58684c7032-20190830
X-UUID: 3cf16ed45a174c4c93b9cb58684c7032-20190830
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <bibby.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 98995751; Fri, 30 Aug 2019 15:38:24 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 30 Aug 2019 15:38:27 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 30 Aug 2019 15:38:27 +0800
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
        Bibby Hsieh <bibby.hsieh@mediatek.com>
Subject: [PATCH 0/2] drm/mediatek: fixup cursor moving unsmooth issue
Date:   Fri, 30 Aug 2019 15:38:17 +0800
Message-ID: <20190830073819.16566-1-bibby.hsieh@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches can fixup cursor moving is not smooth when heavy load in
webgl.

Bibby Hsieh (2):
  drm/mediatek: Only block updates to CRTCs that have a pending update
  drm/mediatek: Bypass atomic helpers for cursor updates

 drivers/gpu/drm/mediatek/mtk_drm_crtc.c  |  53 +++++-
 drivers/gpu/drm/mediatek/mtk_drm_crtc.h  |   2 +
 drivers/gpu/drm/mediatek/mtk_drm_drv.c   | 214 ++++++++++++++++++++---
 drivers/gpu/drm/mediatek/mtk_drm_drv.h   |  15 +-
 drivers/gpu/drm/mediatek/mtk_drm_plane.c |  73 +++++++-
 5 files changed, 330 insertions(+), 27 deletions(-)

-- 
2.18.0

