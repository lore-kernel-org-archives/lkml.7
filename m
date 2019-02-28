Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C2DFC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 18:29:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44B84218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 18:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551378588;
	bh=RI4oguNEOjTg4gEURTbF3rVbBvcx2OwUgHDnoDxViqQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=RJp21iyA1vOIzyd8O0s+RNcisrSxT+XH9WWu5imdeslgrrbuWdAOgwyOu9r6ZGilL
	 /3Z0r1pEvgxyWFzvWvf3gTgbhT3CGT44OYeKb9fkXj+Ie0HXzxR25gWlYUp91ziSDP
	 nMT390/EM8juYVkOVARSlkYSQhTgWsl5NxRXhXQg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733217AbfB1S3q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 13:29:46 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43439 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727871AbfB1S3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 13:29:46 -0500
Received: by mail-lj1-f193.google.com with SMTP id z20so18021548ljj.10
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 10:29:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hfB+xbqViD526mTFHY/rWbd3/CNd8o7FrsgpcKHfHko=;
        b=aiTIjuvmqV+lvxjz76GDPcC8uiZwU+1W0ywuiC50Ji+acOpW9LN18J51ETYq18eoyG
         0vq0SvBZa9CCBs/3Ld1dve7IYMCeudJxuZf/E2zRf34CssqcAOt5TCOKf/HKjQ8g4ET7
         3qd6TfZNbHDMVK4V7QT+3hq4BesEa1NacqiRE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hfB+xbqViD526mTFHY/rWbd3/CNd8o7FrsgpcKHfHko=;
        b=uE9+6t39xARvMQeepHg7XPP65wOGrzQbd+6JAPVRwgG7XGwTMvK7rI9ncxqiF1BfJM
         AtekvK0v4pgh21II+PB12EP12giE3rb7ipXoCkDXhN4RpBGMNDmkzPiAWHh23cahwu0u
         CSx0/CDp8/wEMW7gCweSFLXlNEQ6UO3+TdOsyXiDK7a6Stf/gvUDyKuVnkEDE5ZG8nrW
         9Hgyj7c7BMibww4Wqyrf73LH3bo3YDPn/ZAWAPXHbtNA8RStLOaf5Z8XL+eR+G+i1IDg
         QjoPsO+S0jNCxjFy0UinpEnpD5Y1HRBMy/+HBCBz92OFMimMLHTP76TQX7rrNUM0TJJt
         uYNA==
X-Gm-Message-State: APjAAAWmYZ5YLqvpxowwM046PESZp1yPibWu1rD9ad59JEabQ9omEXup
        GPYa2ALEGEIiKnkidFKUNVZbyKFDUsQ=
X-Google-Smtp-Source: APXvYqwcn5oFXiZMYVZJVswQTSfaRRXkI/Zy9zju56fGYA3OFc+JTmrwE5hqPfyY401kDWnwqaTlNw==
X-Received: by 2002:a2e:4285:: with SMTP id h5mr224812ljf.32.1551378582851;
        Thu, 28 Feb 2019 10:29:42 -0800 (PST)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id m21sm4031415ljc.11.2019.02.28.10.29.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 10:29:41 -0800 (PST)
Received: by mail-lf1-f50.google.com with SMTP id u21so16042284lfu.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 10:29:41 -0800 (PST)
X-Received: by 2002:a19:4ac4:: with SMTP id x187mr534872lfa.166.1551378581006;
 Thu, 28 Feb 2019 10:29:41 -0800 (PST)
MIME-Version: 1.0
References: <20190228145450.289603901@infradead.org> <20190228150152.540038736@infradead.org>
 <CAHk-=wgsSXxL5c2Lbmbai=bcCgN0G=jPO+gWhQ3a+wx-LTaFkQ@mail.gmail.com>
 <20190228175114.GG32494@hirez.programming.kicks-ass.net> <20190228180154.GO32534@hirez.programming.kicks-ass.net>
In-Reply-To: <20190228180154.GO32534@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 28 Feb 2019 10:29:25 -0800
X-Gmail-Original-Message-ID: <CAHk-=whJww5smbSU2VzvcR7tajNqp=i9ZBYHK3RvwVXbs+V_JQ@mail.gmail.com>
Message-ID: <CAHk-=whJww5smbSU2VzvcR7tajNqp=i9ZBYHK3RvwVXbs+V_JQ@mail.gmail.com>
Subject: Re: [PATCH 6/8] i915,uaccess: Fix redundant CLAC
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Peter Anvin <hpa@zytor.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Ingo Molnar <mingo@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>, valentin.schneider@arm.com,
        Brian Gerst <brgerst@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Chris Wilson <chris@chris-wilson.co.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 10:02 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> Weird, that jump is from C, not from a .fixup table. objtool _should_
> see that and complain if there is a AC=1 path that reaches RET.

No, unsafe_put_user() actually does the "asm goto" thing, so the jump
is literally hidden as an exception entry. And apparently objtool
doesn't follow exceptions (which *normally* doesn't matter for code
liveness analysis since they normally jump back to right after the
excepting instruction, but maybe it misses some exception handling
code because of it?).

You may have looked at unsafe_get_user(), which does indeed make the
branch as C code, because gcc currently does not allow outputs from
"asm goto" statements (which "get" obviously needs).

[ One of these days I really should look at the gcc sources to try to
figure out why gcc doesn't like them. I wish we could have a rule like
"it's an output only for the fallthrough case, not for the goto
cases". Because I wonder if the gcc peoples aversion to "asm goto" and
outputs comes from "we can't set outputs in multiple places". But my
gcc-foo is not strong enough that I've felt confident enough to really
go take a deep dive into something that feels pretty subtle, so I've
_thought_ about doing it for a long time, but have never actually
built up the confidence to do so ]

                    Linus
