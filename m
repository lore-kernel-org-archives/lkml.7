Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34A42C468C1
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 09:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F36F02082E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 09:37:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Ngq5TC24"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389054AbfFJJhW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 05:37:22 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44115 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388511AbfFJJhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 05:37:22 -0400
Received: by mail-wr1-f65.google.com with SMTP id b17so8411297wrq.11
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 02:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=YmUQOBR/GJq7UaPzUNV4Rf8Mf+3yYG+dn3tRrCjRgF0=;
        b=Ngq5TC241NWWOhW2wlmQgnfzQHe0pGNYYuPzePTgUZGjgqvK5wXoeSeRykP/JazfaD
         8pH5UBa+KTIJYQ8tqZzStHpWFhGnc+wfqZENECv3w62t2RQf95+LJl2qwxTXS76w4l0I
         JCZWrB7S001YzldoGJy2f7gqPhrdcJzIA1jelI0zp1Oq++2kF4LKd6MTyFrKwDIMJmmb
         RhOJDOU/pUKounO3J7i9QKYSLzzeBUlPCZWbM1C/ImUSykTs56CTg8tvGe6bcB1iG7UA
         x9YxV9KGhaWiRZ8DZSMZ2drVegOnHZWyIp6WsvicK/ECb08DbSwlzbL4N2IAHuX5QGdq
         C7hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=YmUQOBR/GJq7UaPzUNV4Rf8Mf+3yYG+dn3tRrCjRgF0=;
        b=lm92jhLrmmpl8pEh1zhEy/shdr8J3LsFaO4I9ad0VMm4ynMrjq+gNgSRltul0Oolbd
         X1/NDW6kDLyb8hIRCdG9HfI5+CQ2AcBFVV+Qnhst6Pg9vqMbMWXhDIxITus4WoEnbNrH
         /U+3p1KkI6PJpOQemVRkJn/SiIYjfkUHHs+nfCgaHAtObYrr2/CSu30/eaOoMidNR0dh
         3RqqatKXYRVgS2fKpUhlAHGl30+Nd0M7PAkaFVWJdnIJP67R18mgJg5Q2w5y8oqVZrU9
         bAp9CSmRfTqIkSMEJpc9kt5yRhZAdYA7IZSmjA80H/EjTLBVW9iaWXvHof1Ga15W5nqf
         QhgA==
X-Gm-Message-State: APjAAAWhqkR3fHUV3WgflI4s4ly5EBpQ3IPTaBWLZg9aieHitBVAe7wO
        86X+dViUe1FRXvbaaH/M7+o51g==
X-Google-Smtp-Source: APXvYqxkgrvxz7l9kXQsr8B6DVhFVzZ7aagx1lJLoxS4N3XnngCqcHBVUgnOJxELFpFwwO0m7VwIjg==
X-Received: by 2002:a5d:498a:: with SMTP id r10mr44569262wrq.28.1560159439366;
        Mon, 10 Jun 2019 02:37:19 -0700 (PDT)
Received: from boomer.baylibre.com ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.gmail.com with ESMTPSA id a125sm10149177wmf.42.2019.06.10.02.37.17
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 10 Jun 2019 02:37:18 -0700 (PDT)
Message-ID: <6394b7e46a7967f4a5a6f77215e670e3e7a7ef10.camel@baylibre.com>
Subject: Re: [PATCH] clk: fix clock global name usage.
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        Alexandre Mergnat <amergnat@baylibre.com>,
        mturquette@baylibre.com
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        baylibre-upstreaming@groups.io
Date:   Mon, 10 Jun 2019 11:37:16 +0200
In-Reply-To: <20190606225438.F175A2089E@mail.kernel.org>
References: <20190524072745.27398-1-amergnat@baylibre.com>
         <20190524143355.5586D2133D@mail.kernel.org>
         <c89ecb6f328014ce22ae5d6c634e5337dbbf3ea2.camel@baylibre.com>
         <20190524174454.8043420879@mail.kernel.org>
         <5795a73002f2c787b545308585f0437eb5aa2f72.camel@baylibre.com>
         <20190606225438.F175A2089E@mail.kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-06-06 at 15:54 -0700, Stephen Boyd wrote:
> > > > Do you think we could come up with a priority order which makes the first
> > > > example work ?
> > > 
> > > Maybe? I'm open to suggestions.
> > > 
> > > > Something like:
> > > > 
> > > > if (hw) {
> > > >          /* use pointer */
> > > > } else if (name) {
> > > >          /* use legacy global names */
> > > 
> > > I don't imagine we can get rid of legacy name for a long time, so this
> > > can't be in this order. Otherwise we'll try to lookup the legacy name
> > > before trying the DT lookup and suffer performance hits doing a big
> > > global search while also skipping the DT lookup that we want drivers to
> > > use if they're more modern.
> > 
> > You'll try to look up the legacy name only if it is defined, in which case you
> > know you this is what you want to use, so I don't see the penalty.  Unless ...
> 
> We'll only try the legacy name if all else fails. We're hoping that
> .fw_name or .hw is used instead because those are faster than string
> comparisons on the entire tree.
> 
> > Are trying to support case where multiple fields among hw, name, fw_name, index
> > would be defined simultaneously ??
> 
> Yes.

Then this where we have different views ont he matter. I think this makes the
logic a lot more complex.

A controller should *know* if a clock is coming from 'somewhere else' and how.
I think we should not try multiple methods hoping one will eventually work.

I has already caught us now and I'm willing to bet we won't be the last.

> 
> > IMO, it would be weird and very confusing.
> 
> Let's expand the table.
> 
>     .fw_name   |  .index |  .name      | DT lookup? | fallback to legacy? 
>    +-----------+---------+-------------+----+----------------------------
>  1 | NULL      |    >= 0 |  NULL       |    Y       |         N
>  2 | NULL      |    -1   |  NULL       |    N       |         N
>  3 | non-NULL  |    -1   |  NULL       |    Y       |         N
>  4 | non-NULL  |    >= 0 |  NULL       |    Y       |         N
>  5 | NULL      |    >= 0 |  non-NULL   |    Y       |         Y
>  6 | NULL      |    -1   |  non-NULL   |    N       |         Y
>  7 | non-NULL  |    -1   |  non-NULL   |    Y       |         Y
>  8 | non-NULL  |    >= 0 |  non-NULL   |    Y       |         Y
> 
> And then if .hw is set we just don't even try to use the above table.
> 
> You want case #5 to skip the DT lookup because .fw_name is NULL, but the
> index is 0. I stared at this for a few minutes and I think you're
> arguing that we should only do the DT lookup when index is 0 if we can't
> fallback to a legacy lookup.
> 
> Initially that sounds OK, but then we'll get stuck with legacy lookups
> forever if someone doesn't put a matching .fw_name into the
> 'clock-names' property. We don't want that to happen. We want to get off
> legacy and into the new world where either .fw_name or .index is used to
> specify a parent.
> 
> From my perspective you're suffering from static initializers setting
> everything to 0 and that making the index 0 and "valid" for a DT lookup
> hitting up against not wanting to set anything in the structure
> unnecessarily. While at the same time, it's great that .fw_name is set
> to NULL by the static initializer, so it's a case of wanting the same
> thing to do different things.

Sure ... but we are also suffering from the complexity of the logic behind this
(and the table above)

When I define .hw, I don't need to initialize the rest but when I define .name I
must define (at least) .index to a specific value ... This is at least tricky,
and IMO, inconsistent.

> 
> If we would have made it so the DT index started at 1 then this wouldn't
> be a problem, but that's not possible. Or if we would have made a new
> clk flag that said CLK_USE_INDEX_FOR_DT then it could have gotten over
> this problem but that's basically the same as making the inverse set of
> drivers use -1 for the index to indicate they don't want a DT lookup.
> 
> I still believe the large majority of clk drivers will either use .hw or
> .fw_name to find parents, while falling back to the .name for legacy
> reasons. The .index field won't see much use, but we'll support it for
> the firmwares out there that don't use "clock-names". Similarly, we'll
> have only a handful of drivers that only want to specify .name and
> nothing else, and those few drivers can use .index = -1 to overcome
> this.

I'm sorry, I still find all this very confusing just to add a fallback
mechanism. It would be simpler to ask people to choose the method they.

The transition to DT can be done submitting DT part first and submitting the
clock driver part later on

Anyway, we'll define index to -1 since this how it is supposed to be. Thx for
your explanation


