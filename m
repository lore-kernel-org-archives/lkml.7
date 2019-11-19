Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BA3DC432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 17:09:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CCA7222AB
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 17:09:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=origamienergy.com header.i=@origamienergy.com header.b="M61AIJnP";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="IyRtKwj5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728626AbfKSRI7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 12:08:59 -0500
Received: from a6-17.smtp-out.eu-west-1.amazonses.com ([54.240.6.17]:42498
        "EHLO a6-17.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728589AbfKSRI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 12:08:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=awgt3ic55kqhwizgro5hhdlz56bi7lbf; d=origamienergy.com;
        t=1574183334;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
        bh=SU8jScwCz+kC3GRGS/B/NU0X+iFMYaeQW0wTHwg9iFg=;
        b=M61AIJnPXgSeo7nTFKcq+BjfrKcfVHG4gYPUJxcamfjiRVKn4yQdNXPuGsmpHqrD
        cRxcgxz4ecERbAOeCh9HoWY8aHXFSqgeKG9SVQ0XYXyk53cX0Rj8u9Oe9OkyDqk2vGh
        lT5+lj0H1fxcJDqpZGtJ58/X2h2YblmypmKyDHgE=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1574183334;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID;
        bh=SU8jScwCz+kC3GRGS/B/NU0X+iFMYaeQW0wTHwg9iFg=;
        b=IyRtKwj5MfeKe09811kXyohcZkg2WnBTTVZgZwjBtPUuM6XaAx52uoiG7QWQkeYu
        jJrPlTVR+21xTBMoE3hxbM+ApQI398pylzmzUI9jkgib4LjbkxtGROnvCLQaO1WsExq
        Hb88iW3hKhtLeNqgvcmb8ZPujIC8tn62wLgrFheY=
From:   James Byrne <james.byrne@origamienergy.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     James Byrne <james.byrne@origamienergy.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH 2/2] printk: Support message continuation from /dev/kmsg
Date:   Tue, 19 Nov 2019 17:08:54 +0000
Message-ID: <0102016e84a372dc-8c0ca643-ba2c-423a-b96e-6b68b4f010a4-000000@eu-west-1.amazonses.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191119170632.52119-1-james.byrne@origamienergy.com>
References: <20191119170632.52119-1-james.byrne@origamienergy.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SES-Outgoing: 2019.11.19-54.240.6.17
Feedback-ID: 1.eu-west-1.sQ65CuNSNkrvjFrT7j7oeWmhxZgivYoP5c3BHSC7Qc8=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 4bcc595ccd80 ("printk: reinstate KERN_CONT for printing
continuation lines") the behaviour of messages written into /dev/kmsg
from user space has changed. Previously if you wrote a message that
did not end with a newline, followed by one ending with a newline, the
second message was treated as a continuation of the first. This is no
longer the case since for a message to be treated as a continuation, an
explicit KERN_CONT is required at the start, and this cannot be used in
messages written via /dev/kmsg.

This commit allows bit 11 of the facility/level number to be used to set
the continuation flag, so you can write two messages that you want to be
joined into /dev/kmsg like this:

<13>This is a continu
<2061>ation message.\n

Signed-off-by: James Byrne <james.byrne@origamienergy.com>
---

 Documentation/ABI/testing/dev-kmsg | 6 +++++-
 kernel/printk/printk.c             | 6 ++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/dev-kmsg b/Documentation/ABI/testing/dev-kmsg
index 6326deeaf5e3..793cf22595fe 100644
--- a/Documentation/ABI/testing/dev-kmsg
+++ b/Documentation/ABI/testing/dev-kmsg
@@ -12,7 +12,8 @@ Description:	The /dev/kmsg character device node provides userspace access
 		The logged line can be prefixed with a <N> syslog prefix, which
 		carries the syslog priority and facility. The single decimal
 		prefix number is composed of the 3 lowest bits being the syslog
-		priority and the next 8 bits the syslog facility number.
+		priority, the next 8 bits the syslog facility number and the
+		next bit a continuation flag.
 
 		If no prefix is given, the priority number is the default kernel
 		log priority and the facility number is set to LOG_USER (1). It
@@ -20,6 +21,9 @@ Description:	The /dev/kmsg character device node provides userspace access
 		facility number LOG_KERN (0), to make sure that the origin of
 		the messages can always be reliably determined.
 
+		Setting bit 11 of the prefix number, the continuation flag, is
+		equivalent to prefixing a kernel printk message with KERN_CONT.
+
 		Accessing the buffer:
 		Every read() from the opened device node receives one record
 		of the kernel's printk buffer.
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index a3db7f5e56d9..d04353076e92 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -451,6 +451,7 @@ static u32 clear_idx;
 
 #define LOG_LEVEL(v)		((v) & 0x07)
 #define LOG_FACILITY(v)		((v) >> 3 & 0xff)
+#define LOG_CONT_USER(v)	((v) & 0x800)
 
 /* record buffer */
 #define LOG_ALIGN __alignof__(struct printk_log)
@@ -869,6 +870,8 @@ static ssize_t devkmsg_write(struct kiocb *iocb, struct iov_iter *from)
 			level = LOG_LEVEL(u);
 			if (LOG_FACILITY(u) != 0)
 				facility = LOG_FACILITY(u);
+			if (LOG_CONT_USER(u) != 0)
+				facility |= 0x100;
 			endp++;
 			len -= endp - line;
 			line = endp;
@@ -1954,6 +1957,9 @@ int vprintk_store(int facility, int level,
 			text_len -= 2;
 			text += 2;
 		}
+	} else if (facility & 0x100) {
+		lflags |= LOG_CONT;
+		facility &= 0xff;
 	}
 
 	if (level == LOGLEVEL_DEFAULT)
-- 
2.24.0

