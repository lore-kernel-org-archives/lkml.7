Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9289EC04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 16:17:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6524B2087F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 16:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557159461;
	bh=xO41kDz7NLVIkD2y/X2X2tZPi0d+n5DsS8gVh34nHrU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=juSVlw+xgVFghv9WdUqpQZpcb+acROBeW8/VRxLwKG5jiRqCbbuYRPcrcCPnuZEyW
	 g4W7f308fZL6gvd7pK8wMl+9GJ3+jJI+BPN62mw2ylDl23AZAeh+9i48yDED1Onlza
	 xxnbNvj/xf0stKKDy7s4su1YXIbR4KU20rSSVGm8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbfEFQRk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 12:17:40 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35519 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbfEFQRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 12:17:39 -0400
Received: by mail-lf1-f68.google.com with SMTP id j20so9603424lfh.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 09:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gdKWMzG0jTPJKQefPY2Ldaf6Ms3KDojiEWREzp6GY/0=;
        b=acUkx/SyXE0iTsaLBqBApazjPIDAcpKLa6eanB/pwg3/nd2wX7zX61gfnOb7YkZ3Ll
         QSKrbp97fW9PaMvvakbU30HZC6d9E8ZxMJWyn8rtqBZLvZSLIjhpYOKX3sVWKA+T51pr
         jCo9GXVhBGPddoOghrCGtgtxD8b+3ePfN7F28=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gdKWMzG0jTPJKQefPY2Ldaf6Ms3KDojiEWREzp6GY/0=;
        b=GTNrUUJnTi3H3RA0k4Lj6/degxMQ/TRZ3WB47CvWVMWMV83ZLj6+RuspiSDuHNRyFV
         M16WtjC83CHVY25PLgqCStcCbru7tg+rqK4XaYe7lz6tNRDm9GMN2GvVc9ZhbKuVkOV5
         05U9LRtBssciGiz7C9WAdIREqPURwsrXgAUs07hyFQ7qgZwqqGNeTCQQgG5G17yHoGzH
         AIoDHD+XHv7Ij8RfgIPkNwYdEI+95gXzY8AXVppNuEozFYL0jhLW7/US/ATKLQFy/FKs
         uHRMU6RfALVBPQ1zEaTHt9QR9bZiMDc4QbMdt5F/hal1+nsrgJjmRgZ3yimuEdovXNWW
         kDXw==
X-Gm-Message-State: APjAAAVNb8SMwLmQ/OkFK/2bSnPT0CixPrUXKNO/u9ePme5RaWXXSUj/
        kWkHOjAVrcGLjhgHpP4XbcrddTC1Iuo=
X-Google-Smtp-Source: APXvYqzATtAWbt+Pn9TiO+/EFI/LCOUUmNwpYl+1XR6QyAnZ0t6rrELE9FHcf21LwljLagcUHsj4UA==
X-Received: by 2002:a19:96:: with SMTP id 144mr11189347lfa.29.1557159457137;
        Mon, 06 May 2019 09:17:37 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id n9sm2552533lfl.35.2019.05.06.09.17.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 09:17:36 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id j20so9603366lfh.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 09:17:35 -0700 (PDT)
X-Received: by 2002:a19:ec07:: with SMTP id b7mr7420419lfa.62.1557159455483;
 Mon, 06 May 2019 09:17:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190502181811.GY2623@hirez.programming.kicks-ass.net>
 <CAHk-=wi6A9tgw=kkPh5Ywqt687VvsVEjYXVkAnq0jpt0u0tk6g@mail.gmail.com>
 <20190502202146.GZ2623@hirez.programming.kicks-ass.net> <20190502185225.0cdfc8bc@gandalf.local.home>
 <20190502193129.664c5b2e@gandalf.local.home> <20190502195052.0af473cf@gandalf.local.home>
 <20190503092959.GB2623@hirez.programming.kicks-ass.net> <20190503092247.20cc1ff0@gandalf.local.home>
 <2045370D-38D8-406C-9E94-C1D483E232C9@amacapital.net> <CAHk-=wjrOLqBG1qe9C3T=fLN0m=78FgNOGOEL22gU=+Pw6Mu9Q@mail.gmail.com>
 <20190506081951.GJ2606@hirez.programming.kicks-ass.net> <20190506095631.6f71ad7c@gandalf.local.home>
In-Reply-To: <20190506095631.6f71ad7c@gandalf.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 6 May 2019 09:17:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgw_Jmn1iJWanoSFb1QZn3mbTD_JEoMsWcWj5QPeyHZHA@mail.gmail.com>
Message-ID: <CAHk-=wgw_Jmn1iJWanoSFb1QZn3mbTD_JEoMsWcWj5QPeyHZHA@mail.gmail.com>
Subject: Re: [RFC][PATCH 1/2] x86: Allow breakpoints to emulate call functions
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Nicolai Stange <nstange@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Juergen Gross <jgross@suse.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Joerg Roedel <jroedel@suse.de>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 6, 2019 at 6:56 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> I can test this too. I was hoping to get this in by this merge window.
> I spent 3 hours yesterday trying to get Linus's version working on
> i386 with no success. Not sure how much time Linus will have to look at
> this, as he just opened the merge window.

I acvtually just tested it in qemu, and it worked fine.

Ok, so my test was admittedly really simple and stupid, in that al I did was

        printk("Before int3\n");
        asm("int3; nop; nop; nop; nop" : : :"ax","dx","cx");
        printk("After int3\n");

and then I hacked up do_kernel_int3() to just unconditionally do

        return int3_emulate_call(regs, (unsigned long)test_int3);

with a stupid test-function:

    void test_int3(void)
    {
        printk("In int3 handler");
    }

instead fo anything fancy.

But it did exactly the expected thing, and resulted in

    Before int3
    In int3 handler
    After int3

on the screen.

So what is it that doesn't actually work? I've looked at the patch
even more, and I can't for the life of me see how it wouldn't work.

Of course, I didn't test any of the actual ftrace parts, since I
short-circuited them intentionally with the above test function hack.
I have no idea what the semantics for those
ftrace_location(ip)/is_ftrace_caller(ip) cases are supposed to be, I
only tested that yes, the infrastructure clearly emulates a call
instruction.

               Linus
