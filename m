Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E91D9C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 17:16:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2096206BA
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 17:16:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728934AbfDDRQN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 13:16:13 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:55829 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728479AbfDDRQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 13:16:10 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 14D8F8043E;
        Thu,  4 Apr 2019 19:16:08 +0200 (CEST)
Date:   Thu, 4 Apr 2019 19:16:06 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel@lists.freedesktop.org,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        open list <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@linux.ie>, Sean Paul <sean@poorly.run>
Subject: Re: [PATCH v2 5/6] drm: add drm_fb_xrgb8888_to_rgb888() function to
 drm_fb_helper.c
Message-ID: <20190404171606.GE23897@ravnborg.org>
References: <20190404152430.8263-1-kraxel@redhat.com>
 <20190404152430.8263-6-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190404152430.8263-6-kraxel@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=UpRNyd4B c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=20KFwNOVAAAA:8
        a=RUEspaXhLrfXBLgqDvgA:9 a=CjuIK1q_8ugA:10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gerd.

On Thu, Apr 04, 2019 at 05:24:29PM +0200, Gerd Hoffmann wrote:
> Like drm_fb_xrgb8888_to_rgb565() but converts to 24bpp (DRM_FORMAT_RGB888).
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  include/drm/drm_fb_helper.h     |  4 +++
>  drivers/gpu/drm/drm_fb_helper.c | 49 +++++++++++++++++++++++++++++++++
>  2 files changed, 53 insertions(+)
> 
> diff --git a/include/drm/drm_fb_helper.h b/include/drm/drm_fb_helper.h
> index 1406057e1a93..a6e56fcd948e 100644
> --- a/include/drm/drm_fb_helper.h
> +++ b/include/drm/drm_fb_helper.h
> @@ -648,5 +648,9 @@ void drm_fb_xrgb8888_to_rgb565(u16 *dst, void *vaddr,
>  			       struct drm_framebuffer *fb,
>  			       struct drm_rect *clip,
>  			       bool swap, bool dstclip);
> +void drm_fb_xrgb8888_to_rgb888(u8 *dst, void *vaddr,
> +			       struct drm_framebuffer *fb,
> +			       struct drm_rect *clip,
> +			       bool dstclip);
We have here three functions that take a *dst parameter:

	void *dst
	u8 *dst
	u16 *dst

My OCD triggers when things like this is not consistent.
But that said I see why the three implementations takes three different types.

Something I noticed, so passed in onwards to you.
Feel free to ignore.

	Sam
