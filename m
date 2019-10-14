Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 795AAECE587
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 08:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5766920659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 08:41:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730553AbfJNIlH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 04:41:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41920 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730441AbfJNIlG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 04:41:06 -0400
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 649465859E
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 08:41:06 +0000 (UTC)
Received: by mail-pf1-f199.google.com with SMTP id s139so12950878pfc.21
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 01:41:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4FdnQewgGZTEIB4IszhktM32Rs8jClJgBtHw5gOlpAo=;
        b=VG3ZCIAym5VVjBwDH6jyLCLVGCdWHoud4LTF1pRBJiTQzyrv9Y06UzCyHBfn9Rztim
         /qUC6mgx5CBULGwr7jQgTqpKw25J5AIFH2wCkiP1Hxmgtrwj1bHVNEH6DijGgPeusE2u
         gwfdhTs1RdL0ap6YdG7IJioC3mJNckX5Fkjn4KezPQ8pJW5gYO23P4FvsZMb6TftduPW
         +SFaNpgfMNpqKe+974dPxhFjlNWEuD5U2X0rXutSUGRvsJvMBBhcKi3e2VHhUR1kVj5o
         MHrF8RqnXMxQrC+oUgPKPC/GIf2u4QLsQkVlOdnZLofHUFkxILqmbrofrsB+ru366fYx
         nWIA==
X-Gm-Message-State: APjAAAVjxxe9yqVpiQMn3pw8F5+uVhsklA0/N1g8xH8w+P1ieNMlv+WP
        I5js8yJt+hil3vuKCIhIUYccyMBNCrWhNuT+o2FCTHYwBtqNeGigMV4nH12K7cyMnRn8GYVcvz0
        BFSpFC8o8ekoTcnNXN1GuiHdL
X-Received: by 2002:a17:90a:cc12:: with SMTP id b18mr33167021pju.141.1571042465829;
        Mon, 14 Oct 2019 01:41:05 -0700 (PDT)
X-Google-Smtp-Source: APXvYqysi/gpDn1hQzUB8+LiD0F52xkMYWEOwsHT4NROhG1sYO4vX4yLKV+FbHcFJTSVGZHy6ELN0Q==
X-Received: by 2002:a17:90a:cc12:: with SMTP id b18mr33166992pju.141.1571042465531;
        Mon, 14 Oct 2019 01:41:05 -0700 (PDT)
Received: from xz-x1 ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id i10sm19242993pgb.79.2019.10.14.01.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 01:41:04 -0700 (PDT)
Date:   Mon, 14 Oct 2019 16:40:52 +0800
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Maya Gokhale <gokhale2@llnl.gov>,
        Jerome Glisse <jglisse@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Martin Cracauer <cracauer@cons.org>,
        Matthew Wilcox <willy@infradead.org>, Shaohua Li <shli@fb.com>,
        Marty McFadden <mcfadden8@llnl.gov>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Denis Plotnikov <dplotnikov@virtuozzo.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH v5 00/16] mm: Page fault enhancements
Message-ID: <20191014084052.GB8666@xz-x1>
References: <20190926093904.5090-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190926093904.5090-1-peterx@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 26, 2019 at 05:38:48PM +0800, Peter Xu wrote:
> This is v5 of the series.  As Matthew suggested, I split the previous
> patch "mm: Return faster for non-fatal signals in user mode faults"
> into a few smaller ones:
> 
>   1. One patch to introduce fatal_signal_pending(), and use it in
>      archs that can directly apply
> 
>   2. A few more patches to let the rest archs to use the new helper.
>      With that we can have an unified entry for signal detection
> 
>   3. One last patch to change fatal_signal_pending() to detect
>      userspace non-fatal signal
> 
> Nothing should have changed in the rest patches.  Because the fault
> retry patches will depend on the previous ones, I decided to simply
> repost all the patches.
> 
> Here's the new patchset layout:
> 
> Patch 1-2:      cleanup, and potential bugfix of hugetlbfs on fault retry
> 
> Patch 3-9:      let page fault to respond to non-fatal signals faster
> 
> Patch 10:       remove the userfaultfd NOPAGE emulation
> 
> Patch 11-14:    allow page fault to retry more than once
> 
> Patch 15-16:    let gup code to use FAULT_FLAG_KILLABLE too
> 
> I would really appreciate any review comments for the series,
> especially for the first two patches which IMHO are even not related
> to this patchset and they should either cleanup or fix things.

Ping..

IMHO this series should fix some real issues, e.g., the whole series
targets to fix things like [1] or as patch 2 might fix potential
bugs.  I'd appreciate if it can get some more review comments.

I didn't repost because the last patch only need a one-line change so
I assume it does not affect the most rest of reviews.  I can repost if
anyone would like me to.

Thanks,

[1] https://lore.kernel.org/lkml/20171102193644.GB22686@redhat.com/

-- 
Peter Xu
