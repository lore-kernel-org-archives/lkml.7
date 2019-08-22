Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A954C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 23:59:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BA93233FC
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 23:59:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p41cSKCy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727714AbfHVX7P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 19:59:15 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:37854 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727377AbfHVX7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 19:59:15 -0400
Received: by mail-qt1-f196.google.com with SMTP id y26so9684607qto.4
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 16:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iUg8DAsreulZmGLbmztqz+/0OCOUUFf7Xht4SjdCDLI=;
        b=p41cSKCyM0b/vtgWgp6VIKEG49CjOCuQuuAlDGjOLpqNPwprSzKH6kA48t35Y/I1DM
         SHYjiQmySnE6hxC9pqL5867MNtI8G23tju3YELtCHhdusU5fux11nWkk/iRejrLGiYgK
         cRg3XW6lgCdK5kECurbn/dTBHYlFrItOMKk/wimVThnh6MIXhhk5K0w01Co24KVop0li
         yAOosQ6wucGxvgPN1Q264KcUCjhepi6zUNNW5HrwLe3R4f35GKNP3DTI8ZE0PL/4w0qd
         wA8NZCnAxIyVcO8DipeCAl6assq5J/xKHyxpaq3XyuV2hIdn14WCeDPKjCfb6Ep7aeNh
         MP6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iUg8DAsreulZmGLbmztqz+/0OCOUUFf7Xht4SjdCDLI=;
        b=dqlZ+HjYwVWxEn0RoBtwwLFFq72bwvx7ZYfD3oI6l7nZ9pplViia/At99SgOewcQ+S
         jr+i0RytWxlthXaATkFZeWAV6dNx4fbIRnni3Nw1cRrJNwGk473lK6OFYa1+PcXH95KA
         lR0IBnKTBsQsalND4r3nLGOYTL15WpLpjS5yKdd+N4+OE9tTxhpQ79aXLNaxW80j7bZz
         r9TxU1g5p65fzmPmv3joxtYlq5GMmrr1nPblNJEqRoL2S188xK8kZyAWbwuqaTsCL0d/
         bvThrzakeLyTdS35O0G3dkB+YdHoLhicOkH5kl8Pb55EPLxQdgPu9cl3VDUbd/ZVvcQX
         Ggyg==
X-Gm-Message-State: APjAAAXDnqOIZtctWTde9t9lobs1/6UurzwveiNQWQ8vZUHJUgeeQInx
        yr6n6/wsVaClIIlajshWsh0KjrWTXKz6IBuUO9b5BQ==
X-Google-Smtp-Source: APXvYqxMpJz6gRkQfJCR7D8SV3e/USf/0jIT7w/h3y123HfvF2l5zCzxp7XJIwbN2aJFu1qT4H8N6RxrI1/6L/EH5jo=
X-Received: by 2002:ac8:444b:: with SMTP id m11mr2298581qtn.257.1566518353399;
 Thu, 22 Aug 2019 16:59:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190820222403.GB8120@kroah.com> <201908220959.x7M9xP8r011133@www262.sakura.ne.jp>
 <20190822133538.GA16793@kroah.com> <e8d3ce30-8c61-048e-2606-f8a4e8f08d87@i-love.sakura.ne.jp>
 <20190822164249.GA12551@kroah.com> <CACT4Y+Z0yCAwie83Oqd7XBNgQjWtEkuEg5WJCd6rW-ZMWqosxg@mail.gmail.com>
 <433f12f7-cc17-c88b-4f26-7f45eee42884@i-love.sakura.ne.jp>
In-Reply-To: <433f12f7-cc17-c88b-4f26-7f45eee42884@i-love.sakura.ne.jp>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 22 Aug 2019 16:59:02 -0700
Message-ID: <CACT4Y+YCNR5_M29juV9-2UDj55BJVuYbj7bzbjtMDM_odut1Pg@mail.gmail.com>
Subject: Re: [PATCH] /dev/mem: Bail out upon SIGKILL when reading memory.
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        LKML <linux-kernel@vger.kernel.org>,
        syzbot <syzbot+8ab2d0f39fb79fe6ca40@syzkaller.appspotmail.com>,
        Eric Biggers <ebiggers@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 22, 2019 at 2:17 PM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> On 2019/08/23 2:11, Dmitry Vyukov wrote:
> > On Thu, Aug 22, 2019 at 9:42 AM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> >>>>> By the way, write_mem() worries me whether there is possibility of replacing
> >>>>> kernel code/data with user-defined memory data supplied from userspace.
> >>>>> If write_mem() were by chance replaced with code that does
> >>>>>
> >>>>>    while (1);
> >>>>>
> >>>>> we won't be able to return from write_mem() even if we added fatal_signal_pending() check.
> >>>>> Ditto for replacing local variables with unexpected values...
> >>>>
> >>>> I'm sorry, I don't really understand what you mean here, but I haven't
> >>>> had my morning coffee...  Any hints as to an example?
> >>>
> >>> Probably similar idea: "lockdown: Restrict /dev/{mem,kmem,port} when the kernel is locked down"
> >>>
> >>> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/drivers/char/mem.c?h=next-20190822&id=9b9d8dda1ed72e9bd560ab0ca93d322a9440510e
> >>>
> >>> Then, syzbot might want to blacklist writing to /dev/mem .
> >>
> >> syzbot should probably blacklist that now, you can do a lot of bad
> >> things writing to that device node :(
> >
> > Agree. It wasn't supposed to reach it, but it figured out how to mount
> > devfs and then open "./mem"  bypassing all checks. Fortunately there
> > is a config to disable /dev/mem, so we are going to turn it off.
> >
>
> Can't we introduce a kernel config which selectively blocks specific actions?
> If we don't need to worry about bypassing blacklist checks, we will be able to
> enable syz_execute_func() again.


We can consider this, but we need some set of good use cases first.
For /dev/{mem,kmem} we disable them with config, right? That looks
like the right thing to do because we don't want fuzzer to do anything
with these files anyway. So this won't be a good use case for
CONFIG_KERNEL_BUILT_FOR_FUZZ_TESTING.
Fuzzer can also reliably filter out based on syscall numbers of
top-level argument values. The potential problem is with (1)
pointers/indirect memory and (2) where blacklisting some top-level
argument values would backlist too much (e.g. prohibiting 3rd ioctl
argument 0 entirely).


> ----------
>                         ptr = xlate_dev_mem_ptr(p);
>                         if (!ptr) {
>                                 if (written)
>                                         break;
>                                 return -EFAULT;
>                         }
> +#ifndef CONFIG_KERNEL_BUILT_FOR_FUZZ_TESTING
>                         copied = copy_from_user(ptr, buf, sz);
> +#else
> +                       copied = 0;
> +#endif
>                         unxlate_dev_mem_ptr(p, ptr);
> ----------
