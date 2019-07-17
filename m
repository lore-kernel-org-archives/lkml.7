Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82539C7618F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 22:50:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54A46217F4
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 22:50:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="xQsdwRHZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729932AbfGQWuU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 18:50:20 -0400
Received: from terminus.zytor.com ([198.137.202.136]:45535 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727106AbfGQWuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 18:50:19 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6HMnqZf1721179
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 17 Jul 2019 15:49:52 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6HMnqZf1721179
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1563403793;
        bh=2Xp0P282pJPndrE62OooNood1FpAOyswYIewn+I2fPw=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=xQsdwRHZfDseFQan9LU5xMkrBl5bz0JdkCxnRnaEoxAO4lOUrspSrUPZjQjo5SUcv
         fZqtFP71i07WGED34TI8LGWpLwkAIT9d9S2mWFDpo3x8NYRSlW3UdrpCAnWQzntlk7
         /8E8bFu+xd/n9286KpYee30Yp3VlQwkEm+cw4RxdDX8eZ+1CnloyTfzRYgj4kf7nrP
         GCuGOVr318CdwQEPKCWK+9HWNtVNQA1mq2D3NqhtAh6iD+kQSsMEHmU0yC3eOgZdWF
         P4zLta0xdjfayqCiQ9pYRYKnne4Ao22lqSIlYY27Xq0FD3RTHzV/DPpPfhNa0HUlYT
         xB30m5KnZ3+bw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6HMnqNn1721175;
        Wed, 17 Jul 2019 15:49:52 -0700
Date:   Wed, 17 Jul 2019 15:49:52 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-b9fubkhr4jm192lu7y8hgjvo@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        namhyung@kernel.org, daniel@iogearbox.net, hpa@zytor.com,
        mingo@kernel.org, jolsa@kernel.org, acme@redhat.com,
        ast@kernel.org, adrian.hunter@intel.com
Reply-To: namhyung@kernel.org, linux-kernel@vger.kernel.org,
          tglx@linutronix.de, adrian.hunter@intel.com, acme@redhat.com,
          ast@kernel.org, jolsa@kernel.org, hpa@zytor.com,
          mingo@kernel.org, daniel@iogearbox.net
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf test: Auto bump rlimit(MEMLOCK) for BPF test
 sake
Git-Commit-ID: d3280ce01e21a827daa50b0e9bdc8588c6f855d8
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

Commit-ID:  d3280ce01e21a827daa50b0e9bdc8588c6f855d8
Gitweb:     https://git.kernel.org/tip/d3280ce01e21a827daa50b0e9bdc8588c6f855d8
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 9 Jul 2019 16:27:01 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 9 Jul 2019 16:27:01 -0300

perf test: Auto bump rlimit(MEMLOCK) for BPF test sake

I noticed that the 'perf test bpf' was failing:

  # perf test bpf
  41: BPF filter                                            :
  41.1: Basic BPF filtering                                 : Skip
  41.2: BPF pinning                                         : Skip
  41.3: BPF prologue generation                             : Skip
  41.4: BPF relocation checker                              : Skip
  # ulimit -l
  64
  #

Using verbose mode we get just a line bout -EPERF being returned from
libbpf's bpf_load_program_xattr(), that ends up being used in 'perf
test bpf' initial program loading capability query:

  Missing basic BPF support, skip this test: Operation not permitted

Not that informative, but on a separate problem when creating BPF maps
bumping rlimit(MEMLOCK) helped, so I tried it here as well, works:

  # ulimit -l 128
  # perf test bpf
  41: BPF filter                                            :
  41.1: Basic BPF filtering                                 : Ok
  41.2: BPF pinning                                         : Ok
  41.3: BPF prologue generation                             : Ok
  41.4: BPF relocation checker                              : Ok
  #

So use the recently added rlimit__bump_memlock() helper:

  # ulimit -l 64
  # perf test bpf
  41: BPF filter                                            :
  41.1: Basic BPF filtering                                 : Ok
  41.2: BPF pinning                                         : Ok
  41.3: BPF prologue generation                             : Ok
  41.4: BPF relocation checker                              : Ok
  # ulimit -l
  64
  #

I.e. the bumping of memlock is restricted to the 'perf test' instance,
not changing the global value.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-b9fubkhr4jm192lu7y8hgjvo@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/builtin-test.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 66a82badc1d1..c3bec9d2c201 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -21,6 +21,7 @@
 #include <subcmd/parse-options.h>
 #include "string2.h"
 #include "symbol.h"
+#include "util/rlimit.h"
 #include <linux/kernel.h>
 #include <linux/string.h>
 #include <subcmd/exec-cmd.h>
@@ -727,6 +728,11 @@ int cmd_test(int argc, const char **argv)
 
 	if (skip != NULL)
 		skiplist = intlist__new(skip);
+	/*
+	 * Tests that create BPF maps, for instance, need more than the 64K
+	 * default:
+	 */
+	rlimit__bump_memlock();
 
 	return __cmd_test(argc, argv, skiplist);
 }
