Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D540C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 18:03:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 342792133D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 18:03:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731998AbfEXSDE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 14:03:04 -0400
Received: from mga18.intel.com ([134.134.136.126]:55567 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726869AbfEXSDD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 14:03:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 May 2019 11:03:03 -0700
X-ExtLoop1: 1
Received: from unknown (HELO localhost) ([10.252.46.194])
  by fmsmga001.fm.intel.com with ESMTP; 24 May 2019 11:03:01 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Gen Zhang <blackgod016574@gmail.com>,
        maarten.lankhorst@linux.intel.com, maxime.ripard@bootlin.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm_edid-load: Fix a missing-check bug in drm_load_edid_firmware()
In-Reply-To: <20190524023222.GA5302@zhanggen-UX430UQ>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20190522123920.GB6772@zhanggen-UX430UQ> <87o93u7d3s.fsf@intel.com> <20190524023222.GA5302@zhanggen-UX430UQ>
Date:   Fri, 24 May 2019 21:02:59 +0300
Message-ID: <87pno7n31o.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 May 2019, Gen Zhang <blackgod016574@gmail.com> wrote:
> In drm_load_edid_firmware(), fwstr is allocated by kstrdup(). And fwstr
> is dereferenced in the following codes. However, memory allocation 
> functions such as kstrdup() may fail and returns NULL. Dereferencing 
> this null pointer may cause the kernel go wrong. Thus we should check 
> this kstrdup() operation.
> Further, if kstrdup() returns NULL, we should return ERR_PTR(-ENOMEM) to
> the caller site.
>
> Signed-off-by: Gen Zhang <blackgod016574@gmail.com>
> Reviewed-by: Jani Nikula <jani.nikula@intel.com>

Pushed to drm-misc-next, thanks for the patch.

BR,
Jani.

> ---
> diff --git a/drivers/gpu/drm/drm_edid_load.c b/drivers/gpu/drm/drm_edid_load.c
> index a491509..a0e107a 100644
> --- a/drivers/gpu/drm/drm_edid_load.c
> +++ b/drivers/gpu/drm/drm_edid_load.c
> @@ -290,6 +290,8 @@ struct edid *drm_load_edid_firmware(struct drm_connector *connector)
>  	 * the last one found one as a fallback.
>  	 */
>  	fwstr = kstrdup(edid_firmware, GFP_KERNEL);
> +	if (!fwstr)
> +		return ERR_PTR(-ENOMEM);
>  	edidstr = fwstr;
>  
>  	while ((edidname = strsep(&edidstr, ","))) {
> ---

-- 
Jani Nikula, Intel Open Source Graphics Center
