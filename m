Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E61C1CA9EA0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 00:52:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF8332084B
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 00:52:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E1fC8UTL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732078AbfJWAwK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 20:52:10 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38482 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727403AbfJWAwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 20:52:10 -0400
Received: by mail-pl1-f195.google.com with SMTP id w8so9194770plq.5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 17:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=Srd6gml0YLGx1I577UoqvNSMcSiLgu2cTCSMasmakCE=;
        b=E1fC8UTLD3GGDIef9dWBus1qtkkmtrAcx1kuFUFA0HMa6PVDEe+k0alKpZHj5wHZIG
         HpskJIgaFND8TR6D2YN86I9cDYiRF3aEhmMH69RsXSsHFlqA5M1AVqt67btfZXQSUOJm
         67/j4apzvaAoxbq//X21PI2f/aHbbrR1WNWTZl29HeaLcLbZTm+LMzWW/0PzVl6B6cgd
         /BI5xIYJ4HSxRRA13FvrHFh4NmgR0msBEljG2tsYOyhqQt23O2Bsg5Yd+BhNxZSYSb8F
         2o/wDghmzo8c0xyZo8pFj90UXzPoMxwNFQrfQbb+kKQnlUClDEiDCgdA1+ljMOqcswOW
         6IIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=Srd6gml0YLGx1I577UoqvNSMcSiLgu2cTCSMasmakCE=;
        b=MGbR8pPKqp0VWCzyhf29E+al/of1TglIoIvElht1ODoEcpoWeQVkneGvROBQp53Vcp
         pnaYl/lkZoV3acJuFvxJM5n3PUTOlixaBvhodEeITkJzX1VH21kX1RUe+JCzyzGR9UM9
         6FKhlpLZCwkkBgf36rQLxGqaKHQzXg8N9P4ORfrzvdEvHm6s/6tU7VE9TFBzdyqVMrn9
         Iavxb9JE0LLO0FMzY3JOec4hDwEFfRCVaqGLTF8JXLv0Qqu79aqkrRg9SrpXuagL5E1H
         khnyYrLj/bEZd4qWo7ERjHZb/NuhQdn20zoiUN98esyIp38ZWd2fgD1BEhTzBXSF5bgF
         VKZw==
X-Gm-Message-State: APjAAAVAD/LkIZy+QV5VwBF5WTnUjOTlzGuGaudjZdjRDHeWEJ12CgMl
        GI4b8E8jwe4yuuTHNULVPi6uPg==
X-Google-Smtp-Source: APXvYqzGK6vEETGws/tO0syMU7KrEpXi2MFN3psYj9A5lbZHKfsITgzGyRZ6no5eBq0q3Yj3nyJk1A==
X-Received: by 2002:a17:902:6ac8:: with SMTP id i8mr6349524plt.164.1571791929082;
        Tue, 22 Oct 2019 17:52:09 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id 64sm21139510pfx.31.2019.10.22.17.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 17:52:08 -0700 (PDT)
Date:   Tue, 22 Oct 2019 17:52:07 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Waiman Long <longman@redhat.com>
cc:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Vlastimil Babka <vbabka@suse.cz>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Jann Horn <jannh@google.com>, Song Liu <songliubraving@fb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Aquini <aquini@redhat.com>, Mel Gorman <mgorman@suse.de>
Subject: Re: [PATCH] mm/vmstat: Reduce zone lock hold time when reading
 /proc/pagetypeinfo
In-Reply-To: <e272f2e0-153d-4194-f2d6-a15610be4dce@redhat.com>
Message-ID: <alpine.DEB.2.21.1910221734470.126424@chino.kir.corp.google.com>
References: <20191022162156.17316-1-longman@redhat.com> <20191022165745.GT9379@dhcp22.suse.cz> <0b206255-5c62-18f5-d751-a5576a6c0e8f@redhat.com> <e272f2e0-153d-4194-f2d6-a15610be4dce@redhat.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Oct 2019, Waiman Long wrote:

> >>> and used nr_free to compute the missing count. Since MIGRATE_MOVABLE
> >>> is usually the largest one on large memory systems, this is the one
> >>> to be skipped. Since the printing order is migration-type => order, we
> >>> will have to store the counts in an internal 2D array before printing
> >>> them out.
> >>>
> >>> Even by skipping the MIGRATE_MOVABLE pages, we may still be holding the
> >>> zone lock for too long blocking out other zone lock waiters from being
> >>> run. This can be problematic for systems with large amount of memory.
> >>> So a check is added to temporarily release the lock and reschedule if
> >>> more than 64k of list entries have been iterated for each order. With
> >>> a MAX_ORDER of 11, the worst case will be iterating about 700k of list
> >>> entries before releasing the lock.
> >> But you are still iterating through the whole free_list at once so if it
> >> gets really large then this is still possible. I think it would be
> >> preferable to use per migratetype nr_free if it doesn't cause any
> >> regressions.
> >>
> > Yes, it is still theoretically possible. I will take a further look at
> > having per-migrate type nr_free. BTW, there is one more place where the
> > free lists are being iterated with zone lock held - mark_free_pages().
> 
> Looking deeper into the code, the exact migration type is not stored in
> the page itself. An initial movable page can be stolen to be put into
> another migration type. So in a delete or move from free_area, we don't
> know exactly what migration type the page is coming from. IOW, it is
> hard to get accurate counts of the number of entries in each lists.
> 

I think the suggestion is to maintain a nr_free count of the free_list for 
each order for each migratetype so anytime a page is added or deleted from 
the list, the nr_free is adjusted.  Then the free_area's nr_free becomes 
the sum of its migratetype's nr_free at that order.  That's possible to do 
if you track the migratetype per page, as you said, or like pcp pages 
track it as part of page->index.  It's a trade-off on whether you want to 
impact the performance of maintaining these new nr_frees anytime you 
manipulate the freelists.

I think Vlastimil and I discussed per order per migratetype nr_frees in 
the past and it could be a worthwhile improvement for other reasons, 
specifically it leads to heuristics that can be used to determine how 
fragmentated a certain migratetype is for a zone, i.e. a very quick way to 
determine what ratio of pages over all MIGRATE_UNMOVABLE pageblocks are 
free.

Or maybe there are other reasons why these nr_frees can't be maintained 
anymore?  (I had a patch to do it on 4.3.)

You may also find systems where MIGRATE_MOVABLE is not actually the 
longest free_list compared to other migratetypes on a severely fragmented 
system, so special casing MIGRATE_MOVABLE might not be the best way 
forward.
