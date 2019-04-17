Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E777AC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 13:32:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B742F2173C
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 13:32:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732294AbfDQNce (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 09:32:34 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:57425 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729356AbfDQNce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 09:32:34 -0400
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1hGkfm-0003SU-5Y; Wed, 17 Apr 2019 15:32:22 +0200
Message-ID: <1555507937.6446.10.camel@pengutronix.de>
Subject: Re: [PATCH 02/20] drm: Remove users of
 drm_format_(horz|vert)_chroma_subsampling
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org,
        Emil Velikov <emil.velikov@collabora.com>
Date:   Wed, 17 Apr 2019 15:32:17 +0200
In-Reply-To: <749889cdf957406c86c1791c5bc2a00c3cb1be53.1555487650.git-series.maxime.ripard@bootlin.com>
References: <cover.8ec406bf8f4f097e9dc909d5aac466556822f592.1555487650.git-series.maxime.ripard@bootlin.com>
         <749889cdf957406c86c1791c5bc2a00c3cb1be53.1555487650.git-series.maxime.ripard@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-04-17 at 09:54 +0200, Maxime Ripard wrote:
> drm_format_horz_chroma_subsampling and drm_format_vert_chroma_subsampling
> are basically a lookup in the drm_format_info table plus an access to the
> hsub and vsub fields of the appropriate entry.
> 
> Most drivers are using this function while having access to the entry
> already, which means that we will perform an unnecessary lookup. Removing
> the call to these functions is therefore more efficient.
> 
> Some drivers will not have access to that entry in the function, but in
> this case the overhead is minimal (we just have to call drm_format_info()
> to perform the lookup) and we can even avoid multiple, inefficient lookups
> in some places that need multiple fields from the drm_format_info
> structure.
> 
> This is amplified by the fact that most of the time the callers will have
> to retrieve both the vsub and hsub fields, meaning that they would perform
> twice the lookup.
> 
> Reviewed-by: Emil Velikov <emil.velikov@collabora.com>
> Reviewed-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

Just one small suggestion:

[...]
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> index 20a9c296d027..345d5cb5e956 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> @@ -317,21 +317,18 @@ static void scl_vop_cal_scl_fac(struct vop *vop, const struct vop_win_data *win,
>  			     uint32_t src_w, uint32_t src_h, uint32_t dst_w,
>  			     uint32_t dst_h, uint32_t pixel_format)
>  {
> +	const struct drm_format_info *info = drm_format_info(pixel_format);

The only call site in vop_plane_atomic_update passes fb->format->format
as pixel_format parameter, so this could be simplified even further by
replacing the uint32_t pixelformat argument with a const struct
drm_format_info *info, and passing fb->format directly instead.

regards
Philipp
