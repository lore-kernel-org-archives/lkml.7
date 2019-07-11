Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9BA4C742A1
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 19:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D3FA208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 19:55:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728976AbfGKTzK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 15:55:10 -0400
Received: from mga12.intel.com ([192.55.52.136]:32802 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728899AbfGKTzK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 15:55:10 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jul 2019 12:55:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,479,1557212400"; 
   d="scan'208";a="168117192"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by fmsmga007.fm.intel.com with SMTP; 11 Jul 2019 12:55:06 -0700
Received: by stinkbox (sSMTP sendmail emulation); Thu, 11 Jul 2019 22:55:05 +0300
Date:   Thu, 11 Jul 2019 22:55:05 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     intel-gfx@lists.freedesktop.org
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: Re: [PATCH v2] drm/i915: Copy name string into ring buffer for
 intel_update/disable_plane tracepoints
Message-ID: <20190711195505.GC5942@intel.com>
References: <20190710120110.17394e73@gandalf.local.home>
 <20190710171230.7471-1-ville.syrjala@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190710171230.7471-1-ville.syrjala@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 10, 2019 at 08:12:30PM +0300, Ville Syrjala wrote:
> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> 
> Currently the intel_update_plane and intel_disable_plane tracepoints record
> the address of plane->name in the ring buffer, and then when reading the
> ring buffer uses %s to get the name. The issue with this, is that those two
> events can be minutes, hours or even days apart. It is very dangerous to
> dereference a string pointer without knowing if it still exists or not.
> 
> The proper way to handle this is to use the __string() macro in the
> tracepoint which will save the string into the ring buffer at the time of
> recording. Then there's no worries if the original string still exists in
> memory when the ring buffer is read.
> 
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> [vsyrjala: Rebase on top of drm-tip]
> Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>

CI is happy (not that we test this stuff) and I'm happy (the tracepoints
still work) -> pushed to drm-intel-next-queued. Thanks for the patch.

> ---
>  drivers/gpu/drm/i915/i915_trace.h | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/i915_trace.h b/drivers/gpu/drm/i915/i915_trace.h
> index cce426b23a24..da18b8d6b80c 100644
> --- a/drivers/gpu/drm/i915/i915_trace.h
> +++ b/drivers/gpu/drm/i915/i915_trace.h
> @@ -293,16 +293,16 @@ TRACE_EVENT(intel_update_plane,
>  
>  	    TP_STRUCT__entry(
>  			     __field(enum pipe, pipe)
> -			     __field(const char *, name)
>  			     __field(u32, frame)
>  			     __field(u32, scanline)
>  			     __array(int, src, 4)
>  			     __array(int, dst, 4)
> +			     __string(name, plane->name)
>  			     ),
>  
>  	    TP_fast_assign(
> +			   __assign_str(name, plane->name);
>  			   __entry->pipe = crtc->pipe;
> -			   __entry->name = plane->name;
>  			   __entry->frame = intel_crtc_get_vblank_counter(crtc);
>  			   __entry->scanline = intel_get_crtc_scanline(crtc);
>  			   memcpy(__entry->src, &plane->state->src, sizeof(__entry->src));
> @@ -310,7 +310,7 @@ TRACE_EVENT(intel_update_plane,
>  			   ),
>  
>  	    TP_printk("pipe %c, plane %s, frame=%u, scanline=%u, " DRM_RECT_FP_FMT " -> " DRM_RECT_FMT,
> -		      pipe_name(__entry->pipe), __entry->name,
> +		      pipe_name(__entry->pipe), __get_str(name),
>  		      __entry->frame, __entry->scanline,
>  		      DRM_RECT_FP_ARG((const struct drm_rect *)__entry->src),
>  		      DRM_RECT_ARG((const struct drm_rect *)__entry->dst))
> @@ -322,20 +322,20 @@ TRACE_EVENT(intel_disable_plane,
>  
>  	    TP_STRUCT__entry(
>  			     __field(enum pipe, pipe)
> -			     __field(const char *, name)
>  			     __field(u32, frame)
>  			     __field(u32, scanline)
> +			     __string(name, plane->name)
>  			     ),
>  
>  	    TP_fast_assign(
> +			   __assign_str(name, plane->name);
>  			   __entry->pipe = crtc->pipe;
> -			   __entry->name = plane->name;
>  			   __entry->frame = intel_crtc_get_vblank_counter(crtc);
>  			   __entry->scanline = intel_get_crtc_scanline(crtc);
>  			   ),
>  
>  	    TP_printk("pipe %c, plane %s, frame=%u, scanline=%u",
> -		      pipe_name(__entry->pipe), __entry->name,
> +		      pipe_name(__entry->pipe), __get_str(name),
>  		      __entry->frame, __entry->scanline)
>  );
>  
> -- 
> 2.21.0

-- 
Ville Syrjälä
Intel
