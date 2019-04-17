Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C4B3C10F12
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 06:38:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A55A320835
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 06:38:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="0EhN8HCv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730502AbfDQGix (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 02:38:53 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:21395 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbfDQGix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 02:38:53 -0400
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id x3H6cPp5007675
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 15:38:26 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com x3H6cPp5007675
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1555483106;
        bh=/zDvBu2C+eN3YpdLu2UPwlBoiQJ7Y/GgxolsDBc871c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=0EhN8HCv7rvAKCxlwmxj+jr0Rw/4u50Qwpyzqe3xfC1CLzca6F4ponHHeP/3ZmU0z
         7zLGHXEzIGjVgfjZYdV9WUkjK6XlpRa9OMJRpM+Tb5xnNWkskpzw9+r6DoQnT96NxG
         L2JWjSuvR9bJR0E0alfKq7CuOaaVK5diFTeQuiP6/Jeynfdsm7yINXwjMqoVvOt8Dj
         8Kw6EfKTBFHCCCN9r7HxClO6PvumhuSRL2yRnf0af6jqhQl6SiS4dyylQ7kazHqHY6
         Hyrr8wS3d3w3DJTA2JQk5f6ZqCXT8C2n3DvjlfNHR/MQ2qLOAtWy1IMw1IGz+BXVtl
         rY0J9fXDBa29w==
X-Nifty-SrcIP: [209.85.217.45]
Received: by mail-vs1-f45.google.com with SMTP id t78so12986703vsc.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 23:38:26 -0700 (PDT)
X-Gm-Message-State: APjAAAWVRbrKtSCT9h2WCXC4Gt7SNWrc/UAraARdvlo1+stjwVCotNPH
        mxcbiUq1AEq0tdygnD6KdF/pJN+vNpR1yxZTn0M=
X-Google-Smtp-Source: APXvYqwshJL6bnXf8aDFeHApPE3Tn7kpkwLPZPVl4AYZop3sWXfgKy1cM+8w2z4QzVwf+a/SnVn6B8wD4FgRqF3KRLA=
X-Received: by 2002:a67:fbcc:: with SMTP id o12mr7506602vsr.60.1555483104881;
 Tue, 16 Apr 2019 23:38:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190323015227.245455-1-dianders@chromium.org>
 <CAK7LNARYMy2=viA1et9tZk409M=OSteD5D675oAKQEs6SG77HQ@mail.gmail.com> <20190416163034.3e642818ebf27ed6891c1981@linux-foundation.org>
In-Reply-To: <20190416163034.3e642818ebf27ed6891c1981@linux-foundation.org>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 17 Apr 2019 15:37:49 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR4Ty8835sfo4HSvBsMCsV65mY2HOajFSY2TOYurmkFdw@mail.gmail.com>
Message-ID: <CAK7LNAR4Ty8835sfo4HSvBsMCsV65mY2HOajFSY2TOYurmkFdw@mail.gmail.com>
Subject: Re: [PATCH] kdb: Get rid of broken attempt to print CCVERSION in kdb summary
To:     Andrew Morton <akpm@linux-foundation.org>
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On Wed, Apr 17, 2019 at 8:31 AM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Thu, 11 Apr 2019 18:06:23 +0900 Masahiro Yamada <yamada.masahiro@socionext.com> wrote:
>
> > On Sat, Mar 23, 2019 at 10:55 AM Douglas Anderson <dianders@chromium.org> wrote:
> > >
> > > If you drop into kdb and type "summary", it prints out a line that
> > > says this:
> > >
> > >   ccversion  CCVERSION
> > >
> > > ...and I don't mean that it actually prints out the version of the C
> > > compiler.  It literally prints out the string "CCVERSION".
> > >
> > > The version of the C Compiler is already printed at boot up and it
> > > doesn't seem useful to replicate this in kdb.  Let's just delete it.
> > > We can also delete the bit of the Makefile that called the C compiler
> > > in an attempt to pass this into kdb.  This will remove one extra call
> > > to the C compiler at Makefile parse time and (very slightly) speed up
> > > builds.
> > >
> > > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> >
> >
> > I know you add lots of Cc: lines
> > when you pick up patches, but I think
> > your script can be improved.
> >
> > You added "Cc: Douglas Anderson <dianders@chromium.org>",
> > but Douglas is the author.
> > I think the author should be excluded from Cc.
>
> Whoops.
>
> It's pretty benign: Doug will still only get a single email.
>
>
> checkpatch checks for duplicates cc's but I think it assumes that
> things like
>
> Reported-by: fred
> Tested-by: fred
>
> were intentional.
>
> It would perhaps be better for checkpatch to special-case the "Cc:
> fred" tag and report a duplicated Cc: if fred was also mentioned in any
> other tag.

Sorry, I do not understand what you mean.


Douglas did not add any Cc: tag at all
in his original patch:
https://lore.kernel.org/patchwork/patch/1053953/


It's you who added the Cc: tags
(and I am guessing you did it by scripting.)

Why is this topic related to checkpatch?

-- 
Best Regards
Masahiro Yamada
