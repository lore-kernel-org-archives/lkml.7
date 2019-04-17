Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D8C2C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 23:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEEC72183F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 23:00:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YeJDjkuh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387604AbfDQXAs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 19:00:48 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:40566 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729079AbfDQXAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 19:00:48 -0400
Received: by mail-vs1-f67.google.com with SMTP id f22so125354vso.7
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 16:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N31zUaGWnd5ZqQ88e0VU6jnLrKv5k6UaZBsJo+Frdb0=;
        b=YeJDjkuhEDwJQ/ZwFL3R3fbgJBkLxMDgrWmDB6qTwNwB78mp35QfxVfOKzoh9d7VcY
         Nnhi/06/B3fg9kkZs4EQWfN0ywyPlJFRTRYQqHz0VumqFWwbcSt0nu7/PBbNSY+b/tdJ
         JCdABxHHhWXWIUNzYaQ7fRvafolyk2+j6KVnI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N31zUaGWnd5ZqQ88e0VU6jnLrKv5k6UaZBsJo+Frdb0=;
        b=hXOPMccQXnMx9hy2A15Xax2I3cbJrJwDJScMHKQ5890xaX0ApVl//f3c5ZG3C3dFge
         59F2oGiqu7Tka8HzRrOBuk7njiESHdwscjUQpz2483whcgsU0ZgD1VDnGUzDMMNJgbvO
         UB/14ialnSmYG3tQvvL/K3vvxF6b+VNSmtXevgvv1IyLkicW/rieodUHyOcGFnZGrC40
         Y/qvS57HI7c07g6kTkAn9546Y0N0WThsGrDsT7EL/TGCclz+6McfeqFWVA6VS7fnPas4
         Y/MEAdupE4un/AUPhDGIDovYkMA+bHTu3ODOg4SUrgQP0aX7bahn/tjugz17gettA7iy
         4XLA==
X-Gm-Message-State: APjAAAVSNohVyefPZAU7d8NSGbIjW+aBohZ/v0KK+zNGg+GqBLjOuoCH
        V1ga9bOBVQHvvKufiaeEGJOi1mM5l5Y=
X-Google-Smtp-Source: APXvYqyYWdXDwosw5kA9nxd6ElGQ83RbLjXnqCzImeFIurs8FsFojylHSvo5XBnHEMd/RTBsZJSpLg==
X-Received: by 2002:a67:c404:: with SMTP id c4mr51302604vsk.125.1555540131831;
        Wed, 17 Apr 2019 15:28:51 -0700 (PDT)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com. [209.85.217.48])
        by smtp.gmail.com with ESMTPSA id b81sm95427vkf.47.2019.04.17.15.28.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 15:28:50 -0700 (PDT)
Received: by mail-vs1-f48.google.com with SMTP id s11so113455vsn.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 15:28:50 -0700 (PDT)
X-Received: by 2002:a67:eecb:: with SMTP id o11mr49580379vsp.66.1555540130277;
 Wed, 17 Apr 2019 15:28:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190417165321.61cd6380@canb.auug.org.au> <CAGXu5jKYxLe9-umda7C3iWfYFe-Thv=dL4bJQC9nU4GMGK5Wwg@mail.gmail.com>
In-Reply-To: <CAGXu5jKYxLe9-umda7C3iWfYFe-Thv=dL4bJQC9nU4GMGK5Wwg@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 17 Apr 2019 17:28:39 -0500
X-Gmail-Original-Message-ID: <CAGXu5j+9_f=5aT7x=K=Hg9LS3eQ9-dhVF18LCBfZcx+EmTO3PA@mail.gmail.com>
Message-ID: <CAGXu5j+9_f=5aT7x=K=Hg9LS3eQ9-dhVF18LCBfZcx+EmTO3PA@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the akpm-current tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Alexey Dobriyan <adobriyan@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 5:22 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Wed, Apr 17, 2019 at 1:53 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > Hi Andrew,
> >
> > After merging the akpm-current tree, today's linux-next build (arm
> > multi_v7_defconfig) failed like this:
> >
> > fs/binfmt_elf.c: In function 'load_elf_binary':
> > fs/binfmt_elf.c:1140:7: error: 'elf_interpreter' undeclared (first use in this function); did you mean 'interpreter'?
> >   if (!elf_interpreter)
> >        ^~~~~~~~~~~~~~~
> >        interpreter
>
> static int load_elf_binary(struct linux_binprm *bprm)
> {
> ...
>         char * elf_interpreter = NULL;
>
> This is _absolutely_ a valid variable.

I saw a 0day report[1] as well on MIPS for this. Neither have I been
able to reproduce, though. I'm wondering if, due to the misplaced
kfree() that has existed for a while, if some kind of weird scoping is
happening.

What compiler are you using?

[1] https://lists.01.org/pipermail/kbuild-all/2019-April/060058.html

>
> >
> >
> > Caused by commit
> >
> >   3ebf0dd657ce ("fs/binfmt_elf.c: move brk out of mmap when doing direct loader exec")
> >
> > interacting with commit
> >
> >   a34f642bccf1 ("fs/binfmt_elf.c: free PT_INTERP filename ASAP")
> >
> > I have applied the following patch for today.
> >
> > From: Stephen Rothwell <sfr@canb.auug.org.au>
> > Date: Wed, 17 Apr 2019 16:48:29 +1000
> > Subject: [PATCH] fix "fs/binfmt_elf.c: move brk out of mmap when doing direct loader exec"
> >
> > Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > ---
> >  fs/binfmt_elf.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> > index b3bbe6bca499..fe5668a1bbaa 100644
> > --- a/fs/binfmt_elf.c
> > +++ b/fs/binfmt_elf.c
> > @@ -1137,7 +1137,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
> >          * collide early with the stack growing down), and into the unused
> >          * ELF_ET_DYN_BASE region.
> >          */
> > -       if (!elf_interpreter)
> > +       if (!interpreter)
>
> No, this is very wrong and will, I think, cause all PIE binaries to fail to run.

I may be wrong: I think this will cause all static binaries to see
their brk moved very unexpectedly. All static PIE binaries will fail?





--
Kees Cook
