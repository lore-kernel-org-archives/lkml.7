Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D12DEC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 16:09:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A026E21871
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 16:09:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="nCEIs6JQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729502AbfCOQJf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 12:09:35 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:16451 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729396AbfCOQJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 12:09:34 -0400
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id x2FG9PIQ007691;
        Sat, 16 Mar 2019 01:09:26 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com x2FG9PIQ007691
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1552666166;
        bh=ciSNWk4zmFAeEwhNhN+vmqFGz1WJYZ75xB8KRrQZeVg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nCEIs6JQ7LDIoyvejSXX5lDXJ9bMz2H6E65C7PkfoBz5UBhbegdV+zM30fVNu2SzF
         Om1tNmbzC4hTTHqsy/1uNwKtKtOG9c5VTlGFnZ7SQfw8JRONf5IAP2SBqD1QhK0tW8
         pAP+NeDOe1ITDVzIyqyxndyocochJkW3U1929eJkHN4XFwg7zrUvZAts08xGsO1LF2
         i/m8TlDMb7xkInQoIPsserWCHdO1VBVZuzfDR0baFNFH2cicKHTu+FgmraVOfbXmmx
         ZVm8OdRgtvRdo0Uo8GcxkeAGa3ZGp7y6B185q9UChLQCTrzoiA64lmBBfwZibFO3Gd
         lYB9usz6ZxCQw==
X-Nifty-SrcIP: [209.85.222.47]
Received: by mail-ua1-f47.google.com with SMTP id g1so3271195uae.10;
        Fri, 15 Mar 2019 09:09:26 -0700 (PDT)
X-Gm-Message-State: APjAAAVY5hceVnmX2E5VznBaKgAvE1SyzEr38cRDCAr7N2tg2bi+6B/Z
        N5Yu8vsWZ/QrNd1WVqxnEt/XTNJ+Hr6TOdc0xik=
X-Google-Smtp-Source: APXvYqzoGHElriZYWk064q6kNnxFPv8CK7KH/qWDiKhTd4J4mIIx2SA5LfL+mJsVK5JQ010ybMYPfC//Y+l+lg30ZcY=
X-Received: by 2002:ab0:73d3:: with SMTP id m19mr115203uaq.46.1552666165202;
 Fri, 15 Mar 2019 09:09:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190314234159.191745-1-dianders@chromium.org>
 <CAK7LNATa+TnXb+a6on-sx2mjNoAiORe-WeZ8UusETHdSrXowuw@mail.gmail.com>
 <CAK7LNAT=04WAMEfN7u5N_oO2RwT9bYALMN3SZ3WFQo-=3vEjsQ@mail.gmail.com> <CAD=FV=XqH7knZwK+a+bsACwc-j2NgH914mLTc_POR_GAipVf7w@mail.gmail.com>
In-Reply-To: <CAD=FV=XqH7knZwK+a+bsACwc-j2NgH914mLTc_POR_GAipVf7w@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sat, 16 Mar 2019 01:08:49 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQff3c9zUMSyj37WT_hgPQ9x7Vf-Hxnm_u0LxNwEMJ+7w@mail.gmail.com>
Message-ID: <CAK7LNAQff3c9zUMSyj37WT_hgPQ9x7Vf-Hxnm_u0LxNwEMJ+7w@mail.gmail.com>
Subject: Re: [PATCH] kbuild: Make NOSTDINC_FLAGS a simply expanded variable
To:     Doug Anderson <dianders@chromium.org>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Mar 16, 2019 at 12:41 AM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Fri, Mar 15, 2019 at 8:37 AM Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
> >
> > On Sat, Mar 16, 2019 at 12:27 AM Masahiro Yamada
> > <yamada.masahiro@socionext.com> wrote:
> > >
> > > On Fri, Mar 15, 2019 at 8:42 AM Douglas Anderson <dianders@chromium.org> wrote:
> > > >
> > > > During a simple no-op (nothing changed) build I saw 39 invocations of
> > > > the C compiler with the argument "-print-file-name=include".  We don't
> > > > need to call the C compiler 39 times for this--one time will suffice.
> > > >
> > > > Let's change NOSTDINC_FLAGS to a simply expanded variable to avoid
> > > > this since there doesn't appear to be any reason it should be
> > > > recursively expanded.
> > > >
> > > > On my build this shaved ~400 ms off my "no-op" build.
> > > >
> > > > Note that the recursive expansion seems to date back to the (really
> > > > old) commit e8f5bdb02ce0 ("[PATCH] Makefile include path ordering").
> > > > It's a little unclear to me if the point of that patch was to switch
> > > > the variable to be recursively expanded (which it did) or to avoid
> > > > directly assigning to NOSTDINC_FLAGS (AKA to switch to +=) because
> > > > someone else (out of tree?) was setting it.  I presume later since if
> > > > the only goal was to switch to recursive expansion the patch would
> > > > have just removed the ":".
> > > >
> > > > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > >
> > > Applied to linux-kbuild.
> > > Thanks.
> >
> >
> > BTW, I noticed no one else
> > appends NOSTDINC_FLAGS.
> >
> >
> > So, does it make more sense to do as follows?
> >
> >
> > NOSTDINC_FLAGS := -nostdinc -isystem $(shell $(CC) -print-file-name=include)
>
> It might.  ...but go back to look at commit e8f5bdb02ce0 ("[PATCH]
> Makefile include path ordering").  Why did they do a += there since
> even then nobody was setting it.  Try:
>
> $ git grep NOSTDINC_FLAGS e8f5bdb02ce0~
>
>
> Do you understand what was going on in that commit?


No, I do not understand.

Maybe, it fixed a problem in downstream code
since there was no directory like include/asm-xen.


If you do not want to take risk,
I am fine with this patch, though.



> -Doug



-- 
Best Regards
Masahiro Yamada
