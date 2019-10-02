Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FA38C10F14
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 18:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51DBA21D82
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 18:30:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728873AbfJBSaR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 14:30:17 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:42682 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbfJBSaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 14:30:17 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 92514807B3;
        Wed,  2 Oct 2019 20:30:12 +0200 (CEST)
Date:   Wed, 2 Oct 2019 20:30:11 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Cc:     dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
        kernel@collabora.com, Sean Paul <sean@poorly.run>
Subject: Re: [PATCH] drm: Fix comment doc for format_modifiers
Message-ID: <20191002183011.GA29177@ravnborg.org>
References: <20191002154349.26895-1-andrzej.p@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191002154349.26895-1-andrzej.p@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=VcLZwmh9 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=QX4gbG5DAAAA:8
        a=-ltbIxTN5rU7bLVlyRIA:9 a=CjuIK1q_8ugA:10 a=AbAUZ8qAyYyZVLSsDulk:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrzej

Always good to have clear documentation.

On Wed, Oct 02, 2019 at 05:43:49PM +0200, Andrzej Pietrasiewicz wrote:
> To human readers
> 
> "array of struct drm_format modifiers" is almost indistinguishable from
> "array of struct drm_format_modifiers", especially given that
> struct drm_format_modifier does exist.
> 
> And indeed the parameter passes an array of uint64_t rather than an array
> of structs, but the first words of the comment suggest that it passes
> an array of structs.
> 
> Signed-off-by: Andrzej Pietrasiewicz <andrzej.p@collabora.com>
> ---
>  drivers/gpu/drm/drm_plane.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_plane.c b/drivers/gpu/drm/drm_plane.c
> index d6ad60ab0d38..df05d8a0dd63 100644
> --- a/drivers/gpu/drm/drm_plane.c
> +++ b/drivers/gpu/drm/drm_plane.c
> @@ -160,7 +160,7 @@ static int create_in_format_blob(struct drm_device *dev, struct drm_plane *plane
>   * @funcs: callbacks for the new plane
>   * @formats: array of supported formats (DRM_FORMAT\_\*)
>   * @format_count: number of elements in @formats
> - * @format_modifiers: array of struct drm_format modifiers terminated by
> + * @format_modifiers: array of modifiers of struct drm_format terminated by
>   *                    DRM_FORMAT_MOD_INVALID
@format_modifiers is an array of DRM_FORMAT_* which are defined as:

#define fourcc_code(a, b, c, d) ((__u32)(a) | ((__u32)(b) << 8) | \
                                 ((__u32)(c) << 16) | ((__u32)(d) << 24))


But the array is a u64[] like this:
static const u64 tegra20_modifiers[] = {
        DRM_FORMAT_MOD_LINEAR,
        DRM_FORMAT_MOD_NVIDIA_TEGRA_TILED,
        DRM_FORMAT_MOD_INVALID
};

So this is not struct drm_format.

Can you try to give it a shot more?

	Sam
