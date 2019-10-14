Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B875EECE58F
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 15:46:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88B04217D9
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 15:46:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JZ0zW2yk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387781AbfJNPqj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 11:46:39 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52323 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729930AbfJNPqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 11:46:36 -0400
Received: by mail-wm1-f68.google.com with SMTP id r19so17796620wmh.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 08:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VzbHotXa2CNe+yOSdOVLXrQNHA0n+J4DgMTdXlIpchk=;
        b=JZ0zW2ykyoUjwTVOOpVM0OAoNndUncqcPcM3iZQM6ogeifeEz5Ud/6+rgPXaf2ClAM
         Aju0uPZ0zRZ7yhzjv6bkbyZOdyY4YZ9wzITr38I6Ep2kqzIHmW2lghUCTTSrO79faAu0
         FgxD8cm+7jGYL5Fvax3e+TvPJ5QAQeXQyV2/2Wisp3nueC1tPXY0djOqPbaueYKxBL0R
         9p0fJ2EKJRybayba0NVlzcMwUwEe7eVt3IEzKIQFk2+uxL7yJPpQ4qWGMzvsuzC0sEdr
         fV8Pjm/CrIrha2kjdoaADiVt+nwaFJb/TEMzvTmasKJgdweqarshhZmJ26o7OrDVJ+Z+
         1vdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VzbHotXa2CNe+yOSdOVLXrQNHA0n+J4DgMTdXlIpchk=;
        b=JVne39P0nS1/4vkawmyDpfpY9R390wYb6hyWIC+NZqhyK1SGif36PMQV0BW7orWeSq
         4dyuZFsn4omqZnf2gRh4CeqMSeZHTyHFLC58q1Q0NkyKya2KfEK4l3thOn7VhDSzCRXR
         SlcZm2AP5+9AOACRKhNAT3KEvAJdYNVczzBHBdZDm2KX2ooinumDjpJgsokODuzQdIPu
         EjCQ0PFyb+d5SmxSlzBDE+fSllLFVb0ilyZDDc/akd8fk6U7hA2bUhjrc66vbaXfv7TW
         qSwwx5U0KpU9s/Lwx7yErdHooelCTBk6e8a7m+pBaIxQ8/jNGDkywtWEQMQh6FMjJgLx
         QNGQ==
X-Gm-Message-State: APjAAAUx5HDw9aqreblTWz5shjrjZ+/QvaWXpaLGb+xKgxAnhy+CfI8A
        gNeuD7qDYnAb8l/mdUxj+slxEA==
X-Google-Smtp-Source: APXvYqxE+dOkNfiWJwLl4yuWYmrcDvkahTPo50r3LUg8jfCJu+reTdEf/UpEq1yy6Sv/6BL65hhf8g==
X-Received: by 2002:a1c:48d6:: with SMTP id v205mr14942664wma.35.1571067993614;
        Mon, 14 Oct 2019 08:46:33 -0700 (PDT)
Received: from wychelm.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id q22sm16539738wmj.5.2019.10.14.08.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 08:46:32 -0700 (PDT)
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Jason Wessel <jason.wessel@windriver.com>,
        Douglas Anderson <dianders@chromium.org>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        patches@linaro.org
Subject: [PATCH v3 3/5] kdb: Remove special case logic from kdb_read()
Date:   Mon, 14 Oct 2019 16:46:24 +0100
Message-Id: <20191014154626.351-4-daniel.thompson@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191014154626.351-1-daniel.thompson@linaro.org>
References: <20191014154626.351-1-daniel.thompson@linaro.org>
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
---
 kernel/debug/kdb/kdb_bt.c      | 22 +++++++----
 kernel/debug/kdb/kdb_io.c      | 67 +++++++++++++++-------------------
 kernel/debug/kdb/kdb_private.h |  1 +
 3 files changed, 45 insertions(+), 45 deletions(-)

diff --git a/kernel/debug/kdb/kdb_bt.c b/kernel/debug/kdb/kdb_bt.c
index 7e2379aa0a1e..b6dc4d7470fd 100644
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
+		ch = kdb_getchar();
+		while (!strchr("\r\n q", ch))
+			ch = kdb_getchar();
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
index 78cb6e339408..39476616295e 100644
--- a/kernel/debug/kdb/kdb_io.c
+++ b/kernel/debug/kdb/kdb_io.c
@@ -50,14 +50,14 @@ static int kgdb_transition_check(char *buffer)
 }
 
 /*
- * kdb_read_handle_escape
+ * kdb_handle_escape
  *
  * Run a validity check on an accumulated escape sequence.
  *
  * Returns -1 if the escape sequence is unwanted, 0 if it is incomplete,
  * otherwise it returns a mapped key value to pass to the upper layers.
  */
-static int kdb_read_handle_escape(char *buf, size_t sz)
+static int kdb_handle_escape(char *buf, size_t sz)
 {
 	char *lastkey = buf + sz - 1;
 
@@ -106,7 +106,22 @@ static int kdb_read_handle_escape(char *buf, size_t sz)
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
@@ -124,7 +139,6 @@ static int kdb_read_get_key(char *buffer, size_t bufsize)
 		}
 
 		key = (*f)();
-
 		if (key == -1) {
 			if (escape_delay) {
 				udelay(ESCAPE_UDELAY);
@@ -134,14 +148,6 @@ static int kdb_read_get_key(char *buffer, size_t bufsize)
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
@@ -152,7 +158,7 @@ static int kdb_read_get_key(char *buffer, size_t bufsize)
 				return '\e';
 
 			*ped++ = key;
-			key = kdb_read_handle_escape(escape_data,
+			key = kdb_handle_escape(escape_data,
 						     ped - escape_data);
 			if (key < 0)
 				return '\e';
@@ -183,17 +189,7 @@ static int kdb_read_get_key(char *buffer, size_t bufsize)
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
@@ -228,9 +224,7 @@ static char *kdb_read(char *buffer, size_t bufsize)
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
@@ -741,7 +735,7 @@ int vkdb_printf(enum kdb_msgsrc src, const char *fmt, va_list ap)
 
 	/* check for having reached the LINES number of printed lines */
 	if (kdb_nextline >= linecount) {
-		char buf1[16] = "";
+		char ch;
 
 		/* Watch out for recursion here.  Any routine that calls
 		 * kdb_printf will come back through here.  And kdb_read
@@ -776,39 +770,38 @@ int vkdb_printf(enum kdb_msgsrc src, const char *fmt, va_list ap)
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

