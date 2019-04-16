Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D08FC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 15:30:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E8FD20868
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 15:30:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729295AbfDPPaz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 11:30:55 -0400
Received: from terminus.zytor.com ([198.137.202.136]:41393 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbfDPPay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 11:30:54 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3GFU8lj3494874
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 16 Apr 2019 08:30:08 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3GFU8rS3494822;
        Tue, 16 Apr 2019 08:30:08 -0700
Date:   Tue, 16 Apr 2019 08:30:08 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Rikard Falkeborn <tipbot@zytor.com>
Message-ID: <tip-f32c2877bcb068a718bb70094cd59ccc29d4d082@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, rostedt@goodmis.org, hpa@zytor.com,
        rikard.falkeborn@gmail.com, mingo@kernel.org, acme@redhat.com,
        tglx@linutronix.de, tstoyanov@vmware.com
Reply-To: tstoyanov@vmware.com, tglx@linutronix.de, acme@redhat.com,
          mingo@kernel.org, rikard.falkeborn@gmail.com, hpa@zytor.com,
          linux-kernel@vger.kernel.org, rostedt@goodmis.org
In-Reply-To: <20190409091529.2686-1-rikard.falkeborn@gmail.com>
References: <20190409091529.2686-1-rikard.falkeborn@gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] tools lib traceevent: Fix missing equality check
 for strcmp
Git-Commit-ID: f32c2877bcb068a718bb70094cd59ccc29d4d082
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  f32c2877bcb068a718bb70094cd59ccc29d4d082
Gitweb:     https://git.kernel.org/tip/f32c2877bcb068a718bb70094cd59ccc29d4d082
Author:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
AuthorDate: Tue, 9 Apr 2019 11:15:29 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 16 Apr 2019 11:27:36 -0300

tools lib traceevent: Fix missing equality check for strcmp

There was a missing comparison with 0 when checking if type is "s64" or
"u64". Therefore, the body of the if-statement was entered if "type" was
"u64" or not "s64", which made the first strcmp() redundant since if
type is "u64", it's not "s64".

If type is "s64", the body of the if-statement is not entered but since
the remainder of the function consists of if-statements which will not
be entered if type is "s64", we will just return "val", which is
correct, albeit at the cost of a few more calls to strcmp(), i.e., it
will behave just as if the if-statement was entered.

If type is neither "s64" or "u64", the body of the if-statement will be
entered incorrectly and "val" returned. This means that any type that is
checked after "s64" and "u64" is handled the same way as "s64" and
"u64", i.e., the limiting of "val" to fit in for example "s8" is never
reached.

This was introduced in the kernel tree when the sources were copied from
trace-cmd in commit f7d82350e597 ("tools/events: Add files to create
libtraceevent.a"), and in the trace-cmd repo in 1cdbae6035cei
("Implement typecasting in parser") when the function was introduced,
i.e., it has always behaved the wrong way.

Detected by cppcheck.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: Tzvetomir Stoyanov <tstoyanov@vmware.com>
Fixes: f7d82350e597 ("tools/events: Add files to create libtraceevent.a")
Link: http://lkml.kernel.org/r/20190409091529.2686-1-rikard.falkeborn@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/traceevent/event-parse.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/traceevent/event-parse.c b/tools/lib/traceevent/event-parse.c
index 87494c7c619d..981c6ce2da2c 100644
--- a/tools/lib/traceevent/event-parse.c
+++ b/tools/lib/traceevent/event-parse.c
@@ -2233,7 +2233,7 @@ eval_type_str(unsigned long long val, const char *type, int pointer)
 		return val & 0xffffffff;
 
 	if (strcmp(type, "u64") == 0 ||
-	    strcmp(type, "s64"))
+	    strcmp(type, "s64") == 0)
 		return val;
 
 	if (strcmp(type, "s8") == 0)
