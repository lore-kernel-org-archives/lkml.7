Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8717AC3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 23:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 248B121848
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 23:04:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405549AbfHVXEO convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 19:04:14 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:60954 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2405502AbfHVXEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 19:04:13 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 18233027-1500050 
        for multiple; Fri, 23 Aug 2019 00:04:06 +0100
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     Lyude Paul <lyude@redhat.com>, intel-gfx@lists.freedesktop.org
From:   Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <20190822203127.24648-2-lyude@redhat.com>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20190822203127.24648-1-lyude@redhat.com>
 <20190822203127.24648-2-lyude@redhat.com>
Message-ID: <156651504414.31031.15762618327886046790@skylake-alporthouse-com>
User-Agent: alot/0.6
Subject: Re: [PATCH v2 2/2] drm/i915: Enable CONFIG_DMA_API_DEBUG_SG for intel-ci
Date:   Fri, 23 Aug 2019 00:04:04 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Lyude Paul (2019-08-22 21:31:27)
> Now that we've fixed i915 so that it sets a max SG segment length and
> gotten rid of the relevant warnings, let's enable
> CONFIG_DMA_API_DEBUG_SG for intel-ci so that we can catch issues like
> this in the future as well.
> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Cc: Chris Wilson <chris@chris-wilson.co.uk>
> ---
>  drivers/gpu/drm/i915/Kconfig.debug | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/i915/Kconfig.debug b/drivers/gpu/drm/i915/Kconfig.debug
> index 00786a142ff0..ad8d3cd63c9f 100644
> --- a/drivers/gpu/drm/i915/Kconfig.debug
> +++ b/drivers/gpu/drm/i915/Kconfig.debug
> @@ -32,6 +32,7 @@ config DRM_I915_DEBUG
>         select DRM_DEBUG_SELFTEST
>         select DMABUF_SELFTESTS
>         select SW_SYNC # signaling validation framework (igt/syncobj*)

	select DMA_API_DEBUG
as well for it to be enabled, no recursive dependency solver in Kconfig.

> +        select DMA_API_DEBUG_SG
>         select DRM_I915_SW_FENCE_DEBUG_OBJECTS
>         select DRM_I915_SELFTEST
>         select DRM_I915_DEBUG_RUNTIME_PM
> -- 
> 2.21.0
> 
