Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19A93C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 21:04:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD37220657
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 21:04:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbfCIVEk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 16:04:40 -0500
Received: from mx.sdf.org ([205.166.94.20]:61342 "EHLO mx.sdf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726298AbfCIVEk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 16:04:40 -0500
Received: from sdf.org (IDENT:lkml@sdf.lonestar.org [205.166.94.16])
        by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id x29L2Tb1029151
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits) verified NO);
        Sat, 9 Mar 2019 21:02:30 GMT
Received: (from lkml@localhost)
        by sdf.org (8.15.2/8.12.8/Submit) id x29L2TvG017588;
        Sat, 9 Mar 2019 21:02:29 GMT
Date:   Sat, 9 Mar 2019 21:02:29 GMT
From:   George Spelvin <lkml@sdf.org>
Message-Id: <201903092102.x29L2TvG017588@sdf.org>
To:     andriy.shevchenko@linux.intel.com, lkml@sdf.org
Subject: Re: [PATCH 1/5] lib/sort: Make swap functions more generic
Cc:     akpm@linux-foundation.org, daniel.wagner@siemens.com,
        dchinner@redhat.com, don.mullis@gmail.com, geert@linux-m68k.org,
        linux-kernel@vger.kernel.org, linux@rasmusvillemoes.dk,
        st5pub@yandex.ru
In-Reply-To: <20190309140653.GO9224@smile.fi.intel.com>
References: <cover.1552097842.git.lkml@sdf.org>,
    <dc6cc09e71f8687ff2ef4cbfc2b11accc9aba8aa.1552097842.git.lkml@sdf.org>,
    <20190309140653.GO9224@smile.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Shevchenko wrote:
> Shouldn't simple memcpy cover these case for both 32- and 64-bit architectures?

Speaking of replacing swap with copying via temporary buffers, one
idea that did come to mind was avoiding swap for sufficiently small
objects.

Every sift-down is actually a circular shift.  Once the target
position hs been found, we rotate the path from the root to the
target up one, with the target filled in by the previous root.

(When breaking down the heap, there's one additional link in the
cycle, where the previous root goes to the end of the heap and the
end of the heap goes to the target.)

If we had a temporary buffer (128 bytes would handle most things),
we could copy the previous root there and *copy*, rather than swap,
the elements on the path to the target up, then finally copy the
previous root to the target.

However, to rotate up, the this must be done in top-down order.
The way the code currently works with premultiplied offsets, it's
easy to traverse bottom-up, but very awkward to retrace the
top-down path.

The only solution I can think of is to build a bitmap of the
left/right turnings from the root to the leaf, and then back it up
to the target.  There are a few ways to do this:

1) The obvious big-endian order.  The bitmap is simply the 1-based
   position of the leaf. To add a level, shift left and add the new
   bit at the bottom.  To back up a step, shift right.

   To retrace, create a 1-bit mask equal to the msbit of the index
   ((smear_right(x) >> 1) + 1) and repeatedly shift the mask right.

2) The reverse order.  We use a 1-bit mask while building the
   bitmap, and while retracing, just examine the lsbit while shifting
   the bitmap right.

3) As option 1, but don't build the bitmap as we're walking down;
   rather reconstruct it from the premultiplied offset using
   reciprocal_divide().

Nothing really jumps out to me as The Right Way to do it.

I don't want to bloat the code to the point that it would be
easier to implement a different algorithm entirely.
