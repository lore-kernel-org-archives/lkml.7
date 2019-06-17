Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39126C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:18:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F052C20863
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:18:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="xkYMPZgx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbfFQTSw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 15:18:52 -0400
Received: from terminus.zytor.com ([198.137.202.136]:48535 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbfFQTSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 15:18:52 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5HJI7F53560064
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 17 Jun 2019 12:18:07 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5HJI7F53560064
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560799088;
        bh=ow0QS0pQmyHNiHQohkxy0jkHTDlrbWQygFwwaV4X7hQ=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=xkYMPZgxTLYz7qwYap/pQ7UKAClO8q6TX28vIJrB24rnLKGCVTWbm7WS1CJpJggla
         99aiOhNP8ffDGi9oFXUlCl1WbyY+IyRMfFYbqEdPZefsweTLvRzHI14VnGcbgmZhof
         hwKUDxWvBHGFshUyWA5KrJQCQMxGfsrMTYmRZ+SRG9uoN5PNXjUKRim23HpTGZVDgE
         8cNmraV5TsBKw8wo6ZVwdEL8LptjQtOLjoMeJhKgKYt0tfu04vmXMg48ASJBAyPOpN
         rc42VfqXGyJ/U5mP6unm7vcsiiQVC7/TRssYq8DoaTjK98prsG1w5eu79jNGDmugp5
         6TYIoqqeuVJtw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5HJI6lU3560061;
        Mon, 17 Jun 2019 12:18:06 -0700
Date:   Mon, 17 Jun 2019 12:18:06 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-qvqxfk9d0rn1l7lcntwiezrr@git.kernel.org>
Cc:     ast@kernel.org, linux-kernel@vger.kernel.org, hpa@zytor.com,
        tglx@linutronix.de, daniel@iogearbox.net, adrian.hunter@intel.com,
        songliubraving@fb.com, treeze.taeung@gmail.com,
        mathieu.poirier@linaro.org, kafai@fb.com, acme@redhat.com,
        yhs@fb.com, namhyung@kernel.org, suzuki.poulose@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        mingo@kernel.org, mike.leach@linaro.org
Reply-To: tglx@linutronix.de, hpa@zytor.com, linux-kernel@vger.kernel.org,
          ast@kernel.org, daniel@iogearbox.net, adrian.hunter@intel.com,
          acme@redhat.com, kafai@fb.com, mathieu.poirier@linaro.org,
          songliubraving@fb.com, treeze.taeung@gmail.com,
          namhyung@kernel.org, yhs@fb.com,
          alexander.shishkin@linux.intel.com, suzuki.poulose@arm.com,
          jolsa@redhat.com, mingo@kernel.org, mike.leach@linaro.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf config: Bail out when a handler returns
 failure for a key-value pair
Git-Commit-ID: 22d4621987faf651fee92c532a3eaba9a0e31ba0
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

Commit-ID:  22d4621987faf651fee92c532a3eaba9a0e31ba0
Gitweb:     https://git.kernel.org/tip/22d4621987faf651fee92c532a3eaba9a0e31ba0
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Thu, 6 Jun 2019 10:56:55 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 10 Jun 2019 15:50:01 -0300

perf config: Bail out when a handler returns failure for a key-value pair

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
 
