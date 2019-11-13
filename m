Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABA30C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 02:26:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78F152067B
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 02:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573611969;
	bh=Er1C0v6WOPG9MdMVv1ytWpIZtgZTMmVtrfz1ICT1oRc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=G23USAwmQg6CoOSWswCFgKtJ6dfzxP7xtiy0be8GmvYOeIR1UyrhC5jwAhKVDlu71
	 jMCiR6agYyQ7m0bg+948wPF+826G4O1RIXUpLF5kQ35QCqGpOnuFQlemzyEojT+JdI
	 8ohtSf7N0JHeY0iQIwDUNru+nibrT2c7MzH5ThPE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728594AbfKMC0I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 21:26:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:39042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727791AbfKMBvW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 20:51:22 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C941A22473;
        Wed, 13 Nov 2019 01:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573609881;
        bh=Er1C0v6WOPG9MdMVv1ytWpIZtgZTMmVtrfz1ICT1oRc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sJf9y7iLqmM8mlWiz7glVo1iz6ick4u+Aldbgy6vV7JGs8YxLg3z+nGMSFOaSk6GV
         SQyJbpPvde4dVBEUZ/eizgKQmDTLqoxkWTEU5DFXFXQMD9ZL2zUwtpYam8YDbMA5YG
         i4gLG0oqXhDoJ9+/L94F0+7e622o6Zoa/huormV0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 043/209] printk: Do not miss new messages when replaying the log
Date:   Tue, 12 Nov 2019 20:47:39 -0500
Message-Id: <20191113015025.9685-43-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191113015025.9685-1-sashal@kernel.org>
References: <20191113015025.9685-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Petr Mladek <pmladek@suse.com>

[ Upstream commit f92b070f2dc89a8ff1a0cc8b608e20abef894c7d ]

The variable "exclusive_console" is used to reply all existing messages
on a newly registered console. It is cleared when all messages are out.

The problem is that new messages might appear in the meantime. These
are then visible only on the exclusive console.

The obvious solution is to clear "exclusive_console" after we replay
all messages that were already proceed before we started the reply.

Reported-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Link: http://lkml.kernel.org/r/20180913123406.14378-1-pmladek@suse.com
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: linux-kernel@vger.kernel.org
Acked-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Signed-off-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/printk/printk.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index d0d03223b45b1..b627954061bb6 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -423,6 +423,7 @@ static u32 log_next_idx;
 /* the next printk record to write to the console */
 static u64 console_seq;
 static u32 console_idx;
+static u64 exclusive_console_stop_seq;
 
 /* the next printk record to read after the last 'clear' command */
 static u64 clear_seq;
@@ -2014,6 +2015,7 @@ static u64 syslog_seq;
 static u32 syslog_idx;
 static u64 console_seq;
 static u32 console_idx;
+static u64 exclusive_console_stop_seq;
 static u64 log_first_seq;
 static u32 log_first_idx;
 static u64 log_next_seq;
@@ -2381,6 +2383,12 @@ void console_unlock(void)
 			goto skip;
 		}
 
+		/* Output to all consoles once old messages replayed. */
+		if (unlikely(exclusive_console &&
+			     console_seq >= exclusive_console_stop_seq)) {
+			exclusive_console = NULL;
+		}
+
 		len += msg_print_text(msg,
 				console_msg_format & MSG_FORMAT_SYSLOG,
 				text + len,
@@ -2423,10 +2431,6 @@ void console_unlock(void)
 
 	console_locked = 0;
 
-	/* Release the exclusive_console once it is used */
-	if (unlikely(exclusive_console))
-		exclusive_console = NULL;
-
 	raw_spin_unlock(&logbuf_lock);
 
 	up_console_sem();
@@ -2711,6 +2715,7 @@ void register_console(struct console *newcon)
 		 * the already-registered consoles.
 		 */
 		exclusive_console = newcon;
+		exclusive_console_stop_seq = console_seq;
 	}
 	console_unlock();
 	console_sysfs_notify();
-- 
2.20.1

