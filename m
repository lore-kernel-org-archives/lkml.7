Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F346CC31E50
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 13:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D14AB2080A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 13:51:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726432AbfFQNva (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 09:51:30 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:54332 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbfFQNv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 09:51:29 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 9BD91282442;
        Mon, 17 Jun 2019 14:51:28 +0100 (BST)
Date:   Mon, 17 Jun 2019 15:51:25 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     linux-kernel@vger.kernel.org, George Spelvin <lkml@sdf.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Abramov <st5pub@yandex.ru>, kernel@collabora.com
Subject: Re: [PATCH] lib/sort: Add the sort_r() variant
Message-ID: <20190617155125.62da2946@collabora.com>
In-Reply-To: <20190524170937.7ecf7fe1@collabora.com>
References: <20190522112550.31814-1-boris.brezillon@collabora.com>
        <bc3f2b9b-627f-bcc7-c16d-391a962258c0@rasmusvillemoes.dk>
        <20190524170937.7ecf7fe1@collabora.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Rasmus,

On Fri, 24 May 2019 17:09:37 +0200
Boris Brezillon <boris.brezillon@collabora.com> wrote:

> Hello Rasmus,
> 
> On Thu, 23 May 2019 22:04:35 +0200
> Rasmus Villemoes <linux@rasmusvillemoes.dk> wrote:
> 
> > On 22/05/2019 13.25, Boris Brezillon wrote:  
> > > Some users might need extra context to compare 2 elements. This patch
> > > adds the sort_r() which is similar to the qsort_r() variant of qsort().
> > > 
> > > Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> > > ---
> > > Hello,
> > > 
> > > A few more details about this patch.
> > > 
> > > Even though I post it as a standalone patch, I do intend to use it in
> > > a real driver (v4l2 driver), just didn't want to have it burried in a
> > > huge patch series.
> > > 
> > > Note that sort() and sort_r() are now implemented as wrappers around
> > > do_sort() so that most of the code can be shared. I initially went for
> > > a solution that implemented sort() as a wrapper around sort_r() (which
> > > basically contained the do_sort() logic without the cmp_func arg)
> > > but realized this was adding one extra indirect call (the compare func
> > > wrapper), which I know are being chased.    
> > 
> > Hm, I don't like the "pass one or the other, but not both". Yes, the
> > direct way to implement sort() in terms of sort_r would be
> > 
> > cmp_wrapper(void *a, void *b, void *priv)
> > { return ((cmp_func_t)priv)(a, b); }
> > 
> > void sort(...) { sort_r(...., cmp_wrapper, cmp_func); }
> > 
> > but it's easy enough to get rid of that extra indirect call similar to
> > how the swap functions are done: pass a sentinel value, and use a single
> > (highly predictable) branch to check whether we have an old-style cmp
> > function.
> > 
> > [Are there actually any architectures where passing a third argument to
> > a function just expecting two would not Just Work? I.e., could one
> > simply cast a new-style comparison function to an old-style and pass
> > NULL as priv? Well, we'd better not go down that road.]
> > 
> > So I propose this somewhat simpler (at least in terms of diffstat)
> > patch, which also fits nicely with some optimizations I plan on doing to
> > eliminate "trivial" comparison functions (those that just do a single
> > integer comparison of some field inside the structs).  
> 
> Works for me. If you plan to send changes on top (or before) would you
> mind making this patch part of the series so that we don't have to deal
> with merge conflicts.

Gentle ping. How should I proceed with that patch? Do you plan to send
(or have already sent) the changes you were mentioning above?

Regards,

Boris
