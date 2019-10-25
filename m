Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6CEECA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 18:09:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B4F321D7F
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 18:09:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AItMRH1U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387634AbfJYSJA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 14:09:00 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:50975 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732979AbfJYSIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 14:08:36 -0400
Received: by mail-pg1-f201.google.com with SMTP id r24so2338207pgj.17
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 11:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=kVRScVzVdmvaFoKwm7QtsLTFIeCMqlMKNHJqjiwIzwM=;
        b=AItMRH1UHy5LoenPDuyGkF1OiRvd0m877S2ToMuZivwha+hreqICwLyqyN9Ru2Y3vi
         deNqYrxmehH1S8leYnGzbZ4xYWQLuSEWdSeDdaeAOKcvVmk7a5CSvPsAdouwQJpw3iCT
         n2cLjvCsPvN6FiMbHKWUfiTAwXkiXJRhLpsaN2OXL26vA2wHypi9uFh/7qkxG3lHwCR2
         /IhupQ0bfr/hjyWVoMWXmmkEEkqPngb16yymwoKxhdzQhAapCGT7NOCnVPusDeGPFTLD
         geiDwPXy31fWFC4WLVMn2vnjZK/DSxYngLBmwARl64D+PXeGTcryng5l2NkuDZ5GUQYG
         ymGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=kVRScVzVdmvaFoKwm7QtsLTFIeCMqlMKNHJqjiwIzwM=;
        b=ZhGyAKfsZ6pugYJkJkkLP831+89j5JHkXmO+HeJ94CQRLPaBO1kOcMP7MwsqV5X0dK
         5OiCljFjpEDrR9c4++dr26OIzEEq6V9vRErLZ+GtV0A4YZDaqTyQ5WuXHVFlrNP/jJRw
         VdkfQN6j1G9C7IyZqwulQxd0JiNwwvmPcSiYJaHPZi9wNSGSWXeL1l/rnAbpSbDwPzkn
         UNeNwrb9ACPrdUUvdZVYVVZovtgBBaKlJUk/UUdadp0waU3Z9eRYr+IgJ/VfnNyIOM7K
         5cvJAR7iqpjPQWfj19+d5O+o6Ow+oY8lZZ9Y9EeFth53E6BT4V5c1Nero9Fda8Fflvlz
         MlZg==
X-Gm-Message-State: APjAAAUGOTI+oiGwG7X5U20+9E3+R+Lh9jlZWVmGVVE3d1vfjJJMDSMA
        CSi4SP9F/EpTkbMN2oJJMK2onqOocWxK
X-Google-Smtp-Source: APXvYqynPqIJ4hVRg5XDUe9xe9kDv4LxessSXAhwz9Vr0geBG3zYf3JlIDqhF3KzgC8ZV8hsDgy+TiNc8doq
X-Received: by 2002:a65:6456:: with SMTP id s22mr5837656pgv.287.1572026915558;
 Fri, 25 Oct 2019 11:08:35 -0700 (PDT)
Date:   Fri, 25 Oct 2019 11:08:18 -0700
In-Reply-To: <20191024190202.109403-1-irogers@google.com>
Message-Id: <20191025180827.191916-1-irogers@google.com>
Mime-Version: 1.0
References: <20191024190202.109403-1-irogers@google.com>
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
Subject: [PATCH v4 0/9] Improvements to memory usage by parse events
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, clang-built-linux@googlegroups.com
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The parse events parser leaks memory for certain expressions as well
as allowing a char* to reference stack, heap or .rodata. This series
of patches improves the hygeine and adds free-ing operations to
reclaim memory in the parser in error and non-error situations.

The series of patches was generated with LLVM's address sanitizer and
libFuzzer:
https://llvm.org/docs/LibFuzzer.html
called on the parse_events function with randomly generated input. With
the patches no leaks or memory corruption issues were present.

The v4 patches address review comments from Jiri Olsa, turning a long
error message into a single warning, fixing the data type in a list
iterator and reordering patches.

The v3 patches address review comments from Jiri Olsa improving commit
messages, handling ENOMEM errors from strdup better, and removing a
printed warning if an invalid event is passed.

The v2 patches are preferable to an earlier proposed patch:
   perf tools: avoid reading out of scope array

Ian Rogers (9):
  perf tools: add parse events handle error
  perf tools: move ALLOC_LIST into a function
  perf tools: avoid a malloc for array events
  perf tools: splice events onto evlist even on error
  perf tools: ensure config and str in terms are unique
  perf tools: add destructors for parse event terms
  perf tools: before yyabort-ing free components
  perf tools: if pmu configuration fails free terms
  perf tools: add a deep delete for parse event terms

 tools/perf/util/parse-events.c | 177 ++++++++++-----
 tools/perf/util/parse-events.h |   3 +
 tools/perf/util/parse-events.y | 388 ++++++++++++++++++++++++---------
 tools/perf/util/pmu.c          |  32 +--
 4 files changed, 433 insertions(+), 167 deletions(-)

-- 
2.24.0.rc0.303.g954a862665-goog

