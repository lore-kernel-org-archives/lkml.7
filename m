Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEAABC606B0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 08:11:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDC06216C4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 08:11:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726043AbfGIILC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 04:11:02 -0400
Received: from bastet.se.axis.com ([195.60.68.11]:48295 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbfGIILC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 04:11:02 -0400
Received: from localhost (localhost [127.0.0.1])
        by bastet.se.axis.com (Postfix) with ESMTP id D33D9183C4;
        Tue,  9 Jul 2019 10:10:58 +0200 (CEST)
X-Axis-User: NO
X-Axis-NonUser: YES
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
        by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id dCYuBJE3n5uX; Tue,  9 Jul 2019 10:10:57 +0200 (CEST)
Received: from boulder03.se.axis.com (boulder03.se.axis.com [10.0.8.17])
        by bastet.se.axis.com (Postfix) with ESMTPS id A3C36183A0;
        Tue,  9 Jul 2019 10:10:56 +0200 (CEST)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7EB8A1E080;
        Tue,  9 Jul 2019 10:10:56 +0200 (CEST)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7304D1E05C;
        Tue,  9 Jul 2019 10:10:56 +0200 (CEST)
Received: from thoth.se.axis.com (unknown [10.0.2.173])
        by boulder03.se.axis.com (Postfix) with ESMTP;
        Tue,  9 Jul 2019 10:10:56 +0200 (CEST)
Received: from lnxartpec.se.axis.com (lnxartpec.se.axis.com [10.88.4.9])
        by thoth.se.axis.com (Postfix) with ESMTP id 66F562761;
        Tue,  9 Jul 2019 10:10:56 +0200 (CEST)
Received: by lnxartpec.se.axis.com (Postfix, from userid 10564)
        id 60FE980211; Tue,  9 Jul 2019 10:10:56 +0200 (CEST)
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     pmladek@suse.com, sergey.senozhatsky@gmail.com, rostedt@goodmis.org
Cc:     linux-kernel@vger.kernel.org, Vincent Whitchurch <rabinv@axis.com>
Subject: [PATCH] printk: Do not lose last line in kmsg dump
Date:   Tue,  9 Jul 2019 10:10:42 +0200
Message-Id: <20190709081042.31551-1-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmsg_dump_get_buffer() is supposed to select the youngest log messages
which fit into the provided buffer.  When that function determines the
correct start index, by looping and calling msg_print_text() with a NULL
buffer, msg_print_text() calculates a length which would allow the
youngest log messages to completely fill the provided buffer.

However, when doing the actual printing, an off-by-one error in
msg_print_text() leads to that function allowing the provided buffer to
only be filled to (size - 1).

So if the lengths of the selected youngest log messages happen to
precisely fill up the provided buffer, the last log message is not
included.

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

 00000000: 3c 30 3e 5b 20 20 20 20 36 2e 34 32 37 35 30 32  <0>[    6.427502
 00000010: 5d 20 41 41 41 41 41 41 41 41 41 41 41 41 41 0a  ] AAAAAAAAAAAAA.
 00000020: 3c 30 3e 5b 20 20 20 20 36 2e 34 32 37 37 36 39  <0>[    6.427769
 00000030: 5d 20 42 42 42 42 42 42 42 42 31 32 33 34 35 0a  ] BBBBBBBB12345.

Note that this bug only affects the kmsg dump code.  msg_print_text() is
also used from the syslog code and console_unlock() but this bug does
trigger there since the buffers used there are never filled up
completely (since they are only used to print individual lines, and
their size is always LOG_LINE_MAX + PREFIX_MAX, and PREFIX_MAX has a
value which is larger than the largest possible prefix).

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
I posted this patch two years ago and received no replies.  This problem is
still present in mainline.  https://lore.kernel.org/patchwork/patch/781106/

 kernel/printk/printk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 1888f6a3b694..7679d779d5cc 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1318,7 +1318,7 @@ static size_t msg_print_text(const struct printk_log *msg, bool syslog,
 		}
 
 		if (buf) {
-			if (prefix_len + text_len + 1 >= size - len)
+			if (prefix_len + text_len + 1 > size - len)
 				break;
 
 			memcpy(buf + len, prefix, prefix_len);
-- 
2.20.0

