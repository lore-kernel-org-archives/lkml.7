Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 116A5ECE599
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 23:02:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D599521848
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 23:02:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A40bHLsh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405446AbfJPXCs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 19:02:48 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:46106 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391366AbfJPXCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 19:02:44 -0400
Received: by mail-pg1-f202.google.com with SMTP id 195so314878pgc.13
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 16:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=5VeOMLWwE6g0WvRsIC8itj+v+Y0yf4dhqyzJ89LKDQw=;
        b=A40bHLshrNkP45PQDK5L664W/1W68XMbbph48wGTPjAkUy/eye889BQYxk9m7kUSjt
         9qxA81XbIZzgEbVf4Vlegiae0E/Jkr6VEEjwyY6Y9GnlGhFWgL6x3LgNodzcKaEaKeWT
         tiK2M0C6MBwGIlzb6c1NgMs6R5DPf4LEBCpBsk1MjimcIKe6nswxwOmjCx9qOmnEb0V9
         NfVbsyRoCAFtoh6OyDGgEdV0KMiuUHV3INyF8rSa1O2nflcSyqLe1DrCZVUl3yNQTraB
         PQfvRpttT6HAVG1XvjGIuIWQQg/CmAup10Xuo4wruCy6VYcKNQv9DKOl3E0XxuY2mgGN
         N2WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=5VeOMLWwE6g0WvRsIC8itj+v+Y0yf4dhqyzJ89LKDQw=;
        b=uToqdhenDivi0UlogiAHFTYOBTp1g2UitXoSZSS+wTT2vL0VKWt22lLUZNevIqhzIt
         LAZFRRbTrWR7V8bbYXzoTZXLt6I91rWTTdekCw9JIRN6Dx0d1XIYhHlIktE8mLHfRoWB
         lPWUUfW8fB4UkxvmO6V/F8Y9vVEPm8ssp7qpDTvVKbwqFaTTT3d1w10uDMYbKqVsuo6/
         M8mKf9/WX8u9XSDrh9Z2LkZ/YskbE6Fvdlhvnzy40JBx02z0gk6QptMhnYAl+ohxTLhL
         ckhkHIoXGQHYrasPk6tcGojkumn/m6a4V+16Vm+iJv7iqSJ1i3DB/awnuL8E2dnMONSC
         re9g==
X-Gm-Message-State: APjAAAXYiEeP4NHnaQSUxuTsvnhASZpuSWj6MX9EfzFivCtfLnbvO68n
        MN+HipXwU0fuwrUCmxcc6VBuoAJ29U3l8/BTaME=
X-Google-Smtp-Source: APXvYqw9zBMWtZ4DRP13HSZzKIGsxaZGBSg0XfK5PbjAaMKRPT/6Lf7FkHKRcXH2ZXuzmgky7x+B9R0tEbAIcUTdq8c=
X-Received: by 2002:a65:5cc8:: with SMTP id b8mr652311pgt.38.1571266963884;
 Wed, 16 Oct 2019 16:02:43 -0700 (PDT)
Date:   Wed, 16 Oct 2019 16:02:09 -0700
In-Reply-To: <20191016230209.39663-1-ndesaulniers@google.com>
Message-Id: <20191016230209.39663-4-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20191016230209.39663-1-ndesaulniers@google.com>
X-Mailer: git-send-email 2.23.0.700.g56cf767bdb-goog
Subject: [PATCH 3/3] drm/amdgpu: enable -msse2 for GCC 7.1+ users
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

A final attempt at enabling sse2 for GCC users.

Orininally attempted in:
commit 10117450735c ("drm/amd/display: add -msse2 to prevent Clang from emitting libcalls to undefined SW FP routines")

Reverted due to "reported instability" in:
commit 193392ed9f69 ("Revert "drm/amd/display: add -msse2 to prevent Clang from emitting libcalls to undefined SW FP routines"")

Re-added just for Clang in:
commit 0f0727d971f6 ("drm/amd/display: readd -msse2 to prevent Clang from emitting libcalls to undefined SW FP routines")

The original report didn't have enough information to know if the GPF
was due to misalignment, but I suspect that it was. (The missing
information was the disassembly of the function at the bottom of the
trace, to see if the instruction pointer pointed to an instruction with
16B alignment memory operand requirements.  The stack trace does show
the stack was only 8B but not 16B aligned though, which makes this a
strong possibility).

Now that the stack misalignment issue has been fixed for users of GCC
7.1+, reattempt adding -msse2. This matches Clang.

It will likely never be safe to enable this for pre-GCC 7.1 AND use a
16B aligned stack in these translation units.

This is only a functional change for GCC 7.1+ users, and should be boot
tested.

Link: https://bugs.freedesktop.org/show_bug.cgi?id=109487
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 drivers/gpu/drm/amd/display/dc/calcs/Makefile | 4 +---
 drivers/gpu/drm/amd/display/dc/dcn20/Makefile | 4 +---
 drivers/gpu/drm/amd/display/dc/dcn21/Makefile | 4 +---
 drivers/gpu/drm/amd/display/dc/dml/Makefile   | 4 +---
 drivers/gpu/drm/amd/display/dc/dsc/Makefile   | 4 +---
 5 files changed, 5 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/calcs/Makefile b/drivers/gpu/drm/amd/display/dc/calcs/Makefile
index a1af55a86508..26c6d735cdc7 100644
--- a/drivers/gpu/drm/amd/display/dc/calcs/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/calcs/Makefile
@@ -37,9 +37,7 @@ ifdef IS_OLD_GCC
 # GCC < 7.1 cannot compile code using `double` and -mpreferred-stack-boundary=3
 # (8B stack alignment).
 calcs_ccflags += -mpreferred-stack-boundary=4
-endif
-
-ifdef CONFIG_CC_IS_CLANG
+else
 calcs_ccflags += -msse2
 endif
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/Makefile b/drivers/gpu/drm/amd/display/dc/dcn20/Makefile
index cb0ac131f74a..63f3bddba7da 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/Makefile
@@ -23,9 +23,7 @@ ifdef IS_OLD_GCC
 # GCC < 7.1 cannot compile code using `double` and -mpreferred-stack-boundary=3
 # (8B stack alignment).
 CFLAGS_$(AMDDALPATH)/dc/dcn20/dcn20_resource.o += -mpreferred-stack-boundary=4
-endif
-
-ifdef CONFIG_CC_IS_CLANG
+else
 CFLAGS_$(AMDDALPATH)/dc/dcn20/dcn20_resource.o += -msse2
 endif
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/Makefile b/drivers/gpu/drm/amd/display/dc/dcn21/Makefile
index f92320ddd27f..ff50ae71fe27 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/Makefile
@@ -16,9 +16,7 @@ ifdef IS_OLD_GCC
 # GCC < 7.1 cannot compile code using `double` and -mpreferred-stack-boundary=3
 # (8B stack alignment).
 CFLAGS_$(AMDDALPATH)/dc/dcn21/dcn21_resource.o += -mpreferred-stack-boundary=4
-endif
-
-ifdef CONFIG_CC_IS_CLANG
+else
 CFLAGS_$(AMDDALPATH)/dc/dcn21/dcn21_resource.o += -msse2
 endif
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml/Makefile b/drivers/gpu/drm/amd/display/dc/dml/Makefile
index ef1bdd20b425..8df251626e22 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile
@@ -37,9 +37,7 @@ ifdef IS_OLD_GCC
 # GCC < 7.1 cannot compile code using `double` and -mpreferred-stack-boundary=3
 # (8B stack alignment).
 dml_ccflags += -mpreferred-stack-boundary=4
-endif
-
-ifdef CONFIG_CC_IS_CLANG
+else
 dml_ccflags += -msse2
 endif
 
diff --git a/drivers/gpu/drm/amd/display/dc/dsc/Makefile b/drivers/gpu/drm/amd/display/dc/dsc/Makefile
index 3f7840828a9f..970737217e53 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dsc/Makefile
@@ -14,9 +14,7 @@ ifdef IS_OLD_GCC
 # GCC < 7.1 cannot compile code using `double` and -mpreferred-stack-boundary=3
 # (8B stack alignment).
 dsc_ccflags += -mpreferred-stack-boundary=4
-endif
-
-ifdef CONFIG_CC_IS_CLANG
+else
 dsc_ccflags += -msse2
 endif
 
-- 
2.23.0.700.g56cf767bdb-goog

