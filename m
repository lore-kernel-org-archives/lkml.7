Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 345FFC282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 19:24:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC6372067D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 19:24:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iW2/jR5d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729951AbgAHTYl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 14:24:41 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:37547 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727782AbgAHTYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 14:24:40 -0500
Received: by mail-qt1-f193.google.com with SMTP id w47so3743060qtk.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 11:24:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8irOKixnHUMATLKrZUUwWSNZ8XX3xSu9yB+BpQUFjE8=;
        b=iW2/jR5dxFDBmnIVg2tzJ44rV58PfMnhB1MlmOvmeBTyamz5rYMkh4NHVJE9PaTjPq
         hyFZHQFnPq4MWZjq8z1KGdaTbD4lh0no0Fax+RyP1wQJ44yUT30y8Ffnp1NT9eExSW3P
         hHcZk0FGKeeWVKsKZHhj20a0D82R+YOGdJhaWSMiyRYKb9MrTvYY8K60LQ4czmmlChbm
         lpjCUJrLChTImFwz5WbPUC733xSYat3qNIXNpa6oV+v4ifaKcr/n0uQr5ItbLXcyD1E3
         HfkwmyF+GkCyeNqlYffsl7gkU5N/PTCTArEqE9AltE8B0+CyjxoY7vTq7T5IL7EpFOGM
         iybQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8irOKixnHUMATLKrZUUwWSNZ8XX3xSu9yB+BpQUFjE8=;
        b=goboIJHBbQP1Ga1PEzCgasn3RKsK/z7W1FJS80GTiDXOHw92atH/2FaJTEq+m68k84
         rQFFa8Fsqe9gKzCtcZdyD6IT7tsINCbFo0iZiWEasXqL7bgiK8nqNY0l/YhR1C/rt1CN
         rH9jLYh8dYYUdHTkXP4QK87VNgMRS2ne0/686jewYaZMES+tbw1+bteUWZDX6oKah/9d
         vr/t2niYt6KoutsdlyuSCGAZUoyPdIfY3H18UZTJ/WGWtOvLdl3byvD8eYmuul8CIw8a
         vC8Xpfm+OUru2Qd6/cy9nYPQT90J6SjEKDqTHWT+dfBfljZVr9qkAn4/5zYDLSEQ8EwQ
         xcqw==
X-Gm-Message-State: APjAAAUpCDk5grQ63brQ9AaUEpccaeHqsB1iuovs44X7Oqf2mXS5HX7p
        rWqFJP6jzL4cAKI6Wkx1+tNyOXpT
X-Google-Smtp-Source: APXvYqwtylhmZIJZacTvn7gGxJYUz5VzEMPPSlYPGm/v+7SlzZKUajNHZ8yFejzyUZCv0INZ54BOLA==
X-Received: by 2002:ac8:6ec5:: with SMTP id f5mr4940252qtv.137.1578511479602;
        Wed, 08 Jan 2020 11:24:39 -0800 (PST)
Received: from localhost ([2604:2000:4185:2300:6010:98ee:bdb6:667b])
        by smtp.gmail.com with ESMTPSA id v7sm2150055qtk.89.2020.01.08.11.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2020 11:24:38 -0800 (PST)
Date:   Wed, 8 Jan 2020 11:24:37 -0800
From:   Yury Norov <yury.norov@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v1 1/2] lib/test_bitmap: Correct test data offsets for
 32-bit
Message-ID: <20200108192437.GA13872@yury-thinkpad>
References: <20200108184611.7065-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200108184611.7065-1-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 08, 2020 at 08:46:10PM +0200, Andy Shevchenko wrote:
> On 32-bit platform the size of long is only 32 bits which makes wrong offset
> in the array of 64 bit size.
> 
> Calculate offset based on BITS_PER_LONG.
> 
> Fixes: 30544ed5de43 ("lib/bitmap: introduce bitmap_replace() helper")
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  lib/test_bitmap.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
> index 5cb35a734462..af522577a76e 100644
> --- a/lib/test_bitmap.c
> +++ b/lib/test_bitmap.c
> @@ -275,22 +275,23 @@ static void __init test_copy(void)
>  static void __init test_replace(void)
>  {
>  	unsigned int nbits = 64;
> +	unsigned int step = DIV_ROUND_UP(nbits, BITS_PER_LONG);

Step is already defined in this file:
        #define step (sizeof(u64) / sizeof(unsigned long))
to avoid the same problem in other test cases. Introducing another variant of 
it looks messy.

>  	DECLARE_BITMAP(bmap, 1024);
>  
>  	bitmap_zero(bmap, 1024);
> -	bitmap_replace(bmap, &exp2[0], &exp2[1], exp2_to_exp3_mask, nbits);
> +	bitmap_replace(bmap, &exp2[0 * step], &exp2[1 * step], exp2_to_exp3_mask, nbits);
>  	expect_eq_bitmap(bmap, exp3_0_1, nbits);

If nbits is always 64, why don't you pass 64 directly?

Yury

>  	bitmap_zero(bmap, 1024);
> -	bitmap_replace(bmap, &exp2[1], &exp2[0], exp2_to_exp3_mask, nbits);
> +	bitmap_replace(bmap, &exp2[1 * step], &exp2[0 * step], exp2_to_exp3_mask, nbits);
>  	expect_eq_bitmap(bmap, exp3_1_0, nbits);
>  
>  	bitmap_fill(bmap, 1024);
> -	bitmap_replace(bmap, &exp2[0], &exp2[1], exp2_to_exp3_mask, nbits);
> +	bitmap_replace(bmap, &exp2[0 * step], &exp2[1 * step], exp2_to_exp3_mask, nbits);
>  	expect_eq_bitmap(bmap, exp3_0_1, nbits);
>  
>  	bitmap_fill(bmap, 1024);
> -	bitmap_replace(bmap, &exp2[1], &exp2[0], exp2_to_exp3_mask, nbits);
> +	bitmap_replace(bmap, &exp2[1 * step], &exp2[0 * step], exp2_to_exp3_mask, nbits);
>  	expect_eq_bitmap(bmap, exp3_1_0, nbits);
>  }
>  
> -- 
> 2.24.1
