Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11304C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 10:07:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDF042075D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 10:07:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IzxlXlve"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730804AbfCZKHf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 06:07:35 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:54923 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbfCZKHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 06:07:35 -0400
Received: by mail-it1-f196.google.com with SMTP id w18so18576921itj.4;
        Tue, 26 Mar 2019 03:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=K7hooZ3G6onOEeayZK4JiqpFMx2K/uTaEbwPOFqkQEY=;
        b=IzxlXlvejcGQZU1t79O5kLco59xuNTtjx3mVzWH/wUO2vrulEZUcCFIADrYhLIrJ1c
         xv8tgA50pwHfvG4ECP1DqRqHSUWHNE46zKs10GcdgLHa0e6snyHmpSE9LarNcLVISWJT
         IEJroBxgUPUwQu419fGneQKidMLFyy1dXwYEVBsAR/lqjPbcW/hSqmKuWUid1i2Rx5Dd
         6Sn4J4nBEc/SDy2iSt6LPWzdbnzSdwd26t8U29y1xvP4lmNiq7oTdLe7fV9YnB75OSnU
         pbsRpfAlCZ92x57iJUZFH19uOSmpCWYGV5HyazmarrtjfyM7V6QOZZcPZDDrnksUhg70
         GykA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=K7hooZ3G6onOEeayZK4JiqpFMx2K/uTaEbwPOFqkQEY=;
        b=qz3w2gQpDPHHf7NCpOwqRgtfA8MKVVUr7sghBG0WJV+rFMlSmKpbMt5andhLb773XE
         9bh11n9bMb8sUwT3nayiRjqoktq/wwqNFSkJygNBkhkIFPSE5dMzmza+kd7m4a1uQJR+
         3srp3hxNEKKj3ypMdBVrNqTc2ObicsdJem4kv/f0NjMsxCejdrvT45llhw8awJk7kwp4
         hYJgfHHv0A2IbW625hYYYqeFH1FZKE+NQXiGOMBp2G6NBg5Xd0INO8bPlk31HOjjETTT
         JSPGFLGXFO7faqzv/7MQDO73XOJkdZeDcKntk4L7c1D39ktIipK2eIbq6r6IhY5rJg+B
         G33g==
X-Gm-Message-State: APjAAAV8BzghOJNK7ws0VD0/5klSwk987iI10z9B/sJ9yPgLDEkjNP2I
        NTMbt0oxlujpcwei345DcxY=
X-Google-Smtp-Source: APXvYqxSpQ84IA7VmN5bmVRjcpdBlLstMDdFL8tkFu7b4VG0fj2FhjRwbrBlPj5VvA1EiVEggfnoiw==
X-Received: by 2002:a24:a50c:: with SMTP id k12mr15764383itf.6.1553594853706;
        Tue, 26 Mar 2019 03:07:33 -0700 (PDT)
Received: from icarus ([2001:268:c0a3:6e7a:c70:4af9:86e2:2])
        by smtp.gmail.com with ESMTPSA id 76sm7163127itk.40.2019.03.26.03.07.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Mar 2019 03:07:33 -0700 (PDT)
Date:   Tue, 26 Mar 2019 19:08:18 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Lukas Wunner <lukas@wunner.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        akpm@linux-foundation.org, linux-gpio@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        yamada.masahiro@socionext.com,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        geert@linux-m68k.org, preid@electromag.com.au,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v12 01/11] bitops: Introduce the for_each_set_clump8 macro
Message-ID: <20190326100743.GA10005@icarus>
References: <cover.1553494625.git.vilhelm.gray@gmail.com>
 <9afc30a574ce3e6a86b51dd522146a1d2156dedd.1553494625.git.vilhelm.gray@gmail.com>
 <20190325093854.jzkkwaksxi7zvtrg@wunner.de>
 <20190326031422.GB3356@icarus>
 <20190326094345.v7l7xjvfs2scbvbv@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190326094345.v7l7xjvfs2scbvbv@wunner.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 10:43:45AM +0100, Lukas Wunner wrote:
> On Tue, Mar 26, 2019 at 12:14:22PM +0900, William Breathitt Gray wrote:
> > On Mon, Mar 25, 2019 at 10:38:54AM +0100, Lukas Wunner wrote:
> > > On Mon, Mar 25, 2019 at 03:22:23PM +0900, William Breathitt Gray wrote:
> > > > +/**
> > > > + * find_next_clump8 - find next 8-bit clump with set bits in a memory region
> > > > + * @clump: location to store copy of found clump
> > > > + * @addr: address to base the search on
> > > > + * @offset: bit offset at which to start searching
> > > > + * @size: bitmap size in number of bits
> > > > + *
> > > > + * Returns the bit offset for the next set clump; the found clump value is
> > > > + * copied to the location pointed by @clump. If no bits are set, returns @size.
> > > > + */
> > > > +unsigned int find_next_clump8(unsigned long *const clump,
> > > > +			      const unsigned long *const addr,
> > > > +			      unsigned int offset, const unsigned int size)
> > > > +{
> > > > +	for (; offset < size; offset += 8) {
> > > > +		*clump = bitmap_get_value8(addr, size, offset);
> > > > +		if (!*clump)
> > > > +			continue;
> > > > +
> > > > +		return offset;
> > > > +	}
> > > > +
> > > > +	return size;
> > > > +}
> > > > +EXPORT_SYMBOL(find_next_clump8);
> > > 
> > > Just use find_first_bit() / find_next_bit() to use optimized arch-specific
> > > bitops instead of open-coding the iteration over the bitmap.
> > > 
> > > See max3191x_get_multiple() for an example.
> > 
> > Is this the sort of implementation you had in mind:
> > 
> >         offset = find_next_bit(addr, size, offset);
> >         if (offset == size)
> >                 return size;
> > 
> >         offset -= offset % 8;
> >         *clump = bitmap_get_value8(addr, size, offset);
> > 
> >         return offset;
> 
> Almost.  I'd use round_down() instead of "offset -= offset % 8".
> Then it's just a single cheap logical and operation at runtime.

All right I'll try this setup using round_down() then.

> 
> I'd try to avoid copying around the clump value and use a pointer
> to u8 instead.

Although in this case we are handling 8-bit clumps, I anticipate device
drivers in the future which may benefit from larger size clumps (e.g.
GPIO devices with 24-bit ports). It'll be better to define clumps
similar to how we're defining bitmaps now (unsigned long *) so that we
can support these sizes if need be in the future without requiring data
type changes.

> 
> I don't understand the calculations in bitmap_get_value8() at all.
> Why is it so complicated, does it allow passing in a start value
> that's not a multiple of 8?  Do you really need that?  I imagine
> a simplification is possible if that assumption can be made (and
> is spelled out in the kerneldoc).

That's a good point. Originally, I had envisioned the possibility of
calling bitmap_get_value8/bitmap_set_value8 at odd start offsets; this
would open up the possibility of a clump landing as a split between 2
words, thus requiring this complicated case handling code. However, I'm
not sure how often users would need this case; none of the drivers right
now require clumps at odd offsets.

Andy, would you have any objection to restricting the start offset
values for bitmap_get_value8/bitmap_set_value8 to multiples of 8? That
would prevent the split word case, and thus allow the implementation for
those functions to be a lot simpler.

William Breathitt Gray

> 
> 
> > Should the offset and size parameters be redefined as unsigned long to
> > match the find_first_bit/find_next_bit function parameters?
> 
> Yes, probably.  It's just the CPU's native length anyway.
> 
> Thanks,
> 
> Lukas
