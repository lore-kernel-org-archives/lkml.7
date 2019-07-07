Return-Path: <SRS0=HQPa=VE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,GAPPY_SUBJECT,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FAA2C48BDE
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 16:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 424DA2133D
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 16:01:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nCwfu1OY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727244AbfGGQBn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jul 2019 12:01:43 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:43041 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbfGGQBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jul 2019 12:01:43 -0400
Received: by mail-io1-f66.google.com with SMTP id k20so29363972ios.10;
        Sun, 07 Jul 2019 09:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kpL69YTVdvgy2bgbCOoUAnMPb0H84df6WGk7mkMI8Qw=;
        b=nCwfu1OYXtJXAuz5Lw4SgN1PmgDQUVSLIFq+2jh1XLmUp3piIngxYlk0KmfkFI1FdU
         ROOz1oYuYpPTsIRC19fMn50wHKiL/1gzimzolIXiaiQbaMHI7/jEq3bXle+03+OUSiDc
         vb8XG3QFPTFXCgHoRzC3t4VI3dM5wY+VV08O9+8PRER8D6corxQOdB2qjaeH6UCQ+QcP
         FBAc9oCbnVJZQHcsSuN32Wru3Ez2SyPRyHYLFtpT1SvyMWXfGXVY0oh+ribE8rBorJx1
         csI7+IjL0WhDtEaVwk2kiNc+fitKtaiRXFvzVURUwwFo3mTjAhcUNR/9yv01OnRYj5l9
         zVaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kpL69YTVdvgy2bgbCOoUAnMPb0H84df6WGk7mkMI8Qw=;
        b=m2HlpE3bM6ieEtXoM8gqvCqlGuRQeGPMMvOBMYkCx16RsxOnCnNYZbqINQCHBGV26J
         5HDaFhXV7WU4u03/V4x8TPWRvfd1TIVASPrPu2y1sQNgv7J06kAcCqTlaY1jTmuuV8GB
         oKoJz8VS/8ZW7tCaebwlcQSvPOKd9HJCoMdsK4/AB4ZiX5h+2Syhh2EDPDdAVseBCGb0
         1myCYcDcJx+STF9KcTQmFg7Z0BEJ1jpo5t/8BKy1nrqtxrKlaZP9tyl6JqlAI5oIRmg1
         /mMkpiw+n0TGTRqoV7/YD/Dr6PsbBwNofVskdvHcMh/32SdX2VMMqvF6thlwj3bmzJNa
         vvKg==
X-Gm-Message-State: APjAAAVxl/MeFMZiSd/EGGE6ReKwD8NHvc+9cxx+pgGtMqlQuf+mhbVW
        pnYd1HMYjjtWo4YmIno7ifQx4lKjtnB0rZKKoV8=
X-Google-Smtp-Source: APXvYqz+gbqDipYXXJauAyDBwpal9ZoBFjQ62TKLSgnXN1ufM0R8ek36cAH6qd6K24dcXtDGiOBZvXmI/J8cVswrx5g=
X-Received: by 2002:a5d:940b:: with SMTP id v11mr1384909ion.69.1562515302185;
 Sun, 07 Jul 2019 09:01:42 -0700 (PDT)
MIME-Version: 1.0
References: <1562410493-8661-1-git-send-email-s.mesoraca16@gmail.com>
 <1562410493-8661-5-git-send-email-s.mesoraca16@gmail.com> <CAG48ez35oJhey5WNzMQR14ko6RPJUJp+nCuAHVUJqX7EPPPokA@mail.gmail.com>
In-Reply-To: <CAG48ez35oJhey5WNzMQR14ko6RPJUJp+nCuAHVUJqX7EPPPokA@mail.gmail.com>
From:   Salvatore Mesoraca <s.mesoraca16@gmail.com>
Date:   Sun, 7 Jul 2019 18:01:31 +0200
Message-ID: <CAJHCu1+35GhGJY8jDMPEU8meYhJTVgvzY5sJgVCuLrxCoGgHEg@mail.gmail.com>
Subject: Re: [PATCH v5 04/12] S.A.R.A.: generic DFA for string matching
To:     Jann Horn <jannh@google.com>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux-MM <linux-mm@kvack.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Brad Spengler <spender@grsecurity.net>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        PaX Team <pageexec@freemail.hu>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        James Morris <jmorris@namei.org>,
        John Johansen <john.johansen@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jann Horn <jannh@google.com> wrote:
>
> On Sat, Jul 6, 2019 at 12:55 PM Salvatore Mesoraca
> <s.mesoraca16@gmail.com> wrote:
> > Creation of a generic Discrete Finite Automata implementation
> > for string matching. The transition tables have to be produced
> > in user-space.
> > This allows us to possibly support advanced string matching
> > patterns like regular expressions, but they need to be supported
> > by user-space tools.
>
> AppArmor already has a DFA implementation that takes a DFA machine
> from userspace and runs it against file paths; see e.g.
> aa_dfa_match(). Did you look into whether you could move their DFA to
> some place like lib/ and reuse it instead of adding yet another
> generic rule interface to the kernel?

Yes, using AppArmor DFA cloud be a possibility.
Though, I didn't know how AppArmor's maintainers feel about this.
I thought that was easier to just implement my own.
Anyway I understand that re-using that code would be the optimal solution.
I'm adding in CC AppArmor's maintainers, let's see what they think about this.

> > +++ b/security/sara/dfa.c
> > @@ -0,0 +1,335 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +/*
> > + * S.A.R.A. Linux Security Module
> > + *
> > + * Copyright (C) 2017 Salvatore Mesoraca <s.mesoraca16@gmail.com>
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2, as
> > + * published by the Free Software Foundation.
>
> Throughout the series, you are adding files that both add an SPDX
> identifier and have a description of the license in the comment block
> at the top. The SPDX identifier already identifies the license.

I added the license description because I thought it was required anyway.
IANAL, if you tell me that SPDX it's enough I'll remove the description.

Thank you for your comments.
