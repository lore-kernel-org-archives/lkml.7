Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 720F7C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 18:47:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4385F20873
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 18:47:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BB0dY/8F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbfEOSrD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 14:47:03 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:36051 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726392AbfEOSrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 14:47:02 -0400
Received: by mail-ot1-f68.google.com with SMTP id c3so1019922otr.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 11:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eOydKc/WsPS/4UYaw0lrBxS07NNolXo/TbnO9qPBOqA=;
        b=BB0dY/8FNByRR2LvoUO/dEX3U9iTwiAuD6aHdfRN6ftwVYsE1IArfACRpd3ZCZsY6K
         iY3gRSmuhRSwx1CCfGKDmeD+9JrqnQ2zFP92vPEOcQ5dHRWplBxKaMngMkcjtvxNhwfT
         wL6ijfW2WUojZfxbnR6DoqNlpDaHF5luAmcZLddGp/55FRptVwDp2UodImztRLRvOzPs
         e5IB+BeCcv9nlxmyfXT8di+B21J2cX9v6Gd5YYKTdpx0iAi8XF81A8RwPD7taUw9keMH
         LkGSy82DcXdG4vNpjS9JmmDLH853rSylPUd3weZDpNk+E1kXpdMxe0+rTLTqf9jCo9H0
         cZ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eOydKc/WsPS/4UYaw0lrBxS07NNolXo/TbnO9qPBOqA=;
        b=O5tlK8PBZfbksDlemMZFu9KDR4JOmo/qaE03PhUu99Y2naf4SB968AOfylVUhSCT7A
         ooBWINDacZNz6r51T5UMJw4vt+bwpoMdGmFQXap3mr/PWccPxieRYAslXoNBsEIlvM05
         paNqpjbaCgKQgO/euCwxQ+jIrUgaMCybhJpofIFyGjUESzUNGAfVKvjhW+5i+8BgERjQ
         9MeUXn4ayp24bevWxZ1KS5DVvFXdEMG18cQntbN9DWs49o8qCGKY0wWd60VfPEQuNU9i
         nCHfn+WVN3lmrB9jbHqFiOlUzyfNMnyuwVJEklSsAr0eYggQ5EsoExXynn4AtyGnxWe9
         fxDA==
X-Gm-Message-State: APjAAAXzSdaEY5/oq9ijf7lTxhwja3Q2lUOGpoq4qYaChdN1wTZlcQSX
        ENv3CKuPzjszMfkdoo925LNUfCn87b2836MFkDVrNg==
X-Google-Smtp-Source: APXvYqyal1aN8n2OsssxIrvSlvaLMFF5ulsVEFJWHTDanNfWzlN/kwAPewVzo8zGug4MCn40y4+zwPV0F7AvsRqjAxs=
X-Received: by 2002:a9d:5f06:: with SMTP id f6mr26196019oti.18.1557946021528;
 Wed, 15 May 2019 11:47:01 -0700 (PDT)
MIME-Version: 1.0
References: <155793276388.13922.18064660723547377633.stgit@localhost.localdomain>
In-Reply-To: <155793276388.13922.18064660723547377633.stgit@localhost.localdomain>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 15 May 2019 20:46:35 +0200
Message-ID: <CAG48ez20Nu76Q8Tye9Hd3HGCmvfUYH+Ubp2EWbnhLp+J6wqRvw@mail.gmail.com>
Subject: Re: [PATCH RFC 0/5] mm: process_vm_mmap() -- syscall for duplication
 a process mapping
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Michal Hocko <mhocko@suse.com>, keith.busch@intel.com,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        pasha.tatashin@oracle.com,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        ira.weiny@intel.com, Andrey Konovalov <andreyknvl@google.com>,
        arunks@codeaurora.org, Vlastimil Babka <vbabka@suse.cz>,
        Christoph Lameter <cl@linux.com>,
        Rik van Riel <riel@surriel.com>,
        Kees Cook <keescook@chromium.org>, hannes@cmpxchg.org,
        npiggin@gmail.com,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        shakeelb@google.com, Roman Gushchin <guro@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        daniel.m.jordan@oracle.com,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 15, 2019 at 5:11 PM Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
> This patchset adds a new syscall, which makes possible
> to clone a mapping from a process to another process.
> The syscall supplements the functionality provided
> by process_vm_writev() and process_vm_readv() syscalls,
> and it may be useful in many situation.
>
> For example, it allows to make a zero copy of data,
> when process_vm_writev() was previously used:
[...]
> This syscall may be used for page servers like in example
> above, for migration (I assume, even virtual machines may
> want something like this), for zero-copy desiring users
> of process_vm_writev() and process_vm_readv(), for debug
> purposes, etc. It requires the same permittions like
> existing proc_vm_xxx() syscalls have.

Have you considered using userfaultfd instead? userfaultfd has
interfaces (UFFDIO_COPY and UFFDIO_ZERO) for directly shoving pages
into the VMAs of other processes. This works without the churn of
creating and merging VMAs all the time. userfaultfd is the interface
that was written to support virtual machine migration (and it supports
live migration, too).
