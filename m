Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3044C28EB3
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 09:49:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87A7B20868
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 09:49:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qq8fspWR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728314AbfFFJti (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 05:49:38 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:42279 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727540AbfFFJth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 05:49:37 -0400
Received: by mail-yb1-f193.google.com with SMTP id c7so694492ybs.9
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 02:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dIuWqahxwYfa+gg7zLducBqFVlvQ5xNUBiX7691YYJI=;
        b=qq8fspWRrqRd4zZSm3WIi14g0uJacA6l8DkDjMrJY/bMSxeY2EIj0GoZzMXUXP8QoU
         6C86B8kbB9ZhEK+PAtWX+isJfxsQkWKmYjFAWqO2JDQ/dYLMAI5BGZGx0S19LVPeJq94
         QU+u2HEv9nrLxTpshbbh99HmPOGIlkROXPehcUXk3Anb14Fgh+r5nRzdLVI77v4wPQYT
         lz9s1ZSBkQqVp9DESR3lTtAkU2NR9z+JrxvZoUFHHBtlUVtpS6jgAIhpojIJ+QwVddHF
         y3w7m6xGqYbkZNDokLtGCWDLAH1d8xn3AdHjCmzen9xdJbYGz97LCv8PHHauBFIWYsik
         IXAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dIuWqahxwYfa+gg7zLducBqFVlvQ5xNUBiX7691YYJI=;
        b=tjzs+OnZDETodOqJuWNMIpgpo2wPJRnzvMJjJxzuMP/FcmvePtwQ8gEAoRhj8PlJnO
         A0V9fvIKQBZAG68KYjN/x9Tu1kEBqG8UmyimvNtyFx3EMwqsJ1/xTdbhS8np5LXnXhg6
         6kftT58CBJnVe6UsYCzcWAUYdrxex8cmjymAo8555rVlvEJlkCrHSXWguYUC2Cw5Sorp
         dHEQbAgG5ZE9Esi/4sDyD+xcK9XtmKDSilzwYr92udD8l1d3JL5obr2qI7nEL7IcGB1g
         JiOAVbEwd6KhIgegElvbOSo2HSSvjYn77lAeTthQszbYnqC/8bLNc09rCWG5OldoGFAI
         G29g==
X-Gm-Message-State: APjAAAUovw8oAPGVMm+CuyZmKbk98bethcmxWehT16iIktlJS49xcAkd
        VqnqAkYIPS43VIMI3LpyiFUDmw==
X-Google-Smtp-Source: APXvYqwrJDTIobkNOyLW8fbKSaKsQtwcXguk6M+HLUwD9mhc6kEqLYUvnDMOljy2J5eLgh4IlkezEQ==
X-Received: by 2002:a25:84c5:: with SMTP id x5mr13331854ybm.78.1559814576552;
        Thu, 06 Jun 2019 02:49:36 -0700 (PDT)
Received: from localhost.localdomain (li1322-146.members.linode.com. [45.79.223.146])
        by smtp.gmail.com with ESMTPSA id 85sm357652ywm.64.2019.06.06.02.49.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jun 2019 02:49:36 -0700 (PDT)
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
Subject: [PATCH v2 4/4] perf augmented_raw_syscalls: Document clang configuration
Date:   Thu,  6 Jun 2019 17:48:45 +0800
Message-Id: <20190606094845.4800-5-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190606094845.4800-1-leo.yan@linaro.org>
References: <20190606094845.4800-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To build this program successfully with clang, there have three
compiler options need to be specified:

  - Header file path: tools/perf/include/bpf;
  - Specify architecture;
  - Define macro __NR_CPUS__.

This patch add comments to explain the reasons for building failure and
give two examples for llvm.clang-opt variable, one is for x86_64
architecture and another is for aarch64 architecture.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 .../examples/bpf/augmented_raw_syscalls.c     | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tools/perf/examples/bpf/augmented_raw_syscalls.c b/tools/perf/examples/bpf/augmented_raw_syscalls.c
index a3701a4daf2e..fb6987edab2c 100644
--- a/tools/perf/examples/bpf/augmented_raw_syscalls.c
+++ b/tools/perf/examples/bpf/augmented_raw_syscalls.c
@@ -6,6 +6,25 @@
  *
  * perf trace -e tools/perf/examples/bpf/augmented_raw_syscalls.c cat /etc/passwd > /dev/null
  *
+ * This program include two header files 'unistd.h' and 'pid_filter.h', which
+ * are placed in the folder tools/perf/include/bpf, but this folder is not
+ * included in env $KERNEL_INC_OPTIONS and it leads to compilation failure.
+ * For building this code, we also need to specify architecture and define macro
+ * __NR_CPUS__.  To resolve these issues, variable llvm.clang-opt can be set in
+ * the file ~/.perfconfig:
+ *
+ * E.g. Test on a platform with 8 CPUs with x86_64 architecture:
+ *
+ *   [llvm]
+ *		clang-opt = "-D__NR_CPUS__=8 -D__x86_64__ \
+ *			     -I./tools/perf/include/bpf"
+ *
+ * E.g. Test on a platform with 5 CPUs with aarch64 architecture:
+ *
+ *   [llvm]
+ *		clang-opt = "-D__NR_CPUS__=5 -D__aarch64__ \
+ *			     -I./tools/perf/include/bpf"
+
  * This exactly matches what is marshalled into the raw_syscall:sys_enter
  * payload expected by the 'perf trace' beautifiers.
  *
-- 
2.17.1

