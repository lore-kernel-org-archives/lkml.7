Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDF8EC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:19:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 928AE20883
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:19:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727754AbfCVWTE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 18:19:04 -0400
Received: from terminus.zytor.com ([198.137.202.136]:34937 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbfCVWTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 18:19:03 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x2MMIQdv750012
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 22 Mar 2019 15:18:26 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x2MMIPoQ750009;
        Fri, 22 Mar 2019 15:18:25 -0700
Date:   Fri, 22 Mar 2019 15:18:25 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-5270n2quu2gqz22o7itfdx00@git.kernel.org>
Cc:     daniel@iogearbox.net, quentin.monnet@netronome.com,
        jakub.kicinski@netronome.com, ast@kernel.org,
        linux-kernel@vger.kernel.org, acme@redhat.com, yhs@fb.com,
        jolsa@kernel.org, mingo@kernel.org, sdf@google.com,
        tglx@linutronix.de, hpa@zytor.com, namhyung@kernel.org
Reply-To: linux-kernel@vger.kernel.org, ast@kernel.org,
          jakub.kicinski@netronome.com, quentin.monnet@netronome.com,
          daniel@iogearbox.net, yhs@fb.com, acme@redhat.com,
          jolsa@kernel.org, sdf@google.com, namhyung@kernel.org,
          hpa@zytor.com, tglx@linutronix.de, mingo@kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] tools lib bpf: Fix the build by adding a missing
 stdarg.h include
Git-Commit-ID: dfcbc2f2994b8a3af3605a26dc29c07ad7378bf4
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

Commit-ID:  dfcbc2f2994b8a3af3605a26dc29c07ad7378bf4
Gitweb:     https://git.kernel.org/tip/dfcbc2f2994b8a3af3605a26dc29c07ad7378bf4
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Mon, 11 Mar 2019 17:07:52 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 11 Mar 2019 17:14:31 -0300

tools lib bpf: Fix the build by adding a missing stdarg.h include

The libbpf_print_fn_t typedef uses va_list without including the header
where that type is defined, stdarg.h, breaking in places where we're
unlucky for that type not to be already defined by some previously
included header.

Noticed while building on fedora 24 cross building tools/perf to the ARC
architecture using the uClibc C library:

  28 fedora:24-x-ARC-uClibc   : FAIL arc-linux-gcc (ARCompact ISA Linux uClibc toolchain 2017.09-rc2) 7.1.1 20170710

    CC       /tmp/build/perf/tests/llvm.o
  In file included from tests/llvm.c:3:0:
  /git/linux/tools/lib/bpf/libbpf.h:57:20: error: unknown type name 'va_list'
        const char *, va_list ap);
                      ^~~~~~~
  /git/linux/tools/lib/bpf/libbpf.h:59:34: error: unknown type name 'libbpf_print_fn_t'
   LIBBPF_API void libbpf_set_print(libbpf_print_fn_t fn);
                                    ^~~~~~~~~~~~~~~~~
  mv: cannot stat '/tmp/build/perf/tests/.llvm.o.tmp': No such file or directory

Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Jakub Kicinski <jakub.kicinski@netronome.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Quentin Monnet <quentin.monnet@netronome.com>
Cc: Stanislav Fomichev <sdf@google.com>
Cc: Yonghong Song <yhs@fb.com>
Fixes: a8a1f7d09cfc ("libbpf: fix libbpf_print")
Link: https://lkml.kernel.org/n/tip-5270n2quu2gqz22o7itfdx00@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/bpf/libbpf.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index b4652aa1a58a..aa1521a51687 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -10,6 +10,7 @@
 #ifndef __LIBBPF_LIBBPF_H
 #define __LIBBPF_LIBBPF_H
 
+#include <stdarg.h>
 #include <stdio.h>
 #include <stdint.h>
 #include <stdbool.h>
