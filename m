Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B81FC04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 16:35:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0857520862
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 16:35:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qR6Y1RLy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbfEPQf1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 12:35:27 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36454 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbfEPQf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 12:35:26 -0400
Received: by mail-pf1-f194.google.com with SMTP id v80so2134197pfa.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 09:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9J9a2LzssNOHKN9GbYjxdjZY+TIqtIW8RPeTXwMxezA=;
        b=qR6Y1RLypIHQr2YPzAk8GpNVBjwc4L5nEdW/ex0nmNmkVo/WwDQy1FrRZLP2h1qp7k
         PGmjKb6Oqbjuu8AdQkHCsmRc7GTWWt2mjyw4TTboutPDVoACPunBKROxB8bXZMc63IKB
         LjsPTilg+C4hsTZbBiNT52ieyyelwr654xuw/vXZOd/sPdHe3yC3W1fioPqjzM04W4iw
         4OPSmjJyt0u8yUBefe36+UrsAHX++oDf0LGM3xPB4PmYIkOcR1FK3J9L8GJUm+Yx9S3O
         +9lABDVEmY3tDFYXnamhK/BuMDLDmr3pYehi+5YnkEIEzI1UzRB4weU2zotTzPvXZmdz
         D9LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9J9a2LzssNOHKN9GbYjxdjZY+TIqtIW8RPeTXwMxezA=;
        b=OjqTpv2Qvw1prEVqpTsPTDaG/cUXi6lGNgfGnUrHcgOLtam5D99TiQdphlQmp+Eope
         vjEJns2SCqBRfILvflBc61CPR3RuD/Q63a7A1gr1fYVkegJI5kCr2Oil57G/ETzmO/jj
         JzH6ioXADg7SDCHqo67mMNWJ4hFhFU/akrmaTW50phYxhf9cbvE6PvdJLDjNGREb9r+s
         FxFIlzBJdlqo0vlzGJGSa/87tfQPAxGHmdhSA7CTUHHv3gcJ4fTAcp4ZYxitEg4+YHiJ
         6/a8lPVl1osIR3NagwnQMU5wfRlt8G4ye7JcyKzzpht6FeOr87m3F67n50TfOpI7cjJu
         1xag==
X-Gm-Message-State: APjAAAW2sPh9qg34rQOM0CE8Wp0FxTF58XldRPPyRo5D4NFGlXHk8Dyc
        5/7KIRGOZIFrAoKIEth5u4gNyaqGBUkzLyOpwLqLcUojShNw3w==
X-Google-Smtp-Source: APXvYqxyN5EOxa0PrXjKgoD0rTtQ/ipxRkM3fY5lzBGw8U4s4Dco01va6mjU04w4hYtLsK2wtFzvy6r0gsdwMO1l+lc=
X-Received: by 2002:a62:7a8f:: with SMTP id v137mr55367829pfc.243.1558024525130;
 Thu, 16 May 2019 09:35:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190516064304.24057-1-olof@lixom.net> <20190516064304.24057-4-olof@lixom.net>
 <CAHk-=whb-KituxcvM6ZPuXqyPX+rJENb8cnGCPbGE9pyqwOmXA@mail.gmail.com>
In-Reply-To: <CAHk-=whb-KituxcvM6ZPuXqyPX+rJENb8cnGCPbGE9pyqwOmXA@mail.gmail.com>
From:   Patrick Venture <venture@google.com>
Date:   Thu, 16 May 2019 09:35:14 -0700
Message-ID: <CAO=notySOzSjJS9jBCF9fyXEUK7VDZQiJp3WaSLs4Y7X7PC8=Q@mail.gmail.com>
Subject: Re: [GIT PULL 3/4] ARM: SoC-related driver updates
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Olof Johansson <olof@lixom.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        ARM SoC <arm@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "linux-alpha@vger.kernel.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, May 16, 2019 at 9:27 AM
To: Olof Johansson, Patrick Venture, Greg Kroah-Hartman
Cc: ARM SoC, Linux List Kernel Mailing, linux-alpha@vger.kernel.org

> On Wed, May 15, 2019 at 11:43 PM Olof Johansson <olof@lixom.net> wrote:
> >
> > Various driver updates for platforms and a couple of the small driver
> > subsystems we merge through our tree:
>
> Hmm. This moved the aspeed drivers from drivers/misc to
> drivers/soc/aspeed (in commit 524feb799408 "soc: add aspeed folder and
> misc drivers"), but in the meantime we also had a new aspeed soc
> driver added (in commit 01c60dcea9f7 "drivers/misc: Add Aspeed P2A
> control driver").
>
> I ended up resolving that "conflict" by moving the new aspeed P2A
> control driver to be with the other aspeed drivers too. That seemed to
> be the cleanest model.

Thank you.  I agree.  There was some back-and-forth about the SoC move
w.r.t any new aspeed misc drivers. Whether moving them into SoC was a
good approach versus leaving the growing list in misc.  Another aspeed
driver, controlling UART was headed to misc and received push-back
that it was sufficiently specialized to go into SoC
(https://patchwork.ozlabs.org/patch/969238/).  This feedback triggered
this staging move.

I think storing the growing misc drivers for these SoCs (Aspeed,
Nuvoton) in a SoC folder is a reasonable grouping.

>
> I'm used to doing these kinds of fixups in a merge, but I have to
> admit that maybe I should have made it a separate commit, because now
> it's kind of non-obvious, and it's sometimes harder to see changes
> that are in a merge commit than in a separate commit.
>
> In particular, it looks like "git log --follow" is not smart enough to
> follow a rename through a merge. But I think that is a git problem,
> and not a very serious one at that ("git blame" has no such problem).
>
> And it means that now the merge has
>
>  drivers/{misc => soc/aspeed}/aspeed-lpc-ctrl.c                   |   0
>  drivers/{misc => soc/aspeed}/aspeed-lpc-snoop.c                  |   0
>  drivers/{misc => soc/aspeed}/aspeed-p2a-ctrl.c                   |   0
>
> when you do "git show --stat" on it, which looks correct, and it feels
> like conceptually the right merge resolution to me.
>
> Sending out this explanatory email to everybody involved, just so that
> this doesn't take you by surprise. But it looks like Patrick Venture
> is not just the author of that moved driver, he was also involved in
> the move of the two other drivers, so I'm guessing there's not going
> to be a lot of confusion here.
>
> HOWEVER. More subtly, as part of my *testing* for this, I also
> realized that commit 524feb799408 is buggy. In my tests, the config
> worked fine, but the aspeed drivers were never actually *built*. The
> reason is that commit 524feb799408 ends up doing
>
>    obj-$(CONFIG_ARCH_ASPEED)      += aspeed/
>
> which is completely wrong, because the Kconfig fules are
>
>         depends on (ARCH_ASPEED || COMPILE_TEST) && REGMAP && MFD_SYSCON
>
> so those drivers can be configured even if ARCH_ASPEED *isn't* set.
> The Kconfig part works fine, because the soc/aspeed/Kconfig file is
> included unconditionally, but the actual build process then never
> builds anything in the drivers/soc/aspeed/ subdirectory.
>
> I solved _that_ problem by adding a new config option:
>
>   config SOC_ASPEED
>       def_bool y
>       depends on ARCH_ASPEED || COMPILE_TEST
>
> and using that instead of ARCH_ASPEED.

Thank you, that makes perfect sense.  When moving the drivers, I was
only considering the case where one is compiling them for use and
forgot to check for COMPILE_TEST.

>
> End result: this was a somewhat messy merge, and the most subtle mess
> was because of that buggy 524feb799408 "soc: add aspeed folder and
> misc drivers").
>
> I *think* I sorted it all out correctly, and now I see the aspeed
> drivers being built (and cleanly at that) but I really *really* want
> people to double-check this all.
>
> Also, I think that the same "we don't actually build-test the end
> result" problem exists else-where for the same reasons.
>
> At the very least, drivers/soc/{atmel,rockchip,zte} seem to have the
> exact same pattern: the Kconfig files enable the drivers, but the
> Makefile in drivers/soc doesn't actually traverse into the
> subdirectories.
>
> End result: CONFIG_COMPILE_TEST doesn't actually do any compile
> testing for those drivers.
>
> I did not try to fix all of those things up, because I didn't do the
> driver movements there.
>
>                   Linus
