Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6002C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 22:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A22020842
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 22:47:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aKhzrC/S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405245AbfIFWrh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 18:47:37 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34860 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388713AbfIFWre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 18:47:34 -0400
Received: by mail-pg1-f194.google.com with SMTP id n4so4326680pgv.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2019 15:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eh4BYWlMKBWYksN67VKDMRhVawrCIBtabo9ZsX+5Iy0=;
        b=aKhzrC/S3brQTWp4YtDWI5vu5nP4sIGBfd2Qy4mSoPmDn4barETg1DJ1hFgLN1IO/r
         m0kQm7w2FaG2uW24h6MfjCEKfty++Zoo4LLEiOPv6t6azLPl+0Lwn8W4ZgJQBhKRe+d8
         Oy4+hx20U0/0USNaYVfmRNN8q6qbyLJPY3QApO3suvQnTlIltjXzkgd4xVe+aHUZpO4V
         kJEKNMo6GxSaLc1Q56AE4mxsyRNwo1X0ycmH4bOOdpbxnCDET/0in8PIlzx0EvlVW8Ud
         BcGPCs1qA3P5GPm0h9k9it6/X3OFJUIENzGHl4sSdmNRUJ8IpJxPZ2yFd2c5mDZDkLSm
         h4ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eh4BYWlMKBWYksN67VKDMRhVawrCIBtabo9ZsX+5Iy0=;
        b=YijBxTBfvP4G0u3iZurXlCvCspL9keIffI6OysZOQ9F+6/o1eaLRRWOvY8bxeKkCiS
         mREiBKpkHk6TtpZ6HRaY172ANfYJoazF1lTdNwjrarxu+ZqbNQo5++Vg4O4z6qUEftq/
         JRfSyaBiLkBo9h9jvhUgsjDNfwiaP5MUg6/WJpFGdaYONbiXMpkcT21SHNpPc9Iwciu8
         PNXlEQER8/FlGNxb8XKu7Ki7THECqc1QnVKaSeUGjbpcGQ9ISAhK9ACnIT5x7zzUrOlP
         8CHwZMoxY/zq5i1rXN8jyWsx+vpGf+76rB28+8J0pxkPWtY8B6t6+ndPs1YJTc3gTR+V
         nX8A==
X-Gm-Message-State: APjAAAUKcjYb1qgHDlSFpxldAumwL9LvXE3FmfjVZLdDrnXI681pMNaI
        b+ae3Ab0gDN2QEsHy/Y4r37VvgCuKuGchWL7SvTm6A==
X-Google-Smtp-Source: APXvYqwdjdOUtRpbeCXdmOlr2UuwLqFAltRgTvFfFozJRMHdSWg43vl7tVZTanKPZPSAz6sw2iyMF8gn9Qxmsd60juA=
X-Received: by 2002:a17:90a:154f:: with SMTP id y15mr9703535pja.73.1567810053188;
 Fri, 06 Sep 2019 15:47:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190904181740.GA19688@gmail.com> <CAHk-=wi2VOPoweqnDhxXKJ9fcLQzkV1oEDjteV=z-C7KXrpomg@mail.gmail.com>
 <CANiq72mXLbaefVBqZzz1vSREi0=HiBUgR1KU3iRjOCum7rvfrw@mail.gmail.com>
 <CAHk-=wiNksYaQ5zRFgTdY4TMHkxRi3aOcTC2zMMS6+aVSx+yeQ@mail.gmail.com> <CANiq72kyk6uzxS3LRvcOs9zgYYh7V7V2yPtAFkDwpHmyYcsz_Q@mail.gmail.com>
In-Reply-To: <CANiq72kyk6uzxS3LRvcOs9zgYYh7V7V2yPtAFkDwpHmyYcsz_Q@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 6 Sep 2019 15:47:21 -0700
Message-ID: <CAKwvOdkodVFxUr_Xc-qeUHnpxEmofENDhNdvCuiRzcGXQ54QkQ@mail.gmail.com>
Subject: Re: [GIT PULL] compiler-attributes for v5.3-rc8
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Paul Burton <paul.burton@mips.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 6, 2019 at 1:11 PM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Thu, Sep 5, 2019 at 10:53 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > That's probably what we should have done originally, avoiding all the
> > issues with "what if we have multi-part strings" etc.
> >
> > But it's not what we did, probably because it looked slightly simpler
> > to do the stringification in the macro for the usual case.
> >
> > So now we have (according to a quick grep) eight users that have a
> > constant string, and about one hundred users that use the unquoted
> > section name and expect the automatic stringification. I say "about",
> > because I didn't check if any of them might be doing tricks, I really
> > just did a stupid grep.
> >
> > And we have that _one_ insane KENTRY thing that was apparently never
> > actually used.
> >
> > So I think the minimal fix is to just accept that it's what it is,
> > remove the unnecessary quotes from the 8 existing users, and _if_
> > somebody wants to build the string  by hand (like the KENTRY code
> > did), then just use "__attribute__((section(x)))" for that.
> >
> > But yeah, we could just remove the stringification and make the users do it.
> >
> > But for the current late rc (and presumably -stable?), I definitely
> > want the absolute minimal thing that fixes the oops.
>
> Then I will send a PR with that patch only (Nick, do you know if the
> entire patch is needed or we could further reduce it?).

Sedat reported (https://github.com/ClangBuiltLinux/linux/issues/619#issuecomment-520042577,
https://github.com/ClangBuiltLinux/linux/issues/619#issuecomment-520065525)
that only the bottom two hunks of that patch
(https://github.com/ojeda/linux/commit/c97e82b97f4bba00304905fe7965f923abd2d755)

>
> Then for 5.4 I will prepare a new series moving to non-stringification
> (unless Nick wants to do it himself).

Technically, it's not a regression, just something that would be nice
to have sooner rather than later.  The whole series can wait for 5.4,
IMO.  I'll look into updating the patchset next week.
-- 
Thanks,
~Nick Desaulniers
