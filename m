Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EAEDC73C63
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 01:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08DB02064B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 01:55:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qLm5259L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbfGJBzA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 21:55:00 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43146 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726392AbfGJBzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 21:55:00 -0400
Received: by mail-qt1-f195.google.com with SMTP id w17so743309qto.10
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2019 18:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZG+SLoFbXX4Od0nM5B6gRV8rqqx+99je3gS//xwd4IY=;
        b=qLm5259LiImVO0sdHl6Faq5ISIY0gmohJ5aSkskB6WUvcXnJ/JnaAunHPBTA8FPPJB
         9RcHRnwqvWhGsl5dGGmnprtH1buqRANCBUwPNo2j6VPKNR8GYpZMzAYykkkTGorbmv4C
         9pnAwCHL2+sT2GIa7I+V4dRg7u4wL28+Fkdn8SIhXBj/xUKf6QqUQTgpqj08ilSZpxHd
         tZF3cXSatKm12Huuaw+Gn5M8BiO5EPgdIj4ojfDxBVjB/IrJANYGkrzbnRfbh0VfRUVN
         MzzbGXqc8wZs0BRoqnqdcHEyQTZnxUnI1jf7RUXPep1BqgiAONEFY3xEmWC2ldaH95G6
         9KWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZG+SLoFbXX4Od0nM5B6gRV8rqqx+99je3gS//xwd4IY=;
        b=eVtL5EvbhCZ3H6gehJYcYzSe+qIfu6Gj8YPyn0KGTElH114zZ7Ha7HRCxTj7GYql4I
         jQVzvCbjl6l5mLuid+anpssuFUtlPFVPPlHEb5IIyDuKROJdHwT6lWdZ7uACryhAgJgd
         r41ipumMo9LWGsB4ypE0hb+PbrWb3uKJdeii912IcN6lFrDnjt3MbErZAtP0doUHn/V7
         vKdJvia3K+xf1iVFpuoofom1cPTqR4/kXikA/x1T7OrO6yrZ4iPW2GsfKNlomw8gtKkD
         CEei1mph6tto5a0uR74BJKmiJ1fuXROFvIF6VJW2+nU4UQolAYyq/Ut9WYCTbASw/HCO
         Y0JA==
X-Gm-Message-State: APjAAAVT2bq9DR7d6yAnlBoBpUsIP8oiF8HH4+G9LkciEIDNfVAn7C4G
        Qrl1QCq0w85mrIqLS1AiKJCQwgBf7mjoK8iwId0=
X-Google-Smtp-Source: APXvYqwkiKT6mSwInxrO3HJiN1eWje48SQZG7q+SVMH5E6tZSsI1xO3iLf2VnG7pDJJFF9/vXbq/0c2hKS3LzlNo/nU=
X-Received: by 2002:ac8:359a:: with SMTP id k26mr20835352qtb.87.1562723699389;
 Tue, 09 Jul 2019 18:54:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190628091528.17059-1-duyuyang@gmail.com>
In-Reply-To: <20190628091528.17059-1-duyuyang@gmail.com>
From:   Yuyang Du <duyuyang@gmail.com>
Date:   Wed, 10 Jul 2019 09:54:44 +0800
Message-ID: <CAHttsrav5WLV5cmhE9z=61TZHrQHTtpPDtu=RpjMLGzZ8S9Jqg@mail.gmail.com>
Subject: Re: [PATCH v3 00/30] Support recursive-read lock deadlock detection
To:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Bart Van Assche <bvanassche@acm.org>, ming.lei@redhat.com,
        Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Waiman Long <longman@redhat.com>, paulmck@linux.vnet.ibm.com,
        Boqun Feng <boqun.feng@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping. Thanks.

On Fri, 28 Jun 2019 at 17:15, Yuyang Du <duyuyang@gmail.com> wrote:
>
> Hi Peter and Ingo,
>
> Historically, the recursive-read lock is not well supported in lockdep.
> This patchset attempts to solve this problem sound and complete.
>
> The bulk of the algorithm is in patch #27. Now that the recursive-read
> locks are suppported, we have all the 262 cases passed.
>
> Changes from v2:
>
>  - Handle correctly rwsem locks hopefully.
>  - Remove indirect dependency redundancy check.
>  - Check direct dependency redundancy before validation.
>  - Compose lock chains for those with trylocks or separated by trylocks.
>  - Map lock dependencies to lock chains.
>  - Consolidate forward and backward lock_lists.
>  - Clearly and formally define two-task model for lockdep.
>
> Have a good weekend ;)
>
> Thanks,
> Yuyang
>
> --
>
> Yuyang Du (30):
>   locking/lockdep: Rename deadlock check functions
>   locking/lockdep: Change return type of add_chain_cache()
>   locking/lockdep: Change return type of lookup_chain_cache_add()
>   locking/lockdep: Pass lock chain from validate_chain() to
>     check_prev_add()
>   locking/lockdep: Add lock chain list_head field in struct lock_list
>     and lock_chain
>   locking/lockdep: Update comments in struct lock_list and held_lock
>   locking/lockdep: Remove indirect dependency redundancy check
>   locking/lockdep: Skip checks if direct dependency is already present
>   locking/lockdep: Remove chain_head argument in validate_chain()
>   locking/lockdep: Remove useless lock type assignment
>   locking/lockdep: Specify the depth of current lock stack in
>     lookup_chain_cache_add()
>   locking/lockdep: Treat every lock dependency as in a new lock chain
>   locking/lockdep: Combine lock_lists in struct lock_class into an array
>   locking/lockdep: Consolidate forward and backward lock_lists into one
>   locking/lockdep: Add lock chains to direct lock dependency graph
>   locking/lockdep: Use lock type enum to explicitly specify read or
>     write locks
>   locking/lockdep: Add read-write type for a lock dependency
>   locking/lockdep: Add helper functions to operate on the searched path
>   locking/lockdep: Update direct dependency's read-write type if it
>     exists
>   locking/lockdep: Introduce chain_hlocks_type for held lock's
>     read-write type
>   locking/lockdep: Hash held lock's read-write type into chain key
>   locking/lockdep: Adjust BFS algorithm to support multiple matches
>   locking/lockdep: Define the two task model for lockdep checks formally
>   locking/lockdep: Introduce mark_lock_unaccessed()
>   locking/lockdep: Add nest lock type
>   locking/lockdep: Add lock exclusiveness table
>   locking/lockdep: Support read-write lock's deadlock detection
>   locking/lockdep: Adjust selftest case for recursive read lock
>   locking/lockdep: Add more lockdep selftest cases
>   locking/lockdep: Remove irq-safe to irq-unsafe read check
>
>  include/linux/lockdep.h            |   91 ++-
>  include/linux/rcupdate.h           |    2 +-
>  kernel/locking/lockdep.c           | 1221 ++++++++++++++++++++++++------------
>  kernel/locking/lockdep_internals.h |    3 +-
>  kernel/locking/lockdep_proc.c      |    8 +-
>  lib/locking-selftest.c             | 1109 +++++++++++++++++++++++++++++++-
>  6 files changed, 1975 insertions(+), 459 deletions(-)
>
> --
> 1.8.3.1
>
