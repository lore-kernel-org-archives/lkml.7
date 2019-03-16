Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24B88C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 08:44:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8881218FF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 08:44:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbfCPIoL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 04:44:11 -0400
Received: from mga06.intel.com ([134.134.136.31]:7291 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726917AbfCPIoB (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 04:44:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Mar 2019 01:44:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,485,1544515200"; 
   d="scan'208";a="152239417"
Received: from skl.sh.intel.com ([10.239.159.132])
  by fmsmga002.fm.intel.com with ESMTP; 16 Mar 2019 01:43:59 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v2 4/4] perf test: Add a simple test for term 'percore'
Date:   Sun, 17 Mar 2019 00:34:28 +0800
Message-Id: <1552754068-10325-5-git-send-email-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1552754068-10325-1-git-send-email-yao.jin@linux.intel.com>
References: <1552754068-10325-1-git-send-email-yao.jin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's a simple test which just checks if parser works.

 v2:
 ---
 Change 'coresum' to 'percore'

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/tests/parse-events.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index 4a69c07..e59a7bb 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -605,6 +605,14 @@ static int test__checkterms_simple(struct list_head *terms)
 	TEST_ASSERT_VAL("wrong val", term->val.num == 1);
 	TEST_ASSERT_VAL("wrong config", !strcmp(term->config, "umask"));
 
+	/* percore=1*/
+	term = list_entry(term->list.next, struct parse_events_term, list);
+	TEST_ASSERT_VAL("wrong type term",
+			term->type_term == PARSE_EVENTS__TERM_TYPE_PERCORE);
+	TEST_ASSERT_VAL("wrong type val",
+			term->type_val == PARSE_EVENTS__TERM_TYPE_NUM);
+	TEST_ASSERT_VAL("wrong val", term->val.num == 1);
+
 	return 0;
 }
 
@@ -1734,7 +1742,7 @@ struct terms_test {
 
 static struct terms_test test__terms[] = {
 	[0] = {
-		.str   = "config=10,config1,config2=3,umask=1",
+		.str   = "config=10,config1,config2=3,umask=1,percore=1",
 		.check = test__checkterms_simple,
 	},
 };
-- 
2.7.4

