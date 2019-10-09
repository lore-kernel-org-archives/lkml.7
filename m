Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE8BDC47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 09:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0A8421721
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 09:52:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730787AbfJIJw0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 05:52:26 -0400
Received: from mga03.intel.com ([134.134.136.65]:7292 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725935AbfJIJwX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 05:52:23 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Oct 2019 02:52:22 -0700
X-IronPort-AV: E=Sophos;i="5.67,273,1566889200"; 
   d="scan'208";a="187581234"
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.66.161])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Oct 2019 02:52:18 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Colin King <colin.king@canonical.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] drm/i915: remove redundant variable err
In-Reply-To: <20191009093935.17895-1-colin.king@canonical.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20191009093935.17895-1-colin.king@canonical.com>
Date:   Wed, 09 Oct 2019 12:52:15 +0300
Message-ID: <87h84igsa8.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 09 Oct 2019, Colin King <colin.king@canonical.com> wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> An earlier commit removed any error assignments to err and we
> are now left with a zero assignment to err and a check that is
> always false. Clean this up by removing the redundant variable
> err and the error check.
>
> Addresses-Coverity: ("'Constant' variable guard")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Fixes: b1e3177bd1d8 ("drm/i915: Coordinate i915_active with its own mutex")
Reviewed-by: Jani Nikula <jani.nikula@intel.com>


BR,
Jani.


> ---
>  drivers/gpu/drm/i915/i915_active.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/i915_active.c b/drivers/gpu/drm/i915/i915_active.c
> index aa37c07004b9..67305165c12a 100644
> --- a/drivers/gpu/drm/i915/i915_active.c
> +++ b/drivers/gpu/drm/i915/i915_active.c
> @@ -438,7 +438,6 @@ static void enable_signaling(struct i915_active_fence *active)
>  int i915_active_wait(struct i915_active *ref)
>  {
>  	struct active_node *it, *n;
> -	int err = 0;
>  
>  	might_sleep();
>  
> @@ -456,8 +455,6 @@ int i915_active_wait(struct i915_active *ref)
>  	/* Any fence added after the wait begins will not be auto-signaled */
>  
>  	i915_active_release(ref);
> -	if (err)
> -		return err;
>  
>  	if (wait_var_event_interruptible(ref, i915_active_is_idle(ref)))
>  		return -EINTR;

-- 
Jani Nikula, Intel Open Source Graphics Center
