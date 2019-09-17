Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A32EBC4CECE
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 18:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 841A321881
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 18:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568743307;
	bh=wsark4NHqc2reOG/MB/DBWvgFoQMudaWwNtvFuMNGlk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=fjSORSYWflx6DBQ3Eyn+GhC2u8+6JT64yvwUPPKOPRFFw7cqx7dzFfyXyYyr6OqRR
	 EswlhpE71SE87tbTaKjwX5gft5oZLx7nidLnfqTspfp/yHYV6Wf2I6jwqpzfURrn2Q
	 ZB9asAWOwV8tXGiKeKzM75xz2PMOjzPY7ZZW2kCg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728208AbfIQSBq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 14:01:46 -0400
Received: from mail-lf1-f44.google.com ([209.85.167.44]:35882 "EHLO
        mail-lf1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbfIQSBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 14:01:44 -0400
Received: by mail-lf1-f44.google.com with SMTP id x80so3632485lff.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 11:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/Er0gbtf1RnNHz6mdrzuapZEA6kkymLwTpdFJ1HqQU4=;
        b=HvP+vQgteoXL3yfoydiM6Z3RWF/sPvBd8S2iIsbEVja4KJe9Fsest2Y8FdeK6H1KRb
         qHlLfhbs1hWk+4zLWO+FtJSPwCPMIQ/Fxm7zGy+dSaUlkD+x/SIwFCXNAw6nN/tHknBN
         iPA8AbPat0lLjP6IRnGfhXLxkVO5dOqs+W19c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/Er0gbtf1RnNHz6mdrzuapZEA6kkymLwTpdFJ1HqQU4=;
        b=tp+LI2ZS3sLpNMET+skTIWxUTD3oOeqtasfw9AiQQo6iZACI76A+51PWElep8YRD1d
         8nrcGGaNP2VMp+ULKKTN8NR33hAdUlPdULxyl9eLYpOvUHcB7WL3fP9KN3VIOBwSjPwF
         SYewo1sqCMRuf9+XRc7KzHbCjaVc+0IXQzM4F6bBacIWsQNQRKLdcV2c8qPWjoraZFWw
         IPJOIbvjFb0vWwmtBh6Wy03h3RNU/bGQIfEhlFf4CYZvfO3PnZNew0oFVri84YtlAywU
         2i852efqRKSHtu1dVN2Ih8HYDwCmYadTR46ONCrnVPzO5A47mXD/QfYKBoZ0sQwbhgXj
         B+iQ==
X-Gm-Message-State: APjAAAWc0UiV2v9AHKVoMp+a5j1oHH8lHcBiahzzUsJJr1ctMN8puFgr
        TMVKs5Oi0Txl0m7VQKMCj7Se8HSiMZo=
X-Google-Smtp-Source: APXvYqynJSkyh2bTYI2Yl2nnTttVXCbHF57f/hbF/Kpmb6s+jKxBtw2yDOSF5G/3TEodcRENU6Pu2w==
X-Received: by 2002:ac2:5633:: with SMTP id b19mr2768536lff.103.1568743300763;
        Tue, 17 Sep 2019 11:01:40 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id 126sm651564lfh.45.2019.09.17.11.01.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Sep 2019 11:01:40 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id c195so3604223lfg.9
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 11:01:39 -0700 (PDT)
X-Received: by 2002:ac2:5a4c:: with SMTP id r12mr2723201lfn.52.1568743299497;
 Tue, 17 Sep 2019 11:01:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wgs65hez6ctK7J2k46BdQzvKU5avExPOTTJsZu6iqA-ow@mail.gmail.com>
 <C4F7DC65-50B9-4D70-8E9B-0A6FF5C1070A@srcf.ucam.org> <20190917052438.GA26923@1wt.eu>
 <2508489.jOnZlRuxVn@merkaba> <20190917121156.GC6762@mit.edu>
 <20190917123015.sirlkvy335crozmj@debian-stretch-darwi.lab.linutronix.de>
 <20190917160844.GC31567@gardel-login> <CAHk-=wgsWTCZ=LPHi7BXzFCoWbyp3Ey-zZbaKzWixO91Ryr9=A@mail.gmail.com>
 <20190917174219.GD31798@gardel-login>
In-Reply-To: <20190917174219.GD31798@gardel-login>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 17 Sep 2019 11:01:23 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjABG3+daJFr4w3a+OWuraVcZpi=SMUg=pnZ+7+O0E2FA@mail.gmail.com>
Message-ID: <CAHk-=wjABG3+daJFr4w3a+OWuraVcZpi=SMUg=pnZ+7+O0E2FA@mail.gmail.com>
Subject: Re: Linux 5.3-rc8
To:     Lennart Poettering <mzxreary@0pointer.de>
Cc:     "Ahmed S. Darwish" <darwish.07@gmail.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Willy Tarreau <w@1wt.eu>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Vito Caputo <vcaputo@pengaru.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        zhangjs <zachary@baishancloud.com>, linux-ext4@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 17, 2019 at 10:42 AM Lennart Poettering
<mzxreary@0pointer.de> wrote:
>
> So I think people nowadays prefer getrandom() over /dev/urandom
> primarily because of the noisy logging the kernel does when you use
> the latter on a non-initialized pool. If that'd be dropped then I am
> pretty sure that the porting from /dev/urandom to getrandom() you see
> in various projects (such as gdm/x11) would probably not take place.

Sad. So people were actually are perfectly happy with urandom, but you
don't want the warning, so you use getrandom() and as a result your
boot blocks.

What a sad sad reason for a bug.

Btw, having a "I really don't care deeply about some long-term secure
key" flag would soilve that problem too. We'd happily and silently
give you data.

The only reason we _do_ that silly printout for /dev/urandom is
exactly because /dev/random wasn't useful even for the people who
_really_ wanted secure randomness, so they started using /dev/urandom
despite the fact that it didn't necessarily have any entropy at all.

So this all actually fundamentally goes back to the absolutely horrid
and entirely wrong semantics of /dev/random that made it entirely
useless for the only thing it was actually designed for.

This is also an example of how hard-line "security" people that don't
see the shades of gray in between black and white are very much part
of the problem. If you have some unreasonable hard requirements,
you're going to do the wrong thing in the end.

At some point even security people need to realize that reality isn't
black-and-white. It's not also keeping us from making any sane
progress, I feel, because of that bogus "entropy is sacred", despite
the fact that our entropy calculations are actually just random
made-up stuff (but "hey, reasonable") to begin with and aren't really
black-and-white themselves.

> In fact, speaking for systemd: the noisy logging in the kernel is the
> primary (actually: only) reason that we prefer using RDRAND (if
> available) over /dev/urandom if we need "medium quality" random
> numbers, for example to seed hash tables and such. If the log message
> wasn't there we wouldn't be tempted to bother with RDRAND and would
> just use /dev/urandom like we used to for that.

That's also very sad. If we have rdrand, we'll actually mix it into
/dev/urandom regardless, so it's again just the whole "people started
using urandom for keys because random was broken" that is the cause of
this all.

I really really detest the whole inflexible "security" mindset.

> We can make boot hang in "sane", discoverable way.

That is certainly a huge advantage, yes. Right now I suspect that what
has happened is that this has probably been going on as some low-level
background noise for a while, and people either figured it out and
switched away from gdm (example: Christoph), or more likely some
unexplained boot problems that people just didn't chase down. So it
took basically a random happenstance to make this a kernel issue.

But "easily discoverable" would be good.

> The reason why I think this should also be logged by the kernel since
> people use netconsole and pstore and whatnot and they should see this
> there. If systemd with its infrastructure brings this to screen via
> plymouth then this wouldn't help people who debug much more low-level.

Well, I certainly agree with a kernel message (including a big
WARN_ON_ONCE), but you also point out that the last time we added
helpful messages to let people know, it had some seriously unintended
consequences ;)

              Linus
