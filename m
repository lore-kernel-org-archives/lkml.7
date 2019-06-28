Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC833C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 14:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5ADF205C9
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 14:32:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="rdY63TdC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbfF1OcE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 10:32:04 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:34946 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726616AbfF1OcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 10:32:04 -0400
Received: by mail-qt1-f193.google.com with SMTP id d23so6519063qto.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 07:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CfBxdKK+RW6h34KCEm0a8LsqSSwL+A0Ki+xU4tcOBSU=;
        b=rdY63TdCLzqf1IoUW+uJOW10qLkglQwr+qkcRV/yAxEkJjmolhBiG0qlwKTtKHQHZc
         m/Tg/DeM43wkROSwiJw6jgVBloQOM1ZZLBrjxYhT89sTAH6k/JhjmZbf1Zu9BWcEkYPK
         FIlB8PRsrHtOt2ZaphrytIdPKnN7xGylZTPlq+SBJBPvTz6BN07/2l4ZTD70yITZz5dz
         xfJ6q54mRL/W5hBbk1E2NDFc/mvY+XUQxi8lDmUkJo7EL2xYR/IwqDe6OOgvOyS0t0s2
         7AR1qzpAlDeABChjkFFp9QdzBzluYFygp+BH8MMUfEHnzuSp34Pe3ZEmQNj4riKB1Kht
         NbdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CfBxdKK+RW6h34KCEm0a8LsqSSwL+A0Ki+xU4tcOBSU=;
        b=jIjqTujQQuK4SmEeDmplQ54WRfn9OVIcUpPbc1xJ61UcGyo2CaJmoarDMudVBiTcGL
         FSyvXm4xCbOUO3uZmWAON9daf6xGmrRM5u6im5ESHWt8XaW0ya6Wmi2e6GHHa5mFbcbB
         U5cb+A8nfW+OU/jse4F9/y/6tOZOg+0ElqewqspcS98zgNTXW1Vz9Ix6d2VdZ9RbWqNE
         AgXpZFxHUORUzO3HYx9gIq4MDplZeRXMnyElIlEtRY9Uq696WTm1B6hk7ngcTQ6d9isg
         sr01MdWXh8h81hpf7cW9c64J5Pk7WZ6/+O3Vtn66rJ0n1gmirRUFKuGb+pnQh8LhWcmx
         b2wg==
X-Gm-Message-State: APjAAAVIGsPw6aa5NGygm9A1GaPxq7QPlMHAhFfTS+Qywb5phX9lkyrE
        4eSBoy4H5fnlw+BmyLyhjNi14A==
X-Google-Smtp-Source: APXvYqyb7+naelNcLjxlj+hk/ascFI/dJST0XLT4HuP0CSw8DZGvpk4lsZtj7sgeA1s/YIsPKlV5QQ==
X-Received: by 2002:a0c:880f:: with SMTP id 15mr8218923qvl.126.1561732322885;
        Fri, 28 Jun 2019 07:32:02 -0700 (PDT)
Received: from localhost (pool-108-27-252-85.nycmny.fios.verizon.net. [108.27.252.85])
        by smtp.gmail.com with ESMTPSA id s134sm1230855qke.51.2019.06.28.07.32.02
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 28 Jun 2019 07:32:02 -0700 (PDT)
Date:   Fri, 28 Jun 2019 10:32:01 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Kuo-Hsin Yang <vovoy@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Sonny Rao <sonnyrao@chromium.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2] mm: vmscan: fix not scanning anonymous pages when
 detecting file refaults
Message-ID: <20190628143201.GB17212@cmpxchg.org>
References: <20190619080835.GA68312@google.com>
 <20190628111627.GA107040@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190628111627.GA107040@google.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 28, 2019 at 07:16:27PM +0800, Kuo-Hsin Yang wrote:
> When file refaults are detected and there are many inactive file pages,
> the system never reclaim anonymous pages, the file pages are dropped
> aggressively when there are still a lot of cold anonymous pages and
> system thrashes.  This issue impacts the performance of applications
> with large executable, e.g. chrome.

This is good.

> Commit 2a2e48854d70 ("mm: vmscan: fix IO/refault regression in cache
> workingset transition") introduced actual_reclaim parameter.  When file
> refaults are detected, inactive_list_is_low() may return different
> values depends on the actual_reclaim parameter.  Vmscan would only scan
> active/inactive file lists at file thrashing state when the following 2
> conditions are satisfied.
> 
> 1) inactive_list_is_low() returns false in get_scan_count() to trigger
>    scanning file lists only.
> 2) inactive_list_is_low() returns true in shrink_list() to allow
>    scanning active file list.
> 
> This patch makes the return value of inactive_list_is_low() independent
> of actual_reclaim and rename the parameter back to trace.

This is not. The root cause for the problem you describe isn't the
patch you point to. The root cause is our decision to force-scan the
file LRU based on relative inactive:active size alone, without taking
file thrashing into account at all. This is a much older problem.

After the referenced patch, we're taking thrashing into account when
deciding whether to deactivate active file pages or not. To solve the
problem pointed out here, we can extend that same principle to the
decision whether to force-scan files and skip the anon LRUs.

The patch you're pointing to isn't the culprit. On the contrary, it
provides the infrastructure to solve a much older problem.

> The problem can be reproduced by the following test program.
> 
> ---8<---
> void fallocate_file(const char *filename, off_t size)
> {
> 	struct stat st;
> 	int fd;
> 
> 	if (!stat(filename, &st) && st.st_size >= size)
> 		return;
> 
> 	fd = open(filename, O_WRONLY | O_CREAT, 0600);
> 	if (fd < 0) {
> 		perror("create file");
> 		exit(1);
> 	}
> 	if (posix_fallocate(fd, 0, size)) {
> 		perror("fallocate");
> 		exit(1);
> 	}
> 	close(fd);
> }
> 
> long *alloc_anon(long size)
> {
> 	long *start = malloc(size);
> 	memset(start, 1, size);
> 	return start;
> }
> 
> long access_file(const char *filename, long size, long rounds)
> {
> 	int fd, i;
> 	volatile char *start1, *end1, *start2;
> 	const int page_size = getpagesize();
> 	long sum = 0;
> 
> 	fd = open(filename, O_RDONLY);
> 	if (fd == -1) {
> 		perror("open");
> 		exit(1);
> 	}
> 
> 	/*
> 	 * Some applications, e.g. chrome, use a lot of executable file
> 	 * pages, map some of the pages with PROT_EXEC flag to simulate
> 	 * the behavior.
> 	 */
> 	start1 = mmap(NULL, size / 2, PROT_READ | PROT_EXEC, MAP_SHARED,
> 		      fd, 0);
> 	if (start1 == MAP_FAILED) {
> 		perror("mmap");
> 		exit(1);
> 	}
> 	end1 = start1 + size / 2;
> 
> 	start2 = mmap(NULL, size / 2, PROT_READ, MAP_SHARED, fd, size / 2);
> 	if (start2 == MAP_FAILED) {
> 		perror("mmap");
> 		exit(1);
> 	}
> 
> 	for (i = 0; i < rounds; ++i) {
> 		struct timeval before, after;
> 		volatile char *ptr1 = start1, *ptr2 = start2;
> 		gettimeofday(&before, NULL);
> 		for (; ptr1 < end1; ptr1 += page_size, ptr2 += page_size)
> 			sum += *ptr1 + *ptr2;
> 		gettimeofday(&after, NULL);
> 		printf("File access time, round %d: %f (sec)\n", i,
> 		       (after.tv_sec - before.tv_sec) +
> 		       (after.tv_usec - before.tv_usec) / 1000000.0);
> 	}
> 	return sum;
> }
> 
> int main(int argc, char *argv[])
> {
> 	const long MB = 1024 * 1024;
> 	long anon_mb, file_mb, file_rounds;
> 	const char filename[] = "large";
> 	long *ret1;
> 	long ret2;
> 
> 	if (argc != 4) {
> 		printf("usage: thrash ANON_MB FILE_MB FILE_ROUNDS\n");
> 		exit(0);
> 	}
> 	anon_mb = atoi(argv[1]);
> 	file_mb = atoi(argv[2]);
> 	file_rounds = atoi(argv[3]);
> 
> 	fallocate_file(filename, file_mb * MB);
> 	printf("Allocate %ld MB anonymous pages\n", anon_mb);
> 	ret1 = alloc_anon(anon_mb * MB);
> 	printf("Access %ld MB file pages\n", file_mb);
> 	ret2 = access_file(filename, file_mb * MB, file_rounds);
> 	printf("Print result to prevent optimization: %ld\n",
> 	       *ret1 + ret2);
> 	return 0;
> }
> ---8<---
> 
> Running the test program on 2GB RAM VM with kernel 5.2.0-rc5, the
> program fills ram with 2048 MB memory, access a 200 MB file for 10
> times.  Without this patch, the file cache is dropped aggresively and
> every access to the file is from disk.
> 
>   $ ./thrash 2048 200 10
>   Allocate 2048 MB anonymous pages
>   Access 200 MB file pages
>   File access time, round 0: 2.489316 (sec)
>   File access time, round 1: 2.581277 (sec)
>   File access time, round 2: 2.487624 (sec)
>   File access time, round 3: 2.449100 (sec)
>   File access time, round 4: 2.420423 (sec)
>   File access time, round 5: 2.343411 (sec)
>   File access time, round 6: 2.454833 (sec)
>   File access time, round 7: 2.483398 (sec)
>   File access time, round 8: 2.572701 (sec)
>   File access time, round 9: 2.493014 (sec)
> 
> With this patch, these file pages can be cached.
> 
>   $ ./thrash 2048 200 10
>   Allocate 2048 MB anonymous pages
>   Access 200 MB file pages
>   File access time, round 0: 2.475189 (sec)
>   File access time, round 1: 2.440777 (sec)
>   File access time, round 2: 2.411671 (sec)
>   File access time, round 3: 1.955267 (sec)
>   File access time, round 4: 0.029924 (sec)
>   File access time, round 5: 0.000808 (sec)
>   File access time, round 6: 0.000771 (sec)
>   File access time, round 7: 0.000746 (sec)
>   File access time, round 8: 0.000738 (sec)
>   File access time, round 9: 0.000747 (sec)

This is all good again.

> Fixes: 2a2e48854d70 ("mm: vmscan: fix IO/refault regression in cache workingset transition")

Please replace this line with the two Fixes: lines that I provided
earlier in this thread.

Thanks.
