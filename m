Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49F7EC3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:11:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FDB2233FC
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:11:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IRjN9WlJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731791AbfHVRLk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 13:11:40 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:33024 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390913AbfHVRLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 13:11:33 -0400
Received: by mail-qk1-f195.google.com with SMTP id w18so5830910qki.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 10:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gb0fma4SYZkehZAw45Gi4L0bDfo73oujKKHVTeGoQIs=;
        b=IRjN9WlJI2NizOqoywAu1t0dasUD2HvfgwBoOa9osPpEM5aXa+yGTdPiN1TiJrsWvG
         iGjVHWvYW4UX16sIaTg+QfTcU+Oxhzhu02LywcI0apxLSb/bD5M1LZTIeFjzJMXcOwgK
         dj7JFd0ME9QR+iHMqXDTZSGYSBjOVWgr70YI0CNC1cWiUeIlaKextW4Y/iu34MlJrPjr
         XdjfXiZI0uu3CLQkaowXHBF/i4hZdcwaTXJt8OrNJC2Fziu5qs8SrWDAzAjhzuq5XaxE
         xpot9/k1xGzYE0Kjkw6JFcnJ84oyZeq2BwLFoxI2SYVYFfubezEbJKTgvUSfoxkWcuC+
         maZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gb0fma4SYZkehZAw45Gi4L0bDfo73oujKKHVTeGoQIs=;
        b=f6ZF/shjO2/UaFTRgusFNClGrD/xMdKqyoByfrwlTG1vBa+ID2H8i86BvlxI7FiWuo
         bbP2meX4DOwngEi/4DgQ80ZkFtONiNSF+cOJypCgJEfHc3SbWhe3krJF/d3F4KIpdGw8
         edzCtdDJIotaf8gj+L3eG6yDelPK6iNqIVLQAxCYpSj3VOtauB6aTybIVvKgEQ53ymjW
         f7++ktx7Z3cD3RnpgDQcSIjsBDHL+6p/2ay0VFGBpM62MYJA4lt+C4dQQcKti66VuWa5
         IzL695A3Bj4BBcCH0Ov+CSdqwTRot3oD5udlveskj7RjXDRIKX/50RU2v9gcjFVvtCs4
         NThQ==
X-Gm-Message-State: APjAAAVWoxHC5bwXEbh0p7hX9LJlg1jr/sZyhqfrf2U9ZxxCdZcg8U4w
        vt77ZenDuqtN4o7mY/kh6/3eAlWRta3vVcmAgzasrg==
X-Google-Smtp-Source: APXvYqxPEdStgyeuCloUwnL5iefdzeiMR6CC0TYoeSyeF/2xzpm7U2SOTQQPmVIJS4sKZHVEsEOYn5XL1N6tDYT1pig=
X-Received: by 2002:a37:c40d:: with SMTP id d13mr21876qki.8.1566493892003;
 Thu, 22 Aug 2019 10:11:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190820222403.GB8120@kroah.com> <201908220959.x7M9xP8r011133@www262.sakura.ne.jp>
 <20190822133538.GA16793@kroah.com> <e8d3ce30-8c61-048e-2606-f8a4e8f08d87@i-love.sakura.ne.jp>
 <20190822164249.GA12551@kroah.com>
In-Reply-To: <20190822164249.GA12551@kroah.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 22 Aug 2019 10:11:20 -0700
Message-ID: <CACT4Y+Z0yCAwie83Oqd7XBNgQjWtEkuEg5WJCd6rW-ZMWqosxg@mail.gmail.com>
Subject: Re: [PATCH] /dev/mem: Bail out upon SIGKILL when reading memory.
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Arnd Bergmann <arnd@arndb.de>,
        LKML <linux-kernel@vger.kernel.org>,
        syzbot <syzbot+8ab2d0f39fb79fe6ca40@syzkaller.appspotmail.com>,
        Eric Biggers <ebiggers@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 22, 2019 at 9:42 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Aug 22, 2019 at 11:00:59PM +0900, Tetsuo Handa wrote:
> > On 2019/08/22 22:35, Greg Kroah-Hartman wrote:
> > > On Thu, Aug 22, 2019 at 06:59:25PM +0900, Tetsuo Handa wrote:
> > >> Tetsuo Handa wrote:
> > >>> Greg Kroah-Hartman wrote:
> > >>>> Oh, nice!  This shouldn't break anything that is assuming that the read
> > >>>> will complete before a signal is delivered, right?
> > >>>>
> > >>>> I know userspace handling of "short" reads is almost always not there...
> > >>>
> > >>> Since this check will give up upon SIGKILL, userspace won't be able to see
> > >>> the return value from read(). Thus, returning 0 upon SIGKILL will be safe. ;-)
> > >>> Maybe we also want to add cond_resched()...
> > >>>
> > >>> By the way, do we want similar check on write_mem() side?
> > >>> If aborting "write to /dev/mem" upon SIGKILL (results in partial write) is
> > >>> unexpected, we might want to ignore SIGKILL for write_mem() case.
> > >>> But copying data from killed threads (especially when killed by OOM killer
> > >>> and userspace memory is reclaimed by OOM reaper before write_mem() returns)
> > >>> would be after all unexpected. Then, it might be preferable to check SIGKILL
> > >>> on write_mem() side...
> > >>>
> > >>
> > >> Ha, ha. syzbot reported the same problem using write_mem().
> > >> https://syzkaller.appspot.com/text?tag=CrashLog&x=1018055a600000
> > >> We want fatal_signal_pending() check on both sides.
> > >
> > > Ok, want to send a patch for that?
> >
> > Yes. But before sending a patch, I'm trying to dump values using debug printk().
> >
> > >
> > > And does anything use /dev/mem anymore?  I think X stopped using it a
> > > long time ago.
> > >
> > >> By the way, write_mem() worries me whether there is possibility of replacing
> > >> kernel code/data with user-defined memory data supplied from userspace.
> > >> If write_mem() were by chance replaced with code that does
> > >>
> > >>    while (1);
> > >>
> > >> we won't be able to return from write_mem() even if we added fatal_signal_pending() check.
> > >> Ditto for replacing local variables with unexpected values...
> > >
> > > I'm sorry, I don't really understand what you mean here, but I haven't
> > > had my morning coffee...  Any hints as to an example?
> >
> > Probably similar idea: "lockdown: Restrict /dev/{mem,kmem,port} when the kernel is locked down"
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/drivers/char/mem.c?h=next-20190822&id=9b9d8dda1ed72e9bd560ab0ca93d322a9440510e
> >
> > Then, syzbot might want to blacklist writing to /dev/mem .
>
> syzbot should probably blacklist that now, you can do a lot of bad
> things writing to that device node :(

Agree. It wasn't supposed to reach it, but it figured out how to mount
devfs and then open "./mem"  bypassing all checks. Fortunately there
is a config to disable /dev/mem, so we are going to turn it off.
