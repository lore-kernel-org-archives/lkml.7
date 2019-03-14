Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0B27C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 11:55:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A765B20693
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 11:55:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727309AbfCNLzG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 07:55:06 -0400
Received: from ol.sdf.org ([205.166.94.20]:55367 "EHLO mx.sdf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726809AbfCNLzG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 07:55:06 -0400
Received: from sdf.org (IDENT:lkml@sdf.lonestar.org [205.166.94.16])
        by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id x2EBrunI018367
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits) verified NO);
        Thu, 14 Mar 2019 11:53:56 GMT
Received: (from lkml@localhost)
        by sdf.org (8.15.2/8.12.8/Submit) id x2EBrtKi000133;
        Thu, 14 Mar 2019 11:53:55 GMT
Date:   Thu, 14 Mar 2019 11:53:55 GMT
From:   George Spelvin <lkml@sdf.org>
Message-Id: <201903141153.x2EBrtKi000133@sdf.org>
To:     geert@linux-m68k.org, lkml@sdf.org
Subject: Re: [PATCH 1/5] lib/sort: Make swap functions more generic
Cc:     13@sdf.org, akpm@linux-foundation.org,
        andriy.shevchenko@linux.intel.com, daniel.wagner@siemens.com,
        dchinner@redhat.com, don.mullis@gmail.com,
        linux-kernel@vger.kernel.org, linux@rasmusvillemoes.dk,
        st5pub@yandex.ru
In-Reply-To: <CAMuHMdW0jd-oNtgBf=aHfzVoBbVh0OJYC6ELhDv3VrcGwUECwA@mail.gmail.com>
References: <cover.1552097842.git.lkml@sdf.org>,
    <dc6cc09e71f8687ff2ef4cbfc2b11accc9aba8aa.1552097842.git.lkml@sdf.org>,
    <20190309140653.GO9224@smile.fi.intel.com>,
    <201903091553.x29FrfMR018600@sdf.org>,
    <20190314092958.GV9224@smile.fi.intel.com>,
    <201903141009.x2EA9q1Z025888@sdf.org>,
    <CAMuHMdW0jd-oNtgBf=aHfzVoBbVh0OJYC6ELhDv3VrcGwUECwA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Mar 2019 at 11:41:26 +0100, Geert Uytterhoeven wrote:
> On Thu, Mar 14, 2019 at 11:10 AM George Spelvin <lkml@sdf.org> wrote:
>> On Sat, 09 Mar 2019 at 23:19:49 +0300, Andrey Abramov wrote:
>>>> How about one of:
>>>> swap_bytes / swap_ints / swap_longs
>>>> swap_1 / swap_4 / swap_8
>>>
>>> longs are ambiguous, so I would prefer bit-sized types.
>>
>> I already implemented Andrey's suggestions, which were the exact
>> opposite of yours.
>>
>> Pistols at dawn?

I didn't explain the joke because jokes aren't funny if explained,
but just in case, by suggesting a clearly ridiculous method, I was
saying "I have no idea how to resolve this conflict."

> Prepared to fix all future long vs. int bugs?

In the entire kernel?  Or just the one small source file
where these statically scoped helper functions are visible?

In case of uncertainty, the comments and the code are right there
just a few lines away from the one and only call site, so I
don't expect much confusion.

I care a lot about function names when they are exported, but in
this case we're talking about what colour to paint the *inside* of
the bike shed.

I just want to pick some names and move on.  Since nothing so far seems
satsify everyone, I'll go with the ponderous but utterly unambiguous:

swap_bytes
swap_4byte_words
swap_8byte_words
