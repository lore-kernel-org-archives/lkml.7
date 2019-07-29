Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC65EC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 21:15:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8134217D7
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 21:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564434922;
	bh=JzkwWF8HsLh+n4h++aFrrk6WmT23rR8xnFXbKt08onU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=m1l8hWXCTmZ+RGFml/zKGG1h+LewIB98g2OD9qKfxhWi0YMpRqRpKLPTzz2oq+OSE
	 x0n3ERezKa0OMSG/IVWdlABWXA98PA57CwKQSc4KK0OyMo+VbHVlqHjUadNCFzYtzE
	 HmsgozV3i5431Z9aCMKdVuaRO3dYOShkIZFogm80=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388657AbfG2VPV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 17:15:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:57160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388503AbfG2VPQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 17:15:16 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F12CF216C8;
        Mon, 29 Jul 2019 21:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564434915;
        bh=JzkwWF8HsLh+n4h++aFrrk6WmT23rR8xnFXbKt08onU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Mm6Wu9W/DTRyUz3p5Rs4Ndba+40gedafLSXfuBuDfpo9F3cAUoTHdpiN65UmIgcht
         5Mm/HD+BJ6N84LHfCxqvv+PbCDYsN9dAcZjvn3kxWLSkoYRGmALLj5ks3u9rbJp0p5
         4bn4m7wrxBqUoL+WCWUBlbBO3OPHvAI1MK0T3MPI=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Christoph Hellwig <hch@lst.de>,
        =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= 
        <lclaudio@redhat.com>
Subject: [PATCH 03/12] tools headers UAPI: Update tools's copy of mman.h headers
Date:   Mon, 29 Jul 2019 18:14:50 -0300
Message-Id: <20190729211456.6380-4-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190729211456.6380-1-acme@kernel.org>
References: <20190729211456.6380-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To pick up the changes from:

  8aa3c927ec10 ("mm/mmap: move common defines to mman-common.h")
  22fcea6f85f2 ("mm: move MAP_SYNC to asm-generic/mman-common.h")
  0bf5f9492389 ("mm: fix the MAP_UNINITIALIZED flag")

To address the following perf build warnings:

  Warning: Kernel ABI header at 'tools/include/uapi/asm-generic/mman-common.h' differs from latest version at 'include/uapi/asm-generic/mman-common.h'
  diff -u tools/include/uapi/asm-generic/mman-common.h include/uapi/asm-generic/mman-common.h
  Warning: Kernel ABI header at 'tools/include/uapi/asm-generic/mman.h' differs from latest version at 'include/uapi/asm-generic/mman.h'
  diff -u tools/include/uapi/asm-generic/mman.h include/uapi/asm-generic/mman.h

That ends up just moving a bit the auto-generated code->string tables:

  $ tools/perf/trace/beauty/mmap_flags.sh > before
  $ cp include/uapi/asm-generic/mman.h tools/include/uapi/asm-generic/mman.h
  $ cp include/uapi/asm-generic/mman-common.h tools/include/uapi/asm-generic/mman-common.h
  $ tools/perf/trace/beauty/mmap_flags.sh > after
  $ diff -u before after
  --- before 2019-07-26 12:45:02.948335904 -0300
  +++ after 2019-07-26 12:48:05.342893539 -0300
  @@ -4,15 +4,15 @@
          [ilog2(0x02) + 1] = "PRIVATE",
          [ilog2(0x10) + 1] = "FIXED",
          [ilog2(0x20) + 1] = "ANONYMOUS",
  +       [ilog2(0x008000) + 1] = "POPULATE",
  +       [ilog2(0x010000) + 1] = "NONBLOCK",
  +       [ilog2(0x020000) + 1] = "STACK",
  +       [ilog2(0x040000) + 1] = "HUGETLB",
  +       [ilog2(0x080000) + 1] = "SYNC",
          [ilog2(0x100000) + 1] = "FIXED_NOREPLACE",
          [ilog2(0x0100) + 1] = "GROWSDOWN",
          [ilog2(0x0800) + 1] = "DENYWRITE",
          [ilog2(0x1000) + 1] = "EXECUTABLE",
          [ilog2(0x2000) + 1] = "LOCKED",
          [ilog2(0x4000) + 1] = "NORESERVE",
  -       [ilog2(0x8000) + 1] = "POPULATE",
  -       [ilog2(0x10000) + 1] = "NONBLOCK",
  -       [ilog2(0x20000) + 1] = "STACK",
  -       [ilog2(0x40000) + 1] = "HUGETLB",
  -       [ilog2(0x80000) + 1] = "SYNC",
   };
  $

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-fzqvzni9megaurmsp0k4vy27@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/powerpc/include/uapi/asm/mman.h   |  4 ----
 tools/arch/sparc/include/uapi/asm/mman.h     |  4 ----
 tools/include/uapi/asm-generic/mman-common.h | 15 +++++++++------
 tools/include/uapi/asm-generic/mman.h        | 10 ++++------
 4 files changed, 13 insertions(+), 20 deletions(-)

diff --git a/tools/arch/powerpc/include/uapi/asm/mman.h b/tools/arch/powerpc/include/uapi/asm/mman.h
index f33105bc5ca6..8601d824a9c6 100644
--- a/tools/arch/powerpc/include/uapi/asm/mman.h
+++ b/tools/arch/powerpc/include/uapi/asm/mman.h
@@ -4,12 +4,8 @@
 #define MAP_DENYWRITE	0x0800
 #define MAP_EXECUTABLE	0x1000
 #define MAP_GROWSDOWN	0x0100
-#define MAP_HUGETLB	0x40000
 #define MAP_LOCKED	0x80
-#define MAP_NONBLOCK	0x10000
 #define MAP_NORESERVE   0x40
-#define MAP_POPULATE	0x8000
-#define MAP_STACK	0x20000
 #include <uapi/asm-generic/mman-common.h>
 /* MAP_32BIT is undefined on powerpc, fix it for perf */
 #define MAP_32BIT	0
diff --git a/tools/arch/sparc/include/uapi/asm/mman.h b/tools/arch/sparc/include/uapi/asm/mman.h
index 38920eed8cbf..7b94dccc843d 100644
--- a/tools/arch/sparc/include/uapi/asm/mman.h
+++ b/tools/arch/sparc/include/uapi/asm/mman.h
@@ -4,12 +4,8 @@
 #define MAP_DENYWRITE	0x0800
 #define MAP_EXECUTABLE	0x1000
 #define MAP_GROWSDOWN	0x0200
-#define MAP_HUGETLB	0x40000
 #define MAP_LOCKED      0x100
-#define MAP_NONBLOCK	0x10000
 #define MAP_NORESERVE   0x40
-#define MAP_POPULATE	0x8000
-#define MAP_STACK	0x20000
 #include <uapi/asm-generic/mman-common.h>
 /* MAP_32BIT is undefined on sparc, fix it for perf */
 #define MAP_32BIT	0
diff --git a/tools/include/uapi/asm-generic/mman-common.h b/tools/include/uapi/asm-generic/mman-common.h
index abd238d0f7a4..63b1f506ea67 100644
--- a/tools/include/uapi/asm-generic/mman-common.h
+++ b/tools/include/uapi/asm-generic/mman-common.h
@@ -19,15 +19,18 @@
 #define MAP_TYPE	0x0f		/* Mask for type of mapping */
 #define MAP_FIXED	0x10		/* Interpret addr exactly */
 #define MAP_ANONYMOUS	0x20		/* don't use a file */
-#ifdef CONFIG_MMAP_ALLOW_UNINITIALIZED
-# define MAP_UNINITIALIZED 0x4000000	/* For anonymous mmap, memory could be uninitialized */
-#else
-# define MAP_UNINITIALIZED 0x0		/* Don't support this flag */
-#endif
 
-/* 0x0100 - 0x80000 flags are defined in asm-generic/mman.h */
+/* 0x0100 - 0x4000 flags are defined in asm-generic/mman.h */
+#define MAP_POPULATE		0x008000	/* populate (prefault) pagetables */
+#define MAP_NONBLOCK		0x010000	/* do not block on IO */
+#define MAP_STACK		0x020000	/* give out an address that is best suited for process/thread stacks */
+#define MAP_HUGETLB		0x040000	/* create a huge page mapping */
+#define MAP_SYNC		0x080000 /* perform synchronous page faults for the mapping */
 #define MAP_FIXED_NOREPLACE	0x100000	/* MAP_FIXED which doesn't unmap underlying mapping */
 
+#define MAP_UNINITIALIZED 0x4000000	/* For anonymous mmap, memory could be
+					 * uninitialized */
+
 /*
  * Flags for mlock
  */
diff --git a/tools/include/uapi/asm-generic/mman.h b/tools/include/uapi/asm-generic/mman.h
index 36c197fc44a0..406f7718f9ad 100644
--- a/tools/include/uapi/asm-generic/mman.h
+++ b/tools/include/uapi/asm-generic/mman.h
@@ -9,13 +9,11 @@
 #define MAP_EXECUTABLE	0x1000		/* mark it as an executable */
 #define MAP_LOCKED	0x2000		/* pages are locked */
 #define MAP_NORESERVE	0x4000		/* don't check for reservations */
-#define MAP_POPULATE	0x8000		/* populate (prefault) pagetables */
-#define MAP_NONBLOCK	0x10000		/* do not block on IO */
-#define MAP_STACK	0x20000		/* give out an address that is best suited for process/thread stacks */
-#define MAP_HUGETLB	0x40000		/* create a huge page mapping */
-#define MAP_SYNC	0x80000		/* perform synchronous page faults for the mapping */
 
-/* Bits [26:31] are reserved, see mman-common.h for MAP_HUGETLB usage */
+/*
+ * Bits [26:31] are reserved, see asm-generic/hugetlb_encode.h
+ * for MAP_HUGETLB usage
+ */
 
 #define MCL_CURRENT	1		/* lock all current mappings */
 #define MCL_FUTURE	2		/* lock all future mappings */
-- 
2.21.0

