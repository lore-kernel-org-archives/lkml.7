Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E63EC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 03:53:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2086F2087C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 03:53:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="NXTsxJpb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbfCLDxf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 23:53:35 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:35338 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726789AbfCLDxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 23:53:34 -0400
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id x2C3rS6D010613;
        Tue, 12 Mar 2019 12:53:29 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com x2C3rS6D010613
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1552362810;
        bh=zaFOfAURZdCPkLs5TWzJTBb7mi5E51HVonr3K6V00qk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NXTsxJpbPzI/WrA8Dp1KoXEXlyqzWtExTYUNeZ9uZ72Yr57QFvSc0pBQ7JZEkj10q
         nq+2xgWI1r6+0E4SEY8i7gpYFn2tzwWpvBm3NYmH8CqtrdS81rYnK38C7A7etxZfvb
         vi+A9SBpdLSOkdhWoNdu2umGo84cbKV6C86NJtx9YEREa2ZiKwur9XMP2zDMGNRJfQ
         2P7xvo9Kyaynvkr/nPvM5YFT5UCecFD+M0AJOoTMC+/J9qjiToWJiGnYCg/8rjZyUL
         bPqFcvw4Nd6HQwWAXJwO/NO77Mf+7Hkyh9A2xMBCp5soDxz5z9nVncb6hE3SLTcdj9
         69gNRfFiIuGTA==
X-Nifty-SrcIP: [209.85.222.45]
Received: by mail-ua1-f45.google.com with SMTP id s15so332131uap.6;
        Mon, 11 Mar 2019 20:53:29 -0700 (PDT)
X-Gm-Message-State: APjAAAXxOAJ3DYj60KBXLWrF8jfy95ZU+XIdCKrSQG6AZRuBpud2VX+0
        Z86uphOEiuAK+qDe4i0v1SY82w4Pc5yn87ekdi0=
X-Google-Smtp-Source: APXvYqzE31VoxdkNTkmjDAhDMw85ZNm/gTfVkbd24vrF6IAKaVYIbWe2srjPW0nedNO+0WSfnuQ24t2XQhYUwtznJ9I=
X-Received: by 2002:ab0:648c:: with SMTP id p12mr18434292uam.93.1552362808236;
 Mon, 11 Mar 2019 20:53:28 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1551598603.git.vilhelm.gray@gmail.com> <12b3a364ac7fc32194fa6f55911dd800aca92a56.1551598603.git.vilhelm.gray@gmail.com>
In-Reply-To: <12b3a364ac7fc32194fa6f55911dd800aca92a56.1551598603.git.vilhelm.gray@gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 12 Mar 2019 12:52:51 +0900
X-Gmail-Original-Message-ID: <CAK7LNATsuQRj9-zT-+joRxjX1ePVG4ofeT=KS84Cjid2C5_v4Q@mail.gmail.com>
Message-ID: <CAK7LNATsuQRj9-zT-+joRxjX1ePVG4ofeT=KS84Cjid2C5_v4Q@mail.gmail.com>
Subject: Re: [PATCH v9 1/9] bitops: Introduce the for_each_set_clump8 macro
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        bgolaszewski@baylibre.com,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 3, 2019 at 4:48 PM William Breathitt Gray
<vilhelm.gray@gmail.com> wrote:
>
> This macro iterates for each 8-bit group of bits (clump) with set bits,
> within a bitmap memory region. For each iteration, "start" is set to the
> bit offset of the found clump, while the respective clump value is
> stored to the location pointed by "clump". Additionally, the
> bitmap_get_value8 and bitmap_set_value8 functions are introduced to
> respectively get and set an 8-bit value in a bitmap memory region.
>
> Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Suggested-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> ---
>  include/asm-generic/bitops/find.h | 14 ++++++
>  include/linux/bitops.h            |  5 ++
>  lib/find_bit.c                    | 81 +++++++++++++++++++++++++++++++
>  3 files changed, 100 insertions(+)
>
> diff --git a/include/asm-generic/bitops/find.h b/include/asm-generic/bitops/find.h
> index 8a1ee10014de..9a76adff59c6 100644
> --- a/include/asm-generic/bitops/find.h
> +++ b/include/asm-generic/bitops/find.h
> @@ -80,4 +80,18 @@ extern unsigned long find_first_zero_bit(const unsigned long *addr,
>
>  #endif /* CONFIG_GENERIC_FIND_FIRST_BIT */
>
> +unsigned long bitmap_get_value8(const unsigned long *const bitmap,
> +                               const unsigned int size,
> +                               const unsigned int start);
> +
> +void bitmap_set_value8(unsigned long *const bitmap, const unsigned int size,
> +                      const unsigned long value, const unsigned int start);
> +
> +unsigned int find_next_clump8(unsigned long *const clump,
> +                             const unsigned long *const addr,
> +                             unsigned int offset, const unsigned int size);
> +
> +#define find_first_clump8(clump, bits, size) \
> +       find_next_clump8((clump), (bits), 0, (size))
> +
>  #endif /*_ASM_GENERIC_BITOPS_FIND_H_ */
> diff --git a/include/linux/bitops.h b/include/linux/bitops.h
> index 705f7c442691..61c10f20079e 100644
> --- a/include/linux/bitops.h
> +++ b/include/linux/bitops.h
> @@ -40,6 +40,11 @@ extern unsigned long __sw_hweight64(__u64 w);
>              (bit) < (size);                                    \
>              (bit) = find_next_zero_bit((addr), (size), (bit) + 1))
>
> +#define for_each_set_clump8(start, clump, bits, size) \
> +       for ((start) = find_first_clump8(&(clump), (bits), (size)); \
> +            (start) < (size); \
> +            (start) = find_next_clump8(&(clump), (bits), (start) + 8, (size)))
> +
>  static inline int get_bitmask_order(unsigned int count)
>  {
>         int order;
> diff --git a/lib/find_bit.c b/lib/find_bit.c
> index ee3df93ba69a..c2af1f013ea2 100644
> --- a/lib/find_bit.c
> +++ b/lib/find_bit.c
> @@ -218,3 +218,84 @@ EXPORT_SYMBOL(find_next_bit_le);
>  #endif
>
>  #endif /* __BIG_ENDIAN */
> +
> +/**
> + * bitmap_get_value8 - get an 8-bit value within a memory region
> + * @bitmap: address to the bitmap memory region
> + * @size: bitmap size in number of bits
> + * @start: bit offset of the 8-bit value
> + *
> + * Returns the 8-bit value located at the @start bit offset within the @bitmap
> + * memory region.
> + */
> +unsigned long bitmap_get_value8(const unsigned long *const bitmap,
> +                               const unsigned int size,
> +                               const unsigned int start)


A bunch of 'const' qualifiers are eyesore.

The first 'const' of bitmap is the only useful one.


unsigned long bitmap_get_value8(const unsigned long *bitmap, unsigned int size,
                                unsigned int start)

is enough.





> +{
> +       const size_t index = BIT_WORD(start);
> +       const unsigned int offset = start % BITS_PER_LONG;
> +       const unsigned int low_width = (offset + 8 > BITS_PER_LONG) ?
> +                                      BITS_PER_LONG - offset : 8;
> +       const unsigned long low = bitmap[index] >> offset;
> +       const unsigned long high = (low_width < 8 && start + 8 <= size) ?
> +                                  bitmap[index + 1] << low_width : 0;


Meh.



> +
> +       return (low | high) & 0xFF;
> +}
> +EXPORT_SYMBOL(bitmap_get_value8);
> +
> +/**
> + * bitmap_set_value8 - set an 8-bit value within a memory region
> + * @bitmap: address to the bitmap memory region
> + * @size: bitmap size in number of bits
> + * @value: the 8-bit value; values wider than 8 bits may clobber bitmap
> + * @start: bit offset of the 8-bit value
> + */
> +void bitmap_set_value8(unsigned long *const bitmap, const unsigned int size,
> +                      const unsigned long value, const unsigned int start)
> +{
> +       const size_t index = BIT_WORD(start);
> +       const unsigned int offset = start % BITS_PER_LONG;
> +       const unsigned int low_width = (offset + 8 > BITS_PER_LONG) ?
> +                                      BITS_PER_LONG - offset : 8;
> +       const unsigned long low_mask = GENMASK(offset + low_width - 1, offset);
> +       const unsigned int high_width = 8 - low_width;
> +       const unsigned long high_mask = GENMASK(high_width - 1, 0);
> +
> +       /* set lower portion */
> +       bitmap[index] &= ~low_mask;
> +       bitmap[index] |= value << offset;
> +
> +       /* set higher portion if space available in bitmap */
> +       if (high_width && start + 8 <= size) {
> +               bitmap[index + 1] &= ~high_mask;
> +               bitmap[index + 1] |= value >> low_width;
> +       }
> +}
> +EXPORT_SYMBOL(bitmap_set_value8);
> +
> +/**
> + * find_next_clump8 - find next 8-bit clump with set bits in a memory region
> + * @clump: location to store copy of found clump
> + * @addr: address to base the search on
> + * @offset: bit offset at which to start searching
> + * @size: bitmap size in number of bits
> + *
> + * Returns the bit offset for the next set clump; the found clump value is
> + * copied to the location pointed by @clump. If no bits are set, returns @size.
> + */
> +unsigned int find_next_clump8(unsigned long *const clump,
> +                             const unsigned long *const addr,
> +                             unsigned int offset, const unsigned int size)
> +{
> +       for (; offset < size; offset += 8) {
> +               *clump = bitmap_get_value8(addr, size, offset);
> +               if (!*clump)
> +                       continue;
> +
> +               return offset;
> +       }
> +
> +       return size;
> +}
> +EXPORT_SYMBOL(find_next_clump8);
> --
> 2.21.0
>


-- 
Best Regards
Masahiro Yamada
