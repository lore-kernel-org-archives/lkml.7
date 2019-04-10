Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBCA8C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 22:27:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9382920820
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 22:27:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LsFTxSAG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbfDJW13 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 18:27:29 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43337 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725982AbfDJW12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 18:27:28 -0400
Received: by mail-pg1-f196.google.com with SMTP id z9so2368636pgu.10
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 15:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LKdL31+8foJtd7bGbyGnDeB/b6OeiseHFJOeWG1JQTQ=;
        b=LsFTxSAGGNZ3texvmgL48jZe+nTKj3WfcSV93n6mr1O/oflm1TZjNr3TZ6d5Prr7VL
         G4eS+83abr+ducwvrO15GPRXBcaZt7y3vF4XLGDuZR3G49J+T1q/48fa5qqYycu6ka7X
         LqhrS/Dw7qfKeLal1f/7oHitSPg2rozucKt+vo3bpHHBVSpy0CyZAFVMtysLmwgxK/Qh
         55wBglCRUjRYdJywW4j/EaYOm2VscSO+yF7od23y6kdtdfdGzTaVREeDpjtrNQNbqMtC
         gLIcnlb4/uTbTS/U6Qjz0X0a4ni+6o3DCdReCgYARHcmzLp+OG0YM2J/RZvOiWkD+Y1p
         pTmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LKdL31+8foJtd7bGbyGnDeB/b6OeiseHFJOeWG1JQTQ=;
        b=NvHXYZB68nrli5igDQjhNqkjjyAClseGTfCW7HsusIQd6sw8PaAu/Kn0OjvSPMbfOZ
         /3rivlZEaq/pfcuQMYdPUeQ6tfrN9uJcpwUEcVn5Ro1LR5blOENPn7aosaZcX4xdDuU/
         68pbv6mc5LPm6/wV6VcSeh72tMw7lU11KgOvH9eIQfuNtacbUNTyQj9z6trvVxxCd07y
         CAWOXB0fS00IdUXeKJEwtQtvro14HQcG9TfQK1Raho40Jited5SagaTqvweKlNkqoJ6A
         88tI65odhu2D7utRYcqkZYrbEo2z6kLhjsHfA/nw0Vd8cSQjjmAm+JXFBp+dghImATt/
         PCWQ==
X-Gm-Message-State: APjAAAVhb+VDK71XqLCcKY2VZdipbyjhhsJMANrxcZZbesbx9YKNuoPC
        k4NUxrZM4v3lyxLlVmDtSAofUqG2C5WAl7WpcOA+ULYTVk0HAg==
X-Google-Smtp-Source: APXvYqxJOwPelVJQTejf9QA/E5Mh2MGystEBYqz6kTfXwsIEt3mTS8yLWc1eUzEwoVYa6Gwvdya+t8QVnVfPqDDR5Hk=
X-Received: by 2002:aa7:8096:: with SMTP id v22mr17151971pff.94.1554935247511;
 Wed, 10 Apr 2019 15:27:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190410220301.2332-1-louis@kragniz.eu>
In-Reply-To: <20190410220301.2332-1-louis@kragniz.eu>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 10 Apr 2019 15:27:16 -0700
Message-ID: <CAKwvOd=mqzj2pAZEUsW-M_62xn4pijpCJmP=B1h_-wEb0NeZsA@mail.gmail.com>
Subject: Re: [PATCH] afs: use correct format characters
To:     Louis Taylor <louis@kragniz.eu>
Cc:     David Howells <dhowells@redhat.com>, linux-afs@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 3:03 PM Louis Taylor <louis@kragniz.eu> wrote:
>
> When compiling with -Wformat, clang warns:
>
> fs/afs/flock.c:632:29: warning: format specifies type 'short' but the argument has type
>       'unsigned char' [-Wformat]
>         _leave(" = %d [%hd]", ret, fl->fl_type);
>                        ~~~         ^~~~~~~~~~~
>
> fl_type is declared as an unsigned char unconditionally in
> include/linux/fs.h, so use the correct format characters.

Thanks for the patch, LGTM.  I had in my notes that there's a similar warning in
fs/afs/dir.c
line 138
format specifies type 'unsigned short' but the argument has type 'int'

can you verify if that's still the case, and if so, roll that change
into this one in a v2?

Otherwise, I'll post my reviewed by tag, and we can take just this one.

>
> Link: https://github.com/ClangBuiltLinux/linux/issues/378
> Signed-off-by: Louis Taylor <louis@kragniz.eu>
> ---
>  fs/afs/flock.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/afs/flock.c b/fs/afs/flock.c
> index 6a0174258382..be4c3f6a3178 100644
> --- a/fs/afs/flock.c
> +++ b/fs/afs/flock.c
> @@ -629,7 +629,7 @@ static int afs_do_getlk(struct file *file, struct file_lock *fl)
>
>         ret = 0;
>  error:
> -       _leave(" = %d [%hd]", ret, fl->fl_type);
> +       _leave(" = %d [%hhu]", ret, fl->fl_type);
>         return ret;
>  }
>
> --
> 2.21.0
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To post to this group, send email to clang-built-linux@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20190410220301.2332-1-louis%40kragniz.eu.
> For more options, visit https://groups.google.com/d/optout.



-- 
Thanks,
~Nick Desaulniers
