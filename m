Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A896C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:42:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDED120851
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:42:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="mlVO6F81"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbfCHMmC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 07:42:02 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:40116 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbfCHMmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 07:42:02 -0500
Received: by mail-qk1-f194.google.com with SMTP id h28so11033948qkk.7
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 04:42:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=adR+E/OsmXqnABOXHM75x+oGV2p1CkxaPVcL89SSKxk=;
        b=mlVO6F81w/F/09bjDwhaDMn1EfbWifaSFgeXOqWYz2ouX0yLy/AzOdARDXZF+Tu5sB
         St06omjkkaGQzT9GNgARgJFqgH6Cm8aDigUHJ5WARK4U6M4qEPqB2qpASegSZtzfFEmc
         R8LSTlsdehB5Lp+SzadAiUCbkIYHOfEHiTnt/1gt1AH8a3NJVxhcsEjd88fx3PQADjUg
         JO7xnjhDm/DgIntu7fvZZtWL62zhx3aNQY34E8ZswqhZCN976vV74sh1AhRDGp8OLGBm
         GoqlxCLp0bLwRzsfqUz14f8t5qWH/opxD2BFKrYVvzko6+7gzu6jXTgEYfVNvQDb/l8u
         m7/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=adR+E/OsmXqnABOXHM75x+oGV2p1CkxaPVcL89SSKxk=;
        b=MMxoVaXmJRJR0z1fygZFpw/AvqJXwNUoFWN5xw8Mn1p2jAQavCKopFouHySUY4LhcZ
         qKY5JhiuoCRAIT8VfKesWHADOrAeRoIT7qTUtQeIgT0XjDYvL3Bjqm4Sp9n7AI0Ks8qJ
         DDfTWjDiMERsyKr/mh8kcCv+OMgsdw/QkVyDR5BZywtjwndHMkEXaTCetElnYjMeC2sK
         pR8gYiyGN/at3wgdJKJQ/51pgGEbXz2/6A+q/fLpmeWu5wgd90heaav/Bxp9wtYUIYNn
         Xok9STBZmeaifC9dsZhTSvpL43FHhWBL59d+xTfH7zk1ny32n3kzQzmrLjLzfAFxZW+M
         uN4g==
X-Gm-Message-State: APjAAAWFVGREieYq84uUeFj3wOJELRqfFyYfir1rm4rt6xiXw7EfadiL
        2p6u7ntepy+g4oBkk3NjWVoCRg==
X-Google-Smtp-Source: APXvYqzUkMBEatP5qSiaOE3357a7VCo2Pgk5WKbx0F2/RNAXHsIusftrxsMN/Y+SQMO8jAHqwGJRvQ==
X-Received: by 2002:ae9:c008:: with SMTP id u8mr621240qkk.286.1552048920742;
        Fri, 08 Mar 2019 04:42:00 -0800 (PST)
Received: from ziepe.ca ([24.137.65.181])
        by smtp.gmail.com with ESMTPSA id l16sm3893714qke.20.2019.03.08.04.41.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Mar 2019 04:41:59 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1h2Ep4-0006Kj-6d; Fri, 08 Mar 2019 08:41:58 -0400
Date:   Fri, 8 Mar 2019 08:41:58 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Kees Cook <keescook@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Leon Romanovsky <leonro@mellanox.com>
Subject: Re: [PATCH] Avoid that check_shl_overflow() triggers a compiler
 warning when building with W=1
Message-ID: <20190308124158.GD9321@ziepe.ca>
References: <20190307010153.81157-1-bvanassche@acm.org>
 <20190307012417.GU1758@mellanox.com>
 <8a5bd9ae-ebfe-687c-2868-d0f2a610d1e0@acm.org>
 <2c122567-d14b-7867-9230-67f570c13d15@rasmusvillemoes.dk>
 <1552003703.45180.17.camel@acm.org>
 <2d60debb-2b64-1b1f-7e16-d20720c93e28@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d60debb-2b64-1b1f-7e16-d20720c93e28@rasmusvillemoes.dk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 08, 2019 at 08:58:21AM +0100, Rasmus Villemoes wrote:
> On 08/03/2019 01.08, Bart Van Assche wrote:
> > On Thu, 2019-03-07 at 08:18 +0100, Rasmus Villemoes wrote:
> >> On 07/03/2019 03.14, Bart Van Assche wrote:
> >>> On 3/6/19 5:24 PM, Jason Gunthorpe wrote:
> >>>>>
> >>>>> diff --git a/include/linux/overflow.h b/include/linux/overflow.h
> >>>>> index 40b48e2133cb..8afe0c0ada6f 100644
> >>>>> +++ b/include/linux/overflow.h
> >>>>> @@ -202,6 +202,24 @@
> >>>>>     #endif /* COMPILER_HAS_GENERIC_BUILTIN_OVERFLOW */
> >>>>>   +/*
> >>>>> + * Evaluate a >= 0 without triggering a compiler warning if the type
> >>>>> of a
> >>>>> + * is an unsigned type.
> >>>>> + */
> >>>>> +#define is_positive(a) ({                    \
> >>
> >> is_non_negative, please! positive means > 0. And perhaps it's better to
> >> move these utility macros closer to the top of the file, together with
> >> the other type/range helpers.
> > 
> > Hi Rasmus,
> > 
> > Thank you for the feedback. But according to what I found online opinions
> > about whether or not zero is a positive number seem to vary. From
> > https://en.wikipedia.org/wiki/Sign_(mathematics):
> 
> Yes, I'm a mathematician, I'm aware of that. You can also find people
> who use "less than" in the "<=" sense, and then say "strictly less than"
> when they mean "<".
> 
> > Terminology for signs
> > 
> > When 0 is said to be neither positive nor negative, the following phrases
> > may be used to refer to the sign of a number:
> > * A number is positive if it is greater than zero.
> > * A number is negative if it is less than zero.
> > * A number is non-negative if it is greater than or equal to zero.
> > * A number is non-positive if it is less than or equal to zero.
> > 
> > When 0 is said to be both positive and negative, modified phrases are used
> > to refer to the sign of a number:
> > * A number is strictly positive if it is greater than zero.
> > * A number is strictly negative if it is less than zero.
> > * A number is positive if it is greater than or equal to zero.
> > * A number is negative if it is less than or equal to zero.
> 
> Right, but in no way does it ever make sense to mix these conventions.
> So the options for describing ">= 0, < 0" are "non_negative, negative"
> or "positive, strictly_negative".
> 
> In the context of the C language, the first convention is used. While
> not explicitly stated, it can be inferred from usage of the terms.
> First, the word nonnegative is used (e.g. in defining argc). Second, "If
> the value of the right operand [in a shift expression] is negative [...]
> the behaviour is undefined.", so certainly negative cannot include 0.
> Third, E* constants are required to be positive, and "[errno] is never
> set to zero by any library function". Etc. etc.

Lets use is_unsigned() or is_unsigned_value() then for the name of the
test, that is pretty unambiguous and alot nicer to read than
is_not_negative()

FWIW, in computer science I generally see the terms used as:

  negatve: < 0
  positive: >= 0
  natural: > 0

This language naturally follows the twos complement construction where
it is very logical to say a number with the sign bit set is 'negative'
and a number with it clear is 'positive', which means 0 is positive.

Which is probably enraging to mathematicians.. But has a certain
logic.

.. and most CS places don't actually care about the difference
between > 0 and >= 0 , while < 0 is usually highly interesting.

Jason
