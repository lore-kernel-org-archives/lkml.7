Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4505C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 02:54:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EB7A2080F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 02:54:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mQlLUY4R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730575AbfCZCyW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 22:54:22 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44124 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727157AbfCZCyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 22:54:21 -0400
Received: by mail-pf1-f195.google.com with SMTP id y13so1253433pfm.11;
        Mon, 25 Mar 2019 19:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RLypSkbhBWAt3+Nm7TC/H/whEzVkmT5o4pN19mwvgXA=;
        b=mQlLUY4Rgc911g+TivWsd+MfoZ45GJyVyb905UvFKuuLhOjAHtjNEj2Lhmft9c9znF
         5tCY7zeccVFH22hOnKwguCELVDzm7WgN1oIFAEmcsZTTOTYW+IJIe2UeDB6psF62QIlf
         K5NyNaOyQiFeKBU03SMIHNWrpTgMvkK5BmObr9R2kiHj64Ks/hQN1wneczOlV6oA9P2B
         tGkFbQ9kC5zsCVsxohv0PgRH6g0NU1ZSC+N0xv9W5FC47UEgGCnXWTtvIzIchsby364e
         ZVg/j8s0AXtFf87b+I9V6PRuxZ9e25N5u2FVbMyR7c3j/JdMon45Pqd6vO9+K65RrX8r
         HcxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RLypSkbhBWAt3+Nm7TC/H/whEzVkmT5o4pN19mwvgXA=;
        b=mroCxmb7tBnOr/vOKKTtCOST6gzR2VENr2/Ou3ktFu6ZEhFSrYioMFcGt4RVLDc0ln
         wOQ3cEYyag4d4A+mTHcPvpz07tpuVzRSYZFElEAgUn/wj+8xnoEv/XhKPASHmlsZiTFK
         GgQYGN6dR2q0h4aqTLFjdXEl7A0irhqxZUmOA3aKSZw+8PhhIje+pdU4+tj1k8Z8vya6
         Nx3ODcY2mbtG1lxYDBGP8ZSWEPeXecfTWnPrqYp+yDP/x2KFeEpvAM4Ut+Bx2h50r8oW
         yETEcTe/3Pi5ztVkv1jGOlMhtS79fxNkgcPRu/egCi6APL3mzs1zlXjq3fsxwIYe8din
         h4cA==
X-Gm-Message-State: APjAAAVkS/IoI55vT5Pa9DCuTwRebnqvLmEGFJwvFfHETbAQrehDvzH1
        KU0FbeQF7kNMqk4MncrIwPk=
X-Google-Smtp-Source: APXvYqyQZc2Ywz5HDZY60qsLINP1QG5OXUffRj/72WByQSKRasrvqfTyWjix3sGMnz48y3xujky9Vw==
X-Received: by 2002:a65:51c3:: with SMTP id i3mr26202105pgq.45.1553568860845;
        Mon, 25 Mar 2019 19:54:20 -0700 (PDT)
Received: from icarus ([2001:268:c0a3:6e7a:c70:4af9:86e2:2])
        by smtp.gmail.com with ESMTPSA id c13sm27220861pfm.34.2019.03.25.19.54.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Mar 2019 19:54:19 -0700 (PDT)
Date:   Tue, 26 Mar 2019 11:54:59 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        akpm@linux-foundation.org, linux-gpio@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@rasmusvillemoes.dk, yamada.masahiro@socionext.com,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        geert@linux-m68k.org, preid@electromag.com.au,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v12 01/11] bitops: Introduce the for_each_set_clump8 macro
Message-ID: <20190326025459.GA3356@icarus>
References: <cover.1553494625.git.vilhelm.gray@gmail.com>
 <9afc30a574ce3e6a86b51dd522146a1d2156dedd.1553494625.git.vilhelm.gray@gmail.com>
 <20190325131236.GW9224@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190325131236.GW9224@smile.fi.intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 03:12:36PM +0200, Andy Shevchenko wrote:
> On Mon, Mar 25, 2019 at 03:22:23PM +0900, William Breathitt Gray wrote:
> > This macro iterates for each 8-bit group of bits (clump) with set bits,
> > within a bitmap memory region. For each iteration, "start" is set to the
> > bit offset of the found clump, while the respective clump value is
> > stored to the location pointed by "clump". Additionally, the
> > bitmap_get_value8 and bitmap_set_value8 functions are introduced to
> > respectively get and set an 8-bit value in a bitmap memory region.
> 
> 
> This seems to miss Randy's (IIRC) comment about too many const specifiers.

I disagree with removing the const qualifiers; I believe they are useful
and do not significantly impact the clarity of the code (in fact, I'd
argue the opposite). The const qualifiers make it clear these values are
constant, allowing readers at a glace to know these values never change
within this function. Although I believe GCC is smart enough in this
case to deduce implicitly that these are constant values, generally
speaking const qualifiers do make it easier for compilers to optimize
sections of code (OoO execution, algorithm simplification, etc.), so I
believe it's useful in a technical sense as well.

I added the const qualifier to these variables because they really are
constant, and I believe there is merit in making it explicit in the
code. If the primary reason for removing the const qualifiers is for
aesthetics, then I must dissent with that decision.

However, it is difficult to read the definitions that wrap around to a
second line. These definitions are long enough that even removing the
const qualifiers would not help prevent the wrapping, so perhaps it
would make to let these stay on a single line. Do you think it would
help to ignore the 80-character maximum line width coding style rule for
these cases here?

William Breathitt Gray

> 
> > Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > Suggested-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Acked-by: Andrew Morton <akpm@linux-foundation.org>
> > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> > Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> > ---
> >  include/asm-generic/bitops/find.h | 14 ++++++
> >  include/linux/bitops.h            |  5 ++
> >  lib/find_bit.c                    | 81 +++++++++++++++++++++++++++++++
> >  3 files changed, 100 insertions(+)
> > 
> > diff --git a/include/asm-generic/bitops/find.h b/include/asm-generic/bitops/find.h
> > index 8a1ee10014de..9a76adff59c6 100644
> > --- a/include/asm-generic/bitops/find.h
> > +++ b/include/asm-generic/bitops/find.h
> > @@ -80,4 +80,18 @@ extern unsigned long find_first_zero_bit(const unsigned long *addr,
> >  
> >  #endif /* CONFIG_GENERIC_FIND_FIRST_BIT */
> >  
> > +unsigned long bitmap_get_value8(const unsigned long *const bitmap,
> > +				const unsigned int size,
> > +				const unsigned int start);
> > +
> > +void bitmap_set_value8(unsigned long *const bitmap, const unsigned int size,
> > +		       const unsigned long value, const unsigned int start);
> > +
> > +unsigned int find_next_clump8(unsigned long *const clump,
> > +			      const unsigned long *const addr,
> > +			      unsigned int offset, const unsigned int size);
> > +
> > +#define find_first_clump8(clump, bits, size) \
> > +	find_next_clump8((clump), (bits), 0, (size))
> > +
> >  #endif /*_ASM_GENERIC_BITOPS_FIND_H_ */
> > diff --git a/include/linux/bitops.h b/include/linux/bitops.h
> > index 602af23b98c7..f19a7bc8f559 100644
> > --- a/include/linux/bitops.h
> > +++ b/include/linux/bitops.h
> > @@ -40,6 +40,11 @@ extern unsigned long __sw_hweight64(__u64 w);
> >  	     (bit) < (size);					\
> >  	     (bit) = find_next_zero_bit((addr), (size), (bit) + 1))
> >  
> > +#define for_each_set_clump8(start, clump, bits, size) \
> > +	for ((start) = find_first_clump8(&(clump), (bits), (size)); \
> > +	     (start) < (size); \
> > +	     (start) = find_next_clump8(&(clump), (bits), (start) + 8, (size)))
> > +
> >  static inline int get_bitmask_order(unsigned int count)
> >  {
> >  	int order;
> > diff --git a/lib/find_bit.c b/lib/find_bit.c
> > index ee3df93ba69a..1b6f8a6f1957 100644
> > --- a/lib/find_bit.c
> > +++ b/lib/find_bit.c
> > @@ -218,3 +218,84 @@ EXPORT_SYMBOL(find_next_bit_le);
> >  #endif
> >  
> >  #endif /* __BIG_ENDIAN */
> > +
> > +/**
> > + * bitmap_get_value8 - get an 8-bit value within a memory region
> > + * @bitmap: address to the bitmap memory region
> > + * @size: bitmap size in number of bits
> > + * @start: bit offset of the 8-bit value
> > + *
> > + * Returns the 8-bit value located at the @start bit offset within the @bitmap
> > + * memory region.
> > + */
> > +unsigned long bitmap_get_value8(const unsigned long *const bitmap,
> > +				const unsigned int size,
> > +				const unsigned int start)
> > +{
> > +	const size_t index = BIT_WORD(start);
> > +	const unsigned int offset = start % BITS_PER_LONG;
> > +	const unsigned int low_width = (offset + 8 > BITS_PER_LONG) ?
> > +				       BITS_PER_LONG - offset : 8;
> > +	const unsigned long low = bitmap[index] >> offset;
> > +	const unsigned long high = (low_width < 8 && start + 8 <= size) ?
> > +				   bitmap[index + 1] << low_width : 0;
> > +
> > +	return (low | high) & 0xFF;
> > +}
> > +EXPORT_SYMBOL(bitmap_get_value8);
> > +
> > +/**
> > + * bitmap_set_value8 - set an 8-bit value within a memory region
> > + * @bitmap: address to the bitmap memory region
> > + * @size: bitmap size in number of bits
> > + * @value: the 8-bit value; values wider than 8 bits may clobber bitmap
> > + * @start: bit offset of the 8-bit value
> > + */
> > +void bitmap_set_value8(unsigned long *const bitmap, const unsigned int size,
> > +		       const unsigned long value, const unsigned int start)
> > +{
> > +	const size_t index = BIT_WORD(start);
> > +	const unsigned int offset = start % BITS_PER_LONG;
> > +	const unsigned int low_width = (offset + 8 > BITS_PER_LONG) ?
> > +				       BITS_PER_LONG - offset : 8;
> > +	const unsigned long low_mask = GENMASK(low_width - 1, 0) << offset;
> > +	const unsigned int high_width = 8 - low_width;
> > +	const unsigned long high_mask = GENMASK(high_width - 1, 0);
> > +
> > +	/* set lower portion */
> > +	bitmap[index] &= ~low_mask;
> > +	bitmap[index] |= value << offset;
> > +
> > +	/* set higher portion if space available in bitmap */
> > +	if (high_width && start + 8 <= size) {
> > +		bitmap[index + 1] &= ~high_mask;
> > +		bitmap[index + 1] |= value >> low_width;
> > +	}
> > +}
> > +EXPORT_SYMBOL(bitmap_set_value8);
> > +
> > +/**
> > + * find_next_clump8 - find next 8-bit clump with set bits in a memory region
> > + * @clump: location to store copy of found clump
> > + * @addr: address to base the search on
> > + * @offset: bit offset at which to start searching
> > + * @size: bitmap size in number of bits
> > + *
> > + * Returns the bit offset for the next set clump; the found clump value is
> > + * copied to the location pointed by @clump. If no bits are set, returns @size.
> > + */
> > +unsigned int find_next_clump8(unsigned long *const clump,
> > +			      const unsigned long *const addr,
> > +			      unsigned int offset, const unsigned int size)
> > +{
> > +	for (; offset < size; offset += 8) {
> > +		*clump = bitmap_get_value8(addr, size, offset);
> > +		if (!*clump)
> > +			continue;
> > +
> > +		return offset;
> > +	}
> > +
> > +	return size;
> > +}
> > +EXPORT_SYMBOL(find_next_clump8);
> > -- 
> > 2.21.0
> > 
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
