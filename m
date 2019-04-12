Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF6B0C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 16:42:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B75F62075B
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 16:42:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbfDLQmC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 12:42:02 -0400
Received: from terminus.zytor.com ([198.137.202.136]:44881 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbfDLQmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 12:42:02 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3CGeT201753340
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 12 Apr 2019 09:40:29 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3CGeSWv1753337;
        Fri, 12 Apr 2019 09:40:28 -0700
Date:   Fri, 12 Apr 2019 09:40:28 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Mao Han <tipbot@zytor.com>
Message-ID: <tip-21e6dfe04861c2c1b529f2759850bc62a80ca050@git.kernel.org>
Cc:     acme@redhat.com, adrian.hunter@intel.com, peterz@infradead.org,
        namhyung@kernel.org, tglx@linutronix.de, han_mao@c-sky.com,
        alexander.shishkin@linux.intel.com, hpa@zytor.com,
        eranian@google.com, mingo@kernel.org, jolsa@redhat.com,
        linux-kernel@vger.kernel.org
Reply-To: jolsa@redhat.com, linux-kernel@vger.kernel.org,
          alexander.shishkin@linux.intel.com, hpa@zytor.com,
          mingo@kernel.org, eranian@google.com, namhyung@kernel.org,
          tglx@linutronix.de, han_mao@c-sky.com, acme@redhat.com,
          peterz@infradead.org, adrian.hunter@intel.com
In-Reply-To: <29ad7947dc8fd1ff0abd2093a72cc27a2446be9f.1554883878.git.han_mao@c-sky.com>
References: <29ad7947dc8fd1ff0abd2093a72cc27a2446be9f.1554883878.git.han_mao@c-sky.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf evsel: Use hweight64() instead of
 hweight_long(attr.sample_regs_user)
Git-Commit-ID: 21e6dfe04861c2c1b529f2759850bc62a80ca050
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

Commit-ID:  21e6dfe04861c2c1b529f2759850bc62a80ca050
Gitweb:     https://git.kernel.org/tip/21e6dfe04861c2c1b529f2759850bc62a80ca050
Author:     Mao Han <han_mao@c-sky.com>
AuthorDate: Wed, 10 Apr 2019 16:16:43 +0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 10 Apr 2019 10:25:28 -0300

perf evsel: Use hweight64() instead of hweight_long(attr.sample_regs_user)

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
Link: http://lkml.kernel.org/r/29ad7947dc8fd1ff0abd2093a72cc27a2446be9f.1554883878.git.han_mao@c-sky.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evsel.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 66d066f18b5b..966360844fff 100644
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
