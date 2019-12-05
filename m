Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E75AC43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 21:52:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1726D2466E
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 21:52:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AYfqrcCn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387531AbfLEVwu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 16:52:50 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:34690 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729598AbfLEVws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 16:52:48 -0500
Received: by mail-il1-f195.google.com with SMTP id w13so4414149ilo.1;
        Thu, 05 Dec 2019 13:52:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q5OyZGPUGMBoXLkl+yUlAxvS/3ZUhVk94LfmpNzMuB4=;
        b=AYfqrcCnfoG7DjyJ0H5T11F6A1eFZq/1K/6Xbqsqgb/3s/YC+jjZVNc+bi984oJqTf
         tnRzWjJc7GeMjKkCKoFoulLr4cKOGNVZGdIxKh7OhxTbhKaJDhyp/PvMOH2obMMBMcJn
         0N5NGqQHyktVP0sMlZJZYERsZTI06ErDlrO+FX/mqp+DVZMxxMPkMWsbmllM0lndv9sx
         JFlMFjs6wPZaadeNMJsnmaDg+k2j8EGYsOGirfVYWT0zTxNye1Suvcwa6LAJ8CRBno0g
         hkE/qzjlgxmP1guTI9DpxOdkT1ozHVmbpkx+JiQCO0pIt7XzF/9l0LQsoMS0cIk+pn5a
         eFqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q5OyZGPUGMBoXLkl+yUlAxvS/3ZUhVk94LfmpNzMuB4=;
        b=hZuVLAQrdn7iCW8xEN1g4zEE7yyZBM0JcEK6WDEzgoyMJDK6LQFYNc5TRjjeg62OA2
         71CpZMvxjNe/9uYnuBL5Qj0ny9IzG/dXeddfe/uO+BC/xdubgLFHHZYTL7X6J7QKPeYT
         IflXnn5iHsTVe2dxZNdJxJtZ0rg0PQJoIy4Uz+VI1wS4WpDwlBm0ZjlbolKb5zy3aVmj
         tPb79XZN08pGlrkGeOmEvdnWaqkfs12MwDJoB2hBy8uipnwSE9lPpSTkPHsSMB2zxKKy
         pJX0NZYkJ9T6RtjIpT0MvQoZk23UFTv8oT0thUxUbd+NdiOy1oCm6E7E/ijKu7jNrx3o
         3zDw==
X-Gm-Message-State: APjAAAUc0ajtdG42MblOLXuYzDDbnvKl6n85UeijxRl5NmMVi/RhO5P5
        YWbU43Sc3Tc4avu2FvksnQI=
X-Google-Smtp-Source: APXvYqwOn4PTzrg2U8fVNMuriOuaM3sFLCj7xSQkJ4aDdIL5efmvEFnGTM/WEPw0uwrg+gOEdvT7Xw==
X-Received: by 2002:a92:290a:: with SMTP id l10mr10976359ilg.151.1575582766659;
        Thu, 05 Dec 2019 13:52:46 -0800 (PST)
Received: from localhost.localdomain (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id n22sm740184iog.14.2019.12.05.13.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2019 13:52:45 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     linux@rasmusvillemoes.dk, Jim Cromie <jim.cromie@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "David S. Miller" <davem@davemloft.net>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Gary Hook <Gary.Hook@amd.com>, Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>, linux-doc@vger.kernel.org
Subject: [PATCH 17/18] dyndbg: rename dynamic_debug to dyndbg
Date:   Thu,  5 Dec 2019 14:51:50 -0700
Message-Id: <20191205215151.421926-20-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191205215151.421926-1-jim.cromie@gmail.com>
References: <20191205215151.421926-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This rename fixes a subtle usage wrinkle; the __setup() names didn't
match the fake "dyndbg" module parameter used to enable dynamic-printk
callsites in modules.  See the last change in Docs for the effect.

It also shortens the "__FILE__:__func__" prefix in dyndbg.verbose
messages, effectively s/dynamic_debug/dyndbg/

This is a 99.9% rename; trim_prefix and debugfs_create_dir arg excepted.
Nonetheless, it also changes both /sys appearances:

bash-5.0# ls -R /sys/kernel/debug/dyndbg/ /sys/module/dyndbg/parameters/
/sys/kernel/debug/dyndbg/:
control
/sys/module/dyndbg/parameters/:
verbose

Finally, paths in docs are ~= s|/dynamic_debug/|/dyndbg/|,
plus the kernel cmdline example tweak cited above.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 .../admin-guide/dynamic-debug-howto.rst       | 50 +++++++++----------
 lib/Makefile                                  |  4 +-
 lib/{dynamic_debug.c => dyndbg.c}             |  4 +-
 3 files changed, 29 insertions(+), 29 deletions(-)
 rename lib/{dynamic_debug.c => dyndbg.c} (99%)

diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Documentation/admin-guide/dynamic-debug-howto.rst
index 5c170e49121d..d91dbb52721d 100644
--- a/Documentation/admin-guide/dynamic-debug-howto.rst
+++ b/Documentation/admin-guide/dynamic-debug-howto.rst
@@ -31,7 +31,7 @@ Dynamic debug has even more useful features:
    - module name
    - format string
 
- * Provides a debugfs control file: ``<debugfs>/dynamic_debug/control``
+ * Provides a debugfs control file: ``<debugfs>/dyndbg/control``
    which can be read to display the complete list of known debug
    statements, to help guide you
 
@@ -42,16 +42,16 @@ The behaviour of ``pr_debug()``/``dev_dbg()`` are controlled via writing to a
 control file in the 'debugfs' filesystem. Thus, you must first mount
 the debugfs filesystem, in order to make use of this feature.
 Subsequently, we refer to the control file as:
-``<debugfs>/dynamic_debug/control``. For example, if you want to enable
+``<debugfs>/dyndbg/control``. For example, if you want to enable
 printing from source file ``svcsock.c``, line 1603 you simply do::
 
   nullarbor:~ # echo 'file svcsock.c line 1603 +p' >
-				<debugfs>/dynamic_debug/control
+				<debugfs>/dyndbg/control
 
 If you make a mistake with the syntax, the write will fail thus::
 
   nullarbor:~ # echo 'file svcsock.c wtf 1 +p' >
-				<debugfs>/dynamic_debug/control
+				<debugfs>/dyndbg/control
   -bash: echo: write error: Invalid argument
 
 Viewing Dynamic Debug Behaviour
@@ -60,7 +60,7 @@ Viewing Dynamic Debug Behaviour
 You can view the currently configured behaviour of all the debug
 statements via::
 
-  nullarbor:~ # cat <debugfs>/dynamic_debug/control
+  nullarbor:~ # cat <debugfs>/dyndbg/control
   # filename:lineno [module]function flags format
   net/sunrpc/svc_rdma.c:323 [svcxprt_rdma]svc_rdma_cleanup =_ "SVCRDMA Module Removed, deregister RPC RDMA transport\012"
   net/sunrpc/svc_rdma.c:341 [svcxprt_rdma]svc_rdma_init =_ "\011max_inline       : %d\012"
@@ -72,10 +72,10 @@ statements via::
 You can also apply standard Unix text manipulation filters to this
 data, e.g.::
 
-  nullarbor:~ # grep -i rdma <debugfs>/dynamic_debug/control  | wc -l
+  nullarbor:~ # grep -i rdma <debugfs>/dyndbg/control  | wc -l
   62
 
-  nullarbor:~ # grep -i tcp <debugfs>/dynamic_debug/control | wc -l
+  nullarbor:~ # grep -i tcp <debugfs>/dyndbg/control | wc -l
   42
 
 The third column shows the currently enabled flags for each debug
@@ -83,7 +83,7 @@ statement callsite (see below for definitions of the flags).  The
 default value, with no flags enabled, is ``=_``.  So you can view all
 the debug statement callsites with any non-default flags::
 
-  nullarbor:~ # awk '$3 != "=_"' <debugfs>/dynamic_debug/control
+  nullarbor:~ # awk '$3 != "=_"' <debugfs>/dyndbg/control
   # filename:lineno [module]function flags format
   net/sunrpc/svcsock.c:1603 [sunrpc]svc_send p "svc_process: st_sendto returned %d\012"
 
@@ -94,27 +94,27 @@ At the lexical level, a command comprises a sequence of words separated
 by spaces or tabs.  So these are all equivalent::
 
   nullarbor:~ # echo -n 'file svcsock.c line 1603 +p' >
-				<debugfs>/dynamic_debug/control
+				<debugfs>/dyndbg/control
   nullarbor:~ # echo -n '  file   svcsock.c     line  1603 +p  ' >
-				<debugfs>/dynamic_debug/control
+				<debugfs>/dyndbg/control
   nullarbor:~ # echo -n 'file svcsock.c line 1603 +p' >
-				<debugfs>/dynamic_debug/control
+				<debugfs>/dyndbg/control
 
 Command submissions are bounded by a write() system call.
 Multiple commands can be written together, separated by ``;`` or ``\n``::
 
   ~# echo "func pnpacpi_get_resources +p; func pnp_assign_mem +p" \
-     > <debugfs>/dynamic_debug/control
+     > <debugfs>/dyndbg/control
 
 If your query set is big, you can batch them too::
 
-  ~# cat query-batch-file > <debugfs>/dynamic_debug/control
+  ~# cat query-batch-file > <debugfs>/dyndbg/control
 
 Another way is to use wildcards. The match rule supports ``*`` (matches
 zero or more characters) and ``?`` (matches exactly one character). For
 example, you can match all usb drivers::
 
-  ~# echo "file drivers/usb/* +p" > <debugfs>/dynamic_debug/control
+  ~# echo "file drivers/usb/* +p" > <debugfs>/dyndbg/control
 
 At the syntactical level, a command comprises a sequence of match
 specifications, followed by a flags change specification::
@@ -338,7 +338,7 @@ For ``CONFIG_DYNAMIC_DEBUG`` kernels, any settings given at boot-time (or
 enabled by ``-DDEBUG`` flag during compilation) can be disabled later via
 the debugfs interface if the debug messages are no longer needed::
 
-   echo "module module_name -p" > <debugfs>/dynamic_debug/control
+   echo "module module_name -p" > <debugfs>/dyndbg/control
 
 Examples
 ========
@@ -347,41 +347,41 @@ Examples
 
   // enable the message at line 1603 of file svcsock.c
   nullarbor:~ # echo -n 'file svcsock.c line 1603 +p' >
-				<debugfs>/dynamic_debug/control
+				<debugfs>/dyndbg/control
 
   // enable all the messages in file svcsock.c
   nullarbor:~ # echo -n 'file svcsock.c +p' >
-				<debugfs>/dynamic_debug/control
+				<debugfs>/dyndbg/control
 
   // enable all the messages in the NFS server module
   nullarbor:~ # echo -n 'module nfsd +p' >
-				<debugfs>/dynamic_debug/control
+				<debugfs>/dyndbg/control
 
   // enable all 12 messages in the function svc_process()
   nullarbor:~ # echo -n 'func svc_process +p' >
-				<debugfs>/dynamic_debug/control
+				<debugfs>/dyndbg/control
 
   // disable all 12 messages in the function svc_process()
   nullarbor:~ # echo -n 'func svc_process -p' >
-				<debugfs>/dynamic_debug/control
+				<debugfs>/dyndbg/control
 
   // enable messages for NFS calls READ, READLINK, READDIR and READDIR+.
   nullarbor:~ # echo -n 'format "nfsd: READ" +p' >
-				<debugfs>/dynamic_debug/control
+				<debugfs>/dyndbg/control
 
   // enable messages in files of which the paths include string "usb"
-  nullarbor:~ # echo -n '*usb* +p' > <debugfs>/dynamic_debug/control
+  nullarbor:~ # echo -n '*usb* +p' > <debugfs>/dyndbg/control
 
   // enable all messages
-  nullarbor:~ # echo -n '+p' > <debugfs>/dynamic_debug/control
+  nullarbor:~ # echo -n '+p' > <debugfs>/dyndbg/control
 
   // add module, function to all enabled messages
-  nullarbor:~ # echo -n '+mf' > <debugfs>/dynamic_debug/control
+  nullarbor:~ # echo -n '+mf' > <debugfs>/dyndbg/control
 
   // boot-args example, with newlines and comments for readability
   Kernel command line: ...
     // see whats going on in dyndbg=value processing
-    dynamic_debug.verbose=1
+    dyndbg.verbose=1
     // enable pr_debugs in 2 builtins, #cmt is stripped
     dyndbg="module params +p #cmt ; module sys +p"
     // enable pr_debugs in 2 functions in a module loaded later
diff --git a/lib/Makefile b/lib/Makefile
index c5892807e06f..ea4028aa7852 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -15,7 +15,7 @@ KCOV_INSTRUMENT_string.o := n
 KCOV_INSTRUMENT_rbtree.o := n
 KCOV_INSTRUMENT_list_debug.o := n
 KCOV_INSTRUMENT_debugobjects.o := n
-KCOV_INSTRUMENT_dynamic_debug.o := n
+KCOV_INSTRUMENT_dyndbg.o := n
 
 # Early boot use of cmdline, don't instrument it
 ifdef CONFIG_AMD_MEM_ENCRYPT
@@ -180,7 +180,7 @@ lib-$(CONFIG_GENERIC_BUG) += bug.o
 
 obj-$(CONFIG_HAVE_ARCH_TRACEHOOK) += syscall.o
 
-obj-$(CONFIG_DYNAMIC_DEBUG) += dynamic_debug.o
+obj-$(CONFIG_DYNAMIC_DEBUG) += dyndbg.o
 
 obj-$(CONFIG_NLATTR) += nlattr.o
 
diff --git a/lib/dynamic_debug.c b/lib/dyndbg.c
similarity index 99%
rename from lib/dynamic_debug.c
rename to lib/dyndbg.c
index d056fca96b9d..f410d341841a 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dyndbg.c
@@ -77,7 +77,7 @@ module_param(verbose, int, 0644);
 /* Return the path relative to source root */
 static inline const char *trim_prefix(const char *path)
 {
-	int skip = strlen(__FILE__) - strlen("lib/dynamic_debug.c");
+	int skip = strlen(__FILE__) - strlen("lib/dyndbg.c");
 
 	if (strncmp(path, __FILE__, skip))
 		skip = 0; /* prefix mismatch, don't skip */
@@ -1055,7 +1055,7 @@ static int __init dynamic_debug_init_debugfs(void)
 	if (!ddebug_init_success)
 		return -ENODEV;
 
-	dir = debugfs_create_dir("dynamic_debug", NULL);
+	dir = debugfs_create_dir("dyndbg", NULL);
 	debugfs_create_file("control", 0644, dir, NULL, &ddebug_proc_fops);
 
 	return 0;
-- 
2.23.0

