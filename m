Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AA7EC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:27:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C5ED2075C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553714844;
	bh=a/R98ag9Z/zJEGQ59q3ginxprmNPH1EFgKSJeldXw/o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=p/ssS4jDbaIgQNBJfzG6ZhGKQO9LtPVR/TTMC2TPA54EgC4adkS3W2DmLl25DOtUU
	 t7nYvhm5IRsXMvWJjKNc3erfjSD3AGO1aQxOJ62iO/5lJEJzk6yZJDtDed5il+P6eL
	 JmADe8Ln3hOsOETe6gWUM5nM7ONZYpls45BgKAp4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387848AbfC0T1X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 15:27:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:45570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731614AbfC0SEq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:04:46 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47222217F5;
        Wed, 27 Mar 2019 18:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553709885;
        bh=a/R98ag9Z/zJEGQ59q3ginxprmNPH1EFgKSJeldXw/o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xjd/wZGjiiGGS3/9Q4ysfdhQ+RdaPOvWp6xbYaoJ15A+ShkCbDM2zM3FVaBcjG/e7
         PC2bEai0Ahw0xQeW3YELErRBKnjhJVsor9BCYMfDW+nTP4rGMLLxpxilGFLQP7pJL5
         fJGwqeX6m3gu7fGluHa2yV2MwTe6EqBnUaeLd0Xk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.0 089/262] perf script: Handle missing fields with -F +..
Date:   Wed, 27 Mar 2019 13:59:04 -0400
Message-Id: <20190327180158.10245-89-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327180158.10245-1-sashal@kernel.org>
References: <20190327180158.10245-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

[ Upstream commit 4b6ac811bce46c83811b83cdf87b41251596b9fc ]

When using -F + syntax to add a field the existing defaults are
currently all marked user_set. This can cause errors when some field is
missing in the perf.data

This patch tracks the actually user set fields separately, so that we don't
error out in this case.

Before:

  % perf record true
  % perf script -F +metric
  Samples for 'cycles:ppp' event do not have CPU attribute set. Cannot print 'cpu' field.
  %

After:

  5 perf record true
  % perf script -F +metric
              perf 28936 278636.237688:          1 cycles:ppp:  ffffffff8117da99 perf_event_exec+0x59 (/lib/modules/4.20.0-odilo/build/vmlinux)
  ...
  %

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lkml.kernel.org/r/20190224153722.27020-2-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/builtin-script.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index ac221f137ed2..cff4d10daf49 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -148,6 +148,7 @@ static struct {
 	unsigned int print_ip_opts;
 	u64 fields;
 	u64 invalid_fields;
+	u64 user_set_fields;
 } output[OUTPUT_TYPE_MAX] = {
 
 	[PERF_TYPE_HARDWARE] = {
@@ -344,7 +345,7 @@ static int perf_evsel__do_check_stype(struct perf_evsel *evsel,
 	if (attr->sample_type & sample_type)
 		return 0;
 
-	if (output[type].user_set) {
+	if (output[type].user_set_fields & field) {
 		if (allow_user_set)
 			return 0;
 		evname = perf_evsel__name(evsel);
@@ -2627,10 +2628,13 @@ static int parse_output_fields(const struct option *opt __maybe_unused,
 					pr_warning("\'%s\' not valid for %s events. Ignoring.\n",
 						   all_output_options[i].str, event_type(j));
 				} else {
-					if (change == REMOVE)
+					if (change == REMOVE) {
 						output[j].fields &= ~all_output_options[i].field;
-					else
+						output[j].user_set_fields &= ~all_output_options[i].field;
+					} else {
 						output[j].fields |= all_output_options[i].field;
+						output[j].user_set_fields |= all_output_options[i].field;
+					}
 					output[j].user_set = true;
 					output[j].wildcard_set = true;
 				}
-- 
2.19.1

