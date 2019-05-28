Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C979C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 15:53:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80477208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 15:53:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbfE1PxE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 11:53:04 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:42985 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbfE1PxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 11:53:04 -0400
Received: by mail-ot1-f65.google.com with SMTP id i2so18205505otr.9
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 08:53:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SEzbBlQG9PWtd5a62UB1gNIL78kQHaOBX6iGUYxagdo=;
        b=CETdeiRrNkkY/iFb1YW3XjnzbwDSVoDvzeM68rUowQCUX95k5w3pv/tAvlkaXSFmDJ
         zb17VDhb9Oo1RE0ubm0c9yT8XY/0Y8UaWVYslF7kwAjJHm2ZpG9yLcIwK3Q87V5eQswb
         znquuuN1d5e7afl2pP+5wwqB6iDOFDRUndWlr04haGD/T/BDrencfAU1TC5dbmPezmo3
         +cB5FWO0AGJkeOXog8a04ijJxsPCzfpbJaTTkAKZROoGFxaV69i1XpBmF88waWofI/+B
         duG6+PXrWlNeYVUmyEWULmdpUe8aTXmjgtJidflLUhEjhkqgEMEZquMQSZQs+gLLJFQJ
         crhQ==
X-Gm-Message-State: APjAAAXY/wOkS+rV9m65T9isDB/z08npSTO0kaiPqL9ceUhAoced38Dg
        nNWQn0ARJsbHFrIUZc7islVYjaIX+VPSH4FQ/gY=
X-Google-Smtp-Source: APXvYqz5xuCiYcBraQ+feTCqPEQuyUWUjqF+idvC6b9V1DLp0HFySu2Mo/Dr2zATO9JApzPsBMuZVBeP6sCP1tifo1E=
X-Received: by 2002:a9d:7987:: with SMTP id h7mr14821107otm.284.1559058783533;
 Tue, 28 May 2019 08:53:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190312202008.29681-1-malat@debian.org> <20190312212318.17822-1-malat@debian.org>
 <87d0k2q025.fsf@concordia.ellerman.id.au>
In-Reply-To: <87d0k2q025.fsf@concordia.ellerman.id.au>
From:   Mathieu Malaterre <malat@debian.org>
Date:   Tue, 28 May 2019 17:52:52 +0200
Message-ID: <CA+7wUswLP5cffrYZuEZ9bJeq1-FNNq6LFurMrOM1bmnDDN7E-g@mail.gmail.com>
Subject: Re: [PATCH v2] powerpc/32: sstep: Move variable `rc` within
 CONFIG_PPC64 sentinels
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 28, 2019 at 1:40 PM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> Mathieu Malaterre <malat@debian.org> writes:
>
> > Fix warnings treated as errors with W=1:
> >
> >   arch/powerpc/lib/sstep.c:1172:31: error: variable 'rc' set but not used [-Werror=unused-but-set-variable]
> >
> > Suggested-by: Christophe Leroy <christophe.leroy@c-s.fr>
> > Signed-off-by: Mathieu Malaterre <malat@debian.org>
> > ---
> > v2: as suggested prefer CONFIG_PPC64 sentinel instead of unused keyword
>
> I'd rather avoid adding more ifdefs if we can.
>
> I think this works?

It does ! ;)

Reviewed-by: Mathieu Malaterre <malat@debian.org>

> cheers
>
> diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
> index 3d33fb509ef4..600b036ddfda 100644
> --- a/arch/powerpc/lib/sstep.c
> +++ b/arch/powerpc/lib/sstep.c
> @@ -1169,7 +1169,7 @@ static nokprobe_inline int trap_compare(long v1, long v2)
>  int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
>                   unsigned int instr)
>  {
> -       unsigned int opcode, ra, rb, rc, rd, spr, u;
> +       unsigned int opcode, ra, rb, rd, spr, u;
>         unsigned long int imm;
>         unsigned long int val, val2;
>         unsigned int mb, me, sh;
> @@ -1292,7 +1292,6 @@ int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
>         rd = (instr >> 21) & 0x1f;
>         ra = (instr >> 16) & 0x1f;
>         rb = (instr >> 11) & 0x1f;
> -       rc = (instr >> 6) & 0x1f;
>
>         switch (opcode) {
>  #ifdef __powerpc64__
> @@ -1307,10 +1306,14 @@ int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
>                 return 1;
>
>  #ifdef __powerpc64__
> -       case 4:
> +       case 4: {
> +               unsigned int rc;
> +
>                 if (!cpu_has_feature(CPU_FTR_ARCH_300))
>                         return -1;
>
> +               rc = (instr >> 6) & 0x1f;
> +
>                 switch (instr & 0x3f) {
>                 case 48:        /* maddhd */
>                         asm volatile(PPC_MADDHD(%0, %1, %2, %3) :
> @@ -1336,6 +1339,7 @@ int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
>                  * primary opcode which do not have emulation support yet.
>                  */
>                 return -1;
> +       }
>  #endif
>
>         case 7:         /* mulli */
