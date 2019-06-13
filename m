Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD95AC31E4A
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 20:17:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F07F20B7C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 20:17:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YLS2bNye"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729148AbfFMURx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 16:17:53 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44647 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726855AbfFMURw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 16:17:52 -0400
Received: by mail-pl1-f194.google.com with SMTP id t7so5983604plr.11
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 13:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=spF/72Oj0CgnTQoBgUPZDCot9zEM78k4CGq0SIEdWm0=;
        b=YLS2bNyeSL2KqBuL4vme/L2RzTwIodYg0cEGB/qrcLWbyYbPp6JNPPYb9eCN5WP09y
         ++v0/uuo8W94dIgJd9o6qoMxj9zazmylsRaMbQxcPyY7aGPZFFLyLKUh4dfTQhqkwBhA
         2yqlwCGqvNpI+5SWRmQuQ1EyhyzuZvwxRJJf46m3XC8DziJOYnVouoYUqi8iw5+mFuFd
         2tKyIoePhxNq/kqRbEeFfmSvizdDkjiqEYbuL8RzNmGVi32jjbDj96A9WBdf6Wd1WtbA
         n8f+HpJskZtd2cNV5s/hWUr+XWxm102xuuY5lBym80PXFFZtNWsn29+bohAarDRwfP25
         QJaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=spF/72Oj0CgnTQoBgUPZDCot9zEM78k4CGq0SIEdWm0=;
        b=AqCqff/NjU21wO7xrekpB4O4Yh6z3/hfYhNeX6Lavmp4X+ovHI8HEfX/DeocdFViHt
         Qd1WYKILieBB6aGVbiO6fhY9bc5SFmlbdltS3XBVv5rfZj4L9eIxcPsmRBGczvzR1Seq
         +BaenhcViGEpAl9GnQ2q6VS/wKxE9zJvugunZrGCu5iFBJGJ8swYVDLAphqloKS0S0vj
         3PsGVj1Ihs9aKSHxD9qiZDBFG01oya3ZEXO8IJW6If3jOHWO2nKUNvsNdIjaGWqB9YxX
         quF89RpN0uz/hFmMiTq+7qJVz+lMv7B5KBnJwTf7PaJ63gzYf8tpJLCiQZxmfhfG67ec
         fFRw==
X-Gm-Message-State: APjAAAW3LNCP88H8iWo4fuz4s2xHkdLqwWgJIsLs79/u7Ah+XC5qFTA6
        6MNptzyGaRHfRUv7TgA0IGDJRA==
X-Google-Smtp-Source: APXvYqy1MaOcx8RX1Cf/q2VBhkXKvgxOpEIUpBLzCB2gfJYEclPBf7y1RTRL4XnwB3OH/vWtyL+hfg==
X-Received: by 2002:a17:902:2a69:: with SMTP id i96mr80652449plb.108.1560457071307;
        Thu, 13 Jun 2019 13:17:51 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id n7sm546613pff.59.2019.06.13.13.17.49
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 13 Jun 2019 13:17:49 -0700 (PDT)
Date:   Thu, 13 Jun 2019 13:17:49 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Michal Hocko <mhocko@kernel.org>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Zi Yan <zi.yan@cs.rutgers.edu>,
        Stefan Priebe - Profihost AG <s.priebe@profihost.ag>,
        "Kirill A. Shutemov" <kirill@shutemov.name>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Revert "mm, thp: restore node-local hugepage
 allocations"
In-Reply-To: <20190607083255.GA18435@dhcp22.suse.cz>
Message-ID: <alpine.DEB.2.21.1906131300220.27665@chino.kir.corp.google.com>
References: <20190503223146.2312-3-aarcange@redhat.com> <alpine.DEB.2.21.1905151304190.203145@chino.kir.corp.google.com> <20190520153621.GL18914@techsingularity.net> <alpine.DEB.2.21.1905201018480.96074@chino.kir.corp.google.com>
 <20190523175737.2fb5b997df85b5d117092b5b@linux-foundation.org> <alpine.DEB.2.21.1905281907060.86034@chino.kir.corp.google.com> <20190531092236.GM6896@dhcp22.suse.cz> <alpine.DEB.2.21.1905311430120.92278@chino.kir.corp.google.com> <20190605093257.GC15685@dhcp22.suse.cz>
 <alpine.DEB.2.21.1906061451001.121338@chino.kir.corp.google.com> <20190607083255.GA18435@dhcp22.suse.cz>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Jun 2019, Michal Hocko wrote:

> > So my proposed change would be:
> >  - give the page allocator a consistent indicator that compaction failed
> >    because we are low on memory (make COMPACT_SKIPPED really mean this),
> >  - if we get this in the page allocator and we are allocating thp, fail,
> >    reclaim is unlikely to help here and is much more likely to be
> >    disruptive
> >      - we could retry compaction if we haven't scanned all memory and
> >        were contended,
> >  - if the hugepage allocation fails, have thp check watermarks for order-0 
> >    pages without any padding,
> >  - if watermarks succeed, fail the thp allocation: we can't allocate
> >    because of fragmentation and it's better to return node local memory,
> 
> Doesn't this lead to the same THP low success rate we have seen with one
> of the previous patches though?
> 

From my recollection, the only other patch that was tested involved 
__GFP_NORETRY and avoiding reclaim entirely for thp allocations when 
checking for high-order allocations.

This in the page allocator:

                /*
                 * Checks for costly allocations with __GFP_NORETRY, which
                 * includes THP page fault allocations
                 */
                if (costly_order && (gfp_mask & __GFP_NORETRY)) {
			...
			if (compact_result == COMPACT_DEFERRED)
				goto nopage;

Yet there is no handling for COMPACT_SKIPPED (or what my plan above 
defines COMPACT_SKIPPED to be).  I don't think anything was tried that 
tests why compaction failed, i.e. was it because the two scanners met, 
because hugepage-order memory was found available, because the zone lock 
was contended or we hit need_resched(), we're failing even order-0 
watermarks, etc.  I don't think the above plan has been tried, if someone 
has tried it, please let me know.

I haven't seen any objection to disabling reclaim entirely when order-0 
watermarks are failing in compaction.  We simply can't guarantee that it 
is useful work with the current implementation of compaction.  There are 
several reasons that I've enumerated why compaction can still fail even 
after successful reclaim.

The point is that removing __GFP_THISNODE is not a fix for this if the 
remote memory is fragmented as well: it assumes that hugepages are 
available remotely when they aren't available locally otherwise we seem 
swap storms both locally and remotely.  Relying on that is not in the best 
interest of any user of transparent hugepages.

> Let me remind you of the previous semantic I was proposing
> http://lkml.kernel.org/r/20181206091405.GD1286@dhcp22.suse.cz and that
> didn't get shot down. Linus had some follow up ideas on how exactly
> the fallback order should look like and that is fine. We should just
> measure differences between local node cheep base page vs. remote THP on
> _real_ workloads. Any microbenchmark which just measures a latency is
> inherently misleading.
> 

I think both seek to add the possibility of allocating hugepages remotely 
in certain circumstances and that can be influenced by MADV_HUGEPAGE.  I 
don't think we need to try hugepage specific mempolicies unless it is 
shown to be absolutely necessary although a usecase for this could be made 
separate to this discussion.

There's a benefit to faulting remote hugepages over remote pages for 
everybody involved.  My argument is that we can determine the need for 
that based on failed order-0 watermark checks in compaction: if the node 
would require reclaim to even fault a page, it is likely better over the 
long term to fault a remote hugepage.

I think this can be made to work and is not even difficult to do.  If 
anybody has any objection please let me know.
