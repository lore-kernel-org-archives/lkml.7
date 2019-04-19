Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F8E1C282E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:43:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66EDD205C9
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:43:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbfDSSnd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:43:33 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:36062 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbfDSSnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:43:33 -0400
Received: by mail-ot1-f68.google.com with SMTP id o74so4994465ota.3;
        Fri, 19 Apr 2019 11:43:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rgm+DlPYj4YwXD0IUlXbIhCkCaP4ItKaQlGxc47GSHs=;
        b=SInIFcY2m/TthGm7X5J5Pfh5/DQVBIN+8IX9GBRwCmeME5BBL+YdnsY6m9iKJrSJP0
         d4T5uk0NLMnY0ZUcQdPnx+0P0x41Qju76vA+uWVpqBfJMEC9s+hyD5TtUrjKb16I8jcr
         CB3GDLbsi0tuD+CY1eFkR4kR2z3g3rF1Bt4rUS1647NBbn+xRvUVYeAGZ0iflbdtvVR5
         kCA1AoQQism+1jfr6f2V2p8tDjGlILnyC55bT5PrlaLsY6EgbROxIn59CW42TIjJfpxr
         OHXwSM8XFEJ4kS9UadY8A34aIAlzMJjV0TwxkT/Zxy5tP+RoTptVs41SFVenXQY4WtYC
         zK+w==
X-Gm-Message-State: APjAAAVD3ky2kh/ApTNtrpqKFS+D3jNF8Ij0snE/ufOCcY9q9WFYfo6V
        VfTk1D5yzTTWtKe3cj6rCaIummrlxNJ/1RHD//0oQw3N
X-Google-Smtp-Source: APXvYqyzS5bhws5CT7A5nXn4OpfeWT4dvhjZS6lwiZnWt+A2qa8xQlOemhAXzlKYNBL6JXPtGyLamsLnBS+1CfuvVbc=
X-Received: by 2002:a9d:7dda:: with SMTP id k26mr2666597otn.354.1555688742221;
 Fri, 19 Apr 2019 08:45:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190419094754.24667-1-yamada.masahiro@socionext.com> <20190419094754.24667-7-yamada.masahiro@socionext.com>
In-Reply-To: <20190419094754.24667-7-yamada.masahiro@socionext.com>
From:   Mathieu Malaterre <malat@debian.org>
Date:   Fri, 19 Apr 2019 17:45:31 +0200
Message-ID: <CA+7wUsygTo=AN_giku_X6_a4mQWdJL48RoVbVB4hBqkZSKkP0Q@mail.gmail.com>
Subject: Re: [PATCH v2 06/11] MIPS: mark __fls() as __always_inline
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-s390@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        x86@kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-mips@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, linux-mtd@lists.infradead.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Apr 19, 2019 at 12:06 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> This prepares to move CONFIG_OPTIMIZE_INLINING from x86 to a common
> place. We need to eliminate potential issues beforehand.
>
> If it is enabled for mips, the following errors are reported:
>
> arch/mips/mm/sc-mips.o: In function `mips_sc_prefetch_enable.part.2':
> sc-mips.c:(.text+0x98): undefined reference to `mips_gcr_base'
> sc-mips.c:(.text+0x9c): undefined reference to `mips_gcr_base'
> sc-mips.c:(.text+0xbc): undefined reference to `mips_gcr_base'
> sc-mips.c:(.text+0xc8): undefined reference to `mips_gcr_base'
> sc-mips.c:(.text+0xdc): undefined reference to `mips_gcr_base'
> arch/mips/mm/sc-mips.o:sc-mips.c:(.text.unlikely+0x44): more undefined references to `mips_gcr_base'

Tested with success on ppc32/G4. But on CI20 (ci20_defconfig from
master), I get:

  MODPOST vmlinux.o
mipsel-linux-gnu-ld: arch/mips/kernel/traps.o: in function
`addr_gcr_err_control':
/home/mathieu/tmp/linux/linux/ci20/../arch/mips/include/asm/mips-cm.h:169:
undefined reference to `mips_gcr_base'
mipsel-linux-gnu-ld:
/home/mathieu/linux/linux/ci20/../arch/mips/include/asm/mips-cm.h:169:
undefined reference to `mips_gcr_base'
mipsel-linux-gnu-ld: arch/mips/mm/sc-mips.o: in function
`addr_gcr_l2_pft_control':
/home/mathieu/linux/linux/ci20/../arch/mips/include/asm/mips-cm.h:246:
undefined reference to `mips_gcr_base'
mipsel-linux-gnu-ld:
/home/mathieu/linux/linux/ci20/../arch/mips/include/asm/mips-cm.h:246:
undefined reference to `mips_gcr_base'
mipsel-linux-gnu-ld:
/home/mathieu/linux/linux/ci20/../arch/mips/include/asm/mips-cm.h:246:
undefined reference to `mips_gcr_base'
mipsel-linux-gnu-ld:
arch/mips/mm/sc-mips.o:/home/mathieu/linux/linux/ci20/../arch/mips/include/asm/mips-cm.h:246:
more undefined references to `mips_gcr_base' follow


> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>
> Changes in v2:
>   - new patch
>
>  arch/mips/include/asm/bitops.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/mips/include/asm/bitops.h b/arch/mips/include/asm/bitops.h
> index 830c93a010c3..6a26ead1c2b6 100644
> --- a/arch/mips/include/asm/bitops.h
> +++ b/arch/mips/include/asm/bitops.h
> @@ -482,7 +482,7 @@ static inline void __clear_bit_unlock(unsigned long nr, volatile unsigned long *
>   * Return the bit position (0..63) of the most significant 1 bit in a word
>   * Returns -1 if no 1 bit exists
>   */
> -static inline unsigned long __fls(unsigned long word)
> +static __always_inline unsigned long __fls(unsigned long word)
>  {
>         int num;
>
> --
> 2.17.1
>
