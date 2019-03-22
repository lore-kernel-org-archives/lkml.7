Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5D54C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:04:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BE802190A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:04:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbfCVWEM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 18:04:12 -0400
Received: from terminus.zytor.com ([198.137.202.136]:50803 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727440AbfCVWEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 18:04:11 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x2MM1uQ2745347
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 22 Mar 2019 15:01:56 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x2MM1t9N745344;
        Fri, 22 Mar 2019 15:01:55 -0700
Date:   Fri, 22 Mar 2019 15:01:55 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-eaeffeb9838a7c0dec981d258666bfcc0fa6a947@git.kernel.org>
Cc:     jiufei.xue@linux.alibaba.com, alexander.shishkin@linux.intel.com,
        adrian.hunter@intel.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, hpa@zytor.com,
        gregkh@linuxfoundation.org, xuyu@linux.alibaba.com,
        acme@redhat.com, joseph.qi@linux.alibaba.com, mhiramat@kernel.org,
        mingo@kernel.org, luto@kernel.org, tglx@linutronix.de
Reply-To: acme@redhat.com, luto@kernel.org, tglx@linutronix.de,
          mhiramat@kernel.org, mingo@kernel.org,
          joseph.qi@linux.alibaba.com, alexander.shishkin@linux.intel.com,
          adrian.hunter@intel.com, jiufei.xue@linux.alibaba.com,
          xuyu@linux.alibaba.com, hpa@zytor.com,
          gregkh@linuxfoundation.org, peterz@infradead.org,
          linux-kernel@vger.kernel.org
In-Reply-To: <2ed432de-e904-85d2-5c36-5897ddc5b23b@intel.com>
References: <2ed432de-e904-85d2-5c36-5897ddc5b23b@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf probe: Fix getting the kernel map
Git-Commit-ID: eaeffeb9838a7c0dec981d258666bfcc0fa6a947
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

Commit-ID:  eaeffeb9838a7c0dec981d258666bfcc0fa6a947
Gitweb:     https://git.kernel.org/tip/eaeffeb9838a7c0dec981d258666bfcc0fa6a947
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Mon, 4 Mar 2019 15:13:21 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 11 Mar 2019 11:56:03 -0300

perf probe: Fix getting the kernel map

Since commit 4d99e4136580 ("perf machine: Workaround missing maps for
x86 PTI entry trampolines"), perf tools has been creating more than one
kernel map, however 'perf probe' assumed there could be only one.

Fix by using machine__kernel_map() to get the main kernel map.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Tested-by: Joseph Qi <joseph.qi@linux.alibaba.com>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiufei Xue <jiufei.xue@linux.alibaba.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: stable@vger.kernel.org
Cc: Xu Yu <xuyu@linux.alibaba.com>
Fixes: 4d99e4136580 ("perf machine: Workaround missing maps for x86 PTI entry trampolines")
Fixes: d83212d5dd67 ("kallsyms, x86: Export addresses of PTI entry trampolines")
Link: http://lkml.kernel.org/r/2ed432de-e904-85d2-5c36-5897ddc5b23b@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/probe-event.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index a1b8d9649ca7..198e09ff611e 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -160,8 +160,10 @@ static struct map *kernel_get_module_map(const char *module)
 	if (module && strchr(module, '/'))
 		return dso__new_map(module);
 
-	if (!module)
-		module = "kernel";
+	if (!module) {
+		pos = machine__kernel_map(host_machine);
+		return map__get(pos);
+	}
 
 	for (pos = maps__first(maps); pos; pos = map__next(pos)) {
 		/* short_name is "[module]" */
