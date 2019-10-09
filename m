Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 711F2C47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 17:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4698E206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 17:34:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DSdoE+uZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732149AbfJIRd6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 13:33:58 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40639 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731922AbfJIRd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 13:33:58 -0400
Received: by mail-pg1-f194.google.com with SMTP id d26so1847989pgl.7
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 10:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=64S7upTOSmWG0FCz/0I/kvz+kUrhwKMMzAjL3YUfyOs=;
        b=DSdoE+uZ8L84E0Kcmx2jHsU0q/gI//xKqNOllvCfYRUntJA+pUlFzfJtSXTEcLXyX4
         j1EwkWD7j+gFVNlodHVCQYxqxjmF3q7orwFpAqRUEkSd4pdrjK798MkkMZX1wNZGUH9/
         Pw7IIbBkSkicTTKgr/5eE51cPxnC6i1khe24LxPRdLtgbzTjKL0eKDsEENONEeDCwTTr
         ZnTicT40oNjua9Qf63YTQTeTC0i45A8GkMa6t0POwzb+Q/e55Ghn8KzmzDWFWgIz4fk3
         3nZ9muHXPRbMvDgmr1Esod5fKkg/MiCLzRcsnSGTXsI4nTX3CU0vbpb+Y0o5ur5f+k1O
         VWiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=64S7upTOSmWG0FCz/0I/kvz+kUrhwKMMzAjL3YUfyOs=;
        b=pBKqikx/imtTBKR/R8LrwHDrwGaasF4cCWfEms0TeIXl2Wm5EeIWKUzGdzWPdXCwC3
         ELGZ/Xe4HATYg2Tg4TfQ8/3yJ8BDPG+s5qs6dFR6FrMaDw65LNyIZRv1p3UkPxE/EITX
         qoBf0+CVlBJ+TtTMA09Uj76nnMudE6O4edv2BIUlHtoq7ddIfjA8sysxB2rnN1G+HSXh
         s4sHfRi/Eyj0NW61XO5dmVsJgoXXRYaryH/ggSEBLh8x/RM2m/yI8xVNxxabriBaY3Ks
         9dEpOMqio4jzvwetevny+qyaDL0ynJtSRMmZAVPpaQ2HiRoWskLUMHp4vshQ9/nTVSYH
         PATA==
X-Gm-Message-State: APjAAAVaQgqeNLl8yW8EN69ddfJ84xJFhTPHuECQI8+pkbmlbeCJSiLI
        2qWxJLd1vG4zX7UVcol9aQkkyeCzCOkmE+bXpmyDvgsl6tE=
X-Google-Smtp-Source: APXvYqyYmowyP3iUTgyzvcK5h0aRQld1QATwfs+5wymVcbcvYv0z8ISTaj+tGweCKO4zq9qsyd9/i890PgqX3lydTWg=
X-Received: by 2002:a17:90a:aa81:: with SMTP id l1mr1002058pjq.73.1570642436661;
 Wed, 09 Oct 2019 10:33:56 -0700 (PDT)
MIME-Version: 1.0
References: <75f70e5e-9ece-d6d1-a2c5-2f3ad79b9ccb@web.de> <20191009110943.7ff3a08a@gandalf.local.home>
 <CAKwvOdk3OTaAVmbV9Cu+Dzg8zuojjU6ENZfu4cUPaKS2a58d3w@mail.gmail.com> <4d890cae9cbbd873096cb1fadb477cf4632ddb9a.camel@perches.com>
In-Reply-To: <4d890cae9cbbd873096cb1fadb477cf4632ddb9a.camel@perches.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 9 Oct 2019 10:33:45 -0700
Message-ID: <CAKwvOdntBXd3OPiCV5adcDjXor886-XnsSxcStAjYBJpuEBrqQ@mail.gmail.com>
Subject: Re: [PATCH] string.h: Mark 34 functions with __must_check
To:     Joe Perches <joe@perches.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Markus Elfring <Markus.Elfring@web.de>,
        kernel-janitors@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 9, 2019 at 9:38 AM Joe Perches <joe@perches.com> wrote:
>
> On Wed, 2019-10-09 at 09:13 -0700, Nick Desaulniers wrote:
> > On Wed, Oct 9, 2019 at 8:09 AM Steven Rostedt <rostedt@goodmis.org> wro=
te:
> > > On Wed, 9 Oct 2019 14:14:28 +0200 Markus Elfring <Markus.Elfring@web.=
de> wrote:
> []
> > > > Several functions return values with which useful data processing
> > > > should be performed. These values must not be ignored then.
> > > > Thus use the annotation =E2=80=9C__must_check=E2=80=9D in the shown=
 function declarations.
> []
> > > I'm curious. How many warnings showed up when you applied this patch?
> >
> > I got zero for x86_64 and arm64 defconfig builds of linux-next with
> > this applied.  Hopefully that's not an argument against the more
> > liberal application of it?  I view __must_check as a good thing, and
> > encourage its application, unless someone can show that a certain
> > function would be useful to call without it.
>
> stylistic trivia, neither agreeing nor disagreeing with the patch
> as I generally avoid reading Markus' patches.
>
> I believe __must_check is best placed before the return type as
> that makes grep for function return type easier to parse.
>
> i.e. prefer
>         [static inline] __must_check <type> <function>(<args...>);
> over
>         [static inline] <type> __must_check <function>(<args...>);
>

+ Miguel
So I just checked `__cold`, and `__cold` is all over the board in
style.  I see it:
1. before anything fs/btrfs/super.c#L101
2. after static before return type (what you recommend) fs/btrfs/super.c#L2=
318
3. after return type fs/btrfs/inode.c#L9426

Can we pick a style and enforce it via checkpatch? (It's probably not
fun to check for each function attribute in
include/linux/compiler_attributes.h).
--=20
Thanks,
~Nick Desaulniers
