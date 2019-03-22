Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EAD5C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:27:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE86B2083D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:26:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iEkcs0p3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727167AbfCVP06 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 11:26:58 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46141 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbfCVP06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 11:26:58 -0400
Received: by mail-ed1-f68.google.com with SMTP id d1so1994117edd.13;
        Fri, 22 Mar 2019 08:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qArYm5KOTn2B1oqpxmyc508Ts0e3He6uM0TxEsdgUMQ=;
        b=iEkcs0p3MTbh9EhVeFx4plbZjTxLR6OmhMllZ+mmmtp2jHutZoi6g2UNSsY616xX4P
         4TqJ69bdu4tria+ARfrCnybGdZWgMI6lNTxUk6v4Bg6Gg7+HA4D8gdPlUY76JtfEv9oK
         VOKOTmbwqPawowuSjEnCsWFATximmxowYdeMH8Xpv0bAQVAtYPGXAYFRqYkETDbPg7Df
         KCtXhpwMbzSV0zxpa/SKEQxGPI2VsijSkGJrVL9YADTOQ37o0/30Nok2mas3UwLXB8Ge
         rNgL8zCl0IkogDsCruFD9/p1XZT0FICD/0xgj587mzfuEV0uOrw2CAmjQQ7amBZDX0/J
         O3dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qArYm5KOTn2B1oqpxmyc508Ts0e3He6uM0TxEsdgUMQ=;
        b=GBMdjj0G89eLNvSiFR65XrstUGWwjtsWCpcmmmqobqyvYT1yr1cI8uCoOJ3S3rRIvs
         P3sx+MkTxt//WjYI4KlsRQzUq+1wJvwvOIXK9Nt8WJEQWJoV8keXWokFIWMdU20FbJ/P
         +DBZlZrzLdEWCDgn/TMZyocQasJrdQV3b4vgYDym0z1AYriPry/kgf0kYzfsGoOgRCtr
         iL5UpLfsqP7XcW2tFER8yYxJMEj6S1be8JrHHCjsxXH2F4puJDutCAJ3bTXpP6Jnslyw
         RVMWP2JzrbOTnSNNbL1GQwA/ZZDj3lYNbVPbShxFFUpvDjn0VrtHXe7ce7AtwBw3IEbp
         vQ5w==
X-Gm-Message-State: APjAAAWH1F6HWslSFCiE+beVcR8OaRGOcaCFuv24KR9ZiCGYCR0t+CL2
        jXoRF79E9gVJAarxBHHOk9c=
X-Google-Smtp-Source: APXvYqxFzThC4bNSO1SnzpTueC9+wBuAMYa/lzKvPpB7Egb6NIw78vgmNqnmNX6Y8diFhsxEwjIgMA==
X-Received: by 2002:a50:aa4e:: with SMTP id p14mr1657235edc.59.1553268415840;
        Fri, 22 Mar 2019 08:26:55 -0700 (PDT)
Received: from archlinux-ryzen ([2a01:4f9:2a:1fae::2])
        by smtp.gmail.com with ESMTPSA id f5sm2726719ede.94.2019.03.22.08.26.54
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 22 Mar 2019 08:26:54 -0700 (PDT)
Date:   Fri, 22 Mar 2019 08:26:53 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Achim Leubner <achim_leubner@adaptec.com>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] scsi: gdth: Only call dma_free_coherent when buf is not
 NULL in ioc_general
Message-ID: <20190322152653.GB21978@archlinux-ryzen>
References: <20190307231839.3330-1-natechancellor@gmail.com>
 <CAKwvOd=PZUW1U0KiBgn8z8ReHeRX=s8xEtS7Gebf9-AXxguNNQ@mail.gmail.com>
 <CAK8P3a0w=6kk8bkyKi0rU-8Fxmh0XqjqACadUJviMzkp67myOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a0w=6kk8bkyKi0rU-8Fxmh0XqjqACadUJviMzkp67myOw@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 03:30:08PM +0100, Arnd Bergmann wrote:
> On Fri, Mar 8, 2019 at 10:14 PM 'Nick Desaulniers' via Clang Built
> Linux <clang-built-linux@googlegroups.com> wrote:
> >
> > On Thu, Mar 7, 2019 at 3:19 PM Nathan Chancellor
> > <natechancellor@gmail.com> wrote:
> > >
> > > When building with -Wsometimes-uninitialized, Clang warns:
> > >
> > > drivers/scsi/gdth.c:3662:6: warning: variable 'paddr' is used
> > > uninitialized whenever 'if' condition is false
> > > [-Wsometimes-uninitialized]
> > >
> > > Don't attempt to call dma_free_coherent when buf is NULL (meaning that
> > > we never called dma_alloc_coherent and initialized paddr), which avoids
> > > this warning.
> > >
> > > Link: https://github.com/ClangBuiltLinux/linux/issues/402
> > > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > > ---
> > >  drivers/scsi/gdth.c | 5 +++--
> > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/scsi/gdth.c b/drivers/scsi/gdth.c
> > > index e7f1dd4f3b66..0ca9b4393770 100644
> > > --- a/drivers/scsi/gdth.c
> > > +++ b/drivers/scsi/gdth.c
> > > @@ -3697,8 +3697,9 @@ static int ioc_general(void __user *arg, char *cmnd)
> > >
> > >         rval = 0;
> > >  out_free_buf:
> > > -       dma_free_coherent(&ha->pdev->dev, gen.data_len + gen.sense_len, buf,
> > > -                       paddr);
> > > +       if (buf)
> > > +               dma_free_coherent(&ha->pdev->dev, gen.data_len + gen.sense_len,
> > > +                                 buf, paddr);
> > >         return rval;
> > >  }
> 
> I came up with a different fix for this, but I think yours is better
> 
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> 
> For reference, this was my version:

This is also what I had initially but I felt this was more future proof
and matches how the rest of the tree handles calls to dma_free_coherent.

Thanks for the review!
Nathan

> 
> diff --git a/drivers/scsi/gdth.c b/drivers/scsi/gdth.c
> index e7f1dd4f3b66..c01f243902e1 100644
> --- a/drivers/scsi/gdth.c
> +++ b/drivers/scsi/gdth.c
> @@ -3697,8 +3697,9 @@ static int ioc_general(void __user *arg, char *cmnd)
> 
>         rval = 0;
>  out_free_buf:
> -       dma_free_coherent(&ha->pdev->dev, gen.data_len + gen.sense_len, buf,
> -                       paddr);
> +       if (gen.data_len + gen.sense_len > 0)
> +               dma_free_coherent(&ha->pdev->dev, gen.data_len +
> gen.sense_len, buf,
> +                               paddr);
>         return rval;
>  }
> 
> 
> > Alternatively, paddr is a dma_addr_t defined in include/linux/types.h:
> >
> > #ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
> > typedef u64 dma_addr_t;
> > #else
> > typedef u32 dma_addr_t;
> > #endif
> >
> > Just initializing it to zero might be simpler than complicating the
> > control flow of this function further. Thoughts?
> 
> No, blindly shutting up warnings is almost never the
> right solution, even when they are false positives. The code
> might change in the future and the bogus initialization would
> then prevent the compiler from warning about a new bug.
> 
>       Arnd
