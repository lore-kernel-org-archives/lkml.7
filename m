Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC892C10F0C
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:08:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E9A021904
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554368900;
	bh=jcmColJ1GOErNW/EjMc0LrtisJNHSYInyhOr9ptxecA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ECMF02FfysMOB5l2GbwOyAhCfYn+Rq9Y6/Q+tsYBxSADsZ/fsqXRquGZzYJG5ppcc
	 grWYbZ07wBf1jZQmso0bgU9dyaCF3isjEDZIT6PmPGwXiVXoaMtUF+rEloEvTGHeQo
	 YWDzJ4wwi7TbrCCoMblysgYfXJIglgrUUzx90ur0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732431AbfDDJIS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:08:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:47216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732615AbfDDJIN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:08:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74174218C3;
        Thu,  4 Apr 2019 09:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554368891;
        bh=jcmColJ1GOErNW/EjMc0LrtisJNHSYInyhOr9ptxecA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tNxBHAV7Vr7wipLUSDZTtuXctC7vN2Gr4bA+EjNtWTG+3dDB+U/mNU4axRrekbrnp
         rw5otI1U2XWR59uCWZ2tw30K45kCjqewKmCvXwKDy0j5wlBtXyp4M4oKBXEsxD9pBp
         Wc4O/gOwLb2FL7KurqPDGo8rlRsyo6XsMHrsCvY0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Stanislav Fomichev <sdf@google.com>,
        Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 020/246] libbpf: force fixdep compilation at the start of the build
Date:   Thu,  4 Apr 2019 10:45:20 +0200
Message-Id: <20190404084619.860513419@linuxfoundation.org>
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



