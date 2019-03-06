Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2875C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 06:27:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1C6820675
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 06:27:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iHx/ENzF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728866AbfCFG1U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 01:27:20 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42386 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726378AbfCFG1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 01:27:20 -0500
Received: by mail-ed1-f66.google.com with SMTP id j89so9320958edb.9
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2019 22:27:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KAz1j7ZgMDWsDqyOoRcJ0Kmrp0PiQSqZKVbb56djSsE=;
        b=iHx/ENzFiOIDaQKybcPUnHshb7H84D7nhkZurR5vb/MSsjtlMc/qMwdprLaEB9jK6E
         JMLe0aSbhCwNUrkDjS4KSkNaa98w6jeKSogjXDl+4hHm69EG6snwtZFpk+hhnsGaZ/9F
         LpWR9xo9m8W8KJ//y/Mo4hB5KOJ6SjBvcPlV+qa5bZmOK9oeS4wTRYE/s+6dMyhMEZ6K
         KIfsJNoUxjpUqQNpYYFgF75m2pGpYiXnCHrxB1m/Z0RY4crn8/M8C5ItA5AEvZp1HifO
         iMc6rKBn+jeKTk2SCzwMXdbw25TY6U4PmhZD2F0K6vcmYX/B0uGnJrsQZb5LykItfQS5
         13oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KAz1j7ZgMDWsDqyOoRcJ0Kmrp0PiQSqZKVbb56djSsE=;
        b=Dqm6naNV4aVyWd2Ob0hptBMcQhNqQRkvOMnT3no044cRZPRR9J84tgO1nWDPf/ByF4
         JayfrsvsBTFhDmUPo9klyWW7eLGQEeOIdWdmQoFYlpZz/bCcvJYqzM8wDxWKJHsKCB6h
         6lJxeScey3JNNG86JXuavdvFm3rCZLaW1sT5mdASIQ1odLv8xjZIyenDWLa4e0Yp/Jrh
         r3dfsR/RG9AwaT5OK6TXe4nKRXAPRW82rPIS5cGeLJ2jJglRCWPurjrHzuof6/PRjf4v
         NqPJzb6zuuX+bLUnFNY34vxI4FhTo41Uq6vVU2xsDAdv56CycgMhlR8Fd2/FZOQCm4p9
         aBzQ==
X-Gm-Message-State: APjAAAUij8d1X4x09BLePqH3knPamVg8ay5uZ/hLDwz9zaWbdJi9oVEt
        k0TQ+V1mNJWKAL68+myzr7Hc8lgvAlpv/PoW8Og=
X-Google-Smtp-Source: APXvYqy+6/B4xkZpU3/f/JTTzPgkNfThZipO0DG9fe91PaHaelCSHDhnv7sTSSM5zCT7FfBB0UciCRsuURh3VHfKks4=
X-Received: by 2002:a17:906:90c5:: with SMTP id v5mr2817754ejw.173.1551853637592;
 Tue, 05 Mar 2019 22:27:17 -0800 (PST)
MIME-Version: 1.0
References: <20190109124044.GA11935@altlinux.org> <20190109124320.GI11981@altlinux.org>
 <20190227153051.GE23744@altlinux.org> <CAJsyPhxEX-LttRC+F4a+jE3uyjMCFLhHW6=O35W9eQNWjK8ODQ@mail.gmail.com>
In-Reply-To: <CAJsyPhxEX-LttRC+F4a+jE3uyjMCFLhHW6=O35W9eQNWjK8ODQ@mail.gmail.com>
From:   Greentime Hu <green.hu@gmail.com>
Date:   Wed, 6 Mar 2019 14:26:39 +0800
Message-ID: <CAEbi=3edb5Z=6EKGpa7XGgSY_LYsy5vf0-Nivj9HSOy949io1A@mail.gmail.com>
Subject: Re: [PATCH 09/14] nds32: define syscall_get_arch()
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
=A5 =E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=887:50=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Dmitry V. Levin <ldv@altlinux.org> =E6=96=BC 2019=E5=B9=B42=E6=9C=8827=E6=
=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=8811:30=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> >
> > syscall_get_arch() is required to be implemented on all architectures
> > in addition to already implemented syscall_get_nr(),
> > syscall_get_arguments(), syscall_get_error(), and
> > syscall_get_return_value() functions in order to extend the generic
> > ptrace API with PTRACE_GET_SYSCALL_INFO request.
> >
> > Acked-by: Paul Moore <paul@paul-moore.com>
> > Cc: Elvira Khabirova <lineprinter@altlinux.org>
> > Cc: Eugene Syromyatnikov <esyr@redhat.com>
> > Cc: Greentime Hu <green.hu@gmail.com>
> > Cc: Vincent Chen <deanbo422@gmail.com>
> > Cc: Oleg Nesterov <oleg@redhat.com>
> > Cc: Andy Lutomirski <luto@kernel.org>
> > Cc: linux-audit@redhat.com
> > Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
> > ---
> >  This is just a gentle ping, the patch is unchanged.
> >
> >  arch/nds32/include/asm/syscall.h | 9 +++++++++
> >  include/uapi/linux/audit.h       | 2 ++
> >  2 files changed, 11 insertions(+)
> >
> > diff --git a/arch/nds32/include/asm/syscall.h b/arch/nds32/include/asm/=
syscall.h
> > index f7e5e86765fe..cc56a3962f8b 100644
> > --- a/arch/nds32/include/asm/syscall.h
> > +++ b/arch/nds32/include/asm/syscall.h
> > @@ -5,6 +5,7 @@
> >  #ifndef _ASM_NDS32_SYSCALL_H
> >  #define _ASM_NDS32_SYSCALL_H   1
> >
> > +#include <uapi/linux/audit.h>
> >  #include <linux/err.h>
> >  struct task_struct;
> >  struct pt_regs;
> > @@ -185,4 +186,12 @@ void syscall_set_arguments(struct task_struct *tas=
k, struct pt_regs *regs,
> >
> >         memcpy(&regs->uregs[0] + i, args, n * sizeof(args[0]));
> >  }
> > +
> > +static inline int
> > +syscall_get_arch(void)
> > +{
> > +       return IS_ENABLED(CONFIG_CPU_BIG_ENDIAN)
> > +               ? AUDIT_ARCH_NDS32BE : AUDIT_ARCH_NDS32;
> > +}
> > +
> >  #endif /* _ASM_NDS32_SYSCALL_H */
> > diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
> > index b1602dcc13bc..1568ddc1c945 100644
> > --- a/include/uapi/linux/audit.h
> > +++ b/include/uapi/linux/audit.h
> > @@ -401,6 +401,8 @@ enum {
> >  #define AUDIT_ARCH_MIPSEL64    (EM_MIPS|__AUDIT_ARCH_64BIT|__AUDIT_ARC=
H_LE)
> >  #define AUDIT_ARCH_MIPSEL64N32 (EM_MIPS|__AUDIT_ARCH_64BIT|__AUDIT_ARC=
H_LE|\
> >                                  __AUDIT_ARCH_CONVENTION_MIPS64_N32)
> > +#define AUDIT_ARCH_NDS32       (EM_NDS32|__AUDIT_ARCH_LE)
> > +#define AUDIT_ARCH_NDS32BE     (EM_NDS32)
> >  #define AUDIT_ARCH_OPENRISC    (EM_OPENRISC)
> >  #define AUDIT_ARCH_PARISC      (EM_PARISC)
> >  #define AUDIT_ARCH_PARISC64    (EM_PARISC|__AUDIT_ARCH_64BIT)
> > --
> > ldv
>
> Thanks for fixing this.
>
> Acked-by Vincent Chen

Thank you. I add his email address. :P

Acked-by: Vincent Chen <vincentc@andestech.com>
Acked-by: Greentime Hu <greentime@andestech.com>
