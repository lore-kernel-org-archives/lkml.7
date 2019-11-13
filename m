Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C909C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 01:28:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42740222CE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 01:28:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hlsLs9h9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbfKMB2e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 20:28:34 -0500
Received: from mail-pg1-f201.google.com ([209.85.215.201]:34983 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726936AbfKMB2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 20:28:34 -0500
Received: by mail-pg1-f201.google.com with SMTP id t11so623348pgm.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 17:28:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=jKMqCQFEoSSTJ2SShJNtFv+iwOoSX52Fh5gJat66tHM=;
        b=hlsLs9h9D517WqWNmk3xWR52I1v68oK+sW9Wnfji3t5BOWHYMVK1woSQDT/LRD+Ecl
         bUwDdcScSuMkkgWV0nngRuhSBn0nRfX4Ky8i6HsrWMWc7coSO+MxtGdbZBAzGjjrm48j
         G9MlsV8nUNHSjvQL27HtJNSRm49r8bStInCo4cibWgvj/irzj5Ojh/zhr0doDNysZYiR
         1J+//S0frymecb+lIFxoimztvAzM0apP/Z8uQn6+QRDj58TCWJj5c0IN8cYFkJ3Hv64d
         fzRCE3z/Cla32108uLOMomqIBmeSkr/yf0t21/rjfNVO8CWo/Qq/Iya0zpivE3FmLX7Z
         7IYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=jKMqCQFEoSSTJ2SShJNtFv+iwOoSX52Fh5gJat66tHM=;
        b=W0abvVg6Zd1IINsbSIKiV2QiiDjwhVykzKmovykF5SYyAbBkF4C+lBqWQ4ocOCaUUE
         cQuyZK18mRrpyWjGWyfmIdYzKzYQ9IymEQS4PwelHcLkHqnLWocJeppZMGlrsJZvy/2e
         iBgJSh27xHkzHxxp4aWmX+KhVV0KaPpdFDa0ZQdphkGHde5nMl8dYDb9fkVxVe4OWCym
         T5vMx9kTiP3EtvqAJFg7a1W3mfuBRY5p2qfsz1IgiALF/2Tar5TTEEYNqVy8Xu6TiySY
         +qpy0tHrUweTkWc7VTpK9CrvDUoX/hs0Z799WYTsNlknwctf8Fb9jK6jyJDB766V+uie
         1PsA==
X-Gm-Message-State: APjAAAUtnIwloDWM1pjxDUASF5Ttt/He7+oaYtvBXuCGvS9b3lE2mhOK
        n0Bx9RNQNOudHasHJsG9/8d0zIbCXR96JuFvFz2MXA==
X-Google-Smtp-Source: APXvYqxc44Q6R+YXNLRxByMsegXzjdrZQJG4+hZKKdy8MCZim9YpQRM2AB9iS/NNXnkicVFZbuInpqJMFKxfkGR+XF2hZg==
X-Received: by 2002:a65:4085:: with SMTP id t5mr580684pgp.335.1573608512964;
 Tue, 12 Nov 2019 17:28:32 -0800 (PST)
Date:   Tue, 12 Nov 2019 17:27:46 -0800
Message-Id: <20191113012746.52804-1-brendanhiggins@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
Subject: [PATCH linux-kselftest/test v1] Documentation: kunit: add
 documentation for kunit_tool
From:   Brendan Higgins <brendanhiggins@google.com>
To:     shuah@kernel.org, davidgow@google.com
Cc:     kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
        corbet@lwn.net, tytso@mit.edu,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for the Python script used to build, run, and collect
results from the kernel known as kunit_tool. kunit_tool
(tools/testing/kunit/kunit.py) was already added in previous commits.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 Documentation/dev-tools/kunit/index.rst      |  1 +
 Documentation/dev-tools/kunit/kunit-tool.rst | 57 ++++++++++++++++++++
 Documentation/dev-tools/kunit/start.rst      |  3 ++
 3 files changed, 61 insertions(+)
 create mode 100644 Documentation/dev-tools/kunit/kunit-tool.rst

diff --git a/Documentation/dev-tools/kunit/index.rst b/Documentation/dev-tools/kunit/index.rst
index 26ffb46bdf99d..c60d760a0eed1 100644
--- a/Documentation/dev-tools/kunit/index.rst
+++ b/Documentation/dev-tools/kunit/index.rst
@@ -9,6 +9,7 @@ KUnit - Unit Testing for the Linux Kernel
 
 	start
 	usage
+	kunit-tool
 	api/index
 	faq
 
diff --git a/Documentation/dev-tools/kunit/kunit-tool.rst b/Documentation/dev-tools/kunit/kunit-tool.rst
new file mode 100644
index 0000000000000..aa1a93649a45a
--- /dev/null
+++ b/Documentation/dev-tools/kunit/kunit-tool.rst
@@ -0,0 +1,57 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=================
+kunit_tool How-To
+=================
+
+What is kunit_tool?
+===================
+
+kunit_tool is a set of scripts that aid in building the Linux kernel as UML
+(`User Mode Linux <http://user-mode-linux.sourceforge.net/old/>`_), running
+KUnit tests, parsing the test results and displaying them in a user friendly
+manner.
+
+What is a kunitconfig?
+======================
+
+It's just a defconfig that kunit_tool looks for in the base directory.
+kunit_tool uses it to generate a .config as you might expect. In addition, it
+verifies that the generated .config contains the CONFIG options in the
+kunitconfig; the reason it does this is so that it is easy to be sure that a
+CONFIG that enables a test actually ends up in the .config.
+
+How do I use kunit_tool?
+=================================
+
+If a kunitconfig is present at the root directory, all you have to do is:
+
+.. code-block:: bash
+
+	./tools/testing/kunit/kunit.py run
+
+However, you most likely want to use it with the following options:
+
+.. code-block:: bash
+
+	./tools/testing/kunit/kunit.py run --timeout=30 --jobs=8
+
+- ``--timeout`` sets a maximum amount of time to allow tests to run.
+- ``--jobs`` sets the number of threads to use to build the kernel.
+
+If you just want to use the defconfig that ships with the kernel, you can
+append the ``--defconfig`` flag as well:
+
+.. code-block:: bash
+
+	./tools/testing/kunit/kunit.py run --timeout=30 --jobs=8 --defconfig
+
+.. note::
+	This command is particularly helpful for getting started because it
+	just works. No kunitconfig needs to be present.
+
+For a list of all the flags supported by kunit_tool, you can run:
+
+.. code-block:: bash
+
+	./tools/testing/kunit/kunit.py run --help
diff --git a/Documentation/dev-tools/kunit/start.rst b/Documentation/dev-tools/kunit/start.rst
index aeeddfafeea20..1535c4394cfa2 100644
--- a/Documentation/dev-tools/kunit/start.rst
+++ b/Documentation/dev-tools/kunit/start.rst
@@ -21,6 +21,9 @@ The wrapper can be run with:
 
    ./tools/testing/kunit/kunit.py run
 
+For more information on this wrapper (also called kunit_tool) checkout the
+:doc:`kunit-tool` page.
+
 Creating a kunitconfig
 ======================
 The Python script is a thin wrapper around Kbuild as such, it needs to be
-- 
2.24.0.432.g9d3f5f5b63-goog

