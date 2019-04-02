Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F2A2C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 09:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 394302082C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 09:36:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729726AbfDBJgS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 05:36:18 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:39230 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729676AbfDBJgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 05:36:18 -0400
X-UUID: 17d815fc41da487ea0cf91aeb07a4736-20190402
X-UUID: 17d815fc41da487ea0cf91aeb07a4736-20190402
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <wangyan.wang@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 951479963; Tue, 02 Apr 2019 17:36:10 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33N1.mediatek.inc
 (172.27.4.75) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 2 Apr
 2019 17:36:08 +0800
Received: from mszsdclx1067.gcn.mediatek.inc (172.27.4.253) by
 MTKCAS36.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1395.4 via Frontend Transport; Tue, 2 Apr 2019 17:36:07 +0800
From:   wangyan wang <wangyan.wang@mediatek.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, CK Hu <ck.hu@mediatek.com>
CC:     wangyan wang <wangyan.wang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        chunhui dai <chunhui.dai@mediatek.com>,
        Colin Ian King <colin.king@canonical.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <dri-devel@lists.freedesktop.org>, <srv_heupstream@mediatek.com>
Subject: [PATCH V8 0/5] make mt7623 clock of hdmi stable
Date:   Tue, 2 Apr 2019 17:36:00 +0800
Message-ID: <20190402093605.82004-1-wangyan.wang@mediatek.com>
X-Mailer: git-send-email 2.14.1
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wangyan Wang <wangyan.wang@mediatek.com>

V8 adopt maintainer's suggestion.
Here is the change list between V7 & V8

1. Make title more clear in patch commit message.

2. To make MT2701 HDMI stable, TVDPLL should not be adjusted and
it's the parent clock of HDMI phy, so HDMI phy could not adjust parent
rate. there are 3 steps to make MT2701 HDMI stable.
    1). remove flag CLK_SET_RATE_PARENT for mt2701 hdmi phy to not propagate
rate change to parent in "drm/mediatek: remove flag ...".
    2). Using new factor for tvdpll in mt2701 to match divider of DPI in
mt2701 in "drm/mediatek: using new...".
    3). No change parent rate in round_rate() for mt2701 hdmi phy in
"drm/mediatek: no change parent...".

3. Recalculate the rate of this clock, by querying hardware to
make implementation of recalc_rate() to match the definition.


Wangyan Wang (5):
  drm/mediatek: remove flag CLK_SET_RATE_PARENT for mt2701 hdmi phy
  drm/mediatek: fix the rate and divder of hdmi phy for MT2701
  drm/mediatek: using new factor for tvdpll in MT2701
  drm/mediatek: no change parent rate in round_rate() for mt2701 hdmi phy
  drm/mediatek: make implementation of recalc_rate() to match the definition

 drivers/gpu/drm/mediatek/mtk_dpi.c             |  8 ++---
 drivers/gpu/drm/mediatek/mtk_hdmi_phy.c        | 35 +++---------------
 drivers/gpu/drm/mediatek/mtk_hdmi_phy.h        |  5 +--
 drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c | 50 ++++++++++++++++++++++----
 drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c | 23 ++++++++++++
 5 files changed, 76 insertions(+), 45 deletions(-)

-- 
2.14.1

