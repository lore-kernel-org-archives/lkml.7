Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ECB9C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 10:01:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58D202133D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 10:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554890461;
	bh=SolVYzPbTVQJVrTHGLbEqoVV5NMMIq7ltnUIUbvKlxE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RuxcuVbjUlLSKjiqIN+4WK4LHqPKjcYTRQOnrPLwyYMuqNorQHKUrIDE8uFtufv8b
	 UVNYnV0qYSpZm3tQbIlt7D0fbDcJqELOigHSLtXhYqDuVChbMZND7Q+FJg9KZBoHwh
	 /8c1dSirSho8+grVoQKv8pVzZ/64lPp7iXqj0ZX8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729037AbfDJKBA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 06:01:00 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40747 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbfDJKA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 06:00:59 -0400
Received: by mail-wm1-f67.google.com with SMTP id z24so1886456wmi.5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 03:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GG6UNPKytjVIcZYWooBv/xzUmlWJ8dk8kwXm0vupx+I=;
        b=d06YB7CtkWukAXsfcpz5pd/xE9LxC1P7Rmgs7wC8Y9MeYi0F0o0ROt6mOCkKt3fAyn
         aFrBbdMErGr6QMo+dRW1XWSHB3+N+aYcI3vwF88BxJSNP4DJtYO/QjU/qKjlR3qrjHAD
         Fen0MLzxxMBiopdhQsvfu0g5uUSaOJtVwd73mYqN95/9nKXqYipeKvnD3s8jrLnRoE6B
         deR9v+DibUR7yBY0dBVMCNPD8AW0/k+SVXqZ0Fl18BrJ0aG+1aOn6DmiwYxQvpDCHUYf
         9FEl8NDbWyKecrHbsupXj7JVCLXx2PPDCPiTUh/KE/GA/CYu0/qp/qpUUX9a8eZTwQF4
         lOSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=GG6UNPKytjVIcZYWooBv/xzUmlWJ8dk8kwXm0vupx+I=;
        b=a2s27rE2hpJNCpCOG4fQEu/qwciUWAuSUaBmUnqIOlf3px21LpmEkWwW/L9rzNSeVz
         yUk3a3UUKTFD1e7GNVAp5115iIoPaYb15xv1/ia7bgM7gw92c95V4+WA8e/rvYNmnPMV
         tX76diTw6KmNufQM2uSuqgAwaWt33yva6XZTaES96fzYMa7snobtwx0MvlYfcQwQmZf2
         W/4gd04Z6i1zA2sn7WmkunSUpbqjLDsw6MVlO4dE2TyRVhdR4MVWSb4x25wfyqt/uo61
         nikWYNkAy3bCirRfW11OfhD6gzMpGVah3iWuoIATG6YMZYqxYyLEtaaE+T27Hh7QbOSo
         WeCg==
X-Gm-Message-State: APjAAAXvWmWEFBdsRBx8VVQWfl/28HhreiEo/3uMIjhT2wFx01LTyH6k
        rssNx0Smly0Upnj6Jch6zOg=
X-Google-Smtp-Source: APXvYqxCSR5mH0a3yiZ4ilvjtvYmlSV5aSCPeof+9yFFYiSxLlRdbMyYenW6yHhqtCb6hsF3bI/aYQ==
X-Received: by 2002:a1c:2348:: with SMTP id j69mr2064216wmj.35.1554890457771;
        Wed, 10 Apr 2019 03:00:57 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id w16sm52389508wrt.84.2019.04.10.03.00.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Apr 2019 03:00:56 -0700 (PDT)
Date:   Wed, 10 Apr 2019 12:00:54 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>
Subject: Re: [PATCH-tip v2 00/12] locking/rwsem: Rwsem rearchitecture part 2
Message-ID: <20190410100054.GA115532@gmail.com>
References: <20190405192115.17416-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190405192115.17416-1-longman@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Waiman Long <longman@redhat.com> wrote:

>    # of Threads   Before Patch      After Patch
>    ------------   ------------      -----------
>         2            1,179             9,436
>         4            1,505             8,268
>         8              721             7,041
>        16              575             7,652
>        32               70             2,189
>        64               39               534
> 
> Waiman Long (12):
>   locking/rwsem: Implement a new locking scheme
>   locking/rwsem: Implement lock handoff to prevent lock starvation
>   locking/rwsem: Remove rwsem_wake() wakeup optimization
>   locking/rwsem: Make rwsem_spin_on_owner() return owner state
>   locking/rwsem: Ensure an RT task will not spin on reader
>   locking/rwsem: Wake up almost all readers in wait queue
>   locking/rwsem: Enable readers spinning on writer
>   locking/rwsem: Enable time-based spinning on reader-owned rwsem
>   locking/rwsem: Add more rwsem owner access helpers
>   locking/rwsem: Guard against making count negative
>   locking/rwsem: Merge owner into count on x86-64
>   locking/rwsem: Remove redundant computation of writer lock word
> 
>  kernel/locking/lock_events_list.h |   4 +
>  kernel/locking/rwsem-xadd.c       | 635 +++++++++++++++++++-----------
>  kernel/locking/rwsem.c            |   3 +-
>  kernel/locking/rwsem.h            | 290 +++++++++++---
>  4 files changed, 647 insertions(+), 285 deletions(-)

Looks very nice!

With both sets of patches applied they pass all x86 tests, but there's 
cross-build failures on powerpc32, sparc32 and UML:

   kernel/locking/rwsem.h:333:34: error: 'struct rw_semaphore' has no member named 'owner'

Could you please send a delta patch against tip:WIP.locking/core, which 
is the work-in-progress tree? I'll backmerge the delta patch (and any 
other updates you might have meanwhil) to the one that introduces the 
breakage.

Thanks,

	Ingo
