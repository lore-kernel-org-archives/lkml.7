Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A420AC00523
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 09:04:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73807206DA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 09:04:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Syay9oqS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbgAHJEB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 04:04:01 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:47023 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbgAHJEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 04:04:01 -0500
Received: by mail-qt1-f196.google.com with SMTP id g1so2153509qtr.13
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 01:04:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3ookxX+35x4qDLLz6LNEDMg+8XBqMqjiEwb1lH1Me9U=;
        b=Syay9oqSOC1d3cvHK1csdUdLyK5hU7YaoRTe6IAnxWCBk/nFDOCjAjZhkDApG2KQAA
         IwTIR9YDDLWbd5qG49g3t/RGdUja310cww2o1PK83gfjrru5p5LBzmm3MtMQu3ZX8wDa
         waLEJMsbvpeHrnrDvi+dUi+Kg66IuqEXhNml31a8Qu5ykaCBT18Cj+M207bdIBW6qYS4
         NBCrVa04YJpOSx+LJu5ZlsSPaN/LghJFFSSt2w00Zf97Se34YUw5iCgUlAGvs0K6fdEw
         avj/tn3mvB2s9mkAW3BS/bwN0YCUT1nhpjmE8oaanS2IbaE9SzvAzGyochShEt8WlAK7
         QAIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3ookxX+35x4qDLLz6LNEDMg+8XBqMqjiEwb1lH1Me9U=;
        b=M6o9VDNGAe0vPhZkL2lqG1aFqFsZrJj1lah8CjWDcZvFGi6IkIsMrgXzxZ+qtFjkxp
         HXSYMpRibm5xAJvkq/1Ihf1sxFfw9rxBJqsUhX4KVy2yV9QDwO5aAtgHg8xeA6BXwptP
         qKqV32AIpAo0/SDIDVQCgkRDNjTUxc9aTZsyyPazKJj1C4NFa2rrL8PYujQ82sw2w1zm
         0HrkMPEX5JwMc8QUHhtQlFqDrX6u35mQshBz2/PkkXqWZBdzeN0RtEKDz57j+ETT/Le4
         2THx+JTxIWVGr1TcUY0xTyTHxl/TTr08Qgwot83Z54VkckPvgo0xQZuLgRlyKwLj6tYu
         XPJg==
X-Gm-Message-State: APjAAAXf1kO+UDEOE7iZcB453GPIhQALunWSO4oUj7qFFS0xlyiysbVr
        2tqb7Tsaphy+IHHX8/ipNhkOowUQXa56I2sQC3X0dA==
X-Google-Smtp-Source: APXvYqzEDlPPdB37friKXKRTVKirFLwjQ9wv3hF9jtpO1FtnV/M2pPC00ktvS/D/3ZhLuwwIjANuYxtgJ+yfKPt5vGo=
X-Received: by 2002:ac8:71d7:: with SMTP id i23mr2686568qtp.50.1578474239992;
 Wed, 08 Jan 2020 01:03:59 -0800 (PST)
MIME-Version: 1.0
References: <000000000000f04e43059b1ee697@google.com> <20200107205302.45yb2rkekz3nat6v@linutronix.de>
 <CACT4Y+ax6URhDKBREy6XLx=nKFLGSmt87Z-oU3E1D8SAJwBcrg@mail.gmail.com> <20200108085532.37ycr24gryqhkkto@linutronix.de>
In-Reply-To: <20200108085532.37ycr24gryqhkkto@linutronix.de>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 8 Jan 2020 10:03:48 +0100
Message-ID: <CACT4Y+a4ySF6dWwW7jhh9UN-5okJtTexSu_RFsxyQzOzw7ybWg@mail.gmail.com>
Subject: Re: WARNING in switch_fpu_return
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     syzbot <syzbot+f2ca20d4aa1408b0385a@syzkaller.appspotmail.com>,
        alexander.deucher@amd.com, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, nicholas.kazlauskas@amd.com,
        Rik van Riel <riel@surriel.com>, sunpeng.li@amd.com,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "the arch/x86 maintainers" <x86@kernel.org>, zhan.liu@amd.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 8, 2020 at 9:55 AM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> Hi Dmitry,
>
> On 2020-01-08 05:28:31 [+0100], Dmitry Vyukov wrote:
> > > > userspace arch: i386
> > >
> > > So I tried to reproduce this. syz-prog2c made .c out of the above link.
> > > It starts with:
> > > |int main(void)
> > > | {
> > > |   syscall(__NR_mmap, 0x20000000ul, 0x1000000ul, 3ul, 0x32ul, -1, 0);
> >
> > Hi Sebastian,
> >
> > If you want to generate a C repro for 386 arch, you need to add
> > -arch=386 flag to syz-prog2c (then it hopefully should use mmap2).
>
> Ah okay. I've been looking at
>         https://github.com/google/syzkaller/blob/master/docs/syzbot.md#crash-does-not-reproduce
>
> and it says
> |Note: if the report contains userspace arch: i386, then the program
> |needs to be built with -m32 flag.
>
> and with the argument you mentioned it the compiled C code uses mmap2.
> Thanks.
> Now the 32bit testcase reboots, too :)
>
> > But FWIW syzbot wasn't able to reproduce it with a C program,
> > otherwise it would have been provided it. But that may be for various
> > reasons.
>
> Yeah, my memory was also that a C-testcase is provided. But there was this
>         https://syzkaller.appspot.com/x/repro.syz?x=10cc8971e00000
>
> link so I assumed I should use it myself and I missed the update that
> something changed.
> So what should I do with the file above? Feed it to `syz-execprog' or is
> it a rough idea what the test case should have done?

Yes, the syz program can be executed with syz-execprog utility:

https://github.com/google/syzkaller/blob/master/docs/executing_syzkaller_programs.md

However, since it's a KVM bug, it may be somewhat special. At least
there were some special ones historically. For example, behavior may
also depend on the host OS. So maybe you already reproduced it, it's
just that in syzbot environment it caused the WARNING, but in your
environment it causes the reboot. I have no indication that it's
actually the case. But I just want to warn that reproduction of some
KVM bugs proved to be tricky in the past. I am sure that syzbot was
able to trigger that exact warning on that exact kernel version/config
using that exact program. But it happened in one particular
environment.
