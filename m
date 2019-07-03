Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43255C5B57D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 00:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15214219BE
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 00:30:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I0LWxM6d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727371AbfGCAak (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 20:30:40 -0400
Received: from mail-pg1-f173.google.com ([209.85.215.173]:37345 "EHLO
        mail-pg1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726963AbfGCAaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 20:30:39 -0400
Received: by mail-pg1-f173.google.com with SMTP id g15so230567pgi.4
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 17:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vn+LAxBJO7zxGvZ7qZMhFP9o+nyZP9kSApnr8HWEFrc=;
        b=I0LWxM6dylxeZ05/nj4aoBN7X/RCZTrN0PJSydzFd4UPU814KFD5BpK9lx9/rhjLXR
         Q8OqzdSdZJsCu3sBlmNq9VhRx2w/mHhbIE+vp4in58fCSfUVcTsh6/nwoWnobprAr6F9
         n5BFK0sxGgzxKkKho2sDVVZ1d5DCeR8mE2kvciHRn9wLMJ8JXBhJHgMlkXIzRFB68dLT
         pS/lQ9xWfByyLNgPHkp0I1k49SUKuyEre4Et/0ediDaJlpnIEqsLQk8jmMXCeJ1FG4vf
         BvE2DP/GXPNLnxvmWjXjo/ixOzpcId1eF6L6G7YFzc3L7HQCDzGjBythsulUwNPr1gok
         iMRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vn+LAxBJO7zxGvZ7qZMhFP9o+nyZP9kSApnr8HWEFrc=;
        b=qUJn6uWQUkSwIcVHYAJ1CDa6Cx1GPCGluvMLFy1k3ulLWw3RV4j2dSjQHb5iJFyZwa
         +C0IHHlQZjbANM2En8bSv0BnEO+SHgbcamAAcO3hMnOtYFzH+uJvpAwqYgW+F77r0iHI
         dom2Bnk8YTJwurlrsdmIhFiMfmMAhy5Z/7c4wuoxYcEZLT5z3zuzbJKadsKFpGLK6lBf
         MTcM+FWlPupGOLqwHkb7b0AYEuBNXskTOaFEFfbTbzi0qgCh215vymXn7dLoO8u0t8uj
         vuAT5C8+QLLzEKRgc4V90KWipQJ+RKxnbQBrB3FFGTw0WGfKqGb3CWzTQwE14Awvbn1j
         14rA==
X-Gm-Message-State: APjAAAX23FaSNwGGtsvBybujIykqlPDAyB2d1eLIY7kd7yU0KtDWwezm
        JBuOkN4Taz0Y6WT4WQAMFHs7DGuGSYQjIJpZekNpiQ==
X-Google-Smtp-Source: APXvYqx4jRLXTTfaBDu7oGjvQW1U3ugxjFYp6X0Mz+GfQZNQV4p/VDfNSi0vrPKvUv6EI5VN2dgK5l31VVxhLL6S4Fg=
X-Received: by 2002:a63:52:: with SMTP id 79mr33023414pga.381.1562113838414;
 Tue, 02 Jul 2019 17:30:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAKwvOdnGL_9cJ+ETNce89+z7CTDctjACS8DFsLu=ev4+vkVkUw@mail.gmail.com>
 <20190702220739.GJ32547@worktop.programming.kicks-ass.net>
In-Reply-To: <20190702220739.GJ32547@worktop.programming.kicks-ass.net>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 2 Jul 2019 17:30:27 -0700
Message-ID: <CAKwvOdk_faiFKC=hQ0beus5S_kcC0D3=k2rnja1wE_yMhCgPTw@mail.gmail.com>
Subject: Re: objtool warnings in prerelease clang-9
To:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kees Cook <keescook@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Craig Topper <craig.topper@intel.com>,
        Alexander Potapenko <glider@google.com>,
        Bill Wendling <morbo@google.com>,
        Stephen Hines <srhines@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 2, 2019 at 3:07 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
>
> Hi Nick,
>
> That is good news; and I'll strive to read the email in more detail
> in the morning when there is a better chance of me actually
> understanding some of it :-)
>
> But his here is something I felt needed clarification:
>
> On Tue, Jul 02, 2019 at 01:53:51PM -0700, Nick Desaulniers wrote:
> > Of interest are the disassembled __jump_table entries; in groups of
> > three, there is a group for which the second element is duplicated
> > with a previous group.  This is bad because (as explained by Peter in
> > https://lkml.org/lkml/2019/6/27/118) the triples are in the form (code
> > location, jump target, pointer to key).  Duplicate or repeated jump
> > targets are unexpected, and will lead to incorrect control flow after
> > patching such code locations.
>
> > Also, the jump target should be 0x7 bytes ahead of the location, IIUC.
>
> Even if you mean 'at least' I'm fairly sure this is not correct. The
> instruction at the 'code location' is either a jmp.d32 or a nop5 (both 5
> bytes). The target must (obviously) be at an instruction boundary, but
> really can be anywhere (it is compiler generated after all).
>

Got it.  Issue should be fixed outright with:
https://reviews.llvm.org/D64101 (I figured out how to fix the loop
unroller, so now we can proceed with the optimization instead of the
base conservative case).
-- 
Thanks,
~Nick Desaulniers
