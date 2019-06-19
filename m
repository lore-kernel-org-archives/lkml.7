Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A665C31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 08:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35ACB20679
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 08:08:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="U6WZCxft"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731269AbfFSIIk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 04:08:40 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44263 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbfFSIIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 04:08:39 -0400
Received: by mail-pl1-f194.google.com with SMTP id t7so6871526plr.11
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 01:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=hDeVdBWWPPTkbBXHklX8Rt51hyYEzQf0jmQ1XrF86ag=;
        b=U6WZCxft1YmIyjwH5Znr6VX8IS/f71mPVNA/6CormE/HP80HaNHImYH+aM1yKclQRS
         KCCZkUoz8mjPWW++D5Z9ltxghClm58t9I54NwSBZ8Tuv7YxrBqdbm8nkyUG5CuHaGJkZ
         PFhFI26MFip3NWmg15ii8LdoQVSa3a2dWvRdY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=hDeVdBWWPPTkbBXHklX8Rt51hyYEzQf0jmQ1XrF86ag=;
        b=Ts2yit+wWBce35aKV6ij2QaDWHOu/Q1sQsKTojQo5Egwc9lBoXoF8azLu+SvoIGDVU
         xaTg8VomWp75N1a3fGilztf3wAugt2QR0nZF/6YKYDbCk8cOvtV4678BA/Gzh5B9cZuP
         lmLQS/Vu6RwvzKh4AsMdYoxyrPRrLAaczhy4Bh/PU/vACwr8BK221unJNpegf7fN2//k
         DhnEpz2aPYKVokyYf0jBlbMu1PiXBNyJjKCraL18QL8n+Sxi2csScysSC3hWjQ6MpP2e
         3twRjhjCCaCEUOoQlOAUi103j5krVNWnvQSjNYq4sx3xWHJs8d8fwrhg7aOE5qW1ZewA
         uQUw==
X-Gm-Message-State: APjAAAXaokuZTf5ohvX9pdh10fNyzXzdJosp8i+qmUcq0qSwhOqC2vvU
        YaY21WbNMx7xG5shs3enlKO4
X-Google-Smtp-Source: APXvYqy0Rhm4TA+2ZMv3rfgXXv14ZYAZHjJV4QK7rYCsewfrnKIbNiKGk15ogGJUnV+a1ciO9lI0vA==
X-Received: by 2002:a17:902:903:: with SMTP id 3mr93535586plm.281.1560931718751;
        Wed, 19 Jun 2019 01:08:38 -0700 (PDT)
Received: from google.com ([2401:fa00:1:b:d89e:cfa6:3c8:e61b])
        by smtp.gmail.com with ESMTPSA id c26sm740179pfr.172.2019.06.19.01.08.37
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 19 Jun 2019 01:08:38 -0700 (PDT)
Date:   Wed, 19 Jun 2019 16:08:35 +0800
From:   Kuo-Hsin Yang <vovoy@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     Michal Hocko <mhocko@suse.com>, Sonny Rao <sonnyrao@chromium.org>,
        Kuo-Hsin Yang <vovoy@chromium.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH] mm: vmscan: fix not scanning anonymous pages when detecting
 file refaults
Message-ID: <20190619080835.GA68312@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When file refaults are detected and there are many inactive file pages,
the system never reclaim anonymous pages, the file pages are dropped
aggressively when there are still a lot of cold anonymous pages and
system thrashes. This issue impacts the performance of applications with
large executable, e.g. chrome.

When file refaults are detected. inactive_list_is_low() may return
different values depends on the actual_reclaim parameter, the following
2 conditions could be satisfied at the same time.

1) inactive_list_is_low() returns false in get_scan_count() to trigger
   scanning file lists only.
2) inactive_list_is_low() returns true in shrink_list() to allow
   scanning active file list.

In that case vmscan would only scan file lists, and as active file list
is also scanned, inactive_list_is_low() may keep returning false in
get_scan_count() until file cache is very low.

Before commit 2a2e48854d70 ("mm: vmscan: fix IO/refault regression in
cache workingset transition"), inactive_list_is_low() never returns
different value in get_scan_count() and shrink_list() in one
shrink_node_memcg() run. The original design should be that when
inactive_list_is_low() returns false for file lists, vmscan only scan
inactive file list. As only inactive file list is scanned,
inactive_list_is_low() would soon return true.

This patch makes the return value of inactive_list_is_low() independent
of actual_reclaim.

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
times. Without this patch, the file cache is dropped aggresively and
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
---
 mm/vmscan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 7889f583ced9f..b95d05fe828d1 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2151,7 +2151,7 @@ static bool inactive_list_is_low(struct lruvec *lruvec, bool file,
 	 * rid of the stale workingset quickly.
 	 */
 	refaults = lruvec_page_state_local(lruvec, WORKINGSET_ACTIVATE);
-	if (file && actual_reclaim && lruvec->refaults != refaults) {
+	if (file && lruvec->refaults != refaults) {
 		inactive_ratio = 0;
 	} else {
 		gb = (inactive + active) >> (30 - PAGE_SHIFT);
-- 
2.22.0.410.gd8fdbe21b5-goog

