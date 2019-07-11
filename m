Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F92CC74A54
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 14:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3C8F21019
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 14:30:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729161AbfGKOaU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 10:30:20 -0400
Received: from bastet.se.axis.com ([195.60.68.11]:37999 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728930AbfGKOaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 10:30:18 -0400
Received: from localhost (localhost [127.0.0.1])
        by bastet.se.axis.com (Postfix) with ESMTP id BCF151852E;
        Thu, 11 Jul 2019 16:30:14 +0200 (CEST)
X-Axis-User: NO
X-Axis-NonUser: YES
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
        by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id 7h4xgNww2LwS; Thu, 11 Jul 2019 16:30:13 +0200 (CEST)
Received: from boulder02.se.axis.com (boulder02.se.axis.com [10.0.8.16])
        by bastet.se.axis.com (Postfix) with ESMTPS id F071D18524;
        Thu, 11 Jul 2019 16:30:12 +0200 (CEST)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DDC781A0D0;
        Thu, 11 Jul 2019 16:30:12 +0200 (CEST)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D25771A06F;
        Thu, 11 Jul 2019 16:30:12 +0200 (CEST)
Received: from seth.se.axis.com (unknown [10.0.2.172])
        by boulder02.se.axis.com (Postfix) with ESMTP;
        Thu, 11 Jul 2019 16:30:12 +0200 (CEST)
Received: from lnxartpec.se.axis.com (lnxartpec.se.axis.com [10.88.4.9])
        by seth.se.axis.com (Postfix) with ESMTP id C6B15E46;
        Thu, 11 Jul 2019 16:30:12 +0200 (CEST)
Received: by lnxartpec.se.axis.com (Postfix, from userid 10564)
        id B94FF802EC; Thu, 11 Jul 2019 16:30:12 +0200 (CEST)
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     pmladek@suse.com, sergey.senozhatsky@gmail.com, rostedt@goodmis.org
Cc:     linux-kernel@vger.kernel.org, Vincent Whitchurch <rabinv@axis.com>
Subject: [PATCH v2] printk: Do not lose last line in kmsg buffer dump
Date:   Thu, 11 Jul 2019 16:29:37 +0200
Message-Id: <20190711142937.4083-1-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmsg_dump_get_buffer() is supposed to select all the youngest log
messages which fit into the provided buffer.  It determines the correct
start index by using msg_print_text() with a NULL buffer to calculate
the size of each entry.  However, when performing the actual writes,
msg_print_text() only writes the entry to the buffer if the written len
is lesser than the size of the buffer.  So if the lengths of the
selected youngest log messages happen to precisely fill up the provided
buffer, the last log message is not included.

We don't want to modify msg_print_text() to fill up the buffer and start
returning a length which is equal to the size of the buffer, since
callers of its other users, such as kmsg_dump_get_line(), depend upon
the current behaviour.

Instead, fix kmsg_dump_get_buffer() to compensate for this.

For example, with the following two final prints:

[    6.427502] AAAAAAAAAAAAA
[    6.427769] BBBBBBBB12345

A dump of a 64-byte buffer filled by kmsg_dump_get_buffer(), before this
patch:

 00000000: 3c 30 3e 5b 20 20 20 20 36 2e 35 32 32 31 39 37  <0>[    6.522197
 00000010: 5d 20 41 41 41 41 41 41 41 41 41 41 41 41 41 0a  ] AAAAAAAAAAAAA.
 00000020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
 00000030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................

After this patch:

 00000000: 3c 30 3e 5b 20 20 20 20 36 2e 34 35 36 36 37 38  <0>[    6.456678
 00000010: 5d 20 42 42 42 42 42 42 42 42 31 32 33 34 35 0a  ] BBBBBBBB12345.
 00000020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
 00000030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
v2: Move fix to kmsg_dump_get_buffer()

 kernel/printk/printk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 1888f6a3b694..424abf802f02 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3274,7 +3274,7 @@ bool kmsg_dump_get_buffer(struct kmsg_dumper *dumper, bool syslog,
 	/* move first record forward until length fits into the buffer */
 	seq = dumper->cur_seq;
 	idx = dumper->cur_idx;
-	while (l > size && seq < dumper->next_seq) {
+	while (l >= size && seq < dumper->next_seq) {
 		struct printk_log *msg = log_from_idx(idx);
 
 		l -= msg_print_text(msg, true, time, NULL, 0);
-- 
2.20.0

