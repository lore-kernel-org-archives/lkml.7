Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 955E5CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 18:06:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69EE120862
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 18:06:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jnGz5ZBc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730790AbfJ2SGq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 14:06:46 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:41523 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730712AbfJ2SGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 14:06:45 -0400
Received: by mail-vs1-f68.google.com with SMTP id i22so3159983vsl.8
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 11:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mFw8F15ZQ3Xbg7xoMFqwMMbaKM4Z7mDJFWlKx02r/fU=;
        b=jnGz5ZBcGWY68OZAM0i8Lq8WshL9lPwPCKy46KW4Q4CqK1nT+2d8ZAARAMvS6PXKWF
         o7NG7xyF6xKh5LBKn0qUtI0281c0hmJ2dzLNzU/WP3USr8iMDHoA0fHhCuf+Y5KQIysf
         /gxPbdD9yymiy7mPrRQCpSe4/hjycluO7VWmE1bnlYKlYuee/Z6PSw8Q3v0Mc8Wi7hZ8
         2E+OE1apjm/pLB0iqvv0jz3P6BJ0NNgMR3y8PgkI3mLvUBKAsTMd1pFxzhZ05duV3AdK
         By0m5g7JzeYGXlIGp2w4GxLSQ2nwj8OLby9Tzo/kTFVRC8Fnbf+wgIcLkplHN7Gr/fSp
         9Cyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mFw8F15ZQ3Xbg7xoMFqwMMbaKM4Z7mDJFWlKx02r/fU=;
        b=BOhN78028ji8v2BYbOXJx2CvFCrG+3IppfC5N87pgZHLcoYcVfIWH7iGPu49f/Iknh
         2LPZlZPXKrDCsRY4JnuabZbQNSNoJnq3/iDj2N1GX+Mb0x/dnVY3G1N/Oydn5K6nd592
         DfLcyvOfBIiner8vkYPeVOmQTJmmKhos+kbhawtGXCuvFlUhVPegy3ieX0CrBAHAgTaU
         9y/hMMCa7ypcT/UMi2erJwNdR+rKJg+Hz7E5TrOO9xJH5IOn4Fn0HM9dGzFa9u8zqdZJ
         MGCt2bmpHFZKMpvvRa6gfd138Qk7/STZBXLX7IfzDeqzLzu6NihPDzU0RzsdL2paiAAP
         pgSw==
X-Gm-Message-State: APjAAAXOi28B3iIBbVKx/aRADkJER+MDROqbh9kjvBNfLwhfIV6Ttdc2
        bSz5n4sxhmn483wbm/16GG++bBL7hI+Hofa2riZSEQ==
X-Google-Smtp-Source: APXvYqz97vwt703X1r3/ZAfNJZMwiiBLpjsPQNbPUEOndiJkJVVqLzY5YLBzfX1ehhjXGJ9HafNP7XMVii7jjKKfRBs=
X-Received: by 2002:a67:fe02:: with SMTP id l2mr2281254vsr.112.1572372402875;
 Tue, 29 Oct 2019 11:06:42 -0700 (PDT)
MIME-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com>
 <20191024225132.13410-1-samitolvanen@google.com> <20191024225132.13410-6-samitolvanen@google.com>
 <20191025105643.GD40270@lakrids.cambridge.arm.com> <CABCJKuc+XiDRdqfvjwCF7y=1wX3QO0MCUpeu4Gdcz91+nmnEAQ@mail.gmail.com>
 <20191028163532.GA52213@lakrids.cambridge.arm.com> <201910281250.25FBA8533@keescook>
In-Reply-To: <201910281250.25FBA8533@keescook>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Tue, 29 Oct 2019 11:06:31 -0700
Message-ID: <CABCJKufubiN9JdOTGUSRgmmc_0bW3SRCnk9404+zmor4kh9ZCQ@mail.gmail.com>
Subject: Re: [PATCH v2 05/17] add support for Clang's Shadow Call Stack (SCS)
To:     Kees Cook <keescook@chromium.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jann Horn <jannh@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28, 2019 at 12:57 PM Kees Cook <keescook@chromium.org> wrote:
> On Mon, Oct 28, 2019 at 04:35:33PM +0000, Mark Rutland wrote:
> > On Fri, Oct 25, 2019 at 01:49:21PM -0700, Sami Tolvanen wrote:
> > > To keep the address of the currently active shadow stack out of
> > > memory, the arm64 implementation clears this field when it loads x18
> > > and saves the current value before a context switch. The generic code
> > > doesn't expect the arch code to necessarily do so, but does allow it.
> > > This requires us to use __scs_base() when accessing the base pointer
> > > and to reset it in idle tasks before they're reused, hence
> > > scs_task_reset().
> >
> > Ok. That'd be worth a comment somewhere, since it adds a number of
> > things which would otherwise be unnecessary.
> >
> > IIUC this assumes an adversary who knows the address of a task's
> > thread_info, and has an arbitrary-read (to extract the SCS base from
> > thead_info) and an arbitrary-write (to modify the SCS area).
> >
> > Assuming that's the case, I don't think this buys much. If said
> > adversary controls two userspace threads A and B, they only need to wait
> > until A is context-switched out or in userspace, and read A's SCS base
> > using B.
> >
> > Given that, I'd rather always store the SCS base in the thread_info, and
> > simplify the rest of the code manipulating it.
>
> I'd like to keep this as-is since it provides a temporal protection.
> Having arbitrary kernel read and write at arbitrary time is a very
> powerful attack primitive, and is, IMO, not very common. Many attacks
> tend to be chains of bugs that give attackers narrow visibility in to the
> kernel at specific moments. I would say this design is more about stopping
> "current" from dumping thread_info (as there are many more opportunities
> for current to see its own thread_info compared to arbitrary addresses
> or another task's thread_info). As such, I think it's a reasonable
> precaution to take.

I'm not sure if always storing the base address in thread_info would
simplify the code that much. We could remove __scs_base() and
scs_task_reset(), which are both trivial, and drop a few instructions
in the arch-specific code that clear the field. I do agree that a
comment or two would help understand what's going on here though.

Sami
