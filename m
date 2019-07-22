Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44456C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 22:31:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D78821985
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 22:31:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e9z1PXWs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733197AbfGVWb1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 18:31:27 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:53571 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729005AbfGVWb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 18:31:27 -0400
Received: by mail-pg1-f201.google.com with SMTP id t18so14599941pgu.20
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 15:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=oIv+GpT3Jmjvvs475a+O0pvmLeihB9t3PTRepY2uxPk=;
        b=e9z1PXWshOZDjgKxqCTPRkc0JUjHsmX/IqevVTyDuPiWkRIB+0CYAmRNnmgu7/KqQ6
         8QXqjGXLFmWpWuZy7oguTJcroQBSIcYcP9G95Z7rXaXoOQufl44at826em0QasXPcCAP
         tdsuvy2cj/g/s5hmBR8VOLUfCrDdzZXdMhyAo5ZI7soZ5yJwujP1Ke5+GMFFjd+Lhizc
         27s97VDqPn2Z556kjdN12wQLWPZJgDFFhbzIkQSMuvxcmgNCVys8t/SIDJ00InxZV0RL
         Yc0B3Nb4oKMItoq/l6N5ZSFn3vjZ06AtwsYr8wQoyfGg/bItRNpOtBBp056fivsBekUQ
         tkhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=oIv+GpT3Jmjvvs475a+O0pvmLeihB9t3PTRepY2uxPk=;
        b=RZXt7D+7WWH8EmT0Qpps1J7A6rQnDI1YUPEUuv9AXeYjVtMgFwwiazK2DrLmMqz+iR
         OGIUWd2D+ZQgNkj5rV6KbOB4Jqgdr0zqy5wbR95Vugke8i5Bt9HlEE7l7q7EaTLv1+Gt
         aARebf9B3j0R0zZTSrLSVzox5+m9bzDEiZTtRU0VUArfp6g33hBu6xEhHmntrRXWQP11
         5VnNHVKvODiuacfjt4QxyX6bJfgJ9aNpTODs2GRtwlhsoRplXyO1xZKmP8przqJZLCnr
         mFxAhtRkYAjdo2fuoBKmXwxwlfJnCGGWdGO5msPpoFzEBzkMMKty+bujRazmsPixNPDZ
         GEdg==
X-Gm-Message-State: APjAAAVs3V808WKu/+5UX6SMvoOkmlMPVUbT8ny+4I36OOVGjlvhXB3x
        bPEum/32SPqUovHTBd3v4fHvNXxWGUY10tRu0tY=
X-Google-Smtp-Source: APXvYqwEcSe4MFck2BfjWshbTKFhQ7S9cI5h/jLdvcYfysTh6s8k/LGX/naPVIWZYigEduLQQu68IgsnYDMugrAbKaw=
X-Received: by 2002:a65:47c1:: with SMTP id f1mr72262210pgs.169.1563834686245;
 Mon, 22 Jul 2019 15:31:26 -0700 (PDT)
Date:   Mon, 22 Jul 2019 15:31:05 -0700
Message-Id: <20190722223112.199769-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.657.g960e92d24f-goog
Subject: [PATCH] drm/amd/display: readd -msse2 to prevent Clang from emitting
 libcalls to undefined SW FP routines
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     alexander.deucher@amd.com, harry.wentland@amd.com
Cc:     sedat.dilek@gmail.com, samitolvanen@google.com, Shirish.S@amd.com,
        mka@google.com, jyknight@google.com, natechancellor@gmail.com,
        linux@roeck-us.net, Nick Desaulniers <ndesaulniers@google.com>,
        Leo Li <sunpeng.li@amd.com>,
        "=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "=?UTF-8?q?Michel=20D=C3=A4nzer?=" <michel.daenzer@amd.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Charlene Liu <charlene.liu@amd.com>,
        Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arch/x86/Makefile disables SSE and SSE2 for the whole kernel.  The
AMDGPU drivers modified in this patch re-enable SSE but not SSE2.  Turn
on SSE2 to support emitting double precision floating point instructions
rather than calls to non-existent (usually available from gcc_s or
compiler_rt) floating point helper routines for Clang.

This was originally landed in:
commit 10117450735c ("drm/amd/display: add -msse2 to prevent Clang from emitting libcalls to undefined SW FP routines")
but reverted in:
commit 193392ed9f69 ("Revert "drm/amd/display: add -msse2 to prevent Clang from emitting libcalls to undefined SW FP routines"")
due to bugreports from GCC builds. Add guards to only do so for Clang.

Link: https://bugs.freedesktop.org/show_bug.cgi?id=109487
Link: https://github.com/ClangBuiltLinux/linux/issues/327

Suggested-by: Sedat Dilek <sedat.dilek@gmail.com>
Suggested-by: Sami Tolvanen <samitolvanen@google.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 drivers/gpu/drm/amd/display/dc/calcs/Makefile | 4 ++++
 drivers/gpu/drm/amd/display/dc/dcn20/Makefile | 4 ++++
 drivers/gpu/drm/amd/display/dc/dml/Makefile   | 4 ++++
 drivers/gpu/drm/amd/display/dc/dsc/Makefile   | 4 ++++
 4 files changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/calcs/Makefile b/drivers/gpu/drm/amd/display/dc/calcs/Makefile
index 95f332ee3e7e..16614d73a5fc 100644
--- a/drivers/gpu/drm/amd/display/dc/calcs/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/calcs/Makefile
@@ -32,6 +32,10 @@ endif
 
 calcs_ccflags := -mhard-float -msse $(cc_stack_align)
 
+ifdef CONFIG_CC_IS_CLANG
+calcs_ccflags += -msse2
+endif
+
 CFLAGS_dcn_calcs.o := $(calcs_ccflags)
 CFLAGS_dcn_calc_auto.o := $(calcs_ccflags)
 CFLAGS_dcn_calc_math.o := $(calcs_ccflags) -Wno-tautological-compare
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/Makefile b/drivers/gpu/drm/amd/display/dc/dcn20/Makefile
index e9721a906592..f57a3b281408 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/Makefile
@@ -18,6 +18,10 @@ endif
 
 CFLAGS_dcn20_resource.o := -mhard-float -msse $(cc_stack_align)
 
+ifdef CONFIG_CC_IS_CLANG
+CFLAGS_dcn20_resource.o += -msse2
+endif
+
 AMD_DAL_DCN20 = $(addprefix $(AMDDALPATH)/dc/dcn20/,$(DCN20))
 
 AMD_DISPLAY_FILES += $(AMD_DAL_DCN20)
diff --git a/drivers/gpu/drm/amd/display/dc/dml/Makefile b/drivers/gpu/drm/amd/display/dc/dml/Makefile
index 0bb7a20675c4..132ade1a234e 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile
@@ -32,6 +32,10 @@ endif
 
 dml_ccflags := -mhard-float -msse $(cc_stack_align)
 
+ifdef CONFIG_CC_IS_CLANG
+dml_ccflags += -msse2
+endif
+
 CFLAGS_display_mode_lib.o := $(dml_ccflags)
 
 ifdef CONFIG_DRM_AMD_DC_DCN2_0
diff --git a/drivers/gpu/drm/amd/display/dc/dsc/Makefile b/drivers/gpu/drm/amd/display/dc/dsc/Makefile
index e019cd9447e8..17db603f2d1f 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dsc/Makefile
@@ -9,6 +9,10 @@ endif
 
 dsc_ccflags := -mhard-float -msse $(cc_stack_align)
 
+ifdef CONFIG_CC_IS_CLANG
+dsc_ccflags += -msse2
+endif
+
 CFLAGS_rc_calc.o := $(dsc_ccflags)
 CFLAGS_rc_calc_dpi.o := $(dsc_ccflags)
 CFLAGS_codec_main_amd.o := $(dsc_ccflags)
-- 
2.22.0.657.g960e92d24f-goog

