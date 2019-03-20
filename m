Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C544C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 09:38:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24ABD206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 09:38:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727429AbfCTJi5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 05:38:57 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39192 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbfCTJi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 05:38:57 -0400
Received: by mail-qt1-f193.google.com with SMTP id t28so1679275qte.6;
        Wed, 20 Mar 2019 02:38:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=baqznmx5SEUGlKXy0XWhrYbi7y7TbN73HabOIUzlc9g=;
        b=AV8xLCAlOfLApJ983+esKs6J5QuAr+q1ZD3b0+rANLQvkPqYBBCL6LrLwUGRNK/pfm
         6jkehnnbe28T/hFkSRkiv8lJhoE26bVxg0UjzyIQCYVdGe4aJNkLJFWWHTkUfqWfLoqO
         1S/2+IZUucvLu8/yvNqhqNNjhUARttjzEzZeu5TajmJaIEJOKqKrs7f8la9MoDeIIk6b
         SzAoKQpjOgWhDrrzQNDIVvnE2ZWYJ+5YuqrM1eeRHxmZXjt7AhBF3cTJJPtX34iQ21Gt
         pUMh87uNuGWbKO0aAWC3pNkTBAAispPAWQrsxrYKGdNpC+zMpgKAyuy3EeVtMVY3rA1J
         ieZg==
X-Gm-Message-State: APjAAAXKVFOlcaEhSRnCeMa5jmREsWvYm93EFAzJuLLqAejQJ+Tu8L83
        CM6rnmUtTjHDPx+W404jiEbQt0JEp36vsAhkxMZFlyf2
X-Google-Smtp-Source: APXvYqy0JoRVFSrNJl/sRu1o+RTIjkEJdtNCtG5nQiriXKN6DBYQFFQrpf5g/fTnXJYyTn69eJne/HE0Vv+ZGAZte2M=
X-Received: by 2002:ac8:276b:: with SMTP id h40mr6073731qth.319.1553074735819;
 Wed, 20 Mar 2019 02:38:55 -0700 (PDT)
MIME-Version: 1.0
References: <1553062828-27798-1-git-send-email-yamada.masahiro@socionext.com> <CAK7LNAQu9hmeSgKO_B1LhXqq9Z923H25HXNS9XYNvFi55WrFYw@mail.gmail.com>
In-Reply-To: <CAK7LNAQu9hmeSgKO_B1LhXqq9Z923H25HXNS9XYNvFi55WrFYw@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 20 Mar 2019 10:38:38 +0100
Message-ID: <CAK8P3a0-7LRE4ByO2Uf4tb5mR49SbZzBu0AgHpS=03FAMWFLgQ@mail.gmail.com>
Subject: Re: [PATCH] compiler: allow all arches to enable CONFIG_OPTIMIZE_INLINING
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Dave Hansen <dave@sr71.net>,
        Michael Ellerman <mpe@ellerman.id.au>, X86 ML <x86@kernel.org>,
        linux-mips@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Paul Burton <paul.burton@mips.com>,
        Ingo Molnar <mingo@redhat.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 7:41 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:

> It is unclear to me how to fix it.
> That's why I ended up with "depends on !MIPS".
>
>
>   MODPOST vmlinux.o
> arch/mips/mm/sc-mips.o: In function `mips_sc_prefetch_enable.part.2':
> sc-mips.c:(.text+0x98): undefined reference to `mips_gcr_base'
> sc-mips.c:(.text+0x9c): undefined reference to `mips_gcr_base'
> sc-mips.c:(.text+0xbc): undefined reference to `mips_gcr_base'
> sc-mips.c:(.text+0xc8): undefined reference to `mips_gcr_base'
> sc-mips.c:(.text+0xdc): undefined reference to `mips_gcr_base'
> arch/mips/mm/sc-mips.o:sc-mips.c:(.text.unlikely+0x44): more undefined
> references to `mips_gcr_base'
>
>
> Perhaps, MIPS folks may know how to fix it.

I would guess like this:

diff --git a/arch/mips/include/asm/mips-cm.h b/arch/mips/include/asm/mips-cm.h
index 8bc5df49b0e1..a27483fedb7d 100644
--- a/arch/mips/include/asm/mips-cm.h
+++ b/arch/mips/include/asm/mips-cm.h
@@ -79,7 +79,7 @@ static inline int mips_cm_probe(void)
  *
  * Returns true if a CM is present in the system, else false.
  */
-static inline bool mips_cm_present(void)
+static __always_inline bool mips_cm_present(void)
 {
 #ifdef CONFIG_MIPS_CM
        return mips_gcr_base != NULL;
@@ -93,7 +93,7 @@ static inline bool mips_cm_present(void)
  *
  * Returns true if the system implements an L2-only sync region, else false.
  */
-static inline bool mips_cm_has_l2sync(void)
+static __always_inline bool mips_cm_has_l2sync(void)
 {
 #ifdef CONFIG_MIPS_CM
        return mips_cm_l2sync_base != NULL;
