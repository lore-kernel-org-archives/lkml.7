Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07103C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 19:42:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD12F2085A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 19:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561491765;
	bh=rnIbqwj/usshwkoKpQu2uh4UEE0YmQH9oiXkATZ0dNU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=mLDBDItmaPI6Lvg+Q8ZNqJ9+4EO6zu6qUDWC+n+tVzxCOOpfO9SZQii9JRnZS+wnU
	 FHSb0bBLjABQ9HNbLbpc+ZBdafAlBkjyKK1ND/ceDl4y/DgZGgpq2hHUBZ9RF3awaK
	 +MaNfZnm1ACB+F76W4PSUxPgqO3xNgdUKG5/nzyg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727896AbfFYTmn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 15:42:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:49570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727579AbfFYTmn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 15:42:43 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF460204FD;
        Tue, 25 Jun 2019 19:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561491762;
        bh=rnIbqwj/usshwkoKpQu2uh4UEE0YmQH9oiXkATZ0dNU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NBI714jRTbnZZD1qWzAqnrLmRuOYUzFtN/XrbYjYJetiy8f7JDhC4xHdyjcLLH2UG
         bjAOY7VM3gtioo7KoEEi/vbBP1EVc1sdaHK7Zk3YH+nDAIGu4nmhRELdJAe01032WS
         1+MzZHWDKiBMdIQp8a9XrIaXbQMwmv/VqR9KwT5Q=
Date:   Tue, 25 Jun 2019 12:42:41 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        alexander.shishkin@linux.intel.com, ndesaulniers@google.com
Subject: Re: [PATCH][V4] lib: fix __sysfs_match_string() helper when n != -1
Message-Id: <20190625124241.8b963a256ebaa056d489bb15@linux-foundation.org>
In-Reply-To: <20190625132812.GB9224@smile.fi.intel.com>
References: <20190508111913.7276-1-alexandru.ardelean@analog.com>
        <20190625130104.29904-1-alexandru.ardelean@analog.com>
        <20190625132812.GB9224@smile.fi.intel.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jun 2019 16:28:12 +0300 Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Tue, Jun 25, 2019 at 04:01:04PM +0300, Alexandru Ardelean wrote:
> > The documentation the `__sysfs_match_string()` helper mentions that `n`
> > (the size of the given array) should be:
> >  * @n: number of strings in the array or -1 for NULL terminated arrays
> > 
> > The behavior of the function is different, in the sense that it exits on
> > the first NULL element in the array.
> > 
> > This patch changes the behavior, to exit the loop when a NULL element is
> > found, and the size of the array is provided as -1.
> > 
> > All current users of __sysfs_match_string() & sysfs_match_string() provide
> > contiguous arrays of strings, so this behavior change doesn't influence
> > anything (at this point in time).
> > 
> > This behavior change allows for an array of strings to have NULL elements
> > within the array, which will be ignored. This is particularly useful when
> > creating mapping of strings and integers (as bitfields or other HW
> > description).
> 
> Since it does nothing for current users and comes without an example,
> it's hard to justify the need.

Presumably "split this patch away from series" means there's some code
which uses this.  A reference to this in the changelog would be good.

> The code itself looks good to me.

Sure.  But the kerneldoc description of __sysfs_match_string() could do
with an update.


