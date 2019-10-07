Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D935C47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 12:54:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5EE121924
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 12:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570452884;
	bh=Eh/XSGKpppK18CKFKaIQJ6khIpA8L9pWy/nNWO794BY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iQjlMTqNmKotW6MJHSoqJwQd0DcFYgVXreYi2k7VdnFa2doE+NPll7WWILD/5eWUp
	 kDazDs7zEaZbxDiDfMYePsXO36a0GNCToQe7Fwnoo94LV4xxaRAfx0HNQiUwbve5Rb
	 DPJ/bGfxCQwx4iJ7WbT2FTswaJAOqs0kjFFpStf8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728377AbfJGMym (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 08:54:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58750 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728354AbfJGMyi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 08:54:38 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 468EE3084037;
        Mon,  7 Oct 2019 12:54:38 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0A52F5D9CC;
        Mon,  7 Oct 2019 12:54:35 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 22/36] libperf: Centralize map refcnt setting
Date:   Mon,  7 Oct 2019 14:53:30 +0200
Message-Id: <20191007125344.14268-23-jolsa@kernel.org>
In-Reply-To: <20191007125344.14268-1-jolsa@kernel.org>
References: <20191007125344.14268-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Mon, 07 Oct 2019 12:54:38 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently when new map is mmaps we set its refcnt
to 2 in perf_evlist_mmap_ops::mmap callback.

Every mmap is given refcnt set to 2 when it's first mmaped:
  - 1 for current user, which will be taken out by call to
    perf_evlist__munmap_filtered, where we find out there's
    no more data comming from kernel to this mmap
  - 1 for drain code where in perf_mmap__consume the mmap
    is released if it is empty

Moving this common setup into libperf generic code
before mmap callback is called.

Link: http://lkml.kernel.org/n/tip-3us74tjjz258bgk2pavjaq59@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/lib/evlist.c | 30 +++++++++++++++---------------
 tools/perf/util/mmap.c  | 15 ---------------
 2 files changed, 15 insertions(+), 30 deletions(-)

diff --git a/tools/perf/lib/evlist.c b/tools/perf/lib/evlist.c
index b69722627779..f9a802d2ceb5 100644
--- a/tools/perf/lib/evlist.c
+++ b/tools/perf/lib/evlist.c
@@ -362,21 +362,6 @@ static int
 perf_evlist__mmap_cb_mmap(struct perf_mmap *map, struct perf_mmap_param *mp,
 			  int output, int cpu)
 {
-	/*
-	 * The last one will be done at perf_mmap__consume(), so that we
-	 * make sure we don't prevent tools from consuming every last event in
-	 * the ring buffer.
-	 *
-	 * I.e. we can get the POLLHUP meaning that the fd doesn't exist
-	 * anymore, but the last events for it are still in the ring buffer,
-	 * waiting to be consumed.
-	 *
-	 * Tools can chose to ignore this at their own discretion, but the
-	 * evlist layer can't just drop it when filtering events in
-	 * perf_evlist__filter_pollfd().
-	 */
-	refcount_set(&map->refcnt, 2);
-
 	return perf_mmap__mmap(map, mp, output, cpu);
 }
 
@@ -418,6 +403,21 @@ mmap_per_evsel(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *ops,
 		if (*output == -1) {
 			*output = fd;
 
+			/*
+			 * The last one will be done at perf_mmap__consume(), so that we
+			 * make sure we don't prevent tools from consuming every last event in
+			 * the ring buffer.
+			 *
+			 * I.e. we can get the POLLHUP meaning that the fd doesn't exist
+			 * anymore, but the last events for it are still in the ring buffer,
+			 * waiting to be consumed.
+			 *
+			 * Tools can chose to ignore this at their own discretion, but the
+			 * evlist layer can't just drop it when filtering events in
+			 * perf_evlist__filter_pollfd().
+			 */
+			refcount_set(&map->refcnt, 2);
+
 			if (ops->mmap(map, mp, *output, evlist_cpu) < 0)
 				return -1;
 		} else {
diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index 2a8bf0ab861c..063d1b93c53d 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -243,21 +243,6 @@ static void perf_mmap__setup_affinity_mask(struct mmap *map, struct mmap_params
 
 int mmap__mmap(struct mmap *map, struct mmap_params *mp, int fd, int cpu)
 {
-	/*
-	 * The last one will be done at perf_mmap__consume(), so that we
-	 * make sure we don't prevent tools from consuming every last event in
-	 * the ring buffer.
-	 *
-	 * I.e. we can get the POLLHUP meaning that the fd doesn't exist
-	 * anymore, but the last events for it are still in the ring buffer,
-	 * waiting to be consumed.
-	 *
-	 * Tools can chose to ignore this at their own discretion, but the
-	 * evlist layer can't just drop it when filtering events in
-	 * perf_evlist__filter_pollfd().
-	 */
-	refcount_set(&map->core.refcnt, 2);
-
 	if (perf_mmap__mmap(&map->core, &mp->core, fd, cpu)) {
 		pr_debug2("failed to mmap perf event ring buffer, error %d\n",
 			  errno);
-- 
2.21.0

