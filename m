Return-Path: <SRS0=LGpO=UH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 153A0C28CC5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 11:41:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2CCF214C6
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 11:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559994070;
	bh=B8Aohou5Y6aB5x+JbEVMQx3hBA38z8fB2pSS1mPAJAs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RLBSCLTShe88NYKWpACxlJUW23KeWmL0I3GAxpDbLUWrs5nk4V/Tlc0YkYLyK/KTV
	 keFX2yRRyUDUld/NHOraqlAekY4EptVF7F4B2W1zRiFYZRlThE2x9HUTJhh+FPFiZz
	 drmEnalfqgnMOCBEz2tChynSpKwV5hMg54Mrq1ck=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728063AbfFHLlI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 07:41:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:58424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728036AbfFHLlF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 07:41:05 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F47E214D8;
        Sat,  8 Jun 2019 11:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559994065;
        bh=B8Aohou5Y6aB5x+JbEVMQx3hBA38z8fB2pSS1mPAJAs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=14CT1jV6gg+kcx3S3Hdrg5DCFhxmAXSn/7UpFGnYEaUcAoqvCUMykPZAuH1qph1rH
         HAc+shKakLWPUCwd6oxUbcavpuIQ99ZJsLUyS0IWYfW4+g82ALL2jQsXjLQwgshJVr
         DiLVziuzjK5Ykm+TvNIX0FJBkPhBureS1AR9ALfs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Hari Bathini <hbathini@linux.vnet.ibm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Krister Johansen <kjlx@templeofstupid.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.1 45/70] perf namespace: Protect reading thread's namespace
Date:   Sat,  8 Jun 2019 07:39:24 -0400
Message-Id: <20190608113950.8033-45-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190608113950.8033-1-sashal@kernel.org>
References: <20190608113950.8033-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Namhyung Kim <namhyung@kernel.org>

[ Upstream commit 6584140ba9e6762dd7ec73795243289b914f31f9 ]

It seems that the current code lacks holding the namespace lock in
thread__namespaces().  Otherwise it can see inconsistent results.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Cc: Hari Bathini <hbathini@linux.vnet.ibm.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Krister Johansen <kjlx@templeofstupid.com>
Link: http://lkml.kernel.org/r/20190522053250.207156-2-namhyung@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/thread.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
index 50678d318185..b800752745af 100644
--- a/tools/perf/util/thread.c
+++ b/tools/perf/util/thread.c
@@ -132,7 +132,7 @@ void thread__put(struct thread *thread)
 	}
 }
 
-struct namespaces *thread__namespaces(const struct thread *thread)
+static struct namespaces *__thread__namespaces(const struct thread *thread)
 {
 	if (list_empty(&thread->namespaces_list))
 		return NULL;
@@ -140,10 +140,21 @@ struct namespaces *thread__namespaces(const struct thread *thread)
 	return list_first_entry(&thread->namespaces_list, struct namespaces, list);
 }
 
+struct namespaces *thread__namespaces(const struct thread *thread)
+{
+	struct namespaces *ns;
+
+	down_read((struct rw_semaphore *)&thread->namespaces_lock);
+	ns = __thread__namespaces(thread);
+	up_read((struct rw_semaphore *)&thread->namespaces_lock);
+
+	return ns;
+}
+
 static int __thread__set_namespaces(struct thread *thread, u64 timestamp,
 				    struct namespaces_event *event)
 {
-	struct namespaces *new, *curr = thread__namespaces(thread);
+	struct namespaces *new, *curr = __thread__namespaces(thread);
 
 	new = namespaces__new(event);
 	if (!new)
-- 
2.20.1

