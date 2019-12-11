Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03C33C2D0C6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 16:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE9BC2073D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 16:23:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730673AbfLKQX1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 11:23:27 -0500
Received: from mga05.intel.com ([192.55.52.43]:17304 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730062AbfLKQX1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 11:23:27 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Dec 2019 08:23:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,301,1571727600"; 
   d="scan'208";a="264926006"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by FMSMGA003.fm.intel.com with SMTP; 11 Dec 2019 08:23:23 -0800
Received: by stinkbox (sSMTP sendmail emulation); Wed, 11 Dec 2019 18:23:22 +0200
Date:   Wed, 11 Dec 2019 18:23:22 +0200
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] drm/i915: remove redundant checks for a null fb
 pointer
Message-ID: <20191211162322.GL1208@intel.com>
References: <20191210142349.333171-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191210142349.333171-1-colin.king@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 10, 2019 at 02:23:49PM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> A prior check and return when pointer fb is null makes
> subsequent null checks on fb redundant.  Remove the redundant
> null checks.
> 
> Addresses-Coverity: ("Logically dead code")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/gpu/drm/i915/i915_debugfs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/i915_debugfs.c b/drivers/gpu/drm/i915/i915_debugfs.c
> index 062e5bef637a..a48478be6e8f 100644
> --- a/drivers/gpu/drm/i915/i915_debugfs.c
> +++ b/drivers/gpu/drm/i915/i915_debugfs.c
> @@ -2600,8 +2600,8 @@ static void intel_plane_hw_info(struct seq_file *m, struct intel_plane *plane)
>  		       plane_state->hw.rotation);
>  
>  	seq_printf(m, "\t\thw: fb=%d,%s,%dx%d, visible=%s, src=" DRM_RECT_FP_FMT ", dst=" DRM_RECT_FMT ", rotation=%s\n",
> -		   fb ? fb->base.id : 0, fb ? format_name.str : "n/a",
> -		   fb ? fb->width : 0, fb ? fb->height : 0,
> +		   fb->base.id, format_name.str,
> +		   fb->width, fb->height,

Thanks.

Pushed to drm-intel-next-queued.

>  		   yesno(plane_state->uapi.visible),
>  		   DRM_RECT_FP_ARG(&plane_state->uapi.src),
>  		   DRM_RECT_ARG(&plane_state->uapi.dst),
> -- 
> 2.24.0
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Ville Syrjälä
Intel
