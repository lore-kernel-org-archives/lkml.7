Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A31A7C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 19:22:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 733C7206A3
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 19:22:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U6CBJ1LR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728094AbfEHTWw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 15:22:52 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45323 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726687AbfEHTWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 15:22:51 -0400
Received: by mail-pf1-f193.google.com with SMTP id s11so672496pfm.12
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 12:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3g2bi8DoerOy6DCDToROZG2X91/sOCzGiRgK/q+dCis=;
        b=U6CBJ1LRLdPb3Cf3s1bn+pdqH+7H4s+pmJmwohKBFS8talsVMMM1XqTMw4/RcK1x6L
         +SZjTZQgjcJgbiH2XlWuiFr9eSvMmhMWdhrYa8trwijvhpkRvelG+CfaO51m4CWEERqk
         6J16ik7c42IhnOpPMBLhP8ivWUda2bPJb3wMM1kDyCre2Jlkra7waJcNPwvFAsa3PEVQ
         6EOZsgEesM6q6LCd+N5PUwc8l6Me60lY2ngewHEwqo59oniRyhZnkpARqFtJuicA2GoD
         5O2i5fQiykvipeYCnNnfD3pbwpaSTtFhpx2u6PEx9r64IJE5yKIGJOee+ChRaC6IMJST
         azUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3g2bi8DoerOy6DCDToROZG2X91/sOCzGiRgK/q+dCis=;
        b=W1lEVvR/nlzGEdTPaubqK5/EOemWm6pAmdTaltCZv1C3mniPhf/sn9Cikxw8ZwIAHT
         MNA5B/u3zH5RDeF+rNM9QCzFMowvu618MeCSNTGX/rWsBxZOFVfsyHzRIdmKF91hR7Ie
         JonYRIhsaNYaQ5LG9PizwmssrT/OjXpzpjm8rqMC1BCM9EOSTx/JiMLZIPu1lNeJCxHF
         P+JLf7fAmROzy9NsBXDLAbdNJdMHP47jCeJyPINtB/Xqa0X42k5WsYAFzoGWmkTRfRyS
         gKGLvUfP0Fp4edsQTmWuhIO+HxG0+iF0GT12DskJQp82urBbfAjnPgp7NHbhZW+bEkuQ
         Eg1g==
X-Gm-Message-State: APjAAAVXI1zDJbmQkixwYb7koa85Bzq9MLW6KlWkLM4tQyH87Jqu62+8
        54bVXWolfgktHupUYkN9KNKshzAKLilwwys7ARhd9Q==
X-Google-Smtp-Source: APXvYqw3BVt0fAl5bCwCS7AsCC+DFIQEahWkR5yAcgLO4mlm3JstHoA5kquAVbg6bd97XLzbvP3eYNLX03uzO7C20E4=
X-Received: by 2002:a63:441c:: with SMTP id r28mr30973408pga.255.1557343370469;
 Wed, 08 May 2019 12:22:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190423204821.241925-1-ndesaulniers@google.com> <CAKwvOd=ws1D95ydQjGtK0U0KQ-5poyj8Oek5Yka6-cvtCdpJ-g@mail.gmail.com>
In-Reply-To: <CAKwvOd=ws1D95ydQjGtK0U0KQ-5poyj8Oek5Yka6-cvtCdpJ-g@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 8 May 2019 12:22:39 -0700
Message-ID: <CAKwvOd=tA3-i65B_92QHaJrpEREzBB91QkkqgRANncwfb2d-Kg@mail.gmail.com>
Subject: Re: [PATCH] ia64: require -Wl,--hash-style=sysv
To:     tony.luck@intel.com, fenghua.yu@intel.com
Cc:     clang-built-linux <clang-built-linux@googlegroups.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-ia64@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bumping for review, as the merge window is now open.

On Tue, Apr 30, 2019 at 1:24 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Tue, Apr 23, 2019 at 1:48 PM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > Towards the goal of removing cc-ldoption, it seems that --hash-style=
> > was added to binutils 2.17.50.0.2 in 2006. The minimal required version
> > of binutils for the kernel according to
> > Documentation/process/changes.rst is 2.20.
> >
> > Link: https://gcc.gnu.org/ml/gcc/2007-01/msg01141.html
> > Cc: clang-built-linux@googlegroups.com
> > Suggested-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> > ---
> >  arch/ia64/kernel/Makefile.gate | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/ia64/kernel/Makefile.gate b/arch/ia64/kernel/Makefile.gate
> > index f53faf48b7ce..846867bff6d6 100644
> > --- a/arch/ia64/kernel/Makefile.gate
> > +++ b/arch/ia64/kernel/Makefile.gate
> > @@ -11,7 +11,7 @@ quiet_cmd_gate = GATE    $@
> >        cmd_gate = $(CC) -nostdlib $(GATECFLAGS_$(@F)) -Wl,-T,$(filter-out FORCE,$^) -o $@
> >
> >  GATECFLAGS_gate.so = -shared -s -Wl,-soname=linux-gate.so.1 \
> > -                    $(call cc-ldoption, -Wl$(comma)--hash-style=sysv)
> > +                    -Wl,--hash-style=sysv
> >  $(obj)/gate.so: $(obj)/gate.lds $(obj)/gate.o FORCE
> >         $(call if_changed,gate)
> >
> > --
> > 2.21.0.593.g511ec345e18-goog
> >
>
> bumping for review
>
> --
> Thanks,
> ~Nick Desaulniers



-- 
Thanks,
~Nick Desaulniers
