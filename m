Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC86AECE599
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 23:02:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 753FB207FF
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 23:02:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KWxGWHf/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395085AbfJPXCj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 19:02:39 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:45295 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391366AbfJPXCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 19:02:37 -0400
Received: by mail-pl1-f201.google.com with SMTP id t12so151622plo.12
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 16:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+9wE/YnttgoSYQLeI+fM6xNhxWRLjwkrvMn1N+1ady8=;
        b=KWxGWHf/P+f67fdjVt7CHFaUPxIFnuczkzjPcZZra9YWURUHteNwdscbJ2znQA8eDV
         goEv3nDRQ4QVE54XSj97jGZSKnPPJYm/Ov6TLOC4DeDckmJ9hHj8QLEgDKRumt4d1Wnb
         2fHWw5wBhp4xYmQWaql25ZVWU2ghWSggTBnMoDugXAH+1CekRsI4PmfIgmjNGx+fQQKi
         gO+rfcHvncvjMPD1muXY+aVIPjcsFjSyHleTPM06S5sISHbiSqlBsdVMUZE2yXEoXMpv
         Bz7Apmfek4PX7D1+ys3wMXOK7h2IXkN+PV4JxSSfBH/QpzCu4c/AagQYlV5ooJOlylQn
         wLuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+9wE/YnttgoSYQLeI+fM6xNhxWRLjwkrvMn1N+1ady8=;
        b=SIJXMHkDHFXDCky4zS4cnz0JUPSChGqwht7LgFnqLJZ4XYowEFY16tRqd18MXNCXuY
         DTUzO3k1J+oI6L9xRLwW8DkObQXYKnJHzOCdr24r8DHyf8M3Tv3fbdjiiHa88V/XCwr9
         JJX+dleHrF3lhgQ8zAKi7ZqTtfwpIN92mQarXA6jF75Y4bVOtDbhgu3NG8iGhUjHt592
         FjB11S+cGZO/VdVKxUyAR4V10FNlUNgXkygRYNOtYvRMdwy5XAbJr/SmsXMAwEIgyAz8
         Mf2wMH+/+zojUstf6QLsunAYez6gYtRhLOSwWFEt1Lpjb9qBeM6sOQ1CfZE8Smbq3DI3
         +YOQ==
X-Gm-Message-State: APjAAAUoMmNziWfUpu6zoaYBD+SFWUkkz/I/fRPUd1b+gkni5wLHyQOR
        tQMeM0h0TkLcMwxPIMGHhIg0NZ/dhJd4BEi3eZY=
X-Google-Smtp-Source: APXvYqwH1yCvYBDfbKhdl19zSWC1uGut6YcPZH49DaXgT6YV4aCSTkkrAoOP3PncsvwWtgc8p0shEeoAmd14KO3c858=
X-Received: by 2002:a63:e057:: with SMTP id n23mr640963pgj.94.1571266956495;
 Wed, 16 Oct 2019 16:02:36 -0700 (PDT)
Date:   Wed, 16 Oct 2019 16:02:07 -0700
In-Reply-To: <20191016230209.39663-1-ndesaulniers@google.com>
Message-Id: <20191016230209.39663-2-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20191016230209.39663-1-ndesaulniers@google.com>
X-Mailer: git-send-email 2.23.0.700.g56cf767bdb-goog
Subject: [PATCH 1/3] drm/amdgpu: fix stack alignment ABI mismatch for Clang
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     harry.wentland@amd.com, alexander.deucher@amd.com
Cc:     yshuiv7@gmail.com, andrew.cooper3@citrix.com, arnd@arndb.de,
        clang-built-linux@googlegroups.com, mka@google.com,
        shirish.s@amd.com, David1.Zhou@amd.com, christian.koenig@amd.com,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The x86 kernel is compiled with an 8B stack alignment via
`-mpreferred-stack-boundary=3` for GCC since 3.6-rc1 via
commit d9b0cde91c60 ("x86-64, gcc: Use -mpreferred-stack-boundary=3 if supported")
or `-mstack-alignment=8` for Clang. Parts of the AMDGPU driver are
compiled with 16B stack alignment.

Generally, the stack alignment is part of the ABI. Linking together two
different translation units with differing stack alignment is dangerous,
particularly when the translation unit with the smaller stack alignment
makes calls into the translation unit with the larger stack alignment.
While 8B aligned stacks are sometimes also 16B aligned, they are not
always.

Multiple users have reported General Protection Faults (GPF) when using
the AMDGPU driver compiled with Clang. Clang is placing objects in stack
slots assuming the stack is 16B aligned, and selecting instructions that
require 16B aligned memory operands.

At runtime, syscall handlers with 8B aligned stack call into code that
assumes 16B stack alignment.  When the stack is a multiple of 8B but not
16B, these instructions result in a GPF.

Remove the code that added compatibility between the differing compiler
flags, as it will result in runtime GPFs when built with Clang. Cleanups
for GCC will be sent in later patches in the series.

Link: https://github.com/ClangBuiltLinux/linux/issues/735
Debugged-by: Yuxuan Shui <yshuiv7@gmail.com>
Reported-by: Shirish S <shirish.s@amd.com>
Reported-by: Yuxuan Shui <yshuiv7@gmail.com>
Suggested-by: Andrew Cooper <andrew.cooper3@citrix.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 drivers/gpu/drm/amd/display/dc/calcs/Makefile | 10 ++++------
 drivers/gpu/drm/amd/display/dc/dcn20/Makefile | 10 ++++------
 drivers/gpu/drm/amd/display/dc/dcn21/Makefile | 10 ++++------
 drivers/gpu/drm/amd/display/dc/dml/Makefile   | 10 ++++------
 drivers/gpu/drm/amd/display/dc/dsc/Makefile   | 10 ++++------
 5 files changed, 20 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/calcs/Makefile b/drivers/gpu/drm/amd/display/dc/calcs/Makefile
index 985633c08a26..4b1a8a08a5de 100644
--- a/drivers/gpu/drm/amd/display/dc/calcs/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/calcs/Makefile
@@ -24,13 +24,11 @@
 # It calculates Bandwidth and Watermarks values for HW programming
 #
 
-ifneq ($(call cc-option, -mpreferred-stack-boundary=4),)
-	cc_stack_align := -mpreferred-stack-boundary=4
-else ifneq ($(call cc-option, -mstack-alignment=16),)
-	cc_stack_align := -mstack-alignment=16
-endif
+calcs_ccflags := -mhard-float -msse
 
-calcs_ccflags := -mhard-float -msse $(cc_stack_align)
+ifdef CONFIG_CC_IS_GCC
+calcs_ccflags += -mpreferred-stack-boundary=4
+endif
 
 ifdef CONFIG_CC_IS_CLANG
 calcs_ccflags += -msse2
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/Makefile b/drivers/gpu/drm/amd/display/dc/dcn20/Makefile
index ddb8d5649e79..5fe3eb80075d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/Makefile
@@ -10,13 +10,11 @@ ifdef CONFIG_DRM_AMD_DC_DSC_SUPPORT
 DCN20 += dcn20_dsc.o
 endif
 
-ifneq ($(call cc-option, -mpreferred-stack-boundary=4),)
-	cc_stack_align := -mpreferred-stack-boundary=4
-else ifneq ($(call cc-option, -mstack-alignment=16),)
-	cc_stack_align := -mstack-alignment=16
-endif
+CFLAGS_$(AMDDALPATH)/dc/dcn20/dcn20_resource.o := -mhard-float -msse
 
-CFLAGS_$(AMDDALPATH)/dc/dcn20/dcn20_resource.o := -mhard-float -msse $(cc_stack_align)
+ifdef CONFIG_CC_IS_GCC
+CFLAGS_$(AMDDALPATH)/dc/dcn20/dcn20_resource.o += -mpreferred-stack-boundary=4
+endif
 
 ifdef CONFIG_CC_IS_CLANG
 CFLAGS_$(AMDDALPATH)/dc/dcn20/dcn20_resource.o += -msse2
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/Makefile b/drivers/gpu/drm/amd/display/dc/dcn21/Makefile
index ef673bffc241..7057e20748b9 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/Makefile
@@ -3,13 +3,11 @@
 
 DCN21 = dcn21_hubp.o dcn21_hubbub.o dcn21_resource.o
 
-ifneq ($(call cc-option, -mpreferred-stack-boundary=4),)
-	cc_stack_align := -mpreferred-stack-boundary=4
-else ifneq ($(call cc-option, -mstack-alignment=16),)
-	cc_stack_align := -mstack-alignment=16
-endif
+CFLAGS_$(AMDDALPATH)/dc/dcn21/dcn21_resource.o := -mhard-float -msse
 
-CFLAGS_$(AMDDALPATH)/dc/dcn21/dcn21_resource.o := -mhard-float -msse $(cc_stack_align)
+ifdef CONFIG_CC_IS_GCC
+CFLAGS_$(AMDDALPATH)/dc/dcn21/dcn21_resource.o += -mpreferred-stack-boundary=4
+endif
 
 ifdef CONFIG_CC_IS_CLANG
 CFLAGS_$(AMDDALPATH)/dc/dcn21/dcn21_resource.o += -msse2
diff --git a/drivers/gpu/drm/amd/display/dc/dml/Makefile b/drivers/gpu/drm/amd/display/dc/dml/Makefile
index 5b2a65b42403..1bd6e307b7f8 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile
@@ -24,13 +24,11 @@
 # It provides the general basic services required by other DAL
 # subcomponents.
 
-ifneq ($(call cc-option, -mpreferred-stack-boundary=4),)
-	cc_stack_align := -mpreferred-stack-boundary=4
-else ifneq ($(call cc-option, -mstack-alignment=16),)
-	cc_stack_align := -mstack-alignment=16
-endif
+dml_ccflags := -mhard-float -msse
 
-dml_ccflags := -mhard-float -msse $(cc_stack_align)
+ifdef CONFIG_CC_IS_GCC
+dml_ccflags += -mpreferred-stack-boundary=4
+endif
 
 ifdef CONFIG_CC_IS_CLANG
 dml_ccflags += -msse2
diff --git a/drivers/gpu/drm/amd/display/dc/dsc/Makefile b/drivers/gpu/drm/amd/display/dc/dsc/Makefile
index b456cd23c6fa..932c3055230e 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dsc/Makefile
@@ -1,13 +1,11 @@
 #
 # Makefile for the 'dsc' sub-component of DAL.
 
-ifneq ($(call cc-option, -mpreferred-stack-boundary=4),)
-	cc_stack_align := -mpreferred-stack-boundary=4
-else ifneq ($(call cc-option, -mstack-alignment=16),)
-	cc_stack_align := -mstack-alignment=16
-endif
+dsc_ccflags := -mhard-float -msse
 
-dsc_ccflags := -mhard-float -msse $(cc_stack_align)
+ifdef CONFIG_CC_IS_GCC
+dsc_ccflags += -mpreferred-stack-boundary=4
+endif
 
 ifdef CONFIG_CC_IS_CLANG
 dsc_ccflags += -msse2
-- 
2.23.0.700.g56cf767bdb-goog

