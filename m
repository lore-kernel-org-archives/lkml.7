Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CC46C32751
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 20:08:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 494BA21922
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 20:08:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C+IVsyKj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389178AbfHGUIA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 16:08:00 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45975 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388210AbfHGUH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 16:07:59 -0400
Received: by mail-lj1-f194.google.com with SMTP id m23so86578144lje.12
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 13:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=e6mJhABhQHvJEBAYgDnbQQku2ARSnWaho1xEKM71w0o=;
        b=C+IVsyKjjmvjcsuCAiBwOsW88PYOcUy9oMPpHx48In+3NA3K60lFa7cyfGgUFDV0gp
         VLZ+qClMfcDOf/tDowIrybHre/a+WioKIkoZ5uX2lZDxINo874lMvdhI23LtLhOhwL+P
         Utj98Sl+VLxlLcZGPDPPrVZUeulZ7ktKKzHao1lztKROm7MsDHPiqtZT+m/HUdiBCzcV
         k4PcKDZ1T1zPHm04LjbqIJDHsGF2zc4n54qn7fXpUUuOacqS+5UYNzw+OiOvyg2U9BJE
         pEffk8cae4c5UCpwsI2b7yESq+UIyeCmvE9lM4mgjXrGMjs+5+SPNgxynVihkQSKc1mR
         ZVGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=e6mJhABhQHvJEBAYgDnbQQku2ARSnWaho1xEKM71w0o=;
        b=rOnBYXw4Kyk0/Lq5ViWHjblIEaVUTLZ/Vs4ligl6g0wSALxjamITSah5m1EVaU+KFS
         0NUpHla2c8LEoj57iEkDGIZEjxaIB7XtuxdGMmN0ahD7/KXhmuAfoXoF5yXMDi39Dj/U
         BN9kKYORcIhuOzixXtuKMKzTjibb/33b/n+4rZ2h/FIESV5cmMblxYYUK1KDuGWwpqiL
         yXVt/aUFj3+jS8vM2pa+vhEjbmGpGnvZY0Kuk+NWSMK/72aVZFGHIhiy5UdX9fS9c3OP
         Qobj+49ebl3WSpyvt0QIuVvQEFvtz33sGgFTe4GLULm7JWpfL++l1wtQxAEAvcoZYA+5
         udMw==
X-Gm-Message-State: APjAAAUdFL+uYeYa2m2jqy23t7W0+E3nRhHqLhpVB3ki+CGOlAGHoSYe
        z3TsWO/vlgv8MAX0N+omb6s=
X-Google-Smtp-Source: APXvYqzYCZ4mYUZT+k0Or8Q2BIwP836lEJpyjVNHnO1WMUKMqz76SZkNz0iu54H/23Z9Wr/I7To7Mg==
X-Received: by 2002:a2e:298a:: with SMTP id p10mr5869609ljp.74.1565208477643;
        Wed, 07 Aug 2019 13:07:57 -0700 (PDT)
Received: from rikard (h-158-174-186-115.NA.cust.bahnhof.se. [158.174.186.115])
        by smtp.gmail.com with ESMTPSA id i62sm18295577lji.14.2019.08.07.13.07.56
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 07 Aug 2019 13:07:56 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
X-Google-Original-From: Rikard Falkeborn <rikard.falkeborn>
Date:   Wed, 7 Aug 2019 22:07:53 +0200
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joe Perches <joe@perches.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] linux/bits.h: Add compile time sanity check of
 GENMASK inputs
Message-ID: <20190807200753.GA14779@rikard>
References: <20190731190309.19909-1-rikard.falkeborn@gmail.com>
 <20190801230358.4193-1-rikard.falkeborn@gmail.com>
 <20190801230358.4193-2-rikard.falkeborn@gmail.com>
 <20190807142728.GA16360@roeck-us.net>
 <CAK7LNATGuO0D0a-sTvWw5Pzkn5C7jrLiS=rCwiRsEqaS86KbuQ@mail.gmail.com>
 <d1bd1c05-3e92-1a7f-ebd3-3b26981a6f8e@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1bd1c05-3e92-1a7f-ebd3-3b26981a6f8e@roeck-us.net>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 07, 2019 at 09:52:33AM -0700, Guenter Roeck wrote:
> On 8/7/19 7:55 AM, Masahiro Yamada wrote:
> > On Wed, Aug 7, 2019 at 11:27 PM Guenter Roeck <linux@roeck-us.net> wrote:
> > > 
> > > On Fri, Aug 02, 2019 at 01:03:58AM +0200, Rikard Falkeborn wrote:
> > > > GENMASK() and GENMASK_ULL() are supposed to be called with the high bit
> > > > as the first argument and the low bit as the second argument. Mixing
> > > > them will return a mask with zero bits set.
> > > > 
> > > > Recent commits show getting this wrong is not uncommon, see e.g.
> > > > commit aa4c0c9091b0 ("net: stmmac: Fix misuses of GENMASK macro") and
> > > > commit 9bdd7bb3a844 ("clocksource/drivers/npcm: Fix misuse of GENMASK
> > > > macro").
> > > > 
> > > > To prevent such mistakes from appearing again, add compile time sanity
> > > > checking to the arguments of GENMASK() and GENMASK_ULL(). If both the
> > > > arguments are known at compile time, and the low bit is higher than the
> > > > high bit, break the build to detect the mistake immediately.
> > > > 
> > > > Since GENMASK() is used in declarations, BUILD_BUG_ON_ZERO() must be
> > > > used instead of BUILD_BUG_ON(), and __is_constexpr() must be used instead
> > > > of __builtin_constant_p().
> > > > 
> > > > If successful, BUILD_BUG_OR_ZERO() returns 0 of type size_t. To avoid
> > > > problems with implicit conversions, cast the result of BUILD_BUG_OR_ZERO
> > > > to unsigned long.
> > > > 
> > > > Since both BUILD_BUG_ON_ZERO() and __is_constexpr() only uses sizeof()
> > > > on the arguments passed to them, neither of them evaluate the expression
> > > > unless it is a VLA. Therefore, GENMASK(1, x++) still behaves as
> > > > expected.
> > > > 
> > > > Commit 95b980d62d52 ("linux/bits.h: make BIT(), GENMASK(), and friends
> > > > available in assembly") made the macros in linux/bits.h available in
> > > > assembly. Since neither BUILD_BUG_OR_ZERO() or __is_constexpr() are asm
> > > > compatible, disable the checks if the file is included in an asm file.
> > > > 
> > > 
> > > Who is going to fix the fallout ? For example, arm64:defconfig no longer
> > > compiles with this patch applied.
> > > 
> > > It seems to me that the benefit of catching misuses of GENMASK is much
> > > less than the fallout from no longer compiling kernels, since those
> > > kernels won't get any test coverage at all anymore.
> > 
> > 
> > We cannot apply this until we fix all errors.
> > 
> > I do not understand why Andrew picked up this so soon.
> > 
> 
> The same was done with the fallthrough warning in mainline, which still results
> in all "sh" builds failing there (and in -next, obviously). I don't understand
> the logic either, but maybe it is the new normal.
> 
> Guenter

Sorry about that. As Masahiro said, the patch was picked up too soon,
I've asked Andrew and Stephen Rothwell to remove the patch in a separate
email thread.

FWIW, there seems to be a patch for the build failure already (all arm
builds seems to have the same build error):

https://lore.kernel.org/lkml/20190807192305.6604-1-natechancellor@gmail.com/T/#u

Rikard
