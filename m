Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DDE4C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 19:49:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0429A20815
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 19:49:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbfCITtC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 14:49:02 -0500
Received: from terminus.zytor.com ([198.137.202.136]:60153 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726363AbfCITtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 14:49:02 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x29JmdK53200639
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 9 Mar 2019 11:48:39 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x29Jmcxk3200636;
        Sat, 9 Mar 2019 11:48:38 -0800
Date:   Sat, 9 Mar 2019 11:48:38 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   "tip-bot for Gustavo A. R. Silva" <tipbot@zytor.com>
Message-ID: <tip-10c3405f060397e565e4f75c403859f9a074bfa5@git.kernel.org>
Cc:     acme@redhat.com, gustavo@embeddedor.com, tglx@linutronix.de,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        jolsa@redhat.com, namhyung@kernel.org, keescook@chromium.org,
        alexander.shishkin@linux.intel.com, mingo@kernel.org, hpa@zytor.com
Reply-To: namhyung@kernel.org, alexander.shishkin@linux.intel.com,
          acme@redhat.com, gustavo@embeddedor.com, peterz@infradead.org,
          jolsa@redhat.com, keescook@chromium.org, hpa@zytor.com,
          mingo@kernel.org, tglx@linutronix.de,
          linux-kernel@vger.kernel.org
In-Reply-To: <20190212205430.GA8446@embeddedor>
References: <20190212205430.GA8446@embeddedor>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf: Mark expected switch fall-through
Git-Commit-ID: 10c3405f060397e565e4f75c403859f9a074bfa5
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

Commit-ID:  10c3405f060397e565e4f75c403859f9a074bfa5
Gitweb:     https://git.kernel.org/tip/10c3405f060397e565e4f75c403859f9a074bfa5
Author:     Gustavo A. R. Silva <gustavo@embeddedor.com>
AuthorDate: Tue, 12 Feb 2019 14:54:30 -0600
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 1 Mar 2019 10:54:00 -0300

perf: Mark expected switch fall-through

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

This patch fixes the following warning:

  kernel/events/core.c: In function ‘perf_event_parse_addr_filter’:
  kernel/events/core.c:9154:11: warning: this statement may fall through [-Wimplicit-fallthrough=]
      kernel = 1;
      ~~~~~~~^~~
  kernel/events/core.c:9156:3: note: here
     case IF_SRC_FILEADDR:
     ^~~~

Warning level 3 was used: -Wimplicit-fallthrough=3

This patch is part of the ongoing efforts to enable -Wimplicit-fallthrough.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Gustavo A. R. Silva <gustavo@embeddedor.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Kees Kook <keescook@chromium.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190212205430.GA8446@embeddedor
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 kernel/events/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index dd9698ad3d66..6fb27b564730 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -9175,6 +9175,7 @@ perf_event_parse_addr_filter(struct perf_event *event, char *fstr,
 		case IF_SRC_KERNELADDR:
 		case IF_SRC_KERNEL:
 			kernel = 1;
+			/* fall through */
 
 		case IF_SRC_FILEADDR:
 		case IF_SRC_FILE:
