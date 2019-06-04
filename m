Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E8AC04AB5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 03:04:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FD0C26155
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 03:04:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dURqAY7t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbfFDDEN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 23:04:13 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:42206 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbfFDDEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 23:04:11 -0400
Received: by mail-qt1-f194.google.com with SMTP id s15so12059104qtk.9
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 20:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lWwUvsAr9T4nSJk+dRlogEWMDvacYZxKYcOW5ekFU4A=;
        b=dURqAY7tExeylq0yOsamuJ16N5lt4vhiOzYwKYELEUMMaVnCFIpPhEA0W9axjo4uUj
         5Y8q3vrtpDRyYpEUFwyB4d48Zm5uYG+copb1ZzIlWmgoFDCPV25EBdvvuveF06NUIgQP
         3yfPwvVki4eyiIJOyJaKQBOInGlrJQlwVoXU+ac9pKdGbWvNe+LVY5Bn24+sbowCcUhj
         xKCAL4TFkGcR97fr+QgyAhWxCWQKWmmDmshQ1KV8uiP4tyun6N4U6qdsas92nd6IZo5J
         zYlAShbbkNgtbd18I97LUnRR8K4muLv7KpCviTjw9R2W01LeDEY+4/esjmY+TrBjPhGP
         gSpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lWwUvsAr9T4nSJk+dRlogEWMDvacYZxKYcOW5ekFU4A=;
        b=sdVzyDp/4XBsbq4AjNDc7AGeaPm3s8l2Npn9ERzdfWmVU4dFjzu3k5DYipsvQKydMi
         eUp32YLWumzOWrXkUhYKBarPdZ3IkbSlbfCypHMZum5ZxwPdM/3++UFGrx6JAqzH8a4V
         N3bMD6WVm8eCGyRLj/JXS+Rkmyqzma/ssSXFF2Pb9klEwEauyxqfqqYXh1eWxixHMHD1
         eLFOQSLCFMsANpzsV7mKma2lL/68S+Wt6gfBuEZ+RTgc8TR7MvjxHB7yzvFR1rf5YXUG
         L0wOWEzKTjLS/fAT/dZdy7LzSKfr7lYKrQDwbLRX+FTZaXjsnFfZKalzRtYv6oV8H1/a
         oeCA==
X-Gm-Message-State: APjAAAU8G/4a/HMzS2Ln4a+cb2I6X6jZqzWlkQkmgZhfsppn5Y04Fy1a
        o0aQiVjfSh1jGKIAJADHHSjqvkZ36gwfzAqyvLE=
X-Google-Smtp-Source: APXvYqwwbDl/SD0oSVeetHDAy1CgljBQzy5S02/5U+g17LzBEnxrQxr4rsnIHS9I5zbvbhHE9MrFaICnPq+qAmS11rY=
X-Received: by 2002:ac8:359a:: with SMTP id k26mr26024661qtb.87.1559617449970;
 Mon, 03 Jun 2019 20:04:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190520205918.22251-1-longman@redhat.com> <20190520205918.22251-8-longman@redhat.com>
In-Reply-To: <20190520205918.22251-8-longman@redhat.com>
From:   Yuyang Du <duyuyang@gmail.com>
Date:   Tue, 4 Jun 2019 11:03:58 +0800
Message-ID: <CAHttsrYx=pgen5yVpYfCKaymoCaA7iJ52B8t_ycD2UcDR2848Q@mail.gmail.com>
Subject: Re: [PATCH v8 07/19] locking/rwsem: Implement lock handoff to prevent
 lock starvation
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        huang ying <huang.ying.caritas@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Waiman,

On Tue, 21 May 2019 at 05:01, Waiman Long <longman@redhat.com> wrote:
>
> Because of writer lock stealing, it is possible that a constant
> stream of incoming writers will cause a waiting writer or reader to
> wait indefinitely leading to lock starvation.
>
> This patch implements a lock handoff mechanism to disable lock stealing
> and force lock handoff to the first waiter or waiters (for readers)
> in the queue after at least a 4ms waiting period unless it is a RT
> writer task which doesn't need to wait. The waiting period is used to
> avoid discouraging lock stealing too much to affect performance.

I was working on a patchset to solve read-write lock deadlock
detection problem (https://lkml.org/lkml/2019/5/16/93).

One of the mistakes in that work is that I considered the following
case as deadlock:

  T1            T2
  --            --

  down_read1    down_write2

  down_write2   down_read1

So I was trying to understand what really went wrong and find the
problem is that if I understand correctly the current rwsem design
isn't showing real fairness but priority in favor of write locks, and
thus one of the bad effects is that read locks can be starved if write
locks keep coming.

Luckily, I noticed you are revamping rwsem and seem to have thought
about it already. I am not crystal sure what is your work's
ramification on the above case, so hope that you can shed some light
and perhaps share your thoughts on this.

Thanks,
Yuyang
