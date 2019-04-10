Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C58CC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 23:00:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 081B62083E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 23:00:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fiRbnxmF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbfDJXAJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 19:00:09 -0400
Received: from mail-vk1-f193.google.com ([209.85.221.193]:37231 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbfDJXAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 19:00:09 -0400
Received: by mail-vk1-f193.google.com with SMTP id o187so959340vkg.4
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 16:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V/mnOiistNskyNyWzFJ110XGM52BtYbw7mnMXoOf9ss=;
        b=fiRbnxmF4EUFn5589zrjF8mmaXq5M7XTmHAYNR8VIlPO5hdvGO4J901KeKS8ehuB9u
         sSFMnyWDz1LaxmPxuFgwI1ajPAV+oyVGmAtgV4/ByPP8Okd65v1lsbRBlpMEwORppXwt
         fYH3kBjdxPwDR2nSy4EjhX+IqBMADhWhyBnps=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V/mnOiistNskyNyWzFJ110XGM52BtYbw7mnMXoOf9ss=;
        b=bHk6n4yvFmsOT5gDW2tLWkJLpp4JVfjbCxhs3R3aUTk/khIZUtgkgqQno0N30Jq7lF
         WWndrDwEFtz+5zJw6Cbm9CIZdaPnX4ZTFa9qwtH73p2mAFPsZnZyQk/E/n750j+S3Ytz
         a1Y8rsDvQcfFSYGFVFmZgCWZFWjqWhsjZe+Y+g9x3DKEjqjvtrZ7VEtBwrGDaRcsDySh
         0AEYE8VEhB/ddwT9Jprq4+/nu0j6l9IKzOEJl5Ro7CONKAahrhkh9ydVOuEYqxKvn2Qv
         Z0Z4dHIjZxuFOBNHoYB4+IXPAJkCeV8zSTB2vJ/y0ATK7qeFY+7ingND+33v+4kzQH+W
         1Biw==
X-Gm-Message-State: APjAAAXfDIdf1c9M9DE4sV70vKdg7bK2K+BCD6Ab80vJW7sdMGQVynIc
        Ap6BL0X9VjAIBz087CpBJ3QP5C8BGL0=
X-Google-Smtp-Source: APXvYqxcnRP73SBw89wNUcbh9ADKaUrNE0qSAqUrigHCmOyDAWYXoRMVp6zvkyqSyHdRYsM7LVvJUg==
X-Received: by 2002:a1f:2b8e:: with SMTP id r136mr25471936vkr.48.1554937207890;
        Wed, 10 Apr 2019 16:00:07 -0700 (PDT)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com. [209.85.217.50])
        by smtp.gmail.com with ESMTPSA id p12sm4545108vsc.30.2019.04.10.16.00.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 16:00:07 -0700 (PDT)
Received: by mail-vs1-f50.google.com with SMTP id g187so2362339vsc.8
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 16:00:06 -0700 (PDT)
X-Received: by 2002:a67:76c7:: with SMTP id r190mr26927257vsc.196.1554937206551;
 Wed, 10 Apr 2019 16:00:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190408220925.13077-1-mcroce@redhat.com> <20190408220925.13077-3-mcroce@redhat.com>
 <CAGXu5jKc2q3gnBrJ5JowDvOC_tSR5o9iKuF+JVKMJYWAPOZANQ@mail.gmail.com>
 <CAGnkfhwZEqX03H7PqsSTa=GVwZXX127hQO5YHzJasAEYtpLMZw@mail.gmail.com>
 <CAGXu5j+0sAc2fHTuYwYTLoHPDbnfxYuAEJ+tRfgc2Z5DDqp9Jg@mail.gmail.com>
 <CAGnkfhxPZJXmnPJ+k8nGPCBNeDBM_=rN+kEea-Uyq0zfCt0MXg@mail.gmail.com>
 <CAGXu5jKf8ezMOxMn3P8DW+0GQrdkmno8_qxgQtxBD98cP3MRKA@mail.gmail.com> <CAGnkfhyeUdN+H4g9Lx4X2ae9k3crLrZQjQYZVjNE4ZyM8ziY9g@mail.gmail.com>
In-Reply-To: <CAGnkfhyeUdN+H4g9Lx4X2ae9k3crLrZQjQYZVjNE4ZyM8ziY9g@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 10 Apr 2019 15:59:55 -0700
X-Gmail-Original-Message-ID: <CAGXu5j+2CLGmx_Sd+r-GXxPcCg3PfyQDU8ohJfCzxFku5_WzvQ@mail.gmail.com>
Message-ID: <CAGXu5j+2CLGmx_Sd+r-GXxPcCg3PfyQDU8ohJfCzxFku5_WzvQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] kernel: use sysctl shared variables for range check
To:     Matteo Croce <mcroce@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 3:54 PM Matteo Croce <mcroce@redhat.com> wrote:
>
> On Thu, Apr 11, 2019 at 12:34 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Wed, Apr 10, 2019 at 3:30 PM Matteo Croce <mcroce@redhat.com> wrote:
> > >
> > > FYI, this are the stats from my local repo, just to let you the size
> > > of a series with all the changes in it:
> > >
> > > $ git --no-pager log --stat --oneline linus/master
> > >  2 files changed, 4 insertions(+), 9 deletions(-)
> > >  2 files changed, 7 insertions(+), 14 deletions(-)
> > >  6 files changed, 15 insertions(+), 30 deletions(-)
> > >  1 file changed, 16 insertions(+), 19 deletions(-)
> > >  1 file changed, 3 insertions(+), 5 deletions(-)
> > >  3 files changed, 15 insertions(+), 20 deletions(-)
> > >  12 files changed, 93 insertions(+), 116 deletions(-)
> > >  3 files changed, 98 insertions(+), 104 deletions(-)
> > >  2 files changed, 9 insertions(+)
> >
> > Tiny! :) Seriously, though, I think this should be fine to take
> > directly to Linus after patch 1 lands, or see if akpm wants to carry
> > it directly.
> >
> > --
> > Kees Cook
>
> Nice. Still as an 8 patches series, or squashed into a bigger one?

I suspect a single patch would be fine, but let's wait to hear from akpm.

-- 
Kees Cook
