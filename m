Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16451C48BD7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 06:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEAEF20B1F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 06:20:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbfF0GUC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 02:20:02 -0400
Received: from mga03.intel.com ([134.134.136.65]:39130 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726429AbfF0GUA (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 02:20:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jun 2019 23:20:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,422,1557212400"; 
   d="scan'208";a="156135477"
Received: from skl.sh.intel.com ([10.239.159.132])
  by orsmga008.jf.intel.com with ESMTP; 26 Jun 2019 23:19:58 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v5 1/7] perf util: Create block_info structure
Date:   Thu, 27 Jun 2019 22:09:23 +0800
Message-Id: <1561644569-22306-2-git-send-email-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1561644569-22306-1-git-send-email-yao.jin@linux.intel.com>
References: <1561644569-22306-1-git-send-email-yao.jin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

perf diff currently can only diff symbols(functions). We should expand it
to diff cycles of individual programs blocks as reported by timed LBR.
This would allow to identify changes in specific code accurately.

We need a new structure to maintain the basic block information, such as,
symbol(function), start/end address of this block, cycles. This patch
creates this structure and with some ops.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/util/symbol.c | 22 ++++++++++++++++++++++
 tools/perf/util/symbol.h | 23 +++++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index f4540f8..4e0a7b3 100644
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
index 9a8fe01..12755b4 100644
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
2.7.4

