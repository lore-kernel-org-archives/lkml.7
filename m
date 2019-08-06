Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BE4FC31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 15:46:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38FE820C01
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 15:46:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732908AbfHFPqd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 11:46:33 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:44598 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726373AbfHFPqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 11:46:33 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 49FFE80475;
        Tue,  6 Aug 2019 17:46:29 +0200 (CEST)
Date:   Tue, 6 Aug 2019 17:46:27 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel@lists.freedesktop.org,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        open list <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@linux.ie>, tzimmermann@suse.de,
        Sean Paul <sean@poorly.run>
Subject: Re: [PATCH 1/3] drm: add gem ttm helpers
Message-ID: <20190806154627.GA10478@ravnborg.org>
References: <20190806133454.8254-1-kraxel@redhat.com>
 <20190806133454.8254-2-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806133454.8254-2-kraxel@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=VcLZwmh9 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=20KFwNOVAAAA:8
        a=IZVlWtmyn-D7wekicaMA:9 a=CjuIK1q_8ugA:10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gerd.

On Tue, Aug 06, 2019 at 03:34:52PM +0200, Gerd Hoffmann wrote:
> Now with ttm_buffer_object being a subclass of drm_gem_object we can
> easily lookup ttm_buffer_object for a given drm_gem_object, which in
> turm allows to create common helper functions.  This patch starts off
> with dump mmap helpers.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

One nit below.

> ---
>  include/drm/drm_gem_ttm_helper.h     | 27 +++++++++++++++
>  drivers/gpu/drm/drm_gem_ttm_helper.c | 52 ++++++++++++++++++++++++++++
>  drivers/gpu/drm/Kconfig              |  7 ++++
>  drivers/gpu/drm/Makefile             |  3 ++
>  4 files changed, 89 insertions(+)
>  create mode 100644 include/drm/drm_gem_ttm_helper.h
>  create mode 100644 drivers/gpu/drm/drm_gem_ttm_helper.c
> 
> diff --git a/include/drm/drm_gem_ttm_helper.h b/include/drm/drm_gem_ttm_helper.h
> new file mode 100644
> index 000000000000..2c6874190b17
> --- /dev/null
> +++ b/include/drm/drm_gem_ttm_helper.h
> @@ -0,0 +1,27 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +
> +#ifndef DRM_GEM_TTM_HELPER_H
> +#define DRM_GEM_TTM_HELPER_H
> +
> +#include <drm/drm_gem.h>
> +#include <drm/ttm/ttm_bo_api.h>
> +#include <linux/kernel.h> /* for container_of() */

The typical order of include files is:

#include <linux/*>

#include <drm/*>

So space between each block of includes and sort within each block.

The comment "/* for container_of() */" is not really useful for
anyone.

	Sam
