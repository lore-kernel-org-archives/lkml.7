Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B0E4C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 09:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB7D32075C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 09:19:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732333AbfC0JTl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 05:19:41 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:8068 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725768AbfC0JTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 05:19:41 -0400
X-UUID: f7ad7a33b819458eb1713cebf3cc2688-20190327
X-UUID: f7ad7a33b819458eb1713cebf3cc2688-20190327
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <wangyan.wang@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1943863941; Wed, 27 Mar 2019 17:19:37 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS33N1.mediatek.inc
 (172.27.4.75) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 27 Mar
 2019 17:19:35 +0800
Received: from mszsdclx1067.gcn.mediatek.inc (172.27.4.253) by
 MTKCAS32.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1395.4 via Frontend Transport; Wed, 27 Mar 2019 17:19:34 +0800
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
Subject: [PATCH V7 0/6] make mt7623 clock of hdmi stable
Date:   Wed, 27 Mar 2019 17:19:23 +0800
Message-ID: <20190327091929.73162-1-wangyan.wang@mediatek.com>
X-Mailer: git-send-email 2.14.1
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wangyan Wang <wangyan.wang@mediatek.com>

V7 adopt maintainer's suggestion.
Here is the change list between V6 & V7

1. use readl directly & delete hdmi_phy->pll_rate in
mtk_hdmi_pll_recalc_rate(). 
in "drm/mediatek: recalculate hdmi ..."

2. detele mtk_hdmi_phy_read() in mtk_hdmi_phy.c.
in "fix the rate of parent for hdmi phy in MT2701"

3. optimize mtk_hdmi_pll_round_rate().
in "fix the rate of parent for hdmi phy in MT2701"

chunhui dai (6):
  drm/mediatek: recalculate hdmi phy clock of MT2701 by querying
    hardware
  drm/mediatek: move the setting of fixed divider
  drm/mediatek: using different flags of clk for HDMI phy
  drm/mediatek: fix the rate and divder of hdmi phy for MT2701
  drm/mediatek: using new factor for tvdpll in MT2701
  drm/mediatek: fix the rate of parent for hdmi phy in MT2701

 drivers/gpu/drm/mediatek/mtk_dpi.c             |  8 ++---
 drivers/gpu/drm/mediatek/mtk_hdmi_phy.c        | 35 +++---------------
 drivers/gpu/drm/mediatek/mtk_hdmi_phy.h        |  6 +---
 drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c | 50 ++++++++++++++++++++++----
 drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c | 23 ++++++++++++
 5 files changed, 76 insertions(+), 46 deletions(-)

-- 
2.14.1

