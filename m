Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FDF2C04E30
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 02:28:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35FB320726
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 02:28:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g271pfas"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbfLJC2D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 21:28:03 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:40559 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726598AbfLJC2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 21:28:02 -0500
Received: by mail-io1-f65.google.com with SMTP id x1so17110877iop.7;
        Mon, 09 Dec 2019 18:28:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=04rJ1IYwNSIyJOHKJi4xXfEFHxSBSW+n5iwgukHRDYo=;
        b=g271pfas04vYMUSXwPtChhe1b2ZNy5dgqbW+jolbsj9hSY+XC+oqUSime39t7tELTQ
         0n/M//oeYDvhCY886wJrRpIIxWV3vytHnw597xacTMZFbqLNhwQdMdQfj2GocbVkLgMs
         8IRl1Ve5hK/WhqWBDyLSmFmTKF4Ly8tJp3zeFNBEakioUnTlnjIfg7e2bz6VcL6BlUCN
         BqdKymLcR+IeVuOkXkDBfoujUgNxcJblC+TAc7csDYZJz5nb/tlEKFsFvMso0AFVv++p
         c6OxlzIyuZQBGdMgODVorfUBdW252yGDiMs/LxKLp/lXnGoWWay7QPCAknN3mYre9zc/
         wdVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=04rJ1IYwNSIyJOHKJi4xXfEFHxSBSW+n5iwgukHRDYo=;
        b=iSkkTpAaxs0oOLZGwXEI8ybTDhkD9+XlLGq/GOWly8Ly9HLDtdkHvaI74bj/3Iu4g3
         SA/XjhCN+To3mzUa/fncZRinGmvm8KiHM2eQ/QlPP24fVv+wSrDvzhHF6kc2kVf1w8S6
         IZsmULQbERLaJcJuvb83wlOJSmnzgm2O8yjMIgNSD4P9LIPnM/NBK3bOMiOLNoMfp4cH
         qjJ8rutOQpttMYsDnf2Q+HpYg+ShRCfcjxOah0usLaqHN5tJIhmvnLebCN4qHG8ZUTPB
         gCMKosmJ2ErpossEPzkjIt1aZuMft+uuw2zK3rEUoyYxAY6BKhN7gFkIkr5JJ4qXbFhn
         zzww==
X-Gm-Message-State: APjAAAWxYVynHo3tUNE5hUlUBygpEC0JBXJHnGsfMNyCX20iUftUborD
        xR/omAN5WUsJMY87y7IxRuE=
X-Google-Smtp-Source: APXvYqx5I2O5dQp+GMaFmZgAFGJEd9esF+AcqosZZP1zuH+/vhb1FySDAaFFO3prBsaVJJYw4M5Ofg==
X-Received: by 2002:a02:cc75:: with SMTP id j21mr29650457jaq.113.1575944881724;
        Mon, 09 Dec 2019 18:28:01 -0800 (PST)
Received: from localhost.localdomain (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id l9sm334052ioh.77.2019.12.09.18.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 18:28:01 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org,
        akpm@linuxfoundation.org
Cc:     gregkh@linuxfoundation.org, linux@rasmusvillemoes.dk,
        Jim Cromie <jim.cromie@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH v4 01/16] dyndbg-docs: eschew file /full/path query in docs
Date:   Mon,  9 Dec 2019 19:27:27 -0700
Message-Id: <20191210022742.822686-2-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191210022742.822686-1-jim.cromie@gmail.com>
References: <20191210022742.822686-1-jim.cromie@gmail.com>
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

