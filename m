Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70C0CC74A21
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 15:45:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FE7A2086D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 15:45:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728196AbfGJPp2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 11:45:28 -0400
Received: from mga03.intel.com ([134.134.136.65]:19661 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727616AbfGJPp2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 11:45:28 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jul 2019 08:45:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,475,1557212400"; 
   d="scan'208";a="193091354"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by fmsmga002.fm.intel.com with SMTP; 10 Jul 2019 08:45:24 -0700
Received: by stinkbox (sSMTP sendmail emulation); Wed, 10 Jul 2019 18:45:24 +0300
Date:   Wed, 10 Jul 2019 18:45:24 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Need to remove char pointers from trace events
Message-ID: <20190710154524.GG5942@intel.com>
References: <20190710112549.0366bb03@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190710112549.0366bb03@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 10, 2019 at 11:25:49AM -0400, Steven Rostedt wrote:
> I was doing a bit of an audit on trace events and found this:
> 
> # cat /debug/tracing/events/i915/intel_disable_plane/format
> name: intel_disable_plane
> ID: 1358
> format:
> 	field:unsigned short common_type;	offset:0;	size:2;	signed:0;
> 	field:unsigned char common_flags;	offset:2;	size:1;	signed:0;
> 	field:unsigned char common_preempt_count;	offset:3;	size:1;	signed:0;
> 	field:int common_pid;	offset:4;	size:4;	signed:1;
> 
> 	field:enum pipe pipe;	offset:8;	size:4;	signed:1;
> 	field:const char * name;	offset:16;	size:8;	signed:0;
> 	field:u32 frame;	offset:24;	size:4;	signed:0;
> 	field:u32 scanline;	offset:28;	size:4;	signed:0;
> 
> print fmt: "pipe %c, plane %s, frame=%u, scanline=%u", ((REC->pipe) + 'A'), REC->name, REC->frame, REC->scanline
> 
> 
> Same goes for intel_update_plane.
> 
> 
> The problem here is:
> 
> 	field:const char * name;	offset:16;	size:8;	signed:0;
> 
> print fmt: "pipe %c, plane %s, frame=%u, scanline=%u", ((REC->pipe) + 'A'), REC->name, REC->frame, REC->scanline
> 
> 
> Where the TRACE_EVENT() macro has:
> 
> 	    TP_fast_assign(
> 			   __entry->pipe = crtc->pipe;
> 			   __entry->name = plane->name;
> 			   __entry->frame = crtc->base.dev->driver->get_vblank_counter(crtc->base.dev,
> 										       crtc->pipe);
> 			   __entry->scanline = intel_get_crtc_scanline(crtc);
> 			   ),
> 
> 	    TP_printk("pipe %c, plane %s, frame=%u, scanline=%u",
> 		      pipe_name(__entry->pipe), __entry->name,
> 		      __entry->frame, __entry->scanline)
> 
> 
> The issue here is that you record a pointer address to "plane->name"
> and then sometime in the distant future access that same address.
> There's usually no guarantee that the contents at that address will
> exist when the buffer is read.

The only way those can disappear is if the device goes away. But I have
no problem going with your patch. Want to provide a proper commit message
for it?

> 
> The proper way to record strings, is to record the string into the ring
> buffer itself, and not rely on it existing hours or days later.
> 
> I recommend the following patch:
> 
> -- Steve
> 
> diff --git a/drivers/gpu/drm/i915/i915_trace.h b/drivers/gpu/drm/i915/i915_trace.h
> index 12893304c8f8..d41d914a16ca 100644
> --- a/drivers/gpu/drm/i915/i915_trace.h
> +++ b/drivers/gpu/drm/i915/i915_trace.h
> @@ -298,16 +298,16 @@ TRACE_EVENT(intel_update_plane,
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
>  			   __entry->frame = crtc->base.dev->driver->get_vblank_counter(crtc->base.dev,
>  										       crtc->pipe);
>  			   __entry->scanline = intel_get_crtc_scanline(crtc);
> @@ -316,7 +316,7 @@ TRACE_EVENT(intel_update_plane,
>  			   ),
>  
>  	    TP_printk("pipe %c, plane %s, frame=%u, scanline=%u, " DRM_RECT_FP_FMT " -> " DRM_RECT_FMT,
> -		      pipe_name(__entry->pipe), __entry->name,
> +		      pipe_name(__entry->pipe), __get_str(name),
>  		      __entry->frame, __entry->scanline,
>  		      DRM_RECT_FP_ARG((const struct drm_rect *)__entry->src),
>  		      DRM_RECT_ARG((const struct drm_rect *)__entry->dst))
> @@ -328,21 +328,21 @@ TRACE_EVENT(intel_disable_plane,
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
>  			   __entry->frame = crtc->base.dev->driver->get_vblank_counter(crtc->base.dev,
>  										       crtc->pipe);
>  			   __entry->scanline = intel_get_crtc_scanline(crtc);
>  			   ),
>  
>  	    TP_printk("pipe %c, plane %s, frame=%u, scanline=%u",
> -		      pipe_name(__entry->pipe), __entry->name,
> +		      pipe_name(__entry->pipe), __get_str(name),
>  		      __entry->frame, __entry->scanline)
>  );
>  

-- 
Ville Syrjälä
Intel
