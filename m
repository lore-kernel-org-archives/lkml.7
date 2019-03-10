Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F173C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 22:30:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33AD220652
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 22:30:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727269AbfCJWap (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 18:30:45 -0400
Received: from mx.sdf.org ([205.166.94.20]:56997 "EHLO mx.sdf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727192AbfCJWam (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 18:30:42 -0400
Received: from sdf.org (IDENT:lkml@sdf.lonestar.org [205.166.94.16])
        by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id x2AMTP6K001770
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits) verified NO);
        Sun, 10 Mar 2019 22:29:25 GMT
Received: (from lkml@localhost)
        by sdf.org (8.15.2/8.12.8/Submit) id x2AMTOoU009609;
        Sun, 10 Mar 2019 22:29:24 GMT
Date:   Sun, 10 Mar 2019 22:29:24 GMT
From:   George Spelvin <lkml@sdf.org>
Message-Id: <201903102229.x2AMTOoU009609@sdf.org>
To:     linux-kernel@vger.kernel.org, linux@rasmusvillemoes.dk,
        lkml@sdf.org
Subject: Re: [PATCH 4/5] lib/list_sort: Simplify and remove MAX_LIST_LENGTH_BITS
Cc:     akpm@linux-foundation.org, andriy.shevchenko@linux.intel.com,
        daniel.wagner@siemens.com, dchinner@redhat.com,
        don.mullis@gmail.com, geert@linux-m68k.org, st5pub@yandex.ru
In-Reply-To: <3194949c-6e04-da01-68df-60ae344db099@rasmusvillemoes.dk>
References: <cover.1552097842.git.lkml@sdf.org>,
    <dd447448384883bd42c41f0de6a83430b6435dc1.1552097842.git.lkml@sdf.org>,
    <3194949c-6e04-da01-68df-60ae344db099@rasmusvillemoes.dk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rasmus Villemoes wrote:
> On 05/03/2019 04.06, George Spelvin wrote:
>> + * (Actually, it is always called with @a being the element which was
>> + * originally first, so it is not necessary to to distinguish the @a < @b
>> + * and @a == @b cases; the return value may be a simple boolean.  But if
>> + * you ever *use* this freedom, be sure to update this comment to document
>> + * that code now depends on preserving this property!)
>
> This was and still is used at least by the block layer, and likely
> others as well. While 3110fc79606fb introduced a bunch of if() return -1
> else if () ... stuff, it still ends with a 0/1 result. Before
> 3110fc79606fb, it was even more obvious that this property was used.

Ah, thank you!  I actually read through every list_sort caller in
the kernel to see if I could find anywhere that used it and couldn't,
but I didn't study this code carefully enough to see that it does
in the last step.

Since someone *does* use this, I'll change the comment signiicantly.

> Grepping around shows that this could probably be used in more places,
> gaining a cycle or two per cmp callback, e.g. xfs_buf_cmp. But that's of
> course outside the scope of this series.

The one that misled me at first was _xfs_buf_obj_cmp, which returns 0/1,
but that's not used by list_sort().  xfs_buf_cmp returns -1/0/+1.

As you might see from the comment around the cmp_func typedef,
there are other things that could be cleaned up if we did a pass
over all the call sites.

(I'm almost tempted to tell the compiler than cmp_func is const,
since it's supposed to be independent of the pointer frobbing that
list_sort does, but then I remember Henry Spencer's maxim about
lying to the compiler.)
