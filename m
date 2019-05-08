Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FD57C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 09:22:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 383A520578
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 09:22:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbfEHJW2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 05:22:28 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51023 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbfEHJW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 05:22:27 -0400
Received: by mail-wm1-f68.google.com with SMTP id p21so2318141wmc.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 02:22:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=j2zkhFBEgB76ZnYIx375guL7nGDbHUSh9B5wtwzZ4zU=;
        b=nG/X4xG82SXuDtwwFSnDwhShPXx0KQY5ak5ccoF/J4EelfRKYVGzmLoW2HzLmLOBgH
         LDW/WJE7Zv241doIeHze/HaP1T4uWibnWsL3jwW8o9Eq0frexUnOS3hfUIW9m3/GGVBN
         537/TCtivlB20cYixS6KgtxZfG9sNFOp0dRU1ZXEnCSRRfK2827X6/Paf8MJyMOvO+Cc
         oADxH8Asrtus9n6pppmewFMXAVsRnL35vykkXFBkZ1cyogFIR4F2COYogJJ5lIFaDARq
         iewgTjsk6CmRwNBKNGFzmcfz7bPWXy0foF4cgH9jIA5CKjZnbkR/R0cisxKZLrKF+TlH
         7v2A==
X-Gm-Message-State: APjAAAWLB+Vq/L/fTQFX8oI7xnf+JsLxMOwp5X6Q/Lb9yauBB89SSf6d
        AraBCueXmiHNLFnBYXwHYYTAbA==
X-Google-Smtp-Source: APXvYqy/Ows40xvrGOUFIoPcxx95b5c58at1SQ/hPl0xEk9HgPCHAqRBRHSfKOPuwwJTXw6EYkgl5A==
X-Received: by 2002:a05:600c:22c5:: with SMTP id 5mr2123967wmg.129.1557307345100;
        Wed, 08 May 2019 02:22:25 -0700 (PDT)
Received: from localhost.localdomain ([151.29.174.33])
        by smtp.gmail.com with ESMTPSA id v184sm2013826wma.6.2019.05.08.02.22.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 May 2019 02:22:24 -0700 (PDT)
Date:   Wed, 8 May 2019 11:22:22 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     luca abeni <luca.abeni@santannapisa.it>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Quentin Perret <quentin.perret@arm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>
Subject: Re: [RFC PATCH 3/6] sched/dl: Try better placement even for deadline
 tasks that do not block
Message-ID: <20190508092222.GH6551@localhost.localdomain>
References: <20190506044836.2914-1-luca.abeni@santannapisa.it>
 <20190506044836.2914-4-luca.abeni@santannapisa.it>
 <20190508080116.GE6551@localhost.localdomain>
 <20190508101414.1c968810@nowhere>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190508101414.1c968810@nowhere>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/05/19 10:14, luca abeni wrote:
> Hi Juri,
> 
> On Wed, 8 May 2019 10:01:16 +0200
> Juri Lelli <juri.lelli@redhat.com> wrote:
> 
> > Hi Luca,
> > 
> > On 06/05/19 06:48, Luca Abeni wrote:
> > > From: luca abeni <luca.abeni@santannapisa.it>
> > > 
> > > Currently, the scheduler tries to find a proper placement for
> > > SCHED_DEADLINE tasks when they are pushed out of a core or when
> > > they wake up. Hence, if there is a single SCHED_DEADLINE task
> > > that never blocks and wakes up, such a task is never migrated to
> > > an appropriate CPU core, but continues to execute on its original
> > > core.
> > > 
> > > This commit addresses the issue by trying to migrate a
> > > SCHED_DEADLINE task (searching for an appropriate CPU core) the
> > > first time it is throttled.  
> > 
> > Why we failed to put the task on a CPU with enough (max) capacity
> > right after it passed admission control? The very first time the task
> > was scheduled I mean.
> 
> I think the currently executing task cannot be pushed out of a
> CPU/core, right?
> 
> So, if a task switches from SCHED_OTHER to SCHED_DEADLINE while it is
> executing on a fast core, the only way to migrate it would be to
> preempt it (by using the stop_sched_class, I think), no?
> (the typical situation here is a "cpu hog" task that switches from
> SCHED_OTHER to SCHED_DEADLINE, and it is the only SCHED_DEADLINE
> task... The task never blocks, so push/pull functions are never invoked)
> 
> Or am I missing something?

OK, but "ideally" we should not be waiting to it to be throttled, right?

I wonder if you could queue a balance callback in switched_to_dl() (from
check_class_changed()), so that it is picked up by balance_callback()
before setscheduler returns.
