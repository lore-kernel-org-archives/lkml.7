Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B522C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 22:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECD292183E
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 22:22:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TLg9G0bv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728362AbfDQWWx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 18:22:53 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:45284 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728237AbfDQWWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 18:22:53 -0400
Received: by mail-vk1-f196.google.com with SMTP id h127so50968vkd.12
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 15:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d57rP2EVh3StypsBU+1HouITPijGHpFHXUBdsZ7sewo=;
        b=TLg9G0bvkl1+vugkQKzic2EXDKKqDFh0zbQ8zq8n7uqfs2ryqbc0Lf1kwXj0zru42e
         HQEKjYHkFX4aJlSbSobFYx3brj2AMwlSNm4nhPPgeQ0GSWGcesH90zqqjbiw+Ygpfomm
         FYfQkApCfVu0pLyJJeef7Y5FwZRw7FbkEbjLg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d57rP2EVh3StypsBU+1HouITPijGHpFHXUBdsZ7sewo=;
        b=Xj9GVBPCHe0UKyx9x7EEvh60wQoGlnljSNjaPsA41sfY9QEsGX2bcOglXcZe7qiYIm
         eyowgOxRWOtLNCI6FFsITX5hMef2DF7Rqigm5faPkYgmMtDEwFZZ6w2zwiG/1oAmgRVw
         b7XT+6r4xcQBEfltkX/frF5iQN3SwpeYQDHTFLyu2boC0Esx7ODLGJsguflEfPApSt0U
         +fNFROgNoqmzfRuHVQHVa7a3IAijJvhvfdmRm0tIEDX/K6a4miFfA7eiW7Jjif/44mx5
         DjGFmLH0bc5O/s0gD8R0yvfF9BCSbZyyINVxjz+ahDYve8O1XcGGKpPj8w/DgD9LbH1y
         Y4rQ==
X-Gm-Message-State: APjAAAX3rhdb8ljPhfsJPmWEPMTyqcjwgT2xua6glhPLlSLKPaFDNi+6
        gxKOxjsJtrG98dqzgVnIQOas3YmfpEg=
X-Google-Smtp-Source: APXvYqwwG1Nl2l7hkq5OMUX8h6eSotuZX/hTkSz/GLakf1/n+ItVKWLEJqO8V3cYvlP8VdjQwKv0jw==
X-Received: by 2002:a1f:7245:: with SMTP id n66mr37449501vkc.40.1555539771779;
        Wed, 17 Apr 2019 15:22:51 -0700 (PDT)
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com. [209.85.221.182])
        by smtp.gmail.com with ESMTPSA id 2sm558290vke.27.2019.04.17.15.22.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 15:22:50 -0700 (PDT)
Received: by mail-vk1-f182.google.com with SMTP id d15so57322vka.8
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 15:22:50 -0700 (PDT)
X-Received: by 2002:a1f:a4d:: with SMTP id 74mr50288529vkk.13.1555539769904;
 Wed, 17 Apr 2019 15:22:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190417165321.61cd6380@canb.auug.org.au>
In-Reply-To: <20190417165321.61cd6380@canb.auug.org.au>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 17 Apr 2019 17:22:38 -0500
X-Gmail-Original-Message-ID: <CAGXu5jKYxLe9-umda7C3iWfYFe-Thv=dL4bJQC9nU4GMGK5Wwg@mail.gmail.com>
Message-ID: <CAGXu5jKYxLe9-umda7C3iWfYFe-Thv=dL4bJQC9nU4GMGK5Wwg@mail.gmail.com>
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

On Wed, Apr 17, 2019 at 1:53 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi Andrew,
>
> After merging the akpm-current tree, today's linux-next build (arm
> multi_v7_defconfig) failed like this:
>
> fs/binfmt_elf.c: In function 'load_elf_binary':
> fs/binfmt_elf.c:1140:7: error: 'elf_interpreter' undeclared (first use in this function); did you mean 'interpreter'?
>   if (!elf_interpreter)
>        ^~~~~~~~~~~~~~~
>        interpreter

static int load_elf_binary(struct linux_binprm *bprm)
{
...
        char * elf_interpreter = NULL;

This is _absolutely_ a valid variable.

>
>
> Caused by commit
>
>   3ebf0dd657ce ("fs/binfmt_elf.c: move brk out of mmap when doing direct loader exec")
>
> interacting with commit
>
>   a34f642bccf1 ("fs/binfmt_elf.c: free PT_INTERP filename ASAP")
>
> I have applied the following patch for today.
>
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Wed, 17 Apr 2019 16:48:29 +1000
> Subject: [PATCH] fix "fs/binfmt_elf.c: move brk out of mmap when doing direct loader exec"
>
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  fs/binfmt_elf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> index b3bbe6bca499..fe5668a1bbaa 100644
> --- a/fs/binfmt_elf.c
> +++ b/fs/binfmt_elf.c
> @@ -1137,7 +1137,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
>          * collide early with the stack growing down), and into the unused
>          * ELF_ET_DYN_BASE region.
>          */
> -       if (!elf_interpreter)
> +       if (!interpreter)

No, this is very wrong and will, I think, cause all PIE binaries to fail to run.

>                 current->mm->brk = current->mm->start_brk = ELF_ET_DYN_BASE;
>
>         if ((current->flags & PF_RANDOMIZE) && (randomize_va_space > 1)) {
> --
> 2.20.1
>
> --
> Cheers,
> Stephen Rothwell



-- 
Kees Cook
