Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C9ADC0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1160621850
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:33:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="xR73vxu0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbfGCOdR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 10:33:17 -0400
Received: from terminus.zytor.com ([198.137.202.136]:59897 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726490AbfGCOdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 10:33:17 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x63EWuU43327667
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 3 Jul 2019 07:32:56 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x63EWuU43327667
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1562164377;
        bh=QdhKYuzPTneb56kFeLUBSMIHESEum/an+7ClSu6ny3M=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=xR73vxu0biqBsHRZnDQED/B4KNsVIgB9rrUEIaNhi8QnGxg8zvMhHzlyzGSAicKxE
         3i6DAmfDPaEjY3NcUTNXf0my6jabbbH/jGtb5saZ9jS4VQA80lNLHMwr76ZZj/aUuy
         dHHLdE+dV9JWzrcQJwwwNknHZoG5BvEvzV2jMCcC2iLdUcwA4ZlR/eNRpw8kdDF9yY
         pPI1y6x3S9vUun1L9Wy6aXpK9cUXS3W0wDME6KHO/qd052gUTWmV5UrT5snFskBbMF
         VVYdKjD55uimdZEeJjpagKwKR4tHKT1/ni/TqyZplsbBgtIMImQYuj+JmpXh1ChqcZ
         M/TyKuVO9QNWQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x63EWtIV3327661;
        Wed, 3 Jul 2019 07:32:55 -0700
Date:   Wed, 3 Jul 2019 07:32:55 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jin Yao <tipbot@zytor.com>
Message-ID: <tip-0cec2447e7d209b77e52c6ec62169cc564df54e7@git.kernel.org>
Cc:     mingo@kernel.org, peterz@infradead.org, kan.liang@linux.intel.com,
        yao.jin@intel.com, hpa@zytor.com, jolsa@kernel.org,
        alexander.shishkin@linux.intel.com, acme@redhat.com,
        tglx@linutronix.de, ak@linux.intel.com,
        linux-kernel@vger.kernel.org, yao.jin@linux.intel.com
Reply-To: yao.jin@linux.intel.com, ak@linux.intel.com,
          linux-kernel@vger.kernel.org, tglx@linutronix.de,
          acme@redhat.com, hpa@zytor.com, jolsa@kernel.org,
          alexander.shishkin@linux.intel.com, kan.liang@linux.intel.com,
          yao.jin@intel.com, mingo@kernel.org, peterz@infradead.org
In-Reply-To: <1561713784-30533-2-git-send-email-yao.jin@linux.intel.com>
References: <1561713784-30533-2-git-send-email-yao.jin@linux.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf symbol: Create block_info structure
Git-Commit-ID: 0cec2447e7d209b77e52c6ec62169cc564df54e7
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

Commit-ID:  0cec2447e7d209b77e52c6ec62169cc564df54e7
Gitweb:     https://git.kernel.org/tip/0cec2447e7d209b77e52c6ec62169cc564df54e7
Author:     Jin Yao <yao.jin@linux.intel.com>
AuthorDate: Fri, 28 Jun 2019 17:22:58 +0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 2 Jul 2019 12:44:19 -0300

perf symbol: Create block_info structure

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
