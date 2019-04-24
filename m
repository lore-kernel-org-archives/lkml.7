Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCB9EC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:56:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D3972089F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556128588;
	bh=225g5NqxTGsZgapnTJ2tLSHKTrRYVOZmSfLdVtQFubE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=CozEwCzzO0iMuH30uniMMvxSsswHGUw5qTj9lsHaia2/cPSUKLLQDfSQHnbokUXgk
	 a/jYxaYtE0bWGCCV6uyYDVMNMS5IwJSesAEUN8GQ2+yYJvZ9P4FmjbjiEdjuxEPIN5
	 y6jUhSjSHT+POd6ZgfUuPH1y1UZ+hzn5aTYRNhl0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390316AbfDXR41 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:56:27 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45485 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390808AbfDXR4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:56:24 -0400
Received: by mail-lj1-f193.google.com with SMTP id y6so17712662ljd.12
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 10:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hAMP8lrnIAYvASMIpak2/qo17VBuOdCnb72SQGQnKPk=;
        b=Pq10Ge2gP/s9W7oSsdB/c6u6LKJMWhFciYSFHNDhMzz6ALdyugqQaS1y+WHW3T18xq
         G9EPbo/mv7TNQWWm4Ydgu+6hjxI4QHlI3hQZZdATGuF0R7V4m9quSMNk/2K2K35OvOp8
         jIXjIJ8rXClzaOmvT3sZDKaGEXa+AIVBXOeEU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hAMP8lrnIAYvASMIpak2/qo17VBuOdCnb72SQGQnKPk=;
        b=kc9yAg6NjTakkvjyootBWxgP+VTk4DadwLzGmsQbM7KLs4DhsMJqd+aeDUPN07oeCO
         WKVLl/KHeF9g/z+Q4t0NUqVwratO+dzFsW4jfg5x3VCrzTjxM64YmK+t/OtxeOCSXRfG
         li2eUHjpGHhKrilMuuniSqqMSBLPRCYOMZ05csCZie5DJvgFe5Im8/NS0gcPiZe1VQwe
         tTJ/F6RGd8G+4975SEk8kTkFNk+NpT3qUFWjYUtd8yC040Mwhp6+iekI0pUAHwBXtLhO
         nmFoar4TmH8EInZFRsl864li+Hiil4Ur35tEaQxpTbY+370ahucx1jITgwtanKJ3Vuq/
         VocA==
X-Gm-Message-State: APjAAAV5DI9U0Bq+e1W3C1MgGqOCR5/ZJFN0JIrj/NGznpbeA5XP1oXJ
        WetpfrdF1Eb+0MwraRFT9pibp+2XhOI=
X-Google-Smtp-Source: APXvYqyJMezR8XA4TT2BvhBeAYqIEKvB0hRNq5RIIbKCpOk66XFP2CfIn88vBJ2H9+cD7xOZifVdPQ==
X-Received: by 2002:a2e:810d:: with SMTP id d13mr18024499ljg.93.1556128581942;
        Wed, 24 Apr 2019 10:56:21 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id 77sm4069977ljs.58.2019.04.24.10.56.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 10:56:21 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id i186so3817693lji.9
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 10:56:20 -0700 (PDT)
X-Received: by 2002:a2e:9213:: with SMTP id k19mr3850766ljg.118.1556128580498;
 Wed, 24 Apr 2019 10:56:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190419120207.GO4038@hirez.programming.kicks-ass.net>
 <20190419130304.GV14281@hirez.programming.kicks-ass.net> <20190419131522.GW14281@hirez.programming.kicks-ass.net>
 <57620139-92a3-4a21-56bd-5d6fff23214f@redhat.com> <7b1bfc26-6e90-bd65-ab46-08413acd80e9@redhat.com>
 <20190423141714.GO11158@hirez.programming.kicks-ass.net> <CAHk-=whnQJ9YDrkcKteNSACMJxzw1bL0RPfGQsey_9Nm7b8mnw@mail.gmail.com>
 <4f62d7f2-e5f6-500e-3e70-b1d1978f7140@redhat.com> <20190424070959.GE4038@hirez.programming.kicks-ass.net>
 <51589ac0-3e1f-040e-02bf-b6de77cbda1d@redhat.com> <20190424170148.GR12232@hirez.programming.kicks-ass.net>
In-Reply-To: <20190424170148.GR12232@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 24 Apr 2019 10:56:04 -0700
X-Gmail-Original-Message-ID: <CAHk-=whA4dDdp+KT_ZWnKr5ERqhUtsf3wRTh7HL1Dcg0vGYV_g@mail.gmail.com>
Message-ID: <CAHk-=whA4dDdp+KT_ZWnKr5ERqhUtsf3wRTh7HL1Dcg0vGYV_g@mail.gmail.com>
Subject: Re: [PATCH v4 14/16] locking/rwsem: Guard against making count negative
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Waiman Long <longman@redhat.com>, Ingo Molnar <mingo@redhat.com>,
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

On Wed, Apr 24, 2019 at 10:02 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> > For an uncontended rwsem, this offers no real benefit. Adding
> > preempt_disable() is more complicated than I originally thought.
>
> I'm not sure I get your objection?

I'm not sure it's an objection, but I do think that it's sad if we
have to do the preempt_enable/disable around the fastpath.

Is the *only* reason for the preempt-disable to avoid the (very
unlikely) case of unbounded preemption in between the "increment
reader counts" and "decrement it again because we noticed it turned
negative"?

If that's the only reason, then I think we should just accept the
race. You still have a "slop" of 15 bits (so 16k processes) hitting
the same mutex, and they'd all have to be preempted in that same
"small handful instructions" window.

Even if the likelihood of *one* process hitting that race is 90% (and
no, it really isn't), then the likelihood of having 16k processes
hitting that race is 0.9**16384.

We call numbers like that "we'll hit it some time long after the heat
death of the universe" numbers.

     Linus
