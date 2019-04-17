Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98E35C10F12
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 10:50:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 347BE20821
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 10:50:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CNr9KoEK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731829AbfDQKuR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 06:50:17 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34770 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729578AbfDQKuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 06:50:17 -0400
Received: by mail-pg1-f195.google.com with SMTP id v12so11851587pgq.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 03:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lDppYI0uJno8kLm4JBf8SUD//G6mzBBRR4Ij7D52BPQ=;
        b=CNr9KoEK/diOz458onlRR+DbXZJN9l/6gSba9FhSH605HVZ/lkLxyQcWsVP9hjan0c
         LZkHECGX2fnz9bPJe9XCr78mim4vIIKzc1YbqdPr0N8yw9r3gZkHWmQ6po5wr5mHQQu/
         A1tdMk6KtiEyKMt8HkA3Hc3TWeb2y6IYRv9J/bYVNnjhSGWjc4rbinWPiS9wly5ZzgbT
         kPppZo0lFPnlGquQCidh4NWltydvRpfm34gatjmu3tTWJVL4KnTJv7/W/ZWaY06Kla6q
         XdfnBW0vfE//rdepURXXC/yRI624k3yhnr0ntuKLbTDeCia/g2RyStAj3yZU+ij4T493
         Awqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lDppYI0uJno8kLm4JBf8SUD//G6mzBBRR4Ij7D52BPQ=;
        b=l8kCdGKbydVww7khB7OnmiL2qv3CkFfr0A6mT+sdkyWJFVnPMNMydHgPnJLaVYhpVm
         J1p64BI+Nc2sYPESBwnYqLfUjfynflxB8XvoOUSoqotdQ90eMInxOtOSHd5kf10tsWxC
         5sFJ6UJ0yx9/gfnLrkchCTB9vqxOwUBeW3wsM29LX6BXdrSb9p5t0sKnmpJ6ku0g69SI
         o2rNaeS27AUSuqILaoocsCw0csVDj+YI1zDdCHXaZuQWpCFxwiSmGFC4DVN5zyBGfX9s
         lZDghpnT3l83VrH5xtQGS5YFLr0WtNr94QlKdoaeEjnV+2SP9maen6FnbYKMbfRppAZa
         rK2Q==
X-Gm-Message-State: APjAAAXXYnyblkCBqiTIx3eCAr4t0zsPHYrLcKxU7JfHAWF9BpL8q5am
        UZpvOJeIBaZXqu9Mwb6gXrk=
X-Google-Smtp-Source: APXvYqxvtaIFetGHOyzFgAmgAUje+GuYrtlRkAiFsxEDREJt/cxllPoP8OP0Qa7Zx+zUDqo8E2m4aw==
X-Received: by 2002:a62:59cb:: with SMTP id k72mr89642693pfj.111.1555498215376;
        Wed, 17 Apr 2019 03:50:15 -0700 (PDT)
Received: from localhost ([110.70.26.221])
        by smtp.gmail.com with ESMTPSA id v9sm5619575pgf.73.2019.04.17.03.50.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Apr 2019 03:50:14 -0700 (PDT)
Date:   Wed, 17 Apr 2019 19:50:10 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Petr Mladek <pmladek@suse.com>, Feng Tang <feng.tang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Borislav Petkov <bp@suse.de>, ying.huang@intel.com,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [PATCH v2] panic: add an option to replay all the printk message
 in buffer
Message-ID: <20190417105010.GA8492@jagdpanzerIV>
References: <20190410153718.22905-1-feng.tang@intel.com>
 <20190416211922.d3c9c6987f0b992da343be52@linux-foundation.org>
 <20190417064844.ppyqxcx2mgek5455@shbuild888>
 <20190417091832.z252cvcf4ktxeamv@pathway.suse.cz>
 <20190417094614.GB4260@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190417094614.GB4260@jagdpanzerIV>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (04/17/19 18:46), Sergey Senozhatsky wrote:
> 
> Does not look too complex/ugly.

Looks simpler than adding one more global state to the
console_unlock() printing loop.

// Not tested at all //

---

diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 1fd45a8650e1..0fb785ed5ec6 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -179,7 +179,7 @@ extern void panic_flush_kmsg_end(void)
 	kmsg_dump(KMSG_DUMP_PANIC);
 	bust_spinlocks(0);
 	debug_locks_off();
-	console_flush_on_panic();
+	console_flush_on_panic(CONSOLE_FLUSH_PENDING);
 }
 
 static unsigned long oops_begin(struct pt_regs *regs)
diff --git a/include/linux/console.h b/include/linux/console.h
index ec9bdb3d7bab..9e306eb4398a 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -175,7 +175,13 @@ extern int console_trylock(void);
 extern void console_unlock(void);
 extern void console_conditional_schedule(void);
 extern void console_unblank(void);
-extern void console_flush_on_panic(void);
+
+enum console_flush_mode {
+	CONSOLE_FLUSH_PENDING,
+	CONSOLE_FLUSH_ALL,
+};
+
+extern void console_flush_on_panic(enum console_flush_mode flush_mode);
 extern struct tty_driver *console_device(int *);
 extern void console_stop(struct console *);
 extern void console_start(struct console *);
diff --git a/kernel/panic.c b/kernel/panic.c
index cd73af35ec66..50eacfc9bc7e 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -51,6 +51,7 @@ EXPORT_SYMBOL_GPL(panic_timeout);
 #define PANIC_PRINT_TIMER_INFO		0x00000004
 #define PANIC_PRINT_LOCK_INFO		0x00000008
 #define PANIC_PRINT_FTRACE_INFO		0x00000010
+#define PANIC_PRINT_ALL_PRINTK_MSG	0x00000020
 unsigned long panic_print;
 
 ATOMIC_NOTIFIER_HEAD(panic_notifier_list);
@@ -148,6 +149,9 @@ static void panic_print_sys_info(void)
 
 	if (panic_print & PANIC_PRINT_FTRACE_INFO)
 		ftrace_dump(DUMP_ALL);
+
+	if (panic_print & PANIC_PRINT_ALL_PRINTK_MSG)
+		console_flush_on_panic(CONSOLE_FLUSH_ALL);
 }
 
 /**
@@ -277,7 +281,7 @@ void panic(const char *fmt, ...)
 	 * panic() is not being callled from OOPS.
 	 */
 	debug_locks_off();
-	console_flush_on_panic();
+	console_flush_on_panic(CONSOLE_FLUSH_PENDING);
 
 	panic_print_sys_info();
 
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 17102fd4c136..da60a185dbbb 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2538,7 +2538,7 @@ void console_unblank(void)
  *
  * Immediately output all pending messages no matter what.
  */
-void console_flush_on_panic(void)
+void console_flush_on_panic(enum console_flush_mode flush_mode)
 {
 	/*
 	 * If someone else is holding the console lock, trylock will fail
@@ -2549,6 +2549,14 @@ void console_flush_on_panic(void)
 	 */
 	console_trylock();
 	console_may_schedule = 0;
+	if (flush_mode == CONSOLE_FLUSH_ALL) {
+		/*
+		 * Can be done under logbuf lock, but it's unlikely that
+		 * we will have any race conditions here.
+		 */
+		console_seq = log_first_seq;
+		console_idx = log_first_idx;
+	}
 	console_unlock();
 }
 
---
