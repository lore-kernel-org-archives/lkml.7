Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C726C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:38:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD49E2084B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:38:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="cZ9Lau+l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728626AbfFQTiM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 15:38:12 -0400
Received: from terminus.zytor.com ([198.137.202.136]:37101 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbfFQTiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 15:38:12 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5HJbXF63566097
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 17 Jun 2019 12:37:33 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5HJbXF63566097
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560800254;
        bh=FQ1nPZaPbU0VBB2AVxCQPG1ZLTuyx9Qeu1wIWW+8G+U=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=cZ9Lau+lYpdechc5BJuCE/u4fFdK1flJeL4q/ukdYY80FizxeeFMDEPqCIl0RxgBI
         H84kY+5ibAZCD7FDwgpITgljlmK5aySr859hlfoqlPVjPJE3H0h4ClUA9bNw4PHq4B
         Wcih4jGkKVq33TQPtrgVLX2HxXfSpDu0OomHdrZyxxwEWtnv426ed5UKSuUQ1SzdyT
         8yugGlB6lvVZkZeBSKtD+JR898hyDGqBNt1rLJvD7RU5oypEDc9xygbhv6PWu8+c5V
         64AWevwFtCgQR5xdAmVMAf39uyNhHmUYMGiWAphfv0puGNLawJnI/Howt/JIREfRLj
         ESV9txp/rFXWQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5HJbXp83566094;
        Mon, 17 Jun 2019 12:37:33 -0700
Date:   Mon, 17 Jun 2019 12:37:33 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Leo Yan <tipbot@zytor.com>
Message-ID: <tip-87407fa58b6645cecd24102f58476b8dd7ce778d@git.kernel.org>
Cc:     ak@linux.intel.com, hpa@zytor.com, linux-kernel@vger.kernel.org,
        kafai@fb.com, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org, yhs@fb.com, ast@kernel.org,
        tglx@linutronix.de, acme@redhat.com, mingo@kernel.org,
        daniel@iogearbox.net, jolsa@redhat.com, mbd@fb.com,
        songliubraving@fb.com, leo.yan@linaro.org
Reply-To: hpa@zytor.com, ak@linux.intel.com, linux-kernel@vger.kernel.org,
          alexander.shishkin@linux.intel.com, kafai@fb.com, yhs@fb.com,
          namhyung@kernel.org, acme@redhat.com, ast@kernel.org,
          tglx@linutronix.de, jolsa@redhat.com, daniel@iogearbox.net,
          mingo@kernel.org, leo.yan@linaro.org, songliubraving@fb.com,
          mbd@fb.com
In-Reply-To: <20190607143508.18141-1-leo.yan@linaro.org>
References: <20190607143508.18141-1-leo.yan@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf config: Update default value for
 llvm.clang-bpf-cmd-template
Git-Commit-ID: 87407fa58b6645cecd24102f58476b8dd7ce778d
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

Commit-ID:  87407fa58b6645cecd24102f58476b8dd7ce778d
Gitweb:     https://git.kernel.org/tip/87407fa58b6645cecd24102f58476b8dd7ce778d
Author:     Leo Yan <leo.yan@linaro.org>
AuthorDate: Fri, 7 Jun 2019 22:35:08 +0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 10 Jun 2019 16:20:11 -0300

perf config: Update default value for llvm.clang-bpf-cmd-template

The clang bpf cmdline template has defined default value in the file
tools/perf/util/llvm-utils.c, which has been changed for several times.

This patch updates the documentation to reflect the latest default value
for the configuration llvm.clang-bpf-cmd-template.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mark Drayton <mbd@fb.com>
Cc: Martin KaFai Lau <kafai@fb.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Song Liu <songliubraving@fb.com>
Cc: Yonghong Song <yhs@fb.com>
Cc: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org
Fixes: d35b168c3dcd ("perf bpf: Give precedence to bpf header dir")
Fixes: cb76371441d0 ("perf llvm: Allow passing options to llc in addition to clang")
Fixes: 1b16fffa389d ("perf llvm-utils: Add bpf include path to clang command line")
Link: http://lkml.kernel.org/r/20190607143508.18141-1-leo.yan@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-config.txt | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/perf/Documentation/perf-config.txt b/tools/perf/Documentation/perf-config.txt
index 462b3cde0675..e4aa268d2e38 100644
--- a/tools/perf/Documentation/perf-config.txt
+++ b/tools/perf/Documentation/perf-config.txt
@@ -564,9 +564,12 @@ llvm.*::
 	llvm.clang-bpf-cmd-template::
 		Cmdline template. Below lines show its default value. Environment
 		variable is used to pass options.
-		"$CLANG_EXEC -D__KERNEL__ $CLANG_OPTIONS $KERNEL_INC_OPTIONS \
-		-Wno-unused-value -Wno-pointer-sign -working-directory \
-		$WORKING_DIR  -c $CLANG_SOURCE -target bpf -O2 -o -"
+		"$CLANG_EXEC -D__KERNEL__ -D__NR_CPUS__=$NR_CPUS "\
+		"-DLINUX_VERSION_CODE=$LINUX_VERSION_CODE "	\
+		"$CLANG_OPTIONS $PERF_BPF_INC_OPTIONS $KERNEL_INC_OPTIONS " \
+		"-Wno-unused-value -Wno-pointer-sign "		\
+		"-working-directory $WORKING_DIR "		\
+		"-c \"$CLANG_SOURCE\" -target bpf $CLANG_EMIT_LLVM -O2 -o - $LLVM_OPTIONS_PIPE"
 
 	llvm.clang-opt::
 		Options passed to clang.
