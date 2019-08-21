Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10C2BC3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 18:30:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBFD02339E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 18:30:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728858AbfHUSax (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 14:30:53 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:52254 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbfHUSax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 14:30:53 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:b93f:9fae:b276:a89a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 9AD3C2699FC;
        Wed, 21 Aug 2019 19:30:51 +0100 (BST)
Date:   Wed, 21 Aug 2019 20:30:47 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     a.hajda@samsung.com, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@siol.net,
        linux-amlogic@lists.infradead.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC 00/11] drm/bridge: dw-hdmi: implement bus-format
 negotiation and YUV420 support
Message-ID: <20190821203047.06730da4@collabora.com>
In-Reply-To: <20190820084109.24616-1-narmstrong@baylibre.com>
References: <20190820084109.24616-1-narmstrong@baylibre.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Aug 2019 10:40:58 +0200
Neil Armstrong <narmstrong@baylibre.com> wrote:

> This patchset is based on Boris's "drm: Add support for bus-format negotiation" RFC at [1]

Small clarification. Neil's work in based on a slightly different
version of my RFC [4] (I plan to post a v2 very soon).

> patchset to implement :
> - basic bus-format negotiation for DW-HDMI
> - advanced HDMI2.0 YUV420 bus-format negotiation for DW-HDMI
> 
> And the counterpart implementation in the Amlogic Meson VPU dw-hdmi glue :
> - basic bus-format negotiation to select YUV444 bus-format as DW-HDMI input
> - YUV420 support when HDMI2.0 YUV420 modeset
> 
> This is a follow-up from the previous attempts :
> - "drm/meson: Add support for HDMI2.0 YUV420 4k60" at [2]
> - "drm/meson: Add support for HDMI2.0 4k60" at [3]
> 
> [1] https://patchwork.freedesktop.org/patch/msgid/20190808151150.16336-1-boris.brezillon@collabora.com
> [2] https://patchwork.freedesktop.org/patch/msgid/20190520133753.23871-1-narmstrong@baylibre.com
> [3] https://patchwork.freedesktop.org/patch/msgid/1549022873-40549-1-git-send-email-narmstrong@baylibre.com

[4]https://github.com/bbrezillon/linux-0day/commits/drm-bridge-busfmt-2

> 
> Neil Armstrong (11):
>   fixup! drm/bridge: Add the necessary bits to support bus format
>     negotiation
>   drm/meson: venc: make drm_display_mode const
>   drm/meson: meson_dw_hdmi: switch to drm_bridge_funcs
>   drm/bridge: synopsys: dw-hdmi: add basic bridge_atomic_check
>   drm/bridge: synopsys: dw-hdmi: use negociated bus formats
>   drm/meson: dw-hdmi: stop enforcing input_bus_format
>   drm/bridge: dw-hdmi: allow ycbcr420 modes for >= 0x200a
>   drm/bridge: synopsys: dw-hdmi: add 420 mode format negociation
>   drm/meson: venc: add support for YUV420 setup
>   drm/meson: vclk: add support for YUV420 setup
>   drm/meson: Add YUV420 output support
> 
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c |  97 +++++++++++++++-
>  drivers/gpu/drm/drm_bridge.c              |   6 +-
>  drivers/gpu/drm/meson/meson_dw_hdmi.c     | 135 +++++++++++++++++-----
>  drivers/gpu/drm/meson/meson_vclk.c        |  93 +++++++++++----
>  drivers/gpu/drm/meson/meson_vclk.h        |   7 +-
>  drivers/gpu/drm/meson/meson_venc.c        |   8 +-
>  drivers/gpu/drm/meson/meson_venc.h        |  13 ++-
>  drivers/gpu/drm/meson/meson_venc_cvbs.c   |   3 +-
>  include/drm/bridge/dw_hdmi.h              |   1 +
>  9 files changed, 295 insertions(+), 68 deletions(-)
> 

