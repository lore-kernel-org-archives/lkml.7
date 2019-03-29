Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9999AC10F05
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 03:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6306720811
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 03:59:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EkcTR7Mh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728649AbfC2D76 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 23:59:58 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:34844 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbfC2D75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 23:59:57 -0400
Received: by mail-yw1-f67.google.com with SMTP id d132so234099ywa.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 20:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sodBEomwfUZX4txDWtjSVMZxEBAIq/0o8L2NFyjYD0g=;
        b=EkcTR7MhCLUJ3wg1Mkfze+pvFsS9FB7+CPtJTkogY2qjrCBEdYGc1kiyAGuFvCKbFX
         /i3X0AdR8j1gSbjYvOqorKAxMkFweTtSd3UfZW6lzzItqCBTx2wG/e8X0/Sv6auOmel6
         3w4v/O/rNX74uhId2sTheecpJUaZGonuf10NeAc9RXnfWan/Dgxn/0a5psLOH55uOZvZ
         rG4OaN15bq3MAiQGV7Q4jjmSOldrVYzzDyky9mMZ3oozjvW/EHRclj7HEPvtKOAMk1ZC
         LpTpok6yvbeh61jPs1j2Nb1prK/UfFE9QnuBubIq8wY6AwhnFDjcQnN0Pw/PpbcWXRiI
         qrFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sodBEomwfUZX4txDWtjSVMZxEBAIq/0o8L2NFyjYD0g=;
        b=gV76e1WhA4UI7ZGFq9Qpg/cQiynjMgj86jTmop76nD+rKB/o+RuBOMkbYj0WF0viVk
         SyOKrbOn8SFRrHWcopRx+Y3Rnh3xsFMSXs4wdC8o/AxPcVBmhG2ge9FCzvLP6xKLKYfD
         6VYgP56FNcNXPre8dGdCcPi2B6zoAFOEeEauqA6V+3NXmguVexgoZvNAprmLBgdDC2CX
         JbmCX2WfPqWmT01tH4OU+BrCaUZe3TBYdgOKEeKhj+YFID1/KGfIOHVV8/vakhdI/rOc
         q4h2xQcbEHTPrpAUSFcNVyQKhIuIZbCXTerwS/RYe4XPFXoIpk8pj8RCAqXKuAkVwxUV
         xG+g==
X-Gm-Message-State: APjAAAX70HKqdwCvBqW1W/e6lTkj1VxpYTQ2YdvujQJ3I2sEKJeVCeOh
        HaFkoZPzx2AXZDodtPg7C9U0uri6B36/lgXusUQC2Q==
X-Google-Smtp-Source: APXvYqxuG02NZLurFciuM9gsdcxHoqpf5aEBrqH2HonpHDdVpXor894q8P+U1qJC2MJKs8kgzcwU4hs8pReSX8zYJ60=
X-Received: by 2002:a81:1b52:: with SMTP id b79mr39274302ywb.285.1553831996530;
 Thu, 28 Mar 2019 20:59:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190329012836.47013-1-shakeelb@google.com> <20190329023552.GV10344@bombadil.infradead.org>
In-Reply-To: <20190329023552.GV10344@bombadil.infradead.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 28 Mar 2019 20:59:45 -0700
Message-ID: <CALvZod5GiC1+HB3_Mm969Qbgj7s6-unbd141uP5pnMbsufS+mg@mail.gmail.com>
Subject: Re: [RFC PATCH] mm, kvm: account kvm_vcpu_mmap to kmemcg
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ben Gardon <bgardon@google.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Linux MM <linux-mm@kvack.org>, kvm@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 7:36 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Thu, Mar 28, 2019 at 06:28:36PM -0700, Shakeel Butt wrote:
> > A VCPU of a VM can allocate upto three pages which can be mmap'ed by the
> > user space application. At the moment this memory is not charged. On a
> > large machine running large number of VMs (or small number of VMs having
> > large number of VCPUs), this unaccounted memory can be very significant.
> > So, this memory should be charged to a kmemcg. However that is not
> > possible as these pages are mmapped to the userspace and PageKmemcg()
> > was designed with the assumption that such pages will never be mmapped
> > to the userspace.
> >
> > One way to solve this problem is by introducing an additional memcg
> > charging API similar to mem_cgroup_[un]charge_skmem(). However skmem
> > charging API usage is contained and shared and no new users are
> > expected but the pages which can be mmapped and should be charged to
> > kmemcg can and will increase. So, requiring the usage for such API will
> > increase the maintenance burden. The simplest solution is to remove the
> > assumption of no mmapping PageKmemcg() pages to user space.
>
> The usual response under these circumstances is "No, you can't have a
> page flag bit".
>

I would say for systems having CONFIG_MEMCG_KMEM, a page flag bit is
not that expensive.

> I don't understand why we need a PageKmemcg anyway.  We already
> have an entire pointer in struct page; can we not just check whether
> page->mem_cgroup is NULL or not?

PageKmemcg is for kmem while page->mem_cgroup is used for anon, file
and kmem memory. So, page->mem_cgroup can not be used for NULL check
unless we unify them. Not sure how complicated would that be.

Shakeel
