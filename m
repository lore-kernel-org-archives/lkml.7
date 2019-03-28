Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C3AC10F00
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 03:15:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F8CF206C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 03:15:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbfC1DPY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 23:15:24 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:25559 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725948AbfC1DPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 23:15:23 -0400
X-UUID: b4c0625b9b994ffab9735c852d1169a5-20190328
X-UUID: b4c0625b9b994ffab9735c852d1169a5-20190328
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 912598281; Thu, 28 Mar 2019 11:15:16 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 28 Mar 2019 11:15:09 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 28 Mar 2019 11:15:09 +0800
Message-ID: <1553742909.10649.1.camel@mtkswgap22>
Subject: Re: [PATCH V7 0/6] make mt7623 clock of hdmi stable
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     wangyan wang <wangyan.wang@mediatek.com>
CC:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, CK Hu <ck.hu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "David Airlie" <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        chunhui dai <chunhui.dai@mediatek.com>,
        Colin Ian King <colin.king@canonical.com>,
        "Sean Wang" <sean.wang@mediatek.com>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <dri-devel@lists.freedesktop.org>, <srv_heupstream@mediatek.com>
Date:   Thu, 28 Mar 2019 11:15:09 +0800
In-Reply-To: <20190327091929.73162-1-wangyan.wang@mediatek.com>
References: <20190327091929.73162-1-wangyan.wang@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-TM-SNTS-SMTP: 6527065A0EFD741AAEDA97DE63AEF371E2CED00C2E09EC8E80D97158B30C61312000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-03-27 at 17:19 +0800, wangyan wang wrote:
> From: Wangyan Wang <wangyan.wang@mediatek.com>
> 
> V7 adopt maintainer's suggestion.
> Here is the change list between V6 & V7
> 
> 1. use readl directly & delete hdmi_phy->pll_rate in
> mtk_hdmi_pll_recalc_rate(). 
> in "drm/mediatek: recalculate hdmi ..."
> 
> 2. detele mtk_hdmi_phy_read() in mtk_hdmi_phy.c.
> in "fix the rate of parent for hdmi phy in MT2701"
> 
> 3. optimize mtk_hdmi_pll_round_rate().
> in "fix the rate of parent for hdmi phy in MT2701"
> 
> chunhui dai (6):
>   drm/mediatek: recalculate hdmi phy clock of MT2701 by querying
>     hardware
>   drm/mediatek: move the setting of fixed divider
>   drm/mediatek: using different flags of clk for HDMI phy
>   drm/mediatek: fix the rate and divder of hdmi phy for MT2701
>   drm/mediatek: using new factor for tvdpll in MT2701
>   drm/mediatek: fix the rate of parent for hdmi phy in MT2701
> 
>  drivers/gpu/drm/mediatek/mtk_dpi.c             |  8 ++---
>  drivers/gpu/drm/mediatek/mtk_hdmi_phy.c        | 35 +++---------------
>  drivers/gpu/drm/mediatek/mtk_hdmi_phy.h        |  6 +---
>  drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c | 50 ++++++++++++++++++++++----
>  drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c | 23 ++++++++++++
>  5 files changed, 76 insertions(+), 46 deletions(-)
> 

The series could not work on v5.1. Please check it out.

