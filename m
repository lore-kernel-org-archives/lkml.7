Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FFD7C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 19:50:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12E842087C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 19:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552420221;
	bh=IuzcZJU89UVvkoC3bJKgUrD7EP5hKN7pAazl4EpUvxk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=rKOUVQlaN4nKBfTrVurMT1wP3qlcFNqmkPV8GrQWCoK3OGqqxpQU+Gq71Hm3vR7c+
	 Ci12lSO6TvUEMjLNvmgFmeVeMQPpJIKviMd8dq2KQ8uGP/xOwWLKALqzXBG108/pA3
	 RfZaf3RGriBUs1zcRgv32iWJeWYf7vrRy0uzchnM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbfCLTuT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 15:50:19 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55076 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726372AbfCLTuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 15:50:19 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 0942CE52;
        Tue, 12 Mar 2019 19:50:18 +0000 (UTC)
Date:   Tue, 12 Mar 2019 12:50:17 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Drop -Wdeclaration-after-statement
Message-Id: <20190312125017.b1f5af3350434ca05b5fe35e@linux-foundation.org>
In-Reply-To: <20190312172447.GA10166@avx2>
References: <20190310133535.GA20473@avx2>
        <20190311173845.53c2e4e4d2257a3701fa2033@linux-foundation.org>
        <20190312172447.GA10166@avx2>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Mar 2019 20:24:47 +0300 Alexey Dobriyan <adobriyan@gmail.com> wrote:

> On Mon, Mar 11, 2019 at 05:38:45PM -0700, Andrew Morton wrote:
> > On Sun, 10 Mar 2019 16:35:35 +0300 Alexey Dobriyan <adobriyan@gmail.com> wrote:
> > 
> > > Newly added static_assert() is formally a declaration, which will give
> > > a warning if used in the middle of the function.
> > > 
> > > ...
> > >
> > > --- a/Makefile
> > > +++ b/Makefile
> > > @@ -792,9 +792,6 @@ endif
> > >  # arch Makefile may override CC so keep this after arch Makefile is included
> > >  NOSTDINC_FLAGS += -nostdinc -isystem $(shell $(CC) -print-file-name=include)
> > >  
> > > -# warn about C99 declaration after statement
> > > -KBUILD_CFLAGS += -Wdeclaration-after-statement
> > > -
> > >  # Variable Length Arrays (VLAs) should not be used anywhere in the kernel
> > >  KBUILD_CFLAGS += $(call cc-option,-Wvla)
> > 
> > I do wish your changelogs were more elaborate :(
> 
> > So the proposal is to disable -Wdeclaration-after-statement in all
> > cases for all time because static_assert() doesn't work correctly?
> 
> Yes. I converted 2 cases in /proc to static_assert() and you can't write
> 
> 	{
> 		[code]
> 		static_assert()
> 	}
> 
> without a warning because static_assert() is declaration.
> So people would move BUILD_BUG_ON() to where it doesn't belong.

Sure.

> > Surely there's something we can do to squish the static_assert() issue
> > while retaining -Wdeclaration-after-statement?
> 
> It is not good in my opinion to stick to -Wdeclaration-after-statement.

Why?

> > Perhaps by making
> > static_assert() a nop if -Wdeclaration-after-statement is in use. 
> > Perhaps simply by putting { } around the static_assert()?
> 
> Making a statement out of it would disable current cases where it is
> placed in headers.

I think you mean cases where static_assert() is used outside functions?

We could have two versions of it, one for use inside functions, one for
use outside functions?

