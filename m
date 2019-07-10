Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73B92C74A21
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 16:01:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F4342064A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 16:01:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728257AbfGJQBN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 12:01:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:40974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727463AbfGJQBM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 12:01:12 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C1F32064A;
        Wed, 10 Jul 2019 16:01:11 +0000 (UTC)
Date:   Wed, 10 Jul 2019 12:01:10 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Ville =?UTF-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH] drm/i915: Copy name string into ring buffer for
 intel_update/disable_plane tracepoints
Message-ID: <20190710120110.17394e73@gandalf.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Currently the intel_update_plane and intel_disable_plane tracepoints record
the address of plane->name in the ring buffer, and then when reading the
ring buffer uses %s to get the name. The issue with this, is that those two
events can be minutes, hours or even days apart. It is very dangerous to
dereference a string pointer without knowing if it still exists or not.

The proper way to handle this is to use the __string() macro in the
tracepoint which will save the string into the ring buffer at the time of
recording. Then there's no worries if the original string still exists in
memory when the ring buffer is read.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 drivers/gpu/drm/i915/i915_trace.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

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
 
-- 
2.20.1

