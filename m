Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADF87C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 14:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DF7620850
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 14:18:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TBdoOy6g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732610AbfDJOSY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 10:18:24 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:34849 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731287AbfDJOSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 10:18:23 -0400
Received: by mail-lf1-f68.google.com with SMTP id u21so1993653lfu.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 07:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tvIi4gBRIzauHyn+/17L1Jg3co02CCis5UuW49+Fkic=;
        b=TBdoOy6gIftbr3TE+ENeS5qPHiRQkHm/3QsV/yTkaxzEbkqemBfL5lPRCNf5TScIhc
         W5DZKehOkc3DdI+yQLJOM8tH/gjIjaCOCWyZH9lY0hCbKzWN79qZstIj6z0EuQntb/X4
         t0QNQSi3uXvZQwWu7Z12kij5JSm3Mf2yfOzvPvBQyICRPE1zm0EB6Ca2RtoTTqUf6TzG
         IOg2QBuNokxscI8Sww7WR0DRrFtMR6H1P1J8sLCYXakTgGsuS7nESonenwNmBaZTLj0j
         B0+KzguUe5NwrJyRIP3h6fo9Adxa5Zh9L68zegYtEIGuFGKKnmVqJwA3EfyeN8BsQK3i
         UCYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tvIi4gBRIzauHyn+/17L1Jg3co02CCis5UuW49+Fkic=;
        b=lHC0gGWOzQ19wUNIvCida4tlWTgvgOzEXkv7MBdSxEinb7OQj6KVUCcBvpaxu9rpnn
         1t8SrkaIWCOYlc8Phu8ZGekNKYrnXRofB/bfXsHvK+8R75zdUm0gCcfXnbw9qzPx//tl
         QIWrQqPIkHkMpobXlDz2toV3KIylxaDFjbPptMT5RA4xqI0I+sdpiYYYH4iCbYp/PIRQ
         TX48SyvZkjBpJ/eqSQ44HMHvBDgtcBL49W/iTbz2gW5X0BpZSFwq/sxHaVjiyKmo3Dt7
         kVXXswzdMOYjDUeIuSdKMzjhCAkOUMwB2DCYevs3+jkiwL+Cl3JCU6UE4PFJYbnwpzht
         VswA==
X-Gm-Message-State: APjAAAXmj956lQRrjWNrgluIsp5/rrfjq3y8pO6EFeOymCJNq4NNUWfP
        USCBJhL242GOIbAYqF31VClwHueP21Z6DG2Xmzw=
X-Google-Smtp-Source: APXvYqw88wMSj8rTsg8RCbo1xF01Ov5nexXLU9YTy7mJt2WOf0kxlnnqCtnCCrEAe/w7qOmsCpY/aS7L5woitGZ/ZEw=
X-Received: by 2002:ac2:44a6:: with SMTP id c6mr23602158lfm.31.1554905901715;
 Wed, 10 Apr 2019 07:18:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190218165620.383905466@infradead.org> <20190218173514.667598558@infradead.org>
 <20190402064612.GA46500@aaronlu> <20190402082812.GJ12232@hirez.programming.kicks-ass.net>
 <20190405145530.GA453@aaronlu> <460ce6fb-6a40-4a72-47e8-cf9c7c409bef@linux.intel.com>
 <20190410043633.GA67532@aaronlu>
In-Reply-To: <20190410043633.GA67532@aaronlu>
From:   Aubrey Li <aubrey.intel@gmail.com>
Date:   Wed, 10 Apr 2019 22:18:10 +0800
Message-ID: <CAERHkrsKMm7f2auaQwY5=rodQr5T0kbOo2N1DCUCQcuUOpsEMg@mail.gmail.com>
Subject: Re: [RFC][PATCH 13/16] sched: Add core wide task selection and scheduling.
To:     Aaron Lu <aaron.lu@linux.alibaba.com>
Cc:     Tim Chen <tim.c.chen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Subhra Mazumdar <subhra.mazumdar@oracle.com>,
        =?UTF-8?B?RnLDqWTDqXJpYyBXZWlzYmVja2Vy?= <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 12:36 PM Aaron Lu <aaron.lu@linux.alibaba.com> wrote:
>
> On Tue, Apr 09, 2019 at 11:09:45AM -0700, Tim Chen wrote:
> > Now that we have accumulated quite a number of different fixes to your orginal
> > posted patches.  Would you like to post a v2 of the core scheduler with the fixes?
>
> One more question I'm not sure: should a task with cookie=0, i.e. tasks
> that are untagged, be allowed to scheduled on the the same core with
> another tagged task?
>
> The current patch seems to disagree on this, e.g. in pick_task(),
> if max is already chosen but max->core_cookie == 0, then we didn't care
> about cookie and simply use class_pick for the other cpu. This means we
> could schedule two tasks with different cookies(one is zero and the
> other can be tagged).
>
> But then sched_core_find() only allow idle task to match with any tagged
> tasks(we didn't place untagged tasks to the core tree of course :-).
>
> Thoughts? Do I understand this correctly? If so, I think we probably
> want to make this clear before v2. I personally feel, we shouldn't allow
> untagged tasks(like kernel threads) to match with tagged tasks.

Does it make sense if we take untagged tasks as hypervisor, and different
cookie tasks as different VMs? Isolation is done between VMs, not between
VM and hypervisor.

Did you see anything harmful if an untagged task and a tagged task
run simultaneously on the same core?

Thanks,
-Aubrey
