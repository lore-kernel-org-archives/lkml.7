Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B1B3C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 23:30:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2AD0205ED
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 23:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555457439;
	bh=976CHk/Xt7vCI24xs6nkdzjqQ7QO1AkxknBeEWdby7g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=2DVNV40uFh8uhOte0Tp/566zJ+Ji64Ovqd7VM1XADflQ0Di185I/9+zw8VsE6egaN
	 faCxFSm0+zQm/2tR2sAiuV1bHqB/SF2sAHbGEvLv8uox0vCjgP6dV9TPyOUqX1KnwT
	 zIlA8JIIusczbylwhuHJcVavfrGPrHUU5buDmtkQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730020AbfDPXah (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 19:30:37 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35742 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728237AbfDPXah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 19:30:37 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 05E52B49;
        Tue, 16 Apr 2019 23:30:35 +0000 (UTC)
Date:   Tue, 16 Apr 2019 16:30:34 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        kgdb-bugreport@lists.sourceforge.net,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Nicholas Mc Guire <hofrat@osadl.org>,
        Joe Perches <joe@perches.com>
Subject: Re: [PATCH] kdb: Get rid of broken attempt to print CCVERSION in
 kdb summary
Message-Id: <20190416163034.3e642818ebf27ed6891c1981@linux-foundation.org>
In-Reply-To: <CAK7LNARYMy2=viA1et9tZk409M=OSteD5D675oAKQEs6SG77HQ@mail.gmail.com>
References: <20190323015227.245455-1-dianders@chromium.org>
        <CAK7LNARYMy2=viA1et9tZk409M=OSteD5D675oAKQEs6SG77HQ@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Apr 2019 18:06:23 +0900 Masahiro Yamada <yamada.masahiro@socionext.com> wrote:

> On Sat, Mar 23, 2019 at 10:55 AM Douglas Anderson <dianders@chromium.org> wrote:
> >
> > If you drop into kdb and type "summary", it prints out a line that
> > says this:
> >
> >   ccversion  CCVERSION
> >
> > ...and I don't mean that it actually prints out the version of the C
> > compiler.  It literally prints out the string "CCVERSION".
> >
> > The version of the C Compiler is already printed at boot up and it
> > doesn't seem useful to replicate this in kdb.  Let's just delete it.
> > We can also delete the bit of the Makefile that called the C compiler
> > in an attempt to pass this into kdb.  This will remove one extra call
> > to the C compiler at Makefile parse time and (very slightly) speed up
> > builds.
> >
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> 
> 
> I know you add lots of Cc: lines
> when you pick up patches, but I think
> your script can be improved.
> 
> You added "Cc: Douglas Anderson <dianders@chromium.org>",
> but Douglas is the author.
> I think the author should be excluded from Cc.

Whoops.

It's pretty benign: Doug will still only get a single email.


checkpatch checks for duplicates cc's but I think it assumes that
things like

Reported-by: fred
Tested-by: fred

were intentional.

It would perhaps be better for checkpatch to special-case the "Cc:
fred" tag and report a duplicated Cc: if fred was also mentioned in any
other tag.

