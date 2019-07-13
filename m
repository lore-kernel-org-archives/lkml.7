Return-Path: <SRS0=/nvU=VK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2A8DC742D7
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 10:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E5722083B
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 10:55:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="OUo4XWUd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727767AbfGMKzW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jul 2019 06:55:22 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43455 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbfGMKzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jul 2019 06:55:21 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6DAsYMe3837823
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 13 Jul 2019 03:54:35 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6DAsYMe3837823
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1563015276;
        bh=F5U8Yp4oUEP66inJtwpbu9ERHqdQCKl1kYd7mg4mMLc=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=OUo4XWUdtuOe+RYDlse1HYJ3j6gm3EhAgN46mv1tJsNFZuSD3PNekbxPfFSszMtGm
         c097KuW+pcaPnMxHehJ2J/DrLVWWVf7SzdhKkDp2zq7rBLZxlShcJMesN19Y1uCMNs
         IBIqvq65OowlXJFFncwrW4+JgJDI4jydL4vExYq+gvHXT96PqnmK0ELDN1KLmFnL9d
         iEbJFv16m8Q6ScZRYXbqXUZmqiVbC9h1PrJ1Oxuf5DvfEZVlPyIkWaQQovMasrwLb2
         Dp1TNZ+n5Em4EGrOBym02Sgy/hc84dhCPPQ+DwFVAUIbDzLtaf/QaWQSmwU9KDNQXf
         mVbL81UbIPK6Q==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6DAsYMG3837820;
        Sat, 13 Jul 2019 03:54:34 -0700
Date:   Sat, 13 Jul 2019 03:54:34 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Leo Yan <tipbot@zytor.com>
Message-ID: <tip-600c787dbf6521d8d07ee717ab7606d5070103ea@git.kernel.org>
Cc:     hpa@zytor.com, eric.saint.etienne@oracle.com, davem@davemloft.net,
        linux-kernel@vger.kernel.org, alexander.shishkin@linux.intel.com,
        mathieu.poirier@linaro.org, songliubraving@fb.com,
        dave@stgolabs.net, mingo@kernel.org, peterz@infradead.org,
        suzuki.poulose@arm.com, leo.yan@linaro.org, acme@redhat.com,
        adrian.hunter@intel.com, ak@linux.intel.com, tmricht@linux.ibm.com,
        khlebnikov@yandex-team.ru, changbin.du@intel.com,
        namhyung@kernel.org, jolsa@kernel.org, alexios.zavras@intel.com,
        tglx@linutronix.de, alexey.budankov@linux.intel.com,
        linux@rasmusvillemoes.dk, yao.jin@linux.intel.com
Reply-To: alexey.budankov@linux.intel.com, linux@rasmusvillemoes.dk,
          yao.jin@linux.intel.com, ak@linux.intel.com,
          adrian.hunter@intel.com, tmricht@linux.ibm.com,
          khlebnikov@yandex-team.ru, changbin.du@intel.com,
          namhyung@kernel.org, jolsa@kernel.org, alexios.zavras@intel.com,
          tglx@linutronix.de, mathieu.poirier@linaro.org,
          songliubraving@fb.com, mingo@kernel.org, dave@stgolabs.net,
          peterz@infradead.org, suzuki.poulose@arm.com, acme@redhat.com,
          leo.yan@linaro.org, hpa@zytor.com, davem@davemloft.net,
          eric.saint.etienne@oracle.com, linux-kernel@vger.kernel.org,
          alexander.shishkin@linux.intel.com
In-Reply-To: <20190702103420.27540-5-leo.yan@linaro.org>
References: <20190702103420.27540-5-leo.yan@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf annotate: Fix dereferencing freed memory
 found by the smatch tool
Git-Commit-ID: 600c787dbf6521d8d07ee717ab7606d5070103ea
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

Commit-ID:  600c787dbf6521d8d07ee717ab7606d5070103ea
Gitweb:     https://git.kernel.org/tip/600c787dbf6521d8d07ee717ab7606d5070103ea
Author:     Leo Yan <leo.yan@linaro.org>
AuthorDate: Tue, 2 Jul 2019 18:34:13 +0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 9 Jul 2019 09:33:55 -0300

perf annotate: Fix dereferencing freed memory found by the smatch tool

Based on the following report from Smatch, fix the potential
dereferencing freed memory check.

  tools/perf/util/annotate.c:1125
  disasm_line__parse() error: dereferencing freed memory 'namep'

  tools/perf/util/annotate.c
  1100 static int disasm_line__parse(char *line, const char **namep, char **rawp)
  1101 {
  1102         char tmp, *name = ltrim(line);

  [...]

  1114         *namep = strdup(name);
  1115
  1116         if (*namep == NULL)
  1117                 goto out_free_name;

  [...]

  1124 out_free_name:
  1125         free((void *)namep);
                            ^^^^^
  1126         *namep = NULL;
               ^^^^^^
  1127         return -1;
  1128 }

If strdup() fails to allocate memory space for *namep, we don't need to
free memory with pointer 'namep', which is resident in data structure
disasm_line::ins::name; and *namep is NULL pointer for this failure, so
it's pointless to assign NULL to *namep again.

Committer note:

Freeing namep, which is the address of the first entry of the 'struct
ins' that is the first member of struct disasm_line would in fact free
that disasm_line instance, if it was allocated via malloc/calloc, which,
later, would a dereference of freed memory.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Alexios Zavras <alexios.zavras@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Changbin Du <changbin.du@intel.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Eric Saint-Etienne <eric.saint.etienne@oracle.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Song Liu <songliubraving@fb.com>
Cc: Suzuki Poulouse <suzuki.poulose@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-arm-kernel@lists.infradead.org
Link: http://lkml.kernel.org/r/20190702103420.27540-5-leo.yan@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index ec7aaf31c2b2..944a6507a5e3 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1119,16 +1119,14 @@ static int disasm_line__parse(char *line, const char **namep, char **rawp)
 	*namep = strdup(name);
 
 	if (*namep == NULL)
-		goto out_free_name;
+		goto out;
 
 	(*rawp)[0] = tmp;
 	*rawp = skip_spaces(*rawp);
 
 	return 0;
 
-out_free_name:
-	free((void *)namep);
-	*namep = NULL;
+out:
 	return -1;
 }
 
