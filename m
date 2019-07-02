Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5566C5B57D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 07:01:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91AAC2146F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 07:01:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbfGBHBd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 03:01:33 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34973 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbfGBHBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 03:01:32 -0400
Received: by mail-wm1-f68.google.com with SMTP id c6so1978251wml.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 00:01:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7BmWpWsMHr5JYuSho9C6rnA1huvO7+aSrMupO2ViFEI=;
        b=Wy2dDc8QM3DZ2jGjkG2sfb+7aUq37lqEWc+w7vtWQNewM1BpKC7o2U+1jEEg8kXaqh
         lKWiKIwOeq15MTUPxsYH814yy/2TGyqSg9B6VSD16qzq4MMascLtoYNDIN6J63yKpYVF
         9q84mZm/FgVdUOwFt0lisz76Ur2y30d5r01ht8SLfKzCErX9dGkj95aqUZSyoqUF2W94
         1GuDpci6RDjH0SPtv/Lt0nUfI5dA0DEA6bldPWr3M6w2tfFAFKggng3CTgbxbGEppWRR
         bJLdWnoUGUtBO2dV+JU/TTA3cLdA0EPNJzzptp7lL86uy+FqhObN6vzzw2qxP/kudhyl
         Iy2w==
X-Gm-Message-State: APjAAAXjHFA27SOW5y0eNdz0+0MohN+eNbOOZ2pE0q+PHjDXvCGFZts9
        7k4q7d7vMnp0/bPum8dzPnIGRA==
X-Google-Smtp-Source: APXvYqxX3h0O/1RbPglcXFFfIUbuhS5iGSJGJV+SQNR4zsijY3wxjzid5bLZJjgEp5J82pyyIoCJtA==
X-Received: by 2002:a1c:720e:: with SMTP id n14mr2168055wmc.53.1562050890608;
        Tue, 02 Jul 2019 00:01:30 -0700 (PDT)
Received: from localhost.localdomain ([151.15.224.253])
        by smtp.gmail.com with ESMTPSA id d10sm14299306wro.18.2019.07.02.00.01.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Jul 2019 00:01:30 -0700 (PDT)
Date:   Tue, 2 Jul 2019 09:01:28 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, rostedt@goodmis.org, tj@kernel.org,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        bristot@redhat.com, mathieu.poirier@linaro.org, lizefan@huawei.com,
        cgroups@vger.kernel.org
Subject: Re: [PATCH v8 8/8] rcu/tree: Setschedule gp ktread to SCHED_FIFO
 outside of atomic region
Message-ID: <20190702070128.GG26005@localhost.localdomain>
References: <20190628080618.522-1-juri.lelli@redhat.com>
 <20190628080618.522-9-juri.lelli@redhat.com>
 <20190701191308.GE3402@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190701191308.GE3402@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/07/19 21:13, Peter Zijlstra wrote:
> On Fri, Jun 28, 2019 at 10:06:18AM +0200, Juri Lelli wrote:
> > sched_setscheduler() needs to acquire cpuset_rwsem, but it is currently
> > called from an invalid (atomic) context by rcu_spawn_gp_kthread().
> > 
> > Fix that by simply moving sched_setscheduler_nocheck() call outside of
> > the atomic region, as it doesn't actually require to be guarded by
> > rcu_node lock.
> 
> Maybe move this earlier in the series such that the bug doesn't manifest
> in bisection?

OK.
