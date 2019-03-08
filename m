Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A5CFC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 09:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAFE020811
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 09:19:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o+90rphf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbfCHJTa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 04:19:30 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37429 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbfCHJT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 04:19:29 -0500
Received: by mail-pf1-f194.google.com with SMTP id s22so13714505pfh.4;
        Fri, 08 Mar 2019 01:19:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d6G9aoVRcA2Mn1faj5vBVt9zIStu9ypTtyKPwsoNBDc=;
        b=o+90rphffLe0ixbSWlSiMVaWducoNShSBfeaWlf1I8tSKfQGbiX3ioXWPQyLvz6lju
         +GRM5EdgKiXSdpEShqxUsbxIEosuRyzRgGg3bNToO6EfsT/jNW8axv4Hm98eNpRqy7lH
         ghIxEGl1JQls4OwW1EDbLsZcIvcmcMGRxUFRZihwSJ8Qj3ZiEJ3dNt1R5hJ6fCdnMY9z
         KxplaYllZfaBrLHv4A/w78mtqieDFqukTWhuUwIt8KoABJvRfrYHMjjNU86OyjlxL6Cy
         TH3wfWKiNotJFtbpAF6Y/PMX/uHxRTA49i1gGodqO6pKkznXNs+fslbwiuow0WFscDOe
         pLpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d6G9aoVRcA2Mn1faj5vBVt9zIStu9ypTtyKPwsoNBDc=;
        b=hWz/0AiQzy8nc87tk9ryvpqDOa/OWr1Yz3bAfnVfM88adisFVncUZH4ygd2cAKNOvc
         mUjVAL45dhSn3Bl+yNRLjFOKNFxtRzSuDIYBb6MdcB3CNRCF74Vtgk9M25EFk+U2X+Ey
         vssGpI8OX0CK35iB8UliK3nYssny2NUbSMKCU2cAfK8pkkWcUWCaKva7yKHeH3GFcKWB
         bQo3kvgDaMF2sSDmFEdlY072Bj7zkjuGNsD8hM5go80GMl1gdSUZW14VhPmZTC+m5mYO
         clfrMOllxaJINkUEdgaeqosXsPPbH/8Wj1qGWKuPhRRQC4kiIZZKyF5Lx4uN8uJYqkKP
         TXQA==
X-Gm-Message-State: APjAAAU5yHw9NO3ISjYzxNYB2YmehEwbr3sIYInMWFn7ehAcP5nIX/qL
        TqSgvAfd1PdJyJRBzMFPKpENuJRw2jYmibJ8j9g=
X-Google-Smtp-Source: APXvYqyc0o3Stn2vzFGeBl6eStzbfiadPhgbKKdnPUmjf0Q9JiP8Nh1i+tfamtPxCXSU+Bvd+is75mg3hVPvW/pN2ec=
X-Received: by 2002:a17:902:728d:: with SMTP id d13mr17913086pll.12.1552036768074;
 Fri, 08 Mar 2019 01:19:28 -0800 (PST)
MIME-Version: 1.0
References: <cover.1551598603.git.vilhelm.gray@gmail.com> <12b3a364ac7fc32194fa6f55911dd800aca92a56.1551598603.git.vilhelm.gray@gmail.com>
 <CACRpkdbvCGRjB1sZWqN3wm660cP8S4-j0ub1j1iYpitDK_eXcQ@mail.gmail.com> <20190308085733.GA3903@icarus>
In-Reply-To: <20190308085733.GA3903@icarus>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 8 Mar 2019 11:19:16 +0200
Message-ID: <CAHp75VdaHYoXCqmnt=F_mnaTnCedLqs6CL1aC-oPFRdNJCAUCA@mail.gmail.com>
Subject: Re: [PATCH v9 1/9] bitops: Introduce the for_each_set_clump8 macro
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 8, 2019 at 10:56 AM William Breathitt Gray
<vilhelm.gray@gmail.com> wrote:
> On Fri, Mar 08, 2019 at 09:31:00AM +0100, Linus Walleij wrote:
> > On Sun, Mar 3, 2019 at 8:47 AM William Breathitt Gray
> > <vilhelm.gray@gmail.com> wrote:
> >
> > > This macro iterates for each 8-bit group of bits (clump) with set bits,
> > > within a bitmap memory region. For each iteration, "start" is set to the
> > > bit offset of the found clump, while the respective clump value is
> > > stored to the location pointed by "clump". Additionally, the
> > > bitmap_get_value8 and bitmap_set_value8 functions are introduced to
> > > respectively get and set an 8-bit value in a bitmap memory region.

> > Andrew: would you be OK with this being merged in v5.1?
> >
> > If we need to move the code to drivers/gpio that's OK (though
> > I think it's generally useful) but I need to know to proceed with
> > the William's nice optimization of these drivers.
> >
> > Yours,
> > Linus Walleij
>
> I was waiting on Andy to suggest some examples out of the GPIO realm,
> but he may be under a heavy workload right

Yeah, sorry for that. I will use your helpers in the future for sure
in the suitable parts of the code inside and outside of GPIO, just not
in a highest priority to me.

> so I decided to do a quick
> Consider this, if I am able to find a use for this macro outside of the
> GPIO subsystem within a matter minutes, then there must be some benefit
> in allowing the rest of the kernel to use the for_each_set_clump8 macro.
> So let's put it in bitops.h rather than restrict it to just the GPIO
> subsystem.

As I mentioned earlier I'm pretty sure I found as well opportunity to
use this new API
outside of GPIO realm. I just want to be sure (means of testing on real HW).

-- 
With Best Regards,
Andy Shevchenko
