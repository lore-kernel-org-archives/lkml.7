Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BTC_ID,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D332C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 21:52:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2E6621835
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 21:52:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KkIJTde1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730154AbfLEVwG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 16:52:06 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:35553 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729914AbfLEVwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 16:52:05 -0500
Received: by mail-io1-f68.google.com with SMTP id v18so5286078iol.2;
        Thu, 05 Dec 2019 13:52:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=04rJ1IYwNSIyJOHKJi4xXfEFHxSBSW+n5iwgukHRDYo=;
        b=KkIJTde1r4C7sMJ3KIuZeGIH7d3OP0OJGrxgfdw+8B4R5fNsgr/nscwZYqtow/YyUM
         TJiUY9exZT63nfaavupuIVNVm9IFAl6SiNA2l/f6wiZhnr5kBCyHPMgCJMt6KNc5RXTQ
         pqJ1GR5w0DppHHkFgaOOtSl4XSkpFARTTRzRulBLaH3uopxwzQBB/v9QWS7Yh7MvSIdw
         0omlbjob2V49uA/7uJHFyd+9bI2gxrDRMTSoC7E42PqcmNLG9psX7udQK9ddc4hPSt9G
         dksms2GADici3fJJmr+rwiQTBRJbbEJxf7tGEErD0ig2iNYEgy20GmdeMpKBb1uJObv3
         kArg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=04rJ1IYwNSIyJOHKJi4xXfEFHxSBSW+n5iwgukHRDYo=;
        b=EH7pqCeBQERdpjJLQ1x7ZYIG20rEOaCbKZu+arJ3zByfTxkx4L8656Vu3rAe1yOeSr
         mLuWddT8Wkez8fT8dKqD2A4+C1Nep7jkELvesDSo5O7ihHpc4gaykBDzvhtpwbcZSpL6
         ojgCWLvUX31P/Lt+W15QnSjhu2xJCNw+c1QPdSdb33nXbYEH1AcYUVqZB8g0GrRKaHsq
         gC51P6AfAmOYNyyK6XXERumwNqnVWnVDDpYrak0p/RIA1BiFvZ7/qPbYsyq1R2gpqSu4
         Tn5vV7MDgUQ/4984zbLYWqw39xxxI/CQ+K6L7OXeXGJgvYI7J9a9scJR32wghvJ/xIKv
         L6mA==
X-Gm-Message-State: APjAAAXZqk2TdeAgRGSkBZJpbbc6+MEo5xHC4FhXWzCxHQMnu/q6eF/H
        ZI34OPRzJJJ5SeIY2a8AcFw=
X-Google-Smtp-Source: APXvYqyjQJykbez8N9B4qcqPu7CuJ5u4sXk5Bwnj5YfHhpeFb6/xrZEZ+JhuypIl34/GBFBwQldArA==
X-Received: by 2002:a02:52c9:: with SMTP id d192mr4028520jab.29.1575582724755;
        Thu, 05 Dec 2019 13:52:04 -0800 (PST)
Received: from localhost.localdomain (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id n22sm740184iog.14.2019.12.05.13.52.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2019 13:52:04 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     linux@rasmusvillemoes.dk, Jim Cromie <jim.cromie@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH 01/18] dyndbg-docs: eschew file /full/path query in docs
Date:   Thu,  5 Dec 2019 14:51:32 -0700
Message-Id: <20191205215151.421926-2-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191205215151.421926-1-jim.cromie@gmail.com>
References: <20191205215151.421926-1-jim.cromie@gmail.com>
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

