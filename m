Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DDDDC072B1
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 23:30:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 458F3208C3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 23:30:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="Pht68gmg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727509AbfE0Xaa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 19:30:30 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:41372 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727465AbfE0Xaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 19:30:30 -0400
Received: by mail-ed1-f67.google.com with SMTP id m4so28812348edd.8
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 16:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Yx/t5JyNPq2CfWKyPo8S5jl7B36K3tOaXOqgll7VB3Y=;
        b=Pht68gmgXm2tUcD7wDY+aRLSo7xgBF3+W0lFrGP1dCtvsygSYQbwVnPbxlr3KTJiXO
         FYJNp7IT818BdApjvsXCeXP2vbj/wNGLbfkH6GDK51LvyDVgtaCNNyGaFohNyCyLFloc
         381SYX6vJ7L7VQ0oUNClrVqNmNjnOlGaaU3f3Uw0WT66E22fSPM2u7bDmtoSOrhzo0lY
         lIXct0O9UkE+thCN4inaK0oYimDL/qUVHy4kn6NESWaBHUr3P+p78mEVTKffED8NaADK
         NkhQkZtW87MrsG9JfHCdGDx3eKzr7sA+L0JVa4o8hB+bL7rV6jn8a9KwvSSs5iagmCyK
         SgUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Yx/t5JyNPq2CfWKyPo8S5jl7B36K3tOaXOqgll7VB3Y=;
        b=QCX2bJ7TQtc8LSzuCStn/RTwVwroncBj/LXKM8Rvkt1qm8qmtcNnOIGKtnzBB9g2mk
         Ko4Om3NBp0VKrFG4kT6TmbHhChZpB+M6E7sULU/uZek53CZQ1JkEAv4IxY+L9TKo4V9G
         IQzqo+cii47X4xKv91OzdNK0GJ7DGw4VDRxZoZxSP/z556SpYSgTG5mDveeONeN1N4KW
         atTTkI1WacVinjvzaW+SzPfi3rNuKGbqCCvFPdlnOxB9IuAu5WwWrOwUbhXvV2dgjokV
         +XviNzqPcGqOxcTeFIJW3m8bfnMQlEmlNbkvQuM3/UDJ4uESkbGbqb8nqfNS/FKI2i2B
         6CyQ==
X-Gm-Message-State: APjAAAUOacmawRJQs7CAgO22aXU8FnJiLJT3g6nNnUQ0Yt2c26za87lh
        J0rBInphqJ/MpRzkQ4ABHzlDbA==
X-Google-Smtp-Source: APXvYqwNsccQYDQ+T/DIEr4MpbjqeYPxkwVJIYO898WWuLI4de+wC1sH3D8WOusY2p8TGpyiYrsCyg==
X-Received: by 2002:a50:add7:: with SMTP id b23mr125171875edd.215.1558999827807;
        Mon, 27 May 2019 16:30:27 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id b45sm1365013edb.28.2019.05.27.16.30.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 May 2019 16:30:26 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id E7ADE102832; Tue, 28 May 2019 02:30:30 +0300 (+03)
Date:   Tue, 28 May 2019 02:30:30 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     akpm@linux-foundation.org, dan.j.williams@intel.com,
        mhocko@suse.com, keith.busch@intel.com,
        kirill.shutemov@linux.intel.com, alexander.h.duyck@linux.intel.com,
        ira.weiny@intel.com, andreyknvl@google.com, arunks@codeaurora.org,
        vbabka@suse.cz, cl@linux.com, riel@surriel.com,
        keescook@chromium.org, hannes@cmpxchg.org, npiggin@gmail.com,
        mathieu.desnoyers@efficios.com, shakeelb@google.com, guro@fb.com,
        aarcange@redhat.com, hughd@google.com, jglisse@redhat.com,
        mgorman@techsingularity.net, daniel.m.jordan@oracle.com,
        jannh@google.com, kilobyte@angband.pl, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 0/7] mm: process_vm_mmap() -- syscall for duplication
 a process mapping
Message-ID: <20190527233030.hpnnbi4aqnu34ova@box>
References: <155836064844.2441.10911127801797083064.stgit@localhost.localdomain>
 <20190522152254.5cyxhjizuwuojlix@box>
 <358bb95e-0dca-6a82-db39-83c0cf09a06c@virtuozzo.com>
 <20190524115239.ugxv766doolc6nsc@box>
 <c3cd3719-0a5e-befe-89f2-328526bb714d@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3cd3719-0a5e-befe-89f2-328526bb714d@virtuozzo.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 05:00:32PM +0300, Kirill Tkhai wrote:
> On 24.05.2019 14:52, Kirill A. Shutemov wrote:
> > On Fri, May 24, 2019 at 01:45:50PM +0300, Kirill Tkhai wrote:
> >> On 22.05.2019 18:22, Kirill A. Shutemov wrote:
> >>> On Mon, May 20, 2019 at 05:00:01PM +0300, Kirill Tkhai wrote:
> >>>> This patchset adds a new syscall, which makes possible
> >>>> to clone a VMA from a process to current process.
> >>>> The syscall supplements the functionality provided
> >>>> by process_vm_writev() and process_vm_readv() syscalls,
> >>>> and it may be useful in many situation.
> >>>
> >>> Kirill, could you explain how the change affects rmap and how it is safe.
> >>>
> >>> My concern is that the patchset allows to map the same page multiple times
> >>> within one process or even map page allocated by child to the parrent.
> >>>
> >>> It was not allowed before.
> >>>
> >>> In the best case it makes reasoning about rmap substantially more difficult.
> >>>
> >>> But I'm worry it will introduce hard-to-debug bugs, like described in
> >>> https://lwn.net/Articles/383162/.
> >>
> >> Andy suggested to unmap PTEs from source page table, and this make the single
> >> page never be mapped in the same process twice. This is OK for my use case,
> >> and here we will just do a small step "allow to inherit VMA by a child process",
> >> which we didn't have before this. If someone still needs to continue the work
> >> to allow the same page be mapped twice in a single process in the future, this
> >> person will have a supported basis we do in this small step. I believe, someone
> >> like debugger may want to have this to make a fast snapshot of a process private
> >> memory (when the task is stopped for a small time to get its memory). But for
> >> me remapping is enough at the moment.
> >>
> >> What do you think about this?
> > 
> > I don't think that unmapping alone will do. Consider the following
> > scenario:
> > 
> > 1. Task A creates and populates the mapping.
> > 2. Task A forks. We have now Task B mapping the same pages, but
> > write-protected.
> > 3. Task B calls process_vm_mmap() and passes the mapping to the parent.
> > 
> > After this Task A will have the same anon pages mapped twice.
> 
> Ah, sure.
> 
> > One possible way out would be to force CoW on all pages in the mapping,
> > before passing the mapping to the new process.
> 
> This will pop all swapped pages up, which is the thing the patchset aims
> to prevent.
> 
> Hm, what about allow remapping only VMA, which anon_vma::rb_root contain
> only chain and which vma->anon_vma_chain contains single entry? This is
> a vma, which were faulted, but its mm never were duplicated (or which
> forks already died).

The requirement for the VMA to be faulted (have any pages mapped) looks
excessive to me, but the general idea may work.

One issue I see is that userspace may not have full control to create such
VMA. vma_merge() can merge the VMA to the next one without any consent
from userspace and you'll get anon_vma inherited from the VMA you've
justed merged with.

I don't have any valid idea on how to get around this.

-- 
 Kirill A. Shutemov
