Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59317C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 16:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E80521848
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 16:47:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A7XzNgI0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391509AbfHWQrf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 12:47:35 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:46494 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388580AbfHWQrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 12:47:35 -0400
Received: by mail-qk1-f193.google.com with SMTP id p13so8690628qkg.13
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 09:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dh4aupUSPEjaFwU/NhNXf74efZLkJgrHRqRRjH9BeWs=;
        b=A7XzNgI0KJT1ALbnvZWNpvrTQu/KHNrBEO0JR/Jb9GSgs/OFf3H1ueLEpTSYkVYy18
         Bk8T7jMqgVh0PkZ4I2cJAOhNnRfcPkWjInhhLGbGryWtk+1wfLkrVy0iO2VNKpiS/MrP
         XnjTrbYLTUbjAbqEsIusPE+oCrRLJ25Okx89n9T+l3WmpXJDcnOvU6OcMaMyJE5GxRJj
         T5woAb75ZA6Z/QcUFcjGdHwU9PabZY3nMitqx2yIo8bxixSx7TrIgq4QlX1f0xGuQGhv
         r6PSSzzPiJesCr5odnaBlcacIftCwrXyPtxkJd81MlrKyDGJ2xgyqsnePP+e1gSAZJaf
         FvQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dh4aupUSPEjaFwU/NhNXf74efZLkJgrHRqRRjH9BeWs=;
        b=X3lX4JSrg9N5vAozHj/8DToFDf2qag4oJJ7FSc8xpax0f+yLk5XOuGfj2qckDvtjY2
         4i7tDQDTytPLHWYR0yeGIYm2T2pB+rW4uBhCpQgR6GEg53RKX48rTFDYpM25fMbCTwL0
         4K3I7qjKJpwvoD5uH/o6Ac0agX6WQtH2VxIddGPkjT53Q8i++2lcWuWZ+DCM60t/Jisr
         t2KH93/N47VO6OkOudCteE+nNLEENukutxvgoJTkGMVr+CRk6JWeyXKoQsjDvoS/gXCl
         HNlvZm4NgfxKtwLgNKGhivDDNjRItfFGXNWYGC4KR8qRxgxL7t5BmhSl0DNdnJdr2U5P
         79TQ==
X-Gm-Message-State: APjAAAUJqnlrdgFGsd0J+1hS0ek0igMSWeXFz8BD/f/4TshBOJl2JCUO
        GcBh8Zr3cWVVEdusj5GuVZcVPdl2ftdnUpFrFSjNliZf
X-Google-Smtp-Source: APXvYqzPFPnFPo2BBK8L7fBOyBgBifpvaCSzm1+mO6efraLAi3ZBRs2nuLPzNVcI9rVDbEkCCZm094jtVKJT+6wtOws=
X-Received: by 2002:a37:a388:: with SMTP id m130mr5153053qke.250.1566578854478;
 Fri, 23 Aug 2019 09:47:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190820222403.GB8120@kroah.com> <201908220959.x7M9xP8r011133@www262.sakura.ne.jp>
 <20190822133538.GA16793@kroah.com> <e8d3ce30-8c61-048e-2606-f8a4e8f08d87@i-love.sakura.ne.jp>
 <20190822164249.GA12551@kroah.com> <CACT4Y+Z0yCAwie83Oqd7XBNgQjWtEkuEg5WJCd6rW-ZMWqosxg@mail.gmail.com>
 <433f12f7-cc17-c88b-4f26-7f45eee42884@i-love.sakura.ne.jp>
 <CACT4Y+YCNR5_M29juV9-2UDj55BJVuYbj7bzbjtMDM_odut1Pg@mail.gmail.com> <f89b6329-37f5-e0ac-03aa-a58edc4267e4@i-love.sakura.ne.jp>
In-Reply-To: <f89b6329-37f5-e0ac-03aa-a58edc4267e4@i-love.sakura.ne.jp>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 23 Aug 2019 09:47:23 -0700
Message-ID: <CACT4Y+bJrPcEpdEFNPHZGm3ZtJ=ybba9SFbZUm_J6eTuOufeCA@mail.gmail.com>
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

On Fri, Aug 23, 2019 at 1:17 AM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> On 2019/08/23 8:59, Dmitry Vyukov wrote:
> >> Can't we introduce a kernel config which selectively blocks specific actions?
> >> If we don't need to worry about bypassing blacklist checks, we will be able to
> >> enable syz_execute_func() again.
> >
> >
> > We can consider this, but we need some set of good use cases first.
> > For /dev/{mem,kmem} we disable them with config, right?
>
> /dev/{mem,kmem} can be disabled by kernel config options. But
>
> >                                                         That looks
> > like the right thing to do because we don't want fuzzer to do anything
> > with these files anyway.
>
> I don't think so. To examine as corner as possible (e.g. lock dependency),
> I consider that even doing
>
> ----------
> +#ifdef CONFIG_KERNEL_BUILT_FOR_FUZZ_TESTING
> +static char dummybuf[PAGE_SIZE];
> +#endif
> ----------
>
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
> +                       copied = copy_from_user(dummybuf, buf, min(sizeof(dummybuf), sz));
> +#endif
>                         unxlate_dev_mem_ptr(p, ptr);
> ----------
>
> makes sense, for copy_from_user() might find new lock dependency
> which would otherwise be unnoticed.
>
> >                          So this won't be a good use case for
> > CONFIG_KERNEL_BUILT_FOR_FUZZ_TESTING.
> > Fuzzer can also reliably filter out based on syscall numbers of
> > top-level argument values. The potential problem is with (1)
> > pointers/indirect memory and (2) where blacklisting some top-level
> > argument values would backlist too much (e.g. prohibiting 3rd ioctl
> > argument 0 entirely).
>
> I consider that functions that freezes processes/filesystems,
> reboots/shutdowns a system, changes console loglevels can be blocked
> as well. Trying to examine up to last-second conditional branches will
> catch more bugs (e.g. bugs in error recovery paths).

Well, ok, sounds reasonable. If you can take on upstreaming such
config, we will definitely enable it on syzbot.
