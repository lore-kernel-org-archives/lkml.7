Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEE85C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 19:01:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97ADB2183F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 19:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560279718;
	bh=F2upgpS/1NOwwbiE086ApZRRb698tGVlPl1QspG2UVA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cTt7QQO1GmNMtxj94+rk5KH4HL3gYEsKBbCL7NnKlPgDXm3j8RA6jsexrta8g9T2V
	 vdpmclASeMNmz4sK+HH25QWI4atvJ32RNkAQd9PRpUEPkks5HO0E8Zp/rsGhte4J5S
	 wAS6RF2I+bgQvEjbz3pahtmrTvPes8Kbcc+KC5Lg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392315AbfFKTB5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 15:01:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:38118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390411AbfFKTB5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 15:01:57 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4CE6217D6;
        Tue, 11 Jun 2019 19:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560279716;
        bh=F2upgpS/1NOwwbiE086ApZRRb698tGVlPl1QspG2UVA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A8DBdWoPMvIMR8NFlb/1Q3nw6nWcb2mh3rHqcW9PzVUVsavTqOCvAYxBd0qNzxSwP
         326BxBbuiA6/fCjxNUyvQyBZKne7X9jljH5CWVJaao7UKXsE61suIeWobt2PzW6fup
         BvMoSMzIJOaNUhdcQpCGd0kCJ+bc24Th5fguLLd0=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jiri Olsa <jolsa@redhat.com>, Martin KaFai Lau <kafai@fb.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Song Liu <songliubraving@fb.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Taeung Song <treeze.taeung@gmail.com>,
        Yonghong Song <yhs@fb.com>
Subject: [PATCH 34/85] perf config: Bail out when a handler returns failure for a key-value pair
Date:   Tue, 11 Jun 2019 15:58:20 -0300
Message-Id: <20190611185911.11645-35-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190611185911.11645-1-acme@kernel.org>
References: <20190611185911.11645-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

So perf_config() uses:

  int ret = 0;

  perf_config_set__for_each_entry(config_set, section, item) {
          ...
          ret = fn();
          if (ret < 0)
                  break;
  }

  return ret;

Expecting that that break will imediatelly go to function exit to return
that error value (ret).

The problem is that perf_config_set__for_each_entry() expands into two
nested for() loops, one traversing the sections in a config and the
second the items in each of those sections, so we have to change that
'break' to a goto label right before that final 'return ret'.

With that, for instance 'perf trace' now correctly bails out when a
event that is requested to be added via its 'trace.add_events'
~/.perfconfig entry gets rejected by the kernel BPF verifier:

  # perf trace ls
  event syntax error: '/home/acme/git/perf/tools/perf/examples/bpf/augmented_raw_syscalls.o'
                       \___ Kernel verifier blocks program loading

  (add -v to see detail)
  Run 'perf list' for a list of valid events
  Error: wrong config key-value pair trace.add_events=/home/acme/git/perf/tools/perf/examples/bpf/augmented_raw_syscalls.o
  #

While before it would continue and explode later, when trying to find
maps that would have been in place had that augmented_raw_syscalls.o
precompiled BPF proggie been accepted by the, humm, bast... rigorous
kernel BPF verifier 8-)

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Martin KaFai Lau <kafai@fb.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Song Liu <songliubraving@fb.com>
Cc: Suzuki Poulouse <suzuki.poulose@arm.com>
Cc: Taeung Song <treeze.taeung@gmail.com>
Cc: Yonghong Song <yhs@fb.com>
Fixes: 8a0a9c7e9146 ("perf config: Introduce new init() and exit()")
Link: https://lkml.kernel.org/n/tip-qvqxfk9d0rn1l7lcntwiezrr@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/config.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/config.c b/tools/perf/util/config.c
index 7e3c1b60120c..e7d2c08d263a 100644
--- a/tools/perf/util/config.c
+++ b/tools/perf/util/config.c
@@ -739,11 +739,15 @@ int perf_config(config_fn_t fn, void *data)
 			if (ret < 0) {
 				pr_err("Error: wrong config key-value pair %s=%s\n",
 				       key, value);
-				break;
+				/*
+				 * Can't be just a 'break', as perf_config_set__for_each_entry()
+				 * expands to two nested for() loops.
+				 */
+				goto out;
 			}
 		}
 	}
-
+out:
 	return ret;
 }
 
-- 
2.20.1

