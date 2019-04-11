Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B68E2C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 07:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90855217D4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 07:52:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbfDKHwq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 03:52:46 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:41914 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726145AbfDKHwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 03:52:41 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07437655|-1;CH=green;DM=CONTINUE|CONTINUE|true|0.389576-0.0133998-0.597024;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03306;MF=han_mao@c-sky.com;NM=1;PH=DS;RN=9;RT=9;SR=0;TI=SMTPD_---.EJoSU-3_1554969157;
Received: from localhost(mailfrom:han_mao@c-sky.com fp:SMTPD_---.EJoSU-3_1554969157)
          by smtp.aliyun-inc.com(10.147.41.187);
          Thu, 11 Apr 2019 15:52:37 +0800
From:   Mao Han <han_mao@c-sky.com>
To:     linux-kernel@vger.kernel.org
Cc:     Mao Han <han_mao@c-sky.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v4 1/3] perf evsel: Use hweight64() instead of hweight_long(attr.sample_regs_user)
Date:   Thu, 11 Apr 2019 15:44:59 +0800
Message-Id: <bd145773bdde019aa044e51306924bd84311b1d4.1554967684.git.han_mao@c-sky.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1554967684.git.han_mao@c-sky.com>
References: <cover.1554967684.git.han_mao@c-sky.com>
In-Reply-To: <cover.1554967684.git.han_mao@c-sky.com>
References: <cover.1554967684.git.han_mao@c-sky.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 32-bits platform with more than 32 registers, the 64 bits mask is
truncate to the lower 32 bits and the return value of hweight_long will
always smaller than 32. When kernel outputs more than 32 registers, but
the user perf program only counts 32, there will be a data mismatch
result to overflow check fail.

Signed-off-by: Mao Han <han_mao@c-sky.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Fixes: 6a21c0b5c2ab ("perf tools: Add core support for sampling intr machine state regs")
Fixes: d03f2170546d ("perf tools: Expand perf_event__synthesize_sample()")
Fixes: 0f6a30150ca2 ("perf tools: Support user regs and stack in sample parsing")
: http://lkml.kernel.org/r/29ad7947dc8fd1ff0abd2093a72cc27a2446be9f.1554883878.git.han_mao@c-sky.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evsel.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 66d066f..9663608 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2368,7 +2368,7 @@ int perf_evsel__parse_sample(struct perf_evsel *evsel, union perf_event *event,
 		if (data->user_regs.abi) {
 			u64 mask = evsel->attr.sample_regs_user;
 
-			sz = hweight_long(mask) * sizeof(u64);
+			sz = hweight64(mask) * sizeof(u64);
 			OVERFLOW_CHECK(array, sz, max_size);
 			data->user_regs.mask = mask;
 			data->user_regs.regs = (u64 *)array;
@@ -2424,7 +2424,7 @@ int perf_evsel__parse_sample(struct perf_evsel *evsel, union perf_event *event,
 		if (data->intr_regs.abi != PERF_SAMPLE_REGS_ABI_NONE) {
 			u64 mask = evsel->attr.sample_regs_intr;
 
-			sz = hweight_long(mask) * sizeof(u64);
+			sz = hweight64(mask) * sizeof(u64);
 			OVERFLOW_CHECK(array, sz, max_size);
 			data->intr_regs.mask = mask;
 			data->intr_regs.regs = (u64 *)array;
@@ -2552,7 +2552,7 @@ size_t perf_event__sample_event_size(const struct perf_sample *sample, u64 type,
 	if (type & PERF_SAMPLE_REGS_USER) {
 		if (sample->user_regs.abi) {
 			result += sizeof(u64);
-			sz = hweight_long(sample->user_regs.mask) * sizeof(u64);
+			sz = hweight64(sample->user_regs.mask) * sizeof(u64);
 			result += sz;
 		} else {
 			result += sizeof(u64);
@@ -2580,7 +2580,7 @@ size_t perf_event__sample_event_size(const struct perf_sample *sample, u64 type,
 	if (type & PERF_SAMPLE_REGS_INTR) {
 		if (sample->intr_regs.abi) {
 			result += sizeof(u64);
-			sz = hweight_long(sample->intr_regs.mask) * sizeof(u64);
+			sz = hweight64(sample->intr_regs.mask) * sizeof(u64);
 			result += sz;
 		} else {
 			result += sizeof(u64);
@@ -2710,7 +2710,7 @@ int perf_event__synthesize_sample(union perf_event *event, u64 type,
 	if (type & PERF_SAMPLE_REGS_USER) {
 		if (sample->user_regs.abi) {
 			*array++ = sample->user_regs.abi;
-			sz = hweight_long(sample->user_regs.mask) * sizeof(u64);
+			sz = hweight64(sample->user_regs.mask) * sizeof(u64);
 			memcpy(array, sample->user_regs.regs, sz);
 			array = (void *)array + sz;
 		} else {
@@ -2746,7 +2746,7 @@ int perf_event__synthesize_sample(union perf_event *event, u64 type,
 	if (type & PERF_SAMPLE_REGS_INTR) {
 		if (sample->intr_regs.abi) {
 			*array++ = sample->intr_regs.abi;
-			sz = hweight_long(sample->intr_regs.mask) * sizeof(u64);
+			sz = hweight64(sample->intr_regs.mask) * sizeof(u64);
 			memcpy(array, sample->intr_regs.regs, sz);
 			array = (void *)array + sz;
 		} else {
-- 
2.7.4

