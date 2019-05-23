Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69F94C04AAC
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 08:14:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2825A20665
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 08:14:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730006AbfEWIOy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 04:14:54 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:34172 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727708AbfEWIOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 04:14:53 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 7A9BC265E40;
        Thu, 23 May 2019 09:14:52 +0100 (BST)
Date:   Thu, 23 May 2019 10:14:49 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, George Spelvin <lkml@sdf.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrey Abramov <st5pub@yandex.ru>, kernel@collabora.com
Subject: Re: [PATCH] lib/sort: Add the sort_r() variant
Message-ID: <20190523101449.7ad35f46@collabora.com>
In-Reply-To: <20190522113315.08484a3942ec07793b7d6112@linux-foundation.org>
References: <20190522112550.31814-1-boris.brezillon@collabora.com>
        <20190522113315.08484a3942ec07793b7d6112@linux-foundation.org>
Organization: Collabora
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On Wed, 22 May 2019 11:33:15 -0700
Andrew Morton <akpm@linux-foundation.org> wrote:

> On Wed, 22 May 2019 13:25:50 +0200 Boris Brezillon <boris.brezillon@collabora.com> wrote:
> 
> > Some users might need extra context to compare 2 elements. This patch
> > adds the sort_r() which is similar to the qsort_r() variant of qsort().
> > 
> > Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> > ---
> > Hello,
> > 
> > A few more details about this patch.
> > 
> > Even though I post it as a standalone patch, I do intend to use it in
> > a real driver (v4l2 driver), just didn't want to have it burried in a
> > huge patch series.
> > 
> > Note that sort() and sort_r() are now implemented as wrappers around
> > do_sort() so that most of the code can be shared. I initially went for
> > a solution that implemented sort() as a wrapper around sort_r() (which
> > basically contained the do_sort() logic without the cmp_func arg)
> > but realized this was adding one extra indirect call (the compare func
> > wrapper), which I know are being chased.  
> 
> Please move the above text into the changelog.  It's probably useful
> and we can afford the disk space ;)

Will do.

> 
> > There's another option, but I'm pretty sure other people already
> > considered it and thought it was not a good idea as it would make
> > the code size grow: move the code to sort.h as inline funcs/macros so
> > that the compiler can optimize things out and replace the indirect
> > cmp_func() calls by direct ones. I just tried it, and it makes my .o
> > file grow by 576 bytes, given that we currently have 122 users of
> > this function, that makes the kernel code grow by ~70k (that's kind
> > of a max estimate since not all users will be compiled in).  
> 
> eep, let's not do that.
> 
> > --- a/include/linux/sort.h
> > +++ b/include/linux/sort.h  
> 
> Patch otherwise looks OK.  Please include it with the patch series
> which uses it.  Feel free to add
> 
> Acked-by: Andrew Morton <akpm@linux-foundation.org>

Thanks for your review.

Boris
