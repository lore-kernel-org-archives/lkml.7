Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8213C282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 20:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5D6B2072E
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 20:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578600496;
	bh=Y+JhywZJPjeZXecNv6LWKNVULGN0f/sEbleKkUvLb1w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=KGaNf59SQUfT1EgMBWlL/CybmU2LZQLGjVOCFJSym7yWnNBiPKHE3l7t/Q9CWKa/5
	 acyPT9BYeWu/4Nu0ofVPwzwGZqWkZpevoWGgmYHtQaY57W5L+etQwyDmCKlXTGkCu3
	 kMfBbxKmcbS9yu2NkO+apkFiyaMEu1fO4mY6+UYY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728689AbgAIUIP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 15:08:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:46716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725763AbgAIUIP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 15:08:15 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C122D20656;
        Thu,  9 Jan 2020 20:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578600495;
        bh=Y+JhywZJPjeZXecNv6LWKNVULGN0f/sEbleKkUvLb1w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cX6JSyGZn0mXYch169n+4g4cnjO5APGEojHZeXATEDi8m+2K2wPQ6TsVDznT+i/w2
         WNmqM9CoCGO+8Tfw97F4DO5aJ+ZhJLnP1fP9z77sn4aN1oAOsAEpH0eA8IYXoYXwZk
         +JC2G8GFHid0QVrvaVe/ZhP5cNI7WYbo9vPOmIjA=
Date:   Thu, 9 Jan 2020 12:08:14 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Yury Norov <yury.norov@gmail.com>,
        linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2 2/2] lib/test_bitmap: Fix address space when test
 user buffer
Message-Id: <20200109120814.27198f300bbe209cdc411fc6@linux-foundation.org>
In-Reply-To: <20200109103601.45929-2-andriy.shevchenko@linux.intel.com>
References: <20200109103601.45929-1-andriy.shevchenko@linux.intel.com>
        <20200109103601.45929-2-andriy.shevchenko@linux.intel.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  9 Jan 2020 12:36:01 +0200 Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Force address space to avoid the following warning:
> 
> lib/test_bitmap.c:461:53: warning: incorrect type in argument 1 (different address spaces)
> lib/test_bitmap.c:461:53:    expected char const [noderef] <asn:1> *ubuf
> lib/test_bitmap.c:461:53:    got char const *in

We did this in

commit 17b6753ff08bc47f50da09f5185849172c598315
Author:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
AuthorDate: Wed Dec 4 16:53:06 2019 -0800
Commit:     Linus Torvalds <torvalds@linux-foundation.org>
CommitDate: Wed Dec 4 19:44:14 2019 -0800

    lib/test_bitmap: force argument of bitmap_parselist_user() to proper address space

> --- a/lib/test_bitmap.c
> +++ b/lib/test_bitmap.c
> @@ -458,7 +458,8 @@ static void __init __test_bitmap_parse(int is_user)
>  
>  			set_fs(KERNEL_DS);
>  			time = ktime_get();
> -			err = bitmap_parse_user(test.in, len, bmap, test.nbits);
> +			err = bitmap_parse_user((__force const char __user *)test.in, len,
> +						bmap, test.nbits);
>  			time = ktime_get() - time;
>  			set_fs(orig_fs);
>  		} else {

Except your tree has `test' where mainline has `ptest'.  I'm not sure
what has happened here?

