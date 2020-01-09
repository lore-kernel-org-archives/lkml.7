Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0009C282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 23:00:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B60B2072E
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 23:00:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KfSTw+9N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728848AbgAIXAX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 18:00:23 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37690 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbgAIXAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 18:00:23 -0500
Received: by mail-pl1-f194.google.com with SMTP id c23so61813plz.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 15:00:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ygLLyrVHh5h7nOwhV8Xg8UE4z+ax+T0Fe7V+CAv7gRY=;
        b=KfSTw+9NA8VyKbeM4bqaookGZqqOTyYcJsKsTHkDkGsBkDmXnux4mFkBW3X0Cytl09
         y5lKLQuTGhGFPyaTid6p02kfmux0nfQjc9xbPdt0jfJjUZGDj72s8huPszOfMcsFxC19
         OnwVvYhf6hPLQ1qCr7IUlyPYu62jq1HgD7PgN4VWAbZ3FTKhvqpW2emPxRYsM2rsGa3Y
         NKRPPbzA9t11Zbs8ZCXAR3ccL4TT9VNBneI9iDsNeJh1Y0HcTvfAmHe7TU+Bd9hin7uF
         kAmf97xaQrJhsIkrb/y8FKHZ2IvXFuGRnySi52iXgpsgg44LD9wI4A47XUR/x/eeNdjJ
         kcJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ygLLyrVHh5h7nOwhV8Xg8UE4z+ax+T0Fe7V+CAv7gRY=;
        b=c/LkMui0KHhLZpQMTKRGAtWcl41G4qBFT2mZLsINAWOXtJPbWqm9RLft58ZHkLFd+m
         F+HJ6ktAKU/413z+bim6CUhRMC38zqY41LFaNfbbHNJyBJzmoZwyoyzgK5ztVUYSrb/B
         3tSw9y6x9WyfH2cU3B61GW2nmbexOhzA9qU+m3Z3aA3SV43AvjftFKdfQW2gcGUlFvqs
         MWgqw4/KkHB8LGC5Iel8tD02swweMnbvNklx5NVEgQx/OrCaf0URsC3NSRj4djWTBj0u
         7HPraAQojYqCm4cioP8/RROjc514NURCowRruLcPhRjCjH6dh3CQTcYsxiwwUdX0JLNi
         QqCw==
X-Gm-Message-State: APjAAAUqeWQh81XvFmIoVSCRGF/7lWV7xipH7A/lvNtAUuzPHFbBROK6
        kQIl/yQSjlCvgAMxgcbMzFI=
X-Google-Smtp-Source: APXvYqy3XWVhD0YQurHeHr5+sMLB+1eF4zETXFSqHZ1ZYH7cczDxQjitXWjZdiZ3ffc3HYfSbUvesg==
X-Received: by 2002:a17:902:bf09:: with SMTP id bi9mr460555plb.78.1578610822444;
        Thu, 09 Jan 2020 15:00:22 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w131sm97595pfc.16.2020.01.09.15.00.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Jan 2020 15:00:21 -0800 (PST)
Date:   Thu, 9 Jan 2020 15:00:19 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Yury Norov <yury.norov@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] lib/test_bitmap: Fix address space when test user
 buffer
Message-ID: <20200109230019.GA5938@roeck-us.net>
References: <20200109103601.45929-1-andriy.shevchenko@linux.intel.com>
 <20200109103601.45929-2-andriy.shevchenko@linux.intel.com>
 <20200109120814.27198f300bbe209cdc411fc6@linux-foundation.org>
 <CAHp75Vd6JLjPfrA4f2ugwfiZS3fBSxN48ja7OjnZ4s_pqWJZng@mail.gmail.com>
 <20200109135253.ab86a6a61899221e1e4609fa@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200109135253.ab86a6a61899221e1e4609fa@linux-foundation.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 09, 2020 at 01:52:53PM -0800, Andrew Morton wrote:
> On Thu, 9 Jan 2020 23:04:59 +0200 Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> 
> > On Thu, Jan 9, 2020 at 10:53 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> > >
> > > On Thu,  9 Jan 2020 12:36:01 +0200 Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > >
> > > > Force address space to avoid the following warning:
> > > >
> > > > lib/test_bitmap.c:461:53: warning: incorrect type in argument 1 (different address spaces)
> > > > lib/test_bitmap.c:461:53:    expected char const [noderef] <asn:1> *ubuf
> > > > lib/test_bitmap.c:461:53:    got char const *in
> > >
> > > We did this in
> > >
> > > commit 17b6753ff08bc47f50da09f5185849172c598315
> > > Author:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > AuthorDate: Wed Dec 4 16:53:06 2019 -0800
> > > Commit:     Linus Torvalds <torvalds@linux-foundation.org>
> > > CommitDate: Wed Dec 4 19:44:14 2019 -0800
> > >
> > >     lib/test_bitmap: force argument of bitmap_parselist_user() to proper address space
> > 
> > This is for "parseLIST", while new patch for "parse".
> 
> Oh.  This is a fix against the mm patch
> lib-add-test-for-bitmap_parse.patch.  Please tell us such things!
> 
> But [patch 1/2] is applicable to current mainline, yes?
> 
Yes

Guenter
