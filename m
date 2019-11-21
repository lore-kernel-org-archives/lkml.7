Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21723C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 20:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB9CD20672
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 20:59:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="STbB6eOt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbfKUU7o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 15:59:44 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:36785 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727031AbfKUU7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 15:59:35 -0500
Received: by mail-pj1-f65.google.com with SMTP id cq11so2057391pjb.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 12:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DRoA2EhvMXtyon9YkUmd/X1Q313xd8cuv+FnMNFKmCA=;
        b=STbB6eOts0UWAyZ8/n3Rz6xnBEK1XumpRqT/PxHZvy9l59qrxtiAlUgnO+ke1nWRqR
         sxEVtWJkaSLh6wQAdVkbGTtLKkTYHFP70MJUJnmI0vLbNk1WzhitU5RuU0ar/EICva0X
         EanjqoQvHeJMo9GlkY0AbGBZDQYFSpVGBrDh8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DRoA2EhvMXtyon9YkUmd/X1Q313xd8cuv+FnMNFKmCA=;
        b=P5oeqdBUpCovD3+jxXg1gzs7SydzwPaw/oU20e9QdeL8Aqiq0q6tD9a9hPu9SDNolk
         fDb6Q26VTBMiSnArhOSxGQSh03owQM33PNJDojNGsdCDY/TzO3YVuLVW6tBfqK4Hqstw
         UjHvuRLVAwIHKCEz/mm70ujFlBBz1Vpe0CFWbzRqKzaO2LZdNT9d83UpqCqRvm7b4Pkn
         5weAKAwByiXSb4XtC8iq4cwer0t1czhY31cDecPxcTV8GnDUcRVq4bNZeptFCj99oN/e
         XczDgPU8+F+Elw/x/3vXEmf8GnLiByFCn6/QitK1yJ8R0FFSgaoAzK1Dcl3yYEsWnZCW
         obsw==
X-Gm-Message-State: APjAAAVkedepXiiX2oVvhclQdrPpsuB+l1vWwu/VinK05KxsSqbGVyFk
        nSilMt6OEEpysrGetkmSsPJd/g==
X-Google-Smtp-Source: APXvYqzM03HmVHpcqOdxSnbQwFcYraVV46uuaF/gkBLRLufpnKoP0WZot+Xwq+9XDMd3Fj6PpCCInQ==
X-Received: by 2002:a17:90b:3015:: with SMTP id hg21mr14018116pjb.96.1574369974968;
        Thu, 21 Nov 2019 12:59:34 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c1sm426801pjc.23.2019.11.21.12.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 12:59:34 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Kees Cook <keescook@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] docs, parallelism: Rearrange how jobserver reservations are made
Date:   Thu, 21 Nov 2019 12:59:29 -0800
Message-Id: <20191121205929.40371-4-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191121205929.40371-1-keescook@chromium.org>
References: <20191121205929.40371-1-keescook@chromium.org>
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
 Documentation/Makefile                   |  5 +-
 Documentation/sphinx/parallel-wrapper.sh | 33 ++++++++++++
 scripts/jobserver-count                  | 59 ---------------------
 scripts/jobserver-exec                   | 66 ++++++++++++++++++++++++
 4 files changed, 101 insertions(+), 62 deletions(-)
 create mode 100644 Documentation/sphinx/parallel-wrapper.sh
 delete mode 100755 scripts/jobserver-count
 create mode 100755 scripts/jobserver-exec

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
index 000000000000..7daf5133bdd3
--- /dev/null
+++ b/Documentation/sphinx/parallel-wrapper.sh
@@ -0,0 +1,33 @@
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
+parallel="$PARALLELISM"
+if [ -z "$parallel" ] ; then
+	# If no parallelism is specified at the top-level make, then
+	# fall back to the expected "-jauto" mode that the "htmldocs"
+	# target has had.
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
+# Only if some parallelism has been determined do we add the -jN option.
+if [ -n "$parallel" ] ; then
+	parallel="-j$parallel"
+fi
+
+exec "$sphinx" "$parallel" "$@"
diff --git a/scripts/jobserver-count b/scripts/jobserver-count
deleted file mode 100755
index 7807bfa7dafa..000000000000
--- a/scripts/jobserver-count
+++ /dev/null
@@ -1,59 +0,0 @@
-#!/usr/bin/env python
-# SPDX-License-Identifier: GPL-2.0+
-#
-# This determines how many parallel tasks "make" is expecting, as it is
-# not exposed via an special variables.
-# https://www.gnu.org/software/make/manual/html_node/POSIX-Jobserver.html#POSIX-Jobserver
-from __future__ import print_function
-import os, sys, fcntl, errno
-
-# Default parallelism is "1" unless overridden on the command-line.
-default="1"
-if len(sys.argv) > 1:
-	default=sys.argv[1]
-
-# Extract and prepare jobserver file descriptors from envirnoment.
-try:
-	# Fetch the make environment options.
-	flags = os.environ['MAKEFLAGS']
-
-	# Look for "--jobserver=R,W"
-	# Note that GNU Make has used --jobserver-fds and --jobserver-auth
-	# so this handles all of them.
-	opts = [x for x in flags.split(" ") if x.startswith("--jobserver")]
-
-	# Parse out R,W file descriptor numbers and set them nonblocking.
-	fds = opts[0].split("=", 1)[1]
-	reader, writer = [int(x) for x in fds.split(",", 1)]
-	# Open a private copy of reader to avoid setting nonblocking
-	# on an unexpecting process with the same reader fd.
-	reader = os.open("/proc/self/fd/%d" % (reader),
-			 os.O_RDONLY | os.O_NONBLOCK)
-except (KeyError, IndexError, ValueError, IOError, OSError) as e:
-	print(e, file=sys.stderr)
-	# Any missing environment strings or bad fds should result in just
-	# using the default specified parallelism.
-	print(default)
-	sys.exit(0)
-
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
diff --git a/scripts/jobserver-exec b/scripts/jobserver-exec
new file mode 100755
index 000000000000..0fdb31a790a8
--- /dev/null
+++ b/scripts/jobserver-exec
@@ -0,0 +1,66 @@
+#!/usr/bin/env python
+# SPDX-License-Identifier: GPL-2.0+
+#
+# This determines how many parallel tasks "make" is expecting, as it is
+# not exposed via an special variables, reserves them all, runs a subprocess
+# with PARALLELISM environment variable set, and releases the jobs back again.
+#
+# https://www.gnu.org/software/make/manual/html_node/POSIX-Jobserver.html#POSIX-Jobserver
+from __future__ import print_function
+import os, sys, errno
+import subprocess
+
+# Extract and prepare jobserver file descriptors from envirnoment.
+claim = 0
+jobs = b""
+try:
+	# Fetch the make environment options.
+	flags = os.environ['MAKEFLAGS']
+
+	# Look for "--jobserver=R,W"
+	# Note that GNU Make has used --jobserver-fds and --jobserver-auth
+	# so this handles all of them.
+	opts = [x for x in flags.split(" ") if x.startswith("--jobserver")]
+
+	# Parse out R,W file descriptor numbers and set them nonblocking.
+	fds = opts[0].split("=", 1)[1]
+	reader, writer = [int(x) for x in fds.split(",", 1)]
+	# Open a private copy of reader to avoid setting nonblocking
+	# on an unexpecting process with the same reader fd.
+	reader = os.open("/proc/self/fd/%d" % (reader),
+			 os.O_RDONLY | os.O_NONBLOCK)
+
+	# Read out as many jobserver slots as possible.
+	while True:
+		try:
+			slot = os.read(reader, 8)
+			jobs += slot
+		except (OSError, IOError) as e:
+			if e.errno == errno.EWOULDBLOCK:
+				# Stop at the end of the jobserver queue.
+				break
+			# If something went wrong, give back the jobs.
+			if len(jobs):
+				os.write(writer, jobs)
+			raise e
+	# Add a bump for our caller's reserveration, since we're just going
+	# to sit here blocked on our child.
+	claim = len(jobs) + 1
+except (KeyError, IndexError, ValueError, OSError, IOError) as e:
+	# Any missing environment strings or bad fds should result in just
+	# not being parallel.
+	pass
+
+# We can only claim parallelism if there was a jobserver (i.e. a top-level
+# "-jN" argument) and there were no other failures. Otherwise leave out the
+# environment variable and let the child figure out what is best.
+if claim > 0:
+	os.environ['PARALLELISM'] = '%d' % (claim)
+
+rc = subprocess.call(sys.argv[1:])
+
+# Return all the reserved slots.
+if len(jobs):
+	os.write(writer, jobs)
+
+sys.exit(rc)
-- 
2.17.1

