Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E39C6C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 10:51:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B962B25792
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 10:51:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="wDt2SGJo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbfE3KvY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 06:51:24 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:57319 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726198AbfE3KvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 06:51:24 -0400
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id x4UApGno018683;
        Thu, 30 May 2019 19:51:17 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com x4UApGno018683
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1559213477;
        bh=j5xMXtzlfJmtrDOpctpofJ+GhwQ4JC0Tahjh8T6hfJo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=wDt2SGJoCbR8lZkqChfL+ohh3godb14CBnYHfsR842blEZ9HJtzhaG5JRuXHzPW0H
         HuS/tqXXZRS0f6xuTiICGO4Jgu4+fjAcUYFpphsCf/aWsTLfQn/kelbj03rwpcFsow
         E4zKd4JCdjdskMOMLi2GN+OY/XvYc5moE5pVZe6MlZVSE0mv/nxvdP/rGZ3ig05Ugx
         tbgq7G/aziCXuWhXMDa+2IUFGlmEHdxS7nuGTmJf89G/ulL4KYhkSCSfExuJ/aDJeZ
         3+Zp4a9GIm/MgIzg6BXdXxy7bRqJEDZRVn+Ov5re91eDUeQnJDBw2kprTbkkFaG75W
         Ii/kpd8Xj+fgw==
X-Nifty-SrcIP: [209.85.217.54]
Received: by mail-vs1-f54.google.com with SMTP id q64so4094769vsd.1;
        Thu, 30 May 2019 03:51:17 -0700 (PDT)
X-Gm-Message-State: APjAAAWisKc3pbbkYoBUSlPMxQ6oX2uEbGJun76NCmSvcWhTWxj+TW8N
        cFAryo/YUtJkEa6D1aW+qjzKpaT3w82eeJJvRTU=
X-Google-Smtp-Source: APXvYqz1eQpgy1klSJRUBat0BPbDkemKQMZQlg44UME+WzfyPZ3ATsQu01dDSjF1W1pCCB66UyAzAWUE0x86MfG9NnE=
X-Received: by 2002:a67:1783:: with SMTP id 125mr1567738vsx.54.1559213476461;
 Thu, 30 May 2019 03:51:16 -0700 (PDT)
MIME-Version: 1.0
References: <1556887064-12882-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1556887064-12882-1-git-send-email-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 30 May 2019 19:50:40 +0900
X-Gmail-Original-Message-ID: <CAK7LNATKCRqcDWg4X_e2N3TuxTmfr34ZYJOJU=SbubE-+S4eTQ@mail.gmail.com>
Message-ID: <CAK7LNATKCRqcDWg4X_e2N3TuxTmfr34ZYJOJU=SbubE-+S4eTQ@mail.gmail.com>
Subject: Re: [PATCH] x86,sh: use __builtin_constant_p() directly instead of IS_IMMEDIATE()
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     X86 ML <x86@kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On Fri, May 3, 2019 at 9:48 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> __builtin_constant_p(nr) is used everywhere now. It does not make
> much sense to define IS_IMMEDIATE() as its alias.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Ping. Is this a good clean-up?

Thanks.

> ---
>
>  arch/sh/include/asm/bitops-op32.h | 8 +++-----
>  arch/x86/include/asm/bitops.h     | 7 +++----
>  2 files changed, 6 insertions(+), 9 deletions(-)
>
> diff --git a/arch/sh/include/asm/bitops-op32.h b/arch/sh/include/asm/bitops-op32.h
> index 4668803..cfe5465 100644
> --- a/arch/sh/include/asm/bitops-op32.h
> +++ b/arch/sh/include/asm/bitops-op32.h
> @@ -16,11 +16,9 @@
>  #define BYTE_OFFSET(nr)                ((nr) % BITS_PER_BYTE)
>  #endif
>
> -#define IS_IMMEDIATE(nr)       (__builtin_constant_p(nr))
> -
>  static inline void __set_bit(int nr, volatile unsigned long *addr)
>  {
> -       if (IS_IMMEDIATE(nr)) {
> +       if (__builtin_constant_p(nr)) {
>                 __asm__ __volatile__ (
>                         "bset.b %1, @(%O2,%0)           ! __set_bit\n\t"
>                         : "+r" (addr)
> @@ -37,7 +35,7 @@ static inline void __set_bit(int nr, volatile unsigned long *addr)
>
>  static inline void __clear_bit(int nr, volatile unsigned long *addr)
>  {
> -       if (IS_IMMEDIATE(nr)) {
> +       if (__builtin_constant_p(nr)) {
>                 __asm__ __volatile__ (
>                         "bclr.b %1, @(%O2,%0)           ! __clear_bit\n\t"
>                         : "+r" (addr)
> @@ -64,7 +62,7 @@ static inline void __clear_bit(int nr, volatile unsigned long *addr)
>   */
>  static inline void __change_bit(int nr, volatile unsigned long *addr)
>  {
> -       if (IS_IMMEDIATE(nr)) {
> +       if (__builtin_constant_p(nr)) {
>                 __asm__ __volatile__ (
>                         "bxor.b %1, @(%O2,%0)           ! __change_bit\n\t"
>                         : "+r" (addr)
> diff --git a/arch/x86/include/asm/bitops.h b/arch/x86/include/asm/bitops.h
> index 8e790ec..2621438 100644
> --- a/arch/x86/include/asm/bitops.h
> +++ b/arch/x86/include/asm/bitops.h
> @@ -45,7 +45,6 @@
>   * We do the locked ops that don't return the old value as
>   * a mask operation on a byte.
>   */
> -#define IS_IMMEDIATE(nr)               (__builtin_constant_p(nr))
>  #define CONST_MASK_ADDR(nr, addr)      WBYTE_ADDR((void *)(addr) + ((nr)>>3))
>  #define CONST_MASK(nr)                 (1 << ((nr) & 7))
>
> @@ -67,7 +66,7 @@
>  static __always_inline void
>  set_bit(long nr, volatile unsigned long *addr)
>  {
> -       if (IS_IMMEDIATE(nr)) {
> +       if (__builtin_constant_p(nr)) {
>                 asm volatile(LOCK_PREFIX "orb %1,%0"
>                         : CONST_MASK_ADDR(nr, addr)
>                         : "iq" ((u8)CONST_MASK(nr))
> @@ -105,7 +104,7 @@ static __always_inline void __set_bit(long nr, volatile unsigned long *addr)
>  static __always_inline void
>  clear_bit(long nr, volatile unsigned long *addr)
>  {
> -       if (IS_IMMEDIATE(nr)) {
> +       if (__builtin_constant_p(nr)) {
>                 asm volatile(LOCK_PREFIX "andb %1,%0"
>                         : CONST_MASK_ADDR(nr, addr)
>                         : "iq" ((u8)~CONST_MASK(nr)));
> @@ -186,7 +185,7 @@ static __always_inline void __change_bit(long nr, volatile unsigned long *addr)
>   */
>  static __always_inline void change_bit(long nr, volatile unsigned long *addr)
>  {
> -       if (IS_IMMEDIATE(nr)) {
> +       if (__builtin_constant_p(nr)) {
>                 asm volatile(LOCK_PREFIX "xorb %1,%0"
>                         : CONST_MASK_ADDR(nr, addr)
>                         : "iq" ((u8)CONST_MASK(nr)));
> --
> 2.7.4
>


-- 
Best Regards
Masahiro Yamada
