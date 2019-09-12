Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 023F8C5ACAE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 10:52:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C184220678
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 10:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568285559;
	bh=xMG78h2MkJ/pc8o5N/RXI+X5+xvw0DLgNMMeZDSBI5k=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=h15uvSbHW3mGTMC6QH4CQ4XDwdMAeZfVh/Eq7S03cVB2Y0Zudpwmak2hXGUlIQthm
	 TZfHN7+ZoFB3NYmZlspY5WMP8Erzqkiwzf5MVj3EJ7crZHIvq09pk7GuMgt9MbhrzN
	 +Utbqcn9uNgNWX9GVIFkomF9iHWjTDRlLIT8zt1I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731258AbfILKwj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 06:52:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37498 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730023AbfILKwi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 06:52:38 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4A58E36955;
        Thu, 12 Sep 2019 10:52:38 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 243DF194B9;
        Thu, 12 Sep 2019 10:52:35 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH] perf tools: Fix segfault in cpu_cache_level__read
Date:   Thu, 12 Sep 2019 12:52:35 +0200
Message-Id: <20190912105235.10689-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Thu, 12 Sep 2019 10:52:38 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We release wrong pointer on error path in
cpu_cache_level__read function, leading to
segfault:

  (gdb) r record ls
  Starting program: /root/perf/tools/perf/perf record ls
  ...
  [ perf record: Woken up 1 times to write data ]
  double free or corruption (out)

  Thread 1 "perf" received signal SIGABRT, Aborted.
  0x00007ffff7463798 in raise () from /lib64/power9/libc.so.6
  (gdb) bt
  #0  0x00007ffff7463798 in raise () from /lib64/power9/libc.so.6
  #1  0x00007ffff7443bac in abort () from /lib64/power9/libc.so.6
  #2  0x00007ffff74af8bc in __libc_message () from /lib64/power9/libc.so.6
  #3  0x00007ffff74b92b8 in malloc_printerr () from /lib64/power9/libc.so.6
  #4  0x00007ffff74bb874 in _int_free () from /lib64/power9/libc.so.6
  #5  0x0000000010271260 in __zfree (ptr=0x7fffffffa0b0) at ../../lib/zalloc..
  #6  0x0000000010139340 in cpu_cache_level__read (cache=0x7fffffffa090, cac..
  #7  0x0000000010143c90 in build_caches (cntp=0x7fffffffa118, size=<optimiz..
  ...

Releasing the proper pointer.

Link: http://lkml.kernel.org/n/tip-e7js6xoi4y18kydxqehh0ihx@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/header.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index b0c34dda30a0..3527b9897b6f 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -1081,7 +1081,7 @@ static int cpu_cache_level__read(struct cpu_cache_level *cache, u32 cpu, u16 lev
 
 	scnprintf(file, PATH_MAX, "%s/shared_cpu_list", path);
 	if (sysfs__read_str(file, &cache->map, &len)) {
-		zfree(&cache->map);
+		zfree(&cache->size);
 		zfree(&cache->type);
 		return -1;
 	}
-- 
2.21.0

