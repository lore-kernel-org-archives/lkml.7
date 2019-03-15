Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0A06C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 03:36:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83C572186A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 03:36:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbfCODgo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 23:36:44 -0400
Received: from mx.sdf.org ([205.166.94.20]:51241 "EHLO mx.sdf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726708AbfCODgn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 23:36:43 -0400
Received: from sdf.org (IDENT:lkml@sdf.lonestar.org [205.166.94.16])
        by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id x2F3ZVwU004274
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits) verified NO);
        Fri, 15 Mar 2019 03:35:31 GMT
Received: (from lkml@localhost)
        by sdf.org (8.15.2/8.12.8/Submit) id x2F3ZUgS024157;
        Fri, 15 Mar 2019 03:35:30 GMT
Date:   Fri, 15 Mar 2019 03:35:30 GMT
From:   George Spelvin <lkml@sdf.org>
Message-Id: <201903150335.x2F3ZUgS024157@sdf.org>
To:     andriy.shevchenko@linux.intel.com, lkml@sdf.org, st5pub@yandex.ru
Subject: Re: [PATCH 1/5] lib/sort: Make swap functions more generic
Cc:     akpm@linux-foundation.org, daniel.wagner@siemens.com,
        dchinner@redhat.com, don.mullis@gmail.com, geert@linux-m68k.org,
        linux-kernel@vger.kernel.org, linux@rasmusvillemoes.dk
In-Reply-To: <1145741552593595@sas2-2074c606c35d.qloud-c.yandex.net>
References: <cover.1552097842.git.lkml@sdf.org>,
    <dc6cc09e71f8687ff2ef4cbfc2b11accc9aba8aa.1552097842.git.lkml@sdf.org>,
    <20190309140653.GO9224@smile.fi.intel.com>,
    <201903091553.x29FrfMR018600@sdf.org>,
    <20190314092958.GV9224@smile.fi.intel.com>,
    <201903141009.x2EA9q1Z025888@sdf.org>,
    <CAMuHMdW0jd-oNtgBf=aHfzVoBbVh0OJYC6ELhDv3VrcGwUECwA@mail.gmail.com>,
    <201903141153.x2EBrtKi000133@sdf.org>,
    <20190314121811.GY9224@smile.fi.intel.com>,
    <1145741552593595@sas2-2074c606c35d.qloud-c.yandex.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> swap_bytes / swap_4byte_words / swap_8byte_words
>> swap_bytes / swap_ints / swap_longs
>> swap_1 / swap_4 / swap_8
>> Pistols at dawn?

On Thu, 14 Mar 2019 at 22:59:55 +0300, Andrey Abramov wrote:
> Yes, in my opinion, swap_bytes / swap_ints / swap_longs are the
> most readable because we have both swap_ints and swap_longs functions
> (in one file near each other), so I don't think that there will be
> any confusion about size.

Yes, that's what I thought.  They're three related but different
functions, suffixed _bytes, _ints, and _longs.  What could the
difference possibly be?  And if anyone has any lingering doubts,
the functions are right there, with exquisitely clear comments.

No to mention where they're used.  Is "is_aligned(base, size, 8)"
remotely obscure?  Especially in context:

		if (is_aligned(base, size, 8))
			swap_func = swap_longs;
		else if (is_aligned(base, size, 4))
			swap_func = swap_ints;
		else
			swap_func = swap_bytes;

What subtle and mysterious code.

> But actually, it doesn't matter which name will you take, because
> the meaning of each, in my opinion, is obvious enough, so I don't
> mind about any of these options.

I'm just amazed that this piece of bikeshedding is the most
contentious thing about the patch series.

I mean, if I'd named them:
	llanfairpwllgwyngyll()
	shravanabelagola()
	zheleznodorozhny()
or
	peckish()
	esuriant()
	hungry()
then yes, those would be bad names.

I prefer the shorter _ints and _longs names, but this is just
not a hill I want to die on.
