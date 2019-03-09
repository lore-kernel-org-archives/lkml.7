Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DB64C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 19:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E45C420815
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 19:48:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbfCITsh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 14:48:37 -0500
Received: from terminus.zytor.com ([198.137.202.136]:58103 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726348AbfCITsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 14:48:36 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x29JltD13200363
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 9 Mar 2019 11:47:55 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x29JlseT3200360;
        Sat, 9 Mar 2019 11:47:54 -0800
Date:   Sat, 9 Mar 2019 11:47:54 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Tony Jones <tipbot@zytor.com>
Message-ID: <tip-7c5b019e3a638a5a290b0ec020f6ca83d2ec2aaa@git.kernel.org>
Cc:     rostedt@goodmis.org, acme@redhat.com, tonyj@suse.de, hpa@zytor.com,
        mikesart@fastmail.com, fweisbec@gmail.com, minipli@googlemail.com,
        linux-kernel@vger.kernel.org, mingo@kernel.org, tglx@linutronix.de
Reply-To: tonyj@suse.de, acme@redhat.com, rostedt@goodmis.org,
          mikesart@fastmail.com, fweisbec@gmail.com, hpa@zytor.com,
          minipli@googlemail.com, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, mingo@kernel.org
In-Reply-To: <20190228015532.8941-1-tonyj@suse.de>
References: <20190228015532.8941-1-tonyj@suse.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] tools lib traceevent: Fix buffer overflow in
 arg_eval
Git-Commit-ID: 7c5b019e3a638a5a290b0ec020f6ca83d2ec2aaa
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

Commit-ID:  7c5b019e3a638a5a290b0ec020f6ca83d2ec2aaa
Gitweb:     https://git.kernel.org/tip/7c5b019e3a638a5a290b0ec020f6ca83d2ec2aaa
Author:     Tony Jones <tonyj@suse.de>
AuthorDate: Wed, 27 Feb 2019 17:55:32 -0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 28 Feb 2019 16:06:47 -0300

tools lib traceevent: Fix buffer overflow in arg_eval

Fix buffer overflow observed when running perf test.

The overflow is when trying to evaluate "1ULL << (64 - 1)" which is
resulting in -9223372036854775808 which overflows the 20 character
buffer.

If is possible this bug has been reported before but I still don't see
any fix checked in:

See: https://www.spinics.net/lists/linux-perf-users/msg07714.html

Reported-by: Michael Sartain <mikesart@fastmail.com>
Reported-by: Mathias Krause <minipli@googlemail.com>
Signed-off-by: Tony Jones <tonyj@suse.de>
Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Fixes: f7d82350e597 ("tools/events: Add files to create libtraceevent.a")
Link: http://lkml.kernel.org/r/20190228015532.8941-1-tonyj@suse.de
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/traceevent/event-parse.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/traceevent/event-parse.c b/tools/lib/traceevent/event-parse.c
index abd4fa5d3088..87494c7c619d 100644
--- a/tools/lib/traceevent/event-parse.c
+++ b/tools/lib/traceevent/event-parse.c
@@ -2457,7 +2457,7 @@ static int arg_num_eval(struct tep_print_arg *arg, long long *val)
 static char *arg_eval (struct tep_print_arg *arg)
 {
 	long long val;
-	static char buf[20];
+	static char buf[24];
 
 	switch (arg->type) {
 	case TEP_PRINT_ATOM:
