Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 217DCC43215
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 17:50:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E768620835
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 17:50:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jtuGQCCT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727182AbfK0Ruh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 12:50:37 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:37653 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726947AbfK0Rug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 12:50:36 -0500
Received: by mail-io1-f68.google.com with SMTP id k24so15201940ioc.4;
        Wed, 27 Nov 2019 09:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=04rJ1IYwNSIyJOHKJi4xXfEFHxSBSW+n5iwgukHRDYo=;
        b=jtuGQCCTDbUJ5ImvXzF36pJWvS/G0E2f9jGhmPvOSjcR9/GOBctAZDeZZx+XDT+ZFL
         zBkd7eWDm+XH6doZMonVivdpXIzSv5x1nB6rw4K6Z93MVpCL8s3g0ekoR6j9eMJNWHP5
         QZ37fW014SlXffav0nD0sZz12sGAFUnmv5oQmVLQV6lA6oqfzy6EnB1RhU2P7189BCPH
         7PXH53O2VXGzISkP3uge84MCvBgqU9IBqapRO4H17fM8l59sdEYtQYzzbr5flTIr75GR
         74Ea84SQAfV1VlbQu05wqGpE5JqqLdmEAUsGhzF7liHMKQNjAyuAdOOF7bjVdZJ+erxp
         IlQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=04rJ1IYwNSIyJOHKJi4xXfEFHxSBSW+n5iwgukHRDYo=;
        b=SCLXyOlBFhR/JHs6jRjd2+RGH7zSrHDrY/mMEJR3/vcPFCGQibFiIK8ETr3euav3M8
         bRlXMWpiw1ZfVS880N4sbCSK0HVpI1jMIbdBirIkAGRr5xB/La0mGzNP0mgWmAeEYmEF
         F8ujMHkRAGXDkXX3XUyLrFyz2IbeBhBRSvVERbyYqQOpo7/3G4V+7iJDR+SNGbZQViXS
         Yoc3ZICVyMSX+ilotfIunGHWnAAB3+BOzl8l53zTLlUc3xmTh+geu/1Rv/JqfQfnfGH0
         RP6rK2zS0bm2nJ7g2BiY/FuZ3zOiKMev6oB0Iey0I8bVLBL5Pe8TElnZ8lHna/JnpZQ3
         vmZg==
X-Gm-Message-State: APjAAAX8WhROdPGTTr5p0em32CtqQwoeLmkmXPJSUbRLCk7zRb2G6+KM
        agZYzUAF4iEGx745Wj7v0CM=
X-Google-Smtp-Source: APXvYqzWvzxtb7J0G8nzMhO77OMQr50BdQa1XbiNt1L46k32ns3H5ggL9HenLLvInyzeBxVZGAtX+g==
X-Received: by 2002:a02:6a01:: with SMTP id l1mr5693053jac.73.1574877035951;
        Wed, 27 Nov 2019 09:50:35 -0800 (PST)
Received: from localhost.localdomain (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id b22sm1183466ior.49.2019.11.27.09.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 09:50:35 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org
Cc:     linux@rasmusvillemoes.dk, greg@kroah.com,
        Jim Cromie <jim.cromie@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH 01/16] dyndbg-docs: eschew file /full/path query in docs
Date:   Wed, 27 Nov 2019 10:50:24 -0700
Message-Id: <20191127175025.1351158-1-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Regarding:
commit 2b6783191da7 ("dynamic_debug: add trim_prefix() to provide source-root relative paths")
commit a73619a845d5 ("kbuild: use -fmacro-prefix-map to make __FILE__ a relative path")

2nd commit broke dynamic-debug's "file $fullpath" query form, but
nobody noticed because 1st commit trimmed prefixes from control-file
output, so the click-copy-pasting of fullpaths into new queries had
ceased; that query form became unused.

Removing the function is cleanest, but it could be useful in
old-compiler corner cases, where __FILE__ still has /full/path,
and it safely does nothing otherwize.

So instead, quietly deprecate "file /full/path" query form, by
removing all /full/paths examples in the docs.  I skipped adding a
back-compat note.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 .../admin-guide/dynamic-debug-howto.rst       | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Documentation/admin-guide/dynamic-debug-howto.rst
index 252e5ef324e5..e011f8907116 100644
--- a/Documentation/admin-guide/dynamic-debug-howto.rst
+++ b/Documentation/admin-guide/dynamic-debug-howto.rst
@@ -62,10 +62,10 @@ statements via::
 
   nullarbor:~ # cat <debugfs>/dynamic_debug/control
   # filename:lineno [module]function flags format
-  /usr/src/packages/BUILD/sgi-enhancednfs-1.4/default/net/sunrpc/svc_rdma.c:323 [svcxprt_rdma]svc_rdma_cleanup =_ "SVCRDMA Module Removed, deregister RPC RDMA transport\012"
-  /usr/src/packages/BUILD/sgi-enhancednfs-1.4/default/net/sunrpc/svc_rdma.c:341 [svcxprt_rdma]svc_rdma_init =_ "\011max_inline       : %d\012"
-  /usr/src/packages/BUILD/sgi-enhancednfs-1.4/default/net/sunrpc/svc_rdma.c:340 [svcxprt_rdma]svc_rdma_init =_ "\011sq_depth         : %d\012"
-  /usr/src/packages/BUILD/sgi-enhancednfs-1.4/default/net/sunrpc/svc_rdma.c:338 [svcxprt_rdma]svc_rdma_init =_ "\011max_requests     : %d\012"
+  net/sunrpc/svc_rdma.c:323 [svcxprt_rdma]svc_rdma_cleanup =_ "SVCRDMA Module Removed, deregister RPC RDMA transport\012"
+  net/sunrpc/svc_rdma.c:341 [svcxprt_rdma]svc_rdma_init =_ "\011max_inline       : %d\012"
+  net/sunrpc/svc_rdma.c:340 [svcxprt_rdma]svc_rdma_init =_ "\011sq_depth         : %d\012"
+  net/sunrpc/svc_rdma.c:338 [svcxprt_rdma]svc_rdma_init =_ "\011max_requests     : %d\012"
   ...
 
 
@@ -85,7 +85,7 @@ the debug statement callsites with any non-default flags::
 
   nullarbor:~ # awk '$3 != "=_"' <debugfs>/dynamic_debug/control
   # filename:lineno [module]function flags format
-  /usr/src/packages/BUILD/sgi-enhancednfs-1.4/default/net/sunrpc/svcsock.c:1603 [sunrpc]svc_send p "svc_process: st_sendto returned %d\012"
+  net/sunrpc/svcsock.c:1603 [sunrpc]svc_send p "svc_process: st_sendto returned %d\012"
 
 Command Language Reference
 ==========================
@@ -158,13 +158,12 @@ func
 	func svc_tcp_accept
 
 file
-    The given string is compared against either the full pathname, the
-    src-root relative pathname, or the basename of the source file of
-    each callsite.  Examples::
+    The given string is compared against either the src-root relative
+    pathname, or the basename of the source file of each callsite.
+    Examples::
 
 	file svcsock.c
-	file kernel/freezer.c
-	file /usr/src/packages/BUILD/sgi-enhancednfs-1.4/default/net/sunrpc/svcsock.c
+	file kernel/freezer.c	# ie column 1 of control file
 
 module
     The given string is compared against the module name
-- 
2.23.0

