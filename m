Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BC9FC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 08:56:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BE2E20684
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 08:56:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gHL3NkzM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbfCHI44 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 03:56:56 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42237 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbfCHI4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 03:56:55 -0500
Received: by mail-pg1-f195.google.com with SMTP id b2so13615092pgl.9;
        Fri, 08 Mar 2019 00:56:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EvaF26RI7c5HyTPz/s7fr3l3YkC9rN6qerGwkguRTR8=;
        b=gHL3NkzMk1rMibDf4b7nqUDivvpIM8faxWPoOea5c8ln2b9GzJbwW8+kqpdb3KQOVS
         S0ttHMbEGe3tlrF4cP3chkm3KHKGufEgDPpEDDqHkV2xTEEyDaB+35pywPK++4lc4cYt
         G3NjQ1JZXfQvS87kPipvCvbmUTwntS3owjOPIst5LqYyq/pMd+ZUmDsWsJleAuHpWJ/J
         +cap0A5siHiHMcJSbS1YotI/T0OAlaJiVKwHy10y4gYbs6i3ak87ruIjJa8vhKeQaYW8
         Cb/iwj+81A1k4vA0pBEvuiMqyw/bZUTj0FZWGxIxCo42BP8SJgM9px39W3D6XBHqzx3p
         aGRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EvaF26RI7c5HyTPz/s7fr3l3YkC9rN6qerGwkguRTR8=;
        b=hySY9qt5XYJbLHv5sfNLC3SPJMmjZRasbMg+kFq0xMdBCKeEWLJHSpO+KIcRTBjBtD
         nLpAYNzrqjtCz+aqwXCz8SUGAyP1IQreOzS2dCEQf+QD+jVJNI+OzZTD6kWQTT+en0Rl
         Ui0lc155Kz0HHSJek8cskzMxtPvI50lgkwM4/5yVaLy2XiJiyTiD/M5M86W0AtZ5Op6k
         8EQ9OLHIp3lfl4Db+2Sa7xvrHyy5i+o/H/VjfwC2u3vc5DYmPjlrVa8PI0U4q7Yair3p
         ZcHP3ZvsyBPZPSWPyQu5JlRuGWdjv6XS7hIkgMrd8XifrCkj6qHYBMkssmhzBQX6u+Lq
         /BwA==
X-Gm-Message-State: APjAAAUYvYGZ/XFVcQWUeAoJziINW7QKaJN8os7Rjnzf21VxO1VFh/n4
        v98ck2eO+7EXMticvSDTgJyu7fng8TI=
X-Google-Smtp-Source: APXvYqxjNo60pDjliav6Hb6c59I3IewkFpnQk8a3UZqoyEjjf0blzslJRWbMbT5LxTFtZoONDR90wQ==
X-Received: by 2002:aa7:8497:: with SMTP id u23mr17544958pfn.253.1552035414114;
        Fri, 08 Mar 2019 00:56:54 -0800 (PST)
Received: from icarus ([2001:268:c0a4:4f3d:c70:4af9:86e2:2])
        by smtp.gmail.com with ESMTPSA id n10sm9524340pfa.139.2019.03.08.00.56.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Mar 2019 00:56:53 -0800 (PST)
Date:   Fri, 8 Mar 2019 17:57:33 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-arch@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v9 1/9] bitops: Introduce the for_each_set_clump8 macro
Message-ID: <20190308085733.GA3903@icarus>
References: <cover.1551598603.git.vilhelm.gray@gmail.com>
 <12b3a364ac7fc32194fa6f55911dd800aca92a56.1551598603.git.vilhelm.gray@gmail.com>
 <CACRpkdbvCGRjB1sZWqN3wm660cP8S4-j0ub1j1iYpitDK_eXcQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACRpkdbvCGRjB1sZWqN3wm660cP8S4-j0ub1j1iYpitDK_eXcQ@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 08, 2019 at 09:31:00AM +0100, Linus Walleij wrote:
> On Sun, Mar 3, 2019 at 8:47 AM William Breathitt Gray
> <vilhelm.gray@gmail.com> wrote:
> 
> > This macro iterates for each 8-bit group of bits (clump) with set bits,
> > within a bitmap memory region. For each iteration, "start" is set to the
> > bit offset of the found clump, while the respective clump value is
> > stored to the location pointed by "clump". Additionally, the
> > bitmap_get_value8 and bitmap_set_value8 functions are introduced to
> > respectively get and set an 8-bit value in a bitmap memory region.
> >
> > Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > Suggested-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> > Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> 
> Andrew: would you be OK with this being merged in v5.1?
> 
> If we need to move the code to drivers/gpio that's OK (though
> I think it's generally useful) but I need to know to proceed with
> the William's nice optimization of these drivers.
> 
> Yours,
> Linus Walleij

I was waiting on Andy to suggest some examples out of the GPIO realm,
but he may be under a heavy workload right so I decided to do a quick
search for one.

In drivers/of/unittest.c, there is loop across a bitmap in the
of_unittest_destroy_tracked_overlays function:

	for (id = MAX_UNITTEST_OVERLAYS - 1; id >= 0; id--) {
		if (!(overlay_id_bits[BIT_WORD(id)] & BIT_MASK(id)))
			continue;

This section of code is checking each bit individually, and skipping if
that bit is not set. This looping can be optimized by using the
for_each_set_clump8 macro to skip clumps of nonset bits (not to mention
make the logic of the code much simpler and easier to follow by reducing
the code to a single line):

	for_each_set_clump8(id, clump, overlay_id_bits, MAX_UNITTEST_OVERLAYS-1)

The for_each_set_clump8 macro is not specific to the GPIO subsystem; I
just happen to use it in these GPIO drivers simply because I am most
familar with this section of the kernel (it's where most of my
contributions occur afterall).

Consider this, if I am able to find a use for this macro outside of the
GPIO subsystem within a matter minutes, then there must be some benefit
in allowing the rest of the kernel to use the for_each_set_clump8 macro.
So let's put it in bitops.h rather than restrict it to just the GPIO
subsystem.

William Breathitt Gray
