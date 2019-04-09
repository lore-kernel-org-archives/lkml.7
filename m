Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BD03C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 06:53:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 150C021473
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 06:53:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbfDIGx5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 02:53:57 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:47478 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726081AbfDIGx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 02:53:57 -0400
X-UUID: 5cf32289ffdc4524948b1c5951c464b0-20190409
X-UUID: 5cf32289ffdc4524948b1c5951c464b0-20190409
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <wangyan.wang@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 239497021; Tue, 09 Apr 2019 14:53:12 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS33N1.mediatek.inc
 (172.27.4.75) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 9 Apr
 2019 14:53:11 +0800
Received: from mszsdclx1067.gcn.mediatek.inc (172.27.4.253) by
 MTKCAS32.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1395.4 via Frontend Transport; Tue, 9 Apr 2019 14:53:10 +0800
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
Subject: [PATCH V10 0/5] make mt7623 clock of hdmi stable
Date:   Tue, 9 Apr 2019 14:53:02 +0800
Message-ID: <20190409065307.82280-1-wangyan.wang@mediatek.com>
X-Mailer: git-send-email 2.14.1
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wangyan Wang <wangyan.wang@mediatek.com>

V10 adopt maintainer's suggestion.
Here is the change list between V9 & V10

1. Align the first character to the right of '(' in
mtk_hdmi_phy_clk_get_data() of "drm/mediatek: remove flag ..."
2. Align the first character to the right of '(' in
mtk_hdmi_pll_recalc_rate() of "drm/mediatek: make implementation ..." 
3. Align the first character to the right of '(' in
mtk_hdmi_pll_round_rate() of "drm/mediatek: no change ..."
4. move patch " drm/mediatek: make implementation ..." before
patch "drm/mediatek: no change parent ..." 
5. To make MT2701 HDMI stable, TVDPLL should not be adjusted and
it's the parent clock of HDMI phy, so HDMI phy could not adjust parent
rate. there are 3 steps to make MT2701 HDMI stable.
    1). remove flag CLK_SET_RATE_PARENT for mt2701 hdmi phy to not propagate
rate change to parent in "drm/mediatek: remove flag ...".
    2). Using new factor for tvdpll in mt2701 to match divider of DPI in
mt2701 in "drm/mediatek: using new...".
    3). No change parent rate in round_rate() for mt2701 hdmi phy in
"drm/mediatek: no change parent...".

6. Recalculate the rate of this clock, by querying hardware to
make implementation of recalc_rate() to match the definition.

Wangyan Wang (5):
  drm/mediatek: remove flag CLK_SET_RATE_PARENT for mt2701 hdmi phy
  drm/mediatek: fix the rate and divder of hdmi phy for MT2701
  drm/mediatek: using new factor for tvdpll in MT2701
  drm/mediatek: make implementation of recalc_rate() to match the definition
  drm/mediatek: no change parent rate in round_rate() for mt2701 hdmi phy

 03_27_ck.diff                                  | 91 ++++++++++++++++++++++++
 drivers/gpu/drm/mediatek/mtk_dpi.c             |  8 +--
 drivers/gpu/drm/mediatek/mtk_hdmi_phy.c        | 35 ++--------
 drivers/gpu/drm/mediatek/mtk_hdmi_phy.h        |  5 +-
 drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c | 50 ++++++++++++--
 drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c | 23 +++++++
 patch1.diff                                    | 75 ++++++++++++++++++++
 patch_5_4.diff                                 | 95 ++++++++++++++++++++++++++
 remove_parent_flag.diff                        | 75 ++++++++++++++++++++
 9 files changed, 412 insertions(+), 45 deletions(-)
 create mode 100644 03_27_ck.diff
 create mode 100644 patch1.diff
 create mode 100644 patch_5_4.diff
 create mode 100644 remove_parent_flag.diff

-- 
2.14.1

