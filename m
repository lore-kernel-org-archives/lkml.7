Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A315FC33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 16:07:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79FBE21744
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 16:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578326849;
	bh=g9wZar1Zgj88/teH6zS44loQgY50JFMH1EKh60ggOTo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FmbNFKoNJsMoePPVuHSe0DaBwL+y4yLbQ5sE6BESxXxUS9UhybmB+U3auQhI1brYm
	 6pbjHTNtzJyKCIjddHUtEyTz7UJOs914BGL16S+RLWyuvSSjqcvSshNuvw2ko93vNu
	 wpRloQaB+c/Q9alElE7gedVOUpxBJyQqu3mrQA8s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgAFQH2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 11:07:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:44830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726463AbgAFQHZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 11:07:25 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 87975208C4;
        Mon,  6 Jan 2020 16:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578326844;
        bh=g9wZar1Zgj88/teH6zS44loQgY50JFMH1EKh60ggOTo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HLVZx/Rc4a2F/hjYE4JWB2pSbvzHFEYpm+YyAxPM2spEzlmOQBmBkz7lODmS3jyJ4
         sd1CpBd1dH8cWyUud3daBZhdR/SPLLMEB8RxcQeApS6ILzNaGiiSKIjziirrMpnGw+
         DJ8Dl7ZDU1wOL8VcdjgQ/qNreNbmbu8UcDK6dSoA=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 02/20] perf mmap: Declare type for cpu mask of arbitrary length
Date:   Mon,  6 Jan 2020 13:06:47 -0300
Message-Id: <20200106160705.10899-3-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200106160705.10899-1-acme@kernel.org>
References: <20200106160705.10899-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexey Budankov <alexey.budankov@linux.intel.com>

Declare a dedicated struct map_cpu_mask type for cpu masks of arbitrary
length.

The mask is available thru bits pointer and the mask length is kept in
nbits field. MMAP_CPU_MASK_BYTES() macro returns mask storage size in
bytes.

The mmap_cpu_mask__scnprintf() function can be used to log text
representation of the mask.

Committer notes:

To print the 'nbits' struct member we must use %zd, since it is a
size_t, this fixes the build in some toolchains/arches.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/0fd2454f-477f-d15a-f4ee-79bcbd2585ff@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/mmap.c | 12 ++++++++++++
 tools/perf/util/mmap.h | 11 +++++++++++
 2 files changed, 23 insertions(+)

diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index 063d1b93c53d..2ee4faacca21 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -23,6 +23,18 @@
 #include "mmap.h"
 #include "../perf.h"
 #include <internal/lib.h> /* page_size */
+#include <linux/bitmap.h>
+
+#define MASK_SIZE 1023
+void mmap_cpu_mask__scnprintf(struct mmap_cpu_mask *mask, const char *tag)
+{
+	char buf[MASK_SIZE + 1];
+	size_t len;
+
+	len = bitmap_scnprintf(mask->bits, mask->nbits, buf, MASK_SIZE);
+	buf[len] = '\0';
+	pr_debug("%p: %s mask[%zd]: %s\n", mask, tag, mask->nbits, buf);
+}
 
 size_t mmap__mmap_len(struct mmap *map)
 {
diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
index bee4e83f7109..ef51667fabcb 100644
--- a/tools/perf/util/mmap.h
+++ b/tools/perf/util/mmap.h
@@ -15,6 +15,15 @@
 #include "event.h"
 
 struct aiocb;
+
+struct mmap_cpu_mask {
+	unsigned long *bits;
+	size_t nbits;
+};
+
+#define MMAP_CPU_MASK_BYTES(m) \
+	(BITS_TO_LONGS(((struct mmap_cpu_mask *)m)->nbits) * sizeof(unsigned long))
+
 /**
  * struct mmap - perf's ring buffer mmap details
  *
@@ -52,4 +61,6 @@ int perf_mmap__push(struct mmap *md, void *to,
 
 size_t mmap__mmap_len(struct mmap *map);
 
+void mmap_cpu_mask__scnprintf(struct mmap_cpu_mask *mask, const char *tag);
+
 #endif /*__PERF_MMAP_H */
-- 
2.21.1

