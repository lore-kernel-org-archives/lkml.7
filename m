Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26344C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 03:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2987218D0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 03:53:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbfCPDxW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 23:53:22 -0400
Received: from mx.sdf.org ([205.166.94.20]:60215 "EHLO mx.sdf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726765AbfCPDxW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 23:53:22 -0400
Received: from sdf.org (IDENT:lkml@sdf.lonestar.org [205.166.94.16])
        by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id x2G3pFrK022479
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits) verified NO);
        Sat, 16 Mar 2019 03:51:15 GMT
Received: (from lkml@localhost)
        by sdf.org (8.15.2/8.12.8/Submit) id x2G3pEuq020022;
        Sat, 16 Mar 2019 03:51:14 GMT
Message-Id: <cover.1552704199.git.lkml@sdf.org>
From:   George Spelvin <lkml@sdf.org>
Date:   Sat, 16 Mar 2019 02:43:19 +0000
Subject: [PATCH v2 0/5] lib/sort & lib/list_sort: faster and smaller
To:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     George Spelvin <lkml@sdf.org>, Andrey Abramov <st5pub@yandex.ru>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Don Mullis <don.mullis@gmail.com>,
        Dave Chinner <dchinner@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v1->v2:	Various spelling, naming and code style cleanups.
	Generally positive and no negative responses to the
	goals and algorithms used.

	I'm running these patches, with CONFIG_TEST_SORT and
	CONFIG_TEST_LIST_SORT, on the machine I'm sending this from.
	I have tweaked the comments further, but I have verified
	the compiled object code is identical to a snapshot I took
	when I rebooted.

	As far as I'm concerned, this is ready to be merged.
	As there is no owner in MAINTAINERS, I was thinking of
	sending it via AKPM, like the recent lib/lzo changes.
	Andrew, is that okay with you?

Because CONFIG_RETPOLINE has made indirect calls much more expensive,
I thought I'd try to reduce the number made by the library sort
functions.

The first three patches apply to lib/sort.c.

Patch #1 is a simple optimization.  The built-in swap has special cases
for aligned 4- and 8-byte objects.  But those are almost never used;
most calls to sort() work on larger structures, which fall back to the
byte-at-a-time loop.  This generalizes them to aligned *multiples* of 4
and 8 bytes.  (If nothing else, it saves an awful lot of energy by not
thrashing the store buffers as much.)

Patch #2 grabs a juicy piece of low-hanging fruit.  I agree that
nice simple solid heapsort is preferable to more complex algorithms
(sorry, Andrey), but it's possible to implement heapsort with far fewer
comparisons (50% asymptotically, 25-40% reduction for realistic sizes)
than the way it's been done up to now.  And with some care, the code
ends up smaller, as well.  This is the "big win" patch.

Patch #3 adds the same sort of indirect call bypass that has been added
to the net code of late.  The great majority of the callers use the
builtin swap functions, so replace the indirect call to sort_func with a
(highly preditable) series of if() statements.  Rather surprisingly,
this decreased code size, as the swap functions were inlined and their
prologue & epilogue code eliminated.

lib/list_sort.c is a bit trickier, as merge sort is already close to
optimal, and we don't want to introduce triumphs of theory over
practicality like the Ford-Johnson merge-insertion sort.

Patch #4, without changing the algorithm, chops 32% off the code size and
removes the part[MAX_LIST_LENGTH+1] pointer array (and the corresponding
upper limit on efficiently sortable input size).

Patch #5 improves the algorithm.  The previous code is already optimal
for power-of-two (or slightly smaller) size inputs, but when the input
size is just over a power of 2, there's a very unbalanced final merge.

There are, in the literature, several algorithms which solve this, but
they all depend on the "breadth-first" merge order which was replaced
by commit 835cc0c8477f with a more cache-friendly "depth-first" order.
Some hard thinking came up with a depth-first algorithm which defers
merges as little as possible while avoiding bad merges.  This saves
0.2*n compares, averaged over all sizes.

The code size increase is minimal (64 bytes on x86-64, reducing the net
savings to 26%), but the comments expanded significantly to document
the clever algorithm.


TESTING NOTES: I have some ugly user-space benchmarking code
which I used for testing before moving this code into the kernel.
Shout if you want a copy.

I'm running this code right now, with CONFIG_TEST_SORT and
CONFIG_TEST_LIST_SORT, but I confess I haven't rebooted since
the last round of minor edits to quell checkpatch.  I figure there
will be at least one round of comments and final testing.

George Spelvin (5):
  lib/sort: Make swap functions more generic
  lib/sort: Use more efficient bottom-up heapsort variant
  lib/sort: Avoid indirect calls to built-in swap
  lib/list_sort: Simplify and remove MAX_LIST_LENGTH_BITS
  lib/list_sort: Optimize number of calls to comparison function

 include/linux/list_sort.h |   1 +
 lib/list_sort.c           | 244 +++++++++++++++++++++++++---------
 lib/sort.c                | 266 +++++++++++++++++++++++++++++---------
 3 files changed, 387 insertions(+), 124 deletions(-)

-- 
2.20.1

