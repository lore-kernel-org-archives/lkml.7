Return-Path: <SRS0=ebdT=SX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC3C9C10F14
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 16:56:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93BD120833
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 16:56:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XdI9el8s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727699AbfDUQ4Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Apr 2019 12:56:16 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34858 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbfDUQ4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Apr 2019 12:56:16 -0400
Received: by mail-wr1-f68.google.com with SMTP id o12so9896883wrn.2;
        Sun, 21 Apr 2019 09:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RM3jDbprF1xHgFL9XM/gvSF3FPpHquXwIDG6URlkSVE=;
        b=XdI9el8sQoAlCesr0mbddpE5POmzYTMlz5RlTFEdzfbdOaB7WwOb8N2ZjQ7+X0svoz
         DpWbnRu6+u9XYcaOZDFnXAcWqY7PX7OXe3ewRZAWthHyIEc6PhZZb6W7ikwndKyj07m8
         LyxLVM5uFbPJvOxQJLFBoI3RuugAf56olmf//ttGxs3Kr7yD0sAs3wjmm34Ju+/Ze7p0
         lk/LpwfX/7yDuIX6ZoUZ2Hbol0VnbBW5jEXqKDP2JjiZzfJe2t0Q5IcTJxcz7OOEeFn0
         cPvmMZX4xcnVCnrPxnIGR5wM2FvYzBd1/Yl29TScIjgSGIXFy5k5ssIsOtuSFQrylOVF
         xh/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RM3jDbprF1xHgFL9XM/gvSF3FPpHquXwIDG6URlkSVE=;
        b=kM0pgOzLlYWs0rHZ8EDyeqQJPdkmxIYEC/Kl1hwTxv0pm+PiN9xnJdSc+v9RxaGzNb
         5CCGtlf5d0Ux/6mXFAvLRedM/NSg8pSU58BHyXADtDS/kEnxnDMtngE9tHUgPuj4CORh
         56lVMoTndc2b9gDJ4dN+7HfqDjQcHcwB5KNlFIOviJRu9ttklSYrhUI45duKJ1PuMYcJ
         5J5+8AmpKFduY6t6I99tO+1P0ZmZPurEF9HcAIco95PEsF8DPyKPSAp+tF7e0su8Vqha
         P9plWZ4rfdkzk8Sn2OlmALzxjPLswao3Tr2H2ZMgffX9EhPN1+Xm924oyl0VgZSMiWAQ
         78jw==
X-Gm-Message-State: APjAAAWrUH7oflWDTokLb4QQASuLCut2MhWalDkipD21Pn1d9I3su2WK
        eMPDTfWnYw3F3Wv2qTzF7wMJiRY=
X-Google-Smtp-Source: APXvYqyLVtssQPYb9PCP6xoffn7RwuMAUMZCpe/1t/0Q65iA53tf4/mh3vEEwuPpUx6noj0aY0T49w==
X-Received: by 2002:adf:e747:: with SMTP id c7mr8266768wrn.114.1555865774538;
        Sun, 21 Apr 2019 09:56:14 -0700 (PDT)
Received: from avx2 ([46.53.240.200])
        by smtp.gmail.com with ESMTPSA id t24sm8954867wmi.10.2019.04.21.09.56.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Apr 2019 09:56:13 -0700 (PDT)
Date:   Sun, 21 Apr 2019 19:56:11 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the akpm-current tree
Message-ID: <20190421165611.GB26843@avx2>
References: <20190417165321.61cd6380@canb.auug.org.au>
 <CAGXu5jKYxLe9-umda7C3iWfYFe-Thv=dL4bJQC9nU4GMGK5Wwg@mail.gmail.com>
 <CAGXu5j+9_f=5aT7x=K=Hg9LS3eQ9-dhVF18LCBfZcx+EmTO3PA@mail.gmail.com>
 <20190418090247.2982dafd@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190418090247.2982dafd@canb.auug.org.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2019 at 09:02:47AM +1000, Stephen Rothwell wrote:
> Hi Kees,
> 
> On Wed, 17 Apr 2019 17:28:39 -0500 Kees Cook <keescook@chromium.org> wrote:
> >
> > On Wed, Apr 17, 2019 at 5:22 PM Kees Cook <keescook@chromium.org> wrote:
> > >
> > > On Wed, Apr 17, 2019 at 1:53 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:  
> > > >
> > > > Hi Andrew,
> > > >
> > > > After merging the akpm-current tree, today's linux-next build (arm
> > > > multi_v7_defconfig) failed like this:
> > > >
> > > > fs/binfmt_elf.c: In function 'load_elf_binary':
> > > > fs/binfmt_elf.c:1140:7: error: 'elf_interpreter' undeclared (first use in this function); did you mean 'interpreter'?
> > > >   if (!elf_interpreter)
> > > >        ^~~~~~~~~~~~~~~
> > > >        interpreter  
> > >
> > > static int load_elf_binary(struct linux_binprm *bprm)
> > > {
> > > ...
> > >         char * elf_interpreter = NULL;
> > >
> > > This is _absolutely_ a valid variable.  
> 
> It was. However commit a34f642bccf1 from Andrew's tree changes its scope.
> 
> So there is nothing wrong with commit 3ebf0dd657ce, it is the incorrect
> rebase of it on top of a34f642bccf1 that causes the build problem.
> 
> > > > Caused by commit
> > > >
> > > >   3ebf0dd657ce ("fs/binfmt_elf.c: move brk out of mmap when doing direct loader exec")
> > > >
> > > > interacting with commit
> > > >
> > > >   a34f642bccf1 ("fs/binfmt_elf.c: free PT_INTERP filename ASAP")
> > > >
> > > > I have applied the following patch for today.
> > > >
> > > > From: Stephen Rothwell <sfr@canb.auug.org.au>
> > > > Date: Wed, 17 Apr 2019 16:48:29 +1000
> > > > Subject: [PATCH] fix "fs/binfmt_elf.c: move brk out of mmap when doing direct loader exec"
> > > >
> > > > Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > > > ---
> > > >  fs/binfmt_elf.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> > > > index b3bbe6bca499..fe5668a1bbaa 100644
> > > > --- a/fs/binfmt_elf.c
> > > > +++ b/fs/binfmt_elf.c
> > > > @@ -1137,7 +1137,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
> > > >          * collide early with the stack growing down), and into the unused
> > > >          * ELF_ET_DYN_BASE region.
> > > >          */
> > > > -       if (!elf_interpreter)
> > > > +       if (!interpreter)  
> > >
> > > No, this is very wrong and will, I think, cause all PIE binaries to fail to run.  
> > 
> > I may be wrong: I think this will cause all static binaries to see
> > their brk moved very unexpectedly. All static PIE binaries will fail?
> 
> Are you sure that elf_interpreter == NULL is not equivalent to
> interpreter == NULL by this point in the code?  Earlier if
> elf_intpreter is not NULL, we have set interpreter (using open_exec)
> and errored out if that fails.

My patch was done based on this very observation: if interpreter has been
opened then its filename has been allocated before otherwise how do you
know which interpreter to open? Just like with pathname resolution, once
lookup is done and inode has been fished out, pathname becomes irrelevant.
