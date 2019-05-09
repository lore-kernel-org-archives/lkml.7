Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FE56C04AB3
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 09:57:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 095A1206A3
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 09:57:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbfEIJ52 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 05:57:28 -0400
Received: from outbound-smtp06.blacknight.com ([81.17.249.39]:58555 "EHLO
        outbound-smtp06.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725826AbfEIJ52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 05:57:28 -0400
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp06.blacknight.com (Postfix) with ESMTPS id 5E10C98969
        for <linux-kernel@vger.kernel.org>; Thu,  9 May 2019 09:57:26 +0000 (UTC)
Received: (qmail 28448 invoked from network); 9 May 2019 09:57:26 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[37.228.225.79])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 9 May 2019 09:57:26 -0000
Date:   Thu, 9 May 2019 10:57:24 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     syzbot <syzbot+d84c80f9fe26a0f7a734@syzkaller.appspotmail.com>
Cc:     akpm@linux-foundation.org, aryabinin@virtuozzo.com, cai@lca.pw,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@suse.com,
        syzkaller-bugs@googlegroups.com, vbabka@suse.cz
Subject: Re: BUG: unable to handle kernel paging request in
 isolate_freepages_block
Message-ID: <20190509095724.GG18914@techsingularity.net>
References: <0000000000003beebd0588492456@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <0000000000003beebd0588492456@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 07, 2019 at 02:50:05AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    baf76f0c slip: make slhc_free() silently accept an error p..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=16dbe6cca00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=a42d110b47dd6b36
> dashboard link: https://syzkaller.appspot.com/bug?extid=d84c80f9fe26a0f7a734
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> 
> Unfortunately, I don't have any reproducer for this crash yet.
> 

How reproducible is it and can the following (compile tested only) patch
be tested please? I'm thinking it's a similar class of bug to 6b0868c820ff
("mm/compaction.c: correct zone boundary handling when resetting pageblock
skip hints")

diff --git a/mm/compaction.c b/mm/compaction.c
index 3319e0872d01..ae4d99d31b61 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -1228,7 +1228,7 @@ fast_isolate_around(struct compact_control *cc, unsigned long pfn, unsigned long
 
 	/* Pageblock boundaries */
 	start_pfn = pageblock_start_pfn(pfn);
-	end_pfn = min(start_pfn + pageblock_nr_pages, zone_end_pfn(cc->zone));
+	end_pfn = min(start_pfn + pageblock_nr_pages, zone_end_pfn(cc->zone) - 1);
 
 	/* Scan before */
 	if (start_pfn != pfn) {
@@ -1239,7 +1239,7 @@ fast_isolate_around(struct compact_control *cc, unsigned long pfn, unsigned long
 
 	/* Scan after */
 	start_pfn = pfn + nr_isolated;
-	if (start_pfn != end_pfn)
+	if (start_pfn < end_pfn)
 		isolate_freepages_block(cc, &start_pfn, end_pfn, &cc->freepages, 1, false);
 
 	/* Skip this pageblock in the future as it's full or nearly full */
