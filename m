Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0280C43215
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 18:22:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B337D206CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 18:22:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i3GWEGWz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbfKNSV7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 13:21:59 -0500
Received: from mail-vk1-f193.google.com ([209.85.221.193]:37593 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726750AbfKNSV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 13:21:59 -0500
Received: by mail-vk1-f193.google.com with SMTP id l5so1711002vkb.4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 10:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+VmC0KbxXRLmjlMOB0/4aEHZOiDqNhhGvntSX5Ejh5I=;
        b=i3GWEGWzJoezpcuBDQQnlQIoJ+Rv+jSVSok9hmyrDnxtqt29OyhbbtJA/BshvyJ0A+
         xQHroDFiea8vnXV5pDykoN5dMiwmOr370jtxqYTkPulHU2uPmqNHn0Y0bdT1r0ZVnBlS
         T2AFQQUWhBYmf3HiqpDxsDJm1TuozHGfYl4zVe0KbiR+t0ApNOPZj9V3Hd1sjCaoALiv
         fUjmMBfQfH9Jl5MFqHJ1TgDLqhpp+zuhMmjfygnYWexjSfBGhw3XIu0vyYBE5DxvRUkX
         1zUvQ9EidQToL3IbY2wUfRHA6WTAYCPlNFGfIhivzPV2RhF/5o/FJbT9aGP4HQrS+dCV
         5gJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+VmC0KbxXRLmjlMOB0/4aEHZOiDqNhhGvntSX5Ejh5I=;
        b=ZsJYy1c2XkKsPtJmwH9eUj7wdvCCTsD2szlo6Z8TLrw0K3rHwm5QHA0L14kSyQYqgm
         POJPd7Y8a1NbnRHA2zZm5LYyRKVFRDeth8IVMhKhIr/uD7nTmgN+lQkTQ3n1vqFwrv4q
         nLU7kaDYchQQ8bjyesI40uQLUNscLbAi8rgz0ppxoW3wnMiWq6ckhtXdCpJW+lZq49bH
         m06QNAqNZ4I43pOHb8SavU6O9gbnqVswNfZUJ+L4sd3DaAjfSjNGygwnoCHuoEzsb25/
         dfTXiMFogkuMLLnUrOddKzLpWmJx2dcBn2MLt0KuglhwTrwd/0atgvZxph6qIQxilOuf
         GQVQ==
X-Gm-Message-State: APjAAAWgQYJWa6McOjiLSl5VYdVCDgwgYxu8ALIu+HGm3naPWm/zrJuQ
        Ga4EA2Kmjoh8JYNIy11V92SCniF7FgT1QRKrW9kwJw==
X-Google-Smtp-Source: APXvYqw2NIH+2yA3HN+TDprRqlq2TcrmfjkaRKWSAwLb7M4Vw9kp9ssltTe9lpDGejjqT6dY+zc0U+thx75uMkNYkNc=
X-Received: by 2002:a1f:7d88:: with SMTP id y130mr6044142vkc.71.1573755717967;
 Thu, 14 Nov 2019 10:21:57 -0800 (PST)
MIME-Version: 1.0
References: <20191112223046.176097-1-samitolvanen@google.com>
 <20191113200419.GE221701@gmail.com> <CABCJKudoBHo6rZoGMFproXjmexu16gonVKDPdnq9XDCmO2J2cw@mail.gmail.com>
 <CAKv+Gu85PY+A_XxB9DcmcoV8+nAJZGfAc59sj6XnOGyhDedNQA@mail.gmail.com>
In-Reply-To: <CAKv+Gu85PY+A_XxB9DcmcoV8+nAJZGfAc59sj6XnOGyhDedNQA@mail.gmail.com>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Thu, 14 Nov 2019 10:21:46 -0800
Message-ID: <CABCJKudGdwmshFynZQZsPg4JJ+Yu0-GNp+aEjXdJAwu6zU5vtw@mail.gmail.com>
Subject: Re: [PATCH] crypto: arm64/sha: fix function types
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Kees Cook <keescook@chromium.org>,
        linux-crypto <linux-crypto@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 14, 2019 at 1:45 AM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
>
> On Wed, 13 Nov 2019 at 22:28, Sami Tolvanen <samitolvanen@google.com> wrote:
> >
> > On Wed, Nov 13, 2019 at 12:04 PM Eric Biggers <ebiggers@kernel.org> wrote:
> > >
> > > On Tue, Nov 12, 2019 at 02:30:46PM -0800, Sami Tolvanen wrote:
> > > > Declare assembly functions with the expected function type
> > > > instead of casting pointers in C to avoid type mismatch failures
> > > > with Control-Flow Integrity (CFI) checking.
> > > >
> > > > Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> > > > ---
> > > >  arch/arm64/crypto/sha1-ce-glue.c   | 12 +++++-------
> > > >  arch/arm64/crypto/sha2-ce-glue.c   | 26 +++++++++++---------------
> > > >  arch/arm64/crypto/sha256-glue.c    | 30 ++++++++++++------------------
> > > >  arch/arm64/crypto/sha512-ce-glue.c | 23 ++++++++++-------------
> > > >  arch/arm64/crypto/sha512-glue.c    | 13 +++++--------
> > > >  5 files changed, 43 insertions(+), 61 deletions(-)
> > > >
> > > > diff --git a/arch/arm64/crypto/sha1-ce-glue.c b/arch/arm64/crypto/sha1-ce-glue.c
> > > > index bdc1b6d7aff7..3153a9bbb683 100644
> > > > --- a/arch/arm64/crypto/sha1-ce-glue.c
> > > > +++ b/arch/arm64/crypto/sha1-ce-glue.c
> > > > @@ -25,7 +25,7 @@ struct sha1_ce_state {
> > > >       u32                     finalize;
> > > >  };
> > > >
> > > > -asmlinkage void sha1_ce_transform(struct sha1_ce_state *sst, u8 const *src,
> > > > +asmlinkage void sha1_ce_transform(struct sha1_state *sst, u8 const *src,
> > > >                                 int blocks);
> > >
> > > Please update the comments in the corresponding assembly files too.
> > >
> > > Also, this change doesn't really make sense because the assembly functions still
> > > expect struct sha1_ce_state, and they access sha1_ce_state::finalize which is
> > > not present in struct sha1_state.  There should either be wrapper functions that
> > > explicitly do the cast from sha1_state to sha1_ce_state, or there should be
> > > comments in the assembly files that very clearly explain that although the
> > > function prototype takes sha1_state, it's really assumed to be a sha1_ce_state.
> >
> > Agreed, this needs a comment explaining the type mismatch. I'm also
> > fine with using wrapper functions and explicitly casting the
> > parameters instead of changing function declarations. Herbert, Ard,
> > any preferences?
> >
>
> I guess the former would be cleaner, using container_of() rather than
> a blind cast to make the code more self-documenting. The extra branch
> shouldn't really matter.

Sure, using container_of() sounds like a better option, I'll use that
in v2. Thanks!

Sami
