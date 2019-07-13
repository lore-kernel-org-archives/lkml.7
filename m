Return-Path: <SRS0=/nvU=VK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53EF1C742D7
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 10:56:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BD872083B
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 10:56:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="niQRyIm/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727740AbfGMK4g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jul 2019 06:56:36 -0400
Received: from terminus.zytor.com ([198.137.202.136]:40123 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbfGMK4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jul 2019 06:56:36 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6DAtx6j3837931
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 13 Jul 2019 03:55:59 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6DAtx6j3837931
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1563015360;
        bh=gkADcFmjjy6O5zsmAnxX8oLg+s5gfY2W+IkKz4WWCFk=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=niQRyIm/Xvo6Y7VjzBcJoUf/gN9hnfUT9hBFnBf0fPJt/62zXKB7uAaLXD44c3bqH
         xXbXYdTx+iPBd36QNCAhivl5r0u6fpWuuFTGGvwLBIBdcW6zx97yaiMkdLNb9dNslT
         BZYC+5ZUH3aoyoPcZeW6Lhp7Xp1ReYC/9UERLfimuYNhvp/n7II8XDWmlQzxVmNKuO
         QvQcRsrazLaWzvobu1VLr7XvWjj7PxzREoRO/XtOKpSfarNLSmpm+ofNUXqYjUj88a
         NldNfdsdBoBof9tp1brgTGBd0gfc8QRqKMLCp6r/OnjVWkKCXNb26VXT2406r+5Zop
         hTt+YHV3tcEoA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6DAtxpb3837927;
        Sat, 13 Jul 2019 03:55:59 -0700
Date:   Sat, 13 Jul 2019 03:55:59 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Leo Yan <tipbot@zytor.com>
Message-ID: <tip-363bbaef63ffebcc745239fe80a953ebb5ac9ec9@git.kernel.org>
Cc:     yao.jin@linux.intel.com, tmricht@linux.ibm.com,
        linux@rasmusvillemoes.dk, khlebnikov@yandex-team.ru,
        alexander.shishkin@linux.intel.com, acme@redhat.com,
        suzuki.poulose@arm.com, peterz@infradead.org,
        adrian.hunter@intel.com, davem@davemloft.net, hpa@zytor.com,
        linux-kernel@vger.kernel.org, alexey.budankov@linux.intel.com,
        changbin.du@intel.com, jolsa@kernel.org, ak@linux.intel.com,
        mathieu.poirier@linaro.org, namhyung@kernel.org,
        alexios.zavras@intel.com, mingo@kernel.org, songliubraving@fb.com,
        tglx@linutronix.de, leo.yan@linaro.org, dave@stgolabs.net,
        eric.saint.etienne@oracle.com
Reply-To: tmricht@linux.ibm.com, yao.jin@linux.intel.com,
          linux@rasmusvillemoes.dk, khlebnikov@yandex-team.ru,
          alexander.shishkin@linux.intel.com, suzuki.poulose@arm.com,
          acme@redhat.com, peterz@infradead.org, adrian.hunter@intel.com,
          davem@davemloft.net, hpa@zytor.com, linux-kernel@vger.kernel.org,
          changbin.du@intel.com, alexey.budankov@linux.intel.com,
          jolsa@kernel.org, ak@linux.intel.com, mathieu.poirier@linaro.org,
          namhyung@kernel.org, alexios.zavras@intel.com, mingo@kernel.org,
          songliubraving@fb.com, tglx@linutronix.de, dave@stgolabs.net,
          leo.yan@linaro.org, eric.saint.etienne@oracle.com
In-Reply-To: <20190702103420.27540-8-leo.yan@linaro.org>
References: <20190702103420.27540-8-leo.yan@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf map: Fix potential NULL pointer dereference
 found by smatch tool
Git-Commit-ID: 363bbaef63ffebcc745239fe80a953ebb5ac9ec9
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

Commit-ID:  363bbaef63ffebcc745239fe80a953ebb5ac9ec9
Gitweb:     https://git.kernel.org/tip/363bbaef63ffebcc745239fe80a953ebb5ac9ec9
Author:     Leo Yan <leo.yan@linaro.org>
AuthorDate: Tue, 2 Jul 2019 18:34:16 +0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 9 Jul 2019 09:33:55 -0300

perf map: Fix potential NULL pointer dereference found by smatch tool

Based on the following report from Smatch, fix the potential NULL
pointer dereference check.

  tools/perf/util/map.c:479
  map__fprintf_srccode() error: we previously assumed 'state' could be
  null (see line 466)

  tools/perf/util/map.c
  465         /* Avoid redundant printing */
  466         if (state &&
  467             state->srcfile &&
  468             !strcmp(state->srcfile, srcfile) &&
  469             state->line == line) {
  470                 free(srcfile);
  471                 return 0;
  472         }
  473
  474         srccode = find_sourceline(srcfile, line, &len);
  475         if (!srccode)
  476                 goto out_free_line;
  477
  478         ret = fprintf(fp, "|%-8d %.*s", line, len, srccode);
  479         state->srcfile = srcfile;
              ^^^^^^^
  480         state->line = line;
              ^^^^^^^

This patch validates 'state' pointer before access its elements.

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
Fixes: dd2e18e9ac20 ("perf tools: Support 'srccode' output")
Link: http://lkml.kernel.org/r/20190702103420.27540-8-leo.yan@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/map.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index 6fce983c6115..5f87975d2562 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -476,8 +476,11 @@ int map__fprintf_srccode(struct map *map, u64 addr,
 		goto out_free_line;
 
 	ret = fprintf(fp, "|%-8d %.*s", line, len, srccode);
-	state->srcfile = srcfile;
-	state->line = line;
+
+	if (state) {
+		state->srcfile = srcfile;
+		state->line = line;
+	}
 	return ret;
 
 out_free_line:
