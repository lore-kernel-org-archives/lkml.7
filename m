Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63F71C3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:00:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31BA723400
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567620026;
	bh=sT01fR+XnH3y3f0Hio8gBB8oGNSugXeFEJqbhWXUlTQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IJl9/1zbsEye+2TZ4BUMArZFVKWZ/BVOeobopBXCzs+YaLq870TP4/K2Z0iniQW+R
	 +a5LX0To12jKtBo62/1ADNj54Tclo6tp0qZuQt9dfF4iIpAl0MWp8xAF6A9yBrDPhE
	 /1rZB1QTVWdDLYX6GAUq/qTemR816X5HWe/bUiL0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388388AbfIDSAZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 14:00:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:39552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388004AbfIDSAV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 14:00:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16F3D21883;
        Wed,  4 Sep 2019 18:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567620020;
        bh=sT01fR+XnH3y3f0Hio8gBB8oGNSugXeFEJqbhWXUlTQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ObKryKXq8Vzoy4t6MfFsrScbMooHdFNQ4bfj27DatMw3BG3jL4+881OBBQTocN7hZ
         3K1MA5xQ1ph+jz9MS0l5/tr2Fmj1EmO4VNL2gz8gslAAaIAdhJ2MEjoor8TD3l+4eh
         K3mtNo43cJU0FlfHpL/797teUPZLJJ9GcZg8yuYM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 44/83] Revert "perf test 6: Fix missing kvm module load for s390"
Date:   Wed,  4 Sep 2019 19:53:36 +0200
Message-Id: <20190904175307.727656314@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190904175303.488266791@linuxfoundation.org>
References: <20190904175303.488266791@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 9a501cdb05348fa8f85db8df5a82f4b8cd11594e.

Which was upstream commit 53fe307dfd309e425b171f6272d64296a54f4dff.

Ben Hutchings reports that this commit depends on new code added in
v4.18, and so is irrelevant on older kernels, and breaks the build.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/tests/parse-events.c | 27 ---------------------------
 1 file changed, 27 deletions(-)

diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index 9134a0c3e99df..aa9276bfe3e9b 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -12,32 +12,6 @@
 #define PERF_TP_SAMPLE_TYPE (PERF_SAMPLE_RAW | PERF_SAMPLE_TIME | \
 			     PERF_SAMPLE_CPU | PERF_SAMPLE_PERIOD)
 
-#if defined(__s390x__)
-/* Return true if kvm module is available and loaded. Test this
- * and retun success when trace point kvm_s390_create_vm
- * exists. Otherwise this test always fails.
- */
-static bool kvm_s390_create_vm_valid(void)
-{
-	char *eventfile;
-	bool rc = false;
-
-	eventfile = get_events_file("kvm-s390");
-
-	if (eventfile) {
-		DIR *mydir = opendir(eventfile);
-
-		if (mydir) {
-			rc = true;
-			closedir(mydir);
-		}
-		put_events_file(eventfile);
-	}
-
-	return rc;
-}
-#endif
-
 static int test__checkevent_tracepoint(struct perf_evlist *evlist)
 {
 	struct perf_evsel *evsel = perf_evlist__first(evlist);
@@ -1619,7 +1593,6 @@ static struct evlist_test test__events[] = {
 	{
 		.name  = "kvm-s390:kvm_s390_create_vm",
 		.check = test__checkevent_tracepoint,
-		.valid = kvm_s390_create_vm_valid,
 		.id    = 100,
 	},
 #endif
-- 
2.20.1



