Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A4A9C4CEC4
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 16:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1465020835
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 16:08:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TQqgxpQ7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388217AbfIWQI2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 12:08:28 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39296 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387819AbfIWQIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 12:08:16 -0400
Received: by mail-pl1-f195.google.com with SMTP id s17so5224278plp.6
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 09:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hEw6NY5M2Jhu1QjE48KzJEVuyxHVkatyT3269XxLGmY=;
        b=TQqgxpQ7HQmVgDVqV7HrYin2y0u7zy7VtKMraO8LlIyWmnlJIRl3J90jSsm/6tboTi
         1tT6qLIC2RAcNeBwM56cD6sO3sRxN1O8gjgaE8ToFmbsSqCKQnqemRgEN1j9pEFd9Kkr
         Bbbm6ZBVJ2oFTXralq+Lx56we80H8zTzrtpV2r7e+zxBETseLoJT3u4JEvkXFaSFG+ng
         0pGju6cldDNrZtSQcZVX3YqjyFJpFGu5QRAaA45cAybKCKIbLv905Wadg64AIaqx1+eA
         R9xYF2Mccqj/fEqvnT7jSBR6nVQqSDWGNiXAJYwkbc2BfBgoQKveTieg89Ee7zVt0gSu
         6nCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hEw6NY5M2Jhu1QjE48KzJEVuyxHVkatyT3269XxLGmY=;
        b=qmzsZe97KDMX0KjYbMf+nLOGPwbQrWH8guhFqlT9ElGCYk99Lf1M4ErudXGIaiKKKW
         y67oEcwWVurNmtfV7TwNbilpqMfOnc62GUBH+W3P/iRy5JZrL8q32z5AmStjdaPiqlrX
         MXgvy1RoG2NDs/mDace3tQj3rHDWYzYylDOzljRUibrhZEpkdmp/W6MRyknzL3j0vwC5
         4cybnxxnhwo8ywIid+xdxvPoVvbs9m9MUbCwbHIImkBrUJtcwaVepq3iKZcrdGkxP6Fn
         qeXebBjZnRQLCOfZeaQjQ4woz/YlGo8CsR6g4HeLWIiNvjArAPKHJSwhTG3lKqI2/RjL
         Zq9w==
X-Gm-Message-State: APjAAAU6KyC9lSkzE/FtCWbdZ7ETaIjSUnpHSs+IAhuF13VCKtU9gQb4
        5p5LYiOGYZ5ma1lENuAcuLsUcw==
X-Google-Smtp-Source: APXvYqzYvstHngp+mpEkYmBTvKA704PC5takAGBvXAF4amCQPbuqmQn3+vdqDjFC0khug+QY1Yvzng==
X-Received: by 2002:a17:902:b086:: with SMTP id p6mr455657plr.315.1569254895147;
        Mon, 23 Sep 2019 09:08:15 -0700 (PDT)
Received: from localhost.localdomain ([12.206.46.62])
        by smtp.gmail.com with ESMTPSA id r1sm9880006pgv.70.2019.09.23.09.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2019 09:08:14 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mike Leach <mike.leach@linaro.org>,
        Coresight ML <coresight@lists.linaro.org>
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 3/5] perf cs-etm: Support branch filter
Date:   Tue, 24 Sep 2019 00:07:57 +0800
Message-Id: <20190923160759.14866-4-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190923160759.14866-1-leo.yan@linaro.org>
References: <20190923160759.14866-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If user specifies options -F,+callindent or call chain related options,
it means the user only cares about functions calls and returns; thus in
this case it's pointless to generate samples for other types of
branches.

To output only pairs of calls and returns, this patch introduces branch
filter and the filter is set according to synthetic options.  Finally,
perf can output only for calls and returns and without redundant
branches.

Before:

  # perf script -F,+callindent
            main  2808          1          branches:                 coresight_test1@plt                                  aaaaba8d37d8 main+0x14 (/root/coresight_test/main)
            main  2808          1          branches:                     coresight_test1@plt                              aaaaba8d367c coresight_test1@plt+0xc (/root/coresight_test/main)
            main  2808          1          branches:                     _init                                            aaaaba8d3650 _init+0x30 (/root/coresight_test/main)
            main  2808          1          branches:                     _dl_fixup                                        ffff86373b4c _dl_runtime_resolve+0x40 (/lib/aarch64-linux-gnu/ld-2.28.s
            main  2808          1          branches:                         _dl_lookup_symbol_x                          ffff8636e078 _dl_fixup+0xb8 (/lib/aarch64-linux-gnu/ld-2.28.so)
            main  2808          1          branches:                                                                      ffff8636a3f4 _dl_lookup_symbol_x+0x5c (/lib/aarch64-linux-gnu/ld-2.28.s
            main  2808          1          branches:                                                                      ffff8636a3f4 _dl_lookup_symbol_x+0x5c (/lib/aarch64-linux-gnu/ld-2.28.s
            main  2808          1          branches:                                                                      ffff8636a3f4 _dl_lookup_symbol_x+0x5c (/lib/aarch64-linux-gnu/ld-2.28.s
            main  2808          1          branches:                                                                      ffff8636a3f4 _dl_lookup_symbol_x+0x5c (/lib/aarch64-linux-gnu/ld-2.28.s
            main  2808          1          branches:                                                                      ffff8636a3f4 _dl_lookup_symbol_x+0x5c (/lib/aarch64-linux-gnu/ld-2.28.s
  [...]

After:

  # perf script -F,+callindent
            main  2808          1          branches:                 coresight_test1@plt                                  aaaaba8d37d8 main+0x14 (/root/coresight_test/main)
            main  2808          1          branches:                     _dl_fixup                                        ffff86373b4c _dl_runtime_resolve+0x40 (/lib/aarch64-linux-gnu/ld-2.28.s
            main  2808          1          branches:                         _dl_lookup_symbol_x                          ffff8636e078 _dl_fixup+0xb8 (/lib/aarch64-linux-gnu/ld-2.28.so)
            main  2808          1          branches:                             do_lookup_x                              ffff8636a49c _dl_lookup_symbol_x+0x104 (/lib/aarch64-linux-gnu/ld-2.28.
            main  2808          1          branches:                                 check_match                          ffff86369bf0 do_lookup_x+0x238 (/lib/aarch64-linux-gnu/ld-2.28.so)
            main  2808          1          branches:                                     strcmp                           ffff86369888 check_match+0x70 (/lib/aarch64-linux-gnu/ld-2.28.so)
            main  2808          1          branches:                 printf@plt                                           aaaaba8d37ec main+0x28 (/root/coresight_test/main)
            main  2808          1          branches:                     _dl_fixup                                        ffff86373b4c _dl_runtime_resolve+0x40 (/lib/aarch64-linux-gnu/ld-2.28.s
            main  2808          1          branches:                         _dl_lookup_symbol_x                          ffff8636e078 _dl_fixup+0xb8 (/lib/aarch64-linux-gnu/ld-2.28.so)
            main  2808          1          branches:                             do_lookup_x                              ffff8636a49c _dl_lookup_symbol_x+0x104 (/lib/aarch64-linux-gnu/ld-2.28.
            main  2808          1          branches:                                 _dl_name_match_p                     ffff86369af0 do_lookup_x+0x138 (/lib/aarch64-linux-gnu/ld-2.28.so)
            main  2808          1          branches:                                     strcmp                           ffff8636f7f0 _dl_name_match_p+0x18 (/lib/aarch64-linux-gnu/ld-2.28.so)
  [...]

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/cs-etm.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 6bdc9cd8293c..018c7e682ded 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -55,6 +55,7 @@ struct cs_etm_auxtrace {
 
 	int num_cpu;
 	u32 auxtrace_type;
+	u32 branches_filter;
 	u64 branches_sample_type;
 	u64 branches_id;
 	u64 instructions_sample_type;
@@ -1222,6 +1223,10 @@ static int cs_etm__synth_branch_sample(struct cs_etm_queue *etmq,
 	} dummy_bs;
 	u64 ip;
 
+	if (etm->branches_filter &&
+	    !(etm->branches_filter & tidq->prev_packet->flags))
+		return 0;
+
 	ip = cs_etm__last_executed_instr(tidq->prev_packet);
 
 	event->sample.header.type = PERF_RECORD_SAMPLE;
@@ -2638,6 +2643,13 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
 				session->itrace_synth_opts->thread_stack;
 	}
 
+	if (etm->synth_opts.calls)
+		etm->branches_filter |= PERF_IP_FLAG_CALL | PERF_IP_FLAG_ASYNC |
+					PERF_IP_FLAG_TRACE_END;
+	if (etm->synth_opts.returns)
+		etm->branches_filter |= PERF_IP_FLAG_RETURN |
+					PERF_IP_FLAG_TRACE_BEGIN;
+
 	err = cs_etm__synth_events(etm, session);
 	if (err)
 		goto err_delete_thread;
-- 
2.17.1

