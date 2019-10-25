Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAF31CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 07:33:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C53921D71
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 07:33:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wTszrqKW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406921AbfJYHdu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 03:33:50 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39475 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394309AbfJYHdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 03:33:47 -0400
Received: by mail-wm1-f65.google.com with SMTP id r141so904026wme.4
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 00:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HkL33ZCV1mwKrZNMBrW/BScRmTTWu1ZVGldNocshZY4=;
        b=wTszrqKWv+gNXBfniMy1FiAztN7YCmh7vDjZqdoxpIOFlLqeGluOHlfbzgddFxUzEY
         B9fRk06+mdvGqQU2oHc2mGxcZQ47gdLNRXb5yhNDDBNviXIjlG/X17F0hpWt2sTnK4Wq
         vzvWARAEOiyKoX+RiSVtyUePPoKtOL2cyS/Zrno0AdPhBwE3kVG+d4vlrr81n6ygvYDV
         EyVioP88omrz607h9AAE5+DqdCMR9ULnYDhoGxqV5GENf+WC9XoZ0DbKzFDQClcqQMdA
         ROpdcqIBcbMd1vsYt+7/lJIO4jDcJCpPjMDDAr3SSlJ9MlK4v48adsMsQKaJ1wfvguNt
         h3Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HkL33ZCV1mwKrZNMBrW/BScRmTTWu1ZVGldNocshZY4=;
        b=jp9c4CR8Wb5+Ay6GNZImgXyG5eFoBoZ5suAuNN2uuwoOdBPmPss9bmtuMbxE2jdjw9
         lgrjHE9XRIEkkkLECxNprR67VzVRaYxh/T1y9Zivt8rXd6jojleJJKbmolPIEItlG3Vo
         ywFznT/Q1O8mGkiu7ZgY1B8CrAq6bVjQTb+UWPjP10G3xJslkQz88KZcAc9SYSZfPNsU
         yZf4biqTLQtZvYiPIi6nlOjNBwNJ0adgB3YmBYnRrxDmu9TQObYxlNjyajL+s4cwhjyp
         WCigdDPQ2RNKQGyf5xPzLv2k0ODapixLkPCfOexPjGLO5jp42dT4BbUVamhOuh9id6eV
         JgqA==
X-Gm-Message-State: APjAAAUY0eE/8n6zG69zrZ0E/yzWsLCrQZmI8TcTmCrIU8+baQoSNQBH
        MIro+3xnndGEf1Y14hJDuNQ0DA==
X-Google-Smtp-Source: APXvYqzQxgiLXS8gY18v0RCvqJDLb12Q1/CRObgkbL362pcH8m+Npf1+Al+yGV7+h05MQImtvA/Vfg==
X-Received: by 2002:a1c:41c1:: with SMTP id o184mr2005976wma.57.1571988825822;
        Fri, 25 Oct 2019 00:33:45 -0700 (PDT)
Received: from wychelm.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id a11sm1586602wmh.40.2019.10.25.00.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 00:33:45 -0700 (PDT)
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Douglas Anderson <dianders@chromium.org>,
        Jason Wessel <jason.wessel@windriver.com>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        patches@linaro.org
Subject: [PATCH v4 3/5] kdb: Remove special case logic from kdb_read()
Date:   Fri, 25 Oct 2019 08:33:26 +0100
Message-Id: <20191025073328.643-4-daniel.thompson@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191025073328.643-1-daniel.thompson@linaro.org>
References: <20191025073328.643-1-daniel.thompson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kdb_read() contains special case logic to force it exit after reading
a single character. We can remove all the special case logic by directly
calling the function to read a single character instead. This also
allows us to tidy up the function prototype which, because it now matches
getchar(), we can also rename in order to make its role clearer.

This does involve some extra code to handle btaprompt properly but we
don't mind the new lines of code here because the old code had some
interesting problems (bad newline handling, treating unexpected
characters like <cr>).

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---
 kernel/debug/kdb/kdb_bt.c      | 22 +++++++-----
 kernel/debug/kdb/kdb_io.c      | 61 +++++++++++++++-------------------
 kernel/debug/kdb/kdb_private.h |  1 +
 3 files changed, 42 insertions(+), 42 deletions(-)

diff --git a/kernel/debug/kdb/kdb_bt.c b/kernel/debug/kdb/kdb_bt.c
index 7e2379aa0a1e..900187bd666a 100644
--- a/kernel/debug/kdb/kdb_bt.c
+++ b/kernel/debug/kdb/kdb_bt.c
@@ -81,9 +81,10 @@ static int
 kdb_bt1(struct task_struct *p, unsigned long mask,
 	int argcount, int btaprompt)
 {
-	char buffer[2];
-	if (kdb_getarea(buffer[0], (unsigned long)p) ||
-	    kdb_getarea(buffer[0], (unsigned long)(p+1)-1))
+	char ch;
+
+	if (kdb_getarea(ch, (unsigned long)p) ||
+	    kdb_getarea(ch, (unsigned long)(p+1)-1))
 		return KDB_BADADDR;
 	if (!kdb_task_state(p, mask))
 		return 0;
@@ -91,12 +92,17 @@ kdb_bt1(struct task_struct *p, unsigned long mask,
 	kdb_ps1(p);
 	kdb_show_stack(p, NULL);
 	if (btaprompt) {
-		kdb_getstr(buffer, sizeof(buffer),
-			   "Enter <q> to end, <cr> to continue:");
-		if (buffer[0] == 'q') {
-			kdb_printf("\n");
+		kdb_printf("Enter <q> to end, <cr> or <space> to continue:");
+		do {
+			ch = kdb_getchar();
+		} while (!strchr("\r\n q", ch));
+		kdb_printf("\n");
+
+		/* reset the pager */
+		kdb_nextline = 1;
+
+		if (ch == 'q')
 			return 1;
-		}
 	}
 	touch_nmi_watchdog();
 	return 0;
diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
index a92ceca29637..9b6933d585b5 100644
--- a/kernel/debug/kdb/kdb_io.c
+++ b/kernel/debug/kdb/kdb_io.c
@@ -108,7 +108,22 @@ static int kdb_handle_escape(char *buf, size_t sz)
 	return -1;
 }
 
-static int kdb_read_get_key(char *buffer, size_t bufsize)
+/**
+ * kdb_getchar() - Read a single character from a kdb console (or consoles).
+ *
+ * Other than polling the various consoles that are currently enabled,
+ * most of the work done in this function is dealing with escape sequences.
+ *
+ * An escape key could be the start of a vt100 control sequence such as \e[D
+ * (left arrow) or it could be a character in its own right.  The standard
+ * method for detecting the difference is to wait for 2 seconds to see if there
+ * are any other characters.  kdb is complicated by the lack of a timer service
+ * (interrupts are off), by multiple input sources. Escape sequence processing
+ * has to be done as states in the polling loop.
+ *
+ * Return: The key pressed or a control code derived from an escape sequence.
+ */
+char kdb_getchar(void)
 {
 #define ESCAPE_UDELAY 1000
 #define ESCAPE_DELAY (2*1000000/ESCAPE_UDELAY) /* 2 seconds worth of udelays */
@@ -126,7 +141,6 @@ static int kdb_read_get_key(char *buffer, size_t bufsize)
 		}
 
 		key = (*f)();
-
 		if (key == -1) {
 			if (escape_delay) {
 				udelay(ESCAPE_UDELAY);
@@ -136,14 +150,6 @@ static int kdb_read_get_key(char *buffer, size_t bufsize)
 			continue;
 		}
 
-		if (bufsize <= 2) {
-			if (key == '\r')
-				key = '\n';
-			*buffer++ = key;
-			*buffer = '\0';
-			return -1;
-		}
-
 		if (escape_delay == 0 && key == '\e') {
 			escape_delay = ESCAPE_DELAY;
 			ped = escape_data;
@@ -184,17 +190,7 @@ static int kdb_read_get_key(char *buffer, size_t bufsize)
  *	function.  It is not reentrant - it relies on the fact
  *	that while kdb is running on only one "master debug" cpu.
  * Remarks:
- *
- * The buffer size must be >= 2.  A buffer size of 2 means that the caller only
- * wants a single key.
- *
- * An escape key could be the start of a vt100 control sequence such as \e[D
- * (left arrow) or it could be a character in its own right.  The standard
- * method for detecting the difference is to wait for 2 seconds to see if there
- * are any other characters.  kdb is complicated by the lack of a timer service
- * (interrupts are off), by multiple input sources and by the need to sometimes
- * return after just one key.  Escape sequence processing has to be done as
- * states in the polling loop.
+ *	The buffer size must be >= 2.
  */
 
 static char *kdb_read(char *buffer, size_t bufsize)
@@ -229,9 +225,7 @@ static char *kdb_read(char *buffer, size_t bufsize)
 	*cp = '\0';
 	kdb_printf("%s", buffer);
 poll_again:
-	key = kdb_read_get_key(buffer, bufsize);
-	if (key == -1)
-		return buffer;
+	key = kdb_getchar();
 	if (key != 9)
 		tab = 0;
 	switch (key) {
@@ -742,7 +736,7 @@ int vkdb_printf(enum kdb_msgsrc src, const char *fmt, va_list ap)
 
 	/* check for having reached the LINES number of printed lines */
 	if (kdb_nextline >= linecount) {
-		char buf1[16] = "";
+		char ch;
 
 		/* Watch out for recursion here.  Any routine that calls
 		 * kdb_printf will come back through here.  And kdb_read
@@ -777,39 +771,38 @@ int vkdb_printf(enum kdb_msgsrc src, const char *fmt, va_list ap)
 		if (logging)
 			printk("%s", moreprompt);
 
-		kdb_read(buf1, 2); /* '2' indicates to return
-				    * immediately after getting one key. */
+		ch = kdb_getchar();
 		kdb_nextline = 1;	/* Really set output line 1 */
 
 		/* empty and reset the buffer: */
 		kdb_buffer[0] = '\0';
 		next_avail = kdb_buffer;
 		size_avail = sizeof(kdb_buffer);
-		if ((buf1[0] == 'q') || (buf1[0] == 'Q')) {
+		if ((ch == 'q') || (ch == 'Q')) {
 			/* user hit q or Q */
 			KDB_FLAG_SET(CMD_INTERRUPT); /* command interrupted */
 			KDB_STATE_CLEAR(PAGER);
 			/* end of command output; back to normal mode */
 			kdb_grepping_flag = 0;
 			kdb_printf("\n");
-		} else if (buf1[0] == ' ') {
+		} else if (ch == ' ') {
 			kdb_printf("\r");
 			suspend_grep = 1; /* for this recursion */
-		} else if (buf1[0] == '\n') {
+		} else if (ch == '\n' || ch == '\r') {
 			kdb_nextline = linecount - 1;
 			kdb_printf("\r");
 			suspend_grep = 1; /* for this recursion */
-		} else if (buf1[0] == '/' && !kdb_grepping_flag) {
+		} else if (ch == '/' && !kdb_grepping_flag) {
 			kdb_printf("\r");
 			kdb_getstr(kdb_grep_string, KDB_GREP_STRLEN,
 				   kdbgetenv("SEARCHPROMPT") ?: "search> ");
 			*strchrnul(kdb_grep_string, '\n') = '\0';
 			kdb_grepping_flag += KDB_GREPPING_FLAG_SEARCH;
 			suspend_grep = 1; /* for this recursion */
-		} else if (buf1[0] && buf1[0] != '\n') {
-			/* user hit something other than enter */
+		} else if (ch) {
+			/* user hit something unexpected */
 			suspend_grep = 1; /* for this recursion */
-			if (buf1[0] != '/')
+			if (ch != '/')
 				kdb_printf(
 				    "\nOnly 'q', 'Q' or '/' are processed at "
 				    "more prompt, input ignored\n");
diff --git a/kernel/debug/kdb/kdb_private.h b/kernel/debug/kdb/kdb_private.h
index 2118d8258b7c..55d052061ef9 100644
--- a/kernel/debug/kdb/kdb_private.h
+++ b/kernel/debug/kdb/kdb_private.h
@@ -210,6 +210,7 @@ extern void kdb_ps1(const struct task_struct *p);
 extern void kdb_print_nameval(const char *name, unsigned long val);
 extern void kdb_send_sig(struct task_struct *p, int sig);
 extern void kdb_meminfo_proc_show(void);
+extern char kdb_getchar(void);
 extern char *kdb_getstr(char *, size_t, const char *);
 extern void kdb_gdb_state_pass(char *buf);
 
-- 
2.21.0

