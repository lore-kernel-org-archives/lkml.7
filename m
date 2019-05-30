Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C357EC28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 08:15:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9938625778
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 08:15:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="djAy3adU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbfE3IPI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 04:15:08 -0400
Received: from terminus.zytor.com ([198.137.202.136]:34743 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbfE3IPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 04:15:08 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4U8ElRm2904779
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 30 May 2019 01:14:47 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4U8ElRm2904779
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1559204088;
        bh=mMHCVOqKsV9JHE5V6O72mWd2OxPSRQWbYSFy1Mp0XAw=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=djAy3adUiwD9Mga9yv1cx8qsXiP4ocKnHvKaVgHYMomot6a3a2Xxk0NNo9Ma4R+1A
         omUYpOM21zvVdTAFz3giFSuH/Qi76y2AltxQF05mT2ewvQiYEM3QJhSle4sjxO4orM
         Y+MVfc+MT4X8V3mJyINSoNYfcO5HpF3ceDiYOWhvPoHABwEUcsOWeR91SC2VrmKWET
         pnzmuXUOINAmYli8JM507GrGhTUzQyxs6d1kg98IOi1/7MMTQLa3fUMAZ0432y+3Tf
         6l4ARkJh5dwY/zrAFil0MZke2AEPjLGcumBjQ4tHjZf2xG7u2R99TU0CVdnyZSFfI2
         qcYsgFI6TMTLw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4U8Ekos2904776;
        Thu, 30 May 2019 01:14:46 -0700
Date:   Thu, 30 May 2019 01:14:46 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Donald Yandt <tipbot@zytor.com>
Message-ID: <tip-34b65affe18daad31fed83e50d1f3b817786a2b7@git.kernel.org>
Cc:     yanmin_zhang@linux.intel.com, jolsa@redhat.com, hpa@zytor.com,
        mingo@kernel.org, donald.yandt@gmail.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        alexander.shishkin@linux.intel.com, peterz@infradead.org,
        acme@redhat.com
Reply-To: peterz@infradead.org, alexander.shishkin@linux.intel.com,
          acme@redhat.com, donald.yandt@gmail.com,
          linux-kernel@vger.kernel.org, mingo@kernel.org,
          tglx@linutronix.de, yanmin_zhang@linux.intel.com, hpa@zytor.com,
          jolsa@redhat.com
In-Reply-To: <20190528134128.30841-1-donald.yandt@gmail.com>
References: <20190528134128.30841-1-donald.yandt@gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf machine: Return NULL instead of
 null-terminating /proc/version array
Git-Commit-ID: 34b65affe18daad31fed83e50d1f3b817786a2b7
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

Commit-ID:  34b65affe18daad31fed83e50d1f3b817786a2b7
Gitweb:     https://git.kernel.org/tip/34b65affe18daad31fed83e50d1f3b817786a2b7
Author:     Donald Yandt <donald.yandt@gmail.com>
AuthorDate: Tue, 28 May 2019 09:41:28 -0400
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 28 May 2019 18:37:44 -0300

perf machine: Return NULL instead of null-terminating /proc/version array

Return NULL instead of null-terminating version char array when fgets
fails due to end-of-file or error.

Signed-off-by: Donald Yandt <donald.yandt@gmail.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Yanmin Zhang <yanmin_zhang@linux.intel.com>
Fixes: 30ba5b0e66c8 ("perf machine: Null-terminate version char array upon fgets(/proc/version) error")
Link: http://lkml.kernel.org/r/20190528134128.30841-1-donald.yandt@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/machine.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index f5569f005cf3..17eec39e775e 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1241,9 +1241,9 @@ static char *get_kernel_version(const char *root_dir)
 		return NULL;
 
 	tmp = fgets(version, sizeof(version), file);
-	if (!tmp)
-		*version = '\0';
 	fclose(file);
+	if (!tmp)
+		return NULL;
 
 	name = strstr(version, prefix);
 	if (!name)
