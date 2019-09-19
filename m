Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E47BC3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 18:19:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6253621928
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 18:19:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nQqsDv4h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732715AbfISSSz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 14:18:55 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46435 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732659AbfISSSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 14:18:55 -0400
Received: by mail-pf1-f193.google.com with SMTP id q5so2805483pfg.13
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 11:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=LK/ntI5e8UZBioVWF4cAdPWBEu0iGHGSIa7+VcXi35o=;
        b=nQqsDv4htqMeTr29+sArilMSGc4WdWh8clDbsS+ZhaBH8MnOghUWrj7q7bo55eU4zE
         I+mXGqd+A3IXVvRg1mRHX8jhbtB4Q9/WWo2tQqfq3B/6/bmTsiA86mB9fIXjIarfyfUz
         T9M59UB/RUpZXAvS9UMEvet3Chkn1EjLPhN9c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=LK/ntI5e8UZBioVWF4cAdPWBEu0iGHGSIa7+VcXi35o=;
        b=UjWRfyHws5vFX1P28x1qAnud6DK53ZtawJwbsFGJM+YStkC4i67L6XtNRq7dYHHc32
         +BtXuDIdAdm4V7SHo+lzrA5EvKTJf/CEmh8O9V8JqgPw7NXlxENlWHRK+u23nwcfR1vs
         EX7HWgYAywdSr2viBiTx50Nob4qzWmmX8euxU5ReN16S5sQf6Utl7dWTmFV3gntN+8vj
         7GELDtwTQotBS8yd7voQrBS7N0+8G0Wf6Osv2guP+0tx4BXr5ks0LHugNyLKuE8Fu3NW
         xvXzwxE4RIxyH7nZVs8azS4k8cXoQ7NDik5UrwKjyZyhHYLa8e4uOD4eVKUW69dJ/gut
         k7wA==
X-Gm-Message-State: APjAAAUbSdsmWJIHyqGMmpJugBxVfYGj6JJui3pxCxCB2hrQSorpbf6k
        F0yRbQHVOXPHbbCSxF8nxzgJnA==
X-Google-Smtp-Source: APXvYqy2AC9epTUjkt4q5SHYgCwow/H1wFtZDkXZGQpB8RDBJY/GgHldQNGy/Er8PHpj0kcHasCe9g==
X-Received: by 2002:aa7:998d:: with SMTP id k13mr11961195pfh.134.1568917134616;
        Thu, 19 Sep 2019 11:18:54 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 37sm13724113pgv.32.2019.09.19.11.18.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2019 11:18:53 -0700 (PDT)
Date:   Thu, 19 Sep 2019 11:18:52 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] docs: Use make invocation's -j argument for parallelism
Message-ID: <201909191116.192A096C68@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While sphinx 1.7 and later supports "-jauto" for parallelism, this
effectively ignores the "-j" flag used in the "make" invocation, which
may cause confusion for build systems. Instead, extract the available
parallelism from "make"'s job server (since it is not exposed in any
special variables) and use that for the "sphinx-build" run. Now things
work correctly for builds where -j is specified at the top-level:

	make -j16 htmldocs

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 Documentation/Makefile  |  3 +--
 scripts/jobserver-count | 46 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+), 2 deletions(-)
 create mode 100755 scripts/jobserver-count

diff --git a/Documentation/Makefile b/Documentation/Makefile
index e145e4db508b..4408eeaf2891 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -33,8 +33,6 @@ ifeq ($(HAVE_SPHINX),0)
 
 else # HAVE_SPHINX
 
-export SPHINXOPTS = $(shell perl -e 'open IN,"sphinx-build --version 2>&1 |"; while (<IN>) { if (m/([\d\.]+)/) { print "-jauto" if ($$1 >= "1.7") } ;} close IN')
-
 # User-friendly check for pdflatex and latexmk
 HAVE_PDFLATEX := $(shell if which $(PDFLATEX) >/dev/null 2>&1; then echo 1; else echo 0; fi)
 HAVE_LATEXMK := $(shell if which latexmk >/dev/null 2>&1; then echo 1; else echo 0; fi)
@@ -68,6 +66,7 @@ quiet_cmd_sphinx = SPHINX  $@ --> file://$(abspath $(BUILDDIR)/$3/$4)
 	PYTHONDONTWRITEBYTECODE=1 \
 	BUILDDIR=$(abspath $(BUILDDIR)) SPHINX_CONF=$(abspath $(srctree)/$(src)/$5/$(SPHINX_CONF)) \
 	$(SPHINXBUILD) \
+	-j $(shell $(srctree)/scripts/jobserver-count) \
 	-b $2 \
 	-c $(abspath $(srctree)/$(src)) \
 	-d $(abspath $(BUILDDIR)/.doctrees/$3) \
diff --git a/scripts/jobserver-count b/scripts/jobserver-count
new file mode 100755
index 000000000000..5fc9d2fd5254
--- /dev/null
+++ b/scripts/jobserver-count
@@ -0,0 +1,46 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# This determines how many parallel tasks "make" is expecting, as it is
+# not exposed via an special variables.
+# https://www.gnu.org/software/make/manual/html_node/POSIX-Jobserver.html#POSIX-Jobserver
+import os, sys, fcntl
+
+# Set non-blocking for a given file descriptor.
+def nonblock(fd):
+	flags = fcntl.fcntl(fd, fcntl.F_GETFL)
+	fcntl.fcntl(fd, fcntl.F_SETFL, flags | os.O_NONBLOCK)
+	return fd
+
+# Fetch the make environment options.
+flags = os.environ.get('MAKEFLAGS', None)
+if flags == None:
+	print("1")
+	sys.exit(0)
+
+# Look for "--jobserver=R,W"
+opts = [x for x in flags.split(" ") if x.startswith("--jobserver")]
+if len(opts) != 1:
+	print("1")
+	sys.exit(0)
+
+# Parse out R,W file descriptor numbers and set them nonblocking.
+fds = opts[0].split("=", 1)[1]
+reader, writer = [nonblock(int(x)) for x in fds.split(",", 1)]
+
+# Read out as many jobserver slots as possible.
+jobs = b""
+while True:
+	try:
+		slot = os.read(reader, 1)
+		jobs += slot
+	except:
+		break
+# Return all the reserved slots.
+os.write(writer, jobs)
+
+# Report available slots (with a bump for our caller's reserveration).
+if len(jobs) < 1:
+	print("1")
+else:
+	print(len(jobs) + 1)
-- 
2.17.1


-- 
Kees Cook
