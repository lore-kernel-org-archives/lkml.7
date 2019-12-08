Return-Path: <SRS0=RGqN=Z6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A7F2C43603
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 08:07:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10509206D6
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 08:07:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbfLHIH2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Dec 2019 03:07:28 -0500
Received: from mx.sdf.org ([205.166.94.20]:54683 "EHLO mx.sdf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbfLHIH2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Dec 2019 03:07:28 -0500
X-Greylist: delayed 325 seconds by postgrey-1.27 at vger.kernel.org; Sun, 08 Dec 2019 03:07:27 EST
Received: from sdf.org (IDENT:lkml@sdf.lonestar.org [205.166.94.16])
        by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id xB881T8t023432
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits) verified NO);
        Sun, 8 Dec 2019 08:01:29 GMT
Received: (from lkml@localhost)
        by sdf.org (8.15.2/8.12.8/Submit) id xB881RO2001774;
        Sun, 8 Dec 2019 08:01:27 GMT
Date:   Sun, 8 Dec 2019 08:01:27 GMT
From:   George Spelvin <lkml@sdf.org>
Message-Id: <201912080801.xB881RO2001774@sdf.org>
To:     linux-kernel@vger.kernel.org, linux@rasmusvillemoes.dk,
        lkml@sdf.org
Subject: Re: [PATCH 5/5] lib/list_sort: Optimize number of calls to comparison function
Cc:     akpm@linux-foundation.org, andriy.shevchenko@linux.intel.com,
        daniel.wagner@siemens.com, dchinner@redhat.com,
        don.mullis@gmail.com, geert@linux-m68k.org, st5pub@yandex.ru
In-Reply-To: <ee4312b3-ed26-2a78-de26-1907c38a5e4b@rasmusvillemoes.dk>
References: <cover.1552097842.git.lkml@sdf.org>,
    <b36187f091acc1b3a8fc1fc3e9dbb6eca56231a9.1552097842.git.lkml@sdf.org>,
    <dd8924c1-07a9-4317-bfa8-23271b138a62@rasmusvillemoes.dk>,
    <201903140158.x2E1wgFQ018649@sdf.org>,
    <ee4312b3-ed26-2a78-de26-1907c38a5e4b@rasmusvillemoes.dk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Jun 2019 at 01:12:01, Rasmus Villemoes wrote:
> On 14/03/2019 02.58, George Spelvin wrote:
>> On Thu, 14 Mar 2019 at 00:28:16 +0100, Rasmus Villemoes wrote:
> 
>>> Similarly one could do a SORT_SIMPLE_CMP() for when sorting an array of
>>> structs according to a single numeric member. That sort is not stable,
>>> so the comparison functions would have to do a full -1,0,1 return, of
>>> course, but we'd still avoid indirect calls.
>> 
>> Actually, while some sorts (notably fat-pivot quicksort) require
>> a 3-way return to avoid O(n^2) performance, heapsort is just fine
>> with a boolean return value. 
> 
> Hi George
> 
> So I tried starting to implement this, and the timing results look
> promising. However, currently I'm doing
> 
>   (*(u32*)ka > *(u32*)kb) - (*(u32*)ka < *(u32*)kb);
> 
> in my do_cmp. Both existing invocations of the comparison function in
> sort.c compare its return value >= 0, which is always true if I just
> return the boolean (*(u32*)ka > *(u32*)kb). So it seems the algorithm
> would have to be changed to allow the cmp function to return a bool.
> Perhaps it's as simple as changing the two >= to >, but can I get you to
> check that that would be ok? (Quick testing seems to suggest so, but
> it's possible there are some corner cases where it would break.)

The only reason for >= vs. > is to do less work in the == case.

(I prefer to stay in the first backtracking loop, which does no
data motion, and therby reduce the number of swaps performed in
the second part of the backtracking.)

If you want to preserve the logic exactly, you can replace
"do_cmp(a, b, ...) >= 0" with "do_cmp(b, a, ...) <= 0" and then
the conversion is straightforward.
