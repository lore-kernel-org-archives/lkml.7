Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC0AFA372A
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 16:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7685B20872
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 16:01:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g5hMI5kx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439597AbfJQQBp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 12:01:45 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:45262 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388567AbfJQQBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 12:01:44 -0400
Received: by mail-yw1-f67.google.com with SMTP id x65so1028437ywf.12
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 09:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=POEbKiu2fpwZ1QYGdQ3ulL/vn9gYu3XJ/PYCzV6tS1M=;
        b=g5hMI5kxqdtZ26qFVTG0mIIHzCTy2wv7pAqugF2x0aOmsZRu3JJOMH49Vgj5WvQaUI
         PT2t4M/hIdmFhIGsKjToPX7xZkUNPjIqxowbDYhXNUDNnVhnVS+EjnKJiw/FEfXx68KK
         XYdF86TxjqCN94emMWZ2iSp3U+mZWflTkLqcJf4NLI26lmuQ0t1Pqd10vDwxCAXxwupx
         m/n708oPr4x8pp1Y/Xw9/oa6VwHT4kRs6FxvRM5tehLqezrS7MDWfQI/vlUm8bQtC/J/
         YdZSRf1KE/gjgr9U2g2o8ug9nytMu4mQ3id8dcfNno1rIfjjt2qIVNR/bv3/QsoVl9r5
         Z19g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=POEbKiu2fpwZ1QYGdQ3ulL/vn9gYu3XJ/PYCzV6tS1M=;
        b=D0jEmb2VShCjAN/MMtU948Xb3gt8yoC2s3sFRdtLA2U9Jx5FYim4vu1JvQHpnjFket
         QkepnyKljS6UGewlQ4NRDteK2zSEYEPF4uPOqMG9IYFiVb4qVdreDgMZVYPS093jLZqL
         AsCRfPTZ2cgpYJcGeHC+3agsHDFMwsBTvL/5o7o3s6tXzNCRatkK7MbXnWjEHtYTNeHX
         uoqWc3tqo/DEBmWiJGvuUdQM1OgkJwyjO+3n0rz7vr2cu8CzdU6dW3Y1il18LVJf4yPi
         ojTNEgfqgX/8YHJERNC+e32KiI2KY4iDViQcTKT7KH9wtSX8tOqH45IelF9tnPCZoTQb
         tFvA==
X-Gm-Message-State: APjAAAXuwhYE3xjhqflSC3JoIZ6clSah2AbjXEWcu8RhkHmbzmMF+MbG
        hdx4v0we7K1mDBWiKhX2yN7HgW47Wt3EIvaq/d9jdg==
X-Google-Smtp-Source: APXvYqyafii/mt+JYS5iwe9OB8ELAj+7pFClz4MBP4sDjY3OuO43IiyT/gJaF5D4PC/yxshcUBDxdMllcXti4wpM+sw=
X-Received: by 2002:a81:2d41:: with SMTP id t62mr3387017ywt.368.1571328100270;
 Thu, 17 Oct 2019 09:01:40 -0700 (PDT)
MIME-Version: 1.0
References: <20191016221148.F9CCD155@viggo.jf.intel.com>
In-Reply-To: <20191016221148.F9CCD155@viggo.jf.intel.com>
From:   Suleiman Souhlal <suleiman@google.com>
Date:   Fri, 18 Oct 2019 01:01:28 +0900
Message-ID: <CABCjUKDWRJO9s68qhKQGXzrW39KqfZzZhoOX0HgDcnv-RxJZPw@mail.gmail.com>
Subject: Re: [PATCH 0/4] [RFC] Migrate Pages in lieu of discard
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        dan.j.williams@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2019 at 7:14 AM Dave Hansen <dave.hansen@linux.intel.com> wrote:
>
> We're starting to see systems with more and more kinds of memory such
> as Intel's implementation of persistent memory.
>
> Let's say you have a system with some DRAM and some persistent memory.
> Today, once DRAM fills up, reclaim will start and some of the DRAM
> contents will be thrown out.  Allocations will, at some point, start
> falling over to the slower persistent memory.
>
> That has two nasty properties.  First, the newer allocations can end
> up in the slower persistent memory.  Second, reclaimed data in DRAM
> are just discarded even if there are gobs of space in persistent
> memory that could be used.
>
> This set implements a solution to these problems.  At the end of the
> reclaim process in shrink_page_list() just before the last page
> refcount is dropped, the page is migrated to persistent memory instead
> of being dropped.
>
> While I've talked about a DRAM/PMEM pairing, this approach would
> function in any environment where memory tiers exist.
>
> This is not perfect.  It "strands" pages in slower memory and never
> brings them back to fast DRAM.  Other things need to be built to
> promote hot pages back to DRAM.
>
> This is part of a larger patch set.  If you want to apply these or
> play with them, I'd suggest using the tree from here.  It includes
> autonuma-based hot page promotion back to DRAM:
>
>         http://lkml.kernel.org/r/c3d6de4d-f7c3-b505-2e64-8ee5f70b2118@intel.com
>
> This is also all based on an upstream mechanism that allows
> persistent memory to be onlined and used as if it were volatile:
>
>         http://lkml.kernel.org/r/20190124231441.37A4A305@viggo.jf.intel.com
>

We prototyped something very similar to this patch series in the past.

One problem that came up is that if you get into direct reclaim,
because persistent memory can have pretty low write throughput, you
can end up stalling users for a pretty long time while migrating
pages.

To mitigate that, we tried changing background reclaim to start
migrating much earlier (but not otherwise reclaiming), however it
drastically increased the code complexity and still had the chance of
not being able to catch up with pressure.

Because of that, we moved to a solution based on the proactive reclaim
of idle pages, that was presented at LSFMM earlier this year:
https://lwn.net/Articles/787611/ .

-- Suleiman
