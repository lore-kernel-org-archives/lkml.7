Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E257C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 12:17:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF4BB21773
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 12:17:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="bkWHZaxV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729580AbfDXMRm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 08:17:42 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:54015 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729389AbfDXMRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 08:17:41 -0400
Received: by mail-it1-f193.google.com with SMTP id z4so1663423itc.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 05:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uA6iErvAE8AmCa3oijlBpPGbD0Ahz2hRAshYo94dYbc=;
        b=bkWHZaxVdUbxDSpIE8J/X5ZcIj0oYDegfTR67MOvm8G62+5HvF4saaYPm8ynItm5kN
         G20Xi4/aqfZ+4/jmbMANbTdGAhnppMsupMAnEHs/k9teLYIMLRlH8I/QWAaVAWe9sOTy
         3hGOzjwY8WBO0Hk1qyz4N/eaUaYbaCKXz374Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uA6iErvAE8AmCa3oijlBpPGbD0Ahz2hRAshYo94dYbc=;
        b=aHMRipg+kbox6iYNEMssxRDIUoof3j2Vae8+AGInliEOvQRPDBr1SvJPss0Y2+tdn2
         WPysYTHDdyRIOrx77H4g9TFeZ3U7/Omb5HLpGxPzYO5kea/UZdaCDlKz7hx7qBGCplvs
         QythB0DZRwCmEru5P+kvHfyo08Vvx3fxiDfSBG2OaxXGuOnYb6R8ZW4L820SzddEE/mM
         5/P2TO33+qqDvrZ2KCPJLSFPW+wgopAy8QSccmPrJpxvlVKVY2N+JxkeD0kT4aJ67NXI
         3q5nKfKY2tqO9PWrK3KBTZr9YlFLm/7QhKCdQfO6EdmznXVAVBU5ncFl8IMASupZPH/T
         z6Ew==
X-Gm-Message-State: APjAAAWQ6di99LJ2k/sSBVGMf0MJB9E5WB/gU+GmEfYvJ0IPc/0zkg/L
        xG3f67IJTkB33h4dxl09yXYcDl9s8Lk+1AAPIgvg2g==
X-Google-Smtp-Source: APXvYqxY0AbU1GEAGXKKg37O95rypZ8FmCSnT0ZPVpfwGL66ASQ+x+9jR07ZkQnRIpLW+9iO3MHGxk6fGGfV87ohgm8=
X-Received: by 2002:a24:1342:: with SMTP id 63mr6039085itz.69.1556108260820;
 Wed, 24 Apr 2019 05:17:40 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1553680185.git.kirr@nexedi.com> <12f7d0d98555ee0d174d04bb47644f65c07f035a.1553680185.git.kirr@nexedi.com>
 <CAJfpegv0NvcsD9gh3aN+ngzsLqbNWUc73ZPN1qHox_14eN9Pqg@mail.gmail.com> <20190424115620.GA2723@deco.navytux.spb.ru>
In-Reply-To: <20190424115620.GA2723@deco.navytux.spb.ru>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 24 Apr 2019 14:17:27 +0200
Message-ID: <CAJfpegsiWuykUsfg=sO8sKo5h86U65q10=e=wYKXTQEHW8DFkw@mail.gmail.com>
Subject: Re: [RESEND4, PATCH 1/2] fuse: retrieve: cap requested size to
 negotiated max_write
To:     Kirill Smelkov <kirr@nexedi.com>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Jakob Unterwurzacher <jakobunt@gmail.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 1:56 PM Kirill Smelkov <kirr@nexedi.com> wrote:

> I assume you are meaning this:
>
>         --- a/fs/fuse/dev.c
>         +++ b/fs/fuse/dev.c
>         @@ -1745,15 +1745,15 @@ static int fuse_retrieve(struct fuse_conn *fc, struct inode *inode,
>                 unsigned int offset;
>                 size_t total_len = 0;
>                 unsigned int num_pages;
>
>                 offset = outarg->offset & ~PAGE_MASK;
>                 file_size = i_size_read(inode);
>
>         -       num = outarg->size;
>         +       num = min(outarg->size, fc->max_write);
>                 if (outarg->offset > file_size)
>                         num = 0;
>                 else if (outarg->offset + num > file_size)
>                         num = file_size - outarg->offset;               <-- THIS
>
>                 num_pages = (num + offset + PAGE_SIZE - 1) >> PAGE_SHIFT;
>                 num_pages = min(num_pages, fc->max_pages);
>
> and then in this case (offset + num > file_size) num overwrite
>
>         num = file_size - offset
>
> can make num only smaller, right? And then the patch is not wrong because there
> is no other num overwriting in this function except when num is being further
> decremented in loop that prepares pages to retrieve.

You're right, of course.


> > Also the patch is whitespace damaged.
>
> I've tried to do the following in my mutt on "RESEND4, PATCH 1/2"
> message:
>
>         |(cd ~/src/linux/linux && git am -)
>
> and the patch applied successfully. So could you please clarify what
> "whitespace damaged" means?

Hmm, apparently this (and only this) message is "quoted-printable"
encoded.  git-am seems to handle it fine, but my script doesn't.
Anyway, I'll do it manually.

Thanks,
Miklos
