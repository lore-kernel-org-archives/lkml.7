Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE1C6C3A59E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 11:18:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A04E216C8
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 11:18:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=origamienergy.com header.i=@origamienergy.com header.b="Gu4NSEju";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="VuRtX7nH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731514AbfIBLST (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 07:18:19 -0400
Received: from a6-42.smtp-out.eu-west-1.amazonses.com ([54.240.6.42]:46632
        "EHLO a6-42.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730532AbfIBLST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 07:18:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=awgt3ic55kqhwizgro5hhdlz56bi7lbf; d=origamienergy.com;
        t=1567423096; h=From:To:Cc:Subject:Date:Message-Id;
        bh=yf4UDlhY9zG8j1i5sWup6Xc7wzTyoPqlV6dPYa9fU20=;
        b=Gu4NSEjueZq/jkm/u1EajqrO/I0Uu/xHunt6LZmZ5Dji1Hk6/g0l8EFpi14DJGll
        i/RCqnQhQrIwpNP09VkXXzCo86wK6egJZbF7m9xaKf9iW312kNO2wxQjhzJcHXPwPlh
        RwUeZy3k173Hxr8eS+VRTc9LxtrmLuSZiCryMu0c=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1567423096;
        h=From:To:Cc:Subject:Date:Message-Id:Feedback-ID;
        bh=yf4UDlhY9zG8j1i5sWup6Xc7wzTyoPqlV6dPYa9fU20=;
        b=VuRtX7nH/RqA//4vZuYNPkB3nnZLEu93IVHLxge6OE/AqfbYJSXCc2Lt4g6BjKBT
        TMwihe3uWDUEA4oaOkpxIj6NBW+j70mCeL6K5RImQnCx1ex0AmAJIuxrDYN6j+9l1P1
        Q3ISxsmIQaK30XIk5Wffv/1TGOxBK7YqKNLC8sys=
From:   James Byrne <james.byrne@origamienergy.com>
To:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        James Byrne <james.byrne@origamienergy.com>
Subject: [PATCH] ABI: Update dev-kmsg documentation to match current kernel behaviour
Date:   Mon, 2 Sep 2019 11:18:16 +0000
Message-ID: <0102016cf1b26630-8e9b337b-da49-43c6-b028-4250c2fac3ef-000000@eu-west-1.amazonses.com>
X-Mailer: git-send-email 2.17.1
X-SES-Outgoing: 2019.09.02-54.240.6.42
Feedback-ID: 1.eu-west-1.sQ65CuNSNkrvjFrT7j7oeWmhxZgivYoP5c3BHSC7Qc8=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 5aa068ea4082 ("printk: remove games with previous record flags")
abolished the practice of setting the log flag to 'c' for the first
continuation line and '+' for subsequent lines. Now all continuation
lines are flagged with 'c' and '+' is never used.

Update the 'dev-kmsg' documentation to remove the reference to the
obsolete '+' flag. In addition, state explicitly that only 8 bits of the
<N> syslog prefix are used for the facility number when writing to
/dev/kmsg.

Signed-off-by: James Byrne <james.byrne@origamienergy.com>
---
 Documentation/ABI/testing/dev-kmsg | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/Documentation/ABI/testing/dev-kmsg b/Documentation/ABI/testing/dev-kmsg
index fff817efa508..f307506eb54c 100644
--- a/Documentation/ABI/testing/dev-kmsg
+++ b/Documentation/ABI/testing/dev-kmsg
@@ -12,7 +12,7 @@ Description:	The /dev/kmsg character device node provides userspace access
 		The logged line can be prefixed with a <N> syslog prefix, which
 		carries the syslog priority and facility. The single decimal
 		prefix number is composed of the 3 lowest bits being the syslog
-		priority and the higher bits the syslog facility number.
+		priority and the next 8 bits the syslog facility number.
 
 		If no prefix is given, the priority number is the default kernel
 		log priority and the facility number is set to LOG_USER (1). It
@@ -90,13 +90,12 @@ Description:	The /dev/kmsg character device node provides userspace access
 		  +sound:card0 - subsystem:devname
 
 		The flags field carries '-' by default. A 'c' indicates a
-		fragment of a line. All following fragments are flagged with
-		'+'. Note, that these hints about continuation lines are not
-		necessarily correct, and the stream could be interleaved with
-		unrelated messages, but merging the lines in the output
-		usually produces better human readable results. A similar
-		logic is used internally when messages are printed to the
-		console, /proc/kmsg or the syslog() syscall.
+		fragment of a line. Note, that these hints about continuation
+		lines are not necessarily correct, and the stream could be
+		interleaved with unrelated messages, but merging the lines in
+		the output usually produces better human readable results. A
+		similar logic is used internally when messages are printed to
+		the console, /proc/kmsg or the syslog() syscall.
 
 		By default, kernel tries to avoid fragments by concatenating
 		when it can and fragments are rare; however, when extended
-- 
2.17.1

