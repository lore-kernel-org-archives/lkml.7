Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ADCEC3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 17:29:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30B9622CE8
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 17:29:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YjowJ7bq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728133AbfHSR3V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 13:29:21 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38459 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727801AbfHSR3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 13:29:21 -0400
Received: by mail-pf1-f196.google.com with SMTP id o70so1556897pfg.5
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 10:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pJnlN3GB3LCiX8n8Yu41vDyMDj7KwwMgL5n+env2IDs=;
        b=YjowJ7bqBnkG3ACdy3mw+/EopodCPwwQnhh3I+wToU24N+gVvG7CygB/iuXrcZIxAV
         af+fCCmCwgSCffL8K2lcaNLK8qbCpLFPlzYxyNnAvQDVgYTMe8gs4dRnUk5RHl4kf9Wn
         uDUs6MqYbH05O4eJ7jOa2ZnY6c+26JeuyUTvU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pJnlN3GB3LCiX8n8Yu41vDyMDj7KwwMgL5n+env2IDs=;
        b=XgCaPU0D91ndYuHKcnW+sxDS7vC6kAghDk5l+I2g09y3jSlZzBCiGpt2mw2fmMVTpd
         J3dnIr2T7IKdzhx3l2SezOe5rdacY45iegX8SxL3rGDjHOxK2GPX9fhbr73xBVjAr+LP
         5FZS8Wb/1/9cIG6EJ/zV8LCd0p3gfilx5GzzfzSnZjB2LNw3cDoNuQDsXQGe+sEm5Dcs
         eQt0FOHZY8Ewko9sxSSZl8TyMASpZ2cC707ByKuMGgHhvobFk6qTHPbQd4XgKUkSEEE2
         JiD9sW+XzGdgpAo6fSfWizPQObtxd4xAXGssKbI/cPYE3oKlqWGnkS7p+qisQs3jjaQH
         XU/w==
X-Gm-Message-State: APjAAAVzoUoWUa8JXcKNVx4DPnSFnPDYqF1Oq3IcHFPRtzg9PtacjQqC
        /WcZ7uH0hxe9LIqSfK/44w5/cQ==
X-Google-Smtp-Source: APXvYqyfLX6cumQO5rokvmiY8eb0/XCJfsC40kC95OZ/yMJvz1DLeS67pJU3m6lXTsnFXz6dHyqtyg==
X-Received: by 2002:a17:90a:800a:: with SMTP id b10mr21197273pjn.23.1566235760184;
        Mon, 19 Aug 2019 10:29:20 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a1sm21455579pgh.61.2019.08.19.10.29.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Aug 2019 10:29:19 -0700 (PDT)
Date:   Mon, 19 Aug 2019 10:29:18 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        segher@kernel.crashing.org,
        Drew Davenport <ddavenport@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Clean up cut-here even harder (was Re: [PATCH 1/3] powerpc: don't
 use __WARN() for WARN_ON())
Message-ID: <201908191026.831850CDB@keescook>
References: <a6781075192afe0c909ce7d091de7931183a5d93.1566219503.git.christophe.leroy@c-s.fr>
 <201908190917.9C65E23D6A@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201908190917.9C65E23D6A@keescook>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 09:28:03AM -0700, Kees Cook wrote:
> On Mon, Aug 19, 2019 at 01:06:28PM +0000, Christophe Leroy wrote:
> > __WARN() used to just call __WARN_TAINT(TAINT_WARN)
> > 
> > But a call to printk() has been added in the commit identified below
> > to print a "---- cut here ----" line.
> > 
> > This change only applies to warnings using __WARN(), which means
> > WARN_ON() where the condition is constant at compile time.
> > For WARN_ON() with a non constant condition, the additional line is
> > not printed.
> > 
> > In addition, adding a call to printk() forces GCC to add a stack frame
> > and save volatile registers. Powerpc has been using traps to implement
> > warnings in order to avoid that.
> > 
> > So, call __WARN_TAINT(TAINT_WARN) directly instead of using __WARN()
> > in order to restore the previous behaviour.
> > 
> > If one day powerpc wants the decorative "---- cut here ----" line, it
> > has to be done in the trap handler, not in the WARN_ON() macro.
> > 
> > Fixes: 6b15f678fb7d ("include/asm-generic/bug.h: fix "cut here" for WARN_ON for __WARN_TAINT architectures")
> > Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> 
> Ah! Hmpf. Yeah, that wasn't an intended side-effect of this fix.
> 
> It seems PPC is not alone in this situation of making this code much
> noisier. It looks like there needs to be a way to indicate to the trap
> handler that a message was delivered or not. Perhaps we can add another
> taint flag?

I meant "bug flag" here, not taint. Here's a stab at it. This tries to
remove redundant defines, and moves the "cut here" up into the slow path
explicitly (out of _warn()) and creates a flag so the trap handler can
actually detect if things were already reported...

Thoughts?


diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
index aa6c093d9ce9..c2b79878f24c 100644
--- a/include/asm-generic/bug.h
+++ b/include/asm-generic/bug.h
@@ -10,6 +10,7 @@
 #define BUGFLAG_WARNING		(1 << 0)
 #define BUGFLAG_ONCE		(1 << 1)
 #define BUGFLAG_DONE		(1 << 2)
+#define BUGFLAG_PRINTK		(1 << 3)
 #define BUGFLAG_TAINT(taint)	((taint) << 8)
 #define BUG_GET_TAINT(bug)	((bug)->flags >> 8)
 #endif
@@ -62,13 +63,11 @@ struct bug_entry {
 #endif
 
 #ifdef __WARN_FLAGS
-#define __WARN_TAINT(taint)		__WARN_FLAGS(BUGFLAG_TAINT(taint))
-#define __WARN_ONCE_TAINT(taint)	__WARN_FLAGS(BUGFLAG_ONCE|BUGFLAG_TAINT(taint))
-
 #define WARN_ON_ONCE(condition) ({				\
 	int __ret_warn_on = !!(condition);			\
 	if (unlikely(__ret_warn_on))				\
-		__WARN_ONCE_TAINT(TAINT_WARN);			\
+		__WARN_FLAGS(BUGFLAG_ONCE |			\
+			     BUGFLAG_TAINT(TAINT_WARN));	\
 	unlikely(__ret_warn_on);				\
 })
 #endif
@@ -89,7 +88,7 @@ struct bug_entry {
  *
  * Use the versions with printk format strings to provide better diagnostics.
  */
-#ifndef __WARN_TAINT
+#ifndef __WARN_FLAGS
 extern __printf(3, 4)
 void warn_slowpath_fmt(const char *file, const int line,
 		       const char *fmt, ...);
@@ -104,12 +103,12 @@ extern void warn_slowpath_null(const char *file, const int line);
 	warn_slowpath_fmt_taint(__FILE__, __LINE__, taint, arg)
 #else
 extern __printf(1, 2) void __warn_printk(const char *fmt, ...);
-#define __WARN() do { \
-	printk(KERN_WARNING CUT_HERE); __WARN_TAINT(TAINT_WARN); \
-} while (0)
+#define __WARN()		__WARN_FLAGS(BUGFLAG_TAINT(TAINT_WARN))
 #define __WARN_printf(arg...)	__WARN_printf_taint(TAINT_WARN, arg)
-#define __WARN_printf_taint(taint, arg...)				\
-	do { __warn_printk(arg); __WARN_TAINT(taint); } while (0)
+#define __WARN_printf_taint(taint, arg...)	do {			\
+		__warn_printk(arg); __WARN_FLAGS(BUGFLAG_PRINTK |	\
+						 BUGFLAG_TAINT(taint));	\
+	} while (0)
 #endif
 
 /* used internally by panic.c */
diff --git a/kernel/panic.c b/kernel/panic.c
index 057540b6eee9..03c98da6e3f7 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -551,9 +551,6 @@ void __warn(const char *file, int line, void *caller, unsigned taint,
 {
 	disable_trace_on_warning();
 
-	if (args)
-		pr_warn(CUT_HERE);
-
 	if (file)
 		pr_warn("WARNING: CPU: %d PID: %d at %s:%d %pS\n",
 			raw_smp_processor_id(), current->pid, file, line,
@@ -596,6 +593,7 @@ void warn_slowpath_fmt(const char *file, int line, const char *fmt, ...)
 {
 	struct warn_args args;
 
+	pr_warn(CUT_HERE);
 	args.fmt = fmt;
 	va_start(args.args, fmt);
 	__warn(file, line, __builtin_return_address(0), TAINT_WARN, NULL,
@@ -609,6 +607,7 @@ void warn_slowpath_fmt_taint(const char *file, int line,
 {
 	struct warn_args args;
 
+	pr_warn(CUT_HERE);
 	args.fmt = fmt;
 	va_start(args.args, fmt);
 	__warn(file, line, __builtin_return_address(0), taint, NULL, &args);
diff --git a/lib/bug.c b/lib/bug.c
index 1077366f496b..73ce8f9d9eff 100644
--- a/lib/bug.c
+++ b/lib/bug.c
@@ -181,6 +181,10 @@ enum bug_trap_type report_bug(unsigned long bugaddr, struct pt_regs *regs)
 		}
 	}
 
+	/* Did this trap already report a printk line with "cut here"? */
+	if ((bug->flags & BUGFLAG_PRINTK) == 0)
+		printk(KERN_DEFAULT CUT_HERE);
+
 	if (warning) {
 		/* this is a WARN_ON rather than BUG/BUG_ON */
 		__warn(file, line, (void *)bugaddr, BUG_GET_TAINT(bug), regs,
@@ -188,8 +192,6 @@ enum bug_trap_type report_bug(unsigned long bugaddr, struct pt_regs *regs)
 		return BUG_TRAP_TYPE_WARN;
 	}
 
-	printk(KERN_DEFAULT CUT_HERE);
-
 	if (file)
 		pr_crit("kernel BUG at %s:%u!\n", file, line);
 	else


-- 
Kees Cook
