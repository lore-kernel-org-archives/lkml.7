Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79AC5C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 19:59:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C97421773
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 19:59:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728344AbfDXT7L convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 15:59:11 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:62009 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726394AbfDXT7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 15:59:11 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 16349911-1500050 
        for multiple; Wed, 24 Apr 2019 20:58:54 +0100
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Jian-Hong Pan <jian-hong@endlessm.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
From:   Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <20190423092810.28359-1-jian-hong@endlessm.com>
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux@endlessm.com,
        Daniel Drake <drake@endlessm.com>,
        Jian-Hong Pan <jian-hong@endlessm.com>,
        Paulo Zanoni <paulo.r.zanoni@intel.com>
References: <20190423092810.28359-1-jian-hong@endlessm.com>
Message-ID: <155613593248.25205.769591454199358982@skylake-alporthouse-com>
User-Agent: alot/0.6
Subject: Re: [PATCH] i915: disable framebuffer compression on GeminiLake
Date:   Wed, 24 Apr 2019 20:58:52 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jian-Hong Pan (2019-04-23 10:28:10)
> From: Daniel Drake <drake@endlessm.com>
> 
> On many (all?) the Gemini Lake systems we work with, there is frequent
> momentary graphical corruption at the top of the screen, and it seems
> that disabling framebuffer compression can avoid this.
> 
> The ticket was reported 6 months ago and has already affected a
> multitude of users, without any real progress being made. So, lets
> disable framebuffer compression on GeminiLake until a solution is found.
> 
> Buglink: https://bugs.freedesktop.org/show_bug.cgi?id=108085
> Signed-off-by: Daniel Drake <drake@endlessm.com>
> Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>

Fixes: fd7d6c5c8f3e ("drm/i915: enable FBC on gen9+ too") ?
Cc: Paulo Zanoni <paulo.r.zanoni@intel.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: <stable@vger.kernel.org> # v4.11+

glk landed 1 month before, so that seems the earliest broken point.

> ---
>  drivers/gpu/drm/i915/intel_fbc.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/gpu/drm/i915/intel_fbc.c b/drivers/gpu/drm/i915/intel_fbc.c
> index 656e684e7c9a..fc018f3f53a1 100644
> --- a/drivers/gpu/drm/i915/intel_fbc.c
> +++ b/drivers/gpu/drm/i915/intel_fbc.c
> @@ -1278,6 +1278,10 @@ static int intel_sanitize_fbc_option(struct drm_i915_private *dev_priv)
>         if (!HAS_FBC(dev_priv))
>                 return 0;
>  
> +       /* https://bugs.freedesktop.org/show_bug.cgi?id=108085 */
> +       if (IS_GEMINILAKE(dev_priv))
> +               return 0;
> +
>         if (IS_BROADWELL(dev_priv) || INTEL_GEN(dev_priv) >= 9)
>                 return 1;
>  
> -- 
> 2.21.0
> 
