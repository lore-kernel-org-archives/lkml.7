Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22C35C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDDDD20820
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554369236;
	bh=UyVQwB2mx5aUO+b/BhUJrckaETrhpaIbi3RftzIPojg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QjmpPT3O83OqlMeLLDUy/ld6fM9Bx7xXYFuShnJRXDvw4sXTeNsRhGI/vo8ZtHZK8
	 hhFs69CE/3S3P+Qo//o5ZPpqB6Z+b2iCRvtApqE6B3+V+S5wl4AypmDhTHI/o4iNnj
	 qCCQUMpUgtWR8+FALISGV6MKb2zkTZ7030QWKptc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387632AbfDDJNy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:13:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:54258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387415AbfDDJNu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:13:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D61A20693;
        Thu,  4 Apr 2019 09:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554369229;
        bh=UyVQwB2mx5aUO+b/BhUJrckaETrhpaIbi3RftzIPojg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q3C3vCzVAvBsyrL+IG3IKgFUWXFfY8JO4qCS+sTu3FiL7TffnArJDWqvYMUGvLHOv
         njIKtKRlobFnQoVHjhCsbGYMwyHdjL3fnv/LoAIRg6M7uJSlCz+GRuHPX1tkxbMpQt
         4KQ7NsdW7IrjQ9AVuVs/zRM05Soe2unKidHK2B4I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jin Yao <yao.jin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexei Starovoitov <ast@fb.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 132/246] tools build: Add test-reallocarray.c to test-all.c to fix the build
Date:   Thu,  4 Apr 2019 10:47:12 +0200
Message-Id: <20190404084623.779560731@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084619.236418459@linuxfoundation.org>
References: <20190404084619.236418459@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit a96c03e8cdcf123384319f312d0a08a7a760bb35 ]

When a test is in the FEATURE_TESTS_BASIC list in tools/build/Makefile.feature
must be added to tools/build/feature/test-all.c, because the successfull
compilation and linking of that test-all.bin file means that all the
features listed in FEATURE_TESTS_BASIC are present in the system, so we
don't have to go on feature by feature test building them.

Since reallocarray() is expected to be present in modern systems, it has
a place in FEATURE_TESTS_BASIC, so that we speed up the build process
building just that file.

For older systems, such as ubuntu:16.04 (build failure reported by Jin
Yao) debian:8, and for the current flagship RHEL distro, RHEL7, the
build will fail as test-all.bin (without test-reallocarray.c included)
passes but reallocarray() isn't present, making the build fail with:

    CC       /tmp/build/perf/libbpf.o
    MKDIR    /tmp/build/perf/fs/
    CC       /tmp/build/perf/fs/tracing_path.o
    LD       /tmp/build/perf/fd/libapi-in.o
    CC       /tmp/build/perf/bpf.o
  libbpf.c: In function 'bpf_object__add_program':
  libbpf.c:367:10: error: implicit declaration of function 'reallocarray' [-Werror=implicit-function-declaration]
    progs = reallocarray(progs, nr_progs + 1, sizeof(progs[0]));
            ^
  libbpf.c:367:2: error: nested extern declaration of 'reallocarray' [-Werror=nested-externs]
    progs = reallocarray(progs, nr_progs + 1, sizeof(progs[0]));
    ^
  libbpf.c:367:8: error: assignment makes pointer from integer without a cast [-Werror=int-conversion]
    progs = reallocarray(progs, nr_progs + 1, sizeof(progs[0]));
          ^
  libbpf.c: In function 'bpf_object__elf_collect':
  libbpf.c:887:10: error: assignment makes pointer from integer without a cast [-Werror=int-conversion]
      reloc = reallocarray(reloc, nr_reloc,
            ^
  libbpf.c: In function 'bpf_program__reloc_text':
  libbpf.c:1394:12: error: assignment makes pointer from integer without a cast [-Werror=int-conversion]
     new_insn = reallocarray(prog->insns, new_cnt, sizeof(*insn));
              ^
    CC       /tmp/build/perf/nlattr.o

Even with:

  $ grep reallocarray /tmp/build/perf/FEATURE-DUMP
  feature-reallocarray=1
  $

Which ubuntu:16.04.5 LTS doesn't have:

  perfbuilder@38a153a1bba8:/$ head -2 /etc/os-release
  NAME="Ubuntu"
  VERSION="16.04.5 LTS (Xenial Xerus)"
  perfbuilder@38a153a1bba8:/$ find /usr/include/ -name "*.h" | xargs grep -w reallocarray
  perfbuilder@38a153a1bba8:/$

Fix it by including it to test-all.c, which ends up forcing the
individual tests to be triggered and for the build process to notice
that indeed reallocarray() is not there:

  perfbuilder@38a153a1bba8:/$ cat /tmp/build/perf/feature/test-all.make.output
  In file included from test-all.c:178:0:
  test-reallocarray.c: In function 'main_test_reallocarray':
  test-reallocarray.c:7:11: error: implicit declaration of function 'reallocarray' [-Werror=implicit-function-declaration]
    return !!reallocarray(NULL, 1, 1);
             ^
  cc1: all warnings being treated as errors
  perfbuilder@38a153a1bba8:/$

That is the only test that is failing on Ubuntu 16.03.5 LTS, so all
tests are forced:

  perfbuilder@38a153a1bba8:/tmp/build/perf/feature$ ls -lSr *.make.output
  <SNIP successful tests>
  -rw-r--r--. 1 perfbuilder perfbuilder   0 Feb 14 15:00 test-dwarf.make.output
  -rw-r--r--. 1 perfbuilder perfbuilder   0 Feb 14 14:16 test-cplus-demangle.make.output
  -rw-r--r--. 1 perfbuilder perfbuilder   0 Feb 14 15:00 test-bpf.make.output
  -rw-r--r--. 1 perfbuilder perfbuilder   0 Feb 14 15:00 test-backtrace.make.output
  -rw-r--r--. 1 perfbuilder perfbuilder 104 Feb 14 15:00 test-bionic.make.output
  -rw-r--r--. 1 perfbuilder perfbuilder 107 Feb 14 15:00 test-libunwind-x86.make.output
  -rw-r--r--. 1 perfbuilder perfbuilder 115 Feb 14 15:00 test-libunwind-aarch64.make.output
  -rw-r--r--. 1 perfbuilder perfbuilder 122 Feb 14 15:00 test-libbabeltrace.make.output
  -rw-r--r--. 1 perfbuilder perfbuilder 254 Feb 14 15:00 test-reallocarray.make.output
  -rw-r--r--. 1 perfbuilder perfbuilder 312 Feb 14 15:00 test-all.make.output
  perfbuilder@38a153a1bba8:/tmp/build/perf/feature$

And that reallocarray() one shows:

  perfbuilder@38a153a1bba8:/tmp/build/perf/feature$ cat test-reallocarray.make.output
  test-reallocarray.c: In function 'main':
  test-reallocarray.c:7:11: error: implicit declaration of function 'reallocarray' [-Werror=implicit-function-declaration]
    return !!reallocarray(NULL, 1, 1);
             ^
  cc1: all warnings being treated as errors
  perfbuilder@38a153a1bba8:/tmp/build/perf/feature$

Which now generates the expected result:

  perfbuilder@38a153a1bba8:~$ grep reallocarray /tmp/build/perf/FEATURE-DUMP
  feature-reallocarray=0
  perfbuilder@38a153a1bba8:~$

The fallback mechanism kicks in and libbpf and perf are again buildable
in systems without reallocarray():

  $ cat tools/include/tools/libc_compat.h
  // SPDX-License-Identifier: (LGPL-2.0+ OR BSD-2-Clause)
  /* Copyright (C) 2018 Netronome Systems, Inc. */

  #ifndef __TOOLS_LIBC_COMPAT_H
  #define __TOOLS_LIBC_COMPAT_H

  #include <stdlib.h>
  #include <linux/overflow.h>

  #ifdef COMPAT_NEED_REALLOCARRAY
  static inline void *reallocarray(void *ptr, size_t nmemb, size_t size)
  {
	  size_t bytes;

	  if (unlikely(check_mul_overflow(nmemb, size, &bytes)))
		  return NULL;
	  return realloc(ptr, bytes);
  }
  #endif
  #endif
  $

Reported-by: Jin Yao <yao.jin@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexei Starovoitov <ast@fb.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Jakub Kicinski <jakub.kicinski@netronome.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Song Liu <songliubraving@fb.com>
Cc: Yonghong Song <yhs@fb.com>
Fixes: 531b014e7a2f ("tools: bpf: make use of reallocarray")
Link: https://lkml.kernel.org/n/tip-aonqku8axii8rxki5g11w40b@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/build/feature/test-all.c          | 5 +++++
 tools/build/feature/test-reallocarray.c | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/tools/build/feature/test-all.c b/tools/build/feature/test-all.c
index 20cdaa4fc112..93f485098161 100644
--- a/tools/build/feature/test-all.c
+++ b/tools/build/feature/test-all.c
@@ -178,6 +178,10 @@
 # include "test-libaio.c"
 #undef main
 
+#define main main_test_reallocarray
+# include "test-reallocarray.c"
+#undef main
+
 int main(int argc, char *argv[])
 {
 	main_test_libpython();
@@ -219,6 +223,7 @@ int main(int argc, char *argv[])
 	main_test_setns();
 	main_test_libopencsd();
 	main_test_libaio();
+	main_test_reallocarray();
 
 	return 0;
 }
diff --git a/tools/build/feature/test-reallocarray.c b/tools/build/feature/test-reallocarray.c
index 8170de35150d..8f6743e31da7 100644
--- a/tools/build/feature/test-reallocarray.c
+++ b/tools/build/feature/test-reallocarray.c
@@ -6,3 +6,5 @@ int main(void)
 {
 	return !!reallocarray(NULL, 1, 1);
 }
+
+#undef _GNU_SOURCE
-- 
2.19.1



