Return-Path: <SRS0=6Pxm=X6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67B0DC3E8AB
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 09:17:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 300EA2133F
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 09:17:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iK2pdsCd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbfJEJRA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Oct 2019 05:17:00 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:42686 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfJEJQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 05:16:58 -0400
Received: by mail-qk1-f193.google.com with SMTP id f16so8147889qkl.9
        for <linux-kernel@vger.kernel.org>; Sat, 05 Oct 2019 02:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eKAXVWwQgPpjvwNZSw/jMr+jLfq8J9kO6B2NrEvZfHo=;
        b=iK2pdsCdWaOc1I0g+2fPqCFgiDMtjeHznV8u0RGoNSxR8r/zz+UYDQ0+NvkRupaUGl
         3m76XCA2lDeeOinMME+ErfKvXxK2G8UHBsyoH/Fvz6ZfGk4lwVSoamSf1KBuCIuCOD+Z
         q2MqqEpomwpsiLrsTLEfpRF1HcHjXw9avjBNhTyTm4FhdFjo29aQv4ofZtb2acJtYf6a
         GWXNFhxPMhBT4Fp8Mo42tYkrsYvjNNUG9H80iO1vYqEey9Kk9CLgr5/Z3ELokdaKIicn
         ylgrNGAUUpkum2dx/jbMU+BD/S7TjVHZVT3v3CQGJM7D2N26oyS0i+AlXh8ZBOtErEtv
         hB4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eKAXVWwQgPpjvwNZSw/jMr+jLfq8J9kO6B2NrEvZfHo=;
        b=Yee7/4hpnT9iZf+K/Tv8yETmBUiyDEpRRGLGKAJ/q5XH4zgVYPMaiOAH5avXfPwsJw
         +afc/KtbejOoSZVnNNuC61g5GGA8xLK8jUnf8oPFmkgZQi+fFofbr/aWPAUFvBkgxyMj
         VO4z1XoeK7J5m1eEl16dmh779JSc3dys7zdqic0/hYRkL0AVTosgqdz17QPQs8K7FYJG
         tF9+pjTCxd19pI/BIl2uOyVi+cUKGhpdXKsPXNVMmsbRmbA/o7yXJR1nwEvm9z1K/bP/
         nRXFJ2ZN4E3VMqYpcc+WH2E7N0J4BVVXaxIVQvTc6/WLbEhPiN6BklqnDTtVfEYNYDYy
         CrMQ==
X-Gm-Message-State: APjAAAU1tlCFhJxIuaipXhgWsP0FtPiO5iRdQ8EPTsYr5EOTihUeAxuV
        zSddnAPM4Qxln7Xo7gahPKxRRg==
X-Google-Smtp-Source: APXvYqwev03+HLZf+Xm7qZD7x4pEtZFPcBIJhW5afdaPDbV1ZTQQxjNVZ1W3wOk+BkTcdqdSwLifdg==
X-Received: by 2002:a37:a612:: with SMTP id p18mr13816710qke.56.1570267017479;
        Sat, 05 Oct 2019 02:16:57 -0700 (PDT)
Received: from localhost.localdomain (li937-157.members.linode.com. [45.56.119.157])
        by smtp.gmail.com with ESMTPSA id u132sm4384621qka.50.2019.10.05.02.16.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2019 02:16:56 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mike Leach <mike.leach@linaro.org>,
        Coresight ML <coresight@lists.linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v3 4/6] perf cs-etm: Support branch filter
Date:   Sat,  5 Oct 2019 17:16:12 +0800
Message-Id: <20191005091614.11635-5-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191005091614.11635-1-leo.yan@linaro.org>
References: <20191005091614.11635-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If user specifies option '-F,+callindent' or call chain related options,
it means users only care about function calls and returns; for these
cases, it's pointless to generate samples for the branches within
function.  But unlike other hardware trace handling (e.g. Intel's pt or
bts), Arm CoreSight doesn't filter branch types for these options and
generate samples for all branches, this causes Perf to output many
spurious blanks if the branch is not a function call or return.

To only output pairs of calls and returns, this patch introduces branch
filter and the filter is set according to synthetic options.  Finally,
Perf can output only for calls and returns and avoid to output other
unnecessary blanks.

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
index 780abbfd1833..4b42f9c9bd34 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -56,6 +56,7 @@ struct cs_etm_auxtrace {
 
 	int num_cpu;
 	u32 auxtrace_type;
+	u32 branches_filter;
 	u64 branches_sample_type;
 	u64 branches_id;
 	u64 instructions_sample_type;
@@ -1223,6 +1224,10 @@ static int cs_etm__synth_branch_sample(struct cs_etm_queue *etmq,
 	} dummy_bs;
 	u64 ip;
 
+	if (etm->branches_filter &&
+	    !(etm->branches_filter & tidq->prev_packet->flags))
+		return 0;
+
 	ip = cs_etm__last_executed_instr(tidq->prev_packet);
 
 	event->sample.header.type = PERF_RECORD_SAMPLE;
@@ -2639,6 +2644,13 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
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

