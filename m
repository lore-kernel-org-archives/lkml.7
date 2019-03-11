Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F4EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 09:56:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 314AF20857
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 09:56:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbfCKJ4v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 05:56:51 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:53700 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbfCKJ4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 05:56:50 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 46A2326048B;
        Mon, 11 Mar 2019 09:56:47 +0000 (GMT)
Date:   Mon, 11 Mar 2019 10:56:42 +0100
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Helen Koike <helen.koike@collabora.com>
Cc:     dri-devel@lists.freedesktop.org, nicholas.kazlauskas@amd.com,
        andrey.grodzovsky@amd.com, daniel.vetter@ffwll.ch,
        linux-kernel@vger.kernel.org, Tomasz Figa <tfiga@chromium.org>,
        David Airlie <airlied@linux.ie>,
        Sean Paul <seanpaul@google.com>, kernel@collabora.com,
        harry.wentland@amd.com,
        =?UTF-8?B?U3TDqXBoYW5l?= Marchesin <marcheu@google.com>,
        Eric Anholt <eric@anholt.net>
Subject: Re: [PATCH 5/5] drm/vc4: fix fb references in async update
Message-ID: <20190311105642.44816e7b@collabora.com>
In-Reply-To: <20190304144909.6267-6-helen.koike@collabora.com>
References: <20190304144909.6267-1-helen.koike@collabora.com>
        <20190304144909.6267-6-helen.koike@collabora.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Eric (the VC4 driver maintainer)

Hello Helen,

On Mon,  4 Mar 2019 11:49:09 -0300
Helen Koike <helen.koike@collabora.com> wrote:

> Async update callbacks are expected to set the old_fb in the new_state
> so prepare/cleanup framebuffers are balanced.
> 
> Calling drm_atomic_set_fb_for_plane() (which gets a reference of the new
> fb and put the old fb) is not required, as it's taken care by
> drm_mode_cursor_universal() when calling drm_atomic_helper_update_plane().
> 
> Cc: <stable@vger.kernel.org> # v4.19+: 25dc194b34dd: drm: Block fb changes for async plane updates
> Cc: <stable@vger.kernel.org> # v4.19+: 8105bbaf9afd: drm: don't block fb changes for async plane updates

Hm, the commit hash you give here will change when applied to the DRM
tree. I think there's a standard way to express dependencies between
patches that needs to be applied to stable, but I'm not sure you need
to describe that since Greg picks patches in the order they appear in
Linus' tree and those patches will be applied in the right order.

Another option if you want to keep things simple is to squash all
changes in a single patch ;).

> Fixes: 25dc194b34dd ("drm: Block fb changes for async plane updates")

Nitpicking: this Fixes tag is a bit of lie since you're actually fixing a
mistake that was introduced when async update support was added to VC4.
Commit 25dc194b34dd only added a new constraint to fix the initial
problem.

So I'd suggest:

Fixes: 539c320bfa97 ("drm/vc4: update cursors asynchronously through atomic")

BTW, the same applies to other patches in this series.

> Suggested-by: Boris Brezillon <boris.brezillon@collabora.com>

Other than that,

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

Regards,

Boris

> Signed-off-by: Helen Koike <helen.koike@collabora.com>
> 
> ---
> Hello,
> 
> As mentioned in the cover letter,
> I tested on the rockchip and on i915 using igt plane_cursor_legacy and
> kms_cursor_legacy and I didn't see any regressions.
> But I couldn't test on VC4. I have a Raspberry pi model B rev2, when
> FB_SIMPLE is running I can see output on the screen, but when vc4 is
> loaded my hdmi display is not detected anymore, I am still debugging
> this, probably some config in the firmware, but I would appreciate if
> anyone could help me testing it.
> 
> Also the Cc statble commit hash dependency needs to be updated once the
> refered commit is merged.
> 
> Thanks!
> Helen
> 
>  drivers/gpu/drm/vc4/vc4_plane.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/vc4/vc4_plane.c b/drivers/gpu/drm/vc4/vc4_plane.c
> index 1babfeca0c92..1235e53b22a3 100644
> --- a/drivers/gpu/drm/vc4/vc4_plane.c
> +++ b/drivers/gpu/drm/vc4/vc4_plane.c
> @@ -968,7 +968,7 @@ static void vc4_plane_atomic_async_update(struct drm_plane *plane,
>  {
>  	struct vc4_plane_state *vc4_state, *new_vc4_state;
>  
> -	drm_atomic_set_fb_for_plane(plane->state, state->fb);
> +	swap(plane->state->fb, state->fb);
>  	plane->state->crtc_x = state->crtc_x;
>  	plane->state->crtc_y = state->crtc_y;
>  	plane->state->crtc_w = state->crtc_w;

