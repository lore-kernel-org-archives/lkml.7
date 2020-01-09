Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48393C282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 21:52:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B23F2077B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 21:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578606777;
	bh=5DLp22CF09LQRKU0FnyC64xSySF0nuhuN4RHkiJDXlY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=rGOrz6AKEOAoA4QSotYIdI9GMdZ5WwNoK+8bA0Nd7czrsUSU20IVuW/WfkItcBR5p
	 30OUajErJZ7zLr5I4FW5HyXw8kHJH/a/hc/GE49cIG6f3aJR6pcpKSfUBJYrrHZo2L
	 1D03gD73yb+mJEfde65nC8T6jzy5wB3fopUPQcvc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728991AbgAIVwz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 16:52:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:46438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728964AbgAIVwz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 16:52:55 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8CCAF20656;
        Thu,  9 Jan 2020 21:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578606774;
        bh=5DLp22CF09LQRKU0FnyC64xSySF0nuhuN4RHkiJDXlY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZR2jtD5xs/KVPW1T8tyMlTsZ8ZLmGaFmSQMZexBljczcSJGEeu6+haWvStCBfoebT
         2aGMmjSAexn6V4O90W23FcXhVbYuYxS5sE48lJ6b1xhK9v0nRCQRsuqIGGJ7+QorvP
         VemzCwePdqNFt7iLtrYUe22xqoivVNafS3v9GajA=
Date:   Thu, 9 Jan 2020 13:52:53 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Yury Norov <yury.norov@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2 2/2] lib/test_bitmap: Fix address space when test
 user buffer
Message-Id: <20200109135253.ab86a6a61899221e1e4609fa@linux-foundation.org>
In-Reply-To: <CAHp75Vd6JLjPfrA4f2ugwfiZS3fBSxN48ja7OjnZ4s_pqWJZng@mail.gmail.com>
References: <20200109103601.45929-1-andriy.shevchenko@linux.intel.com>
        <20200109103601.45929-2-andriy.shevchenko@linux.intel.com>
        <20200109120814.27198f300bbe209cdc411fc6@linux-foundation.org>
        <CAHp75Vd6JLjPfrA4f2ugwfiZS3fBSxN48ja7OjnZ4s_pqWJZng@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Jan 2020 23:04:59 +0200 Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Thu, Jan 9, 2020 at 10:53 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > On Thu,  9 Jan 2020 12:36:01 +0200 Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> >
> > > Force address space to avoid the following warning:
> > >
> > > lib/test_bitmap.c:461:53: warning: incorrect type in argument 1 (different address spaces)
> > > lib/test_bitmap.c:461:53:    expected char const [noderef] <asn:1> *ubuf
> > > lib/test_bitmap.c:461:53:    got char const *in
> >
> > We did this in
> >
> > commit 17b6753ff08bc47f50da09f5185849172c598315
> > Author:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > AuthorDate: Wed Dec 4 16:53:06 2019 -0800
> > Commit:     Linus Torvalds <torvalds@linux-foundation.org>
> > CommitDate: Wed Dec 4 19:44:14 2019 -0800
> >
> >     lib/test_bitmap: force argument of bitmap_parselist_user() to proper address space
> 
> This is for "parseLIST", while new patch for "parse".

Oh.  This is a fix against the mm patch
lib-add-test-for-bitmap_parse.patch.  Please tell us such things!

But [patch 1/2] is applicable to current mainline, yes?

