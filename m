Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87F7DC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 13:31:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F20E2084D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 13:31:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbfDLNbX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 09:31:23 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:34688 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbfDLNbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 09:31:22 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 35BD2281156;
        Fri, 12 Apr 2019 14:31:20 +0100 (BST)
Date:   Fri, 12 Apr 2019 15:31:17 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Helen Koike <helen.koike@collabora.com>
Cc:     dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        dnicoara@chromium.org, daniels@collabora.com,
        alexandros.frantzis@collabora.com, daniel.vetter@ffwll.ch,
        linux-kernel@vger.kernel.org, tomasz Figa <tfiga@chromium.org>,
        tina.zhang@intel.com, Sean Paul <seanpaul@google.com>,
        kernel@collabora.com, nicholas.kazlauskas@amd.com,
        =?UTF-8?B?U3TDqXBoYW5l?= Marchesin <marcheu@google.com>,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        Sean Paul <sean@poorly.run>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v3 1/4] drm/uapi: add documentation for atomic flags
Message-ID: <20190412153117.1333f3d1@collabora.com>
In-Reply-To: <20190412125827.5877-2-helen.koike@collabora.com>
References: <20190412125827.5877-1-helen.koike@collabora.com>
        <20190412125827.5877-2-helen.koike@collabora.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Helen,

On Fri, 12 Apr 2019 09:58:24 -0300
Helen Koike <helen.koike@collabora.com> wrote:

> add a brief description of the flags used in an atomic commit
> 
> Signed-off-by: Helen Koike <helen.koike@collabora.com>
> ---
> 
> Changes in v3: None
> Changes in v2: None
> Changes in v1: None
> 
>  include/uapi/drm/drm_mode.h | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/include/uapi/drm/drm_mode.h b/include/uapi/drm/drm_mode.h
> index 83cd1636b9be..88ef2cf04d13 100644
> --- a/include/uapi/drm/drm_mode.h
> +++ b/include/uapi/drm/drm_mode.h
> @@ -729,7 +729,23 @@ struct drm_mode_destroy_dumb {
>  	__u32 handle;
>  };
>  
> -/* page-flip flags are valid, plus: */
> +/*

You might want to use a standard kernel/sphynx doc header so that it
can be parsed by sphynx and included in the DRM doc.

> + * drm atomic flags
> + *
> + * page-flip flags are valid, plus:
> + *
> + * DRM_MODE_ATOMIC_TEST_ONLY
> + * Used with fences to check if the Sync File is a valid one.

I think it can be used for any kind of tests, like when you want to
know if a combination of property updates is supported. It's fine
having the fence example, but I think you should be clear that it's
just one use case.

> + *
> + * DRM_MODE_ATOMIC_NONBLOCK
> + * Perform a normal atomic update but do not block the ioctl until the request
> + * is finished, return the ioctl call immediately.
> + *
> + * DRM_MODE_ATOMIC_ALLOW_MODESET
> + * Indicates whether a full modeset is acceptable or not.
> + */
> +
> +/*  */
>  #define DRM_MODE_ATOMIC_TEST_ONLY 0x0100
>  #define DRM_MODE_ATOMIC_NONBLOCK  0x0200
>  #define DRM_MODE_ATOMIC_ALLOW_MODESET 0x0400

Regards,

Boris
