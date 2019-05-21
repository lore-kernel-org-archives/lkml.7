Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBB3DC46460
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 21:17:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0B762182B
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 21:17:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728016AbfEUVRb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 17:17:31 -0400
Received: from ms.lwn.net ([45.79.88.28]:42962 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727560AbfEUVR2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 17:17:28 -0400
Received: from meer.lwn.net (localhost [127.0.0.1])
        by ms.lwn.net (Postfix) with ESMTPA id 6854F9A9;
        Tue, 21 May 2019 21:17:27 +0000 (UTC)
From:   Jonathan Corbet <corbet@lwn.net>
To:     linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Markus Heiser <markus.heiser@darmarit.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 1/2] doc: Cope with Sphinx logging deprecations
Date:   Tue, 21 May 2019 15:17:13 -0600
Message-Id: <20190521211714.1395-2-corbet@lwn.net>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190521211714.1395-1-corbet@lwn.net>
References: <20190521211714.1395-1-corbet@lwn.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recent versions of sphinx will emit messages like:

  /stuff/k/git/kernel/Documentation/sphinx/kerneldoc.py:103:
     RemovedInSphinx20Warning: app.warning() is now deprecated.
     Use sphinx.util.logging instead.

Switch to sphinx.util.logging to make this unsightly message go away.
Alas, that interface was only added in version 1.6, so we have to add a
version check to keep things working with older sphinxes.
---
 Documentation/sphinx/kerneldoc.py | 12 ++++++----
 Documentation/sphinx/kernellog.py | 28 +++++++++++++++++++++++
 Documentation/sphinx/kfigure.py   | 38 ++++++++++++++++++-------------
 3 files changed, 58 insertions(+), 20 deletions(-)
 create mode 100644 Documentation/sphinx/kernellog.py

diff --git a/Documentation/sphinx/kerneldoc.py b/Documentation/sphinx/kerneldoc.py
index 9d0a7f08f93b..e8891e63e001 100644
--- a/Documentation/sphinx/kerneldoc.py
+++ b/Documentation/sphinx/kerneldoc.py
@@ -39,6 +39,8 @@ from docutils.statemachine import ViewList
 from docutils.parsers.rst import directives, Directive
 from sphinx.ext.autodoc import AutodocReporter
 
+import kernellog
+
 __version__  = '1.0'
 
 class KernelDocDirective(Directive):
@@ -90,7 +92,8 @@ class KernelDocDirective(Directive):
         cmd += [filename]
 
         try:
-            env.app.verbose('calling kernel-doc \'%s\'' % (" ".join(cmd)))
+            kernellog.verbose(env.app,
+                              'calling kernel-doc \'%s\'' % (" ".join(cmd)))
 
             p = subprocess.Popen(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
             out, err = p.communicate()
@@ -100,7 +103,8 @@ class KernelDocDirective(Directive):
             if p.returncode != 0:
                 sys.stderr.write(err)
 
-                env.app.warn('kernel-doc \'%s\' failed with return code %d' % (" ".join(cmd), p.returncode))
+                kernellog.warn(env.app,
+                               'kernel-doc \'%s\' failed with return code %d' % (" ".join(cmd), p.returncode))
                 return [nodes.error(None, nodes.paragraph(text = "kernel-doc missing"))]
             elif env.config.kerneldoc_verbosity > 0:
                 sys.stderr.write(err)
@@ -132,8 +136,8 @@ class KernelDocDirective(Directive):
             return node.children
 
         except Exception as e:  # pylint: disable=W0703
-            env.app.warn('kernel-doc \'%s\' processing failed with: %s' %
-                         (" ".join(cmd), str(e)))
+            kernellog.warn(app, 'kernel-doc \'%s\' processing failed with: %s' %
+                           (" ".join(cmd), str(e)))
             return [nodes.error(None, nodes.paragraph(text = "kernel-doc missing"))]
 
 def setup(app):
diff --git a/Documentation/sphinx/kernellog.py b/Documentation/sphinx/kernellog.py
new file mode 100644
index 000000000000..af924f51a7dc
--- /dev/null
+++ b/Documentation/sphinx/kernellog.py
@@ -0,0 +1,28 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Sphinx has deprecated its older logging interface, but the replacement
+# only goes back to 1.6.  So here's a wrapper layer to keep around for
+# as long as we support 1.4.
+#
+import sphinx
+
+if sphinx.__version__[:3] >= '1.6':
+    UseLogging = True
+    from sphinx.util import logging
+    logger = logging.getLogger('kerneldoc')
+else:
+    UseLogging = False
+
+def warn(app, message):
+    if UseLogging:
+        logger.warning(message)
+    else:
+        app.warn(message)
+
+def verbose(app, message):
+    if UseLogging:
+        logger.verbose(message)
+    else:
+        app.verbose(message)
+
+
diff --git a/Documentation/sphinx/kfigure.py b/Documentation/sphinx/kfigure.py
index b97228d2cc0e..448c450fe70c 100644
--- a/Documentation/sphinx/kfigure.py
+++ b/Documentation/sphinx/kfigure.py
@@ -60,6 +60,8 @@ import sphinx
 from sphinx.util.nodes import clean_astext
 from six import iteritems
 
+import kernellog
+
 PY3 = sys.version_info[0] == 3
 
 if PY3:
@@ -171,20 +173,20 @@ def setupTools(app):
     This function is called once, when the builder is initiated.
     """
     global dot_cmd, convert_cmd   # pylint: disable=W0603
-    app.verbose("kfigure: check installed tools ...")
+    kernellog.verbose(app, "kfigure: check installed tools ...")
 
     dot_cmd = which('dot')
     convert_cmd = which('convert')
 
     if dot_cmd:
-        app.verbose("use dot(1) from: " + dot_cmd)
+        kernellog.verbose(app, "use dot(1) from: " + dot_cmd)
     else:
-        app.warn("dot(1) not found, for better output quality install "
-                 "graphviz from http://www.graphviz.org")
+        kernellog.warn(app, "dot(1) not found, for better output quality install "
+                       "graphviz from http://www.graphviz.org")
     if convert_cmd:
-        app.verbose("use convert(1) from: " + convert_cmd)
+        kernellog.verbose(app, "use convert(1) from: " + convert_cmd)
     else:
-        app.warn(
+        kernellog.warn(app,
             "convert(1) not found, for SVG to PDF conversion install "
             "ImageMagick (https://www.imagemagick.org)")
 
@@ -225,7 +227,8 @@ def convert_image(img_node, translator, src_fname=None):
     if in_ext == '.dot':
 
         if not dot_cmd:
-            app.verbose("dot from graphviz not available / include DOT raw.")
+            kernellog.verbose(app,
+                              "dot from graphviz not available / include DOT raw.")
             img_node.replace_self(file2literal(src_fname))
 
         elif translator.builder.format == 'latex':
@@ -252,7 +255,8 @@ def convert_image(img_node, translator, src_fname=None):
 
         if translator.builder.format == 'latex':
             if convert_cmd is None:
-                app.verbose("no SVG to PDF conversion available / include SVG raw.")
+                kernellog.verbose(app,
+                                  "no SVG to PDF conversion available / include SVG raw.")
                 img_node.replace_self(file2literal(src_fname))
             else:
                 dst_fname = path.join(translator.builder.outdir, fname + '.pdf')
@@ -265,18 +269,19 @@ def convert_image(img_node, translator, src_fname=None):
         _name = dst_fname[len(translator.builder.outdir) + 1:]
 
         if isNewer(dst_fname, src_fname):
-            app.verbose("convert: {out}/%s already exists and is newer" % _name)
+            kernellog.verbose(app,
+                              "convert: {out}/%s already exists and is newer" % _name)
 
         else:
             ok = False
             mkdir(path.dirname(dst_fname))
 
             if in_ext == '.dot':
-                app.verbose('convert DOT to: {out}/' + _name)
+                kernellog.verbose(app, 'convert DOT to: {out}/' + _name)
                 ok = dot2format(app, src_fname, dst_fname)
 
             elif in_ext == '.svg':
-                app.verbose('convert SVG to: {out}/' + _name)
+                kernellog.verbose(app, 'convert SVG to: {out}/' + _name)
                 ok = svg2pdf(app, src_fname, dst_fname)
 
             if not ok:
@@ -305,7 +310,8 @@ def dot2format(app, dot_fname, out_fname):
     with open(out_fname, "w") as out:
         exit_code = subprocess.call(cmd, stdout = out)
         if exit_code != 0:
-            app.warn("Error #%d when calling: %s" % (exit_code, " ".join(cmd)))
+            kernellog.warn(app,
+                          "Error #%d when calling: %s" % (exit_code, " ".join(cmd)))
     return bool(exit_code == 0)
 
 def svg2pdf(app, svg_fname, pdf_fname):
@@ -322,7 +328,7 @@ def svg2pdf(app, svg_fname, pdf_fname):
     # use stdout and stderr from parent
     exit_code = subprocess.call(cmd)
     if exit_code != 0:
-        app.warn("Error #%d when calling: %s" % (exit_code, " ".join(cmd)))
+        kernellog.warn(app, "Error #%d when calling: %s" % (exit_code, " ".join(cmd)))
     return bool(exit_code == 0)
 
 
@@ -415,15 +421,15 @@ def visit_kernel_render(self, node):
     app = self.builder.app
     srclang = node.get('srclang')
 
-    app.verbose('visit kernel-render node lang: "%s"' % (srclang))
+    kernellog.verbose(app, 'visit kernel-render node lang: "%s"' % (srclang))
 
     tmp_ext = RENDER_MARKUP_EXT.get(srclang, None)
     if tmp_ext is None:
-        app.warn('kernel-render: "%s" unknown / include raw.' % (srclang))
+        kernellog.warn(app, 'kernel-render: "%s" unknown / include raw.' % (srclang))
         return
 
     if not dot_cmd and tmp_ext == '.dot':
-        app.verbose("dot from graphviz not available / include raw.")
+        kernellog.verbose(app, "dot from graphviz not available / include raw.")
         return
 
     literal_block = node[0]
-- 
2.21.0

