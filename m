Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ABD8C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 14:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E938720851
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 14:41:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbfCIOlG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 09:41:06 -0500
Received: from terminus.zytor.com ([198.137.202.136]:52813 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726498AbfCIOlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 09:41:06 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x29EeKh53109459
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 9 Mar 2019 06:40:20 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x29EeJ033109455;
        Sat, 9 Mar 2019 06:40:19 -0800
Date:   Sat, 9 Mar 2019 06:40:19 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   "tip-bot for Gustavo A. R. Silva" <tipbot@zytor.com>
Message-ID: <tip-43aa378b41700650e4ddbd068650f9fe4ab496df@git.kernel.org>
Cc:     eranian@google.com, alexander.shishkin@linux.intel.com,
        torvalds@linux-foundation.org, keescook@chromium.org,
        namhyung@kernel.org, vincent.weaver@maine.edu, acme@kernel.org,
        mingo@kernel.org, acme@redhat.com, tglx@linutronix.de,
        riel@surriel.com, jolsa@redhat.com, linux-kernel@vger.kernel.org,
        bp@alien8.de, luto@kernel.org, dave.hansen@linux.intel.com,
        gustavo@embeddedor.com, peterz@infradead.org, hpa@zytor.com
Reply-To: eranian@google.com, alexander.shishkin@linux.intel.com,
          torvalds@linux-foundation.org, keescook@chromium.org,
          namhyung@kernel.org, vincent.weaver@maine.edu, acme@kernel.org,
          acme@redhat.com, mingo@kernel.org, jolsa@redhat.com,
          riel@surriel.com, tglx@linutronix.de, luto@kernel.org,
          linux-kernel@vger.kernel.org, bp@alien8.de,
          gustavo@embeddedor.com, peterz@infradead.org,
          dave.hansen@linux.intel.com, hpa@zytor.com
In-Reply-To: <20190212205430.GA8446@embeddedor>
References: <20190212205430.GA8446@embeddedor>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf/core: Mark expected switch fall-through
Git-Commit-ID: 43aa378b41700650e4ddbd068650f9fe4ab496df
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

Commit-ID:  43aa378b41700650e4ddbd068650f9fe4ab496df
Gitweb:     https://git.kernel.org/tip/43aa378b41700650e4ddbd068650f9fe4ab496df
Author:     Gustavo A. R. Silva <gustavo@embeddedor.com>
AuthorDate: Tue, 12 Feb 2019 14:54:30 -0600
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Sat, 9 Mar 2019 14:10:32 +0100

perf/core: Mark expected switch fall-through

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
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Link: https://lkml.kernel.org/r/20190212205430.GA8446@embeddedor
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/events/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 5f59d848171e..68ff130b99e7 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -9174,6 +9174,7 @@ perf_event_parse_addr_filter(struct perf_event *event, char *fstr,
 		case IF_SRC_KERNELADDR:
 		case IF_SRC_KERNEL:
 			kernel = 1;
+			/* fall through */
 
 		case IF_SRC_FILEADDR:
 		case IF_SRC_FILE:
