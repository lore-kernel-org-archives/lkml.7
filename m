Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FFCCC31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 22:03:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEA342089E
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 22:03:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F2iKZ4lO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728312AbfHIWDn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 18:03:43 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40255 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbfHIWDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 18:03:43 -0400
Received: by mail-pg1-f193.google.com with SMTP id w10so46489723pgj.7
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2019 15:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4YE5LFpbQmY5CUf9HiiZAitomsRy44hXFJVcN3+uc3g=;
        b=F2iKZ4lOk3Ih5R8vAeqlbdrBc0o0/2oPVqnxRiWVqXjqSSkS0hpJwY8/YpKGOaysmn
         S7RZmGdJWCcjYz5bky70ydz7Ay2uw/D5UfOz58OF/e09ambmcuAy/7caWD6Gu/8MZQDD
         kVqtz0SfTVti/fNY1P+4wOxv9CyVCfKZW/JhCEIdShv7eyoDF0003q3Qz5cDaNO/oV+8
         ocxCDTmnNj6lX9aKWMtmKBid2xr8N7AmyTYIAQSf2rpqUIxrXM6haG3j8DFCDjmQTg9z
         YMtbBY7z9XoMpxQTQAeQanKoqciXuUF8/jLaNvyJvHQlxiHfytWc3UIpLanxf2sUkmtH
         mUHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4YE5LFpbQmY5CUf9HiiZAitomsRy44hXFJVcN3+uc3g=;
        b=WSDK/oRgphPETQ0YXKMW4TODcwqnWQDzUYybTvignEcY0eMIqYTn0aP+D3PfaR4rHB
         hKTrsMKhNGjFZIEPtC/yWyvm5CylOjcqhcGfKeGtKb/v33C9OZVVS7gc9mWrRmgRRWIi
         BBDTh9BiCj9oVoFOLe9yEHIZQO09TUvvgrNX6dz5F9acQeDK4FwVlqPED5kkvc35fUoH
         Wdk9BlLdXpdYk+GywmQ6olGp7foLRLQIQWJDuV7nq+egaWNlNiL80/lAHz/RdGYQZUpd
         gPoDuEkMa0i14BfaYK6duASxrrVrMGgULDFIDljUNQ8dUh9OgsC98gqB53wG653Y0jf9
         3H4Q==
X-Gm-Message-State: APjAAAWVuw/O+xh8XwXXQLyZDyBJEsHP19De710ZPJK+G4AZ2NvM1IGl
        aM5iNOm+stym2HfSorR6dQK0pk2Ix/YNKNSw8oiq1DvnVyl1bg==
X-Google-Smtp-Source: APXvYqzoA3qP5cLMx/N6kQkj8ONKAvUo3SkoeRrc9oKrOALvTgOH+HjnoEMS8kqTYGRPlpr+JSvGRCE1qbTPLaobk8c=
X-Received: by 2002:a63:61cd:: with SMTP id v196mr19675034pgb.263.1565388221708;
 Fri, 09 Aug 2019 15:03:41 -0700 (PDT)
MIME-Version: 1.0
References: <87h873zs88.fsf@concordia.ellerman.id.au> <20190809182106.62130-1-ndesaulniers@google.com>
 <CAK8P3a3LynWTbpV8=VPm2TqgNM2MnoEyCPJd0PL2D+tcZqJgHg@mail.gmail.com>
 <20190809220301.Horde.AR6y4Bx4WGIq58V9K0En9g4@messagerie.si.c-s.fr> <CAK8P3a1AwmAe+PpHTRmN153fhG4ZkF_pb+240rj1ZAg-S6SKeg@mail.gmail.com>
In-Reply-To: <CAK8P3a1AwmAe+PpHTRmN153fhG4ZkF_pb+240rj1ZAg-S6SKeg@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 9 Aug 2019 15:03:30 -0700
Message-ID: <CAKwvOdmhUPTUPa3=_AQ04zEDTsScduqOM29TfK656riAb_t=rQ@mail.gmail.com>
Subject: Re: [PATCH] powerpc: fix inline asm constraints for dcbz
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Christophe Leroy <christophe.leroy@c-s.fr>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        kbuild test robot <lkp@intel.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 9, 2019 at 1:13 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Fri, Aug 9, 2019 at 10:02 PM Christophe Leroy
> <christophe.leroy@c-s.fr> wrote:
> >
> > Arnd Bergmann <arnd@arndb.de> a =C3=A9crit :
> > > On Fri, Aug 9, 2019 at 8:21 PM 'Nick Desaulniers' via Clang Built
> > > Linux <clang-built-linux@googlegroups.com> wrote:
> > >
> > >>  static inline void dcbz(void *addr)
> > >>  {
> > >> -       __asm__ __volatile__ ("dcbz %y0" : : "Z"(*(u8 *)addr) : "mem=
ory");
> > >> +       __asm__ __volatile__ ("dcbz %y0" : "=3DZ"(*(u8 *)addr) :: "m=
emory");
> > >>  }
> > >>
> > >>  static inline void dcbi(void *addr)
> > >>  {
> > >> -       __asm__ __volatile__ ("dcbi %y0" : : "Z"(*(u8 *)addr) : "mem=
ory");
> > >> +       __asm__ __volatile__ ("dcbi %y0" : "=3DZ"(*(u8 *)addr) :: "m=
emory");
> > >>  }
> > >
> > > I think the result of the discussion was that an output argument only=
 kind-of
> > > makes sense for dcbz, but for the others it's really an input, and cl=
ang is
> > > wrong in the way it handles the "Z" constraint by making a copy, whic=
h it
> > > doesn't do for "m".
> > >
> > > I'm not sure whether it's correct to use "m" instead of "Z" here, whi=
ch
> > > would be a better workaround if that works. More importantly though,
> > > clang really needs to be fixed to handle "Z" correctly.
> >
> > As the benefit is null, I think the best is probably to reverse my
> > original commit until at least CLang is fixed, as initialy suggested
> > by mpe
>
> Yes, makes sense.
>
> There is one other use of the "Z" constraint, so on top of the revert, I
> think it might be helpful if Nick could check if the patch below makes
> any difference with clang and, if it does, whether the current version
> is broken.
>
>        Arnd
>
> diff --git a/arch/powerpc/include/asm/io.h b/arch/powerpc/include/asm/io.=
h
> index 23e5d5d16c7e..28b467779328 100644
> --- a/arch/powerpc/include/asm/io.h
> +++ b/arch/powerpc/include/asm/io.h
> @@ -106,7 +106,7 @@ static inline u##size name(const volatile u##size
> __iomem *addr)    \
>  {                                                                      \
>         u##size ret;                                                    \
>         __asm__ __volatile__("sync;"#insn" %0,%y1;twi 0,%0,0;isync"     \
> -               : "=3Dr" (ret) : "Z" (*addr) : "memory");                =
 \
> +               : "=3Dr" (ret) : "m" (*addr) : "memory");                =
 \
>         return ret;                                                     \
>  }
>
> @@ -114,7 +114,7 @@ static inline u##size name(const volatile u##size
> __iomem *addr)    \
>  static inline void name(volatile u##size __iomem *addr, u##size val)   \
>  {                                                                      \
>         __asm__ __volatile__("sync;"#insn" %1,%y0"                      \
> -               : "=3DZ" (*addr) : "r" (val) : "memory");                =
 \
> +               : "=3Dm" (*addr) : "r" (val) : "memory");                =
 \
>         mmiowb_set_pending();                                           \
>  }

Does not work:
https://travis-ci.com/ClangBuiltLinux/continuous-integration/builds/1226548=
99
https://github.com/ClangBuiltLinux/continuous-integration/pull/197/files#di=
ff-40bd16e3188587e4d648c30e0c2d6d37

--=20
Thanks,
~Nick Desaulniers
