Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50019C04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 17:39:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1872220848
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 17:39:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="HrNwXNUo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728839AbfEPRjW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 13:39:22 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:34994 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726409AbfEPRjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 13:39:21 -0400
Received: by mail-io1-f66.google.com with SMTP id p2so3297913iol.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 10:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n4kyV2+gH9O/+achKRV4DAR9WUsLHSm0sKFkMloko7c=;
        b=HrNwXNUoERnsOAO+DYmF16v80ow6GZDPlHz13QmZjJOu3/MvwlyNTenvEQWAaRK1Wv
         ceFpOEzfy0p6TDA7y7xbQBuTTNFG221kKtgaqi9k3Rt6ty/TwNGfRlnGUsL8pMzmqMhR
         g/JKj2MXOF57Jbe7tNBfCPQSINDVGTyzun+/IfOVwoTNa0XotzoGCx2VEhn9vELUpwZH
         Ln7l9R6+GuisDmH+az64fc3kEpfsYq4su1vYiNuj04LyjMdJqSwWCXQye1l8k4K+urDd
         xyIuZe5aO19JPkMJxVcVCnYdaoI6M6OuP/Txi8qu/yqeuIdOhZh7gU/kje6+XLnCH6FS
         kAZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n4kyV2+gH9O/+achKRV4DAR9WUsLHSm0sKFkMloko7c=;
        b=pk1lboHI3/83W8Pi8Kfxp5S6KGfBSFkTl058FUI2WcoyoMbdw3OoAfcZwAmONrVW56
         8WQG6t82+tZpd2ssI7xDTzu1hV3kmqaUmgjZUkPB8z7uh86ys0G0BO6kD4gG6VUXHMBY
         KnUH+lN6J/VuEM3w41s+7C8CyJu5Pryyfb8PeRZMwhn50e25QXEeCPuz0IOpg6NZ7pdk
         2Fv2apX1bkmHd8toQe32UaCxoCls+8KN08EKr5WCBRZdJy0m70D71Nl3t2XcF7UnqimO
         s7pxuxUshCF432WXT0L/02HPBCAjfO3M1omx0DZJPPjjjvi/bhMJH85UTfXq/GBpQnEr
         mucQ==
X-Gm-Message-State: APjAAAX8fASPBNBABOUJpcKXR+lDlDk2HEEvE1qygtC8YqIotX8srXsW
        570W4yTAaYv5lGhp58blVIXPgEWrKSzAyzbpKT4Jow==
X-Google-Smtp-Source: APXvYqwLHVhQvM2YqHN0Q3s/d9DcoXG5S8Y32LS4Gu00TYBdggXhMCvV1iEqBAgHgbqmR15Oisi0OkmhfJNReCqMUHQ=
X-Received: by 2002:a6b:da11:: with SMTP id x17mr31451636iob.78.1558028360320;
 Thu, 16 May 2019 10:39:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190516064304.24057-1-olof@lixom.net> <20190516064304.24057-4-olof@lixom.net>
 <CAHk-=whb-KituxcvM6ZPuXqyPX+rJENb8cnGCPbGE9pyqwOmXA@mail.gmail.com>
In-Reply-To: <CAHk-=whb-KituxcvM6ZPuXqyPX+rJENb8cnGCPbGE9pyqwOmXA@mail.gmail.com>
From:   Olof Johansson <olof@lixom.net>
Date:   Thu, 16 May 2019 10:39:08 -0700
Message-ID: <CAOesGMjY+OOLP6oYgz9f4+VHwj-H1rA7K+u=QHTG1t2xG9YhUw@mail.gmail.com>
Subject: Re: [GIT PULL 3/4] ARM: SoC-related driver updates
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Patrick Venture <venture@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        ARM SoC <arm@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "linux-alpha@vger.kernel.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 16, 2019 at 9:27 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
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

Yeah, that's the approach we're heading towards with aspeed.

Part of the reason for why I wasn't 100% sure we wanted to move all
drivers over, is that most of drivers/soc has been for "soc glue
logic" code, not for the little SoC-specific drivers where we've
pushed hard to get out into their best-matching driver directories
instead.

Aspeed is an unusually "messy" SoC in that it has a handful of little
widgets used to communicate with the host (in its role as BMC), and
either we'd squint and put all of them in drivers/misc, or we could
pick them up in drivers/soc as we're now doing. Either way the code
will be in the kernel, and keeping it together might not be a bad
idea.

We might get more of a kitchen sink in drivers/soc over time with this
slight change in approach, but we've dealt with messes before and if
it happens, we'll clean it up when it gets too bad. Sometimes letting
it happen is the best way of seeing the bigger picture and not
over-engineer something upfront.

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

Yeah. I think that's fine in this case.

I've got some horror stories from botched rebases where merges ended
up containing actual code changes and that caused immense confusion,
but that's not the case here.

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

Yep, looks good -- thanks!

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

We'll follow up with patches for that, thanks for pointing it out.

I have to admit that most of my focus tends to be to check for new
errors, not whether everything still is built. Easy to automate, so
I'll poke around with it a bit.

-Olof
