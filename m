Return-Path: <SRS0=6Pxm=X6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7904C3E8AB
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 09:16:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAF572133F
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 09:16:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HBsvOaZB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727523AbfJEJQf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Oct 2019 05:16:35 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:39055 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfJEJQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 05:16:35 -0400
Received: by mail-qk1-f194.google.com with SMTP id 4so8174296qki.6
        for <linux-kernel@vger.kernel.org>; Sat, 05 Oct 2019 02:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Exi5UyL0PhH33Ps5pBXqP1xNMfxsYGUrj1r7XnToftM=;
        b=HBsvOaZBhNgUpos1V33McIYsUXTiRKItvww8OG7PAidxLUZJxFHXJ+BhcZmBe4YVHz
         L+kRN2TarhZKp6d4YLX3tyoMpHC0j8g8wMvJx1bItTgdhfx3GT/fgdqdHB8HYye/ZNvo
         crv5ALgNYzvEtIx75anB3HAwRMyRWjFH9z4LjYT/gJKwQab+uflqfn9ACGHxkkNxx04x
         thFAur1Zq8VCybtnzOvF7gkAJbnMy6NDN++wbeZOZG0ShJzLlVxcjxKO7e7uBH+OU1b9
         Gz3un43hxB0MrkdmCZbxdf9CgUsSwbUL9+7XoE5PVIFPZRQsClQL3S2EcjMA9LlPwk+q
         uikw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Exi5UyL0PhH33Ps5pBXqP1xNMfxsYGUrj1r7XnToftM=;
        b=aEkNUtMOar5bzRRAxWQjH5PCx0ZTkmy9jczS2ZiBtdTySZXsr7dh0aRNpN6CdWMXlS
         iJiUq/JQSLBkbH2slsxM1Gsis7/K2Bg3WYOq27MRt4lQ21ECPSTddu140wswWl8EM5aj
         DFiGZSujYgA65sCDHfk/N8DeJgyDFKDAQCKj40QGVPC5E4xBdkSlPqOg4x9Kypfb5mw3
         qJCY4ODCh2R0iqv3oTagAXbG09KOfgRpw3s52Rsy5zwP9lvFrCaF45FEQRrfgSe4JWKb
         5zlHi7huOLvItFBiS0/TrR2v8vKRlBH5RZ0Uwt3fytjAOmmr8AsmP28tFR6xjCZQeQmR
         HA9g==
X-Gm-Message-State: APjAAAVH7wgMrR97v0mOC1GpmzkgBuMJaA6LHE2+TNcv/hZqu6sUp0tZ
        ZpVamAul5tiDfJSUitfrr4JChA==
X-Google-Smtp-Source: APXvYqz0E7B560FCkqn4XP7U4uK6vA5nHplvaCeGOYvqT3lal/PIKxer0ocPHwmadlXJgUOHkRXcMA==
X-Received: by 2002:a37:a695:: with SMTP id p143mr14707173qke.144.1570266993361;
        Sat, 05 Oct 2019 02:16:33 -0700 (PDT)
Received: from localhost.localdomain (li937-157.members.linode.com. [45.56.119.157])
        by smtp.gmail.com with ESMTPSA id u132sm4384621qka.50.2019.10.05.02.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2019 02:16:32 -0700 (PDT)
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
Subject: [PATCH v3 0/6] perf cs-etm: Support thread stack and callchain
Date:   Sat,  5 Oct 2019 17:16:08 +0800
Message-Id: <20191005091614.11635-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds support for thread stack and callchain.

Patch 01 is to fix the unsigned variable comparison to zero; patch 02 is
to refactor the instruction size calculation; these two patches are
preparation for patch 03.

Patch 03 is to add thread stack support, after applying this patch the
option '-F,+callindent' can be used by perf script tool; patch 04 is to
add branch filter thus the Perf tool can display branch samples only
for function calls and returns after enable the call indentation or call
chain related options.

Patch 05 is to synthesize call chain for the instruction samples.

Patch 06 allows the instruction sample can be handled synchronously with
the thread stack, thus it fixes an error for the callchain generation.

This patch set has been tested on 96boards Hikey620 after applied on
perf/core branch with latest commit f7bf75a78095 ("perf annotate: Don't
return -1 for error when doing BPF disassembly").


Test for option '-F,+callindent':

Before:

  # perf script -F,+callindent
            main  2808          1          branches: coresight_test1                      ffff8634f5c8 coresight_test1+0x3c (/root/coresight_test/libcstest.so)
            main  2808          1          branches: printf@plt                           aaaaba8d37ec main+0x28 (/root/coresight_test/main)
            main  2808          1          branches: printf@plt                           aaaaba8d36bc printf@plt+0xc (/root/coresight_test/main)
            main  2808          1          branches: _init                                aaaaba8d3650 _init+0x30 (/root/coresight_test/main)
            main  2808          1          branches: _dl_fixup                            ffff86373b4c _dl_runtime_resolve+0x40 (/lib/aarch64-linux-gnu/ld-2.28.so)
            main  2808          1          branches: _dl_lookup_symbol_x                  ffff8636e078 _dl_fixup+0xb8 (/lib/aarch64-linux-gnu/ld-2.28.so)
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


Test for option '--itrace=g':

Before:

  # perf script --itrace=g16l64i100
            main  1579        100      instructions:  ffff0000102137f0 group_sched_in+0xb0 ([kernel.kallsyms])
            main  1579        100      instructions:  ffff000010213b78 flexible_sched_in+0xf0 ([kernel.kallsyms])
            main  1579        100      instructions:  ffff0000102135ac event_sched_in.isra.57+0x74 ([kernel.kallsyms])
            main  1579        100      instructions:  ffff000010219344 perf_swevent_add+0x6c ([kernel.kallsyms])
            main  1579        100      instructions:  ffff000010214854 perf_event_update_userpage+0x4c ([kernel.kallsyms])
  [...]

After:

  # perf script --itrace=g16l64i100

  main  1579        100      instructions:
          ffff000010213b78 flexible_sched_in+0xf0 ([kernel.kallsyms])
          ffff00001020c0b4 visit_groups_merge+0x12c ([kernel.kallsyms])

  main  1579        100      instructions:
          ffff0000102135ac event_sched_in.isra.57+0x74 ([kernel.kallsyms])
          ffff0000102137a0 group_sched_in+0x60 ([kernel.kallsyms])
          ffff000010213b84 flexible_sched_in+0xfc ([kernel.kallsyms])
          ffff00001020c0b4 visit_groups_merge+0x12c ([kernel.kallsyms])

  main  1579        100      instructions:
          ffff000010219344 perf_swevent_add+0x6c ([kernel.kallsyms])
          ffff0000102135f4 event_sched_in.isra.57+0xbc ([kernel.kallsyms])
          ffff0000102137a0 group_sched_in+0x60 ([kernel.kallsyms])
          ffff000010213b84 flexible_sched_in+0xfc ([kernel.kallsyms])
          ffff00001020c0b4 visit_groups_merge+0x12c ([kernel.kallsyms])
  [...]


Changes from v2:
* Added patch 01 to fix the unsigned variable comparison to zero
  (Suzuki).
* Refined commit logs.

Changes from v1:
* Added comments for task thread handling (Mathieu).
* Split patch 02 into two patches, one is for support thread stack and
  another is for callchain support (Mathieu).
* Added a new patch to support branch filter.


Leo Yan (6):
  perf cs-etm: Fix unsigned variable comparison to zero
  perf cs-etm: Refactor instruction size handling
  perf cs-etm: Support thread stack
  perf cs-etm: Support branch filter
  perf cs-etm: Support callchain for instruction sample
  perf cs-etm: Synchronize instruction sample with the thread stack

 tools/perf/util/cs-etm.c | 145 ++++++++++++++++++++++++++++++++-------
 1 file changed, 120 insertions(+), 25 deletions(-)

-- 
2.17.1

