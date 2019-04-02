Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59133C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:49:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 309DD2133D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:49:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731238AbfDBNkC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 09:40:02 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:42802 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731141AbfDBNkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 09:40:01 -0400
Received: from [167.98.27.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hBJdu-0002mV-2k; Tue, 02 Apr 2019 14:39:58 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hBJdt-0004qT-5h; Tue, 02 Apr 2019 14:39:57 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Chris Wilson" <chris@chris-wilson.co.uk>,
        "Ville =?UTF-8?Q?Syrj=C3=A4l=C3=A4?=" <ville.syrjala@linux.intel.com>
Date:   Tue, 02 Apr 2019 14:38:27 +0100
Message-ID: <lsq.1554212307.213091977@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 02/99] drm/i915/ringbuffer: Delay after
 EMIT_INVALIDATE for gen4/gen5
In-Reply-To: <lsq.1554212307.17110877@decadent.org.uk>
X-SA-Exim-Connect-IP: 167.98.27.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.65-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Chris Wilson <chris@chris-wilson.co.uk>

commit 55f99bf2a9c331838c981694bc872cd1ec4070b2 upstream.

Exercising the gpu reloc path strenuously revealed an issue where the
updated relocations (from MI_STORE_DWORD_IMM) were not being observed
upon execution. After some experiments with adding pipecontrols (a lot
of pipecontrols (32) as gen4/5 do not have a bit to wait on earlier pipe
controls or even the current on), it was discovered that we merely
needed to delay the EMIT_INVALIDATE by several flushes. It is important
to note that it is the EMIT_INVALIDATE as opposed to the EMIT_FLUSH that
needs the delay as opposed to what one might first expect -- that the
delay is required for the TLB invalidation to take effect (one presumes
to purge any CS buffers) as opposed to a delay after flushing to ensure
the writes have landed before triggering invalidation.

Testcase: igt/gem_tiled_fence_blits
Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20181105094305.5767-1-chris@chris-wilson.co.uk
[bwh: Backported to 3.16:
 - Use intel_ring_emit() instead of assignments
 - Use ring->scratch.gtt_offset instead of i915_ggtt_offset()
 - Use (invalidate_domains & I915_GEM_DOMAIN_INSTRUCTION) instead of
   (mode & EMIT_INVALIDATE)
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/gpu/drm/i915/intel_ringbuffer.c | 38 +++++++++++++++++++++++--
 1 file changed, 36 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/i915/intel_ringbuffer.c
+++ b/drivers/gpu/drm/i915/intel_ringbuffer.c
@@ -103,6 +103,7 @@ gen4_render_ring_flush(struct intel_engi
 	struct drm_device *dev = ring->dev;
 	u32 cmd;
 	int ret;
+	int i;
 
 	/*
 	 * read/write caches:
@@ -142,12 +143,47 @@ gen4_render_ring_flush(struct intel_engi
 	    (IS_G4X(dev) || IS_GEN5(dev)))
 		cmd |= MI_INVALIDATE_ISP;
 
-	ret = intel_ring_begin(ring, 2);
+	i = 2;
+	if (invalidate_domains & I915_GEM_DOMAIN_INSTRUCTION)
+		i += 20;
+
+	ret = intel_ring_begin(ring, i);
 	if (ret)
 		return ret;
 
 	intel_ring_emit(ring, cmd);
-	intel_ring_emit(ring, MI_NOOP);
+
+	/*
+	 * A random delay to let the CS invalidate take effect? Without this
+	 * delay, the GPU relocation path fails as the CS does not see
+	 * the updated contents. Just as important, if we apply the flushes
+	 * to the EMIT_FLUSH branch (i.e. immediately after the relocation
+	 * write and before the invalidate on the next batch), the relocations
+	 * still fail. This implies that is a delay following invalidation
+	 * that is required to reset the caches as opposed to a delay to
+	 * ensure the memory is written.
+	 */
+	if (invalidate_domains & I915_GEM_DOMAIN_INSTRUCTION) {
+		intel_ring_emit(ring, GFX_OP_PIPE_CONTROL(4) |
+				PIPE_CONTROL_QW_WRITE);
+		intel_ring_emit(ring, ring->scratch.gtt_offset |
+				PIPE_CONTROL_GLOBAL_GTT);
+		intel_ring_emit(ring, 0);
+		intel_ring_emit(ring, 0);
+
+		for (i = 0; i < 12; i++)
+			intel_ring_emit(ring, MI_FLUSH);
+
+		intel_ring_emit(ring, GFX_OP_PIPE_CONTROL(4) |
+				PIPE_CONTROL_QW_WRITE);
+		intel_ring_emit(ring, ring->scratch.gtt_offset |
+				PIPE_CONTROL_GLOBAL_GTT);
+		intel_ring_emit(ring, 0);
+		intel_ring_emit(ring, 0);
+	}
+
+	intel_ring_emit(ring, cmd);
+
 	intel_ring_advance(ring);
 
 	return 0;

