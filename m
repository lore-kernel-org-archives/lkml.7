Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7686C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 01:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC66120684
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 01:52:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728719AbfCFBwh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 20:52:37 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:61242 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726069AbfCFBwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 20:52:36 -0500
X-UUID: 3dfd3b1805e94ed4b8f40d9a1d5f4e7e-20190306
X-UUID: 3dfd3b1805e94ed4b8f40d9a1d5f4e7e-20190306
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 321559164; Wed, 06 Mar 2019 09:52:22 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 6 Mar 2019 09:52:21 +0800
Received: from [172.21.77.4] (172.21.77.4) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 6 Mar 2019 09:52:21 +0800
Message-ID: <1551837141.23995.13.camel@mtksdaap41>
Subject: Re: [PATCH V6 0/8] make mt7623 clock of hdmi stable
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
Date:   Wed, 6 Mar 2019 09:52:21 +0800
In-Reply-To: <20190225020912.29120-1-wangyan.wang@mediatek.com>
References: <20190225020912.29120-1-wangyan.wang@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-02-25 at 10:09 +0800, wangyan wang wrote:
> From: Wangyan Wang <wangyan.wang@mediatek.com>
> 
> V6 adopt maintainer's suggestion.
> Here is the change list between V5 & V6
> 1. change "unsigned char mux_flags;" to "u8 mux_flags;" to
> match with the struct in " clk: mediatek: add MUX_GATE_FLAGS_2".
> 

Hi, Wangyan:

I'm not familiar with this clock system, so I still have some question
about it, if you could describe more clear, it would help us to speed up
this review process.

In [1], I find the clock that dpi and hdmi_phy controls,

	dpi0: dpi@14014000 {
		clocks = <&mmsys CLK_MM_DPI1_DIGL>,
			 <&mmsys CLK_MM_DPI1_ENGINE>,
			 <&topckgen CLK_TOP_TVDPLL>;
		clock-names = "pixel", "engine", "pll";
	};


	hdmi_phy: phy@10209100 {
		clocks = <&apmixedsys CLK_APMIXED_HDMI_REF>;
		clock-names = "pll_ref";
	};

In [2], You say that to prevent changing tvdpll would let hdmi stable,
and this clock is controlled by dpi, why do you modify the control flow
in hdmi_phy? If these two have relationship, please describe more clear
because I'm not familiar with this clock system.

And I think that patch 'drm/mediatek: using new factor for tvdpll in
MT2701' is the major patch to prevent modifying tvdpll because it reduce
the factor case. Does MT8173 has the same problem? Just ask, I does not
require you to modify MT8173 part.

[1]
https://github.com/frank-w/BPI-R2-4.14/blob/663f7def421952eb49b2d698eadaff12d02622d2/arch/arm/boot/dts/mt7623.dtsi
[2]
http://lists.infradead.org/pipermail/linux-mediatek/2019-February/017693.html


Regards,
CK


> 
> chunhui dai (8):
>   drm/mediatek: recalculate hdmi phy clock of MT2701 by querying
>     hardware
>   drm/mediatek: move the setting of fixed divider
>   drm/mediatek: using different flags of clk for HDMI phy
>   drm/mediatek: fix the rate and divder of hdmi phy for MT2701
>   clk: mediatek: add MUX_GATE_FLAGS_2
>   clk: mediatek: using CLK_MUX_ROUND_CLOSEST for the clock of dpi1_sel
>   drm/mediatek: using new factor for tvdpll in MT2701
>   drm/mediatek: fix the rate of parent for hdmi phy in MT2701
> 
>  drivers/clk/mediatek/clk-mt2701.c              |  4 +-
>  drivers/clk/mediatek/clk-mtk.c                 |  2 +-
>  drivers/clk/mediatek/clk-mtk.h                 | 20 ++++++---
>  drivers/gpu/drm/mediatek/mtk_dpi.c             |  8 ++--
>  drivers/gpu/drm/mediatek/mtk_hdmi_phy.c        | 34 ++++------------
>  drivers/gpu/drm/mediatek/mtk_hdmi_phy.h        |  7 +---
>  drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c | 56 +++++++++++++++++++++++---
>  drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c | 23 +++++++++++
>  8 files changed, 102 insertions(+), 52 deletions(-)
> 


