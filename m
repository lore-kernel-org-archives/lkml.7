Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE4CC282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 20:43:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D9E420692
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 20:43:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dhHuw8Rj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbgAHUnK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 15:43:10 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:33409 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726667AbgAHUnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 15:43:10 -0500
Received: by mail-qk1-f196.google.com with SMTP id d71so3996159qkc.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 12:43:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+AFPzGUO9SUbYFZEafDP9G9AZJkhroN1Aj3MxjVZ6wk=;
        b=dhHuw8RjaeGj0RwUKlC6LJej4MV9JSs/i1FVa74x3iBEtHqB36DjBh3VvAJsh1j1cS
         RiBW0ZNUSnzAEFrrfnfSPoHimNX9JXkn8NcmFuhb4b/TA7CRynxhkA644uD7Hy+DsKKx
         O4obvy9nQPqq88lwxTApceDaIhwuaNrA/M724vPZS/w053nuvf2JmHvz9vthxrAhchzI
         1svkpSR32lAwjzc+Cf+eGFsawykPdMaM9isGhupJRy/TImfKs8zR/hjTvzyKrUftf0es
         XF+yjemlnVT/SceK17YZ+1RMR/eRVGmYpzkW61OYR6kVX972gMXoxvPXNSncVl9sdV0/
         4tCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+AFPzGUO9SUbYFZEafDP9G9AZJkhroN1Aj3MxjVZ6wk=;
        b=T8DNUgrA2jidp3SfIOFVZdOObYd/ZIjP+EDFPB9tvTKB+6N1FXRsVbK+ydY8SNzOBF
         NqDsLM1SO2klYO/MzgWEMvficKt6Xat3QY9zPj6teQYOXnpKKuKitmGzMaIiz+AUAtxt
         sGvzyiqrJamJYrnLKrimqqX7PGXTLyb1Ck5iBcNlRPQXy9iLGPInkcC31JuCIcoLxYl3
         7vvjUWl7m5IwhU/s9b7AkufNYmPLCU3qK7/PFC+eX7lii9LYR8YxyAZHpWuGI+0kPqal
         0uNZyB2EXJajHaUNOUMzCqdHT7hGwee1OSf7uEkrDLKFwCOB4/o7GL2r1A1iT30gPQ94
         fmNg==
X-Gm-Message-State: APjAAAUo6BQU/3XGX7PToN0/CrHL3fGgdTzI+C52QujtLxaywNjCXBgl
        /TB9BtikJCrvahXEO6HPLESzFWI2
X-Google-Smtp-Source: APXvYqwAweVmQDOgW/7ybu7ym28b+C3wBLYil2dwJH1VWy06dMuRNxqmzWuL5FfWR06dzGs+o/tjcg==
X-Received: by 2002:a05:620a:14a2:: with SMTP id x2mr6283214qkj.36.1578516189060;
        Wed, 08 Jan 2020 12:43:09 -0800 (PST)
Received: from localhost ([2604:2000:4185:2300:6010:98ee:bdb6:667b])
        by smtp.gmail.com with ESMTPSA id p19sm2169333qte.81.2020.01.08.12.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2020 12:43:08 -0800 (PST)
Date:   Wed, 8 Jan 2020 12:43:07 -0800
From:   Yury Norov <yury.norov@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v1 1/2] lib/test_bitmap: Correct test data offsets for
 32-bit
Message-ID: <20200108204307.GC14503@yury-thinkpad>
References: <20200108184611.7065-1-andriy.shevchenko@linux.intel.com>
 <20200108192437.GA13872@yury-thinkpad>
 <20200108202654.GJ32742@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200108202654.GJ32742@smile.fi.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 08, 2020 at 10:26:54PM +0200, Andy Shevchenko wrote:
> On Wed, Jan 08, 2020 at 11:24:37AM -0800, Yury Norov wrote:
> > On Wed, Jan 08, 2020 at 08:46:10PM +0200, Andy Shevchenko wrote:
> > > On 32-bit platform the size of long is only 32 bits which makes wrong offset
> > > in the array of 64 bit size.
> > > 
> > > Calculate offset based on BITS_PER_LONG.
> > > 
> > > Fixes: 30544ed5de43 ("lib/bitmap: introduce bitmap_replace() helper")
> > > Reported-by: Guenter Roeck <linux@roeck-us.net>
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> > >  	unsigned int nbits = 64;
> > > +	unsigned int step = DIV_ROUND_UP(nbits, BITS_PER_LONG);
> > 
> > Step is already defined in this file:
> >         #define step (sizeof(u64) / sizeof(unsigned long))
> 
> ...and later undefined.
> 
> > to avoid the same problem in other test cases. Introducing another variant of 
> > it looks messy.
> 
> I don't see any problem.

The problem is that you reimplement the functionality instead of
reuse.
 
> > >  	DECLARE_BITMAP(bmap, 1024);
> > >  
> > >  	bitmap_zero(bmap, 1024);
> > > -	bitmap_replace(bmap, &exp2[0], &exp2[1], exp2_to_exp3_mask, nbits);
> > > +	bitmap_replace(bmap, &exp2[0 * step], &exp2[1 * step], exp2_to_exp3_mask, nbits);
> > >  	expect_eq_bitmap(bmap, exp3_0_1, nbits);
> > 
> > If nbits is always 64, why don't you pass 64 directly?
> 
> We may use any setting. For now it's 64, but nothing prevents us to extend to,
> let's say, 75.
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
