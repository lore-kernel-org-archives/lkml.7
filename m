Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB31DCA9EA0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 00:54:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87A732084B
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 00:54:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G3+2N9hR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732184AbfJWAyA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 20:54:00 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:34664 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728353AbfJWAx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 20:53:59 -0400
Received: by mail-pl1-f202.google.com with SMTP id 70so11604262ple.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 17:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=hTNszrLwiWQM9d4qPLewL0yEQ/cfDBLkldVagVLEUe8=;
        b=G3+2N9hR6CXSywV/BCG9jOzcYqmnnIcMKGmlNKEdFehcbxSmPwGHWUEGPxsOqi0UPp
         8M0SlH5BoyojTAmdI60I4dOtJ3aXm2zJJGSdETJyBFUEkUQv9JxUsiYcbWUeWnW6HR9M
         moMWeOLseXW3m+Ak1+9LsOXvbUUOmsHD1W8OOdKwYcVxOlF4J7ok5HWpf4mmtd3i0SUx
         jBxJiJYqlILVQ6WdIpWFFB/NYBoD3pg2UcQPJLrNqXMllSQomgO8rX4ZapAE76zjdLjW
         REN4Hu+gnSTSl53QCKw5BI2Z+WrADhrHAvaBO2pETg5rxfgSXkYFcIhpaoubzbm9GkAj
         uO8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=hTNszrLwiWQM9d4qPLewL0yEQ/cfDBLkldVagVLEUe8=;
        b=RSx3TyypwGfWQLqYUln1sRSvSGcJOTPNy+1zSnV7w//CA5xPuzjWyGLqxYBUMcMUPS
         n1ZMUGzhTdVCUKAh4MIOY23uTEdTf+K0g5x/6uPgn4LrZ6960TdVeNpyQeE201nWmldf
         IqhHe251BMWH8M83uPX5w7B/Mnfk0s6chJbrT76a4BNVwPomH2LgjqEGY8IMOzgIrDcx
         CoPIWzF5imcmSus6DA7d9yAmWnR2HkD22soU+4CZZXFtwmdVcU7/9E5z2FyK/IsEuuv0
         g9otgTyiBDGAesUEUN+R3I4aC9E3sl04j5Jn6vmBb3nM3E/YDegeD3dTS1S1om6jm5Bh
         bWKQ==
X-Gm-Message-State: APjAAAUG/BnfISZ5bhCZENTmxYXQ4bsmK628Ucfq1zhPSIiWbC58RQjS
        F4efR6bHmoW1DRmEjXPJqYwCaR0MKFtl
X-Google-Smtp-Source: APXvYqzYOzdcq5nCtM6xX1BGWadrzL6Bve96/TmAwvY8X0RhJGLPOQH1XzQWxptmeVhcoCUBfC4g1K9JIAd4
X-Received: by 2002:a63:e255:: with SMTP id y21mr3404951pgj.353.1571792038384;
 Tue, 22 Oct 2019 17:53:58 -0700 (PDT)
Date:   Tue, 22 Oct 2019 17:53:28 -0700
In-Reply-To: <20191017170531.171244-1-irogers@google.com>
Message-Id: <20191023005337.196160-1-irogers@google.com>
Mime-Version: 1.0
References: <20191017170531.171244-1-irogers@google.com>
X-Mailer: git-send-email 2.23.0.866.gb869b98d4c-goog
Subject: [PATCH v2 0/9] Improvements to memory usage by parse events
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

The parse events parser leaks memory for certain expressions as well as
allowing a char* to reference stack, heap or .rodata. This series of patches
improves the hygeine and adds free-ing operations to reclaim memory in
the parser in error and non-error situations.

The series of patches was generated with LLVM's address sanitizer and
libFuzzer:
https://llvm.org/docs/LibFuzzer.html
called on the parse_events function with randomly generated input. With
the patches no leaks or memory corruption issues were present.

These patches are preferable to an earlier proposed patch:
   perf tools: avoid reading out of scope array

Ian Rogers (9):
  perf tools: add parse events append error
  perf tools: splice events onto evlist even on error
  perf tools: ensure config and str in terms are unique
  perf tools: move ALLOC_LIST into a function
  perf tools: avoid a malloc for array events
  perf tools: add destructors for parse event terms
  perf tools: before yyabort-ing free components
  perf tools: if pmu configuration fails free terms
  perf tools: add a deep delete for parse event terms

 tools/perf/util/parse-events.c | 177 ++++++++++-----
 tools/perf/util/parse-events.h |   3 +
 tools/perf/util/parse-events.y | 388 ++++++++++++++++++++++++---------
 tools/perf/util/pmu.c          |  38 ++--
 4 files changed, 431 insertions(+), 175 deletions(-)

-- 
2.23.0.866.gb869b98d4c-goog

