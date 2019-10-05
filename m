Return-Path: <SRS0=6Pxm=X6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BD72C4740A
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 21:48:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D2C3222CB
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 21:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570312113;
	bh=HNhRg9C+uT8munplm6gItEmqRk2fzoMeetuPUipn458=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=RRYO2UuICQd1DUr5+N0q3iVuLOGrkgDKiXq2QtV5DjGBCPE9k5usvosRrRmncmNRt
	 jCZlV06KZZkpd8r6uXy7QFCdKD7xf3uxNI1fvOsvf1WwRh2+laoZHezYiuEASFevId
	 gljw63JJxvLNf/FAKeT6grvvnyEOguXfYR1hHWgU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726034AbfJEVsc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Oct 2019 17:48:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:40674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725801AbfJEVsc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 17:48:32 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 494D0222C0;
        Sat,  5 Oct 2019 21:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570312111;
        bh=HNhRg9C+uT8munplm6gItEmqRk2fzoMeetuPUipn458=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=09sGzm+TkX4yptOvFcUZkbVIfYJVinR8FNqinr3BNuPCm9QnXgBl25ss/I51or6+n
         dRjZCJYRrB9O7ZgSvm/k/Yca6R4Vzq6Hfk2pmpWSeYNfMan5hE+i4HKKh8zpVGNvY2
         djLeN5GjdXIwt/0F+3LNDkESxOLCJdgIJLWz4fS8=
Date:   Sat, 5 Oct 2019 14:48:30 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Joe Perches <joe@perches.com>, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>,
        linux-doc@vger.kernel.org, Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v3] printf: add support for printing symbolic error
 codes
Message-Id: <20191005144830.f94bc9d63001981c5eefe875@linux-foundation.org>
In-Reply-To: <20190917065959.5560-1-linux@rasmusvillemoes.dk>
References: <20190909203826.22263-1-linux@rasmusvillemoes.dk>
        <20190917065959.5560-1-linux@rasmusvillemoes.dk>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Sep 2019 08:59:59 +0200 Rasmus Villemoes <linux@rasmusvillemoes.dk> wrote:

> It has been suggested several times to extend vsnprintf() to be able
> to convert the numeric value of ENOSPC to print "ENOSPC". This is yet
> another attempt. Rather than adding another %p extension, simply teach
> plain %p to convert ERR_PTRs. While the primary use case is
> 
>   if (IS_ERR(foo)) {
>     pr_err("Sorry, can't do that: %p\n", foo);
>     return PTR_ERR(foo);
>   }
> 
> it is also more helpful to get a symbolic error code (or, worst case,
> a decimal number) in case an ERR_PTR is accidentally passed to some
> %p<something>, rather than the (efault) that check_pointer() would
> result in.
> 
> With my embedded hat on, I've made it possible to remove this.
> 
> I've tested that the #ifdeffery in errcode.c is sufficient to make
> this compile on arm, arm64, mips, powerpc, s390, x86 - I'm sure the
> 0day bot will tell me which ones I've missed.
> 
> The symbols to include have been found by massaging the output of
> 
>   find arch include -iname 'errno*.h' | xargs grep -E 'define\s*E'
> 
> In the cases where some common aliasing exists
> (e.g. EAGAIN=EWOULDBLOCK on all platforms, EDEADLOCK=EDEADLK on most),
> I've moved the more popular one (in terms of 'git grep -w Efoo | wc)
> to the bottom so that one takes precedence.

Looks reasonable to me.

Is there any existing kernel code which presently uses this?  Can we
get some conversions done to demonstrate and hopefully test the
feature?

