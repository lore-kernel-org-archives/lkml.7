Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C10FCC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 15:01:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EBCF206DD
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 15:01:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pBdpUgvA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728762AbfCFPBd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 10:01:33 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:52852 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727849AbfCFPBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 10:01:33 -0500
Received: by mail-it1-f193.google.com with SMTP id g17so9907374ita.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 07:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ma7gN33rHEJBg2nn3xt0dVYNYTaKKiTjeqHcsyF0hbA=;
        b=pBdpUgvAvGvIVakxr0C+K5X4Gw/cSqF/AW50mdjmLdq3gT+W2tjbDMmfWX8JJy1udm
         OAMrdBYbBvuhVsWZRdTfVGYOn/VPj3lcSJiTfxOxE9u6rHF1uZKly1V2BKKrnvIG3rDF
         rwCf0xm6VUSV9xHz50xXEpHjrWOLZP+PDTKN1IF2u18w2ncLv2Q/x2qy6unu1G5jdC3m
         m4I+SCQAdS8voqnMN3AO9/9xin2lGJcSfJ7sAmLVOP5X+5g0U5KYbeulFHXbjeYSIfJU
         BLuaklxaezPJTzH8v8TsBSjUMVabQ3t0timSb621UrL8/wnfnxghedVLci27S9TD87HR
         LO9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ma7gN33rHEJBg2nn3xt0dVYNYTaKKiTjeqHcsyF0hbA=;
        b=kNO8mWrWQEmMkSvbP/O6zi+TGtScOAywE1WrFli9/2JDmS65a+h1LflbmPLUCwcN9+
         1L2W3mYK2aecIg5ZVTZjNWBvKxoKu3/yrRkdY7hSSpGrpIRXMRpLEalRT8gkNuSK9YCZ
         eoM3XRP7/onlR4V8fYKuAegp8UMigGGsR9ugZtQ0w4N0xHQPbgyy698i1hJ4F3Te1D4U
         lAVNpzOns8+I0uOAXMjWe1jJLFxek3q8DFH22gk1KZ80uAxvjlmUdEU8pjrOmysGBfh5
         /KSbH03VjFraXzKbdOmwDbW6jMXltx6i8NoPTo2COSKcYgwh+R479S4XubF0x/qrSDIs
         kRSw==
X-Gm-Message-State: APjAAAUIKnaA+CpUH9u/x0ozeU8MISs0bVPEId6yiiGqAikwutQJCKb1
        hNattV6h90C/t8wArOEtFE1MgzH+HlkNV9XXvIMxcQ==
X-Google-Smtp-Source: APXvYqzEazw1Mc+SDDFsHpyRBxuO1roRHBSKrbBBfer7mH9u/Oq15c1caHcTwZx9eb6wxlv/dUYFVXTwOa1NXX8hW68=
X-Received: by 2002:a24:c8:: with SMTP id 191mr2095149ita.166.1551884491972;
 Wed, 06 Mar 2019 07:01:31 -0800 (PST)
MIME-Version: 1.0
References: <20190301144556.GY32477@hirez.programming.kicks-ass.net>
 <CACT4Y+ZyXAJiKtzoWxY-u7e9HaL7iM9tnFXnFZd7Hdy4uHEOyA@mail.gmail.com>
 <20190301152305.GJ32494@hirez.programming.kicks-ass.net> <20190306131347.GX32534@hirez.programming.kicks-ass.net>
 <CACT4Y+YFkDRwTN1MKqLDePfuRis3Qas1kgEF7g5eVR0ijodtkw@mail.gmail.com>
 <20190306135728.GV32477@hirez.programming.kicks-ass.net> <CACT4Y+YP+Xn3TxVXrza_LBK8m7CCKBUYWpuGS0+MzFCXEE+Akg@mail.gmail.com>
 <20190306141237.GW32477@hirez.programming.kicks-ass.net> <20190306143439.GY32534@hirez.programming.kicks-ass.net>
 <CACT4Y+YmQBc67hU2exY5=tAVG1jWNUeZ7FAm+GGgqDvOH7cu1A@mail.gmail.com> <20190306145555.GX32477@hirez.programming.kicks-ass.net>
In-Reply-To: <20190306145555.GX32477@hirez.programming.kicks-ass.net>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 6 Mar 2019 16:01:20 +0100
Message-ID: <CACT4Y+ayL4vYHvuqjpQ+nL2jxb=TOmkTWR__qmOCSsTbN7bDig@mail.gmail.com>
Subject: Re: [PATCH 1/8] kasan,x86: Frob kasan_report() in an exception
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Ingo Molnar <mingo@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>, valentin.schneider@arm.com,
        Brian Gerst <brgerst@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 6, 2019 at 3:56 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Mar 06, 2019 at 03:40:51PM +0100, Dmitry Vyukov wrote:
> > On Wed, Mar 6, 2019 at 3:34 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> > > mm/kasan/generic_report.o: warning: objtool: __asan_report_load1_noabort()+0x0: call to __fentry__() with UACCESS enabled
>
> > But if it makes things simpler for the objtool, then I think we can
> > disable function tracer for generic_report.c too.
>
> It's not simpler; it is actually a correctness issue. Those functions
> must not call into the tracer with AC=1

You are right!
I assumed they are defined in kasan.c and then call into a report
function that is compiled with -pg.
We can either disable -pg for report.c, or move these callbacks into
kasan.c which already has -pg disabled. I don't have strong preference
either way as long as the option works in all cases.
