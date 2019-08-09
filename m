Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C569DC31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 20:13:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E28D20B7C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 20:13:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbfHIUNN convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 16:13:13 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:33741 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725927AbfHIUNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 16:13:13 -0400
Received: by mail-qt1-f195.google.com with SMTP id v38so4653021qtb.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2019 13:13:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GbPWtVLcWUFZEanEykp/OCGxgAAWNiMhq/BzUwSZwpc=;
        b=Pfzv3Vx5kuVq9FwniEfM9fybl5j2vplgWPZHj3YsngCwPcRPIen54GkZxGk8idsHDg
         pYXCkFPxstZlTyXMMxSTdQcspaNQWVrV+tyu2DNY79C1Zmx3FXCR2b4OQn3nHwkdywOR
         6+GjY7qaR7ggnrAN/Gkh1Fjy5lcYEqBNDdlZckTh1zHyZ6/+UkUpUJRd3loZwTOwgdOy
         52J6BqTzQCnHImUev4yF5S3UQ8SkpHBlSqydheph6OgruWw0FK5FPBeLGapleWHt4VeU
         g0kjgDLs8gWmuHa6GwnLOy9e2MOdUt07oMEF4cRQ+CowPZnG4e0htzTor9mPARHw1TVt
         aLVg==
X-Gm-Message-State: APjAAAW+OJVF5z1pvoSHy+1mql/DkCzGm0tH5+CO434YRz3yKTxh27v3
        4Rt8fhgIejB2yEqN/6IWMQMq1nwZEsA+VexkPeA=
X-Google-Smtp-Source: APXvYqyk3q8MhchB1R6AFYNT+9FpyBYbsPgBvN9+GrgESLIDnDfEbrh9okrGG2cC4n/YagmVVq76vmcA8yBUqOX0j7Y=
X-Received: by 2002:a0c:ba2c:: with SMTP id w44mr19391116qvf.62.1565381592182;
 Fri, 09 Aug 2019 13:13:12 -0700 (PDT)
MIME-Version: 1.0
References: <87h873zs88.fsf@concordia.ellerman.id.au> <20190809182106.62130-1-ndesaulniers@google.com>
 <CAK8P3a3LynWTbpV8=VPm2TqgNM2MnoEyCPJd0PL2D+tcZqJgHg@mail.gmail.com> <20190809220301.Horde.AR6y4Bx4WGIq58V9K0En9g4@messagerie.si.c-s.fr>
In-Reply-To: <20190809220301.Horde.AR6y4Bx4WGIq58V9K0En9g4@messagerie.si.c-s.fr>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 9 Aug 2019 22:12:56 +0200
Message-ID: <CAK8P3a1AwmAe+PpHTRmN153fhG4ZkF_pb+240rj1ZAg-S6SKeg@mail.gmail.com>
Subject: Re: [PATCH] powerpc: fix inline asm constraints for dcbz
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     clang-built-linux <clang-built-linux@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        kbuild test robot <lkp@intel.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 9, 2019 at 10:02 PM Christophe Leroy
<christophe.leroy@c-s.fr> wrote:
>
> Arnd Bergmann <arnd@arndb.de> a écrit :
> > On Fri, Aug 9, 2019 at 8:21 PM 'Nick Desaulniers' via Clang Built
> > Linux <clang-built-linux@googlegroups.com> wrote:
> >
> >>  static inline void dcbz(void *addr)
> >>  {
> >> -       __asm__ __volatile__ ("dcbz %y0" : : "Z"(*(u8 *)addr) : "memory");
> >> +       __asm__ __volatile__ ("dcbz %y0" : "=Z"(*(u8 *)addr) :: "memory");
> >>  }
> >>
> >>  static inline void dcbi(void *addr)
> >>  {
> >> -       __asm__ __volatile__ ("dcbi %y0" : : "Z"(*(u8 *)addr) : "memory");
> >> +       __asm__ __volatile__ ("dcbi %y0" : "=Z"(*(u8 *)addr) :: "memory");
> >>  }
> >
> > I think the result of the discussion was that an output argument only kind-of
> > makes sense for dcbz, but for the others it's really an input, and clang is
> > wrong in the way it handles the "Z" constraint by making a copy, which it
> > doesn't do for "m".
> >
> > I'm not sure whether it's correct to use "m" instead of "Z" here, which
> > would be a better workaround if that works. More importantly though,
> > clang really needs to be fixed to handle "Z" correctly.
>
> As the benefit is null, I think the best is probably to reverse my
> original commit until at least CLang is fixed, as initialy suggested
> by mpe

Yes, makes sense.

There is one other use of the "Z" constraint, so on top of the revert, I
think it might be helpful if Nick could check if the patch below makes
any difference with clang and, if it does, whether the current version
is broken.

       Arnd

diff --git a/arch/powerpc/include/asm/io.h b/arch/powerpc/include/asm/io.h
index 23e5d5d16c7e..28b467779328 100644
--- a/arch/powerpc/include/asm/io.h
+++ b/arch/powerpc/include/asm/io.h
@@ -106,7 +106,7 @@ static inline u##size name(const volatile u##size
__iomem *addr)    \
 {                                                                      \
        u##size ret;                                                    \
        __asm__ __volatile__("sync;"#insn" %0,%y1;twi 0,%0,0;isync"     \
-               : "=r" (ret) : "Z" (*addr) : "memory");                 \
+               : "=r" (ret) : "m" (*addr) : "memory");                 \
        return ret;                                                     \
 }

@@ -114,7 +114,7 @@ static inline u##size name(const volatile u##size
__iomem *addr)    \
 static inline void name(volatile u##size __iomem *addr, u##size val)   \
 {                                                                      \
        __asm__ __volatile__("sync;"#insn" %1,%y0"                      \
-               : "=Z" (*addr) : "r" (val) : "memory");                 \
+               : "=m" (*addr) : "r" (val) : "memory");                 \
        mmiowb_set_pending();                                           \
 }
