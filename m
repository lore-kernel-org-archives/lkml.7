Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B14EC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 18:51:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFB2920854
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 18:51:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oPsExYOt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbfCMSvW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 14:51:22 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39381 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbfCMSvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 14:51:21 -0400
Received: by mail-pf1-f193.google.com with SMTP id i20so2011368pfo.6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 11:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6YxfRY7ivmv+Dn9ItWpamf0fbtNROFoXEVByMZjWJA4=;
        b=oPsExYOtvI5BfW9N5p2TxoA3Xuh9aJ+XkGwt4y3EbxgJ+zxKlpAmndQalqCyfqGEGP
         E7WPHYvNn7c1lp0Ig9sHilenD26Dim0TGC77kbUy8cGj3rTIDNtZ3gipTVs4C6r4CjVj
         MG3yNUJL9qEKO5aoT7X9cSaCZuLjYk6rSutTRcgVQqmlfNP9Nnf+gM5WcLMOYVQ4LYZ7
         lOpTdABY2DKpj851Ho47p7VdK4KXCbL/72X9dDC1XDUlOxu0e/m3bRd3kVwRB88udbee
         Zhyh/HojNLiIFWMPa8wSHZKuYGYcyaVZYRjNucgb0SWhFIGZYOykdjF1aFROCNTVkcsB
         94yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6YxfRY7ivmv+Dn9ItWpamf0fbtNROFoXEVByMZjWJA4=;
        b=uJoap/J/eblol8iS2vqxFIeZySv/pe+NVtiJw2kXWx+J937lUnza7miKm6D1OkYVhJ
         QfjRPMU4VeO46I3yiXGCTQeZu7KZuLr572CdkXkR9whJqiKOKCzcdhNr7oOExnrR/u6c
         0DEQlWV1RYDxvJGXhK7olVdeZqQRlqmoCNpTV2QykTsrPr0jjtwStcMtus1jm1Ff5yFG
         1DWCuMK9M2yTWtqcJmTpaNPcarz/DovgngWZYOMZmArHXJcSia6Kze6JOcLeKXc2X526
         1ZnAXLvQam2SHHe115LU8xyeNh6k0ru+f6OVpebwQvY9eDzpfQ9SqkoqnANtjCtQP9DJ
         knEg==
X-Gm-Message-State: APjAAAVijTmrge1TrYxIGvAbKbHNdpdbAoSb0Dsj+nhPTH6YLQtsw4d5
        eQiMRGawOnWA5OvHixAVeIFTQhv1Hjafya+MAcUAQg==
X-Google-Smtp-Source: APXvYqxlwGoVztMsuEQkx+N++WkCWIXdn7z+NQJHSFaAGseuJf4vWcVjPVTqZifQN0mzd59LpVbnTefXemSSIrI7Cr4=
X-Received: by 2002:a17:902:e85:: with SMTP id 5mr47465496plx.13.1552503080226;
 Wed, 13 Mar 2019 11:51:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAKwvOdmdEH1U9vOmVKo2Fn+hMPF9AB1enZ2rkpJcU9XHgR8Wng@mail.gmail.com>
 <20190313181719.87859-1-ndesaulniers@google.com> <20190313144013.37cab5c7@gandalf.local.home>
In-Reply-To: <20190313144013.37cab5c7@gandalf.local.home>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 13 Mar 2019 11:51:09 -0700
Message-ID: <CAKwvOdnheUi6Ho5u4akTLGa-tBeUq94hQJH0+a4ROe_aEUgo7g@mail.gmail.com>
Subject: Re: [PATCH v2] lib/string.c: implement a basic bcmp
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        clang-built-linux@googlegroups.com,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        "# 3.4.x" <stable@vger.kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Adhemerval Zanella <adhemerval.zanella@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        James Y Knight <jyknight@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2019 at 11:40 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Wed, 13 Mar 2019 11:17:15 -0700
> Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> > +#ifndef __HAVE_ARCH_BCMP
> > +/**
> > + * bcmp - Like memcmp but a non-zero return code simply indicates a non-match.
> > + * @cs: One area of memory.
> > + * @ct: Another area of memory.
> > + * @count: The size of the areas.
> > + */
> > +#undef bcmp
> > +int bcmp(const void *cs, const void *ct, size_t count)
> > +{
> > +     return memcmp(cs, ct, count);
>
> This is confusing where the comment says "like memcmp but .." and then
> just returns memcmp() unmodified. If anything, I would expect to see
>
>         return !!memcmp(cs, ct, conut);

That's more work than strictly needed. memcmp already provides the
semantics of bcmp.  memcmp just provides more meaning to the
signedness of the return code, whereas bcmp does not.

>
> or have a better comment explaining why its the same.

I could add something about "the signedness of the return code not
providing any meaning."  What would you like to see in such a comment?
-- 
Thanks,
~Nick Desaulniers
