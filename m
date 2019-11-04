Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B215CA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 17:37:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55B60214B2
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 17:37:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="VAyQzygl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729474AbfKDRhh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 12:37:37 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50477 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728898AbfKDRhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 12:37:35 -0500
Received: by mail-wm1-f68.google.com with SMTP id 11so17674682wmk.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 09:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PXKWmt04LLOdOQwT4J7BpfWO3zbtkR+P8tnC3gpeEXQ=;
        b=VAyQzyglRqNMJ3a4V+Jk2zst6aCR675sfvIjYWZoY/TUikK/EnbUf83SZsY6hQMvZ/
         qpqrMTLp8w0fMoHxqmLb1x9cV4Jrfhnir+g7hTsKlxb8muPuiiTG+25XLfQkayp2UfU3
         uqK791FxcspFJz55XB6wK9tl9Y/kCkD4f7HQs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PXKWmt04LLOdOQwT4J7BpfWO3zbtkR+P8tnC3gpeEXQ=;
        b=OCsgoXMvq6nsiC5lO6nIWylPT0Z43TjXXt+ImMTLPtARXrTubabtyL+JWI7VK9gAtF
         BPG3TfCUU9ez2OkBAKCumEoSccKQxhW20Jd9BdvtEvWMBFNFdMBQRDskt1gY4et6bdQ/
         KA3cbRlX6Rkb3PNNjrevlPUovMeRLC65AQdrSR5K7u2yUNRAknOkxEpRbQ1WcqItx1YR
         E+j5xrOj82npq8Z3UQKZmWJGSS+yGz4F248c9ONuYJyyoGU4MUagXU2cDuTPNy9fp/HZ
         N5c6QS3qfudpSWoa2kBf+CkOiLs2VAF5gzN5UydaB8/Y1xhwldJ7QIaJRQ2TnAIChHv2
         h7fg==
X-Gm-Message-State: APjAAAUH0ixoTdFQQOcIwTFuMqpf3tzcCBcytU14xw94oOBa7r8K7GVe
        /7dhSBX2G8oqD2zKcMA8bFAbsQ==
X-Google-Smtp-Source: APXvYqwnBFrltg4BcDYvyP0LQfKr7LnFL2T1UPgzUktng1ER3WfNh2V8RcaPXqBQ9MI5hBomwShRrA==
X-Received: by 2002:a05:600c:21c9:: with SMTP id x9mr252564wmj.54.1572889053413;
        Mon, 04 Nov 2019 09:37:33 -0800 (PST)
Received: from phenom.ffwll.local (212-51-149-96.fiber7.init7.net. [212.51.149.96])
        by smtp.gmail.com with ESMTPSA id l22sm32408863wrb.45.2019.11.04.09.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 09:37:32 -0800 (PST)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] drm/i915: use might_lock_nested in get_pages annotation
Date:   Mon,  4 Nov 2019 18:37:20 +0100
Message-Id: <20191104173720.2696-3-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.24.0.rc2
In-Reply-To: <20191104173720.2696-1-daniel.vetter@ffwll.ch>
References: <20191104173720.2696-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So strictly speaking the existing annotation is also ok, because we
have a chain of

obj->mm.lock#I915_MM_GET_PAGES -> fs_reclaim -> obj->mm.lock

(the shrinker cannot get at an object while we're in get_pages, hence
this is safe). But it's confusing, so try to take the right subclass
of the lock.

This does a bit reduce our lockdep based checking, but then it's also
less fragile, in case we ever change the nesting around.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org
---
 drivers/gpu/drm/i915/gem/i915_gem_object.h | 36 +++++++++++-----------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_object.h b/drivers/gpu/drm/i915/gem/i915_gem_object.h
index edaf7126a84d..e5750d506cc9 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_object.h
+++ b/drivers/gpu/drm/i915/gem/i915_gem_object.h
@@ -271,10 +271,27 @@ void __i915_gem_object_set_pages(struct drm_i915_gem_object *obj,
 int ____i915_gem_object_get_pages(struct drm_i915_gem_object *obj);
 int __i915_gem_object_get_pages(struct drm_i915_gem_object *obj);
 
+enum i915_mm_subclass { /* lockdep subclass for obj->mm.lock/struct_mutex */
+	I915_MM_NORMAL = 0,
+	/*
+	 * Only used by struct_mutex, when called "recursively" from
+	 * direct-reclaim-esque. Safe because there is only every one
+	 * struct_mutex in the entire system.
+	 */
+	I915_MM_SHRINKER = 1,
+	/*
+	 * Used for obj->mm.lock when allocating pages. Safe because the object
+	 * isn't yet on any LRU, and therefore the shrinker can't deadlock on
+	 * it. As soon as the object has pages, obj->mm.lock nests within
+	 * fs_reclaim.
+	 */
+	I915_MM_GET_PAGES = 1,
+};
+
 static inline int __must_check
 i915_gem_object_pin_pages(struct drm_i915_gem_object *obj)
 {
-	might_lock(&obj->mm.lock);
+	might_lock_nested(&obj->mm.lock, I915_MM_GET_PAGES);
 
 	if (atomic_inc_not_zero(&obj->mm.pages_pin_count))
 		return 0;
@@ -317,23 +334,6 @@ i915_gem_object_unpin_pages(struct drm_i915_gem_object *obj)
 	__i915_gem_object_unpin_pages(obj);
 }
 
-enum i915_mm_subclass { /* lockdep subclass for obj->mm.lock/struct_mutex */
-	I915_MM_NORMAL = 0,
-	/*
-	 * Only used by struct_mutex, when called "recursively" from
-	 * direct-reclaim-esque. Safe because there is only every one
-	 * struct_mutex in the entire system.
-	 */
-	I915_MM_SHRINKER = 1,
-	/*
-	 * Used for obj->mm.lock when allocating pages. Safe because the object
-	 * isn't yet on any LRU, and therefore the shrinker can't deadlock on
-	 * it. As soon as the object has pages, obj->mm.lock nests within
-	 * fs_reclaim.
-	 */
-	I915_MM_GET_PAGES = 1,
-};
-
 int __i915_gem_object_put_pages(struct drm_i915_gem_object *obj);
 void i915_gem_object_truncate(struct drm_i915_gem_object *obj);
 void i915_gem_object_writeback(struct drm_i915_gem_object *obj);
-- 
2.24.0.rc2

