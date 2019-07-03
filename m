Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6430C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:35:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88DCE21850
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:35:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="tHhdk3Eh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbfGCOfo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 10:35:44 -0400
Received: from terminus.zytor.com ([198.137.202.136]:52717 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbfGCOfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 10:35:43 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x63EYMxq3328050
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 3 Jul 2019 07:34:23 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x63EYMxq3328050
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1562164463;
        bh=TzaUPptbuNZ3LN8VFvFVeYhpzHds8Y+PZ/yN7PMTwFw=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=tHhdk3EhNQX+SFr2+U7ji8q6GEFStNSoIawb0riomB7z5GLPE9BUGDAGxRL7Ty11h
         JPV4xg4EA2dsyjQ//gG8elhQX5NwUO41/oNK7ZUmFM5WAtSZ1aOagdt2N6bBHV31O5
         oa/MDYZSi6d/NMsxk5TqG6Chx6QUlZA7H7p/JnWHKL36331mpJgKjQRh+5WKsM50Zn
         Favj7Mhi7T+ZKotuZ7+CBtTXqYo53NcnHSZ68tPaPd4j3mRBArjl3BYj1YY2yJd9EW
         KQ+qF+rDtJAQnvphWKVQViBdrVJseLn9ItdAS0AglZLY926jtlR/+33etGrMnWtowc
         FW8p6TQcURe8Q==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x63EYMRe3328045;
        Wed, 3 Jul 2019 07:34:22 -0700
Date:   Wed, 3 Jul 2019 07:34:22 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jin Yao <tipbot@zytor.com>
Message-ID: <tip-30d815534e63d737f8004414d12b1679c032e0dd@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, jolsa@kernel.org, ak@linux.intel.com,
        yao.jin@intel.com, alexander.shishkin@linux.intel.com,
        mingo@kernel.org, tglx@linutronix.de, acme@redhat.com,
        hpa@zytor.com, peterz@infradead.org, yao.jin@linux.intel.com,
        kan.liang@linux.intel.com
Reply-To: jolsa@kernel.org, linux-kernel@vger.kernel.org,
          ak@linux.intel.com, yao.jin@intel.com,
          alexander.shishkin@linux.intel.com, mingo@kernel.org,
          tglx@linutronix.de, acme@redhat.com, hpa@zytor.com,
          peterz@infradead.org, yao.jin@linux.intel.com,
          kan.liang@linux.intel.com
In-Reply-To: <1561713784-30533-4-git-send-email-yao.jin@linux.intel.com>
References: <1561713784-30533-4-git-send-email-yao.jin@linux.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf diff: Check if all data files with branch
 stacks
Git-Commit-ID: 30d815534e63d737f8004414d12b1679c032e0dd
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

Commit-ID:  30d815534e63d737f8004414d12b1679c032e0dd
Gitweb:     https://git.kernel.org/tip/30d815534e63d737f8004414d12b1679c032e0dd
Author:     Jin Yao <yao.jin@linux.intel.com>
AuthorDate: Fri, 28 Jun 2019 17:23:00 +0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 2 Jul 2019 12:46:11 -0300

perf diff: Check if all data files with branch stacks

We will expand perf diff to support diff cycles of individual programs
blocks, so it requires all data files having branch stacks.

This patch checks HEADER_BRANCH_STACK in header, and only set the flag
has_br_stack when HEADER_BRANCH_STACK are set in all data files.

 v2:
 ---
 Move check_file_brstack() from __cmd_diff() to cmd_diff().
 Because later patch will check flag 'has_br_stack' before
 ui_init().

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@intel.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1561713784-30533-4-git-send-email-yao.jin@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-diff.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
index 6e7920793729..a7e04202955c 100644
--- a/tools/perf/builtin-diff.c
+++ b/tools/perf/builtin-diff.c
@@ -32,6 +32,7 @@ struct perf_diff {
 	struct perf_time_interval	*ptime_range;
 	int				 range_size;
 	int				 range_num;
+	bool				 has_br_stack;
 };
 
 /* Diff command specific HPP columns. */
@@ -873,6 +874,31 @@ static int parse_time_str(struct data__file *d, char *abstime_ostr,
 	return ret;
 }
 
+static int check_file_brstack(void)
+{
+	struct data__file *d;
+	bool has_br_stack;
+	int i;
+
+	data__for_each_file(i, d) {
+		d->session = perf_session__new(&d->data, false, &pdiff.tool);
+		if (!d->session) {
+			pr_err("Failed to open %s\n", d->data.path);
+			return -1;
+		}
+
+		has_br_stack = perf_header__has_feat(&d->session->header,
+						     HEADER_BRANCH_STACK);
+		perf_session__delete(d->session);
+		if (!has_br_stack)
+			return 0;
+	}
+
+	/* Set only all files having branch stacks */
+	pdiff.has_br_stack = true;
+	return 0;
+}
+
 static int __cmd_diff(void)
 {
 	struct data__file *d;
@@ -1487,6 +1513,9 @@ int cmd_diff(int argc, const char **argv)
 	if (data_init(argc, argv) < 0)
 		return -1;
 
+	if (check_file_brstack() < 0)
+		return -1;
+
 	if (ui_init() < 0)
 		return -1;
 
