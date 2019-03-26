Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C2BC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 03:13:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF73E20828
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 03:13:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TrjA+eap"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730660AbfCZDNY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 23:13:24 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41306 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727157AbfCZDNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 23:13:23 -0400
Received: by mail-pl1-f193.google.com with SMTP id y5so925866plk.8;
        Mon, 25 Mar 2019 20:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MinFei9y55S8BB3lIJN4Zd2NC15gAsU5rmUgcJ/yuXI=;
        b=TrjA+eapEbjBMS8P7sEKmLpBp0YEw+GcQcONqsGvTaqETKh+x+NLKocqs9zPHNR13F
         m+BYYqLlu1cf4zDi4dz3L8CxrMGJ+OvKBdP/pcRa7aZgbh/JBWKr7J772+2Z8LWhXQd2
         VsNJIDMK1iVKhT8Bd5HQ0xiI+h80584mliCEwN+dUlG1IW6xVaFK5+a25wmj+QfMT04F
         koJVn4ovW5BxgaNP9v3aZlES5gpEBnkpQoJRVhqsRhBbLszkve9is/TYdolnPABlMhAy
         oZYB/PEIcI9syoGbEhKQ3LVdAZ4LkC+B8G7KU8LUxRHUK4gStnKBjDeY1bm4PSMBzV7v
         PWXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MinFei9y55S8BB3lIJN4Zd2NC15gAsU5rmUgcJ/yuXI=;
        b=SfNAcuna+gHRyKWAxq602iDr0QY4SLTfzcUdhj+rZnp/OJg4+9zdErZCqfXcNOrNIk
         KbyrmBSaz3BrhV4jwlEqIfJQhSMaKLfqr6Ul2jlJSt+z8C82mOr+WoSvCY6l4Cva6MbN
         Wq/HCuO86lbKmRG67XQ7bod/GJ825s3nK8CmIUmyLt7dgEAcDVZ/UZ5PmgP/HT4R+ya9
         Qap8NXrM8cE2UheIMXyqzxqMC75Gg2V2NBEA7K5cJ1wBoAsv28+blKCngZeoT7oJtAwL
         j7O7EodjNsuSrqVYfeXtIPLvuQzw7Lm6xoj5Xnk4aOmOlxMwK+QZQN1YiDy1ANTqdg7R
         u96A==
X-Gm-Message-State: APjAAAXmqbYmLQXwMzQuDeCpGIaMQWKJQK1/7oJECDe3Q8rY+WOSjVmp
        zGpwTFUnzZVMOKpq8l39C0M=
X-Google-Smtp-Source: APXvYqwSFiRdDaTC0unzOdl6OozUx1Di7vdpvlhIFLAoPI/PoJwnq/bdkwslNzOq2Jz4dD1X0QaKqA==
X-Received: by 2002:a17:902:9a98:: with SMTP id w24mr28467310plp.247.1553570002759;
        Mon, 25 Mar 2019 20:13:22 -0700 (PDT)
Received: from icarus ([2001:268:c0a3:6e7a:c70:4af9:86e2:2])
        by smtp.gmail.com with ESMTPSA id b133sm23029909pfb.62.2019.03.25.20.13.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Mar 2019 20:13:22 -0700 (PDT)
Date:   Tue, 26 Mar 2019 12:14:22 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        akpm@linux-foundation.org, linux-gpio@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        yamada.masahiro@socionext.com,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        geert@linux-m68k.org, preid@electromag.com.au,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v12 01/11] bitops: Introduce the for_each_set_clump8 macro
Message-ID: <20190326031422.GB3356@icarus>
References: <cover.1553494625.git.vilhelm.gray@gmail.com>
 <9afc30a574ce3e6a86b51dd522146a1d2156dedd.1553494625.git.vilhelm.gray@gmail.com>
 <20190325093854.jzkkwaksxi7zvtrg@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190325093854.jzkkwaksxi7zvtrg@wunner.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 10:38:54AM +0100, Lukas Wunner wrote:
> On Mon, Mar 25, 2019 at 03:22:23PM +0900, William Breathitt Gray wrote:
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
> 
> Just use find_first_bit() / find_next_bit() to use optimized arch-specific
> bitops instead of open-coding the iteration over the bitmap.
> 
> See max3191x_get_multiple() for an example.
> 
> Thanks,
> 
> Lukas

Is this the sort of implementation you had in mind:

        offset = find_next_bit(addr, size, offset);
        if (offset == size)
                return size;

        offset -= offset % 8;
        *clump = bitmap_get_value8(addr, size, offset);

        return offset;

Yes, this does seem more efficient to leverage the existing
find_next_bit function.

Should the offset and size parameters be redefined as unsigned long to
match the find_first_bit/find_next_bit function parameters?

William Breathitt Gray
