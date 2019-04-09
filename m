Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79B18C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 09:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 531462084F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 09:55:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbfDIJzH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 05:55:07 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:48239 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726091AbfDIJzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 05:55:06 -0400
X-UUID: 9d811f41075f4480b6f030b159cf0e77-20190409
X-UUID: 9d811f41075f4480b6f030b159cf0e77-20190409
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1393709304; Tue, 09 Apr 2019 17:55:02 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 9 Apr 2019 17:55:00 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 9 Apr 2019 17:55:00 +0800
Message-ID: <1554803700.4573.2.camel@mtksdaap41>
Subject: Re: [PATCH V10 0/5] make mt7623 clock of hdmi stable
From:   CK Hu <ck.hu@mediatek.com>
To:     wangyan wang <wangyan.wang@mediatek.com>
CC:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Philipp Zabel" <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        "Daniel Vetter" <daniel@ffwll.ch>,
        chunhui dai <chunhui.dai@mediatek.com>,
        "Colin Ian King" <colin.king@canonical.com>,
        Sean Wang <sean.wang@mediatek.com>,
        "Ryder Lee" <ryder.lee@mediatek.com>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <dri-devel@lists.freedesktop.org>, <srv_heupstream@mediatek.com>
Date:   Tue, 9 Apr 2019 17:55:00 +0800
In-Reply-To: <20190409065307.82280-1-wangyan.wang@mediatek.com>
References: <20190409065307.82280-1-wangyan.wang@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-SNTS-SMTP: A9E3ABC3D003D8A67525A74E6C1333482FF6F4303CB99A21F1AB2EC1BD8EE2BD2000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Wangyan:

This version still has alignment problem, but I've fixed it and for this
series,

Applied to mediatek-drm-fixes-5.1 [1], thanks.

[1]
https://github.com/ckhu-mediatek/linux.git-tags/commits/mediatek-drm-fixes-5.1

Regards,
CK

On Tue, 2019-04-09 at 14:53 +0800, wangyan wang wrote:
> From: Wangyan Wang <wangyan.wang@mediatek.com>
> 
> V10 adopt maintainer's suggestion.
> Here is the change list between V9 & V10
> 
> 1. Align the first character to the right of '(' in
> mtk_hdmi_phy_clk_get_data() of "drm/mediatek: remove flag ..."
> 2. Align the first character to the right of '(' in
> mtk_hdmi_pll_recalc_rate() of "drm/mediatek: make implementation ..." 
> 3. Align the first character to the right of '(' in
> mtk_hdmi_pll_round_rate() of "drm/mediatek: no change ..."
> 4. move patch " drm/mediatek: make implementation ..." before
> patch "drm/mediatek: no change parent ..." 
> 5. To make MT2701 HDMI stable, TVDPLL should not be adjusted and
> it's the parent clock of HDMI phy, so HDMI phy could not adjust parent
> rate. there are 3 steps to make MT2701 HDMI stable.
>     1). remove flag CLK_SET_RATE_PARENT for mt2701 hdmi phy to not propagate
> rate change to parent in "drm/mediatek: remove flag ...".
>     2). Using new factor for tvdpll in mt2701 to match divider of DPI in
> mt2701 in "drm/mediatek: using new...".
>     3). No change parent rate in round_rate() for mt2701 hdmi phy in
> "drm/mediatek: no change parent...".
> 
> 6. Recalculate the rate of this clock, by querying hardware to
> make implementation of recalc_rate() to match the definition.
> 
> Wangyan Wang (5):
>   drm/mediatek: remove flag CLK_SET_RATE_PARENT for mt2701 hdmi phy
>   drm/mediatek: fix the rate and divder of hdmi phy for MT2701
>   drm/mediatek: using new factor for tvdpll in MT2701
>   drm/mediatek: make implementation of recalc_rate() to match the definition
>   drm/mediatek: no change parent rate in round_rate() for mt2701 hdmi phy
> 
>  03_27_ck.diff                                  | 91 ++++++++++++++++++++++++
>  drivers/gpu/drm/mediatek/mtk_dpi.c             |  8 +--
>  drivers/gpu/drm/mediatek/mtk_hdmi_phy.c        | 35 ++--------
>  drivers/gpu/drm/mediatek/mtk_hdmi_phy.h        |  5 +-
>  drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c | 50 ++++++++++++--
>  drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c | 23 +++++++
>  patch1.diff                                    | 75 ++++++++++++++++++++
>  patch_5_4.diff                                 | 95 ++++++++++++++++++++++++++
>  remove_parent_flag.diff                        | 75 ++++++++++++++++++++
>  9 files changed, 412 insertions(+), 45 deletions(-)
>  create mode 100644 03_27_ck.diff
>  create mode 100644 patch1.diff
>  create mode 100644 patch_5_4.diff
>  create mode 100644 remove_parent_flag.diff
> 


