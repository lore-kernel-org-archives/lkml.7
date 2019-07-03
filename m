Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECDBAC0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B93CC218A6
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:03:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="uJgtEcRF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbfGCODN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 10:03:13 -0400
Received: from terminus.zytor.com ([198.137.202.136]:33985 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbfGCODN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 10:03:13 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x63E2hIP3318473
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 3 Jul 2019 07:02:43 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x63E2hIP3318473
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1562162564;
        bh=m6ftjh9jiLen9wZRZMjrphqIHAx+1NwhFiXu7nN7In0=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=uJgtEcRFqPx/VdKNeJUpbqcMF3U9h9yG92pB5LPOP5oW3ceYlpzD0tSYyJR7kIykt
         0pRGtJr1fy8H6g74kn8K4QymUni2DV6AhPOje6UWq4cEFLgyVXcHySN9rSoCdeFjlT
         piaV5xWZrG4oljAOGZYVusQvFCeDy9usswFvPLjXzA4MBe+sHVI7mDBa2AMEspJR5e
         EQc1xazT/m75isb5bt2Y45Y3flLGiw88qHtMaILy4UNsGlnHuXAfvZnujm5DpTEF0v
         FRa5QjTmCK2XnLMUCpDbgv7A9MnDBq3hX6AHYlx3nuO35pEsaePtUgtqpmrPE+cPJ7
         yi2wwTwoug2Rg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x63E2g3k3318467;
        Wed, 3 Jul 2019 07:02:42 -0700
Date:   Wed, 3 Jul 2019 07:02:42 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-eb5d854456f5a4ccec6f9681b7196cf056df8cfa@git.kernel.org>
Cc:     jolsa@redhat.com, adrian.hunter@intel.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, acme@redhat.com,
        hpa@zytor.com
Reply-To: hpa@zytor.com, tglx@linutronix.de, linux-kernel@vger.kernel.org,
          acme@redhat.com, mingo@kernel.org, adrian.hunter@intel.com,
          jolsa@redhat.com
In-Reply-To: <20190619064429.14940-3-adrian.hunter@intel.com>
References: <20190619064429.14940-3-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf thread-stack: Eliminate code duplicating
 thread_stack__pop_ks()
Git-Commit-ID: eb5d854456f5a4ccec6f9681b7196cf056df8cfa
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

Commit-ID:  eb5d854456f5a4ccec6f9681b7196cf056df8cfa
Gitweb:     https://git.kernel.org/tip/eb5d854456f5a4ccec6f9681b7196cf056df8cfa
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Wed, 19 Jun 2019 09:44:29 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 25 Jun 2019 08:47:10 -0300

perf thread-stack: Eliminate code duplicating thread_stack__pop_ks()

Use new function thread_stack__pop_ks() in place of equivalent code.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190619064429.14940-3-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/thread-stack.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/tools/perf/util/thread-stack.c b/tools/perf/util/thread-stack.c
index 4c826a2e08d8..6ff1ff4d4ce7 100644
--- a/tools/perf/util/thread-stack.c
+++ b/tools/perf/util/thread-stack.c
@@ -664,12 +664,9 @@ static int thread_stack__no_call_return(struct thread *thread,
 
 	if (ip >= ks && addr < ks) {
 		/* Return to userspace, so pop all kernel addresses */
-		while (thread_stack__in_kernel(ts)) {
-			err = thread_stack__call_return(thread, ts, --ts->cnt,
-							tm, ref, true);
-			if (err)
-				return err;
-		}
+		err = thread_stack__pop_ks(thread, ts, sample, ref);
+		if (err)
+			return err;
 
 		/* If the stack is empty, push the userspace address */
 		if (!ts->cnt) {
@@ -679,12 +676,9 @@ static int thread_stack__no_call_return(struct thread *thread,
 		}
 	} else if (thread_stack__in_kernel(ts) && ip < ks) {
 		/* Return to userspace, so pop all kernel addresses */
-		while (thread_stack__in_kernel(ts)) {
-			err = thread_stack__call_return(thread, ts, --ts->cnt,
-							tm, ref, true);
-			if (err)
-				return err;
-		}
+		err = thread_stack__pop_ks(thread, ts, sample, ref);
+		if (err)
+			return err;
 	}
 
 	if (ts->cnt)
