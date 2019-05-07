Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64FC1C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 13:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CB16205C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 13:55:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CCwcJmAi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbfEGNzS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 09:55:18 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53718 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbfEGNzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 09:55:17 -0400
Received: by mail-wm1-f67.google.com with SMTP id 198so2722256wme.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 06:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ftaHeLN6LcCSd/vTpOtKevk2/0Z7rhTtE8080NO1IyY=;
        b=CCwcJmAiQKULARVAkP5inOfEjWKng+/5qwejU5zut+xMgxu9Lz7szjMOX5Xye5c1oJ
         cznwYpljGq+BC3K3fwYe2OCHd3JKh+sj63tnCIW+RGgG3ZIIseDiPfkjvM99TqCbVV61
         P6jXTr6/iwdE6OllImhcj0qRaffSt4WZQBbx1EQTbXo3x5dnsOa6JZtvr5+xRh9OT8tQ
         GOEV+VC4l5vhCJlxTGY37rJ1yDUvKjoy8Kx3/dZoc9f2eTvBo6XdvF2p7aQEBMRynLAn
         nLNHfPLXYOq/H8snFIZWzds05JeICe1XCFTTGJMBZHhjpW3lT+6Ir7OEDneubUy43MGd
         MY5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ftaHeLN6LcCSd/vTpOtKevk2/0Z7rhTtE8080NO1IyY=;
        b=a7oajdYSv4az7klcToaaAc0QBtidhXNgk73pjp8kq41TtUWq4u6gpvYOM276E5slTf
         55Lh9+RTLOISRZhe9VjcbgtZca07ioNpOS3/P0IHKjH7kiqmug659ZCLAKquPCIfT7xi
         WM8dEmJmxg9HDnNqTsL7tfjgwPMMpRyUEKsdWfqPLyY5i1h+YmYjmDbVRdrcjSNb8mtF
         9jj4esT/jqrmcLeRPYq/SzsF35IEqVK3Oc4h3NCis40vBFSvvmGONPshVGifb092wJhT
         QaaQU0rVQrvm+ZGcn4HXGnQjXRfaJIHkg34j6jufH1LhjRlefRYAaQ0BPUllclveZmh4
         QAzA==
X-Gm-Message-State: APjAAAW2VFMv9VajiXZJR/Rs17f1WL+2NbbzIWUowrInxR7fyePb9Z26
        NXwRdMvmuuzFlfvxkUD81nzfAA==
X-Google-Smtp-Source: APXvYqzL08M0l8/b/QjHbLH9zM/aRoR1h6JRay21JayfU1JzJMO2JVVBenIDL7uUa3ccVpd9cExWAg==
X-Received: by 2002:a7b:c411:: with SMTP id k17mr21162882wmi.68.1557237315102;
        Tue, 07 May 2019 06:55:15 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id f138sm6267700wmf.23.2019.05.07.06.55.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 May 2019 06:55:14 -0700 (PDT)
Date:   Tue, 7 May 2019 14:55:12 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
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
Subject: Re: [PATCH] kdb: Get rid of broken attempt to print CCVERSION in kdb
 summary
Message-ID: <20190507135512.5fyy3zu7ljjaeg3u@holly.lan>
References: <20190323015227.245455-1-dianders@chromium.org>
 <CAK7LNARYMy2=viA1et9tZk409M=OSteD5D675oAKQEs6SG77HQ@mail.gmail.com>
 <20190416163034.3e642818ebf27ed6891c1981@linux-foundation.org>
 <CAK7LNAR4Ty8835sfo4HSvBsMCsV65mY2HOajFSY2TOYurmkFdw@mail.gmail.com>
 <20190418160651.40cb6a11186a6c6028e9d20d@linux-foundation.org>
 <CAK7LNAQe2uaVfKee1F6R4siVvUSCMgSaYAnUQfz8MS5PeFqpGA@mail.gmail.com>
 <e5f29ca9b6067fff9ea68cb25e15906659cd51ad.camel@perches.com>
 <CAK7LNATFrp=4JcqU2pFJ-+06HZ_6T+R75gwSF=ax-0yJZJ_rVg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNATFrp=4JcqU2pFJ-+06HZ_6T+R75gwSF=ax-0yJZJ_rVg@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 06, 2019 at 11:28:17PM +0900, Masahiro Yamada wrote:
> This patch is technically super easy,
> but shows how difficult to apply a
> single patch in a correct manner.
> 
> 
> The following showed up in today's linux-next,
> doubling
> "Signed-off-by: Douglas Anderson <dianders@chromium.org>"
> 
> This is obviously caused by the committer.

Quite so. Thanks for pointing it out.


> Do we need some check script for maintainers
> before "git push" ?

I have to admit that I think this was just a checkpatch mistake on
my part.

This thread is a bit unusual in that patchwork has collected up
all the example Tested-by: Fred stuff that arose during the earlier
tools conversation. It looks like I was sufficiently distracted by
those to overlook the duplicated sign off...


Daniel.

 
> commit 51fee3389d71bfd281df02c55546a6103779e145
> Author:     Douglas Anderson <dianders@chromium.org>
> AuthorDate: Fri Mar 22 18:52:27 2019 -0700
> Commit:     Daniel Thompson <daniel.thompson@linaro.org>
> CommitDate: Thu May 2 14:55:07 2019 +0100
> 
>     kdb: Get rid of broken attempt to print CCVERSION in kdb summary
> 
>     If you drop into kdb and type "summary", it prints out a line that
>     says this:
> 
>       ccversion  CCVERSION
> 
>     ...and I don't mean that it actually prints out the version of the C
>     compiler.  It literally prints out the string "CCVERSION".
> 
>     The version of the C Compiler is already printed at boot up and it
>     doesn't seem useful to replicate this in kdb.  Let's just delete it.
>     We can also delete the bit of the Makefile that called the C compiler
>     in an attempt to pass this into kdb.  This will remove one extra call
>     to the C compiler at Makefile parse time and (very slightly) speed up
>     builds.
> 
>     Signed-off-by: Douglas Anderson <dianders@chromium.org>
>     Reviewed-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>     Signed-off-by: Douglas Anderson <dianders@chromium.org>
>     Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> 
> 
> 
> 
> 
> 
> 
> 
> On Sat, Apr 20, 2019 at 3:24 AM Joe Perches <joe@perches.com> wrote:
> >
> > On Fri, 2019-04-19 at 12:28 +0900, Masahiro Yamada wrote:
> > > Hi Joe,
> > >
> > > Can you detect redundant Cc: by checkpatch?
> > >
> > > Please see below in details.
> > > Thanks.
> >
> > Yes, but I'm not sure why it's useful or necessary.
> > git send-email using some scripts elides duplicate email addresses
> > ---
> >  scripts/checkpatch.pl | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> >
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > index 1c421ac42b07..bedec83cb797 100755
> > --- a/scripts/checkpatch.pl
> > +++ b/scripts/checkpatch.pl
> > @@ -2688,6 +2688,19 @@ sub process {
> >                                 $signatures{$sig_nospace} = 1;
> >                         }
> >
> > +# Check for a cc: line with another signature -by: by the same author
> > +                       if ($sig_nospace =~ /^cc:/) {
> > +                               my $sig_email = substr($sig_nospace, 3);
> > +                               foreach my $sig (sort keys %signatures) {
> > +                                       next if ($sig =~ /^cc:/);
> > +                                       $sig =~ s/^[^:]+://;
> > +                                       if ($sig eq $sig_email) {
> > +                                               WARN("BAD_SIGN_OFF",
> > +                                                    "Unnecessary CC: as there is another signature with the same name/email address\n" . $herecurr);
> > +                                       }
> > +                               }
> > +                       }
> > +
> >  # Check Co-developed-by: immediately followed by Signed-off-by: with same name and email
> >                         if ($sign_off =~ /^co-developed-by:$/i) {
> >                                 if ($email eq $author) {
> >
> >
> 
> 
> -- 
> Best Regards
> Masahiro Yamada
