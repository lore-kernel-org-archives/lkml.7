Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA90FC10F03
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 22:07:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8849420830
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 22:07:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbfCDWHR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 17:07:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:57116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726087AbfCDWHR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 17:07:17 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C2AD20835;
        Mon,  4 Mar 2019 22:07:16 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92-RC5)
        (envelope-from <rostedt@goodmis.org>)
        id 1h0vjv-0000ih-AO; Mon, 04 Mar 2019 17:07:15 -0500
Message-Id: <20190304220715.209699305@goodmis.org>
User-Agent: quilt/0.65
Date:   Mon, 04 Mar 2019 17:06:16 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable@vger.kernel.org,
        Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Subject: [PATCH 1/2] tracing: Fix event filters and triggers to handle negative numbers
References: <20190304220615.385873907@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>

Then tracing syscall exit event it is extremely useful to filter exit
codes equal to some negative value, to react only to required errors.
But negative numbers does not work:

[root@snorch sys_exit_read]# echo "ret == -1" > filter
bash: echo: write error: Invalid argument
[root@snorch sys_exit_read]# cat filter
ret == -1
        ^
parse_error: Invalid value (did you forget quotes)?

Similar thing happens when setting triggers.

These is a regression in v4.17 introduced by the commit mentioned below,
testing without these commit shows no problem with negative numbers.

Link: http://lkml.kernel.org/r/20180823102534.7642-1-ptikhomirov@virtuozzo.com

Cc: stable@vger.kernel.org
Fixes: 80765597bc58 ("tracing: Rewrite filter logic to be simpler and faster")
Signed-off-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_filter.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 27821480105e..217ef481fbbb 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -1301,7 +1301,7 @@ static int parse_pred(const char *str, void *data,
 		/* go past the last quote */
 		i++;
 
-	} else if (isdigit(str[i])) {
+	} else if (isdigit(str[i]) || str[i] == '-') {
 
 		/* Make sure the field is not a string */
 		if (is_string_field(field)) {
@@ -1314,6 +1314,9 @@ static int parse_pred(const char *str, void *data,
 			goto err_free;
 		}
 
+		if (str[i] == '-')
+			i++;
+
 		/* We allow 0xDEADBEEF */
 		while (isalnum(str[i]))
 			i++;
-- 
2.20.1


