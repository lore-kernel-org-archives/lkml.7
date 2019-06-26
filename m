Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36342C48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 06:57:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E8AE2086D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 06:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561532234;
	bh=h270XSQR4HolgMBKtPYzDJLyOe03vdnKPXJi7f/tNRM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ylDo9lGBiCIkZA4HANPFCt/onX4mpxV/HkMedi/fGTNyKG7QeM5klVN4gLK2ixN2Q
	 R8uFi2aum7Yo2ECowvjq5Q2zeX25uaT+MZjC27Rwne16IjEkzwMj73yeTKbIco3OyV
	 mwFZzBrYSCr6ADCFMKMvel7afJ8EsQyGDxXZUY6E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbfFZG5M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 02:57:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:43978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725930AbfFZG5K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 02:57:10 -0400
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 928EF2086D;
        Wed, 26 Jun 2019 06:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561532228;
        bh=h270XSQR4HolgMBKtPYzDJLyOe03vdnKPXJi7f/tNRM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HupmX+5Rtg9kMo0+c7MtqHspj5yq0C1i+GHhqAfPjXpvRXGFlJmGNWUbzYG4I4Vrf
         Xc2a11E3p3qv2IjffyBBtc+hzBXn9wpdwWBB5O83bL9WUAaI462ArX8xxDF70mac3X
         jG83M2a3D2nE4EQACKx7oBSWIzyjwwLvLTLN70TI=
Received: by mail-wr1-f48.google.com with SMTP id k11so1348331wrl.1;
        Tue, 25 Jun 2019 23:57:08 -0700 (PDT)
X-Gm-Message-State: APjAAAXypLMPFrVhEEXSu1lNP3GcgX2bEbQVUnPw3F7HTbnrCLFcc3MV
        ONvMZiZnYDXqV1QX5u4Nr8jxvk/9YTZbvU0FFNM=
X-Google-Smtp-Source: APXvYqyMc3SCW8AHCkxvuRUSme5yc5XG19mBM0GzvXnR8YWbXLG4W90TUwCbI4ickEEAG9SxmgbuA94jgtkfbGlbleA=
X-Received: by 2002:adf:f28a:: with SMTP id k10mr2189723wro.343.1561532227206;
 Tue, 25 Jun 2019 23:57:07 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1561531557.git.han_mao@c-sky.com> <d874d7782d9acdad5d98f2f5c4a6fb26fbe41c5d.1561531557.git.han_mao@c-sky.com>
In-Reply-To: <d874d7782d9acdad5d98f2f5c4a6fb26fbe41c5d.1561531557.git.han_mao@c-sky.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 26 Jun 2019 14:56:55 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRyma8sDMJaWCde1eOe6KSwn4_e=tJOT4d3kgmvzOxz8g@mail.gmail.com>
Message-ID: <CAJF2gTRyma8sDMJaWCde1eOe6KSwn4_e=tJOT4d3kgmvzOxz8g@mail.gmail.com>
Subject: Re: [PATCH 1/1] perf annotate csky: Add perf annotate support
To:     Mao Han <han_mao@c-sky.com>
Cc:     linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thx Mao,

Approved!

Best Regards
 Guo Ren

On Wed, Jun 26, 2019 at 2:53 PM Mao Han <han_mao@c-sky.com> wrote:
>
> This patch add basic arch initialization and instruction associate suppor=
t
> for csky.
>
> perf annotate --stdio2
> Samples: 161  of event 'cpu-clock:pppH', 4000 Hz, Event count (approx.):
> 40250000, [percent: local period]
> test_4() /usr/lib/perf-test/callchain_test
> Percent
>
>             Disassembly of section .text:
>
>             00008420 <test_4>:
>             test_4():
>               subi  sp, sp, 4
>               st.w  r8, (sp, 0x0)
>               mov   r8, sp
>               subi  sp, sp, 8
>               subi  r3, r8, 4
>               movi  r2, 0
>               st.w  r2, (r3, 0x0)
>             =E2=86=93 br    2e
> 100.00  14:   subi  r3, r8, 4
>               ld.w  r2, (r3, 0x0)
>               subi  r3, r8, 8
>               st.w  r2, (r3, 0x0)
>               subi  r3, r8, 4
>               ld.w  r3, (r3, 0x0)
>               addi  r2, r3, 1
>               subi  r3, r8, 4
>               st.w  r2, (r3, 0x0)
>         2e:   subi  r3, r8, 4
>               ld.w  r2, (r3, 0x0)
>               lrw   r3, 0x98967f    // 8598 <main+0x28>
>               cmplt r3, r2
>             =E2=86=91 bf    14
>               mov   r0, r0
>               mov   r0, r0
>               mov   sp, r8
>               ld.w  r8, (sp, 0x0)
>               addi  sp, sp, 4
>             =E2=86=90 rts
>
> Signed-off-by: Mao Han <han_mao@c-sky.com>
> Cc: Guo Ren <guoren@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/arch/csky/annotate/instructions.c | 48 ++++++++++++++++++++++=
++++++
>  tools/perf/util/annotate.c                   |  5 +++
>  2 files changed, 53 insertions(+)
>  create mode 100644 tools/perf/arch/csky/annotate/instructions.c
>
> diff --git a/tools/perf/arch/csky/annotate/instructions.c b/tools/perf/ar=
ch/csky/annotate/instructions.c
> new file mode 100644
> index 0000000..5337bfb
> --- /dev/null
> +++ b/tools/perf/arch/csky/annotate/instructions.c
> @@ -0,0 +1,48 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) 2019 Hangzhou C-SKY Microsystems co.,ltd.
> +
> +#include <linux/compiler.h>
> +
> +static struct ins_ops *csky__associate_ins_ops(struct arch *arch,
> +                                              const char *name)
> +{
> +       struct ins_ops *ops =3D NULL;
> +
> +       /* catch all kind of jumps */
> +       if (!strcmp(name, "bt") ||
> +           !strcmp(name, "bf") ||
> +           !strcmp(name, "bez") ||
> +           !strcmp(name, "bnez") ||
> +           !strcmp(name, "bnezad") ||
> +           !strcmp(name, "bhsz") ||
> +           !strcmp(name, "bhz") ||
> +           !strcmp(name, "blsz") ||
> +           !strcmp(name, "blz") ||
> +           !strcmp(name, "br") ||
> +           !strcmp(name, "jmpi") ||
> +           !strcmp(name, "jmp"))
> +               ops =3D &jump_ops;
> +
> +       /* catch function call */
> +       if (!strcmp(name, "bsr") ||
> +           !strcmp(name, "jsri") ||
> +           !strcmp(name, "jsr"))
> +               ops =3D &call_ops;
> +
> +       /* catch function return */
> +       if (!strcmp(name, "rts"))
> +               ops =3D &ret_ops;
> +
> +       if (ops)
> +               arch__associate_ins_ops(arch, name, ops);
> +       return ops;
> +}
> +
> +static int csky__annotate_init(struct arch *arch, char *cpuid __maybe_un=
used)
> +{
> +       arch->initialized =3D true;
> +       arch->objdump.comment_char =3D '/';
> +       arch->associate_instruction_ops =3D csky__associate_ins_ops;
> +
> +       return 0;
> +}
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index 79db038..eb2456e 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -144,6 +144,7 @@ static int arch__associate_ins_ops(struct arch* arch,=
 const char *name, struct i
>  #include "arch/arc/annotate/instructions.c"
>  #include "arch/arm/annotate/instructions.c"
>  #include "arch/arm64/annotate/instructions.c"
> +#include "arch/csky/annotate/instructions.c"
>  #include "arch/x86/annotate/instructions.c"
>  #include "arch/powerpc/annotate/instructions.c"
>  #include "arch/s390/annotate/instructions.c"
> @@ -163,6 +164,10 @@ static struct arch architectures[] =3D {
>                 .init =3D arm64__annotate_init,
>         },
>         {
> +               .name =3D "csky",
> +               .init =3D csky__annotate_init,
> +       },
> +       {
>                 .name =3D "x86",
>                 .init =3D x86__annotate_init,
>                 .instructions =3D x86__instructions,
> --
> 2.7.4
>


--=20
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
