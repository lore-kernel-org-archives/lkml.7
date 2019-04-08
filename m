Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4221C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 14:34:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5EF720818
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 14:34:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bk12MZVq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbfDHOea (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 10:34:30 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44764 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbfDHOea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 10:34:30 -0400
Received: by mail-wr1-f68.google.com with SMTP id y7so1086947wrn.11
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 07:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=+t48Q8KkFENFm+kHlN+Brhw2DxX9JJkzfGw4eDrv4nU=;
        b=Bk12MZVqXgLoP8yrnqX1IgcCMRNPkZPIf3S9WZfcnv6P/zOGI/NYcJF2dzj/7PuSWt
         LRtKkpBC73qtQPZPx4Jvec89IHR1fSg1tOg+eG8NQGzhdcv6OsrOqZH1CBZev5k1rPpM
         q5AP+1aOMuGsDEPRhzY2oeugQRUOsXa4/+BE39k4rxjBcsmXT1v02nkvV5+ND5xdm3kO
         ixYCgdj3AORpLjAfpXMMxI+/O+dtrRuavsQoY69cdgrp0Yqix93pi/KGpH5Z4d8dWrU9
         +IGGUfKNVELER3AzO36uyx3l0OUlmOS613QRxqpTvVCJ3BipUgwRhoxL+3kXpKkhd+28
         6R2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=+t48Q8KkFENFm+kHlN+Brhw2DxX9JJkzfGw4eDrv4nU=;
        b=dAeLdDpuefIijskMhzYBacwB4/F4AAmaPIp1yRP215lp2GGmXzc05bUr6gpSP+usPx
         EPsRUmGil9MZtRrFFWdKgANoy+BmjPpl1D+Gp/xpBoGuWGBw+CFnJAeVq3zQ3aU/3xrf
         2CcLPV/s71UsztoIEYYwfXIchOdjzbgOKLgJaKi3XbAuDrPPbhIyqcvRlXo6BOpjGnyZ
         TXemWnh2p7xEss1Qfea5RxKTDCpXxiwb0M+/4+wuICb/Ds5Wju9Bk5XlNfLLOmvGgqkI
         mWdwbc+oDcnjWtzv+iBX9jy7rHCx9YgbEHBJzVgBrQ99K7UXZ9In8aSfqaZqBCkGiB6c
         6JFQ==
X-Gm-Message-State: APjAAAWmOdbMivsHwwt2E3/675ePqzZmiYfhRc4h756OdGzYLGcFGhZL
        TJhuMIG9uNkvMAO+n72g7FUN52djv2mqO+ktFpk=
X-Google-Smtp-Source: APXvYqxaVF0SGE//JjI6CN2hkMckkBtZovemDywnco+huYTpnft4NI3m2YEXopqLjpWTOAhwiiJBlqyxbZ/puTiiVrw=
X-Received: by 2002:adf:c002:: with SMTP id z2mr18762171wre.177.1554734067583;
 Mon, 08 Apr 2019 07:34:27 -0700 (PDT)
MIME-Version: 1.0
References: <CA+icZUVW2X6G=qukJTrZuUevcnrOiuShJGxnxVaqyONNxv+RYg@mail.gmail.com>
 <e5d3d2fc-874c-a8e3-1320-f9396a3621b5@redhat.com> <99dde862-6aee-65a0-8b39-33b8ac10df45@redhat.com>
 <CA+icZUUw3SgyCdk9fyv+mVUGDepDNGj8Bm7t0WWOE3Q0sHJs4Q@mail.gmail.com> <863a33cf-0a1a-17af-0ea8-42e288f8a1fd@redhat.com>
In-Reply-To: <863a33cf-0a1a-17af-0ea8-42e288f8a1fd@redhat.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Mon, 8 Apr 2019 16:34:16 +0200
Message-ID: <CA+icZUVvtLkNNor+9wQy1_bt=NfRAfJD9f_daqX2Da=EcdjAaA@mail.gmail.com>
Subject: Re: CBL issue #431: lld: x86_64: sysfs: cannot create duplicate
 filename $module/.rodata.cst{16,32}
To:     Denys Vlasenko <dvlasenk@redhat.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 8, 2019 at 4:29 PM Denys Vlasenko <dvlasenk@redhat.com> wrote:
>
> On 4/8/19 4:23 PM, Sedat Dilek wrote:
> > For the .rodata.cst16 part you mean sth. like this?
>
> yes, see below
>
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
> > +.section        .rodata.cst16.camellia-aesni-avx-asm_64, "aM", @progbits, 16
>
> dashes in the name may cause problems, replace with '_'.
>
> >   .align 16
> >
> >   #define SHUFB_BYTES(idx) \
> > diff --git a/arch/x86/crypto/camellia-aesni-avx2-asm_64.S
> > b/arch/x86/crypto/camellia-aesni-avx2-asm_64.S
> > index b66bbfa62f50..d6ce36e82a93 100644
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
> > +.section        .rodata.cst16.ccamellia-aesni-avx2-asm_64, "aM", @progbits, 16
>
> dashes in the name may cause problems, replace with '_'.

Oops.

v2:

sdi@iniza:~/src/linux-kernel/linux$ git --no-pager diff
diff --git a/arch/x86/crypto/camellia-aesni-avx-asm_64.S
b/arch/x86/crypto/camellia-aesni-avx-asm_64.S
index a14af6eb09cb..712d6a7e8b8f 100644
--- a/arch/x86/crypto/camellia-aesni-avx-asm_64.S
+++ b/arch/x86/crypto/camellia-aesni-avx-asm_64.S
@@ -573,8 +573,12 @@
ENDPROC(roundsm16_x4_x5_x6_x7_x0_x1_x2_x3_y4_y5_y6_y7_y0_y1_y2_y3_ab)
        vmovdqu y7, 15 * 16(rio);


-/* NB: section is mergeable, all elements must be aligned 16-byte blocks */
-.section       .rodata.cst16, "aM", @progbits, 16
+/*
+ * NB: section is mergeable, all elements must be aligned 16-byte blocks
+ * There is more than one object in this section, let's use module name
+ * instead of object name as unique suffix
+ */
+.section        .rodata.cst16.camellia_aesni_avx_asm_64, "aM", @progbits, 16
 .align 16

 #define SHUFB_BYTES(idx) \
diff --git a/arch/x86/crypto/camellia-aesni-avx2-asm_64.S
b/arch/x86/crypto/camellia-aesni-avx2-asm_64.S
index b66bbfa62f50..34f6b0c4196d 100644
--- a/arch/x86/crypto/camellia-aesni-avx2-asm_64.S
+++ b/arch/x86/crypto/camellia-aesni-avx2-asm_64.S
@@ -626,8 +626,12 @@
ENDPROC(roundsm32_x4_x5_x6_x7_x0_x1_x2_x3_y4_y5_y6_y7_y0_y1_y2_y3_ab)
        .long 0x00010203, 0x04050607, 0x80808080, 0x80808080
        .long 0x00010203, 0x04050607, 0x80808080, 0x80808080

-/* NB: section is mergeable, all elements must be aligned 16-byte blocks */
-.section       .rodata.cst16, "aM", @progbits, 16
+/*
+ * NB: section is mergeable, all elements must be aligned 16-byte blocks
+ * There is more than one object in this section, let's use module name
+ * instead of object name as unique suffix
+*/
+.section        .rodata.cst16.ccamellia_aesni_avx2_asm_64, "aM", @progbits, 16
 .align 16

 /* For CTR-mode IV byteswap */
diff --git a/arch/x86/crypto/cast6-avx-x86_64-asm_64.S
b/arch/x86/crypto/cast6-avx-x86_64-asm_64.S
index 7f30b6f0d72c..fcd5732aba4d 100644
--- a/arch/x86/crypto/cast6-avx-x86_64-asm_64.S
+++ b/arch/x86/crypto/cast6-avx-x86_64-asm_64.S
@@ -225,7 +225,12 @@
        vpshufb rmask,          x2, x2;       \
        vpshufb rmask,          x3, x3;

-.section       .rodata.cst16, "aM", @progbits, 16
+/*
+ * NB: section is mergeable, all elements must be aligned 16-byte blocks
+ * There is more than one object in this section, let's use module name
+ * instead of object name as unique suffix
+ */
+.section        .rodata.cst16.cast6_avx_x86_64_asm_64, "aM", @progbits, 16
 .align 16
 .Lxts_gf128mul_and_shl1_mask:
        .byte 0x87, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0

I tried to check for the .rodata.cst32 case, how do I identify the *.S files?

- Sedat -
