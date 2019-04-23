Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E02DC10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 20:27:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D5F321773
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 20:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556051273;
	bh=SeD+nzS6ay4LxdEVWQDczghu8ed+oUMgDFabvO6Gqvw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=CXy0krFCK+vieiG0XezXA+T6aI9l5MLkD9DPM0C0iQKc7nUWxP9C7wihn5x4ZVm8P
	 JKtGWtiEggWDcOx4f3A/0NLzjDy+aHHBf6qNxvxoAUT4OaYL3c2qm2Uty8Fml5p302
	 rzE9dMm0Y4/6hH0z8wwm9it+1KQbeXytbiHhtgss=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727283AbfDWU1w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 16:27:52 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:34316 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbfDWU1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 16:27:51 -0400
Received: by mail-lf1-f67.google.com with SMTP id h5so12765752lfm.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 13:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Tgn11LGFeELKyUgvqpY2du2plaeY7T4q1kaUk3Z+uew=;
        b=XV+JotLC70gIzBW9D2y8SjKqs6enqpD9qJNN1YzBbjOFrMeC8SmLZ+EJkmnPEPYdPH
         n6+BqR+ENhaP34iI5skB4mYQ2uwC934+SWHf80RqZ1hPzV+RyOcI+fUtcO+le9qUjK8x
         IB7Z945H7DIbZPMWCP8OMhLV93lOOsmmWmZsc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tgn11LGFeELKyUgvqpY2du2plaeY7T4q1kaUk3Z+uew=;
        b=sXux7SNzM8JKK3SshE4knrRzxk+aE/HoYh/ql2tcra9pkUlKE42lf+c00d/AMiq4mf
         RAVx8Kp6gOvmB5/tmXO67O9xUWQHsv94ZlcmQmafs/Q8mGvx1iwGHWQm0zbflE0UNqqR
         uW1g26VG0vVlKrw7lqKkVCeBexxmdhHFKjegReWYGICGM0AXOzv1JeVyx3OZzhnDdzEm
         SBntLFZxJAq1TfLX6llnXdSfzpuAWJqEoJC0toqH5Uo0fjsfYKiBrArufgiN7a43+EqC
         HxdBxz4Eq9vc+TvliGXBKmP9e2VdimW7G3ll9hNSJTlqyI7E1bVyHgr+ItFZu5S0EybC
         /ElA==
X-Gm-Message-State: APjAAAXhxi0KUIt6UX059yVGaAsaCp3ND362iNtrpQXu36iK8s+uKiQd
        TZpFbfoP06tgtbm/+90PibNzQE7KvaU=
X-Google-Smtp-Source: APXvYqzfsdSlMEyfCetj+Eq92cwDmqXyPKGd7+2KapX7crU/zLicDVKpWG2xQvsa9Oa7EST/VTpBOQ==
X-Received: by 2002:a19:ed04:: with SMTP id y4mr14880401lfy.165.1556051268828;
        Tue, 23 Apr 2019 13:27:48 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id r3sm3658721ljr.7.2019.04.23.13.27.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 13:27:46 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id k2so452648lje.10
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 13:27:46 -0700 (PDT)
X-Received: by 2002:a2e:3c12:: with SMTP id j18mr14948521lja.193.1556051265814;
 Tue, 23 Apr 2019 13:27:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190419120207.GO4038@hirez.programming.kicks-ass.net>
 <20190419130304.GV14281@hirez.programming.kicks-ass.net> <20190419131522.GW14281@hirez.programming.kicks-ass.net>
 <57620139-92a3-4a21-56bd-5d6fff23214f@redhat.com> <7b1bfc26-6e90-bd65-ab46-08413acd80e9@redhat.com>
 <20190423141714.GO11158@hirez.programming.kicks-ass.net> <CAHk-=whnQJ9YDrkcKteNSACMJxzw1bL0RPfGQsey_9Nm7b8mnw@mail.gmail.com>
 <4f62d7f2-e5f6-500e-3e70-b1d1978f7140@redhat.com> <20190423193435.GX4038@hirez.programming.kicks-ass.net>
 <88ba7be0-9ec5-941e-1b3f-80fbe05fe3a0@redhat.com> <20190423195559.GY4038@hirez.programming.kicks-ass.net>
In-Reply-To: <20190423195559.GY4038@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 23 Apr 2019 13:27:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgopkA+NiFCDOBcc24usK8hwL9CnQGzmv_4j8zJLGTrqA@mail.gmail.com>
Message-ID: <CAHk-=wgopkA+NiFCDOBcc24usK8hwL9CnQGzmv_4j8zJLGTrqA@mail.gmail.com>
Subject: Re: [PATCH] bpf: Fix preempt_enable_no_resched() abuse
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Waiman Long <longman@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        huang ying <huang.ying.caritas@gmail.com>,
        Roman Gushchin <guro@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 12:56 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> Unless the very next line is schedule(), or implies it, one must not use
> preempt_enable_no_resched(). It can cause a preemption to go missing and
> thereby cause arbitrary delays, breaking the PREEMPT=y invariant.

That language may be a bit strong, or m,aybe the "implies it" might at
least be extended on.

It doesn't need to be "schedule()" per se, it can be any of the things
that check if we _need_ to be scheduled.

IOW, various variations of "if (need_resched())" exiting a loop, and
then outside the loop there's a cond_resched() or similar.

                    Linus
