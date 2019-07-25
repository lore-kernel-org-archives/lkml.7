Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C08CC7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 06:17:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1060721850
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 06:17:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KXuSpQ3R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729088AbfGYGR3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 02:17:29 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55989 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727455AbfGYGR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 02:17:29 -0400
Received: by mail-wm1-f65.google.com with SMTP id a15so43792820wmj.5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 23:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=SzxCqlcNQ6D/PXRgJlqf5N+S31sDfHsDb/3gkPnk7H4=;
        b=KXuSpQ3R0mukq3k5Zz8pHExmtrW7gK04tthYlnxlUkHLk4yfUcs81h2z/M4jC31GWo
         al1/qQNZex95vvQhPuJKyybhUIgR3LcJAMwqjoamutxBC/idk3pBVY68GE5a4teOsEuA
         JmfLih4oiIHLhBPS0ks+7ScwgP3TmYNYF+fUseWNlX8JDHVi4ghmuzFAPMIumjA8dGNy
         6WKnq7UI7Q6pPVkLOf2fAR59SqfoxeTzkFGDJsMLgNDNVrSzIGtOIUXmRAe6kK9D4mw7
         duF3aJtIZksvsYboAarMbK/5gVltEHRNJvxy1/pwI5t7xEyX4uRoHskfqGpwvCe4/q6Z
         0o2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=SzxCqlcNQ6D/PXRgJlqf5N+S31sDfHsDb/3gkPnk7H4=;
        b=tLK3nD9NOYYbCRTXkHoj76AQDzw0rvT2Q7rcOoVp55vX57pGFBScsUpTco7Ela+hyz
         5YemwQThKNJaYe8RVUrWUXZcrksnsazOyex4IKK18wqlvr50WFErrxiPmzXw6DZtFZY2
         x+Rw+F7ZeDcbSPVpEutLnyjGQ8T7bl0/Cu2LQxyjloJG3OayXUik2FXfXKrWkPWOZ21T
         eqHaHlUuHINcqWv4yi4DsaWKf6v/sIqnKNWDxPmgi4NrExYlOcxDsC2Z2iSdjhalDIi7
         6M7DfVtLevXfBdswUayKHX/01drZl7cE5/mD2IAnP1SRaT/FNmfqhl5j9CR8YRN/JbKI
         6p7A==
X-Gm-Message-State: APjAAAXwy0mqFfNlnEBEY8OdjZmFIl396JnbmrVt9ghfRItToFLHS0Mi
        EgNoRpAxF4S+9FzSYnX3CtST6Ka9tY6qFlxGHD8=
X-Google-Smtp-Source: APXvYqzC+to7nCQiCgdF7eSEcsqrkzDBHmrXrbVZE+VAlAc51SAWRf4rkSijNXnYzpIVvRiSmG+eV+4lcr3sg2s7e7E=
X-Received: by 2002:a05:600c:10ce:: with SMTP id l14mr75641329wmd.118.1564035447400;
 Wed, 24 Jul 2019 23:17:27 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.21.1907182223560.1785@nanos.tec.linutronix.de>
 <CA+icZUW5jNJY3L5EcxrtOttwpbdAWQ7=U_bZaLHcTogOdNuTcQ@mail.gmail.com>
 <CA+icZUUtNibYGbHEt+cqsu6cuKYF7=MobvPQ9mkXU1pJZhFw9w@mail.gmail.com> <CA+icZUVbYL9RkcVqU=Z0HJgn0U=hYStr30rQDaZ_rcBr27Cv6Q@mail.gmail.com>
In-Reply-To: <CA+icZUVbYL9RkcVqU=Z0HJgn0U=hYStr30rQDaZ_rcBr27Cv6Q@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Thu, 25 Jul 2019 08:17:16 +0200
Message-ID: <CA+icZUVC+4-QP5Wj2DUxAZ9wP_Ox311k-EUKkAsSL+8S_j2j1A@mail.gmail.com>
Subject: Re: x86 - clang / objtool status
To:     Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 5:40 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> On Fri, Jul 19, 2019 at 3:48 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> >
> > > First of all I find out that it is possible to download and apply the
> > > series (here: v2) from patchwork (see [1]).
> > > I highly appreciate to have this in Josh's Git [2].
> > >
> >
> > There it is.
> >
> > - sed@ -
> >
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/jpoimboe/linux.git/log/?h=objtool-many-fixes-v2
>
> next-20190722 has them.
>
> Parallely, I opened an CBL issue #617
> "drivers/gpu/drm/i915/gem/i915_gem_execbuffer.o: warning: objtool:
> .altinstr_replacement+0x86: redundant UACCESS disable"
>
> I hope Josh can look at this.
>
> - Sedat -
>
> [1] https://github.com/ClangBuiltLinux/linux/issues/617

The objtool warning is fixed by [1].

Now, I see only 3 objtool warnings (all "falls through to next function"):

drivers/gpu/drm/radeon/atom.o: warning: objtool: atom_op_move() falls
through to next function atom_op_and()
drivers/gpu/drm/radeon/evergreen_cs.o: warning: objtool:
evergreen_cs_parse() falls through to next function
evergreen_dma_cs_parse()
drivers/infiniband/hw/hfi1/platform.o: warning: objtool: tune_serdes()
falls through to next function apply_tx_lanes()

The other i915 call-trace I have seen was independent of $COMPILER and
the objtool warning (details see [2] and [3]).

I was able to boot into my system.

- Sedat -

[1] https://lore.kernel.org/patchwork/series/403494/mbox/
[2] https://lore.kernel.org/lkml/20190721142930.GA480@tigerII.localdomain/
[3] https://github.com/ClangBuiltLinux/linux/issues/617#issuecomment-514906560
