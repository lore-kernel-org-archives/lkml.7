Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2665DCA9EC9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 21:53:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECF6D21E6F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 21:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572904388;
	bh=sn9PuHWrsSWJy+qnRz1rl2QGZbrjTOyXUksthEqa3vc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=l8NyR4fDiDFOazMfBUxohPaDXQPJYUrUyor30gjKIsOQT60n/JpPZhtUNgW0NQQTA
	 0YaSFUo9joXD5U4hP8aj3i7N6Gf1IAz0R509i9kueRqS/uT4KUGcZKkHHHyiXaYfi0
	 GzpEj/mYg0hHVO5NkiqpxnfJZmYHiIHyn+3lC/j0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730025AbfKDVxG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 16:53:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:46802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730881AbfKDVxC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 16:53:02 -0500
Received: from localhost (6.204-14-84.ripe.coltfrance.com [84.14.204.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C485D218BA;
        Mon,  4 Nov 2019 21:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572904381;
        bh=sn9PuHWrsSWJy+qnRz1rl2QGZbrjTOyXUksthEqa3vc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bUmAfNwOhxvENFDwFiV/6i12j8zRk6ZIQwUNz5PVqaGeNHSyknegcdAq7Wk7Q1Bit
         j/VNltIpjYoq/SG+2MtHFjNvstdlj6XMAu1+WaRceRHCLmj344IwKdNF6PulT1GfSM
         fhs3KvfVJEAtypX+jr7SuX8FNDMUtPafEZnp0GmQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ian Rogers <irogers@google.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        Wang Nan <wangnan0@huawei.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 27/95] perf tests: Avoid raising SEGV using an obvious NULL dereference
Date:   Mon,  4 Nov 2019 22:44:25 +0100
Message-Id: <20191104212056.389615802@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191104212038.056365853@linuxfoundation.org>
References: <20191104212038.056365853@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ian Rogers <irogers@google.com>

[ Upstream commit e3e2cf3d5b1fe800b032e14c0fdcd9a6fb20cf3b ]

An optimized build such as:

  make -C tools/perf CLANG=1 CC=clang EXTRA_CFLAGS="-O3

will turn the dereference operation into a ud2 instruction, raising a
SIGILL rather than a SIGSEGV. Use raise(..) for correctness and clarity.

Similar issues were addressed in Numfor Mbiziwo-Tiapo's patch:

  https://lkml.org/lkml/2019/7/8/1234

Committer testing:

Before:

  [root@quaco ~]# perf test hooks
  55: perf hooks                                            : Ok
  [root@quaco ~]# perf test -v hooks
  55: perf hooks                                            :
  --- start ---
  test child forked, pid 17092
  SIGSEGV is observed as expected, try to recover.
  Fatal error (SEGFAULT) in perf hook 'test'
  test child finished with 0
  ---- end ----
  perf hooks: Ok
  [root@quaco ~]#

After:

  [root@quaco ~]# perf test hooks
  55: perf hooks                                            : Ok
  [root@quaco ~]# perf test -v hooks
  55: perf hooks                                            :
  --- start ---
  test child forked, pid 17909
  SIGSEGV is observed as expected, try to recover.
  Fatal error (SEGFAULT) in perf hook 'test'
  test child finished with 0
  ---- end ----
  perf hooks: Ok
  [root@quaco ~]#

Fixes: a074865e60ed ("perf tools: Introduce perf hooks")
Signed-off-by: Ian Rogers <irogers@google.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lore.kernel.org/lkml/20190925195924.152834-2-irogers@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/tests/perf-hooks.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/perf/tests/perf-hooks.c b/tools/perf/tests/perf-hooks.c
index a693bcf017ea2..44c16fd11bf6e 100644
--- a/tools/perf/tests/perf-hooks.c
+++ b/tools/perf/tests/perf-hooks.c
@@ -20,12 +20,11 @@ static void sigsegv_handler(int sig __maybe_unused)
 static void the_hook(void *_hook_flags)
 {
 	int *hook_flags = _hook_flags;
-	int *p = NULL;
 
 	*hook_flags = 1234;
 
 	/* Generate a segfault, test perf_hooks__recover */
-	*p = 0;
+	raise(SIGSEGV);
 }
 
 int test__perf_hooks(struct test *test __maybe_unused, int subtest __maybe_unused)
-- 
2.20.1



