Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 362D3C74A21
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 15:25:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1141521530
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 15:25:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727879AbfGJPZw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 11:25:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:44190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726080AbfGJPZw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 11:25:52 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E2B9F20645;
        Wed, 10 Jul 2019 15:25:50 +0000 (UTC)
Date:   Wed, 10 Jul 2019 11:25:49 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Ville =?UTF-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Need to remove char pointers from trace events
Message-ID: <20190710112549.0366bb03@gandalf.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I was doing a bit of an audit on trace events and found this:

# cat /debug/tracing/events/i915/intel_disable_plane/format
name: intel_disable_plane
ID: 1358
format:
	field:unsigned short common_type;	offset:0;	size:2;	signed:0;
	field:unsigned char common_flags;	offset:2;	size:1;	signed:0;
	field:unsigned char common_preempt_count;	offset:3;	size:1;	signed:0;
	field:int common_pid;	offset:4;	size:4;	signed:1;

	field:enum pipe pipe;	offset:8;	size:4;	signed:1;
	field:const char * name;	offset:16;	size:8;	signed:0;
	field:u32 frame;	offset:24;	size:4;	signed:0;
	field:u32 scanline;	offset:28;	size:4;	signed:0;

print fmt: "pipe %c, plane %s, frame=%u, scanline=%u", ((REC->pipe) + 'A'), REC->name, REC->frame, REC->scanline


Same goes for intel_update_plane.


The problem here is:

	field:const char * name;	offset:16;	size:8;	signed:0;

print fmt: "pipe %c, plane %s, frame=%u, scanline=%u", ((REC->pipe) + 'A'), REC->name, REC->frame, REC->scanline


Where the TRACE_EVENT() macro has:

	    TP_fast_assign(
			   __entry->pipe = crtc->pipe;
			   __entry->name = plane->name;
			   __entry->frame = crtc->base.dev->driver->get_vblank_counter(crtc->base.dev,
										       crtc->pipe);
			   __entry->scanline = intel_get_crtc_scanline(crtc);
			   ),

	    TP_printk("pipe %c, plane %s, frame=%u, scanline=%u",
		      pipe_name(__entry->pipe), __entry->name,
		      __entry->frame, __entry->scanline)


The issue here is that you record a pointer address to "plane->name"
and then sometime in the distant future access that same address.
There's usually no guarantee that the contents at that address will
exist when the buffer is read.

The proper way to record strings, is to record the string into the ring
buffer itself, and not rely on it existing hours or days later.

I recommend the following patch:

-- Steve

diff --git a/drivers/gpu/drm/i915/i915_trace.h b/drivers/gpu/drm/i915/i915_trace.h
index 12893304c8f8..d41d914a16ca 100644
--- a/drivers/gpu/drm/i915/i915_trace.h
+++ b/drivers/gpu/drm/i915/i915_trace.h
@@ -298,16 +298,16 @@ TRACE_EVENT(intel_update_plane,
 
 	    TP_STRUCT__entry(
 			     __field(enum pipe, pipe)
-			     __field(const char *, name)
 			     __field(u32, frame)
 			     __field(u32, scanline)
 			     __array(int, src, 4)
 			     __array(int, dst, 4)
+			     __string(name, plane->name)
 			     ),
 
 	    TP_fast_assign(
+			   __assign_str(name, plane->name);
 			   __entry->pipe = crtc->pipe;
-			   __entry->name = plane->name;
 			   __entry->frame = crtc->base.dev->driver->get_vblank_counter(crtc->base.dev,
 										       crtc->pipe);
 			   __entry->scanline = intel_get_crtc_scanline(crtc);
@@ -316,7 +316,7 @@ TRACE_EVENT(intel_update_plane,
 			   ),
 
 	    TP_printk("pipe %c, plane %s, frame=%u, scanline=%u, " DRM_RECT_FP_FMT " -> " DRM_RECT_FMT,
-		      pipe_name(__entry->pipe), __entry->name,
+		      pipe_name(__entry->pipe), __get_str(name),
 		      __entry->frame, __entry->scanline,
 		      DRM_RECT_FP_ARG((const struct drm_rect *)__entry->src),
 		      DRM_RECT_ARG((const struct drm_rect *)__entry->dst))
@@ -328,21 +328,21 @@ TRACE_EVENT(intel_disable_plane,
 
 	    TP_STRUCT__entry(
 			     __field(enum pipe, pipe)
-			     __field(const char *, name)
 			     __field(u32, frame)
 			     __field(u32, scanline)
+			     __string(name, plane->name)
 			     ),
 
 	    TP_fast_assign(
+			   __assign_str(name, plane->name);
 			   __entry->pipe = crtc->pipe;
-			   __entry->name = plane->name;
 			   __entry->frame = crtc->base.dev->driver->get_vblank_counter(crtc->base.dev,
 										       crtc->pipe);
 			   __entry->scanline = intel_get_crtc_scanline(crtc);
 			   ),
 
 	    TP_printk("pipe %c, plane %s, frame=%u, scanline=%u",
-		      pipe_name(__entry->pipe), __entry->name,
+		      pipe_name(__entry->pipe), __get_str(name),
 		      __entry->frame, __entry->scanline)
 );
 
