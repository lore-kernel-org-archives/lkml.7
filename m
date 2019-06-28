Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6795AC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 11:16:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E142208E3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 11:16:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CLpGl7MV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbfF1LQc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 07:16:32 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44787 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbfF1LQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 07:16:31 -0400
Received: by mail-pl1-f194.google.com with SMTP id t7so3064050plr.11
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 04:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=9sipjHExFeuV0K4UVRepUa+lADx+MbUcc8ZZsr0g1z8=;
        b=CLpGl7MVAA5z/efotkyK3c2z4dD4AyInMNHT0tUmc4cqfeE8y9vwvj39u7b2zrD+et
         tCIRt/5GhFSMwXDep80CHeU3SqpJ28HmcmX/uBjE/EUvGWpWdB574k6n2+lJjixspJXt
         +YP6iNPdTakoR7dOl9eV/8GCUDGT7GwROXAus=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9sipjHExFeuV0K4UVRepUa+lADx+MbUcc8ZZsr0g1z8=;
        b=lMj9g2EpVFcpIBM72CMHovi+PbeolPjpVxrK5Lx2kdo2r9W9G5OBPI+QL3LJdy0rZD
         zDG/ZMZXj9VX7AS2BSgUp25zSCVObjUIsQEXhXXzbaxgpLzfMvImtafY1/T1ybp+0SnO
         Umi/LdHPGpc0a0LvjBNCeb7xa2BATPtR09D0zrQE8D93baC7kRgjU5TeOEI/Tb0ElUMi
         LOK1ZjZM28XqD20GrO9yVgTQCI9dLSPYvyUYoqscDyO+Fi5+Hs3IrD2kv7jfs6pfypib
         zcyxO8okhUOoi5hFOZoejuQJudldL/e3na0Ob6PFDZQc3e4XLKu6I4KlmDLmj8rbo+Wj
         d+Mw==
X-Gm-Message-State: APjAAAVTglGQhoRbnSVQsDJe20+0s8+HyRYWCAbtqQtH/98RHQSDAYT3
        7/z8XVhreP/vyF0r08EfFtDn0VC3xvtQ
X-Google-Smtp-Source: APXvYqwFBxOXRwJS5o/s0J9UhYNxGdQOVXQ/vWFl+RQQGuFDJp2kNVy5jlupPWRbnXu8ylFSsIEXdQ==
X-Received: by 2002:a17:902:b20c:: with SMTP id t12mr11043488plr.285.1561720590639;
        Fri, 28 Jun 2019 04:16:30 -0700 (PDT)
Received: from google.com ([2401:fa00:1:b:d89e:cfa6:3c8:e61b])
        by smtp.gmail.com with ESMTPSA id n184sm1893411pfn.21.2019.06.28.04.16.28
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 28 Jun 2019 04:16:30 -0700 (PDT)
Date:   Fri, 28 Jun 2019 19:16:27 +0800
From:   Kuo-Hsin Yang <vovoy@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     Minchan Kim <minchan@kernel.org>, Michal Hocko <mhocko@suse.com>,
        Sonny Rao <sonnyrao@chromium.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v2] mm: vmscan: fix not scanning anonymous pages when
 detecting file refaults
Message-ID: <20190628111627.GA107040@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190619080835.GA68312@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When file refaults are detected and there are many inactive file pages,
the system never reclaim anonymous pages, the file pages are dropped
aggressively when there are still a lot of cold anonymous pages and
system thrashes.  This issue impacts the performance of applications
with large executable, e.g. chrome.

Commit 2a2e48854d70 ("mm: vmscan: fix IO/refault regression in cache
workingset transition") introduced actual_reclaim parameter.  When file
refaults are detected, inactive_list_is_low() may return different
values depends on the actual_reclaim parameter.  Vmscan would only scan
active/inactive file lists at file thrashing state when the following 2
conditions are satisfied.

1) inactive_list_is_low() returns false in get_scan_count() to trigger
   scanning file lists only.
2) inactive_list_is_low() returns true in shrink_list() to allow
   scanning active file list.

This patch makes the return value of inactive_list_is_low() independent
of actual_reclaim and rename the parameter back to trace.

The problem can be reproduced by the following test program.

---8<---
void fallocate_file(const char *filename, off_t size)
{
	struct stat st;
	int fd;

	if (!stat(filename, &st) && st.st_size >= size)
		return;

	fd = open(filename, O_WRONLY | O_CREAT, 0600);
	if (fd < 0) {
		perror("create file");
		exit(1);
	}
	if (posix_fallocate(fd, 0, size)) {
		perror("fallocate");
		exit(1);
	}
	close(fd);
}

long *alloc_anon(long size)
{
	long *start = malloc(size);
	memset(start, 1, size);
	return start;
}

long access_file(const char *filename, long size, long rounds)
{
	int fd, i;
	volatile char *start1, *end1, *start2;
	const int page_size = getpagesize();
	long sum = 0;

	fd = open(filename, O_RDONLY);
	if (fd == -1) {
		perror("open");
		exit(1);
	}

	/*
	 * Some applications, e.g. chrome, use a lot of executable file
	 * pages, map some of the pages with PROT_EXEC flag to simulate
	 * the behavior.
	 */
	start1 = mmap(NULL, size / 2, PROT_READ | PROT_EXEC, MAP_SHARED,
		      fd, 0);
	if (start1 == MAP_FAILED) {
		perror("mmap");
		exit(1);
	}
	end1 = start1 + size / 2;

	start2 = mmap(NULL, size / 2, PROT_READ, MAP_SHARED, fd, size / 2);
	if (start2 == MAP_FAILED) {
		perror("mmap");
		exit(1);
	}

	for (i = 0; i < rounds; ++i) {
		struct timeval before, after;
		volatile char *ptr1 = start1, *ptr2 = start2;
		gettimeofday(&before, NULL);
		for (; ptr1 < end1; ptr1 += page_size, ptr2 += page_size)
			sum += *ptr1 + *ptr2;
		gettimeofday(&after, NULL);
		printf("File access time, round %d: %f (sec)\n", i,
		       (after.tv_sec - before.tv_sec) +
		       (after.tv_usec - before.tv_usec) / 1000000.0);
	}
	return sum;
}

int main(int argc, char *argv[])
{
	const long MB = 1024 * 1024;
	long anon_mb, file_mb, file_rounds;
	const char filename[] = "large";
	long *ret1;
	long ret2;

	if (argc != 4) {
		printf("usage: thrash ANON_MB FILE_MB FILE_ROUNDS\n");
		exit(0);
	}
	anon_mb = atoi(argv[1]);
	file_mb = atoi(argv[2]);
	file_rounds = atoi(argv[3]);

	fallocate_file(filename, file_mb * MB);
	printf("Allocate %ld MB anonymous pages\n", anon_mb);
	ret1 = alloc_anon(anon_mb * MB);
	printf("Access %ld MB file pages\n", file_mb);
	ret2 = access_file(filename, file_mb * MB, file_rounds);
	printf("Print result to prevent optimization: %ld\n",
	       *ret1 + ret2);
	return 0;
}
---8<---

Running the test program on 2GB RAM VM with kernel 5.2.0-rc5, the
program fills ram with 2048 MB memory, access a 200 MB file for 10
times.  Without this patch, the file cache is dropped aggresively and
every access to the file is from disk.

  $ ./thrash 2048 200 10
  Allocate 2048 MB anonymous pages
  Access 200 MB file pages
  File access time, round 0: 2.489316 (sec)
  File access time, round 1: 2.581277 (sec)
  File access time, round 2: 2.487624 (sec)
  File access time, round 3: 2.449100 (sec)
  File access time, round 4: 2.420423 (sec)
  File access time, round 5: 2.343411 (sec)
  File access time, round 6: 2.454833 (sec)
  File access time, round 7: 2.483398 (sec)
  File access time, round 8: 2.572701 (sec)
  File access time, round 9: 2.493014 (sec)

With this patch, these file pages can be cached.

  $ ./thrash 2048 200 10
  Allocate 2048 MB anonymous pages
  Access 200 MB file pages
  File access time, round 0: 2.475189 (sec)
  File access time, round 1: 2.440777 (sec)
  File access time, round 2: 2.411671 (sec)
  File access time, round 3: 1.955267 (sec)
  File access time, round 4: 0.029924 (sec)
  File access time, round 5: 0.000808 (sec)
  File access time, round 6: 0.000771 (sec)
  File access time, round 7: 0.000746 (sec)
  File access time, round 8: 0.000738 (sec)
  File access time, round 9: 0.000747 (sec)

Fixes: 2a2e48854d70 ("mm: vmscan: fix IO/refault regression in cache workingset transition")
Signed-off-by: Kuo-Hsin Yang <vovoy@chromium.org>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/vmscan.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 7889f583ced9f..da0b97204372e 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2125,7 +2125,7 @@ static void shrink_active_list(unsigned long nr_to_scan,
  *   10TB     320        32GB
  */
 static bool inactive_list_is_low(struct lruvec *lruvec, bool file,
-				 struct scan_control *sc, bool actual_reclaim)
+				 struct scan_control *sc, bool trace)
 {
 	enum lru_list active_lru = file * LRU_FILE + LRU_ACTIVE;
 	struct pglist_data *pgdat = lruvec_pgdat(lruvec);
@@ -2151,7 +2151,7 @@ static bool inactive_list_is_low(struct lruvec *lruvec, bool file,
 	 * rid of the stale workingset quickly.
 	 */
 	refaults = lruvec_page_state_local(lruvec, WORKINGSET_ACTIVATE);
-	if (file && actual_reclaim && lruvec->refaults != refaults) {
+	if (file && lruvec->refaults != refaults) {
 		inactive_ratio = 0;
 	} else {
 		gb = (inactive + active) >> (30 - PAGE_SHIFT);
@@ -2161,7 +2161,7 @@ static bool inactive_list_is_low(struct lruvec *lruvec, bool file,
 			inactive_ratio = 1;
 	}
 
-	if (actual_reclaim)
+	if (trace)
 		trace_mm_vmscan_inactive_list_is_low(pgdat->node_id, sc->reclaim_idx,
 			lruvec_lru_size(lruvec, inactive_lru, MAX_NR_ZONES), inactive,
 			lruvec_lru_size(lruvec, active_lru, MAX_NR_ZONES), active,
-- 
2.22.0.410.gd8fdbe21b5-goog

