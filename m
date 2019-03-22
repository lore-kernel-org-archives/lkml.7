Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 439C5C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A79E218D4
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:28:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727985AbfCVW2T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 18:28:19 -0400
Received: from terminus.zytor.com ([198.137.202.136]:51183 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbfCVW2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 18:28:19 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x2MMRLYR753141
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 22 Mar 2019 15:27:21 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x2MMRLQr753138;
        Fri, 22 Mar 2019 15:27:21 -0700
Date:   Fri, 22 Mar 2019 15:27:21 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Changbin Du <tipbot@zytor.com>
Message-ID: <tip-54569ba4b06d5baedae4614bde33a25a191473ba@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        mingo@kernel.org, peterz@infradead.org, treeze.taeung@gmail.com,
        changbin.du@gmail.com, daniel@iogearbox.net, hpa@zytor.com,
        tglx@linutronix.de, acme@redhat.com, namhyung@kernel.org,
        ast@kernel.org, jolsa@kernel.org
Reply-To: ast@kernel.org, acme@redhat.com, changbin.du@gmail.com,
          daniel@iogearbox.net, jolsa@kernel.org, peterz@infradead.org,
          rostedt@goodmis.org, namhyung@kernel.org, hpa@zytor.com,
          tglx@linutronix.de, linux-kernel@vger.kernel.org,
          treeze.taeung@gmail.com, mingo@kernel.org
In-Reply-To: <20190316080556.3075-6-changbin.du@gmail.com>
References: <20190316080556.3075-6-changbin.du@gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf config: Fix a memory leak in
 collect_config()
Git-Commit-ID: 54569ba4b06d5baedae4614bde33a25a191473ba
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

Commit-ID:  54569ba4b06d5baedae4614bde33a25a191473ba
Gitweb:     https://git.kernel.org/tip/54569ba4b06d5baedae4614bde33a25a191473ba
Author:     Changbin Du <changbin.du@gmail.com>
AuthorDate: Sat, 16 Mar 2019 16:05:45 +0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 19 Mar 2019 16:52:04 -0300

perf config: Fix a memory leak in collect_config()

Detected with gcc's ASan:

  Direct leak of 66 byte(s) in 5 object(s) allocated from:
      #0 0x7ff3b1f32070 in __interceptor_strdup (/usr/lib/x86_64-linux-gnu/libasan.so.5+0x3b070)
      #1 0x560c8761034d in collect_config util/config.c:597
      #2 0x560c8760d9cb in get_value util/config.c:169
      #3 0x560c8760dfd7 in perf_parse_file util/config.c:285
      #4 0x560c8760e0d2 in perf_config_from_file util/config.c:476
      #5 0x560c876108fd in perf_config_set__init util/config.c:661
      #6 0x560c87610c72 in perf_config_set__new util/config.c:709
      #7 0x560c87610d2f in perf_config__init util/config.c:718
      #8 0x560c87610e5d in perf_config util/config.c:730
      #9 0x560c875ddea0 in main /home/changbin/work/linux/tools/perf/perf.c:442
      #10 0x7ff3afb8609a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x2409a)

Signed-off-by: Changbin Du <changbin.du@gmail.com>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: Taeung Song <treeze.taeung@gmail.com>
Fixes: 20105ca1240c ("perf config: Introduce perf_config_set class")
Link: http://lkml.kernel.org/r/20190316080556.3075-6-changbin.du@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/config.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/perf/util/config.c b/tools/perf/util/config.c
index fa092511c52b..7e3c1b60120c 100644
--- a/tools/perf/util/config.c
+++ b/tools/perf/util/config.c
@@ -633,11 +633,10 @@ static int collect_config(const char *var, const char *value,
 	}
 
 	ret = set_value(item, value);
-	return ret;
 
 out_free:
 	free(key);
-	return -1;
+	return ret;
 }
 
 int perf_config_set__collect(struct perf_config_set *set, const char *file_name,
