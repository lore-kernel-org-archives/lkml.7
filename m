Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D099ACA9EAB
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 15:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F60021897
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 15:09:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aHNodF4+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505122AbfJRPJH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 11:09:07 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:35553 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392875AbfJRPJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 11:09:04 -0400
Received: by mail-lf1-f66.google.com with SMTP id w6so5001989lfl.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 08:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5G0J25R+L4feZP0FafuhoQQw/6NR5l7vb68kANu0aIA=;
        b=aHNodF4+80Cs0F+qKHJFEivmVOS/gdvgET6bxn8yoLENBeRXCYqvhl9v/M38MMaq6e
         8YEB1vcD78CyP1nZqpmkhVrEwEqWrPGEYETQ3SAxQwo1566wLhjx5I1waaOy5F1DrMl1
         fzH6qT+nhlfOSYQdEX1ysLJ9RV/Q//0jpr6RM5ZNUCfJPezwIDf8rbzK4qmYYlFv0ojj
         WyZI/n6b23ZWuxTlX/c0rzzB7kTZLToBsd3B228rP4wWcZDGLL3/Wy2vwKdQAF7spZIi
         UWZnd6jTHHjHclmoVg4QAoodG5xoUF4BJ3vrComUCsW1g6J5vu5ug0PxqzIrknDASLVZ
         n2Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5G0J25R+L4feZP0FafuhoQQw/6NR5l7vb68kANu0aIA=;
        b=UlRLdQRA2Y/9QMTOihs5PopXsjwA+jy6wTdCH7pXQuK7Dvr9bhEmG2qhIPOTAXwXFx
         e51YlETHeH6JWxOxNgxbz6J3DbFh3Pr4hoSJGIHzq0tII/XkC00pl26yzv7yc38s+k9Y
         N3xOUDQnRqZf1mZHCz0dwbEVw09v68l/1BGh512Q1zZMvbKCinR13yUWg4khh2/z+/hc
         bPlguiRajiq1hfDr+iSGdErCHYNGsCd/KKFtZHEQdRR2ShZELahIt/uqDRy6cxK/l4Oe
         zL22q8L2IqJcztlckHHc4LLFAVrIDjyqXLrg/9jAeeBdnFzmN5lU5uhimXPJlxL3M/Ec
         23QQ==
X-Gm-Message-State: APjAAAUh0ofP3rvaMXztl6e2Wr/uWR5rrO1d64L5ONU9HHLPNw8yuK+A
        nc4dP7Sz6qPoQhE8h/hUzReB30SmYGBGNjmFRPzV8rDX
X-Google-Smtp-Source: APXvYqxTW3nVCTJY1fAE6D+bC1VpeJos310SOzFkH+H7YLp7iiJ9gn4VcyP4oTpzXYRtxrUcWAOcYHqpKOIQj2eDm6s=
X-Received: by 2002:ac2:533c:: with SMTP id f28mr6535730lfh.0.1571411341666;
 Fri, 18 Oct 2019 08:09:01 -0700 (PDT)
MIME-Version: 1.0
References: <20191016082430.5955-1-poeschel@lemonage.de> <CANiq72=uXWpEWHixM+wwyxZfzQ41WYvQsoV8B3+JLRharDjC0w@mail.gmail.com>
 <20191017080741.GA17556@lem-wkst-02.lemonage>
In-Reply-To: <20191017080741.GA17556@lem-wkst-02.lemonage>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 18 Oct 2019 17:08:50 +0200
Message-ID: <CANiq72m0V5CBxp97Q4h70Gup1DCoZj4ZFa6VWQLk0jyurxeztQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] auxdisplay: Make charlcd.[ch] more general
To:     Lars Poeschel <poeschel@lemonage.de>
Cc:     Willy Tarreau <willy@haproxy.com>,
        Ksenija Stanojevic <ksenija.stanojevic@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Joe Perches <joe@perches.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2019 at 10:07 AM Lars Poeschel <poeschel@lemonage.de> wrote:
>
> That panel.c doesn't compile is of course a no-go. Sorry. I missed
> something and I will fix this in a next version of the patch. But before
> submitting a next version, I will wait some time, if there is more
> feedback.

I meant I wasn't sure if the overall patch as that well tested ;-)

> The idea with changing the return types: It seems a bit, that with this
> patch charlcd is becoming more of an universal interface and maybe more
> display backends get added - maybe with displays, that can report
> failure of operations. And I thought, it will be better to have this
> earlier and have the "interface" stable and more uniform. But you are
> the maintainer. If you don't like the changed return types I happily
> revert back to the original ones in the next version of the patch.

I see the value of the idea, but given kernel APIs are not stable
anyway, I prefer not to have things that we do not use yet. If someone
requires returning an error code in a future driver, they can change
it later on. I don't have a strong opinion on this anyway.

> >   * Some things (e.g. the addition of enums like charlcd_onoff) seem
> > like could have been done other patches (since they are not really
> > related to the reorganization).
>
> I can split this out into separate patches. It'd be good know what else
> you mean by "some things" so I can do this as well. Do you want each
> enum as a separate patch or one big enum patch ?

As Andy said, ideally patches/commits implement logical changes, i.e.
broken down as much as reasonably possible. For instance, changing the
interface from int/bool to an enum is probably a good idea, but it is
not related to the overall reorganization. In fact, it is orthogonal,
since it could be done either before or after the reorganization.

In general, it is much more easy to understand and review changes if
you split them. For instance, I noticed the enum change by chance, I
may have not noticed it; but if it was in a different patch, it would
have been clear for everyone. It also allows you to explain each
change individually in the commit message. Another of those "things"
is what Andy suggested. Of course, after you split things, it will
become easier to spot other things too, so we might have to do another
round etc.

A single patch for all the enums is fine. We could split those too,
but given the change has the same rationale, and is small enough, we
can put them together and share the commit message + is easier for you
and us to handle too. That is the "as much as reasonably possible"
part of the guideline ;-)

> Strange. I did indeed checkpatch.pl the patches before submitting and I
> got no complaints about whitespace or line endings. There was "WARNING:
> added, moved or deleted file(s), does MAINTAINERS need updating?" and
> patch 1 also has "WARNING: please write a paragraph that describes the
> config symbol fully". I submitted the patches with git send-email so it
> is very unlikely, that the mailer messed up the patches. Strange...

Hm... Try sending the series to yourself and see if you can reproduce it.

> Oh by the way: Do you know what I can do to make checkpatch happy with
> its describing of the config symbol ? I tried writing a help paragraph
> for the config symbols in Kconfig, but that did not help.

CC'ing Joe.

> > I am not capable of testing this, so extra testing by anyone who has
> > the different hardware affected around is very welcome.
>
> Are you able to test the panel driver ?

Even worse: at the moment I cannot test any of the drivers (and more
have been added over time). The 3 of them I could test are very
old/obsolete and I will be dropping them, so my role here is basically
"abstract" :-)

If there is anyone that can actually test most of the drivers in
auxdisplay and wants to help maintaining, it would be great, in fact.

> Thank you for your prompt feedback!

You're welcome!

Cheers,
Miguel
