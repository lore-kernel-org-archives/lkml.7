Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00446C74A30
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 17:12:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D27A820844
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 17:12:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728240AbfGJRMe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 13:12:34 -0400
Received: from mga03.intel.com ([134.134.136.65]:26586 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726617AbfGJRMe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 13:12:34 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jul 2019 10:12:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,475,1557212400"; 
   d="scan'208";a="249532861"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by orsmga001.jf.intel.com with SMTP; 10 Jul 2019 10:12:31 -0700
Received: by stinkbox (sSMTP sendmail emulation); Wed, 10 Jul 2019 20:12:30 +0300
From:   Ville Syrjala <ville.syrjala@linux.intel.com>
To:     intel-gfx@lists.freedesktop.org
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: [PATCH v2] drm/i915: Copy name string into ring buffer for intel_update/disable_plane tracepoints
Date:   Wed, 10 Jul 2019 20:12:30 +0300
Message-Id: <20190710171230.7471-1-ville.syrjala@linux.intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190710120110.17394e73@gandalf.local.home>
References: <20190710120110.17394e73@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
[vsyrjala: Rebase on top of drm-tip]
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 drivers/gpu/drm/i915/i915_trace.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_trace.h b/drivers/gpu/drm/i915/i915_trace.h
index cce426b23a24..da18b8d6b80c 100644
--- a/drivers/gpu/drm/i915/i915_trace.h
+++ b/drivers/gpu/drm/i915/i915_trace.h
@@ -293,16 +293,16 @@ TRACE_EVENT(intel_update_plane,
 
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
 			   __entry->frame = intel_crtc_get_vblank_counter(crtc);
 			   __entry->scanline = intel_get_crtc_scanline(crtc);
 			   memcpy(__entry->src, &plane->state->src, sizeof(__entry->src));
@@ -310,7 +310,7 @@ TRACE_EVENT(intel_update_plane,
 			   ),
 
 	    TP_printk("pipe %c, plane %s, frame=%u, scanline=%u, " DRM_RECT_FP_FMT " -> " DRM_RECT_FMT,
-		      pipe_name(__entry->pipe), __entry->name,
+		      pipe_name(__entry->pipe), __get_str(name),
 		      __entry->frame, __entry->scanline,
 		      DRM_RECT_FP_ARG((const struct drm_rect *)__entry->src),
 		      DRM_RECT_ARG((const struct drm_rect *)__entry->dst))
@@ -322,20 +322,20 @@ TRACE_EVENT(intel_disable_plane,
 
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
 			   __entry->frame = intel_crtc_get_vblank_counter(crtc);
 			   __entry->scanline = intel_get_crtc_scanline(crtc);
 			   ),
 
 	    TP_printk("pipe %c, plane %s, frame=%u, scanline=%u",
-		      pipe_name(__entry->pipe), __entry->name,
+		      pipe_name(__entry->pipe), __get_str(name),
 		      __entry->frame, __entry->scanline)
 );
 
-- 
2.21.0

