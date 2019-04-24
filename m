Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28AC6C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:06:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9449218FE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:06:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="gwlF17+d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727397AbfDXOGF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:06:05 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:36028 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbfDXOGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 10:06:04 -0400
Received: by mail-io1-f67.google.com with SMTP id d19so11692458ioc.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 07:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to;
        bh=bfi6hU0fzLUzQ0C3iIvMYCD+NlHGclLmaRNIdLTsmoc=;
        b=gwlF17+dOjw96nbtZgpkzfROfnAokfJQGZty2Yaon0zFFtgItsm6ASL8mfIfTQjG6A
         jjUnvrxw2AkCimPjwAUHItE7YyaQ5fPbFc07Kcgmxj1dMuxMZfZVJWKWi/T7O/+d8gfM
         UnapEkjPf0ESsNkGkCdSpkE0shdC7Mgv4rePU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to;
        bh=bfi6hU0fzLUzQ0C3iIvMYCD+NlHGclLmaRNIdLTsmoc=;
        b=FPSwGz87VZe0XwKUpBeDLz6Jh6DEuAS14PlGXsuxLXmK/p4f7y+pqeqNnZWh8F/KWI
         VZoOOq5OakkmdtD4cZQVcR0kK0iyT/iYeO7Np8tSkdl6mYnzjBqCayF9RSc/j0ezvlR9
         S3LOU+m9odns83qte3EG3UhpLi2fgPPcsAJoB96+hrxQsZXZo2CsreOboNk3fOpam//J
         xEdEWM7n+hrgeYOg+UAoqJEDDUpmYMzhumAx0QVQczBg7ClwLEr9SPBVCzG3ok+KY5jx
         dC/B8RxgRtoEVmJPmUMKYoduh/kQgOzkKgW1bVTX0jTNF0CLDlNUpHKk0MrFUH/94CkO
         Dkew==
X-Gm-Message-State: APjAAAVrEz+H4j2OkZ3LycPKB70BTJUmiKVZ07Uu5UzvnDDKBUD9Kb6l
        FoNfQlbq6N8OCozhs340fC6tNQ==
X-Google-Smtp-Source: APXvYqzb2pSgWA1XPK0s7hYfX0spUm21vw6WrENDW7E6Wur2n8sXcPiLtp6O9AgLXjxFFG0e3l6BwA==
X-Received: by 2002:a6b:c9d0:: with SMTP id z199mr742190iof.223.1556114763988;
        Wed, 24 Apr 2019 07:06:03 -0700 (PDT)
Received: from swap-tester ([178.128.225.14])
        by smtp.gmail.com with ESMTPSA id a23sm6881948ios.20.2019.04.24.07.06.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Apr 2019 07:06:03 -0700 (PDT)
From:   Vineeth Remanan Pillai <vpillai@digitalocean.com>
To:     Aubrey Li <aubrey.intel@gmail.com>
Cc:     Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, subhra.mazumdar@oracle.com,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Aaron Lu <aaron.lwe@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Phil Auld <pauld@redhat.com>
Subject: Re: [RFC PATCH v2 15/17] sched: Trivial forced-newidle balancer
Date:   Wed, 24 Apr 2019 14:05:54 +0000
Message-Id: <20190424140554.17590-1-vpillai@digitalocean.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CAERHkrtP90QJCc-xxqxJbiWg+0jod_U2i-tHayw=Wd+WRDdTFQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> try_steal_cookie() is in the loop of for_each_cpu_wrap().
> The root domain could be large and we should avoid
> stealing cookie if source rq has only one task or dst is really busy.
>
> The following patch eliminated a deadlock issue on my side if I didn't
> miss anything in v1. I'll double check with v2, but it at least avoids
> unnecessary irq off/on and double rq lock. Especially, it avoids lock
> contention that the idle cpu which is holding rq lock in the progress
> of load_balance() and tries to lock rq here. I think it might be worth to
> be picked up.
>

The dst->nr_running is actually checked in queue_core_balance with the
lock held. Also, try_steal_cookie checks if dst is running idle, but
under the lock. Checking whether src is empty makes sense, but shouldn't
it be called under the rq lock? Couple of safety and performance checks
are done before calling try_steal_cookie and hence, I hope double lock
would not cause a major performance issue.

If the hard lockup is reproducible with v2, could you please share more
details about the lockup?

Thanks
