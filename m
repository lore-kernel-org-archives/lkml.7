Return-Path: <SRS0=X3/1=2E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB285C43603
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 11:25:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A368A20706
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 11:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576322756;
	bh=bfAx3tMBpuyf9PTP1KRe7hblSecePb+KkhuMWPbsFy0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XQcQTPvxJ7ufcijmcizJXSckNcWBBUL9Kci38crQBkKLkCOAwb771aJwmsC/6mnsW
	 5RKAUQh/1NH/yCasokH/kdgIaRj80zjw60PEMDtdSBV3RmQju+V/SSdfJ2LG4T/o/l
	 mnyNzljLH67ljawrxdypSB0KEQHBYYNASZJ6VF/o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbfLNLZy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Dec 2019 06:25:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:36826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725883AbfLNLZy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Dec 2019 06:25:54 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4975720706;
        Sat, 14 Dec 2019 11:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576322752;
        bh=bfAx3tMBpuyf9PTP1KRe7hblSecePb+KkhuMWPbsFy0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZoYfbxq+FWhksWV/FryykzNpUrg4TRRBonSt3uGe0SHTHm98yaXV+u4Jv43RILhXV
         hcqXWo6LaqCAzjuhXRB+Muayiy48T8i/lI9oSNSTE/Kj+Wr/aAKevyZQ9XmT3CA9Yg
         atQOdZZ3kwHcKQYlKs9XhbwtohmOYmGx5xQozfT8=
Date:   Sat, 14 Dec 2019 12:25:50 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        syzbot <syzbot+f4f1e871965064ae689e@syzkaller.appspotmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        asierra@xes-inc.com, ext-kimmo.rautkoski@vaisala.com,
        Jiri Slaby <jslaby@suse.com>,
        kai heng feng <kai.heng.feng@canonical.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        mika.westerberg@linux.intel.com, o.barta89@gmail.com,
        paulburton@kernel.org, sr@denx.de,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        yegorslists@googlemail.com
Subject: Re: BUG: unable to handle kernel NULL pointer dereference in
 mem_serial_out
Message-ID: <20191214112550.GA3328133@kroah.com>
References: <CACT4Y+ZeR=z-3CSXFazmngUhs9DqfxgZLKBNhzvfg49Nrw=EzA@mail.gmail.com>
 <20191213093357.GB2135612@kroah.com>
 <CACT4Y+beoeY9XwbQX7nDY_5EPMQwK+j3JZ9E-k6vhiZudEA1LA@mail.gmail.com>
 <74859736-478a-6ad7-f0be-cfe87ec40ff5@i-love.sakura.ne.jp>
 <20191213160700.GA2632926@kroah.com>
 <4f514a5a-af11-e688-8f8d-72bbadadc889@i-love.sakura.ne.jp>
 <20191214075517.GA3314866@kroah.com>
 <8b130791-d48a-6505-f3f1-d08cada23d8d@i-love.sakura.ne.jp>
 <20191214090905.GA3322570@kroah.com>
 <1634f244-543c-28c6-c322-c3d981c3a973@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1634f244-543c-28c6-c322-c3d981c3a973@i-love.sakura.ne.jp>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 14, 2019 at 07:28:02PM +0900, Tetsuo Handa wrote:
> On 2019/12/14 18:09, Greg KH wrote:
> > On Sat, Dec 14, 2019 at 05:39:02PM +0900, Tetsuo Handa wrote:
> >> On 2019/12/14 16:55, Greg KH wrote:
> >>>>>> That suggestion got no response for two months.
> >>>>>>
> >>>>>>   https://lkml.kernel.org/r/3e4e2b6b-7828-54ab-cf28-db1a396d7e20@i-love.sakura.ne.jp
> >>>>>>
> >>>>>> Unless we add such kernel config option to upstream kernels, it will become
> >>>>>> a whack-a-mole game.
> >>>>>
> >>>>> It will be a whack-a-mole game no matter what.
> >>>>>
> >>>>> Yes, /dev/mem/ makes no sense to fuzz.  Neither does other things (like
> >>>>> serial port memory addresses.)
> >>>>
> >>>> /dev/mem makes sense to fuzz. Ditto for other things.
> >>>
> >>> What?  What are you going to find if you randomly start to write to
> >>> /dev/mem?  How are we supposed to "fix" that?
> >>>
> >>
> >> When did I say "writing to random addresses" ? If you saw my suggestion, you
> >> will find that "fuzzer will be able to test reading from random addresses,
> >> writing to safe addresses (in order to find new lock dependency which would
> >> otherwise be unnoticed)".
> > 
> > I don't remember the suggestion specifically, sorry.  But how would you
> > figure out what those "safe addresses" really are?  They will change on
> > every single platform.
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

Ick ick ick, we don't like #ifdefs in .c files for a reason :)

>                         unxlate_dev_mem_ptr(p, ptr);
> ----------
> 
> How dummybuf cannot be "safe address" ?

Sure, that's safe, but don't try to change what I originally said about
writing to random /dev/mem addresses please.

> > And why would this even help anything?  What lock dependency?
> > 
> 
> copy_from_user() can trigger page fault which involves memory allocation.
> And direct reclaim which is performed within memory allocation operation
> is full of subtle dependency bugs. :-(

It's as if you want a memory/platform type to be a "fuzz target", right?
You aren't going to go around and try to put the above crazyness into
each and every spot in the kernel that wants to write to a
user-specified address.

Fuzzing the kernel is great, but remember it's a means to an end, that
of trying to ensure that the kernel has less bugs than before.  Forcing
the kernel to adapt a memory model that is not what it "normally" uses
kind of goes against your main goal here, right?

And have you all really run out of apis that are all now bug free that
you are going after these types of ones?

thanks,

greg k-h
