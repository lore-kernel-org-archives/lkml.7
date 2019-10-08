Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C258C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 13:21:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF018206C0
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 13:21:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xri8FTar"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731055AbfJHNVI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 09:21:08 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41326 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730927AbfJHNVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 09:21:06 -0400
Received: by mail-wr1-f66.google.com with SMTP id q9so19398133wrm.8
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 06:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NMLYLlRd8vaGiF3jciw9wbZQHk5ZOlFvcl94Sy7qkg4=;
        b=Xri8FTarDkqF/+gVzxi8Z1C8t3l+cY/LBwvDd8AM/lD01TIBPh2Ax8Ye7jrUK5VjUD
         gJC5tdWhaPPdZCcLfRW4CZjYLAnT17YFEKMw87Q7uUF1i+q1YxE4v/dYeiTh+QgIoNYx
         FtHyVPPWVXtJH1xRusubfoHJoCZyPBJtES89DoUpdmyV4NlUqRPmurRCMPfoivfs3UhZ
         GmzFrQZbbXuODOak2XTTxp4GSNJl+ua5nuNUN8sIKKpQvj1XCnArikM/DyMzeVeLej6R
         J37LpQfeb276fZwkABKDadNJslLGV9TQA3JlBV4xAPaiIRfLytvGobHmf9dMgWBbiIyj
         WW4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NMLYLlRd8vaGiF3jciw9wbZQHk5ZOlFvcl94Sy7qkg4=;
        b=tCLH1wTVFnAUrBzVmjssHFgYKePGqNaox3eAyE4RzkNNrlPw4/eEvYEz66QEvbKshv
         QnIIpiWPawL3g0l0qx7EKcXcncVm0Jjk11UkLmWoCHN+fWrXHnCxZOqgHp66yvsDOtxh
         0fBgwvP4kCOgAM2w6zAHHVLYk6x2A1gMsrT8T4qgfIe63fl6MwJuGXfLPkOTbpmuWoPZ
         b2OfzL7Z/0BBHS8NQ8ceyvtQ0Vh46adtvK90gvS4GM7tqeez8uKrInZHgoLnRCR4zY1V
         UCIyvhnyI8CAhClEYOl/VtLpjlebs9qGpVhwFk+FrcOvUrDTdGXgxFQcTeUkqQZlRwR6
         a1FA==
X-Gm-Message-State: APjAAAWr3Gv6n6VuZvPaXFSqs5oAMPQ+mPhcAVxaHMgUF1F7ImN4XDUl
        BdZNGQxcDbLECdzdoYuSAngd6kPCpxEJoA==
X-Google-Smtp-Source: APXvYqwg7jDYE8hDC+1bJHrrQK5xqAb2IY7xmf6UM3OWEdgwCAq2KjDkHpqihKJYblsyf4uaAwuHvw==
X-Received: by 2002:adf:bb0a:: with SMTP id r10mr28074897wrg.13.1570540862771;
        Tue, 08 Oct 2019 06:21:02 -0700 (PDT)
Received: from wychelm.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id t8sm18237214wrx.76.2019.10.08.06.21.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2019 06:21:01 -0700 (PDT)
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Jason Wessel <jason.wessel@windriver.com>,
        Douglas Anderson <dianders@chromium.org>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        patches@linaro.org
Subject: [PATCH v2 3/5] kdb: Remove special case logic from kdb_read()
Date:   Tue,  8 Oct 2019 14:20:41 +0100
Message-Id: <20191008132043.7966-4-daniel.thompson@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191008132043.7966-1-daniel.thompson@linaro.org>
References: <20191008132043.7966-1-daniel.thompson@linaro.org>
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

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 kernel/debug/kdb/kdb_io.c | 56 ++++++++++++++++-----------------------
 1 file changed, 23 insertions(+), 33 deletions(-)

diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
index 78cb6e339408..a9e73bc9d1c3 100644
--- a/kernel/debug/kdb/kdb_io.c
+++ b/kernel/debug/kdb/kdb_io.c
@@ -106,7 +106,19 @@ static int kdb_read_handle_escape(char *buf, size_t sz)
 	return -1;
 }
 
-static int kdb_read_get_key(char *buffer, size_t bufsize)
+/*
+ * kdb_getchar
+ *
+ * Read a single character from kdb console (or consoles).
+ *
+ * An escape key could be the start of a vt100 control sequence such as \e[D
+ * (left arrow) or it could be a character in its own right.  The standard
+ * method for detecting the difference is to wait for 2 seconds to see if there
+ * are any other characters.  kdb is complicated by the lack of a timer service
+ * (interrupts are off), by multiple input sources. Escape sequence processing
+ * has to be done as states in the polling loop.
+ */
+static int kdb_getchar(void)
 {
 #define ESCAPE_UDELAY 1000
 #define ESCAPE_DELAY (2*1000000/ESCAPE_UDELAY) /* 2 seconds worth of udelays */
@@ -124,7 +136,6 @@ static int kdb_read_get_key(char *buffer, size_t bufsize)
 		}
 
 		key = (*f)();
-
 		if (key == -1) {
 			if (escape_delay) {
 				udelay(ESCAPE_UDELAY);
@@ -134,14 +145,6 @@ static int kdb_read_get_key(char *buffer, size_t bufsize)
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
@@ -183,17 +186,7 @@ static int kdb_read_get_key(char *buffer, size_t bufsize)
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
@@ -228,9 +221,7 @@ static char *kdb_read(char *buffer, size_t bufsize)
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
@@ -741,7 +732,7 @@ int vkdb_printf(enum kdb_msgsrc src, const char *fmt, va_list ap)
 
 	/* check for having reached the LINES number of printed lines */
 	if (kdb_nextline >= linecount) {
-		char buf1[16] = "";
+		char ch;
 
 		/* Watch out for recursion here.  Any routine that calls
 		 * kdb_printf will come back through here.  And kdb_read
@@ -776,39 +767,38 @@ int vkdb_printf(enum kdb_msgsrc src, const char *fmt, va_list ap)
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
+		} else if (ch && ch != '\n') {
 			/* user hit something other than enter */
 			suspend_grep = 1; /* for this recursion */
-			if (buf1[0] != '/')
+			if (ch != '/')
 				kdb_printf(
 				    "\nOnly 'q', 'Q' or '/' are processed at "
 				    "more prompt, input ignored\n");
-- 
2.21.0

