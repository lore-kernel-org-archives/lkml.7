Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E9CCC4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 14:30:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62D50218E2
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 14:30:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729002AbfCVOad (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 10:30:33 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:46130 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727719AbfCVOa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 10:30:27 -0400
Received: by mail-qt1-f193.google.com with SMTP id z17so2647246qts.13;
        Fri, 22 Mar 2019 07:30:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hyJdUwSZHf2dBWdcos+lUhOTArTqOxZqs66GsnlJ3fk=;
        b=gKU0c8dU/lmvzBIqlUB9M8dMLSCJ6ScghZ9kAepk3wxhphhSGzLQMMwsUsozaB1WvB
         Q88eRclY8v6z4tlbFpVHh4t+Kk7XyqfBs6iNbqmTHafiyBPVDTE91uq2dLVtVDTC5CoG
         mKXdoiIdfbr+eXLH5S4cY3EzRb2zLe0uNTPJYsyO0w0ACSnmAhXAhnuttexrd5TyHXx9
         X7kccKUg9qJFmbQlDmSur1L4gJQ0+tmCWJRBC9DbNGmjrGFhUYM2AKRgO/3E0oPK4/e6
         wKskH6QdOLU//kCy2/ggb6WjGW6XoaByXZHx2ddq2zEmgGYGL/PhWiDzxseLzi0nFL8E
         g03g==
X-Gm-Message-State: APjAAAX8UZ8C48KVhiO1bCQ8R9qZpNWTelqaBsqgTlTSYJKlH7i/7ZQh
        Xr1fGeUmV8ZVI2d2NSyCaydpDjJpjE4uQF9kcgc=
X-Google-Smtp-Source: APXvYqzk8UV6SP8ZyJXAWKLd6i0rUGTdwQ7cAMPd+/F4AY6OIkDDdXMWNYzPb8Rscb2KRE+728oQRXX+KIVZFG3kCV4=
X-Received: by 2002:ac8:1637:: with SMTP id p52mr8255936qtj.212.1553265026051;
 Fri, 22 Mar 2019 07:30:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190307231839.3330-1-natechancellor@gmail.com> <CAKwvOd=PZUW1U0KiBgn8z8ReHeRX=s8xEtS7Gebf9-AXxguNNQ@mail.gmail.com>
In-Reply-To: <CAKwvOd=PZUW1U0KiBgn8z8ReHeRX=s8xEtS7Gebf9-AXxguNNQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 22 Mar 2019 15:30:08 +0100
Message-ID: <CAK8P3a0w=6kk8bkyKi0rU-8Fxmh0XqjqACadUJviMzkp67myOw@mail.gmail.com>
Subject: Re: [PATCH] scsi: gdth: Only call dma_free_coherent when buf is not
 NULL in ioc_general
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Achim Leubner <achim_leubner@adaptec.com>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 8, 2019 at 10:14 PM 'Nick Desaulniers' via Clang Built
Linux <clang-built-linux@googlegroups.com> wrote:
>
> On Thu, Mar 7, 2019 at 3:19 PM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> >
> > When building with -Wsometimes-uninitialized, Clang warns:
> >
> > drivers/scsi/gdth.c:3662:6: warning: variable 'paddr' is used
> > uninitialized whenever 'if' condition is false
> > [-Wsometimes-uninitialized]
> >
> > Don't attempt to call dma_free_coherent when buf is NULL (meaning that
> > we never called dma_alloc_coherent and initialized paddr), which avoids
> > this warning.
> >
> > Link: https://github.com/ClangBuiltLinux/linux/issues/402
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > ---
> >  drivers/scsi/gdth.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/scsi/gdth.c b/drivers/scsi/gdth.c
> > index e7f1dd4f3b66..0ca9b4393770 100644
> > --- a/drivers/scsi/gdth.c
> > +++ b/drivers/scsi/gdth.c
> > @@ -3697,8 +3697,9 @@ static int ioc_general(void __user *arg, char *cmnd)
> >
> >         rval = 0;
> >  out_free_buf:
> > -       dma_free_coherent(&ha->pdev->dev, gen.data_len + gen.sense_len, buf,
> > -                       paddr);
> > +       if (buf)
> > +               dma_free_coherent(&ha->pdev->dev, gen.data_len + gen.sense_len,
> > +                                 buf, paddr);
> >         return rval;
> >  }

I came up with a different fix for this, but I think yours is better

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

For reference, this was my version:

diff --git a/drivers/scsi/gdth.c b/drivers/scsi/gdth.c
index e7f1dd4f3b66..c01f243902e1 100644
--- a/drivers/scsi/gdth.c
+++ b/drivers/scsi/gdth.c
@@ -3697,8 +3697,9 @@ static int ioc_general(void __user *arg, char *cmnd)

        rval = 0;
 out_free_buf:
-       dma_free_coherent(&ha->pdev->dev, gen.data_len + gen.sense_len, buf,
-                       paddr);
+       if (gen.data_len + gen.sense_len > 0)
+               dma_free_coherent(&ha->pdev->dev, gen.data_len +
gen.sense_len, buf,
+                               paddr);
        return rval;
 }


> Alternatively, paddr is a dma_addr_t defined in include/linux/types.h:
>
> #ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
> typedef u64 dma_addr_t;
> #else
> typedef u32 dma_addr_t;
> #endif
>
> Just initializing it to zero might be simpler than complicating the
> control flow of this function further. Thoughts?

No, blindly shutting up warnings is almost never the
right solution, even when they are false positives. The code
might change in the future and the bogus initialization would
then prevent the compiler from warning about a new bug.

      Arnd
