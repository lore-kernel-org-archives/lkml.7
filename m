Return-Path: <SRS0=Iotr=V7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 362DCC31E40
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 18:36:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF0CA206A2
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 18:36:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iYNYmAfY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728774AbfHCSgn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Aug 2019 14:36:43 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45151 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728198AbfHCSgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Aug 2019 14:36:43 -0400
Received: by mail-lj1-f193.google.com with SMTP id m23so75717631lje.12
        for <linux-kernel@vger.kernel.org>; Sat, 03 Aug 2019 11:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NSi9TsGQZaVw6ZnB5I+qwD8eQNLA90Rl9Pl0pGBoFKk=;
        b=iYNYmAfYPo91w0uTmZHV0nLr+KnMSZUDVJzS17n/JwAllP8QqUQoSrEqhOD/I+nyUs
         zd0WtPlRZLpypUIjAXJJf+oKQp0Xh6EyOhP3js0LQopfrZ6ZyJ/EKpOCuidyeNpzYvTY
         AV7SiK6moveh3mhwpLmTjFqUxs3Iunh2bE8qbimoTsqOci1qrVoaqjGSJ2hNiK4l6sNP
         Be52NpI0Pqx7HK3lS+reLkiTiI35Und7ven7XSuHgpvQ/eK9yCfjqdmdcGRge/IhopLA
         BRMSHwtRpzyMrG8SHZWolDuUr2BApfhz9RzRpQ3bx5GceIu9MkeNyCMF67VsFEYbUuFL
         51OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NSi9TsGQZaVw6ZnB5I+qwD8eQNLA90Rl9Pl0pGBoFKk=;
        b=dtDCHawCqT92csTzaL8DzUBMSauKyWr+aqUO5pEpDzvYzqM9M+TlsXr0V8QjdNCGko
         aj01BDnOOGVdGDzhNxRrzr4Qg2fv3tkQYkd1hKQiVD4slY9O2L6Q5Qh6U0QOgryRPzWe
         t5U7saEpTUEeQdiQVsgsNAWm7qfAPyhA2oIhnzW2Gwqc2PeU1LKUmj1PwFRiO3R7alF3
         /n6ejaGcD9JUkVWq1aK444liFshIRXSjBiStHH2+n+OewPzoJjYvRRftDQ85dmQLmbZL
         prqdq1LRE2lHINZnb8J49yhL2EwWbU2Q93ynEaeqMoyvTXNvEHz958WPlor9S2NJW4bs
         4Ktg==
X-Gm-Message-State: APjAAAXDOf+SLBRn1qcQjLXp+wHXdCbeEzJyUbN/L8Gj8YwlVIeWmM5H
        huHMmuSQtelmqtRVCs6Hn2o=
X-Google-Smtp-Source: APXvYqyXgo8Xs/B2nD15LYQVjuKG9rBD/Oc+6YQ8mAiuxTFnXGfk4KTb5tOrOsvIfmjT6KEbQbt3Lw==
X-Received: by 2002:a2e:8ed2:: with SMTP id e18mr33045635ljl.235.1564857401548;
        Sat, 03 Aug 2019 11:36:41 -0700 (PDT)
Received: from rikard (h-158-174-186-115.NA.cust.bahnhof.se. [158.174.186.115])
        by smtp.gmail.com with ESMTPSA id n24sm15971745ljc.25.2019.08.03.11.36.39
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 03 Aug 2019 11:36:40 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
X-Google-Original-From: Rikard Falkeborn <rikard.falkeborn>
Date:   Sat, 3 Aug 2019 20:36:37 +0200
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] linux/bits.h: Add compile time sanity check of GENMASK
 inputs
Message-ID: <20190803183637.GA831@rikard>
References: <0306bec0ec270b01b09441da3200252396abed27.camel@perches.com>
 <20190731190309.19909-1-rikard.falkeborn@gmail.com>
 <47d29791addc075431737aff4b64531a668d4c1b.camel@perches.com>
 <CAK7LNAQdgUOsjWtWFnXm66DPnYFRp=i69DMyr+q4+NT+SPCQxA@mail.gmail.com>
 <2b782cf609330f53b6ecc5b75a8a4b49898483eb.camel@perches.com>
 <CAK7LNASw+Fraio3t=bZw-FzJihScTuDR=p2EktFVOmdLH4GTGA@mail.gmail.com>
 <20190802181853.GA809@rikard>
 <CAK7LNAT+cNxna4SER04MdkBsq_LDg4TwYR_U1ioNNxYOZWXigA@mail.gmail.com>
 <CAK7LNAQv-5epL8DYDaUdHsQEQ=Va676t_6TgsaSYC30Eix=iyw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNAQv-5epL8DYDaUdHsQEQ=Va676t_6TgsaSYC30Eix=iyw@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 03, 2019 at 12:12:46PM +0900, Masahiro Yamada wrote:
> On Sat, Aug 3, 2019 at 12:03 PM Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
> 
> >
> > BTW, v2 is already inconsistent.
> > If you wanted GENMASK_INPUT_CHECK() to return 'unsigned long',,
> > you would have to cast (low) > (high) as well:
> >
> >                (unsigned long)((low) > (high)), UL(0))))
> >
> > This is totally redundant, and weird.
> 
> I take back this comment.
> You added (unsigned long) to the beginning of this macro.
> So, the type is consistent, but I believe all casts should be removed.

Maybe you're right. BUILD_BUG_ON_ZERO returns size_t regardless of
inputs. I was worried that on some platform, size_t would be larger than
unsigned long (as far as I could see, the standard does not give any
guarantees), and thus all of a sudden GENMASK would be 8 bytes instead
of 4, but perhaps that is not a problem?
