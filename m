Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FFEFC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:42:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCFF721925
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:42:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728260AbfCVWm2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 18:42:28 -0400
Received: from terminus.zytor.com ([198.137.202.136]:41757 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727852AbfCVWm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 18:42:27 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x2MMfpDd755509
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 22 Mar 2019 15:41:51 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x2MMfpa5755506;
        Fri, 22 Mar 2019 15:41:51 -0700
Date:   Fri, 22 Mar 2019 15:41:51 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Song Liu <tipbot@zytor.com>
Message-ID: <tip-31be9478ed7f43d6351e0d5a2257ca76609c83d3@git.kernel.org>
Cc:     ast@kernel.org, daniel@iogearbox.net, songliubraving@fb.com,
        peterz@infradead.org, tglx@linutronix.de, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, sdf@google.com, hpa@zytor.com,
        acme@redhat.com, jolsa@kernel.org, mingo@kernel.org
Reply-To: namhyung@kernel.org, tglx@linutronix.de, ast@kernel.org,
          peterz@infradead.org, daniel@iogearbox.net, mingo@kernel.org,
          jolsa@kernel.org, acme@redhat.com, hpa@zytor.com,
          songliubraving@fb.com, sdf@google.com,
          linux-kernel@vger.kernel.org
In-Reply-To: <20190312053051.2690567-12-songliubraving@fb.com>
References: <20190312053051.2690567-12-songliubraving@fb.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf feature detection: Add -lopcodes to
 feature-libbfd
Git-Commit-ID: 31be9478ed7f43d6351e0d5a2257ca76609c83d3
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

Commit-ID:  31be9478ed7f43d6351e0d5a2257ca76609c83d3
Gitweb:     https://git.kernel.org/tip/31be9478ed7f43d6351e0d5a2257ca76609c83d3
Author:     Song Liu <songliubraving@fb.com>
AuthorDate: Mon, 11 Mar 2019 22:30:47 -0700
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 19 Mar 2019 16:52:07 -0300

perf feature detection: Add -lopcodes to feature-libbfd

Both libbfd and libopcodes are distributed with binutil-dev/devel. When
libbfd is present, it is OK to assume that libopcodes also present. This
has been a safe assumption for bpftool.

This patch adds -lopcodes to perf/Makefile.config. libopcodes will be
used in the next commit for BPF annotation.

Signed-off-by: Song Liu <songliubraving@fb.com>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stanislav Fomichev <sdf@google.com>
Cc: kernel-team@fb.com
Link: http://lkml.kernel.org/r/20190312053051.2690567-12-songliubraving@fb.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.config | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 0f11d5891301..df4ad45599ca 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -713,7 +713,7 @@ else
 endif
 
 ifeq ($(feature-libbfd), 1)
-  EXTLIBS += -lbfd
+  EXTLIBS += -lbfd -lopcodes
 else
   # we are on a system that requires -liberty and (maybe) -lz
   # to link against -lbfd; test each case individually here
@@ -724,10 +724,10 @@ else
   $(call feature_check,libbfd-liberty-z)
 
   ifeq ($(feature-libbfd-liberty), 1)
-    EXTLIBS += -lbfd -liberty
+    EXTLIBS += -lbfd -lopcodes -liberty
   else
     ifeq ($(feature-libbfd-liberty-z), 1)
-      EXTLIBS += -lbfd -liberty -lz
+      EXTLIBS += -lbfd -lopcodes -liberty -lz
     endif
   endif
 endif
