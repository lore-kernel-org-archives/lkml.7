Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0041C10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 03:10:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7D2421773
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 03:10:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729391AbfDQDKX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 23:10:23 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:53311 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726946AbfDQDKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 23:10:23 -0400
X-UUID: caff947aba394d54aec74b8af7cf43b7-20190417
X-UUID: caff947aba394d54aec74b8af7cf43b7-20190417
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 841935205; Wed, 17 Apr 2019 11:10:09 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 17 Apr 2019 11:10:07 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 17 Apr 2019 11:10:07 +0800
Message-ID: <1555470607.16005.12.camel@mtksdaap41>
Subject: Re: [PATCH v1 0/4] make hdmi work on bananapi-r2
From:   CK Hu <ck.hu@mediatek.com>
To:     Frank Wunderlich <frank-w@public-files.de>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>,
        chunhui dai <chunhui.dai@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>
Date:   Wed, 17 Apr 2019 11:10:07 +0800
In-Reply-To: <20190416145848.11932-1-frank-w@public-files.de>
References: <20190416145848.11932-1-frank-w@public-files.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-SNTS-SMTP: 99C8C695C00BE1498F28D75BB209642C1DFFA3ED41B2D58F321499A3CD20CA382000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Frank:

On Tue, 2019-04-16 at 16:58 +0200, Frank Wunderlich wrote:
> This Patch-Series adds missing Patches/Bugfixes to get hdmi working on BPI-R2
> 
> first 2 Patches were already posted, but not yet merged into mainline
> i found no hint why
> - config component output by device node port
>   https://patchwork.kernel.org/patch/10609007/
> - add display subsystem related device nodes (resend)
>   https://patchwork.kernel.org/patch/10588951/
> 

These patches need to modify binding document and need long term
discuss. I have an idea not to modify binding document so you could be
quicker to merge these patches. The idea is:

1. Keep the patch 'drm/mediatek: fix possible_crtcs', let DPI encoder
support both crtc0 and crtc1.
2. For encoder and crtc, it could find each other by encoder->crtc and
crtc->encoder_mask to configure hardware correctly.

Regards,
CK

> Bibby Hsieh (1):
>   drm/mediatek: config component output by device node port
> 
> Ryder Lee (2):
>   arm: dts: mt7623: add display subsystem related device nodes
>   drm/mediatek: fix possible_crtcs
> 
> chunhui dai (1):
>   drm/mediatek: fix boot up for 720 and 480 but 1080
> 
>  arch/arm/boot/dts/mt7623.dtsi                 | 177 ++++++++++++++++++
>  arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts |  85 +++++++++
>  arch/arm/boot/dts/mt7623n-rfb-emmc.dts        |  85 +++++++++
>  drivers/gpu/drm/mediatek/mtk_dpi.c            |   2 +-
>  drivers/gpu/drm/mediatek/mtk_drm_drv.c        |  41 +++-
>  drivers/gpu/drm/mediatek/mtk_drm_drv.h        |   4 +-
>  drivers/gpu/drm/mediatek/mtk_hdmi_phy.c       |   3 +
>  drivers/gpu/drm/mediatek/mtk_hdmi_phy.h       |   1 +
>  .../gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c    |   1 +
>  9 files changed, 390 insertions(+), 9 deletions(-)
> 
> --
> 2.17.1
> 


