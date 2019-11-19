Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C21DCC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 17:09:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97A4F22362
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 17:09:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=origamienergy.com header.i=@origamienergy.com header.b="CxnE0PGo";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="B6FUyhgv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728606AbfKSRI5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 12:08:57 -0500
Received: from a6-1.smtp-out.eu-west-1.amazonses.com ([54.240.6.1]:44786 "EHLO
        a6-1.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726985AbfKSRIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 12:08:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=awgt3ic55kqhwizgro5hhdlz56bi7lbf; d=origamienergy.com;
        t=1574183333;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
        bh=oQggy2A5pLNP6au2ICTYTrltBjKw3jVSSrNnN429nSc=;
        b=CxnE0PGoIoa4067XbCcDRMrztdxTrliSmc1jNqXAxamgkkeF1oNMXNjIApec/D0k
        qeyYrLKDXll367iRBb1E9+y9Qw2DpIRJaVyb+Ks38yuJXYo9dttlQrdwMFHh4saupLk
        P1Mx7FU0I7R+18QdlF3HQyN+E3vZvYknaYvaQ8gs=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1574183333;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID;
        bh=oQggy2A5pLNP6au2ICTYTrltBjKw3jVSSrNnN429nSc=;
        b=B6FUyhgvbnkmrQBHB63/ianp2fcgLCg9xMZEas+rk4kGjmNnyv1gvEXv38SeJJHR
        1V4+mcZL4Xvdz7lOpKSJ6+rk+yoJgB44a4gNz+xorUTaepf9n1e5utX4/rpSGN4WpQD
        xlNtVx1KlP+66TtX07KymaGl/v8TN7yn+8Jm3zAM=
From:   James Byrne <james.byrne@origamienergy.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     James Byrne <james.byrne@origamienergy.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH 1/2] printk: Make continuation flags from /dev/kmsg useful again
Date:   Tue, 19 Nov 2019 17:08:53 +0000
Message-ID: <0102016e84a36dea-00d03c3c-75ba-4354-ad1f-4380e7cba235-000000@eu-west-1.amazonses.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191119170632.52119-1-james.byrne@origamienergy.com>
References: <20191119170632.52119-1-james.byrne@origamienergy.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SES-Outgoing: 2019.11.19-54.240.6.1
Feedback-ID: 1.eu-west-1.sQ65CuNSNkrvjFrT7j7oeWmhxZgivYoP5c3BHSC7Qc8=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 5aa068ea4082 ("printk: remove games with previous record flags")
abolished the practice of setting the log flag to 'c' for the first
continuation line and '+' for subsequent lines. Since this change all
continuation lines are flagged with 'c' and '+' is never used.

From the point of view of a consumer of /dev/kmsg, the behaviour now
is not very useful because you cannot join lines together based on the
'c' flag since you do not know whether a line starting with 'c' was
actually a continuation of the previous line or not.

This commit changes the flag field emitted in /dev/kmsg to expose the
log buffer flags in a more useful way:

- If LOG_NEWLINE=1 and LOG_CONT=0 the flag will be '-', meaning this is
a single self-contained line.
- If LOG_NEWLINE=0 and LOG_CONT=0 the flag will be 'c', meaning that
this is potentially the start of a sequence of continuation lines.
- If LOG_NEWLINE=0 and LOG_CONT=1 the flag will be '+', meaning that
this is the middle of a sequence of continuation lines.
- If LOG_NEWLINE=1 and LOG_CONT=1 the flag will be '*', meaning that
this is the end of a sequence of continuation lines.

This allows a consumer to concatenate continuations in a straightforward
manner.

Signed-off-by: James Byrne <james.byrne@origamienergy.com>
---

 Documentation/ABI/testing/dev-kmsg | 14 ++++++++------
 kernel/printk/printk.c             | 19 +++++++++++++++++--
 2 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/Documentation/ABI/testing/dev-kmsg b/Documentation/ABI/testing/dev-kmsg
index f307506eb54c..6326deeaf5e3 100644
--- a/Documentation/ABI/testing/dev-kmsg
+++ b/Documentation/ABI/testing/dev-kmsg
@@ -90,12 +90,14 @@ Description:	The /dev/kmsg character device node provides userspace access
 		  +sound:card0 - subsystem:devname
 
 		The flags field carries '-' by default. A 'c' indicates a
-		fragment of a line. Note, that these hints about continuation
-		lines are not necessarily correct, and the stream could be
-		interleaved with unrelated messages, but merging the lines in
-		the output usually produces better human readable results. A
-		similar logic is used internally when messages are printed to
-		the console, /proc/kmsg or the syslog() syscall.
+		fragment of a line. Following fragments are flagged with '+'
+		and the final fragment in a sequence is flagged with '*'. Note
+		that these hints about continuation lines are not necessarily
+		correct, and the stream could be interleaved with unrelated
+		messages, but merging the lines in the output usually produces
+		better human readable results. A similar logic is used
+		internally when messages are printed to the console, /proc/kmsg
+		or the syslog() syscall.
 
 		By default, kernel tries to avoid fragments by concatenating
 		when it can and fragments are rare; however, when extended
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index ca65327a6de8..a3db7f5e56d9 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -715,7 +715,7 @@ static ssize_t msg_print_ext_header(char *buf, size_t size,
 				    struct printk_log *msg, u64 seq)
 {
 	u64 ts_usec = msg->ts_nsec;
-	char caller[20];
+	char flag, caller[20];
 #ifdef CONFIG_PRINTK_CALLER
 	u32 id = msg->caller_id;
 
@@ -727,9 +727,24 @@ static ssize_t msg_print_ext_header(char *buf, size_t size,
 
 	do_div(ts_usec, 1000);
 
+	switch (msg->flags & (LOG_CONT|LOG_NEWLINE)) {
+	case LOG_CONT|LOG_NEWLINE:
+		flag = '*';
+		break;
+	case LOG_CONT:
+		flag = '+';
+		break;
+	case LOG_NEWLINE:
+		flag = '-';
+		break;
+	default:
+		flag = 'c';
+		break;
+	}
+
 	return scnprintf(buf, size, "%u,%llu,%llu,%c%s;",
 			 (msg->facility << 3) | msg->level, seq, ts_usec,
-			 msg->flags & LOG_CONT ? 'c' : '-', caller);
+			 flag, caller);
 }
 
 static ssize_t msg_print_ext_body(char *buf, size_t size,
-- 
2.24.0

