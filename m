Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02524C28D1B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 07:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF24E20868
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 07:56:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JYJ+BH8p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726835AbfFFH4l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 03:56:41 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:38128 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbfFFH4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 03:56:40 -0400
Received: by mail-yb1-f195.google.com with SMTP id x7so604359ybg.5
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 00:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=5zxl/1kwHqAI4DRUEiMT/LtSxO6kWAE0NYYYjCPxIgw=;
        b=JYJ+BH8ph9BynXcTk2T/3rfh/N0Ej+7xz1AMhk6isvVyWzHAuJc/sM8EEU+qAcYtvl
         BAxgMC7pwl1YD2LI1XPyg1yT0FesASXKl7La/mTM9ibgfsmC/hJ3YYuBUQ76nPx1cXT8
         /wxcxr4b/GImAmIEFcbo/ufvJh6kqnUJJbztB6Tk5TB/n2VYGPO/fXFEJ/edIwOm6mnK
         hn7QrepywI0oofHP87M/f5zrj4UgwXMzpppSSCxAIu9s2tRr+IbB4g0APtILtcFMk/Ho
         xYMPWajy77pzC5mzpW7AXUsZQSEgWcNeMcjl3lhMNJyldTfbD9Na5CsLCdbrV7wWpM0Z
         gNqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5zxl/1kwHqAI4DRUEiMT/LtSxO6kWAE0NYYYjCPxIgw=;
        b=YwNnnyB6IgNPpMmemidQLGqkUNluB1uG2HfY09x2+0CtqPkc9jveOhzZTA0AX5s6bW
         t8Z9dCyCUfUnJUVLYxS46pzcZwux9mWGSY9FHpcQ1sUeDHO391eLDw0NUUuu1MuF9Ecl
         o+zfwP51FC/RXcRMhdA1nJdutBG/t5VtEyPAufd3bjtoYuoDrK7PsIseo5rcFEJihqKz
         gUaYm9Th45eYunlzf0Yq964p94PB7wsGqu7tjL4C5UH3N5rMD8tm2wz2vwK5gBd19z9p
         Z8QIFMignF7AZraNQoQfefvVISIVmy1uVa/DnNS5F2VHmLNP4XnaUH3kEWmUyW1yNjHN
         7UOA==
X-Gm-Message-State: APjAAAUponGqypbMx3diIHlumM9a129h05TElYPLr2WlZ/4v+EfLAEW4
        aZ5B1i80ztCegrWBZ0e3AVLvQQ==
X-Google-Smtp-Source: APXvYqzdoeciY6MLysk++kMEtzU9vvDXtgdZswYM+X9azUgBXZKQokrV4uheSAdrBO38BdvIhQn58A==
X-Received: by 2002:a25:19d6:: with SMTP id 205mr3559544ybz.135.1559807799726;
        Thu, 06 Jun 2019 00:56:39 -0700 (PDT)
Received: from localhost.localdomain (li1322-146.members.linode.com. [45.79.223.146])
        by smtp.gmail.com with ESMTPSA id 14sm316343yws.16.2019.06.06.00.56.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jun 2019 00:56:38 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 0/4] perf augmented_raw_syscalls: Support for arm64
Date:   Thu,  6 Jun 2019 15:56:13 +0800
Message-Id: <20190606075617.14327-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When I tried to run the trace on arm64 platform with eBPF program
augmented_raw_syscalls, it reports several failures for eBPF program
compilation.  So tried to resolve these issues and this patch set is
the working result.

0001 patch lets perf command to exit directly if find eBPF program
building failure.

0002 patch is minor refactoring code to remove duplicate macro.

0003 patch is to add support arm64 raw syscalls numbers.

0004 patch is to document clang configuration so that can easily use
this program on both x86_64 and aarch64 platforms.


Leo Yan (4):
  perf trace: Exit when build eBPF program failure
  perf augmented_raw_syscalls: Remove duplicate macros
  perf augmented_raw_syscalls: Support arm64 raw syscalls
  perf augmented_raw_syscalls: Document clang configuration

 tools/perf/builtin-trace.c                    |   8 ++
 .../examples/bpf/augmented_raw_syscalls.c     | 102 +++++++++++++++++-
 2 files changed, 109 insertions(+), 1 deletion(-)

-- 
2.17.1

