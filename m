Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEC2DC48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 17:36:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E7512080C
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 17:36:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbfFZRf6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 13:35:58 -0400
Received: from ms.lwn.net ([45.79.88.28]:40908 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726500AbfFZRf4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 13:35:56 -0400
Received: from meer.lwn.net (localhost [127.0.0.1])
        by ms.lwn.net (Postfix) with ESMTPA id B20FE2AE;
        Wed, 26 Jun 2019 17:29:10 +0000 (UTC)
From:   Jonathan Corbet <corbet@lwn.net>
To:     linux-doc@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v3 1/4] Docs: An initial automarkup extension for sphinx
Date:   Wed, 26 Jun 2019 11:28:56 -0600
Message-Id: <20190626172859.16113-2-corbet@lwn.net>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190626172859.16113-1-corbet@lwn.net>
References: <20190626172859.16113-1-corbet@lwn.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rather than fill our text files with :c:func:`function()` syntax, just do
the markup via a hook into the sphinx build process.

Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 Documentation/conf.py              |  3 +-
 Documentation/sphinx/automarkup.py | 93 ++++++++++++++++++++++++++++++
 2 files changed, 95 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/sphinx/automarkup.py

diff --git a/Documentation/conf.py b/Documentation/conf.py
index 7ace3f8852bd..a502baecbb85 100644
--- a/Documentation/conf.py
+++ b/Documentation/conf.py
@@ -34,7 +34,8 @@ needs_sphinx = '1.3'
 # Add any Sphinx extension module names here, as strings. They can be
 # extensions coming with Sphinx (named 'sphinx.ext.*') or your custom
 # ones.
-extensions = ['kerneldoc', 'rstFlatTable', 'kernel_include', 'cdomain', 'kfigure', 'sphinx.ext.ifconfig']
+extensions = ['kerneldoc', 'rstFlatTable', 'kernel_include', 'cdomain',
+              'kfigure', 'sphinx.ext.ifconfig', 'automarkup']
 
 # The name of the math extension changed on Sphinx 1.4
 if (major == 1 and minor > 3) or (major > 1):
diff --git a/Documentation/sphinx/automarkup.py b/Documentation/sphinx/automarkup.py
new file mode 100644
index 000000000000..b300cf129869
--- /dev/null
+++ b/Documentation/sphinx/automarkup.py
@@ -0,0 +1,93 @@
+# SPDX-License-Identifier: GPL-2.0
+# Copyright 2019 Jonathan Corbet <corbet@lwn.net>
+#
+# Apply kernel-specific tweaks after the initial document processing
+# has been done.
+#
+from docutils import nodes
+from sphinx import addnodes
+import re
+
+#
+# Regex nastiness.  Of course.
+# Try to identify "function()" that's not already marked up some
+# other way.  Sphinx doesn't like a lot of stuff right after a
+# :c:func: block (i.e. ":c:func:`mmap()`s" flakes out), so the last
+# bit tries to restrict matches to things that won't create trouble.
+#
+RE_function = re.compile(r'([\w_][\w\d_]+\(\))')
+
+#
+# Many places in the docs refer to common system calls.  It is
+# pointless to try to cross-reference them and, as has been known
+# to happen, somebody defining a function by these names can lead
+# to the creation of incorrect and confusing cross references.  So
+# just don't even try with these names.
+#
+Skipfuncs = [ 'open', 'close', 'read', 'write', 'fcntl', 'mmap'
+              'select', 'poll', 'fork', 'execve', 'clone', 'ioctl']
+
+#
+# Find all occurrences of function() and try to replace them with
+# appropriate cross references.
+#
+def markup_funcs(docname, app, node):
+    cdom = app.env.domains['c']
+    t = node.astext()
+    done = 0
+    repl = [ ]
+    for m in RE_function.finditer(t):
+        #
+        # Include any text prior to function() as a normal text node.
+        #
+        if m.start() > done:
+            repl.append(nodes.Text(t[done:m.start()]))
+        #
+        # Go through the dance of getting an xref out of the C domain
+        #
+        target = m.group(1)[:-2]
+        target_text = nodes.Text(target + '()')
+        xref = None
+        if target not in Skipfuncs:
+            lit_text = nodes.literal(classes=['xref', 'c', 'c-func'])
+            lit_text += target_text
+            pxref = addnodes.pending_xref('', refdomain = 'c',
+                                          reftype = 'function',
+                                          reftarget = target, modname = None,
+                                          classname = None)
+            xref = cdom.resolve_xref(app.env, docname, app.builder,
+                                     'function', target, pxref, lit_text)
+        #
+        # Toss the xref into the list if we got it; otherwise just put
+        # the function text.
+        #
+        if xref:
+            repl.append(xref)
+        else:
+            repl.append(target_text)
+        done = m.end()
+    if done < len(t):
+        repl.append(nodes.Text(t[done:]))
+    return repl
+
+def auto_markup(app, doctree, name):
+    #
+    # This loop could eventually be improved on.  Someday maybe we
+    # want a proper tree traversal with a lot of awareness of which
+    # kinds of nodes to prune.  But this works well for now.
+    #
+    # The nodes.literal test catches ``literal text``, its purpose is to
+    # avoid adding cross-references to functions that have been explicitly
+    # marked with cc:func:.
+    #
+    for para in doctree.traverse(nodes.paragraph):
+        for node in para.traverse(nodes.Text):
+            if not isinstance(node.parent, nodes.literal):
+                node.parent.replace(node, markup_funcs(name, app, node))
+
+def setup(app):
+    app.connect('doctree-resolved', auto_markup)
+    return {
+        'parallel_read_safe': True,
+        'parallel_write_safe': True,
+        }
-- 
2.21.0

