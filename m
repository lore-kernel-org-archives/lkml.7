Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCB51C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 16:57:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA9DF22409
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 16:57:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728783AbfKSQ5Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 11:57:25 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:52906 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728684AbfKSQ5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 11:57:11 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iX6oF-0007R2-If; Tue, 19 Nov 2019 17:56:59 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 6ABB61C19D5;
        Tue, 19 Nov 2019 17:56:49 +0100 (CET)
Date:   Tue, 19 Nov 2019 16:56:49 -0000
From:   "tip-bot2 for Konstantin Khlebnikov" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] libtraceevent: Fix parsing of event %o and %X argument types
Cc:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        "Tzvetomir Stoyanov (VMware)" <tz.stoyanov@gmail.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <157338066113.6548.11461421296091086041.stgit@buzz>
References: <157338066113.6548.11461421296091086041.stgit@buzz>
MIME-Version: 1.0
Message-ID: <157418260938.12247.10146099611400140704.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     10f64581b1b79f3b0121c987e9ef272195940bf7
Gitweb:        https://git.kernel.org/tip/10f64581b1b79f3b0121c987e9ef272195940bf7
Author:        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
AuthorDate:    Sun, 10 Nov 2019 13:11:01 +03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Mon, 18 Nov 2019 13:01:59 -03:00

libtraceevent: Fix parsing of event %o and %X argument types

Add missing "%o" and "%X". Ext4 events use "%o" for printing i_mode.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: Tzvetomir Stoyanov (VMware) <tz.stoyanov@gmail.com>
Link: http://lore.kernel.org/lkml/157338066113.6548.11461421296091086041.stgit@buzz
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/traceevent/event-parse.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/lib/traceevent/event-parse.c b/tools/lib/traceevent/event-parse.c
index d948475..beaa8b8 100644
--- a/tools/lib/traceevent/event-parse.c
+++ b/tools/lib/traceevent/event-parse.c
@@ -4395,8 +4395,10 @@ static struct tep_print_arg *make_bprint_args(char *fmt, void *data, int size, s
 				/* fall through */
 			case 'd':
 			case 'u':
-			case 'x':
 			case 'i':
+			case 'x':
+			case 'X':
+			case 'o':
 				switch (ls) {
 				case 0:
 					vsize = 4;
@@ -5078,10 +5080,11 @@ static void pretty_print(struct trace_seq *s, void *data, int size, struct tep_e
 
 				/* fall through */
 			case 'd':
+			case 'u':
 			case 'i':
 			case 'x':
 			case 'X':
-			case 'u':
+			case 'o':
 				if (!arg) {
 					do_warning_event(event, "no argument match");
 					event->flags |= TEP_EVENT_FL_FAILED;
