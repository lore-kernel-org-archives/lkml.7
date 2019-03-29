Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC07C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 16:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 277E0218A3
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 16:02:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JzgR25kC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729744AbfC2QCe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 12:02:34 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:37231 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728961AbfC2QCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 12:02:34 -0400
Received: by mail-ot1-f67.google.com with SMTP id c16so2576879otn.4
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 09:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gZocI1SHIOi+y+CZmlS2EmaUnqDOacK/vDCn4VI5GrM=;
        b=JzgR25kC4l++7jTABaN2rrKfoz+i48okcWfMkYR7hmO5IFY8sx/LcuEonBUkP0/0dZ
         s7YNniyP3nNQGfxt5sNp/E19XK9VHFYNR85hlCAix8pjXSOACpRtCVivcW5bqPUegl0+
         2bufc+FYmO+24EwOl9bIrS6S/KmeJ+eNWv2fuGQ0arI9QUSm6UgHM5fPmExFNDsnAaJc
         +ZSL8N5uh5woYa8iQZnODLnf+/Vy1hIGn/frlRm/xYFjJD/GTrhx9rMZvEp1zxy9UPWH
         V+VgZJvImfEe2tGVqwAWxl7h176E6zVdaxUdRi6oI5yEdV9aIFVubUR0svK8TJXAE3tM
         GQPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gZocI1SHIOi+y+CZmlS2EmaUnqDOacK/vDCn4VI5GrM=;
        b=DBRWkDYjdem0JeQ8DIzge/U6vNSHZJ/5lGISS87YUZo8whdja7moHBBzARqy2vN3Tb
         FK3kBQDrsTwaxt3USZKwfwvl/zi5zr/4nHABEJpbxPuIDG8k+GZV7sLEXLXktzM7Ki2j
         r5oWR2JzSLkNq1cvU8+QehMPqjj51CXcNlpIqJLY8HLdhA4uRUXUxsNjfedAsM23eqD8
         eJaAFYP6TN1Dc8p+gwLa0APb5eJzMn6BESemGJ76yIazn3Xy7qZe86ECutIbLqyHbhbh
         0XzMW3NAR2v7wteqLToSs88iNWGk866lgAZfRKBUbmsCmVZEvTReFcSj1Ujkf/6ValRg
         rhGg==
X-Gm-Message-State: APjAAAXee3E32W5cuggU2E0v3AuRoQfcSoWT1BleW9tQ10BF+jRVn8HF
        nGdHUVCTkKUWhXh/3PO3+8zziMhhLzpPSvLKoIY+wA==
X-Google-Smtp-Source: APXvYqwX0qH7mq19xoHHNYY/1wLYoeUkBLWzQ3eYww/f7ltjjadZXutpvHfQQVzfRDjdDTUefmn1+XLXIlx3eHZI2W0=
X-Received: by 2002:a9d:694c:: with SMTP id p12mr34273929oto.242.1553875353202;
 Fri, 29 Mar 2019 09:02:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190328212321.92463-1-jannh@google.com> <20190328212321.92463-2-jannh@google.com>
 <20190329133956.GE21152@zn.tnic>
In-Reply-To: <20190329133956.GE21152@zn.tnic>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 29 Mar 2019 17:02:06 +0100
Message-ID: <CAG48ez1KY3n5CFVR3y=kE7yU5JkkVSd_Ns8wwsQGxyw53u8J-Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] x86: fix __user annotations
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Qiaowei Ren <qiaowei.ren@intel.com>,
        Ben Dooks <ben.dooks@codethink.co.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 29, 2019 at 2:39 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Thu, Mar 28, 2019 at 10:23:21PM +0100, Jann Horn wrote:
> > Fix __user annotations in various places across the x86 tree:
> >
> >  - cast to wrong pointer type in __user_atomic_cmpxchg_inatomic()
> >  - generic_load_microcode() deals with a pointer that can be either a
> >    kernel pointer or a user pointer; change the code to pass it around as
> >    a __user pointer, and add explicit casts to convert between __user and
> >    __kernel
> >  - save_xstate_epilog() has missing __user in explicit casts
> >  - setup_sigcontext() and x32_setup_rt_frame() rely on the cast performed
> >    by put_user_ex() on its first argument, but sparse requires __force for
> >    casting __user pointers to unsigned long
> >  - xen_hvm_config() has missing __user
> >
> > This patch removes all sparse warnings about the asn:1 address space
> > (__user) in arch/x86/ for my kernel config.
> >
> > Signed-off-by: Jann Horn <jannh@google.com>
> > ---
> > This patch requires the previous one, "[PATCH 1/2] kernel.h: use
> > parentheses around argument in u64_to_user_ptr()", otherwise
> > xen_hvm_config() breaks. Can we take both together through the x86 tree,
> > or does the first one have to go through akpm's tree?
>
> I don't see why not, unless akpm has objections.
>
> However,
>
> >  arch/x86/include/asm/uaccess.h        |  3 +--
> >  arch/x86/include/asm/uaccess_64.h     |  2 +-
>
> This chunk is being discussed here already:
>
> https://lkml.kernel.org/r/20190228185027.2480-1-ben.dooks@codethink.co.uk
>
> and I'd like to take Ben's v2 when Ben adds Linus' explanation.

Alright, dropped the changes in:
arch/x86/lib/usercopy_64.c
arch/x86/include/asm/uaccess_64.h

> Then, it would be probably easier if you could split that patch into:
>
> >  arch/x86/kernel/cpu/microcode/intel.c | 20 ++++++++++++--------
>
> microcode
>
> >  arch/x86/kernel/fpu/signal.c          |  6 +++---
> >  arch/x86/kernel/signal.c              |  4 ++--
>
> fpu patch
>
> >  arch/x86/kvm/x86.c                    |  8 ++++----

Split these out as suggested. Additionally, I've split out one commit
for x86/uaccess (the change to arch/x86/include/asm/uaccess.h wasn't
in Ben's patch).

> kvm patch

Actually, looking at the log of that file, and at MAINTAINERS, it
looks like that should go through the KVM tree? There's also something
I want to fix in virt/kvm/kvm_main.c, so I have to send some stuff to
Paolo anyway.
