Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B32C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 15:15:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F6AE23BE2
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 15:15:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F6fn5gpa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbfE2PPI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 11:15:08 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:46553 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbfE2PPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 11:15:08 -0400
Received: by mail-ua1-f67.google.com with SMTP id a95so1083627uaa.13
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 08:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nFS7DYDcSBIlL9pCKMAk47pQJxKKCBzIJ9W13eqoYN4=;
        b=F6fn5gpaGuYqO6Ccmwgb5jEUNvXmNK6gC79/sAGDn8OdS3iwTeKzYqKh4Rzo6ZEFNl
         InObiFVGn8EsvfusrteVzdK9+AP/X/7w+rSqJPnd2MtC6qzcq2/VaSh+R/Pe/jpml/Gd
         BdLvJdwrtoSJIMK9Su+HKjWvjA2k7b4Lk+RfJqd1+9EynZj9CpqURY/ArPekUOAWJFbr
         fQEB1sQVSY+bMgzBJ4iz2JwuRbwfY6Q5Y1MEter+aeEDddmJPN5bsGHq4DsntsTP2uLR
         SSoWzQe6cOOnZgPQ7jmxaTfHkrF2/P3UMJEPDEaJtppcVieimUE2n/ioRcwOcVWPWcFk
         bItg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nFS7DYDcSBIlL9pCKMAk47pQJxKKCBzIJ9W13eqoYN4=;
        b=lxajBkjFUJ3zN9oM+glzOyLoeYWwjTuJtiVfiBa/QVU1OW3lD3J447gEjzREAiBOcR
         qBKZ2X+qiMhluZZ9RpfnANGZ/4fXYI2d625gtY8TjFbSgCOvKDprtNvXEHau2PqLx1Dc
         AOWC76sogiN1R/UmOodgYPG3P7uO5vWHQXa2k8EiEGJL0tVBtaGLHYwotvfojg3nr2b8
         sS5NqT2gZxNwobgxAAyUHmF7QUETSKEst3/Qg5trBiD/kvdSni+zqvwcaEhplfR9/GBq
         gaUkyF48jzD95PQBDuj0bS6Vds81gf8LdsQj21JPvYdU0R/TO6JWtI3Mfmd7fJJMteII
         jq/Q==
X-Gm-Message-State: APjAAAUrK51S9WeuY3w4Bt94cc92bsBtueiGBb4R4mt2Q/exuutFJy9K
        qjYBs7UBvr9ZdGeByzYhFcFVLhHcuafF+e+17E2xXnKlkHvgtA==
X-Google-Smtp-Source: APXvYqzFJkPpNIJNBafakif0WH6+0M62vR0Gh/qeo/dr6pJy9x5zhkhoZsnrLvrIoO0vYkzOSni2p7inyL0lFYohP2w=
X-Received: by 2002:ab0:4e12:: with SMTP id g18mr33952342uah.1.1559142907086;
 Wed, 29 May 2019 08:15:07 -0700 (PDT)
MIME-Version: 1.0
References: <1559105521-27053-1-git-send-email-92siuyang@gmail.com> <20190529083459.GA1936@kroah.com>
In-Reply-To: <20190529083459.GA1936@kroah.com>
From:   Yang Xiao <92siuyang@gmail.com>
Date:   Wed, 29 May 2019 23:14:29 +0800
Message-ID: <CAKgHYH2qhVMFdnxnjuO6TjGHrzsP4oCNPgEBww6KPPLOhfU9mA@mail.gmail.com>
Subject: Re: [PATCH] amd64-agp: fix arbitrary kernel memory writes
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     airlied@linux.ie, arnd@arndb.de,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am not so sure about taking off the cast, just to be in line with
patch in 194b3da873fd.
The comment can be deleted.

On Wed, May 29, 2019 at 4:35 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Wed, May 29, 2019 at 12:52:01PM +0800, Young Xiao wrote:
> > pg_start is copied from userspace on AGPIOC_BIND and AGPIOC_UNBIND ioctl
> > cmds of agp_ioctl() and passed to agpioc_bind_wrap().  As said in the
> > comment, (pg_start + mem->page_count) may wrap in case of AGPIOC_BIND,
> > and it is not checked at all in case of AGPIOC_UNBIND.  As a result, user
> > with sufficient privileges (usually "video" group) may generate either
> > local DoS or privilege escalation.
> >
> > See commit 194b3da873fd ("agp: fix arbitrary kernel memory writes")
> > for details.
> >
> > Signed-off-by: Young Xiao <92siuyang@gmail.com>
> > ---
> >  drivers/char/agp/amd64-agp.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/char/agp/amd64-agp.c b/drivers/char/agp/amd64-agp.c
> > index c69e39f..5daa0e3 100644
> > --- a/drivers/char/agp/amd64-agp.c
> > +++ b/drivers/char/agp/amd64-agp.c
> > @@ -60,7 +60,8 @@ static int amd64_insert_memory(struct agp_memory *mem, off_t pg_start, int type)
> >
> >       /* Make sure we can fit the range in the gatt table. */
> >       /* FIXME: could wrap */
> > -     if (((unsigned long)pg_start + mem->page_count) > num_entries)
> > +     if (((pg_start + mem->page_count) > num_entries) ||
> > +         ((pg_start + mem->page_count) < pg_start))
>
> Why did you take off the cast for the first test?
>
> And if this really does fix this issue, should you remove the FIXME
> line?
>
> thanks,
>
> greg k-h



-- 
Best regards!

Young
-----------------------------------------------------------
