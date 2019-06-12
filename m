Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0C46C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 18:45:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B49D206E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 18:45:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HGFLTVZM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbfFLSpO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 14:45:14 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36354 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbfFLSpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 14:45:14 -0400
Received: by mail-pl1-f195.google.com with SMTP id d21so6998714plr.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 11:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=omuFOa2tFDyvD/Kk+1R1oTq5IbQwKSGOjinwhbTkIxM=;
        b=HGFLTVZMj2Fv4UYi1jfmmbPBoEzDA/UVQezc0W2Bcd79cW34Pu3BbuwYPOupjYvbEX
         LQKbdb6JrU5QfS09J2UwNKfMNPLzrfuYbKSyO+k6eVh+g8iRlLN8h8u2rU8Bx10TybEp
         cBsQA/Zx7CsMDNXEKahpWcbwFw+loKIOFKzKllQm7pEYL3oZCciuOO4Rx27sbQ1tFpZD
         TtcGl78VF8GJasVUbYYq0ndgFWWSUba1B8hXNee4GB/ZFYgj3GEF6zd2eVqn9RK3IcAW
         NCiQWQgmVccoDuLas/dTLv5nhBA6sLMm9VIJs9erexVXlrnRIpo6NK4oPZvf90rYZOn6
         xWyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=omuFOa2tFDyvD/Kk+1R1oTq5IbQwKSGOjinwhbTkIxM=;
        b=jNOdDbIkInj8P21I7CmqohaycOsIJQ4v461hKFE122tuxGfuniBlOclG71G9NIt1Fd
         NRIxCVCIXMJkivjU7if6flZAS4IxY4yOtw8JOiqZhqdqCIy5vY+urZwC7HbV4Mw8zjvN
         8FwK/NH96tBNypKpThMVpdKF01/j9f5JhOGcVVwhWM/0sDLLiCVcKg+ZpAm3nR3gfoaD
         NfBjP8HYt5sIm8WlE2AXYxH5zVL7q1kdFd5RZN6c349VyXPN93flH0We4X7uDsn8rNcS
         sul2Rv4Xl/MoDWE2mbExH4GqQ9BbwMDAZiPMHWJ3tC0KMY1CUq3+/Tu+gCz6k/Q03D4y
         spyg==
X-Gm-Message-State: APjAAAWoX+ZHG8hWJCaeubuR4cdeBEgd9vmfqhU8XQvp3F/mlkF9OLl2
        NHy3tahhxZU3EXvFZf0IQSFDQQ==
X-Google-Smtp-Source: APXvYqyIHxzrp9wTkBh/Z0Wezdft3T2dBv3Ff7o00sYtjg56R9Q392wcAQJKkhAxczOYIvNrKXebGA==
X-Received: by 2002:a17:902:e011:: with SMTP id ca17mr15951482plb.328.1560365112972;
        Wed, 12 Jun 2019 11:45:12 -0700 (PDT)
Received: from [100.112.83.253] ([104.133.9.109])
        by smtp.gmail.com with ESMTPSA id m96sm210388pjb.1.2019.06.12.11.45.11
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 12 Jun 2019 11:45:12 -0700 (PDT)
Date:   Wed, 12 Jun 2019 11:44:54 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Yang Shi <yang.shi@linux.alibaba.com>
cc:     Hugh Dickins <hughd@google.com>, mhocko@suse.com, vbabka@suse.cz,
        rientjes@google.com, kirill@shutemov.name,
        kirill.shutemov@linux.intel.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [v2 PATCH] mm: thp: fix false negative of shmem vma's THP
 eligibility
In-Reply-To: <578b7903-40ef-e616-d700-473713f438c0@linux.alibaba.com>
Message-ID: <alpine.LSU.2.11.1906121120240.1107@eggly.anvils>
References: <1556037781-57869-1-git-send-email-yang.shi@linux.alibaba.com> <alpine.LSU.2.11.1906072008210.3614@eggly.anvils> <578b7903-40ef-e616-d700-473713f438c0@linux.alibaba.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jun 2019, Yang Shi wrote:
> On 6/7/19 8:58 PM, Hugh Dickins wrote:
> > Yes, that is correct; and correctly placed. But a little more is needed:
> > see how mm/memory.c's transhuge_vma_suitable() will only allow a pmd to
> > be used instead of a pte if the vma offset and size permit. smaps should
> > not report a shmem vma as THPeligible if its offset or size prevent it.
> > 
> > And I see that should also be fixed on anon vmas: at present smaps
> > reports even a 4kB anon vma as THPeligible, which is not right.
> > Maybe a test like transhuge_vma_suitable() can be added into
> > transparent_hugepage_enabled(), to handle anon and shmem together.
> > I say "like transhuge_vma_suitable()", because that function needs
> > an address, which here you don't have.
> 
> Thanks for the remind. Since we don't have an address I'm supposed we just
> need check if the vma's size is big enough or not other than other alignment
> check.
> 
> And, I'm wondering whether we could reuse transhuge_vma_suitable() by passing
> in an impossible address, i.e. -1 since it is not a valid userspace address.
> It can be used as and indicator that this call is from THPeligible context.

Perhaps, but sounds like it will abuse and uglify transhuge_vma_suitable()
just for smaps. Would passing transhuge_vma_suitable() the address
    ((vma->vm_end & HPAGE_PMD_MASK) - HPAGE_PMD_SIZE)
give the the correct answer in all cases?

> > 
> > The anon offset situation is interesting: usually anon vm_pgoff is
> > initialized to fit with its vm_start, so the anon offset check passes;
> > but I wonder what happens after mremap to a different address - does
> > transhuge_vma_suitable() then prevent the use of pmds where they could
> > actually be used? Not a Number#1 priority to investigate or fix here!
> > but a curiosity someone might want to look into.
> 
> Will mark on my TODO list.
> 
> > Even with your changes
> > ShmemPmdMapped:     4096 kB
> > THPeligible:    0
> > will easily be seen: THPeligible reflects whether a huge page can be
> > allocated and mapped by pmd in that vma; but if something else already
> > allocated the huge page earlier, it will be mapped by pmd in this vma
> > if offset and size allow, whatever THPeligible says. We could change
> > transhuge_vma_suitable() to force ptes in that case, but it would be
> > a silly change, just to make what smaps shows easier to explain.
> 
> Where did this come from? From the commit log? If so it is the example for
> the wrong smap output. If that case really happens, I think we could document
> it since THPeligible should just show the current status.

Please read again what I explained there: it's not necessarily an example
of wrong smaps output, it's reasonable smaps output for a reasonable case.

Yes, maybe Documentation/filesystems/proc.txt should explain "THPeligble"
a little better - "eligible for allocating THP pages" rather than just
"eligible for THP pages" would be good enough? we don't want to write
a book about the various cases.

Oh, and the "THPeligible" output lines up very nicely there in proc.txt:
could the actual alignment of that 0 or 1 be fixed in smaps itself too?

Thanks,
Hugh
