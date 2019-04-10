Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F504C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 22:21:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66A3020818
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 22:21:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Q50iCGuk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbfDJWVb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 18:21:31 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:33342 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbfDJWVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 18:21:30 -0400
Received: by mail-ua1-f66.google.com with SMTP id g8so1361273uaj.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 15:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=boT/6riwdA2m3FxQ0jLzkBJdoIdhrXNKi7UsmGCQNCg=;
        b=Q50iCGuk1s4FMu7uPxo7AJcKBDeOGVVuU5GDs1SQ58P87qZgstj/5c/kHiF1+q9Chg
         d82TiMkdbiJnRjpfUxXc+EmMGrtJcZUKVsvC8VDd0f5y1EjbHoJtbctKSUCvwpLFE9hV
         j0nQQ61qVfyi1XygbbnDznnHUtKAQkTrNpYxA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=boT/6riwdA2m3FxQ0jLzkBJdoIdhrXNKi7UsmGCQNCg=;
        b=pRZhTguljQtagXmfcsYsqsnEMtzYXPztqUzWavAVisz7hzbZZM7UeChlznoSR5Ny2h
         n9XkhU/Kpcz5ZFNpIY4OJ3bX/cRCnPiaQoNjVbiOUnPcZZLw+noOjHb/8L2lhgFhH7B0
         cJq6Rtm4gvSPu/WVekKYjSH9EQSAQv3eROz9u2UOzMFUz/mQahr/pU66CPtajS4cGj25
         Bsf9wfydpV4WY9nKnWRBXbFB+5EiO5dVhpgrpfRgzOyo18PVJjWUSh5AwLiMYWR7JY8l
         uhTYIWqMGYEIHbNY7nPo+sDIO7HSn0YwVw5XIo1A0zJN0agN5UM93cpaitE4bCXP6Z2b
         iK6A==
X-Gm-Message-State: APjAAAWeke2x+ZIdjvLbqfayYPuhgjQoeAEgKs+wEY8BO9/w6KZhAZ5O
        XXmV9oYVokKB0mNGW4sNTf5tO8DtDtQ=
X-Google-Smtp-Source: APXvYqzJpZ3dfzDNRDFWbHJl1t9HF21fBkksq58JmT+ub0cT24t3QOpgTcurkpfqIO92QDjrwFTlGg==
X-Received: by 2002:ab0:278b:: with SMTP id t11mr22731142uap.88.1554934889212;
        Wed, 10 Apr 2019 15:21:29 -0700 (PDT)
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com. [209.85.221.178])
        by smtp.gmail.com with ESMTPSA id r24sm4534297ual.8.2019.04.10.15.21.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 15:21:28 -0700 (PDT)
Received: by mail-vk1-f178.google.com with SMTP id x2so925308vkx.13
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 15:21:28 -0700 (PDT)
X-Received: by 2002:a1f:7d4e:: with SMTP id y75mr25311986vkc.53.1554934886529;
 Wed, 10 Apr 2019 15:21:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190410212627.29514-1-okaya@kernel.org> <CAGXu5j+uBuPjDc+gGcxW_QoJJi7sQZ8m=Zg-Q2wKDxyTt7yGvg@mail.gmail.com>
 <a9508cc3-3385-256e-2f27-c1e0a770ba69@kernel.org> <CAGXu5jLPxUESH9eMm6rvaTVue_9rNEdx+9dcxiV11kgi03jUmA@mail.gmail.com>
 <ac8f52a9-30a4-41fd-50f6-65c8ae859675@kernel.org>
In-Reply-To: <ac8f52a9-30a4-41fd-50f6-65c8ae859675@kernel.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 10 Apr 2019 15:21:15 -0700
X-Gmail-Original-Message-ID: <CAGXu5jLsdSsgVmAU57rpBVAYK6-KxEhzDKj-w5-z2c+dsofD-Q@mail.gmail.com>
Message-ID: <CAGXu5jLsdSsgVmAU57rpBVAYK6-KxEhzDKj-w5-z2c+dsofD-Q@mail.gmail.com>
Subject: Re: [PATCH v1] init: Do not select DEBUG_KERNEL by default
To:     Sinan Kaya <Okaya@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Adrian Reber <adrian@lisas.de>,
        Richard Guy Briggs <rgb@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 3:18 PM Sinan Kaya <Okaya@kernel.org> wrote:
>
> On 4/10/2019 6:04 PM, Kees Cook wrote:
>
> >> I don't want any of the debug features in my kernel but still
> >> need all the expert features. My kernel is considered a production
> >> kernel. I don't really want to ship all the good debug enables.
> >
> > Production kernels enable it. e.g. Ubuntu:
> > $ grep '\bCONFIG_DEBUG_KERNEL\b' /boot/config-$(uname -r)
> > CONFIG_DEBUG_KERNEL=y
> >
>
> It makes sense for a general purpose operating system. It doesn't apply
> to my limited case where I'm very concerned about image size.

Gotcha.

>
> >> I don't see the relationship between CONFIG_DEBUG and CONFIG_EXPERT
> >> as none of the features except KALLSYMS depend on it. If there was
> >> a compile time dependency, I'd say move it to the things that need
> >> it as this patch suggests.
> >
> > CONFIG_DEBUG_KERNEL mainly only enables the visibility of various
> > other options. I can only find two instances of it controlling a
> > "default", and one is overridden by CONFIG_SMP on alpha. :)
> >
> > $ git grep -B2 'default.*DEBUG_KERNEL'
> > arch/alpha/Kconfig.debug-config MATHEMU
> > arch/alpha/Kconfig.debug-       tristate "Kernel FP software
> > completion" if DEBUG_KERNEL && !SMP
> > arch/alpha/Kconfig.debug:       default y if !DEBUG_KERNEL || SMP
> > --
> > kernel/trace/Kconfig-menuconfig FTRACE
> > kernel/trace/Kconfig-   bool "Tracers"
> > kernel/trace/Kconfig:   default y if DEBUG_KERNEL
>
> If the idea is to just show, nothing should happen based on
> DEBUG_KERNEL, right?
>
> No default selection as in FTRACE, no c/S file changes in the code
> path as Mathieu identified.

Yeah, this is clearly a problem. I hadn't looked for code #ifdefs :(

> I can go after individual enables if you agree assuming Mathieu will
> go after the changes in the other email. Let me know otherwise.

How about you split it, but make DEBUG_KERNEL be "default EXPERT" that
way enabling EXPERT will enable DEBUG_KERNEL still in the default
case?

-- 
Kees Cook
