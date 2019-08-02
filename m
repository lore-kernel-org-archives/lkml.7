Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C800C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 18:19:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 478F320880
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 18:19:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VlMJb0Ss"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406690AbfHBSTC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 14:19:02 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:43434 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406670AbfHBSTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 14:19:01 -0400
Received: by mail-lf1-f65.google.com with SMTP id c19so53563632lfm.10
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2019 11:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=o7ebvf6TNjfzhKP129VVdrJbnkwuHNahJ9dzTw6RxyE=;
        b=VlMJb0SskHBGIb7MfUzGstX+8RHf1lr5chskiZnjShYKMehbKDJpuNU1ww3FZhjXN7
         nhPmB82SWxcwPsvC4OhnTIGy0I6piobg+b5ggaAg3jEYvXGu4Ti8WveryMIkYziw5t05
         uoZawvg0nYg73RjCmwpUhVjYo8ailCJtGEtWl7MErUUZg2Nfb1tetXoHACg+6Z9h5NpA
         spdGd9Vw6cTK2OKaaNHO06mF7MhRTDhaic48kKCTYU6dRb+4wwQK1Hz0jztdvrCDlrQf
         /tYuu6T3scPP6X0JTdiEeqikVcR0VIfW44gxMH08OIz9CszfWR/K8ygenPn7Cfbo+8x8
         7Pig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=o7ebvf6TNjfzhKP129VVdrJbnkwuHNahJ9dzTw6RxyE=;
        b=KH6BPe7cJA+3wntxqlcoPU4o4qDNcLYn56vkrbcVsfd7kmn+V3+07InsNMskNpAQ4R
         /61sheBzE8vpXSPx/AVrNOKfMndIwyf6Xye0sziCWRoDwQ7A1WzdQ+8LksrYXH+xlxZj
         SOTl5XFzpKn7smotJcUpzuNxii2pV46PcQOuO271Kjlr76NaM7ltcuWoZ8+Z9RnzoDIb
         Fe4+7Eii7d4GseLDghuUGMxpYw+fcijGbpc1QGzL977c4E0okoO4IibXsTlE0+CI/PCr
         8snLMnef+SZAF3p3/yGkb4L5YcrfAJwtm5rFtHuXEHTglXrpb/99e2m6nRfcYeV2RO6C
         Mrfg==
X-Gm-Message-State: APjAAAX6ICv+rH7ZMoIeWeqVCu+38BYOibgLQNSkZjAHjW2Au8Ahl6Km
        p+XWtU/0X5IKrLiyUZJJ/heB2hUU/dM=
X-Google-Smtp-Source: APXvYqzA/WKeP7TSJFvM5QfyQZSjy8l+e61zNukPXljvLqREetLEDCC6A+4KjRaLs4j9amcJS42syw==
X-Received: by 2002:ac2:4157:: with SMTP id c23mr626973lfi.173.1564769938514;
        Fri, 02 Aug 2019 11:18:58 -0700 (PDT)
Received: from rikard (h-158-174-186-115.NA.cust.bahnhof.se. [158.174.186.115])
        by smtp.gmail.com with ESMTPSA id k23sm11598025ljg.90.2019.08.02.11.18.57
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 02 Aug 2019 11:18:57 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
X-Google-Original-From: Rikard Falkeborn <rikard.falkeborn>
Date:   Fri, 2 Aug 2019 20:18:53 +0200
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Joe Perches <joe@perches.com>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] linux/bits.h: Add compile time sanity check of GENMASK
 inputs
Message-ID: <20190802181853.GA809@rikard>
References: <0306bec0ec270b01b09441da3200252396abed27.camel@perches.com>
 <20190731190309.19909-1-rikard.falkeborn@gmail.com>
 <47d29791addc075431737aff4b64531a668d4c1b.camel@perches.com>
 <CAK7LNAQdgUOsjWtWFnXm66DPnYFRp=i69DMyr+q4+NT+SPCQxA@mail.gmail.com>
 <2b782cf609330f53b6ecc5b75a8a4b49898483eb.camel@perches.com>
 <CAK7LNASw+Fraio3t=bZw-FzJihScTuDR=p2EktFVOmdLH4GTGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNASw+Fraio3t=bZw-FzJihScTuDR=p2EktFVOmdLH4GTGA@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 02, 2019 at 12:25:06PM +0900, Masahiro Yamada wrote:
> On Fri, Aug 2, 2019 at 12:14 PM Joe Perches <joe@perches.com> wrote:
> >
> > On Fri, 2019-08-02 at 10:40 +0900, Masahiro Yamada wrote:
> > > On Thu, Aug 1, 2019 at 4:27 AM Joe Perches <joe@perches.com> wrote:
> > > > On Wed, 2019-07-31 at 21:03 +0200, Rikard Falkeborn wrote:
> > > > > GENMASK() and GENMASK_ULL() are supposed to be called with the high bit
> > > > > as the first argument and the low bit as the second argument. Mixing
> > > > > them will return a mask with zero bits set.
> > > > >
> > > > > Recent commits show getting this wrong is not uncommon, see e.g.
> > > > > commit aa4c0c9091b0 ("net: stmmac: Fix misuses of GENMASK macro") and
> > > > > commit 9bdd7bb3a844 ("clocksource/drivers/npcm: Fix misuse of GENMASK
> > > > > macro").
> > > > >
> > > > > To prevent such mistakes from appearing again, add compile time sanity
> > > > > checking to the arguments of GENMASK() and GENMASK_ULL(). If both the
> > > > > arguments are known at compile time, and the low bit is higher than the
> > > > > high bit, break the build to detect the mistake immediately.
> > > > >
> > > > > Since GENMASK() is used in declarations, BUILD_BUG_OR_ZERO() must be
> > > > > used instead of BUILD_BUG_ON(), and __is_constexpr() must be used instead
> > > > > of __builtin_constant_p().
> > > > >
> > > > > Commit 95b980d62d52 ("linux/bits.h: make BIT(), GENMASK(), and friends
> > > > > available in assembly") made the macros in linux/bits.h available in
> > > > > assembly. Since neither BUILD_BUG_OR_ZERO() or __is_constexpr() are asm
> > > > > compatible, disable the checks if the file is included in an asm file.
> > > > >
> > > > > Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
> > > > > ---
> > > > > Joe Perches sent a series to fix the existing misuses of GENMASK() that
> > > > > needs to be merged before this to avoid build failures. Currently, 7 of
> > > > > the patches were not in Linus tree, and 2 were not in linux-next.
> > > > >
> > > > > Also, there's currently no asm users of bits.h, but since it was made
> > > > > asm-compatible just two weeks ago it would be a shame to break it right
> > > > > away...
> > > > []
> > > > > diff --git a/include/linux/bits.h b/include/linux/bits.h
> > > > []
> > > > > @@ -18,12 +18,22 @@
> > > > >   * position @h. For example
> > > > >   * GENMASK_ULL(39, 21) gives us the 64bit vector 0x000000ffffe00000.
> > > > >   */
> > > > > +#ifndef __ASSEMBLY__
> > > > > +#include <linux/build_bug.h>
> > > > > +#define GENMASK_INPUT_CHECK(h, l)  BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
> > > > > +             __is_constexpr(h) && __is_constexpr(l), (l) > (h), 0))
> > > > > +#else
> > > > > +#define GENMASK_INPUT_CHECK(h, l) 0
> > > >
> > > > A few things:
> > > >
> > > > o Reading the final code is a bit confusing.
> > > >   Perhaps add a comment description saying it's not checked
> > > >   in asm .h uses.
> > > >
> > > > o Maybe use:
> > > >   #define GENMASK_INPUT_CHECK(h, l) UL(0)
> > >
> > > Why?
> >
> > Consistency with the uses in what's now called __GENMASK
> 
> Inconsistent with __GENMASK_ULL.

Would you prefer to add GENMASK_ULL_INPUT_CHECK? Or replace UL(0) with
0 and then probably move the cast of BUILD_BUG_OR_ZERO (to avoid
GENMASK be of type size_t) to GENMASK and GENMASK_ULL?
