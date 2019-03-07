Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB34BC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:48:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B0592085A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551980918;
	bh=SmSth95zvuaC7DCebSPhmTgONl4Dhy94UvNQ6SyBmvs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=iKGOWJwMJ+ikSqfDECOOVwylQSB9fXTZ5E3qhIRZwRKGBXWrgfpj+/c3BziQ/lfLD
	 QLO4lNoXmGFBqMZ0qBVIsnyCxHzdxetHAopbe8NofS/X4SiJB13z3zrGqKXDX+vK0t
	 s5+Mf2XXloXM7aDyo7KrALwnAEdOOw/gYO28IXNg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbfCGRsh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 12:48:37 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:42900 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726425AbfCGRse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 12:48:34 -0500
Received: by mail-lf1-f66.google.com with SMTP id p1so12332887lfk.9
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 09:48:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f61htgF1/+YV01wdEKiD4NQ5/+6jtJJSYbuVhPUpTlI=;
        b=QAb2wXwgdvQLeX0YnctQzgT0HazZBkIaz16vBXTmIG6bBw3wipPf+fE7ej3bvNmGzm
         j2CmeIaFpMw3O0Ng670MAboFMq/wL+ntsitWP1jp7Lcik/QttGWeBPnVgJNO4k6XucF5
         v87yeYKoySLlgMzRroaGe5Cc9ZCUfSrqeS9wg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f61htgF1/+YV01wdEKiD4NQ5/+6jtJJSYbuVhPUpTlI=;
        b=E6dJrqILIupUTVnbIdTWgpY0anz8gcEqW+cPZVVz0719oQ5id2fHu8RzXAgIXbifk7
         RyjBJn8KKdBXpqFbDPy2REnfQjnNF3rwCbtU6BpEDHCfRddPx4t+dnf9Nv1BXCv2IK/Y
         649+iDxF3AlzIgW7X/wNvHQme++jrI0hQ2XuAiXaCAN1jI78yKype7lRE1D0nYVeSati
         M5jbu4iPAwep7NnCDeG1j1UN/xYfQ+FLzZ/jZJKDJ3uINAToRqzVEzAfSMXGemNLj1gN
         lSY9RJsnX1N+S6W71fD61vPefflLWJmnJYi04k+zuXOpOglo5oPmh0Ck0bsf52Aih5XN
         Tw6Q==
X-Gm-Message-State: APjAAAW3fjzO9+8fH0w4+w5+9XZkzCFTSuhcQ3c9FCR+IkyNz0kPI+5r
        vBmzBHYtYbxgmNzY0vfEsGCYahbett8=
X-Google-Smtp-Source: APXvYqy6VyvPdPeEVa5gSxt0ACdyQ0tA8vDnyQQte7aDBia+zA/XakPeERUOBMTN9KdJ0XWyDYLqcw==
X-Received: by 2002:a19:d602:: with SMTP id n2mr7662781lfg.165.1551980912208;
        Thu, 07 Mar 2019 09:48:32 -0800 (PST)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id v20sm928921ljv.83.2019.03.07.09.48.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Mar 2019 09:48:30 -0800 (PST)
Received: by mail-lj1-f180.google.com with SMTP id v10so15008684lji.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 09:48:29 -0800 (PST)
X-Received: by 2002:a2e:208a:: with SMTP id g10mr6564724lji.135.1551980909153;
 Thu, 07 Mar 2019 09:48:29 -0800 (PST)
MIME-Version: 1.0
References: <20190307114511.870090179@infradead.org> <20190307120317.GD32477@hirez.programming.kicks-ass.net>
 <20190307125526.GB32534@hirez.programming.kicks-ass.net> <20190307131312.GC32534@hirez.programming.kicks-ass.net>
 <20190307164705.qbu4ytdfdmsighas@treble> <2F80FC70-5D2F-425F-BEB5-D70E981CC684@zytor.com>
 <20190307171829.xww7is5qja32r7ux@treble> <714E9D57-CCAE-4A69-AC3E-E6AFC525834E@zytor.com>
 <20190307174556.m7nh2y4wt3lbhuxd@treble>
In-Reply-To: <20190307174556.m7nh2y4wt3lbhuxd@treble>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 7 Mar 2019 09:48:13 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgE40LzP7KNdEqjEeUQJN3r5Qa-sSymZRMO7CgnMdM57A@mail.gmail.com>
Message-ID: <CAHk-=wgE40LzP7KNdEqjEeUQJN3r5Qa-sSymZRMO7CgnMdM57A@mail.gmail.com>
Subject: Re: [PATCH 00/20] objtool: UACCESS validation v3
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Peter Anvin <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
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

On Thu, Mar 7, 2019 at 9:46 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> Is that possible to do in a C macro?  Doesn't seem to work for me...

The meat of that macro could easily be done as a helper inline function.

But as mentioned, I think a better option would be to remove it
entirely, if at all possible.

The best part about that config option is the comment, and while cute
I don't think that's really worth saving it for...

               Linus
