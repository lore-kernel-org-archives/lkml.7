Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B99ECC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:32:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85B892075C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553715168;
	bh=QxT++6H9Ub1czxq143z5rjk+Ci+OD4P3uiOUB8xIhLQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gV78B76NHD+SBCfuZAjogcH6GzZ8I/JbfdZOwuqPvqQJD802UVqrnQMBZkS64zyBt
	 iF+mxg6o0z4NDP/9Rz4edTbmYg1DTWc1mOMM8V9ARSQGjFx2rAyrZN0aZ0X4oTCqrV
	 0SqC5/Q4mCtHxdDwCO9JavzGvTb3b+GW/aV28Wbw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733111AbfC0Tcr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 15:32:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:42582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731120AbfC0SCj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:02:39 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A43142177E;
        Wed, 27 Mar 2019 18:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553709758;
        bh=QxT++6H9Ub1czxq143z5rjk+Ci+OD4P3uiOUB8xIhLQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cKiBEVO4Rx/Y1e72mWPOh1pJMCp9flQ6DG8mSjcy35KnJob0t/nuzVjKHLDxyW8ZI
         8I9jExA2T7ynALm48y/tOsykVC4jzVmOrB79XI8keNl02xSN5x879MKyYk2FxCkKXH
         SWdvKpTTcJSUujjviz3orLJJio0kUuwevOwgWdHg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Stanislav Fomichev <sdf@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 5.0 024/262] libbpf: force fixdep compilation at the start of the build
Date:   Wed, 27 Mar 2019 13:57:59 -0400
Message-Id: <20190327180158.10245-24-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327180158.10245-1-sashal@kernel.org>
References: <20190327180158.10245-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stanislav Fomichev <sdf@google.com>

[ Upstream commit 8e2688876c7f7073d925e1f150e86b8ed3338f52 ]

libbpf targets don't explicitly depend on fixdep target, so when
we do 'make -j$(nproc)', there is a high probability, that some
objects will be built before fixdep binary is available.

Fix this by running sub-make; this makes sure that fixdep dependency
is properly accounted for.

For the same issue in perf, see commit abb26210a395 ("perf tools: Force
fixdep compilation at the start of the build").

Before:

$ rm -rf /tmp/bld; mkdir /tmp/bld; make -j$(nproc) O=/tmp/bld -C tools/lib/bpf/

Auto-detecting system features:
...                        libelf: [ on  ]
...                           bpf: [ on  ]

  HOSTCC   /tmp/bld/fixdep.o
  CC       /tmp/bld/libbpf.o
  CC       /tmp/bld/bpf.o
  CC       /tmp/bld/btf.o
  CC       /tmp/bld/nlattr.o
  CC       /tmp/bld/libbpf_errno.o
  CC       /tmp/bld/str_error.o
  CC       /tmp/bld/netlink.o
  CC       /tmp/bld/bpf_prog_linfo.o
  CC       /tmp/bld/libbpf_probes.o
  CC       /tmp/bld/xsk.o
  HOSTLD   /tmp/bld/fixdep-in.o
  LINK     /tmp/bld/fixdep
  LD       /tmp/bld/libbpf-in.o
  LINK     /tmp/bld/libbpf.a
  LINK     /tmp/bld/libbpf.so
  LINK     /tmp/bld/test_libbpf

$ head /tmp/bld/.libbpf.o.cmd
 # cannot find fixdep (/usr/local/google/home/sdf/src/linux/xxx//fixdep)
 # using basic dep data

/tmp/bld/libbpf.o: libbpf.c /usr/include/stdc-predef.h \
 /usr/include/stdlib.h /usr/include/features.h \
 /usr/include/x86_64-linux-gnu/sys/cdefs.h \
 /usr/include/x86_64-linux-gnu/bits/wordsize.h \
 /usr/include/x86_64-linux-gnu/gnu/stubs.h \
 /usr/include/x86_64-linux-gnu/gnu/stubs-64.h \
 /usr/lib/gcc/x86_64-linux-gnu/7/include/stddef.h \

After:

$ rm -rf /tmp/bld; mkdir /tmp/bld; make -j$(nproc) O=/tmp/bld -C tools/lib/bpf/

Auto-detecting system features:
...                        libelf: [ on  ]
...                           bpf: [ on  ]

  HOSTCC   /tmp/bld/fixdep.o
  HOSTLD   /tmp/bld/fixdep-in.o
  LINK     /tmp/bld/fixdep
  CC       /tmp/bld/libbpf.o
  CC       /tmp/bld/bpf.o
  CC       /tmp/bld/nlattr.o
  CC       /tmp/bld/btf.o
  CC       /tmp/bld/libbpf_errno.o
  CC       /tmp/bld/str_error.o
  CC       /tmp/bld/netlink.o
  CC       /tmp/bld/bpf_prog_linfo.o
  CC       /tmp/bld/libbpf_probes.o
  CC       /tmp/bld/xsk.o
  LD       /tmp/bld/libbpf-in.o
  LINK     /tmp/bld/libbpf.a
  LINK     /tmp/bld/libbpf.so
  LINK     /tmp/bld/test_libbpf

$ head /tmp/bld/.libbpf.o.cmd
cmd_/tmp/bld/libbpf.o := gcc -Wp,-MD,/tmp/bld/.libbpf.o.d -Wp,-MT,/tmp/bld/libbpf.o -g -Wall -DHAVE_LIBELF_MMAP_SUPPORT -DCOMPAT_NEED_REALLOCARRAY -Wbad-function-cast -Wdeclaration-after-statement -Wformat-security -Wformat-y2k -Winit-self -Wmissing-declarations -Wmissing-prototypes -Wnested-externs -Wno-system-headers -Wold-style-definition -Wpacked -Wredundant-decls -Wshadow -Wstrict-prototypes -Wswitch-default -Wswitch-enum -Wundef -Wwrite-strings -Wformat -Wstrict-aliasing=3 -Werror -Wall -fPIC -I. -I/usr/local/google/home/sdf/src/linux/tools/include -I/usr/local/google/home/sdf/src/linux/tools/arch/x86/include/uapi -I/usr/local/google/home/sdf/src/linux/tools/include/uapi -fvisibility=hidden -D"BUILD_STR(s)=$(pound)s" -c -o /tmp/bld/libbpf.o libbpf.c

source_/tmp/bld/libbpf.o := libbpf.c

deps_/tmp/bld/libbpf.o := \
  /usr/include/stdc-predef.h \
  /usr/include/stdlib.h \
  /usr/include/features.h \
  /usr/include/x86_64-linux-gnu/sys/cdefs.h \
  /usr/include/x86_64-linux-gnu/bits/wordsize.h \

Fixes: 7c422f557266 ("tools build: Build fixdep helper from perf and basic libs")
Reported-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
Acked-by: Yonghong Song <yhs@fb.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/lib/bpf/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
index 34d9c3619c96..78fd86b85087 100644
--- a/tools/lib/bpf/Makefile
+++ b/tools/lib/bpf/Makefile
@@ -162,7 +162,8 @@ endif
 
 TARGETS = $(CMD_TARGETS)
 
-all: fixdep all_cmd
+all: fixdep
+	$(Q)$(MAKE) all_cmd
 
 all_cmd: $(CMD_TARGETS) check
 
-- 
2.19.1

