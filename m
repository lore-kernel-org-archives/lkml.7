Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FEA4C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 19:22:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EF9320644
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 19:22:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CB1BCNZi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727971AbfEHTWd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 15:22:33 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34757 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726687AbfEHTWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 15:22:32 -0400
Received: by mail-pf1-f193.google.com with SMTP id n19so2440620pfa.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 12:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ft6EOyvYHRbxghf4ibP2yDUEDKBSiu7rrJ8IV2ARge4=;
        b=CB1BCNZiaTLxg6tOUGINx1olRrTu9x7aCQ8+7GpeaQQvOHzJd8VPVRV9b/g9lZNh+K
         X0j4pf+vo5HOoOELzJtNbjT3LriRfmWk8OcKazgmTMy7U6ApnNsfPuQUQQPl7FrdgKQQ
         hI1zUWhfvqEZ7mgrzHqseMwoUsMyVumh5AarinrlnWFyrr/luruWS+uyEfE4naOPUIEr
         BFUA4/qzHnZ5sOaSQwxq0uXm2D0954CBuCj4xQXCG3jiIrfk3mEfwMGDTLVMiWhaSv/0
         2uXhVh57yHjF6Pl7uNBCVUKfNs9qtnAhMYKVlHFeJbUyJHSJTcOPkUwdOTCT9S2WluqT
         h+fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ft6EOyvYHRbxghf4ibP2yDUEDKBSiu7rrJ8IV2ARge4=;
        b=IfaeuCMw2cGmXoGRtAqt4s1eJ2jqbFeS5ZZmLrizSlPhrLjy8QVE1Arf8Xsem+9cI3
         Wctpegw/NpHHJ+67Ok3NZBxjniiYxe+e/1pSgx6F1kZg65kBDADmbMzY1JkNEygnrpgx
         wILo262eYbcVsnW0k+l6hZvEFVJS0fNQJqy27zzOs1jSeZeQL6KUGNCsppUP3EgVKN3o
         ACl0vOD2jxNkxISD5RYXXZH/rQKp7ks5qwzAArLZmTrNEvqI3NTzZ+Jeobh2Kb4GPqih
         uDJXW+UxZ1DQranyLh0J9EOpIKUD5YhxzrRKaacsEZZoUburPsHwyx0nj2zQukQAvxti
         pA1A==
X-Gm-Message-State: APjAAAViTXUKPerEhz1DAu3yfdE+R9NpKL/apfAuTtVB9HvZCDHKBHrz
        n01ebJAA5GYai2NYfMoqbOe53nC0Vx+pXALTJOZH0A==
X-Google-Smtp-Source: APXvYqy+F7cyChtJEW0QfoYLRnjdvRuMptX+gdsJzETkAsPfkGfClW6PDkLUacZJUuIu/vUPamM5PEFe+TfUwwMe0Tg=
X-Received: by 2002:aa7:8b88:: with SMTP id r8mr50703470pfd.174.1557343351587;
 Wed, 08 May 2019 12:22:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAK7LNASLBQ=w9YFBD80s7dit1bd_Tr+ggVyRNms0jf1pR9k=ZA@mail.gmail.com>
 <20190424180223.253025-1-ndesaulniers@google.com> <CAKwvOd=5SVBFsfEgYc9Dpgr--h+pQgCwOnpAjg9B4HG2VY6kFg@mail.gmail.com>
In-Reply-To: <CAKwvOd=5SVBFsfEgYc9Dpgr--h+pQgCwOnpAjg9B4HG2VY6kFg@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 8 May 2019 12:22:20 -0700
Message-ID: <CAKwvOdkpjwgt3pP9rjZtm=rEK9MhEfQdc6PEr91Bnb9tMVDBEA@mail.gmail.com>
Subject: Re: [PATCH v2] sh: vsyscall: drop unnecessary cc-ldoption
To:     Yoshinori Sato <ysato@users.sourceforge.jp>, dalias@libc.org
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Andy Lutomirski <luto@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-sh@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bumping for review, as the merge window is now open.

On Tue, Apr 30, 2019 at 1:26 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Wed, Apr 24, 2019 at 11:02 AM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > Towards the goal of removing cc-ldoption, it seems that --hash-style=
> > was added to binutils 2.17.50.0.2 in 2006. The minimal required version
> > of binutils for the kernel according to
> > Documentation/process/changes.rst is 2.20.
> >
> > Link: https://gcc.gnu.org/ml/gcc/2007-01/msg01141.html
> > Cc: clang-built-linux@googlegroups.com
> > Suggested-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> > ---
> > Changes V1 -> V2:
> > * update commit subject and message as per Masahiro/Geert.
> >
> > To Geert's question about minimum binutils versions; no change needed to
> > binutils.
> >
> >
> >  arch/sh/kernel/vsyscall/Makefile | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/arch/sh/kernel/vsyscall/Makefile b/arch/sh/kernel/vsyscall/Makefile
> > index 5db6579bc44c..6e8664448048 100644
> > --- a/arch/sh/kernel/vsyscall/Makefile
> > +++ b/arch/sh/kernel/vsyscall/Makefile
> > @@ -15,8 +15,7 @@ quiet_cmd_syscall = SYSCALL $@
> >
> >  export CPPFLAGS_vsyscall.lds += -P -C -Ush
> >
> > -vsyscall-flags = -shared -s -Wl,-soname=linux-gate.so.1 \
> > -               $(call cc-ldoption, -Wl$(comma)--hash-style=sysv)
> > +vsyscall-flags = -shared -s -Wl,-soname=linux-gate.so.1 -Wl,--hash-style=sysv
> >
> >  SYSCFLAGS_vsyscall-trapa.so    = $(vsyscall-flags)
> >
> > --
> > 2.21.0.593.g511ec345e18-goog
> >
>
> bumping for review
> --
> Thanks,
> ~Nick Desaulniers



-- 
Thanks,
~Nick Desaulniers
