Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0588FC4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 18:16:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D49912083B
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 18:16:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OeWJRcUg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388748AbfJNSQJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 14:16:09 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:40445 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731955AbfJNSQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 14:16:09 -0400
Received: by mail-oi1-f193.google.com with SMTP id k9so14534949oib.7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 11:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MIBRcx0ifowvcR39u0o/yTqzRxoaaM/WNcTZ/tvS6ro=;
        b=OeWJRcUgEFxmkHpbnahx0BDp6S/Ozy0Bl3rOrSHIseNZuZLmKTZEQBNd0C4sfgGnzi
         t+w0+A7CFBRljCV40IDvG0WrnfNWMxa46gF7l6TDTUxKIXMEdaIjJYlnXNTSfJf7gQi7
         iPpIy+HoaNN7lu7ME5QtEtS4EYWCPxlIwVK1KQJDQ4a4ILsMgCUUMwtUj0U1/8qkx6Pu
         ePCKTenz99fyKckB6S736oaiKJ5l81f8n5VJReMhYfwQQJYn/9MVoIOpzbxUIdOHBfFc
         m2/gS7idPQA6uGdH74+QYKnFYK4bJ7JxKEwdYkOjcLSnlitIlGJGO0uMtz/CoYYYXbhC
         C6qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MIBRcx0ifowvcR39u0o/yTqzRxoaaM/WNcTZ/tvS6ro=;
        b=lZe68QdoVr765Ph5ntrGEbtlLsnJ07XsIVk28SXqlGgVngUIqMai68RqVeMciVw7Th
         b84RDdSRM4E9d9IcHwCEUwcMM3XJpkQvH7IPl5Rh+QRG72EYS+FthyTkDxWPdAj7yG3l
         n9cnwgxEkaFMBlt2rjvEeCkPDg+dwb8W4+6vW2cDoEmQh0YAztMxz9RDbARt03d3Y5lC
         TT/gegVDZlz2oJqEpllZE8GsNDMG8r5L9OR5R9c/gjC+Ne7Owbp8jLeswQ+MnUPPRDL0
         Hgdg6EVU0Z6nIGDtlIkG0v5wPwKPZmexql4lR7KvpMWFfweFgNBAx7jirMnfgYpvJcPe
         pnUg==
X-Gm-Message-State: APjAAAWJHaqX3Kww7FvIc7/nRJJa1UWamRWJFDpVJwxCoIL/1nCFjOZD
        Y7+oASbo1CMHerSU89YJS7VcUdkkpGs6Kx1TFHXtvVuuI3U=
X-Google-Smtp-Source: APXvYqzKxEz2BXIZJr/sLy+beuJcyD6wKA+TWsW55YiekuTAJeYe/skCAcGEK0KEpc5Ghf3kqL8lt3rB40/+shwwfp0=
X-Received: by 2002:aca:4557:: with SMTP id s84mr25179212oia.101.1571076967291;
 Mon, 14 Oct 2019 11:16:07 -0700 (PDT)
MIME-Version: 1.0
References: <20191012191602.45649-1-dancol@google.com> <20191012191602.45649-2-dancol@google.com>
 <CAG48ez3yOPAC3mTJdQ5_8aARQPe+siid5jaa8U+aMtfj-bUJ2g@mail.gmail.com>
In-Reply-To: <CAG48ez3yOPAC3mTJdQ5_8aARQPe+siid5jaa8U+aMtfj-bUJ2g@mail.gmail.com>
From:   Daniel Colascione <dancol@google.com>
Date:   Mon, 14 Oct 2019 11:15:30 -0700
Message-ID: <CAKOZuet4VM-P_xm9R7cJO2_f60eUcqt5wHG8+khJedhctfEEhw@mail.gmail.com>
Subject: Re: [PATCH 1/7] Add a new flags-accepting interface for anonymous inodes
To:     Jann Horn <jannh@google.com>
Cc:     Linux API <linux-api@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Nick Kralevich <nnk@google.com>,
        Nosh Minwalla <nosh@google.com>,
        Tim Murray <timmurray@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for taking a look

On Mon, Oct 14, 2019 at 8:39 AM Jann Horn <jannh@google.com> wrote:
>
> On Sat, Oct 12, 2019 at 9:16 PM Daniel Colascione <dancol@google.com> wrote:
> > Add functions forwarding from the old names to the new ones so we
> > don't need to change any callers.
>
> This patch does more than the commit message says; it also refactors
> the body of the function. (I would've moved that refactoring over into
> patch 2, but I guess this works, too.)
>
> [...]
> > -struct file *anon_inode_getfile(const char *name,
> > -                               const struct file_operations *fops,
> > -                               void *priv, int flags)
> > +struct file *anon_inode_getfile2(const char *name,
> > +                                const struct file_operations *fops,
> > +                                void *priv, int flags, int anon_inode_flags)
>
> (AFAIK, normal kernel style is to slap a "__" prefix in front of the
> function name instead of appending a digit, but I guess it doesn't
> really matter.)

I thought prefixing "_" was for signaling "this is an implementation
detail and you probably don't want to call it unless you know what
you're doing", not "here's a new version that does a new thing".

> >  {
> > +       struct inode *inode;
> >         struct file *file;
> >
> > -       if (IS_ERR(anon_inode_inode))
> > -               return ERR_PTR(-ENODEV);
> > -
> > -       if (fops->owner && !try_module_get(fops->owner))
> > -               return ERR_PTR(-ENOENT);
> > +       if (anon_inode_flags)
> > +               return ERR_PTR(-EINVAL);
> >
> > +       inode = anon_inode_inode;
> > +       if (IS_ERR(inode))
> > +               return ERR_PTR(-ENODEV);
> >         /*
> > -        * We know the anon_inode inode count is always greater than zero,
> > -        * so ihold() is safe.
> > +        * We know the anon_inode inode count is always
> > +        * greater than zero, so ihold() is safe.
> >          */
>
> This looks like maybe you started editing the comment, then un-did the
> change, but left the modified line wrapping in your patch? Please
> avoid that - code changes with no real reason make "git blame" output
> more annoying and create trouble when porting patches between kernel
> versions.

I'll fix it.

>
> [...]
> >  EXPORT_SYMBOL_GPL(anon_inode_getfile);
> > +EXPORT_SYMBOL_GPL(anon_inode_getfile2);
> [...]
> >  EXPORT_SYMBOL_GPL(anon_inode_getfd);
> > +EXPORT_SYMBOL_GPL(anon_inode_getfd2);
>
> Since anon_inode_getfd() is now a static inline function in
> include/linux/anon_inodes.h, exporting it doesn't make sense anymore.
> Same for anon_inode_getfile().

I didn't want to break modules unnecessarily. Declaring the function
inline and also exporting it gives us an efficiency win while avoiding
an ABI break, right?

> [...]
> > +#define ANON_INODE_SECURE 1
>
> That #define belongs in a later patch, right?

Yep.
