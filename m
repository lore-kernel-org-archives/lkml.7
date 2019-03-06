Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E96C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 06:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F284720675
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 06:28:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DLk9b524"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728907AbfCFG2f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 01:28:35 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39469 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726378AbfCFG2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 01:28:34 -0500
Received: by mail-ed1-f65.google.com with SMTP id p27so9322189edc.6
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2019 22:28:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UgvsFVEFEIm0Ah792Wt/GKnqyIOu7B8JgslYQMKcNHM=;
        b=DLk9b5243SH++rK8MAkLLkDbD7FEOpivI+HRG+/qfpEJLxj6neHs2qZhH1KM0xETm2
         TdOfUMoF1br7PbPU7gLuq0ET3UW0DqQhjG+5muOdrr95eqe6ok61i/SlmFmeo4mfL8Ag
         OADnISsljNX+uChrciqJriIWveZUt2+8hYWcE+wJF1XiR04spxLG6Botu09sByu03CVe
         hJvUIsK0I6iMIMyYjYIY/zY9STaT5MVvCuoIJMewEYMhmQwP4RI8JMtdhR9t4f6L/xmg
         uTXCSdG7E8sD3r/dr6TL3k4sM9If46GlCRplisTco5iu1w0TyyPmwSYBYmmq+h89Pj/K
         c0JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UgvsFVEFEIm0Ah792Wt/GKnqyIOu7B8JgslYQMKcNHM=;
        b=TU3/g+fn2zJg3n+1F+DYmcX/j/cK0U1JYQfqrnf2qg10Gs0AGd7Xzlz7z3zGD+a02Y
         8hg7z8IC1Fj9FRMR5YH9mEqeacBVXMrSiFu/5E9KtMlb4/rIjUFSelxVjHwamGBISg2F
         6vGzxgb9WmuPrwLyNUf2dhSvAN6a4beSbyupcieC/9FmH1eZUxTw+0wb20k7YlCwp3eS
         G+xSKcXV9A+r5uzo+PtOsgUZ1deO5rX4hppgMQubSVAbMrfJEf9gXwQF6N4a3BcU2cD4
         b+MLqf4G54zcKb5lNJx5wfTex7KvC/WBlzUy2/Y6MW7i5mh1U0ywlor57yDB4lHpI1JU
         eyRg==
X-Gm-Message-State: APjAAAU62WCAJrci28J3ZlxidVoI93qzNQojPlnqRZVDbCxV07F5M2wp
        H2Gq2gNahzy6+/zjL5zMDwDt2akCZnMMbpOPmQw=
X-Google-Smtp-Source: APXvYqwSY4NChPzbb73TCInYSJQrbr5QWd8yJpm8gX0HTzPpeAkJxI/PktHf7y27QXslQRI4uCL3drWJdGHQKsAvH8A=
X-Received: by 2002:a17:906:1c4b:: with SMTP id l11mr2758217ejg.20.1551853712788;
 Tue, 05 Mar 2019 22:28:32 -0800 (PST)
MIME-Version: 1.0
References: <20190109124044.GA11935@altlinux.org> <20190109124316.GH11981@altlinux.org>
 <20190227153034.GD23744@altlinux.org> <CAJsyPhzmJyJiwRSn0eB6g0BLYM0zpoSWJ=XfcBje6EJNGGQ1eA@mail.gmail.com>
In-Reply-To: <CAJsyPhzmJyJiwRSn0eB6g0BLYM0zpoSWJ=XfcBje6EJNGGQ1eA@mail.gmail.com>
From:   Greentime Hu <green.hu@gmail.com>
Date:   Wed, 6 Mar 2019 14:27:55 +0800
Message-ID: <CAEbi=3eFNF=nqUxu=kZO0wgd5EHSSAbZatGfiw90BNnOV0KZBw@mail.gmail.com>
Subject: Re: [PATCH 08/14] Move EM_NDS32 to uapi/linux/elf-em.h
To:     Vincent Chen <deanbo422@gmail.com>
Cc:     "Dmitry V. Levin" <ldv@altlinux.org>,
        Elvira Khabirova <lineprinter@altlinux.org>,
        Eugene Syromyatnikov <esyr@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Paul Moore <paul@paul-moore.com>, linux-audit@redhat.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vincent Chen <deanbo422@gmail.com> =E6=96=BC 2019=E5=B9=B43=E6=9C=885=E6=97=
=A5 =E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=888:26=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Dmitry V. Levin <ldv@altlinux.org> =E6=96=BC 2019=E5=B9=B42=E6=9C=8827=E6=
=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=8811:30=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
>
> >
> > This should never have been defined in the arch tree to begin with,
> > and now uapi/linux/audit.h header is going to use EM_NDS32
> > in order to define AUDIT_ARCH_NDS32 which is needed to implement
> > syscall_get_arch() which in turn is required to extend
> > the generic ptrace API with PTRACE_GET_SYSCALL_INFO request.
> >
> > Acked-by: Paul Moore <paul@paul-moore.com>
> > Cc: Greentime Hu <green.hu@gmail.com>
> > Cc: Vincent Chen <deanbo422@gmail.com>
> > Cc: Elvira Khabirova <lineprinter@altlinux.org>
> > Cc: Eugene Syromyatnikov <esyr@redhat.com>
> > Cc: Oleg Nesterov <oleg@redhat.com>
> > Cc: Andy Lutomirski <luto@kernel.org>
> > Cc: linux-audit@redhat.com
> > Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
> > ---
> >  This is just a gentle ping, the patch is unchanged.
> >
> >  arch/nds32/include/asm/elf.h | 3 +--
> >  include/uapi/linux/elf-em.h  | 2 ++
> >  2 files changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/nds32/include/asm/elf.h b/arch/nds32/include/asm/elf.=
h
> > index 95f3ea253e4c..02250626b9f0 100644
> > --- a/arch/nds32/include/asm/elf.h
> > +++ b/arch/nds32/include/asm/elf.h
> > @@ -10,14 +10,13 @@
> >
> >  #include <asm/ptrace.h>
> >  #include <asm/fpu.h>
> > +#include <linux/elf-em.h>
> >
> >  typedef unsigned long elf_greg_t;
> >  typedef unsigned long elf_freg_t[3];
> >
> >  extern unsigned int elf_hwcap;
> >
> > -#define EM_NDS32                       167
> > -
> >  #define R_NDS32_NONE                   0
> >  #define R_NDS32_16_RELA                        19
> >  #define R_NDS32_32_RELA                        20
> > diff --git a/include/uapi/linux/elf-em.h b/include/uapi/linux/elf-em.h
> > index bd02325028d8..4b8df722330e 100644
> > --- a/include/uapi/linux/elf-em.h
> > +++ b/include/uapi/linux/elf-em.h
> > @@ -40,6 +40,8 @@
> >  #define EM_ALTERA_NIOS2        113     /* Altera Nios II soft-core pro=
cessor */
> >  #define EM_TI_C6000    140     /* TI C6X DSPs */
> >  #define EM_HEXAGON     164     /* QUALCOMM Hexagon */
> > +#define EM_NDS32       167     /* Andes Technology compact code size
> > +                                  embedded RISC processor family */
> >  #define EM_AARCH64     183     /* ARM 64 bit */
> >  #define EM_TILEPRO     188     /* Tilera TILEPro */
> >  #define EM_MICROBLAZE  189     /* Xilinx MicroBlaze */
> > --
> > ldv
>
> Thanks for fixing this.
>
> Acked-by Vincent Chen

Thank you. I add his email address. :P

Acked-by: Vincent Chen <vincentc@andestech.com>
Acked-by: Greentime Hu <greentime@andestech.com>
