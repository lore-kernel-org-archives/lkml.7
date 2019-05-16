Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D47EC04E84
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 13:14:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7011220818
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 13:14:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fReDa0z9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727369AbfEPNOg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 09:14:36 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:43198 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbfEPNOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 09:14:35 -0400
Received: by mail-ot1-f66.google.com with SMTP id i8so3326129oth.10
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 06:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ROaA0wXtesoRLV9jmYQxe8dOtv7TkiCY5hrIvCy7dF4=;
        b=fReDa0z9uHf+JdOnFb05L1Sb2NczVkeE/wfdtsKJtVRJdlu/Fy7TPQQlZVllJGEfVI
         RGg7FWvRbo8E6AVP8MLFTeXB72jglZuZienY2l/zowEbQoOpIBaa/+jFnlle3GzGFc3X
         xNigM0FnR9XrDOEY5QID9N8l7rr1SPmrT5PfodS5GKNfnFOfOth2NQIDjT3rgcY+M3vB
         Cfuq7MjGvfW0ty3Bhj2YvrKqrFz97mPOyFCFMPTS0hiLi4mZ+3MOlRoB3Jehl3WmsUD2
         iBrqKjQNY+qEgbDG40juKK/o/hmnoDNXWF12m1KsESJx4v2wbFNzxs5C0nwXyl5NB/mP
         /Q/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ROaA0wXtesoRLV9jmYQxe8dOtv7TkiCY5hrIvCy7dF4=;
        b=hRepLT395rGfcvY4f/4TSLnlFBHX0sIgscdJ5gEsX/h3rdmm64z2K6RxGip7+o6PrX
         DDTRyuFgLneblt0+AXzGj/zopHqsa9hwrLG997H9x3HtYZVrvUTbSZ5ttLGmxaeBavxH
         7kmGG5ore3JSNEIrpYjffIdVhRPNlaS54bYiQekr3ZH5BT9+kXTA1z8O9W3XHKH/4+HC
         igfCbWYSVMJSaHBBIdCfpDkf1YwJdkxRgElUE+B6upXRMOB+VSfEQjKcB5Y3kQr9Yu86
         IuAAe/c2KQGYaMrX7tdtXCB5ZLjltqyk9K2w8q5VhHIKAJp2NlDFHc3NkE9RxHrgAbW0
         MZag==
X-Gm-Message-State: APjAAAUKTB59/qtqKVK0KyNiGzxOVdyMazTwyRGctEGRpWc17Amv6qKI
        DZaT71UVrXZEQwkSVokKoeRPUHjch5A+bWQhvfzL7g==
X-Google-Smtp-Source: APXvYqz8ONif2CczL0twdpVOaBW6vNrGkKqpu7xEjjDuQ4L9r3lh6OrdS3yiomN/QUeXmHuUGmjDQ0jYNaDLm4icWVQ=
X-Received: by 2002:a9d:6954:: with SMTP id p20mr8910155oto.337.1558012474998;
 Thu, 16 May 2019 06:14:34 -0700 (PDT)
MIME-Version: 1.0
References: <155793276388.13922.18064660723547377633.stgit@localhost.localdomain>
 <CAG48ez20Nu76Q8Tye9Hd3HGCmvfUYH+Ubp2EWbnhLp+J6wqRvw@mail.gmail.com> <456c7367-0656-933b-986d-febdcc5ab98e@virtuozzo.com>
In-Reply-To: <456c7367-0656-933b-986d-febdcc5ab98e@virtuozzo.com>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 16 May 2019 15:14:08 +0200
Message-ID: <CAG48ez0itiEE1x=SXeMbjKvMGkrj7wxjM6c+ZB00LpXAAhqmiw@mail.gmail.com>
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
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>,
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

On Thu, May 16, 2019 at 3:03 PM Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
> On 15.05.2019 21:46, Jann Horn wrote:
> > On Wed, May 15, 2019 at 5:11 PM Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
> >> This patchset adds a new syscall, which makes possible
> >> to clone a mapping from a process to another process.
> >> The syscall supplements the functionality provided
> >> by process_vm_writev() and process_vm_readv() syscalls,
> >> and it may be useful in many situation.
> >>
> >> For example, it allows to make a zero copy of data,
> >> when process_vm_writev() was previously used:
> > [...]
> >> This syscall may be used for page servers like in example
> >> above, for migration (I assume, even virtual machines may
> >> want something like this), for zero-copy desiring users
> >> of process_vm_writev() and process_vm_readv(), for debug
> >> purposes, etc. It requires the same permittions like
> >> existing proc_vm_xxx() syscalls have.
> >
> > Have you considered using userfaultfd instead? userfaultfd has
> > interfaces (UFFDIO_COPY and UFFDIO_ZERO) for directly shoving pages
> > into the VMAs of other processes. This works without the churn of
> > creating and merging VMAs all the time. userfaultfd is the interface
> > that was written to support virtual machine migration (and it supports
> > live migration, too).
>
> I know about userfaultfd, but it does solve the discussed problem.
> It allocates new pages to make UFFDIO_COPY (see mcopy_atomic_pte()),
> and it accumulates all the disadvantages, the example from [0/5]
> message has.

Sorry, right, I misremembered that.
