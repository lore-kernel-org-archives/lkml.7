Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42515C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 00:26:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11342206DD
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 00:26:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="suSD9b7i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726854AbfCEA0r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 19:26:47 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:34965 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbfCEA0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 19:26:47 -0500
Received: by mail-it1-f193.google.com with SMTP id 188so1754781itb.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 16:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7D6R1hbiS1TVqH0gs1uD4xGzsX7DgHc5hwTY1MQLTbY=;
        b=suSD9b7iUGbtJnh6UoQNmNqV20U0Ee4+63MRu+ycP7bM8GnuG95g0EoGRv34pALh8t
         laAPVApFCPXVLnCqB8Rx6g/zBFOHH1BpIcl33LEL0PcXgxjwHS45MEWVxyyAM/ulRg3D
         needFv/v4e6xxwggXgILL/I1YOd4H0R+EW+Nttu6C0K32JXID4/VZ8U8PPSPukdN5Mm+
         oKG1jLSYkjRB0RnaVYT5hE6tpoLPnZZXokHCHBL3C1C2kn7CWNI+hDvWLuOLHYMLdfp8
         D/A8Pio4sr8PujEgQnZ4KAAnw6TY9+kJFauHxuvoGrYMHjA3YjY/tIFXQsyEV7FKSUoq
         QJMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7D6R1hbiS1TVqH0gs1uD4xGzsX7DgHc5hwTY1MQLTbY=;
        b=FrHDJAfRSLkENXQayZ/os1oqy/tOZ3XL/wI6kMbLL7oLKMeJaBCHTm+e36KEKFoUJp
         y4I1pWN/AT/4feoa2OLRJaGyeXGKrmQtorGMph8dEYFQVXrvYRmqaIfTPmP2g67Yekqd
         uY+JABm1ZOTg4Ph/eu+zX11vg3csQ/gAgK9H6kNSS/ByRScCgX9Tou0NdpYgGXDBbG/1
         0t7o7cF56RDOtB0V7A0cy22Qr/iuHqsVWf02T2Ylkw6We2IZwHc5rc+OaIIAZkyPxh6w
         JpW3uIUze/bei5gxiMvpwpqnFcOEOCfHvFMP4tQOb9UuIkcFCW3k+oKsrD5+FYne4AIt
         Hbew==
X-Gm-Message-State: APjAAAVK+vHxMRGkLKP0o4vAGi+HEWmo8L9xucW8g65TLPzQtp7vXXKQ
        0QEfhcqwhgjELnZ+bRogWeUDCufsKs3LLxTbojk=
X-Google-Smtp-Source: APXvYqxjKrvDxi5NIN9WlsEGa5ozH5YurLh1hjfg4dBiO/f6QsTS6ZdElIVpH/pnaTd1jWAqGP0oWIy0i2nRm9ZEmEg=
X-Received: by 2002:a02:6a0b:: with SMTP id l11mr12119121jac.138.1551745606514;
 Mon, 04 Mar 2019 16:26:46 -0800 (PST)
MIME-Version: 1.0
References: <20190109124044.GA11935@altlinux.org> <20190109124316.GH11981@altlinux.org>
 <20190227153034.GD23744@altlinux.org>
In-Reply-To: <20190227153034.GD23744@altlinux.org>
From:   Vincent Chen <deanbo422@gmail.com>
Date:   Tue, 5 Mar 2019 08:26:36 +0800
Message-ID: <CAJsyPhzmJyJiwRSn0eB6g0BLYM0zpoSWJ=XfcBje6EJNGGQ1eA@mail.gmail.com>
Subject: Re: [PATCH 08/14] Move EM_NDS32 to uapi/linux/elf-em.h
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
> This should never have been defined in the arch tree to begin with,
> and now uapi/linux/audit.h header is going to use EM_NDS32
> in order to define AUDIT_ARCH_NDS32 which is needed to implement
> syscall_get_arch() which in turn is required to extend
> the generic ptrace API with PTRACE_GET_SYSCALL_INFO request.
>
> Acked-by: Paul Moore <paul@paul-moore.com>
> Cc: Greentime Hu <green.hu@gmail.com>
> Cc: Vincent Chen <deanbo422@gmail.com>
> Cc: Elvira Khabirova <lineprinter@altlinux.org>
> Cc: Eugene Syromyatnikov <esyr@redhat.com>
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: linux-audit@redhat.com
> Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
> ---
>  This is just a gentle ping, the patch is unchanged.
>
>  arch/nds32/include/asm/elf.h | 3 +--
>  include/uapi/linux/elf-em.h  | 2 ++
>  2 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/arch/nds32/include/asm/elf.h b/arch/nds32/include/asm/elf.h
> index 95f3ea253e4c..02250626b9f0 100644
> --- a/arch/nds32/include/asm/elf.h
> +++ b/arch/nds32/include/asm/elf.h
> @@ -10,14 +10,13 @@
>
>  #include <asm/ptrace.h>
>  #include <asm/fpu.h>
> +#include <linux/elf-em.h>
>
>  typedef unsigned long elf_greg_t;
>  typedef unsigned long elf_freg_t[3];
>
>  extern unsigned int elf_hwcap;
>
> -#define EM_NDS32                       167
> -
>  #define R_NDS32_NONE                   0
>  #define R_NDS32_16_RELA                        19
>  #define R_NDS32_32_RELA                        20
> diff --git a/include/uapi/linux/elf-em.h b/include/uapi/linux/elf-em.h
> index bd02325028d8..4b8df722330e 100644
> --- a/include/uapi/linux/elf-em.h
> +++ b/include/uapi/linux/elf-em.h
> @@ -40,6 +40,8 @@
>  #define EM_ALTERA_NIOS2        113     /* Altera Nios II soft-core proce=
ssor */
>  #define EM_TI_C6000    140     /* TI C6X DSPs */
>  #define EM_HEXAGON     164     /* QUALCOMM Hexagon */
> +#define EM_NDS32       167     /* Andes Technology compact code size
> +                                  embedded RISC processor family */
>  #define EM_AARCH64     183     /* ARM 64 bit */
>  #define EM_TILEPRO     188     /* Tilera TILEPro */
>  #define EM_MICROBLAZE  189     /* Xilinx MicroBlaze */
> --
> ldv

Thanks for fixing this.

Acked-by Vincent Chen
