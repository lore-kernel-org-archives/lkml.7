Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03B12C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 23:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9BE62086A
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 23:44:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XSaBvr71"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407233AbfITXow (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 19:44:52 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38404 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407211AbfITXou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 19:44:50 -0400
Received: by mail-pl1-f195.google.com with SMTP id w10so3918827plq.5
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 16:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lqDIHj9lZasR/zDtsnve221vNIVF3/3BuxETCeMHCc4=;
        b=XSaBvr71r6CXxRkl47+im5CtQOOiRKY/iuu1X/oF7O0195aBtQdo4E6H31j2DRdwMB
         s+h2SbgX6KwCSKPN/vksW+oTjyn/PocXCe2Kbp7D50FyleyNJKKiDms9wE4+010NuDGz
         Tq75Lq2/Of0H+EgT6rh/B7HmjzNMrYZDTILOvyQjFxsnvmyOoLNZmh4oqM1yuhhFP8pe
         sRZaN6hX2UO3lPWFmdzLQbJnBe69O1mU2qIHiv3K3roTU3fxgbwZK3OKCga8hxSzWAhk
         hBJHVhNvM+mzWFILJB/Im3xuyQ/V1FTP6vSQ4wkxN1OHoJdGyrC0V7kg/MssknjtxoVt
         FgJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lqDIHj9lZasR/zDtsnve221vNIVF3/3BuxETCeMHCc4=;
        b=o5nTMGChkx6w77IfOi+PRD0og9Nd7CLSQfVqu8pkzKUCJL4FrMcwpRIVZVqNE84BUJ
         jVCSG/AA81R+Lez89CLj3oTpTSOmL0j0MCvyAJg06MCyb/N1dJNUccQEUDYSgIjAAnB3
         K+xG8siaKV2mh7yvbnsPj9e3wngffSCBnNLUi4J+6TUlojxkCexM78vYgvPwncO7pv1X
         ZTQTWEnxnqCTvVpKev92+OZ/yT8OlgiR6W1wHDCsCwUh7U25JaoFt3LhHCKwoJFx8mqv
         UtRi5sNuhrL2CSkxzAoTxGsf3jaN8FgYqR8+NJLUb1kkdEu8UkF6iO4PaE9va82hD6+s
         LP7g==
X-Gm-Message-State: APjAAAWjB4WNsyMOwW2hcn5ZZwmmgKTLkGABANl2+MSP5yc0ERxLhYl+
        KzjS2UbIYBE1Kup/yipm9uJpi3oQNgnGDLza2oLQDQ==
X-Google-Smtp-Source: APXvYqyNiRlbO6R3uG9HEH5vDFWKxf6oFNbwaLwTM4FngoMH0rrK0KW2vni8a9ARb9jmWGlDeibYyIhP8RN53cwInWk=
X-Received: by 2002:a17:902:ff0e:: with SMTP id f14mr19947847plj.325.1569023089386;
 Fri, 20 Sep 2019 16:44:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190920231923.141900-1-brendanhiggins@google.com>
 <20190920231923.141900-7-brendanhiggins@google.com> <20190920233600.48BBA20644@mail.kernel.org>
In-Reply-To: <20190920233600.48BBA20644@mail.kernel.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Fri, 20 Sep 2019 16:44:38 -0700
Message-ID: <CAFd5g46pndA_gOD9i8M5e5fb8x4mSL9mcgMDujN7XufeFs8bmQ@mail.gmail.com>
Subject: Re: [PATCH v16 06/19] lib: enable building KUnit in lib/
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Kees Cook <keescook@google.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Rob Herring <robh@kernel.org>, shuah <shuah@kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        devicetree <devicetree@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        kunit-dev@googlegroups.com,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-um@lists.infradead.org,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        "Bird, Timothy" <Tim.Bird@sony.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Daniel Vetter <daniel@ffwll.ch>, Jeff Dike <jdike@addtoit.com>,
        Joel Stanley <joel@jms.id.au>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Kevin Hilman <khilman@baylibre.com>,
        Knut Omang <knut.omang@oracle.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Petr Mladek <pmladek@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        David Rientjes <rientjes@google.com>,
        Steven Rostedt <rostedt@goodmis.org>, wfg@linux.intel.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 20, 2019 at 4:36 PM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Brendan Higgins (2019-09-20 16:19:10)
> > KUnit is a new unit testing framework for the kernel and when used is
> > built into the kernel as a part of it. Add KUnit to the lib Kconfig and
> > Makefile to allow it to be actually built.
> >
> > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > Cc: Randy Dunlap <rdunlap@infradead.org>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> > Cc: Kees Cook <keescook@chromium.org>
> > ---
> >  lib/Kconfig.debug | 2 ++
> >  lib/Makefile      | 2 ++
> >  2 files changed, 4 insertions(+)
> >
> > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > index 5960e2980a8a..5870fbe11e9b 100644
> > --- a/lib/Kconfig.debug
> > +++ b/lib/Kconfig.debug
> > @@ -2144,4 +2144,6 @@ config IO_STRICT_DEVMEM
> >
> >  source "arch/$(SRCARCH)/Kconfig.debug"
> >
> > +source "lib/kunit/Kconfig"
> > +
>
> Perhaps this should go by the "Runtime Testing" part? Before or after.

Yeah, that probably makes sense.

> >  endmenu # Kernel hacking
