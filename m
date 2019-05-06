Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA93EC04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 14:29:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BCCD204EC
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 14:29:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="XhpGpVKT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbfEFO3O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 10:29:14 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:22796 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbfEFO3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 10:29:14 -0400
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id x46ESsXM029567
        for <linux-kernel@vger.kernel.org>; Mon, 6 May 2019 23:28:55 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com x46ESsXM029567
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1557152935;
        bh=eqLFB0nVFnZiNimHn82KIGN7U2ZgzKcawlpMijhfc9w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XhpGpVKTClir5AxkSP7NnwHlzCdghMB4dNiu1+xGvHpE07nPSmbwmD1d2ynaoeOuB
         FahHzJzl8/gkBMAQiJ9HlPTZjYwZ/r2pUzr9+aaAiL1ACzqOS3KkfF56H34Nr1BC4y
         322kyQ0SfRdiY+J31kxWHBYV/ybhHi/TSvsr73oieLL1Xlgj8/ip0fIln4yCqlcx+p
         VY6kPFU+PLyQ3w7QLHtVZ9jLKmbrL9Lqmli6uTbJeGowaqligirlscL9AZBW0cs084
         q7bX8b937+hT3AodRM+O5sBL6ZWg/G7Bpc+wHmC+YK3ZNPKlMLthIyGryGKMTC7a+c
         b8OIF2SoI285A==
X-Nifty-SrcIP: [209.85.217.52]
Received: by mail-vs1-f52.google.com with SMTP id c24so1369101vsp.7
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 07:28:55 -0700 (PDT)
X-Gm-Message-State: APjAAAX4P+cz+EvAXtqCBuCMCcAP8Q5+LCqOcTuwMB4DNaqM1LSNOpOq
        YUw15v/WprMSoLG/f0Bs4Xnt4ND6qhZpS68kWE0=
X-Google-Smtp-Source: APXvYqxdltPkQPlIf2njpz+a8BUdQSjsHQ5lVipXcpd+mrcRcFhyBsTBof90IRV3XT2pIlW7uxsmlC28VFTtzEvAAEo=
X-Received: by 2002:a67:fd89:: with SMTP id k9mr1073873vsq.54.1557152934032;
 Mon, 06 May 2019 07:28:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190323015227.245455-1-dianders@chromium.org>
 <CAK7LNARYMy2=viA1et9tZk409M=OSteD5D675oAKQEs6SG77HQ@mail.gmail.com>
 <20190416163034.3e642818ebf27ed6891c1981@linux-foundation.org>
 <CAK7LNAR4Ty8835sfo4HSvBsMCsV65mY2HOajFSY2TOYurmkFdw@mail.gmail.com>
 <20190418160651.40cb6a11186a6c6028e9d20d@linux-foundation.org>
 <CAK7LNAQe2uaVfKee1F6R4siVvUSCMgSaYAnUQfz8MS5PeFqpGA@mail.gmail.com> <e5f29ca9b6067fff9ea68cb25e15906659cd51ad.camel@perches.com>
In-Reply-To: <e5f29ca9b6067fff9ea68cb25e15906659cd51ad.camel@perches.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Mon, 6 May 2019 23:28:17 +0900
X-Gmail-Original-Message-ID: <CAK7LNATFrp=4JcqU2pFJ-+06HZ_6T+R75gwSF=ax-0yJZJ_rVg@mail.gmail.com>
Message-ID: <CAK7LNATFrp=4JcqU2pFJ-+06HZ_6T+R75gwSF=ax-0yJZJ_rVg@mail.gmail.com>
Subject: Re: [PATCH] kdb: Get rid of broken attempt to print CCVERSION in kdb summary
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        kgdb-bugreport@lists.sourceforge.net,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Nicholas Mc Guire <hofrat@osadl.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joe Perches <joe@perches.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is technically super easy,
but shows how difficult to apply a
single patch in a correct manner.


The following showed up in today's linux-next,
doubling
"Signed-off-by: Douglas Anderson <dianders@chromium.org>"

This is obviously caused by the committer.

Do we need some check script for maintainers
before "git push" ?





commit 51fee3389d71bfd281df02c55546a6103779e145
Author:     Douglas Anderson <dianders@chromium.org>
AuthorDate: Fri Mar 22 18:52:27 2019 -0700
Commit:     Daniel Thompson <daniel.thompson@linaro.org>
CommitDate: Thu May 2 14:55:07 2019 +0100

    kdb: Get rid of broken attempt to print CCVERSION in kdb summary

    If you drop into kdb and type "summary", it prints out a line that
    says this:

      ccversion  CCVERSION

    ...and I don't mean that it actually prints out the version of the C
    compiler.  It literally prints out the string "CCVERSION".

    The version of the C Compiler is already printed at boot up and it
    doesn't seem useful to replicate this in kdb.  Let's just delete it.
    We can also delete the bit of the Makefile that called the C compiler
    in an attempt to pass this into kdb.  This will remove one extra call
    to the C compiler at Makefile parse time and (very slightly) speed up
    builds.

    Signed-off-by: Douglas Anderson <dianders@chromium.org>
    Reviewed-by: Masahiro Yamada <yamada.masahiro@socionext.com>
    Signed-off-by: Douglas Anderson <dianders@chromium.org>
    Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>








On Sat, Apr 20, 2019 at 3:24 AM Joe Perches <joe@perches.com> wrote:
>
> On Fri, 2019-04-19 at 12:28 +0900, Masahiro Yamada wrote:
> > Hi Joe,
> >
> > Can you detect redundant Cc: by checkpatch?
> >
> > Please see below in details.
> > Thanks.
>
> Yes, but I'm not sure why it's useful or necessary.
> git send-email using some scripts elides duplicate email addresses
> ---
>  scripts/checkpatch.pl | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 1c421ac42b07..bedec83cb797 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -2688,6 +2688,19 @@ sub process {
>                                 $signatures{$sig_nospace} = 1;
>                         }
>
> +# Check for a cc: line with another signature -by: by the same author
> +                       if ($sig_nospace =~ /^cc:/) {
> +                               my $sig_email = substr($sig_nospace, 3);
> +                               foreach my $sig (sort keys %signatures) {
> +                                       next if ($sig =~ /^cc:/);
> +                                       $sig =~ s/^[^:]+://;
> +                                       if ($sig eq $sig_email) {
> +                                               WARN("BAD_SIGN_OFF",
> +                                                    "Unnecessary CC: as there is another signature with the same name/email address\n" . $herecurr);
> +                                       }
> +                               }
> +                       }
> +
>  # Check Co-developed-by: immediately followed by Signed-off-by: with same name and email
>                         if ($sign_off =~ /^co-developed-by:$/i) {
>                                 if ($email eq $author) {
>
>


-- 
Best Regards
Masahiro Yamada
