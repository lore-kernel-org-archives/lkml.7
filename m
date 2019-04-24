Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6BBEC282E1
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:45:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C28F21773
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556127928;
	bh=wHT9pwE+jWg6dZ68IjmaOivb0kJlqGOZMLa30r9E2uI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zGo0I7Qv1e1BRfh0z/ODs+vh6hsF56zWjxRKpOoNpMdziLu56FWFpurBU/jVGYbK3
	 tMPKfminoIEtjbfSbipJ+cLMy5hj6v4jYrV9ahelYxY8vAW75OdtVNmxOv7YF9lfST
	 VPFAlIpOEXfceaAKYt+Kmoaxxav1XKx0C5IwWLsI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391514AbfDXRdd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:33:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:60376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391481AbfDXRdY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:33:24 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F3C5218B0;
        Wed, 24 Apr 2019 17:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556127203;
        bh=wHT9pwE+jWg6dZ68IjmaOivb0kJlqGOZMLa30r9E2uI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HxQMtynblKGWJGv++TVTIJHQuh5IisPLTssrmZIDrbGsTBqcsjrgrjyqP6SmT30SQ
         du1EdQLoTw4zJs4AJspQYHbrdjh9skASaNhSufmM/SRE+yv1zJiTuv9jtOSF52GKBs
         JtU95VXz9DDr/ruwVdzfRyLo2zKm6vUl0/s1OdzM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 4.19 94/96] tools include: Adopt linux/bits.h
Date:   Wed, 24 Apr 2019 19:10:39 +0200
Message-Id: <20190424170926.164666576@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170919.829037226@linuxfoundation.org>
References: <20190424170919.829037226@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

commit ba4aa02b417f08a0bee5e7b8ed70cac788a7c854 upstream.

So that we reduce the difference of tools/include/linux/bitops.h to the
original kernel file, include/linux/bitops.h, trying to remove the need
to define BITS_PER_LONG, to avoid clashes with asm/bitsperlong.h.

And the things removed from tools/include/linux/bitops.h are really in
linux/bits.h, so that we can have a copy and then
tools/perf/check_headers.sh will tell us when new stuff gets added to
linux/bits.h so that we can check if it is useful and if any adjustment
needs to be done to the tools/{include,arch}/ copies.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Sverdlin <alexander.sverdlin@nokia.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-y1sqyydvfzo0bjjoj4zsl562@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/include/linux/bitops.h |    7 ++-----
 tools/include/linux/bits.h   |   26 ++++++++++++++++++++++++++
 tools/perf/check-headers.sh  |    1 +
 3 files changed, 29 insertions(+), 5 deletions(-)

--- a/tools/include/linux/bitops.h
+++ b/tools/include/linux/bitops.h
@@ -3,8 +3,6 @@
 #define _TOOLS_LINUX_BITOPS_H_
 
 #include <asm/types.h>
-#include <linux/compiler.h>
-
 #ifndef __WORDSIZE
 #define __WORDSIZE (__SIZEOF_LONG__ * 8)
 #endif
@@ -12,10 +10,9 @@
 #ifndef BITS_PER_LONG
 # define BITS_PER_LONG __WORDSIZE
 #endif
+#include <linux/bits.h>
+#include <linux/compiler.h>
 
-#define BIT_MASK(nr)		(1UL << ((nr) % BITS_PER_LONG))
-#define BIT_WORD(nr)		((nr) / BITS_PER_LONG)
-#define BITS_PER_BYTE		8
 #define BITS_TO_LONGS(nr)	DIV_ROUND_UP(nr, BITS_PER_BYTE * sizeof(long))
 #define BITS_TO_U64(nr)		DIV_ROUND_UP(nr, BITS_PER_BYTE * sizeof(u64))
 #define BITS_TO_U32(nr)		DIV_ROUND_UP(nr, BITS_PER_BYTE * sizeof(u32))
--- /dev/null
+++ b/tools/include/linux/bits.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LINUX_BITS_H
+#define __LINUX_BITS_H
+#include <asm/bitsperlong.h>
+
+#define BIT(nr)			(1UL << (nr))
+#define BIT_ULL(nr)		(1ULL << (nr))
+#define BIT_MASK(nr)		(1UL << ((nr) % BITS_PER_LONG))
+#define BIT_WORD(nr)		((nr) / BITS_PER_LONG)
+#define BIT_ULL_MASK(nr)	(1ULL << ((nr) % BITS_PER_LONG_LONG))
+#define BIT_ULL_WORD(nr)	((nr) / BITS_PER_LONG_LONG)
+#define BITS_PER_BYTE		8
+
+/*
+ * Create a contiguous bitmask starting at bit position @l and ending at
+ * position @h. For example
+ * GENMASK_ULL(39, 21) gives us the 64bit vector 0x000000ffffe00000.
+ */
+#define GENMASK(h, l) \
+	(((~0UL) - (1UL << (l)) + 1) & (~0UL >> (BITS_PER_LONG - 1 - (h))))
+
+#define GENMASK_ULL(h, l) \
+	(((~0ULL) - (1ULL << (l)) + 1) & \
+	 (~0ULL >> (BITS_PER_LONG_LONG - 1 - (h))))
+
+#endif	/* __LINUX_BITS_H */
--- a/tools/perf/check-headers.sh
+++ b/tools/perf/check-headers.sh
@@ -14,6 +14,7 @@ include/uapi/linux/sched.h
 include/uapi/linux/stat.h
 include/uapi/linux/vhost.h
 include/uapi/sound/asound.h
+include/linux/bits.h
 include/linux/hash.h
 include/uapi/linux/hw_breakpoint.h
 arch/x86/include/asm/disabled-features.h


