Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C646C43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 00:37:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AE2321734
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 00:37:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="glcKlG96"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbfEAAh4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 20:37:56 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41574 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbfEAAhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 20:37:55 -0400
Received: by mail-pg1-f196.google.com with SMTP id f6so7621453pgs.8
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2019 17:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=J81kdwj15h6coZaW3g3NQdpDoj3Y1AWOmdo80wMXa9s=;
        b=glcKlG961+/ilb95AlC+YEi91LqfxuEWEr74KI13HJSiDByIQKawmi5H0EgG+/9SfN
         isLQjZSJCZJgpEa7h6mQvF59aMdQpm65EtnKOr+kTam0sm7s/iWxmv4nZdnfnGpB2ZKm
         CqUChQNKNcXrclR2VX6xqpCkCxd78vQwtnW/t3SDk1VKeC7TkinGLcaDUcUZxquk7qjq
         kNamKuM5yEqS1tpaOX8IZ0qjljtyjr0DboAsoLLN2+79zUHAJsMvOcDK70hmveby7u0X
         NlmTTEg0KBLQ9I0a7Wwl/ux1i69sLDFXXxHTH+r/jXAwpbcg6fvcTINn+ny92eHlnTbT
         RGjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=J81kdwj15h6coZaW3g3NQdpDoj3Y1AWOmdo80wMXa9s=;
        b=o64VXM6P4n6tOzy0mNuRthHjQvnm+ftqnZxcFy/wMJKEyztnlaHVT/SRXCMocZmJxI
         dY6zDHK2G4XdGkoNOthjV4mJSozAjjqlrkgZHCs+7P068mVgn2T9bLriqpBwBRRJFl7D
         F+jQAMgQ472RfZB8x+qI3iIuVFMytBW0vFD79rMajSPbLhEXYXFnqVh34B0PXDeSKesf
         dcYDwyZycebCJeEzoNXm+hwc2pA5CKhyDFcsM3Q6/TW28hrAZX1+nNc8XHUo0/HyeMe5
         F15jgFBPY9+glJHiLnPYgSyqwoQpwpd0CZzkSsmc/oBASvmp9G8oAf8bdKuqA1Ku9YwL
         XmzA==
X-Gm-Message-State: APjAAAUSnX6cbceExZfbiVbyuh5QOyfvvC4lRtmmOoiUd6DMtOYZYh2E
        TgQaV5ZfohgTxsjY34NwHO8=
X-Google-Smtp-Source: APXvYqzzP0eB/Jm18FimfPiERciV/7+uGdLuzXPnwpkf95OhHHM/62t3PvyFaVN2/Ey/7zsIP8acEg==
X-Received: by 2002:a63:dd02:: with SMTP id t2mr54641407pgg.434.1556671074449;
        Tue, 30 Apr 2019 17:37:54 -0700 (PDT)
Received: from localhost ([2601:640:7:332f:bc53:6e04:b584:e900])
        by smtp.gmail.com with ESMTPSA id n65sm62795520pga.92.2019.04.30.17.37.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Apr 2019 17:37:53 -0700 (PDT)
Date:   Tue, 30 Apr 2019 17:37:50 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Amritha Nambiar <amritha.nambiar@intel.com>,
        Willem de Bruijn <willemb@google.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Tobin C . Harding" <tobin@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Vineet Gupta <vineet.gupta1@synopsys.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Yury Norov <ynorov@marvell.com>, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Steffen Klassert <steffen.klassert@secunet.com>
Subject: Re: [PATCH 4/6] lib: rework bitmap_parse()
Message-ID: <20190501003750.GA28987@yury-thinkpad>
References: <20190428032936.1317-1-ynorov@marvell.com>
 <20190428032936.1317-5-ynorov@marvell.com>
 <20190428165745.GX9224@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190428165745.GX9224@smile.fi.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 28, 2019 at 07:57:45PM +0300, Andy Shevchenko wrote:
> On Sat, Apr 27, 2019 at 08:29:34PM -0700, Yury Norov wrote:
> > bitmap_parse() is ineffective and full of opaque variables and opencoded
> > parts. It leads to hard understanding of it. This rework includes:
> >  - remove bitmap_shift_left() call from the cycle. Now it makes the
> >    complexity of the algorithm as O(nbits^2). In the suggested approach
> >    the input string is parsed in reverse direction, so no shifts needed;
> >  - relax requirement on a single comma and no white spaces between chunks.
> >    It is considered useful in scripting, and it aligns with
> >    bitmap_parselist();
> >  - split bitmap_parse() to small readable helpers;
> >  - make an explicit calculation of the end of input line at the
> >    beginning, so users of the bitmap_parse() won't bother doing this.
> 
> > +static inline bool in_str(const char *start, const char *ptr)
> > +{
> > +	return start <= ptr;
> > +}
> > +
> 
> I don't see how it's better than explicit use. Moreover, explicit use shows the
> exact condition in-line. Even by used characters it's longer.

I did 2 mistakes with a condition ('<' instead of '<=') during the
development, after that I decided to introduce it. I would prefer
keep it.
 
> > +static const char *bitmap_get_hex32_rev(const char *start,
> > +					const char *end, u32 *num)
> 
> In kernel few functions to work with hex u32 named foo_x32(). I would rather
> use that. Besides, we spell "reverse" in full.

OK

> > +{
> > +	u32 ret = 0;
> > +	int c, i;
> > +
> > +	if (hex_to_bin(*end) < 0)
> > +		return ERR_PTR(-EINVAL);
> > +
> > +	for (i = 0; i < 32; i += 4) {
> > +		c = hex_to_bin(*end--);
> > +		if (c < 0)
> 
> Perhaps we may need similar patch for hex_to_bin() as in the commit
> 9888a588ea96 ("lib/hexdump.c: return -EINVAL in case of error in hex2bin()")
> 
> > +			return ERR_PTR(-EINVAL);
> 
> > +
> > +		ret |= c << i;
> > +
> > +		if (!in_str(start, end) || __end_of_region(*end))
> > +			goto out;
> > +	}
> > +
> > +	if (hex_to_bin(*end) >= 0)
> > +		return ERR_PTR(-EOVERFLOW);
> > +out:
> > +	*num = ret;
> > +	return end;
> > +}
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
