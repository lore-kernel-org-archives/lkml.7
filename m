Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A871FC7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 14:11:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 639C721880
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 14:11:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W5dFTmZf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728341AbfGZOLU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 10:11:20 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:35048 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727397AbfGZOLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 10:11:19 -0400
Received: by mail-lf1-f67.google.com with SMTP id p197so37158189lfa.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 07:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5375/eYD+teVgs8myc08Hg0r4foVjCEWpzZlGZgwvTY=;
        b=W5dFTmZfHWiAh/QWhQxjIPcVlNfiJWhuNNjmAytEgYyXT/M5s/PyhdTIrFzAvwXyoE
         pr6e5ZqoL2hR3i71NfQa0ojOcbxeOFQEihAwZoU5nJttafjiuEFu1DcbNJ39bqyCJwzh
         t5dHWLjmYNC1zDBvBrvkaRre1fnBCW94ycYUQVla3kVzz6MPum8OsqFweDQnwbMEk2dv
         XIsncO8K9r/BszhJhHeQhK7tc6AzDqBrbLCmYZ0CEQNXuS6Ap0JMN/faMtHLeOne/TJ0
         D0YizyvxI2PPGJ5MT7yAAVLcabdPqNfqcZxNjcPR31vWPGuqqXpKmaaijvMYvcDhTDYK
         aSvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5375/eYD+teVgs8myc08Hg0r4foVjCEWpzZlGZgwvTY=;
        b=h3YdnA64F3Jou5Qv55jLrU8xdkwCPq5fzmrD3etDYIfqeX0kpqmWpzyAGDjaqwC27f
         39HfAneKlux/ojF6fgD43vGfwj27ZpVFNytrEnSjQSGlumB0ZmBXwbQCR3E3TKawyxvo
         SYv1tPKzmnXt+2VG+3b2E/2sLdV1SIRto4OdUTBw6meaZNtuqELcCAeAMQz4M3mzB/hW
         4417uLhC6oSGL0zAP/jqTstBetnCgVRy0TpJJSro+IKFVtZMSgQn1MjHg4+cQ+35jcy+
         n3VGhq2EXirVYQVzty/2drY4hui64s4AVogeQjSSqOiUPsH3Apc1KMosC/pLvLNl2M6E
         rkbg==
X-Gm-Message-State: APjAAAXgqKYSBkMsPVdwX5FUR37/ozGe6wY9l5q9Ah1UShoOp3kcK6te
        U3HhmHnAANompIJmrifwbXURfUzCH+X/UAPYISVgxA==
X-Google-Smtp-Source: APXvYqzMgQAbRUdF6wQfNbEPaSg6/IktcAeJvaYlRdgeSXtPSwva+MvNu1bwGkYWd6Rni5sD4rhYSBUiheJB1QWdbtU=
X-Received: by 2002:ac2:46d5:: with SMTP id p21mr11936228lfo.133.1564150276602;
 Fri, 26 Jul 2019 07:11:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190726112710.19051-1-anders.roxell@linaro.org> <86d0hxnfif.wl-marc.zyngier@arm.com>
In-Reply-To: <86d0hxnfif.wl-marc.zyngier@arm.com>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Fri, 26 Jul 2019 16:11:05 +0200
Message-ID: <CADYN=9KmNwsP7TDkf30xCa8ARVzQ_q=-v8cwkFueQ+NT-9JdyQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: KVM: hyp: debug-sr: Mark expected switch fall-through
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>, will@kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        kvmarm@lists.cs.columbia.edu,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Jul 2019 at 14:31, Marc Zyngier <marc.zyngier@arm.com> wrote:
>
> On Fri, 26 Jul 2019 12:27:10 +0100,
> Anders Roxell <anders.roxell@linaro.org> wrote:
> >
> > When fall-through warnings was enabled by default the following warning=
s
> > was starting to show up:
> >
> > ../arch/arm64/kvm/hyp/debug-sr.c: In function =E2=80=98__debug_save_sta=
te=E2=80=99:
> > ../arch/arm64/kvm/hyp/debug-sr.c:20:19: warning: this statement may fal=
l
> >  through [-Wimplicit-fallthrough=3D]
> >   case 15: ptr[15] =3D read_debug(reg, 15);   \
> > ../arch/arm64/kvm/hyp/debug-sr.c:113:2: note: in expansion of macro =E2=
=80=98save_debug=E2=80=99
> >   save_debug(dbg->dbg_bcr, dbgbcr, brps);
> >   ^~~~~~~~~~
> > ../arch/arm64/kvm/hyp/debug-sr.c:21:2: note: here
> >   case 14: ptr[14] =3D read_debug(reg, 14);   \
> >   ^~~~
> > ../arch/arm64/kvm/hyp/debug-sr.c:113:2: note: in expansion of macro =E2=
=80=98save_debug=E2=80=99
> >   save_debug(dbg->dbg_bcr, dbgbcr, brps);
> >   ^~~~~~~~~~
> > ../arch/arm64/kvm/hyp/debug-sr.c:21:19: warning: this statement may fal=
l
> >  through [-Wimplicit-fallthrough=3D]
> >   case 14: ptr[14] =3D read_debug(reg, 14);   \
> > ../arch/arm64/kvm/hyp/debug-sr.c:113:2: note: in expansion of macro =E2=
=80=98save_debug=E2=80=99
> >   save_debug(dbg->dbg_bcr, dbgbcr, brps);
> >   ^~~~~~~~~~
> > ../arch/arm64/kvm/hyp/debug-sr.c:22:2: note: here
> >   case 13: ptr[13] =3D read_debug(reg, 13);   \
> >   ^~~~
> > ../arch/arm64/kvm/hyp/debug-sr.c:113:2: note: in expansion of macro =E2=
=80=98save_debug=E2=80=99
> >   save_debug(dbg->dbg_bcr, dbgbcr, brps);
> >   ^~~~~~~~~~
> >
> > Rework to add a 'break;' where the compiler warned about
> > fall-through.
>
> That's not what this patch does, I'm afraid.

urgh I'm sorry.
Sending a v2 shortly.

>
> Thanks,
>
>         M.
>
> >
> > Fixes: d93512ef0f0e ("Makefile: Globally enable fall-through warning")
> > Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> > ---
> >  arch/arm64/kvm/hyp/debug-sr.c | 30 ++++++++++++++++++++++++++++++
> >  1 file changed, 30 insertions(+)
> >
> > diff --git a/arch/arm64/kvm/hyp/debug-sr.c b/arch/arm64/kvm/hyp/debug-s=
r.c
> > index 26781da3ad3e..0fc9872a1467 100644
> > --- a/arch/arm64/kvm/hyp/debug-sr.c
> > +++ b/arch/arm64/kvm/hyp/debug-sr.c
> > @@ -18,40 +18,70 @@
> >  #define save_debug(ptr,reg,nr)                                        =
       \
> >       switch (nr) {                                                   \
> >       case 15:        ptr[15] =3D read_debug(reg, 15);                 =
 \
> > +                     /* Fall through */                              \
> >       case 14:        ptr[14] =3D read_debug(reg, 14);                 =
 \
> > +                     /* Fall through */                              \
> >       case 13:        ptr[13] =3D read_debug(reg, 13);                 =
 \
> > +                     /* Fall through */                              \
> >       case 12:        ptr[12] =3D read_debug(reg, 12);                 =
 \
> > +                     /* Fall through */                              \
> >       case 11:        ptr[11] =3D read_debug(reg, 11);                 =
 \
> > +                     /* Fall through */                              \
> >       case 10:        ptr[10] =3D read_debug(reg, 10);                 =
 \
> > +                     /* Fall through */                              \
> >       case 9:         ptr[9] =3D read_debug(reg, 9);                   =
 \
> > +                     /* Fall through */                              \
> >       case 8:         ptr[8] =3D read_debug(reg, 8);                   =
 \
> > +                     /* Fall through */                              \
> >       case 7:         ptr[7] =3D read_debug(reg, 7);                   =
 \
> > +                     /* Fall through */                              \
> >       case 6:         ptr[6] =3D read_debug(reg, 6);                   =
 \
> > +                     /* Fall through */                              \
> >       case 5:         ptr[5] =3D read_debug(reg, 5);                   =
 \
> > +                     /* Fall through */                              \
> >       case 4:         ptr[4] =3D read_debug(reg, 4);                   =
 \
> > +                     /* Fall through */                              \
> >       case 3:         ptr[3] =3D read_debug(reg, 3);                   =
 \
> > +                     /* Fall through */                              \
> >       case 2:         ptr[2] =3D read_debug(reg, 2);                   =
 \
> > +                     /* Fall through */                              \
> >       case 1:         ptr[1] =3D read_debug(reg, 1);                   =
 \
> > +                     /* Fall through */                              \
> >       default:        ptr[0] =3D read_debug(reg, 0);                   =
 \
> >       }
> >
> >  #define restore_debug(ptr,reg,nr)                                    \
> >       switch (nr) {                                                   \
> >       case 15:        write_debug(ptr[15], reg, 15);                  \
> > +                     /* Fall through */                              \
> >       case 14:        write_debug(ptr[14], reg, 14);                  \
> > +                     /* Fall through */                              \
> >       case 13:        write_debug(ptr[13], reg, 13);                  \
> > +                     /* Fall through */                              \
> >       case 12:        write_debug(ptr[12], reg, 12);                  \
> > +                     /* Fall through */                              \
> >       case 11:        write_debug(ptr[11], reg, 11);                  \
> > +                     /* Fall through */                              \
> >       case 10:        write_debug(ptr[10], reg, 10);                  \
> > +                     /* Fall through */                              \
> >       case 9:         write_debug(ptr[9], reg, 9);                    \
> > +                     /* Fall through */                              \
> >       case 8:         write_debug(ptr[8], reg, 8);                    \
> > +                     /* Fall through */                              \
> >       case 7:         write_debug(ptr[7], reg, 7);                    \
> > +                     /* Fall through */                              \
> >       case 6:         write_debug(ptr[6], reg, 6);                    \
> > +                     /* Fall through */                              \
> >       case 5:         write_debug(ptr[5], reg, 5);                    \
> > +                     /* Fall through */                              \
> >       case 4:         write_debug(ptr[4], reg, 4);                    \
> > +                     /* Fall through */                              \
> >       case 3:         write_debug(ptr[3], reg, 3);                    \
> > +                     /* Fall through */                              \
> >       case 2:         write_debug(ptr[2], reg, 2);                    \
> > +                     /* Fall through */                              \
> >       case 1:         write_debug(ptr[1], reg, 1);                    \
> > +                     /* Fall through */                              \
> >       default:        write_debug(ptr[0], reg, 0);                    \
> >       }
> >
> > --
> > 2.20.1
> >
>
> --
> Jazz is not dead, it just smells funny.
