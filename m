Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E4A3C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 00:03:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DA9120878
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 00:03:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CRFILFHf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbfKUADY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 19:03:24 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46269 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbfKUADM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 19:03:12 -0500
Received: by mail-pl1-f194.google.com with SMTP id l4so602440plt.13
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 16:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6psxPlZl9k9hVxAcY5nJfgBFA/h6KZ9Pi6P6/8PS9Bs=;
        b=CRFILFHfiKc0hbSgbiktgDPENvDtSf8an3+vKm10BZnsX8g0nra/XcnzdM6nqNBJWu
         39/vTFFigXtiz0ZeqeZF+RNZMC5+AtvcRrXQ9pm6AwjAu10Jbgc6r6P8L0uZr5RU5L6+
         retbqw+fEVqIUjM3FmrMu9Pp1/m6Qjansn9RY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6psxPlZl9k9hVxAcY5nJfgBFA/h6KZ9Pi6P6/8PS9Bs=;
        b=KGUrhyxiM0tLnAixF8Utf+DTAiW3T1a7WFMl054Swkks7RQduTWNZG3IPUEWUC0Sb4
         r8WvNU3vMuIFmLUPZKMaLF9nEo+SYqmHf0oJRpSMpRExP4WqpzehD0q+ys+qqkQBdNxk
         tjnnG9MmYRagihwoXswHafVQ5GvgCYad3fKXWxObQLZBnJy/kcQErq7bkJZIKl2bWkMD
         ZH9FJYFr7AexvIsGs0XI8NCrIyIIwXPWagIL3+Q45OCdDwbcxqURxJgXxdMMp0fUOCf9
         d3FiRBeb2bpIbJbY/9sBqMo3l2R0HhaAj8c1TKxO44sGKP/1R1ZcAkbS9MI0JBcgvTQC
         l3Xw==
X-Gm-Message-State: APjAAAUHbb3DGByzN+rFnqcEFm5+S7Sx7ncJ9MOvSoVa5hB6X6jnxPoO
        nqUJlFWqMJhcGlJu/EpRowlOww==
X-Google-Smtp-Source: APXvYqyzWByrYIkrLzCIeRZ6LRyRadEKAymWhM5zAzN3FhG5cyzWRqRVTnzqfGk2yK2chnaZ94vfMw==
X-Received: by 2002:a17:90a:bf81:: with SMTP id d1mr7373559pjs.125.1574294590377;
        Wed, 20 Nov 2019 16:03:10 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s18sm573022pfm.27.2019.11.20.16.03.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 16:03:09 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Kees Cook <keescook@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] docs, parallelism: Rearrange how jobserver reservations are made
Date:   Wed, 20 Nov 2019 16:03:04 -0800
Message-Id: <20191121000304.48829-4-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191121000304.48829-1-keescook@chromium.org>
References: <20191121000304.48829-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rasmus correctly observed that the existing jobserver reservation only
worked if no other build targets were specified. The correct approach
is to hold the jobserver slots until sphinx has finished. To fix this,
the following changes are made:

- refactor (and rename) scripts/jobserver-exec to set an environment
  variable for the maximally reserved jobserver slots and exec a
  child, to release the slots on exit.

- create Documentation/scripts/parallel-wrapper.sh which examines both
  $PARALLELISM and the detected "-jauto" logic from Documentation/Makefile
  to decide sphinx's final -j argument.

- chain these together in Documentation/Makefile

Suggested-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Link: https://lore.kernel.org/lkml/eb25959a-9ec4-3530-2031-d9d716b40b20@rasmusvillemoes.dk
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 Documentation/Makefile                      |  5 +-
 Documentation/sphinx/parallel-wrapper.sh    | 25 +++++++
 scripts/{jobserver-count => jobserver-exec} | 73 ++++++++++++---------
 3 files changed, 68 insertions(+), 35 deletions(-)
 create mode 100644 Documentation/sphinx/parallel-wrapper.sh
 rename scripts/{jobserver-count => jobserver-exec} (50%)
 mode change 100755 => 100644

diff --git a/Documentation/Makefile b/Documentation/Makefile
index ce8eb63b523a..30554a2fbdd7 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -33,8 +33,6 @@ ifeq ($(HAVE_SPHINX),0)
 
 else # HAVE_SPHINX
 
-export SPHINX_PARALLEL = $(shell perl -e 'open IN,"sphinx-build --version 2>&1 |"; while (<IN>) { if (m/([\d\.]+)/) { print "auto" if ($$1 >= "1.7") } ;} close IN')
-
 # User-friendly check for pdflatex and latexmk
 HAVE_PDFLATEX := $(shell if which $(PDFLATEX) >/dev/null 2>&1; then echo 1; else echo 0; fi)
 HAVE_LATEXMK := $(shell if which latexmk >/dev/null 2>&1; then echo 1; else echo 0; fi)
@@ -67,8 +65,9 @@ quiet_cmd_sphinx = SPHINX  $@ --> file://$(abspath $(BUILDDIR)/$3/$4)
       cmd_sphinx = $(MAKE) BUILDDIR=$(abspath $(BUILDDIR)) $(build)=Documentation/media $2 && \
 	PYTHONDONTWRITEBYTECODE=1 \
 	BUILDDIR=$(abspath $(BUILDDIR)) SPHINX_CONF=$(abspath $(srctree)/$(src)/$5/$(SPHINX_CONF)) \
+	$(PYTHON) $(srctree)/scripts/jobserver-exec \
+	$(SHELL) $(srctree)/Documentation/sphinx/parallel-wrapper.sh \
 	$(SPHINXBUILD) \
-	-j $(shell python $(srctree)/scripts/jobserver-count $(SPHINX_PARALLEL)) \
 	-b $2 \
 	-c $(abspath $(srctree)/$(src)) \
 	-d $(abspath $(BUILDDIR)/.doctrees/$3) \
diff --git a/Documentation/sphinx/parallel-wrapper.sh b/Documentation/sphinx/parallel-wrapper.sh
new file mode 100644
index 000000000000..a416dbfd2025
--- /dev/null
+++ b/Documentation/sphinx/parallel-wrapper.sh
@@ -0,0 +1,25 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Figure out if we should follow a specific parallelism from the make
+# environment (as exported by scripts/jobserver-exec), or fall back to
+# the "auto" parallelism when "-jN" is not specified at the top-level
+# "make" invocation.
+
+sphinx="$1"
+shift || true
+
+parallel="${PARALLELISM:-1}"
+if [ ${parallel} -eq 1 ] ; then
+	auto=$(perl -e 'open IN,"'"$sphinx"' --version 2>&1 |";
+			while (<IN>) {
+				if (m/([\d\.]+)/) {
+					print "auto" if ($1 >= "1.7")
+				}
+			}
+			close IN')
+	if [ -n "$auto" ] ; then
+		parallel="$auto"
+	fi
+fi
+exec "$sphinx" "-j$parallel" "$@"
diff --git a/scripts/jobserver-count b/scripts/jobserver-exec
old mode 100755
new mode 100644
similarity index 50%
rename from scripts/jobserver-count
rename to scripts/jobserver-exec
index a68a04ad304f..4593b2a1e36d
--- a/scripts/jobserver-count
+++ b/scripts/jobserver-exec
@@ -2,17 +2,16 @@
 # SPDX-License-Identifier: GPL-2.0+
 #
 # This determines how many parallel tasks "make" is expecting, as it is
-# not exposed via an special variables.
+# not exposed via an special variables, reserves them all, runs a subprocess
+# with PARALLELISM environment variable set, and releases the jobs back again.
+#
 # https://www.gnu.org/software/make/manual/html_node/POSIX-Jobserver.html#POSIX-Jobserver
 from __future__ import print_function
 import os, sys, fcntl, errno
-
-# Default parallelism is "1" unless overridden on the command-line.
-default="1"
-if len(sys.argv) > 1:
-	default=sys.argv[1]
+import subprocess
 
 # Extract and prepare jobserver file descriptors from envirnoment.
+jobs = b""
 try:
 	# Fetch the make environment options.
 	flags = os.environ['MAKEFLAGS']
@@ -30,31 +29,41 @@ try:
 	reader = os.open("/proc/self/fd/%d" % (reader), os.O_RDONLY)
 	flags = fcntl.fcntl(reader, fcntl.F_GETFL)
 	fcntl.fcntl(reader, fcntl.F_SETFL, flags | os.O_NONBLOCK)
-except (KeyError, IndexError, ValueError, IOError, OSError) as e:
-	print(e, file=sys.stderr)
+
+	# Read out as many jobserver slots as possible.
+	while True:
+		try:
+			slot = os.read(reader, 1)
+			jobs += slot
+		except (OSError, IOError) as e:
+			if e.errno == errno.EWOULDBLOCK:
+				# Stop at the end of the jobserver queue.
+				break
+			# If something went wrong, give back the jobs.
+			if len(jobs):
+				os.write(writer, jobs)
+			raise e
+except (KeyError, IndexError, ValueError, OSError, IOError) as e:
 	# Any missing environment strings or bad fds should result in just
-	# using the default specified parallelism.
-	print(default)
-	sys.exit(0)
+	# not being parallel.
+	pass
 
-# Read out as many jobserver slots as possible.
-jobs = b""
-while True:
-	try:
-		slot = os.read(reader, 1)
-		jobs += slot
-	except (OSError, IOError) as e:
-		if e.errno == errno.EWOULDBLOCK:
-			# Stop when reach the end of the jobserver queue.
-			break
-		raise e
-# Return all the reserved slots.
-os.write(writer, jobs)
-
-# If the jobserver was (impossibly) full or communication failed, use default.
-if len(jobs) < 1:
-	print(default)
-	sys.exit(0)
-
-# Report available slots (with a bump for our caller's reserveration).
-print(len(jobs) + 1)
+claim = len(jobs)
+if claim < 1:
+	# If the jobserver was (impossibly) full or communication failed
+	# in some way do not use parallelism.
+	claim = 0
+
+# Launch command with a bump for our caller's reserveration,
+# since we're just going to sit here blocked on our child.
+claim += 1
+
+os.unsetenv('MAKEFLAGS')
+os.environ['PARALLELISM'] = '%d' % (claim)
+rc = subprocess.call(sys.argv[1:])
+
+# Return all the actually reserved slots.
+if len(jobs):
+	os.write(writer, jobs)
+
+sys.exit(rc)
-- 
2.17.1

