Return-Path: <SRS0=HtuS=UO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E63EC31E47
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 04:32:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08C8721773
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 04:32:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MX802H27"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbfFOEb4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Jun 2019 00:31:56 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45487 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbfFOEb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jun 2019 00:31:56 -0400
Received: by mail-pf1-f195.google.com with SMTP id r1so2559472pfq.12
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 21:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=GhNgzXtM4tGvVEyxgoC3lFmAbUBSKHJWtkDkmPBUve8=;
        b=MX802H27ZDKjJ2mDaWd42QO5M9nAY+sAS+/IXYRWUHB8Mejp7YKj3zDt0bW+QJvjGx
         gju0OME4rN38kMjWiLbq9TNhH5LB7Gb2oRgT1/BhWORsVZjYM8v+PrwaHktUH+41KzmA
         gJVGR5u008kBzIPj85o6hfchW9WNUwQF7yQ0WNm61tODyetNceAspl3FbErnRYAIV6uo
         DvXCwvaeOrvNPcGsxS51606RL6WSdBn2gY9ej7VwRuEPdL+fx4Hxwz5OriFO1CVPHBd6
         bwpCWMdIc/tXFuLQDFPK4EJ4Ue7Yu3K0BA+aNgc1FC20u1K8zBygI4crUmhorxOweQN6
         EBOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=GhNgzXtM4tGvVEyxgoC3lFmAbUBSKHJWtkDkmPBUve8=;
        b=AhEvOjHigXH/k8mx2iXcLqxvj3GgsvLMd7Z3gdFJhOysfjET6OczPVvFW2+/XYlIWh
         jtusJhgEb93sVAdqfPsGY1e23KQWzEhc830anpefhmy+QGJXDuLCMllGfW4JP8vW9DZu
         RxA6heWkeu5hE3phTySdeYtZFGKL/RiSlUKYD+ZGXfBvHg5N6iDX6qb8T1zzO0I2047G
         uMbiNgLYJqgrssd2lb8L8bnuw7HDZqFYwuvOwhjf/YWGj0EkniDkrreaz7mKjMomrP6F
         M89KpIFIwwcml09favrq0e5bXnb8Woy57ArlODpJNT467UK3S2B2/KDoUyVS4s4b7VCN
         +xSQ==
X-Gm-Message-State: APjAAAURnUReCjZhdhXWRzi+zKDKxhkow5cMeqXrTn84akvUGDFnJCAQ
        CBg1OS+VXFAc5fvS8jpRhCw=
X-Google-Smtp-Source: APXvYqx1COb71k1C7iNo5+gHRsYmRvhYuZJAyXVhivjf0PYSCvxuN9QEl+cW9xc9BHN0GLUjGq5+rw==
X-Received: by 2002:a63:140c:: with SMTP id u12mr38869255pgl.378.1560573115190;
        Fri, 14 Jun 2019 21:31:55 -0700 (PDT)
Received: from nishad (p3261240-ipngn21201hodogaya.kanagawa.ocn.ne.jp. [153.202.122.240])
        by smtp.gmail.com with ESMTPSA id g5sm3705374pjt.14.2019.06.14.21.31.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Jun 2019 21:31:54 -0700 (PDT)
Date:   Sat, 15 Jun 2019 10:01:46 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/i915: Use the correct style for SPDX License Identifier
Message-ID: <20190615043142.GA1890@nishad>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch corrects the SPDX License Identifier style
in header files related to DRM Drivers for Intel 915 Graphics.
For C header files Documentation/process/license-rules.rst
mandates C-like comments (opposed to C source files where
C++ style should be used)

Changes made by using a script provided by Joe Perches here:
https://lkml.org/lkml/2019/2/7/46
and some manual changes.

Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 drivers/gpu/drm/i915/gem/i915_gem_clflush.h          | 3 +--
 drivers/gpu/drm/i915/gem/i915_gem_context.h          | 3 +--
 drivers/gpu/drm/i915/gem/i915_gem_context_types.h    | 3 +--
 drivers/gpu/drm/i915/gem/i915_gem_ioctls.h           | 3 +--
 drivers/gpu/drm/i915/gem/i915_gem_object.h           | 3 +--
 drivers/gpu/drm/i915/gem/i915_gem_object_types.h     | 3 +--
 drivers/gpu/drm/i915/gem/i915_gem_pm.h               | 3 +--
 drivers/gpu/drm/i915/gem/i915_gemfs.h                | 3 +--
 drivers/gpu/drm/i915/gem/selftests/huge_gem_object.h | 3 +--
 drivers/gpu/drm/i915/gem/selftests/igt_gem_utils.h   | 3 +--
 drivers/gpu/drm/i915/gem/selftests/mock_context.h    | 3 +--
 drivers/gpu/drm/i915/gem/selftests/mock_dmabuf.h     | 3 +--
 drivers/gpu/drm/i915/gem/selftests/mock_gem_object.h | 3 +--
 drivers/gpu/drm/i915/gt/intel_context.h              | 3 +--
 drivers/gpu/drm/i915/gt/intel_context_types.h        | 3 +--
 drivers/gpu/drm/i915/gt/intel_engine_pm.h            | 3 +--
 drivers/gpu/drm/i915/gt/intel_engine_types.h         | 3 +--
 drivers/gpu/drm/i915/gt/intel_gpu_commands.h         | 3 +--
 drivers/gpu/drm/i915/gt/intel_gt_pm.h                | 3 +--
 drivers/gpu/drm/i915/gt/intel_lrc_reg.h              | 3 +--
 drivers/gpu/drm/i915/gt/intel_reset.h                | 3 +--
 drivers/gpu/drm/i915/gt/intel_sseu.h                 | 3 +--
 drivers/gpu/drm/i915/gt/intel_workarounds.h          | 3 +--
 drivers/gpu/drm/i915/gt/intel_workarounds_types.h    | 3 +--
 drivers/gpu/drm/i915/i915_active.h                   | 3 +--
 drivers/gpu/drm/i915/i915_active_types.h             | 3 +--
 drivers/gpu/drm/i915/i915_gem_batch_pool.h           | 3 +--
 drivers/gpu/drm/i915/i915_globals.h                  | 3 +--
 drivers/gpu/drm/i915/i915_gpu_error.h                | 3 +--
 drivers/gpu/drm/i915/i915_oa_bdw.h                   | 3 +--
 drivers/gpu/drm/i915/i915_oa_bxt.h                   | 3 +--
 drivers/gpu/drm/i915/i915_oa_cflgt2.h                | 3 +--
 drivers/gpu/drm/i915/i915_oa_cflgt3.h                | 3 +--
 drivers/gpu/drm/i915/i915_oa_chv.h                   | 3 +--
 drivers/gpu/drm/i915/i915_oa_cnl.h                   | 3 +--
 drivers/gpu/drm/i915/i915_oa_glk.h                   | 3 +--
 drivers/gpu/drm/i915/i915_oa_hsw.h                   | 3 +--
 drivers/gpu/drm/i915/i915_oa_icl.h                   | 3 +--
 drivers/gpu/drm/i915/i915_oa_kblgt2.h                | 3 +--
 drivers/gpu/drm/i915/i915_oa_kblgt3.h                | 3 +--
 drivers/gpu/drm/i915/i915_oa_sklgt2.h                | 3 +--
 drivers/gpu/drm/i915/i915_oa_sklgt3.h                | 3 +--
 drivers/gpu/drm/i915/i915_oa_sklgt4.h                | 3 +--
 drivers/gpu/drm/i915/i915_pmu.h                      | 3 +--
 drivers/gpu/drm/i915/i915_priolist_types.h           | 3 +--
 drivers/gpu/drm/i915/i915_query.h                    | 3 +--
 drivers/gpu/drm/i915/i915_scatterlist.h              | 3 +--
 drivers/gpu/drm/i915/i915_scheduler.h                | 3 +--
 drivers/gpu/drm/i915/i915_scheduler_types.h          | 3 +--
 drivers/gpu/drm/i915/i915_sw_fence.h                 | 3 +--
 drivers/gpu/drm/i915/i915_timeline_types.h           | 3 +--
 drivers/gpu/drm/i915/i915_user_extensions.h          | 3 +--
 drivers/gpu/drm/i915/intel_huc_fw.h                  | 3 +--
 drivers/gpu/drm/i915/intel_wakeref.h                 | 3 +--
 drivers/gpu/drm/i915/intel_wopcm.h                   | 3 +--
 drivers/gpu/drm/i915/selftests/igt_flush_test.h      | 3 +--
 drivers/gpu/drm/i915/selftests/igt_live_test.h       | 3 +--
 drivers/gpu/drm/i915/selftests/igt_reset.h           | 3 +--
 drivers/gpu/drm/i915/selftests/igt_spinner.h         | 3 +--
 drivers/gpu/drm/i915/selftests/igt_wedge_me.h        | 3 +--
 drivers/gpu/drm/i915/selftests/mock_timeline.h       | 3 +--
 61 files changed, 61 insertions(+), 122 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_clflush.h b/drivers/gpu/drm/i915/gem/i915_gem_clflush.h
index e6c382973129..9d7ee1579900 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_clflush.h
+++ b/drivers/gpu/drm/i915/gem/i915_gem_clflush.h
@@ -1,6 +1,5 @@
+/* SPDX-License-Identifier: MIT */
 /*
- * SPDX-License-Identifier: MIT
- *
  * Copyright © 2016 Intel Corporation
  */
 
diff --git a/drivers/gpu/drm/i915/gem/i915_gem_context.h b/drivers/gpu/drm/i915/gem/i915_gem_context.h
index 630392c77e48..26a965805e7a 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_context.h
+++ b/drivers/gpu/drm/i915/gem/i915_gem_context.h
@@ -1,6 +1,5 @@
+/* SPDX-License-Identifier: MIT */
 /*
- * SPDX-License-Identifier: MIT
- *
  * Copyright © 2016 Intel Corporation
  */
 
diff --git a/drivers/gpu/drm/i915/gem/i915_gem_context_types.h b/drivers/gpu/drm/i915/gem/i915_gem_context_types.h
index cc513410eeef..7f8557f505ed 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_context_types.h
+++ b/drivers/gpu/drm/i915/gem/i915_gem_context_types.h
@@ -1,6 +1,5 @@
+/* SPDX-License-Identifier: MIT */
 /*
- * SPDX-License-Identifier: MIT
- *
  * Copyright © 2019 Intel Corporation
  */
 
diff --git a/drivers/gpu/drm/i915/gem/i915_gem_ioctls.h b/drivers/gpu/drm/i915/gem/i915_gem_ioctls.h
index ddc7f2a52b3e..0326e985943c 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_ioctls.h
+++ b/drivers/gpu/drm/i915/gem/i915_gem_ioctls.h
@@ -1,6 +1,5 @@
+/* SPDX-License-Identifier: MIT */
 /*
- * SPDX-License-Identifier: MIT
- *
  * Copyright © 2019 Intel Corporation
  */
 
diff --git a/drivers/gpu/drm/i915/gem/i915_gem_object.h b/drivers/gpu/drm/i915/gem/i915_gem_object.h
index 7cb1871d7128..5f5a729d1b40 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_object.h
+++ b/drivers/gpu/drm/i915/gem/i915_gem_object.h
@@ -1,6 +1,5 @@
+/* SPDX-License-Identifier: MIT */
 /*
- * SPDX-License-Identifier: MIT
- *
  * Copyright © 2016 Intel Corporation
  */
 
diff --git a/drivers/gpu/drm/i915/gem/i915_gem_object_types.h b/drivers/gpu/drm/i915/gem/i915_gem_object_types.h
index 5b05698619ce..254c9391fb57 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_object_types.h
+++ b/drivers/gpu/drm/i915/gem/i915_gem_object_types.h
@@ -1,6 +1,5 @@
+/* SPDX-License-Identifier: MIT */
 /*
- * SPDX-License-Identifier: MIT
- *
  * Copyright © 2016 Intel Corporation
  */
 
diff --git a/drivers/gpu/drm/i915/gem/i915_gem_pm.h b/drivers/gpu/drm/i915/gem/i915_gem_pm.h
index 6f7d5d11ac3b..e5d8c8adb8d9 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_pm.h
+++ b/drivers/gpu/drm/i915/gem/i915_gem_pm.h
@@ -1,6 +1,5 @@
+/* SPDX-License-Identifier: MIT */
 /*
- * SPDX-License-Identifier: MIT
- *
  * Copyright © 2019 Intel Corporation
  */
 
diff --git a/drivers/gpu/drm/i915/gem/i915_gemfs.h b/drivers/gpu/drm/i915/gem/i915_gemfs.h
index 2a1e59af3e4a..66b6b12b92d8 100644
--- a/drivers/gpu/drm/i915/gem/i915_gemfs.h
+++ b/drivers/gpu/drm/i915/gem/i915_gemfs.h
@@ -1,6 +1,5 @@
+/* SPDX-License-Identifier: MIT */
 /*
- * SPDX-License-Identifier: MIT
- *
  * Copyright © 2017 Intel Corporation
  */
 
diff --git a/drivers/gpu/drm/i915/gem/selftests/huge_gem_object.h b/drivers/gpu/drm/i915/gem/selftests/huge_gem_object.h
index 549c1394bcdc..5afc1fa40d93 100644
--- a/drivers/gpu/drm/i915/gem/selftests/huge_gem_object.h
+++ b/drivers/gpu/drm/i915/gem/selftests/huge_gem_object.h
@@ -1,6 +1,5 @@
+/* SPDX-License-Identifier: MIT */
 /*
- * SPDX-License-Identifier: MIT
- *
  * Copyright © 2016 Intel Corporation
  */
 
diff --git a/drivers/gpu/drm/i915/gem/selftests/igt_gem_utils.h b/drivers/gpu/drm/i915/gem/selftests/igt_gem_utils.h
index 0f17251cf75d..9ee66c11cdb1 100644
--- a/drivers/gpu/drm/i915/gem/selftests/igt_gem_utils.h
+++ b/drivers/gpu/drm/i915/gem/selftests/igt_gem_utils.h
@@ -1,6 +1,5 @@
+/* SPDX-License-Identifier: MIT */
 /*
- * SPDX-License-Identifier: MIT
- *
  * Copyright © 2018 Intel Corporation
  */
 
diff --git a/drivers/gpu/drm/i915/gem/selftests/mock_context.h b/drivers/gpu/drm/i915/gem/selftests/mock_context.h
index 0b926653914f..4a02874419a0 100644
--- a/drivers/gpu/drm/i915/gem/selftests/mock_context.h
+++ b/drivers/gpu/drm/i915/gem/selftests/mock_context.h
@@ -1,6 +1,5 @@
+/* SPDX-License-Identifier: MIT */
 /*
- * SPDX-License-Identifier: MIT
- *
  * Copyright © 2016 Intel Corporation
  */
 
diff --git a/drivers/gpu/drm/i915/gem/selftests/mock_dmabuf.h b/drivers/gpu/drm/i915/gem/selftests/mock_dmabuf.h
index f0f8bbd82dfc..9ab4752a03d0 100644
--- a/drivers/gpu/drm/i915/gem/selftests/mock_dmabuf.h
+++ b/drivers/gpu/drm/i915/gem/selftests/mock_dmabuf.h
@@ -1,6 +1,5 @@
+/* SPDX-License-Identifier: MIT */
 /*
- * SPDX-License-Identifier: MIT
- *
  * Copyright © 2016 Intel Corporation
  */
 
diff --git a/drivers/gpu/drm/i915/gem/selftests/mock_gem_object.h b/drivers/gpu/drm/i915/gem/selftests/mock_gem_object.h
index 370360b4a148..7cd66effb204 100644
--- a/drivers/gpu/drm/i915/gem/selftests/mock_gem_object.h
+++ b/drivers/gpu/drm/i915/gem/selftests/mock_gem_object.h
@@ -1,6 +1,5 @@
+/* SPDX-License-Identifier: MIT */
 /*
- * SPDX-License-Identifier: MIT
- *
  * Copyright © 2016 Intel Corporation
  */
 
diff --git a/drivers/gpu/drm/i915/gt/intel_context.h b/drivers/gpu/drm/i915/gt/intel_context.h
index 6d5453ba2c1e..0dc25dcd7cb5 100644
--- a/drivers/gpu/drm/i915/gt/intel_context.h
+++ b/drivers/gpu/drm/i915/gt/intel_context.h
@@ -1,6 +1,5 @@
+/* SPDX-License-Identifier: MIT */
 /*
- * SPDX-License-Identifier: MIT
- *
  * Copyright © 2019 Intel Corporation
  */
 
diff --git a/drivers/gpu/drm/i915/gt/intel_context_types.h b/drivers/gpu/drm/i915/gt/intel_context_types.h
index 825fcf0ac9c4..3f5957bbb746 100644
--- a/drivers/gpu/drm/i915/gt/intel_context_types.h
+++ b/drivers/gpu/drm/i915/gt/intel_context_types.h
@@ -1,6 +1,5 @@
+/* SPDX-License-Identifier: MIT */
 /*
- * SPDX-License-Identifier: MIT
- *
  * Copyright © 2019 Intel Corporation
  */
 
diff --git a/drivers/gpu/drm/i915/gt/intel_engine_pm.h b/drivers/gpu/drm/i915/gt/intel_engine_pm.h
index b326cd993d60..33b580196323 100644
--- a/drivers/gpu/drm/i915/gt/intel_engine_pm.h
+++ b/drivers/gpu/drm/i915/gt/intel_engine_pm.h
@@ -1,6 +1,5 @@
+/* SPDX-License-Identifier: MIT */
 /*
- * SPDX-License-Identifier: MIT
- *
  * Copyright © 2019 Intel Corporation
  */
 
diff --git a/drivers/gpu/drm/i915/gt/intel_engine_types.h b/drivers/gpu/drm/i915/gt/intel_engine_types.h
index 01223864237a..0ed0156455e3 100644
--- a/drivers/gpu/drm/i915/gt/intel_engine_types.h
+++ b/drivers/gpu/drm/i915/gt/intel_engine_types.h
@@ -1,6 +1,5 @@
+/* SPDX-License-Identifier: MIT */
 /*
- * SPDX-License-Identifier: MIT
- *
  * Copyright © 2019 Intel Corporation
  */
 
diff --git a/drivers/gpu/drm/i915/gt/intel_gpu_commands.h b/drivers/gpu/drm/i915/gt/intel_gpu_commands.h
index eec31e36aca7..90a74f80edef 100644
--- a/drivers/gpu/drm/i915/gt/intel_gpu_commands.h
+++ b/drivers/gpu/drm/i915/gt/intel_gpu_commands.h
@@ -1,6 +1,5 @@
+/* SPDX-License-Identifier: MIT */
 /*
- * SPDX-License-Identifier: MIT
- *
  * Copyright � 2003-2018 Intel Corporation
  */
 
diff --git a/drivers/gpu/drm/i915/gt/intel_gt_pm.h b/drivers/gpu/drm/i915/gt/intel_gt_pm.h
index 7dd1130a19a4..f800a59152cd 100644
--- a/drivers/gpu/drm/i915/gt/intel_gt_pm.h
+++ b/drivers/gpu/drm/i915/gt/intel_gt_pm.h
@@ -1,6 +1,5 @@
+/* SPDX-License-Identifier: MIT */
 /*
- * SPDX-License-Identifier: MIT
- *
  * Copyright © 2019 Intel Corporation
  */
 
diff --git a/drivers/gpu/drm/i915/gt/intel_lrc_reg.h b/drivers/gpu/drm/i915/gt/intel_lrc_reg.h
index 5ef932d810a7..a5013a4746be 100644
--- a/drivers/gpu/drm/i915/gt/intel_lrc_reg.h
+++ b/drivers/gpu/drm/i915/gt/intel_lrc_reg.h
@@ -1,6 +1,5 @@
+/* SPDX-License-Identifier: MIT */
 /*
- * SPDX-License-Identifier: MIT
- *
  * Copyright © 2014-2018 Intel Corporation
  */
 
diff --git a/drivers/gpu/drm/i915/gt/intel_reset.h b/drivers/gpu/drm/i915/gt/intel_reset.h
index 580ebdb59eca..328cd7a2e6b0 100644
--- a/drivers/gpu/drm/i915/gt/intel_reset.h
+++ b/drivers/gpu/drm/i915/gt/intel_reset.h
@@ -1,6 +1,5 @@
+/* SPDX-License-Identifier: MIT */
 /*
- * SPDX-License-Identifier: MIT
- *
  * Copyright © 2008-2018 Intel Corporation
  */
 
diff --git a/drivers/gpu/drm/i915/gt/intel_sseu.h b/drivers/gpu/drm/i915/gt/intel_sseu.h
index b50d0401a4e2..49a258dab704 100644
--- a/drivers/gpu/drm/i915/gt/intel_sseu.h
+++ b/drivers/gpu/drm/i915/gt/intel_sseu.h
@@ -1,6 +1,5 @@
+/* SPDX-License-Identifier: MIT */
 /*
- * SPDX-License-Identifier: MIT
- *
  * Copyright © 2019 Intel Corporation
  */
 
diff --git a/drivers/gpu/drm/i915/gt/intel_workarounds.h b/drivers/gpu/drm/i915/gt/intel_workarounds.h
index 3761a6ee58bb..8fcce5c7f386 100644
--- a/drivers/gpu/drm/i915/gt/intel_workarounds.h
+++ b/drivers/gpu/drm/i915/gt/intel_workarounds.h
@@ -1,6 +1,5 @@
+/* SPDX-License-Identifier: MIT */
 /*
- * SPDX-License-Identifier: MIT
- *
  * Copyright © 2014-2018 Intel Corporation
  */
 
diff --git a/drivers/gpu/drm/i915/gt/intel_workarounds_types.h b/drivers/gpu/drm/i915/gt/intel_workarounds_types.h
index 42ac1fb99572..fd314dce42b7 100644
--- a/drivers/gpu/drm/i915/gt/intel_workarounds_types.h
+++ b/drivers/gpu/drm/i915/gt/intel_workarounds_types.h
@@ -1,6 +1,5 @@
+/* SPDX-License-Identifier: MIT */
 /*
- * SPDX-License-Identifier: MIT
- *
  * Copyright © 2014-2018 Intel Corporation
  */
 
diff --git a/drivers/gpu/drm/i915/i915_active.h b/drivers/gpu/drm/i915/i915_active.h
index 7d758719ce39..5534a0d1dce8 100644
--- a/drivers/gpu/drm/i915/i915_active.h
+++ b/drivers/gpu/drm/i915/i915_active.h
@@ -1,6 +1,5 @@
+/* SPDX-License-Identifier: MIT */
 /*
- * SPDX-License-Identifier: MIT
- *
  * Copyright © 2019 Intel Corporation
  */
 
diff --git a/drivers/gpu/drm/i915/i915_active_types.h b/drivers/gpu/drm/i915/i915_active_types.h
index b679253b53a5..74a3b42d6b2a 100644
--- a/drivers/gpu/drm/i915/i915_active_types.h
+++ b/drivers/gpu/drm/i915/i915_active_types.h
@@ -1,6 +1,5 @@
+/* SPDX-License-Identifier: MIT */
 /*
- * SPDX-License-Identifier: MIT
- *
  * Copyright © 2019 Intel Corporation
  */
 
diff --git a/drivers/gpu/drm/i915/i915_gem_batch_pool.h b/drivers/gpu/drm/i915/i915_gem_batch_pool.h
index feeeeeaa54d8..4773051d58c6 100644
--- a/drivers/gpu/drm/i915/i915_gem_batch_pool.h
+++ b/drivers/gpu/drm/i915/i915_gem_batch_pool.h
@@ -1,6 +1,5 @@
+/* SPDX-License-Identifier: MIT */
 /*
- * SPDX-License-Identifier: MIT
- *
  * Copyright © 2014-2018 Intel Corporation
  */
 
diff --git a/drivers/gpu/drm/i915/i915_globals.h b/drivers/gpu/drm/i915/i915_globals.h
index 04c1ce107fc0..73e1054ffaf3 100644
--- a/drivers/gpu/drm/i915/i915_globals.h
+++ b/drivers/gpu/drm/i915/i915_globals.h
@@ -1,6 +1,5 @@
+/* SPDX-License-Identifier: MIT */
 /*
- * SPDX-License-Identifier: MIT
- *
  * Copyright © 2019 Intel Corporation
  */
 
diff --git a/drivers/gpu/drm/i915/i915_gpu_error.h b/drivers/gpu/drm/i915/i915_gpu_error.h
index 2ecd0c6a1c94..69d7b359e42f 100644
--- a/drivers/gpu/drm/i915/i915_gpu_error.h
+++ b/drivers/gpu/drm/i915/i915_gpu_error.h
@@ -1,6 +1,5 @@
+/* SPDX-License-Identifier: MIT */
 /*
- * SPDX-License-Identifier: MIT
- *
  * Copyright � 2008-2018 Intel Corporation
  */
 
diff --git a/drivers/gpu/drm/i915/i915_oa_bdw.h b/drivers/gpu/drm/i915/i915_oa_bdw.h
index 0e667f1a8aa1..acefe1c2cfe2 100644
--- a/drivers/gpu/drm/i915/i915_oa_bdw.h
+++ b/drivers/gpu/drm/i915/i915_oa_bdw.h
@@ -1,6 +1,5 @@
+/* SPDX-License-Identifier: MIT */
 /*
- * SPDX-License-Identifier: MIT
- *
  * Copyright © 2018 Intel Corporation
  *
  * Autogenerated file by GPU Top : https://github.com/rib/gputop
diff --git a/drivers/gpu/drm/i915/i915_oa_bxt.h b/drivers/gpu/drm/i915/i915_oa_bxt.h
index 679e92cf4f1d..3aceb1634d6a 100644
--- a/drivers/gpu/drm/i915/i915_oa_bxt.h
+++ b/drivers/gpu/drm/i915/i915_oa_bxt.h
@@ -1,6 +1,5 @@
+/* SPDX-License-Identifier: MIT */
 /*
- * SPDX-License-Identifier: MIT
- *
  * Copyright © 2018 Intel Corporation
  *
  * Autogenerated file by GPU Top : https://github.com/rib/gputop
diff --git a/drivers/gpu/drm/i915/i915_oa_cflgt2.h b/drivers/gpu/drm/i915/i915_oa_cflgt2.h
index 4d6025559bbe..4ee15c857941 100644
--- a/drivers/gpu/drm/i915/i915_oa_cflgt2.h
+++ b/drivers/gpu/drm/i915/i915_oa_cflgt2.h
@@ -1,6 +1,5 @@
+/* SPDX-License-Identifier: MIT */
 /*
- * SPDX-License-Identifier: MIT
- *
  * Copyright © 2018 Intel Corporation
  *
  * Autogenerated file by GPU Top : https://github.com/rib/gputop
diff --git a/drivers/gpu/drm/i915/i915_oa_cflgt3.h b/drivers/gpu/drm/i915/i915_oa_cflgt3.h
index 0697f4077402..01bda863294e 100644
--- a/drivers/gpu/drm/i915/i915_oa_cflgt3.h
+++ b/drivers/gpu/drm/i915/i915_oa_cflgt3.h
@@ -1,6 +1,5 @@
+/* SPDX-License-Identifier: MIT */
 /*
- * SPDX-License-Identifier: MIT
- *
  * Copyright © 2018 Intel Corporation
  *
  * Autogenerated file by GPU Top : https://github.com/rib/gputop
diff --git a/drivers/gpu/drm/i915/i915_oa_chv.h b/drivers/gpu/drm/i915/i915_oa_chv.h
index 0986eae3135f..c6316963e44a 100644
--- a/drivers/gpu/drm/i915/i915_oa_chv.h
+++ b/drivers/gpu/drm/i915/i915_oa_chv.h
@@ -1,6 +1,5 @@
+/* SPDX-License-Identifier: MIT */
 /*
- * SPDX-License-Identifier: MIT
- *
  * Copyright © 2018 Intel Corporation
  *
  * Autogenerated file by GPU Top : https://github.com/rib/gputop
diff --git a/drivers/gpu/drm/i915/i915_oa_cnl.h b/drivers/gpu/drm/i915/i915_oa_cnl.h
index e830a406aff2..63d454c48c23 100644
--- a/drivers/gpu/drm/i915/i915_oa_cnl.h
+++ b/drivers/gpu/drm/i915/i915_oa_cnl.h
@@ -1,6 +1,5 @@
+/* SPDX-License-Identifier: MIT */
 /*
- * SPDX-License-Identifier: MIT
- *
  * Copyright © 2018 Intel Corporation
  *
  * Autogenerated file by GPU Top : https://github.com/rib/gputop
diff --git a/drivers/gpu/drm/i915/i915_oa_glk.h b/drivers/gpu/drm/i915/i915_oa_glk.h
index 06dedf991edb..36c387d509de 100644
--- a/drivers/gpu/drm/i915/i915_oa_glk.h
+++ b/drivers/gpu/drm/i915/i915_oa_glk.h
@@ -1,6 +1,5 @@
+/* SPDX-License-Identifier: MIT */
 /*
- * SPDX-License-Identifier: MIT
- *
  * Copyright © 2018 Intel Corporation
  *
  * Autogenerated file by GPU Top : https://github.com/rib/gputop
diff --git a/drivers/gpu/drm/i915/i915_oa_hsw.h b/drivers/gpu/drm/i915/i915_oa_hsw.h
index 3d0c870cd0bd..26c43e681898 100644
--- a/drivers/gpu/drm/i915/i915_oa_hsw.h
+++ b/drivers/gpu/drm/i915/i915_oa_hsw.h
@@ -1,6 +1,5 @@
+/* SPDX-License-Identifier: MIT */
 /*
- * SPDX-License-Identifier: MIT
- *
  * Copyright © 2018 Intel Corporation
  *
  * Autogenerated file by GPU Top : https://github.com/rib/gputop
diff --git a/drivers/gpu/drm/i915/i915_oa_icl.h b/drivers/gpu/drm/i915/i915_oa_icl.h
index 24eaa97d61ba..5c59e2bd201e 100644
--- a/drivers/gpu/drm/i915/i915_oa_icl.h
+++ b/drivers/gpu/drm/i915/i915_oa_icl.h
@@ -1,6 +1,5 @@
+/* SPDX-License-Identifier: MIT */
 /*
- * SPDX-License-Identifier: MIT
- *
  * Copyright © 2018 Intel Corporation
  *
  * Autogenerated file by GPU Top : https://github.com/rib/gputop
diff --git a/drivers/gpu/drm/i915/i915_oa_kblgt2.h b/drivers/gpu/drm/i915/i915_oa_kblgt2.h
index a55398a904de..c13f7de0b5bf 100644
--- a/drivers/gpu/drm/i915/i915_oa_kblgt2.h
+++ b/drivers/gpu/drm/i915/i915_oa_kblgt2.h
@@ -1,6 +1,5 @@
+/* SPDX-License-Identifier: MIT */
 /*
- * SPDX-License-Identifier: MIT
- *
  * Copyright © 2018 Intel Corporation
  *
  * Autogenerated file by GPU Top : https://github.com/rib/gputop
diff --git a/drivers/gpu/drm/i915/i915_oa_kblgt3.h b/drivers/gpu/drm/i915/i915_oa_kblgt3.h
index 3ddd3483b7cc..3e702e88425b 100644
--- a/drivers/gpu/drm/i915/i915_oa_kblgt3.h
+++ b/drivers/gpu/drm/i915/i915_oa_kblgt3.h
@@ -1,6 +1,5 @@
+/* SPDX-License-Identifier: MIT */
 /*
- * SPDX-License-Identifier: MIT
- *
  * Copyright © 2018 Intel Corporation
  *
  * Autogenerated file by GPU Top : https://github.com/rib/gputop
diff --git a/drivers/gpu/drm/i915/i915_oa_sklgt2.h b/drivers/gpu/drm/i915/i915_oa_sklgt2.h
index be6256037239..51764538d62e 100644
--- a/drivers/gpu/drm/i915/i915_oa_sklgt2.h
+++ b/drivers/gpu/drm/i915/i915_oa_sklgt2.h
@@ -1,6 +1,5 @@
+/* SPDX-License-Identifier: MIT */
 /*
- * SPDX-License-Identifier: MIT
- *
  * Copyright © 2018 Intel Corporation
  *
  * Autogenerated file by GPU Top : https://github.com/rib/gputop
diff --git a/drivers/gpu/drm/i915/i915_oa_sklgt3.h b/drivers/gpu/drm/i915/i915_oa_sklgt3.h
index 650beb068e56..c78488c9e9f2 100644
--- a/drivers/gpu/drm/i915/i915_oa_sklgt3.h
+++ b/drivers/gpu/drm/i915/i915_oa_sklgt3.h
@@ -1,6 +1,5 @@
+/* SPDX-License-Identifier: MIT */
 /*
- * SPDX-License-Identifier: MIT
- *
  * Copyright © 2018 Intel Corporation
  *
  * Autogenerated file by GPU Top : https://github.com/rib/gputop
diff --git a/drivers/gpu/drm/i915/i915_oa_sklgt4.h b/drivers/gpu/drm/i915/i915_oa_sklgt4.h
index 8dcf849d131e..5efa090a726c 100644
--- a/drivers/gpu/drm/i915/i915_oa_sklgt4.h
+++ b/drivers/gpu/drm/i915/i915_oa_sklgt4.h
@@ -1,6 +1,5 @@
+/* SPDX-License-Identifier: MIT */
 /*
- * SPDX-License-Identifier: MIT
- *
  * Copyright © 2018 Intel Corporation
  *
  * Autogenerated file by GPU Top : https://github.com/rib/gputop
diff --git a/drivers/gpu/drm/i915/i915_pmu.h b/drivers/gpu/drm/i915/i915_pmu.h
index 4fc4f2478301..e1d89fb7e995 100644
--- a/drivers/gpu/drm/i915/i915_pmu.h
+++ b/drivers/gpu/drm/i915/i915_pmu.h
@@ -1,6 +1,5 @@
+/* SPDX-License-Identifier: MIT */
 /*
- * SPDX-License-Identifier: MIT
- *
  * Copyright © 2017-2018 Intel Corporation
  */
 
diff --git a/drivers/gpu/drm/i915/i915_priolist_types.h b/drivers/gpu/drm/i915/i915_priolist_types.h
index 49709de69875..3cb5218ddf34 100644
--- a/drivers/gpu/drm/i915/i915_priolist_types.h
+++ b/drivers/gpu/drm/i915/i915_priolist_types.h
@@ -1,6 +1,5 @@
+/* SPDX-License-Identifier: MIT */
 /*
- * SPDX-License-Identifier: MIT
- *
  * Copyright © 2018 Intel Corporation
  */
 
diff --git a/drivers/gpu/drm/i915/i915_query.h b/drivers/gpu/drm/i915/i915_query.h
index 31dcef181f63..94e03e773774 100644
--- a/drivers/gpu/drm/i915/i915_query.h
+++ b/drivers/gpu/drm/i915/i915_query.h
@@ -1,6 +1,5 @@
+/* SPDX-License-Identifier: MIT */
 /*
- * SPDX-License-Identifier: MIT
- *
  * Copyright © 2018 Intel Corporation
  */
 
diff --git a/drivers/gpu/drm/i915/i915_scatterlist.h b/drivers/gpu/drm/i915/i915_scatterlist.h
index 6617963df9ed..33956d140f5c 100644
--- a/drivers/gpu/drm/i915/i915_scatterlist.h
+++ b/drivers/gpu/drm/i915/i915_scatterlist.h
@@ -1,6 +1,5 @@
+/* SPDX-License-Identifier: MIT */
 /*
- * SPDX-License-Identifier: MIT
- *
  * Copyright © 2016 Intel Corporation
  */
 
diff --git a/drivers/gpu/drm/i915/i915_scheduler.h b/drivers/gpu/drm/i915/i915_scheduler.h
index 7eefccff39bf..d51048152a14 100644
--- a/drivers/gpu/drm/i915/i915_scheduler.h
+++ b/drivers/gpu/drm/i915/i915_scheduler.h
@@ -1,6 +1,5 @@
+/* SPDX-License-Identifier: MIT */
 /*
- * SPDX-License-Identifier: MIT
- *
  * Copyright © 2018 Intel Corporation
  */
 
diff --git a/drivers/gpu/drm/i915/i915_scheduler_types.h b/drivers/gpu/drm/i915/i915_scheduler_types.h
index 3e309631bd0b..ce46bf9cc2e5 100644
--- a/drivers/gpu/drm/i915/i915_scheduler_types.h
+++ b/drivers/gpu/drm/i915/i915_scheduler_types.h
@@ -1,6 +1,5 @@
+/* SPDX-License-Identifier: MIT */
 /*
- * SPDX-License-Identifier: MIT
- *
  * Copyright © 2018 Intel Corporation
  */
 
diff --git a/drivers/gpu/drm/i915/i915_sw_fence.h b/drivers/gpu/drm/i915/i915_sw_fence.h
index 9cb5c3b307a6..88fc90d12447 100644
--- a/drivers/gpu/drm/i915/i915_sw_fence.h
+++ b/drivers/gpu/drm/i915/i915_sw_fence.h
@@ -1,6 +1,5 @@
+/* SPDX-License-Identifier: MIT */
 /*
- * SPDX-License-Identifier: MIT
- *
  * i915_sw_fence.h - library routines for N:M synchronisation points
  *
  * Copyright (C) 2016 Intel Corporation
diff --git a/drivers/gpu/drm/i915/i915_timeline_types.h b/drivers/gpu/drm/i915/i915_timeline_types.h
index 1688705f4a2b..1b88f131e668 100644
--- a/drivers/gpu/drm/i915/i915_timeline_types.h
+++ b/drivers/gpu/drm/i915/i915_timeline_types.h
@@ -1,6 +1,5 @@
+/* SPDX-License-Identifier: MIT */
 /*
- * SPDX-License-Identifier: MIT
- *
  * Copyright © 2016 Intel Corporation
  */
 
diff --git a/drivers/gpu/drm/i915/i915_user_extensions.h b/drivers/gpu/drm/i915/i915_user_extensions.h
index a14bf6bba9a1..0760c95e0e5f 100644
--- a/drivers/gpu/drm/i915/i915_user_extensions.h
+++ b/drivers/gpu/drm/i915/i915_user_extensions.h
@@ -1,6 +1,5 @@
+/* SPDX-License-Identifier: MIT */
 /*
- * SPDX-License-Identifier: MIT
- *
  * Copyright © 2018 Intel Corporation
  */
 
diff --git a/drivers/gpu/drm/i915/intel_huc_fw.h b/drivers/gpu/drm/i915/intel_huc_fw.h
index 8a00a0ebddc5..e97e75dbdb1f 100644
--- a/drivers/gpu/drm/i915/intel_huc_fw.h
+++ b/drivers/gpu/drm/i915/intel_huc_fw.h
@@ -1,6 +1,5 @@
+/* SPDX-License-Identifier: MIT */
 /*
- * SPDX-License-Identifier: MIT
- *
  * Copyright © 2014-2018 Intel Corporation
  */
 
diff --git a/drivers/gpu/drm/i915/intel_wakeref.h b/drivers/gpu/drm/i915/intel_wakeref.h
index 8a5f85c000ce..c18d09c690b1 100644
--- a/drivers/gpu/drm/i915/intel_wakeref.h
+++ b/drivers/gpu/drm/i915/intel_wakeref.h
@@ -1,6 +1,5 @@
+/* SPDX-License-Identifier: MIT */
 /*
- * SPDX-License-Identifier: MIT
- *
  * Copyright © 2019 Intel Corporation
  */
 
diff --git a/drivers/gpu/drm/i915/intel_wopcm.h b/drivers/gpu/drm/i915/intel_wopcm.h
index 114401971520..5c77baee0db0 100644
--- a/drivers/gpu/drm/i915/intel_wopcm.h
+++ b/drivers/gpu/drm/i915/intel_wopcm.h
@@ -1,6 +1,5 @@
+/* SPDX-License-Identifier: MIT */
 /*
- * SPDX-License-Identifier: MIT
- *
  * Copyright © 2017-2018 Intel Corporation
  */
 
diff --git a/drivers/gpu/drm/i915/selftests/igt_flush_test.h b/drivers/gpu/drm/i915/selftests/igt_flush_test.h
index 63e009927c43..5772b54d7884 100644
--- a/drivers/gpu/drm/i915/selftests/igt_flush_test.h
+++ b/drivers/gpu/drm/i915/selftests/igt_flush_test.h
@@ -1,6 +1,5 @@
+/* SPDX-License-Identifier: MIT */
 /*
- * SPDX-License-Identifier: MIT
- *
  * Copyright © 2018 Intel Corporation
  */
 
diff --git a/drivers/gpu/drm/i915/selftests/igt_live_test.h b/drivers/gpu/drm/i915/selftests/igt_live_test.h
index c0e9f99d50de..460ad2889be8 100644
--- a/drivers/gpu/drm/i915/selftests/igt_live_test.h
+++ b/drivers/gpu/drm/i915/selftests/igt_live_test.h
@@ -1,6 +1,5 @@
+/* SPDX-License-Identifier: MIT */
 /*
- * SPDX-License-Identifier: MIT
- *
  * Copyright © 2019 Intel Corporation
  */
 
diff --git a/drivers/gpu/drm/i915/selftests/igt_reset.h b/drivers/gpu/drm/i915/selftests/igt_reset.h
index 363bd853e50f..020dc5888f73 100644
--- a/drivers/gpu/drm/i915/selftests/igt_reset.h
+++ b/drivers/gpu/drm/i915/selftests/igt_reset.h
@@ -1,6 +1,5 @@
+/* SPDX-License-Identifier: MIT */
 /*
- * SPDX-License-Identifier: MIT
- *
  * Copyright © 2018 Intel Corporation
  */
 
diff --git a/drivers/gpu/drm/i915/selftests/igt_spinner.h b/drivers/gpu/drm/i915/selftests/igt_spinner.h
index 34a88ac9b47a..1e68ccfa0804 100644
--- a/drivers/gpu/drm/i915/selftests/igt_spinner.h
+++ b/drivers/gpu/drm/i915/selftests/igt_spinner.h
@@ -1,6 +1,5 @@
+/* SPDX-License-Identifier: MIT */
 /*
- * SPDX-License-Identifier: MIT
- *
  * Copyright © 2018 Intel Corporation
  */
 
diff --git a/drivers/gpu/drm/i915/selftests/igt_wedge_me.h b/drivers/gpu/drm/i915/selftests/igt_wedge_me.h
index 08e5ff11bbd9..cf7f2620fc2a 100644
--- a/drivers/gpu/drm/i915/selftests/igt_wedge_me.h
+++ b/drivers/gpu/drm/i915/selftests/igt_wedge_me.h
@@ -1,6 +1,5 @@
+/* SPDX-License-Identifier: MIT */
 /*
- * SPDX-License-Identifier: MIT
- *
  * Copyright © 2018 Intel Corporation
  */
 
diff --git a/drivers/gpu/drm/i915/selftests/mock_timeline.h b/drivers/gpu/drm/i915/selftests/mock_timeline.h
index b6deaa61110d..408d29813d22 100644
--- a/drivers/gpu/drm/i915/selftests/mock_timeline.h
+++ b/drivers/gpu/drm/i915/selftests/mock_timeline.h
@@ -1,6 +1,5 @@
+/* SPDX-License-Identifier: MIT */
 /*
- * SPDX-License-Identifier: MIT
- *
  * Copyright © 2017-2018 Intel Corporation
  */
 
-- 
2.17.1

