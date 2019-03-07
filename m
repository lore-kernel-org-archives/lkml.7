Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21720C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:01:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEF5A20851
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551978072;
	bh=deT2N7Ov/A4SE4ht2D39cgVT2fk83tsBvxgaNw9nycg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=YWGv4itPk0chuv65k7SDfzlivxoQUUzexRmNPigrYfeONvmX/l9ZLAT7JxwBkC9WY
	 NmuFHiNmxXFYtU3hzr1u/UzhviWuwI9ecrnE+pTIuKw02ACWpUZMyvCOJWAIfO8SFO
	 XTHYePsf5N3+7RlG8dg6d/VFWp+pNnH8mcAwHxC8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbfCGRBK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 12:01:10 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:34489 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbfCGRBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 12:01:10 -0500
Received: by mail-lf1-f67.google.com with SMTP id d26so12225417lfa.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 09:01:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s1zsB/737Tin5CwcqhmNyyqJfdWx3oMpEszPfXu6l9U=;
        b=IKSxgclQkCN0UpoO8GTTI61KcDoTPid2lOS/fmRFez62Fh/bmnGQsVXHwovTOBJAey
         s1xiOqztJAcc/abRipT5Osb48j1XzMpHhaR89qjt6OjJihYQ5sAVtp71lv9EcGSXHnSX
         fM0yH7MDuByffboSXDThJlxPU/Af4pUQFD2Xs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s1zsB/737Tin5CwcqhmNyyqJfdWx3oMpEszPfXu6l9U=;
        b=ugzcqkAk6MmFt3iWbiIVtPIQYfWU5H1EY1gTjZCudsGxQn7iQC9xbJ2H8GLIU5AYMw
         qeQ4k+AfofH/wxPQ0lCZ5UHdoCvqVYFR/GK3T9dnK5MBpuZVhSXKsBhO00VyPRgJ0nH7
         HaOjkmQVqy9qwoIn9Y9wGdHgtrYcZ2MOlsSHXZDC2QUbKjsaRHXIimBjUlxBpE9tMkNE
         AmfkZy6KwUE++h/abxoEFyd8cZGOYakBgMqQeFE76WLvDDd1Rg1OkGhg96bkPovf0YRV
         nRHT9AEn+Bbo0siiZYXQ2HBlTZIUfDeIJh+qr4WM0/wYEA15GvGVOaTicSXXlWw84Bf5
         mC/w==
X-Gm-Message-State: APjAAAUBTd2FnXkWPyQCu9Q5PzMkmTTDNMslrKezANBLedmGQAWtvGPn
        O6OV3Skd3szybVvJku6/Ch7B32GK/HI=
X-Google-Smtp-Source: APXvYqyqtIOnj6x6jsF0SDe3S9OwRBNaGWanx8ndqtkK4HIfKdsAnFjAKV74iHxo8BokqAuV2mFbxw==
X-Received: by 2002:ac2:5497:: with SMTP id t23mr7643541lfk.69.1551978067012;
        Thu, 07 Mar 2019 09:01:07 -0800 (PST)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id s7sm923839ljs.8.2019.03.07.09.01.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Mar 2019 09:01:06 -0800 (PST)
Received: by mail-lj1-f180.google.com with SMTP id l5so14886698lje.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 09:01:05 -0800 (PST)
X-Received: by 2002:a2e:9786:: with SMTP id y6mr5777048lji.79.1551978065237;
 Thu, 07 Mar 2019 09:01:05 -0800 (PST)
MIME-Version: 1.0
References: <20190307114511.870090179@infradead.org> <20190307120317.GD32477@hirez.programming.kicks-ass.net>
 <20190307125526.GB32534@hirez.programming.kicks-ass.net> <20190307131312.GC32534@hirez.programming.kicks-ass.net>
 <20190307164705.qbu4ytdfdmsighas@treble>
In-Reply-To: <20190307164705.qbu4ytdfdmsighas@treble>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 7 Mar 2019 09:00:49 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgfvwn1L7BduXA02rZdDnKGb8ebzm4C--QcfVF+gjHAvQ@mail.gmail.com>
Message-ID: <CAHk-=wgfvwn1L7BduXA02rZdDnKGb8ebzm4C--QcfVF+gjHAvQ@mail.gmail.com>
Subject: Re: [PATCH 00/20] objtool: UACCESS validation v3
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Anvin <hpa@zytor.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Ingo Molnar <mingo@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>, valentin.schneider@arm.com,
        Brian Gerst <brgerst@gmail.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 7, 2019 at 8:47 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> This "fixes" it, and also seems to help -Os make much code:

Yeah, considering that this __trace_if() macro from hell is doing an
'if()' on the result of that inner thing, it makes sense to *not*  use
that "looks simpler and shorter" array sequence, but depend on the
compiler then noticing that the conditionals are the same and joining
the two branches together.

The compiler has to do much more work to either generate the actual
dynamic array thing, or notice that the _index_ of the array matches
the _conditional_ on the branch, and undo that thing.

But that macro really is the macro from hell regardless.

Do people really use CONFIG_PROFILE_ALL_BRANCHES?

                Linus
