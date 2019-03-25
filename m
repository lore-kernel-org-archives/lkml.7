Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30332C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 00:28:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDC0620870
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 00:28:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729217AbfCYA2S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 20:28:18 -0400
Received: from ol.sdf.org ([205.166.94.20]:58438 "EHLO mx.sdf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729149AbfCYA2S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 20:28:18 -0400
Received: from sdf.org (IDENT:lkml@sdf.lonestar.org [205.166.94.16])
        by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id x2P0SD4i014183
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits) verified NO);
        Mon, 25 Mar 2019 00:28:13 GMT
Received: (from lkml@localhost)
        by sdf.org (8.15.2/8.12.8/Submit) id x2P0SDH3026861;
        Mon, 25 Mar 2019 00:28:13 GMT
Date:   Mon, 25 Mar 2019 00:28:13 GMT
From:   George Spelvin <lkml@sdf.org>
Message-Id: <201903250028.x2P0SDH3026861@sdf.org>
To:     Jason@zx2c4.com, lkml@sdf.org
Subject: Re: [RFC PATCH] random: add get_random_max() function
Cc:     linux-kernel@vger.kernel.org, tytso@mit.edu
In-Reply-To: <CAHmME9p3TR6ESekKRQxFsfQe3rZp7T4-4WLOn-SL98zUnAo2DQ@mail.gmail.com>
References: <201903241244.x2OCiL8P011277@sdf.org>,
    <CAHmME9p3TR6ESekKRQxFsfQe3rZp7T4-4WLOn-SL98zUnAo2DQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Mar 2019 at 21:47:50 +0100, Jason A. Donenfeld wrote:
> I generally use a slightly simpler algorithm in various different projects:
> 
> //[0, bound)
> static unsigned long random_bounded(unsigned long bound)
> {
>        unsigned long ret;
>        const unsigned long max_mod_bound = (1 + ~bound) % bound;
> 
>        if (bound < 2)
>                return 0;
>        do
>                ret = random_integer();
>        while (ret < max_mod_bound);
>        return ret % bound;
> }
>
> Is the motivation behind using Lemire that you avoid the division (via
> the modulo) in favor of a multiplication?

Yes.  If we define eps = max_mod_bound * ldexp(1.0, -BITS_PER_LONG) as
the probability of one retry, and retries = eps / (1 - eps) as the
expected number of retries, then both algorithms take 1+retries
random_integer()s.

The above agorithm takes 2 divisions, always.  Divides are slow, and
usually not pipelined, so two in short succession gets a latency penalty.

Lemire's mutiplicative algorithm takes 1 multiplication on the fast
path (probability 1 - 2*eps on average), 1 additional division on the slow
path (probability 2*eps), and 1 multiplication per retry.

In the common case when bound is much less than ULONG_MAX, eps is
tiny and the fast path is taken almost all the time, and it's
a huge win.

Even in the absolute worst case of bound = ULONG_MAX/2 + 2 when
eps ~ 0.5 (2 multiplies, 0.5 divide; there's no 2*eps penalty in
this case), it's faster as long as 2 mutiplies cost less than 1.5
divides.

I you want simpler code, we could omit the fast path and stil get
a speedup.  But a predictable branch for a divide seemed like
a worthwhile trade.


(FYI, this all came about as a side project of a kernel-janitor project
to replace "prandom_u32() % range" by "prandom_u32() * range >> 32".
I'm also annoyed that get_random_u32() and get_random_u64() have
separate buffers, even if EFFICIENT_UNALIGNED_ACCESS, but that's
a separate complaint.)
