Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48C88C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 23:30:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10CB9214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 23:30:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ndKjN9PX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442095AbfIXXaD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 19:30:03 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37992 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2442084AbfIXXaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 19:30:01 -0400
Received: by mail-pg1-f196.google.com with SMTP id x10so2116740pgi.5
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2019 16:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=hDUCRnovERuna7WKgcUyWC1089K6x+TQ4NYVGW2tMJg=;
        b=ndKjN9PXPKpgZypiGtw5+V39czKqyhWbpuDdL9ymcglLiyFbxaHBpQmR5AlCm14CYN
         Cy3k0fDcyuKcGFIewZrYKYse76pfxRahWzJQPFIxPdk8COBULfRhP0NE3EV/obeROM5C
         lkMP+4piwFtk7ymP5XfrJwLqfsg+E2/lc//qc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=hDUCRnovERuna7WKgcUyWC1089K6x+TQ4NYVGW2tMJg=;
        b=iSxNWgoMv+p5ICp9YWcOiLdzr8rir6mczKbBF/18Q2uxhEEYKhIUoxJDLb8pB1rrFq
         Kxcwt8qlY/zwbY0xIPMdurLzR5mx1YAEEmepCUyUfhvez30JP8zXI6LO3Z0+s6r8BBF9
         fvRXB/MXhI36A+uPJ8CNgyeAt0fyIUBJ5J1sBhu1fpgFGsOkvIOuytw0UnM8VoJtOsGk
         rZGcOfIPAoDc4jsav+9XclRTW+CREo6GHWlAKlcV/sMsItGV94AgmC/d1P6P7Z/P89Qp
         lP1fNMYxa8k6scb4dH27Qvwcfg1n0Hrnt1Y/bzulVj08HwxCYzqUaK27dnYeAJrDOFGf
         Gi0A==
X-Gm-Message-State: APjAAAWQiqirBzWDOrOX7qTamjr8MAyt0fzJ5HonfqPwOk93zi7raD30
        x1Gh/jHhYC+cgxkpkLbc1ck3n9SaTMs=
X-Google-Smtp-Source: APXvYqyZQ1DH75N1hfUmgYvspKfUCy8wk/94lyd0xXxzSq//YzXGyQDttZlx6jOwBTik27aAnB9hXA==
X-Received: by 2002:a63:4824:: with SMTP id v36mr5730519pga.385.1569367800943;
        Tue, 24 Sep 2019 16:30:00 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f74sm5759500pfa.34.2019.09.24.16.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2019 16:29:59 -0700 (PDT)
Date:   Tue, 24 Sep 2019 16:29:58 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] docs: Use make invocation's -j argument for parallelism
Message-ID: <201909241627.CEA19509@keescook>
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
v3: python2, specific exceptions, correct SPDX, blocking writer
v2: retain "-jauto" default behavior with top-level -j is missing.              
---
 Documentation/Makefile  |  3 ++-
 scripts/jobserver-count | 58 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+), 1 deletion(-)
 create mode 100755 scripts/jobserver-count

diff --git a/Documentation/Makefile b/Documentation/Makefile
index e145e4db508b..c6e564656a5b 100644
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
+	-j $(shell python $(srctree)/scripts/jobserver-count $(SPHINX_PARALLEL)) \
 	-b $2 \
 	-c $(abspath $(srctree)/$(src)) \
 	-d $(abspath $(BUILDDIR)/.doctrees/$3) \
diff --git a/scripts/jobserver-count b/scripts/jobserver-count
new file mode 100755
index 000000000000..0b482d6884d2
--- /dev/null
+++ b/scripts/jobserver-count
@@ -0,0 +1,58 @@
+#!/usr/bin/env python
+# SPDX-License-Identifier: GPL-2.0+
+#
+# This determines how many parallel tasks "make" is expecting, as it is
+# not exposed via an special variables.
+# https://www.gnu.org/software/make/manual/html_node/POSIX-Jobserver.html#POSIX-Jobserver
+from __future__ import print_function
+import os, sys, fcntl, errno
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
+	reader, writer = [int(x) for x in fds.split(",", 1)]
+	reader = nonblock(reader)
+except (KeyError, IndexError, ValueError, IOError):
+	# Any missing environment strings or bad fds should result in just
+	# using the default specified parallelism.
+	print(default)
+	sys.exit(0)
+
+# Read out as many jobserver slots as possible.
+jobs = b""
+while True:
+	try:
+		slot = os.read(reader, 1)
+		jobs += slot
+	except (OSError, IOError) as e:
+		if e.errno == errno.EWOULDBLOCK:
+			# Stop when reach the end of the jobserver queue.
+			break
+		raise e
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
