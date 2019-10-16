Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C18EFA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 23:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FA4F207FF
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 23:02:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RLuFVPUM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395451AbfJPXCn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 19:02:43 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:44912 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391366AbfJPXCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 19:02:41 -0400
Received: by mail-pg1-f202.google.com with SMTP id z7so318991pgk.11
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 16:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+HTLwtBsb8GklYcE8zHDNoq/yMsTyW1DbJyJzcZRL08=;
        b=RLuFVPUMzPc1pMJytJNDhf0T00cd/XENdfqEGL/9yFMKxi0/KOv6x9ACs/02+0mo3S
         g8OZsQ2AJe6jSNHPgY1WFxvceih3ZJQeEaj7QPMFLGYUgax0sT32Ho1CTb1RSPrx2Oet
         PBov+kC+ZibuaEdC7BHcJxEVhMwsS14atR2hYzeLnSaUyFEqPY5lk+gZ1Tq9aab/mGg7
         BWEk6HcAV5pR5WtFEO/WSEf+MgOI6ijaDroFmLWaJJxhU6Mud7WD89CMEQgFfkxNjq7E
         eTNFbIVEB1LzdbvAU+lSrksBuetCyMi4xo63aE0SlWnN4pFJkt5zTje5fLmOfyvJQv9E
         PeWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+HTLwtBsb8GklYcE8zHDNoq/yMsTyW1DbJyJzcZRL08=;
        b=L75bt2zFc70W0vyWvhPSDw0JkaIEDVmOVyoxWECNH0aJ7nzywolqSeCRYqBXfQanFg
         FKEHvK0eNZe9c1/9SMw8hp8lh5p9E8xgG5hfewVMY/IbpmvZy20cbbZuE+eQuqc5DGRc
         89/QL41Sfh5rYxCXRgtwzT4V3j3nkOv3l4k6bYWBfY9B3Z0e0YuHvpr2rqnLsg0eo0AA
         r1AaExpnr3XkgRKlXIhrnT7T9RlOPHBpD1wPo9AJmKJSA7Lv8ElFUBwbHhS13Wnvkejk
         WzFni9eaSK9s/IVJJLBA73TSr48LezPMqcf0vTsXNW4RCXUbf/GghAW8c9FyKv1/K5OZ
         g8ug==
X-Gm-Message-State: APjAAAUS9TnnAcqLD5m+xHm02N8+6Squ4ZHAdLWduyTHHFpU5T/XgY/a
        nQ8ySZNGtaCWQMHgycxH68AY0QKyUWJ6x4rdLIE=
X-Google-Smtp-Source: APXvYqwkg8HN8XV4CLIJMwhRw0vzbiXRyaa5lU6XL2se1i+1u0odSGvmeJt68GbH/0Goi6/A0NAGsyQZoSFq7fpXaAo=
X-Received: by 2002:a63:c446:: with SMTP id m6mr648240pgg.136.1571266960259;
 Wed, 16 Oct 2019 16:02:40 -0700 (PDT)
Date:   Wed, 16 Oct 2019 16:02:08 -0700
In-Reply-To: <20191016230209.39663-1-ndesaulniers@google.com>
Message-Id: <20191016230209.39663-3-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20191016230209.39663-1-ndesaulniers@google.com>
X-Mailer: git-send-email 2.23.0.700.g56cf767bdb-goog
Subject: [PATCH 2/3] drm/amdgpu: fix stack alignment ABI mismatch for GCC 7.1+
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

GCC earlier than 7.1 errors when compiling code that makes use of
`double`s and sets a stack alignment outside of the range of [2^4-2^12]:

$ cat foo.c
double foo(double x, double y) {
  return x + y;
}
$ gcc-4.9 -mpreferred-stack-boundary=3 foo.c
error: -mpreferred-stack-boundary=3 is not between 4 and 12

This is likely why the AMDGPU driver was ever compiled with a different
stack alignment (and thus different ABI) than the rest of the x86
kernel. The kernel uses 8B stack alignment, while the driver was using
16B stack alignment in a few places.

Since GCC 7.1+ doesn't error, fix the ABI mismatch for users of newer
versions of GCC.

There was discussion about whether to mark the driver broken or not for
users of GCC earlier than 7.1, but since the driver currently is
working, don't explicitly break the driver for them here.

Relying on differing stack alignment is unspecified behavior, and
brittle, and may break in the future.

This patch is no functional change for GCC users earlier than 7.1. It's
been compile tested on GCC 4.9 and 8.3 to check the correct flags. It
should be boot tested when built with GCC 7.1+.

-mincoming-stack-boundary= or -mstackrealign may help keep this code
building for pre-GCC 7.1 users.

The version check for GCC is broken into two conditionals, both because
cc-ifversion is currently GCC specific, and it simplifies a subsequent
patch.

Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 drivers/gpu/drm/amd/display/dc/calcs/Makefile | 9 +++++++++
 drivers/gpu/drm/amd/display/dc/dcn20/Makefile | 9 +++++++++
 drivers/gpu/drm/amd/display/dc/dcn21/Makefile | 9 +++++++++
 drivers/gpu/drm/amd/display/dc/dml/Makefile   | 9 +++++++++
 drivers/gpu/drm/amd/display/dc/dsc/Makefile   | 9 +++++++++
 5 files changed, 45 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/calcs/Makefile b/drivers/gpu/drm/amd/display/dc/calcs/Makefile
index 4b1a8a08a5de..a1af55a86508 100644
--- a/drivers/gpu/drm/amd/display/dc/calcs/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/calcs/Makefile
@@ -27,6 +27,15 @@
 calcs_ccflags := -mhard-float -msse
 
 ifdef CONFIG_CC_IS_GCC
+ifeq ($(call cc-ifversion, -lt, 0701, y), y)
+IS_OLD_GCC = 1
+endif
+endif
+
+ifdef IS_OLD_GCC
+# Stack alignment mismatch, proceed with caution.
+# GCC < 7.1 cannot compile code using `double` and -mpreferred-stack-boundary=3
+# (8B stack alignment).
 calcs_ccflags += -mpreferred-stack-boundary=4
 endif
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/Makefile b/drivers/gpu/drm/amd/display/dc/dcn20/Makefile
index 5fe3eb80075d..cb0ac131f74a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/Makefile
@@ -13,6 +13,15 @@ endif
 CFLAGS_$(AMDDALPATH)/dc/dcn20/dcn20_resource.o := -mhard-float -msse
 
 ifdef CONFIG_CC_IS_GCC
+ifeq ($(call cc-ifversion, -lt, 0701, y), y)
+IS_OLD_GCC = 1
+endif
+endif
+
+ifdef IS_OLD_GCC
+# Stack alignment mismatch, proceed with caution.
+# GCC < 7.1 cannot compile code using `double` and -mpreferred-stack-boundary=3
+# (8B stack alignment).
 CFLAGS_$(AMDDALPATH)/dc/dcn20/dcn20_resource.o += -mpreferred-stack-boundary=4
 endif
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/Makefile b/drivers/gpu/drm/amd/display/dc/dcn21/Makefile
index 7057e20748b9..f92320ddd27f 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/Makefile
@@ -6,6 +6,15 @@ DCN21 = dcn21_hubp.o dcn21_hubbub.o dcn21_resource.o
 CFLAGS_$(AMDDALPATH)/dc/dcn21/dcn21_resource.o := -mhard-float -msse
 
 ifdef CONFIG_CC_IS_GCC
+ifeq ($(call cc-ifversion, -lt, 0701, y), y)
+IS_OLD_GCC = 1
+endif
+endif
+
+ifdef IS_OLD_GCC
+# Stack alignment mismatch, proceed with caution.
+# GCC < 7.1 cannot compile code using `double` and -mpreferred-stack-boundary=3
+# (8B stack alignment).
 CFLAGS_$(AMDDALPATH)/dc/dcn21/dcn21_resource.o += -mpreferred-stack-boundary=4
 endif
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml/Makefile b/drivers/gpu/drm/amd/display/dc/dml/Makefile
index 1bd6e307b7f8..ef1bdd20b425 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile
@@ -27,6 +27,15 @@
 dml_ccflags := -mhard-float -msse
 
 ifdef CONFIG_CC_IS_GCC
+ifeq ($(call cc-ifversion, -lt, 0701, y), y)
+IS_OLD_GCC = 1
+endif
+endif
+
+ifdef IS_OLD_GCC
+# Stack alignment mismatch, proceed with caution.
+# GCC < 7.1 cannot compile code using `double` and -mpreferred-stack-boundary=3
+# (8B stack alignment).
 dml_ccflags += -mpreferred-stack-boundary=4
 endif
 
diff --git a/drivers/gpu/drm/amd/display/dc/dsc/Makefile b/drivers/gpu/drm/amd/display/dc/dsc/Makefile
index 932c3055230e..3f7840828a9f 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dsc/Makefile
@@ -4,6 +4,15 @@
 dsc_ccflags := -mhard-float -msse
 
 ifdef CONFIG_CC_IS_GCC
+ifeq ($(call cc-ifversion, -lt, 0701, y), y)
+IS_OLD_GCC = 1
+endif
+endif
+
+ifdef IS_OLD_GCC
+# Stack alignment mismatch, proceed with caution.
+# GCC < 7.1 cannot compile code using `double` and -mpreferred-stack-boundary=3
+# (8B stack alignment).
 dsc_ccflags += -mpreferred-stack-boundary=4
 endif
 
-- 
2.23.0.700.g56cf767bdb-goog

