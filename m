Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54715C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 15:31:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23BC8206BF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 15:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557243099;
	bh=3eYZWxtC2u15K5ryIBo7UV/M/ltBwh7KfvE8xRwPu9A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=yEUgRMP0jbU/q36tc0j3VwcwbUSEdpUsoCn1AtS5ARTAWudPhJsSQChSlTQvznsu6
	 F4xXbsv99cMA85z/cojr14fGGiYuTZ8W/RifXoQm60NRkUTgr6TPCqSbXSJ8t1BQ7m
	 v+ocyLyKvfP26pEc9G/a43l5oPwjc5s3L3410sgw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbfEGPbi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 11:31:38 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:43877 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbfEGPbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 11:31:37 -0400
Received: by mail-lf1-f66.google.com with SMTP id u27so11924250lfg.10
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 08:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y6ybn9R2wRwK7OVl8uatl/i1llM+QJoRgaCyqAFbo9Y=;
        b=BNzVqUAAViERdEuxZy8DHUiuYxo8ddmm9cVx4BOchUH3WtVYroxRTUSipMK+LTDMnx
         G6Nz0qaFq78h9Jxdf15yovQ7B7GKRx+9GVUL2kenVn+ddQfRmu4UzyEd25IlQcp/jSGE
         dAIUJDF1c1Wz5T5Q+QRd4jWS9Etfzd3108pkw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y6ybn9R2wRwK7OVl8uatl/i1llM+QJoRgaCyqAFbo9Y=;
        b=bCmw6s3BSyRfjlUs/ktByJ4b4pBNwVGJAmfNmkyJ5xFbbwR5L3asgOHh3P/xiEu+W7
         4jFwQPt0c2nPiYfocyPQOzvEv4O4HpyKOz/hdU8zAUoVZYMwbRDdLAywPJE9jrmXH9a7
         5+HHmbZ4gtgP9qFmLLmMCmYRakp0dhhpwmmmRx5h9ztB1ibbGBDa3w1WPjzXOeH/62ny
         4MFkGNSjnZRA8d8XgVnU2So3uf0StQm3PB2JO0y0arsWk3zB/2h3XwTe1ZiEX2Xh1qNh
         xW3eg3xmKv4bmkHFyhtA8vvdPQVHAEg7id2GbVrGmP0GK90B1gtFkTBThi4Gt7cBQlp7
         kCXg==
X-Gm-Message-State: APjAAAXPO8eCB36wAS577ueK/oLL0f27S0Gpmw0jCIWAUyk0hQmJRQli
        EyTHZy5SrxnvqZtWNG/HljqH+UwF1dc=
X-Google-Smtp-Source: APXvYqxYvzuz1mAUVDa3gmiZA5YDVQubw2qHSk0qhoQ7cqRaMvcz5r+nOgdEZa2L/K0RW+Qx5v322w==
X-Received: by 2002:ac2:53b2:: with SMTP id j18mr17591251lfh.78.1557243093971;
        Tue, 07 May 2019 08:31:33 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id m3sm3312502lfh.94.2019.05.07.08.31.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2019 08:31:32 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id r76so3670620lja.12
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 08:31:31 -0700 (PDT)
X-Received: by 2002:a2e:3e0e:: with SMTP id l14mr17667665lja.125.1557243091071;
 Tue, 07 May 2019 08:31:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190502181811.GY2623@hirez.programming.kicks-ass.net>
 <20190506145745.17c59596@gandalf.local.home> <CAHk-=witfFBW2O5v6g--FmqnAFsMkKNLosTFfWyaoJ7euQF8kQ@mail.gmail.com>
 <20190506162915.380993f9@gandalf.local.home> <CAHk-=wi5KBWUOvM94aTOPnoJ5L_aQG=vgLQ4SxxZDeQD0pF2tQ@mail.gmail.com>
 <20190506174511.2f8b696b@gandalf.local.home> <CAHk-=wj3R_s0RTJOmTBNaUPhu4fz2shNBUr4M6Ej65UYSNCs-g@mail.gmail.com>
 <20190506210416.2489a659@oasis.local.home> <CAHk-=whZwqzbu-=1r_j_cXfd=ta1q7RFCuneqBZfQQhS_P-BmQ@mail.gmail.com>
 <20190506215353.14a8ef78@oasis.local.home> <CAHk-=wjLXmOn=Cp=uOfO4gE01eN_-UcOUyrMTTw5-f_OfPO48Q@mail.gmail.com>
 <20190506225819.11756974@oasis.local.home> <CAHk-=wh4FCNBLe8OyDZt2Tr+k9JhhTsg3H8R4b55peKcf0b6eQ@mail.gmail.com>
 <20190506232158.13c9123b@oasis.local.home> <CAHk-=wi4vPg4pu6RvxQrUuBL4Vgwd2G2iaEJVVumny+cBOWMZw@mail.gmail.com>
 <CAHk-=wg2_okyU8mpkGCUrudgfg8YmNetSD8=scNbOkN+imqZdQ@mail.gmail.com> <20190507111227.1d4268d7@gandalf.local.home>
In-Reply-To: <20190507111227.1d4268d7@gandalf.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 7 May 2019 08:31:14 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjYdj+vvV8uUA8eaUSxOhu=xuQxdo-dtM927j0-3hSkEw@mail.gmail.com>
Message-ID: <CAHk-=wjYdj+vvV8uUA8eaUSxOhu=xuQxdo-dtM927j0-3hSkEw@mail.gmail.com>
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
        <linux-kselftest@vger.kernel.org>, stable <stable@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 7, 2019 at 8:12 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>>
> Yes, band-aids are usually simpler than a proper fix.

What? No/.

My fix is the *proper* fix.

PeterZ's is the bandaid.

>             We have 28 years
> of hacks built on hacks. There's a lot of hacks in the C code to handle
> the differences between the crappy way x86_32 does pt_regs and the
> proper way x86_64 does them.

You're confusing "reality": with "your dream world". They are different.

The reality is that the i386 kernel stack is just how things work. End of story.

The reality is that changing something fundamental like the kernel
stack at this point for an architecture that will not change in the
future is silly.

The reality is that Peter's patch is much bigger than mine, because it
needed a lot of other changes *because* it did that change.

> To implement your way, we need to change how the int3 handler works.
> It will be the only exception handler having to return regs, otherwise
> it will crash.

What? That's what the patch *does*. It's trivial.  It is done.

                  Linus
