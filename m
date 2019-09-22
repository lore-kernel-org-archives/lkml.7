Return-Path: <SRS0=BACo=XR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C08C3A5A6
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 19:26:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 340F120578
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 19:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569180365;
	bh=J857V+s2eCUvaCpjWd7tdKg18VSQm5KUn4SWhVl283w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uZy0SJmMqdl26gHtygFYICEf3dkR4R0BfGL7WkWmJLx6Vft6PI9vlPo7yKSFGAlii
	 bZju12onCEvWqWI7XCgECaMhd7ijNsXWvUFDImI/bEN86srFBm7P/OCWjaGSQA+/lq
	 YtZ9Gc0hAbMT+S00W7PzEpTUbYLv3KwPLMXEqBoA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731516AbfIVT0E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 15:26:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:50474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406813AbfIVSwD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 14:52:03 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B9F3F21A4A;
        Sun, 22 Sep 2019 18:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569178322;
        bh=J857V+s2eCUvaCpjWd7tdKg18VSQm5KUn4SWhVl283w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A7bNsMHHjh7GQ9GZi7b9iO85cm4xdGeV6A7FYicmrvaAhGamHumEg4DDky5R4Msf4
         m7NpfgOPzUj6aYZaiKx9MZxo0BSZLFvL1MrzBb/GgAC7bbqyXhvc0Uf7kKgloeYwSS
         1KzBk503MLsrXF0NzgwpnpKisRgIMGB6jx2O6mzg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-riscv@lists.infradead.org
Subject: [PATCH AUTOSEL 5.2 088/185] tools headers: Fixup bitsperlong per arch includes
Date:   Sun, 22 Sep 2019 14:47:46 -0400
Message-Id: <20190922184924.32534-88-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190922184924.32534-1-sashal@kernel.org>
References: <20190922184924.32534-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

[ Upstream commit 42fc2e9ef9603a7948aaa4ffd8dfb94b30294ad8 ]

We were getting the file by luck, from one of the paths in -I, fix it to
get it from the proper place:

  $ cd tools/include/uapi/asm/
  [acme@quaco asm]$ grep include bitsperlong.h
  #include "../../arch/x86/include/uapi/asm/bitsperlong.h"
  #include "../../arch/arm64/include/uapi/asm/bitsperlong.h"
  #include "../../arch/powerpc/include/uapi/asm/bitsperlong.h"
  #include "../../arch/s390/include/uapi/asm/bitsperlong.h"
  #include "../../arch/sparc/include/uapi/asm/bitsperlong.h"
  #include "../../arch/mips/include/uapi/asm/bitsperlong.h"
  #include "../../arch/ia64/include/uapi/asm/bitsperlong.h"
  #include "../../arch/riscv/include/uapi/asm/bitsperlong.h"
  #include "../../arch/alpha/include/uapi/asm/bitsperlong.h"
  #include <asm-generic/bitsperlong.h>
  $ ls -la ../../arch/x86/include/uapi/asm/bitsperlong.h
  ls: cannot access '../../arch/x86/include/uapi/asm/bitsperlong.h': No such file or directory
  $ ls -la ../../../arch/*/include/uapi/asm/bitsperlong.h
  -rw-rw-r--. 1 237 ../../../arch/alpha/include/uapi/asm/bitsperlong.h
  -rw-rw-r--. 1 841 ../../../arch/arm64/include/uapi/asm/bitsperlong.h
  -rw-rw-r--. 1 966 ../../../arch/hexagon/include/uapi/asm/bitsperlong.h
  -rw-rw-r--. 1 234 ../../../arch/ia64/include/uapi/asm/bitsperlong.h
  -rw-rw-r--. 1 100 ../../../arch/microblaze/include/uapi/asm/bitsperlong.h
  -rw-rw-r--. 1 244 ../../../arch/mips/include/uapi/asm/bitsperlong.h
  -rw-rw-r--. 1 352 ../../../arch/parisc/include/uapi/asm/bitsperlong.h
  -rw-rw-r--. 1 312 ../../../arch/powerpc/include/uapi/asm/bitsperlong.h
  -rw-rw-r--. 1 353 ../../../arch/riscv/include/uapi/asm/bitsperlong.h
  -rw-rw-r--. 1 292 ../../../arch/s390/include/uapi/asm/bitsperlong.h
  -rw-rw-r--. 1 323 ../../../arch/sparc/include/uapi/asm/bitsperlong.h
  -rw-rw-r--. 1 320 ../../../arch/x86/include/uapi/asm/bitsperlong.h
  $

Found while fixing some other problem, before it was escaping the
tools/ chroot and using stuff in the kernel sources:

    CC       /tmp/build/perf/util/find_bit.o
In file included from /git/linux/tools/include/../../arch/x86/include/uapi/asm/bitsperlong.h:11,
                 from /git/linux/tools/include/uapi/asm/bitsperlong.h:3,
                 from /git/linux/tools/include/linux/bits.h:6,
                 from /git/linux/tools/include/linux/bitops.h:13,
                 from ../lib/find_bit.c:17:

  # cd /git/linux/tools/include/../../arch/x86/include/uapi/asm/
  # pwd
  /git/linux/arch/x86/include/uapi/asm
  #

Now it is getting the one we want it to, i.e. the one inside tools/:

    CC       /tmp/build/perf/util/find_bit.o
  In file included from /git/linux/tools/arch/x86/include/uapi/asm/bitsperlong.h:11,
                   from /git/linux/tools/include/linux/bits.h:6,
                   from /git/linux/tools/include/linux/bitops.h:13,

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-8f8cfqywmf6jk8a3ucr0ixhu@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/include/uapi/asm/bitsperlong.h | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/tools/include/uapi/asm/bitsperlong.h b/tools/include/uapi/asm/bitsperlong.h
index 57aaeaf8e1920..edba4d93e9e6a 100644
--- a/tools/include/uapi/asm/bitsperlong.h
+++ b/tools/include/uapi/asm/bitsperlong.h
@@ -1,22 +1,22 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #if defined(__i386__) || defined(__x86_64__)
-#include "../../arch/x86/include/uapi/asm/bitsperlong.h"
+#include "../../../arch/x86/include/uapi/asm/bitsperlong.h"
 #elif defined(__aarch64__)
-#include "../../arch/arm64/include/uapi/asm/bitsperlong.h"
+#include "../../../arch/arm64/include/uapi/asm/bitsperlong.h"
 #elif defined(__powerpc__)
-#include "../../arch/powerpc/include/uapi/asm/bitsperlong.h"
+#include "../../../arch/powerpc/include/uapi/asm/bitsperlong.h"
 #elif defined(__s390__)
-#include "../../arch/s390/include/uapi/asm/bitsperlong.h"
+#include "../../../arch/s390/include/uapi/asm/bitsperlong.h"
 #elif defined(__sparc__)
-#include "../../arch/sparc/include/uapi/asm/bitsperlong.h"
+#include "../../../arch/sparc/include/uapi/asm/bitsperlong.h"
 #elif defined(__mips__)
-#include "../../arch/mips/include/uapi/asm/bitsperlong.h"
+#include "../../../arch/mips/include/uapi/asm/bitsperlong.h"
 #elif defined(__ia64__)
-#include "../../arch/ia64/include/uapi/asm/bitsperlong.h"
+#include "../../../arch/ia64/include/uapi/asm/bitsperlong.h"
 #elif defined(__riscv)
-#include "../../arch/riscv/include/uapi/asm/bitsperlong.h"
+#include "../../../arch/riscv/include/uapi/asm/bitsperlong.h"
 #elif defined(__alpha__)
-#include "../../arch/alpha/include/uapi/asm/bitsperlong.h"
+#include "../../../arch/alpha/include/uapi/asm/bitsperlong.h"
 #else
 #include <asm-generic/bitsperlong.h>
 #endif
-- 
2.20.1

