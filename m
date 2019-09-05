Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49906C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 18:20:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42A13206BA
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 18:20:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vmxz18y5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403871AbfIESUK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 14:20:10 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42162 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389317AbfIESUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 14:20:10 -0400
Received: by mail-pf1-f193.google.com with SMTP id w22so2281062pfi.9
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 11:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u0s/PLxFo+syH7M9Wh4VFiPBwZwXzQ4qynXsfqd0qpc=;
        b=vmxz18y5j40Fyf1TwsRasL2dZnUKzA3rO7twC/uwCcyhfoYuY0LNznOubNlag7C+9q
         Lty9gPyH0n2Gctqtx/AOaqPJNMIuS4ySIRccpu//efecqEBBFhNixIAxRZiitPU4oeLw
         x24yZkCeDpV5AVxXhUrUjrOWlWFSut7LUSlfxIKcyp4GXYZ4VEbM4nT0lBnTpaCCf1tK
         JoYBYjY3IaUwpcBCYfrSZDkpsDFWLxq10f/Ybz/D2wStJ+xw91ApLosRC00cj4XN2gzk
         PTG76cOduLryMZfxigByHLYtXDB4d/bB/wdWlPHZwkXH7r8pRdaL+y7tvJvQSc3dfeHg
         soUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u0s/PLxFo+syH7M9Wh4VFiPBwZwXzQ4qynXsfqd0qpc=;
        b=bCfoCW724GJ0T0eBFBWAKQ5YaBcpXyExueGFKAdGvzIiGejfKO/Q2BrqRXxZ/+PJ2v
         Ek1GdoOqhpisMyPpKu2nY9I2o6s7z+tuP31vLLZjFTkwqOX3Z50Axo0c/U4X1gG/6Tql
         z+srdiyCVEj++xXcaqWGTRyTM3gvV3Dj6WO5VVSeAO/GxQCkIYmKSFmCwubp3lPi9f5C
         t6TPRqp7dSsjBYBg9VmFDIDVM7PLvQVKi2WzTjnp9kuBboZPRbaHlEWfzcDGl3P1ooRI
         KOdT0iwTKP/MbuBzwj4AxkDI5oaNWbptuf+aBaKdnc+AFgQl5JV4X9PPGZcNVW3ojxyW
         ve7A==
X-Gm-Message-State: APjAAAXxw48Qb92yIp+RU2BoLQ9WuZsaGUCGmS47qnxUrbRmmaURT7Ad
        4ikAqybMdONSg7EzS+hPv2m8vxLxaPd+j18bikC54w==
X-Google-Smtp-Source: APXvYqw+oFVeAJknbozW26/1yn4L4sz/FBw/rk3QcNuA2SjTmYHXPoaBM3/VeVtKgK/4bLYx6HxGpkIAwiAIWE3HX9o=
X-Received: by 2002:a63:6193:: with SMTP id v141mr4496292pgb.263.1567707608710;
 Thu, 05 Sep 2019 11:20:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190904214505.GA15093@swahl-linux> <CAKwvOdnX3qVq1wGovViyGJSnySKzCATU4SU_ASsL-9XfDZ8+Eg@mail.gmail.com>
 <CAObFT-RqSa+8re=jLfM-=yyFH38dz89jRjrwGjnhHhGszKxXmQ@mail.gmail.com>
In-Reply-To: <CAObFT-RqSa+8re=jLfM-=yyFH38dz89jRjrwGjnhHhGszKxXmQ@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 5 Sep 2019 11:19:57 -0700
Message-ID: <CAKwvOdk00-v=yT3C3NfN=-FJWLF+9sAYXm_LeFXo+DBZ-vKSxw@mail.gmail.com>
Subject: Re: [PATCH 1/1] x86/purgatory: Change compiler flags to avoid
 relocation errors.
To:     Andreas Smas <andreas@lonelycoder.com>
Cc:     Steve Wahl <steve.wahl@hpe.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Vaibhav Rustagi <vaibhavrustagi@google.com>,
        russ.anderson@hpe.com, dimitri.sivanich@hpe.com,
        mike.travis@hpe.com, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 4, 2019 at 10:34 PM Andreas Smas <andreas@lonelycoder.com> wrote:
>
> On Wed, Sep 4, 2019 at 3:19 PM Nick Desaulniers <ndesaulniers@google.com> wrote:
> > Thanks for confirming the fix.  While it sounds like -mcmodel=large is
> > the only necessary change, I don't object to -ffreestanding of
> > -fno-zero-initialized-in-bss being readded, especially since I think
> > what you've done with PURGATORY_CFLAGS_REMOVE is more concise.
>
> Without -ffreestanding this results in undefined symbols (as before this patch)

Thanks for the report and sorry for the breakage.  Can you test
Steve's patch and send your tested by tag?  Steve will likely respin
the final patch today with Boris' feedback, so now is the time to get
on the train.

>
> $ readelf -a arch/x86/purgatory/purgatory.ro|grep UND
>      0: 0000000000000000     0 NOTYPE  LOCAL  DEFAULT  UND

^ what's that? A <strikethrough>horse</strikethrough> symbol with no name?

>     51: 0000000000000000     0 NOTYPE  GLOBAL DEFAULT  UND __stack_chk_fail

^ so I would have expected the stackprotector changes in my and Steve
commits to prevent compiler emission of that runtime-implemented
symbol.  ie. that `-ffreestanding` affects that and not removing the
stackprotector flags begs another question.  Without `-ffreestanding`
and `-fstack-protector` (or `-fstack-protector-strong`), why would the
compiler emit references to __stack_chk_fail?  Which .o file that
composes the .ro file did we fail to remove the `-fstack-protector*`
flag from?  `-ffreestanding` seems to be covering that up.

>
> I just bumped into this issue as I discovered that kexec() no longer works after
> the x86/purgatory: Use CFLAGS_REMOVE rather than reset KBUILD_CFLAGS -commit
> was merged.



-- 
Thanks,
~Nick Desaulniers
