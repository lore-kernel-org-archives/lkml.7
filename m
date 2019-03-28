Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C401C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 14:38:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17D53217F9
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 14:38:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kYQ6AMnc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbfC1Oi2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 10:38:28 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:42877 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbfC1Oi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 10:38:27 -0400
Received: by mail-yw1-f66.google.com with SMTP id e76so15166452ywa.9;
        Thu, 28 Mar 2019 07:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AQ3+TH2TAd+zg8omRE3N+qEiuvxMp+BLut05jNg0Ce0=;
        b=kYQ6AMncm5AUD03kZYPPZjDusKLAmg1+H/PVurk4Sfs0h99KITrwZNbZ1ADbK6IAtn
         /rBN+WK9jdMPIUKD8lZdCaah7qdqMBUj2Gcf3VSaNlfET34HsKyYhOMwfy29/+T8m4fe
         3YkFPJBW9O4iKjGcNC5baMWYwYmEcW6CXTH/Nq/qHdcg7E77nCRbMioWj7XvKl+j30Qw
         MVOkrIfbMgIlCqgYcikN0GC7On/bNVU2soINGXx8mcoDMK5rHbop7uJhsyyWrTwqfmuw
         IYwptkNvsEbp8Fpk2y5UFrRBzuyh0UfN5B+rjSKdE1LBlKr43cNma6iNeRkrM6PllzuA
         FKDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AQ3+TH2TAd+zg8omRE3N+qEiuvxMp+BLut05jNg0Ce0=;
        b=U01YlZEp6CNot9OysQf/TmPk/sudiFdIIYJo+KfX0aBmBrJ/ZMIzqjdIlsx1sPifgq
         MOAGTKBi2b/JUqADpOj6KlQk1m7vCiEfqvuS09VIP8D/Nk+2k/KRvRr+MKqK0kN2jVhQ
         Y9H27gUPtYChhYoXzGHV9kGpK75Puyc30sQG/sszFM1ltdErFRSlnt2LbNNiGvIf0x/x
         BLn2dmnTE0Vshjs3hue/dPwJQlFK5VQwBAt4mtw1f6nzTw6iPZQQKP72BVX6SsvZvZ1/
         Yfn5BeMP7fqpPXDBi5sHpKFglbMr1dNYYyKnroSJP2A4re5pFyhiyu3tivh688eJ8+pT
         q5gg==
X-Gm-Message-State: APjAAAWRFhBz5+DL/aOpG7GLT17Td9Ew5iyN69+Y2tjwyvc17sFVd/nQ
        P+6F/rXUNaNfizl9oI3t2hFMl62AqBUVqaWKPkM=
X-Google-Smtp-Source: APXvYqwUnnOp0CTN8yjXk8g8P1lS/kIt4O2uGqaCuH5acv7NYlxCTrN78vlJWAjfyvICdGYszywyCPdOVqAKG3MGXoA=
X-Received: by 2002:a81:6d51:: with SMTP id i78mr36749518ywc.273.1553783906755;
 Thu, 28 Mar 2019 07:38:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190328141652.wssqboyekxmp6tkw@yubo-2> <d870f83e-48fa-7372-7664-e268aa1acf6c@netronome.com>
In-Reply-To: <d870f83e-48fa-7372-7664-e268aa1acf6c@netronome.com>
From:   Bo YU <tsu.yubo@gmail.com>
Date:   Thu, 28 Mar 2019 22:38:15 +0800
Message-ID: <CAKq8=3LSoSq1CPUo=g8GQSsi0HC9s+ewWEcxKk6uhHARyP_phg@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH=5D_bpf=3A_bpftool=3A_convert_=E2=80=98const_char_=2A=E2=80=99?=
        =?UTF-8?Q?_type_into_=27char_=2A=27_in_assignment?=
To:     Quentin Monnet <quentin.monnet@netronome.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>, songliubraving@fb.com,
        Yonghong Song <yhs@fb.com>, jakub.kicinski@netronome.com,
        df@google.com, Netdev <netdev@vger.kernel.org>,
        bpf@vger.kernel.org, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 10:33 PM Quentin Monnet
<quentin.monnet@netronome.com> wrote:
>
> 2019-03-28 10:16 UTC-0400 ~ Bo YU <tsu.yubo@gmail.com>
> > When compiling with check flag: make -C tools/bpf/bpftool/
> > gcc will warning:
> >
> > jit_disasm.c:119:29: warning: assignment discards =E2=80=98const=E2=80=
=99 qualifier from
> > pointer target type [-Wdiscarded-qualifiers]
> >   info.disassembler_options =3D disassembler_options;
> >
> > So convert 'const char *' type into 'char *' to fix the warning.
> >
> > Fixes:3ddeac6705aba(tools: bpftool: use 4 context mode for the NFP disa=
sm)
> > Signed-off-by: Bo YU <tsu.yubo@gmail.com>
> > ---
> > tools/bpf/bpftool/jit_disasm.c | 2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/bpf/bpftool/jit_disasm.c
> > b/tools/bpf/bpftool/jit_disasm.c
> > index 3ef3093560ba..40b46e46454a 100644
> > --- a/tools/bpf/bpftool/jit_disasm.c
> > +++ b/tools/bpf/bpftool/jit_disasm.c
> > @@ -116,7 +116,7 @@ void disasm_print_insn(unsigned char *image, ssize_=
t
> > len, int opcodes,
> >     info.arch =3D bfd_get_arch(bfdf);
> >     info.mach =3D bfd_get_mach(bfdf);
> >     if (disassembler_options)
> > -        info.disassembler_options =3D disassembler_options;
> > +        info.disassembler_options =3D (char *)disassembler_options;
> >     info.buffer =3D image;
> >     info.buffer_length =3D len;
> >
>
>
> Hi, the warning does not show with latest versions of binutils, it was
> fixed with this (binutils) commit:
>
>     commit f995bbe8e62fdb5607acb1ee127240cfe50d2b8f
>     Author: Pedro Alves <palves@redhat.com>
>     Date:   Wed Apr 5 19:21:33 2017 +0100
>
>         -Wwrite-strings: Constify struct disassemble_info's
>                 disassembler_options field
>
> Distributions with recent binutils (Ubuntu 18.04, Fedora 29 at least)
> should not have this message. I thought about sending the same patch
> some time ago, but in the end Jakub and I decided that it may not be
> worth casting the const away to silence the warning just for older
> distributions. Daniel also shared the same opinion at the time (but that
> was off the mailing-list).
Ok, good to know it.
Thanks,
>
> Quentin
