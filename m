Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 050CBC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:30:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBD5D21925
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:30:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728161AbfCVWaJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 18:30:09 -0400
Received: from terminus.zytor.com ([198.137.202.136]:46541 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727606AbfCVWaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 18:30:08 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x2MMTI4H753278
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 22 Mar 2019 15:29:18 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x2MMTIbP753275;
        Fri, 22 Mar 2019 15:29:18 -0700
Date:   Fri, 22 Mar 2019 15:29:18 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Changbin Du <tipbot@zytor.com>
Message-ID: <tip-70c819e4bf1c5f492768b399d898d458ccdad2b6@git.kernel.org>
Cc:     ast@kernel.org, changbin.du@gmail.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        peterz@infradead.org, mingo@kernel.org, hpa@zytor.com,
        acme@redhat.com, rostedt@goodmis.org, jolsa@kernel.org,
        namhyung@kernel.org, daniel@iogearbox.net
Reply-To: ast@kernel.org, linux-kernel@vger.kernel.org,
          peterz@infradead.org, tglx@linutronix.de, changbin.du@gmail.com,
          rostedt@goodmis.org, acme@redhat.com, hpa@zytor.com,
          mingo@kernel.org, namhyung@kernel.org, daniel@iogearbox.net,
          jolsa@kernel.org
In-Reply-To: <20190316080556.3075-9-changbin.du@gmail.com>
References: <20190316080556.3075-9-changbin.du@gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf top: Fix error handling in cmd_top()
Git-Commit-ID: 70c819e4bf1c5f492768b399d898d458ccdad2b6
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

Commit-ID:  70c819e4bf1c5f492768b399d898d458ccdad2b6
Gitweb:     https://git.kernel.org/tip/70c819e4bf1c5f492768b399d898d458ccdad2b6
Author:     Changbin Du <changbin.du@gmail.com>
AuthorDate: Sat, 16 Mar 2019 16:05:48 +0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 19 Mar 2019 16:52:04 -0300

perf top: Fix error handling in cmd_top()

We should go to the cleanup path, to avoid leaks, detected using gcc's
ASan.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
Link: http://lkml.kernel.org/r/20190316080556.3075-9-changbin.du@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-top.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 614f278235fa..2508a7a552fa 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1617,8 +1617,9 @@ int cmd_top(int argc, const char **argv)
 	annotation_config__init();
 
 	symbol_conf.try_vmlinux_path = (symbol_conf.vmlinux_name == NULL);
-	if (symbol__init(NULL) < 0)
-		return -1;
+	status = symbol__init(NULL);
+	if (status < 0)
+		goto out_delete_evlist;
 
 	sort__setup_elide(stdout);
 
