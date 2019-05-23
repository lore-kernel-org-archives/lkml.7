Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3475FC282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 11:49:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BE1520851
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 11:49:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730420AbfEWLtw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 07:49:52 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:36741 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729361AbfEWLtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 07:49:52 -0400
Received: by mail-oi1-f194.google.com with SMTP id y124so4128119oiy.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 04:49:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SDPZpn1Z/WVcAFnu0wVzRJujrt6mxAJ74qzNvfLBBxg=;
        b=Fjei1j+PbJgEQTjbX3e/hJJxkoKTUJ7I7PIlCkTc2BxDNhNW+1DBlCyWJsNe73n86E
         /y262Hmci2/MUaQ+MhiSZA8dvjoU92EeIXpbq+1VIjI5XuIzO5dUsvRhrfjEaLJ6ZfX2
         /wMTeJzL2iTYK56C0jzytIwLImv9E4BSVpZccdM6UmfN5PhSOr+9p+X5uuIZ08gJPLd9
         Kw+BxIEBP7NiZhvjFntusDYBmoth6Sk4f1mmD5fZb9USEFPEKCJTElH5TTWDrug2IeW+
         VhYXB8HF81Vz2KBUl/sWnam9hVRcsA0i1geyQVq4ra7SikQhu7wE25ZnHpv1chyNTbRR
         UuXg==
X-Gm-Message-State: APjAAAVBf2NP0Z9QftN2jVMZCFkPHlHYYXzXjTdoFHveqjhE6bJO3ypi
        N4YL3qSMOHX3QRFN1Nr0dvt4BdpL63GGcxSicFg=
X-Google-Smtp-Source: APXvYqyI2EjTKGdCz8up8VgvWh4xBSwLJzL9dCRQnLByupzgDHI7qG2w659u2fgJb7RIPVhnUUIVbWffOSOp331evS0=
X-Received: by 2002:a05:6808:98a:: with SMTP id a10mr535oic.57.1558612191818;
 Thu, 23 May 2019 04:49:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190312202008.29681-1-malat@debian.org> <20190312212318.17822-1-malat@debian.org>
In-Reply-To: <20190312212318.17822-1-malat@debian.org>
From:   Mathieu Malaterre <malat@debian.org>
Date:   Thu, 23 May 2019 13:49:41 +0200
Message-ID: <CA+7wUswq0nDfo7d7F_+v+bMXZUSr0ZQ7QbOTdxmLGp4_SK7xBw@mail.gmail.com>
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

ping ?

On Tue, Mar 12, 2019 at 10:23 PM Mathieu Malaterre <malat@debian.org> wrote:
>
> Fix warnings treated as errors with W=1:
>
>   arch/powerpc/lib/sstep.c:1172:31: error: variable 'rc' set but not used [-Werror=unused-but-set-variable]
>
> Suggested-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> ---
> v2: as suggested prefer CONFIG_PPC64 sentinel instead of unused keyword
>
>  arch/powerpc/lib/sstep.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
> index 3d33fb509ef4..9996dc7a0b46 100644
> --- a/arch/powerpc/lib/sstep.c
> +++ b/arch/powerpc/lib/sstep.c
> @@ -1169,7 +1169,10 @@ static nokprobe_inline int trap_compare(long v1, long v2)
>  int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
>                   unsigned int instr)
>  {
> -       unsigned int opcode, ra, rb, rc, rd, spr, u;
> +       unsigned int opcode, ra, rb, rd, spr, u;
> +#ifdef CONFIG_PPC64
> +       unsigned int rc;
> +#endif
>         unsigned long int imm;
>         unsigned long int val, val2;
>         unsigned int mb, me, sh;
> @@ -1292,7 +1295,9 @@ int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
>         rd = (instr >> 21) & 0x1f;
>         ra = (instr >> 16) & 0x1f;
>         rb = (instr >> 11) & 0x1f;
> +#ifdef CONFIG_PPC64
>         rc = (instr >> 6) & 0x1f;
> +#endif
>
>         switch (opcode) {
>  #ifdef __powerpc64__
> --
> 2.20.1
>
