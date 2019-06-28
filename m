Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 817B1C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 06:51:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EC9020644
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 06:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561704707;
	bh=SioYLHz/1CTC17aB359/G+bAFbYCJOFebHCZihN4FzM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dlyIh1PpvOZVI5oKrk/WsLX/Q08Taauqopbew1fQkvqo94DQEo60YkMPjDJwxg/45
	 OqMj1htnkYPOWjwo7wEDscpe1ZLuT45uaToeotmcsOdVhsem0z6LOARmfvm7RBTEYW
	 o3N4ylILyUH/Wwj3MIgxR0hJyUmoDQWRc+HaDeCY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727204AbfF1Gvp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 02:51:45 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43390 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726827AbfF1Gvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 02:51:45 -0400
Received: by mail-pl1-f196.google.com with SMTP id cl9so2679620plb.10
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 23:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mCstpKpvgbBC+V+ZGiWFlCxOPjghNzZbXr1kJOJkGEc=;
        b=Cv6URamx2iez5Bj7TuIlhxGqHMOHEygYhuPAvLwOBofBDUglWIMw6QdOGPE73NQ6+i
         jav6fRvR0NxwWAYc3M4mcV4KkwniIE0+DN9BgNIy7ng1I8LL3V9c861VT0Mkbmx7mC9N
         XGLVsuuq500ozM+G8Ui+mQjISaOIxPaU3cOkGDCtd9Vyy9OgRtlfuNKeA+I7aE3nz2Hr
         taBSqBi3qcGKuPWxaNJoWNCupfRrMuMfUeLAzTyq3HwfoaGB9JSEheS21EIa6ByWe/jg
         oQ3malVO0XGQYEpnPI6g+Au35JqstM4w6ueSgeJmsm2dmTDleG4RBR1U+TdoyM29PAjK
         AFXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=mCstpKpvgbBC+V+ZGiWFlCxOPjghNzZbXr1kJOJkGEc=;
        b=r8fbvhPJgCv8uF0qDm+BstF3cy7wHU+l5L4rDpv+1Ru5qEEMW2R8UVOl003aTl5Qfo
         eee3utr/X2MceOGjpC+AzSlQuiNzztdASxZBbjPHwVeLiWsRgEbMVUxW0LJywxG0BLFj
         masm+gZoHp/63C71R/oSeIFerennC8cekAf5vJojmHZCFogBZD4zrRAv1ukqy7B++lRD
         Zx0lc/CyixRlwN6/2g0temG3Gc6cJAr5CGLnWRa3CHdvvjEEHTwz6sMHBE0FcfL+IQli
         pMdQK0BGfUCWldjpx3H3cej6jHHKjZIG1MKuBYMNaNMZa2sm4cxIipocyUuAvV9c5oPg
         BPaw==
X-Gm-Message-State: APjAAAV8uTbcFqRm6DL9XOK2u+aLa6G6FMboD5XkyQ9STLT2/9YOPcaC
        f+wCWfrWdw3cyWN1se2J3j7asMfe
X-Google-Smtp-Source: APXvYqx0UNr92nbIQgrbFzeisVKRoLX5W8EvyZ4FlCsQmFV+ndqxBqkjfrAhnW2TJAC39KbTxs9vPA==
X-Received: by 2002:a17:902:542:: with SMTP id 60mr9722394plf.68.1561704703972;
        Thu, 27 Jun 2019 23:51:43 -0700 (PDT)
Received: from google.com ([2401:fa00:d:0:98f1:8b3d:1f37:3e8])
        by smtp.gmail.com with ESMTPSA id a21sm1303140pfi.27.2019.06.27.23.51.40
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 27 Jun 2019 23:51:42 -0700 (PDT)
Date:   Fri, 28 Jun 2019 15:51:38 +0900
From:   Minchan Kim <minchan@kernel.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Kuo-Hsin Yang <vovoy@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Sonny Rao <sonnyrao@chromium.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm: vmscan: fix not scanning anonymous pages when
 detecting file refaults
Message-ID: <20190628065138.GA251482@google.com>
References: <20190619080835.GA68312@google.com>
 <20190627184123.GA11181@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190627184123.GA11181@cmpxchg.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johannes,

On Thu, Jun 27, 2019 at 02:41:23PM -0400, Johannes Weiner wrote:
> On Wed, Jun 19, 2019 at 04:08:35PM +0800, Kuo-Hsin Yang wrote:
> > When file refaults are detected and there are many inactive file pages,
> > the system never reclaim anonymous pages, the file pages are dropped
> > aggressively when there are still a lot of cold anonymous pages and
> > system thrashes. This issue impacts the performance of applications with
> > large executable, e.g. chrome.
> > 
> > When file refaults are detected. inactive_list_is_low() may return
> > different values depends on the actual_reclaim parameter, the following
> > 2 conditions could be satisfied at the same time.
> > 
> > 1) inactive_list_is_low() returns false in get_scan_count() to trigger
> >    scanning file lists only.
> > 2) inactive_list_is_low() returns true in shrink_list() to allow
> >    scanning active file list.
> > 
> > In that case vmscan would only scan file lists, and as active file list
> > is also scanned, inactive_list_is_low() may keep returning false in
> > get_scan_count() until file cache is very low.
> > 
> > Before commit 2a2e48854d70 ("mm: vmscan: fix IO/refault regression in
> > cache workingset transition"), inactive_list_is_low() never returns
> > different value in get_scan_count() and shrink_list() in one
> > shrink_node_memcg() run. The original design should be that when
> > inactive_list_is_low() returns false for file lists, vmscan only scan
> > inactive file list. As only inactive file list is scanned,
> > inactive_list_is_low() would soon return true.
> > 
> > This patch makes the return value of inactive_list_is_low() independent
> > of actual_reclaim.
> > 
> > The problem can be reproduced by the following test program.
> > 
> > ---8<---
> > void fallocate_file(const char *filename, off_t size)
> > {
> > 	struct stat st;
> > 	int fd;
> > 
> > 	if (!stat(filename, &st) && st.st_size >= size)
> > 		return;
> > 
> > 	fd = open(filename, O_WRONLY | O_CREAT, 0600);
> > 	if (fd < 0) {
> > 		perror("create file");
> > 		exit(1);
> > 	}
> > 	if (posix_fallocate(fd, 0, size)) {
> > 		perror("fallocate");
> > 		exit(1);
> > 	}
> > 	close(fd);
> > }
> > 
> > long *alloc_anon(long size)
> > {
> > 	long *start = malloc(size);
> > 	memset(start, 1, size);
> > 	return start;
> > }
> > 
> > long access_file(const char *filename, long size, long rounds)
> > {
> > 	int fd, i;
> > 	volatile char *start1, *end1, *start2;
> > 	const int page_size = getpagesize();
> > 	long sum = 0;
> > 
> > 	fd = open(filename, O_RDONLY);
> > 	if (fd == -1) {
> > 		perror("open");
> > 		exit(1);
> > 	}
> > 
> > 	/*
> > 	 * Some applications, e.g. chrome, use a lot of executable file
> > 	 * pages, map some of the pages with PROT_EXEC flag to simulate
> > 	 * the behavior.
> > 	 */
> > 	start1 = mmap(NULL, size / 2, PROT_READ | PROT_EXEC, MAP_SHARED,
> > 		      fd, 0);
> > 	if (start1 == MAP_FAILED) {
> > 		perror("mmap");
> > 		exit(1);
> > 	}
> > 	end1 = start1 + size / 2;
> > 
> > 	start2 = mmap(NULL, size / 2, PROT_READ, MAP_SHARED, fd, size / 2);
> > 	if (start2 == MAP_FAILED) {
> > 		perror("mmap");
> > 		exit(1);
> > 	}
> > 
> > 	for (i = 0; i < rounds; ++i) {
> > 		struct timeval before, after;
> > 		volatile char *ptr1 = start1, *ptr2 = start2;
> > 		gettimeofday(&before, NULL);
> > 		for (; ptr1 < end1; ptr1 += page_size, ptr2 += page_size)
> > 			sum += *ptr1 + *ptr2;
> > 		gettimeofday(&after, NULL);
> > 		printf("File access time, round %d: %f (sec)\n", i,
> > 		       (after.tv_sec - before.tv_sec) +
> > 		       (after.tv_usec - before.tv_usec) / 1000000.0);
> > 	}
> > 	return sum;
> > }
> > 
> > int main(int argc, char *argv[])
> > {
> > 	const long MB = 1024 * 1024;
> > 	long anon_mb, file_mb, file_rounds;
> > 	const char filename[] = "large";
> > 	long *ret1;
> > 	long ret2;
> > 
> > 	if (argc != 4) {
> > 		printf("usage: thrash ANON_MB FILE_MB FILE_ROUNDS\n");
> > 		exit(0);
> > 	}
> > 	anon_mb = atoi(argv[1]);
> > 	file_mb = atoi(argv[2]);
> > 	file_rounds = atoi(argv[3]);
> > 
> > 	fallocate_file(filename, file_mb * MB);
> > 	printf("Allocate %ld MB anonymous pages\n", anon_mb);
> > 	ret1 = alloc_anon(anon_mb * MB);
> > 	printf("Access %ld MB file pages\n", file_mb);
> > 	ret2 = access_file(filename, file_mb * MB, file_rounds);
> > 	printf("Print result to prevent optimization: %ld\n",
> > 	       *ret1 + ret2);
> > 	return 0;
> > }
> > ---8<---
> > 
> > Running the test program on 2GB RAM VM with kernel 5.2.0-rc5, the
> > program fills ram with 2048 MB memory, access a 200 MB file for 10
> > times. Without this patch, the file cache is dropped aggresively and
> > every access to the file is from disk.
> > 
> >   $ ./thrash 2048 200 10
> >   Allocate 2048 MB anonymous pages
> >   Access 200 MB file pages
> >   File access time, round 0: 2.489316 (sec)
> >   File access time, round 1: 2.581277 (sec)
> >   File access time, round 2: 2.487624 (sec)
> >   File access time, round 3: 2.449100 (sec)
> >   File access time, round 4: 2.420423 (sec)
> >   File access time, round 5: 2.343411 (sec)
> >   File access time, round 6: 2.454833 (sec)
> >   File access time, round 7: 2.483398 (sec)
> >   File access time, round 8: 2.572701 (sec)
> >   File access time, round 9: 2.493014 (sec)
> > 
> > With this patch, these file pages can be cached.
> > 
> >   $ ./thrash 2048 200 10
> >   Allocate 2048 MB anonymous pages
> >   Access 200 MB file pages
> >   File access time, round 0: 2.475189 (sec)
> >   File access time, round 1: 2.440777 (sec)
> >   File access time, round 2: 2.411671 (sec)
> >   File access time, round 3: 1.955267 (sec)
> >   File access time, round 4: 0.029924 (sec)
> >   File access time, round 5: 0.000808 (sec)
> >   File access time, round 6: 0.000771 (sec)
> >   File access time, round 7: 0.000746 (sec)
> >   File access time, round 8: 0.000738 (sec)
> >   File access time, round 9: 0.000747 (sec)
> > 
> > Fixes: 2a2e48854d70 ("mm: vmscan: fix IO/refault regression in cache workingset transition")
> > Signed-off-by: Kuo-Hsin Yang <vovoy@chromium.org>
> 
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> 
> Your change makes sense - we should indeed not force cache trimming
> only while the page cache is experiencing refaults.
> 
> I can't say I fully understand the changelog, though. The problem of

I guess the point of the patch is "actual_reclaim" paramter made divergency
to balance file vs. anon LRU in get_scan_count. Thus, it ends up scanning
file LRU active/inactive list at file thrashing state.

So, Fixes: 2a2e48854d70 ("mm: vmscan: fix IO/refault regression in cache workingset transition")
would make sense to me since it introduces the parameter.

> forcing cache trimming while there is enough page cache is older than
> the commit you refer to. It could be argued that this commit is
> incomplete - it could have added refault detection not just to
> inactive:active file balancing, but also the file:anon balancing; but
> it didn't *cause* this problem.
> 
> Shouldn't this be
> 
> Fixes: e9868505987a ("mm,vmscan: only evict file pages when we have plenty")
> Fixes: 7c5bd705d8f9 ("mm: memcg: only evict file pages when we have plenty")

That would affect, too but it would be trouble to have stable backport
since we don't have refault machinery in there.
