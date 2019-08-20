Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F363C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 16:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D75CC2054F
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 16:48:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IwJV8bd1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730174AbfHTQr7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 12:47:59 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39810 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729639AbfHTQr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 12:47:59 -0400
Received: by mail-pl1-f194.google.com with SMTP id z3so3044401pln.6
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 09:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:reply-to:mime-version
         :content-disposition;
        bh=94eu4gQpkuQ9j1HnR7KOvdKvZHNUgZsHuQosVNjqQpQ=;
        b=IwJV8bd1Y3w4IHpyHjizWFaH+TvxAq+hbOjq0s/Vb89iivzKVZHZEy3a0UBamaSD8R
         OM0UVCJiEscA7OeAxBuKHbCHK7qZz5dCmP5vfzwpdR4732LfLxchZUXv0Vv1lBF3QN1M
         OnAj9iE5xxyys1hZ9ELdj6YEVG5yU0oioC5dI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mime-version:content-disposition;
        bh=94eu4gQpkuQ9j1HnR7KOvdKvZHNUgZsHuQosVNjqQpQ=;
        b=BaiDk35sQOQjDir5dEULQFLRpwYWhj2MpKZNNUYBQXtENXqJz2XVtxg/5ryLgvUhNP
         spTBQqbLyw+SwONAA2G5ka+F2RXoEGmyFA4xXrhV3X/4fgT35b13r+oN9vQu4CnzKGK5
         7T8wSPDc9WvQKZps0ZaVs3oqRROhLONRtDOAFt9WWdb+PZAE8wzi4qlFssznTrDKwbNu
         I6h+z0+Jo5XbmpicOv27yS7xo5OR0DxQr9uRnLqb+5jW0wIEirpifd8zyXaS3tYjA/Ul
         8cqnhyhA6RGBfXrKhavyQbLien5NUcKZvGozLl3nNLHyipOdfKx5fidois75iyGcmCG7
         nHDw==
X-Gm-Message-State: APjAAAWPN76HutjZojL6XMurACPyOG0G3vjY8giMLEoZKvpZgBcX9X8I
        iZjc5n/pL+53CHSe91sL4kyXEA==
X-Google-Smtp-Source: APXvYqwpueort6fkRqZzV2MzImcaL+fg8ja4cFzE38QELQbf+3smfZuohR6eRwl2V1DH/lCxSs0qDA==
X-Received: by 2002:a17:902:8302:: with SMTP id bd2mr29596587plb.9.1566319678301;
        Tue, 20 Aug 2019 09:47:58 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g2sm18007770pfm.32.2019.08.20.09.47.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Aug 2019 09:47:57 -0700 (PDT)
Date:   Tue, 20 Aug 2019 09:47:55 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Peter Zijlstra <peterz@infradead.org>,
        Drew Davenport <ddavenport@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Feng Tang <feng.tang@intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        YueHaibing <yuehaibing@huawei.com>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 7/7] bug: Move WARN_ON() "cut here" into exception handler
Message-ID: <201908200943.601DD59DCE@keescook>
Reply-To: 20190819234111.9019-8-keescook@chromium.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The original clean up of "cut here" missed the WARN_ON() case (that
does not have a printk message), which was fixed recently by adding
an explicit printk of "cut here". This had the downside of adding a
printk() to every WARN_ON() caller, which reduces the utility of using
an instruction exception to streamline the resulting code. By making
this a new BUGFLAG, all of these can be removed and "cut here" can be
handled by the exception handler.

This was very pronounced on PowerPC, but the effect can be seen on
x86 as well. The resulting text size of a defconfig build shows some
small savings from this patch:

   text    data     bss     dec     hex filename
19691167        5134320 1646664 26472151        193eed7 vmlinux.before
19676362        5134260 1663048 26473670        193f4c6 vmlinux.after

This change also opens the door for creating something like BUG_MSG(),
where a custom printk() before issuing BUG(), without confusing the "cut
here" line.

Reported-by: Christophe Leroy <christophe.leroy@c-s.fr>
Fixes: Fixes: 6b15f678fb7d ("include/asm-generic/bug.h: fix "cut here" for WARN_ON for __WARN_TAINT architectures")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
v2:
 - rename BUGFLAG_PRINTK to BUGFLAG_NO_CUT_HERE (peterz, christophe)
---
 include/asm-generic/bug.h |  8 +++-----
 lib/bug.c                 | 11 +++++++++--
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
index 588dd59a5b72..a21e83f8a274 100644
--- a/include/asm-generic/bug.h
+++ b/include/asm-generic/bug.h
@@ -10,6 +10,7 @@
 #define BUGFLAG_WARNING		(1 << 0)
 #define BUGFLAG_ONCE		(1 << 1)
 #define BUGFLAG_DONE		(1 << 2)
+#define BUGFLAG_NO_CUT_HERE	(1 << 3)	/* CUT_HERE already sent */
 #define BUGFLAG_TAINT(taint)	((taint) << 8)
 #define BUG_GET_TAINT(bug)	((bug)->flags >> 8)
 #endif
@@ -86,13 +87,10 @@ void warn_slowpath_fmt(const char *file, const int line, unsigned taint,
 	warn_slowpath_fmt(__FILE__, __LINE__, taint, arg)
 #else
 extern __printf(1, 2) void __warn_printk(const char *fmt, ...);
-#define __WARN() do {							\
-		printk(KERN_WARNING CUT_HERE);				\
-		__WARN_FLAGS(BUGFLAG_TAINT(TAINT_WARN));		\
-	} while (0)
+#define __WARN()		__WARN_FLAGS(BUGFLAG_TAINT(TAINT_WARN))
 #define __WARN_printf(taint, arg...) do {				\
 		__warn_printk(arg);					\
-		__WARN_FLAGS(BUGFLAG_TAINT(taint));			\
+		__WARN_FLAGS(BUGFLAG_NO_CUT_HERE | BUGFLAG_TAINT(taint));\
 	} while (0)
 #define WARN_ON_ONCE(condition) ({				\
 	int __ret_warn_on = !!(condition);			\
diff --git a/lib/bug.c b/lib/bug.c
index 1077366f496b..8c98af0bf585 100644
--- a/lib/bug.c
+++ b/lib/bug.c
@@ -181,6 +181,15 @@ enum bug_trap_type report_bug(unsigned long bugaddr, struct pt_regs *regs)
 		}
 	}
 
+	/*
+	 * BUG() and WARN_ON() families don't print a custom debug message
+	 * before triggering the exception handler, so we must add the
+	 * "cut here" line now. WARN() issues its own "cut here" before the
+	 * extra debugging message it writes before triggering the handler.
+	 */
+	if ((bug->flags & BUGFLAG_NO_CUT_HERE) == 0)
+		printk(KERN_DEFAULT CUT_HERE);
+
 	if (warning) {
 		/* this is a WARN_ON rather than BUG/BUG_ON */
 		__warn(file, line, (void *)bugaddr, BUG_GET_TAINT(bug), regs,
@@ -188,8 +197,6 @@ enum bug_trap_type report_bug(unsigned long bugaddr, struct pt_regs *regs)
 		return BUG_TRAP_TYPE_WARN;
 	}
 
-	printk(KERN_DEFAULT CUT_HERE);
-
 	if (file)
 		pr_crit("kernel BUG at %s:%u!\n", file, line);
 	else
-- 
2.17.1


-- 
Kees Cook
