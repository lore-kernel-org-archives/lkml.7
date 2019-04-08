Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F8A3C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 14:24:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47E2321473
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 14:24:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FKMeJicU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbfDHOYA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 10:24:00 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33362 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726349AbfDHOX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 10:23:59 -0400
Received: by mail-wm1-f68.google.com with SMTP id z6so98243wmi.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 07:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=hJZeisUDTLSfqcq/veZ5B7pzvTvzhEpC8ZWVzvwPuls=;
        b=FKMeJicUbfagnmgT+Hay4+CphiW8FmCgFGhFy9nJtJCXw9rIqe6tzZzKzFXfREKdii
         A2ZZRomh/t9S3W/MMmfRv4mBchuQRLUvsXDTsRhxVghzn0Pblsh/45fIjU9p1uQDQjcl
         82tuxbqrjwLsF+wXrULEWV8SwIc8BfYEXsp5Qze69uKxWs1ynjeQ+gfTsHU2jt0n/tmC
         WBx1Kk/fnhAcXGqLgVb16yCsvSDgLzDf+rCYh5xwNFRT7f2SnlpBFm7z+9IBe8tCjkfo
         GP6BTMm0Y+6GYcuT32cvPQ8XnCookdCTRlzovlJIn9azsBgbNlmG7gK6KfeCBRW8hgHb
         XcJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=hJZeisUDTLSfqcq/veZ5B7pzvTvzhEpC8ZWVzvwPuls=;
        b=gB25UUmVEUqjka11T014O88fRdcbDrW9E9Rom5NGUeB9tHvsAwEhsHocLJf+ECbVwc
         4jQqkp0i7lEkMc7VAjPa/e4hOBqyKI1RTvC16cQpHzHXg0DUw329IoB4BMDB3gNa9LqQ
         CnNhke9Vgv7tX6K67qRb4XZxT8+hOx8hcvbL/Lo5Sc21SCBkuRVxrbpPai4NT42SwFzO
         vMQA4NQwB5YLDMuAgbIvu+PGLU6v+St7iKjNZKhc+fUiqASnIT8KNj3aOgNc+00K3fbK
         6jznwidWQxQga8iuesw4qq8c//VBIB6sLPh/N2oh5fDuMYyngNG3i4kKGzD/45xj4p9c
         BmLA==
X-Gm-Message-State: APjAAAX1Ezrvib4NvyI2k7Gvo/F1aSn2BGtzoyPzr5Yf8OqmpLOCSA2Z
        j9G2tHG/AAGGDxr1mylM7n9+Qx+NV7JO9BGG5iU=
X-Google-Smtp-Source: APXvYqx7FK/FDApzERyXVTR1vRlP17e+5FoVF1TKnyRAhSETSDvC1Kr5yYj6kI5ipTBQHFZowfp+oyjoCwznBBMzchA=
X-Received: by 2002:a7b:c4d2:: with SMTP id g18mr1090912wmk.108.1554733437235;
 Mon, 08 Apr 2019 07:23:57 -0700 (PDT)
MIME-Version: 1.0
References: <CA+icZUVW2X6G=qukJTrZuUevcnrOiuShJGxnxVaqyONNxv+RYg@mail.gmail.com>
 <e5d3d2fc-874c-a8e3-1320-f9396a3621b5@redhat.com> <99dde862-6aee-65a0-8b39-33b8ac10df45@redhat.com>
In-Reply-To: <99dde862-6aee-65a0-8b39-33b8ac10df45@redhat.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Mon, 8 Apr 2019 16:23:45 +0200
Message-ID: <CA+icZUUw3SgyCdk9fyv+mVUGDepDNGj8Bm7t0WWOE3Q0sHJs4Q@mail.gmail.com>
Subject: Re: CBL issue #431: lld: x86_64: sysfs: cannot create duplicate
 filename $module/.rodata.cst{16,32}
To:     Denys Vlasenko <dvlasenk@redhat.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 8, 2019 at 3:58 PM Denys Vlasenko <dvlasenk@redhat.com> wrote:
>
> On 4/8/19 3:56 PM, Denys Vlasenko wrote:
> > I propose to change section name, append _module_ name and optionally
> > a comment why this is done:
> >
> >   /* NB: section is mergeable, all elements must be aligned 16-byte blocks */
> > +/* There is more than one object in this section, let's use module name
> > +   as unique suffix */
>
> Probably not clear enough... maybe this is better:
>
> +/* There is more than one object in this section, let's use module name
> +   instead of object name as unique suffix */
> -.section        .rodata.cst16, "aM", @progbits, 16
>
> and do not use '-' in the name, replace with '_':
>
> +.section        .rodata.cst16.cast6_avx_x86_64_asm_64, "aM", @progbits, 16
>
>

Hi Denys,

Thanks for the quick answer!

For the .rodata.cst16 part you mean sth. like this?

sdi@iniza:~/src/linux-kernel/linux$ git --no-pager diff
diff --git a/arch/x86/crypto/camellia-aesni-avx-asm_64.S
b/arch/x86/crypto/camellia-aesni-avx-asm_64.S
index a14af6eb09cb..19b2b80258d2 100644
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
+.section        .rodata.cst16.camellia-aesni-avx-asm_64, "aM", @progbits, 16
 .align 16

 #define SHUFB_BYTES(idx) \
diff --git a/arch/x86/crypto/camellia-aesni-avx2-asm_64.S
b/arch/x86/crypto/camellia-aesni-avx2-asm_64.S
index b66bbfa62f50..d6ce36e82a93 100644
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
+.section        .rodata.cst16.ccamellia-aesni-avx2-asm_64, "aM", @progbits, 16
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

Regards,
- Sedat -
