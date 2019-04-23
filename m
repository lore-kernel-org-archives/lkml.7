Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B11F0C282DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 16:28:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83C2F20645
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 16:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556036884;
	bh=iUAw/C0wzaQ8tbNHZLeELmihlk7coMMmIZIUXTYT1+s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=O6BgUacfQCQg2u0tBdhM17RqftdrQBLamABZiT5gg/0qlJYMoYiFg3XC/o7XZ+h8R
	 hJxwWHfZgHiQ5schmk5JGjPsZsj6oNkDaev3I/vdFuilABYELkGB7wdIFcQP0GU5cn
	 ivvk8/DubKFBltut0aaIUCxHi35KFJXJwUJYm2V4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728659AbfDWQ2D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 12:28:03 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:35790 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726655AbfDWQ2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 12:28:01 -0400
Received: by mail-lf1-f67.google.com with SMTP id j20so12258931lfh.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 09:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hq70GMyrcNpGr6YMX9JFvVr2SCmZbppu9orqm02sFio=;
        b=KBRmA2LB3iAsjQu2OQJW3Hl0mMgLHWznuPkQMIXsh2VmkHwKK6kscei+aNySlhF4ir
         2IOaC70fvmdKl8NZnB1olK9EvONMsWvsQhzk8ZBhD9JrIr2dgLUCHJdyYZUYv3IB9HdG
         MXxZPEjm8P+dW9F+5LrOytZF15RHV2ERumCPk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hq70GMyrcNpGr6YMX9JFvVr2SCmZbppu9orqm02sFio=;
        b=FcEdY9UsMKjutFFBtTZQhinCLUTUTnWQ8WtAf7R0Cx/j2T26l8WVTW636kUjbnQCqh
         PpiqZ1P8cJ7/s5dVi3GjzSqKNHxnogudQlYE5U2LkFshK0C8U1Y3F3528EkxrGk9yduL
         NRID6zAszueHxOoQPrBoZ1nm7hzXHrhlKaCmamPfjxf1HdgI9UFVJK0wzRWyaVEzy64H
         6JCnG4VAadCBH/SkUmmNvZSIGOKJxEa3Gy4akJPMjaC9L1ExiNYWSXuMh3rTnXg/3BGA
         zZ4Aelmc4tUaSM+el+J2Ut94doDEIRxfGR1qkHSl9U8Wakm54gNYnPEoUQGqvw8L8xMd
         X+ZA==
X-Gm-Message-State: APjAAAXGqU3YQXa74mIvJN+2ZlPECmLwZ4m9SFT6QTygxz122MwUF8zU
        tNo9xcw/Tkps9W342wHErkaN9msbOJ4=
X-Google-Smtp-Source: APXvYqxOKjyE93AVcGaYKkJjO2mp7b273In9GlsHsunIXMAVeIOdc04ttBPIasnTvusxomEAq918Kw==
X-Received: by 2002:a19:760f:: with SMTP id c15mr13963117lff.105.1556036878681;
        Tue, 23 Apr 2019 09:27:58 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id c5sm4553524ljd.18.2019.04.23.09.27.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 09:27:57 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id q66so14086414ljq.7
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 09:27:57 -0700 (PDT)
X-Received: by 2002:a2e:960b:: with SMTP id v11mr14076652ljh.135.1556036876926;
 Tue, 23 Apr 2019 09:27:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190418135151.GB12232@hirez.programming.kicks-ass.net>
 <d931916b-41f5-f12d-8c38-0cccbc00a301@redhat.com> <20190418144036.GE12232@hirez.programming.kicks-ass.net>
 <4cbd3c18-c9c0-56eb-4e01-ee355a69057a@redhat.com> <20190419102647.GP7905@worktop.programming.kicks-ass.net>
 <20190419120207.GO4038@hirez.programming.kicks-ass.net> <20190419130304.GV14281@hirez.programming.kicks-ass.net>
 <20190419131522.GW14281@hirez.programming.kicks-ass.net> <57620139-92a3-4a21-56bd-5d6fff23214f@redhat.com>
 <7b1bfc26-6e90-bd65-ab46-08413acd80e9@redhat.com> <20190423141714.GO11158@hirez.programming.kicks-ass.net>
In-Reply-To: <20190423141714.GO11158@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 23 Apr 2019 09:27:40 -0700
X-Gmail-Original-Message-ID: <CAHk-=whnQJ9YDrkcKteNSACMJxzw1bL0RPfGQsey_9Nm7b8mnw@mail.gmail.com>
Message-ID: <CAHk-=whnQJ9YDrkcKteNSACMJxzw1bL0RPfGQsey_9Nm7b8mnw@mail.gmail.com>
Subject: Re: [PATCH v4 14/16] locking/rwsem: Guard against making count negative
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Waiman Long <llong@redhat.com>, Waiman Long <longman@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        huang ying <huang.ying.caritas@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 7:17 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> I'm not aware of an architecture where disabling interrupts is faster
> than disabling preemption.

I don't thin kit ever is, but I'd worry a bit about the
preempt_enable() just because it also checks if need_resched() is true
when re-enabling preemption.

So doing preempt_enable() as part of rwsem_read_trylock() might cause
us to schedule in *exactly* the wrong place,

So if we play preemption games, I wonder if we should make them more
explicit than hiding them in that helper function, because
particularly for the slow path case, I think we'd be much better off
just avoiding the busy-loop in the slow path, rather than first
scheduling due to preempt_enable(), and then starting to look at the
slow path onlly afterwards.

IOW, I get the feeling that the preemption-off area might be better
off being potentially much bigger, and covering the whole (or a large
portion) of the semaphore operation, rather than just the
rwsem_read_trylock() fastpath.

Hmm?

                   Linus
