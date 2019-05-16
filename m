Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A070C04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 16:27:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A3D72082E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 16:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558024028;
	bh=JvHLQ3WLEQPhtVYvcVQym5MZ+Jr2ujTfzyMJQ+itCew=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=kxAikzfr9za3BzmTxnjRkG3tUQFFSkncpd4UX8kEvd0f1+YWKLZQ4HfBP7Saqu/9G
	 lAV1wqO0vQhSdIFgYnWzn3kqqlvv8roZt9sjqUgir2fjrcLMUfIUIcT6uYIvbeFsyt
	 517fWXcfGv6wEvOdfN3mlMe4DMriWu8X2xRHbw9w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbfEPQ1H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 12:27:07 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34256 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbfEPQ1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 12:27:07 -0400
Received: by mail-lj1-f196.google.com with SMTP id j24so3715351ljg.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 09:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CJn+s1/9iwnST3l6oaCFH3Pabu3jpALwTCNZgnOPKSk=;
        b=RbIOcHhbe/wAJnhmE+X0+jqRT3pY8KcZzvhJF5Lg9TwQ8gVf3VLYKAsRoqwWTQp4qX
         GNwZxaLxD1imdCwMmdAyJyfUGNksYji2fm0afsXvot60M+nvGFT0cP+SGpPpRIIjwh3a
         zRlK4oU9gZLMtkC00ta8Onnj2sYvjd9PLdIOI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CJn+s1/9iwnST3l6oaCFH3Pabu3jpALwTCNZgnOPKSk=;
        b=HnoznO+phFu8nDjo75ahXglCRpg47d3VrwymV4UKg9bVZ0RKacBZgCM/3Bkx/a5BrZ
         TpoXzXgAuCxXtbHwr4J6mdfg/IJ02GQ8BlqLBo3MVVC8zlk54D3ntOukhRrj+6PnZgK6
         GjOycDofrRqciCJsa02z7LLDwwkjWTqlVwkZnMoCLFvpO15QmeVzlhqjPofhme9ZO9W3
         jVpO0eSrdgg9DiTvgkd2GNYh1TA91cN7uv+NQcmBqIRQZLVwBmTFxxZwD/KuNlBjc3s3
         BdGwFZ3CLijtGaMFndHKkQh74MTTynagckY++28kjciVxrsO9ffkIUSXBaNu15YflQJx
         sVfw==
X-Gm-Message-State: APjAAAUo1k5OcOCrBukt6aCYMgCephTlfhZ+j454KQIixKzslCZU7lCl
        5DSdGx3MEhZ6G9ur/TYNNlp+1JwAWKI=
X-Google-Smtp-Source: APXvYqyIeHmh6gDVSCAtlS6zsoC7qw/rkct5meaQ+qlMywnWI6tmaHhtvmx3/GG4Ot+W8E4iMXzy9w==
X-Received: by 2002:a2e:96d9:: with SMTP id d25mr23702980ljj.78.1558024024228;
        Thu, 16 May 2019 09:27:04 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id k26sm1184326lfb.63.2019.05.16.09.27.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2019 09:27:03 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id l26so3088941lfh.13
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 09:27:03 -0700 (PDT)
X-Received: by 2002:ac2:5212:: with SMTP id a18mr25173004lfl.166.1558024022880;
 Thu, 16 May 2019 09:27:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190516064304.24057-1-olof@lixom.net> <20190516064304.24057-4-olof@lixom.net>
In-Reply-To: <20190516064304.24057-4-olof@lixom.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 16 May 2019 09:26:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=whb-KituxcvM6ZPuXqyPX+rJENb8cnGCPbGE9pyqwOmXA@mail.gmail.com>
Message-ID: <CAHk-=whb-KituxcvM6ZPuXqyPX+rJENb8cnGCPbGE9pyqwOmXA@mail.gmail.com>
Subject: Re: [GIT PULL 3/4] ARM: SoC-related driver updates
To:     Olof Johansson <olof@lixom.net>,
        Patrick Venture <venture@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     ARM SoC <arm@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "linux-alpha@vger.kernel.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 15, 2019 at 11:43 PM Olof Johansson <olof@lixom.net> wrote:
>
> Various driver updates for platforms and a couple of the small driver
> subsystems we merge through our tree:

Hmm. This moved the aspeed drivers from drivers/misc to
drivers/soc/aspeed (in commit 524feb799408 "soc: add aspeed folder and
misc drivers"), but in the meantime we also had a new aspeed soc
driver added (in commit 01c60dcea9f7 "drivers/misc: Add Aspeed P2A
control driver").

I ended up resolving that "conflict" by moving the new aspeed P2A
control driver to be with the other aspeed drivers too. That seemed to
be the cleanest model.

I'm used to doing these kinds of fixups in a merge, but I have to
admit that maybe I should have made it a separate commit, because now
it's kind of non-obvious, and it's sometimes harder to see changes
that are in a merge commit than in a separate commit.

In particular, it looks like "git log --follow" is not smart enough to
follow a rename through a merge. But I think that is a git problem,
and not a very serious one at that ("git blame" has no such problem).

And it means that now the merge has

 drivers/{misc => soc/aspeed}/aspeed-lpc-ctrl.c                   |   0
 drivers/{misc => soc/aspeed}/aspeed-lpc-snoop.c                  |   0
 drivers/{misc => soc/aspeed}/aspeed-p2a-ctrl.c                   |   0

when you do "git show --stat" on it, which looks correct, and it feels
like conceptually the right merge resolution to me.

Sending out this explanatory email to everybody involved, just so that
this doesn't take you by surprise. But it looks like Patrick Venture
is not just the author of that moved driver, he was also involved in
the move of the two other drivers, so I'm guessing there's not going
to be a lot of confusion here.

HOWEVER. More subtly, as part of my *testing* for this, I also
realized that commit 524feb799408 is buggy. In my tests, the config
worked fine, but the aspeed drivers were never actually *built*. The
reason is that commit 524feb799408 ends up doing

   obj-$(CONFIG_ARCH_ASPEED)      += aspeed/

which is completely wrong, because the Kconfig fules are

        depends on (ARCH_ASPEED || COMPILE_TEST) && REGMAP && MFD_SYSCON

so those drivers can be configured even if ARCH_ASPEED *isn't* set.
The Kconfig part works fine, because the soc/aspeed/Kconfig file is
included unconditionally, but the actual build process then never
builds anything in the drivers/soc/aspeed/ subdirectory.

I solved _that_ problem by adding a new config option:

  config SOC_ASPEED
      def_bool y
      depends on ARCH_ASPEED || COMPILE_TEST

and using that instead of ARCH_ASPEED.

End result: this was a somewhat messy merge, and the most subtle mess
was because of that buggy 524feb799408 "soc: add aspeed folder and
misc drivers").

I *think* I sorted it all out correctly, and now I see the aspeed
drivers being built (and cleanly at that) but I really *really* want
people to double-check this all.

Also, I think that the same "we don't actually build-test the end
result" problem exists else-where for the same reasons.

At the very least, drivers/soc/{atmel,rockchip,zte} seem to have the
exact same pattern: the Kconfig files enable the drivers, but the
Makefile in drivers/soc doesn't actually traverse into the
subdirectories.

End result: CONFIG_COMPILE_TEST doesn't actually do any compile
testing for those drivers.

I did not try to fix all of those things up, because I didn't do the
driver movements there.

                  Linus
