Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B3DFC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 23:50:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA592206B6
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 23:50:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PVatIOjj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbfCDXuG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 18:50:06 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:52591 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbfCDXuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 18:50:05 -0500
Received: by mail-it1-f196.google.com with SMTP id g17so1561791ita.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 15:50:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jFIL/Lm1iT14hvIKAqaYjpV6FqyFVUKsClKXD2NFliQ=;
        b=PVatIOjj1000QxqyOlaoOe5jsaYynSbnejWceXOyCDODBOjEIyPHlkyZ4HZ112FhFf
         S6cNkdttUWdPEI0sDhaQXZ/40FC3Z8SGjWGkux8D7FqGyG/GSUkFOtDNpkm16AEss5as
         d2UlvYzPpL+6l5fnu2a48K6YHbbf3dlJ9j6QZbd5yoWUPOfO3U9DPt9XBl7CyFNW1m2Y
         tshwmmCO8dRJcTaCSbkSWmYDW9MeD282qPu2zWqKpn8f34mlCk9LaEfopvFeDX0PS5Uh
         gNQzrcdWLGxPbygIQaPwyb72EYUqNXNXMrZotm6HestNmpAskhRtyFqJBwk7R0hv909Q
         2lMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jFIL/Lm1iT14hvIKAqaYjpV6FqyFVUKsClKXD2NFliQ=;
        b=MOlSJSfPuc3xGFOsMIQOMCBtqSEvlqyT9Hql2sHX19nq33uOhviysUz+GBNxt63pDV
         KOrDMmB+XlKyYO8iB5zW5hoMCWcOqolgEruucHSWcXzy6fI+ryXIbHbKZMN19a499XWt
         Qdy35uHE0HqB1FIdDCravLi31UOd0469CVeCopuPTyTO6wF5bvz/wG5vq0CK2U/RWW4h
         K/SlPLt5cCIeYlcnB6C90BdJraGxRd38G2gGRae4GhVN8X/GoD9wt5FwCfmRwjqcwU6o
         /Sm7toV/EqWngI7n5HgZ5VK7FLRto25UPo30tQlyKop/QwlTHaKO7LYZYKATDQIgc07L
         7KYg==
X-Gm-Message-State: APjAAAUFUS93HnM3xm8a47gcx9t8TmHmzaRX1crY53FnECwhObPY5nrV
        O1DQdnZI/ZJ74xhqvGgIGpRED7ct/vqnkzwiIq8=
X-Google-Smtp-Source: APXvYqyqeyIFuHQ1kH2NEIuQU4veZE+3CzdT2TpNj7M0Mv8zcKs60nw3+CrhxTw3AW57sgc7AWOdet7DVHbo2KXXyJU=
X-Received: by 2002:a02:6a0b:: with SMTP id l11mr12048860jac.138.1551743404622;
 Mon, 04 Mar 2019 15:50:04 -0800 (PST)
MIME-Version: 1.0
References: <20190109124044.GA11935@altlinux.org> <20190109124320.GI11981@altlinux.org>
 <20190227153051.GE23744@altlinux.org>
In-Reply-To: <20190227153051.GE23744@altlinux.org>
From:   Vincent Chen <deanbo422@gmail.com>
Date:   Tue, 5 Mar 2019 07:49:54 +0800
Message-ID: <CAJsyPhxEX-LttRC+F4a+jE3uyjMCFLhHW6=O35W9eQNWjK8ODQ@mail.gmail.com>
Subject: Re: [PATCH 09/14] nds32: define syscall_get_arch()
To:     "Dmitry V. Levin" <ldv@altlinux.org>
Cc:     Greentime Hu <green.hu@gmail.com>,
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

Dmitry V. Levin <ldv@altlinux.org> =E6=96=BC 2019=E5=B9=B42=E6=9C=8827=E6=
=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=8811:30=E5=AF=AB=E9=81=93=EF=BC=
=9A

>
> syscall_get_arch() is required to be implemented on all architectures
> in addition to already implemented syscall_get_nr(),
> syscall_get_arguments(), syscall_get_error(), and
> syscall_get_return_value() functions in order to extend the generic
> ptrace API with PTRACE_GET_SYSCALL_INFO request.
>
> Acked-by: Paul Moore <paul@paul-moore.com>
> Cc: Elvira Khabirova <lineprinter@altlinux.org>
> Cc: Eugene Syromyatnikov <esyr@redhat.com>
> Cc: Greentime Hu <green.hu@gmail.com>
> Cc: Vincent Chen <deanbo422@gmail.com>
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: linux-audit@redhat.com
> Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
> ---
>  This is just a gentle ping, the patch is unchanged.
>
>  arch/nds32/include/asm/syscall.h | 9 +++++++++
>  include/uapi/linux/audit.h       | 2 ++
>  2 files changed, 11 insertions(+)
>
> diff --git a/arch/nds32/include/asm/syscall.h b/arch/nds32/include/asm/sy=
scall.h
> index f7e5e86765fe..cc56a3962f8b 100644
> --- a/arch/nds32/include/asm/syscall.h
> +++ b/arch/nds32/include/asm/syscall.h
> @@ -5,6 +5,7 @@
>  #ifndef _ASM_NDS32_SYSCALL_H
>  #define _ASM_NDS32_SYSCALL_H   1
>
> +#include <uapi/linux/audit.h>
>  #include <linux/err.h>
>  struct task_struct;
>  struct pt_regs;
> @@ -185,4 +186,12 @@ void syscall_set_arguments(struct task_struct *task,=
 struct pt_regs *regs,
>
>         memcpy(&regs->uregs[0] + i, args, n * sizeof(args[0]));
>  }
> +
> +static inline int
> +syscall_get_arch(void)
> +{
> +       return IS_ENABLED(CONFIG_CPU_BIG_ENDIAN)
> +               ? AUDIT_ARCH_NDS32BE : AUDIT_ARCH_NDS32;
> +}
> +
>  #endif /* _ASM_NDS32_SYSCALL_H */
> diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
> index b1602dcc13bc..1568ddc1c945 100644
> --- a/include/uapi/linux/audit.h
> +++ b/include/uapi/linux/audit.h
> @@ -401,6 +401,8 @@ enum {
>  #define AUDIT_ARCH_MIPSEL64    (EM_MIPS|__AUDIT_ARCH_64BIT|__AUDIT_ARCH_=
LE)
>  #define AUDIT_ARCH_MIPSEL64N32 (EM_MIPS|__AUDIT_ARCH_64BIT|__AUDIT_ARCH_=
LE|\
>                                  __AUDIT_ARCH_CONVENTION_MIPS64_N32)
> +#define AUDIT_ARCH_NDS32       (EM_NDS32|__AUDIT_ARCH_LE)
> +#define AUDIT_ARCH_NDS32BE     (EM_NDS32)
>  #define AUDIT_ARCH_OPENRISC    (EM_OPENRISC)
>  #define AUDIT_ARCH_PARISC      (EM_PARISC)
>  #define AUDIT_ARCH_PARISC64    (EM_PARISC|__AUDIT_ARCH_64BIT)
> --
> ldv

Thanks for fixing this.

Acked-by Vincent Chen
