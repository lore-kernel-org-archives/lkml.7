Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B29CC76191
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 21:12:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A5BA2173C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 21:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563225149;
	bh=XAxw2xTdhNovu0xJNJcWljjxiZOoBif6tYcjxMF2+zg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FToS2zAzn73yrVSEQ+LadmU2rdZq16bqjfT3semWaUbYKkoLwsd2PY/iF07GMbhg0
	 xpz4gKszQgih7lMv1U1ghEtYz83pX7C5eafYtVLlC7DQSHygRlMjUJklem8AXw8Zm3
	 /XYkDe5iwylj/WiSOAfH+Br7Db+7XgXZSJBqcz7Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732552AbfGOVM2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 17:12:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:43238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731927AbfGOVM1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 17:12:27 -0400
Received: from quaco.ghostprotocols.net (179-240-129-12.3g.claro.net.br [179.240.129.12])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 228622173B;
        Mon, 15 Jul 2019 21:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563225146;
        bh=XAxw2xTdhNovu0xJNJcWljjxiZOoBif6tYcjxMF2+zg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A9SeosM9IU7AVXJW5x3EycZbG40QclUJ55U3ndA8hUfpod42plgxpE6cvQoBe5L5B
         J4+gaE21rkGs8BpfCDsljryBCMQIaSJ7vd0weKeZm5xH5Nbusll20z4BDInszFkmE1
         A6qwju4OPrYlewuRnA+lGBFUKQDQyWtcY/eskgEg=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH 02/28] perf test: Auto bump rlimit(MEMLOCK) for BPF test sake
Date:   Mon, 15 Jul 2019 18:11:34 -0300
Message-Id: <20190715211200.10984-3-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190715211200.10984-1-acme@kernel.org>
References: <20190715211200.10984-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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
-- 
2.21.0

