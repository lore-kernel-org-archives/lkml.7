Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61A9EC4CECF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 16:08:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AA9120882
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 16:08:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XaxFwbhJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387943AbfIWQIN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 12:08:13 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37821 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387552AbfIWQIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 12:08:12 -0400
Received: by mail-pf1-f196.google.com with SMTP id y5so9405184pfo.4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 09:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=IXxi2vrfMEVupNAeuIgNvmrAUxH/Gbkd/cQqi7Ofrvc=;
        b=XaxFwbhJs4+dHHi4UZw+oyLADuuSENg6feC1z1Y/ni+BdyXP8ZTlVLiDYaAKfDcuoo
         dScW/EqLIAl+j7jF2RBQyu27w7jyrVvb93TrhyY8a5bo1cUw0ywH9kowAOpld+hhPYbR
         eoJrnLtgoZs72AP7Fkg4zt3mpg3eGr/Dg1VrcXKEcu390hda3pBXLsbeJXbE4Fq7AL5x
         j1mTe+mKgHoPUXIL0a4xpDNz6zNrTWq91vOmZcgeSetKUnRIdFxeHGq6mkm91YLxoiVD
         UQydRkx29Z1jhELzu7LmGYnUeGgmYVo4xALy6l6cmlOTWA/m4yMhQUFqL/mIns9xq9ub
         iwSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=IXxi2vrfMEVupNAeuIgNvmrAUxH/Gbkd/cQqi7Ofrvc=;
        b=fXXoRbadikoT893aGigxOXY2uDCu/7SsR/JDU2KK6PCiQ3HF33mf+qeEcn2jPh+/zD
         G0J0fXYhYhFD26F4DbxkAZjlYd3tldK9kXllo+l7ZYpAmfrRDlAwSpuyLodDiTWP1c/C
         O++mDq8oqzZ+BUzKtAdfCo4HoFkCRmTUtyNy1c5lIHOTutDevgg+/t/2S57BThQmlhjx
         W2kW0QKTtGWgs0lK5pU8b13zxi8YG0OOv0Yp1TKjCDYvxTGmJnRWwgAi+fbVU9gBCSOb
         8GFhwYGRlpX0ZLsVv3HqjvmXfRmV5oH6qcSiLKFOdmJK4YMDx9YdIzy3GgC0qVrodQ+B
         5IUw==
X-Gm-Message-State: APjAAAU/IBkwmcTtikpchUYxXdDSJEPuXNU1XK7DK9WsDUjW+a2emtBp
        Yi/I9t2bnwtg6qG8/A/gIFzLHg==
X-Google-Smtp-Source: APXvYqyz0At433mF0rIBUpJte9BNhdnS9QFusRpbTm21jinv7d5XiR4XWFf8cSw4p/B0nU+/LQ9NsA==
X-Received: by 2002:a63:5f47:: with SMTP id t68mr658004pgb.363.1569254890911;
        Mon, 23 Sep 2019 09:08:10 -0700 (PDT)
Received: from localhost.localdomain ([12.206.46.62])
        by smtp.gmail.com with ESMTPSA id r1sm9880006pgv.70.2019.09.23.09.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2019 09:08:10 -0700 (PDT)
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
Subject: [PATCH v2 0/5] perf cs-etm: Support thread stack and callchain
Date:   Tue, 24 Sep 2019 00:07:54 +0800
Message-Id: <20190923160759.14866-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds support for thread stack and callchain.

Patch 01 is to refactor the instruction size calculation and it is a
preparation for patch 02.

Patch 02 is to add thread stack support, after applying this patch then
the option '-F,+callindent' can be used by perf script tool; patch 03
is to add branch filter thus the perf tool can only display function
calls and returns after enable the call indentation or call chain
related options.  Patch 04 is the patch to synthesize call chain for the
instruction samples.

Patch 05 allows the instruction sample can be handled synchronously with
the thread stack, thus it fixes an error for the callchain generation.

This patch set has been tested on 96boards Hikey620.


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


Changes from v1:
* Added comments for task thread handling (Mathieu).
* Split patch 02 into two patches, one is for support thread stack and
  another is for callchain support (Mathieu).
* Added a new patch to support branch filter.


Leo Yan (5):
  perf cs-etm: Refactor instruction size handling
  perf cs-etm: Support thread stack
  perf cs-etm: Support branch filter
  perf cs-etm: Support callchain for instruction sample
  perf cs-etm: Correct callchain for instruction sample

 tools/perf/util/cs-etm.c | 141 ++++++++++++++++++++++++++++++++-------
 1 file changed, 118 insertions(+), 23 deletions(-)

-- 
2.17.1

