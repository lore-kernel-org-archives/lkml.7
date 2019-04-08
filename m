Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD1DC10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 14:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11C5820879
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 14:45:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i5+Uv9he"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbfDHOpB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 10:45:01 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53600 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726766AbfDHOpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 10:45:01 -0400
Received: by mail-wm1-f67.google.com with SMTP id q16so14699993wmj.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 07:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=OvtsZvBIPegZVpWgT+mNI1vGXaLKwFMVf7AKwd2D1tI=;
        b=i5+Uv9heeo+WPBLpLcCfkin0u8aVUhmbUoRzDCjw5rO7RZgz0LzmdTDx2qAE8cHNH2
         gUxcM9cCQPcmNOVVJk7qm68RvsEkZ2jd5VbExiyFFuJa+P5Z483Z8Mt86Z1EhXqqFyJD
         DUmB4hYDzXzvs8etsVaV609WG7+LtnSfdebb+WVo9n9X/QhrUUict4TnLQ1X8jCsMIYv
         Mzv5gPICgibN+JUHIKq8gf26aRw7ZRVFvxiCG6Gy55+BQ/61w5ecGeeuoLBTY1J0RwkF
         XKT0/S9ZmHafgYsgcvXTANEBmtAsrFZFZqtoGaKIXlnrMcurbUUXqBZvwhSDD+0OHoEN
         k7OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=OvtsZvBIPegZVpWgT+mNI1vGXaLKwFMVf7AKwd2D1tI=;
        b=FTZ0Pgb+02Y7BDGqaHCdYihQyVNqxK1yxM6jA6cUL6+I0qvU2rckFMkZdj1i2Arz1B
         AFRHvB6mloOVU+PJxU8kGusraIbXGfaw/VNVPjG+hYDFUf75OmeTiiP2cHdjwU4fZogH
         qmTI/iAiGw0Ipq6SGVgvJE3ii8xughnR3nVK+ZRqSLu/3LNANtJrGW8RMUuHVF+rXRhs
         H8Y1ydQna6GXX5yvBR6cllF+7n1+ke/RZcPqQpbjKK74cOaoEEOiQUtAzL+U+woJzRSE
         oBXw/Uy3oBWW5PEvyQ4XfH2vSrbtsDtV5HN3a8UbmaTYbQ8Npq0qDv+8b8cQPO6rC3Fo
         91Lw==
X-Gm-Message-State: APjAAAXwvayzHu/ZoNwDBtTbzriEpkCreXWW6UTq3D6oWiIpwCWra7U/
        TlClwJ00qoKiYYyDg8gN0XY+/AXpPklYuMd52bzayiXw
X-Google-Smtp-Source: APXvYqx/v6L4BzsEVBfTen7ydio3fjObvguaboMcaE5BRCRyfQYB7fXs71N0+9HOVaBHipkCJPjLX8SIrRYSMN++oFs=
X-Received: by 2002:a1c:9991:: with SMTP id b139mr17016807wme.53.1554734698953;
 Mon, 08 Apr 2019 07:44:58 -0700 (PDT)
MIME-Version: 1.0
References: <CA+icZUVW2X6G=qukJTrZuUevcnrOiuShJGxnxVaqyONNxv+RYg@mail.gmail.com>
 <e5d3d2fc-874c-a8e3-1320-f9396a3621b5@redhat.com> <99dde862-6aee-65a0-8b39-33b8ac10df45@redhat.com>
 <CA+icZUUw3SgyCdk9fyv+mVUGDepDNGj8Bm7t0WWOE3Q0sHJs4Q@mail.gmail.com>
 <863a33cf-0a1a-17af-0ea8-42e288f8a1fd@redhat.com> <CA+icZUVvtLkNNor+9wQy1_bt=NfRAfJD9f_daqX2Da=EcdjAaA@mail.gmail.com>
 <5c5c169d-3bad-9e34-8c56-bedca3e5ae08@redhat.com>
In-Reply-To: <5c5c169d-3bad-9e34-8c56-bedca3e5ae08@redhat.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Mon, 8 Apr 2019 16:44:47 +0200
Message-ID: <CA+icZUUk8jhGqsu65A8oHFcqzrqNRon+riPff9aJu2UFLXL7wQ@mail.gmail.com>
Subject: Re: CBL issue #431: lld: x86_64: sysfs: cannot create duplicate
 filename $module/.rodata.cst{16,32}
To:     Denys Vlasenko <dvlasenk@redhat.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 8, 2019 at 4:42 PM Denys Vlasenko <dvlasenk@redhat.com> wrote:
>
> On 4/8/19 4:34 PM, Sedat Dilek wrote:
> > v2:
> >
> > sdi@iniza:~/src/linux-kernel/linux$ git --no-pager diff
> > diff --git a/arch/x86/crypto/camellia-aesni-avx-asm_64.S
> > b/arch/x86/crypto/camellia-aesni-avx-asm_64.S
> > index a14af6eb09cb..712d6a7e8b8f 100644
> > --- a/arch/x86/crypto/camellia-aesni-avx-asm_64.S
> > +++ b/arch/x86/crypto/camellia-aesni-avx-asm_64.S
> > @@ -573,8 +573,12 @@
> > ENDPROC(roundsm16_x4_x5_x6_x7_x0_x1_x2_x3_y4_y5_y6_y7_y0_y1_y2_y3_ab)
> >          vmovdqu y7, 15 * 16(rio);
> >
> >
> > -/* NB: section is mergeable, all elements must be aligned 16-byte blocks */
> > -.section       .rodata.cst16, "aM", @progbits, 16
> > +/*
> > + * NB: section is mergeable, all elements must be aligned 16-byte blocks
> > + * There is more than one object in this section, let's use module name
> > + * instead of object name as unique suffix
> > + */
> > +.section        .rodata.cst16.camellia_aesni_avx_asm_64, "aM", @progbits, 16
> >   .align 16
> >
> >   #define SHUFB_BYTES(idx) \
> > diff --git a/arch/x86/crypto/camellia-aesni-avx2-asm_64.S
> > b/arch/x86/crypto/camellia-aesni-avx2-asm_64.S
> > index b66bbfa62f50..34f6b0c4196d 100644
> > --- a/arch/x86/crypto/camellia-aesni-avx2-asm_64.S
> > +++ b/arch/x86/crypto/camellia-aesni-avx2-asm_64.S
> > @@ -626,8 +626,12 @@
> > ENDPROC(roundsm32_x4_x5_x6_x7_x0_x1_x2_x3_y4_y5_y6_y7_y0_y1_y2_y3_ab)
> >          .long 0x00010203, 0x04050607, 0x80808080, 0x80808080
> >          .long 0x00010203, 0x04050607, 0x80808080, 0x80808080
> >
> > -/* NB: section is mergeable, all elements must be aligned 16-byte blocks */
> > -.section       .rodata.cst16, "aM", @progbits, 16
> > +/*
> > + * NB: section is mergeable, all elements must be aligned 16-byte blocks
> > + * There is more than one object in this section, let's use module name
> > + * instead of object name as unique suffix
> > +*/
> > +.section        .rodata.cst16.ccamellia_aesni_avx2_asm_64, "aM", @progbits, 16
>
> why "ccamellia", not "camellia"?
>

Grrr.

> > I tried to check for the .rodata.cst32 case, how do I identify the *.S files?
>
> ?
>
> Looks like all .rodata.cst32 sections have suffixes, nothing to fix.

$ for i in .rodata.cst32.pack_bswap .rodata.cst32.shufb_16x16b
.rodata.cst32.CTR2BL .rodata.cst32.CTR4BL .rodata.cst32.CTRINC
.rodata.cst32.ROT16 .rodata.cst32.ROT8 .rodata.cst32.CTR2BL
.rodata.cst32.CTR4BL .rodata.cst32.CTR8BL
.rodata.cst32.pshufb_shf_table .rodata.cst32.morus1280_const
.rodata.cst32.morus1280_counter .rodata.cst32.ANMASK
.rodata.cst32.ORMASK .rodata.cst32.PSHUFFLE_BYTE_FLIP_MASK
.rodata.cst32._SHUF_00BA .rodata.cst32._SHUF_DC00
.rodata.cst32.MASK_YMM_LO .rodata.cst32.PSHUFFLE_BYTE_FLIP_MASK ; do
echo [ "$i" ] ; git grep $i arch/x86 ; echo [ "/$i" ] ; echo "" ; done
[ .rodata.cst32.pack_bswap ]
arch/x86/crypto/camellia-aesni-avx2-asm_64.S:.section
.rodata.cst32.pack_bswap, "aM", @progbits, 32
[ /.rodata.cst32.pack_bswap ]

[ .rodata.cst32.shufb_16x16b ]
arch/x86/crypto/camellia-aesni-avx2-asm_64.S:.section
.rodata.cst32.shufb_16x16b, "aM", @progbits, 32
[ /.rodata.cst32.shufb_16x16b ]

[ .rodata.cst32.CTR2BL ]
arch/x86/crypto/chacha-avx2-x86_64.S:.section   .rodata.cst32.CTR2BL,
"aM", @progbits, 32
arch/x86/crypto/chacha-avx512vl-x86_64.S:.section
.rodata.cst32.CTR2BL, "aM", @progbits, 32
[ /.rodata.cst32.CTR2BL ]

[ .rodata.cst32.CTR4BL ]
arch/x86/crypto/chacha-avx2-x86_64.S:.section   .rodata.cst32.CTR4BL,
"aM", @progbits, 32
arch/x86/crypto/chacha-avx512vl-x86_64.S:.section
.rodata.cst32.CTR4BL, "aM", @progbits, 32
[ /.rodata.cst32.CTR4BL ]

[ .rodata.cst32.CTRINC ]
arch/x86/crypto/chacha-avx2-x86_64.S:.section   .rodata.cst32.CTRINC,
"aM", @progbits, 32
[ /.rodata.cst32.CTRINC ]

[ .rodata.cst32.ROT16 ]
arch/x86/crypto/chacha-avx2-x86_64.S:.section   .rodata.cst32.ROT16,
"aM", @progbits, 32
[ /.rodata.cst32.ROT16 ]

[ .rodata.cst32.ROT8 ]
arch/x86/crypto/chacha-avx2-x86_64.S:.section   .rodata.cst32.ROT8,
"aM", @progbits, 32
[ /.rodata.cst32.ROT8 ]

[ .rodata.cst32.CTR2BL ]
arch/x86/crypto/chacha-avx2-x86_64.S:.section   .rodata.cst32.CTR2BL,
"aM", @progbits, 32
arch/x86/crypto/chacha-avx512vl-x86_64.S:.section
.rodata.cst32.CTR2BL, "aM", @progbits, 32
[ /.rodata.cst32.CTR2BL ]

[ .rodata.cst32.CTR4BL ]
arch/x86/crypto/chacha-avx2-x86_64.S:.section   .rodata.cst32.CTR4BL,
"aM", @progbits, 32
arch/x86/crypto/chacha-avx512vl-x86_64.S:.section
.rodata.cst32.CTR4BL, "aM", @progbits, 32
[ /.rodata.cst32.CTR4BL ]

[ .rodata.cst32.CTR8BL ]
arch/x86/crypto/chacha-avx512vl-x86_64.S:.section
.rodata.cst32.CTR8BL, "aM", @progbits, 32
[ /.rodata.cst32.CTR8BL ]

[ .rodata.cst32.pshufb_shf_table ]
arch/x86/crypto/crct10dif-pcl-asm_64.S:.section
.rodata.cst32.pshufb_shf_table, "aM", @progbits, 32
[ /.rodata.cst32.pshufb_shf_table ]

[ .rodata.cst32.morus1280_const ]
arch/x86/crypto/morus1280-avx2-asm.S:.section
.rodata.cst32.morus1280_const, "aM", @progbits, 32
[ /.rodata.cst32.morus1280_const ]

[ .rodata.cst32.morus1280_counter ]
arch/x86/crypto/morus1280-avx2-asm.S:.section
.rodata.cst32.morus1280_counter, "aM", @progbits, 32
[ /.rodata.cst32.morus1280_counter ]

[ .rodata.cst32.ANMASK ]
arch/x86/crypto/poly1305-avx2-x86_64.S:.section .rodata.cst32.ANMASK,
"aM", @progbits, 32
[ /.rodata.cst32.ANMASK ]

[ .rodata.cst32.ORMASK ]
arch/x86/crypto/poly1305-avx2-x86_64.S:.section .rodata.cst32.ORMASK,
"aM", @progbits, 32
[ /.rodata.cst32.ORMASK ]

[ .rodata.cst32.PSHUFFLE_BYTE_FLIP_MASK ]
arch/x86/crypto/sha256-avx2-asm.S:.section
.rodata.cst32.PSHUFFLE_BYTE_FLIP_MASK, "aM", @progbits, 32
arch/x86/crypto/sha512-avx2-asm.S:.section
.rodata.cst32.PSHUFFLE_BYTE_FLIP_MASK, "aM", @progbits, 32
[ /.rodata.cst32.PSHUFFLE_BYTE_FLIP_MASK ]

[ .rodata.cst32._SHUF_00BA ]
arch/x86/crypto/sha256-avx2-asm.S:.section
.rodata.cst32._SHUF_00BA, "aM", @progbits, 32
[ /.rodata.cst32._SHUF_00BA ]

[ .rodata.cst32._SHUF_DC00 ]
arch/x86/crypto/sha256-avx2-asm.S:.section
.rodata.cst32._SHUF_DC00, "aM", @progbits, 32
[ /.rodata.cst32._SHUF_DC00 ]

[ .rodata.cst32.MASK_YMM_LO ]
arch/x86/crypto/sha512-avx2-asm.S:.section
.rodata.cst32.MASK_YMM_LO, "aM", @progbits, 32
[ /.rodata.cst32.MASK_YMM_LO ]

[ .rodata.cst32.PSHUFFLE_BYTE_FLIP_MASK ]
arch/x86/crypto/sha256-avx2-asm.S:.section
.rodata.cst32.PSHUFFLE_BYTE_FLIP_MASK, "aM", @progbits, 32
arch/x86/crypto/sha512-avx2-asm.S:.section
.rodata.cst32.PSHUFFLE_BYTE_FLIP_MASK, "aM", @progbits, 32
[ /.rodata.cst32.PSHUFFLE_BYTE_FLIP_MASK ]

- Sedat -
