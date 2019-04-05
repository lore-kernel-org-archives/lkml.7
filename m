Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41799C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 11:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 182462186A
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 11:41:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731167AbfDELl4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 07:41:56 -0400
Received: from terminus.zytor.com ([198.137.202.136]:49373 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730283AbfDELl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 07:41:56 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x35BfJWJ2734925
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 5 Apr 2019 04:41:19 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x35BfIFP2734920;
        Fri, 5 Apr 2019 04:41:18 -0700
Date:   Fri, 5 Apr 2019 04:41:18 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   "tip-bot for Steven Rostedt (VMware)" <tipbot@zytor.com>
Message-ID: <tip-328b82b7497787cf4e4856a216dbf4e8a54c06a6@git.kernel.org>
Cc:     hpa@zytor.com, mingo@kernel.org, jolsa@redhat.com,
        tglx@linutronix.de, rostedt@goodmis.org, akpm@linux-foundation.org,
        tstoyanov@vmware.com, namhyung@kernel.org, acme@redhat.com,
        linux-kernel@vger.kernel.org
Reply-To: linux-kernel@vger.kernel.org, acme@redhat.com,
          tstoyanov@vmware.com, namhyung@kernel.org, rostedt@goodmis.org,
          akpm@linux-foundation.org, tglx@linutronix.de, mingo@kernel.org,
          jolsa@redhat.com, hpa@zytor.com
In-Reply-To: <20190401164342.837312153@goodmis.org>
References: <20190401164342.837312153@goodmis.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] tools lib traceevent: Handle trace_printk() "%px"
Git-Commit-ID: 328b82b7497787cf4e4856a216dbf4e8a54c06a6
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

Commit-ID:  328b82b7497787cf4e4856a216dbf4e8a54c06a6
Gitweb:     https://git.kernel.org/tip/328b82b7497787cf4e4856a216dbf4e8a54c06a6
Author:     Steven Rostedt (VMware) <rostedt@goodmis.org>
AuthorDate: Mon, 1 Apr 2019 12:43:06 -0400
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 1 Apr 2019 15:18:08 -0300

tools lib traceevent: Handle trace_printk() "%px"

With security updates, %p in the kernel is hashed to protect true kernel
locations. But trace_printk() is not allowed in production systems, and
when a pointer is used, there are many times that the actual address is
needed. "%px" produces the real address. But libtraceevent does not know how
to handle that extension. Add it.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Tzvetomir Stoyanov <tstoyanov@vmware.com>
Link: http://lkml.kernel.org/r/20190401164342.837312153@goodmis.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/traceevent/event-parse.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/lib/traceevent/event-parse.c b/tools/lib/traceevent/event-parse.c
index 87494c7c619d..2ebb257ce7ba 100644
--- a/tools/lib/traceevent/event-parse.c
+++ b/tools/lib/traceevent/event-parse.c
@@ -4338,6 +4338,7 @@ static struct tep_print_arg *make_bprint_args(char *fmt, void *data, int size, s
 					case 'S':
 					case 'f':
 					case 'F':
+					case 'x':
 						break;
 					default:
 						/*
