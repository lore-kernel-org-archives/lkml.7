Return-Path: <SRS0=maO4=XY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F3E7C4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 07:49:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBEF0206C0
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 07:49:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CKpoYcvB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728640AbfI2Htd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Sep 2019 03:49:33 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34084 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbfI2Htd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Sep 2019 03:49:33 -0400
Received: by mail-pg1-f194.google.com with SMTP id y35so5622838pgl.1
        for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2019 00:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=ALfay30h7dJ26wuLT+jtgKPUgydlfxhNtnqYzbldtjs=;
        b=CKpoYcvB+dApUun67rFK8JgcxsGfC4Q84EUMFa1ACiz33b37J1GChmGP3Y1eT+2iVr
         4K/orX0v2WutapxA25YnlcVcQheXodt48Nwi88TcqT+l/eS3ripTP9rJPuDTe2X8IreY
         +hRjNoHEsXAo1qx1o85RstbXwuVdFuEHNuGRi4VSZ6eWApbpZa64LP3ZoBiPr/kQF6j4
         BXMHOZBNamzNLRAFRd5ZIwjWFPqKsjzHMYsTHvLDey+e3iNYYMPvl25jCWFkQoJnletQ
         elzgohPErRQUREyMY117RNo80duWWsfMio0TjBbj1cgkOcdBzB2bNPcEx4/ajv/W7JGm
         tSlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=ALfay30h7dJ26wuLT+jtgKPUgydlfxhNtnqYzbldtjs=;
        b=oCRppum8m1iLMJ7376hCAVDYN0/iwAaleg8k4CzyGtUjjI48IvHnOtyuW20shlvPdR
         9tyIOXirCeIQJwVPWAJhgBW/DhF1Wn7bjWNWVSUT/t8ctjggo7Udk+DMBryn++D2a+Di
         AowPwzwz4ai06R+nPtOZdZuMdH7tALbsTk7SxSq6hUfOvvO023jmH3uyl5Ryg4BUE6y/
         ymUNjY1PQzNiQyQPGWkcWrbAD8WICO3Ew3rb7KFq+Yajm0QCP7etqqE8o8c3m0x20w0d
         5Qx5ybKeNFHd+NcP/QYvrH05LmQF4mPs255OKDTg+3DN/n1RkPsQC58uzeLjzRQLpMA5
         n5Ew==
X-Gm-Message-State: APjAAAXT88u740x77YZ44RaJgqogZETAWU4J+34t0zxGIVEWbRRtAzda
        OuThtc7q3PT+NzoMjt6Im2y/2KYntfc=
X-Google-Smtp-Source: APXvYqwk03VqmdgTfQONRgf7XvkS8T1usRALeIgGxILt9vc0ZCZ02zCIEnmCAsXr2uQvMEZJgFoLiQ==
X-Received: by 2002:a62:3083:: with SMTP id w125mr14881576pfw.102.1569743371103;
        Sun, 29 Sep 2019 00:49:31 -0700 (PDT)
Received: from localhost ([2402:3a80:1386:365a:afc8:2b6a:7e98:d2fd])
        by smtp.gmail.com with ESMTPSA id 192sm8507377pfb.110.2019.09.29.00.49.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2019 00:49:30 -0700 (PDT)
Date:   Sun, 29 Sep 2019 13:19:19 +0530
From:   Jaskaran Singh <jaskaransingh7654321@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        jani.nikula@linux.intel.com
Subject: [PATCH] drm/i915: Fix documentation build warnings w/r/t kernel-doc
Message-ID: <20190929074919.GA5699@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building docs with make htmldocs yields documentation build
warnings for drivers/gpu/drm/i915/i915_drv.h. Some of the
documentation does not follow kernel-doc format.

This patch fixes these warnings.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 drivers/gpu/drm/i915/i915_drv.h | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_drv.h b/drivers/gpu/drm/i915/i915_drv.h
index 772154e4073e..573a972e3643 100644
--- a/drivers/gpu/drm/i915/i915_drv.h
+++ b/drivers/gpu/drm/i915/i915_drv.h
@@ -1126,7 +1126,7 @@ struct i915_perf_stream {
 	struct i915_oa_config *oa_config;
 
 	/**
-	 * The OA context specific information.
+	 * @pinned_ctx: The OA context specific information.
 	 */
 	struct intel_context *pinned_ctx;
 	u32 specific_ctx_id;
@@ -1140,7 +1140,7 @@ struct i915_perf_stream {
 	int period_exponent;
 
 	/**
-	 * State of the OA buffer.
+	 * @oa_buffer: State of the OA buffer.
 	 */
 	struct {
 		struct i915_vma *vma;
@@ -1151,7 +1151,7 @@ struct i915_perf_stream {
 		int size_exponent;
 
 		/**
-		 * Locks reads and writes to all head/tail state
+		 * @ptr_lock: Locks reads and writes to all head/tail state
 		 *
 		 * Consider: the head and tail pointer state needs to be read
 		 * consistently from a hrtimer callback (atomic context) and
@@ -1173,8 +1173,8 @@ struct i915_perf_stream {
 		spinlock_t ptr_lock;
 
 		/**
-		 * One 'aging' tail pointer and one 'aged' tail pointer ready to
-		 * used for reading.
+		 * @tails: One 'aging' tail pointer and one 'aged' tail pointer
+		 * ready to used for reading.
 		 *
 		 * Initial values of 0xffffffff are invalid and imply that an
 		 * update is required (and should be ignored by an attempted
@@ -1185,22 +1185,24 @@ struct i915_perf_stream {
 		} tails[2];
 
 		/**
-		 * Index for the aged tail ready to read() data up to.
+		 * @aged_tail_idx: Index for the aged tail ready to read() data
+		 * up to.
 		 */
 		unsigned int aged_tail_idx;
 
 		/**
-		 * A monotonic timestamp for when the current aging tail pointer
-		 * was read; used to determine when it is old enough to trust.
+		 * @aging_timestamp: A monotonic timestamp for when the current
+		 * aging tail pointer was read; used to determine when it is old
+		 * enough to trust.
 		 */
 		u64 aging_timestamp;
 
 		/**
-		 * Although we can always read back the head pointer register,
-		 * we prefer to avoid trusting the HW state, just to avoid any
-		 * risk that some hardware condition could * somehow bump the
-		 * head pointer unpredictably and cause us to forward the wrong
-		 * OA buffer data to userspace.
+		 * @head: Although we can always read back the head pointer
+		 * register, we prefer to avoid trusting the HW state, just to
+		 * avoid any risk that some hardware condition could * somehow
+		 * bump the head pointer unpredictably and cause us to forward
+		 * the wrong OA buffer data to userspace.
 		 */
 		u32 head;
 	} oa_buffer;
-- 
2.21.0

