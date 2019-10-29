Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B571CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 20:00:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03CCC2067D
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 20:00:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JR0vw0hb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727504AbfJ2UAS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 16:00:18 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:33705 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbfJ2UAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 16:00:17 -0400
Received: by mail-io1-f66.google.com with SMTP id n17so3104080ioa.0;
        Tue, 29 Oct 2019 13:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XFtN+XGvbR1I6A3qEJqZM9z+JSUPPupQU7FJEjlcOXU=;
        b=JR0vw0hbABPx+plRSJz53fHZYUuZWTk8x9Ldf8KysVTFsqAdiLX5uJclKbxOrENE1g
         ep4egRhA43e4I41wtOAZnVzpZZ571NfsusYWFfT2J/zYBa3lH0T4UmLZWCYRcI+MxsNJ
         aOmVc1Cxe2dtHba9THbRElcuj4PYfhy97dr2W7qYK7Q/6QYSvxCg2fwtWtqHZBKWmpyF
         Eu70sAcN7VRfGZ8Bzq2uOBHoiPXK1m5akC293s7wCfw/Myw7zauakKhKHk3eT7zD342Z
         Ww8rStz+26KaU9L0l0n3+FsTxZ7vfN4z2rZH3DrgiZBS4xLJ9T28FDuXeZa+CP7jlHGm
         8Hvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XFtN+XGvbR1I6A3qEJqZM9z+JSUPPupQU7FJEjlcOXU=;
        b=dEViGdBeqwWzxb0k1guYu4SOMe4SY6dbpicjXbSM5OMVHjRfi4THoeHI4begW9LHtg
         mk4rVSdYKS5hcGA0MrZJFComCas4dXYHMtH7LTX0y7Ezbsfx3IzNfA4tKvPdXSZLfOSx
         ju6M69S3jriEGw7FVACzpiVYeuajhX8ERFyzFcQnr8jKyGnNrs7TijtrJiCtvCf82G3M
         cVzYKciSHo3PcK0Nv3jVyS/yeTxh0uEX6SwlTka09qi+RBmsedu+bQkptgTi5EWnR/M1
         w5RvlS4/5kkJn5L2sAnjEAKhL/X9ENlKPmpcQwqWRDU3+ZSS152SAiw0BQiKfDYMYxh0
         gVug==
X-Gm-Message-State: APjAAAW9ChvLcOi/VHE9rkJ5TIU7XAHX07q+SGcsKHY1qhkA62KUwtpD
        WdHI9sXAyhT9jwv1CNWLWBPmmgzmZas=
X-Google-Smtp-Source: APXvYqytZC735/YDLLdQj1rP8iMwjXHtXvM9JN0dpSLnDJtr39J5ZpCT/eVDRirnkaX5JYzzbPHFXg==
X-Received: by 2002:a6b:b486:: with SMTP id d128mr5670385iof.47.1572379213067;
        Tue, 29 Oct 2019 13:00:13 -0700 (PDT)
Received: from localhost.localdomain (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id v14sm420iob.59.2019.10.29.13.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 13:00:10 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org
Cc:     linux@rasmusvillemoes.dk, greg@kroah.com,
        Jim Cromie <jim.cromie@gmail.com>,
        clang-built-linux@googlegroups.com,
        Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org
Subject: [PATCH 01/16] dyndbg: drop trim_prefix, obsoleted by __FILE__s relative path
Date:   Tue, 29 Oct 2019 14:00:00 -0600
Message-Id: <20191029200001.9640-1-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.21.0
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

So remove the function and callers; its purpose was to strip the
prefix from __FILE__, which is now gone.  Further, there is no loss of
query selectivity, and no real value in iteratively trimming ^/\w+
prefix and testing for a match.

Also drop "file $fullpath" from docs, and tweak example to cite column
1 of control-file as valid "file $input".

cc: clang-built-linux@googlegroups.com

I built one clang-kernel a while ago to see if this patch broke
things, it did not, but I may have messed up something.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 .../admin-guide/dynamic-debug-howto.rst       | 19 +++++++++----------
 lib/dynamic_debug.c                           | 19 +++----------------
 2 files changed, 12 insertions(+), 26 deletions(-)

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
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index c60409138e13..ba35199edd9c 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -67,17 +67,6 @@ static LIST_HEAD(ddebug_tables);
 static int verbose;
 module_param(verbose, int, 0644);
 
-/* Return the path relative to source root */
-static inline const char *trim_prefix(const char *path)
-{
-	int skip = strlen(__FILE__) - strlen("lib/dynamic_debug.c");
-
-	if (strncmp(path, __FILE__, skip))
-		skip = 0; /* prefix mismatch, don't skip */
-
-	return path + skip;
-}
-
 static struct { unsigned flag:8; char opt_char; } opt_array[] = {
 	{ _DPRINTK_FLAGS_PRINT, 'p' },
 	{ _DPRINTK_FLAGS_INCL_MODNAME, 'm' },
@@ -162,9 +151,7 @@ static int ddebug_change(const struct ddebug_query *query,
 			if (query->filename &&
 			    !match_wildcard(query->filename, dp->filename) &&
 			    !match_wildcard(query->filename,
-					   kbasename(dp->filename)) &&
-			    !match_wildcard(query->filename,
-					   trim_prefix(dp->filename)))
+					    kbasename(dp->filename)))
 				continue;
 
 			/* match against the function */
@@ -199,7 +186,7 @@ static int ddebug_change(const struct ddebug_query *query,
 #endif
 			dp->flags = newflags;
 			vpr_info("changed %s:%d [%s]%s =%s\n",
-				 trim_prefix(dp->filename), dp->lineno,
+				 dp->filename, dp->lineno,
 				 dt->mod_name, dp->function,
 				 ddebug_describe_flags(dp, flagbuf,
 						       sizeof(flagbuf)));
@@ -827,7 +814,7 @@ static int ddebug_proc_show(struct seq_file *m, void *p)
 	}
 
 	seq_printf(m, "%s:%u [%s]%s =%s \"",
-		   trim_prefix(dp->filename), dp->lineno,
+		   dp->filename, dp->lineno,
 		   iter->table->mod_name, dp->function,
 		   ddebug_describe_flags(dp, flagsbuf, sizeof(flagsbuf)));
 	seq_escape(m, dp->format, "\t\r\n\"");
-- 
2.21.0

