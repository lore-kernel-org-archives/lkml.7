Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DFEAC48BD7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 04:03:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB14E21841
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 04:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561608203;
	bh=SlTXh2p/gZLvTtduY3oa5W16xSgTr4O6Sb7YsAg67yw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=yBu/BUUJUmB4bN9ihQkYon0iDgP7HhQR1gmry2ucJrObkLepb3Raae6CjLSAlp/He
	 PIIATFfhZcwhz/i/1SslElLVeiNVyUE6Bz4DDjzc5J1UnDuObyrib5DL+xWiuehWCx
	 xaHONSiOEypLvpLrZZBQ8+yjL/AeJ9ql3iXdyGrU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbfF0EDV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 00:03:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:40520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725385AbfF0EDV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 00:03:21 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34EDB20665;
        Thu, 27 Jun 2019 04:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561608199;
        bh=SlTXh2p/gZLvTtduY3oa5W16xSgTr4O6Sb7YsAg67yw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UQTCOigFlal+jLNVCEMxU9SMZjBz7DxdN6SUdRf48bXzHgUx/6a1Y1Mm+V32b2iXN
         N5j/viwFx/q67djfUKPLE0LSrUFqbhsITxsm/so7UyTGGcz4jZckZPZfoGPNtsnGHU
         EAL2yHl30SPElMv2NsmtSzpxYVbTeLs+9U5rpLqw=
Date:   Wed, 26 Jun 2019 21:03:18 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Kuo-Hsin Yang <vovoy@chromium.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Sonny Rao <sonnyrao@chromium.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm: vmscan: fix not scanning anonymous pages when
 detecting file refaults
Message-Id: <20190626210318.af48d796f461f704a535a88d@linux-foundation.org>
In-Reply-To: <20190619080835.GA68312@google.com>
References: <20190619080835.GA68312@google.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Could we please get some review of this one?  Johannes, it supposedly
fixes your patch?

I added cc:stable to this.  Agreeable?

From: Kuo-Hsin Yang <vovoy@chromium.org>
Subject: mm: vmscan: fix not scanning anonymous pages when detecting file refaults

When file refaults are detected and there are many inactive file pages,
the system never reclaim anonymous pages, the file pages are dropped
aggressively when there are still a lot of cold anonymous pages and system
thrashes.  This issue impacts the performance of applications with large
executable, e.g.  chrome.

When file refaults are detected.  inactive_list_is_low() may return
different values depends on the actual_reclaim parameter, the following 2
conditions could be satisfied at the same time.

1) inactive_list_is_low() returns false in get_scan_count() to trigger
   scanning file lists only.
2) inactive_list_is_low() returns true in shrink_list() to allow
   scanning active file list.

In that case vmscan would only scan file lists, and as active file list is
also scanned, inactive_list_is_low() may keep returning false in
get_scan_count() until file cache is very low.

Before 2a2e48854d70 ("mm: vmscan: fix IO/refault regression in cache
workingset transition"), inactive_list_is_low() never returns different
value in get_scan_count() and shrink_list() in one shrink_node_memcg()
run.  The original design should be that when inactive_list_is_low()
returns false for file lists, vmscan only scan inactive file list.  As
only inactive file list is scanned, inactive_list_is_low() would soon
return true.

This patch makes the return value of inactive_list_is_low() independent of
actual_reclaim.

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
		printf("File access time, round %d: %f (sec)
", i,
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
		printf("usage: thrash ANON_MB FILE_MB FILE_ROUNDS
");
		exit(0);
	}
	anon_mb = atoi(argv[1]);
	file_mb = atoi(argv[2]);
	file_rounds = atoi(argv[3]);

	fallocate_file(filename, file_mb * MB);
	printf("Allocate %ld MB anonymous pages
", anon_mb);
	ret1 = alloc_anon(anon_mb * MB);
	printf("Access %ld MB file pages
", file_mb);
	ret2 = access_file(filename, file_mb * MB, file_rounds);
	printf("Print result to prevent optimization: %ld
",
	       *ret1 + ret2);
	return 0;
}
---8<---

Running the test program on 2GB RAM VM with kernel 5.2.0-rc5, the program
fills ram with 2048 MB memory, access a 200 MB file for 10 times.  Without
this patch, the file cache is dropped aggresively and every access to the
file is from disk.

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

Link: http://lkml.kernel.org/r/20190619080835.GA68312@google.com
Fixes: 2a2e48854d70 ("mm: vmscan: fix IO/refault regression in cache workingset transition")
Signed-off-by: Kuo-Hsin Yang <vovoy@chromium.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Sonny Rao <sonnyrao@chromium.org>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Rik van Riel <riel@redhat.com>
Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/vmscan.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/mm/vmscan.c~mm-vmscan-fix-not-scanning-anonymous-pages-when-detecting-file-refaults
+++ a/mm/vmscan.c
@@ -2151,7 +2151,7 @@ static bool inactive_list_is_low(struct
 	 * rid of the stale workingset quickly.
 	 */
 	refaults = lruvec_page_state_local(lruvec, WORKINGSET_ACTIVATE);
-	if (file && actual_reclaim && lruvec->refaults != refaults) {
+	if (file && lruvec->refaults != refaults) {
 		inactive_ratio = 0;
 	} else {
 		gb = (inactive + active) >> (30 - PAGE_SHIFT);
_

