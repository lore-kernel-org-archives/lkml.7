Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41ECAC10F00
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 22:48:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 121DF206DD
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 22:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551912494;
	bh=e9RSnELXLOjF1US988iwHM5qMpBbVvt+Th4lFBfyF3A=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=vVzXOgo6bRwmSJ5MmWdPupvyOzHewoUfnzaWFMpXdje3iEcfNAPh0tK4eFHA6wPHO
	 zgs/TpnYQRtSdvXTSGARenzlKPxgihsjbhI/xTuzJgWH42knDwIcFytvjwft/5dTvV
	 1AHuyvpNt5Ioi0NqGLJlMjWyS2qBAsXee+yUykvk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbfCFWsM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 17:48:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:57744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725783AbfCFWsL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 17:48:11 -0500
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 23AA420675;
        Wed,  6 Mar 2019 22:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551912490;
        bh=e9RSnELXLOjF1US988iwHM5qMpBbVvt+Th4lFBfyF3A=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=fwYQm7zP2769SP+uuMgs5aFPFjAMChvalElqTU0GL5DR5mYI9mvuhGBGUWILIh+QV
         jT77XiDHJTbm2Z6njrqg8qwby36azquuPpsZuoCuuHxLmXDOGJAvPmvz/I8Bh5UqTt
         r/u5DdUkBzFZ5KPMcoHfuXvOr1FDRi9jJKqOUTK0=
Date:   Wed, 6 Mar 2019 23:48:03 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Vlastimil Babka <vbabka@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-api@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jann Horn <jannh@google.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Cyril Hrubis <chrubis@suse.cz>, Daniel Gruss <daniel@gruss.cc>,
        Dave Chinner <david@fromorbit.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Kevin Easton <kevin@guarana.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 0/3] mincore() and IOCB_NOWAIT adjustments
In-Reply-To: <20190306143547.c686225447822beaf3b6e139@linux-foundation.org>
Message-ID: <nycvar.YFH.7.76.1903062342020.19912@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.1901051817390.16954@cbobk.fhfr.pm> <20190130124420.1834-1-vbabka@suse.cz> <nycvar.YFH.7.76.1903061310170.19912@cbobk.fhfr.pm> <20190306143547.c686225447822beaf3b6e139@linux-foundation.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Mar 2019, Andrew Morton wrote:

> > could you please take at least the correct and straightforward fix for 
> > mincore() before we figure out how to deal with the slightly less 
> > practical RWF_NOWAIT? Thanks.
> 
> I assume we're talking about [1/3] and [2/3] from this thread?
> 
> Can we have a resend please?  Gather the various acks and revisions,
> make changelog changes to address the review questions and comments?

1/3 is clearly the one to be merged. The version with all the acks 
gathered is in this thread, at

	https://lore.kernel.org/lkml/de52b3bd-4e39-c133-542a-0a9c5e357404@suse.cz/

Attaching the patch also at the end of this mail so that it could be 
easily picked up.

I am unfortunately not sure what changelog changes you are talking about, 
there were none requested during the review as far as I know.

2/3 is clearly postponed for now, it needs more thinking.

3/3 is actually waiting for your decision, see

	https://lore.kernel.org/lkml/20190212063643.GL15609@dhcp22.suse.cz/

The 1/3 patch to be merged in any case:


=== cut here ===

From: Jiri Kosina <jkosina@suse.cz>
Date: Wed, 16 Jan 2019 20:53:17 +0100
Subject: [PATCH v2] mm/mincore: make mincore() more conservative

The semantics of what mincore() considers to be resident is not completely
clear, but Linux has always (since 2.3.52, which is when mincore() was
initially done) treated it as "page is available in page cache".

That's potentially a problem, as that [in]directly exposes meta-information
about pagecache / memory mapping state even about memory not strictly belonging
to the process executing the syscall, opening possibilities for sidechannel
attacks.

Change the semantics of mincore() so that it only reveals pagecache information
for non-anonymous mappings that belog to files that the calling process could
(if it tried to) successfully open for writing.

[mhocko@suse.com: restructure can_do_mincore() conditions]
Originally-by: Linus Torvalds <torvalds@linux-foundation.org>
Originally-by: Dominique Martinet <asmadeus@codewreck.org>
Cc: Dominique Martinet <asmadeus@codewreck.org>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Dave Chinner <david@fromorbit.com>
Cc: Kevin Easton <kevin@guarana.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Cyril Hrubis <chrubis@suse.cz>
Cc: Tejun Heo <tj@kernel.org>
Cc: Kirill A. Shutemov <kirill@shutemov.name>
Cc: Daniel Gruss <daniel@gruss.cc>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
Acked-by: Josh Snyder <joshs@netflix.com>
Acked-by: Michal Hocko <mhocko@suse.com>
---
 mm/mincore.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/mm/mincore.c b/mm/mincore.c
index 218099b5ed31..b8842b849604 100644
--- a/mm/mincore.c
+++ b/mm/mincore.c
@@ -169,6 +169,16 @@ static int mincore_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 	return 0;
 }
 
+static inline bool can_do_mincore(struct vm_area_struct *vma)
+{
+	if (vma_is_anonymous(vma))
+		return true;
+	if (!vma->vm_file)
+		return false;
+	return inode_owner_or_capable(file_inode(vma->vm_file)) ||
+		inode_permission(file_inode(vma->vm_file), MAY_WRITE) == 0;
+}
+
 /*
  * Do a chunk of "sys_mincore()". We've already checked
  * all the arguments, we hold the mmap semaphore: we should
@@ -189,8 +199,13 @@ static long do_mincore(unsigned long addr, unsigned long pages, unsigned char *v
 	vma = find_vma(current->mm, addr);
 	if (!vma || addr < vma->vm_start)
 		return -ENOMEM;
-	mincore_walk.mm = vma->vm_mm;
 	end = min(vma->vm_end, addr + (pages << PAGE_SHIFT));
+	if (!can_do_mincore(vma)) {
+		unsigned long pages = (end - addr) >> PAGE_SHIFT;
+		memset(vec, 1, pages);
+		return pages;
+	}
+	mincore_walk.mm = vma->vm_mm;
 	err = walk_page_range(addr, end, &mincore_walk);
 	if (err < 0)
 		return err;


-- 
Jiri Kosina
SUSE Labs

