Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2577CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 09:42:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB1DE2087C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 09:42:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbfCNJl7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 05:41:59 -0400
Received: from mx.sdf.org ([205.166.94.20]:56252 "EHLO mx.sdf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726628AbfCNJl7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 05:41:59 -0400
Received: from sdf.org (IDENT:lkml@sdf.lonestar.org [205.166.94.16])
        by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id x2E9ffC2017873
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits) verified NO);
        Thu, 14 Mar 2019 09:41:41 GMT
Received: (from lkml@localhost)
        by sdf.org (8.15.2/8.12.8/Submit) id x2E9ffkx024340;
        Thu, 14 Mar 2019 09:41:41 GMT
Date:   Thu, 14 Mar 2019 09:41:41 GMT
From:   George Spelvin <lkml@sdf.org>
Message-Id: <201903140941.x2E9ffkx024340@sdf.org>
To:     andriy.shevchenko@linux.intel.com, lkml@sdf.org
Subject: Re: [PATCH 4/5] lib/list_sort: Simplify and remove MAX_LIST_LENGTH_BITS
Cc:     akpm@linux-foundation.org, daniel.wagner@siemens.com,
        dchinner@redhat.com, don.mullis@gmail.com, geert@linux-m68k.org,
        linux-kernel@vger.kernel.org, linux@rasmusvillemoes.dk,
        st5pub@yandex.ru
In-Reply-To: <20190314091041.GU9224@smile.fi.intel.com>
References: <cover.1552097842.git.lkml@sdf.org>,
    <dd447448384883bd42c41f0de6a83430b6435dc1.1552097842.git.lkml@sdf.org>,
    <20190314091041.GU9224@smile.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Mar 2019 at 11:10:41 +0200, Andy Shevchenko wrote:
> On Tue, Mar 05, 2019 at 03:06:44AM +0000, George Spelvin wrote:
>> +		/* Do merges corresponding to set lsbits in count */
>
>> +		for (bit = 1; count & bit; bit <<= 1) {
>> +			cur = merge(priv, (cmp_func)cmp, pending, cur);
>> +			pending = pending->prev;  /* Untouched by merge() */
>>  		}
>
> Wouldn't be it the same to
>
> 	bit = ffz(count);
> 	while (bit--) {
> 		...
> 	}
> ?
>
> Though I dunno which one is generating better code.

Yes, it's the same.  But count is an incrementing counter, so the
pattern of return values from ffz() is 01020103010201040102010301020105...,
which has mean value 1/2 + 1/4 + 1/8 + 1/16 +... = 1.

So spending one instruction on ffz() to save one instruction per loop
iteration is an even trade, and if the processor doesn't have an ffz()
instruction, it's a loss.

There's a third possible implementation:

>> +		for (bit = count; bit & 1; bit >>= 1) {

...which works fine, too.  (It even saves a few bytes of code, so I
might switch to it.)  I used the form I did because my test code
verified that the length of the lists being merged equalled "bit".

The other forms don't have that property.


Thank you for looking at the code!
