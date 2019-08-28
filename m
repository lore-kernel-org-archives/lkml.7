Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48E4BC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 22:07:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14A8F2189D
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 22:07:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iH04IjDN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbfH1WHP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 18:07:15 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33483 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726907AbfH1WHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 18:07:14 -0400
Received: by mail-pl1-f193.google.com with SMTP id go14so599743plb.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 15:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mt34mNKIrP8Htb1nVD5HqQKjSaQZQHcNYu8vWAeak1k=;
        b=iH04IjDNGifHI7tT+hqPSbNJdrbhPMnWjA/w201hZzZdVVX/cuEXXNipMbU3zgzimK
         Rr5MdpTySQRBJ/50mVA8WJQtJwIvYOvTLmCFYpMM5Xkl5xgpxwYV+k1WEoAZPv1tF9ea
         W3XorqI6mJKqtfb3Yyr2rZuXFfy+EakKbjMzpqXPW9PdnSctAXvVU70zZygvKmli/uH2
         J2sVWzdC+StG1KOXlEWjjicrCgkgVnE3RcpITVkUwk67za3DbaMgol3Voqrv4n83Mw7E
         tQPmRKc1Qg+3qzEsFlCUyqK5yB4RrTirlGpbHpanixhj3zQMFJ5vGvCAaXU0kmDhSnw6
         nBGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mt34mNKIrP8Htb1nVD5HqQKjSaQZQHcNYu8vWAeak1k=;
        b=GeBrbJomDykDGE6K1NqnjeLGygECK6mqz/b8XdmqYzMuB3drfb7OTwT2o3pCYFI4ZA
         SxUjsY79ETIq/3QMm37QoyqX06W5W609PCka5iXuDc+hrhex9QaJk4BGOantyfHNLjRC
         s5gO0DBWIiy5FhG2Qak6K1cGEDfmnYzFMkDprJr+VvVMR+X1dn1lVMLiFAPj//TRJNMT
         MjAh8JLaR+sLeP8sbUw6LIFkD8SVyf54E3pxlF3foTp295NK9hPmPewFNG/ae9fvYA3i
         suwmLYAcdTQfhBAQ0kIKag9pBSUan+jCWcvW0iSc17BXgCAInNDVNQJs3JUYFydMZFt6
         OsYg==
X-Gm-Message-State: APjAAAW7Y3D1NamxN8/cSu/RpyhtxY35QYQLOsNFH9OCbTmTFc7iZUpV
        dio/yUZV64jnne3f5WH0BPfBhCM3ktxWSQdNYDYOXA==
X-Google-Smtp-Source: APXvYqwKJcTORr5goZNG/ZGtgIKGQ4s6FfLBg86jGM0y+Ml3Gw2WP/m1IL78gAQkHrFGa9CZYJrL1f7a4Z5llqj/Wik=
X-Received: by 2002:a17:902:8484:: with SMTP id c4mr6500095plo.223.1567030033405;
 Wed, 28 Aug 2019 15:07:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190828194226.GA29967@swahl-linux> <CAKwvOdn0=7YabPD-5EUwkSoJgWjdYHY2mirM2LUz0TxZTBOf_Q@mail.gmail.com>
In-Reply-To: <CAKwvOdn0=7YabPD-5EUwkSoJgWjdYHY2mirM2LUz0TxZTBOf_Q@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 28 Aug 2019 15:07:02 -0700
Message-ID: <CAKwvOdm3T1BBeDoXp=YftFKdWHkbdabCwzqx+O0HHZrO+4omag@mail.gmail.com>
Subject: Re: Purgatory compile flag changes apparently causing Kexec
 relocation overflows
To:     Steve Wahl <steve.wahl@hpe.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vaibhav Rustagi <vaibhavrustagi@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, russ.anderson@hpe.com,
        dimitri.sivanich@hpe.com, mike.travis@hpe.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2019 at 2:51 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Wed, Aug 28, 2019 at 12:42 PM Steve Wahl <steve.wahl@hpe.com> wrote:
> >
> > Please CC me on responses to this.
> >
> > I normally would do more diligence on this, but the timing is such
> > that I think it's better to get this out sooner.
> >
> > With the tip of the tree from https://github.com/torvalds/linux.git (a
> > few days old, most recent commit fetched is
> > bb7ba8069de933d69cb45dd0a5806b61033796a3), I'm seeing "kexec: Overflow
> > in relocation type 11 value 0x11fffd000" when I try to load a crash
> > kernel with kdump. This seems to be caused by commit
> > 059f801a937d164e03b33c1848bb3dca67c0b04, which changed the compiler

is this the correct SHA from mainline?  I assume you meant
commit b059f801a937 ("x86/purgatory: Use CFLAGS_REMOVE rather than
reset KBUILD_CFLAGS")

> > flags used to compile purgatory.ro, apparently creating 32 bit
> > relocations for things that aren't necessarily reachable with a 32 bit
> > reference.  My guess is this only occurs when the crash kernel is
> > located outside 32-bit addressable physical space.
> >
> > I have so far verified that the problem occurs with that commit, and
> > does not occur with the previous commit.  For this commit, Thomas
> > Gleixner mentioned a few of the changed flags should have been looked
> > at twice.  I have not gone so far as to figure out which flags cause
> > the problem.
> >
> > The hardware in use is a HPE Superdome Flex with 48 * 32GiB dimms
> > (total 1536 GiB).
> >
> > One example of the exact error messages seen:
> >
> > 019-08-28T13:42:39.308110-05:00 uv4test14 kernel: [   45.137743] kexec: Overflow in relocation type 11 value 0x17f7affd000
> > 2019-08-28T13:42:39.308123-05:00 uv4test14 kernel: [   45.137749] kexec-bzImage64: Loading purgatory failed
>
> Thanks for the report and sorry for the breakage.  Can you please send
> me more information for how to precisely reproduce the issue?  I'm
> happy to look into fixing it.
>
> Let me go dig up the different listed flags.  Steve, it may be fastest
> for you to test re-adding them in your setup to see which one is
> important.

https://lkml.org/lkml/2019/7/26/198 was the list.  The "ratpoutine"
flags were added in the final version of the patch that landed.  It's
not immediately clear to me which of those 4 changed flags would
result in the error that you're observing, but if you could test them
quickly to see which restores working behavior, we could triple check
it on our end and submit it.

>
> Tglx, if you want to revert the above patches, I'm ok with that.  It's
> important that we fix the issue eventually that my patches were meant
> to address, but precisely *when* it's solved isn't critical; our
> kernels can carry out of tree patches for now until the issue is
> completely resolved worst case.

-- 
Thanks,
~Nick Desaulniers
