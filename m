Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26BAAC3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 21:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E17B921920
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 21:44:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HlZ1OQE3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393092AbfISVom (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 17:44:42 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34745 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393049AbfISVol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 17:44:41 -0400
Received: by mail-pl1-f195.google.com with SMTP id d3so2224987plr.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 14:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=lwqOPnc+Hjspz39B1KdPwekwTjVU9dAcHcFGUbS/esU=;
        b=HlZ1OQE3iymgQ80SUY3b+Fuk//VK9KTazuInlcYoRmR20coGXrKV9oRmqxpUkyja9S
         uC87fqyMVhaBi37taW9UIp5BTh/OgTP/dfs3vTzL7NbY6rF2IZdUXiRGrjNHNSCwQ2n8
         GTJkvUfDHt2fpxT02DnGs4LARmG4fhNSwsnPY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=lwqOPnc+Hjspz39B1KdPwekwTjVU9dAcHcFGUbS/esU=;
        b=WVtBeK+2lqCDeYC54U+O9Kdmc/WrvhOwAp4QqKJWQYYSkZ+3nQdzYTal8g9zOoItH/
         r4Uqoohy1yhRrywWJ5Xb7JyBu6lexwIPjr4XuJx3mUnKWO2NnwvrZEw2aFrhO8KWLBjC
         P/HdXCv0IsdkOPHhP9BLP8ciV9xXUdEj6Tg5Zg69suMn6y8wwHNjjx8SzHbmbKSA8x5x
         MN4maigFCaXoOYjnf7pJFQ65nvb3FqLb3jQr1Vw+Zl5I6tY0mNGCKgSARbzlLokELwgp
         OulmTWJgTu8Uc+c9INWUnRmtpvitfi6pY4SH1yICG6F/36nQrjX6SkKX9vxe4cXKkiQT
         mZOg==
X-Gm-Message-State: APjAAAXXeeFFaFYwf5mlmSLKKTW6Eq3TWaOk3+Mm5z8U9oazl9izwLEc
        yBOa9sRX3XbFpY/FxjPwqaoeiQ==
X-Google-Smtp-Source: APXvYqx/8ttJRdpg/QX+6cfq1KNAhA8woc3uN5dOVzoy8J/e0FrMLpj502vN+iv2c2lfaubQHgbvqg==
X-Received: by 2002:a17:902:7895:: with SMTP id q21mr11565977pll.94.1568929479404;
        Thu, 19 Sep 2019 14:44:39 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b185sm11082438pfg.14.2019.09.19.14.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2019 14:44:38 -0700 (PDT)
Date:   Thu, 19 Sep 2019 14:44:37 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] docs: Use make invocation's -j argument for parallelism
Message-ID: <201909191438.C00E6DB@keescook>
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

If -j is not specified, continue to fallback to "-jauto" if available.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
v2: retain "-jauto" default behavior with top-level -j is missing.
---
 Documentation/Makefile  |  3 ++-
 scripts/jobserver-count | 53 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+), 1 deletion(-)
 create mode 100755 scripts/jobserver-count

diff --git a/Documentation/Makefile b/Documentation/Makefile
index e145e4db508b..8bfd38a865ff 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -33,7 +33,7 @@ ifeq ($(HAVE_SPHINX),0)
 
 else # HAVE_SPHINX
 
-export SPHINXOPTS = $(shell perl -e 'open IN,"sphinx-build --version 2>&1 |"; while (<IN>) { if (m/([\d\.]+)/) { print "-jauto" if ($$1 >= "1.7") } ;} close IN')
+export SPHINX_PARALLEL = $(shell perl -e 'open IN,"sphinx-build --version 2>&1 |"; while (<IN>) { if (m/([\d\.]+)/) { print "auto" if ($$1 >= "1.7") } ;} close IN')
 
 # User-friendly check for pdflatex and latexmk
 HAVE_PDFLATEX := $(shell if which $(PDFLATEX) >/dev/null 2>&1; then echo 1; else echo 0; fi)
@@ -68,6 +68,7 @@ quiet_cmd_sphinx = SPHINX  $@ --> file://$(abspath $(BUILDDIR)/$3/$4)
 	PYTHONDONTWRITEBYTECODE=1 \
 	BUILDDIR=$(abspath $(BUILDDIR)) SPHINX_CONF=$(abspath $(srctree)/$(src)/$5/$(SPHINX_CONF)) \
 	$(SPHINXBUILD) \
+	-j $(shell python3 $(srctree)/scripts/jobserver-count $(SPHINX_PARALLEL)) \
 	-b $2 \
 	-c $(abspath $(srctree)/$(src)) \
 	-d $(abspath $(BUILDDIR)/.doctrees/$3) \
diff --git a/scripts/jobserver-count b/scripts/jobserver-count
new file mode 100755
index 000000000000..ff6ebe6b0194
--- /dev/null
+++ b/scripts/jobserver-count
@@ -0,0 +1,53 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# This determines how many parallel tasks "make" is expecting, as it is
+# not exposed via an special variables.
+# https://www.gnu.org/software/make/manual/html_node/POSIX-Jobserver.html#POSIX-Jobserver
+import os, sys, fcntl
+
+# Default parallelism is "1" unless overridden on the command-line.
+default="1"
+if len(sys.argv) > 1:
+	default=sys.argv[1]
+
+# Set non-blocking for a given file descriptor.
+def nonblock(fd):
+	flags = fcntl.fcntl(fd, fcntl.F_GETFL)
+	fcntl.fcntl(fd, fcntl.F_SETFL, flags | os.O_NONBLOCK)
+	return fd
+
+# Extract and prepare jobserver file descriptors from envirnoment.
+try:
+	# Fetch the make environment options.
+	flags = os.environ['MAKEFLAGS']
+
+	# Look for "--jobserver=R,W"
+	opts = [x for x in flags.split(" ") if x.startswith("--jobserver")]
+
+	# Parse out R,W file descriptor numbers and set them nonblocking.
+	fds = opts[0].split("=", 1)[1]
+	reader, writer = [nonblock(int(x)) for x in fds.split(",", 1)]
+except:
+	# Any failures here should result in just using the default
+	# specified parallelism.
+	print(default)
+	sys.exit(0)
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
+# If the jobserver was (impossibly) full or communication failed, use default.
+if len(jobs) < 1:
+	print(default)
+
+# Report available slots (with a bump for our caller's reserveration).
+print(len(jobs) + 1)
-- 
2.17.1


-- 
Kees Cook
