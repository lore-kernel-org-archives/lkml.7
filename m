Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95C83C28EB2
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 09:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E46F2064A
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 09:49:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SdjqbUbT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbfFFJtE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 05:49:04 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:36723 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727842AbfFFJtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 05:49:04 -0400
Received: by mail-yw1-f67.google.com with SMTP id t126so622140ywf.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 02:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=yNb0Fj6n9km2JVdDN9Uekf1sOIr2hggzzvNxUDiKBF4=;
        b=SdjqbUbT1cHno2hjuwgq87mWDphOAtQJ3FRy/UQjLOeTmvC55V0Paqyc5eIT5UTaMj
         kaJ3QT3w1DVNOSN5D3oLm0P4DQzS510cF7JEkzDKyuyjahqcyCWY12YOxQNf5R7lU6xF
         3pp+d5hH3tKDwybV4X5mikJ9G/i4ePHmNy6EQaA++MHvQ+BPipVeCGbbBFA8uJ6VWxyq
         +vmRcD0ZEJjSlUQrWXH7zTk1ibmyZe7vX7oG8jggMKi1h3yxgWTKiPyxX8aIJyXL7ESV
         etzXHJHh9udMFILd7limdtRD6uX4XryAKpHGZfke5kvmeTxtsFcSugKCsKeu9KI++MPf
         BL9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=yNb0Fj6n9km2JVdDN9Uekf1sOIr2hggzzvNxUDiKBF4=;
        b=K5n13Lk57DD86+xVJ3hKm14BWvnqy65TXCV0I/aYB97SMCXCIxuVgqM4I+MPyQ0Ft4
         VjO+H5Rq2Uj/AOb3sS3qoktNNDhq2WAgDjzQ+koyESEQtCWI8C7c9/Hj33ffBLEL94PP
         Bzr1hlaoeUXMvPb6VyhAeuo5uXp1V4r3TKwc0M4f0TP1KAyCuCgUqGbjKtorWjfECRWN
         PUNO1KwF+s4+Vwbc89jXP9WOeywBklgyhHzUz8a90hrLg4q9hiIZN5AyoYqxAjSmiOCV
         KnPA8gbFXFNnJGwLO02CgYXdvblepjHqofHD6TO5tgIHETPSGikA6yizbADQ/5OHXd//
         UAPQ==
X-Gm-Message-State: APjAAAXgkS1QXEQ+SSbJrNeg7rI1ePKverVMDPf1oq9zDutBRsisSKot
        nLuo5hC70Ia/lIJU1Qz/uW9AJQ==
X-Google-Smtp-Source: APXvYqxz0XWfsmbzfDmzbRe2redmsNqGmSe1BzZBfwxV8y9htux3O/q5LgublDbdDBqLOTH72HI2fA==
X-Received: by 2002:a81:1d13:: with SMTP id d19mr22128098ywd.490.1559814542843;
        Thu, 06 Jun 2019 02:49:02 -0700 (PDT)
Received: from localhost.localdomain (li1322-146.members.linode.com. [45.79.223.146])
        by smtp.gmail.com with ESMTPSA id 85sm357652ywm.64.2019.06.06.02.48.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jun 2019 02:49:02 -0700 (PDT)
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
Subject: [PATCH v2 0/4] perf augmented_raw_syscalls: Support for arm64
Date:   Thu,  6 Jun 2019 17:48:41 +0800
Message-Id: <20190606094845.4800-1-leo.yan@linaro.org>
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

Changes from v1:
* Removed duplicated macro and aligned the numbers indention for arm64.

Leo Yan (4):
  perf trace: Exit when build eBPF program failure
  perf augmented_raw_syscalls: Remove duplicate macros
  perf augmented_raw_syscalls: Support arm64 raw syscalls
  perf augmented_raw_syscalls: Document clang configuration

 tools/perf/builtin-trace.c                    |   8 ++
 .../examples/bpf/augmented_raw_syscalls.c     | 101 +++++++++++++++++-
 2 files changed, 108 insertions(+), 1 deletion(-)

-- 
2.17.1

