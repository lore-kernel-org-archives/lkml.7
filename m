Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA622C5B57D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 03:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0A9B205C9
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 03:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562124485;
	bh=XG5Ax5wYlyRFcG75pT+QEnD+Oji60YXfoFK70TFx5R8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LsQZfRYNw9iBouzkZdkcAqKKH/AWpQHi7wNjpi6TyoITNThtbJ2jTlNy6XpnGuuJN
	 JPBTz3t53xt5WVyVTWgRJyLAGrz68Qdes85KKc3tHbuAvUr0R7TL6nt7hFz+Duq8kR
	 hm3GU/h9OpGRSXW1b14bCVUfen/q76vTWZROLR7Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727300AbfGCD2E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 23:28:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:56054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727049AbfGCD2D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 23:28:03 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C6BBB21871;
        Wed,  3 Jul 2019 03:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562124482;
        bh=XG5Ax5wYlyRFcG75pT+QEnD+Oji60YXfoFK70TFx5R8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I06FKFFLI0aOLfN9fdLNH+WRPvuuvbLZ8yDDvoa15mHFQP4XNnNjKatzuEEKCxI4d
         H/JWwHfSxBZFycINu3KIgXxk/7Hrs7UZ8HWeJyellnxKO6TkAR9bUNGX+Bcyewfk0i
         M3TgsuhA1yaSljvYwuIqjt2nRY2ioptcclP12rro=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Jin Yao <yao.jin@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jin Yao <yao.jin@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 02/18] perf symbol: Create block_info structure
Date:   Wed,  3 Jul 2019 00:27:30 -0300
Message-Id: <20190703032746.21692-3-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190703032746.21692-1-acme@kernel.org>
References: <20190703032746.21692-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jin Yao <yao.jin@linux.intel.com>

'perf diff' currently can only diff symbols(functions).

We should expand it to diff cycles of individual programs blocks as
reported by timed LBR.  This would allow to identify changes in specific
code accurately.

We need a new structure to maintain the basic block information, such as,
symbol(function), start/end address of this block, cycles. This patch
creates this structure and with some ops.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@intel.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1561713784-30533-2-git-send-email-yao.jin@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/symbol.c | 22 ++++++++++++++++++++++
 tools/perf/util/symbol.h | 23 +++++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 46d2c03814a1..ae2ce255e848 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -2351,3 +2351,25 @@ struct mem_info *mem_info__new(void)
 		refcount_set(&mi->refcnt, 1);
 	return mi;
 }
+
+struct block_info *block_info__get(struct block_info *bi)
+{
+	if (bi)
+		refcount_inc(&bi->refcnt);
+	return bi;
+}
+
+void block_info__put(struct block_info *bi)
+{
+	if (bi && refcount_dec_and_test(&bi->refcnt))
+		free(bi);
+}
+
+struct block_info *block_info__new(void)
+{
+	struct block_info *bi = zalloc(sizeof(*bi));
+
+	if (bi)
+		refcount_set(&bi->refcnt, 1);
+	return bi;
+}
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index 9a8fe012910a..12755b42ea93 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -131,6 +131,17 @@ struct mem_info {
 	refcount_t		refcnt;
 };
 
+struct block_info {
+	struct symbol		*sym;
+	u64			start;
+	u64			end;
+	u64			cycles;
+	u64			cycles_aggr;
+	int			num;
+	int			num_aggr;
+	refcount_t		refcnt;
+};
+
 struct addr_location {
 	struct machine *machine;
 	struct thread *thread;
@@ -332,4 +343,16 @@ static inline void __mem_info__zput(struct mem_info **mi)
 
 #define mem_info__zput(mi) __mem_info__zput(&mi)
 
+struct block_info *block_info__new(void);
+struct block_info *block_info__get(struct block_info *bi);
+void   block_info__put(struct block_info *bi);
+
+static inline void __block_info__zput(struct block_info **bi)
+{
+	block_info__put(*bi);
+	*bi = NULL;
+}
+
+#define block_info__zput(bi) __block_info__zput(&bi)
+
 #endif /* __PERF_SYMBOL */
-- 
2.20.1

