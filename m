Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 748B8C742A1
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 01:06:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DE132084B
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 01:06:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="L1mdsonq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729019AbfGLBGP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 21:06:15 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42605 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728951AbfGLBGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 21:06:14 -0400
Received: by mail-pg1-f193.google.com with SMTP id t132so3728175pgb.9
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2019 18:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nmH4dUuXTwGwTRcFB8jQVIYfMpEYADeZlQkwNfxXvEQ=;
        b=L1mdsonqWbRzlNqPFsce3Hl6x96SSTj8v4B2uaPkl/nalAUWxujEPWFubYRB63Xm+N
         W2R2sUtrsdXKGuPQizXzyV6tuHrAQSB9wLNTVpDqGQSAmOC+nByB6pCaQZeagD308MOP
         rJkhoOvQmp/VELAV17erbZ3oUBBnEV697ZswU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nmH4dUuXTwGwTRcFB8jQVIYfMpEYADeZlQkwNfxXvEQ=;
        b=SwZ9HR0DBmCno8aZQT2Gh1BTrWaxaARUcwwqlxJ7XAs2wlY/R1UeYUhWFzzEn06e1H
         0C76j4u01EseZdw1S75IDQ+zduxezwyqsrZVI+KK0guneCl82OU9WFsm5GCYfyiyeyKO
         AiSK4ypLLD4D2i6j9K3xo1zYBXw3wXGsLmQeKSj8hwLubIfAzu0lvY4RV+e0wY5xXBDj
         A3u6CWjqP0tk3bSJ6ADhl0TjpYg4BOZ6GCSWbCK9QHVZXsDNKGQBoG1ZqXAOdbur9W39
         eAfelJ84jIO3aJzhNasP8O3veu7hgEetd8XVEK/YuLY2rCY38HwiU8iIPtclXnIXaPV1
         TGeQ==
X-Gm-Message-State: APjAAAWje44ZqGS61n6/c59lv1f9bxrhItnnTZwiKE2NF8uf/uLiL8Vq
        A1cbSEBMjwmOsL41SgsOwUEsWIEduuw=
X-Google-Smtp-Source: APXvYqyDq3qBrzZxJ7oWD1OfGNB3ekb+yLXv2Fg2sUriUGlQXZAtty13IXllabXRlHCFg5ZJ5mso8A==
X-Received: by 2002:a63:d23:: with SMTP id c35mr7466485pgl.376.1562893572752;
        Thu, 11 Jul 2019 18:06:12 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:534:b7c0:a63c:460c])
        by smtp.gmail.com with ESMTPSA id z20sm11159202pfk.72.2019.07.11.18.06.10
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 11 Jul 2019 18:06:11 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     <linux-kernel@vger.kernel.org>, <linux-kbuild@vger.kernel.org>
Cc:     Jason Baron <jbaron@akamai.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Kees Cook <keescook@chromium.org>,
        Borislav Petkov <bp@suse.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Brian Norris <briannorris@chromium.org>
Subject: [RFC PATCH] bug: always show source-tree-relative paths in WARN()/BUG()
Date:   Thu, 11 Jul 2019 18:05:56 -0700
Message-Id: <20190712010556.248319-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building out-of-tree (e.g., 'make O=...'), __FILE__ ends up being
an absolute path, and so WARN() and BUG() end up putting path names from
the build system into the log text. For example:

  # echo BUG > /sys/kernel/debug/provoke-crash/DIRECT
  ...
  kernel BUG at /mnt/host/source/[...]/drivers/misc/lkdtm/bugs.c:71!

Not only is this excessively verbose, it also adds extra noise into
tools that might parse this output. (For example, if builder paths
change across versions, we suddenly get a "new" crash signature.)

All in all, this looks much better as:

  kernel BUG at drivers/misc/lkdtm/bugs.c:71!

It appears the Kbuild system is fairly entrenched in using
$(KBUILD_OUTPUT) for the ${CWD}, which necessarily means that the
preprocessor will get handed an absolute path. It seems the only
solution then, is to do some sort of post-processing on __FILE__.

It so happens that lib/dynamic_debug.c already solves this sort of
problem, so I steal its solution for use in panic/warn/bug code as well.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---
I'd be happy to entertain better solutions to this problem, but so far,
I haven't been creative enough to come up with one.

I'm also unsure of who best to address this to. If anyone has better
pointers, I'm all ears.

 include/linux/bug.h |  2 ++
 kernel/panic.c      | 21 +++++++++++++++++++--
 lib/bug.c           |  3 ++-
 lib/dynamic_debug.c | 18 ++++--------------
 4 files changed, 27 insertions(+), 17 deletions(-)

diff --git a/include/linux/bug.h b/include/linux/bug.h
index fe5916550da8..6ab59e53801d 100644
--- a/include/linux/bug.h
+++ b/include/linux/bug.h
@@ -76,4 +76,6 @@ static inline __must_check bool check_data_corruption(bool v) { return v; }
 		corruption;						 \
 	}))
 
+const char *trim_filepath_prefix(const char *path);
+
 #endif	/* _LINUX_BUG_H */
diff --git a/kernel/panic.c b/kernel/panic.c
index 4d9f55bf7d38..0bed3101f049 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -546,6 +546,23 @@ struct warn_args {
 	va_list args;
 };
 
+/**
+ * trim_filepath_prefix - retrieve source-root relative path from a __FILE__
+ * @path: a __FILE__-like path argument.
+ * Return: path relative to source root.
+ */
+const char *trim_filepath_prefix(const char *path)
+{
+	int skip = strlen(__FILE__) - strlen("kernel/panic.c");
+
+	BUILD_BUG_ON(strlen(__FILE__) < strlen("kernel/panic.c"));
+
+	if (strncmp(path, __FILE__, skip))
+		skip = 0; /* prefix mismatch, don't skip */
+
+	return path + skip;
+}
+
 void __warn(const char *file, int line, void *caller, unsigned taint,
 	    struct pt_regs *regs, struct warn_args *args)
 {
@@ -556,8 +573,8 @@ void __warn(const char *file, int line, void *caller, unsigned taint,
 
 	if (file)
 		pr_warn("WARNING: CPU: %d PID: %d at %s:%d %pS\n",
-			raw_smp_processor_id(), current->pid, file, line,
-			caller);
+			raw_smp_processor_id(), current->pid,
+			trim_filepath_prefix(file), line, caller);
 	else
 		pr_warn("WARNING: CPU: %d PID: %d at %pS\n",
 			raw_smp_processor_id(), current->pid, caller);
diff --git a/lib/bug.c b/lib/bug.c
index 1077366f496b..2aa91d330451 100644
--- a/lib/bug.c
+++ b/lib/bug.c
@@ -191,7 +191,8 @@ enum bug_trap_type report_bug(unsigned long bugaddr, struct pt_regs *regs)
 	printk(KERN_DEFAULT CUT_HERE);
 
 	if (file)
-		pr_crit("kernel BUG at %s:%u!\n", file, line);
+		pr_crit("kernel BUG at %s:%u!\n", trim_filepath_prefix(file),
+			line);
 	else
 		pr_crit("Kernel BUG at %pB [verbose debug info unavailable]\n",
 			(void *)bugaddr);
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 8a16c2d498e9..0896f067ba17 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -13,6 +13,7 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ":%s: " fmt, __func__
 
+#include <linux/bug.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
@@ -67,17 +68,6 @@ static LIST_HEAD(ddebug_tables);
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
@@ -164,7 +154,7 @@ static int ddebug_change(const struct ddebug_query *query,
 			    !match_wildcard(query->filename,
 					   kbasename(dp->filename)) &&
 			    !match_wildcard(query->filename,
-					   trim_prefix(dp->filename)))
+					   trim_filepath_prefix(dp->filename)))
 				continue;
 
 			/* match against the function */
@@ -199,7 +189,7 @@ static int ddebug_change(const struct ddebug_query *query,
 #endif
 			dp->flags = newflags;
 			vpr_info("changed %s:%d [%s]%s =%s\n",
-				 trim_prefix(dp->filename), dp->lineno,
+				 trim_filepath_prefix(dp->filename), dp->lineno,
 				 dt->mod_name, dp->function,
 				 ddebug_describe_flags(dp, flagbuf,
 						       sizeof(flagbuf)));
@@ -827,7 +817,7 @@ static int ddebug_proc_show(struct seq_file *m, void *p)
 	}
 
 	seq_printf(m, "%s:%u [%s]%s =%s \"",
-		   trim_prefix(dp->filename), dp->lineno,
+		   trim_filepath_prefix(dp->filename), dp->lineno,
 		   iter->table->mod_name, dp->function,
 		   ddebug_describe_flags(dp, flagsbuf, sizeof(flagsbuf)));
 	seq_escape(m, dp->format, "\t\r\n\"");
-- 
2.22.0.410.gd8fdbe21b5-goog

