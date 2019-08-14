Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC186C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 11:10:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 938EA2083B
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 11:10:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fireburn-co-uk.20150623.gappssmtp.com header.i=@fireburn-co-uk.20150623.gappssmtp.com header.b="f+18YRJ1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727411AbfHNLKL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 07:10:11 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39653 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbfHNLKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 07:10:10 -0400
Received: by mail-qt1-f193.google.com with SMTP id l9so109567549qtu.6
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 04:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fireburn-co-uk.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B32Wax03scMRHJx0YqLvq2dD5tNvHyjSP3ubTYlL/vY=;
        b=f+18YRJ13t1HJZOidK7xGJ5SH3ZrbTRTES34LXX4AHECjyX/tWeY9N4SVQaeJ7voHx
         yz6TZX5Dg7SkR6VHxvwWlcYzm5xQ8ehRPibMShT7mWoieAhVNZl0/bi+IP2KY4yxR9Cr
         R0Q0ayaXM058mE/57yVsb5ENbQp9POrgHajgvfDULm0/oA8dDHOkwhMTjv37oz5vsjbh
         Ydp+DXxyvpB9CjS1MBbKuwP2HKwc7ohKfoBoSq90Ka0mHFsV2N9VH8LfnS3Va0g5tz1k
         pbWZd0LzYWykghmgpyBcUfVhI9Uyx15DqaKtTIDILl5OVykZhk3mqDY9OlKexbMHVKbU
         pbLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B32Wax03scMRHJx0YqLvq2dD5tNvHyjSP3ubTYlL/vY=;
        b=nLAPo4azxRer4YzYggdFVgl0lRTkfEYvmodgI7i2s/TtLCYT+c0ZjSXb9gF/BEKwMf
         XddokySg7z3XK5LzGwF5uB3Gqvx1+UZsyVHZK7fLCMHyaaKiATnsh8scUaPesn18eFVd
         0sMXoT0sgJ0aGD1cl73XZfulubTp+AYkUfCYuWtgTqrmVaSfuoKfe1jIN011xRR1SFhj
         wnTHpIweYW8utjJHQ56JEP/d2VF8Bm6QOS2vjnTUAnb2nHqW557MctGX6uyLlvNGg3DX
         +rBsyA3QPK9TKWoLvMVhBjgQCF4LtAh38/kw8i3H3SEHxMn3I/yaAhUYA/NEY7J20iEa
         tpRg==
X-Gm-Message-State: APjAAAVwfYlGSQ0iSIJEyo2r1YmGDna3EIU85ZPvY0UrpSZxWc8ny9zQ
        u0HkbSQkP8FETuaifnS2SGIg3MxHon1jT58GEqqX+A==
X-Google-Smtp-Source: APXvYqwT6HhmEVC4IelNYd3H7GRJDkOi+S6Co7r3sKPD1xnVvtfkiIPDLrrKDM4KSoHMb3QZDa91tGK7EhPtwNLU36E=
X-Received: by 2002:a0c:f701:: with SMTP id w1mr2114277qvn.195.1565781007230;
 Wed, 14 Aug 2019 04:10:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190723130513.GA25290@kroah.com> <alpine.DEB.2.21.1907231519430.1659@nanos.tec.linutronix.de>
 <20190723134454.GA7260@kroah.com> <20190724153416.GA27117@kroah.com>
 <alpine.DEB.2.21.1907241746010.1791@nanos.tec.linutronix.de>
 <20190724155735.GC5571@kroah.com> <alpine.DEB.2.21.1907241801320.1791@nanos.tec.linutronix.de>
 <20190724161634.GB10454@kroah.com> <alpine.DEB.2.21.1907242153320.1791@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1907242208590.1791@nanos.tec.linutronix.de> <20190725062447.GB5647@kroah.com>
In-Reply-To: <20190725062447.GB5647@kroah.com>
From:   Mike Lothian <mike@fireburn.co.uk>
Date:   Wed, 14 Aug 2019 12:09:56 +0100
Message-ID: <CAHbf0-FenMwa6uMqpD_fJZLU3YKviOcMe_pBh8oWmUPoUYk_LA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] x86/mm: Identify the end of the kernel area to be reserved
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "H.J. Lu" <hjl.tools@gmail.com>,
        Tom Lendacky <thomas.lendacky@amd.com>, bhe@redhat.com,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, lijiang@redhat.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Jul 2019 at 07:59, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Wed, Jul 24, 2019 at 10:20:34PM +0200, Thomas Gleixner wrote:
> > On Wed, 24 Jul 2019, Thomas Gleixner wrote:
> >
> > > On Wed, 24 Jul 2019, Greg KH wrote:
> > > > On Wed, Jul 24, 2019 at 06:03:41PM +0200, Thomas Gleixner wrote:
> > > > > > Gotta love old tool-chains :(
> > > > >
> > > > > Oh yes. /me does archaeology to find a VM with old stuff
> > > >
> > > > I can provide a binary if you can't find anything.
> > >
> > > Found GNU ld (GNU Binutils for Debian) 2.25 and after fiddling with
> > > LD_PRELOAD it builds without failure.
> > >
> > > ld.gold from that binutils version dies with a segfault on various files ...
> >
> > Then tried that old ld.bfd with GCC8 and that causes ld.bfd to segfault on
> > every other file.
> >
> > Copied that config to the clang build directory and it causes the same
> > explosions with ld.bfd.
> >
> > What a time waste...
> >
> >
> >
>
> Ugh, sorry about this.  I can't seem to track it down either, and at
> this point am just going to punt and let the Android build people try to
> figure it out as it is their custom build system that is failing at the
> moment, only for x86, and if this single patch is reverted, it starts
> working again.
>
> voodo...
>
> thanks,
>
> greg k-h

As it's related. I've raised
https://bugzilla.kernel.org/show_bug.cgi?id=204495 about the
relocatition I'm seeing since switching back to ld.bfd - is this safe
to ignore? I'm guessing this is why gold isn't working as it can't do
them

Cheers

Mike
