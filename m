Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5608C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 04:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80D1A21871
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 04:33:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbfCOEdg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 00:33:36 -0400
Received: from mx.sdf.org ([205.166.94.20]:54552 "EHLO mx.sdf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727166AbfCOEdf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 00:33:35 -0400
Received: from sdf.org (IDENT:lkml@sdf.lonestar.org [205.166.94.16])
        by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id x2F4XACg004600
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits) verified NO);
        Fri, 15 Mar 2019 04:33:10 GMT
Received: (from lkml@localhost)
        by sdf.org (8.15.2/8.12.8/Submit) id x2F4X9oT024601;
        Fri, 15 Mar 2019 04:33:09 GMT
Date:   Fri, 15 Mar 2019 04:33:09 GMT
From:   George Spelvin <lkml@sdf.org>
Message-Id: <201903150433.x2F4X9oT024601@sdf.org>
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

One question I should ask everyone: should "count" be 32 or 64 bits
on 64-bit machines?  That would let x86 save a few REX bytes.  (815
vs. 813 byte code, if anyone cares.)

Allegedy ARM can save a few pJ by gating the high 32
bits of the ALU.

Most other 64-bit processors would prefer 64-bit operations as
it saves masking operations.

If we never sort a list with more than 2^32 entries, it
makes no difference.

If we use a 32-bit count and we *do* sort a list with more than
2^32 entries, then it still sorts, but the performance degrades to
O((n/2^32)^2).

Just how often do we expect the kernel to face lists that long?
(Note that the old code was O((n/2^20)^2).)

In the code, I could do something like

#ifdef CONFIG_X86_64
/* Comment explaining why */
typedef uint32_t count_t;
#else
typedef size_t count_t;
#endif

...
	count_t count = 0;
